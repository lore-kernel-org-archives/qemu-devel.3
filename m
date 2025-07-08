Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548CEC83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZF8A-0005o9-P3; Tue, 08 Jul 2025 16:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZCPd-0002Nm-Gt
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:47:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZCOj-0004nR-AP
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 13:47:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60c3aafae23so287828a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751996775; x=1752601575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLf82i0E4bHsDMZnIc9oDAmicMRD9HvwtBZXyX589m0=;
 b=a6LGdUjR9MvwZ0hiA2IL4JnIYGJgde+SfbSJXYBueD+Cr/T7VmxPHTAcvrguLLA1jp
 XtTeKKWWj84bUtgKqD7Jg9a/sjXnfVuxoonLE6pHssgjEHxPhUODYf/viudKQK2My3X1
 vUt9FvuSmDqSgbMDy6p6j297O3ag5Ho1NWJRiicOXYWM7INdJxR/VFN41inAj7R5TTNi
 3o6tj4HIeMadduiuiBIVUrGI8Xw8Ck+JE9Xniy5wVhETZaJHSYZY55iIVCFlxfW2hyWU
 4S9vS6hDy2npvvRzuHTpKEaNTBbpqSSdFqfpd/SLMA4lH7MxBDrGRXKz3ml5d+ikCsA9
 /aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751996775; x=1752601575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLf82i0E4bHsDMZnIc9oDAmicMRD9HvwtBZXyX589m0=;
 b=Ahfd/kglu6YHOhVCHYkDWzX79VkOL1XNrjT/UnM4CqxvZ2q68BS0C6SCnW2WtnW43D
 t6O2sfJuXl4IH5hPJ+reSklwArsWSTCRGP+YogtaPxLRgLu6mlmdh++tzXzBPsYIW+by
 4remZ/movfNGO6kJCcDEA8OoLxg3MHm2uLFdLwWS51rzgDeLQO1tpTBEIXyUSnbYN2O2
 27D+nnlLIvowL61Jp119TmAQnZgAOUfBIeTW561N8YnlAo2d8QlOy36rsBfQPOfrJil8
 hBr3oydRwmgZhOGUAIMvlYl62F0kLcLwe1VGPqu1pVSIabYjrXXkyir4ERn6eOM7uZZR
 xBLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdHKgXmrW8lmrmqnRh0iWcQ7ts0ZX2i667hRVbjQAZ1te0rFP7zlHT9KueaqLfSPFwOgbwjJ4/vqSG@nongnu.org
X-Gm-Message-State: AOJu0Yyi54C7Ai3jMGkEXGfOvvvH7BVnRyKUsvd8zHBpZIpmEtP9/6/W
 Cf691T06rw0YKrYW+OD/GF4z95DzbyBFGDJ9ZDNxEzGaz6QXZXe3TkBu8e3ZE3PbhN8nb15bVQl
 Y/3P8Mvs=
X-Gm-Gg: ASbGncv6nxlWYMrlklUN35wqxuwSkktOSy8Lho2rG2dOHUW9vHG6UzanlHmfoGN6NZK
 xvbVMRTaU5Vh9h/v2JOZP3GP6dcouB/xsTcSLJBjv3XtrS93x6rb2LI778F0EWZQDGXIT20W1ol
 eAJMsE/M9oHKNFsUQ0XeOwmr4+WELuUgbZcLRIwo4hpSqdHezdllw1h+485lIFF6iU0EcJ1XfI3
 xkt+sXBJ04Pysqco2ZQ4fbU6pvPgOefmkvZ9HmlBu0vsEd77GBhyy2d7PkaMvv/kV3yXvaadfCl
 wNEVE3FSfTajpB87EEDaaN02GT93JyIFJWevXxOxZqaPcbqTkEhP2tmiCLPcSZSvEbAgKBeax0T
 zFYRgc9V5gNn1xG/SnybeKVwbtctCMRfp3br5Lltq
X-Google-Smtp-Source: AGHT+IFxatNnW+QKBMdaxUOxZ6SRs4fusBamvYNO1CzAf2O/0Wh3iQaSBDtflxfWM2FbHILXi8Wf5A==
X-Received: by 2002:a05:600c:4e14:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-454cd85d080mr35094695e9.8.1751987836584; 
 Tue, 08 Jul 2025 08:17:16 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d085asm13158142f8f.25.2025.07.08.08.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 08:17:15 -0700 (PDT)
Message-ID: <2e462292-7744-44ba-b536-2e1b6a39d6df@linaro.org>
Date: Tue, 8 Jul 2025 17:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/5] qom: qom-tree-get
To: Steven Sistare <steven.sistare@oracle.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-2-git-send-email-steven.sistare@oracle.com>
 <526f5090-eeae-4eb8-8d1c-e006d9501f62@linaro.org>
 <5f3ee337-ee4d-4bc7-835d-fc9ba2469b10@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5f3ee337-ee4d-4bc7-835d-fc9ba2469b10@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 8/7/25 13:50, Steven Sistare wrote:
> On 7/8/2025 3:14 AM, Philippe Mathieu-Daudé wrote:
>> On 12/5/25 15:47, Steve Sistare wrote:
>>> Define the qom-tree-get QAPI command, which fetches an entire tree of
>>> properties and values with a single QAPI call.  This is much faster
>>> than using qom-list plus qom-get for every node and property of the
>>> tree.  See qom.json for details.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   qapi/qom.json      | 56 ++++++++++++++++++++++++++++++++++++++++++
>>>   qom/qom-qmp-cmds.c | 72 +++++++++++++++++++++++++++++++++++++++++++ 
>>> +++++++++++
>>>   2 files changed, 128 insertions(+)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Hi Philippe, thank you for reviewing this.
> 
> Markus has requested that I drop qom-tree-get, and only provide qom- 
> list-getv,
> to simplify things.  Do you prefer that we keep qom-tree-get?

Doh I missed that, I only noticed his "QOM maintainers please review"
at the end.

If you already addressed Markus comments, please respin to get a chance
to get it merged for 10.1, otherwise I'll try to look at getv in the
next days.

Regards,

Phil.

