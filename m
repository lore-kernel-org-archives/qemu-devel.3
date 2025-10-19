Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1714CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY9A-0005Ba-MB; Sun, 19 Oct 2025 14:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY97-00059b-01
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:45 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY95-0000aB-Ft
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:44 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-33bbc4e81dfso3729711a91.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898522; x=1761503322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCA4lO39TZ+W18kn7Yc3OzkHymFkx8JhkJlKEUl0Maw=;
 b=xc/3cQCr6uo5Uy3hx6hpt1EOgEDstRFwUErJMq204ln52mPvnRZkOFk6nO51UC2S4z
 nBdmYjokX4897OHXs1aaDdFAktvc+iDo6F56AM7iOVM7wPnQboPn/J9/uFla9znHfV5G
 IzwN7tQv/i3DCKUoQslcktXMcyYDkyq0aVUXmxLb9kjlBPTLtruJcMf8KQVDJ/JAnRYL
 GyRdjA9k8OuV1CwAsbc+tsj9xfxGREOqR2d0/W4FYNTXLHU6jJn7KWP0S/SUa/XD4B+9
 GwORSDc/dqfKLmxwvVlNEo+pD3fP/Lh5W1as5ONodMm5WEIKymxm1NFqzzX24FS0lmMo
 HRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898522; x=1761503322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCA4lO39TZ+W18kn7Yc3OzkHymFkx8JhkJlKEUl0Maw=;
 b=L8Dp/yy/ph9uaone9qEQR454iAj30ifudwEISVR8HAqc+Qxhd/lC9ImNYxYnfxOOGp
 hnkk3/Aq/a7GGEERMmJBnyTw9AyUxxP7CFUroegLK22y4wEwy4zcw4qhfIVUoMPQkeWW
 wW0/momIvjznujWiZe2PQA0M3o8RDo6++CThgyzNr/Iz/M4oYY/pw7JdvlQpJtFCU1vQ
 oxORRLSTk85UpsrjlZFYbbhq8O0h7/znzwuYG9Ek0SsF8XkdU93WbaVxAJiYwnre4ydl
 sCVhLfkDURV7O4/QwKTLaFOJDcegp/XkPO9R+D4RoiQoiw3rONj+ASC9fX8c/l5/6AD3
 LOJA==
X-Gm-Message-State: AOJu0Yy6HmgJgxw7URJJ62yuhfZ4Km2gtaCpRan3Os0GZ5rVqb+TY9cC
 r6s97LVjOFokOXBpyu65Kcm8jX4sGdccvifYz6COPNo6eAzKjXn3US7jD+lb20oFMBny2jVrdVC
 S44IQ4vc=
X-Gm-Gg: ASbGncv4CXec8+dkUEqJpbrL5XIOopNIuyumVyozSsulABlsEaYIj8k+Ol4D+/kYzIf
 wCaMl3DU3GSLNOiO/Z0pnjQejO+VJ1jMik2poXsGeg96Mn2rnF4k9BSJWNtIKTQ9t3t9QCETYer
 9ZXEHAWgsh2vg/hf31N2P4SLVjMuzhp/vzAZF3YqJaBFXjW0GZFlI4xnYGIfp29vTdo7Z7J0q+l
 oDnXusOYene4IkAhunZ5lzagfauUxB4tqo2V3jPFwhRo9jO6Z906jBA9Yr0Jv+ouNbkmTTq5/Gx
 nz9wcn2wrgRFDTzAa6TtC9GiFIWANj0pMPZaowqRLj192K3+jANDmx/XEJ6hps2ii7gYzBGf7Zd
 Wl/oObMR5cqiaPsMcBR+0uEKu04/yKAIDXptQYEDP1C9EhBCUk47Q4HW8jBR2kMzpi0aMcd2vPc
 PV5w+VAbA3CwzM92WO
X-Google-Smtp-Source: AGHT+IFNYzBmy4kDrlDRix3VYVJamW8OtR/x+DG0CcMPRnZDB3yf5t7llpqJ/B1/XGpVlq6vkH4OHA==
X-Received: by 2002:a17:903:350d:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-290cb94765fmr147777345ad.39.1760898521762; 
 Sun, 19 Oct 2025 11:28:41 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] tcg/ppc: Remove dead cases from tcg_target_op_def
Date: Sun, 19 Oct 2025 11:28:33 -0700
Message-ID: <20251019182834.481541-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Missed some lines when converting to TCGOutOpQemuLdSt*.

Fixes: 86fe5c2597c ("tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b8b23d44d5..cd2b68f9e1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4435,12 +4435,6 @@ static TCGConstraintSetIndex
 tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
-    case INDEX_op_qemu_st:
-        return C_O0_I2(r, r);
-    case INDEX_op_qemu_st2:
-        return TCG_TARGET_REG_BITS == 64
-               ? C_O0_I3(o, m, r) : C_O0_I3(r, r, r);
-
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-- 
2.43.0


