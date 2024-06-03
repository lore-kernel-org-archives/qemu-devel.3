Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8D8C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8M5-0003Sk-6C; Mon, 03 Jun 2024 10:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sE8M3-0003S6-7t
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:08:07 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sE8M0-00009a-2S
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:08:06 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6ae0abdf095so23531166d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717423682; x=1718028482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WIJwRmXD5LIF9j8bmdf8eR81EB4upKwkxK9QWrqgfzk=;
 b=URIKM+bcGsEluJB/DyQ16CWJZB3N5lDV9ROOE2OUTnL3Ta/wqvl/HGjbzMk5pyXxHi
 2EVMNqLCHr23cfXrgfgYTa3M8kIG9rkMtl7Mdpurr8S/e6KF5cp52ktYCgG9hV+0sHu+
 t3P6pt3/kicEhDAb91RGqr7Trh1epZ7QoUYF7MRG//R1yQXNVP4dkZmly4Gg+mDlQLlQ
 uIIhQFfHIIVAwJ+d4BZdUS5H3Z6/4+2shBgLgJZeBqnGKj5Ra5zW81Tt1jfHPaj7gVYG
 Xcini3TaTN2TGEe5ttKAykI+szmV6VCaf7DPLu3pZPAvz3dNiHHw3VNdy3BONQLAdnjO
 xOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717423682; x=1718028482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WIJwRmXD5LIF9j8bmdf8eR81EB4upKwkxK9QWrqgfzk=;
 b=kDq2Jk4rzohM+tsrLqj57qE7ZzG6zWWMihBrBl1VD1d29js/eR6r02cdfXIX3/T3y8
 Zk2ONf9yZqHcFoGBI/Am2VUT2gRlphIzzX6cZmCtuv4kR72itq0zGwqni6jv+L5wH68z
 HRqg9+4nH1W+oPIR1E1bSP/wamVeffVUBJHRhZ8nyzdW6KYKWSau5lhAWcKBB5TOtGF6
 69oEbDgJiB89gmixr5LaT8VV+uRFedqMM/93c62CyXo9fD+FSqejiQ/wptMYbsI/J4UV
 Bc+mw0t0pfRFIr2mYOydUkI+ExuekqIqugX31AVB7hukpNGYrsjzFP/9eexF5l4oMGtt
 Au4A==
X-Gm-Message-State: AOJu0YzCjGeokQgSQ04qGqdULGY+kCekvZBsJso2mRpCoich2jJLGJQ2
 w/jUIEUdzEpXdrQHflmFN/gOdJkNeyMNWtby1su1hqLNDhAWULVTAniyRYmF4w==
X-Google-Smtp-Source: AGHT+IGoeKlI0vbiT1D3vyrsEDkDqrZcYNMTwC1wTcfaohgMWOCgjyL/hkKTVVJjQWmTanqzA1ydPQ==
X-Received: by 2002:a05:6214:3d99:b0:6af:c64c:d1a0 with SMTP id
 6a1803df08f44-6afc64cd5b7mr23038506d6.56.1717423682373; 
 Mon, 03 Jun 2024 07:08:02 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a74770dsm30784596d6.30.2024.06.03.07.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:08:01 -0700 (PDT)
Message-ID: <b89b9708-f9e1-4857-bd44-9c49a065c31c@cs.unc.edu>
Date: Mon, 3 Jun 2024 10:07:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] Add an "info pg" command that prints the current
 page tables
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-2-porter@cs.unc.edu> <ZlnajZpUHyGDTgNx@gallifrey>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <ZlnajZpUHyGDTgNx@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/31/24 10:11 AM, Dr. David Alan Gilbert wrote:
> * Don Porter (porter@cs.unc.edu) wrote:
>> +
>> +SRST                                                                               |
>> +  ``info pg``                                                                      |
>> +    Show the active page table.                                                    |
>> +ERST
> Are those |'s over ----->    in the actual patch?
>
>> +    {
>> +        .name       = "mtree",
>> +        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
>> +        .params     = "[-f][-d][-o][-D]",
>> +        .help       = "show memory tree (-f: dump flat view for address spaces;"
>> +                      "-d: dump dispatch tree, valid with -f only);"
>> +                      "-o: dump region owners/parents;"
>> +                      "-D: dump disabled regions",
>> +        .cmd        = hmp_info_mtree,
>> +    },
> Hmm this looks like a copy-pasteism ?

Yep, my bad. Sorry about that - will be addressed in v3.


