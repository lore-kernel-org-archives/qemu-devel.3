Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D857BECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1zS-0007HA-5M; Tue, 10 Sep 2024 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1zP-00078f-WA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:37:08 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so1zO-0001r2-7w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:37:07 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso975376a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979024; x=1726583824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9RlGtbBGyYYZ5pNAkXiiC9Pk+QpNb/DlIBkwLE1N54=;
 b=iH51bhyF2Yqt+qe0DE8lLX0uIaycyDdH+HL1tCB0+1y5sPq41n1eU8a7fekmwGctA6
 2X+DYf+pRJHSfVzb5xvF1AH2FtZvNv8VlCMvUJe3E10ErMRWP8c9cxETAlkzxepL0akV
 6IQRT0XFPLsR9E68vO8DY2yWPXl1RFkQ2mT2ouNksY/pYTMA+QZoz8iV06oeObimvmt3
 +HisBnUCFhw4KTEFyX5jOTXdCytCKIFFCBPRqJwAS2cEEU59hfiF23lVFoS9tufVAm0C
 EmULA4sZv0YSzZH8bfNOnSGqS2b1eILD3Msr40gU1AlqRe1sFlmcF4l1D4f8WkOMNvKF
 5+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979024; x=1726583824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9RlGtbBGyYYZ5pNAkXiiC9Pk+QpNb/DlIBkwLE1N54=;
 b=R2+/Su0JHMNgh1dP2PaPJQoRESIsTBoAW+6vnuLLQCe5bVT9+m2QnPJMC0v7lKF7DZ
 3hRMlZxC2Lx65uQF2Vj0g/kkxQ6nJSyK9gXli0PYl2S7beVrbXkGpYhTAuMk7wSVPsVO
 fLNKgYpzHNqaMmeqPoqTl0Ko6gHTI6PBpMI+mZUYqkHQLO1ebNT4PGneooRNv8Koz+Q+
 rX73RvAe8u2Dg+dNj0r4uCg3xiRpJ+5JiiRsYmflnklHZUqZF2Zkqj1rXmQt47sBOVih
 lJW7bn7vlX1DtrN9ngeL1iXU7QqAwOdnjSFjbV574VSgFD72fYBG5196e5OZK525NNyt
 musg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWatO5UBhpBYtdU5C4NF7AY/KBXvOYR+OKt3FwJ6ErEOF0U1Xz7sCrSSkosDEgRoLkXKX6JPmWT4SUx@nongnu.org
X-Gm-Message-State: AOJu0YwDAFHj9wW+LksYZrAFVGxcf9Z8xfK1WElZlq8Y7rOIvqid2bOy
 E2Y8v/QzQ96OCBJ0uzUOE4IsTLqL2oXJaYkYUkid77PKRS9hS4Zi44QHO2Nf+Oc=
X-Google-Smtp-Source: AGHT+IHiIbIr6cf9HjC2wWtJ1TfPcrlkSXMk7yvH5Ikott62A6jhPLJnPzrWjAZR6vGWFx6uPeabVw==
X-Received: by 2002:a05:6402:40d2:b0:5c2:7727:6109 with SMTP id
 4fb4d7f45d1cf-5c3dc7c6f21mr10841461a12.30.1725979024338; 
 Tue, 10 Sep 2024 07:37:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebce3448sm4389142a12.0.2024.09.10.07.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:37:03 -0700 (PDT)
Message-ID: <9b5a53e4-49aa-49b0-85b7-11482deea2d0@linaro.org>
Date: Tue, 10 Sep 2024 16:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/29] target/arm: Push tcg_rnd into
 handle_shri_with_rndacc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/9/24 18:22, Richard Henderson wrote:
> We always pass the same value for round; compute it
> within common code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 32 ++++++--------------------------
>   1 file changed, 6 insertions(+), 26 deletions(-)

Per 
https://lore.kernel.org/qemu-devel/c3b1870a-6939-4470-92be-c9a4ba0c98b4@linaro.org/:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


