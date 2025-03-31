Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88030C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDrv-0007xc-U0; Mon, 31 Mar 2025 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDrh-0007wQ-P8
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:03:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzDrc-0002dx-RZ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:03:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso29876815e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743422614; x=1744027414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cEk3jO9GTHWeddzAWGtgrx0xbF/oiL5qddsxWmnJo6I=;
 b=NvMKAHpjp2YdAfrFLjsQ6aFdx0s6/anjbQ4KMPF9LaIB7iE+AGCWFczny9sKhD9xNM
 9RnLMHhxGQIbNsv7r/m4CVXE6kAPYoQcfqPXEOPF9+jOEfDYS5CY/wHHqufd/Z+y118t
 i7hSaW8XDg1eji0aPt9QagqFmRsvk9eQcRGv8HYH4Sg3mgZT6/XyVuGqMjsJURBwMJVK
 NuxIDTUHFtelkje6VTODyy4HPdxmdEtqET7FQJCqmHhp+DcSi5rlu6Q6gftxCJC9KYr0
 Wdy1YU+Kn/B3mt82wgCxso8XRdqh0uN2p49twiL4ZlLnY93nguXcErG3hpkd/Hi7zjnr
 VwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422614; x=1744027414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cEk3jO9GTHWeddzAWGtgrx0xbF/oiL5qddsxWmnJo6I=;
 b=snafqpXtJu48DpKeUefYebTUgaELZq2uzn06CCZyqAWaGBda/eoNkaa4KL2s1IYM5Q
 LdK5qJOPhlDx1Kpct0/zoiagKDH1gNhjrECMp8UQidxkpEklqS4axebVVKPPAo1t6Yq6
 hJnMYYvjiD8Yi9ET9QHjO1DSTwvtIlnKecGu4yfZsc/Z0jsCAMapybLgRAuQzlKwER8r
 e5nEeOcoL35fjYJ70rHKJU9xDiX9hqSHZCUew58wGbzM4n/DtUuxb4qeuGfVKdpL3aB6
 r4LoKWBT6cZgQZ5+05We59vUi0t3YT+X+rmR6R1uS7v/h2g90BvesEnTdEf+H0Qk143C
 ht5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfb3oohKf55bmgzsDV0IUSLwVeXlXxPyCZ35Kme51I3hxYCjXqtoZEwtmWhXBFwscSeFUGr60pc5d@nongnu.org
X-Gm-Message-State: AOJu0YxdEsqgoa22MWrNYCJX9r7aXsvfVTNAJsY2YHYT8SzcCrwjBhIC
 /lsqtdqVFXdGIUwjfvv8mDpEOv17DBc307EpPDHkhm3yi/W+sbVcBks66sOGNqQ=
X-Gm-Gg: ASbGncuFba2KOLLnVZxoI/VNuppzHlI0Kyqf55lQeAYhkGsZHSbTE3diPvDW5H5AguK
 HkspklHtIqhZ4dMA00J1Dnvb9mAcb3sNBMenjjKETzDapymsnasf8H9lVa0g6/grqZNh0pULbU5
 KIjnkR7LLmA2+mC/HO1GTjU5wBoKtZHE0ResJRAfNwVI/ZqoJ/wq3gcSk5uGyvAVmddBSEWIhgs
 QdfrzCZ7K2s4dvgD3RkAxZIKvNVIWXoWvYgwEUeMtM3phDvsCwPtuPw/tHmu5ZrWwzw4nRZBzV0
 TjUQ4P1nb8gzG790CzeRGJSoVmClU9FxIfohYU+JJoXdzYBj1JdGlOPz3pHaple5Gx4FLAEga9q
 ZXF+E4EhPVeUt
X-Google-Smtp-Source: AGHT+IFcLYhmRgHVt+W7gFZQTIxL437kdCSYkdJn7QmSKbEPj9Gns298tnEPSYHgJXzXnndGDfT7xw==
X-Received: by 2002:a05:600c:501f:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-43db62bf0acmr67100615e9.28.1743422614549; 
 Mon, 31 Mar 2025 05:03:34 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede2csm162435215e9.5.2025.03.31.05.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:03:34 -0700 (PDT)
Message-ID: <bfe9e233-bcaa-4c27-9c8b-7540dc2795ef@linaro.org>
Date: Mon, 31 Mar 2025 14:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mips: Mark the "mipssim" machine as deprecated
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU devel <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20250121103655.1285596-1-thuth@redhat.com>
 <b0accbae-b9ca-4fb2-a842-f08ac947ef0a@app.fastmail.com>
 <f96de148-67e2-41ab-ad5e-23d68af25f85@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f96de148-67e2-41ab-ad5e-23d68af25f85@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/1/25 13:09, Jiaxun Yang wrote:
> 
> 
> 在2025年1月21日一月 下午12:07，Jiaxun Yang写道：
>> 在2025年1月21日一月 上午10:36，Thomas Huth写道：
>>> We are not aware of anybody still using this machine, support for it
>>> has been withdrawn from the Linux kernel (i.e. there also won't be
>>> any future development anymore), and we are not aware of any binaries
>>> online that could be used for regression testing to avoid that the
>>> machine bitrots ... thus let's mark it as deprecated now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   If anybody is still using this machine, please speak up now!
>>
>>
>> FYI I'm using it to run MIPS AVP (Architecture Verification Programs)
>> time by time to check TCG's compliance.
>>
>> It is a proprietary software so unfortunately no binary available
>> to public :-(
>>
>> AVP has two supported platforms, the first is plain old MIPSSIM
>> here, the second is OVPSim MIPS, which is compatible with my previous
>> MIPS virt machine effort.
>>
>> Maybe I should bring MIPSSIM work back?
>                          ^ Oops I meant MIPS VIRT.

IIRC I didn't finished to review the previous version?

Is it this series?
https://lore.kernel.org/qemu-devel/20221124212916.723490-1-jiaxun.yang@flygoat.com/

