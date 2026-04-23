Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DBFF589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSK-0000dB-2J; Thu, 23 Apr 2026 09:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuS6-0000bv-E5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:50:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuS4-0005T2-2D
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:50:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so86213585e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952238; x=1777557038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+Gh4gAhCyJWuIktnSc/R0tEKiQpXEAJ3EEfe3HRlIo=;
 b=eZQJJTT2PNGwteGoYisNkprb0kNqBO7UlRrvvT0XLB5gKHK/oAv0Ukjjj06QEdMyYH
 hynWdbs2lrMOnnOLLJeny7Qjbb31CFLvX99TzkuY/LMJCr52lB9fAn+pjDYOhy5dEOOL
 7twaN5VGxbRCWD/yNjeVMDIjx82p13ooUU2GcQmut902+4BAFh8G5E9NCsCXzKvlmOfc
 Igpwfj1c7mQtCV+IRTyZ+bjhIIaker+KG4tcc4HEEnepTLumolJ/mqFU4gUnpZlkHlSp
 55cy99zy0ezX5F8QYbT+t9z9BG3HBf5NcHRLUAvsmJA0AyZ0Y/8egJ56OI7/EQKdu2/H
 Mzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952238; x=1777557038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+Gh4gAhCyJWuIktnSc/R0tEKiQpXEAJ3EEfe3HRlIo=;
 b=HZ6pwyay9+tpmwG/ymwp3QxMwkkQgNwBPuUY2fgu/XorJfjo+/oBJafuIPBwuzv7sx
 4B3tbdLQeDcKDc1qaVRwkYenQqTSgB/qWR0CsI+mTDmf4+kCdNqnm54alzti75+lbH7t
 koWRr/6nTgjeu2jiu6t+qLOx5kY/7peLUYe3fqjbPIg1m8zz6fy8A7yKcq3O7tMDzd4i
 XG4XGesg55mFKEH3/iVBng8tNhjvzGtuOg3JEpiTicLlPJsGEKCC4SODXBarkaoIv2Hr
 D93qmyN00EhAgRQgRPaU96NL8jFVIjhAHvNuNwSluATGZ7HCqjz5Ukg5NyWIpC0s6jrG
 MrmQ==
X-Gm-Message-State: AOJu0Yzg+bCeYy2fFCchtNHtaaguimHyBRm9H+rN37iJBsEJKs57Ho1G
 sm7UK3beSIDX70oD3CS7I1SIu5oQsdKIwFMCV8tEsF6+DBPUWBvGrDQAAtp7m7QnYYaM1G5IwZI
 8TxU32hs=
X-Gm-Gg: AeBDies3tnm+8xr+7eEPwNzL9Xgl+TP2LKkVNT0uzYM3xW4WmsLqZw2yO0PqG1U2pP1
 3bXkGzm1h5M1ezrFODoFufrlfQyxTNTr2/hHMRHtZ7kPelblJKOIAyukuwlOiD9jjURzbTg8DnW
 JIEVw9M+QR9UxcDMum0mAZGE4DFki19yh036vcPlladC6ZYlJRl5O6+7nIYvMPBiRFwKhFVxVQt
 r/ZNKIb6mUp+8csRQySKU5E2BpRaR56NXp4cJbMHVBP+NM8LEvV1axl78oWlo5p15ZbLaYdNVw6
 vl1bNiFnbD/+Q4ytQiaaCyFOoFn3HqqptBs5kEnQNlWw92n+gozFkQiLtli4+RsGZ4zsPF/a+FM
 TsYjDdLS5Q5PykIpnHFnygYoC0sC9M+xA0lveKU0Yo2HcC75Gf40z1lm8W3uiW9mfvXKS7NFoHl
 iqGiQBzXrAWyX7h6dtAZfHqUd9BD1TPFnkCBo5LNfN2qIi4pbUxdhL8Gn+CxM/MhjZ9dQ70vjDn
 YA4eFOJW4A=
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-488fb782d91mr407738965e9.21.1776952238307; 
 Thu, 23 Apr 2026 06:50:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm165558255e9.2.2026.04.23.06.50.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:50:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/s390x/tcg: Compile various files once
Date: Thu, 23 Apr 2026 15:50:26 +0200
Message-ID: <20260423135035.50126-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

When a file doesn't use any target-specific knowledge, it can
be compiled once as common object. By moving the file to a
meson 'common' source set, we ensure no target-specific API
will be ever used [*]. This series move early few s390x TCG
files to common because in the current state it is cheap
enough to do so, no need to procrastinate.

[*] https://lore.kernel.org/qemu-devel/beefeef5-96ba-4645-a01a-7ca96055d93a@oss.qualcomm.com/

Philippe Mathieu-Daudé (9):
  tcg: Include missing 'tcg/tcg-op-common.h' header in 'tcg-op-mem.h'
  target/s390x: Do not compile KVM stubs for linux-user binary
  target/s390x: Introduce common system/user meson source set
  target/s390x: Compile few files as common unit
  target/s390x: Compile translate.c as common unit
  target/s390x: Compile vec_helper.c as common unit
  target/s390x: Have MSA helper pass a mmu_idx argument
  target/s390x: Compile crypto_helper.c as common unit
  target/s390x: Replace cpu_stb_data_ra -> cpu_stb_mmu in STFLE opcode

 include/tcg/tcg-op-mem.h         |  2 +
 target/s390x/tcg/crypto_helper.c | 80 +++++++++++++++++---------------
 target/s390x/tcg/misc_helper.c   |  7 ++-
 target/s390x/tcg/translate.c     |  6 ++-
 target/s390x/tcg/vec_helper.c    | 34 +++++++++-----
 target/s390x/kvm/meson.build     |  2 +-
 target/s390x/meson.build         | 25 +++++-----
 target/s390x/tcg/meson.build     |  8 ++--
 8 files changed, 96 insertions(+), 68 deletions(-)

-- 
2.53.0


