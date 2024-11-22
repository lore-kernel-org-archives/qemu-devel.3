Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E1EE69186
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEY9O-0007zf-2u; Fri, 22 Nov 2024 13:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY9L-0007zQ-Pr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:12:59 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEY9K-00026V-9W
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:12:59 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so1170076fac.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732299175; x=1732903975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UD8M2mQFVj+73QOQ1DF1PRhKrbDoq4MOxx29GkOAzPk=;
 b=PGvv1Kb5Sa7aj1TRbeRnO9QvTCeu7hKKWyM3IPB7WWrQO4ho9CPaUe1Lmjg/Uvf+Ij
 JZkPulKHonl57dl90wjT3/o2OzjNO3NQx7WwjiyN4KuQ606+f7pRvYS1IElHTboV93DI
 1YEWXYw8gkelzwzPVR8cwfp2e0rJjHxHwOKZv/Fh2lysWnBGsdVMg6xuzFjvCEvzD/iH
 AyNivc74v929XcjHV53b1lWoaYNB29l9cEKjUdqWBBCgWEGRs1rD4xb2ATW5O3MTFp78
 toLYBUxncoKwaYlTJq//8Y1ddVl47KzFfVDSTWc6oeSG9GTRBXVsB3rUAAH4w13YnTpi
 dAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732299175; x=1732903975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UD8M2mQFVj+73QOQ1DF1PRhKrbDoq4MOxx29GkOAzPk=;
 b=kodnti1xBz+ul7Kqir/380RudRmNQ1NyAxjHiblVfmYsoD5r+2ew08q8uWhSfBSWwh
 g3gqspAyn9sznWUcZW8Hpvs/knJBZyQT4TovGNk7F3h95Ow3ukaDRhBwzTtfhOMqcqPD
 kKvAa2dMFBkrR6HuZjt0sdCPEPD/vlL4sl441gI6XKVXdmpyCczvUFXAxTSAfiGfUCbl
 mccFInfaa0zEzTwfETe1nu20Nokvf1JyNMLc7gRHyD2qNlD8S22t/2zRMmufrRSRxqic
 cIb+Q646UwpbbxLa+6Na7C9qrpekttTTVcS8Tw81cYdnY5EgpBAv83HqW1ZoO7nQH7wj
 8RPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLiC6x4pt/g3p27VC7n6XD0+36pVNaVnbCVRoywG06dVzhcdF2mJg1GHjyEv3dVkh1YzoyArUcxsfk@nongnu.org
X-Gm-Message-State: AOJu0Yx3DpOiqc+QmYa6X9EAUxmd340Da/R/pIlp/WjKvSOiBZ7veyGI
 iKnSQB3ybKQMHFzvN9wR9LdhR/oYSBjDxT5mE2dIQnbqar+GME9cKY73QZxbGas=
X-Gm-Gg: ASbGncvkcHKa3f0FrMiZk3NauwqQtsSQa9zL53XRotst4w0SqSCQrsflodIRu0kp1sp
 Rk8AoWnW+kKAN5SoBI+oLUBGXvFKmn82cXJUeRl4hjeufdvJXXBnaQUvQDW6wrzJNEcQjZzI1iC
 ikVIGLbgKIkBSmEoC4HcRCXz59ZtKIRnk+CRzRYFLGQS5LrDjdAF96bYT5TIiJ+/0Itybw7KBHq
 2qmRJ1ODk9hDYZFvv6ODzDAbXHUxGEXnibvuhK6V76EnkovdNMbWMyfbo2qm/g3Her7YbI=
X-Google-Smtp-Source: AGHT+IGTZI859ZFRJ1NfyVye7tAAe9dCj7RnwmNL6mqX/VsLwIvh3ehWSFmbZ9diBnFyO0jd/8LliQ==
X-Received: by 2002:a05:6871:580e:b0:296:4be1:1d58 with SMTP id
 586e51a60fabf-29720e7b041mr4565269fac.40.1732299175421; 
 Fri, 22 Nov 2024 10:12:55 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d5e2fa6sm702614fac.20.2024.11.22.10.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:12:54 -0800 (PST)
Message-ID: <0cc41877-c1fe-42ba-9a5f-b84563f25ba0@linaro.org>
Date: Fri, 22 Nov 2024 12:12:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 08/43] include/helper-to-tcg: Introduce annotate.h
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-9-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Wrap __attribute__((annotate(str))) in a macro for convenient
> function annotations.  Will be used in future commits to tag functions
> for translation by helper-to-tcg, and to specify which helper function
> arguments correspond to immediate or vector values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/helper-to-tcg/annotate.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 include/helper-to-tcg/annotate.h

Is this really specific to helper-to-tcg, or might it be used for something else in the 
future?  In other words, does it belong in include/qemu/compiler.h?


r~

