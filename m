Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D45DD6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgmn-000516-HC; Thu, 14 Nov 2024 15:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgmj-0004za-B4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:49:51 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgmh-00053v-Hr
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:49:48 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e9b4a4182dso814536a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731617386; x=1732222186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJUD9uM5PxKptuVyfms2yHOSK2OiJKniu5sJIcGJ8Bs=;
 b=A0j7sDYItP8UgnG6mxdw+aGyxQmBTJxptPJIiGCHv68X2o7TtEhXDUQbOmqdo/W08k
 YRM+PwmOGBOzM2qJzmuer3p8mOx/0EpUDdWIfRvhNuOYjoiXA1RQj/TTl5WyTilgko1k
 aCmD2Pp99anMs+56+GCqawC2MOPEEPvSVHaesSpHMGoA8HwggApzoC5Z3EsEII1wSq6E
 LN5gRDqyUveggqPbqjbpe6xb/rvtlqEm9KT6BPCzaZdSvbJyGZvuEcsApTpJ3kHDvLLO
 eMxem7G+gZTV0xhaXIsv4f5IpJrUkmArf6o81DrUr1RLc3Zpo520IQU7ymy9ULZdGl3l
 kUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617386; x=1732222186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJUD9uM5PxKptuVyfms2yHOSK2OiJKniu5sJIcGJ8Bs=;
 b=Ue1EDd/Jlpwd5WrIr06bacnt5I1ZXgboNwUDWm9NyFZdY5k+aSw0uEY9nAn7JwMv+h
 qO5dV9Bi96KX+deGZZY4Keb2lgNeSCtF7nru0SsFenzHaTFYDPgrH2ep4bn8dU3Lx9Y5
 cAsSiJRjz5kqnveeLtniINDh3IaoZfTjkRjOTrymPYhWYykeYbKi1bWMB3HefuUi80FQ
 PzJTPrGWa9RYiBINI8cPMnSnUVTViPb/94mKKQyEdAvvvmK07apmRUug6c/VcLXgG/vV
 C05Oqi7WfNPFgUzfx3oE0jMWMn2oNgDd30ApZh2iK3CbWOR+AS03Qa6cIFsTcJnPH96o
 66zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGLdpQtNb5p5q62UQilvdXt3peNQRw5mMJ7YR1p+TYYCnENo8XFOTC07jND2Mz4KF1SoiyP464KKqM@nongnu.org
X-Gm-Message-State: AOJu0YyBj2hQYrrasLZcQvlE2l/JSn2AzfG+EI0oVY6Sk5GSpVn6urNB
 hopgpKUhXYsMkv+G9wzxw9vd/LugcLTqu2NxEYaJGDxZUqGJjOJia1WMiHDih6c=
X-Google-Smtp-Source: AGHT+IH2rDc3YgY30ffUov9J2rcLzG333Y6x/mq7BzZ40lFfXo/a+HwYk+K6wda8MTcdzp3r4dC6ag==
X-Received: by 2002:a17:90b:5292:b0:2e2:bdaa:baad with SMTP id
 98e67ed59e1d1-2ea14e1c2d6mr867046a91.7.1731617386107; 
 Thu, 14 Nov 2024 12:49:46 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f4b191sm1595087a91.27.2024.11.14.12.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 12:49:45 -0800 (PST)
Message-ID: <6dfe7a0c-af7f-4de6-a8e5-a6b9a0d8edc7@linaro.org>
Date: Thu, 14 Nov 2024 12:49:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] exec: Move 'ram_addr.h' header under sysemu/
 namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> "ram_addr.h" contains declarations specific to system emulation,
> move it under the sysemu/ directory to clarify the API namespace.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                         | 2 +-
>   include/exec/cpu-common.h           | 2 +-
>   include/exec/memory.h               | 2 +-
>   include/exec/translation-block.h    | 2 +-
>   include/sysemu/physmem-target.h     | 2 +-
>   include/{exec => sysemu}/ram_addr.h | 0
>   accel/kvm/kvm-all.c                 | 2 +-
>   accel/tcg/cputlb.c                  | 2 +-
>   accel/tcg/translate-all.c           | 2 +-
>   hw/ppc/spapr.c                      | 2 +-
>   hw/ppc/spapr_caps.c                 | 2 +-
>   hw/ppc/spapr_pci.c                  | 2 +-
>   hw/remote/memory.c                  | 2 +-
>   hw/remote/proxy-memory-listener.c   | 2 +-
>   hw/s390x/s390-stattrib-kvm.c        | 2 +-
>   hw/s390x/s390-stattrib.c            | 2 +-
>   hw/s390x/s390-virtio-ccw.c          | 2 +-
>   hw/vfio/common.c                    | 2 +-
>   hw/vfio/container.c                 | 2 +-
>   hw/vfio/iommufd.c                   | 2 +-
>   hw/vfio/migration.c                 | 2 +-
>   hw/vfio/spapr.c                     | 2 +-
>   hw/virtio/virtio-mem.c              | 2 +-
>   migration/ram.c                     | 2 +-
>   plugins/api.c                       | 2 +-
>   system/memory.c                     | 2 +-
>   system/physmem.c                    | 2 +-
>   target/arm/tcg/mte_helper.c         | 2 +-
>   target/ppc/kvm.c                    | 2 +-
>   target/s390x/kvm/kvm.c              | 2 +-
>   30 files changed, 29 insertions(+), 29 deletions(-)
>   rename include/{exec => sysemu}/ram_addr.h (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

