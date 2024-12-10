Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD69DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 22:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL8YZ-0000dt-Mn; Tue, 10 Dec 2024 17:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8YY-0000dl-3N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:18:14 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL8YW-0003Ew-MY
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 17:18:13 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3eb6210742aso56235b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733869091; x=1734473891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vl20P6btBfBB9m55zw6VNnWmkan8dZFdndQSrABbobk=;
 b=wK2iqjNdvX9kwh5AQGDEWChTpjig860SeLQ10M2KlFE1F6/kzju4K2UX/5GdFLr8E+
 2JiRHAAatN6GwoiYa7CerlvT+6RIVfHG5o+m2Sy9jLu/wQZcgBvRCnzi+VTu0F0gY7/2
 /pgjhj66xGH9GnBFQuQQNYBguPpU6CCIbRFqoLQBP0q/6BV6zELsg8ePyxFcYT6dGugX
 ov3Uck9Kb6Ip218HGUxXBfJZ5+YTpuflCrnF6BkEXZh0m8L//AsIUftmBWIpy9iudTLO
 imTIbWPFvejapsue22Vgbg2D+ppm5wVu7flPBvYEFQz/keA41no+6H8MJzpl4hCHv4bi
 pjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733869091; x=1734473891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vl20P6btBfBB9m55zw6VNnWmkan8dZFdndQSrABbobk=;
 b=YEcEiKNjGh5SqICoSdZdDUX0VA+Pn2Y3zy0I/ezrrXoGGXqyP6PTcDfCprwjkd0hJr
 boWQ4JNfhpWRsYY7aa9pbeWITdrNEzVN5+rTBENU3SIFPQbvdA9T1e8RhFXwLBu3QKbD
 jita8hJqb4dUABS5B4k76ohPXfmfL9+yyqwMEJicpkehQcAwYps0nOnepvWd2v2W4Trp
 w6LUH3gjtI2xBCmo7h7hSUfOkYyFj74L6/JdAlaENVaqkHK/KWamUgKowK7uRJ0cKdYO
 daB1yGEBU5/ldLisSx8L/V9V+cgvxoP9icf8OFQt5MzNiUuPYiU9XH7B5Bbk3/C1tgb3
 dGLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/c7VLRTa1wAbg+Y3SEd10RHUd/lnDkYLyRUXHE+b94ZtBsyH7MnQN6/+uIzFaaOmWTIU8EzH8+XLu@nongnu.org
X-Gm-Message-State: AOJu0YwxzBlJc8F8ww7oFqRXy5a0Jw97yobRxz63+3noElYdcI1ukiw7
 Q1vDpXqnzKwPlwWygxcwOUK7wf3ntjig7VEXCCVzr9phVxgAN04jMehhd8qSbc0=
X-Gm-Gg: ASbGnctK1QHkG14KxODHdXPGL7iNxaPdQkcmMJnUehil0ppuRVxZKl8a26wGLZDA5zE
 gMabvTqBh8/vpamfqC5iVPrvLb4Ez6BCpyzefWoa3ndYYGPjhvoNAGyyl/DzwA4dUUKNv+RBtWM
 YVMzZvfNpl39yOeVrhrS5EGThCuiGNkPJ3ZTAy1/FNwPm1a92gPJl1qtZsR2SrcElZdSIPY3k6c
 DoARz30zpoVA/BYdlbMbIKF60XoSb9Hg0Jx0GjcS5VWhDiLGrTifPRGhz9MZtepQRQOMfWW266P
 X+tEJ0qAo1hgPiP32ID+XZMqczDf8zJ8
X-Google-Smtp-Source: AGHT+IG1LKDzhb0Xj/ad1TQYmiEcrISER4yHVW7yMFvyfeANr6LMGFZzzMQGf4Fmibxe4dPk/s/wLw==
X-Received: by 2002:a05:6808:2226:b0:3eb:4292:e6c9 with SMTP id
 5614622812f47-3eb86a34b80mr217799b6e.2.1733869091252; 
 Tue, 10 Dec 2024 14:18:11 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb4b26c93asm1446207b6e.34.2024.12.10.14.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 14:18:10 -0800 (PST)
Message-ID: <37c01f87-dfba-420a-b254-aea801a40ed8@linaro.org>
Date: Tue, 10 Dec 2024 16:18:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] tests/functional: remove hacky sleep from the tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-20-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210204349.723590-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 12/10/24 14:43, Alex Bennée wrote:
> We have proper detection of prompts now so we don't need to guess with
> sleep() sprinkled through the test. The extra step of calling halt is
> just to flush the final bits of the log (although the last line is
> still missed).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

