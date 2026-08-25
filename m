Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A65FC61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypL4-0001xo-5G; Tue, 25 Aug 2026 07:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypL3-0001x3-32
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypL1-0005ih-JD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIWgkTtXHlop9N0eBts49XgxQSRwkff9LfqhjOfKMNQ=;
 b=fkLIGGOuvBe+e/A1B9SB0VOSiTcxFZ8MCpINum+wcU/kP3Kf9SVagIuYBPUqlwapH/eJEb
 4B/4rGUKsr58D8uVC0oRiXIk4/wFwD5pWE23VxB/v234XVmUZeeley5pN/YTb4+OTDVBC1
 EHvf2PNkZGj9kW5rfQgE7VWgCIQs72A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-vRyRKmTgPmu6pt6959eYzQ-1; Tue,
 25 Aug 2026 07:29:01 -0400
X-MC-Unique: vRyRKmTgPmu6pt6959eYzQ-1
X-Mimecast-MFC-AGG-ID: vRyRKmTgPmu6pt6959eYzQ_1787657340
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58A0A195DBA2; Tue, 25 Aug 2026 11:29:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0318C1800643; Tue, 25 Aug 2026 11:28:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:20:53 +0400
Subject: [GIT PULL 03/19] hw/core/machine: fix fdt memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-3-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bQisH5FZBJ2nMb07NbswCswDkAvlnIJEcdbaLo+TT1k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrTLrD5mVNjRcmEg0mI5HbRkFcA8K+5Qw5un
 DLKhNIPfbCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao160wAKCRDa6OEJdZac
 5eZVD/oCfL6/oLnq/00TvY7vigOQH6NG110X35hK9c5iqMOvOGJSjmsSz3HcFRJV6SHDF8AdXH4
 gw16jm0LhStIBpgwy8ycN6qXIpeIqfTj5xsiYMJhQXxcixmF55hyHq0PyzHKcc7quY9+eu1JRHH
 kyHWdpP+RhwYjoADAMK126nqv1kH9Qwu7R5OFImEyp/Bdpk6yLMaeuv/MNoklAOtvPJ0/hk5xOF
 cge8/RPTcWr2kQgicGJIUvc5fwP90AXxKsZhaGN54zm+WFmx767sjuDnsnH3REW8/IZIbLBUvHW
 cPuGEwNNw08u2JrMd+q0RNNAItOQgT0geOdoOOL+DmM86oz7yM8aHNeXyjIoxulp8zsibMvH95F
 tQiDLFpt2x3F4h6kBDATzcEyROnVru2fRG7wj6tQxSM9gGBoaiQhWQ95krQBbiMhkcLo8VeEsXM
 s3GPwBNVoMjlQzJwcehis1CU08oJny6mNiRi33t5ONM8CZKRdFLSQBmqibbjcWnrLCwBhVGiS89
 RKgTBZwj/zV+fVU74qHtXytlvO4BNXynq20eChz4N84N9I0/bK8E6jKjUSSkQ1+y3W7ZI2ab6nq
 0Rimkkm6YAwagvNOFdZ6DK92BqssLsOWB+tlejQsmv3lRr3YDOeJPlW1f9XNJk47VapwZV7+DPi
 Q20T3MNK8sEMEGw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MachineState fdt field is allocated by various machine types via
create_device_tree(), load_device_tree(), or similar, but was never
freed in machine_finalize(). Add the missing g_free() call.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260709111249.1107640-1-marcandre.lureau@redhat.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e617f7804d4e..8939ae16666c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1314,6 +1314,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
     g_free(ms->audiodev);
+    g_free(ms->fdt);
 }
 
 bool machine_usb(MachineState *machine)

-- 
2.55.0.543.g5ebe2ebe4ea8


