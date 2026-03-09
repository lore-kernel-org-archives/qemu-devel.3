Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8AEFCD9C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZDa-0006vR-H6; Mon, 09 Mar 2026 07:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZDZ-0006rH-AE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:56:13 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzZDX-0003Ox-Ns
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 07:56:13 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so9642169d50.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 04:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773057370; cv=none;
 d=google.com; s=arc-20240605;
 b=lirZQ5Td/4zK0x52OIIY7RwzmP+38mTJ1GH19Vg89i7i8+9jQvpVNAtyCZNNcweO1n
 YYRuKBLSb+9t8Iwv9w7W4AC/PMN2tKIrokMs0VoFcvui2KBwuaSuA2eztCwTfNQDuY8h
 bOq0UE3Vux/64EGt264pYMJRBcjvCJTP0A2FEll2a+aRHDh5co+nKjNvZoVl7Uj0DomT
 MZ5MJK5WLhgKU+hmOyGiPVe/1rGKBNsJV/qy0S4dpOXjg4K3JoaPr5SBr2Gw68Z8+Od/
 EqUV3AzbNTXtEDZrErv7p/OfIthEYReKq0dp2ClPSc5c/YRtB8CirQiRdSHNsx12IN2K
 UwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=94Iphx7gUJzQt83oBXB8zMjuJKGMu1qLm/q7hqFuGLM=;
 fh=lsCqHUXZE9oE8/N/BQx+TqZ3m1fFVYRPKbMaQkTxTcU=;
 b=diURbOceOzH8juSL1N7f0ObQIiYdbPWgX6LR4/KE4b8CT8dM24QL1QamgJxTcLqBpY
 TeSuC7iZGunB7/uMF3ihH52gKpce+RV17Hl982Z0VEkqJZ8Xk8ParEp1ojw/1kUWc2Sz
 sFKf+2uxuMntF6Ey+w4Aqtq1b94q3c0m6V4vx9Qq1avmFud9CuofL5/7j4/zrfjDl91F
 +JdfxEyQggC89g9w4BPZqbUvN4ZZi9tZA08g6OTVhlbDw7is871BeQNrNXUjLWEmj/9k
 BYJJQlg2XJlIwPmAJakCc2JvpPu3+pHiNAoYLNN5r8IlYH2R/qCsSZA1wd/h6UO/B/XR
 RVDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773057370; x=1773662170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=94Iphx7gUJzQt83oBXB8zMjuJKGMu1qLm/q7hqFuGLM=;
 b=MNultRMuKXAJ0uotrjY5cWd3YHv3ZVBC06wEJHHo0iS7HBil92qc4Ns1CemsDGZn7a
 Vc7Qs6CHAKYYTbBs9Tm4HhOZ1a4fuLhV++rpnNWoPWS0vJkr2mYIpYfcu/0ZdttegZeu
 iIkcwCgjoKQ0GQRINZooCQ4KRSb7wIikGohLoj9VPP/x3ATxuzpnIOaA1LQD4wV2TZRo
 emDt0twQMvbzNM5/NrNPwYS2hPWSk2qZR21U+XJwGZgIQqCIjnPftgr9mA2IjBQ63H3a
 Pn/n4KIYmX8N0L3BvgdnFP0t6v0xvqcWG0csmR1GNgn5unjHAe+8oU/xcMsUa8rhspt3
 LAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773057370; x=1773662170;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94Iphx7gUJzQt83oBXB8zMjuJKGMu1qLm/q7hqFuGLM=;
 b=YAOFSX2WhseWJ5zp+HtCPebcqh0dOOkKVdPoYftwyRaIAOcDiFXznzEBzEqvxUWucN
 4Qg0w/XleFB3D7Gvt0Lpaa6hOCp2foPNtr/BcmBjkw9bkw7Wg7yyfdeKHX/2BxusEG8I
 2mVNdJjIltLGOI1U43/fDqQCXtHYbkfi/G5Eyhl4Xb4hHuWzcJasF+EYvKZ+LCoOR+4d
 U68c93UKhBZavEzyXpUnCsE7GA/+AyExR90BUN23uPTnytRBVno4tu1D7+zkRiroKQBi
 KHcSxrTBo5yBbj4TAjhITHvIKTN+/sPIzfH7xTbrvbt7XE/EvzF3wLdeUr0Yg4HeiVLU
 ICwg==
X-Gm-Message-State: AOJu0Yy7+FzGNGWUa/pInFGKLXCVzDlEyIw1iDywDfG9JZvhNNkfqiqY
 aImZXLyLzEh5Nxg4nC3Yd0wsRxfr5CpSJhW3wDfJqyMJuZPEk05mWJdQJrdGfcIUzLbNqM+qwP0
 u2nFiy05aNY62lCjmmTcbeb3Ob2LduwRw0ceZFBivKKY3q7GJjRxS9ZE=
X-Gm-Gg: ATEYQzx4lO4qtXZaZfjb9/73Jow2fb1VnOBhzFjXNQS3w3g/db4ZgbdMN9AQAL1aw0W
 9zAlGDOtmD0ayTtPgCZ37xwygN6Ji0HzhL+ywI9D7ccwgrB0yq/yoxj4Gy/6Xq6T0JVeAdSn4xT
 Lh3W8ToJqi/8mqKI80bnCZ8iY8+qvGZO9w2lAxOcB8gE3PyhWMUnrjEtJmcR1QdZuiTkxzrvCQI
 lZb/I58qbNOmBy7qK9jKUYHfJ0wyagM1iLel5FbO+99DJ5pMI5KwZapMusYF4D6U1F9Z6CCDZpq
 8lRNJFgYgp5J/J/+zU9Nj5cHt5W/fMMfCETZnTeYX36IENKna+dMcw1Bf8ENQG3xlv0=
X-Received: by 2002:a05:690e:d8b:b0:649:4302:cea2 with SMTP id
 956f58d0204a3-64d142794c8mr10614786d50.43.1773057369804; Mon, 09 Mar 2026
 04:56:09 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 11:55:58 +0000
X-Gm-Features: AaiRm52WVhx-DyKeaCUhxDvUwTTQP-e0gYPjGKbljkCtdOZM-MZrpg_4cAWUoiY
Message-ID: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
Subject: running a single functional test: where do the logs go?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

The functional test documentation suggests running a single test
with the build/run script. But if you do this where do the logfiles go?
As you can see from this transcript, they don't seem to get written
into the place that a "make check-functional" run puts them:

$ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
total 16
-rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
-rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
-rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch
$ date
Mon Mar  9 11:20:13 GMT 2026
$ time QEMU_TEST_QEMU_BINARY=./build/san/qemu-system-arm
./build/san/run tests/functional/arm/test_emcraft_sf2.py
TAP version 13
ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
1..1

real    3m24.394s
user    3m21.314s
sys     0m3.100s
$ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
total 16
-rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
-rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
-rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch

thanks
-- PMM

