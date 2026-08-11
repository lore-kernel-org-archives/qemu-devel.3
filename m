Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D373BC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjfZ-0007Em-Kl; Tue, 11 Aug 2026 06:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjfX-0007CX-LL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:25:15 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjfW-0004yk-0C
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:25:15 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-821106b5b64so15178427b3.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786443912; cv=none;
 d=google.com; s=arc-20260327;
 b=im6ba9q23+4q59ZyM3rBsb9dKM7m8Z+Ego/PzLTZ59JkuUs5d45qDSk+2tPrUJNhaS
 1V+B57YA/+3guhjDuWj2vKW3FHDCfFUpZ0JKWC9tG2yE1I3cz674rU52M7mihWQ/8sG8
 7hIbiafRYi4vrKGpdy7W59hl2HLI1VZw8gyeJ08iGsv5dD/nuKVPTkpiyOBi/IQRYOWE
 I4Od/5eiT9SEBhAClsHJAwrXH48xeuMwnVB2cEf9OOz90lS/GBk1sYu3pNI9dIw9qeTx
 D9GGsQjd+BhUQDU5xP//zGLkJ/E8mXlksl5+NoM1YL29X7bNssWqiroqYLNCtboZEqM6
 F7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uvdRbPu+mAOcN5Hl36DJm5zpu8FZi6IK1n/F9YxiBk4=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=sIEFzRdLJt+9U12A47zGrSxsPFcm1GQTGbpqdxQnhCzNaE1fUnERg7Bc5eqZRkn76Y
 S1DPLZTEAWN26rGN2KW8MiwKwuM4Ow86ryr/eRGYzAhHCl6C3N/+6k0cKoqgT+xwPKu4
 dWHdKhB7S11CM/LhANBU2QC6tH9SBFzcpZqQDRDFc3JUws/K15vtgVCJm3suXRBpkAiE
 1gF/iYExR7c9ij2wlre2idH7p+bjfZdxzmbbsQVd8r+vFf6b25SGY/Xsde8OMx12TWzq
 2ggrE4uWvimasa9MUrsuU4yUDxDFoa8KgCE8WTPJyAI+43KjjnrYcCmyVULshtADgiiR
 olMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786443912; x=1787048712; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uvdRbPu+mAOcN5Hl36DJm5zpu8FZi6IK1n/F9YxiBk4=;
 b=Md5isdlwasTyvDwcPDdQK0L52NB3CxIv0De+AvteCXmg5skXfGgAeC0JyrGNT4Ve4g
 1EjCF2JJLZ64LOBgTrgSRIVNTB7MzR6e0eEL5Iin+JJ4I777F1t4zWmnqcgaqUjgeoW6
 r4FWfAO3ckTgaLI97J/3+OyLHR8wVqlwCfT625Pxl+n6x99L1gRVqWzZDAlSoBs4giiR
 OV50y354mIzxM1CIyfobiU2q8zUr7fwtT430fnlExKTaSHQV22R/QME+0VKYVmXxOcVu
 xPI7REVFcJxr3j0bgdbgl7CO3dg+MTN8Z8ZOg+wXKrDOaiDg7/rzh9fKCslljfvGv9cf
 su/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443912; x=1787048712;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uvdRbPu+mAOcN5Hl36DJm5zpu8FZi6IK1n/F9YxiBk4=;
 b=aN94mVzgxzG51v5ZYLD09/OJc8PT2HTAtTIQi3urRBDQEHr0Siufptb9dBzmk4Mf/U
 o2T3u+FvPOP/68UDU9t5cT0YF7VAc3Mz2sJsnYYxXt7+iGeVygHCqjxajrXSp9j5Y3RQ
 eeC0XrgZerUUPSQDkhqZaXhSN5LCpkDEiMUg4hTn/NMP9R1vxw0DfZert7G87t0yxUIT
 b4a7blEb4uiUR19RLopTaxIDE6UrmNCJfJB993TWqcaXbUXAgzVOca/q3O7kLPu6T7hi
 NTW2wutVc/VSIQ4SC/buS+APjbAMYfDeooGex3Z+2HyA09+SR47QNGtXI2vJSlaVvRzM
 4xSA==
X-Gm-Message-State: AOJu0YxcHhHexTAXsS9vHaDuaUVOEHhj4zaD/t7FpfJK7So6MJ1rfy8E
 dIrSRoImZGB99l3aUu0dO40XxAdlxrU1cb2xfj0ZI7B9Jk0mnjJKEwNhbzk3h/tnPBGR9n5dNES
 GhQELSvX6hD+bPerK1kXJRcXex+ZVds1EQpa4jpP+GoSMd0tKOjIr
X-Gm-Gg: AR+sD10TIUKjTHzPQKkD8ipqEQBAMWg67IyP8rFM4Ne2svdjMJRkLnq5FNlNv0fmXUx
 sNJxXyrKR+X1wDGjWWzr/TTzwvDlcNP2CccWbXMyFKrqNGO7CsjBQDpf6CX0+MhBgLvvdtLHw9w
 3cpaz8xfEYN5dK1Gr84QbbP1lCpJoBo3eYfpW+StTlcCuOpuvfcqgdndnmA1dP+qZVu2rlu5bq5
 0jOUXmVYDbfw3RRGC0IunHkJ209nGR4ap6B1FKOcByFN20POHUCFyC252exAXOD6u7q8gJ7Y/KV
 t6Ss0dHqlnrRhpsLjU5ViegX8yKw7mHizIiDsjo3XR5v1ZxizI0xbBfW1NUc+I83pCS+8Yj+kCm
 DL4K7TaR47tRKbZm8okFx7y3vWetG
X-Received: by 2002:a05:690c:9988:b0:7f0:38f7:6ca6 with SMTP id
 00721157ae682-82f215a85dcmr12427017b3.5.1786443912517; Tue, 11 Aug 2026
 03:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
 <20260805191257.11303-3-simonxhy0404@gmail.com>
In-Reply-To: <20260805191257.11303-3-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:25:00 +0100
X-Gm-Features: AUfX_mxVmi4XCGO_W80vDo7hanxtZJqVL-uOwAqlMX5bxcLjVhMqkmM0gydN6j8
Message-ID: <CAFEAcA_f6S0XTL-v6Wa9n=vKJMob4xm4FhDDSyC3MwBbgOH4ag@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/arm/armsse.c: fix SSE-300 PPU addresses
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 5 Aug 2026 at 20:13, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> The SSE-300 CPU0_PPU, MGMT_PPU, DEBUG_PPU had the wrong addresses
> that were the same as the SSE-200 addresses.
> Page 146 of the SSE-300 TRM defines the addresses of the PPUs.
>
> SSE-300 TRM: https://support.arm.com/documentation/101773/latest/
>
> Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>

I got the SYS_PPU address right, at least :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

