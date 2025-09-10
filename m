Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF81CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 07:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwF1e-0001we-JF; Wed, 10 Sep 2025 03:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwF1c-0001wM-7l
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:13:52 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwF1Z-00064J-LJ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:13:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b042cc39551so1152301066b.0
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757488423; x=1758093223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/cbovFAN3C6XxalQNrKwP30Gp5wR3K0LDp6s3qY3QA=;
 b=F4L92wrRjNkK7x3uZnk8AN3hMkRlXbR+Mbhjr7zW8zZ7zfwnmntJkBA+UfssMPoVtL
 a63QeT6UBD25oJv2RIRPrzi/LFrxtjiafIrGRh9W630TpB+i7Xi2l5IST/FG/mWuTQfL
 /XjCaGu/03PmHo9d3GZ4DV3k/YxY7caALIbu8mMayGsATf1ZcRUCCAUacvfSaxRi/gb5
 /CY+WWtyobv0d2iuWiLNQDwpS8agQkwWsE54rdrFdlXNMZ6TJJtR+q6BTgwiffgkv3i6
 V4sl3vwp/apgXqsNTAoMdVGpAbkT1EGNdQIYsZneTUvEHhzdnGVRGOZ47D4my/Y5x9Zm
 EzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757488423; x=1758093223;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d/cbovFAN3C6XxalQNrKwP30Gp5wR3K0LDp6s3qY3QA=;
 b=V0Q3KVgxg+E+L75q8UlxaoZ70R30cS1c+7enC2vx9m4nDi4CzTANZmdaczXeu7d4ci
 Z/fLxirQa9+N7IeuZAdA8RlMY+O2Qf7K3otC8E7JYN8/XsjdH41Y+sNR8ABvMP66kF3d
 JQyMMiibndrXlplYSWK++NSkNgRPz7CAWqiw5ypaXcIYb7lz7lnaZ+eMv/NO8Czl46Co
 It9XIwpRZ8iIBu5BX/wLNLqTBvlMOfetTEKukbTn800ruSed8UdyX6b38Y62IBPA+M8V
 IOHr+GVJwwFeN0jB/gPeHpOq4rO0pwkcglCHdJDF9Sjn+jacqAA0zrei1lgeqWPneCsD
 45XA==
X-Gm-Message-State: AOJu0YxhpIkimyW9a2x8ExEm2F1AEiM6uPyGeBosrZP8LJGa5cp3hFfX
 kkjDZXEeQTdq3sQ6K5lPctU6Ykx/W3E+dMZAJDjDfjQbiQJLSqEjhfZfyGzp6mtcRAy6AYNmuNM
 BhikYiXw=
X-Gm-Gg: ASbGncvPgpT8clT3a9bxuofgIOz3vgJbz7PxH4unr3IKUWDi6Xa0gRfiKh6tOEm2D1N
 S/6NPDHKUWSU7sJvGoVyenBk0+cbnasECLxv9CCqMlCMQrsRzhMd4sh3vGYrM6CAerDHJpp8TyP
 HY/uXmN/8XX8HK06hmT4u6AdbmwH83QAmLQgrLL4GLxmceVvM3PV5YMKgzjJPFEtBsl119ikoBd
 iCT6ePxN3v9xGuB9T79QhDhn+viqBTc8L3o5RTtvPVj07vKSBgU6QRmz9WLQnvEXTsy/vMe4Ic9
 rL4wqjBwMQX/0QHNIYmjY2d02+3BZRPcePoZY8xzNOGGFXHp2QBS96QEVQV6B3BPVzMbto2QjFQ
 b5KDBfvJDKNXTjo8a/FYccYAQ1OehdTmLmF/fWLbLr31V0Ekbe6T5sNVi4RgINl+xYDWMLyc/9c
 ARuU9k+Q==
X-Google-Smtp-Source: AGHT+IEQeq9xPtHrpaw7j7tbI2LBfEyyKrs85MQ9dKF18QvrQ6n86ci8OBoH8CmI7jCuTqtAQKWmrw==
X-Received: by 2002:a17:906:fe49:b0:aff:321:c31d with SMTP id
 a640c23a62f3a-b04b13d0193mr1356807366b.7.1757488423570; 
 Wed, 10 Sep 2025 00:13:43 -0700 (PDT)
Received: from ?IPV6:2a01:6f02:11a:55d1:9b51:8c04:222d:31e6?
 ([2a01:6f02:11a:55d1:9b51:8c04:222d:31e6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07830ac12asm119714766b.38.2025.09.10.00.13.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 00:13:43 -0700 (PDT)
Message-ID: <813fe62c-229c-404a-ab0d-6c6c80247dd3@linaro.org>
Date: Wed, 10 Sep 2025 07:13:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] cpus: properly kick CPUs out of inner execution loop
To: qemu-devel@nongnu.org
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-15-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250908101241.2110068-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 9/8/25 10:12, Paolo Bonzini wrote:
> Now that cpu_exit() actually kicks all accelerators, use it whenever
> the message to another thread is processed in qemu_wait_io_event().
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   cpu-common.c                | 3 ++-
>   hw/ppc/ppc.c                | 2 ++
>   hw/ppc/spapr_hcall.c        | 7 +++----
>   hw/ppc/spapr_rtas.c         | 2 +-
>   replay/replay-events.c      | 3 ++-
>   system/cpu-timers.c         | 6 +++---
>   system/cpus.c               | 5 +++--
>   target/arm/tcg/mte_helper.c | 2 +-
>   target/i386/kvm/hyperv.c    | 1 -
>   9 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

