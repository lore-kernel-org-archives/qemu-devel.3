Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0930CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrd1-00056J-2J; Mon, 04 May 2026 07:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcx-0004bd-16
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcv-0001AU-Al
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u94aymaMQos4Ok1FqE43DnNiM5L1ZW3yqR+cto55E4c=;
 b=S1Ibgy0SLLNBuTcNWJLyOVb4z3WWkzmzcfsNgd/YWSGuJfTjWflDA2US2BTG8pvYpPes6U
 wITNlOFxd6eIn5ESjCzwriimzdnVaHsimGQjpg3tdn4kiTQfBQmtjBM0YYGdRPcNSRQO8N
 f7BLerkPiu9krmL1/F137u4tC2CRihU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-zvlHHODKOOG1f7_53V6GZg-1; Mon,
 04 May 2026 07:38:15 -0400
X-MC-Unique: zvlHHODKOOG1f7_53V6GZg-1
X-Mimecast-MFC-AGG-ID: zvlHHODKOOG1f7_53V6GZg_1777894694
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9409E1955F12
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:14 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 372461800480; Mon,  4 May 2026 11:38:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:19 +0400
Subject: [PATCH v2 31/46] hw/i386/pc: free pcspk on finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-31-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nx/Hm05PL6UbVe3ziRxkh2R3TZg6+6BhzI4zbHucfHg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRtm7mN7Afu/0v0L3zWLhbBpXKAZusND8HOT
 VQpfdOuuieJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5ReWEACLpjVlXaq/KPe5L00IqE6NJs6VX7jhxffAfw6cr73p9YC8IFL7VKMHyVAKLOEa3M8CNZH
 3JvjxbDtEEyKXxYVWemhDTucRtDtAJBhPXyMUaMWd8F82CqFCxBC1dDJ38fVDMt/Vd+nFlvH3b+
 lpuWNG+HjIrmn5XgfFBxHVPLVQr4jAHTRSJTbVT/ZJup400f9voWmf5GMQr1+gW2P4H7eSP3K1H
 F3sBVz8hwEfTvzxd0dbPUOMZXQCoXP/sgSG1eMSnIhY8Z2ubaSRZvYeHvClmX6P5DzcL3pcJfpu
 L4UbqahC9JRTprHohCVStmTq5Cd7Ypi6DDzUHEXvJFVYEsiTOwkbRo8LwH1QMppUmMOjRR96ZcU
 43uC2wNduII/qJL+q31eAcWwmoFftikgO6X3kP1jq9tCwkJNG535mjS0Kj4e4JptclLyOLB7dIg
 GbxusVrdYfy5yKP5ECAERAf/5vTqieIpj94ikOS+D+4fdbFGgs9BHujqjjM5pMaNXCGSbWtDlP0
 GN2zlLzQRiwRnJ90W27OoCr5lrkCb2vRgCnsufAHmMlWECMkozWGyl6uG7VrZ3FTgQfOB5fIR7a
 DIwNowhr9DrjOtbsSbGWLx5ELm42tA+XAhUzf4OKjl55l8NN+qJufYg2aGcw4ja6hLweBbvkQ3m
 x/+I5YujeOQhmUg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add pc_machine_finalize() to unref the pcspk device when it was never
realized. Once realized, the bus owns it and no action is needed.

Fixes: 6b8d1416482f ("audio: create pcspk device early")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503f..7b6ad97e5a9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1610,6 +1610,15 @@ static void pc_machine_initfn(Object *obj)
     }
 }
 
+static void pc_machine_finalize(Object *obj)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    if (pcms->pcspk && !qdev_is_realized(DEVICE(pcms->pcspk))) {
+        object_unref(OBJECT(pcms->pcspk));
+    }
+}
+
 static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
@@ -1748,6 +1757,7 @@ static const TypeInfo pc_machine_info = {
     .abstract = true,
     .instance_size = sizeof(PCMachineState),
     .instance_init = pc_machine_initfn,
+    .instance_finalize = pc_machine_finalize,
     .class_size = sizeof(PCMachineClass),
     .class_init = pc_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {

-- 
2.54.0


