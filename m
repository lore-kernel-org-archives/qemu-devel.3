Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25981FF885A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 21:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGODj-0001AV-Kh; Fri, 24 Apr 2026 17:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wGODg-0001AE-Pi
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 17:37:52 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wGODb-0001cB-22
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 17:37:51 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12c7212836bso4440501c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777066665; x=1777671465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=269qtn7cPdtGhV6FdZFqbMCD2iQK4aW+opNK6I11K+E=;
 b=pEHcIBC98Y6N91JMzke+BAivjBPwsnfNhI+cXWyYQNBTmcfXzFwv/P1uFhTM8mJNb4
 HNbxSnNhMJIF2I7vBihSEK6A9fmzwVkg4YI6IPK36d1pnnhtE7D6WArSOw1abbPYNHrl
 kkhir3vR7EBT55wsEfbu8NCH4m3O6tV+O+w+DqsMR147K1ixeh16QswCeSJbPZNwEG/h
 dquSC5/QbU2VBxyDIsnQZ/UfB8VhvNoRQhsKc+nZhaGNSd5iT8JW4M3CW9/VO6w7hSHm
 6k7lJzTKE6EXGAdRqF0WxOr70sAVvUTlAS3YOcrI1sVyvzd9SwWRnS2haiv/DKJEw9Lz
 SVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777066665; x=1777671465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=269qtn7cPdtGhV6FdZFqbMCD2iQK4aW+opNK6I11K+E=;
 b=aeKWfoE09WrKOan7FpQuY2gmd7d/ZT0LrymtYyoqKDvtBEdGnJBZxKHNSm9DvUziaK
 8m7QTEx/krwkZlmBrpZQrzlEWR5S36rrb9aWIVbi6HibXsnuRw1mot59CSwsMajI4rC5
 YpVFL4dqnmV6CiODt2Tpe5S7+wcjmD8yMyogktb41E516pFwvgFrYuzuL7ApSY1H9oHH
 0vSsqLh0O291kI8yPeRCpztH/wRViCoLarFWw/2WmxvKc97Nvi9ijMAtygYD/drIC0Sz
 HvX8rQg2S6T+bb99P+d94Ips2ljhzuyS88Vir+vLcP9oiJjlSWL168azxotMlqk6Z2jx
 dT+g==
X-Gm-Message-State: AOJu0Ywr2xLOknDdgdh+6StFMPEm46EInen/p1Gy2oSbGv0KSWuIfLb8
 P+5ZsDvLTy+iD2cx/0zhV6yCLVZ7fPSOy0XNq2Oy1k66/130pTRIRDRK
X-Gm-Gg: AeBDiev67kRAYxDHYudTgFqYQRu8RCRs7fdW0s7qsbpWR00h1QBh10etkqv8WPY9xVG
 5Kza0l/4XQKq/OPUERZaTcNY0jGX2XsYT7pB+9eTXE+pB0Zc1HWveTQXVJPcS2tPkrEZdpsU9Gl
 8Kp+MCVuZRbJxkgz0vWIhSiYgt/RzPcb5zdH9VEPRVWTrZ/v1uluIHR+LWGubPKMdk7NGquNpHx
 AvSefbVyAqoMyRxtH6fyDn3b6vjGeIXNGo1TYWni9WIo4AxL2C7b/QUP9PWacCxh5UBryOOHM6q
 lKMPeJMl9JNGK6jwg8bWo1TSzBj+A+7VuA4DDsxJnCnDlDmYSQ8zYybJVKSFTTYruKu7uJnzk+X
 MgIzUrZo1efOXuylbMmADwCIwUpixTEh972V+TIHOYlpPxbmeVrwgSnMNTBaS3zlIRWPn7nCh9J
 eT+4CrXM8R0BwG8UMhWVDZPecZXtZ1SKY94IFWKMI9MTB01IfXhFZtPXigDPwHd5mMhCPR5AeHk
 w==
X-Received: by 2002:a05:7022:23a0:b0:11e:163:be60 with SMTP id
 a92af1059eb24-12c73fadd10mr18223648c88.31.1777066664943; 
 Fri, 24 Apr 2026 14:37:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:6c9a:9faa:5f6e:c92f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dca2c1c16sm2390350c88.5.2026.04.24.14.37.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 14:37:44 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH v4 1/3] virtio-gpu: validate host page alignment for
 MAP_FIXED blobs
Date: Fri, 24 Apr 2026 18:37:38 -0300
Message-ID: <20260424213738.45385-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <875x5gwtxx.fsf@draig.linaro.org>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260317175744.32469-2-lucaaamaral@gmail.com>
 <87mrytwo8h.fsf@draig.linaro.org>
 <20260423234415.7753-1-lucaaamaral@gmail.com>
 <875x5gwtxx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1236.google.com
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

On 2026-04-24, Alex Bennée wrote:
> Well we at least images for the Linux side which we can use. See
> tests/functional/aarch64/test_virt_gpu.py

Good pointer — that infrastructure should work. My local reproduction
is even simpler: a plain Ubuntu 24.04 ARM64 image, unmodified, with
stock Mesa. The failure surfaces immediately on:

  sudo vulkaninfo --summary
  sudo run_wayland timeout 120 vkmark

Without patch 1/3, virgl_renderer_resource_map_fixed() returns EINVAL
on the first 4KB-aligned blob and the guest renderer falls over.

> I wonder if TCG guests will also fail?

Yes — the MAP_FIXED requirement is a host kernel mmap() constraint,
not an accelerator one. The patch 1/3 guard sits in the
accelerator-agnostic path and protects all configurations, including
TCG.

> A lot of moving parts, do you have a rolled up branch I can test
> against?
> Any rolled up branch for this set as well?

Easier than a rolled-up branch — the three QEMU series apply cleanly
on current master in any order:

  Stack A (ISV=0 emulation):
    https://patchew.org/QEMU/20260409220614.65558-1-lucaaamaral@gmail.com/
  Stack B (this series):
    https://patchew.org/QEMU/20260424000544.9617-1-lucaaamaral@gmail.com/
  Stack C (Venus without OpenGL):
    https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/

Renderer side just needs current virglrenderer main — the last macOS
Metal/Vulkan MR landed yesterday.

> This is a bit of a challenge - we will be loosing CirrusCI soon
> which has our only real MacOS build test. Either we get someone
> willing to host a custom runner or we need to find another CI
> runner that we can plug MacOS tests into.

Acknowledged — separate infrastructure problem, but I'm happy to
share my macOS test scripts/workflow if useful, and can ack-test
macOS-specific patches locally on Apple Silicon when asked.

Thanks,
Lucas

