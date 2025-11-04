Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD37CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGDr-00061U-QQ; Tue, 04 Nov 2025 07:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGGDq-00061H-EZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:33:14 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGGDo-0003Qr-LM
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:33:13 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b725ead5800so15084666b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762259590; x=1762864390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EhPqbtEQzDSV9X3vnxbm9qLczrJw9XOdOcGOPrrG9G4=;
 b=ByVd1x2AMbbaJbiR3KJtWaBX7Qlz/hQuk9nDXjbMhV7K9XxGYQ0T84ZolNYtm3xYEv
 xlXXTCXTqgFjNazcQXXXLHRf3KNBwnrz6iRfRw6TThmZinNKKNSy7VolWI0Yjg7NvqHq
 x1H0T+iTN9Y/0S/+om0Z10H2RxpI02IzxsqzelziLPpDRP+z+HFs7KEqVViwnGxDy7/M
 h9f5SsYqw25BPbaiRmFF63499nlvP5x3jc/ARUyd9FQHjxLOu8fO3Vq0f/yXMZ8HT42m
 Z98kR9ONIYJbktMPxtKUevwllR9T/YNr9oEP3ULsC9QAT/ny+OmcUTvdjbf+98ILHCHv
 Eyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762259590; x=1762864390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EhPqbtEQzDSV9X3vnxbm9qLczrJw9XOdOcGOPrrG9G4=;
 b=tQ2oBokmsig/lQDSprgMzGFEvFhuu9CexfOTnq2H9OsXuQrdbJ/kJeu1n/DOThCZjS
 pVCJubg69aV73vjw3TCcqzzEtNs9IKBiFgTcQazYlE4T4kqrhH98HsGM3ilNeCBmz9FA
 SP9fH7ueP81o3bwF0XDD91ia+ipFse1ciFUNi7Hx8sBvgNR58Dn5PXzFB52SRL46gqd9
 D0dIl0U2nzuqpYnQ52ivv0vfwNvsACsQBOz0T9wvzQgklcMua4FU8gfLo+OVU35F835X
 ou8xpYpbtkC9pl5DTc+MD/12bKTDaELMuhXZBBt4RAXoGBenUwjOhZp/qSNrxvWNhAW+
 vUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Y1O70XB8G/56ZFarzyj+yuSopdnHFulFBuYXj/gxrs6GRb3Oc3N2oGyfXqHkYE6+uzkn+o4FaM9i@nongnu.org
X-Gm-Message-State: AOJu0Ywpo+MYQ1lqwoxGAt6545hQahGkQGOsj0zqkMoPNpn+LWQVKADY
 dgigl0vkrIXXHKupAj8fNSzwAUJMUzePQVjwD8SpjY0gs+wGGYxDnN20p6+tz4AdpAw=
X-Gm-Gg: ASbGncsXhkPjubs2hIjl2Dodvn41cmbJOze6da6Rdk6nQwCTf+hkplulvGYQjBE8QVo
 sQmDlxGQ7iK7ZwzLgZ7I4EbEzoBH6bq3bn6y1ijvb4LxffAgYv/CavJxPx1+DYp+OKNNYhtmHBH
 Mr+P0BCa6aFOxl2+EYk8DsRyvY1uzGjy5kWbcYYlZ8VoY5fXMJfyVcHRszyDVzKq0wiYzJPDtYA
 CcEXRmDp3ZWw+Q9iwXzpaplW8l2HlW7KsvmD/Sp0o9gVLX3S9q7i3RfqzYI8GSczDK1MCa2X56G
 ICPLvkovyjnTu4xom19/U6DtzEOhX2X9oqcY8a/oBFtqGAdwztlphAPNoCDObzvQgENa3JDq06l
 Magd6LfKpyzRys4z9J7P3cKMdnyoXeB65wbWeztQsPzTv9HoKu2EBhCsBFfNHTeA3ZgoDzPlckz
 I3BKiczEAaM1Oxrw==
X-Google-Smtp-Source: AGHT+IG0TxJ6+0K9MtVYWqBu58WugjnnMO2+Ie67gXKR4dZXKdZy4PDYs0+jibTLk545dhJ7zG608g==
X-Received: by 2002:a17:907:3d0a:b0:b3d:200a:bd6e with SMTP id
 a640c23a62f3a-b7070732726mr1553619266b.47.1762259590182; 
 Tue, 04 Nov 2025 04:33:10 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d6f33aesm198031266b.19.2025.11.04.04.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 04:33:09 -0800 (PST)
Message-ID: <dcb21299-f6b1-489b-b952-aafd64dba31a@linaro.org>
Date: Tue, 4 Nov 2025 13:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] scripts: Add helper script to generate eMMC block
 device images
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Eric Blake <eblake@redhat.com>
References: <cover.1760702638.git.jan.kiszka@siemens.com>
 <5c9c6495ad4afc9d11f856bafcb797fed8fccecc.1760702638.git.jan.kiszka@siemens.com>
 <bfd49f9a-0a37-4e1d-b7e2-f0e59943915e@linaro.org>
 <08287450-4889-4329-b21c-87fde274b13f@siemens.com>
 <b4becb69-cf74-4e1b-97f3-52756b8a69d2@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b4becb69-cf74-4e1b-97f3-52756b8a69d2@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 4/11/25 10:26, Jan Kiszka wrote:
> On 04.11.25 07:30, Jan Kiszka wrote:
>> On 03.11.25 14:12, Philippe Mathieu-Daudé wrote:
>>> Hi Jan,
>>>
>>> On 17/10/25 14:03, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>


>>>> +if [ "$bootsz" -gt $((32640 * 1024)) ]; then
>>>
>>> Running on macOS:
>>>
>>> scripts/mkemmc.sh: line 165: [: : integer expression expected
>>> scripts/mkemmc.sh: line 169: [: : integer expression expected
>>> scripts/mkemmc.sh: line 179: [: : integer expression expected
>>> scripts/mkemmc.sh: line 191: [: : integer expression expected
>>> scripts/mkemmc.sh: line 200: [: : integer expression expected
>>> scripts/mkemmc.sh: line 202: [: : integer expression expected
>>> scripts/mkemmc.sh: line 204: [: : integer expression expected
>>>
>>> $ sh --version
>>> GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
>>>
>>> When using dash:
>>>
>>> scripts/mkemmc.sh: 165: [: Illegal number:
>>> scripts/mkemmc.sh: 169: [: Illegal number:
>>> scripts/mkemmc.sh: 179: [: Illegal number:
>>> scripts/mkemmc.sh: 191: [: Illegal number:
>>> scripts/mkemmc.sh: 200: [: Illegal number:
>>> scripts/mkemmc.sh: 202: [: Illegal number:
>>> scripts/mkemmc.sh: 204: [: Illegal number:
>>>
>>> Should we replace s/[/[[/?
>>
>> No, that would be invalid outside of bash. There must be a logical error.
>>
>> How did you invoke the script? What was the value of bootsz then?
>>
> 
> I tried with dash from debian trixie, and there is no issue like yours
> visible.
> 
> What problem could macOS have here? Will need your help, don't have
> anything mac-like around right now.

Don't worry, we can merge v6 code part, and add the script / doc
during the freeze period.

