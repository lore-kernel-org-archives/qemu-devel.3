Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114C4C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIB-00053n-RQ; Tue, 08 Jul 2025 16:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZE8F-0001GL-VK
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:37:37 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZE8E-00055U-3u
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:37:35 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3df2ccbb895so44028885ab.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003452; x=1752608252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gFl9ycDvD8hTkIKtix9h4JxZql62asrb+MOPRsaNjSc=;
 b=OGzs7j43MsqpgQjKVA8ow95wcf5/qJoWiMp71LcupYBHjRln44DMWSY36v0BbiYROB
 dMvts4/deb2HRReZ03vtpN+lUl1YYtEk9CHV9ComcVvVM/1qCt5ye/QQwY/EEIVtzdO8
 vW+hnDEnVVwnEcemRTkQXzo2/G89Xhn69oD3dpqkTUg2YQkeG4KO3XEIcnzNxHRkwGa0
 4+pynYZ+PhWHj5rI2tb3pkcsnzIkKuISwVlykmx1zF3jVuGwtFIyuoF2hMPgrcrAlUFN
 xI2HY49SAVx/o12aVxvFlF3uWEUrUOW9crCjmt1Uj7kRCF7/YkHwseue8+KL9xXbBTM6
 zO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003452; x=1752608252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFl9ycDvD8hTkIKtix9h4JxZql62asrb+MOPRsaNjSc=;
 b=wdmBafl6nYn5vb9go0pHQq3E49p2vtRlEQLNQx7AuO6e5FAjbRtH3Pb0ynK9Bx+4pp
 9g0Aps1aHdlcpxdyvQUSPcE4FJqXTi1HUT+Yte4iHgZ5x2r4CBTJ/aPWlFjY2ijMqaX0
 n3XcUPGq6o0z/bvBiIcFL8FtpACMXKkj1vFM9FjAvSlWM+wlnyyPmoIQgLBtIBFsLObP
 0zLg9iaLTwQ1XITkY5VzC3RMG/4WRlpCq92MYLYT6unAnbrd2H7xd74Zv6Id3Yx4dyod
 PeUkLKFMtegGSVIH6dDeIWGl6EvEyQaFDSc5JQWM2QRZaeNtoT3cMBYoeni4i+6Gf+fO
 4q2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRHTmGhU1NcQuDB1umHJKvwD4lKCvgIWi1WGCmpMv7pUdASVovW5mgHeMAjvsQW7r2MgB8+HmS2xX@nongnu.org
X-Gm-Message-State: AOJu0Yyo9PVOAaImpw0mwwTHg3aZM5SAqucEJG6PKAOfiKQeWnVLgxzp
 qpQY8rXcwLl6oGY5G3+9e5Obw4ODK5FxeUudr+j2VmPEBkrqR5ZP13A1ATGdIcSX9AUVdRA02uH
 c4ZbDWIw=
X-Gm-Gg: ASbGncv51wNjxe+2CB5IiaVVoSk+1J3pYV6Fx2B+e1M0R+TctkQG9arOWe84PI6TmAa
 k+NcqWM5IuwUOD3AyT+bRHTPa5KF3LuEjzxBuOfoq9TRmj2dLdPvKQIrSesPhXnCxV99JqjIpGq
 3YR8f6UxznPVJnXHIU3WpiDJjIQCDMarHnw4B3j6z4ua627ut/ryGlj9LyOstSYeBE9Fulhihcf
 9zBrgS800xFTTjvRdazGKkWhiIbDMT7dCnVf2N1g+GSTel7dk8tDnGORjVk6chOagNijw8rDCAM
 gyTKWhddpqTdLLnUkfgE07ciQhxBg+veRE0h9lD2bVjjH7p4oVDTPaUli9LIJsba/f2BsHoLTxc
 svMN5xC5/wBAOO9MRhnhFaLwCf2jHPxit1wVaBDpw
X-Google-Smtp-Source: AGHT+IEtnZVx8pxz2Bsy1b7CSnXurKno5YuaxEVnhnM2MYcsGC4zvlbMkQQgbLPB0Lq6wNwAmjGpaA==
X-Received: by 2002:a05:6808:4fe0:b0:403:37dd:e109 with SMTP id
 5614622812f47-40d073dd740mr12731140b6e.27.1751996176929; 
 Tue, 08 Jul 2025 10:36:16 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02ac77e9sm1678991b6e.36.2025.07.08.10.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:36:16 -0700 (PDT)
Message-ID: <d182e9ee-afae-41fc-b160-971cd909b9b9@linaro.org>
Date: Tue, 8 Jul 2025 11:36:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 4/8] qemu/target-info: Add target_endian_mode()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708171949.62500-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/8/25 11:19, Philippe Mathieu-Daudé wrote:
> +/**
> + * target_endian_mode:
> + *
> + * Returns: QAPI EndianMode enum (i.e. ENDIAN_MODE_LITTLE).

s/i.e./e.g./

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

