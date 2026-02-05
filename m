Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C90ECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo382-0004PM-0j; Thu, 05 Feb 2026 12:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37v-0004NU-8q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:47 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo37r-0001Nh-8d
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:26:45 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4096aab5521so936102fac.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312402; x=1770917202;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GimB7dne7Oe9wJI1KLdFgXWHS63uf789leW03HzUlTo=;
 b=F14iukIJ9zwJCL3U/iG7k4LGPCS0BTbumEkZVPNarA/q3q9tAESPOvr1FNOedCWdVh
 cj5eg6nEqbeqe68WdA4bUJdnktKzIG3yAYlk/kjd/e+bYkBiMGfbJKD6ZVquuJz/z/67
 9MctULB7mVZXTCnXb1VgoU8rj5lt7CY0VFWp6ROmmm1alRXqPNXx8Ffpo5D87StyAzh+
 e7YcAh/pZ2i0fd0KiRgp8Mv3LKRb2JaZk1r5m1K3OEaAmSNV1QaoTJgPRe0py3Q6FBDs
 gZqnIhg25odfGQ5PWFBAla67THGv3h6U/dWC8OP2UR9dkSORLNqpvf08wI6cBiym5LyB
 Tpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312402; x=1770917202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GimB7dne7Oe9wJI1KLdFgXWHS63uf789leW03HzUlTo=;
 b=s0XPGH160UjmtFB2KpgFAHZ7c3PKExzR9UY+8bivXcbzAcCBrJml8/TgUfdcoktSaf
 5DmQkjloEfg8/9RYJzCGO4OMZVPX1I51EbynR6FefUqwvbCnGjGzofMHAmUIdHILXnpq
 plIb64unZJv6zO7kbkbwLYBHQ8xYByhGREGFjcYzTh7kSch5Q/TwhX+JX/dS4C49ql7Q
 XFMhdYSphBAJOp+wMQQ4+SPVThCMCqTtFFltwy0df6dKvLQQKY+6Jpr4xaB/7sp8Obn5
 tyonx2MlEyUFmukmYXK4xFe+fTBZ1M5l/AAG7HtA8qHDcrFxhfAlmPdNBMS11aZA7f6y
 8D0w==
X-Gm-Message-State: AOJu0YzhcChtKG3mjkCU/uxtaFIlJqrUZmq+qlnUUjxi6G/tXmQQOqFr
 Fb5eApz7mSQ+hDKyaGgrr30RLr7/GdtBpSf6qdsW9Vsuj1OAkXtJ85rsmNgSVWx4nFg=
X-Gm-Gg: AZuq6aKYEfWsGfAeKWR33sT/LTwihxfMe7WJn/H8+oeyR0+nCCfWj/b3kFbARNbunSw
 lB7iEYED1HHq/RWPMSUhdJxx29Ndlor6Z0w/Ku4g2CMNBzS/mLSsvL13xf/dm+b92WcM0OCxEsn
 caPsEuZNZo6reT3a07JnXLCjBSU8441C73ITzGvrVX9e1coS1AGeXhdDXWWXvCQfsTZ8v9SPruX
 opwDLE70rjdPoG9RUZRyrhn5OvXWBzRb5VYLn3tijDUnoEQuuv3q8JEJE8umpKyJ9SUr+CGQQ8r
 dl8XJFuBKXujWgx/tEt5RhmKJ689zhfvIFtFsY15gbLQoY5tBWzLp1ggB3BqcadPkmFOex9kfa1
 +U+EcIFRP6rHIK8Jh5lsy54meYyhWJilhQ1eSuYjsmyDTm1H4etgxxqBd0yJ1+jNYVYEM/pvskO
 XqbDOv7D+o
X-Received: by 2002:a05:6871:3592:b0:3ff:4ab4:774c with SMTP id
 586e51a60fabf-40a5404eb59mr3488978fac.43.1770312402056; 
 Thu, 05 Feb 2026 09:26:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:41 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:35 -0700
Subject: [PATCH 02/24] bsd-user: FreeBSD needs this too, so drop linux
 ifdef
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-2-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=wI53u9gokJ1G/DP8XVjcBLEQnvR+W+t0+0NCsq2XsJU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLZPoI4CWv70/PjcBPDXk1tNR0UCtLMAoQmu
 KvNi3f+y7WJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2QAKCRBsHNEofbAR
 ACqcEACnQR/xjFza3cUbg9NkLkrxGv4Y248BbTggfx22K1l3xsRJbkTeXbO4X9963ePNPlXz2lp
 fwx1ousWI9DMwhMDB3RL1+msAvUqwe8UpnOrizIJfreOJkaQ2cTbk00+IASqZyb5DuW2SW82+Zr
 RqpTLdu/Oze/Ir0ZUXNvzG/baId54naz9lgoMkSzWf7VzRraHLuJ/olJexUU6JvAjyiYYgk/Xif
 DmEP6u3iw+bLjR2AQIwOZnMyZR9jcgE2QRqYGNaNQ/4oJSOH60lvdQnnzV9qjYvC1j4pjFIynpT
 agyVPY8vezfp8Y72Jc1YqsUkAVaY6T51T11zijRRkUBmCKTydBIUVJucAtkxejmOwp32Jku3eUI
 Q6PARaIcCuIDqo9u1TaDxvGmx4gViSTADjSnezLAmLcfz7TI/HkEGtsduzOXKXz2Q1F/wjHAwII
 vyHkesELCSXOiD4C3S/aF25DPwdqNWDR+//BqH2AUcATDte0mgicOSN1gjYb2w97y9FNXf7fo+4
 QcD9r5IrFeWOHZx4MNDPvL07xKTqhWfCeHEUk2ChE3aWWfeo6FkXGExpUnSoCzMBno0VK2X/Jf+
 +omrw13ZeSHHybqlm4ft4u+oBGucdHnTBcWDs3rwSnP7k7y4VWGStFOUrFJ/ZLFLWC6TPel0KUU
 WCpSMCSYPIMG6bA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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

This is more of a toolchain than an OS issue, and all the toolchains are
headed to requiring this. There's nothing Linux specific about it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
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


