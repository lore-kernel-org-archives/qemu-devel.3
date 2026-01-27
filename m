Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66BED19515
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfY1-00011i-Vd; Tue, 27 Jan 2026 04:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXx-0000ox-Al
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXv-00004s-Sn
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrVgQW/kqSWhVYiXeyV6SFlSSylxz1IDdjlWD4x2rHo=;
 b=HlHn+Aojk/5yd1R8Ly4VkvJelUehbASbC0w4P3TwG11kygFl5P2PcGoKlYG/+/rD/1pfdD
 9P/BcwdWfTY1vvAVYm7GSomIdcL7sBPlK8U76MweW024VvP3PlMe7XZp7/bMfiIbZpz7Y6
 tmp23pK2nU/cwBCK5JmH/sOrwpTQhnw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Ps8EGjdmM8OWqfGpPktH-Q-1; Tue, 27 Jan 2026 04:39:35 -0500
X-MC-Unique: Ps8EGjdmM8OWqfGpPktH-Q-1
X-Mimecast-MFC-AGG-ID: Ps8EGjdmM8OWqfGpPktH-Q_1769506774
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-434302283dcso4796391f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506773; x=1770111573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrVgQW/kqSWhVYiXeyV6SFlSSylxz1IDdjlWD4x2rHo=;
 b=fMqov84T8ycUhHB+H4dXR3d37ajSQKsgRd9Qz3SQsA7KJF1gdo4FUWM2daDnF048U6
 SRttckLhStx6wwjyumTH+Zrq9wNuEXqkCx+alQf7ym8kSAw/FFtsdL5e7LszhHl9tpld
 wX7uyDsTgQhqWpniBG7MN9IvCQk6hWwZiRnLrUEKu04c+FYxPqql4pNkwcy9SxDl/1md
 pwP2UBbEZS4Df74UvltSBr44Iv+Pdf2+EzB5L8buf24Ki/1kZeEm1h9UMqceq9L6Q7iI
 LWu+dDRSez5lAaI95MOcfCnX/kFIIYMHL0k1RdAAyZWOhkmyn+FR1659NxV+nrdcSEO2
 qlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506773; x=1770111573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jrVgQW/kqSWhVYiXeyV6SFlSSylxz1IDdjlWD4x2rHo=;
 b=gG09x2N7qdUs9xrDFXuyYg3jmb+JTkny5F/XG5ZY4mTKNp8McYmg/DOAI1kis6LTSs
 LIao+vuESYMUyD0zRmqgAHpJyi64s+7WEvcDnLVT6A1mUdU2jWvO+Gaqb6h1GKx2qOoD
 5JpPhQL1W5FVnMkQDhsQBWJfI0VJTOgaU5kq8uTadeMZDRoZpguaELckM2bmPjY46ttE
 W5AWkcReUGG2rCcdsSuuANQdt9SnOgBF/q7YihJy3Jy6LGTE6Mj0BIKwbdXBBSAT7noZ
 A/6ThNHnBVJVpUvmNIQGAQnBp+0oATxbHprvb0Khi9v1FDgpLwZGrRKXAUtUP5xVBY1B
 Tweg==
X-Gm-Message-State: AOJu0YzYsN4O+f51LpVPh4xXzt5wJtP7JLuxll7KYo4rhGrpi2hOfTdr
 TN6dG3hZyCh3k2jaRknUSrtbowPUIwhXwaDh2Ce98SWpzxCCQXwfCLqJNP2DheV9NqibonSgUrG
 MmAYoenL8ysM53yy/4eiDneYcQ2EB68sCh/rh2SqSs2rFUsxSBgkVck66FG97tmHx1EWJI5V1CH
 ALTSx+XngYLe10ZxtwFXP5lgPiHqMLIzXRrlo3iG/4
X-Gm-Gg: AZuq6aJGubR2PDf1ErwzsKrwl/8c4RXrIx+q0B1E6AImaf9LXkqOu9ToWpmYiDvz87u
 tpyn0LUJl+nKPDEa4za3ttXXbUKglHeMxL8UY4rr7perhdzcjsRRFLhRNIqifZSBm2aSWjO9uuL
 MVWpF4/xZa3Oyv0k51uDVMG8ucxrVRdSYiQ1VZvN8W553x75nQLNkrsFiUA01dq/6zZLvtkDPcN
 Z8xTaBsIsZUVEfmV1WRvAHJFwkWvhzxZO+orn/QU/dRWBz+X8JnzFuKur5GuLPo6T0UKLGRa/9F
 0yAnP3YqRVftm/ZZM9h7bi8oPY0F6MeuNQUmoLbOYQWsa60il5bIgFoDHARoiWEwX9yAglfYdvi
 rCeg9NQ0swH8EM86HRx/6u4FwRuEE4f7vs1ZxtafCjwmJvKE52elu4C57HOo6VGHih+vXXo5PvK
 7hO4CTy78iGvbNwA==
X-Received: by 2002:a05:6000:2508:b0:435:ae10:cf92 with SMTP id
 ffacd0b85a97d-435dd02bca1mr1428804f8f.8.1769506773173; 
 Tue, 27 Jan 2026 01:39:33 -0800 (PST)
X-Received: by 2002:a05:6000:2508:b0:435:ae10:cf92 with SMTP id
 ffacd0b85a97d-435dd02bca1mr1428762f8f.8.1769506772628; 
 Tue, 27 Jan 2026 01:39:32 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm40880291f8f.25.2026.01.27.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/13] target/i386/tcg: replace havesib variable with the SIB
 byte itself
Date: Tue, 27 Jan 2026 10:39:04 +0100
Message-ID: <20260127093906.353741-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 662d1d707d0..086a3bcec18 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2015,7 +2015,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     int mod = (modrm >> 6) & 3;
     int rm = modrm & 7;
     bool is_vsib = decode->e.vex_class == 12;
-    bool havesib = false;
+    int sib = -1;
 
     if (mod == 3) {
         op->n = rm;
@@ -2036,14 +2036,13 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
     case MO_64:
     case MO_32:
         if (rm == 4) {
-            int code = x86_ldub_code(env, s);
-            scale = (code >> 6) & 3;
-            index = ((code >> 3) & 7) | REX_X(s);
+            sib = x86_ldub_code(env, s);
+            scale = (sib >> 6) & 3;
+            index = ((sib >> 3) & 7) | REX_X(s);
             if (index == 4 && !is_vsib) {
                 index = -1;  /* no index */
             }
-            base = (code & 7) | REX_B(s);
-            havesib = true;
+            base = (sib & 7) | REX_B(s);
         }
 
         switch (mod) {
@@ -2051,7 +2050,7 @@ static void decode_modrm(DisasContext *s, CPUX86State *env,
             if ((base & 7) == 5) {
                 base = -1;
                 disp = (int32_t)x86_ldl_code(env, s);
-                if (CODE64(s) && !havesib) {
+                if (CODE64(s) && sib == -1) {
                     base = -2;
                     disp += s->pc + s->rip_offset;
                 }
-- 
2.52.0


