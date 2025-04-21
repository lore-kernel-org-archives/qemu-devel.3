Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF61CC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u0R-0005vg-3w; Mon, 21 Apr 2025 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6u0P-0005vH-4G
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:28:25 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u6u0N-0002hk-65
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:28:24 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so3736210a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745252901; x=1745857701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d73NQ5qgH+EYWH6oChRJBaXBQPB3TuMOIVeA4r9fsQ8=;
 b=mWE967lDmtsHQxwncVngcYL8XC3aVru4niEGJkruLQYnF5hKcUukSEj5npz+TXXtVT
 Hgb0VjMD9RMHJE1YIkIt53bGbNUIQt6iC3JKBhz8f6Izg3ujut2DMFWKDWrcEkMY/Mbj
 WkS8tafEyry/9siGhswDszl9G2iuni7LojG5NU7maZ0JI1Tm2AJ8gza1i15aTx/HoZr+
 MXwbLfkhEC1R2cX9T5zJwEiR4oIKM57dJIqOCs2nfUI+HR+tJNDMmLUni6UFqGwTa0up
 b7OzKiKrl/NZtSNKrYkUC2ZGuKDk0rkxfT5FEkSIRsx58IOrhovsPBc1fR2iImRnCLk3
 5LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252901; x=1745857701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d73NQ5qgH+EYWH6oChRJBaXBQPB3TuMOIVeA4r9fsQ8=;
 b=LcFWvWJmMmrH5Qu2EZ80QwRRk+JEQXI9fBJ5QRN2dkXeiVCLpPt/E4X+U4thS+FnIh
 Gcqe4K1Sp5M941Le3dDablFUTiuWOids5+xTo4OmZ+/tGQ7J1xA98T1eW4HfanEBAyHk
 +xG8v4GoSSwkvUvwpQqkDqV+wdSo0Ik/7rxM0FSHK4OJISYur9MMyc+KvSaiMD6iHicP
 sGdoPvEXrud7SvfzJLlAwJA+EYYS+7wUZ82VaDLTOFQ8z0Wo3XaCR5+NoKwtwyvQwdmP
 5R7uA0Z4cTG458TXyijmzOhl4DRah9nXT7U6u8jaRaj3ky5SfxwED3PMyBSqkY3flc/t
 rz/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjyFwRCDUnbaAfTUpkiQIZPSe6bMNcvrogJ2estsLNd+AduGkyuPmqtH5Kbp1gFC6gPPKzS6y4KooC@nongnu.org
X-Gm-Message-State: AOJu0YzrxDqEnNvr26Ea4wImpmraXSdKmflJK8nil2EDvyZlkAR1k1E/
 IiZP7WsvSCfHiQG/Szab2vmJHtbhypv/Ei/NXuLOfnAJHayh61UwPPRN1wLTZ1M=
X-Gm-Gg: ASbGnctFJ0F98FJutPhOzFxToByG//eSf8EMuCozPtMvqvn9RpyniRybNrv2vqZqgkU
 qvcLR73XRIoyc3Qk6i3lxH+VjD0IWO0ihyhSMTCcRPM0vCGOvITpVU4QG1s1BxBBTxee23KyggF
 /5FyBM7B9lMAJ56q90E3/ZOehj7UkL0MwfWSp3KJqiYVu3OCQcqEHLR+0J5WJAxAmfEEH1zV2kM
 ObOBNzQtuiDw9XTjkgVuWbZgQf4gttTz6JPb4eVW29kAf+mYwjjH2NC7U63+U6h49zlKMnPAoq8
 xQysHl5SkpbLdIBpbWfr2Hd2IJ0WTWSs+iEHlH4BJ+t7GLaBBJ37HRijp1KJ0p539bmV7WRMDuy
 HSYB9M3g=
X-Google-Smtp-Source: AGHT+IGe4e7W3i4/cBt0q2EqqKuPCW/9KZc475adHsiZA42O8OBBLcTRonW1+SAv7mRWX9A2KQU5iA==
X-Received: by 2002:a17:90a:c2d0:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-3087bb3f2cemr18351532a91.2.1745252901371; 
 Mon, 21 Apr 2025 09:28:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e8b6236sm5821232a91.1.2025.04.21.09.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 09:28:20 -0700 (PDT)
Message-ID: <ba6d0343-98bb-4464-b805-8b74a85a5552@linaro.org>
Date: Mon, 21 Apr 2025 09:28:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 153/163] tcg: Assign TCGOP_TYPE in liveness_pass_2
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-154-richard.henderson@linaro.org>
 <D99PDOQBOJL0.2MX82UOFOJ9FK@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <D99PDOQBOJL0.2MX82UOFOJ9FK@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/18/25 03:46, Nicholas Piggin wrote:
> On Wed Apr 16, 2025 at 5:25 AM AEST, Richard Henderson wrote:
>> Here we cannot rely on the default copied from
>> tcg_op_insert_{after,before}, because the relevant
>> op could be typeless, such as INDEX_op_call.
>>
>> Fixes: ...
> 
> Missing ^

Yeah, I filled in that blank just recently:
Fixes: fb744ece3a78 ("tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}")

>> @@ -4408,6 +4408,7 @@ liveness_pass_2(TCGContext *s)
>>                                     : INDEX_op_ld_i64);
>>                   TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
>>   
>> +                TCGOP_TYPE(lop) = arg_ts->type;
> 
> tcg_op_insert_before/after I think are only called in these 3 places?

No, it's used quite a bit more in tcg/optimize.c.

> So after this patch, the type assignment in those functions looks
> redundant. Maybe you could pass in the type as an argument.

During development I had that, but it turned out to be unwieldy.  But perhaps that could 
be fixed with a local wrapper within optimize.c, taking the type from OptContext.

I'll experiment and get back to you.


r~

