Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D676C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmoZ-0000w5-6u; Mon, 24 Mar 2025 14:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoW-0000ua-Kt
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoT-0008Mp-Rm
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso36110775e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742841975; x=1743446775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EtHbfn1fbFKflRQMdeysPm/QTqpqrsNvRoPoT6AS7VQ=;
 b=eMRx/pSKTjLWa0FccGmAtPjED1AW+mWFKbpwwloTozX77mp75zoEbCa0a6RaFKRMda
 QnFPGpx0Mw61Otlhfh9YrO7janR85rJHmDTqk+oHgebL1CMOgWj1NBFWMLRIn7KvlV17
 RFXyMVi4YbbqVzhbfZWUq61/8cZrx/lzawJHlaVfQbGqaqgDexkDXo8Rhz05uD+1CO8R
 s1nrRMSPrJE3c4qm/jlDvfqofZPRi1mBbcvIEfpsnbWFkzCadu53LrphbzguqwwfUVIz
 Vy+lmgYs+virtEE7svKg31Ky6d2NpKXza3W/9L49EodwUBKofDvqAjfHvLp3zc/kbiGz
 s0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841975; x=1743446775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtHbfn1fbFKflRQMdeysPm/QTqpqrsNvRoPoT6AS7VQ=;
 b=Gd5fSOM/VscejSJCGGZx3Si0kjU4F6IeezoIQtGs4ZLPZKq8cnLGR0WWnWscBFxg5j
 O3pUa3mueJSaXoOiiCTzcKcH0vtssQCbJ8ha9YHW5+m3+Y4OHx3W1ksCLg6PPZRsvp28
 yZ9jzFrNVo+Pi1PyFTt6JfndFOeMeJOljj0aGUv67RmbqN6DkFvQIrVYlbwOyj9CPbQC
 p4jwsUw/ldm2+uujEWpZlNitDfG6OZ9QX1oZ4UsHRi90R99n5QUgEi65JvuVntrFdQq7
 b+ZlAfZ4gOA3iuAK4TGgmJIZ8U+OUIexu7aVnTgW/yCSwpR1SqiKb2eTlgesvdoDcVOu
 eppw==
X-Gm-Message-State: AOJu0YzBLhxhjNpb+F503qWO8yEXUMo1g29lBZEmIXYvH1SWEllsQZ3k
 ZmeBtcPy6BaXt28UO6x4qxJuAq+cgnHu26Cz6gcPs/q5rriMszmOoGw3s70YLF0idZL2DZ/VYs3
 r
X-Gm-Gg: ASbGnctJidBgySlaUEhs2oxqpXZiEVwhmQ0L9cM7FWV5NgE/SeYBzf8K3by9i4d6DpV
 u//Q+LcxofoVIfWt61bp2y5Z20geVzKFMP9pSbYN3pz9wVwVHdyKTn1DhvAGoUeXy9KZfHt7s3O
 jjpdh+iMDXV25urDs3OeE/jjSSxMwKFTdy9jDilguvw9sjxCdX3ivG/R/gWD1aZWTJsWvwebHxz
 glM7s8ThqKHc1NHk+TRL/adHCdvGq4b63kcBwbeuXUeDEd53BN+U3bZzSAtF8nmwhS0yJgRzySg
 7Vqav1ZAkK3i3yxsOz4ysEcFnfqmclPHEjlE3FbisJB5XZNFL4BgzEYt9Wob1X9l190huR1NMiw
 uc3tM0bJ6zOQHHewvAI80lBX/
X-Google-Smtp-Source: AGHT+IG1QuCF9/AdZQSgHISCEMTJTjQkAz2xZ3QXb88KEbXmtqc4BttEgoGYJERcSiLAGg551uVT8Q==
X-Received: by 2002:a05:600c:3b95:b0:43b:b756:f0a9 with SMTP id
 5b1f17b1804b1-43d509ea96fmr129771595e9.11.1742841974818; 
 Mon, 24 Mar 2025 11:46:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f43e50sm177444345e9.12.2025.03.24.11.46.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
Date: Mon, 24 Mar 2025 19:46:04 +0100
Message-ID: <20250324184611.44031-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1 (Thomas review comments)
- Move s390_set_qemu_cpu_model/s390_cpu_list to "cpu_models.h"
- Correct 'target/s390x: Register CPUClass:list_cpus' subject

'cpu_list' might be defined per target, and force code to be
built per-target. We can avoid that by introducing a CPUClass
callback.

This series combined with another which converts CPU_RESOLVING_TYPE
to a runtime helper, allows to move most of cpu-target to common.

Based-on: <20250324165356.39540-1-philmd@linaro.org>

Philippe Mathieu-Daudé (7):
  cpus: Introduce CPUClass::list_cpus() callback
  target/i386: Register CPUClass:list_cpus
  target/ppc: Register CPUClass:list_cpus
  target/sparc: Register CPUClass:list_cpus
  target/s390x: Declare s390_set_qemu_cpu_model/cpu_list in cpu_models.h
  target/s390x: Register CPUClass:list_cpus
  cpus: Remove #ifdef check on cpu_list definition

 include/hw/core/cpu.h      |  2 ++
 target/i386/cpu.h          |  3 ---
 target/ppc/cpu.h           |  4 ----
 target/s390x/cpu.h         |  4 ----
 target/s390x/cpu_models.h  |  3 +++
 target/sparc/cpu.h         |  3 ---
 cpu-target.c               | 25 ++++++++++++-------------
 hw/s390x/s390-virtio-ccw.c |  2 +-
 target/i386/cpu.c          |  3 ++-
 target/ppc/cpu_init.c      |  3 ++-
 target/s390x/cpu.c         |  1 +
 target/sparc/cpu.c         |  3 ++-
 12 files changed, 25 insertions(+), 31 deletions(-)

-- 
2.47.1


