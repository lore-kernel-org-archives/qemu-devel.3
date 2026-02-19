Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FFAE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVL-0002wd-51; Thu, 19 Feb 2026 00:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVI-0002to-Sd
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:08 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVH-00027q-Dv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:08 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40efc77933fso330846fac.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478586; x=1772083386;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=Aik4F1AOnAzB+xV3OzViPwb4EkdQ4duW+FWcUEKtvKaO/60di1D0sw5IUl0RIE2E3y
 ifpk0N24Tj40veBIBF+CkkCxVX2qvRaDQwvRgJ6+QgsczP1qQi440KYR0nlKQbLSgAFs
 Ha43kG+ZCLBs7VJNOx0iNZXX/y4q0rNI+YIVRObk7C9SDGnduu57k054IWFwxSOj3GPK
 9oSnOFny98nBJBpMaMmiXY55mIixAy46dJIovbrwNQYAGlIFKc28pms+QhIPVUyLwP1o
 GfV6symd9OeeDAdyECPT1Y4MChB7RtMocgciE26gy4mv7dcnhdhULjhQZFOSKljPFpBx
 TIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478586; x=1772083386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=kvS4DnHOn30qf0hYwaHa5NN+S4qOSAIq0eBLXIbGrTJDUOji5leUnNXEo/vu0xfomv
 pPX5OvghowaO5iHad424XSvUS3IRmkToy7eLbDU01k1U4YVwksUWmdqHAgO4hVZc8WvX
 SVQnSE+24fVOg7CZoSbaM+C+Nb7AQXa+JIQ8nT/f7MBtz21iIw7VnIL6EJdUPs0aOWq+
 zINu5EBvz1PRhYVRfjIUe4u3XcbpELCWGdykzS39pXteTogKWY984rumCFMkAPfLXpvT
 o+3QW+Q0UYG5Lu8d4+j9VIsZ7ZOHei9DuxnPnDEFWsXu7P4QQxnfmD0cBAPStYhrAIDe
 1jGg==
X-Gm-Message-State: AOJu0Yy9k37iRHoAOk9VKqkDDkU5iRC/O59TNDJ9guZkbk039aqZ81WD
 x8BDOT9zILNnhAf4CkSlSr4TYrkath98enayx/BwbOAmwf61KFAGc075KPgDveKz94aEyfByRnD
 aVnwMLNU=
X-Gm-Gg: AZuq6aJc9H2SsZB9/7s2RaTuu+/VS7mrgrJ+62pTHfHB4NtL1a0C4m9gKInQ1zgmixM
 8DOC87vV+KLQTzg74emmI6WPlf3gp2FEFiLi9TGoQoquUPociC1cq7Y/HD+i/R9d1CtI1r8T6pF
 j3RZyK6xUsf9Wk8YPE+DtImw7wauvFjsf/u8tfwYDxwjxAOe7srWF6dwSWpkaw44piv1AzDxj40
 sIcihopZfHmAfwsb9Tz2gmKLrlfkaTid0Mmutl9fgGlmHenMEx9CuCjiG0seLk70yWhhD9geh7O
 8Onp0waHcMCrAp/rENSKvutu8mTrLZNl2a0U/nd2ETplITu7SqQ7DqYvdVyJFXzqBLE6KGqQeNI
 8RjgUJyhIg+D/so2v7Pz41JLHkc35nB9HD5Z3ZZJ0uhLIkMRe3anEqEGcrcuVSGjgGz2RdQusMA
 l12ruPENdXAw==
X-Received: by 2002:a05:6820:490e:b0:66e:ce9a:f404 with SMTP id
 006d021491bc7-678590df863mr6615935eaf.13.1771478585867; 
 Wed, 18 Feb 2026 21:23:05 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:05 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:44 -0700
Subject: [PATCH v3 21/24] bsd-user: Add bsd-misc.c to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-21-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lYzRsyug+gEPTEbXMUdsQyKOjOqAIW1H1r6EjiVoPYg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4tRevBZQPlih/zHweiFMt2rv494LM26Jc0N
 zU4azauLryJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLQAKCRBsHNEofbAR
 AKbxEACQr0Nj/KYhopcIpWEWk7Woryd6WovcPRpjk5Pe49JDkPdBDC+jDaFcF4OgO471+82sPbP
 xz/1TCSWxfdarF2sumaYl+7AaCpxGU53FmV5h/rlAMssfhXIUCTokh96y/d8n6RhZ+Gl5iUe+wr
 Tpgn09Af0cZGjVn4EU/Q+Y9gvF+r1HqNN6lLy3WZ9ZqM/5AAqOixPv+6QqbMIj0+lwSXNFKNIDT
 gpJ3+Jug7V4yrCIWDQkXDDQ54rT6EEmXga2N84Pc3/kxA2wVi2Yh1TBGePmP3M3PLA8pDkPPzFi
 p9TgYlQwyz57Mb/Yq5u5LL3/KZ6YlFj8hAq1hxPbiTHcGcz7UW1O45fcs9QpVnlixAgb/Dvok0w
 ODGZWuGDVNbXjBjew3OPaBLRN96QPZkITUG/CPV53gH9EI/fuEA326t3bUDUWhTfxo8xWHioOem
 qhO817BPCTaV8NL8HMhkOD7XMS6y3hbbB2JNVXrgoUUKGe0zxwKv992rn76V/FRCmNsa72RnhRT
 0H4lRVQKOTSejntRy92u9bswigCagoEP3gTMQJwBEGsJKpen9aGGA9+KeHOE7+LC9ddlmNrjBQt
 7ZfYYNno5Go7QL2OvO4aisVknyD3MFcXvIEryL+rRRqRmfI1mJnDvfJFhNbPnn/dQUIea4AweJK
 bbWaQAztoYHi2xw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x32.google.com
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

Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
reboot and getdtablesize.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 37b7cd6de8..00428fc2f8 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -8,6 +8,7 @@ common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
   'bsd-mem.c',
+  'bsd-misc.c',
   'bsd-proc.c',
   'bsdload.c',
   'elfload.c',

-- 
2.52.0


