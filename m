Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DF8E6BF1D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlqDS-0001uT-Va; Fri, 30 Jan 2026 10:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDI-0001sb-6k
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:12 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlqDF-0001HD-SV
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:15:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so29577025e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769786108; x=1770390908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u8DoG0M5QeffjvDoH1tbWrg8Qsvu+t8M0JBqwNamlJI=;
 b=xIeiXa29dHkQI1U2bGA+L3MQmb0WY5VZKuJpGTJEIbX4nhzzdc1dMF3fMesq0mDes0
 pOPk4r3IpJnJONcXOQx2jz5kXW7UrkzoVc91gzVKm5+fSKjyjUq4vlYgnmtd7TCBV5hG
 VKfJJNvMEeh0oaHjpTqikX8jOKRjuy5m3PBzTnE0SCdGTZBKE70NEoiz1CpCzGALtJ3G
 4dm5jNx8aOw5HB+KReOvKuoiIOWtZJQdODw1esD1q24ykGPDo4+hAyDaORMBhUm7MGWJ
 G/9tUC3ZC2j/JTSMn44M04TfmqUPOUEbwil/5QAfsySZS72jr0GiD+ldeTPYcc3B7+w2
 LqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769786108; x=1770390908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8DoG0M5QeffjvDoH1tbWrg8Qsvu+t8M0JBqwNamlJI=;
 b=AqZe3JRCy7vZheUxl8aAMekekfqeaOE7q4G/1OEcgynl0ikyefaCWe/nun4R74VZ49
 3VfKzt+9ux9/jHc74nPFVEhAHflFdC0NZ4Ff/Zb3y88YzACDRF/G7DbUoYuKZMVZlxkb
 oA2UdEvsgZxN5jRqmFodOqdwUB0Y9OIAfipyod3y0nbBBVgEbaXp7hStVMsUEI0GnyXA
 IfA4cA0lC/zx4xs4pD3OuXS9aRb5QuIHaeD0WtyPbdOGcFjqcJSMuUuaX897ZTN11WPW
 D6fjf6xQRSkqotqtlMX+ii/QYDtWTrYrwReHeLUe/A9RAAk5yXGErkrRrQXwQz1CB1AY
 D2Mg==
X-Gm-Message-State: AOJu0YzOIfYh1fz3uo9oMZH/RNQYfvkV3wkzYct1oaNA79kbB+Xo1wz6
 Xg8YAmi0s+aEqeVDyFyoNZcBvH7/kHCDs8mM/f9SwIaFe1oefqJxypgp51/y+7uVDzw=
X-Gm-Gg: AZuq6aK6Sv0imA4lfTHnDh0vAcCPzjJ/5HTPXWSmwlucHpqw9Gaj3K/PPff6Gd4LAzD
 0kCRaZTZ73r2b5DJdUxdkmU29tJk5PAfBq5+YqarqyWmzGBemSODOPKVOyu73eYQTd9tAm+IPGi
 FqatlVMH2VYYKXXw0U3QChG8523dOVDLdZfHn3fU/F6tYZCABJIV44gfzAmnynS9n8BYP87cUFk
 zvrZeYqZMlab9bCxN0Cn6LjBkqu3La8clsS5wctoinJLixfpDGtLFOPnI/jQdC/HiJ1Q4xWdbJs
 6126JATMJEC9R+eL9BYIijioImsc+w5C4XsYfaJcMAu0Af926AWrP8tTFZwVCqrkoyVCfT5+mQS
 jDqIcN0YWlrAKJeK9D+lpDaQnoZFS91MSx9eQuoJI3cacuEICIuoz+5DzC00NEWvUVKMXLmIQoB
 6L5keP4NDZiFw=
X-Received: by 2002:a05:600c:3115:b0:480:69b6:dfee with SMTP id
 5b1f17b1804b1-482db46c59cmr37521065e9.15.1769786108042; 
 Fri, 30 Jan 2026 07:15:08 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e04a87a2sm17665285e9.4.2026.01.30.07.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:15:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6ADAB5F856;
 Fri, 30 Jan 2026 15:15:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/2] testing fixes (docker, sbsa-ref)
Date: Fri, 30 Jan 2026 15:15:02 +0000
Message-ID: <20260130151504.550929-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:

  Merge tag 'pr-build_fix-20260128' of https://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-fixes-300126-1

for you to fetch changes up to d9ca273f8f31acb22d3f5aca5f063b94fb962e19:

  tests/functional: migrate sbsa_ref test images (2026-01-30 13:52:59 +0000)

----------------------------------------------------------------
testing updates (sbsa-ref, docker)

  - restore weekly container job
  - move assets for sbsa-ref tests

----------------------------------------------------------------
Alex Bennée (2):
      tests/docker: rename wasm cross container
      tests/functional: migrate sbsa_ref test images

 .gitlab-ci.d/container-cross.yml                       |  1 -
 .gitlab-ci.d/container-template.yml                    |  4 +---
 ...sdk-wasm-cross.docker => emsdk-wasm64-cross.docker} |  0
 tests/functional/aarch64/test_sbsaref.py               | 18 ++++++++----------
 4 files changed, 9 insertions(+), 14 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm-cross.docker => emsdk-wasm64-cross.docker} (100%)


-- 
2.47.3


