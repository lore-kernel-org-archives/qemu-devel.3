Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493DBC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6zX9-0007as-QH; Wed, 16 Sep 2026 19:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zX7-0007aF-IX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:59:21 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zX5-0007yt-HF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:59:21 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc502a179c1so175526a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789603157; x=1790207957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=716cKke/AHRxrgBZLffY7OITtyjFnDtcLFhFF1jHUTc=;
 b=wycehb8NFQACUzYxWvm06J3JNk43Yi2/xj971WIAfvbgO5iPgPIVy+qrnKpAg2Xo1j
 b6Fu7o2IhyJeSHvZQowxJMUISveWddutBTZITCOVlrW5DbDBv2wEvyXMq9L5bZG4OvqW
 hH6M0UYBI28ITN7gAUthEcPGVVfy8icUL1lGgexEqobqW+XcsYp1so4CDohUVy7aWDsF
 eQ3W9Jd2d/qCH/ECfrhp/TUtSwscR9edB1AkK3wxcK9ShRKmz3IBF11bFoV/KgsxISQD
 lczCHYQdmdc4jHgM9spwdlYJJSNghr5h2Md3Grnfzlw5/vWLizPGd7wUWIQZ1AIIpzxA
 6ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789603157; x=1790207957;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=716cKke/AHRxrgBZLffY7OITtyjFnDtcLFhFF1jHUTc=;
 b=ov3zX2u+wZb5Qz6yzLPKDh63r7HXXJDOnviukhakUFCspC8gUl0eCyN0uP0hHdcbMO
 JMYfEJ0ggn2BPecZi6NFCyYHu0SSMtJW0tHpA90j4yB58/Oom+Rbj1BkXPtPukRGWlSg
 CGZ6Tnv1IenlZZ7N1rov2I270w280pxP7euX6Eu1hsjsVa8XeyQYvVEBMn3JbIklSyFd
 gEUhrvKhiT5MMaK3Ky2XBqa9wGLB2mQ/GRO2l/q/mlyExD0PaUV+ljvdp0ANVUvwPrlc
 Iis6H0gJttaSFeF+2SZtfeVnBA9hA5y0C2HZt1cXiTqL40CITpZQGcZcgKTVNt0acwjz
 oiNA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCrA6bAsP+tGh0S8H1lJGqLfpwWfwooFzqGJAf2ArFyTkCQjsb15LptNWr3SYTmVY4B2u/7AKhLO5q@nongnu.org
X-Gm-Message-State: AFuF++mGdbqVHnRuCkXwl6CwVnlWx3lQQFjb39ezPdCNiqPoeLZUn6kl
 I3DArOcVLLBFjnRQ2UbRSxlYaQz60/v8qpkXrJofpbqR9NU8frWJn0QYyLY6ejPAizI=
X-Gm-Gg: AYBFou1pH7Eqg/UWRmOOkmR9y80EZJOMF0SUpQrppCWdTsAX7Jsn0QgJUItYWJat41T
 9dQSO0E6b/kAlr9t5wA0E4Yyhi/J3V3rHWFtTuIIg2/KyZRqBM0cdjY6k46S+53649Abt8sum3i
 KiRKrCfo1h9S3mztmXaShiaB8masjDpf43dnn8i6I930K8IJ3kOZbLaM0PLL4YMH63Iv+UBWOPb
 Z/xYjlFyZZ7p1yNESjGJ+/3iZo1JixEu3RE/115XbmazeWE7D0iuxyYLi8EY243ntRrHxKxBPw5
 AQyPazIBvNLd9qQpZUjzqdP5Zw8ougkOXf/IyvFhlRIPWh2jJtyurL2xrBnPSd7gqIdKAVfT8oM
 eMiK2Xb3w9WBgE5QBGHYg2OwJZpXvFxcSr8zp8Ri1OPMfBnN3k3HXwkI2s+9Ja3g3ePHO/hfxnz
 p1wE82oNt4YKGnhRShrK7y4f4GNXYoURj3of0wbn3XvI0gbUeQor4Yo8Nfwa1PpjXyDmqHntEe7
 cuW37I3+Qtd+0QDlt/aHyjGTC3clk19R3w5nN5T54wGGr67FfcOaYwUTMOnig==
X-Received: by 2002:a05:6a21:e344:b0:3d3:aed2:6f25 with SMTP id
 adf61e73a8af0-3dd726d9df7mr1688661637.25.1789603157275; 
 Wed, 16 Sep 2026 16:59:17 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:325f:1938:d075:8c13?
 ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c00ede586sm7830388eec.10.2026.09.16.16.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 16:59:16 -0700 (PDT)
Message-ID: <97cd9bd9-0b4c-4b43-9113-0d4721c513f2@linaro.org>
Date: Wed, 16 Sep 2026 13:59:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/19] testing: various docker clean-ups post meson tcg
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/16/26 05:29, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> v4
>   - added Illya's fixes for out of tree and s390x tests
>   - tweaked the revert so --disable-containers still passed to meson
>   - don't define tests if no compiler available to avoid excess SKIPs
> 
> v3
> 
>   - Update make2test to trigger docker build from Makefile.include.
>   - add Daniels's suggested console: true patch
>   - fixed up some unref vars from the reverts
> 
> v2
> 
> I've restored the configure based compiler checks for so we can build
> roms and the vdso blobs again. It looks like we could never build roms
> with container based images so I've left it for now. Unlike the vdso
> build we can't trigger a container build through Makefile.prereqs.
> 
> TODO
> ----
> 
> I also need to look at the timestamp stuff that Pierrick has suggested
> to see if that improves the caching from the registry.
> 
> The following still need review:
> 
>    tests/tcg: add console property to docker image custom target
>    scripts/make2mtest: add docker dependencies for check-tcg-% targets
>    tests/docker: fix brown bag typo for docker-ccache
>    tests/docker: swap --quiet for --verbose
>    tests/docker: add container registry to configure and use
>    tests/tcg: don't define tests when missing compilers
>    tests/tcg: use --add-current-user when building containers
>    configure: re-purpose the tcg test compiler configs for vdso building
>    Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* options"
> 
> Please test and review.

While I don't really understand some of the container intricacies, this 
does fix all of my build and test issues, so

Tested-by: Richard Henderson <richard.henderson@linaro.org>

r~

