Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FACCC9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 22:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAEBs-00073T-D1; Fri, 25 Sep 2026 18:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAEBk-00072p-RQ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:14:41 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAEBi-0001E1-Vo
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 18:14:40 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so1067031a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790374477; x=1790979277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qf/7wkq4i0EQ7DPD14a2r1e4NB/3fAiRDuoB5NJCqQo=;
 b=L2Xt87oSABbKk2hWN2C+HbLPftAlCVrKVsPdky34h+pGL6O6nMTn1z4W+WsshmXHah
 USo9ZLzt+kyMG5gRu3pvyYub5IxydSLMDQqtlSG8uBtk4TRCRJ+BHm4OLMWNoSGh2Jaz
 uc0kbMU2HNEs1NtIwzErFxiy3ZNRpX0Xk/OL6QN3d8e7U8opFU0alwRXtMiMiqBw7Goo
 U7kkY9srqQ718UR1z628wwftQcZU7UmSmBpDFMtvYduilOh71wVyy/wBTn21Tc+Ka1qw
 7Kx8AcMucB40pfPRG+NyCx7mVsj48zRxkEmSCEffxMZasIH5gzBL0xHvG6cK0anoROG+
 kulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374477; x=1790979277;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qf/7wkq4i0EQ7DPD14a2r1e4NB/3fAiRDuoB5NJCqQo=;
 b=iJs/a5de+M3noCh6KNxTK8t3sX3cTqPsQa30bNzeYK0hdTeb02mNBMoDe3Y+fH6MkQ
 rFuqOQVTw3ToA8hl9Ha1Cx2/ZZ+isiPk4pk8R8jYXdZ0z84K2rztXTV7FEQF4P7t4qvn
 clwCTBgms7xdjdvyHk2pGNTiaF3zi+KUid67vJEPPhqrxOfuMIG/BHfCNov+Fo+OSHOQ
 I4+a/YgDKCzK4QKjMsstnPi9Nf/2rIqdRM7ISnsroIFqUUWbfNbk6/ShZr7BJj+ePIMJ
 GdD8uqRFoE3dCc0jsaSeAZRkXWwXBEycet3b7y5VJI9sTnXTw0iEjA1v28ewEz01uyR2
 ND7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxebN39BIcAGqI+WvY/+/P8/f4rEmoDmFUp2wPMDhdk31/0hrAnZmpZbGm/GBzDIYPaTAAX3Ny668g0@nongnu.org
X-Gm-Message-State: AFuF++n0z9PYbJuU8/Uat9TX6G2LtsLzwYRRByUvzKt3UqgMOBlnggoz
 3mwLYJcDXG2c/YZ2YR0+rOJ5NTSHUVEz07+qjM9buAHBPupPrHor43kcdhQqUTtTCC0=
X-Gm-Gg: AYBFou216KDm8UOYRTSesnjMTKN93hghQryD7g4WLYIBNUHYOnVshHF9LaPLyMXghwi
 pGVkyvbLG23Igioh5vBZ+A0lz1QKCpohOtIpmBEDVqwZAc16xTFb3dTCH+fuuOfiZWSUSZ7T6Wo
 C76yrCtkxP848d5yKbJxrt9JDLhhH0HsiwRE+toUjGcTcNkxGHbwi1Yg8uav0PXZ1B9dcK5jNLz
 pG3oDgGl+P39T63boDmH0wvH1PeI6UgwjGOOUvt8uX0qlQgq2Ctw/dMKm8VEU+k0KfuiAWPfDvz
 vSY6qWcCE3aMPdh4JuXsprE22qRBCrUqFV5e14UYnpHTV8YMmLdP3KMQ2bHgVIEr0swujqZlox8
 lvhYCIPEVf4nvJUdjfk/66AgQErYltA4jrpp7ZpyxebznDKIaPK8M56VGvde3UUjdvqzqIttXNZ
 wto/7XnrYQgMXn9UkH4d3SfZE4URjtrLOy6dYl9mFhA3UJPQkpmzYUlcMq2eQfoCVNtm4xj3QpY
 Ppf/J77ZkwxSjpweffD1RFbKm23IKRnpmZPps8r
X-Received: by 2002:a17:90b:4cc4:b0:3a0:9640:8042 with SMTP id
 98e67ed59e1d1-3a0bb60e57dmr2635698a91.43.1790374477363; 
 Fri, 25 Sep 2026 15:14:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9589bbfsm6541420a91.9.2026.09.25.15.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 15:14:36 -0700 (PDT)
Message-ID: <9c3b84c0-e431-4047-8fad-5ef4d31200f0@linaro.org>
Date: Fri, 25 Sep 2026 15:14:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/13] tcg tests 20260925
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/25/26 10:53, Pierrick Bouvier wrote:
> The following changes since commit 80c1d80c10a0676728d65874a9641eb578626d7c:
> 
>    Merge tag 'pull-hex-20260924' ofhttps://github.com/qualcomm/qemu into staging (2026-09-24 19:35:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg-tests-20260925
> 
> for you to fetch changes up to 2ed098a7f2549781fc06e5228bf1fddcaf402db1:
> 
>    tests/tcg: add alternative cross-compilers for macos (homebrew) (2026-09-25 17:04:17 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] tests/tcg/meson.build: reintroduce build-tcg target (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260918202704.9790-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH] tests/docker/dockerfiles/debian-loongarch-cross: update (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260923000510.218473-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH] tests/tcg/meson.build: compile test with -fno-stack-protector (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260924202012.2465-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH v2 0/6] tests/tcg: use x86_64 cross containers on all host (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260923185725.863311-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH 0/4] tests/tcg/meson.build: detect additional cross compilers (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260924213942.26491-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

