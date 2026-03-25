Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C2109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RMO-000597-Q5; Wed, 25 Mar 2026 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RMD-0004uZ-IX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RM9-0004f5-Pm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVD6uAi4AdJLbgGot/VRbxtOsgGbrhgZgoqUeF+TBQI=;
 b=JYLt/PHnQN4MP2XlEYroIQ45foo9qP48IsUojfKJvCSa/sHAL6oYz1wNXLfkWYEARubnxB
 qgroPrDJvwynbpKwq/4p7WmmxNgdJeiM2JizeiNq3itZ8rHa7Hn9T1Ds2l1+1XVDkjaDgD
 vKxaKehUi7EYm1+3drFY/I2+WYfYe40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-E4gsIstsNqqI8ON1bDI9Hw-1; Wed, 25 Mar 2026 12:45:19 -0400
X-MC-Unique: E4gsIstsNqqI8ON1bDI9Hw-1
X-Mimecast-MFC-AGG-ID: E4gsIstsNqqI8ON1bDI9Hw_1774457119
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486ff4498b2so3462585e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457117; x=1775061917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVD6uAi4AdJLbgGot/VRbxtOsgGbrhgZgoqUeF+TBQI=;
 b=CJOgFVVcm/+aXDihUVg8KwChmtWFGPDgooX06r6yFuSBBEQB30Zw2p27GtOkM3Usfg
 lLL9rExoaBpkdFr+0bjYZ/0AGQ2fz2lIAqPhlnTj5m0sbiRiTcllQESxEC/XJJ45JtLu
 uUNMY98R9B8VdLgOjfT7bJwrXHdsCvvV7pQ45tbIk8sBEPv1ot+7LDszCKbNcYcLbksw
 KjspiGYJChYQoBc8ZelRWA13kG7q7G8+VW5RpBnKXznXw0XNSHRiFSI2M7mrFRNl7r02
 efc5/6a0+hBjTgJllld35eZxgdEL8CWCVbVjc5rbcWbxbwJLyimglLCTpczYMr65hIHG
 +aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457117; x=1775061917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gVD6uAi4AdJLbgGot/VRbxtOsgGbrhgZgoqUeF+TBQI=;
 b=Tno2aE0sXpFAhmu46C9TjyHFRPdHKQyv2fwCskL6bct1N0ykQJ1Zo0leIvrVO27/43
 8Fr6q1TfrztTYGtN2AD32tBYh0VDBAzOHUCL3V+9LDg4ppJQVFCyiUX5qctso6UQycpa
 huT6EBj5qAxtAKGrYHNZN7mS9Wvk+Bpdc5zejPrhmrRGzvV5DaEk2qc47tVM8uG5b2uJ
 Y9hZP4tqXtXKKpH17XQXb+yC82nDDaByd+gaBtuAs2KwSFZTS3yYFhxnO1Q5Us//EdBS
 QBrsnrLC2/narZnYCZM39OwO+HEZpAh9lZcL+Z7AXyFIWdLNEVbvC/0BqL87q09ipAJp
 6MOA==
X-Gm-Message-State: AOJu0Yzg61gJy0Y7AqbEuxmWHvUJ1NjqTuZyR7x5rT8pn37qoJIsFlZd
 W603f+BcAvreiCMgu9Mcmz8F/cYLN0cN5gllKHlKyHThvHJ6+sa1CEG1EXStwfa1ijaeb7mLurn
 tg24zAuwIcMN9VWn9QYmmsTLjuTfKeC9tfwxgluVVn3GY1be6yN6c5wmG0hDAvhkQGJY+MkREQT
 2fzktCqWvOcgpeRkpdtzN4t0f6KzHdKpdYSvNXJEU/
X-Gm-Gg: ATEYQzzvDnj+JykF8Usd0J8ZRDCN/t8Rf9kz1/ZisjpUKVenkQauPLuKgtKKZPZ5vKw
 /2opBUcelh/ugmTKCinaWxA3KgSWb5V6EK3UON6ufOu9BXrtnr3M2D0nP05lWqeuP8LYiY/9GYC
 OXzd4aY2piBEuVfpelHLQlryOebDYz3jwcAWHkMihbeV8XyXQoIygVxEg+nl6lx4bO2ww9LG9EE
 UjWB2jSMq97TId900fPQ3W/84ggNEZhEVi8ku7oGESbu/EKsT8qeSiPKfH3vE4YURSa4LGCgDfH
 xEgC458yTZf9HFytM91f7rT289J1dqCotxsusOy1oGDPGwMzA1l3P703ATxnrmXemikxXuWoWog
 zv9lzILsGUsAHxVSdsACE/MQkjKfShzoHP+fBD25Oe1ssw3l2lGCZD3lue50oIZFqi7uPA3RqQN
 JpxgKFZIK+jkYdZ+hkZEddHcnX
X-Received: by 2002:a05:600c:6089:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48716008471mr60870585e9.14.1774457117181; 
 Wed, 25 Mar 2026 09:45:17 -0700 (PDT)
X-Received: by 2002:a05:600c:6089:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48716008471mr60870145e9.14.1774457116709; 
 Wed, 25 Mar 2026 09:45:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487165be1e3sm28475055e9.1.2026.03.25.09.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 12/19] whpx: i386: indirect access to CRs
Date: Wed, 25 Mar 2026 17:44:46 +0100
Message-ID: <20260325164453.72127-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-10-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b97dc9fd514..71b33a632ac 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -905,12 +905,42 @@ static bool is_user_mode(CPUState *cpu)
     return vcpu->exit_ctx.VpContext.ExecutionState.Cpl == 3;
 }
 
+static target_ulong read_cr(CPUState *cpu, int cr)
+{
+    WHV_REGISTER_NAME whv_cr;
+    WHV_REGISTER_VALUE val;
+
+    switch (cr) {
+    case 0:
+        whv_cr = WHvX64RegisterCr0;
+        break;
+    case 2:
+        whv_cr = WHvX64RegisterCr2;
+        break;
+    case 3:
+        whv_cr = WHvX64RegisterCr3;
+        break;
+    case 4:
+        whv_cr = WHvX64RegisterCr4;
+        break;
+    case 8:
+        whv_cr = WHvX64RegisterCr8;
+        break;
+    default:
+        abort();
+    }
+    whpx_get_reg(cpu, whv_cr, &val);
+
+    return val.Reg64;
+}
+
 static const struct x86_emul_ops whpx_x86_emul_ops = {
     .read_segment_descriptor = read_segment_descriptor,
     .handle_io = handle_io,
     .is_protected_mode = is_protected_mode,
     .is_long_mode = is_long_mode,
-    .is_user_mode = is_user_mode
+    .is_user_mode = is_user_mode,
+    .read_cr = read_cr
 };
 
 static void whpx_init_emu(void)
-- 
2.53.0


