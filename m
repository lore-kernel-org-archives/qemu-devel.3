Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C9FDEE4D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 23:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG3il-0003R2-70; Thu, 23 Apr 2026 19:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG3ib-0003QY-TT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:44:29 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wG3ia-0006tF-9a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:44:25 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so6917365c88.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 16:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776987862; x=1777592662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAdHLWnuSeVBWefsBC1Hxr6LizTZgQKhAWmdD64qU78=;
 b=kHCpbX+FAkKVc0p89Rn3vFMp4DWfiqgr+hMk9B5LEI9jZtAWngY9D/1i+wQ7kxIlQs
 BTMuKr+RvV/rBDud10zta91ceQ0OWUSwOJIAMqTs7x5OGcAPC5HG4hadPSTCGtE82iog
 uPmyOSopBXe+5T34lkk+F8840lmCM95Sjk4lVuxMaLWFfQEPtp/1xoNbs/ZfVYX1mKgT
 KZt9Dxa7XeYzopZ7sE/C3vjtsaciQsNZ2ZqxSeES3SMNdQ+Pc5m1LCcC2iCLPQC3Xmlz
 GCG2xMoO5sTF2oqc6yFqwTgdfMPe9yEc1FDo1TwSsHTIUVeIqSw5G7/coudH+pS+isv0
 SnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776987862; x=1777592662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAdHLWnuSeVBWefsBC1Hxr6LizTZgQKhAWmdD64qU78=;
 b=hyp716/IAzfmBcSJSn2waTahOfx04PwIN6EYCFecTripxVTCPiujIPsxoGYP2ONoFc
 cdzjjrDZ60T7NhpJ4MmP9bu+CjAiX+20oAydfQSFstyUs5zWh9am9aeGfIbscp93pcnp
 YUqOCFioJ9mI7wLOKP2WwZFyVZERqoHBXkNSezXAZaS71PMjit87PnXrZk0I4GCNmo21
 NY4cfJdRnuG2WttFTLSAWYNsmFk1YKBw9HmkHmHObCZfWqnXy/FSgjHaxkMZ74UJcYM8
 EjOEocTb7ZWleaC95xZ0gonjGiyY8ArEFHiZSyBpLe337kmZPlqnII/V+9etCDW1QEkA
 AX+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JT5X72JPkTConE8EHaapX1DMRJGuGAp44MDn+ShDo+fG8h5+ogCSAM6n7qUt0E9Mm+LC8tHG5z2IZ@nongnu.org
X-Gm-Message-State: AOJu0YwsxyxAxG3vuOcuf2kQ0TvzZiMp1pEePyaJeuIyYSfvpbSAxTIM
 niu77Uxk7rlnBfnTc+WSsbi2S1YYbodP+eP1jpzf7xf1v86hCHnT0tZB
X-Gm-Gg: AeBDietSsbmG8qzRE8vi/9/ooOSR1cTyzlkur2lINMFhR+OESlTtxhzMm1t0BcgPbJ4
 lyFc8y19bUbAe5vciNMqXNIjb3rfyEoEpIA9bo5hOUnvlp5JZZG67HvDACLj5Y80ZV6BqmA8Xm3
 fWdHK8mbs+TjZaDBvJu8dQsXpr3PPr1VrOrn0XfONy+Ir2XET3fKAD5gFsJLruhIhpSpIFOzKWT
 kJl8X15vi3XgGsJIxf//f5RV56gS0c9D4pyndL1gJub4tQXfcnngHXeSqMcUh26l6amLoreyNtB
 tlrwEEvabaR3Z0GbUOlcKFJPfp7CvOvbQRjxV3UWtdHsKkC658iByPLtIM+G2ibMcfLOtF0Nszm
 hS8iVVnQAKBRGcecTQS1DHxq9G/eMSnKnad+/80SypSHX86OFE7IPpdCezVYA5wTKylKLj8H6Y1
 gbc9PQNHPgc8EBnFLo0F+xSRYRjgsXBJn58KmtVElROXwDMLf+jYGkqBV6VDIjxa4l6PM1uR+i
X-Received: by 2002:a05:7022:1e03:b0:12d:c3fb:14a7 with SMTP id
 a92af1059eb24-12dc3fb1703mr1346396c88.18.1776987862361; 
 Thu, 23 Apr 2026 16:44:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:c4b9:45be:963d:f3a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c8caecebfsm20202580c88.5.2026.04.23.16.44.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 16:44:21 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, agraf@csgraf.de,
 mohamed@unpredictable.fr
Subject: Re: [PATCH v4 1/3] virtio-gpu: validate host page alignment for
 MAP_FIXED blobs
Date: Thu, 23 Apr 2026 20:44:15 -0300
Message-ID: <20260423234415.7753-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <87mrytwo8h.fsf@draig.linaro.org>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260317175744.32469-2-lucaaamaral@gmail.com>
 <87mrytwo8h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Alex,

Thanks for looking at this.

> What was your test case? Is it possible to publish some images for a
> functional test?

The test case is running a Linux VM with virtio-gpu Venus (Vulkan
passthrough) on an Apple Silicon Mac:

  - Host: macOS ARM64 with 16KB pages
  - Guest: Linux ARM64 with 4KB pages
  - GPU: virtio-gpu-gl with Venus/virglrenderer + MoltenVK

When the guest allocates a blob resource with a 4KB-aligned size,
mmap(MAP_FIXED) fails with EINVAL because the size isn't aligned to
the host's 16KB page boundary. Without this patch the blob resource
is silently unusable — the guest sees no GPU output.

Reproducing it requires the full macOS Venus stack, which includes
patches across multiple projects:

  QEMU (this series + two others on the list):
  - Stack A: ISV=0 data abort emulation (v6, R-b by Mohamed)
    https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/
  - Stack B: this series (hvf map granule + MAP_FIXED alignment)
  - Stack C: Venus without OpenGL (v5)
    https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/

  virglrenderer (GitLab MRs):
  - MR !1600: macOS build support (merged)
  - MR !1601: posix_spawn worker for macOS (merged)
  - MR !1602: Metal shared memory (R-b by Yiwei Zhang, under review)
    https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1602
  - MR !1603: SOCK_CLOEXEC/MSG_CMSG_CLOEXEC optional (merged)
  - MR !1607: server preparations for macOS process model (merged)
  - MR !1608: Metal vulkan header roll (merged)

I don't think a functional test is practical for CI since it requires
macOS + HVF + MoltenVK + a guest image, but I'm open to suggestions.

Thanks,
Lucas

