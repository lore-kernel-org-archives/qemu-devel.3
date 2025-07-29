Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F1C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 19:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugqCG-0005WO-4L; Tue, 29 Jul 2025 15:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugo19-0002sT-W8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:21:36 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugo18-0001jt-0Z
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:21:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so6390270b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753809691; x=1754414491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o36SU+/RYcs46FtNHqIxijN8wE9mQm+I9M4/VJFNRoI=;
 b=V/onMolW9bMvtW+jzMOHNwqc4p+bejHq2blFSbyOcm//9/t7tthGUKa+3R66ilx+73
 d0kSomFCEvS7ejidaAhx+9+6J9eED49NQ+IWpO1Vqan1WuW0hEjlRbT3fuCIjFIPuwnj
 Zxxm+V/DkLYAETo05B90FItvcVSW/sxjRg9ugjYzQeVRaQuq34vuhb6I5aELebcUJJiB
 p1DmFaqjk52IdBdkdKOP0bKm75xy6SSzUjvx5WrbQuYd0B8tUKyPxhSHId8lDtlq33Uf
 v5feSv9EzCTTiQ/gWCErfXVJ/36MHz44Qz2XkQP69y151RsSFQvZxOH2jAlrgyw2UJzA
 gmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753809691; x=1754414491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o36SU+/RYcs46FtNHqIxijN8wE9mQm+I9M4/VJFNRoI=;
 b=crqxXt9tLiMgwQw2TbVYbpTr2x7gU6DM4HhIy5mM/A9Yl4shx2b1VnkbtLwqtgucxE
 EJReGpsDHMc3xFapB4zwmXsMFRrGkr7sVzTQ05s1lyTB693BKG1EylznBaKjZwz1VPA5
 Dg7a7GXwbTv6BupvhV0zlvj+54rPu1lTdQfyjvySW3UKkUt1tVP1pPjk3YDj+nrc3247
 7fadXZQx5pFZ0OLA0Hf6bF1peWlACqn17RACn+LDiWLzOJiLELEKvUwQJbOCOPcWn5YR
 36queRF+RKoTtPAayBhU4/txzJrLMP5Cq+RxbMTlpsPPiFsw6QsaQBw/cGWyJZkCtWeh
 GZgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAcWaU7QIWOyFMN6wzM6+Br3AZdZ+Lf8XoEKg2ZefmMg44iyarxXyfKIzTGDvyzuEGgl2OvB6QVDjC@nongnu.org
X-Gm-Message-State: AOJu0YyZWlSn3dNUUGT2jC4EWFMe211IlWQIY2TgzmnNK7fhm0jlz/g/
 UZVyCfwj1ZWTm6otGzR97NOgEmv1bSTsTxfHHBuqc4VZKabOxBaDMlOgmYOwHA8cExE=
X-Gm-Gg: ASbGncs+vDdc/QSo/BC7Z5uYQgfci3f7Y+UvIj4KTUWnK5Djrsa7tKgIFXwyXyybMWt
 MeqHtQfQyQn62n9YkquEhzNdXpSY3S+jwptaBada3Uv38JoYYWLeycYaN+NGBXUSi4FV8RI9AvH
 IGGhDtrNDi8dCGlLEKPmDhhRJsat3ybndKACOcHxCHE4ZUlQq9K1YcyEQNhL9DAZPuKGJhTgqbI
 6h075rklmclRAIABSorBNPbR+8fVK+6ml/p6z18/ehADVgkF1EQhCtK91nzOIySlbwVakm1QJnK
 Za0cswre5MyVGh999ulB0Is9Pkhvrd5Ju6n6TUZ08s2FFvCzJ5BnkHl9PX/XwLNq6mD0v4KARDK
 XTVQ0/UciKlulCC+gjjL4NZdIka+1OgcX2JlnlXSFuzkz2Ush3XM0jwS5mq7vIeyz81ZZMiHIJv
 D5lQ==
X-Google-Smtp-Source: AGHT+IFdcb0h4DkzNFFUajGH2uguiqxR1rddOR7PsqYQhVTcV6zxSK2V+xKJ4by02fSwsCepIPrz/A==
X-Received: by 2002:a05:6a20:6a10:b0:218:59b:b2f4 with SMTP id
 adf61e73a8af0-23dc0eb2b8bmr312783637.42.1753809691418; 
 Tue, 29 Jul 2025 10:21:31 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7642db46f00sm8306446b3a.109.2025.07.29.10.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 10:21:31 -0700 (PDT)
Message-ID: <c6265c03-1eda-4a5b-92b7-c70e2514b5c9@linaro.org>
Date: Tue, 29 Jul 2025 07:21:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/82] target/arm: Implement FEAT_CHK
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-47-richard.henderson@linaro.org>
 <9209927c-6c5f-4499-a3ef-1f4c70951ad0@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9209927c-6c5f-4499-a3ef-1f4c70951ad0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/29/25 06:01, Gustavo Romero wrote:
>> +static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
>> +{
>> +    uint64_t feat_en = 0;
>> +
>> +    if (s->gcs_en) {
>> +        feat_en |= 1 << 0;
> 
> I understand that CHKFEAT is currently only tied to GCS but will cover more features
> in the future so we can keep feat_en |= 1 << 0 even if it could gate TCG andi directly
> on s->gcs_en and do andi with 0. ok.

Yep.

> 
> It's curious that this instruction is tied to x16, it seems easy to use any other
> general purpose register to query for the features.

That's because the instruction is allocated from HINT space, which means that it executes 
as a NOP on cpus that don't support FEAT_CHK.  The HINT space is limited, and it would be 
wastefull to allocate 32 such insns, one for each register.


r~

