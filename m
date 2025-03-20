Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A669C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvA9J-0001oN-2q; Thu, 20 Mar 2025 03:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA9G-0001nW-LI
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:17:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA9E-00008h-Ti
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:17:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso2255705e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742455019; x=1743059819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7oN3IJUQ+cRRip6WoFOMgHlo+DR8URxsDY/k19Goo3M=;
 b=XnvkivzC7W3YDfGIOCQbiKWS/LQ1uQKh3v06TJj5wM2NH93TJj0b4PHFjJW5d1THcv
 kTn5CXe2iJ1BNbwIwy+oFxpwhGobzzAgeug67RAQK8xxGYvRA4ouS8oRaiRoIArTaY7B
 MQ2WSnQRkh+CpvXBVLGiemS+UAGbUI0zhjfHMIqUv9wQ2Fd0aHlUrZKkPqmyCUU6Uxic
 kSNCnBorNzURgdAl3umtNHuaoj7KfoHR62ZrJkdqdK0bAF/xCU+TZjIKPJHoDfVVbanT
 W8FAGSwrpO+GtXIsAKGsTKmgC3mZZgV7hO+MrLd/xvoOE6oAcDnvkuOkhb8zlHtQC9eo
 bkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742455019; x=1743059819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oN3IJUQ+cRRip6WoFOMgHlo+DR8URxsDY/k19Goo3M=;
 b=VrO32WezLfKolVkMSfH5UVXs4i3c/4+ERp/LfAsXpZmvDgElZBL0TGgCIabYCGPmw0
 ntBe9e+W0buW1AEgW/s23siMn0YLrhCOt2drF8OM/DZG0FHEPWrqOlFwFpYkwSGgP8+4
 4VRDZes3Fvli2V1x5vOqThti5Z+lhsiEtrB7p96pCYO1NnkhpPdnOpGBQKfUyCY4z3Zx
 fjBHT0ajDOLZhx7oKDDKD6q0wnlkyUuMZqTkNlpL2Cl1ramvdeO75CUbc2DgauaBVjKN
 4LbO/p2IYKBvisODuakDAq88gMxRC+1FGjJKEg8DK3/Xrf2m9o8si6Fd+BIjfv9wDVBI
 kdtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKuD4Ivo2LGk5FywZyf3ETqb+OXTrsOgItLUuaR0C1A7OafDplvxaffrFYIx1lyil7pTh+ddoqxQjm@nongnu.org
X-Gm-Message-State: AOJu0YwRxK6/eEhMSXoeIetqnvHs+Lr0UxqmE03W8E6LlNmCrCxN+CnY
 Wiv/IUFNK7y4om+l/OtGoFJUNveriqiA8HSbyLn6zc+nbTZlabNcFwleoAVb/0o=
X-Gm-Gg: ASbGncv9LfuCouLfRsH8yJpwsCGjSlt3m1V5hRrJlk98qG5w9oF1qk//ntrTxS22VVF
 i11G2oailaHpnbIFcIhBgzEbGCs9YdcpQSoGkCgy4vuyJyucpramNMfxbpUmWJ888qsddPIXKkh
 vIeNMEmT3WscKWXg2buXcCBbzSVdgzWQhyC+fTc2+KnkI7e2nhtgg4D3iBQob1xV6hzzNEk/5GY
 qc8uaMBUfM04AcQAUOPTOn8DdSZdH+GXbIgm+ZxwydhKR/lPJovsU9bt4XoEudksySlh+e+DS2n
 bg0OxdLtphzeyOcm7/uDofoGGz2Ej2CN5gHay+H23papGaTy2boUwoyK6VSYj8Lt18TSpnfDpju
 Y31NplSWrqltu
X-Google-Smtp-Source: AGHT+IG0u0c/IXGQAKxF96XMJoa8uDQbJuXuOj5glAxbLjbyg7hpDQTZsIHMLKZ6uC2B6qjDfJ5jFQ==
X-Received: by 2002:a5d:5f41:0:b0:391:3150:96fb with SMTP id
 ffacd0b85a97d-399739c8c85mr4283503f8f.23.1742455018793; 
 Thu, 20 Mar 2025 00:16:58 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b7656sm22466021f8f.40.2025.03.20.00.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:16:58 -0700 (PDT)
Message-ID: <02460753-0054-4779-8d4a-c481e905ad2b@linaro.org>
Date: Thu, 20 Mar 2025 08:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-3-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Alex,

On 19/3/25 19:22, Alex Bennée wrote:
> The current helper.h functions rely on hard coded assumptions about
> target endianess to use the tswap macros. We also end up double
> swapping a bunch of values if the target can run in multiple endianess
> modes. Avoid this by getting the target to pass the endianess and size
> via a MemOp and fixing up appropriately.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/gdbstub/registers.h | 30 ++++++++++++++++++++++++++++++
>   gdbstub/gdbstub.c           | 22 ++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
>   create mode 100644 include/gdbstub/registers.h


> +/**
> + * gdb_get_register_value() - get register value for gdb
> + * mo: size and endian MemOp

Since we pass the size, ...

> + * buf: GByteArray to store in target order
> + * val: pointer to value in host order

we don't know the type of the value, ...

> + *
> + * This replaces the previous legacy read functions with a single
> + * function to handle all sizes. Passing @mo allows the target mode to
> + * be taken into account and avoids using hard coded tswap() macros.
> + *
> + * Returns the number of bytes written to the array.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val);

so I'd rather use a 'void *' type here (also const),

int gdb_get_register_value(MemOp op, GByteArray *gbuf, const void *ptr);

...

> +/*
> + * Target helper function to read value into GByteArray, target
> + * supplies the size and target endianess via the MemOp.
> + */
> +int gdb_get_register_value(MemOp op, GByteArray *buf, uint8_t *val)
> +{

using uint8_t type being one implementation choice for this method:

int gdb_get_register_value(MemOp op, GByteArray *gbuf, const void *ptr)
{
        const uint8_t *buf = ptr;

> +    size_t bytes = memop_size(op);
> +
> +    if (op & MO_BSWAP) {
> +        for ( int i = bytes ; i > 0; i--) {
> +            g_byte_array_append(buf, &val[i - 1], 1);
> +        };
> +    } else {
> +        g_byte_array_append(buf, val, bytes);
> +    }
> +
> +    return bytes;
> +}


