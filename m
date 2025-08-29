Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E41FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNi8-0002ET-Rh; Sat, 30 Aug 2025 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6jp-0003XD-U4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:34:26 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6jo-0007SD-7i
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:34:25 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b4dc35711d9so531762a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503262; x=1757108062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tOwibmf+GhgC+Y+lRl1ImCOgkIBLcfEA70fp26QT5XQ=;
 b=ddnTphDrQYqTmxi0lE38B3JYrOmAHTna52jssQy8mfk1S7OwJw2trY1TpHcrkSe921
 KoT8xhw/RbnkUmgGfixdwNnS6L8AE5HYgHOjnKQkVvzjm/lr+DOord/D7GcSOSHupN9J
 EDiqCxUFYx1xuLyV1I/t0YZtpAjuFs9Z/9JnCHZlAUgOHhepbL3s8HB6C6G9Thd2pTD+
 0S2Xy5zzYfWR1YpD82JELPCsyw+c0N7PVUwajMSl/lJ0W40T6ZOQUqviUOVexQ4SU8gM
 yXkSXEYx/R2bCDAgIrSwYcnG3BAMGsfmDOi2FDfyGHzTJjfsXsDjjR+tFfIg2Q6BdliF
 tP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503262; x=1757108062;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOwibmf+GhgC+Y+lRl1ImCOgkIBLcfEA70fp26QT5XQ=;
 b=vgKoM34tviYMbgyHWk9n9IgETy1ddtKPipLzMi/SjywA4s/vqsNH5q2DHEL2GRhvA7
 tOipTIz9B1N1hi1I9qUI0wy5pjz6HiIZgQ/e4rziPJVAUreBVD8ObS0wHEgh6LkZ2b31
 f4ejePD6Dj1D0X7vAvLTGfH1fyzAC1jpvv8wcr5GYPQQKUUfCc/NTb6HMI//8dIoBoOS
 ACBtwdG8sQrY9WHP877IIZUAQmkwATng5ICuI1uJ0v9wduQEwWTYpNJhudqADROvY6jY
 nhDzGamYiosS5AbernVhyVJmKn8nLJXRcwCGvSJzG0MzOxz5N9NJdqZXRK+E52XmDMua
 Hrmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsXzvpIjJ1BepuAi3s/5Hdi/9UsIZt1bhNhH+yhW3KuZfpLFnai86dJ+elpCxrZ645F2hWKmmAzoYa@nongnu.org
X-Gm-Message-State: AOJu0YwIstBn/VISmY843GQ/0O4IHgbR1IO11gfEmJIpZnwQJIuRqD/3
 Byft+QX0C95Rfq0nIXBt57zlYM2kOG6PNFXOvjt4rJqJvbV27IpRG/looh4+Fk29hIg=
X-Gm-Gg: ASbGncvxRsHfU/2q9Q2IHxwal5aN/b1WV6KF4uzEebZS3DrhRJgpLdbQpNbS4o40seJ
 k0oaoW/cHSrjkuKfUKmsh8UgBUXsoniU1BVXiQJT6vn2EUo4SvRU7vIkOG455czFMKKxYWFV0jU
 pzr/UgmDQv7SaX2yFPz5L4Egm0iDjuF/nyQqpAHNxku8jV70n6aljumZbggEWbbqmS1E9amHfli
 TVtmwwlLJjEwLvGMmfUWGV/9H6Xigh35+ozI+DsqwmxU/Jf9Jb9mMykrdpgtDx89D4r2fpwK8Hk
 Gly+hwJict543qDF8pnzGPq2Oi8j4TOyfO3kZicMQ4UbBLgO4toqzCzGHy9zvhgoHBMQHqyGHHL
 e2Aj1pVdZiCeHtz9EDAtep1NLIOJJ6jam94nj50g1uZIZViFbye4RHu/KgObdkjcQFn8DwdEgfN
 Yf/b9CCuOOAyYGBOUBNA==
X-Google-Smtp-Source: AGHT+IFXxOEBSfK5+FxFHO2pnYpvUjBLLTwPtFOAQabCPGnHOnqzoWI/WZnWAi40dOly0282kiV01A==
X-Received: by 2002:a05:6a20:5493:b0:243:78a:82bd with SMTP id
 adf61e73a8af0-243d6f888e7mr118494637.55.1756503262582; 
 Fri, 29 Aug 2025 14:34:22 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26abd1sm3258085b3a.8.2025.08.29.14.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:34:22 -0700 (PDT)
Message-ID: <3f95afe4-7188-40c0-9553-365328f62814@linaro.org>
Date: Sat, 30 Aug 2025 07:34:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] treewide: clear bits of cs->interrupt_request with
 cpu_reset_interrupt()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> ---
>   accel/tcg/cpu-exec.c                |  6 +++---
>   hw/core/cpu-system.c                |  2 +-
>   target/avr/helper.c                 |  4 ++--
>   target/i386/hvf/x86hvf.c            |  8 ++++----
>   target/i386/kvm/kvm.c               | 14 +++++++-------
>   target/i386/nvmm/nvmm-all.c         | 10 +++++-----
>   target/i386/tcg/system/seg_helper.c | 13 ++++++-------
>   target/i386/tcg/system/svm_helper.c |  2 +-
>   target/i386/whpx/whpx-all.c         | 12 ++++++------
>   target/openrisc/sys_helper.c        |  2 +-
>   target/rx/helper.c                  |  4 ++--
>   target/s390x/tcg/excp_helper.c      |  2 +-
>   12 files changed, 39 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

