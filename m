Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E504ECD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4Ge-0002CN-Mm; Mon, 15 Jun 2026 06:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ4Gd-0002C0-H7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ4Ga-0001p4-68
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781518202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4M1I8RGpIwaaxXIH54iyHEod1yhkQwEymkDVwIP9iD0=;
 b=Ed1BCuS0TMT6/Ovap4iaVz9T+zECr30IfLKsdfvnlmZQpXIF/v7boz3NK6g2GBDcC4C+JN
 cEhbJHBy7BwkhmeBpSuMp0sposb984kGOTNBb8hDMyXbdaidbMoI5esVeUpBZnsnGBPMFM
 6V03vEVwsohnBqomVZ+nR4qoWXeCHEg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-bcpg7zanOmq5U9uZQPHJpw-1; Mon, 15 Jun 2026 06:10:01 -0400
X-MC-Unique: bcpg7zanOmq5U9uZQPHJpw-1
X-Mimecast-MFC-AGG-ID: bcpg7zanOmq5U9uZQPHJpw_1781518200
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5042444eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781518200; x=1782123000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4M1I8RGpIwaaxXIH54iyHEod1yhkQwEymkDVwIP9iD0=;
 b=Vpg6c4c69fAtGWrAYkZ/Lk7ECCtZnooKQ6FrprcUMm1j31tE9WazzFdQJK5gsuh/Wf
 LqbDn2er6AimmmUHejkI8+zV+5SSy08XmRSQRQEtQ9dPN4K84AQUf4JSOLW2tfALqDER
 Ul8UCGrFF9lvfyRSwvKTSgzxHRHZj/Xg9GQa7sDCgViQ3Th7AO2shu1MpB2St0O1LfGa
 oxIiRn0rWiwJU6Xk8AxKUuL14NO0/OLoTkaStiSPPSBcryUwJ0YyDc5HgxG3H5NqG3Ki
 H+RzpASZ2s0SFNRZ+fri0/i+VOHXK4o0cI0Ddn8D7giJlH80MR/XUtXleRQ+mjdC/BAO
 LVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781518200; x=1782123000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4M1I8RGpIwaaxXIH54iyHEod1yhkQwEymkDVwIP9iD0=;
 b=Url6bWudwddBwMNkBIqRRxTx2CBy7EEl46DYjB0DuCBdedvJjR8vq6qc+An3cf3GVf
 NwOWXTxwZpG0i2U9S3g8e/I6uVwqWkzlEe/7jicjlaIQvtobwwWVVvl9XF+pM0CImg2g
 XlKKfu51rMneQnfyMqJM6/lml7xuzsFH3pCpJE3LNPbnsGFXjrwl1tfHjT+4Ouo9GxCg
 1DdSnClsA/1Jgq6RXyforqWRQBatKNa5xV8i84P8hjrx/BiqbzTYUywdM9/8QPQ9ugLn
 UI4E/RAcfO4sBk1dKLSR3vbp9U1HIaVY92vwpK+XbZO7V3pAhRIKucGSWfT1NOeiO5Z2
 qiYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KShwr+xfD74eiN6YovPg0YIr2D6F5GbXHX74AkbYX+3V9YswjkoaFBMcdDWAe7cd0mDWDy2Tkuxw9@nongnu.org
X-Gm-Message-State: AOJu0YzAPFLFzJNTCaFejsR5LbbiFisW8WDtlQ42ZMmmNRnfJf7ZrF7G
 BU6CQsGnR+2U96XKjv6Ynb64zD1oInOlD+o583CkHfmBcESjdowfsLvglLRJgEsyOczyd6aMpuF
 8IqKYFbuiwhYBhC/PZLlEKPQL/JQxZJ+Zn+L7tWCsSa9MgOoBBCdLKYSj
X-Gm-Gg: Acq92OHOyPsL2nSl6/0Lisvd+QezeBwBGAcToCLY58PMG8icQJsiQHLtDB7Hc9WA0KD
 sPSPKwKnZJJuDLrHsUfI5K5uvQiiSdz2bDb82Wfetgp+i1u2SbeKGXLPNJ9Nt0uyjdqxZWSDXlY
 U0ObhVgjgphbYvGBfNRa7hZ8TiGLhqFbxc2PEkT53DOGbJvY9JyDeg1f8bOBy1ufM/L8qiYy0ie
 GISImr3qAHswDsDtOcUrTxqPaQZKKJe1FFQ4pSyUgMeTgNrExmClzo+1MIFBB5lqkWiDO7iSgXf
 0dspR9lNjmyNxnjYSBYP7WKUlozmXj0TYWUmg8RkBdNbj2DXISZHLwD0SP3Ty/lHMUoPJurcbrb
 1zJDHgAIhQ7MKOfnhh7W9Qkb/pKioP94Kp/Uhy03haDm8ecnqMN42dYQINS6B/bVD
X-Received: by 2002:a05:7300:4355:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-30940357f24mr6231710eec.34.1781518199799; 
 Mon, 15 Jun 2026 03:09:59 -0700 (PDT)
X-Received: by 2002:a05:7300:4355:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-30940357f24mr6231675eec.34.1781518199173; 
 Mon, 15 Jun 2026 03:09:59 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43bc7sm13986211eec.22.2026.06.15.03.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 03:08:35 -0700 (PDT)
Message-ID: <1845165e-5ab8-49ae-ac23-fabbe723f718@redhat.com>
Date: Mon, 15 Jun 2026 20:08:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com,
 david@kernel.org, alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com,
 philmd@mailo.com, phrdina@redhat.com, jugraham@redhat.com,
 shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
 <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
 <20260614131704-mutt-send-email-mst@kernel.org>
 <52c2af6c-f494-4e30-bac6-bde2aaf48931@linaro.org>
 <20260615032545-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260615032545-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/15/26 5:58 PM, Michael S. Tsirkin wrote:
> On Sun, Jun 14, 2026 at 06:41:57PM -0700, Richard Henderson wrote:
>> On 6/14/26 10:22, Michael S. Tsirkin wrote:
>>> On Sun, Jun 14, 2026 at 09:45:51AM -0700, Richard Henderson wrote:
>>>> On 6/14/26 08:13, Michael S. Tsirkin wrote:
>>>>> Yes, I think it does work because we use -fno-strict-aliasing.
>>>>> For bigger sizes we'll need packed because the addresses
>>>>> could be unaligned.
>>>> ...
>>>>> For most host/guest pairs things simply work even for unaligned.
>>>>>
>>>>> And yes, guest drivers do do this.
>>>>>
>>>>> On classical pci, there are no transactions as such and
>>>>> an unaligned access will be split anyway.
>>>>
>>>> I'm saying, if you're talking about pass-through to real devices, that won't
>>>> work. For instance, AArch64 will trap unaligned accesses to Device memory.
>>>
>>> Presumably, AArch64 drivers don't do unaligned at all then?
>>
>> Yes.
>>
>>>> You need to actually handle unaligned.  Perhaps something like
>>>>
>>>>       /* Find unit to fit size and alignment of dst */
>>>>       uintptr_t test = (uintptr_t)dst | size;
>>>>       uintptr_t lsb = test & -test;
>>>>
>>>>       switch (lsb) {
>>>>       case 1:   // loop over uint8_t
>>>>       case 2:   // loop over uint16_t
>>>>       case 4:   // loop over uint32_t
>>>>       default:  // loop over uint64_t
>>>>       }
>>>>
>>>> with the expectation that normally we'll have aligned addresses and size
>>>> such that the loop will iterate once.
>>>>
>>>>
>>>> r~
>>>
>>> And ifdef for arches without unaligned support?
>>
>> No ifdef.  All accesses produced by the above are aligned.
>>
>>
>> r~
> 
> So something like:
> 
> #if defined(__i386__) || defined(__x86_64__)
> #define HOST_UNALIGNED_MMIO_OK  1
> #else
> #define HOST_UNALIGNED_MMIO_OK  0
> #endif
> 
> 
> and then we can check that.
> 

Thanks for all the comments. A new revision (v2) has been sent for further
comments, thanks.

https://lore.kernel.org/qemu-arm/20260615100200.266968-1-gshan@redhat.com/

Thanks,
Gavin


