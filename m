Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20441C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 14:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raGJA-000113-Tg; Wed, 14 Feb 2024 09:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGJ9-0000zx-6n
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:32:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raGJ7-0005ys-7b
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 09:32:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1db4cafbbebso7660305ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 06:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707921136; x=1708525936;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OwauHfUyMuoE/Bfmbc+NSS75jLIdX2koeLrr/kSr5WE=;
 b=V+Y8WJFLW5Lg3kKRoISrGatc1RKxNSaL+q5dUK/35Y/wF7VlQCPJ5v0Qv0cApR/Man
 ht46ipGgduyXL/XH0BjL/Jyq10SHeNiumA7DAGqROs7TPc8xqd/Oog2gXUE7G30jY30B
 +GFyHkrrJV7oID07C+4oD6hde0OrTIq3/QNP8m69bJCH5gf0BtI6r/lmI2GdHu4RQTQS
 QWQ7ZKV3/c9taEqlH6ZhpayoqRYZk4b/FyfIe5jSPb/WaW9/kZKvCcgoc95ImfspTgOJ
 9YrKxFaNgGgqvaAZBRy2vO1W/q6+rAJs9/xudA6a1kP3bXYD0XoMz/AkgHOHGyOVhxJo
 WECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707921136; x=1708525936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OwauHfUyMuoE/Bfmbc+NSS75jLIdX2koeLrr/kSr5WE=;
 b=LtXxUHPe2KSg9VUGUwj4RTdX/NQtBTTHkmo1YlbKWfTwIXA4VAxG6IC5rrXSxkRbm2
 1TykuzT5tWmrXsGEGIxLos7N+ofQcSUIeRRv0KWRnHBWFHuQ7nnDC3Q2G98dPwlZLnIf
 wvwnPMxZ/AZfo/xFmqkEhZ/LzGx07qRirOPtdQSRMgcuW+x4Zjg9GiwfeepXzmaRgJMj
 Cl2xnVr+dsdKXZk2nFerpe8j1u63dlpEPFTojnK4bQfRfqzHT8aXunACldRWJrLvxolo
 goAUWnSK8PE/uUhxeolILAjsncm4MqbfXtoDA9ODoA3Xpqw2/TG4pCeNJjFJBeN0EhhW
 4HQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQwM4Kq5AP5Pn1u50Vq96F4YJHdA9ZzEK3LpOR5L1Kc7OFnl93+NFCH7Dw/RMtl4wEMBKn1BMY+I2PxbJVX7oOrPuPTo=
X-Gm-Message-State: AOJu0YweetPOr7Ou7NNVPvKI2EQa6QVSZxZ9VMpTg+RMRxlFNY/cJi4b
 e0bq0/RKvoDh1ES4PnR1mwdzOu3Xfrrf4ik71hZyEMgUpxSPtzv4AzeYmZN4XT8=
X-Google-Smtp-Source: AGHT+IFp8CouJV7JfT11Ul6sXpVDEjZMDnF2l0z8IT9Q4Zqj6cy1yI92rCMep99UNQ4YVJGCbhQBwA==
X-Received: by 2002:a17:903:493:b0:1d9:b3ef:8331 with SMTP id
 jj19-20020a170903049300b001d9b3ef8331mr2632730plb.3.1707921135706; 
 Wed, 14 Feb 2024 06:32:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVBNBXwMgPHN/pwjzyquIc5n6yWkMNyEc8SEbOglsOHIPjt5wD46yEw/YDj0ZYdzL7/U1pHgxg0PquzbqEpnDmb511lboReIOxQK+L/yWhDPfpkTFQ0xi6jd5/Pn4afpTCgbZ9X1Skn/O97Jn6HK0h4o1kknhhmLu2bISl49bXvKeWj/i6pxEK12ovRDc09NhskjxjlIdts7VW/QBNa5qfQpYx9xc91sIXyCjBqrS9yGbifgxtNk1KAecsZlbJ8q5Z271nrolS16s3D4Lihzy6fiT7hv413qLqfbjoS4q+Pqwalo+qBG+n83AWYTOwVCSvTir8BaFCoOsOPtE7Ay9G4RZxyueJ5c3Ccs5vfCoXPgAP/AG+hfAffsBzs0/CO9Z5+CZ+bzGEQoESBMM47tuSqm6fMEjUigGN+lQ==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a170902d04a00b001da2951a788sm3817491pll.304.2024.02.14.06.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 06:32:15 -0800 (PST)
Message-ID: <a20793a9-87b0-4a3d-9032-590502454dd0@daynix.com>
Date: Wed, 14 Feb 2024 23:32:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] pcie_sriov: Do not reset NumVFs after
 unregistering VFs
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
 <20240214-reuse-v4-8-89ad093a07f4@daynix.com>
 <20240214015322-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214015322-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

On 2024/02/14 15:53, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 02:13:46PM +0900, Akihiko Odaki wrote:
>> I couldn't find such a behavior specified.
> 
> Is it fixing a bug or just removing unnecessary code?
> Is this guest visible at all?

My intention is just to remove unnecessary code, but it is 
guest-visible. The original behavior causes a problem and it should be 
considered as a bug fix if a guest expects VFs can be restored by 
setting VF Enable after clearing it, but I don't know such an example.

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/pci/pcie_sriov.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index 9d668b8d6c17..410bc090fc58 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -209,7 +209,6 @@ static void unregister_vfs(PCIDevice *dev)
>>           pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>>       }
>>       dev->exp.sriov_pf.num_vfs = 0;
>> -    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
>>   }
>>   
>>   void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>
>> -- 
>> 2.43.0
> 

