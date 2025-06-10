Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A72C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtnm-00079i-Gp; Tue, 10 Jun 2025 03:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtnl-00079F-1T
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:53:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtni-0005cj-P8
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:53:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450dd065828so34307285e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749542018; x=1750146818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yl/Y3FkXDtDjUPxbkFt6Yy4tgqM0z+3lONqy92kGbCY=;
 b=czkwe1VkDsan3Ve3qGMcNNUEltXIosfcvZ3OQPmEq4+rrB8xcdCz9eoMHZoL0z9DKj
 vKxY34O3V2tKTvFafYF9Npuh6rf8VaBMB7PChefyBrsv/21t7X8K/qiOziH7e0o6TInf
 fT1DjLH7G1346naACEpbFQhW3vzDxU1xEV/2vg5Nv6WT5VLGOmLDrFtnfo1rX2UYC2UY
 CjQ+eLXipHcBzPsdaB8QAx12Wv1X2uWGyqFEnKWtAOJAeTnLyRYX+L0mJPhA6him0TnI
 aShDoe9aUlu7zQatdXbJHT+bHMmz56M5RJDO/wPBgESR5AgbqPb1ZO89lJfiQ22zcGhY
 tgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542018; x=1750146818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yl/Y3FkXDtDjUPxbkFt6Yy4tgqM0z+3lONqy92kGbCY=;
 b=DFVfyQh/DeYn7MjHZVWuWSaa0cg6SWK2TKkDRIW4yctU00i3N2urPEBK2DJ4DKIRtS
 Ecoyj6ES87PYw/HyFIgmYW6J0R5YSYyzu00IoXtnUnzg3Lf7gsmEq5DO4g1eKA+YTjc3
 Xuk576pKxKuqyi8EswHDN2Yb5Y3u30maSH4ooIEDzGUK/LnsEaNnwmnh7zNIeIQDW1A7
 8oJG8Zh3pi4fTy0FFD70hVgYNT2d59J4BihlRbBCYKUuKYGhNSpETELtLESJy6NBKaYw
 +G1ur/QlTFfXQ+LoOVexltYyiaLyjN93jFLmviqNGuEALqeIyGX+nHqNvgn2lfVf+Jau
 RAtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQTJ055snPFUtHzc/dtciDfIijWVIzLKRyfa7nXUoU6taJAoKW103XHxojltMOc5iEjEEaEVUF5aoT@nongnu.org
X-Gm-Message-State: AOJu0YwW1eJK05NrSj0B7M0yXfpOZlgqNl35xdKHcq+hTnlaBI4rQuri
 OAyBdtN0xIiGr5BQtKUSo6ORekzpK9D8WvvRjAdDb04EXZLxfMZaF3hq9dl5DOQI9Y0=
X-Gm-Gg: ASbGncvwStIxw4VS7BEzGbWdm2KERyunOFV4bRQzyidaeyOuSDDEL8Bi+qScW91x7Ur
 DYHcnTW5XEN4OOU0T3GkiUaUPw6R4okHVXjHWtb9MrUfM3NMe5f37LknbQkuZ2rds3VSpQ4xBhB
 7dHRQKhkzcI+Yrw9BG04Yc1tnnPY3l2fOJuQpjsZW+e16Ok78cDb1wmNVbEpjBg6C7/wMF3PwxA
 tjNkdkp8xn4mBRWhkfmGGOcIDOaeNsCLhb5iZz/NPlUjj0jvO0wieh/shlB8TEupt/CzZo6X3us
 S7xmiNqMu4dpxkPYXAhstSGYgs+OXkDBVvTU11paeBwTNWJPX/Y1ACcOl4ND10mbpfTmxlX/HZ/
 99zuXJlZIBXuQB8knUyf/Bd4k5GiMk+s0xUE=
X-Google-Smtp-Source: AGHT+IH/eyKMjTG4rAlQuKMEy0r+godjtdWG5Iris8QkVatX+iFt1dfA9Q/kFftvoybRCu8RB4r5lw==
X-Received: by 2002:a05:600c:1f1a:b0:43d:46de:b0eb with SMTP id
 5b1f17b1804b1-45201414958mr156079505e9.12.1749542017630; 
 Tue, 10 Jun 2025 00:53:37 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de53sm11463582f8f.8.2025.06.10.00.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:53:37 -0700 (PDT)
Message-ID: <91e38ead-cea4-4100-9f90-f0e75dd748a1@linaro.org>
Date: Tue, 10 Jun 2025 09:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/77] rocker: do not pollute the namespace
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250530071250.2050910-1-pbonzini@redhat.com>
 <20250530071250.2050910-14-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250530071250.2050910-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Paolo,

On 30/5/25 09:11, Paolo Bonzini wrote:
> Do not leave the __le* macros defined, in fact do not use them at all.  Fixes a
> build failure on Alpine with the TDX patches:
> 
> In file included from ../hw/net/rocker/rocker_of_dpa.c:25:
> ../hw/net/rocker/rocker_hw.h:14:16: error: conflicting types for 'uint64_t'; have '__u64' {aka 'long long unsigned int'}
>     14 | #define __le64 uint64_t
>        |                ^~~~~~~~
> In file included from /usr/include/stdint.h:20,
>                   from ../include/qemu/osdep.h:111,
>                   from ../hw/net/rocker/rocker_of_dpa.c:17:
> /usr/include/bits/alltypes.h:136:25: note: previous declaration of 'uint64_t' with type 'uint64_t' {aka 'long unsigned int'}
>    136 | typedef unsigned _Int64 uint64_t;
>        |                         ^~~~~~~~
> 
> because the Linux headers include a typedef of __leNN.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Your tools sometimes miss R-b tags:
https://lore.kernel.org/qemu-devel/4d8013d1-3787-4d8a-8b8d-3eee7d389d6e@linaro.org/

> ---
>   hw/net/rocker/rocker.h        | 14 +++---------
>   hw/net/rocker/rocker_hw.h     | 20 +++++++-----------
>   hw/net/rocker/rocker_of_dpa.c | 40 +++++++++++++++++------------------
>   3 files changed, 31 insertions(+), 43 deletions(-)


