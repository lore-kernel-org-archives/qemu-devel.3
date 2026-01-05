Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57ACCCF2C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 20:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcr34-0002Yl-3n; Mon, 05 Jan 2026 15:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcr2t-0002X9-RZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:19:19 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcr2q-0006or-Lw
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 15:19:17 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso2639915ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767644353; x=1768249153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bMJsbzg8Ool3gsaU7WkR6YNZQi/CXJi+qu/kX7zH2U8=;
 b=T3O7Sm3W3XH7DYVT/9YafNNT8lsLtMUHZU/vDBZ54n15s7NnaS9Ae+QSJ5GEWX6/Os
 t9X+3Hgxd2pY387RHrQx+m3+vjWrVeWPixz23ZtCk2MKR7lU8zzl39uAWz9qseNu7Kfg
 kE3zI79JsSRF96o4nyEMqJ80jQmkqhYg7URAbpLI64rs28E/qq2LnCtQswVFem8B16mv
 Pk0PapBs74vLSmudKH3+U2iK+Wa/vZY7fi/617Rv3eseuKw3C6UmS3gyfMatD7w28B2g
 Boxou/IVg9faE6EoBThgoanWsQglJ1ggLmtKR9/sqvXWAJrUHNXELL8XuVJ4gzBssh85
 kCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767644353; x=1768249153;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMJsbzg8Ool3gsaU7WkR6YNZQi/CXJi+qu/kX7zH2U8=;
 b=vNTd26/lgNpgp3ObPZ6eJZt2UByP5BVVscv/QRCYUFY7zRkiusoK/fNGV14017HLUZ
 ydcN68bi9DmnbyKifob/VuCtpTXp0upUgmgoAQ170CI5OJ97ZEOfkGR7RdxAx6YaGnOD
 PqO1IOTg+uZlpGrNV1HMu+oN+0McQlqIKhJ1oWl6wTkxdaPqsf//6WVcdOsJbSZDXeoZ
 PcVHgx2xCxnmkkj/a0dTa8GRojSByWia51ZTRQQOPewvv3JeyoCR79zKvHaPXYKMYcjQ
 hhRAO5/Xz38BX3UXdc/MabhMeVc/11mVHrqTDVwIbdTqul1KPjIVnbw8WNu7qRvUh/sg
 WtoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZArffSgDQ2bc26MYMxsPpGTFvlDy6xssphmP08ft7N9o+V7tzLjQAFyKUYj0eE5bmRuHx4tJaVwA@nongnu.org
X-Gm-Message-State: AOJu0YzzPByZ/jG10fkJ1gyzuNXW0sVocuYH4Yns+T4u7OVPwRm2/SvQ
 kAu8P5j3ftTKXPN2XNEXnKC1NiUsA61/wSQLbliJF2CqrnMg+fYtdIj9Lk0uwFv6/X0=
X-Gm-Gg: AY/fxX5d7jq0v8fYUHqc8bdgWiwciFKVeooQboJdh66ay5u4RAp9BEE6OQBvzjph9/d
 ir0PLzaOJSYNoIrc7aIR1wp7+LW3Tz4QsZDbAv7XFHihlD8kulxCoXkfN5/6GA5q4HYSBkmY6cj
 2TbEqYRVAAPJHNTBvB7qEwkjJIuG33sIBm2960ij4pdGWFXrbilk0OIdjm4PAK6H+0B9jCyuUgr
 6YX1f3+rTKb3PZYkIFdSDAfXB/VTFbxViO/79DYXsTZm7O+JPzYYCzVOIxd9HrTpUkBzNIyvxcI
 UdZCurFysRHG3Fca7pqO+ooUHjlJnsYOz9lg4kuZL81u5govI6bVrABxBDbVO7LcDmQDkkJR3bB
 x5xG5q/YiLM2+F2TBXNDIUe7aMY2zjD9ElDD4mdMr/jwfnWK/wd8gLpA/Wqr0VHkzyPEjD3JZx2
 1LwqNjZRQdkeNpZu0BI12apajrcc2QAg==
X-Google-Smtp-Source: AGHT+IGXAYqegzVrMA7xJBRVtud67UUHxrFz87ajkkjIbWfj3dGtKf586gWft15XJbodAHfjMon5Wg==
X-Received: by 2002:a17:903:90c:b0:2a0:81c1:6194 with SMTP id
 d9443c01a7336-2a3e2d2551amr9700385ad.47.1767644353140; 
 Mon, 05 Jan 2026 12:19:13 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd2b3asm905335ad.88.2026.01.05.12.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 12:19:12 -0800 (PST)
Message-ID: <ad81b4ca-971e-4560-8d91-0e44f6a120a6@linaro.org>
Date: Tue, 6 Jan 2026 07:19:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm: add {get,set}_dczid_bs helpers
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20260105154119.59853-1-cohuck@redhat.com>
 <20260105154119.59853-2-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105154119.59853-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/6/26 02:41, Cornelia Huck wrote:
> Most accesses to cpu->dcz_blocksize really care about
> DCZID_EL0.BS (i.e. the part of the register that does not change at
> different EL.) Wean them off directly dealing with cpu->dcz_blocksize
> so that we can switch to handling DCZID_EL0 differently in a followup
> patch.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu.c               |  2 +-
>   target/arm/cpu.h               | 10 ++++++++++
>   target/arm/cpu64.c             |  4 ++--
>   target/arm/helper.c            |  1 +
>   target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
>   target/arm/tcg/helper-a64.c    |  2 +-
>   target/arm/tcg/mte_helper.c    |  4 ++--
>   target/arm/tcg/translate-a64.c |  2 +-
>   8 files changed, 29 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

