Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B789CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yTh-0002wB-Fa; Thu, 09 Oct 2025 17:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yTf-0002kc-HS
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:47:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6yTc-0000Cw-1I
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:47:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-78125ed4052so1705352b3a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760046426; x=1760651226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n/q2Tws1NpxHkO24ZK6Gtpk17NNdM2TRsxH65Xby0tw=;
 b=SZYsKuQJ3DZiyvq7rgyLhYN2JDJ8lxf8sTZ6Zz+BR2/F6T1ww96aVZuJDKiPWbmTGK
 cvbIG3wK2XZIkm9ltCveFZEJdCe0PBr0jp0sCENVRiePEaNrt0Xs1nDjaq5XVZwxnE13
 sDQLe9ydIIjtzbCPE6Isp0Gkn5Z8CbjEOYhNnwtTnJpHIMM4Pds/Sejha77A0bL5NwyA
 BpxEj2LKCY2FXZK/pX3zPmLDcQHXCXVqO+vcOOTcDi8JibR5O/oPAsCGCFm46FMVbJWo
 mJUT5UlUBotvD8e/+souNku6NBeT6m25W3ALg4qY9em9xNv3ZfSOuUJT00ORrtfLW7HL
 M10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760046426; x=1760651226;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/q2Tws1NpxHkO24ZK6Gtpk17NNdM2TRsxH65Xby0tw=;
 b=R2CvYs8kbTcfW/wf8HPtTCZeP5UdgeIPQocq2pgzVJwaY/Gjk0jrLLnL4PmAcPfNvv
 vBQmrCt+jMa3FS1ctI799f9eTRzYjtz2EItV8QkPCN28rNH4Y9LnP4f6EsYS97ffMtMy
 sAXzZn4v4SGrBYoXqrDnKrBBlxtC8XguTvpNedsQ0Jvkq0HEahcARK/GXmFtwqLlBdyY
 DXaZU/6dvvaDyEuuW5/dy0Hhy5/56O+VqLmKlNeducuGBOtw7yjKVFD9pZIFa7h82eUL
 xOAE+Pmt/z+A/nXKcXNtzTKdV2SXF4DhYyI4U4Qpmjhj5+zx+IApu1t63gobr1PVWGRr
 Kddw==
X-Gm-Message-State: AOJu0YxwnfRs+zfDHHryPewaeJBsywQ9JDGntcSOjzHLlNjo46bRXw1g
 n+RM6WO5Qx7YEvXar00WOsX5ce2H/4oi3hS3mmW/qo6vo0B4+DM6iKkCF2r+mrBIuhNOGhdf6V6
 MnYnjwU8=
X-Gm-Gg: ASbGnctKK0EamIbivQquiflKVdm7tuBcA1bOKhNRGDXye6z1Y5Pgo2fEvCtHh3oo5MY
 Is082LgvBYl8z2NIBqTn8qjU4mmIK+l49Qxs6mGJHYANdnUlzltNJrBFdmlWFfkal9yfKyKfQVf
 1E3OqaiI2cVu7K/eQuhpWmZ67I5yKPHb5YF/T2/+K8FuXqyHrv/UsLdB7NkHf6mhuXYDFtFoecI
 xQPQnqfVJmObc9EeAOhLkC0A0S53kEntqflWl7HAvbz7ZcQXnBeUACS1XGRDX3b9VXNpv36IoMQ
 3vmhnzWbQrEPeIh+luN80OUIyuviY/gEWmb4vcpICisygMcd3mg32Y9KeyOijxPoM/OztbjW+Ox
 J0LhdJr4OBFntuDZTsd2GvpFLPqK9HuGQhIHQ1Eqq2X0/HVuv4EGOi0GX4KY0e0KE
X-Google-Smtp-Source: AGHT+IEG3Eh02OsDS5M5Z9rp0bLgSZSPNC+un8/PMDuIhLgBICUQPN5+9QYxz4hN6r81wksh1YEquQ==
X-Received: by 2002:a05:6a00:1385:b0:781:9f2:efb1 with SMTP id
 d2e1a72fcca58-79387146b38mr11843605b3a.15.1760046426191; 
 Thu, 09 Oct 2025 14:47:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d9992ddsm711903b3a.80.2025.10.09.14.47.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 14:47:05 -0700 (PDT)
Message-ID: <2f745e59-8506-4513-b605-b090812f8a06@linaro.org>
Date: Thu, 9 Oct 2025 14:47:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/loongarch: Remove target_ulong use in
 gdb_write_register handler
To: qemu-devel@nongnu.org
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009201947.34643-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/9/25 13:19, Philippe Mathieu-Daudé wrote:
> ldq_le_p() returns a uint64_t type, big enough to also hold
> ldl_le_p() return value. If we were building for a 32-bit
> LoongArch target, ldq_le_p() would not fit in target_ulong.
> Better stick to plain uint64_t.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
> index 471eda28c73..23a5eecc20b 100644
> --- a/target/loongarch/gdbstub.c
> +++ b/target/loongarch/gdbstub.c
> @@ -62,7 +62,7 @@ int loongarch_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> -    target_ulong tmp;
> +    uint64_t tmp;
>       int length = 0;
>   
>       if (n < 0 || n > 34) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

