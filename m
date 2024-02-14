Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74753C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raGaP-0002zc-BG; Wed, 14 Feb 2024 09:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGaL-0002z0-Hb
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:50:05 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGaF-000262-84
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:50:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d71cb97937so53271295ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707922197; x=1708526997;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhHHxRCDs5owoK4TNJv5cS3UjeloKTRO1LjR/xe5zU4=;
 b=b0nfImXRk2BnO2Bffm+MZFT4wpW3kmyEoa0qgHFS/qRn2ETUB3TbPbFSuRm4Q6GFql
 9UTVTjlviBNrJmtPBaeo31nJsARotueKx6jYTQBrE1zJSpllFwrjxp+DGZ7b9Igh/TwI
 X9Ru1sDpX4WYO4ty1mRtW2Q6hh+Fy9gE9nnIM+SdKyaG1T60OcpHCTTJRsTDhM+TKcxw
 YTeXg8xJkhlZZ54Jk+BIjC7fTe5bdIYm9N67LNBsP0tVt10ncdGyjZ1iDnZx2zpRMz+3
 tRfEZWx2mJxT82UDb3wKo08oV5KFMfRcKV06hwHbQSD6Reme9vSYTQbMYQkAayCVj+Rh
 GuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707922197; x=1708526997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nhHHxRCDs5owoK4TNJv5cS3UjeloKTRO1LjR/xe5zU4=;
 b=Csttrb43T2kKEg2V1kJLtyt+/aOlf93jAJ/ppgWzTylepZrj530vn/C6JaF+To2VqM
 I/wiM+uFcWltyZmG95CN+1S0CpVSQ6LOGd4CfVTQfwyniFCniRWCHawep9976GaoDB3R
 VTeAfSZKeMGVs6M12hB0twKJW1E5zcdAGhDblj9NGXfmEmdFN9VfdUqhePblkSFCjnuZ
 Nm+qiZwL8vq99Hx2j0c/PziDCahnwW4YW5TR3IRUu562IMoKZpgRpmgRq4nDGIy8CM+J
 lX95zHzTZP3vZF38531hh5q+7POeDMryzrEvWtOD/45qwCD8ozQPUaisBxOAspIbmgH/
 dM5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg9KjcpHAgC/gTJ4FeK7oooEA9HaLA7BKDhm7qTJVg/ank3S4iobzBidh/Hg/b++VcRQSCZoWpmv2q7P268A1JonJiCaY=
X-Gm-Message-State: AOJu0Yw7rKvRRhQWtYa5F7TY1Q5olHsQRP0AnANXZA/WLlwLMY7QfarX
 /JIH6rC1MEjCzAkC+DBAXukch4kOvfylDEl+SIFS3v4j2M+k1P4rUzueGzGkFcY=
X-Google-Smtp-Source: AGHT+IHNfrq4/OsSPCcThqB5dzfuZtpN7pQfAdMB1lZfyOjh05AaN/2ZZiqQim96qfKu8VU8K6YZuA==
X-Received: by 2002:a17:902:fc4d:b0:1d9:3938:40bb with SMTP id
 me13-20020a170902fc4d00b001d9393840bbmr4304271plb.20.1707922197649; 
 Wed, 14 Feb 2024 06:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUH1H2lqGgLik0o8bSvX3TAK9yMUGVv35IWzi7QtG8BsfMZ01be662A2hM0lF75mVqTZfDJUq5McOKVvvjGG5HbJyg7AaCYgfrfjeyLmnXxw0FF79eGtybzLYM/cU4wVaxLPMqphRNUneEhDNA8EVh3/GLpHWaM7bIrUDTe0NFYQ7cItVIBBbsuF5KPY2DbVfAuIxa/lZTe1+THe1gOKnqnE4DCQ31xKZoW0N1xvRrqWdE5IjJEWbWwJrzE5AkcxktbvvsJ2gbftNHguZ3r42WLJjIPICcSTb50seCiKcGKoyTn6A2wYf3Pw2d2Lme1Q5zhB/lXI/wPEH5hnRY+ZjZ/XaxUh3BqBuhT0u5YfXzau0GwDDhr8B3R1IUjKogclet+TO+mg31iBSWVuIYQw+KTg6v3Y+pcrtr5MQ==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170902eac600b001db674a6f07sm714721pld.225.2024.02.14.06.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:49:57 -0800 (PST)
Message-ID: <dbb8562b-6532-45af-a6fe-63bbf9b74a1d@daynix.com>
Date: Wed, 14 Feb 2024 23:49:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
 <20240214015107-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214015107-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/14 15:52, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 02:13:43PM +0900, Akihiko Odaki wrote:
>> The guest may write NumVFs greater than TotalVFs and that can lead
>> to buffer overflow in VF implementations.
>>
>> Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/pci/pcie_sriov.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index a1fe65f5d801..da209b7f47fd 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
>>   
>>       assert(sriov_cap > 0);
>>       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>> +    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
>> +        return;
>> +    }
> 
> 
> yes but with your change PCI_SRIOV_NUM_VF no longer reflects the
> number of registered VFs and that might lead to uninitialized
> data read which is not better :(.
> 
> How about just forcing the PCI_SRIOV_NUM_VF register to be
> below PCI_SRIOV_TOTAL_VF at all times?

PCI_SRIOV_NUM_VF is already divergent from the number of registered VFs. 
It may have a number greater than the current registered VFs before 
setting VF Enable.

The guest may also change PCI_SRIOV_NUM_VF while VF Enable is set; the 
behavior is undefined in such a case but we still accept such a write. A 
value written in such a case won't be reflected to the actual number of 
enabled VFs.

