Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DB3C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6Xr-0007FD-8c; Tue, 10 Jun 2025 17:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6Xp-0007Ev-Mu
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:30:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6Xn-0000zB-Pn
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:30:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso5289125b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749591006; x=1750195806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Y+R/4hfC6c7YmAlHIh0C+aYRoaI5jOCaK51LW7WwGM=;
 b=XKZcX2ezaqR+tq11NOUJc+ttfnrMgq7NfqQiZ6m4qxzSCa2Yzym+TBRYC3PHkg+lN3
 51N+MfVtM0V+TQs5GFCve0rARJG2Ivyt1TlwHIuOfKjlrMZeAz3XeBSgH8RrGuX+EELh
 IwDFn+27eq1t9ovAYQAJXNrvoFED0gL45NxaCGI1igB2DDeelXBEUgK4RhEavaDdZjy9
 UJM1a1x6DBwDnIUQ6vdPtPr7yUJ86ScskNdr7232iRfPBdYhtR9p5FyPoG9XEQLc0E5d
 FFWT0m5NTz+AQiid5sfPtVmMBwdHqOEs4yHOp2soHfeyBbaIRNug/9ib4qdu2AxX7Ocj
 Wquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749591006; x=1750195806;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Y+R/4hfC6c7YmAlHIh0C+aYRoaI5jOCaK51LW7WwGM=;
 b=djz7kTWnDfJRbQDIg5k+ZHXQSN9ozDNRKi2ntqJrafARQXu1gmMopsLTLARUiDGRwz
 dZzrCSess8phepMeuE6w/+va/4j2QxG1CQfemhnwhlSxXmH8kEkLXjCKCqNEFLa/JtNM
 FPLIxPeqmepOWaftJdrTNYulRkogOkFkXETJFCwBAdQJMHhiGi7CHamxO3IYHaWEfMuf
 OV1RelFTsEhH25LmhLNL8q0OqX94mBvoRsxf59WeEcjuAEZyu2z6qSYhyqJA791LRbxB
 pFETTRFokE/zvglWFsQOct8luGtjKg1aW5kHlKMhe2k34Oyu4hMsbM/gmjrl5A+3yjdy
 jfPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzpfV1Fr55Xljkrc9huJBVa3SQefTAQHs263/mQTnOiupvPJ17UPfzegDBnV709xF1Qful+aJN+gGn@nongnu.org
X-Gm-Message-State: AOJu0YzXqemIf+ohWhD9WP1uElCSmvMvqgnOU/yqr5hY2sKFHotyHSnU
 yYvbFQrJDEsP13EdkrihObHHX25BTkSDeAuKEc/+rsO2QA5IVP7HfOOYROjfrP+lNCsgUm6IxFP
 ZB23E
X-Gm-Gg: ASbGncvGYbseNwpDyZp6pHM0vWHQqHVAkps/RSZ/dNslZ9p9FqW6LKZ2LZ6rs66cVz1
 aQw7CI9N9X6ZdCtHkmA3bqvOrz/Gkm0tDUxVbASa5VY0qXpH9UqNCUZYukOn3n8vweiqU9RSTLd
 XHwJ+igdQMm+FHJfZzTJ6VtCLCCuR8dnem3/bdt0QGlVy33sp3Dm9JzeKyuz71VuRApcqKnW2n/
 NPUuBLIGw9B32SkCGqVZe6wojOUVxwtvMRvWsVdkEL6xXohThSLfozCX0Se4ta+41l73ga1v3zW
 6QXxeMPl42RhuAAOd26lPhRvAfpMwusV4WNdQW1SDVxw+zP3a4955zGHwKHJrqtGpHrKpZYRaro
 =
X-Google-Smtp-Source: AGHT+IH3YHHubumg2IMgGOyXmsAgs5lVJAMampfRfM7pUNmVe8gCu4cmL9c2FDlpAsE3YhOGw/+uww==
X-Received: by 2002:a05:6a00:3ccc:b0:740:6fa3:d323 with SMTP id
 d2e1a72fcca58-7486cbee3edmr1282889b3a.11.1749591006235; 
 Tue, 10 Jun 2025 14:30:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482af38307sm8144993b3a.14.2025.06.10.14.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 14:30:05 -0700 (PDT)
Message-ID: <6a25710c-f576-4892-a8f0-4ee64bbdcad3@linaro.org>
Date: Tue, 10 Jun 2025 14:30:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Controlling time in QEMU
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
In-Reply-To: <b3cef05e-8bb5-4390-8b43-914adca3b3b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/6/25 12:03 PM, Pierrick Bouvier wrote:
> Hi,
> 
> I recently needed to slow down time within a virtual machine, due to a
> timeout being hit because my QEMU binary which was not fast enough (gcov
> debug build if you're curious about the use case).
> 
> Currently, people tend to use -icount shift=X with low values for that,
> as it roughly maps time to how many instructions were ran.
> As well, I've been working on ips (Instructions per second) plugin [1],
> which allows to slow down QEMU execution by sleeping, as suggested by
> Alex. It's using a new clock update API [2], that is limited to move
> time faster (jump to future time), but not slower.
> 
> After looking at how all this implemented, I am wondering why we don't
> simply fake real time QEMU is using as a reference, which is based on
> gettimeofday [3].
> 
> Using faketime, which fakes gettimeofday I've been able to manipulate
> QEMU time:
> - faketime -f '+0 x10' qemu-system-aarch64: boot timestamp is 14s
> - faketime -f '+0 x0.1' qemu-system-aarch64: boot timestamp is 0.13s
> In both cases, the real boot time (QEMU execution) is around 3s.
> 
> It works as expected, speeding or slowing execution without impacting
> QEMU speed itself, which can run without needing to do any artificial
> sleep or clock manipulation. If a program in guest vm sleeps with an
> absolute time, it will be multiplied by the factor, which results in
> significant slowdown. But it can't be avoided, by design.
> By using a time factor big enough (x200), it can even trigger
> rcu_preempt stall detection in Linux guest kernel.
> 
> As it seems a bit too good to be true, time for questions:
> - Has it already been considered?
> - Any obvious downside I might have skipped?
> - Would that be interesting to offer such a feature in QEMU itself
>     (-time-dilation 0.10)?
> 
> [1]
> https://gitlab.com/qemu-project/qemu/-/commit/72db6d54a4a9203736261fc63f32f6cd3486b7e4
> [2]
> https://gitlab.com/qemu-project/qemu/-/commit/847a65dd76bf1868c7966a2b2608dcd00cb68dc7
> [3]
> https://gitlab.com/qemu-project/qemu/-/blob/master/include/qemu/timer.h?ref_type=heads#L809
> [4] https://github.com/wolfcw/libfaketime
> 
> Regards,
> Pierrick

Series sent:
https://lore.kernel.org/qemu-devel/20250610212829.2818792-1-pierrick.bouvier@linaro.org/T/#t

