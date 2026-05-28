Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F39CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSV7N-0003lG-7p; Thu, 28 May 2026 03:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSV6v-0003YT-KJ
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:24:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSV6s-0001aw-PM
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:24:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-49056b9f04aso63607765e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953093; x=1780557893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsafEjPNf0aehMFFDkjIO29wWxRkbVrPF2thKPprA4w=;
 b=TeuHHtcApkQja+sD8RDM3jXfH3pRQI6AvNWeHf1AHZZZ0qaPZJ17nGLDKsx11maYui
 rA3uTlikWbHRJHHOaDWthKFLOQX47EpeNGG7G8Over3ZiJNJ/5d4Y5X12VdRpFjtH/9z
 ZU3JimqWR36mhOFeT7JJ1iaN4NpoMqqsUMg80pnsoYFYRwCvmnSPanqiMwj/sYBTVjAk
 1YO1wNtVrZlMW7XOeZqFhTHImQKUnFpjs4nkmU+RKQYD5ESPfWY4V4+XiC8wZieDyB2u
 an23Fc2m9AK1OUL3AWsDWAsEvCEOvEGumLQ/FLlmfmfClbwe6hZO9pB3gV6BSn/zgwBW
 SKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953093; x=1780557893;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsafEjPNf0aehMFFDkjIO29wWxRkbVrPF2thKPprA4w=;
 b=MP+GSYFdZ3wxKpzqjvDTqQl9jni6RcXVUU2m6wQ1Px8yF+5xr7CAJKgwB9SbvKLbMs
 TdQUqG7Eeyr/cONkWUVVIsynz/hywZeSL4DtQxwjLMSWTfvDcx3D2MJjlBjUJqqDSi81
 +8WkTtj7pcmYxyJaL/dt0lThTLg5sTO32d2BYx5LtW3+MvLXa0H9NVp9befJX9gnMfTS
 s/dCEdLmiLsSJlyQuHy1+ttGA+ltXR9HtoOwd5UgowISUaB0WAUCt60HnHC5rmupWKM7
 E+Vo6Z7+He5a+6qgOZjq3N2C8jJg/LC7C6I5HP44zTtgNV8iIDshmKFfG2n1ou6F8O4y
 4UoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZmMdrnNXcljUZy93xnWPS9WHUbemypzv8hulaOGuTebw8Q69znZx4NpSB7E3a+kVCpRt+Vv1uZycR@nongnu.org
X-Gm-Message-State: AOJu0YwVuleMNTaMPwfgB/mkh11Ad3W3ePNuP+3U0zzqjnwH25G7i443
 pf9wpi71NrPiU0Y8Di3NPd2FNu/3rOd0cpJdra6hsOpxEgqctNTyft/Rr+VJ/MR1j8s=
X-Gm-Gg: Acq92OFVsAeJ6E5Y+i3Pz5fVF3gj4d2jX1wMrFndB0Q+MrgvtzZAYRhZo2MYwIJeqi/
 Wh3cqfDjXZnDMI3zJFPI8huV2hKNeLZjPlglbSr7VqdLCwrNrCNtca86HD4QfBynwxGvds8gyHq
 vvS1Hjk5LPsZzLikypJa/bE4AoFTlh8uWDkTRfQ100bjNO73+H1FpwZg9clIlai8yADrU//jYcD
 xQMb2K5ejfJI/zis1/zw3ylFocq/JO6XXletLHnY29by508UCaazI8Ev4t9Aij2HLY2Wj3oDtvl
 9S0Z8jkE5T8GUi9RmSO4i0SfLSzRffDFEIfXEYOQNRMUf/mRATI5pjK7meJGK7IqvpRQT6fC5qy
 kKYVfwCD9NR7E31+E0XvM6V87aDGh0yeSIAWN9Q/7nStYVH1o1QMc06C+4fUju2FLlyZBIZbFUO
 u3XK5/Mqhw2PobaDkZviTaBFey2TRnMvd9Epmf8zrRzA1mxUfe7wLeBIHLMFMUexmjlGw0T3ooV
 dFCTAobXRdOm0k=
X-Received: by 2002:a05:600c:8b23:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-490425aa7a4mr451413785e9.13.1779953092743; 
 Thu, 28 May 2026 00:24:52 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b6a93bdsm11873225e9.10.2026.05.28.00.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:24:51 -0700 (PDT)
Message-ID: <41e70c92-99d0-49d5-b233-a7f80f863f8d@linaro.org>
Date: Thu, 28 May 2026 09:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/microblaze: rename helper unaligned_access
 to microblaze_unaligned_access
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Brian Cain
 <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Peter Xu <peterx@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 28/5/26 07:16, Pierrick Bouvier wrote:
> Solves conflict with aarch64 unaligned_access.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/microblaze/helper.c    | 2 +-
>   target/microblaze/helper.h    | 2 +-
>   target/microblaze/translate.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Duplicate of this patch which you already reviewed:
https://lore.kernel.org/qemu-devel/20260224193028.2370-4-philmd@linaro.org/

