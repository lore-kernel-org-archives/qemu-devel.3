Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E8CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlcF-0002es-Rr; Tue, 28 Oct 2025 11:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlcD-0002eQ-F4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDlc4-0001xD-Pd
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761665271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGQw+A1JTXD93/cdpqTomTVVOnhkKl/PoqaDHAqcED8=;
 b=emJG0VJPNshqDOJZwGWCyYiEoKmR7BIKwS2MX7+za6F27787QbHzS4i5Wh9qP3a9zTf2IK
 kHJXkZxxjvYcfAJNStk5I8XTfkoFGlbGdSB8AI9vCU2cnvaL2xsOV8UFZxJATl4uX1OEjf
 EqYcCH0xva8CgWrFfiEHvVzoeKj1O9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-LXg8cA2DNUODCdZGoAxA5w-1; Tue, 28 Oct 2025 11:27:48 -0400
X-MC-Unique: LXg8cA2DNUODCdZGoAxA5w-1
X-Mimecast-MFC-AGG-ID: LXg8cA2DNUODCdZGoAxA5w_1761665267
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4770c37331fso16871855e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665267; x=1762270067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qGQw+A1JTXD93/cdpqTomTVVOnhkKl/PoqaDHAqcED8=;
 b=E7Eo4TPx2/WDWwaQGO1q8Ez+M1s+fDgsl2lCS2pmeZtZFzgoiOx+0A5nfzezPyXovO
 zT1nN4u11JZGqFvTAyQKA9FiPXF6rg40JpjXZTk5j3MzegO3Ht+qZjDr1S5MvJjNGRbB
 TLqOcrxJ8OvJBv+5S8h2MuXXtktro7/BKb91mr2hlcM2TjdJdG86ZBShs8eeE1QfPR0Q
 GF4PQQowbodAx/IKptDCRn6tt+SC0AM7SBNwvLDF/16cSzAMfBVhdtkziQ48miQiY/Oz
 0yj9F6VL44Uy3eAPTDU+DDta7KPEifvGhLotgAURkeBGU7e/8owCUB1nMLtZzu07to8X
 sJGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtvQDDl79gzALNQR3FSwM8CqSk/geLwXb+WEVEvB7IGqqL5OibEgSpWV+zeJDk5NGNSTF6JERSWIXe@nongnu.org
X-Gm-Message-State: AOJu0YybMMx3DfvPxqjtEfxcFepzwvlD9Jtypgj3MC+tPIA+FXYhm1bC
 NUHVv8/d2igz7PUUCzLm67VpTvbHERHgQ4BfPa954lHAzdeKm5c6CMcShAJBCB/G2yiIdrWRXeX
 YYV/Vqeyna+2eJ/wOKH/zPY/jkNjaZLlnYnSckst5xRww4vXWvrCBtUdv
X-Gm-Gg: ASbGncur0DXWHrI8HDxkwJ4SFFVnDpvss0Fn1120avUXdn2YoqpgFKntRwmLPumiQC5
 VUNBa922EMSqaVGpEPXiwqRznvaGpHWa1SmXUPvtS7vWGPnqtbsDthbL6B8lfpnS7l3Q0RdJJkT
 HyHFGNs2KJEFCUcJeAK+8wWAEcSe0TdTlqvYh3e0UM5eO533dNvPqzA3ooFj/nEsacLsiMjbTtf
 r4G/rTjgpRpwerUhXnmFBrLjpI4s13AXUk2ecFA20/8cVJFA5Eie20ogwtiGarhDxlKcYkJWlnP
 FxP+l3OHWUdwbpxzVSoX37T0JbZYcJDx1rqdcGwKMJaRS01jEcrAUor6s5d7txKEjQRKX6rcwCi
 jHWvn04yjQbVz0NsUToMblALiUk5+GfMEVnoGJNT2/Gzz8g==
X-Received: by 2002:a05:600c:4ecc:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47717e6ac1cmr41288675e9.34.1761665266936; 
 Tue, 28 Oct 2025 08:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Ld/qnc3/wN7I7cp03I6mkRUBEYJkmR3ltKfQUIKHVSTG0Woa3rNFDtS3ChQJFP9aB4QB3w==
X-Received: by 2002:a05:600c:4ecc:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47717e6ac1cmr41288415e9.34.1761665266509; 
 Tue, 28 Oct 2025 08:27:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd478202sm200259115e9.14.2025.10.28.08.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 08:27:45 -0700 (PDT)
Message-ID: <84affea6-414b-44c0-bc80-738e8348a333@redhat.com>
Date: Tue, 28 Oct 2025 16:27:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/7] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <3c963761-8587-4905-8c8b-60dda381262f@redhat.com>
 <CAFEAcA9LfL8cYka8Dr2t6oS4av+4+Gvso4ywoMb8ERcXVJETHQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9LfL8cYka8Dr2t6oS4av+4+Gvso4ywoMb8ERcXVJETHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Peter,

On 10/28/25 11:47 AM, Peter Maydell wrote:
> On Tue, 28 Oct 2025 at 10:05, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>
>> On 10/16/25 3:59 PM, Eric Auger wrote:
>>> When migrating ARM guests accross same machines with different host
>>> kernels we are likely to encounter failures such as:
>>>
>>> "failed to load cpu:cpreg_vmstate_array_len"
>>>
>>> This is due to the fact KVM exposes a different number of registers
>>> to qemu on source and destination. When trying to migrate a bigger
>>> register set to a smaller one, qemu cannot save the CPU state.
>>>
>>> For example, recently we faced such kind of situations with:
>>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>>   register from v6.16 onwards. Causes backward migration failure.
>>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>>   from v6.13 onwards. Causes forward migration failure.
>> Gentle ping.
>>
>> Any comments on the approach?
> A couple of general remarks:
>
> (1) This isn't KVM specific -- see e.g. commit 4f2b82f60
> where we had to add back a fake cpreg to un-break forward
> migration of TCG CPUs. So our handling of this kind of problem
> shouldn't be restricted to only working with KVM.

interesting. I will see how this can be extended to TCG
>
> (2) essentially we're re-inventing the migration compat
> support that VMStateDescriptions provide. That's kind of
> unavoidable because of the way I implemented cpreg migration
> years ago, but is there anything we can learn in terms of
> (a) required feature set and (b) trying to keep parallels
> between the two for the way things work ?

OK I will study that further.

Thank you for your suggestions!

Eric
>
> thanks
> -- PMM
>


