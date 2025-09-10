Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2584CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 07:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwF2j-0002Ml-AD; Wed, 10 Sep 2025 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwF2X-0002Kk-CF
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:14:51 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwF28-00069M-1P
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 03:14:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0785be64f5so61316166b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757488460; x=1758093260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmtBc0GszxYjVvZCnS41uOjmBQHAJF3IaA04S6IeCEA=;
 b=FAXmGwHDPH8DRAx48YhPQbcm66VRJZ35TMfZLY9bYN3xIy2vDMRqGS3QFM4a1joan0
 stvaJEAbX9dlGlnbVn4pMG5hj9uQ8AUWpkM1phNlqwzvQ3Ez1LTIIqDTPiRIIJq254oz
 TfP6E61EOh4GBMhkklTIncyde1rMMSVVCH9ip5U1/ehzSJ+WWIGQtuUNS97adQ01/NLl
 xmeYIwh16Vhm6b1H0VsUFBFk87ULgbLveWr64hQcy8NqVreiZrfwPWZH/hc/nKDFzlSt
 KOgLlk8PCMYewR3BCUW9UHeNe0nP5CFM1B2gbsT+s6h+I+SRTFmiNAz/rbQh5odegYod
 TwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757488460; x=1758093260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AmtBc0GszxYjVvZCnS41uOjmBQHAJF3IaA04S6IeCEA=;
 b=C8X94eJ/ArHB4iq3tPvhuLQstoRMGlv70MWIfBUQ7uftcmUqqtEdzsskW/XHB5aoDD
 A4RFwfI3SZrppCEQrA/qbhzOcctyFbIEphaQu4NE1iT8QRDQCoC2sacdZncHfWnrdEMp
 eUuGeV78cXnalirlzg7Yh8LGZMg3KPU9GxOnJdsjL9LqLuyZ13s4fCSYdUTPdxxnXiyF
 hqW4Dql+AIt3NrWit5NepFXcuo9SQL6aqoxAXsMDA1jhaJgrzkD2v+j7IqVh41tGT/Zh
 2gYhTG0g62Nhbp3ggd66j3M3X/7R25q6n3fQUw7+k/7pBYdegDSrK2+pYvrMuojzYhHG
 CjCQ==
X-Gm-Message-State: AOJu0YwmNVERMo+C1LNCtgTES8oFqVhKMSXZ0e+/b64MNBxUmxNebf/3
 4FXke53E7rHKwcYIrY4GqrDBUT7fCBrZpeR61+Zi8f4+r6tnuaQJ3lBiiKSJ3p5T6Ml2ZD7htQe
 8lMplrGY=
X-Gm-Gg: ASbGnctjjnDYceYjRiqRgvvoE1pJfq2HXn/VtEyJiYBVFkS6Y8QNI2vv8MV6VcFhmSg
 kJWKgsskFZ3jbtVZJyTHiGIZpW3q+PsUib7AJCY8OOMbB5s5V7xjOc4SnjwN48c7t3xCwLf0Tlz
 bWmCfNaxFPN0T7nD4hyquODJasfuJV4B9vtSXLy2wkrauvna5vKbDHdHIv6CVWYOGYtgwDT03it
 6ODUo/gq95oziXtzAIQxBX547P0WO2VnDWHrL7W+O/6yCC3zmQ2ILzSgPYGnRXZkNcgEHP4lpG9
 Z/vm864TM4Sfd03IpkcSvJ7tRYPDEZre8MgeH1MRoJ+0M+wFzG0+/UlGo7eRojjEVj47ZBaoXrl
 43PyxOZoXkoj/nBT8z/gbJAqRRrk8xgD+LMBbmAJcL2kBS7+F8dlJEkW/cnWNOgY92FFI+Xt45I
 EtaG9Yk/Ck3TeXWodR
X-Google-Smtp-Source: AGHT+IFLFuA5Phm2QML2lmSmDtJsXIPDWQ+VsXxIhbvRC4nbifGGn+n6W815XmL+dwVcEmbbuQ7T3g==
X-Received: by 2002:a17:907:3e09:b0:afe:6648:a243 with SMTP id
 a640c23a62f3a-b049307ef09mr2089030466b.3.1757488460404; 
 Wed, 10 Sep 2025 00:14:20 -0700 (PDT)
Received: from ?IPV6:2a01:6f02:11a:55d1:9b51:8c04:222d:31e6?
 ([2a01:6f02:11a:55d1:9b51:8c04:222d:31e6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b078334b0afsm118233366b.51.2025.09.10.00.14.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 00:14:20 -0700 (PDT)
Message-ID: <18b069f2-6a78-451a-8c80-7d6379019a28@linaro.org>
Date: Wed, 10 Sep 2025 07:14:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] treewide: rename
 qemu_wait_io_event/qemu_wait_io_event_common
To: qemu-devel@nongnu.org
References: <20250908101241.2110068-1-pbonzini@redhat.com>
 <20250908101241.2110068-16-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250908101241.2110068-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Do so before extending it to the user-mode emulators, where there is no
> such thing as an "I/O thread".
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/hw/core/cpu.h             | 2 +-
>   include/system/cpus.h             | 4 ++--
>   accel/dummy-cpus.c                | 2 +-
>   accel/hvf/hvf-accel-ops.c         | 2 +-
>   accel/kvm/kvm-accel-ops.c         | 2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
>   accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
>   cpu-common.c                      | 2 +-
>   system/cpus.c                     | 6 +++---
>   target/i386/nvmm/nvmm-accel-ops.c | 2 +-
>   target/i386/whpx/whpx-accel-ops.c | 2 +-
>   11 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

