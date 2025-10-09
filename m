Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1713CCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6xcm-0000hY-V6; Thu, 09 Oct 2025 16:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1v6xck-0000gz-Ce
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:52:30 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1v6xcg-0002Yj-Fb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:52:28 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-7960d69f14bso9070186d6.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760043141; x=1760647941; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nCJfS3LEThSZ6DuQKoxyDC7RI8lzDxdovaH0TkRts64=;
 b=iwZaeHazvCSoDoVDCHmQxiL2oUxt/crK8YiqwAo0SEfQRPazPyAtp4H+17Q4plwJ2L
 BJTJNSxJPEt15l6E8Gcgi/2yNdI6NSgXPWLP9Y6UMs9gSiH75AOOWEqXu1Gfwc7dV7lT
 9oWvsZiFwwEECSKl/uWL25+AzyDIlD8YkZHp7aEoQIdJSrOzN+PBa7jMScNez+jzVAOy
 sbSq98aJy+fz0P+8uFOz8eybBquozhldxKX79rS3MIKiVWmHrAfhFgESVR3sdNvu1HK6
 D77LAjg/xoMKlMI6pNPOxmWM/Xm6E46ozE4rgvEfLPIlB1LvDHltlAzKSruc9+P0sCrY
 TPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760043141; x=1760647941;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCJfS3LEThSZ6DuQKoxyDC7RI8lzDxdovaH0TkRts64=;
 b=MPGNZ/xqlpUP3QAWKSuiQqZKO6fJjT5GGrpVQzGZ4a4kUlzUU6066tasrrGLZsuCIf
 sSlZeNc9CMvH+AcSQ2U4myfNYl/fUWKLEH6252w5TbU6izYGNToBTE7W6nhpca61ufZv
 RpGfh7LCVKHmu/AxSGWp6yrqPldUmNUpHt1QCp5Ao9VxWU8jCQvqddrkZvXaAm5lUq/R
 9low4O4abUknMGm6cx4WxW+LEU4pjVI+3QVQhkoMSyGXKcbwxWRvrfZoO91hro6gXVOU
 Jufa38/NldgwVdIPKg/19YEClCk3Eh9YYO1xzfhM/HDnyftsHXR/gjU4IRPNAfGNYtGm
 GdVg==
X-Gm-Message-State: AOJu0YybC8f0rc6Dw6SgkihQWAUCJO6Wfxa9t0kH7F8u2iO4aUDrFsEs
 B1sXVDNn/20+J5VzGtY/NkOUfZKl4xtQ8bochuxOZMliuNPAGHNaZqsC
X-Gm-Gg: ASbGncswDvVqgp1aqW3L86OOXPsgOgihIUIWoxz2BGwrpMiPcQZm14pm2hUdRu/9dnK
 EMPoaDPH901o+dyg42jxwVa7gFIwa9o1Vz32FgMiRo6VuBSD813FO4WZ9oq38rmV2I1/EexOQA5
 uH0ARaL3Woq92s0AIXUI3HoCsyj9gmJsrWVogZz1AJ+TixE9FxAEyl61fk6knwjbJqftaHv3IyI
 s+YYdc9/iQ04zzSUVst+/5ZFh5las1BXpfJtmj+YaWJQ3Q9QbKqcAcB3yXv9D9kJB9k3IfVQ8HC
 HW4ISUiEcJCx93/qPFFYNqUG6jzljw1ohk+TVmrkBtiY3rdDkKLz2Dve44gJfXyrH47UhtZRLiL
 wReSy2plUmj5VO4yQL4qPLThZb14mHCMu8p/RGITm72Grq1mSHOyU5V0UxqxiwpuuVQ==
X-Google-Smtp-Source: AGHT+IEtZcq481vQx58py/dSPNHs/+UjgS5+T7TqGA1YFjXiLdXiEQ2g6SfYl42nTuBQkUSQQ2JzEQ==
X-Received: by 2002:a05:6214:1bcf:b0:87a:aa4:60f9 with SMTP id
 6a1803df08f44-87b2ef0d0f7mr114768826d6.37.1760043141025; 
 Thu, 09 Oct 2025 13:52:21 -0700 (PDT)
Received: from [172.26.42.166] ([185.213.193.209])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3595df4sm2985426d6.51.2025.10.09.13.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 13:52:20 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Thu, 09 Oct 2025 16:51:11 -0400
Subject: [PATCH] target/hppa: correct size bit parity for fmpyadd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD4g6GgC/x3NMQ6DMAxA0asgz7XkoGZIr1J1cGMDHppECapKE
 XcnYnzL/zs0raYNHsMOVb/WLKcOdxsgLpxmRZNuGGn0jijgUgpjzLVqXHH6lI1FsNlf8W0risY
 slmYkHzw5JtZ7gB4rVSf7XaPn6zhOiqe7sHgAAAA=
X-Change-ID: 20251009-hppa-correct-fmpyadd-size-bit-decoding-059501a0ae49
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Andreas_H=C3=BCttel?= <andreas.huettel@ur.de>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760043139; l=2657;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=i89NyhtNNnShtWBlfuC1TSS3ynCepKkxqLXcugH4S9I=;
 b=x7a6J/gy9+pP/vPzSjxhFU8W4TBdmf1ZnhzXVRdp4QnqyJl+dgAww0lYtGcmh+3dSLdPug/9i
 XNidzicfpphBGe18EFo7wTi6Fzs5CQveT0dIJEpmUrSgfM/Xob+B/n0
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

For the fmpyadd instruction on the hppa architecture, there is a bit
used to specify whether the instruction is operating on a 32 bit or 64
bit floating point register. For most instructions, such a bit is 0 when
operating on the smaller register and 1 when operating on the larger
register. However, according to page 6-57 of the PA-RISC 1.1 Architecture
and Instruction Set Reference Manual, this convention is reversed for the
fmpyadd instruction specifically, meaning the bit is 1 for operations on
32 bit registers and 0 for 64 bit registers. Previously, QEMU decoded
this operation as operating on the other size of register, leading to
bugs when translating the fmpyadd instruction. This patch fixes that
issue.

Reported-by: Andreas Hüttel <andreas.huettel@ur.de>
Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
---
Hi all,

This patch fixes the decoding of the fmpyadd instruction on the hppa
target, which uses an inverted bit convention to select between
32-bit and 64-bit floating-point registers. The issue was reported by
Andreas Hüttel after observing incorrect behavior when running real
binaries under that target. He kindly submitted a minimal reproducer
which I was able to use to debug the issue. I used this reproducer
to verify correct operation after my fix.

Thanks,
Gabriel

Reported-by: Andreas Hüttel
---
 target/hppa/insns.decode | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 4eaac750ea..13c6a55bf2 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -365,10 +365,10 @@ fstd            011100 ..... ..... .. ............1.    @ldstim11
 &mpyadd         rm1 rm2 ta ra tm
 @mpyadd         ...... rm1:5 rm2:5 ta:5 ra:5 . tm:5     &mpyadd
 
-fmpyadd_f       000110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpyadd_d       000110 ..... ..... ..... ..... 1 .....  @mpyadd
-fmpysub_f       100110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_f       000110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_d       000110 ..... ..... ..... ..... 0 .....  @mpyadd
+fmpysub_f       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpysub_d       100110 ..... ..... ..... ..... 0 .....  @mpyadd
 
 ####
 # Conditional Branches

---
base-commit: 94474a7733a57365d5a27efc28c05462e90e8944
change-id: 20251009-hppa-correct-fmpyadd-size-bit-decoding-059501a0ae49

Best regards,
-- 
Gabriel Brookman <brookmangabriel@gmail.com>


