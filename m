Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595AECE7AE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smU8N-0006UN-V4; Fri, 06 Sep 2024 04:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smU8C-0005p1-Dx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smU8A-0004lg-Ow
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725610543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lv6V72wsImtO692vEhV2B/YfSXPpYJbdq9+g/1B9nWU=;
 b=PMfH5pDGjI0jZ0UcYySvdLNpDosYRBn2u+bltHRvgReHurGiZJhthBQHRfGL0bR1F3BG0u
 rJLVlctMIErDwWBHYLkt40JbFnPAR3Ee7+GuijjoWbXse3/1bbO/lYsqVSEBHOgiFtGWmb
 5xLu0ShijkW4G/xrL0e2GMx5HtlSSDA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-7O9CNorQOLyEs87OSRsHjQ-1; Fri, 06 Sep 2024 04:15:42 -0400
X-MC-Unique: 7O9CNorQOLyEs87OSRsHjQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bb2f100fso889161f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 01:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725610541; x=1726215341;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lv6V72wsImtO692vEhV2B/YfSXPpYJbdq9+g/1B9nWU=;
 b=U/+WWl4i/JFROrMn+NHxlPg3HCpHVvtjHgngRvXh6pDusu2rTVrYtwu/EfTIcPhxhC
 jYtRpSgSN9Hz0RdXnIZnk1sNMlaTltaShLZ4aL0HbC2nZRF9Q8KZC72Je6c+KkmPrvZR
 Mqq5Fxk51oQwPnT+Z0dNds1nw6rJIENLwsnMrgI2nCAhAERtS/ywCM1Njr5666uQwhQc
 saZG0iiIFhAJUhMUl0ISm4UpOEsnRMV8dCGJzwfX56dDr5mnvUEclzcYfXpwQ4pFHDCI
 TgvWAY1XLmQD3Y2M+DDI86tOA1UwCI6ZXymfb8H3mwnk4i8D+xcpOiVnpkimdpvSVZhB
 eq5Q==
X-Gm-Message-State: AOJu0Yy8efpjCVqj/5VEkO5xSfAFBvJb4eqeg30IOO/DZibankaz9vrX
 MkjjpDtHw5Zd7irK4TNDMNowA/gmOhV5muwsLuY8C0HgG0GNO98mWah1dr3B6FVk90HGyH7zTnR
 0azDmtQlhAlokpUsR422bHNzMd9oQDZ+bO516dyfmTybrpLSDKtda
X-Received: by 2002:adf:fe8e:0:b0:374:c69b:5a21 with SMTP id
 ffacd0b85a97d-378896740f7mr985343f8f.36.1725610540801; 
 Fri, 06 Sep 2024 01:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAp2Wwj1rfv2ZrbuTlszHvAicTIAhwYqDEJlFSRZBEPNtrsEiHAuHCmrNeiBqzj5GI34WM5A==
X-Received: by 2002:adf:fe8e:0:b0:374:c69b:5a21 with SMTP id
 ffacd0b85a97d-378896740f7mr985326f8f.36.1725610540246; 
 Fri, 06 Sep 2024 01:15:40 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-115-52.web.vodafone.de.
 [109.43.115.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c4ae4850sm14632120f8f.61.2024.09.06.01.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 01:15:39 -0700 (PDT)
Message-ID: <d0222e6b-8874-4708-a90d-437a9c7a08ab@redhat.com>
Date: Fri, 6 Sep 2024 10:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] Revert "target/riscv: Restrict semihosting to TCG"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-8-thuth@redhat.com>
 <CAFEAcA8NqfTdHhCJo8QzPy=EJQYKm=9dCC41UN4K_2pqeXifqA@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA8NqfTdHhCJo8QzPy=EJQYKm=9dCC41UN4K_2pqeXifqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 05/09/2024 21.53, Peter Maydell wrote:
> On Thu, 5 Sept 2024 at 20:16, Thomas Huth <thuth@redhat.com> wrote:
>>
>> This reverts commit 10425887ba54241be1ce97f8935fc320332b531c.
>>
>> Using "imply" instead of "select" is causing a build failure:
>>
>>   /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o: in function `riscv_cpu_do_interrupt':
>>   .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined reference to `do_common_semihosting'
>>
>> Thus revert to fix the build.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/riscv/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
>> index c332616d36..5f30df22f2 100644
>> --- a/target/riscv/Kconfig
>> +++ b/target/riscv/Kconfig
>> @@ -1,9 +1,9 @@
>>   config RISCV32
>>       bool
>> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>>       select DEVICE_TREE # needed by boot.c
>>
>>   config RISCV64
>>       bool
>> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
>> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>>       select DEVICE_TREE # needed by boot.c
> 
> This will break the intended "we don't need semihosting if
> this is a KVM-only compile", though. Can we fix the
> build problem use see with
>   "select ARM_COMPATIBLE_SEMIHOSTING if TCG"

I haven't tried, but I assume that this will produce the same linking issues 
when TCG is disabled. Maybe best if we fix it in the code, see the patch 
suggested here:

  https://lore.kernel.org/qemu-devel/20240906080928.710051-1-thuth@redhat.com/

  Thomas


