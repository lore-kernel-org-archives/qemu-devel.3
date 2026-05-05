Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1D2CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKES4-0003Zd-Ml; Tue, 05 May 2026 08:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKERz-0003XO-1q
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:00:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKERv-0004kX-Tl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:00:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so61220855e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777982425; x=1778587225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vp6/FR2Q7DFGQ2lXC5WW++HB0DUM0tirO3EEdRzEicc=;
 b=gbgQHVY3OA40k0KE7v3hexaFT/Lb8R3CwBS2CilurZsBo/W9VYUdnE8x6Le1LMQ2xl
 /QGX8KlUeYNoZgRChyHzq3qHSHHB3m9Ae4zkMF/lk/mhjbs4IRshe3YAmoOQvM9o7e46
 lATBsR50T1xxoJww2gnyKfhb6r566kK4nrhLEU/pdBRr4yCNFVQCs+YzO/jGSCOraLoD
 C9jZ6eURDJ5kYPq0OtsLKP4OZAiM3LEGt138VCQXEgNEWJlV9ziZUBAxlcRKguC5rHFN
 ZtZcmuYlP+EG32oM5Rus39dATWHkfQ+iaXSKJ79bHV+lTZM6jhYw2NIKAHA64fAJbc3R
 pevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777982425; x=1778587225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vp6/FR2Q7DFGQ2lXC5WW++HB0DUM0tirO3EEdRzEicc=;
 b=P3XAtA8sG7KCJ9/q/uITVdizafWLb3Tkma81q28x9H2rdLmy9huVPfS02qoI32twOX
 PDFtWEVJGBFlygTHDQ6x5bUTtBGPbeEKUqBljNJNaKl+OfTFc+ZSmvrblVI7B1NB0n4c
 2qQtp1oKxK9BtXDZlQlBMgbYJTix/rBqtU5gr2MmYvUvjgJXRyY9kcci4YyxaQ50D32Y
 G5WavLcMHoiOZ2dyXHAWiySvMkjEkgigvJMWYx9VimmgKVNTp2FaBglUK9Z/mgXVGo6/
 LD25ppsjZmod0/YPUePkPoRJfF5xHnye/PY5TMjcgvSIARuDYUU4kwciTxxq+UsF5yy9
 R4AA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LG3qUKoFCNJvjbrDxbOkX4//vr4x9uzrg/Edo3bGE+Y6t32ynw2NOca5ksi+O0BUtYxZMyhyZbVGy@nongnu.org
X-Gm-Message-State: AOJu0YyVOE7Yh+mY0UKZ/HNA41EpUp/QOkthNG+Yt7o2Dfln996C2cj6
 OOqWqJSDvfn3/4mLHZcer0cDQdEnW8s/C7AcbaKXlSEJ9OdxPlvsAuL+8qFRQuMEYZ4=
X-Gm-Gg: AeBDiesARE5egpipRA21X6XxUr6RH4ZhKY3SvDjkC9F7n/iAWNcEmWD4VUgJRN+DqtZ
 qqYKqStxEeXf7bO5NOhz1MfMptLYqwQuG5dUslPlew+ZG5vc0Pf5LDSpkuWmwLYCjsatml/Z988
 oKRZ+oz5D4LHYGUJK0RGBofP2B3Of6dBAJGYkQZvsUX9JO9AzokoKDwBX8XKTfDF60P9UCP+Y5D
 YutvwsVEtAD75JpLBmq1Z1HXJKCm0YEFW5GnpoRCzEHUq8OngP915LQoXIA60/CNpkJCNPY1Wx6
 GNhhOd2T+rC3B+PUntIWWDHJuKK2LztxcltOIfdwfH0ibexUAULKcFjUp6PnHO1tnTlUZzUM7yM
 3eo/9dSeFJf/GbiYYp0S4V1+wUMP1GGVxTdTjkNiIUyJ8kPoc7OvnWkV2FaBOkukOedfAnVyrVC
 eQ8OeL5wLVMvYCAleVuwLqhmknfIUK5sYIwy4919TIKJrt50os9hPsRdH62UViQg7DZUg5FqpvS
 co5
X-Received: by 2002:a05:600d:11:b0:48a:97b6:7420 with SMTP id
 5b1f17b1804b1-48d1271fc9bmr73322455e9.24.1777982424134; 
 Tue, 05 May 2026 05:00:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm429243655e9.7.2026.05.05.05.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:00:23 -0700 (PDT)
Message-ID: <dcce1185-642a-4e34-8856-2401eefc2011@linaro.org>
Date: Tue, 5 May 2026 14:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Miscellaneous patches for 2026-05-05
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com
References: <20260505115036.1170186-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Markus,

On 5/5/26 13:50, Markus Armbruster wrote:
> The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-misc-2026-05-05
> 
> for you to fetch changes up to 8dc8f7b5bc755227c72eb74aa332e7a6bbb90066:
> 
>    qdev-monitor: Fix qdev ID validation regression (2026-05-05 12:52:26 +0200)
> 
> ----------------------------------------------------------------
> Miscellaneous patches for 2026-05-05
> 
> ----------------------------------------------------------------
> Markus Armbruster (5):
>        hw/core: Deprecate query-kvm
>        error: Fix "to current monitor if we have one" comments
>        error: Restore error_printf()'s function comment
>        qemu-print: Document qemu_fprintf(), qemu_vfprintf() failure
>        qdev-monitor: Fix qdev ID validation regression

My single-binary pull request is blocked since you said you wanted to
have a look at this series:
https://lore.kernel.org/qemu-devel/20260427080738.77138-1-philmd@linaro.org/


