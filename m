Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvlY-0003e7-RY; Wed, 05 Jun 2024 14:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sEvlW-0003db-UR
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:53:42 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sEvlU-0002Xu-37
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:53:42 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dfa4876a5bbso166939276.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717613618; x=1718218418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NQ1ZXV71PwAlZBzhcwbSsbg19bD6ox8k5DW5j1iiMiY=;
 b=Dv40TusspdZPyKvL5MYNBGpl4scFOfuUpQI/oIt29nCsdqqozzNUbehzk8+uEvHk+y
 0bEWdycHnnG5ct564oD1jkJ8XyntSLl3Qy0BzVIQFfbkPh4dhV0v12qaP+YY0ObIv14F
 rU+5NWXPJJ+kXUaFsIDrPJbQykErrlwwFfr/OakpZ3U65hcFfNcetFmjcvGsDPy7abVP
 PjysLUS7ejmC1sNJGwX0RQOAjlDRkwzfwVhLLm1+hwQBK8w6giME4FUmNIBQHmsL9KAz
 zWqemBn3JgIC4gsapKglgJhNlPRei/KJj2Wi1cMl484zF9BOPjgk/cCBct8iq5WWPMU2
 ih0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717613618; x=1718218418;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQ1ZXV71PwAlZBzhcwbSsbg19bD6ox8k5DW5j1iiMiY=;
 b=kL9U+1+s4sTfG6fTdYzXdaLjPK0evNhXI+iz0wk61MkmsEERw/WxuJjpKDbofhoWNp
 9gXWj9x0LWl9D1xUuSqKILPJvL6WsmMLOfQViDFPyFLOtYfrTsiCEKTrihXa3o9/qohA
 hq9nDgox4jk2uY3COrB9Emq5QM4ihXPgZ9b4XjqdyiPf1YKaOjLfBf6qIB3IhLeALT4z
 kt3zNV+qrGj0NHqahdEpX8jig8iovp9R+m7LKJ1Dv0IjZ3MScy39GxJeL+1z2dDpEt4z
 EaOgK03a1Cly3VROdKXRPRidU64REoMPl+X9zHoUrIUmy+oLkZHZFfYj7jBKbmR0lhoJ
 Rx+Q==
X-Gm-Message-State: AOJu0YzQAWoQ0AJlU7hNvPVLnln4vJytMVOWs2XKbgRhdEuTyIY71yxO
 i4EN4D2LyyObLVmacMbHE65nnElOjHsk94JXq468Q5sfZZhoFmRNTuP3vaQ4ng==
X-Google-Smtp-Source: AGHT+IGRbmATLlBsqGFJSBtDUhaUMs6bV/t/81kwgECinzYhtNBxhwNUA8ivrbVmJBvi06/3iXu1Pg==
X-Received: by 2002:a25:d8c7:0:b0:df7:92ee:bb1a with SMTP id
 3f1490d57ef6-dfacacf8df9mr3283602276.52.1717613617973; 
 Wed, 05 Jun 2024 11:53:37 -0700 (PDT)
Received: from [152.2.133.133] (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a7463b0sm49884526d6.35.2024.06.05.11.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 11:53:37 -0700 (PDT)
Message-ID: <18028410-1700-4c44-bdd1-6b7e458c4557@cs.unc.edu>
Date: Wed, 5 Jun 2024 14:53:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Convert 'info tlb' to use generic iterator
To: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-3-porter@cs.unc.edu> <ZlncNh_GHoEfXMPB@gallifrey>
 <1f862dbf-0f25-493c-a94c-0ef42531f8ec@cs.unc.edu>
 <e914d69d-9088-4c4d-bb26-cb64d5cbdce2@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <e914d69d-9088-4c4d-bb26-cb64d5cbdce2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=porter@cs.unc.edu; helo=mail-yb1-xb36.google.com
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

On 6/5/24 14:44, Richard Henderson wrote:
> On 6/5/24 13:35, Don Porter wrote:
>>
>> On 5/31/24 10:18, Dr. David Alan Gilbert wrote:
>>> * Don Porter (porter@cs.unc.edu) wrote:
>>>> Signed-off-by: Don Porter<porter@cs.unc.edu>
>>> If this changes the output of 'info tlb' could you add a before/after
>>> to the commit message please.
>>
>> Thanks for the advice.  It should not change the output of info tlb.
>>
>>> Also, have a look at glib's g_printf and friends, you might find 
>>> they're
>>> easier;
>>> https://www.manpagez.com/html/glib/glib-2.52.3/glib-String-Utility-Functions.php#g-printf 
>>>
>>
>> Thanks for this tip too!  It isn't clear to me that converting will 
>> substantially simplify
>> the patch at this point, but I'm open to it if I'm missing something 
>> or this is the preferred
>> project style.
>
> sprintf is deprecated in the current MacOS version, so using it 
> produces warnings.  Once we convert our existing usage, we will want 
> to poison new uses entirely.
>
>
Gotcha, makes sense.

Thank you,

Don


