Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94652D3C54B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4j-0004wo-Ma; Wed, 10 Dec 2025 08:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4I-0004pz-H3
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4G-0003EC-CI
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JmnpFRe4llaHNNrdqOS8nOURF1rsOD1zpds34mYAHg=;
 b=R7lSwMBYzQBERGVTP5R76WgoAPpRxsJIjhzcCOKYbbVTzvUBtFvMfiD6w/ZP7jiUQ9NINh
 U3AEQvZXAyXZRVd4ZrzrOCcyyUSl89HnLXn42AqSRtryj/pK1u9Gi61jg2WWaB4/Hj3ZIl
 ZMWahWWe152V9G6da1+lC8w/Ct7qvwA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-hYf8V-FIPqeNmcGseXIPQg-1; Wed, 10 Dec 2025 08:17:18 -0500
X-MC-Unique: hYf8V-FIPqeNmcGseXIPQg-1
X-Mimecast-MFC-AGG-ID: hYf8V-FIPqeNmcGseXIPQg_1765372637
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso55899355e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372637; x=1765977437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3JmnpFRe4llaHNNrdqOS8nOURF1rsOD1zpds34mYAHg=;
 b=g2ko4kszKaPZB2LyxC0H/9UD9W8dbMUcDgvaOQRuzfxSmOEbV7Lhipawp0wVnP7mLM
 5q6W33cZ3mahoRU39/cFPPHHmbNDPad6SNmFsOrFne9pzPJUN41LZdryDoaQ1KEu8AUk
 Q1JVKh+xap8um9zJjLVDbrFV3aO9gwPDY1JysN49aVR0dY0pxm7ChhfuGavV0jmKrSAd
 u6/CQB5KC9FcyNcT9lochagvcnKgISEs57RcmFWOAZkkaIfT1qISuZI9J8t33OH03DhX
 GYnwVshddQJDjIpE8V+3TOXPEG4UlVDhU14yGUxFt5fnTbnE1Q5Qh0yKq5uigNeIPU7q
 jMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372637; x=1765977437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3JmnpFRe4llaHNNrdqOS8nOURF1rsOD1zpds34mYAHg=;
 b=vl+/UvT7EBwYMHrMEMwqp99lDgx99Nuw1G2z9vzWtHxQuVi02+xk2pKOpXX24Lk9DE
 MdRXmLhrN8OJtdot+zX3R4Qy85DtrhsqGMbL/UukiIhg2GVaUQ7f1h++k3WaIeeQnI3a
 BwEXQeW0etVlOAm7gdkBosUamgFX66/ibf41PjY7uje3wFR5a+a0qdvkvz8PdRIvSAa+
 ZhA1eiZcX7x2bjG+WK9lm40ctJZF/u7eMJrAgrg5FO9KxKwfyG/IHWnhIKFGDFeSF+MQ
 zJIVIuSo0Zu3i0JtihPILFrgT6IOw4lPzRRdN76WIfrnFk5vcasQAY9kO1xap8310cdN
 CayA==
X-Gm-Message-State: AOJu0YxyW8ALOaOsf/8KFwtBbhID5C84wzWlXKCOpmGfY/TCixJUzZHr
 /fWFVLiMvoeyVz1nWvBYBz2h62D8N5Qud1jjmyLVph0Agnvy3mgRYpQBF6Eru8Hx8yF9nCxp0rU
 cvyIzOTrd8tUuOdKll7RyZB08ksp4oNYP7QetTb3tS5gKfsUbJpOb8jnBKmruwJQsN7+7mIeoRP
 RlPLujifyezMB4iQ+yiApFBjjYtLrCoGEcVQkjeptN
X-Gm-Gg: ASbGncvkfrWJSzI0ZMWYuEcV15P44Djo2dZj8swpWfZatEFo81XSINKw1YB7zLLd1AW
 U7ehmUXcvqfzLJLmZ2qu6lMehV+nF7smyCi7sckp+BJHYKKhUaLMTzS3Q6lku6rTQDGt+WvGZ+F
 H4SOqOpE4vSkEV7FCtJ+OUNcshQp2l4Txt4/p4MCPXSwSsAGyjxeDjGGqhXHPwW3DODkTT3Jrhj
 NoB8VZA+d6ryP8jAPCFsD/g79UvscLfAx8LpJUbUaw/65KvN0YU905cI1VavwaDu2QQ9Xu6uVJ5
 1rrNZsNNo0sZEBaEET3wIQfNFgpWaR9Eg35i98IqcutqQKckKN/MTId8rnDtpaUpr7AGgsEHHBW
 dN3EZ+iDfiIWX6l3P0K2ypIrJrhMvlNnEM3/JDMCMx7GPAvYy24RkPOkuGyAMKt4Q2s5iswTCyd
 BhBPboA8nmwP7mJZA=
X-Received: by 2002:a05:600c:3e8d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47a8378ce43mr20990415e9.20.1765372636792; 
 Wed, 10 Dec 2025 05:17:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQQK4stTo0DzT/wd4uNdytQtriJ+l3rE/GxOFljvYo6qq8hcOZbyMEvNjpQeXz8kCzTpSe4Q==
X-Received: by 2002:a05:600c:3e8d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47a8378ce43mr20990145e9.20.1765372636338; 
 Wed, 10 Dec 2025 05:17:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d98ef5bsm46576075e9.3.2025.12.10.05.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for
 undocumented fcom/fcomp variants
Date: Wed, 10 Dec 2025 14:16:47 +0100
Message-ID: <20251210131653.852163-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For 0x32 hack the op to be fcomp; for the others there isn't even anything special
to do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8f50071a4f4..f47bb5de8b3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2777,7 +2777,12 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 break;
             }
             break;
+        case 0x32: /* fcomp5, undocumented op */
+            /* map to fcomp; op & 7 == 2 would not pop  */
+            op = 0x03;
+            /* fallthrough */
         case 0x00 ... 0x07: /* fxxx st, sti */
+        case 0x22 ... 0x23: /* fcom2 and fcomp3, undocumented ops */
             gen_helper_fmov_FT0_STN(tcg_env,
                                     tcg_constant_i32(opreg));
             gen_helper_fp_arith_ST0_FT0(op & 7);
@@ -2790,16 +2795,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 gen_helper_fpop(tcg_env);
             }
             break;
-        case 0x22: /* fcom2, undocumented op */
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fcom_ST0_FT0(tcg_env);
-            break;
-        case 0x23: /* fcomp3, undocumented op */
-        case 0x32: /* fcomp5, undocumented op */
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fcom_ST0_FT0(tcg_env);
-            gen_helper_fpop(tcg_env);
-            break;
         case 0x15: /* da/5 */
             switch (rm) {
             case 1: /* fucompp */
-- 
2.52.0


