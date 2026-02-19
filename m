Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993EFE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVL-0002xt-U1; Thu, 19 Feb 2026 00:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVJ-0002vK-Pi
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:09 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVI-0002AL-9h
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:09 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-662f5c5507cso380962eaf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478587; x=1772083387;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KyAAySKGEyrx2ixnnRFGbmSqIcx7VodIdDffNZU+p9w=;
 b=g062+jJLi799niZOv8JElUy82igtFtyHzPITqqNtlsDrhuMnUmsFMbNAbJw3WEgIN/
 o0cWqxjdIqWjGI2YdPcBUltZtAe52qp/EY5IJ9R9kzP0P7HSbZzXKFEMrbp5dIrFecud
 qWl+aOMBfljMqJ40FGa7NnQWWxs4tUTQYciEXYK5aiajvd39HKdXQu7uktqaaimgTnpR
 AFtvtVZXPCfL/05AryEjsRlp8kyxj/a6jpnDqpCNqKXnuA/jh2ZlhlhwdVnarOwl8GoE
 RXuMXm5TwILAkswCDw/P3rJmhKifyy+1DQ0gF7rnxNbC+noKp5bVACwBiLCqTG3T2Nms
 k0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478587; x=1772083387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KyAAySKGEyrx2ixnnRFGbmSqIcx7VodIdDffNZU+p9w=;
 b=pC5Jn6v8tlZmWVTpLlWDUIAeIPZ29BqjJU6O0m5fL5+ynYSeAP5YYOQQmsaG6tWKnV
 +xwpN/XwGcgJ0ppEiZ5vcsWXpD9CRxSoV6Kr0TnNCxmeTxdUAZIPPNlb/nFxlkW0zBFR
 Paai/oYMkHMHUdwHiVuxYgzlsGThAPIi/m0iFq72qqQQ3Ul7S3xJI1j3NDJAk9yk6g+h
 SdXNI41u5Nx0aicatw8+/mXOMjqTENJv3G4N2JTP3qJaHa6zVJd9M1NkXprAurVRW+DO
 27+sCn9N39H4QQpfDA8w0GAkOYy/JTasJwKYKGmdQHLx8zlFNjHdvjy54upF1j0FdoJd
 O4Pg==
X-Gm-Message-State: AOJu0YxD329hU2Jd19vE2lYqIu8AvzCtS0VERV/iKyrOfGYGMaDwQpFI
 EgGjUJUdGVyffznA+cIh0bHFviZ9p4Gs4/9SxbeqfPHkGSYMUVsRDvcztyAjozfED2pJ8ferxVx
 QLPX1sl4=
X-Gm-Gg: AZuq6aIfs2VsFe5v7WvTkZTJl9T2Ot9LlgPwMlQ1HCvm2oz59HpSxv7eA4Ph9Zy/tOt
 2ekmxyy3ues2122B5xSviQLbFmlqbHOYjPDBqGRlsNxdgnySfeTss9RI9B5xgYHfHfxRAhFkoLx
 4gjrsVIJV5Wad4SrKuqlzZQ0wN689zegUMZoEWUWh0bTao8s9aapWWhQPov9B7kuMhba9X1Zy3m
 xuYDSApglBH0bcRshw6FlAujcGpNoXSjTvvUb5lmnJhrVH82D01OjX+5ygjLn8zcnIecTjqMETd
 sc34+PdwuUgSF/5kuczlpuxJo4cvVkNI5bBtEoum5H14Y9nfFWpTR9TL1cQ/LDSnNUIavAnqDSs
 IeYszW+RV1PkJERp0Df5IQOEbQXLeDdFrlvKCe1Du6CD+ODl/Jl3yz+XdIhJSu6m2X8Yj7zmDzw
 F9rqS2lkz2653AWsI+X4/F
X-Received: by 2002:a05:6820:2108:b0:66e:66b1:963f with SMTP id
 006d021491bc7-679aeec7538mr942660eaf.18.1771478587084; 
 Wed, 18 Feb 2026 21:23:07 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:06 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:45 -0700
Subject: [PATCH v3 22/24] bsd-user: Implement System V semaphore calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-22-0137b37b221e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=G/MtAZXxblLExrmekUauAECEshkdpeArgaMJyuYCSAQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4tawZfjZDE5ZCFv/VXyMNp3sNYR8jOSJu2/
 2NDA2P2QU2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLQAKCRBsHNEofbAR
 AFN0D/9k9ZIyyHkKkA7JJos6dRxn2YUauvZp4+1RQ64eP1t59Nh4yA0TiqxwJ6sSQDv7+8Df1eE
 Jkba3aMQWbS46casm/HdAufnGPn8xaPeRHfRb8I/zGUvXCbzQ7GfJqJixc6O7HXIsAHW1TyCB1b
 SROBAe+5X+dLOLm2nlBgfvZWB6EfVh8sdoPsuvkHASvUEmYTkEETeDMva1VWhiApnrp5whS83M8
 N2305iICidt3E8PDvDDPaO7O6z9kqM+t08TrGDoCjOPmOz3uuD5mJKCY9JjmvkgYt8u+C3Q9UEJ
 +Ja6KwINCpqcB4toalAoPenJewauzyArFihmQqyCB2Ejv5cZcDgt5dVRtxPsvaJRf2v63zlW202
 cf4/cZv/Sz3Rh/BguCtRnPwLu2xHjPoAdjvXftykcjsQ1IsKdO/4/YZi+gO2+f2uRJKxFcF0HiF
 0ffnJgJZw/QbH/l2rT/m8uNSRT2BbbRbCb5xfwV3J7BkvymktKmHyVrwV0MIZKqzQe+0DMItk+3
 W2Ir24XBt8Zzf2D5WpId4o54NrX9DS5HDSCZ0NSsnmiyIIvI569Ywc30EDEBBbYWUUwZXbHofi0
 ENbBxbKhQ2mZ4n4qyM9UstStfovSYidmEg1Aj4dm4skFCllSn6V6MPcKgdvYLFxe6LD/gAUUbYa
 ThSEx9K3v4thc6w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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

Wire up semget(2) and semop(2) syscalls to get System V semaphore
implementation, as well the undocumented __semctl used to implement the
bits of the interface in libc.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4c1191b8f4..234bd78fd2 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -36,6 +36,7 @@
 #include "bsd-file.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
+#include "bsd-misc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -878,6 +879,21 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


