Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ABCC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 06:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujXsS-0001jo-Md; Wed, 06 Aug 2025 02:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXsR-0001it-HW
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:43:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujXsP-00041F-QJ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 02:43:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-459e39ee7ccso11247835e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754462632; x=1755067432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RJkzZarT6XRxBPDw0ufSNroq79gdmfHXX8Fpt6gHlJ0=;
 b=qDxrXul7qPG+S9N+rY42H5+JUTxcM1e2KauvizG37xteIpJwp5j4hUgV52RdH8vdre
 e98ET54NlCGX1zAnwKoXJY1/8wVTraPxMXPrT1fA9VFRDQvVpEyqLtaYQzQ0QX5ew4s5
 ie7r+5+kVioqrhUEfvq++Vs1k7J6hriZQHl8IRdqiciDpftcFGAzFljK5NOLOcIaK8tF
 qMZotxkN98UZJdLMa2UWTbyE9C/yoBQl+QQiZPCH4u2T0tI+vDgQkLG6mYfWCMHrK/Q1
 D2mMKQozL0oSx626k5XRB4bz0c3+joTIjSJ7fumz8U57FFq1uujb0q8BOZNdgmxaQLyv
 Ci0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754462632; x=1755067432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RJkzZarT6XRxBPDw0ufSNroq79gdmfHXX8Fpt6gHlJ0=;
 b=B723PdxMlEaWyfd7pU6Vwf/0Sa0ymWqlgHmDLjDBUlu2F2igWZr2UBfyGCVvXc84OP
 QeDbZEsYo7DsA+fCrEotZUnV95+Ppbx8mCJl/yFbsh/J+WH03odLrEjKLpCUysVtdJze
 KiUCaSXIW1y36Z/NcRQLkWZ6M0iovAmAFY9dkL21lZ0kfiiohzaodkKqxk3tbSaQsktp
 R9M8kiZCcQhIfYCI2SLECgYtck3yT5liIIH1ylslGSGHqjYLU48OXE7XpWRzTl6ENxWM
 qWOlyDPOXJdaY3quEo8YmEdPmzTEqwLy+60uySrGxgzONJNnRypiBhFlPGyUndW2+02c
 0/jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7/Jv3TUcumym2Sa2r6R5eyinBdWxIp8+AD9QrfwWYpwPVRa87I0yTW7SKK+Oqf0rXb0x+fXS2IYui@nongnu.org
X-Gm-Message-State: AOJu0Yx0K4cFvI/PoecoLYzthiBqXdHY7t8umnfdLtEzHCGDlUb7mxJ4
 +xyPI4x0mYtMjherGm29XKQkIBQYWd5njuuqaoQfB+xZJz5kP2ljva0nVuZyvqXy++4=
X-Gm-Gg: ASbGncttDZPqj+eYSCweFFyfBbvA/meQW5j0/a3ElKU4ZRLb0FCaf54neBR3k5CrxJG
 7EqKqFJPQ+aOykHNmzC2RrbbtH30uiAxEjFVEQoIqg0GZjZVWk/8MqbQSkW9VhmzW8TzO6PWUaC
 yAiRNBgFjR/ua+lH3B/+mqf2cxCaqUTZA+P4FvZbP/0osodV3zMpqbbo3PrCVrQeosrSe8DIeZu
 UtnO1czCYqyvKjNBnWfAe5qwCcDFhZOh7ffgt5PyUZFgDgqt+fb55YT8jRA1+vfWfPBqj+Ul3pE
 meb3YDGK7eHxSVQ7cRa8y0Ty38mmb4UYglhEWjQMe81MwzdG8TicZLle1nCQQ97uQ06tVz+m8D8
 ffIwreXiaDToq/y0kwtBQTKABV4W1N7oU7qNgDScQk0ZZw/Gcr+xHQlnGvf1yTGWfy4aPZgSlO8
 4W
X-Google-Smtp-Source: AGHT+IH6kpaNn90VSwZQwbghT5skhb10CaqFYUpMmBhEF1DeAXfPtsKJ960XxMeeo3zx4egOiM7eOQ==
X-Received: by 2002:a05:6000:2302:b0:3b7:8146:4642 with SMTP id
 ffacd0b85a97d-3b8f4166f59mr1201882f8f.20.1754462632239; 
 Tue, 05 Aug 2025 23:43:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453328sm22884745f8f.46.2025.08.05.23.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 23:43:51 -0700 (PDT)
Message-ID: <4b1ca922-e17a-4cd7-894a-f0ac758457d5@linaro.org>
Date: Wed, 6 Aug 2025 08:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tracetool: avoid space after "*" in arg types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250805200334.629493-1-berrange@redhat.com>
 <20250805200334.629493-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250805200334.629493-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 5/8/25 22:03, Daniel P. Berrangé wrote:
> QEMU code style is to have no whitespace between "*" and the
> arg name. Since generated trace code will soon be added to
> git, make it comply with code style.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/tracetool/__init__.py | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


