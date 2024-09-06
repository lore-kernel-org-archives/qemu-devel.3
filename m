Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C57E6FE2B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smawi-0003Lw-Tg; Fri, 06 Sep 2024 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smawg-00034r-Lo
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:32:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smawe-0005xL-Or
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:32:22 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so2346698a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725636739; x=1726241539; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DPFFJQVcsuCwQ2p/MkF+/pRYxXZXIiAqrfK5ohsi/mg=;
 b=MOaLu8nBo7Xpaz5+xuBkJJcL7p8Dv8zXX7ygeZCG9VIGm+uKyGhJ7dzHgFoHppFDak
 pzlcpShUELo/5eoQk7fIpyBaAScwf4WdIMbD0MDLdZ0+Hdm2mJATfX71j6rASuYBjnm0
 pE2hRpIwo16P+0Glygr0EaG4CLbk0f13P+e+21Hpos+7gOm3koxyf9XRwo0O6gwmuAql
 ul7gpHkc4Y9CvFegX5Oj6MME2PqHRPA0ab2Hx3bB0DrddQnAXrUiwOKR9mYh5kMTbUWF
 5c0gl5NtYLOwl+alGDbpHk/GuMFmudSlG3AsYRdkxKf/fkatS74HNVOcKQwzrkPN/WIJ
 aVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636739; x=1726241539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DPFFJQVcsuCwQ2p/MkF+/pRYxXZXIiAqrfK5ohsi/mg=;
 b=t9nCW7PapkBLRbXMMlCjt8VIvXe17kFbHx8pq7V1/fPMWnm3gQi1JoM4cU9x8ROA40
 f3c8Vpq7AUspIPX959GKA+WnNyhBdBl3984k29Yy2LSMoTp4T7tdTwxVhDik8BlGLO5o
 4/JmIW5vDSg8KYZjaJsBpfjrlMtj3aM2A12wNcn/oNu6Ez2DcrhYHKvI+EC4Mvr37q3V
 fBEDRZnQ9J8PJDcypMSI9Q+a6MeiAsPP4lsIf2PSkyM++JkBZFs2xv3FGgVrWyxZfIir
 u2xULymNMgNj5p62I6SIFvoDZa9/NoCOJmIs3HuCnXV8vdTySqvgtbbbOetGbJor1uZN
 VD1Q==
X-Gm-Message-State: AOJu0Yw05wQd+SLRBTVaLIHBQjf1vL9OENwE4vVJrZHeIwOTuX7mteYl
 4P2CNpElsXzwk2akSlDXGeSm13NJu3ZckGVDD5n9Lwm/mGnkUx4Fot2Q3yUKK9Z8qSCpBJAji2Y
 uLr8W0G1yE9CG/ZC4fMOPV4VmndpIkQZJrSaG9Q==
X-Google-Smtp-Source: AGHT+IFcCXeCqMfeaxAAcErB6/KrMls9HrBBJTw8oN4DnUohf/vk1F0RkPt7/H4jV3F2GOneCRFKg1RowPRWt363mDU=
X-Received: by 2002:a05:6402:84e:b0:5c3:d9ce:4199 with SMTP id
 4fb4d7f45d1cf-5c3dc7c4625mr1958164a12.29.1725636738947; Fri, 06 Sep 2024
 08:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240828111552.93482-1-danny_canter@apple.com>
In-Reply-To: <20240828111552.93482-1-danny_canter@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:32:08 +0100
Message-ID: <CAFEAcA-Hocqio2DwQoVak+ihGRDx=SQed3nomPiGRAx67BA7Zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hvf: arm: Support creating VMs with 64+GB of RAM
 on macOS 15+
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dirty@apple.com, 
 rbolshakov@ddn.com, agraf@csgraf.de, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 28 Aug 2024 at 12:16, Danny Canter <danny_canter@apple.com> wrote:
>
> This patchsets focus is on lighting up the ability to create VMs with 64+GB
> of RAM through using some new APIs introduced in macOS 13. Due to the IPA sizes
> supported in macOS, the first version we can properly support this requirement
> is macOS 15 as (if the hardware supports it also) the kernel adds support for a
> 40b IPA size, which is the first supported ARM PARange value after 36b, so we
> can advertise this to the guest properly as well in id_aa64mmfr0_el1.
>
> Today if you asked for a > 64GB VM you'd be met with a pretty unwieldy
> HV_BAD_ARGUMENT. On machines without 40b IPA support this patchset also
> improves this, and the message mirrors the kvm_type error you'd get on ARM:
>
> "qemu-system-aarch64: -accel hvf: Addressing limited to 36 bits, but memory
> exceeds it by 18253611008 bytes"
>
> Changes from V1 to V2 (Thanks Peter for review!):
>
> - Added a new function pointer to MachineClass to be able to freeze the memory
> map and compute the highest guest physical address. We use this to inform VM
> creation on what IPA size we should ask the kernel for. This is very similar to
> what ARM's kvm_type() does.
>
> - Fixed redundant loop in `round_down_to_parange_bit_size`
>
> - Move the splitting up of hv_vm_create logic per platform to a separate patch.
> This is mostly for readability.

I only had one minor comment on patch 1, so I've applied the
series to target-arm.next and made that tweak there.

thanks
-- PMM

