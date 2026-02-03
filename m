Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB1BE83040
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn76e-000523-HY; Mon, 02 Feb 2026 22:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn76V-0004v5-76
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:29:28 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn76T-0003Av-Bt
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:29:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso54280065ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089364; x=1770694164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sltVt2KjaeJK1bdwL2H4RtrAgjXja8LctnyYoFfFy3I=;
 b=bwqEMZJBuu38WuG71zPDf5OnGCzr6t83s5FgGXkgXaxB97y5OJQ/LXPJRn/H8FnS8Y
 bMZ0uZOKUlpxrrZBbfYW63c8otKPENihoo6mYKdC92UchZw388zxh2E8Xso4GCBp6qo0
 F2jShvWRc8EjC0+1BZiYfORQm/hmYhBd2HZDI/h55gcJ6mSa8mMnTSjDsLMHqzDUYkfq
 w8eVBV3SUjHdmmRSXkQS+H/PS4+/ZRVKQEAgvTRwJRrSkZq92WlVeAkrOULqQMd1YNZp
 IkmCzuPLuu1t986g1xaBI2LQHRv027PhiQ3ji5xXbvPOVSCZP/I/t0gAA0/+Sn1Mf4B8
 2LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089364; x=1770694164;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sltVt2KjaeJK1bdwL2H4RtrAgjXja8LctnyYoFfFy3I=;
 b=HixtF52c/unhnJj9SsqMblQ+qgVolaj4BZi/PF8HjZnjLQc7Xy4tRiM75QKp0eGlpw
 An4a8yqSjeHztLdqm7dxgumCi2nLgacT02wlDiM8R9Dby/3ikpbUYeL6/smUXNrvHCQ2
 h0zi4k5odEs5rJ3XhI3nNF65wGMtcBAHIkBVpYaAydMVNAhAgVI7rZhzpO1v+KZ+eGzH
 HUlwL3l3TeCUyyDQYXslDC0wHC3It2+CDosE/s5Lh7xpOcW5RLhcyfFUIpGDQH4J+DDu
 cJlD7Gu2cVbtGhRv2h688qQpBvB+Tin8SAUTN9QYJz0/BWTKv9nw2ZWBtwlCUWAyUTf5
 jnWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXThHjRdslkrV8IlGxFSOP0peU6cv5b3JSoJU0z2NOAn4SCa02InP+Ct6qV97W1sZlMxKAzxLkoLZqZ@nongnu.org
X-Gm-Message-State: AOJu0YzwlFJ4fiNsKb5b/adMi2ioZ8IHzw1ZcNMLZmadQux4OBlakqFw
 5QJBFYtcgDSpYuSJPwlQCMf92wgoQEEvsLcOuofZCu4JyObX5lplfVsJkvMBRBxBRZa6vGqq8cX
 +HFHUQO1Uag==
X-Gm-Gg: AZuq6aImjPNfVbMPxTzDB+pD0H5hwjScALNc45XItoDdqFkXmuC4CiClqjsu7SNpWeT
 NUlOjcNFCbemfT67m5F8uQB67OsceI2Gt01ZFkjkqMlszGaLqmhFsP7vSwXsTfPShlc5RrUIKyL
 QBAVxAd8fZDMfQoFr7NZarx3Dv6d9f9rem4mPyIUgX80HuUVJrzrQw9npg8T030j/F5rpVb0LA+
 JWfyxKrp7HbdsCec17ceXtbcTF/Gcng18XOqH7m7obJS9r3LosLtuwiAErtlzM4lvQ5Whs3QDjh
 5/w9q24n4jGsyACa3v8LI++g4+outI6pcthBXc2s8Yi5MkIL0hBcFK+vG5p3qEEWluVzSzgDc0A
 wdM0XiWjBD8DbnvzyY5P/1zE8EAruMa4Y5oXLeLvBQz9vPHWBtHCGr1gWkpYK7YYYOxIApn4+Di
 r31eOEleS3HR0/zh7ITNZp0BKIIb8MWBvQ5V9A/ww6tvJ5xsjouGkS5bCngro0EGIOzjfEjlP81
 6EJaVOaDknvhysmzPEHG+bDlTI6fh4QZnH256/dJmla3jGcLpZ2
X-Received: by 2002:a17:903:f8c:b0:2a3:ec72:f462 with SMTP id
 d9443c01a7336-2a8d96e3854mr128982395ad.25.1770089363864; 
 Mon, 02 Feb 2026 19:29:23 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b417394sm155292885ad.42.2026.02.02.19.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:29:23 -0800 (PST)
Message-ID: <aa8ecbc2-f688-4d8b-97a2-7265edac8ac6@linaro.org>
Date: Tue, 3 Feb 2026 13:29:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] target/alpha: Remove unnecessary target_ulong uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20260202234550.34156-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202234550.34156-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/3/26 09:45, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (7):
>    target/alpha: Avoid target-specific migration headers in machine.c
>    target/alpha: Build system units in common source set
>    target/alpha: Replace target_ulong -> uint64_t in gdb_write_register()
>    target/alpha: Do not use target_ulong for trap arguments
>    target/alpha: Do not use target_ulong for page table entries / indexes
>    target/alpha: Remove target_ulong uses in get_physical_address()
>    target/alpha: Expand TCGv type for 64-bit target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

