Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB52C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03P4-0004c3-ST; Fri, 28 Aug 2026 16:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ox-0004U5-SZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ow-0007yp-Fz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08qxR8qEWvPdNTDRrzBPsumwdfrzNrJ4768tkoehZiM=;
 b=Wy4LYDvlCtJ7mJSvF6Rff2SldEfLt7LQu2My7qypTQSqmaIzZFnlgac+OSxecDOnG9ZeXr
 rZM6sgQzqvwLC3Rd96v+f6GwsaPUns25VPdc7kqrrYoe1WwsaTTeLg3t4aScKU/eFa9wi0
 hJqcPonh3l90zB7qoBOelwUHMFkPxLQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-fzgTAIWVOdCHmtzu4kCj6g-1; Fri,
 28 Aug 2026 16:42:10 -0400
X-MC-Unique: fzgTAIWVOdCHmtzu4kCj6g-1
X-Mimecast-MFC-AGG-ID: fzgTAIWVOdCHmtzu4kCj6g_1787949729
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0638A18C0FB9; Fri, 28 Aug 2026 20:42:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 375F140E; Fri, 28 Aug 2026 20:42:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:41 +0400
Subject: [GIT PULL 02/50] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-2-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ng42cmSmqYMl5lkPkvXmAXL7nRbtrSSPGEtfn8S/2AY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKTxl98m6hyruwo/dM/W1fn7+Jqw93x6fg7U
 m3LTvTmnFuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5TBmD/9EbVQd2MaqSltLyhXYkwe0L1sHffAUYWs0NkXYlj91i2yjiT3/HjlH5D0TNUFm1YyJmg+
 /yO2Kf4yihxMUbr2b/Env4ddDtC/T85ai3g3FT+k51Rjj9hFvUJBIGaJSOOBN3R6+4RC2VTh3vA
 ZKfmZO3NDTTAqOtyGpgHEpUb0P1DLH/SJBb4A9SvEC4BEge8L57pcMgl6Hk9Bmp8PH0eqTQ6MiC
 A7+V6nhw1/kVdKAa0P5AhTpb4aQFNDhj1azT0oscmvWCVfOrsRHUXoMYAi0xeFjqmQUX9SbCcyw
 V5dPOV7xgA7oeYv9unIXdT8uSyogWHt/YDcaRvV+oucUiVA/hoARV+hKDbykYFHAuj9s/EUeG+s
 2ZIaj+K5cEclQ65rCLOtBa2UGGZ7AWqNuMeVzWCPpivLLMAI4eD4XGe+60EAN6bSkldqVuZHKrz
 Ez2M5sF1C6cXM/Su2L3drksfg76TkmyDLgJPOI2MZKqmENAFZDI6IiB8SZjDlV5/pcFAO6G5szc
 aGByWNxZ6w49wUOjEJASe2cPLXuviiHqULcFqz7RoaSzR0DV3LsAvgHvs7cB0Z2r+/dJw5Smw6C
 NtacfKt/r0wMgTdtHjrAsGhprB8O5ZtVOqlGUxeTqec5S3rvzXhj75CahjU/B7imWalSV0WRFuK
 cZia0NvGUKB2XWg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-2-9227de146347@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 061cbdf860bf..5ccc19282ba2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3226,7 +3226,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.55.0.543.g5ebe2ebe4ea8


