Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E3DC0218A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 04:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tenmx-00053Q-8j; Sun, 02 Feb 2025 23:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tenmv-000539-Sq
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 23:10:21 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tenmt-0007sd-Tl
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 23:10:21 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso5059164a91.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 20:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738555818; x=1739160618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N63F6p7v7YMJV5tnFTtFiRwx7gfzzfbmkhZBP1+aPB4=;
 b=WzOChTpCF1bT/47fwDqWuUYFmiPBltFVsspiIcWzSav4MsySwmMs9lOt16nV6iGr0U
 gUegfEzzh/EqhAfar8exew/aIKi74kkTHnMjwpvp6EoazVS7FRRECMl3+effmAWfmZBQ
 cgjgtJhqQcJeG4DhkJi2Vbw79qbzpCtszHD/9Zm6LMPdfbD2X5TglUSKpjJLc0PiPN5h
 URKtSefnm1WioTfcG7cFPtvSKYCIlMs/621USML8kt0uLCxPAP61YwSrq0cIRLv/jomf
 bezVGT1+ZEjhjZHyuXaOxy/DeEm0ji4vzWrTviXYM34el8Lwyna3cHUq4ftguzwS0lJo
 lGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738555818; x=1739160618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N63F6p7v7YMJV5tnFTtFiRwx7gfzzfbmkhZBP1+aPB4=;
 b=aEoywGnHXpsau85Hq4B7WsCRTfxBHHbZbDUk7MTa1F/+900AAo8kD9BKkrHiSB5CM1
 TEyrsWQAr0H95NR6kHPU4rGu4YmSDRWHIRL9xQCvKgC1u57/8CfkHgLOLKvwFOOCoh2J
 4oMRWLmbcbi2v3wiGNNxRWmf0kp5uJ84N2UGRS+Q4nIkPqivFd20ApBzUeYJ+YWfBi8I
 AxVVA4as8uvqIET9PsSNSJAUBU4yOqlbs0wC+BBupnfdBxSeLZOFzAXx2+lD1lsI8dqO
 H4sSrrKXpRoOOl6nrHtSelhIG0TMmKHRLoPijdmSF/TAwmpy9CO9DW0aVyMUHrEHd2GH
 swbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2NdRE2pn1iPqVwCZ6cHVfkYtcHDr839r2kxhIIoh4LbhZhIiu6EpLWYf/z6pUaS/XFvbxr1oZYX3i@nongnu.org
X-Gm-Message-State: AOJu0YwjlRQ7ZepTsajYVdQsVxm5wDB7MzLcPSL83qid1whaLFHItAQT
 +cu2RVRGIhKJxPSe9fXVETlvFftU+C6GAYb1HZLcainzNN0GVDcQpcwEhsqDlPyDxkYg2EQGg04
 8
X-Gm-Gg: ASbGnctqnuJCaYIerVj96fmH1GYWyMyFKa+NDDUPaL+rrIkqDaWwd6DFl8MCloTKkXH
 uLtmODXY8Vr/clI8N7woS9JITQ6Jh9ETztfpPNVvWYLTZXDBj9ucGePpM2bRR/hz4vo1OY8dPjQ
 Zbs7hqifd5YDrOy3DBdDPZDf4rZNLEZONRdHk8OAWYtS8/lgfo81FLhHdf8GkwmiwUxZDsTHsvB
 l5QuXJP4RazockF4sEMHGVsp3Xl0WPiWVKYj7v8nroH5UowK/eCir3X7Xze1vHCmWNCFF4oFOJJ
 vElA0xMfqm9o6dnw7dh+VP1ItsBIvjeCPPnV0Q4C/nubm35Eyx38Hb0=
X-Google-Smtp-Source: AGHT+IFxJZymwEOoKzgAF+3GUxSil/eBW1OK+0B/tJ5feHJ1lhbZQc0vnoY6xOwb1CXhA47zA5Nwpg==
X-Received: by 2002:a05:6a00:9a6:b0:72f:c513:a5fc with SMTP id
 d2e1a72fcca58-72fd0c7c731mr30883213b3a.23.1738555817942; 
 Sun, 02 Feb 2025 20:10:17 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe631bf73sm7386397b3a.36.2025.02.02.20.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2025 20:10:17 -0800 (PST)
Message-ID: <b12f5f86-cd05-4f6d-9cd0-0b51a8304ce6@linaro.org>
Date: Sun, 2 Feb 2025 20:10:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch: Sparc prevent segfault when dumping uninitialzed cpu state
To: "Henk van der Laak (LaakSoft)" <henk@laaksoft.nl>,
 qemu-devel <qemu-devel@nongnu.org>
References: <eb7fe8ed-e885-48c0-a36f-1f700bc692bf@laaksoft.nl>
 <abbdad0c-fc98-4ec4-b69a-8d91dbd49554@linaro.org>
 <a392d217-852c-46b4-84ef-d8ea5ad296c1@laaksoft.nl>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a392d217-852c-46b4-84ef-d8ea5ad296c1@laaksoft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 2/2/25 20:03, Henk van der Laak (LaakSoft) wrote:
> On 03/02/2025 04:45, Richard Henderson wrote:
>> On 2/2/25 19:14, Henk van der Laak (LaakSoft) via wrote:
>>> Hi all, my first contribution. I checked code style, patch submission rules and did a 
>>> manual test (details on request)
>>>
>>> Synopsis:
>>> It's a corner case, where a segfault occurs when logging Sparc CPU state in a partially 
>>> initialized state.
>>>
>>> No related bug report.
>>>
>>> Open to harsh criticism ;-)
>>
>> How do we arrive here with a partially initialized state?
>>
>>
>> r~
>>
> |> qemu-sparc64 -d cpu_reset -D ./cpu_reset.log demo.sparc64.asm.elf ||The logging category 'cpu_reset' causes logging of all resets including the very first 
> one, where initialization by Qemu has not been completed. Like I said, it's a corner case. 
> Henk van der Laak |
> 

Gotcha.  I'd forgotten that -d cpu_reset exists.

Of course the logging happens before the superclass reset even starts, much less finishes.
I guess the logging should happen in the exit phase, not the hold phase.


r~

