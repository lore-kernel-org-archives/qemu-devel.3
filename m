Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B8CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 23:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYBPI-0000ld-0a; Fri, 12 Jun 2026 19:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYBPG-0000lK-AD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 19:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYBPE-0007Vp-K0
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 19:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781307318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNC+ZgjL7TXzhh5eX1Rz2Ygkx6ktozTkZMaMpEWA9co=;
 b=ZYvRG6GSMyo9JdLp+qDlah3a2lToufqiImKOYhHm47cpfeoCDjGxCNRymsWljn4sXGAEjZ
 e/VoTBZtoYYEZtDgAgnHN5MjYZheTi/ntwTr3rTAg6CPYnt4YuK4/T5U6wqJVMnelk09T/
 mFnXbbqo+5u2Es6zvW8KcEET7TxH0gQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-K_IYfTVWNY6Fx2-5GZXAEg-1; Fri, 12 Jun 2026 19:35:17 -0400
X-MC-Unique: K_IYfTVWNY6Fx2-5GZXAEg-1
X-Mimecast-MFC-AGG-ID: K_IYfTVWNY6Fx2-5GZXAEg_1781307316
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c2d0a8b5beso15898105ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781307316; x=1781912116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RNC+ZgjL7TXzhh5eX1Rz2Ygkx6ktozTkZMaMpEWA9co=;
 b=pNgVoTZ8WSPo4vtTJ7SVZu9gBsdeVoUBMlC9alZLAil40d1yW65TgfjmCibx9w4cXz
 Tnp8D0H0Cpn6NSzJjWrVCEsHn8gHk+go0N3kOq/e8uMEzgUXNYiKHYq9mStuMlRYSDAX
 q1pbYdVxtYd9O34qZmahMo1u4RXzahVE3oJfVpum61xMd7YyBCB7SJpZycRODHuOIkg4
 Ia+fEnwNlBZ+GWXNKd6gyKPU8eILaSxY/qwlx2EUlw1wGNk5xWFFjPLnfM6n3o4QsEJf
 jWXtFAm0+lnoJI/YkZ/z0V+el0p6PQp4UiQeSwmRp3RM8oomhBgeNmJhCxhS5EJIGPQe
 atJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781307316; x=1781912116;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNC+ZgjL7TXzhh5eX1Rz2Ygkx6ktozTkZMaMpEWA9co=;
 b=Dc6RiwT8nlrbXVzuZ0zvgx439TSE4PnRM95kQobE0iPgQyiEb1rG4qvfEY8M71vN3E
 4NALUvxMpkVKF8lt0/zzNKjvuyLbke0MYz2xsLgjaiIhcDMACrkXVYw6+iEwEPE6FPE9
 2doFsj80lu4wr1s90zAI0bk1dMoqjNym+O13aH2X0GfQEA2Q9K9StNiyFOuMbkciOl+R
 0XfSCoQagfVOjpAjDj7DW4COZqLrxWWbE1CoM8HJU18KCdjiYN5kIf6xtyEyfiCmr0Ek
 5e751dQMLdpi+5Z6DHa54vIkELrsOcWB5NoiotS5daCT1JRoyDJKYoMl3ePFoMEo0pbP
 +FJw==
X-Gm-Message-State: AOJu0YycMJLU/68v5IH6JX/HMxMeg5/1jz3pVKdr1i7u6mvPTX/LWz2g
 HsbGtp7PXlmGkwdq51mJO9o1NTyNEoKZCAik3kGXaTNtiAngI1gvvpXcaMcMg+WqTSLV+YA4HmI
 T4jNAM+AiNbDvffJKx90ADAU2fccFKJdca7xtqz6SdNSnRyXZqi36qZv/
X-Gm-Gg: Acq92OF/ULsL0AX2dyjvycq0Lt7mSL2+NDWVPICiDT11lY4QIbaKewDixT13I1Z82Uk
 aElhM6vFrFXDD10Jw4z/C5Gx2tBaZA4rSZLLBUuHsXHNZFRkEq3MUpVkCjnvrz12ijwAnnDBmwY
 YihXp4hTSwYKPwlDVRClbGLuABIF5Ed2YkWOS8xu5hxwtEl3DNLyLj+dOPLPPbilzXj54AVD9bu
 8GbpqtRxrx3jLZ60hMXcdG2AtG7/y2MQT6r+T6SFp721RYgvQyXVwD2pP5ufrJeTb166Ut/Nhw4
 qyUkkw7P1AM9B3DiRLBRADptBprooR6wF0GIrbpVCeJjESc/+wL8fh0KDAtrGAqAPLEfXJuI5mc
 uvbuxlQHzVNtxVVDHOnbTNa8Nzh2PZ1D6uKmg2tMparBl9mQkrI2AcTXU8XZCxOP6
X-Received: by 2002:a17:903:2f89:b0:2c1:8fea:4dbf with SMTP id
 d9443c01a7336-2c4104113a0mr53580745ad.8.1781307315974; 
 Fri, 12 Jun 2026 16:35:15 -0700 (PDT)
X-Received: by 2002:a17:903:2f89:b0:2c1:8fea:4dbf with SMTP id
 d9443c01a7336-2c4104113a0mr53580415ad.8.1781307315488; 
 Fri, 12 Jun 2026 16:35:15 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac631sm31167195ad.44.2026.06.12.16.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 16:35:14 -0700 (PDT)
Message-ID: <311f0568-facf-49de-83e8-7844f5c60e29@redhat.com>
Date: Sat, 13 Jun 2026 09:35:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] system/memory: Make ram device region directly
 accessible
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 peter.maydell@linaro.org, berrange@redhat.com, david@kernel.org,
 alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn
References: <20260612110307.1264798-1-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20260612110307.1264798-1-gshan@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[Cc Liu Gang and Ding hui]

On 6/12/26 9:03 PM, Gavin Shan wrote:
> All ram device regions was turned to be indirectly accessible by commit
> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
> to a hanged guest where a NVidia GH100 GPU is passed from host. The memory
> in its PCI BAR#4 can be allocated as DMA target buffer. qemu has to take
> DMA bounce buffer in address_space_map() to cover the DMA request. However,
> the bounce buffer size is 4096 bytes and we're overrunning it easily when
> the guest has significant disk activities on compiling 'cuda-samples'.
> The full log and problem description can be found from PATCH[1/2]'s commit
> log.
> 
> Try to fix the issue handled in commit 4a2e242bbb by replacing mem{cpy, move}
> with __builtin_mem{cpy, move} in the accessors to the ram device regions.
> With this, we can basically revert that commit to make ram device region
> directly accessible again and bypass the bounce buffer in address_space_map()
> where the guest hang is caused.
> 
> PATCH[1] replaces mem{cpy, move} with __builtin_mem{cpy, move}
> PATCH[2] makes ram device region directly accessible again
> 

Liu and Ding, Could you give this series a try to see if your e1000 issue gets
fixed by this?

   https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/

> Changelog
> =========
> RFCv1 -> v1:
>    * https://lists.nongnu.org/archive/html/qemu-arm/2026-06/msg00307.html
>    * Reworked solution based on suggestions from Peter Xu, Peter Maydell
>      and Michael S. Tsirkin
> 
> Gavin Shan (2):
>    system/memory: Use __builtin_mem{cpy, move} in accessors of ram device
>      region
>    system/memory: Make ram device region directly accessible
> 
>   hw/remote/vfio-user-obj.c |  4 +--
>   include/system/memory.h   | 53 +++++++++++++++++++++++++++++++--------
>   system/memory.c           | 41 +-----------------------------
>   system/physmem.c          |  8 +++---
>   system/trace-events       |  2 --
>   5 files changed, 50 insertions(+), 58 deletions(-)
> 

Thanks,
Gavin


