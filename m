Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADFC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6srW-0000Ya-Rf; Wed, 16 Sep 2026 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1x6sMh-0005Tm-BH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifan@redhat.com>)
 id 1x6sMf-0003xr-4Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789575602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ZXuRgLVJtCBD/gKjByH0k0wyMPgms3+YCiNM3WV5Uw=;
 b=IwYDsKuX76vvqiVh5yDpxWfgbHpC8fHlCrvGFnu/TX51YzcQaPnfTezQWksZIjo5NDOv+W
 yXoM9k4CDM13M4If0TNNY747n30e0NnRc8385IpxwKIEEGSSXfwF5F+zA4FThdp4VcizoE
 s3+Fk656wuCj7Bw/57J00ERr+8tOiKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-YTfgtvyFNtOhxWe2QgoH-Q-1; Wed, 16 Sep 2026 12:18:29 -0400
X-MC-Unique: YTfgtvyFNtOhxWe2QgoH-Q-1
X-Mimecast-MFC-AGG-ID: YTfgtvyFNtOhxWe2QgoH-Q_1789575508
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4843e59c32dso3948058f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789575508; x=1790180308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ZXuRgLVJtCBD/gKjByH0k0wyMPgms3+YCiNM3WV5Uw=;
 b=l8sR0Rn9Qqkf1DUAqykpPIaBCKmeEU/8bXXVVkM+Hiwcw5MuPGsbWlv2/BesE/9AZg
 dJhilpZrwD86rb2HUg0jCsiMrHMQmAnFJK3SDlq2qFLvTU7cnYMXQ0Momxr1C7NvvDkV
 uPLRj4LNdfISfmHxw+BPunhSrrWjZKBTdlOcyQMiYXyfkNiC//HWA1FCIP2JmgmXpzQ5
 kpTgZuo9ilWDnAxruNATocc7GSLCh/S4zXPPVfRQxdXA0REUDl+P8V+SmiX+ABZTLGw9
 pcVY9aYXh2MQn58/eTsTqdCKhpcJ2J7G2GEXxbl0FZY+CgX/pAoAP2yV+wBnGVuTXfqo
 tgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575508; x=1790180308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ZXuRgLVJtCBD/gKjByH0k0wyMPgms3+YCiNM3WV5Uw=;
 b=H3F0OEp/XpADQi89upOTaudIMOGHClz6odMZubcBLnn3xhZncoKvtFN2Fj+QQnTkwn
 m/ycpT7i6LQyRvIourWotX6iACIJTRNKGdxOMymKbG/OQ6rqg8q7JdfgzDzzp1jbL4UQ
 qXGGdiOMWBi3zhSnEE1G93EJ1daLbTYHl5ogL/Dmbk25+oQBi9j3bUn4rhCIic0MvoFi
 YroQrYdr9R4BLMduzqw4Ab4FxZA4tycMir1VITWVo81yS5efCaPrxkneiYDBlFz8qlDF
 +tWwpCLFE8VMRGUhFhWI0AK4VUbHMK+Btf0lVbijV4MFpCPh32ADfQ6maF3+cGa6lJ8o
 pT7Q==
X-Gm-Message-State: AFuF++l9qOtOLLsubxmXgPI4aIelqRSN52TmCPUE1l/PAm42PDVksnr/
 Q3JzmHSQjnAogwHq5YfJXhWp9d67IuvqeS74iKf4e6iSsuWsp1yqKPgQ+PN+5KcdYu0gYc7Rj9j
 55TxJzVQJl1TzAyBQA9OOWGqR9X4qbg9EiuW4cWUlDUml8YbJZuhnJrSzAI+/Q2gRyyG0q8QTJU
 I37c8cRsXBZM0dY7Wgsw7/JM9PGuPMewfrWLhbJwDLdZU=
X-Gm-Gg: AYBFou13Bc/2Mv8qTLfTO555AbAfJWl1LWTImHMly/3sm6/CChcR43AKbJH+b7JiTed
 MPWaXzYcp+KKKtmsbNdGqu1lmw/MC6/15e3M94JY8+NDtOd0UhlW0C87cp78U9+B9Iwf4PkeTrA
 LfrFS7lCd0m8Y2tu2Uw+F9ZKObCcATii76ou7+8Qyu6suRQf0p1yMAQrF9O5+6CU2OWjaXYjz9R
 j43J1o4BSYWM/aQqhR0sFgiGZphBK6Qk30MN+wut0sfybytqeHq9aU/JnSNwweozX1fF1f6uhfp
 XX75nIArefYhZ3O9VcCxLiXQA0VI6LwoHF1pCObKmRLm32mjH2P2xSeCvcH9hDdx0xV/FvQ=
X-Received: by 2002:a05:6000:41cd:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870d0667e3mr3999679f8f.36.1789575508156; 
 Wed, 16 Sep 2026 09:18:28 -0700 (PDT)
X-Received: by 2002:a05:6000:41cd:b0:487:971:6b19 with SMTP id
 ffacd0b85a97d-4870d0667e3mr3999643f8f.36.1789575507746; 
 Wed, 16 Sep 2026 09:18:27 -0700 (PDT)
Received: from tcalifan-p1g8.csb ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf413dcsm8332677f8f.31.2026.09.16.09.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:18:27 -0700 (PDT)
From: Tommaso Califano <tcalifan@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tommaso Califano <tcalifan@redhat.com>
Subject: [PATCH] hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn List
 Iteration
Date: Wed, 16 Sep 2026 18:18:26 +0200
Message-ID: <20260916161826.223733-1-tcalifan@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 16 Sep 2026 12:51:54 -0400
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

In QEMU's USB MTP (Media Transfer Protocol) device emulation, the usb_mtp_deletefn()
function in hw/usb/dev-mtp.c iterates over a child object list using QLIST_FOREACH
while the recursive call may free the current element. After the free, the macro reads
the le_next field from freed memory to advance the iterator.

Replace QLIST_FOREACH with QLIST_FOREACH_SAFE, which saves the next pointer before the
iteration body executes.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3991
Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
---
 hw/usb/dev-mtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc..c2d36a73cf 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,7 +1152,7 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2;
+    MTPObject *iter, *iter2, *iter2_next;
     int ret = 0;
 
     /*
@@ -1161,7 +1161,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH(iter2, &iter->children, list) {
+            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
                 ret |= usb_mtp_deletefn(s, iter2, trans);
             }
         }
-- 
2.55.0


