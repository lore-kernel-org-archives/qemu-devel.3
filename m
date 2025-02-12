Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AC7C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiH8x-0002Oh-S7; Wed, 12 Feb 2025 13:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiH8t-0002OS-WC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:07:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiH8r-0002bd-FJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:07:22 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439585a0544so209335e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383640; x=1739988440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vb/oUksy2T0eDVs/WZ+OlTrq9ZEiRMXDXMoP2yaB2MQ=;
 b=qeO6oSW9SKXs2GRE6siTsTIpDgJjXwqOrzCjgajqCSYgnq/q3VhTqOIXGvrU72b/5y
 aOaj1BQExraZh3NwGuOUDWQmvuxefnsAvJtIMPXiS1lkYFjNDTAiko2vaoKYZlGvdE27
 yteDFHbfzQJJgXHcuWgvAhFPdiHDhq8x2vMM5h7lDCPXeIEOUE7cE+XZjVkb5O3E3Y0o
 EaUJEoUIsib8D97sbpk8P/NW9BA3rsRwPIK8swr9uo/OOzFhVxR4Lyr8RChfFOL0Xk14
 Hp8UP3rfyhqFzdrAEg/ydC0Xh2h/IS1THexmAC7AB3lVaMoU68BWw7ilYaJqM7m9dlro
 p27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383640; x=1739988440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vb/oUksy2T0eDVs/WZ+OlTrq9ZEiRMXDXMoP2yaB2MQ=;
 b=QaCIBq76nlyxdwXs/IeytDRFoSLRuEjeDN/gD4UAYakQM95Pgl7j+lC/2QLTyj3VGZ
 BujYaY2TGtt7IeAZ3KBe7XxqYp4KNOjr0UIjTK1ndAF2lJckoSmPJ+cNmIDJftZHHrVf
 wFXTJPwI8Cu2w3jjlMEJVNRWgTRPJBJmE0YY7bd17Zzi4S43NT3dFT8GQ0T3y8btvL0Q
 BoJLwmkku4bX82116uQeqrB+ztRhE7V5tPJnY10BvRqyzOlXmmDNtElQ0nq/nA43Re/e
 Dci0/YgFn8WJa/pU0bbHVOMIaVTodd1qkpatF+5k6ECgvx9dK4mIJcXfjpI6iEGJGlyL
 XmLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHilrvrbJzbtxgpt+DU/Y8ci1XJievdSZZfrDyG3lhOOQn6mSscQ3xw2eCbT3pJ3aFbNYY9eLQBut7@nongnu.org
X-Gm-Message-State: AOJu0Ywa2TxFYiyYbc4LYm4iHfDpYRwjO+iAMXCPfIx0/WcNWrIr3CaT
 elxz5EHut+niWbePMP9/zL8qe8Lpi1fQTmPJjO1I5SWtWWtXbnWTQrJl3ODoMfI=
X-Gm-Gg: ASbGncuVRuf3zbDaT6+SOAa7BqvkthM4pmk6V6V7LFReu70aB867UNhiNkDD2Yja3zN
 yuh7uuR/D9mSiHsxAPWzMF9iowifGVPLvb3qxiFYjDzaYPMk+BRZboy2WtY7F7qMyWqbhpTSx/F
 tv6KqcVZPqFdC0kEMGWMitabrBNJ/U7dkxp4xctG1XBtGobvYTO1CnVdJpx80s50+3LvTzrnB6j
 FOa9YgTNYSydLOIVIc5yv0/FIXQNlwV0k3auduFA8yUMMqHJgRhvOf2T4BlmS6txR1Nbh01GRGV
 X2cSmL2xtRR1F/BqsRciaNylKp9y36ZVR5lwQvSnP8L8ED2FfBXkmX2sM2jwjtoU
X-Google-Smtp-Source: AGHT+IFOie6orGe2C2aMDe9cLFd4HrospoXenp/i55zLUq+ElR5xJaM2mCO32g5sOPS+uCc1cNNz3w==
X-Received: by 2002:a7b:cbd5:0:b0:439:4b7d:72f1 with SMTP id
 5b1f17b1804b1-43959a480dcmr35825315e9.15.1739383639603; 
 Wed, 12 Feb 2025 10:07:19 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b8443sm26943925e9.35.2025.02.12.10.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 10:07:18 -0800 (PST)
Message-ID: <07a8be9a-d99e-4d02-b475-671435c11396@linaro.org>
Date: Wed, 12 Feb 2025 19:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
 <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
 <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <23d119e5-ea42-4b0b-a491-0fb7b8c4dfb4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/2/25 18:24, Konstantin Shkolnyy wrote:
> On 2/12/2025 08:52, Philippe Mathieu-Daudé wrote:
>> On 11/2/25 17:19, Konstantin Shkolnyy wrote:
>>> Add .set_vnet_le() function that always returns success, assuming that
>>> vDPA h/w always implements LE data format. Otherwise, QEMU disables 
>>> vDPA and
>>> outputs the message:
>>> "backend does not support LE vnet headers; falling back on userspace 
>>> virtio"
>>>
>>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>> ---
>>>   net/vhost-vdpa.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>> index 231b45246c..7219aa2eee 100644
>>> --- a/net/vhost-vdpa.c
>>> +++ b/net/vhost-vdpa.c
>>> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>>>   }
>>> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>>   static bool vhost_vdpa_check_peer_type(NetClientState *nc, 
>>> ObjectClass *oc,
>>>                                          Error **errp)
>>>   {
>>> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>>>           .cleanup = vhost_vdpa_cleanup,
>>>           .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>>>           .has_ufo = vhost_vdpa_has_ufo,
>>> +        .set_vnet_le = vhost_vdpa_set_vnet_le,
>>
>> Dubious mismatch with set_vnet_be handler.
> 
> I'm not sure what you are suggesting...

Implement set_vnet_le for parity?


