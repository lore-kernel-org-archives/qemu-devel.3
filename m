Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0043ACA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2PO-0001RA-72; Mon, 01 Sep 2025 07:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2PM-0001Qo-Hf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:09:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2PK-00038i-L7
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:09:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b8b7ac427so5491555e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756724945; x=1757329745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sRHr5guPu7iMPr3nU1tfv6PHzbX40PpKttGsE7g8MxE=;
 b=eq+fYuGFkAA088V8hTVCC4rATQSqeo1ERzte1Tj7PE7q0p1m29mY+pXc0BpZmSKAdF
 x7BNioH1imtTgzpoeJ2dLR5fvTxfDNtOfDk+x9L3BnEHiHkuhRovtOP+hyh/KaH3GpwC
 Jo4R/f6nvoSTyxr4TfnF/DE5ngVYP/KvPZcKT4D0rDMA2vcoLXPoC9Jm+tT5tpHVVZmq
 9rLl0sQkMiTJJ3fqVmec6AT43DnZe40OnLN2lOBES8lFNKFmmf/2uBXyrdDf5V6mi0OQ
 mS5QIvhdNWThCwCndNX1rzyhooA3XJ3yE8F06M7cJ+2sM7hhcmoFND5hRt5K3vOig1fK
 qqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756724945; x=1757329745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRHr5guPu7iMPr3nU1tfv6PHzbX40PpKttGsE7g8MxE=;
 b=A3BGSUMuGtVQdt4klK5fwIl6TVNAf/0eB5ph56s/3h07JPOI4ZXhgDbDj0DWSraTuc
 0Y2XTAirQrj53yTQ9OnHWZVKHmAtnm4QCd6wmWcgE8lO8NYQ2SOqT9J4CfvQ7gmfF7CP
 g7LgIya9JZBGlOfK851/J9juK0gibBwbCVMchXsnwr6ckOlYesKV2AkA87cfyybowfYW
 wXMAY94BMba7OiknpFadCgcnFZAgVKMZSPhKLQAC3dwB/siQ744c82IshIjU+prqFfd3
 CYAwlvj1PBsL/ZkNujVdAH1GGX83FK9rXNHx5tIbVP5As4y97g7OnTBeRLZp7cki6Flw
 8GBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFaUnPReJU9w/3D9CgQexGpHgSeknyEkrqWRtmviYlX23mB5+p1CSsW8rjXkNXXWvoXN2HY/4UW5U/@nongnu.org
X-Gm-Message-State: AOJu0YxAEPgT6qXtm8yBcdHlUlFUi8b9RPKA0FZarbMyhkGydHXBR3Nu
 flZFsvtqRn+hOzNWi9X8GUsaEXYrZFD3BVh8UlAz8yjTtC9q+ZSrY0MVUrjBE42jkFE=
X-Gm-Gg: ASbGncuhNe3HPuA1IB1gCYcqsAD8Y720TskXEuBiykVGZ5JvXdu9YqPAu4p3TvjQrly
 OCEBfF1ljoHOWhb6MTx1dsJLPU9DUv+c406siefCncMdADmAtLomq+zmWtD1EU1kM/o6wguJy2f
 UXOOHscLATWqldSF/iv6A9Y7PW0lnUsGpvE4EH9K2MDLR+qbiQkt7tvnOIK5MoM1mJBCabXC6u5
 FTetDGYwSUj38sgqYkvNhh+PVR7vj8r4zAjY2sD7rZVlgPSB29+HRUSE7W0zgBID1HM3JopCUqN
 vugjwI1DIOSQBzwPbEMzte3z0p34MEK15hCIhHaWuVvBk0axWQeY7D4c3IDZ6MWpLB589ngJJ+4
 qF6THAIDn3rYFyqsnBsgf4p1D7O82yo2T0cd1g9pAdp91UyM2HjXCjYkcpjK3W/Q2rw==
X-Google-Smtp-Source: AGHT+IFdSChrNZBgh+G+ZPiCNJM44gS23B8A9HZ9z2jgAbSZbaDgR1QCxTmRal7HhuVYQgcDCgbjyQ==
X-Received: by 2002:a05:600c:1ca9:b0:45b:8c3f:7d5a with SMTP id
 5b1f17b1804b1-45b8c3f7dc6mr30041875e9.4.1756724944622; 
 Mon, 01 Sep 2025 04:09:04 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab093sm157419385e9.22.2025.09.01.04.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:09:04 -0700 (PDT)
Message-ID: <f903021c-e4e4-46c3-ae6a-d03201ee76bf@linaro.org>
Date: Mon, 1 Sep 2025 13:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/14] target/riscv: Add Xmipslsp instructions
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-8-djordje.todorovic@htecgroup.com>
 <87427d18-af1e-4815-b95f-75bae32720d3@linaro.org>
 <00c8547e-dbbc-44d3-bcdf-122899d7dc2e@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00c8547e-dbbc-44d3-bcdf-122899d7dc2e@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/9/25 10:30, Djordje Todorovic wrote:
> 
> On 8. 8. 25. 18:02, Philippe Mathieu-Daudé wrote:
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you recognize the sender
>> and know the content is safe.
>>
>>
>> On 17/7/25 11:38, Djordje Todorovic wrote:
>>> Add MIPS P8700 ldp, lwp, sdp, swp instructions.
>>>
>>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>> ---
>>>    target/riscv/cpu.c                        |  3 +
>>>    target/riscv/cpu_cfg.h                    |  2 +-
>>>    target/riscv/cpu_cfg_fields.h.inc         |  1 +
>>>    target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
>>>    target/riscv/xmips.decode                 | 23 +++++++
>>>    5 files changed, 112 insertions(+), 1 deletion(-)
>>
>>
>>> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
>>> index 9734963035..f35d477f27 100644
>>> --- a/target/riscv/cpu_cfg.h
>>> +++ b/target/riscv/cpu_cfg.h
>>> @@ -39,7 +39,7 @@ static inline bool always_true_p(const
>>> RISCVCPUConfig *cfg __attribute__((__unus
>>>
>>>    static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
>>>    {
>>> -    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
>>> +    return cfg->ext_xmipscbop || cfg->ext_xmipscmov ||
>>> cfg->ext_xmipslsp;
>>
>> Checking for any XMIPS instruction implemented to return vendor
>> extension presence seems odd. Can you implement them separately?
> 
> And I tried several options, but it only made the code even "more off" :(

OK, maybe this is the correct way to go then.

