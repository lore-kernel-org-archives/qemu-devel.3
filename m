Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC9CF45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOO-0002pB-Ui; Fri, 10 Apr 2026 15:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHON-0002fW-3t
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOL-0000hy-Cv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM1LdpvMo/ryUlaKFnRu4IyfjRwCYwSedayje/V4ZLw=;
 b=VejQ6BZD1yWXI2aaT5UFEbzrN4oYyvJ5jA2TUWO0BHqXGd/GjLQWKHdmas6eWt0hCIeWk8
 FqzetEuL+uGigq+8DwPuFvFY/B0UYdgqSQd98hOz2hIgAJrRbkK7LQMvAmE/kkLyeIRlJH
 gMzO0wJbfcMYhtPWpy1U+3SuX8Q9NDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133--tHQ7Uw-MFmRZKrGUjduog-1; Fri,
 10 Apr 2026 15:19:42 -0400
X-MC-Unique: -tHQ7Uw-MFmRZKrGUjduog-1
X-Mimecast-MFC-AGG-ID: -tHQ7Uw-MFmRZKrGUjduog_1775848782
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFF7C1800454
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5D663000C16; Fri, 10 Apr 2026 19:19:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:30 +0400
Subject: [PATCH v2 08/67] ui/console-vc: fix off-by-one in CSI J 2 (clear
 entire screen)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-8-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+B++g3vg0UFSP1H5PN6zGwpYWHVJzQ3p7MliDE5OVm0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0TrFwNRtxqIGHKIO5B4Qh+MPxJQDf+heFcV
 N5qGc3iwH6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNEwAKCRDa6OEJdZac
 5ZjUD/9hdwgtLg6oHtm7DhK1Xyag5w9j/Jc+LGs+45YedptowdhPe+lsnoQaNBqDhCSE51AALXr
 i7UdJwBFhbWuh6Jyblv2jwOs8hZGCYIOFRzZdArJqxGI64DOFaOAMhpVz8f+aNM9Z2v8B314Ano
 NmAolgwk3po84USswCKYj7Rnr3HF8bZPkuKwhHQSABWzEGW9JHnkYU7/YgPWQWCPv9PMplKdZ2R
 cxMDPtykz3kUnkGt8M20sBKb262Nrl8+z13ydVDaE+XaZScMmRkafTFN7Uo7w1zPR0n77HL7AzJ
 8m5qSCPj03TZ1CzuhMBaHqvWEZj4F7BWCz2IEFYI+x2HkrV/GXe01HOXP1k5K401a7WjtOq6C9C
 NSHS95N9Qp7zcMuerLUKN2/BA1ruJO7C8UwlKIVQUeBLF/aeWC2+Dn/ONBp4bgRoMvuhZ+stX4k
 AtcVFCicrFmG1vHvedzKT63oszhOv66ujLsSt/zgpXFGAUrOrCtYFkvqkd+3YuAwlpnWjywQ8Bt
 jKFwQ2I7dpVTxkSwvpUOIX5veMTC7icL8mJB0Unfy+RqCT2e6oGo8vIuQeBFn+fyQgSIfSBg5i1
 klgtScZDlktXEdbdR98ByDB4EmtrYBOgTTrL/IMxGb8sBwmC+6KK0UlPGn30ee065uKh+qgYQuU
 GSdNUvFijVcmJVQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The loop condition used `y <= s->height` instead of `y < s->height`,
causing vc_clear_xy() to be called with y == s->height. This clears
a row in the scrollback buffer beyond the visible screen.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index f22806fed79..8dee1f9bd01 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -899,7 +899,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 case 2:
                     /* clear entire screen */
-                    for (y = 0; y <= s->height; y++) {
+                    for (y = 0; y < s->height; y++) {
                         for (x = 0; x < s->width; x++) {
                             vc_clear_xy(vc, x, y);
                         }

-- 
2.53.0


