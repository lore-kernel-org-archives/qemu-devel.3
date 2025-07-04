Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBF6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh18-0004R1-NO; Fri, 04 Jul 2025 10:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXh0U-0004AH-Pc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:03:25 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXh0N-0000Y5-GA
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:03:12 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-739f2508ffaso854794a34.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751637786; x=1752242586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XNq0c8GL5ZyhDYOqX8QVyvyzFsqz5xU7FqcEI7jxulc=;
 b=gEtcZ4C6Z5d9dgIe6WmAA5O+Hv5ehwEeT7yoKuaJG/cN2CTqzBoPzQe0UAb1AHLwwc
 xBmG9e+TRpMnbYIHMMn6c3UvghE7DeY8T4YQbEaRclv/NrqI5RHJUsKsGtCX9CqG93t5
 3WgiDZc1JMuDE3Zh8LjGgejQ1ir5w37nW6fbrqWADB5FSLlu6zNXPMmjnpffqph0cue/
 PGnZsEetcM9YsEGGBljCoJ5idXQlnuY1aeaumZSy71J3LIhPHjKmNARiqxIEsg9XL1Lh
 QKH8OGFxVgCRR1itOm2T17xzMNcM9W3Kyp408gplBQtSxWAgz4v+d6b7cLEh+sRoIaaN
 IbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751637786; x=1752242586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XNq0c8GL5ZyhDYOqX8QVyvyzFsqz5xU7FqcEI7jxulc=;
 b=TlZDPN8OGYw+M4SdVUW1xt2PVsa3wk4RB7vZ1/TLM5Wcustpj5lM0FCN0HvFxICoVa
 +rdX1AiJB5JFe9Z9WUcf0yBw8zBBWV4421m6avdoHvzIVKyHtz0Z8WF58+9oszk9BnLo
 MpQHVWXWRT7re/81llQggjtRbcwhbZG8KOS3jP0ZV+ReMm3EeSwoyZCkVmH+rtGa7oY2
 QKHTYColfaUQduA8EeP+tkL/YCVajgTerWeLkd4SpXUcbxaGR6OXejHrNFXfXeTrXkew
 gHmpkEGRG1mRQiifQsbEe9Z5vjbzB++HV+N5kFlWsKHf1T4f7GEkxfDwVXL3uyP7O9po
 aBJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb909HcwqUcIsvmR59yW/UdeaSEpDIrWqap+/Rc0ZvmIG3Ex9y9k64RPlCP20S1MetMeFKMopgLxTF@nongnu.org
X-Gm-Message-State: AOJu0YyiVVlCCBZUS3DsibMgsUweh8+XLduRozU+raENwk5jSK4+nN71
 s/6BoD9McmAvCdcCkGX4Wonkh3WvlPdyNlI8pLxamm5BijhXXChpGuSof39lytAPMqo=
X-Gm-Gg: ASbGncujXLgtQ+zEaVmkHUanrmUoDt0tEFwqPFKlxigDzVbzjZC50O4oy7R14ITFThq
 xhpwrU8U78unJUzmU1fBVeZuEXg+XKhXPyuJywYRUBvIUJExdwzpeZn30Old26o5oTp3Dz3Guqi
 mXkUAtGzZkK5myXv2MzPb5BQBpTmRxKs5r5uhrwo2CXTNzlchkOsFtB7BR3BjVBN5yFDqbyUqcj
 vPwqE+2DMr9BGsgxcykPRDBzvXpOQ+C44Rzy2LSRvUDCJyqnZ3y+PFn6Y/FsSVPQRZcoK9u3Ydv
 MwvFScqKy1TpavEaPK4k1AGXw+lcqU6q+dzTIzZ/0zg5Hxmf13XZb67J3DJH9NDPLb4Ji9DsCJA
 FJ4dLOu40i65Ou7LA5lfhz2TaWE6KT+/2ZYRmd7P7
X-Google-Smtp-Source: AGHT+IHCjZMWku2sXb4MaomGmkFzos2MmBGatOccfc0k+r2F+uBCum+atRQEn6lI9s8yQAG5RNVFtg==
X-Received: by 2002:a05:6830:4d86:b0:73a:8a8a:5151 with SMTP id
 46e09a7af769-73ca66dc922mr1238051a34.17.1751637786225; 
 Fri, 04 Jul 2025 07:03:06 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f735144sm388064a34.14.2025.07.04.07.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 07:03:05 -0700 (PDT)
Message-ID: <68bd424d-0249-4c74-a7a1-d0f46d46a835@linaro.org>
Date: Fri, 4 Jul 2025 08:03:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 38/39] accel: Extract AccelClass definition to
 'accel/accel-ops.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Warner Losh
 <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-39-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250703173248.44995-39-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 7/3/25 11:32, Philippe Mathieu-Daudé wrote:
> Only accelerator implementations (and the common accelator
> code) need to know about AccelClass internals. Move the
> definition out but forward declare AccelState and AccelClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                 |  2 +-
>   include/accel/accel-ops.h   | 50 +++++++++++++++++++++++++++++++++++++
>   include/qemu/accel.h        | 40 ++---------------------------
>   include/system/hvf_int.h    |  3 ++-
>   include/system/kvm_int.h    |  1 +
>   accel/accel-common.c        |  1 +
>   accel/accel-system.c        |  1 +
>   accel/hvf/hvf-all.c         |  1 +
>   accel/kvm/kvm-all.c         |  1 +
>   accel/qtest/qtest.c         |  1 +
>   accel/tcg/tcg-accel-ops.c   |  1 +
>   accel/tcg/tcg-all.c         |  1 +
>   accel/xen/xen-all.c         |  1 +
>   bsd-user/main.c             |  1 +
>   gdbstub/system.c            |  1 +
>   linux-user/main.c           |  1 +
>   system/memory.c             |  1 +
>   target/i386/nvmm/nvmm-all.c |  1 +
>   target/i386/whpx/whpx-all.c |  1 +
>   19 files changed, 70 insertions(+), 40 deletions(-)
>   create mode 100644 include/accel/accel-ops.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

