Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7A0E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUs-0002fc-NK; Thu, 19 Feb 2026 00:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUr-0002co-1W
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:41 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUo-0001Q7-LD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:40 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-40efc77933fso330690fac.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478557; x=1772083357;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=wEtAG2lN5HKtvtsHDsA/5CLyeq9KM9iWys3+QSMEk094aMxKB01pT+JhA8gSfXw6dE
 PwY507kNC5LbRJR3DC2hlQJPUwvQ3EEWajIp8tQVxU2qc99gsLk5UdiPxWmWG/MbDVCU
 +wxfci9BsoF5n8Rx/+cxR3z5le16vkCTtb9t0McS33FKVlM8kUOUuuwgFbb+lvL5QctV
 MZMuOMncGb++AkFit4GiRmeW/ay1d6v85YugPdCucTiG9TxeZ29K4iVnpAYp/gVy2y0I
 oMnum4AJH7zWOO+jvHFlduXNMNPwKBnPkKNsQ2frjmgVFbfYQ89Sdz5qG572HivNm/Gs
 in2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478557; x=1772083357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d+t1iHUqtREGyGrJCLj2fqTNeBuRk/na2OctX3Jzxbs=;
 b=CZ0D/P/cONQEJ0Mg7VrR7F2laypFY+qDq4x5DU3wiETMl0D3zg507SaV2vHm+txpOw
 OF54NMy7YWzrweO8m2W2B/rpErRc0MSZhd4AuecEwP+AC0YNse91Fk8yugxeU8SlwLRT
 DXHVLPQBqyvejNXIufDJ69qdQm/CRWvODrA5y2rhz9qE2G4EUrQ9s66B+1dekCVhCGfO
 k/bIRcUThERFpTb7+oQHM8AtVpFNoAmwX79UtPnzddOSoEDgxontov83rgVT0PbUTS3Y
 gJ9p5L3zHWk7+ao1GquTSF6NjqutE1kQxduAKu84CObv091AURm3Lhp7AiOBCSHOrQw4
 +WgQ==
X-Gm-Message-State: AOJu0YyvKC10+gpOLp3F9cSEKaiaKAlxDut4FAUEY8Ex2LoKIWgwTGXE
 dxMKSn3HfBhrQaXbG+jFsDCQMEOXdOZ6werCUHLqo9z+o/88CdLV7Gtc5o++yKZp+IE=
X-Gm-Gg: AZuq6aLhNSiy8k9Zi4FkomSDJtsIatuNC7fsyTJBiJc8iMQLxJ4+bxUMzITlRdf6CPI
 0B+k88G1vbB5TWnew5ibRcyacIT2eNfSVBr1z49os7GcfqCSew5jt/QW9T8yYRQSHF5AjPV6nJp
 aeBibXbMZkt7zaodf6t5N22CLq2XhLbWWZWF06xbJJqOtjfZ7FNkr6+PQwNse07pGCfMhcdfDX5
 tca8qODHCVMNE/19Kkg+y3dFVSFnKkvIkYreCrXRPk8v6Eir8vy9kkgZYEM7LA3DLyQRHeoFOAo
 NKF1sPcmpS+q8DR9rq4jrbfTvtayG7HdA5V8U/VXyTzyrJxvGtUYy0wEtMUE0RLrhS5GlcsIUO2
 EZtf8/euBxbr/Qyhbs/SdyafMOQMYIkX6D9O/lZiP2AYlaJ3Y94EeFmy8h0vfEZR4wspL0BEfc5
 e+/c6RgGA7Xg==
X-Received: by 2002:a4a:ec44:0:b0:677:48f4:3c66 with SMTP id
 006d021491bc7-6785bc602c9mr8327176eaf.67.1771478556988; 
 Wed, 18 Feb 2026 21:22:36 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:36 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:25 -0700
Subject: [PATCH v3 02/24] common-user: Drop __linux__ around
 .note.GNU-stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-bsd-user-claude-v3-2-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=848; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=8f1kgvOYIoToweJ4bia5M92ZB5KgOcRUK3PIe6pRhak=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4rKnN/GPcJtKbdJXXhK9nvaZxRsAOCz+c6u
 XMzdGrW1w2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AN57D/9GIK/vbZ9OIYgBgBuNTAUvZ92fZ3CB4svqd0mjA/gUrypSLs/MujnrcRSZRRntacLo6YP
 nSc1qMUSi+DC7dGMw2ukFDZBDvOTgjjlvqNP4TWdQkqmvMFkwfeuAKFdwFzbFNP7ci50pf+hXXt
 05NmAFYIalLKch6OQDjzr7d9YVqnmqcGY3Fwov/gFUJDQcsTU1fMq0a3lAemMi2MtL+nr9e8XD5
 0LoARRAK+5nLpj8vGNO0NJYt7tvT8Lc7bW3jZWBFw0enplIeDAo06oXMSoFlAZDKE6k+gAHd5J2
 DDxaxg5qJWyNbC7umAfKGPIG//kmDKwIuGm3YL76RVSxk5oEV8N88jURsd10vEw4OnZpSRTjFhy
 gMEls1YD/d/lkT1t+AgjUNzmOVVvxqCZsyF+XGzbly5qT6ABq+I98VeBBqBdvkYoYxyH0NOIPot
 8Vmj/66IX2V38sdW0cqGvnKiyN1I+uHGmu/lpjuPPwtvYRECjyC92djq6zMNcwSvPLkFzVJRE00
 mggQRjKeRaeqq2fKCPrVxkf0i4ClYMxoAltM+281oZUENaCkK4Sly9E0qQ0Nu0IKFZ0rCUFWwFO
 ziQW5NuU4l+hFyY4pwiADksuanhPSThgiM78PWius5Z2Pt/Z6ppnkSBWMRed9QRwuksd3vPzH0T
 doFJ90aZL/6RteA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::36;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

GNU-stack tagging is a toolchain issue, not an OS issue. All the
toolchains require this for ELF.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 common-user/safe-syscall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common-user/safe-syscall.S b/common-user/safe-syscall.S
index 74f7e35694..2f714cfbe8 100644
--- a/common-user/safe-syscall.S
+++ b/common-user/safe-syscall.S
@@ -22,6 +22,6 @@
  * assembly needs an executable stack and the whole QEMU binary will
  * needlessly end up with one. This should be the last thing in this file.
  */
-#if defined(__linux__) && defined(__ELF__)
+#if defined(__ELF__)
 .section        .note.GNU-stack, "", %progbits
 #endif

-- 
2.52.0


