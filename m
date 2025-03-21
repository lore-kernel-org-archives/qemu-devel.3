Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A2EC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjj-0001dH-AV; Fri, 21 Mar 2025 10:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjP-0001TJ-QP
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjM-0006wR-S5
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSrRos5HyrEm16kMqZjAz/pRCErOCij+EXv0KMx7yHA=;
 b=JMgHrg9pecbzSrOW0HuZvqTy82kE/e+zUd+n3OFhy6nxDTDPn3z04kFDCjw7juCP5zXqIb
 Bg017pCW7v2YFevsJCz0AZes2SyHEYSSKrUps76QJC1RfJo6czWMeP69GH7q9wkGAYSGr7
 2BgPa7lSGE3Pfvkl0UVmXmm0VRTzaaI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-WU9PCvDzPr2Zh28-LoHaZw-1; Fri,
 21 Mar 2025 10:52:11 -0400
X-MC-Unique: WU9PCvDzPr2Zh28-LoHaZw-1
X-Mimecast-MFC-AGG-ID: WU9PCvDzPr2Zh28-LoHaZw_1742568730
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90068196D2CD; Fri, 21 Mar 2025 14:52:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CA5B195609D; Fri, 21 Mar 2025 14:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9A8A21E6682; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 2/8] error: Strip trailing '\n' from an error string argument
Date: Fri, 21 Mar 2025 15:51:52 +0100
Message-ID: <20250321145158.3896812-3-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tracked down with scripts/coccinelle/err-bad-newline.cocci.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250312143504.1659061-1-armbru@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 net/vmnet-common.m | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 54d900ba67..ab33ce2b0c 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -94,7 +94,7 @@ ssize_t vmnet_receive_common(NetClientState *nc,
 
     if_status = vmnet_write(s->vmnet_if, &packet, &pkt_cnt);
     if (if_status != VMNET_SUCCESS) {
-        error_report("vmnet: write error: %s\n",
+        error_report("vmnet: write error: %s",
                      vmnet_status_map_str(if_status));
         return -1;
     }
-- 
2.48.1


