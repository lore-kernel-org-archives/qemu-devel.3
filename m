Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A26C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZcQ-0003oo-73; Thu, 01 May 2025 15:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZcN-0003nU-Qi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:30:47 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZcM-0000mT-CC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:30:47 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-86135d11760so111872839f.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746127845; x=1746732645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Hb91IPuLXKJoQyP6cAOpZVHX8T71l5f/umHeyLbAqA=;
 b=jvmNwTBiPnrV5Zsn6bop+nt7vg4R10B8cwx6Zj2ujYsvlYomj89N9+KdlV6OXpDSsi
 EeWjNuJrSTjl4m6v6wtsFHJpmtgIEVinImF390gxTZXz3Jv8MU2vGGtbYm9Z1U3fh9yV
 qglDTo7joMKAm52uPLxDHjzeh8KQtFfAkDYtIJB3b19DhJOXSOvVsjtjui1Tob1EPZEz
 HP/Ozma3HKUsldgWrUGHGPt4OqOEZKQ8NgTqDCC4e5CmCXLc8OJKlH9ZmTxeArDi1kXv
 Uscvxh0s2ka/R1Q4juiea6J8BHrr+er41NgI9Vrj0X55AMjcEx89iOYBOM0IU8KfP2Rk
 Xqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746127845; x=1746732645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Hb91IPuLXKJoQyP6cAOpZVHX8T71l5f/umHeyLbAqA=;
 b=YkJt+plS5aZFdKmJCy/qbc1nQya2vYlCsA2NaxGS5rFruoGrJaUb9BPuOsTfRN5wT0
 dZayVZqp8CFjr3HuHL9I6CAk1mn6li3+aYr/OyIi5jrem9nDoOGIRscphEVSHcnXWRcz
 GwAbTXagYLYkfDJojNMGdNpEXjrTcaM6RU/7VPaHHrwFx5ja0oar8/2oWxOfJ5Yu6mIV
 qPZPd+9P7aNdROiYXkpEBb+gkaQTAYsdQ0ToOPVHD9wjxtEbYOyl4syGsonV92C9c3TG
 FMHUsZoIZKQkGUvaYGEE2OvDeTBrMEhPETNKmBIxq+sKWve0vQ8858B5HaVFREHrAbow
 OdNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNLPG9a1/UyWua9KTj+ExHyhC5K5g15yiOzlI2EZ3JDmE3ymE+xdbAdZpW2Yijycy/Ike8NTXcBTHu@nongnu.org
X-Gm-Message-State: AOJu0YzuueDhHwGcirUKqFBnWt3Hjv7oCGhWHOsnxEZt0bP2KftgDfu1
 bFiNK5fIhFnEU/pYE1jTVSHuIxkTic5kwimg+OrTxTJw4JvN5u9IaXkbMMtR9zs=
X-Gm-Gg: ASbGnct+P+k8o6mR2UcE2EHdizMjSQU+PKcOuIqiw3eTWWzc6tjZcK9wkbwf411KNMf
 sJEEd7LGdLJKnQTTttdEJ9Wn6q6TTBPEh+9xvHdb5a92SOuNW+F+4lyCo6QLKyBORrhQTGZS7Zh
 rODe1k9CFtLCeWVddM30+fOnl6A7HbGUpOL4dEqWj4B3zPelDS+8XPvnzBCVKEKW8pL4z62dh+m
 P5u36Nw57gyWK44TxaFVfK5dhTm7SlQjVSccAcTl888hwB13IkF4PQjs4zuLNI2i7g8R2vYCKwg
 6CP8Xn7eaMLf+Xuc8tq5wbux4iw1VM1BXiLa2lVCxeWbZKvaROe+z2jq+RzYLBWy576ellF36CD
 F32fBROLMEZG9eB/JXMrcHJOB
X-Google-Smtp-Source: AGHT+IEGwirHslwhuIZ9+rShS20f1JaFjO5yKz5qatVFPhxgLt8HRbW4UFj1Y+LjXp1SbZ9We+Nlvg==
X-Received: by 2002:a05:6602:398b:b0:864:4a82:15ec with SMTP id
 ca18e2360f4ac-8669fad4facmr76490939f.6.1746127844964; 
 Thu, 01 May 2025 12:30:44 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac7f4esm8058173.136.2025.05.01.12.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:30:44 -0700 (PDT)
Message-ID: <91c5f1ac-105a-4567-b1c2-e1d230d8cfc9@linaro.org>
Date: Thu, 1 May 2025 21:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/33] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-26-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd32.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Associated code is protected by cpu_isar_feature(aa64*)
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/arch_dump.c | 6 ------
>   1 file changed, 6 deletions(-)

Should we assert() in the callees? Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


