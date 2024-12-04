Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41345E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIw0E-0005XW-OB; Wed, 04 Dec 2024 15:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIw02-0005IW-AA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:29:31 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvzx-0003gA-6V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:29:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434aa472617so1362085e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344163; x=1733948963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtLB4CHtN3EMKTvfZ13tIQ6jPNgFO8tgEUT2dy4RBn8=;
 b=fHHiOYEp9iv4eeNlD8h3FnuyXuyKaBaFnJinMjus/mPf0B5wp4ymUBMuMlZ9ZvG1fE
 E5D3Id+VOBX20D/Jl95T83bfmJ97h8R8BFFxEWVWDMaRjXEE5TzA7a9e1a2VLWnSH4GX
 XRAIgrWI6Hs7RGhkvRqbaSXBquptDQ8iRbufFH/hQ/KaZI/otnoFFrY4nqOLALTVt2q5
 MvpIK3a1kHK3uUbAo1EVOx9Xko8Xt5OMir5X4Rlv4iDCm2+b7aeOmnzw1mHBl+jYQ+9D
 gJK0vr1iEWxOlfVDo6HF2jEc2qKmOQEsBsZShBFRNjqGJ6aaieBKsgFDyZyFQqWxxdwu
 jt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344163; x=1733948963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtLB4CHtN3EMKTvfZ13tIQ6jPNgFO8tgEUT2dy4RBn8=;
 b=N656/sVKdXa/HfjiRV62yeX1geYL8WSivzihb5amzWbBx7qmHImEasz3+DtwtdWKHh
 q8x9LLv64Let8kuNWpZMG4E/ON1x2w1E1X7V2CuVhF0C42u1RNv5TxelNB/xFNgc1ugW
 AtPl0rI0tenicb8hsAHgANqSAs5h0T4S52ye7Os2amVLoXmqjPDcSkJjkR9MqYh4QTSy
 v1DUBhvxESJDjtRZbz2gUZDVSFdzedOhn5AekRrDx+eBv3oJfZrsn52Mn/iiejzUB6Vd
 11VSaYN2IS+TZGHv7M1IEIiQJzlMLhFCrqXQ5GQymC11SqrlGg8KFdUXmIh5axgrYvvQ
 x0Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTrfvOM8KpQPQcDOsMrjfHZ3PMp0s6TmexwyjEB526MSRVva7mviIowsKGKMZnfe8OmOSwYxST4SQG@nongnu.org
X-Gm-Message-State: AOJu0Yz7l5Aw1T0hcxs6RFVCHPFgJNYCvdUZCqrodXxwe0yAdTE4SW2F
 /StcMbIhOIKhCumid09D+I90+l92V8icaVt2qwbKf9wz2L1tSaMMW84tVT6JBK8=
X-Gm-Gg: ASbGnctR6gzfPgPxhN1F9CZcRK3nyEwknw/ttDcwAz2BZTk3cRfL/J/HlMgzwIAgbZ4
 pW5mf3FcfSDSpnNUdOFLrwJFYghVjcBL7/YH4tD3syseJDhu4dN4BnfxKdLT7OKpwlAoETCFhmb
 JnOpZ8Qz5Ok/WrPeRo2U2kLLK//qqlYhuLXfYd0dBST9z6SEceGJ7kTpcLlPWvOfaIfYAikVg9N
 gfXtEY18y2DICdLS60hpxRWLmvd4WNnAMEgxf1qZHkp9gEdWsihzwmA6v6KOefGl07kPwhdOh3E
 COfLWB3nH2Qfx/u1wA==
X-Google-Smtp-Source: AGHT+IF27oJ6ZBQWbyrsKoV1xo7XPqL32PmI/OtbA0a3nCZ5zz6kmohFVn0752qwrjlnbiPtUcMTnQ==
X-Received: by 2002:a05:600c:3ba5:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434d09b147fmr77918635e9.3.1733344163615; 
 Wed, 04 Dec 2024 12:29:23 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b312sm36761735e9.6.2024.12.04.12.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 12:29:23 -0800 (PST)
Message-ID: <a9d0bbba-1a79-424f-94aa-9d20732bdc76@linaro.org>
Date: Wed, 4 Dec 2024 21:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] gitlab: purge build files from cirrus CI jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241204194807.1472261-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/12/24 20:48, Daniel P. Berrangé wrote:
> Uploading artifacts in Cirrus CI requires sufficient disk space to
> create a tarball of the artifact files. IOW, whatever size the
> artifacts are, double that. This results in space pressure on the
> FreeBSD jobs due to limited disk size. Purging the .o files from
> the meson build directory reclaims significant space.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/build.yml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


