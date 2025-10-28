Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F575CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhY0-0001e9-EA; Tue, 28 Oct 2025 07:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDhXz-0001df-1o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDhXu-0008QO-SA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649640;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiZygqK3nrPdhOoVaeAx5pny0s8zlVN8FdyMOFmhpD8=;
 b=FL8lrZESGbp5BDi8yTUkc3zmfbvrD6/NMC4rDst8kssTJccszVfsHKMKvsOhUrGknuewFG
 FOXOD2eNCqKrJKvPZkDU1XRE8dg8wTiUCABXNefFMIvzbh8LmKslcKOdZFZlp4YlWsLcy+
 1Hal4rh38S5FjDxhOiP03TcvSbnqrp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Wf7YQsG-O9-0XmkuSSiGsg-1; Tue, 28 Oct 2025 07:07:18 -0400
X-MC-Unique: Wf7YQsG-O9-0XmkuSSiGsg-1
X-Mimecast-MFC-AGG-ID: Wf7YQsG-O9-0XmkuSSiGsg_1761649638
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dc22db7eso30701155e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649637; x=1762254437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiZygqK3nrPdhOoVaeAx5pny0s8zlVN8FdyMOFmhpD8=;
 b=BYK8iAVaUZ/kJjCHTAMhBqB3Olu/UNRKPzkXwINT+HLyGx/YSeLWF27S4EIfWluX4X
 XLiytNu0f/fp+/QkWbGLhYbSg+MbG7V7DrgxRNGl8YafyP9NYV4ijW3WOgeGUPQWVdWh
 xho92UcKa3EzULvOAgIcRKXI/E+rxZL7co/OOfsSpDubsqoCMvx7ZW8GXEQCRU7cBKZJ
 9zH4ioEocx4dhAxMHYxKhEl1qsMFjd89b1TbBr8G+3CPUBvGYi446My60NnOt0h0SZWN
 +i+PiOoyk7tYJEGoeUrWKRMGnGCtJPc4gJ9GsmNCNzCFpyW6hozfPMsPCRaV3umpJPBJ
 x6ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAKzyHhGYHyALDyduiRtpNUGe4ea24lf+pw2E85lBK0rSWKMuBgK5QwCfrToJx/dJxKyX8oxXOm3CX@nongnu.org
X-Gm-Message-State: AOJu0Yz4XoEIIbmIxr7nnZlU4Xex8uqq6CzVc1lgIxLPEezHRGmVqxBv
 fdrO2NjlqWnKBBrAS0LMKIRZWuGSlr7OSVXsQCIPLvJCxx7qb3MjcyEkz/aTrPzFXAyiT1H2/lv
 txyMlvbahYZ5sG4nFdbznna6jjGEcXIKs5/pa4aEF5eKCC27OrakOYLtIzhWV6em8
X-Gm-Gg: ASbGncvHRzkbmqt3LPX6wdZeHclBFeOUL+gXxoETTUDUKxurKEvjXe+8roiG2e1yso+
 V4NBRY1VVmUNwN7Y+3kqybCpDsO9d8Giru3C5eGO2XVuy8tEWVGgzcxciQ/sYxP4b6eljfW/CH/
 WP+iVawygmQxbqRc/ZTp1YW816De1NCBWyQhr/mjinbaitXmMCmo/iYNMKzRIRRpyi3FTRc5UnL
 5RpZZof2FlMT6XrdyKdpcYpo+Pm1RlTJ3HbaYPreAbFuEqQF4g/tiBDSZY79ETORdMOx7rYZUrm
 gRmiaZbJ7ksYKqfet5xZuxOgwf+0YrGCYl008w1hGExxYpxl3QSLenSYhWvkeknyZ9d8xuLnjP1
 NCD6dIXMS33EE/+npCCFZ8pBRq8gUOpeazya3gKICJqmGEQ==
X-Received: by 2002:a05:600c:6215:b0:471:16b1:b824 with SMTP id
 5b1f17b1804b1-47717e3f3b5mr30828405e9.28.1761649637348; 
 Tue, 28 Oct 2025 04:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjKiJZ1L3buHymE+/qfFxnMX4DBs9WMUeaXcg4jB0+smPA3O5BdC+eUEhECQ10KoQ47iZc9w==
X-Received: by 2002:a05:600c:6215:b0:471:16b1:b824 with SMTP id
 5b1f17b1804b1-47717e3f3b5mr30827975e9.28.1761649636876; 
 Tue, 28 Oct 2025 04:07:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a6043sm189636795e9.12.2025.10.28.04.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:07:16 -0700 (PDT)
Message-ID: <5909c005-8a7c-4bd9-84c4-e0d6d7009947@redhat.com>
Date: Tue, 28 Oct 2025 12:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 7/7] hw/arm/virt: [DO NOT UPSTREAM] Enforce
 compatibility with older kernels
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-8-eric.auger@redhat.com>
 <CAFEAcA_DSo7COpwXF_W4sMiwwmGvZy21GON7UbKWm4H5uDxb4A@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_DSo7COpwXF_W4sMiwwmGvZy21GON7UbKWm4H5uDxb4A@mail.gmail.com>
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

On 10/28/25 11:37 AM, Peter Maydell wrote:
> On Thu, 16 Oct 2025 at 15:01, Eric Auger <eric.auger@redhat.com> wrote:
>> This is an example on how to use the new CPU options. This catters to
>> distributions who want machines to be migratable (forward and backward)
>> accross different host kernel versions in case KVM registers exposed
>> to qemu vary accross kernels. This patch is not meant to be upstreamed
>> as it is really kernel dependent. The goal is to illustrate how this
>> would be used.
>>
>> In this example, For 10_1 machines types and older we apply the following
>> host kernel related compats:
>>
>> 1) Make sure the KVM_REG_ARM_VENDOR_HYP_BMAP_2 exposed from v6.15 onwards
>>    is ignored/hidden.
>> 2) Make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are always seen by qemu
>>    although not exposed by KVM. They were unconditionnally exposed before
>>    v6.13 while from v6.13 they are only exposed if supported by the guest.
>>
>> This will allow 10_1 machines types and older machines to migrate
>> forward and backward from old downstream kernels that do not feature
>> those changes to newer kernels (>= v6.15).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 175023897a..c4f9b82c38 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -97,6 +97,23 @@ static GlobalProperty arm_virt_compat[] = {
>>  };
>>  static const size_t arm_virt_compat_len = G_N_ELEMENTS(arm_virt_compat);
>>
>> +/*
>> + * if a 10_1 machine type or older is used:
>> + * 1) make sure TCR_EL1, PIRE0_EL1, PIR_EL1 are enforced, even if they are not
>> + *    exposed by the kernel
>> + * 2) hide KVM_REG_ARM_VENDOR_HYP_BMAP_2
>> + */
>> +static GlobalProperty arm_virt_kernel_compat_10_1[] = {
>> +    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
>> +    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
>> +    /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
>> +    { TYPE_ARM_CPU, "kvm-enforced-regs",
>> +      "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
> Strings which are lists of long hex numbers? Is there a
> more readable way to do this?
for sysregs, we could use the reg name string directly once we have
script generated list of regs from json description. However for some
regs it won't be possible, like pseudo FW regs.
As those props are really supposed to be used by very informed users
(distro staff) who need to know the kvm indices, I thought it could be
acceptable. Maybe we can rely on defines to make it more readable.

Thanks

Eric
>
> -- PMM
>


