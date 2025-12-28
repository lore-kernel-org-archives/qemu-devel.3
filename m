Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9CDD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 20:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZx0J-0008KP-Ez; Sun, 28 Dec 2025 15:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZx0C-0008Jf-OM
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:04:33 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZx0A-0000qk-RU
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:04:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432777da980so1270920f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766952269; x=1767557069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pdCRjUFvOTViQZL43sqGU4JJ4yonnIqlJdxd+ZCezq8=;
 b=l5Ebc4eG6oSUO9u1Q/Fs5uk45/DIIk4REXu+7R+Mbgm7SzbTCxUHQiDr12t1lLP9TL
 t/48ooNkWfh/Q1axbkl6wd/V5FRcfMG/gp7+dDxZhs0Ikqk+KGWvH1bwHSiMr7VO6S7K
 ImYTKFSTxDI746ZjEbAuktXRoua+pAmg+Scb2RgX24Q8t18ZSjKuG17xTRIkDFlUXtqK
 sQMWc4ta2cCFu3JrhlYtgviDbv8Qh8YUoD4he3P3N524D0pG8Zk/uijsSvv6Nn1UadCH
 668kHWev/Hmoiluahv3RZ5UIsXPkO1UVfzkURMPY8kbmJcA684VlXTRZU0q4n2i2sVuM
 4KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766952269; x=1767557069;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pdCRjUFvOTViQZL43sqGU4JJ4yonnIqlJdxd+ZCezq8=;
 b=w2U342uj1oxQSOswFfSjxXHXxxBEiJGx60DoiR/LbP1d8JFefX5AVxLQkSjMTVS0bW
 CoP1ZQEbk/A5O2rGd6sEyx8zjjLWEPXT0O1hW4P0p7fzk4lyBVtTonPhOi7PHFuSkXvO
 lNXQ/hoVShWDOhTpP1J3WGu7JrffaizbAS4n4UyvoXE4EAQJ6vLKQg1A/Knh1d6YPr9v
 yPFgXkwKQXlHZP3Nq1qMMbpF4wjtDMsmB9MY80vnh3xjGAYSYyxYfRzaEWAKazGAyA4/
 PQNBOgxFlZO26KFplny3KNSa01fMd+/osIvNPcPBdHXPpyu0nltxXMUyo1i6BVpuNF4g
 IBnw==
X-Gm-Message-State: AOJu0Yzx6lHAHDzHEmLC67ydoSB/99MPhZncmTNd9flKUOMGnUqYWztT
 x3hmCA9rYttHKqB3e7NvzocrMtkx55U8+TjOM61U6fdj9H0F1hgUMT8VCxxncaGad3c=
X-Gm-Gg: AY/fxX4+5y63f2MFaTzMo1qPd8azsMZzWgzoff8wI9Q837zVTcJgZDwaezLd0Q3q++6
 XuvWEdE2dOlCsUZOq12ncIPlqe4MQtl9CaqRlRo38nLwvx5Wb024tHGmibHDApRcdvCeTNCMHAD
 b8bp6VeRSGFHnRKMJgGFshLf++tx/x5Xp5YCS5/9uOocikwwXs7EJ44aVklGu8yW7I2z9Bv2+wc
 Pba0CkFI+WAQQoqb7mQTKKtbNVKIwOH5ihupRy3Of/P8ElskYRv/zl7THcdiStykEIFjgtb2nQi
 JlTmdBXBxboaTHsnHj6TiUKiZiS/Ukn8XwKEGS+CH7amC7/NVdc3Z9HnrkhcgWmgmTccISwmmDX
 oq/053cogGkv6znalVhzZH1+pNj1K+9iXF7M/dQtykvMX9bzBLabpYhAOq2t1QAXbQk70fFFBm5
 cLGWZm5k5XvdwwWYVwjv5Gqiih3zBxvU2Yx+7859KP4baFKJlWjyKbE4TYX4seuA==
X-Google-Smtp-Source: AGHT+IGFmMn6ta4NaHqvPDQG/CrddZZqWU5EQEUhyfReL/UPR+EVeZKyHjTGMBg1tx8KFQiMKP8B5g==
X-Received: by 2002:a05:6000:25c8:b0:430:fdc8:8be3 with SMTP id
 ffacd0b85a97d-4324e4f938fmr34887073f8f.29.1766952268763; 
 Sun, 28 Dec 2025 12:04:28 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm57985358f8f.3.2025.12.28.12.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 12:04:27 -0800 (PST)
Message-ID: <0102f50b-0778-4a32-9bab-a4786a7b1b92@linaro.org>
Date: Sun, 28 Dec 2025 21:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] system/memory: Extract 'qemu/memory_ldst_unaligned.h'
 header
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-3-philmd@linaro.org>
 <ffcf5368-9b35-d1c8-16ba-6b517e056469@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ffcf5368-9b35-d1c8-16ba-6b517e056469@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Zoltan,

On 28/12/25 17:46, BALATON Zoltan wrote:
> On Sun, 28 Dec 2025, Philippe Mathieu-Daudé wrote:
>> Unaligned memcpy API is buried within 'qemu/bswap.h',
>> supposed to be related to endianness swapping. Extract
>> to a new header to clarify.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> include/qemu/bswap.h                 | 62 +------------------------
>> include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++++++++++
>> accel/tcg/translator.c               |  1 +
>> hw/display/ati_2d.c                  |  1 +
>> hw/display/sm501.c                   |  2 +-
>> hw/remote/vfio-user-obj.c            |  1 +
>> hw/vmapple/virtio-blk.c              |  1 +
>> net/checksum.c                       |  1 +
>> ui/vnc-enc-tight.c                   |  1 +
>> util/bufferiszero.c                  |  2 +-
>> 10 files changed, 76 insertions(+), 63 deletions(-)
>> create mode 100644 include/qemu/memory_ldst_unaligned.h
>>
>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index b77ea955de5..e8b944988c3 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -1,6 +1,7 @@
>> #ifndef BSWAP_H
>> #define BSWAP_H
>>
>> +#include "qemu/memory_ldst_unaligned.h"
> 
> If it's included here do users need to also include it separately or if 
> so should some of those users lose bswap.h include now instead of 
> including both this header and bswap.h? I think it's simpler to only 
> include it here and let users get it through bswap.h unless you review 
> and remove now unnecessary bswap.h includes from places that only need 
> this hearder but I don't know if that's worth the effort.

bswap API users have to include <qemu/bswap.h>,
users of ld/st_unaligned() one have to include 
<qemu/memory_ldst_unaligned.h>.

This is a one to one match, what is the problem?


