Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDE10AB83D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67yP-0001xp-QT; Fri, 27 Mar 2026 10:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67xv-0001sr-7A
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:15:12 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67xr-0006jD-7U
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:15:09 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64fc6b21789so1409201d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620906; cv=none;
 d=google.com; s=arc-20240605;
 b=Vs8r7mU+Ten+3zGA/D3eNLH7Nv0aIO5QktdHsmI+jUIGKnbfV6xwP16ZNwFhiEVXCC
 Vhk1q560U5tsLCS4G/80YP4pDBTtiF7TxBimHVDsEkZyw5aSc38UesHe6I4Y/WiDansT
 consjwkh1QBy+s7WdVFT2P0pGr0HYgALoe5lRkBRGFsJKj8D+a/8QS+rFEHDG3GirlhW
 NPVmInMeQXEWfLdrEQ91loG+sMqtG8UH4rz4nCksbtFJ5vlw/+904zLAKcBVUYn8qMzT
 CyWR74izfObe0CZ88CCvIqbykYzNxrQxnTycsZ/+7ZsWaM9YhC1grdR1VVK9RSSMgzYB
 sV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
 fh=qqxWUM8cCPjQSx9Wp4Qlr1tA6UvCZ7lVroduyqUQEAw=;
 b=ZH5JSWW9Qb8rI5VJuVp9HNSp0GkPpBUXomU5CzzsruxdSX+D1XiEquSSogr82BdauA
 7YttsQhjPkpdB4HcQLCTSKrwTD6TQagytbcLbpIaFi9bCyYTZH5PmW+WzICfhmMqebQL
 7dwY8PbW5g1xAEkuKi4rZxpGWjsxXW6K5z0cQ+D1O9w3AlXHAzgxYPDKt+7Be/ETrf9E
 zYdPsdEvns9kf+D/cuO2UbLJEnb4oEU9Yo4PdfJqIjTJUxotPhsscPc9MKw62PDfZlnI
 GTo+kEgkzUailI6Y5tqJgKQtA0Cc+FejGCZ2GYVfcwCE6K7o3elJdmjaSUeDIpku8cdF
 SFFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620906; x=1775225706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
 b=PvbzwMJEsgI1u3rp4g6kU79O8SBXwKofEjUhmWBkXaWHt28aH0CgtjR9V+wQfP2psP
 z6P+FpBt2XoBn1Kew12XBfOpOa6fXKUwazBT7ppDp/KR1JbXovDgW65dqLri5oCkCjZs
 2/sVbarxsE2Udsjg+xQlkwXNowJ0IY11U9b0ggYqrVzDaO60Y/AW1oJAPdekp8F54EQc
 jrgfmvlyw98ZoghUI/B1vFCCkoewxfOSHZWJRO/KQYjWVXYEUU+uKfBWnIooDrIahfOE
 p/0B6Rh+QQvZoGIRbUYDFQ1GUDPi8zw/EPEhVYfllHHJLGIaLlwvf0O3wuZn4JNGj0VB
 5ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620906; x=1775225706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMoCz01d3cmlBMF4Ojv1E+E/bWckDcyAWJZe1tRwo4s=;
 b=ODRisOO5O2l3xMW16SMsDIrOo/ykPYlN4P0TTqn69HL2jJtph2zV9EWU7gdi0XtYaq
 T9EFEs5gCTNYaL90jGbdnJHp570WG3u2NfsR01Bu0lFxywkD7U+Ptltt/sDtGo5HK367
 jkUbb9nvi7g94no6WX+ckWGHH6jmfI7HvESvYARfatnxwD/JflY20XWTZQBq7NJKw73V
 zZtcHcynlkUaKrTp81JfhykClzIxqcgVEKyk03v9EQNGMXVD2Xc6vFl8S/jlJO+nawBl
 BwNQ81oPDSo8+oT/fLsq9j2LlaoJVPLLBJbyTcGtMlFB5A3lPVb4NmsIyxoWKUpKnFmp
 pQDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFkE6/Q+QdwhMUrZcj+Jjt0ZjfdZz9vqyauWp94EAhuD9Owk4Z+1tXPB43OQZ60w+HRp42WC0ERcfJ@nongnu.org
X-Gm-Message-State: AOJu0YyHJKUVeluP87XPJx0jGeSWiGF5XXhhzxdUX2DRDmDU8VhtJ6Qx
 U7mb3/b8SQR4HAOPFNQag4Jl09/pB9AJG3GN+Aeln62A4Ehy3tKfwCRF3oGDmJYT2qLAu0li4Na
 xE9TBsZCPMfGIFpOddJnbimERjRpPcZURRHe56WQqVw==
X-Gm-Gg: ATEYQzyIBxNYYNXHRIcX2LT20KmYsQ0yAkfnqR4nB5DZooBRQIt9SXFwEk2exIhiUU7
 Uoz13l47cOj1aDfGetfY5B2IAvoAjWetyjHfYyR4LZhMGn1ebj8eUNlswjNfhy5Jc4hYmyrnS2R
 B0ZfgdqqMo3riba05VIOQFDtGGYZvHxwM+htOmfPNYRyV8NXDZvGltm3AYCqphWh7h+0hDnQrgG
 eS7T1J+zuitvWGX9mlp1vHbnvJym+d22LEhmekav6LiHM8diWHLE7ae2m2RPPPpFhd0/YGA+1wH
 0MuhNa8Ivv8ajkDlVjmAiRWuAIu8kPnTzadOlHLpQnOQl6/HMK7oYecVbsayOQx0TRgQ9CTemEi
 8rA==
X-Received: by 2002:a05:690e:169b:b0:64a:d04e:a340 with SMTP id
 956f58d0204a3-64ff71ae9fbmr2663602d50.11.1774620905698; Fri, 27 Mar 2026
 07:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-7-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-7-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:14:54 +0000
X-Gm-Features: AQROBzAb9vsQ_kkEVN2eAQD5ljCjhhyX1HQ5iCE0-l3o0akiYD6zlpbtJhMxPgY
Message-ID: <CAFEAcA_EeyGk3TuUAN9doe-rN4gSD1Gvm=N9x16MZ5HvQTZFGA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] target/sparc: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison on boolean property value to be a plain
>      ASCII one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

