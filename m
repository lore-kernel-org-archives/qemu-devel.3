Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3638DCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 17:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9oUt-0003Rw-9i; Fri, 17 Oct 2025 13:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9oUj-0003QB-MQ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:44:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9oUf-0002KU-QF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 13:44:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-269af38418aso23705205ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760723035; x=1761327835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yV8ZwAdDIVyq8cR16il1DckZyK9t2UaBOggI8wORDCU=;
 b=tSfgupBtnc92GhpMR9vH2OWPJQcJBZuBOx/TjbFMy8rIyVeFuohQVG5NPX4d+M8xde
 1j7/BrvcqFkk4zs8ZHtFoEg+z84UnI8tsgSM5tPs2YtMKS1EKp12ESYoYfCTxbF++ezB
 Vl94ljYiCZX8cZDfr2OxCJvmIW1MAYgsQ/ZtafoQDyW8K/Ino7zK+YBAnM6u9AafG5aA
 yZa8N7uNdVJBS2YD+EjE9rfGXZxan8Uvszu7Pl6VEgNCHjaaFmEL1Tbl4Nq54GqfJRA+
 7l/fbiYQJrgJ34nAoRYZRe5BDuaf/FF1Q3D8Oox6XNqEsOOKyj8cd/i1TwI4rLps4PD5
 RsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760723035; x=1761327835;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yV8ZwAdDIVyq8cR16il1DckZyK9t2UaBOggI8wORDCU=;
 b=fR7lH4NNcAjrAZjM6FC3SI9u+Px1NSQbY50YINxx4hhCDjZPtLWVBZ0QHP8svRdgBJ
 r5X9DhcxnOTsglSYYt8g40mBRHSpa6+Izcpomq5NTEoXhT93A8K4UI8cQPdtc23MO3pD
 4vpXPHzcDSm1HjmzIK6LEsQUVi0k+aR8LzY8+0PdGtMSQ/iCTbGZ9k2+9rrMT0ZgJSoX
 mGvs7No2pR2o/9+wpqAVrADtPELbEfofZpJwENqtREisXuvxp6pO6KuqqgVWiX5THv+u
 KjKbKG+kv4UrMY2VWkAz/6nYMAd9eWr8gqMG8DZ/SR3qgaOOBH+KSrevLeskqvXxqjBO
 KawQ==
X-Gm-Message-State: AOJu0YynFZ/59PMEWIstRZK57Pasj0jq3TWYfBeeb5XSk+48lrfoQfHR
 ufuHPFqLbBZiUOK8h03c+EpemMHBuQT8Syg4igGaxHHzSW5HEMZAM1H6w5CTlCDeVfnrCGdMu6u
 L8alnlrU=
X-Gm-Gg: ASbGncvKS3T+fQCYwwD9ubgxQhISUMyu2O2jCAqTECkemLG41vNyBkS2RIHOY5QcObZ
 CeiDUAuWVwPaw/cDDLgdK6EJBlQIDHfAssYcnQaxnd1NFY74W053J3zCh3uYD/GPSA1ZrtjkkgK
 3upk2vC6+cu3uF6/YxdyjnjyjV9WR+bZ1XWkRpPhietnW5rCuZ8077YOr2z+46x1f8+RkRHvcRD
 r6UesrVB6DDaIKFwhoRD1s6CHUEZX72NpyPYo9xFKFwW5IO9mdnTNqjjpCGzGFUQosIjW//MSR+
 +s1HYUJq2yvaDjpPLRhkWEwJposWb15tdS6FkLc33jK9RxZVK7jh5FYGfCWvvNKx+j10eq90H/G
 ZoPom2K0VNR0GCKPCsBNTI9DQF7G0/VWZyXNoP7QdGUNm7UWUr7qcb7xyEn9agNdcY7JGYkB4ck
 09whKUagzY5vWOU7eF6VZSoGyU
X-Google-Smtp-Source: AGHT+IFhXlwL90OM63zNiQvCIEm2GKDZYgKwslFuLbdfe+JsDnJbIE8CakcK2Tdn3Te7B/0LovzRzQ==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id
 d9443c01a7336-290caf8582emr68041105ad.36.1760723035158; 
 Fri, 17 Oct 2025 10:43:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ffb815sm1132855ad.50.2025.10.17.10.43.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 10:43:54 -0700 (PDT)
Message-ID: <cf61f89b-ad0b-4d4a-865a-c71fb131e5cf@linaro.org>
Date: Fri, 17 Oct 2025 10:43:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] gitlab: use template for ubuntu-24.04-aarch64 jobs
To: qemu-devel@nongnu.org
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016150357.876415-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/16/25 08:03, Alex Bennée wrote:
> Most of the test is pure boilerplate so to save ourselves from
> repetition move all the main bits into a minimal copy of
> native_build_job_template but without the caching.
> 
> We keep all the current allow_fail and configure setups but do take
> the opportunity to replace the -j`nproc --ignore=40` hack with
> something that almost, but not quite, saturates the machine its being
> built on.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   .../custom-runners/ubuntu-24.04-aarch64.yml   | 230 ++++++++----------
>   1 file changed, 96 insertions(+), 134 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

