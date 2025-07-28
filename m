Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687B9C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 22:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugVwp-0006Po-Q4; Mon, 28 Jul 2025 18:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugVwG-000696-CQ
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 18:03:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugVwE-0001wR-Ix
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 18:03:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d54214adso31729125e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753740197; x=1754344997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RNIcMWrT77lRSI5yJdux4FBr4DfzeqIMHH1qpDmp+PU=;
 b=j4vyzPatsh/MOuzs36afsYeEaeRxqdvxuLN9kKUO99iEcj2AwaHSeDDXuNReFFjfxY
 dI6B0S9yJw8LJl2CM5xVhMbtmxwP2moNyFKI4uEQ5BiLikOI5Trra+VaOIUcK/J9bZAg
 Sf5sLW9Mqf7RZEpDccb+HFTxB9uqUutYoeQZg0t4oZETJJXMek/fnV3OXkNiRC8qFVBf
 g42t4Va1xcm3nkrrDRQZjXtj8k1MyHrylYK4XoCet7BmjJ3QfA1pEZZ+mc8tg9NR1pdT
 AtTK4a78vwa1x/OV3FYpZcvrinH1WBSSYYPRYkVScvOAL7dH7wmnRfPX9j8YkPmBxJPM
 LzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740197; x=1754344997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNIcMWrT77lRSI5yJdux4FBr4DfzeqIMHH1qpDmp+PU=;
 b=WS08YDqyLb6peJqSFawI3Ait7PI8RzmlmGS1PkyPhcWqQhZQ0cyg8htVTMD2MY7nCQ
 J0xlAnf53zrPjSxPqgITVw7Qz4g4ceGceX3qa4qreBr3Pf+b5bwdZoswkLIU1ixc6rTy
 qHJOn9XQ7sbjelndp8WD2D6UGNkcNrLMExhH9LxOgq8qk3mDXem0Nnox1q3PF72Z7iSw
 4cH0WzrsmqJl3KWagbA+vj5vT4/yDJ+uKs32H47imnffgoXfmLNF2HkfrkRgbAD7/0zm
 ZSqbbJbmhcYb/91YjTnqyAecAj1B/KYWQhLUVGAy1YUidkYgcTmVIoreKCHHqGLPq/hR
 OGAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWARRI0lRi0HsuQspjtGBJHlT/ibmic7PoC8279ub8IacrWMiTAW4MTOf59uTpFSQXVEm8HEZpUQDaq@nongnu.org
X-Gm-Message-State: AOJu0YyUlZW9v0KwZYbIek6rQ2uG/ApwISB1sykuRo4CvUNXQPTshW59
 dvgocwtvXH04TWOzKAeOa48NJvSboGQez4Vc+tUPWldhoylh3GHS6wkWbvHF37h12qsplfETKJX
 nx+34
X-Gm-Gg: ASbGncsB0gERfqYghO6EXTRhwuDXNPGNmvjxx60lBSuJQtPhIBnQrws9pa0M80K731o
 qIPnit5d2Y3aoJG3AE60VHmGOvJNV+XjYb1VDAlT2JY3Hfit8rqoCVIKFStiP6xv4YzbWGK5ba2
 8o5dNpfOdthO6KztBIiB2IhLncJ1cdthQg7gMhn02JxM5N3VuJKPP5crTVTlfVP+h0ESYrK2nRo
 ocHs1b+EFrcO06yIhQl1AQON+3ONDf2RgDLW0s02tv83lRvSds66KLAgV8VaYm4xdyUY7PH7S+F
 3GWXVIydUp5sSA6zpTHgMfK0CFeYrcCVuOmEc8BwOVz3SAgmKaxv66GSYE1jdogQFbadhUc1tqQ
 kJbo4pPTMJjywX4X1oUaIRofagV70JuLLnNO0sszGl9nBgMDF2M/y4XyJo6FafpPMEQ==
X-Google-Smtp-Source: AGHT+IFXbprBq/nqvVOgW0TQZTcZxJT6uBqAu5FR/QXzaf3Ftm6UCd9ha+8+mUgcBdzxbAhoHz4Dow==
X-Received: by 2002:a05:600c:1da8:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-4587d83d6a0mr86970465e9.9.1753740196915; 
 Mon, 28 Jul 2025 15:03:16 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac76b92sm109791715e9.32.2025.07.28.15.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 15:03:16 -0700 (PDT)
Message-ID: <09452c14-9ca6-4e7e-9a57-a71e6c24c84b@linaro.org>
Date: Tue, 29 Jul 2025 00:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
To: Adam Williamson <awilliam@redhat.com>, qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250717220207.171040-1-awilliam@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717220207.171040-1-awilliam@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 18/7/25 00:02, Adam Williamson wrote:
> In cfcacba an `error_report` was added to this file, but the
> corresponding include of `qemu/error-report.h` was missed. This
> only becomes apparent when building against Xen 4.20+.
> 
> Signed-off-by: Adam Williamson <awilliam@redhat.com>
> ---
>   hw/xen/xen_pt.c | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks!

