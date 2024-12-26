Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B11E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 22:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQw5R-0005PJ-Dj; Thu, 26 Dec 2024 17:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQw5P-0005P7-JX
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:12:07 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQw5M-0001H8-Vt
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:12:07 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso79377695ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735251122; x=1735855922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7QqzMaCZOKDi4RLXx7UxzCqqtiTd17jCdc2R0uNw80U=;
 b=ldWun6bt9XiylN7mun+XDnRpkqi0UqyZUKfTq20fmxtsqASEBeQfv1BDV3H1wAtOE4
 4q5m7y9IfKTqeTyEwA4HXxshdWrQuy72Z/4NkzX0D931PRS+fTuf8DQC6RmhFJ6LK71d
 zk/ayB5AqqmALyfABubhuYvH5O8QGB4mw+o6ssJx20J0DGpd+dZQwedXsElEdoOMUiw1
 vQvTYPvrTYtRALni4yOdOh+TIeYCPmXaP69lD5RhwLZ+2k24CVeK5NRe63GuAA7MDoJY
 ZgXqbfjQIuxtVTLADaSt0KGlO7dnD1c8H+snCk+myKqYpfUC035tqDm7liAT1Jkw6krl
 qIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735251122; x=1735855922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7QqzMaCZOKDi4RLXx7UxzCqqtiTd17jCdc2R0uNw80U=;
 b=vXB5Z+DP6Bp1kXKLPPsPED0w0uliUaLAHnCdNqtGsItitrrTPAxl5CLVjbFAPbiD+P
 sVyibXzOUU+JyISjCEPTWZzBYGhgZAS5x5a2Y6lxJO6e57zHNG4PGRtlavFebY/8vezi
 q3GmJjfXTE3Cy0vRXsHPTwWDDGcWg984b0aiuacV1tWbmcBuHPnPtZqOgMrAlA9oruoV
 NrGtElQzFHtB2MgYVKj+N5Jmoqz9ntzbryB4SzCGpnwh2PwZvvp8N/NrTEKkVjBMOFTv
 8gI+cLaDeZRvcTMtABql5G36gVthC+VzLPz+CVA2ASGsDC5XFjQDQlXo+JNVufsLv7N9
 hcFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjTjg5DyHjvEl7wjoZFZ8EXX8llKFquKWj73N3vMH8h9Dg2xzUyod3bYSKdVIVU/yAVo4DCby91WRz@nongnu.org
X-Gm-Message-State: AOJu0YzjEnE+aimoqaGbMpgnsxacxhO1BlVS7KU0Ed9OTGltxS48mLwy
 ki8+LitvgymFm9tO7lNM9iJ6g5Mhbv3OTBHIEp0pyFFLXuSPbaBYLluG78UGH+I=
X-Gm-Gg: ASbGncuvkuOUhqacNXRc4P3Imu3eguH3fBi93Swr6zlTFnuGTIxbcv+CK3WmiE400K1
 l22EKW/0nysI3EAxinaqzsU/Q91UZUwSijSrSwQQLVJYjFXEG8zjK5OuypRKz/H5t1SWQ5EKUx0
 qNJSmeL/ni4rAAOF3oeHgnhonB9WrvuWsqlHPr3KFs45j1lxOeNUinvJZsgY5SBDAEgeb0TdH55
 eo9h8s9yelMyCTkYkRX73WMC8uhHe5gUclcER/2+rJHAhUIzcGd0J+A6l6CX1UtPXxz7YMC0MZt
 AI9y3DXro6Cfxan88F3cY3m/Y/TLgoB0CjsCem0=
X-Google-Smtp-Source: AGHT+IE/jFsqX2LolhEgJq39xer1ceaxyEwMVzVUOW8VHTiDLdzMxLaWjzEP6bDmLHhnWBoC7UArfQ==
X-Received: by 2002:a17:903:238b:b0:216:39fa:5cb4 with SMTP id
 d9443c01a7336-219e6eb6234mr369693435ad.25.1735251121636; 
 Thu, 26 Dec 2024 14:12:01 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96294bsm124011225ad.36.2024.12.26.14.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:12:01 -0800 (PST)
Message-ID: <c16cfb39-3736-42b0-ae0e-ee74e0d5c9e5@linaro.org>
Date: Thu, 26 Dec 2024 14:11:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/23] target/loongarch: Scrutinise TCG float
 translation for 32 bit build
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-10-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-10-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> All float computations are kept to be 64 bit, fix types for various TCGv.
> 
> Performing TCGv type conversion as necessary when interaction with GPR
> happens.
> 
> Signed-off-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_farith.c.inc | 53 +++++++-------
>   target/loongarch/tcg/insn_trans/trans_fcmp.c.inc   | 16 ++---
>   .../loongarch/tcg/insn_trans/trans_fmemory.c.inc   | 34 ++++-----
>   target/loongarch/tcg/insn_trans/trans_fmov.c.inc   | 83 ++++++++++++----------
>   target/loongarch/tcg/translate.c                   |  6 +-
>   5 files changed, 99 insertions(+), 93 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

