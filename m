Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A2CCD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMokd-0003Z5-Nj; Tue, 12 May 2026 11:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMokc-0003Ya-3d
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:10:26 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMoka-000510-GA
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:10:25 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43587e63a8eso1850095fac.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778598619; x=1779203419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O0PvP72O9s8pCVRs3S4paO2OKuC+D/Ed4MKom9Qvn90=;
 b=avRWuJjkJbj3VKR3hYfUS/PTUlXU4V/WIHIDYyjAFvRiSI9N6vVIBJklaEOjFZKQWy
 6Ti9BoX1a94KZaRvbcdwGyADDLy6mqT5Z94KijuMV1ThObyERviH5POnIwKRFQme+s6v
 CiL8Eocsw/PMiEz7XIWB/MypiOV097qoovCBw1CqgBWLrkLBq8CNUVOfFqN4DiCl6YWj
 9QTedk9OeUs3CG1xAM6+gBRklQImMFB/4JQM7gSgYYpXUu3jVLK6GKYlp6gzfsHk1Lx6
 mVuvmGFQF/LCJL/7qqisAgv8ob/okHokVz+3INsM53HHQjmv30mexVOm7+7Auxuvu84E
 FJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598619; x=1779203419;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O0PvP72O9s8pCVRs3S4paO2OKuC+D/Ed4MKom9Qvn90=;
 b=b+3L04LujkpT7VJH2QWj5YvEcEl8Z+6OSXBogzVEmrH06ulcmekOmIAY0DfsugkLtB
 CdeBr1JE/oaLJoHvIEYHnsPgSZzFCzhytv9TACcrJ1qdd3F/hlIm9nZSJb8CGTT5C0cI
 CboSD5lafPfSz4Dv5nC4StafWjgCIlv7aC+Y0WN/aaTOcbQrLC26qmiNIO62X+hKJT3D
 3mvBmhI084Sb59fz1H+RS1tInz67M6PNXn4f9GbJus9ZBjfMzQ/AThW4+0k1MJY4+iUA
 CEe0EdulV6Un7ne0uYORAXOFksBfiIMzEjgzcf2/YYLFvu3f4tit+iWvKgxVCL/drfHG
 l1eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rUQNQEd1pvvSkykqzuxwCCli6lPdxuxdV7gm3mydH0/HczgiwuUlDyTCsUjF2tlFeZectMGhLD6bS@nongnu.org
X-Gm-Message-State: AOJu0YzxRpunxuHGUPYFVsZX7o4MdrEl4soNDl/cRACWCWed9Pb482iU
 1lmv4vZauztTMGxT5/mhPv1hey2qct7+JhvUprsFUGkfWy1kSHzDDWHaM6zff+AKTGU=
X-Gm-Gg: Acq92OHT5l/H2PlvAetBNKKm7Z+3gJZjlbwbSv9K42HZhXsZswQ+WISvrIt3oY6bpg/
 9tvNgvU39ijpymamRf4cW9ZHhg6dqcJRKm65ONpRK3PYSj/ceTPwzfuTXP3MUREU8K8sdZaKVUX
 ePylAihU+BROtN9O0JcdP14DXRTaEB4NIJ+69vukl7fThnkFjK5ABuNB7ypQGSpkz/bFyxEyHil
 0RBTaI11Yg93goR2JnX4S1SJYpCKu7c6B94TznpIBOcTglPYB7NeID0ADz38TDTqgkaI94gIPqP
 0NgKhvurXYawAWaVOWTi/dVNSiboV+zcx6GNDOnfewMxeHh88tqi8KpgvpdULN6P/m8UDOvev33
 uBxrYXzCIAllP1EpHA9nmFP4/MlTERwdYitGH27cnkuBTM+YPOoHGRhfEEXLA10R5NqDr6Ccaxg
 VLflgPVAXVL3wnnqi412mP14DikH90UAJvJb0qNQzXP2KgnqIc6XPewNSIeohXJUNAyd+C8vs9t
 LL+xRQ1eg==
X-Received: by 2002:a05:6870:b007:b0:40a:5a07:3598 with SMTP id
 586e51a60fabf-434f737e4eamr18340594fac.36.1778598618628; 
 Tue, 12 May 2026 08:10:18 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:63de:4fd4:c660:2749?
 ([2600:381:c938:6375:63de:4fd4:c660:2749])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ad92dsm12926809fac.2.2026.05.12.08.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:10:17 -0700 (PDT)
Message-ID: <e8a35a2a-3235-453e-993f-f317505ec6e8@linaro.org>
Date: Tue, 12 May 2026 10:10:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] target-info: introduce TargetInfo in QOM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
 <20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 5/12/26 10:02, Pierrick Bouvier wrote:
> For the single-binary, we want to be able to retrieve at runtime the
> current target among the different ones available.
> A consequence is that we can't rely on existing target_info() definition
> since it will create a conflict once more than one target is available.
> 
> To solve this, we add TargetInfo in QOM, with this hierarchy.
> We define one class "target-info-X" per target, that inherits from
> abstract class "target-info". Using concrete vs abstract class ensure we
> can easily filter "target-info-X" from all QOM types.
> Associated TargetInfo is directly set through class initialization,
> without relying on any instance.
> 
> For user mode, we simply define target_info() like it was done
> previously. In this patch, we keep the same definition for system-mode
> also, and it will be replaced in next commits.
> 
> We will introduce detection of target from QOM, so we need to make sure
> those types are registered early.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   configs/targets/aarch64-softmmu.c |  6 ++--
>   configs/targets/arm-softmmu.c     |  6 ++--
>   include/qemu/module.h             |  1 +
>   include/qemu/target-info-init.h   | 58 +++++++++++++++++++++++++++++++
>   include/qemu/target-info-qom.h    | 28 +++++++++++++++
>   system/vl.c                       |  2 ++
>   target-info-qom.c                 | 24 +++++++++++++
>   target-info-stub.c                |  6 ++--
>   8 files changed, 119 insertions(+), 12 deletions(-)
>   create mode 100644 include/qemu/target-info-init.h
>   create mode 100644 include/qemu/target-info-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

