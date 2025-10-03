Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFFCCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 08:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4ary-00057q-Ga; Fri, 03 Oct 2025 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4arx-00057h-8H
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v4arn-00070M-DQ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 04:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759479009;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWW4Q5c07mNKuoKMyN3hVC5KFm+OYMWzCNhbYqx+Gsw=;
 b=ZOUVRM/kNR3NW6K5kwn6z1Qa+Tu5FnyMsiXpiqRcwW2+m8izWZZHUwYDk0Vk/42Ufxi3LX
 kMjDJ4dDspQ8+rDb6qXrZg9uYu6PMCWvy2XtaywTncFyftaP9P1f/4EftILHIj3OQjfJsA
 2xDbRiGmQdKI845lWqQesJ29Hs6MFHw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-2fSx2E6ZOxCdcijgFBGHgw-1; Fri, 03 Oct 2025 04:10:08 -0400
X-MC-Unique: 2fSx2E6ZOxCdcijgFBGHgw-1
X-Mimecast-MFC-AGG-ID: 2fSx2E6ZOxCdcijgFBGHgw_1759479007
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42421b15185so2078643f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 01:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759479007; x=1760083807;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWW4Q5c07mNKuoKMyN3hVC5KFm+OYMWzCNhbYqx+Gsw=;
 b=vf53E30MOX0yHog6kEI1lNaEufM1MGi6jmiK7LfplxmKdv/6h6U7gyLPvb8PijSx4+
 VfWdlDrxMVKDxmVjLo6Jr3++azMrXijJAk3Fex3XvcDw7qfYwAuWyzzgIXo3C9Mb7+xW
 qR+yTVqFuDUSS/NMAqxZudJRAF+NQ3qvcxOImK/zvf65kMQe8xYmn3H3cgP1u4n00E2e
 V2erKu5BO3briQRUxuMX91tWJixLdiCi4nw8SA/UjDeJlDDflZpIH0nw7upvx+J38Ion
 W5PjBwdlOnmIyeO0rkVKbTlxhLz8YrBhULLtfKGcZIwLAuGbxjevu43iVToUu40z+FU+
 GSuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5gPRsM6zs3m/3mX0sToSoAGZzBVShPnmvJ67W9+BFmQVFYI/hM3CuXYZkjVk6G5ZWHeA0tzAwcFqm@nongnu.org
X-Gm-Message-State: AOJu0Yx089XSRoOozgZmW3E9swexZ8siIdjwvxC75L+JPpRo6U75xwzl
 r6uJFl/3Fdz1600lIgV+VhfxBdhjRmOkTKYB84svqnlaSCE25kzrzVIoN+khixQkxLexKToPiHl
 lhRO32k+ofbCNyjWJTa0xZYITjgZjqRKIxJYn3Gvds1YNT6hPq+Ch3RiR
X-Gm-Gg: ASbGncumNMp6BgLupfPcVurTRpyTcfQP0ZBi5T6boZNqjqSN25iIEzzSc15cHWz2cz0
 97WOM5OajcnCwhnU95nRF6kUDjhizL5vWHVyeQyY9iYhqwedGgQ14Ix7H802FQCdkvZxAZ3hsAC
 5+oVMJYeNs0p2f7+uWtBBIVCcFlMkR4Dsop3FV9NdstH7ChVwCcM1b48OHVjtHQDKxWq8aYC25z
 El8hXXyL1IQEVsEddN18r4YfStxPyWoCbTSarhvGCgcOYuO1CqQFqDQEidUrrvkmzCkfLVyfA6b
 zhGK03nKE5muexigH9h28qGGs0Nr70QHDuaiwjT/Wp7IlYDBO6Ky2g/dupnW6lsTc1qcA8hQ9W8
 fUg9AfOnd8jtRDcHK
X-Received: by 2002:a05:6000:184b:b0:3f3:3c88:505e with SMTP id
 ffacd0b85a97d-425671a7ccemr1258633f8f.29.1759479006965; 
 Fri, 03 Oct 2025 01:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3srH1bmWoa6laPcEdNKvi7Z2cyApOiyDKIp8Lrni6yoNvbB9NcYP9VHF5aYS7CdxIc/KCKw==
X-Received: by 2002:a05:6000:184b:b0:3f3:3c88:505e with SMTP id
 ffacd0b85a97d-425671a7ccemr1258608f8f.29.1759479006552; 
 Fri, 03 Oct 2025 01:10:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm113965265e9.7.2025.10.03.01.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 01:10:05 -0700 (PDT)
Message-ID: <8aa994f6-ed65-4572-8d71-b4681585d1b8@redhat.com>
Date: Fri, 3 Oct 2025 10:10:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Mitigation of migration failures accross different host
 kernels
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com
References: <20250911134324.3702720-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250911134324.3702720-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 9/11/25 3:40 PM, Eric Auger wrote:
> When migrating ARM guests accross same machines with different host
> kernels we are likely to encounter failures such as:
>
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This is due to the fact KVM exposes a different number of registers
> to qemu on source and destination. When trying to migrate a bigger
> register set to a smaller one, qemu cannot save the CPU state.
>
> For example, recently we faced such kind of situations with:
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>   register from v6.16 onwards. Causes backward migration failure.
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1,  PIR_EL1
>   from v6.13 onwards. Causes forward migration failure.
>
> More details can be found in individual patches.
>
> This situation is really problematic for distributions which want to
> guarantee forward and backward migration of a given machine type
> between different releases.
>
> This small series tries to address that issue by introducing CPU
> array properties that list the registers to ignore or to fake according
> to the situation. An example is given to illustrate how those props
> could be used to apply compats for machine types supposed to "see" the
> same register set accross various host kernels.
>
> Obviously this is a last resort situation and this situation should be
> avoided as much as possible.

Gentle ping. Any other comments/advices on how to mitigate those kinds
of issue?
I think I will split the series because although it tries to address the
same

"failed to load cpu:cpreg_vmstate_array_len" class of error, hiding or faking KVM registers induce different side effects and risks and it may be better to handle them separately.

I forgot to mention that when registers disappear without notice/KVM knob, one could argue that the easiest way is to backport the fix in older kernels but there will always be a point when a VM running on a non fixed host kernel won't be live migratable to a kernel where the fix was backported, which kills the point of doing live migration I think.

Best Regards

Eric 

>
> Eric Auger (3):
>   target/arm/cpu: Add new CPU property for KVM regs to hide
>   target/arm/kvm: Add new CPU property for KVM regs to enforce
>   hw/arm/virt: [DO NOT UPSTREAM] Enforce compatibility with older
>     kernels
>
>  target/arm/cpu.h        | 15 +++++++
>  hw/arm/virt.c           | 19 ++++++++
>  target/arm/kvm.c        | 99 +++++++++++++++++++++++++++++++++++++++--
>  target/arm/trace-events |  6 +++
>  4 files changed, 135 insertions(+), 4 deletions(-)
>


