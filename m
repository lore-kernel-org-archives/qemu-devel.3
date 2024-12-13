Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F23E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 18:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMA5K-0005Ur-9d; Fri, 13 Dec 2024 13:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMA5I-0005US-S5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:08:16 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tMA5G-0000rd-02
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:08:16 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216728b1836so17752715ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734113292; x=1734718092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=32K7dLQssYS+4P7/hRI0aZ38jcfbfSvmbhPnfFuI2VI=;
 b=WqfqgMBtkzK85+zgJRymuM/sqjDa+C9TQGcsXbmPbXizgtox8g6jAQadldFHM63WXm
 02lycxXou/d7vHQNdrqcEQ11LVs/BvSRjjlvkrM3z3Dw/iqtpD73fEdzEpNj09X2LJjo
 rxcYNSLS8h9QgUbj3VE1UWYInH03nuGD9UR8l3Zh6piBW0iMCZCdgbGQcvm8MQaq/o5A
 JMnprx4eqsH1fLDMvLXO/DLk2/Z/ExXDPqbvtj7m3jCIs2dAO9WmxY9kuTz2RgN0XU3l
 wGWTtZOVJuP/Eb2/esdusqVYl9G0Dtg5m1toIqibSJ+LaMlZ8gTU6cIlMAxK1g48Kkwm
 y2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734113292; x=1734718092;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=32K7dLQssYS+4P7/hRI0aZ38jcfbfSvmbhPnfFuI2VI=;
 b=CvX2gn7MzDci2AmWZvWeJQ7ZuGBNwfpAV7M+jqYtG2zZXi3U6qTwe2xr+GZpHAPONg
 BGybSlWCJ+7yhB+lkYJIHYec2lab18DecpNx/q5+iTZvJ+CNhbc88/mOzQn8UkcC6TQc
 708Viln9X9mERLBuriSRmorRZOfK7drCgClOVdgBwkMyokOfPXnjtUNeD90EuqGrk5Cq
 a4VfV3t9hUZczJqDQBgPBDVdUqD+X4tfaZSPQFzIS9SidgiG78lws+U29ZHPKvMqLy/n
 YRW/8iTuAa4gzbdK2r10GxEi85i4AGApU40TS0ZVDrcUh4zZmaG6FrR/or8Fs0Mn6s8x
 lADw==
X-Gm-Message-State: AOJu0YzWnqpfgGrliRMhrrljet1nX+RCLW4fYwdh0didYXfMeUnNTTnh
 etPk/toZvqqN2iNY1MvILI3ESfvZ64XQlOctv3LWqydN3uaJJoKYQ1SYE4WSShE=
X-Gm-Gg: ASbGncv566L2ZR1z4fhiBhg9Sf/5xNkorku+wJwXtwjyRb/w4bazunqP0pvJITm+Qc8
 gTFXKY7a0vU5woa70O5whp7J0ICHpmcJN4cwRlQOgs5RKqVAMOHsvN1QyNpbX4gxKkPm5z+gkY6
 zVWUIeNEYyn10LIKKdWx/hSuODgwp66ADxG9NFtj+uoW7iaxp2JanvD3xogH1uKeIZIDEPtw7sI
 XXDBhMg/4a8B0GkkRFeN7VX2AqMr7iEB2grYAXxJuG32fG25KzZzkNKnAQUrP6410b1PCgsBFNY
 TDYRCZJmJB3P6vByBTP9aevmFBvo
X-Google-Smtp-Source: AGHT+IELi90T2T5w4fUGYnNhmKL+wn8t6xo50LzYOQsdbB/wLVUlw75rJ4T6pDaFU048BR2YL3yllg==
X-Received: by 2002:a17:902:fc48:b0:216:239e:f90f with SMTP id
 d9443c01a7336-21892a588e3mr54978685ad.37.1734113292189; 
 Fri, 13 Dec 2024 10:08:12 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb0esm631825ad.94.2024.12.13.10.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 10:08:11 -0800 (PST)
Message-ID: <72ea263e-4052-4d57-8d58-24b56545647c@linaro.org>
Date: Fri, 13 Dec 2024 10:08:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Minor fixes for Arm documentation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org
References: <20241206192254.3889131-1-pierrick.bouvier@linaro.org>
 <CAFEAcA8TKyEJrPcNz3NOzv_LOkh9ENKiyMtBgDmH+xdEwZBqOg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8TKyEJrPcNz3NOzv_LOkh9ENKiyMtBgDmH+xdEwZBqOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/13/24 07:37, Peter Maydell wrote:
> On Fri, 6 Dec 2024 at 19:23, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Reviewed following things:
>> - system/arm/cpu-features (options)
>> - system/arm/virt (options)
>> - boards documented and listed with -machine help (arm and aarch64)
>> - grep object_class_property_set_description hw/arm: ensure all options are
>>    documented
>> - reviewed boards description
>> - reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/
>>
>> The Arm section of the documentation is in very good shape, and this series only
>> has minors fixes.
>>
> 
> 
> 
> Applied to target-arm.next, thanks.
>

Thank you for merging this Peter.

> -- PMM


