Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F601E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJG0X-0003MC-OK; Thu, 05 Dec 2024 12:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJG0W-0003M3-7P
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:51:20 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJG0S-00016K-8x
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:51:19 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ea405aa7b3so607755b6e.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733421075; x=1734025875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQGfAFdlhsvYYkB+lRdBv4snwvviASPNn8cECY7bHwM=;
 b=sLGNcA6J6Jim+EtS0QwLEdjB+Wirn8VqaSM5hbYAZacO2Jq+izoVtoZX9MtX53Fhgq
 5xXA1rPu1dvAjnLrl5M28Dcx3PuFPyoQo2q1FqQ3Xlocp92FHjJOaDypGA2/4fk+ViWB
 xiOw3NFFtyd03beg5JqJmwd7VGdiLXi+s76mKyzbPAf35cP1SN+BhqIshgiiStBmWR51
 1YpkNpOKv1RfTnnV+i0QskUmm6EOlLOipW7EZ6hQBLul7GwwVITFhO3uotVAY+hHZk5F
 sMN1iI77ehbmYDQjJ8FNZ0R5HAGqOI0mtUpzTqaIL9G2AWATb97/X5MkZkr9VREKH+2b
 VTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421075; x=1734025875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QQGfAFdlhsvYYkB+lRdBv4snwvviASPNn8cECY7bHwM=;
 b=nQ7FleIuHcykRcvrCui4NbfJprVdWXgc279qdOIF2EQJtGf+vjk1kEV5P7MicRTfc6
 FT/MvDYSM3xNVzN+b5aF6DH0q5E1wo1Q8Z4s3Nnly8W1v/TzoOllJTDUgq6jc9/MggfM
 LYSZnB2HbHWCHHZdGqFtiBIQ7gfZhHe4lX3Foyw+zMCZC6MhwKkqQ1aQxUrGYHffUFGr
 8ZDLQod+f275y2/rBD1OEehaF8Rr5TQiXQKOpsMoEXrwDmADafLJC3w0nteYK3MD8y2/
 Dt6Sl5VMrSKqkgWPpfAH8FRvqtgIyI1aJfq0ETgkBDAbPDvcvwDQlX1W6ANW1h6rcmGQ
 bpuQ==
X-Gm-Message-State: AOJu0YxB7EE4Ri3dPkZDB8FOEbtlKl80BtlfMkMcpzToZ1T7wuHdsuoL
 vY7ApkIcNBOx+wbxo7OaI52OpWeG8DuYJoZvdi94x9fyRXXAQ7asugjj96Ew8Jn9ZvHe8lo/BB4
 sBVLEgtsu
X-Gm-Gg: ASbGncsTEv+v6B5iEDwWqJ0QlXEI/CMWnVGhUeSK2eV0uP0Ac0f3y/rrcEmwEUK7r7e
 DDqXwznAkwvgwVKC1QhxQx+BgcpeDl69FKWLrXFMcGjJn2gag8XK/yKXsk43ACyQXT+v67ce6F5
 6B4PHagy6efLTSsDurSdyIJhloj30y4RulPyD2+gB4+2xHcoIJVFExlKrMgW8eeX3PF+Bk446j+
 tiMgEXJ7GHnlXPZmaBHhWIDAnuDbXzeHIazcqNA2Sb0wvWTH+lk1Tz9xbZcIfDxAKhCvE/SDazB
 gOiEmdHb+uHgqhpkaSq1hvplNtBu
X-Google-Smtp-Source: AGHT+IE0L7UvsclMmQIlQaqKBZ5mdsX/mJyCOhsej5jvsdO6f7S/HsmAfOItLw7SAEaY4n7/W5Z7CA==
X-Received: by 2002:a05:6808:200e:b0:3ea:64cc:4972 with SMTP id
 5614622812f47-3eaf03bab8cmr5403288b6e.30.1733421074818; 
 Thu, 05 Dec 2024 09:51:14 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc495273asm369765a34.22.2024.12.05.09.51.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:51:14 -0800 (PST)
Message-ID: <07fe05ac-4053-4efd-9dcd-0e1f101e0728@linaro.org>
Date: Thu, 5 Dec 2024 11:51:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] softfloat: Sink frac_cmp in parts_pick_nan until
 needed
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-11-richard.henderson@linaro.org>
 <CAFEAcA9_HncJBCbEFb_804uZ0YCk18jz_9P54b74umWO8tPGSA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9_HncJBCbEFb_804uZ0YCk18jz_9P54b74umWO8tPGSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 12/5/24 07:48, Peter Maydell wrote:
> On Tue, 3 Dec 2024 at 20:40, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Move the fractional comparison to the end of the
>> float_2nan_prop_x87 case.  This is not required for
>> any other 2nan propagation rule.  Reorganize the
>> x87 case itself to break out of the switch when the
>> fractional comparison is not required.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
>> @@ -89,20 +84,24 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
>>            * return the NaN with the positive sign bit (if any).
>>            */
>>           if (is_snan(a->cls)) {
>> -            if (is_snan(b->cls)) {
>> -                which = cmp > 0 ? 0 : 1;
>> -            } else {
>> +            if (!is_snan(b->cls)) {
>>                   which = is_qnan(b->cls) ? 1 : 0;
>> +                break;
>>               }
>>           } else if (is_qnan(a->cls)) {
>>               if (is_snan(b->cls) || !is_qnan(b->cls)) {
> 
> Pre-existing code, but isn't
>     is_snan(X) || !is_qnan(X)
> the same as
>     !is_qnan(X)
> ?

No, since X may not be a NaN at all.  We arrive in pick_nan knowing only that one operand 
must be a NaN, but the other may be anything at all.


r~

