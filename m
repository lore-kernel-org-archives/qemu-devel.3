Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E03CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squCy-0003aY-2O; Wed, 18 Sep 2024 08:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCu-0003UZ-5Q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1squCq-0002pH-U9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so66065275e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726664091; x=1727268891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h1kd82LVPM0QwwFbNXUzYoW8UKMIxENMRxYyzlKOH+Q=;
 b=hZXZ/W1WhnDQmI88St0mlPkgP90Of89dz53ImV2nUPCYa6gIOR/F6jkdU9/04iZHyt
 RRP9NE6wzfE4kmEGfSSAZqPVNVovd5vJOICKXNUqC2a6I8zl8SG0evrVIf+8DRB2F1jm
 mDt+Gq1hkqPPE2FbG+3blgbnRxvTIw27w3OU2GrC2Kg6IsVoBuQBIcZ8JRrjGOO3Gm1D
 K5P8boqivR6NheIBOi4xyMPKRgWKO6rPyirzAiXOrB8IW5HsStBgyh5eKZVyGQ6EMILF
 EwPqv2z2GVBGcNBTvIVmb1iHV8b6uiwfX7KpEDt3L7XAgbL2a+H46wl9WbZTrkXw1xh0
 uc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664091; x=1727268891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1kd82LVPM0QwwFbNXUzYoW8UKMIxENMRxYyzlKOH+Q=;
 b=a6+GpcnZ+DmviYhlkH2N3edORIEnEX4u83b7RLaVKfm2oP1HVV9VtW5jqsaYqxPyTL
 BZnuQdKny7kTA/JPbhXDH49rEnGU7XiwEmS8f0gSSj+Agc28YGX+B0KJU5mSlNQG7gYi
 5e3cjp+kvoEaSVpTOPJQFWTBki2ZS0FkbzuTrIKS2kdEXwiE2CV0dkTTtVUGf60ZhvMS
 4n9rmEXDnLiHELkj+Bk11zULMEnZbTtv53TA0vsphwmFGtlqhbZH0NbkEPqDvSNwgzqv
 pTvQs34gK/RHk+j/sPWkC9pljvnnTTY90uvR1ng0AwWH+1+Mz+BtH9nx04bUqi1xQTqZ
 qUbw==
X-Gm-Message-State: AOJu0YxyqKKRi5LkSc09IRxiRXU4OiUNhxETMPYyjT0ub9IZlBo8KsYQ
 DKJtLv7pcV4QdIxzHkOBbTrVCvHoZ1VPPIl88t/veCrrt4S5zaSUaODPKQPJnsPb1DLZO7Dv+sI
 0
X-Google-Smtp-Source: AGHT+IHy/eA+FK/76d7FVVO/oTbeqNdyDjYm7Q8YpyBBb2lbU1vYeYOl4XwiwXksW0WWopEp+ChHyA==
X-Received: by 2002:a05:600c:4fd6:b0:42c:d084:ed7e with SMTP id
 5b1f17b1804b1-42cdb509eafmr152434275e9.4.1726664090845; 
 Wed, 18 Sep 2024 05:54:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7051335fsm16410645e9.30.2024.09.18.05.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 05:54:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 0/2] gitlab-ci: Make separate sections for build and test
Date: Wed, 18 Sep 2024 13:54:47 +0100
Message-Id: <20240918125449.3125571-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patchset uses gitlab's support for putting special lines
in the log output that it will interpret as the beginning and
end markers for a collapsible section in the build log.

That's documented here, but it's just "write a line with
the right format and a timestamp and a magic escape sequence
in it":
https://docs.gitlab.com/ee/ci/yaml/script.html#expand-and-collapse-job-log-sections

Since gitlab puts little "time taken" bubbles for each
collapsible section, we can use this to easily find out how
much time is taken for build versus test.

Patch 1 splits out "make" and "make check" to separate make
invocations for the cross-build templates; we do this for
the native-build already.

Patch 2 adds the shell functions that emit start and end
section markers, and puts in section lines in the job
templates.

Since this is just for convenience in looking at CI job logs,
I have not put in a lot of effort into dividing things into
sections -- I've mostly just put configure/build/test into
the templates. We can always tweak the sections later if
we find out it would be useful.

If you want to see what the resulting logs look like you
can look at the jobs in this pipeline:
https://gitlab.com/pm215/qemu/-/pipelines/1458593312

thanks
-- PMM

Peter Maydell (2):
  .gitlab-ci.d: Split build and test in cross build job templates
  .gitlab-ci.d: Make separate collapsible log sections for build and
    test

 .gitlab-ci.d/buildtest-template.yml  | 14 ++++++++
 .gitlab-ci.d/buildtest.yml           |  1 +
 .gitlab-ci.d/crossbuild-template.yml | 48 ++++++++++++++++++++++++++--
 scripts/ci/gitlab-ci-section         | 29 +++++++++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)
 create mode 100644 scripts/ci/gitlab-ci-section

-- 
2.34.1


