Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406DFC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg1Q-0004TO-2h; Tue, 02 Jul 2024 12:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg1O-0004T4-3L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:06:22 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg1K-0006wK-OJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:06:21 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec595d0acbso54184311fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936377; x=1720541177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aRxD39Zokvn9iLXSCY6oLJA+8dI86FxowQXzUUYbOo8=;
 b=nZIm/SIe0EgJweg5I4ALs3z7YWy97BbztqOrBTKEt/FRNgZa+1+6pNqVcgGGjNwr6c
 ayA3iNQp1JvZ7KePJ7iNkJbBOfl2yo6Tajgx/gznBI65EhIXkVE7YKd2tLI2uBoe2EQn
 eZeiHc5IGFxoWZC6sfjaW8/+7b5jMuhPao471sM+SLIkVP/8XSv5Byb1ivHuT9WwXug8
 Hcddj+3O4Mj/WRLlV98OpnYVDskq79gGni+cyJK2MbkJL+KVcPu0JTisYZTlm4IBBxTp
 VMl9SzOyEcJ9LwSZnxuwyQTCPFC/w7SfnQIPwMlKyMnkVY6ONSxKE8PVWB+6iyR6yKMu
 VHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936377; x=1720541177;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aRxD39Zokvn9iLXSCY6oLJA+8dI86FxowQXzUUYbOo8=;
 b=GcDvl7EvmEsZBiFALCPZJxdEKLVdsPB0lvmkRM1pkP5FW4cejHgIGs0qD8DkLzNkxw
 +CQnd9ya8A0U0grwTDep9qkQBSrhe6lqc5vuPU66tru2Jb6W0M6wDr+eMc+yobmHIczL
 dFlz4/dlJkkjXVeaq2VpX8BcC1fsEN9T6JvSK46hTV+fsPwXUSovi+fL89g7EvfWAWDl
 ddMKqgUSet2ujomt5DuNvJGr2a+Y2P3tBlZAweWYwaY0DygPFyAkc8u+ucbBaqr0XMLu
 GE+Yh7k5gdLdG8t7U+z4OJyVSkVKN9ljMV9/UJCBpkEpMyJd4h4Lq0Q0COMEvH/9rqod
 HrBw==
X-Gm-Message-State: AOJu0Yxlb26qMDXW4boX2KqbtzhUnwv1PVWqV2e0U2jkfKL5cIrn2Pda
 wukEGvbDInQ8ZAwLWcNp791Nude7QWOpDY9IL+Im3Y5eKeJfl0mhA2i+x97R95sN5nmvQwsMVM1
 M
X-Google-Smtp-Source: AGHT+IFzjPkkzNBy0wr62GToJMnEZRnAoXH7Ge22vEHoXH1y2vqjuyLn5Fks00orafKQdmllvqCLog==
X-Received: by 2002:a19:f715:0:b0:52c:1d8a:9716 with SMTP id
 2adb3069b0e04-52e82671e95mr5309749e87.19.1719936376726; 
 Tue, 02 Jul 2024 09:06:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1430sm13690243f8f.52.2024.07.02.09.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:06:16 -0700 (PDT)
Message-ID: <4fcc7b92-6aba-4d85-9b8f-f971a28d713f@linaro.org>
Date: Tue, 2 Jul 2024 18:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 06/98] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-7-philmd@linaro.org>
 <ZoJiTdo0yr6V_rgN@XFR-LUMICHEL-L2.amd.com>
 <9be76565-45e5-48dc-a3c6-e0546786fee7@linaro.org>
Content-Language: en-US
In-Reply-To: <9be76565-45e5-48dc-a3c6-e0546786fee7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 2/7/24 18:04, Philippe Mathieu-Daudé wrote:
> On 1/7/24 10:01, Luc Michel wrote:
>> On 09:00 Fri 28 Jun     , Philippe Mathieu-Daudé wrote:
>>> Caution: This message originated from an External Source. Use proper 
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> "General command" (GEN_CMD, CMD56) is described as:
>>>
>>>    GEN_CMD is the same as the single block read or write
>>>    commands (CMD24 or CMD17). The difference is that [...]
>>>    the data block is not a memory payload data but has a
>>>    vendor specific format and meaning.
>>>
>>> Thus this block must not be stored overwriting data block
>>> on underlying storage drive. Keep it in a dedicated
>>> 'vendor_data[]' array.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>> RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
>>> to be the same size)?
>>>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Fabiano Rosas <farosas@suse.de>
>>
>> I'm not sure about this migration question.
>>
>> But IMHO you can simplify your implementation to avoid having to store
>> and migrate this vendor_data array. After some research on this command,
>> I came to the conclusion that it's used by manufacturers to return
>> device health related vendor-specific data. (E.g.,
>> https://images-na.ssl-images-amazon.com/images/I/91tTtUMDM3L.pdf Section
>> 1.6.1). So I guess you can simply discard writes and return 0s on reads
>> (or "QEMU" in ASCII or... :)).
> 
> Thanks, very interesting datasheet! Note the argument filter:
> 
>    To query the Health Status register, CMD56 with
>    argument of [00 00 00 01] is used.
> 
> Since we can program this array, I'll simply add it as R/W (KISS).

(What really matters here is that we don't overwrite the generic
  data[] array used to access the blocks)


