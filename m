Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFF5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTuQ-0004pC-7O; Thu, 15 May 2025 04:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTuO-0004lD-Al
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:25:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTuL-0003QO-Kl
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:25:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a1b8e8b2b2so355016f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747297534; x=1747902334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g4mIHRukfsyQLoTY2SGlesoy3rVSNICaN7xO6S89D40=;
 b=FuAzTKMF97+3Iu3+LX5w4olpXxQe1R5lv79zUNemDP8CDeEGcH0FM5HD9S8bSzevFe
 TEeuVPMw4myNg7dH4SXhKTof+sSuhOUbNNnOKc+YEnVYLXuAmo/yanQsYL3ONFMX4a15
 WmSObBJKKG9tyg9bSU+McGwClZDUZdg+IIGGKMDJL5J443HqHA3njPRSBJIDdleseWNh
 tv8AS6YVahi1afxKKbq7sim7L9Uo+E25IghEhSQNC4WxhpQLWTDUu1ls2xudBGSePwOr
 +Sa77Fd2PSji2PMFA09OAZmCWxKo2pvvgO5/ayoAv1W+Lc1Kf5e6tPjohWKX7G+y0oX8
 ztQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747297534; x=1747902334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4mIHRukfsyQLoTY2SGlesoy3rVSNICaN7xO6S89D40=;
 b=rzgK6pIo0qFQB8CS+6zy/xeoy4E/Q9OEpRtKaT3LBHEbm5AYKxbwpU/HOUpbCCPUfL
 uCP4o0QH2bKy7+foexLJN98J6WscCdihxwJrNH1gJ+G9SbqH6JuzNWLgqZ4H8umJZ6f1
 8w6f9tGr+382KEqgOP32S+BVq+lvN0Kr8aqMDJEYqz8Gp7KTZNA9zsQ+9kUsT8QAIjcZ
 zZpFJwGCxjqeAeYDDbh83LDVKcCerdeKEI0G/8WGeTmADT9eBiNjK4bSDfhHBoqLBL1l
 9lKIig9tp5trhAL+ZCu/16ATY1PWNGXIop6/UyK3M3gm6CsR4YHFkg1Q6nkmu+W7K7q1
 v4uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB2HJEvLHClmJRI98GakOj67pE7n5hi70nilpQF9DiumdiNIT2c4cjE9PQoc22D5xUPe6de35oldEF@nongnu.org
X-Gm-Message-State: AOJu0YxpP/XLyJBfjqA0LUQWDKwGJPqLheX1Gj0V3ynoGsYQFm5lw/IH
 VBnJXoRdtXXfjTPf8GIX+OWYggqz2JzCZvM7jVw/+rE0WGEQpn2DOmX6saI7DU8=
X-Gm-Gg: ASbGncsvJxjDaOnPSXFhWA0yfx/5Lws1oeM08ikTthkcGx2kco8JNSCaC+z0FqSisIK
 3GZ7lhf1vv+w32cUltSwxXzE1egO5MO8E2QOjXFPPnGSEQKSEeUYeqa//MV0KcURqB6mOBxY+iI
 wQmHzz76y9LESVyIh6oxQKn8fmokBO4Y7sKwA9ml6gcFMH0dfhx+k4jVZW0lOmsGosyNm94u+1p
 e1KfSE2f73w/03qZE6IX0CMsT8B9lxynESxM0ikxvjASp4e46XB+lv4cHPh+17dh4DOa3nRCApN
 YtwmXbCAXdplBLHN7mRYKG5KFBSdhJsMwqXFcYk6AednEtsQwOdLfqfcxTuILIhn6FM2CtxxwjL
 ynbp3Sb3pDChmy18=
X-Google-Smtp-Source: AGHT+IF1mvUJoJaTsvFk0wGDO4zhn0HDsm7O3YOmy5GtT1J6vU1/uEG2f6rO3zzRf6ahZG8Cv2Opkg==
X-Received: by 2002:a05:6000:22c6:b0:39c:3107:c503 with SMTP id
 ffacd0b85a97d-3a3496c2785mr5349154f8f.31.1747297531703; 
 Thu, 15 May 2025 01:25:31 -0700 (PDT)
Received: from [10.61.1.10] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f3369sm22258019f8f.57.2025.05.15.01.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 01:25:31 -0700 (PDT)
Message-ID: <be615554-04f0-456f-b734-a542db9aab43@linaro.org>
Date: Thu, 15 May 2025 09:25:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] qapi: remove all TARGET_* conditionals from the
 schema
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 5/15/25 00:40, Pierrick Bouvier wrote:
> This series exposes all qmp commands for any target unconditionally, allowing to
> compile QAPI generated code without any TARGET conditionals.
> 
> Based on original RFC from Daniel P. Berrangé:
> https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redhat.com/
> 
> v1
> --
> 
> - remove file qapi/misc-target.json (Markus)
> - remove qapi/*-target.json from MAINTAINERS (Markus)
> - remove qapi_specific_outputs from qapi/meson.build (Markus)
> - update comment in rtc-reset-reinjection stub (Markus)
> - build QAPI generated code only once
> 
> Daniel P. Berrangé (9):
>    qapi: expose rtc-reset-reinjection command unconditionally
>    qapi: expand docs for SEV commands
>    qapi: make SEV commands unconditionally available
>    qapi: expose query-gic-capability command unconditionally
>    qapi: make SGX commands unconditionally available
>    qapi: make Xen event commands unconditionally available
>    qapi: remove the misc-target.json file
>    qapi: make most CPU commands unconditionally available
>    qapi: make s390x specific CPU commands unconditionally available
> 
> Philippe Mathieu-Daudé (1):
>    qapi: Make CpuModelExpansionInfo::deprecated-props optional and
>      generic
> 
> Pierrick Bouvier (2):
>    qapi: remove qapi_specific_outputs from meson.build
>    qapi: make all generated files common


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

