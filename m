Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7B1E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVO-0002yt-2k; Thu, 19 Feb 2026 00:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVM-0002yJ-MV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:12 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVK-0002DF-VD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:12 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-662fe3ff6f6so321302eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478590; x=1772083390;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZXQv4gZD+ncGRmcanP3bAVNuvnim3Z+KZJ0IpojcCw=;
 b=rA1eHl8LxgUYvQbgTVsSOudAgA/uXeJITvEuBS/U7w4O1FNQhApYOI9GIxWicW2GDK
 cD6wPPT4OqrnSRCL4+5oOaq3ZF1C82Bggz6SAmO2FxkRgTNG48YI/S6sQGsvHYPeAy2W
 8ZNzwQLdfl75tVI/oJGeFA05Z/iql8GNCjXT336ybxLXajR/u9L/MNRwwCOpZDEjhwSa
 +G/AbqF39NsbUbou8LWM1eIw+y4pAgLJj0Y/28rSGFjKHm0B+hzFoZ9ENjZrU0tKaafZ
 Oqp1BhIdAD1RiozmA6LDgBSBsQttiSxRcfg2cWmfrcoJrazLJYbqURqLZbwZVASZdB/t
 2Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478590; x=1772083390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZXQv4gZD+ncGRmcanP3bAVNuvnim3Z+KZJ0IpojcCw=;
 b=ADenVdjm9egFctIe0aPSuWcZkrUeSHWAPtZ/32idAHWkBxohZMdzsdrxGx6NYZ1akI
 dtz1CON7qcCi3hAoT1hGdCncKqda4vBPDK1qToByDXHHwNv0BZBJDtXu64tmpIjdUzd6
 WGrMwn7d7qf6HneJhsCT4Ny+oAgniwD1GpJMhptVXWDxhdavt0ll9z8Szyx9IMWuGgIb
 KxWizPInWee77DOxGJxnDIPBwrn/U1ee63QtmNSi0jhrBLabpAy+iU8gTudyGbFzAaBs
 FCGUlHokFhYraMgGfpFMLY4tBJB13a9hqqfZ/qh9EDEdOYO8QWkKHd+gq8UwY4q91GLT
 zO0Q==
X-Gm-Message-State: AOJu0YwAgVn/o2G20yfbqXwWlxZdtc/2kRvs85Zi9Vj9tZAF3L2CvJg/
 DK7vmH00PuPr4XcEL+5N7GNtezX/mjxIT+HZ3SVIK/W2wv72sPCdHsPvX7HtswjXOUs=
X-Gm-Gg: AZuq6aJN27+kpH5/KLf/61d4nsulg1tEZKdBhdTllqgL9ddiPbM1Z+Anx6LwZ5sVw5E
 gGkj19rhQK0DK4p5Kn9es6/1EIARY6B6JGChmntLePTdtaL27DxLowjwRM4u/l99EG1K/TZSscL
 jQUKREOvm7K/FHd2S3H64x8ddcrWcKv8IQd2/tLG44Q9frJggVukZSDKEIMxBcPO/zEoZQLDNZg
 UM4uRZOXYSUrlxrc/vXr1qIC0+5Advb1LyRTVKBsYCOnfVlQVKXDwveIpN7fblH1lR2jhLbRYun
 y4/YTkX3apEaRFa2beKU7rE+l4YA+JASFl2YCPBDKOjPnL8h3ozBP73z5dUrVF44iNOZ/WcrL1r
 9WZ6jVW0/Tuhy0jPsWU39BNWyVixzpQidD/elRMGdMyIz4KMPOjYDMFELJHz+bQEccDKqTbZ99L
 BysbLup4WRcA==
X-Received: by 2002:a05:6820:4c86:b0:679:920a:9b73 with SMTP id
 006d021491bc7-679920a9d56mr6459009eaf.6.1771478589812; 
 Wed, 18 Feb 2026 21:23:09 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:09 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:47 -0700
Subject: [PATCH v3 24/24] bsd-user: Add miscellaneous BSD syscall
 implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-24-0137b37b221e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=5JNtxaB6Hh3wMCs2T5wWom3HT0DjtMFbl/EcUs72mDM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4tJSSA/JF2qt/C2KdugyZyQEI8NPUeGYBxL
 9zdjJ+WR0yJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLQAKCRBsHNEofbAR
 AETLEACOcxYR6R3Q5iLCAXodrwswEv1oLOCupVIWUvMZWCY5ne69tTHuiu9ioZXALOfWEaPctQM
 dmJVac1El6ikYqOKdI9mLHnYzqQsAMlgVNjbeAn5jOsBC9JNFTo0ShAwNZoUD2dW3MLTinh9ATk
 evh4Qonxw8WePaKVQMqDbPUW9wb+7EgZF41uOLufopEQzlsaWYTAZ4oVpJ2rleczqNeGIhMPbue
 ligICVHbiIegGYU3lTTLFkFfOdNrTuAXFSlDXwpnufEpOBgrtwiV6oic/UKhKrYNxsIu7hr5+9w
 JVn/hPMGSfu9jF89/moMK4GyFusVyZzFmRFZgPyi9y2FKjtrNnSZqGbo/lJWtsAYMFlwLoiJHiZ
 PMZPEm/3a1wxLLOlmEqmOlbyLNktYP/nuhdv/U8S18NEXMI/HwfPl1KqX/4TjSMK0Y7NCHhHmNt
 b1AB01IrVbHQjGF9s3oD14UlMmjeKP53SN6YOQpaAI++6zprN9fhB3XGiFYO5VfLdoAfOTuVnXp
 sOwt/F3jCE/UzXHA2KxcOWZU1+tlP26ja3gVKu9ay4pf36hIftrSrUS6kk8p41vT4SZ/9YoHRGh
 SPYJ2ezP2Cp541E18OxwiFQ0MTg+CczpjvH95C7p18kirr4a9JkY4PKkpfLPbkzY0SfovWEMfqH
 RQ79qu9sEFF9WQQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc36.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Wire up the remaining miscellaneous BSD syscalls:
- quotactl(2): Quota control (stub returning ENOSYS)
- reboot(2): Reboot system (stub returning ENOSYS)
- uuidgen(2): Generate UUIDs
- getdtablesize(2): Get descriptor table size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f39e521e42..85e5db19a3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -933,6 +933,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_obreak(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


