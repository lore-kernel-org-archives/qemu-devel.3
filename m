Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A7DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfln-0003US-6a; Mon, 10 Mar 2025 12:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfli-0003TX-Ct
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:14:18 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trflc-0000bg-J4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:14:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so4788133a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741623250; x=1742228050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHZlYmM/7OKJq2dQEBV3R6C56jeySPBJUXFrBeW14Cc=;
 b=u/9QZsmRwwz7/gfVaLiYu/R3ybe30UoKc+cLxRFr0iQWXxGLRk2ApwEYJHYICVXyVf
 9u0t2GkrNlzOjddEHm8RgT5/bsTr4qNpNV5rcb4b3rTDTqmbrLkoPNTv9+27u53thufc
 WzSqT015V8aAH8ocdb7M7TVAZl1CGTlObP4sBLnjGRNcGa2b9h3yOT6VB+8EL5ytQmkv
 b/A3O4t4lBqOj+iwQkm8OtDLEaX8gX8kWo6Mls9EREcl7vHzFmoPczz0V6G7r0/6QozZ
 ldCrv0ueUxpmILPqDlPpVQwAAZBWnlv/Q2AfcD06Ox+INwGh7fxdIdCrVq8rLqIwaoTt
 RRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623250; x=1742228050;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHZlYmM/7OKJq2dQEBV3R6C56jeySPBJUXFrBeW14Cc=;
 b=l8nZAT+922at2qa3BYgVtN1pqz44e8Zy1fGlkwvIq2nbAMaPC6Hai2e3xp8KIC3/sx
 gag9xI/ozebU6IthTcnuHRxlnBGlYaL4GgFB6LTZbC0p7XH8FwzwqZKf74LPZTYPr/Ai
 UrxhX3QJoMQmwAtiNlSUoq5ntIv7iJSOthk3Yej+4moAWlnOG/npMlkukCkMQKSYK8D3
 bLrxW111LFFFnan5Lrz1TDJU0g6yUcn02nlH7pak1oo8IXpLzjDtylrGcsv9WTqwNy4I
 J28bENMKKWaAsc6FjWWpJIyFyXBF8oeB9YyySg4gSxwdguLAP9sZa0aVYXweTEslOyCD
 h2/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAZnj5sHTovpXkco3IOX6gmpLBxzIJZ+766un3yAMazcp0ig47rnner+9YV62OhxAshsQK4/Yjq5rW@nongnu.org
X-Gm-Message-State: AOJu0Yyw701AfR9fNHzmeHaaSi/sBiMNk6/V4G9h4/RmrNHrAFGQhPBE
 /mYSng+zClBaL1k76nwjuT+RBqlVPOYiR5ZmJoeNV6fPhYbMVsd0kcIZARJTlOI=
X-Gm-Gg: ASbGnct/HVEcQoku+8NPQgxA61D8hGWygELgMJjSbiKhbLjgNIRusVw+CsS4OuYN0WO
 1Z4KFXDEDxLyffmtunTuPkCzNZj8LgJoWG9fVZVRogISlj0KOsHqhElVeHCruBkT9popPNj+9Ts
 mNi9hUJcY4e15DSTeYiG/R8Xdx37JtECzPY0brIzi4/lS91wbaYOIFgcOABt/LbJ9H2bJqAFBac
 JM8boLq366wiAHFVIF/ej6hY28uzet3tphjIvx8y16wT8utBDDbCvrTjahnWFW3OF0wXymB0gMb
 wulAqd/JfpykuN5RrqxlDLT3VbldIer0OucaU9AAgRIpzn4Bd45gHpAM2w==
X-Google-Smtp-Source: AGHT+IHQxEV98E1DG95DFR0C95klUlNa9yEZnyzi/XiFqCM3t3dF/7rKOc3hAfoMEiOexAI1W2h1eg==
X-Received: by 2002:a17:90b:3887:b0:2fa:4926:d18d with SMTP id
 98e67ed59e1d1-301005a6be8mr84629a91.13.1741623249937; 
 Mon, 10 Mar 2025 09:14:09 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7737a5sm10125678a91.13.2025.03.10.09.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:14:09 -0700 (PDT)
Message-ID: <6a0cd17e-1c76-4b2d-b781-ea7f438cc4b2@linaro.org>
Date: Mon, 10 Mar 2025 09:14:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] qemu/bswap: implement {ld,st}.*_p as functions
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-6-pierrick.bouvier@linaro.org>
 <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4ac28725-33bc-4b29-a941-03784566d330@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/10/25 09:08, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> For now, they are duplicate of the same macros in cpu-all.h that we
>> eliminate in next commit.
>>
>> Keep code readable by not defining them with macros, but simply their
>> implementation.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Why do you want these in bswap.h, rather than tswap.h?
> They're target swaps, after all.
> 
> 
> r~

No preference on that, I simply added them to the same file than their 
explicit endianness variant. Would you prefer the endianness agnostic 
variant to be in tswap.h instead?

