Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECF0CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 21:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snPD4-0001Zf-Vz; Sun, 08 Sep 2024 17:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snPD3-0001ZC-R2
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 17:12:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snPD2-00083S-Ay
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 17:12:37 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d985b6bbso2017273b3a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725829954; x=1726434754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfHhOjtooLJmr3ZKYvqakDOtYPuaVbyGKV2a8ckUJok=;
 b=awJLvb/sg8lghXL7SQxCGFc/g8A3ENgbrb5LT2f4W6EXpy7tOa4OxK9DYQq/60LFXB
 PY0O8iQOeZI54wtDt45XUwvB5i4xyfYkUN00OW4vpKdj2NDqIcXb0VqtqFZs7ZYMNFUU
 Ve5SmJQtG9p+pUHvdxS4SVtk92JeYkPSke+lTjjIpMvkS21iE2ALnRYbhsGuEyo7OiJJ
 Yw5Z0IEogVVAp4kHACjZMwu3hEGUlM4tvIbuLWU+Wq3p6XQgnjFCuXuX9gx+Xnh/uI5F
 yo5SFYfQ30m5mZ2hPqu5TAh1AyfbbD0YKp1woqX2OSQkqUd4MEVSmQ0/DB5VnaIzFX1V
 W0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725829954; x=1726434754;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VfHhOjtooLJmr3ZKYvqakDOtYPuaVbyGKV2a8ckUJok=;
 b=GiDtV3rCyy7VinOfb47QmJ9GxXDvAocGdAfP9khrSAPWJZjGawKcFGAwzTY8p9HGKw
 wDsWMQ3dYs5ag1QOYTIDu0hBx1XAUlhx1KBiJMjiMTXYxblXYFXZ256wxIDswJFqx0wl
 anYa7iR6pAkBtBQJopz/LQCL+X1fgWxY22CinKiHTkguS/ZzpMubiDAbMc9n8icr+7Ld
 5Vq1oeqgWkoJY5NL8RrWuEQLLOWa7VFz7D7uopJ0hWq4ZTOOLAWw1xBAMB/gYwxGIOh4
 dd/e+k37fd0wrF4DtaZh9GzByhhGm/h13Pw7Dn698VBQzja6gLiPzI1gS+MFoqwHUKuM
 9lDQ==
X-Gm-Message-State: AOJu0YyLZIbChcm9PnCnZ1H00tYLrhGGxlwN0ui+b1HA7FYXjykhkYdM
 3xPbOtRJozpJeotNZniiAX9WrnaH+QeuVzxEtc+hRQ2yz9nlRsiWqpiOeyWiFvr7WTh0KHxLc0c
 p
X-Google-Smtp-Source: AGHT+IHKgKanToKoYlf56gWvAO0CWDHHWpU30vg2wrO7jIR26XMrWrFuNecXXdaMxw9kpomrnn8CRg==
X-Received: by 2002:a05:6a00:b87:b0:70d:21d9:e2ae with SMTP id
 d2e1a72fcca58-718d5deec8fmr11979974b3a.6.1725829954300; 
 Sun, 08 Sep 2024 14:12:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5982c8asm2463481b3a.145.2024.09.08.14.12.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 14:12:33 -0700 (PDT)
Message-ID: <10506b1f-a2ea-4b58-9dfe-32e40b998895@linaro.org>
Date: Sun, 8 Sep 2024 14:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2? 0/2] meson: Rationalize sanitizer configuration
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240813095216.306555-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240813095216.306555-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Ping.

On 8/13/24 02:52, Richard Henderson wrote:
> In the CI that we actually run (x86) we don't want to use ASan,
> only UBSan, we jump through --extra-cflags hoops to make that
> happen, and we fail to disable function sanitizer during normal
> configuration.
> 
> In the CI that we don't run, we enable ASan and fail to disable
> function sanitizer.  So its a bit lucky that don't run it.
> 
> Split the --enable-santizers config option, and move stuff back
> to meson.build from .gitlab-ci.d.
> 
> 
> r~
> 
> 
> Richard Henderson (2):
>    meson: Split --enable-sanitizers to --enable-{asan,ubsan}
>    meson: Move -fsanitize=undefined into normal configuraton
> 
>   tests/qtest/fdc-test.c                        |  2 +-
>   .gitlab-ci.d/buildtest.yml                    | 10 +++----
>   .../custom-runners/ubuntu-22.04-aarch64.yml   |  2 +-
>   .../custom-runners/ubuntu-22.04-s390x.yml     |  2 +-
>   docs/devel/fuzzing.rst                        |  4 +--
>   meson.build                                   | 26 ++++++++++++++-----
>   meson_options.txt                             |  6 +++--
>   scripts/meson-buildoptions.sh                 |  9 ++++---
>   tests/docker/test-debug                       |  4 +--
>   9 files changed, 41 insertions(+), 24 deletions(-)
> 


