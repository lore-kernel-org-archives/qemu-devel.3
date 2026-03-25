Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898A8106B533
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5O8Q-0001mV-Fg; Wed, 25 Mar 2026 09:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5O8M-0001jp-7A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 09:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5O8J-00022n-Qo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 09:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774444729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=Hym629OOUBdWfhCXpzbQ9l9prjxEqbqqRXBgKbQR0DU7sq9xwgTLo50+7alRo0GSJ5BVb5
 nDbKH9EcBLlZBElU/ov8A6xzjsMZUn7iUusnccVw6PQgB3UkHzYy3MfXky1VRKQAAA6rP2
 XMEc8sZkmFz/pJt2Q4E32kHunC1dA4I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-3P3P8LqbPxuOgqP_ihmmnA-1; Wed, 25 Mar 2026 09:18:47 -0400
X-MC-Unique: 3P3P8LqbPxuOgqP_ihmmnA-1
X-Mimecast-MFC-AGG-ID: 3P3P8LqbPxuOgqP_ihmmnA_1774444726
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a27868e512so3871433e87.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774444726; x=1775049526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=YN65zc8oo3hjz9GCXoc0M/Ck4sC7/iaEBZ5x9Qdep+KkVIcIrKalLvAcgXWQeW1s9m
 buhY7N3Bq6EFqj1A+BQcXhpRUNskiU+h6jYrbh19CAxFZolTxTYEm671kBSj82P05cVO
 fHGiYX6fdaKNVJKoNkeuyZ8jFUp/kxCObUdgRSwq4TpxIK1yQk4k/H4N8SUllRAZ1TMe
 uk0h/5p6EeNjMx6AWznMlrCiT5duRk/BrV0zOM2gkYCXV6TBmO6IoHAqEiLkKKX+SjZv
 77KI14Ex2/Vhsrqndeb2dy4R4LD7pC9J+aS7znFM8zphw0468eFmo1n2U3AbRjL6bQ+P
 c3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774444726; x=1775049526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpNDy6y1w/fo9WvmajHhnQ/yfO8JE34pImny9o9u5IQ=;
 b=FZNhVWzyryDycHRwGlcHAxab7HOwA74vwHP+/vpR4m7NKFpQRJ3JofEBaVDVoIV50K
 Vi7KGoEX41vJ5jkb9nB2tcb77oPnVI/mX0JQAwbuOBrn8KzDWfv6t0KaPphT14+z53gy
 Jhs8yGl4Qd0yb4RiAgMZ27X0bySn/DYwUtKavbwEX80dejeIeNXMF4FUqxMfICfTWNl3
 V6YpmKX5tzsJYszcgU0IWjdcfKJiKzS06A+mCgVHiLuLURb4hXDVtLIeB75xWYQqhtH9
 Kot8tVF7sl3ppqvMZUXl70Hd8rhBsQhspQbSPaq7D+iUgAOLoaawQoIJyx1gmOKCkpz+
 6hYQ==
X-Gm-Message-State: AOJu0YwX4rziRkAtvIv4dCyltpKXCldQHRt8qMZdZow5doN1FGtLyaCe
 KhO8XCNQ0GBJNggmwaaVJ1g0OLnj56OVLSxAd2CIG1mQSouWH3SR1F0L8iM/DQQGQywqv9dAYgE
 J5+PA8zZhDzUYBlLu5n/uzbvCTSPYIOPvRCjxXvhjZ3I/UT0nYiLsFQvswCqC2CAyeUaVi5/jya
 FuXL0bVlP8/LBAj/zELQNWPzXnXNJhRDwtwRCq6stA
X-Gm-Gg: ATEYQzxd925EUZMLlWmZ/+PS9BbhP+1UinEocpok9DOduwg5AMayCmgP7vjH3BqSpX8
 ftM8QEYyd+UFF9fHmhryubhTNmQIoUeYq7l4Awi1D3bT+2ExmIUFxPWPUXQb6MREbHjJSPgr30y
 81Y03dhvOsH0eNOKbycpe54N3P2HRd8BqlunbSNzyAvo0FV+Qb6TOXwjNo9mvjOPyh93FxndQVa
 lLZ4T5JUnjHF18B9FGfYQ9mgr1UEqe7Gp47oY8TmRCzrjlAZ6rpkmMSL3OKTjNaH4WLAvQ9ga2B
 vXX1Z9b5/5uETG0e+6bbR3f9N8k2VQHbazGDykMkI0Z7QWYfEbGQNKDhgDBkhkzbagc173HRpwJ
 U8mSYrc/LYhnq7jvEcIvRq9VZZEp2CA9EdWy1fcXO/JkVK1KiVn/V6n9fLUMM4InvDohtPgIUhP
 dvgkTjunH5eu9QklVKce6yo8zv
X-Received: by 2002:a05:6512:31d6:b0:5a1:2f0d:f31b with SMTP id
 2adb3069b0e04-5a29b98da18mr1329240e87.21.1774444725560; 
 Wed, 25 Mar 2026 06:18:45 -0700 (PDT)
X-Received: by 2002:a05:6512:31d6:b0:5a1:2f0d:f31b with SMTP id
 2adb3069b0e04-5a29b98da18mr1329217e87.21.1774444724794; 
 Wed, 25 Mar 2026 06:18:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a29f8a9882sm133070e87.80.2026.03.25.06.18.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 06:18:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: expose AMD GMET feature
Date: Wed, 25 Mar 2026 14:18:42 +0100
Message-ID: <20260325131842.940238-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is implemented entirely by the hypervisor, so only the bit has to be
exposed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e483e8cd2..d02f6f0653e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1170,7 +1170,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
             NULL, NULL, "pause-filter", NULL,
             "pfthreshold", "avic", NULL, "v-vmsave-vmload",
-            "vgif", NULL, NULL, NULL,
+            "vgif", "gmet", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "vnmi", NULL, NULL,
             "svme-addr-chk", NULL, NULL, NULL,
-- 
2.53.0


