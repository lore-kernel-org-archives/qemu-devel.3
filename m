Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3A6C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uK-0005CW-85; Fri, 14 Mar 2025 09:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uF-0005A3-OZ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uE-00017G-35
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so19608655e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958212; x=1742563012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IdlyuYB3xYVCVbo670B57ocGusiFprbIk9JgFgFb0pc=;
 b=PgtgWwnCRDiesjLogeUIt8FhwttLmLa2OENjuUJQt/4t3anwFs2ohDKLprNvOUraoI
 82+HoQhluqj3/2uHR/jI+VRVsEJFr9ReI08aIiGfn+dikU7cvlA0Tqis85ivSZJJj1hs
 fXTiGFOo22StS86+obggYOF/YSQlAd4my2Xqc9a5rpwA42FMv7CQ2xDO9y+m025htM4p
 KkrQZU1ejEkISFVdGABpUSeSZK8uPjIFkRGTlk0hVGDS0UkDcIhcmFWGsPmRLlEcD9j5
 hX6ajOYTQ0uz+aY9hlSYYnIEO6fyF+8Yl3L/pquKL2FOBvSdJseG+7Nm03u5oPLM+5pa
 n4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958212; x=1742563012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdlyuYB3xYVCVbo670B57ocGusiFprbIk9JgFgFb0pc=;
 b=BFAmzwgUfW4gQq7PnM9lGjtot6BY7ELWrAhnDXPnrd/CHV/7sGPX2N0D7/HTaNaf5p
 2jwiW2bIeUfy4LCscK8HKo1w8LNeAXsrWbq/534j81LD8hi73mRFdFuJuqjh6FyGOwrF
 PhqXmznwe36C95QrglJaQZPEfyMNkDUbqpvD9nCXLZM+ErmvWN6WHGruPqB3wUNO1q+j
 22Oe6fM/XluJdcH9v6XVyr1XzDOJOspH2t0bkaj6S0ayiNIWrern0QmGaxVim4vxX4fv
 qIFqhZsXtu8nj2E3LroNbzAf+23LwNIm+/M0qQnRN1hNwWppU4++m5pYRV9K96/O1EtN
 eumw==
X-Gm-Message-State: AOJu0YyRIC4vL+vusGi2+uFdwASkFiv2l/Rw/3cKD3CvW8fVE4ruTQ7s
 SYHQSQR0jZBgpMaxJGXy/wBb1xBbJNlrSVyZeaxpZAipd1Mjmu5ZC1GDHxzO5OdTjAL88wMdpdO
 5
X-Gm-Gg: ASbGncuuHaPQWJufUnoHAUHzM69MSngCoktr72WhsSCwBJk2Kb3yc8Z5L3OJHA1tyHU
 ovK+wDykCAAKQ3VznrdvOA3WGT4BZ4OVn1qCF+2V1/8acfwRndLwXaVQ85y6LpkywS+GF62hiJQ
 FxAaiImc0L8N6QCkmONg7SbqhZxQeezYYVfUTOjDHKsBKev2xqQof9QYaxQ62hIjk3OYnN1kTBJ
 v8+J8AuB4B+PoORnN2v0bqalrhzOwQ6EwUg+XxLkECq87xldBRSp/uzOWLZ/LC0mnP47nn56kJ8
 iq1/OYNwda3vE1i1CqBTMUIAgoZL7Rx2RKZ3XLt4+OCCrfayUnk=
X-Google-Smtp-Source: AGHT+IF+fLVAMMWK6hNHKyftY0K5DbDX546vHTcnKWIsYrU5xqGrSnNbK7Ps97mqvOftjHtoTKJVCQ==
X-Received: by 2002:a05:600c:45d3:b0:43c:fe85:e4ba with SMTP id
 5b1f17b1804b1-43d1ec8e7eamr35861295e9.15.1741958211664; 
 Fri, 14 Mar 2025 06:16:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] tests/functional: Bump up arm_replay timeout
Date: Fri, 14 Mar 2025 13:16:32 +0000
Message-ID: <20250314131637.371866-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

On my machine the arm_replay test takes over 2 minutes to run
in a config with Rust enabled and debug enabled:

$ time (cd build/rust ; PYTHONPATH=../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
../../tests/functional/test_arm_replay.py)
TAP version 13
ok 1 test_arm_replay.ArmReplay.test_cubieboard
ok 2 test_arm_replay.ArmReplay.test_vexpressa9
ok 3 test_arm_replay.ArmReplay.test_virt
1..3

real    2m16.564s
user    2m13.461s
sys     0m3.523s

Bump up the timeout to 4 minutes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250310102830.3752440-1-peter.maydell@linaro.org
-- 
2.43.0


