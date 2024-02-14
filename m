Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FE5C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 16:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHqK-0006sR-Ts; Wed, 14 Feb 2024 11:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raHqI-0006rx-KB
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:10:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1raHqH-0004kr-06
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 11:10:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d7431e702dso49170165ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 08:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707927035; x=1708531835;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRUKnOU0Z94toFl2MGSatcojSmwuRb1tIocZQSlwDu8=;
 b=kI1YmHRzsW1ZBAp6MBhNUaOd8RTlEuh0I4WKUQ+HMRDebM4RwipYI1DZ0SLB+fG7N3
 VdmlkiIemGUEgg/cfyslFq92asbbQ/af9XVre78nZKMNyqkTh8I2tEnA8jiBnrHQGdxb
 U0dF6NF3Zd5Tq9dNJl0ZUlqccVo+fnlpwB7nRyKzkFOlIusXTHsx6Tf7Mfw3RKjkJX0/
 EXOtEiWWIjUy0FryBEQXTesDUh4AEvjAhoh6QNpvVTtROmldFWCnP2MRHYadvtV1J1ge
 IUqIvUGQHr5PERnwyWaMVTipzZ3dKQH2fZZjgaFUCDB1Irp7cGV3WOWR+CMjdzlMIzKR
 Om5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707927035; x=1708531835;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRUKnOU0Z94toFl2MGSatcojSmwuRb1tIocZQSlwDu8=;
 b=AWzNyL/fvZiQeRWzf2LjpCEd++9p2PYclxM82KKexgUJ/TJju74LqYux9aAPrr3Vqc
 i/cwFKxbKLeiQeSGMJjFc/XPg1oK1SwU7y5H8bVer81tC+OwuRzTDK9O8tWFO3aUc5Mu
 iiiXQsTii3dmDk2xO3AU7Mk3BR/qB2pOzd8QV25Zzo7K2gS9Ut+br1VhIxi5FZcyz7st
 GY+wHO6cg8ScsRXhUxDAfodPwKfOIASb7mrk7VH8RrbbOHSluZweXMx4+J9mIc8IxNH+
 /kdPYr9AilDSgaoAvCq3DOKpNLGb92LxkOpduQn31RfGHv+m1/I6ECSN3iqG861uFhNm
 6jnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy5aWPcIf+Z5+Vx+/LNDybUyoFZ5JSyGGsMb5Im5NWOS4sy9Ia0QGRh/QMmcyN5bdCmmBQ+V9Ec6hri/fLN7aZoPXJ0IQ=
X-Gm-Message-State: AOJu0YxFP/bNHs5yS+v0bhoq+qtch8GrtoNqmp/DxMjaKLiAXHIUPvXO
 sOgsNzQep8c0K/zKJEBTfYsaYa+9+kv9uJh2/PITSOmQWqbFXEjS89tehWN5Jhw=
X-Google-Smtp-Source: AGHT+IGDLJH/ZuiaOrA0gk9q7u81BYrfrMt3Gk3ypoRTI6N0+A2A0cqKIlDin4fUsuqkZUTawXgcGQ==
X-Received: by 2002:a17:902:fc84:b0:1d9:7ebe:432a with SMTP id
 mf4-20020a170902fc8400b001d97ebe432amr3652002plb.30.1707927035575; 
 Wed, 14 Feb 2024 08:10:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Y05mVjzvWkyDwAJfT7bg0uGs+NCLcMys6/ulZejLehHK1hkqVwmwJ2WnGUFTPqsVvjBeLqO5XdgLXjxgda+nonmBp6uBAbj0b+esFwlWEiRqnDcXJJFwgyZkWQxAfQcLs0+oL90Tzk9XfklEeQjcSXkZ2JJMbzxl1FBkwvqRxcgYox3ian/cpoaFN95AmM1R9u8J+yW2Qt1jJCK1/+1Qip0GwfSqx7YC9aM8XgALhRvy3ST3g8oFWetqTGNdlFjQRNB5p1QLT8Z5fIaYiGztvwPsHm9dImpL8G91IGILXtAocfEY/4eGNiJl49chY81HtGCGRPn7EJiUrkl1Rz3BwqR9g88aronoku47KC9hznGTSzvcwNiM3VEdk1e7TQH9T/749g6Fr5Xk/GTFoZtOTVtMrSd3ZmhbiQ==
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 ks3-20020a170903084300b001d9df9589e5sm3963766plb.10.2024.02.14.08.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 08:10:35 -0800 (PST)
Message-ID: <baa47c5d-050d-4687-bacd-f16ba1740ecc@daynix.com>
Date: Thu, 15 Feb 2024 01:10:31 +0900
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
 <a20793a9-87b0-4a3d-9032-590502454dd0@daynix.com>
 <20240214104637-mutt-send-email-mst@kernel.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240214104637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2024/02/15 0:51, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2024 at 11:32:11PM +0900, Akihiko Odaki wrote:
>> On 2024/02/14 15:53, Michael S. Tsirkin wrote:
>>> On Wed, Feb 14, 2024 at 02:13:46PM +0900, Akihiko Odaki wrote:
>>>> I couldn't find such a behavior specified.
>>>
>>> Is it fixing a bug or just removing unnecessary code?
>>> Is this guest visible at all?
>>
>> My intention is just to remove unnecessary code, but it is guest-visible.
>> The original behavior causes a problem and it should be considered as a bug
>> fix if a guest expects VFs can be restored by setting VF Enable after
>> clearing it, but I don't know such an example.
> 
> Ah ok.  So:
> 
> 	According to the spec, PCI_SRIOV_NUM_VF isn't reset when
> 	VFs are disabled. Clearing it is guest visible and out of spec,
> 	even though guests mostly don't rely on this value being
> 	preserved, so we never noticed.
> 
> I wonder however what happens on reset.
> How come we don't have a reset callback for sriov cap?
> I suspect this hack serves as a work around to avoid leaking
> this register, and we really should fix that too here?

pcie_sriov_pf_disable_vfs() is meant to serve for that purpose, but it 
just disable VFs and does not update registers. I'll change it to update 
registers and rename it to pcie_sriov_pf_reset().

> 
>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    hw/pci/pcie_sriov.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>>> index 9d668b8d6c17..410bc090fc58 100644
>>>> --- a/hw/pci/pcie_sriov.c
>>>> +++ b/hw/pci/pcie_sriov.c
>>>> @@ -209,7 +209,6 @@ static void unregister_vfs(PCIDevice *dev)
>>>>            pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>>>>        }
>>>>        dev->exp.sriov_pf.num_vfs = 0;
>>>> -    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
>>>>    }
>>>>    void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>>>
>>>> -- 
>>>> 2.43.0
>>>
> 

