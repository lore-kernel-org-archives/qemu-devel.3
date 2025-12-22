Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717B1E674B0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXfnG-0000WP-3t; Mon, 22 Dec 2025 08:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vXfn1-0000VW-Iy
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vXfmw-00052t-5c
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 08:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766409443;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbzYKL4kid0fl45TgaQIDaXjJo0xpcY+XP1aQXK+w/I=;
 b=hNZ11ENJ5sWg1UzBoz9+R/kgYmv9Nv2RW1SDz+OozE/Ss+eM8dycMciQW2Uos4sywT/JU3
 U23B60/DTk7kkbcLBD8Gq4P0IgAlmiCGERVrCVvdFDmkzZm1IbptjWSpnaqv/SF8E662U9
 dQcUaDEbTp4qeHT2D22bLftY1XEPBdU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-KiWWj-dwOCqOGD8-SK0Pdg-1; Mon, 22 Dec 2025 08:17:22 -0500
X-MC-Unique: KiWWj-dwOCqOGD8-SK0Pdg-1
X-Mimecast-MFC-AGG-ID: KiWWj-dwOCqOGD8-SK0Pdg_1766409441
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso847679f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 05:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766409441; x=1767014241;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbzYKL4kid0fl45TgaQIDaXjJo0xpcY+XP1aQXK+w/I=;
 b=CR3sAGSKUAKEZIplcP3fuHVxlvYKZTc3uXxJ36h9JZ+gaQP9DNCA0JghLRwYN+gb3g
 c86MSZR2FrUU79hkr529JKNm4kwx+mvk671kSpyAv1rRjpQ/e6hfeJT15RQTZj+lYlfJ
 T+1Rk2ErDQ2im90RCv7lNY5btKMVO91TqX0JsuU+BavbQBUK6z7y4aT8IJMa9uVCYvtM
 atqjzMdv7zugZQNyhSdzgTxDKIjsmB3tHkEVt3xqFRsZR5a+d94DTpxOx3f/28XpbXbH
 4YhXYImmyJjlF9rYMj3b/sZEqt+sJl5zxfqlOq0vqC5jym3KJjTty299oDUKgzcNU+z6
 hUAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk/P1XPeMcGU1et5b1eDcempEgBq59BdoqIQXYE6m9cc/HKbUiwcP24P3ZXkK3aAL3Q2aY/4XihYgw@nongnu.org
X-Gm-Message-State: AOJu0YxtQe//2cTi0FpT0ghiTfq5G2FCVjzjYzXmBTTuMHOe3CgMzseW
 LBD8cfabog20dxxZa12Stg+i4l0tIB4+xvsjZG2lvLLIvPlFNRiiIemjVf2SlqD6aIqigA7qML7
 eGVXRxQiCjSI0ujx9tRs/b4Q+FUaD/BinBS5PSml3n+XZBHgRs3Wolw9T
X-Gm-Gg: AY/fxX4rlJywHIWgstjkJRFmrG65v3iQMV9M5nYwJ0V3FlNzOPmf5M3AY83ELHOJY/U
 aLqtMDk+llWjN6oiF+YzHSc0in649TgCfwH4GxLmoNeqkiBxxy+ORKWo2JGN/PAM8LWuttDGnBl
 IrV16cBT9bC2KWbYJ2iS8gAlyj1uO+5RWAlIHGQJhoTbnsZhkuMZ0YP3PR/GtzBAnWbA4baV++X
 AnfPMB2RiVX3D44PKQVoSP6QqR+gpOGVFfsKCydG6QaUwm3L7HDiOksRO+got8YGNtK2m2nwjjG
 EoP0ogsniM7gnIVwtAgBqhYQwWoNltWhCsWkub8He0LYwoIWuIdus2EaBOBAYnQ5Coyjaf8T6fm
 e2aoqAdj/VC61bOmg/kITQ1uKe3N83qSiWIuklSKB2DZ8/DEHzehgByYFgA==
X-Received: by 2002:a05:6000:25c1:b0:430:c76b:fadd with SMTP id
 ffacd0b85a97d-4324e4d3f7dmr11825061f8f.28.1766409440984; 
 Mon, 22 Dec 2025 05:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPJjAh0lWUYPqsFueQKbsmYXj2ojv/iXGbb0RKNaQUZcrRVENH0icM2yFnO4llfDZa37/BQQ==
X-Received: by 2002:a05:6000:25c1:b0:430:c76b:fadd with SMTP id
 ffacd0b85a97d-4324e4d3f7dmr11825030f8f.28.1766409440534; 
 Mon, 22 Dec 2025 05:17:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm22277090f8f.29.2025.12.22.05.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 05:17:20 -0800 (PST)
Message-ID: <6bbc1612-389c-4fa1-9fbf-354209fb6b1c@redhat.com>
Date: Mon, 22 Dec 2025 14:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] target/arm/cpu: Allow registers to be hidden
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-4-eric.auger@redhat.com> <87ms4aoxg9.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87ms4aoxg9.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/25/25 6:04 PM, Cornelia Huck wrote:
> On Tue, Nov 25 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> More recent kernels sometimes expose new registers in an
>> unconditionnal manner. This situation breaks backward migration
>> as qemu notices there are more registers in the input stream
>> than supported on the destination host. This leads to a
>> "failed to load cpu:cpreg_vmstate_array_len" error.
>>
>> A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
>> Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
>> migration from a host kernel that features the commit to a destination
>> host that doesn't, fail with above error.
>>
>> Currently QEMU is not using that feature so ignoring this latter
>> is not a problem. An easy way to fix the migration issue is to teach
>> qemu we don't care about that register and we can simply ignore it
>> when syncing its state during migration.
>>
>> This patch introduces an array of such hidden registers. Soon it will
>> be settable through an array property.
>>
>> If hidden, the register is moved out of the array of cpreg which is
>> built in kvm_arm_init_cpreg_list(). That way their state won't be
>> synced.
> I'm wondering whether the patch description should also mention non-KVM
> cases (e.g. the bogus reg that was exposed). It might also make sense to
> merge patch 5 here?

Actually the AArch32 DBGDTRTX is not "hidden" on destination but rather
marked as safe to ignore in the incoming stream (so the other category).
So I don't have any example of TCG usage for this category.

wrt potiential merge I agree they could. 2nd patch is an enforcement of
non access so I prefer to keep them separate but will put them
contiguously in the series. 

Eric 
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Otherwise, LGTM.
>


