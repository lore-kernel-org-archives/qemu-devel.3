Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ADCC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9XE-0004hZ-HG; Sat, 21 Jun 2025 21:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9XC-0004fe-Hd
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:30:14 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9XB-0001W9-2N
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:30:14 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b31d489a76dso2565646a12.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555811; x=1751160611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zazw2wlsdR9z7hsuH+yL8Sw64ckET7ib1OsAm2uafw=;
 b=vbLFw0qPwscDcYNYl+YPQuxjq8gO7Ys7c/A5yll60aDAx60WTOMBQbLnbEF6djzjdX
 GAmzvjM+BmtnV4AAFwX6tZxxyHIxOfyDdOVpM9DImEgng3wHihpVnsgWdXkgAEIwMB23
 yTCq9GU5i6Q0MPelVz06qYL22QAI6z94oIxO10GlroS29B/mNlg1U22BFQZW+Ns7Ji+p
 fjn4hZDxPHt3n6AfDbbO+wgJN/mVKX3a/gYgb4j17JYeVHkVJQoLnuRocryK8/Qp0A6M
 8ixY80NK7++SPZGp/RFHkMFEF68MLTGWpSZNPYEbkX4CuJrlYAWioD29rCuh/r5ImLAJ
 W1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555811; x=1751160611;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1zazw2wlsdR9z7hsuH+yL8Sw64ckET7ib1OsAm2uafw=;
 b=QQW/Y5mXB6SQiMzI/NcPbAO22XKqRYcDNeQvVi/FpwfxjthTiOUHUm0cq8Xv9NeGtt
 ZZQLKc9Sw9YGby+mSQHQjp7R18mAlhDqdQM9i6CkLJWo6qptp3QUjw4Cr+3oH6Mb35A8
 si9IatybJyF3ai8UxiUohXXkSfMbUttIgfZcUsd52+MsCT+jyl0aYG2E174C+0haz6oP
 WoGAcjoj0BHsbpfF6K/qEnTv2Thv/fEBs4mIwl9pMssI8p99fc82x7YF5pVoYqp1U8Mt
 CZhTdBat+TBgCV7nA12wgG2/N1+cqwx6cXNoRwKmjIi8u897j87pjTRNn06JuNaejavq
 VIbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsZpkv8U5+tS00lOSxNgVt3ghtUzjb+npm/pg6K+CKl8No2JJo456RWtfxKnrlbxKlec7InMA61Eqm@nongnu.org
X-Gm-Message-State: AOJu0Yywq0sjjj9M3w4gBQkELboBAdlxV5kZb9lnsZc3sCAkbLWQArnB
 iyaxm4vAlvTlDvoZqzIlo9Vwzs2hTkXfUDI8xpmKtvr8l8WsHIbRsQ+5Sn/9FVLNBaOSL3/KeRK
 1YlyRgVo=
X-Gm-Gg: ASbGncsry3YcGTdw/tFo8Ys2nfE5FHbz+Onuv52mrBQIvUp+UBL6jQwxuOChAJoS5LH
 zt7hGX2rkGCLNJ+FYupz1l8ZBHGyI/JDH4xjLQfHC4dLeIi/YkGobY28QZtfgFZNlIWM16DsSMz
 wM2DWfF1Bj8KIwOx5EkKXDupkUSeZ4pSQhiyyTOek5c4OK5MgGn01FNwzBxPh5hnXBZDg0TX9aB
 S9a5OLc92g229xFY/cgBeecNM/ZTHQ+PUk4xSFYcq1baq5jivWsWs7pLfa807sk/bOiBAsOdgPa
 V5Yn4Tux+8HV53nVVDcfXR4kbTNjDmxvKrwd4joBo8lrKvxq5NXWQVGe9KgY6vmZYomPNaGVPl3
 cuE5VVDXexHy2PgM5UfHn3khLnz8v
X-Google-Smtp-Source: AGHT+IFB9/IQoWWZlcM/XkZ8yiEiWHMsvWORtYWOG7TET8WnqH6kZeXRweRd7DzBB5tgnK6QGsf5bA==
X-Received: by 2002:a17:902:d58c:b0:234:f4da:7eeb with SMTP id
 d9443c01a7336-237d9775562mr115727795ad.7.1750555811520; 
 Sat, 21 Jun 2025 18:30:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83d101esm50960885ad.64.2025.06.21.18.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:30:11 -0700 (PDT)
Message-ID: <15e2c2b4-4c1d-4944-a33a-1e3b02f094f3@linaro.org>
Date: Sat, 21 Jun 2025 18:30:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/48] accel/hvf: Implement get_vcpu_stats()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

