Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F72FC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0U2-0004li-E4; Mon, 17 Aug 2026 12:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Tv-0004i8-GX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:46:40 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Tu-0000bs-4O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:46:39 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15d47266baso408646466b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786985195; cv=none;
 d=google.com; s=arc-20260327;
 b=nIZDzu1IR2KZNcJmCV+1qvrKtbeUkdheIiggD/Avz4+7SM8x5v0M6LldMtkAh1aJB5
 B081tP1/1IeiVR08rkYn2AAc/n7JihwIRM1d7+gKM4AFJPFOT+7UpU5zWlFWMi52Vj2/
 sspi4+7r0GJQMIGjxZEq8hWYAcSsshdew7UFw2STtOFNI6uA1KWW5FcvuV292PXXkAdF
 BnQIS2Ph9ZDDuruw+5W5F91Ug44iDheLCj0Y+8xhjaZo9KWgEDlImMxP6zSu2xbYht7a
 EPiaXCFFxWt5+DC9tYmL0ZP6kYMBFOzgG8V887qtJ5UbAr2YTmt6xbWAHii1K26YIXe1
 luYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AV6goHSKGsE3VVTq5jrrNh8OWghK6XxWxIOBN/w6kL4=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=jeVOBWZq0liKuUI8/dbZj8HoCGMiXsxrAvUvS+0GoJ1t0+qml+Yyfeu7gmO3ZMx78T
 wt/HROI1NKNiQ8+gWVE3DwaR+xVHhQZxVrpcZy7vdYlccX29by8eD67t96CUtj18Lvt3
 mpYr0d46kfF3RG/4jy9klfVcV9al3xC6BycdPFwY8l7O+KJaC+ePUoSNtDgnvGYLh6Uh
 5R0cX2RhYueg1IoUyCQLcdSmv10TZfVrhIAyzVHDT9bYvzDWj9GTUhyVNKYB9cDT+/Od
 Kjm+PDcxoSCevd7eUhDKkW7iKCEBRM8Z40WRgmB4zn6AbzgIOcX38r+LjC/tTjnT4ymN
 I+eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786985195; x=1787589995; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AV6goHSKGsE3VVTq5jrrNh8OWghK6XxWxIOBN/w6kL4=;
 b=Tg7td4ZfornlkPUXuHjNCDOckFmQPGGJR1Bbqcz4BRWeI8+AgSuH2IZaEZZoLFTuQN
 dgTQSvEf0b4W2Lk1NAlFOmfvFqrLqiHwYHo8zrrZY4/tcQGMbguFuSjLsYFIhc7xkmKN
 RtgoRJZEPDoRHlP4V51PukJVS5mN6xW/OFOHXXovDbxpdSuQIbrhnI5zRqEohn5yjPh3
 wxSQIfE8fsNM1eDAc86sJQ+i09YvJmJVvIIc6QYORkLN6tgA+WShZ7U+S+bKeqhnW1Nz
 ygjbDAXOhGsPJVp3/DzP9GfAZGT1hgZij6bWjn4nA21rb6hoUkOupa7E5KbCsRJq0RrP
 pJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985195; x=1787589995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AV6goHSKGsE3VVTq5jrrNh8OWghK6XxWxIOBN/w6kL4=;
 b=dHE0JwMhIX38J2kKGOSkld9KDcOTgKCt9RT4StHEaZcsCWlPXXxoQhhO1t1beb/hi3
 TPjvU6Sh4mhF7uK/fnu/pXCgsnZkbO2BJBbDTygCj6t5e5DmcVU6gTjYSqbt4p7cPTgH
 cdGxxtJlwTIWUckZI6+IWhCmYcmxsTTeF0RSPEFPqr2md7+X1T+eyc8P2uLbJVYBLzu5
 SJ8KtqxUD9QrxYAsFaTplHhoxXTLPnbgrZgYW80pUgXwmJqB/9Ibbm32+AG6h2tt+9A/
 +Mav/mRUgZ4Hm5uGMkS9s3JJAHopU0j1tOUXFXr/gGiH0tYQU3/iBSA1QJVMt5baeY5d
 gVJw==
X-Gm-Message-State: AOJu0Yx+0sFTgKQGSPbHpxIgkcgmudqXX4qL33G11XHIjneBTtgSAoBR
 GrxphaLMMBjfqw2+3jlHn1AbF5NAQym8/JMBbv1H0LnHcXigXAP3Ug6WujWJChlioMwKSgu8zgg
 XC1kjaVWJs/d2RtdfWJEmx07cHgmt2jVqIWvDFQKGZw==
X-Gm-Gg: AR+sD11MAzPgM5kIU2HudO7M1XHfWXpnDJ/6ELhaMF1lTy4lj46z1T4F0FXdC79a8SM
 U9csOxcItEYzwCk9xfGqeimdggXvM8JTeI8ChnQ1j35QgZ+LWqZTl51pDHM2shRIsSofpqwYQxB
 nUJ35CkBmPl7HcyZ9ViLrJuRqaa6T3O2XjGq6NqBRIbL3Wf/HttweUxtCyXcnI42KS+JCTEpvga
 kp7dPuEVJMxbS34Y83r/uKWH/ns7CBFWot8bKojBd/fXRXDENFNy7mEVngYg6vj7XjmlYuBDETc
 zd74uRMTeuT9xRacz8oapHGMRJP78FMDxjhGPhZX4fqzqBrITDGNWtbTwg/mHeZo40NO16qh7le
 bAJDRRUxa/SguzDgkX3XS5qM00PaP
X-Received: by 2002:a17:907:928b:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c212a1d6bf2mr1218417866b.21.1786985195282; Mon, 17 Aug 2026
 09:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
In-Reply-To: <20260811191540.79882-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:46:21 +0100
X-Gm-Features: AcwNN1Xe53c6TAmOJb9lfsZLZ4m_quFlY6T5mqrZYlWgXwPrMYhO73vZZI3FaWU
Message-ID: <CAFEAcA_7dF4EjcpkjhxwG24J4W7ST4eVVLM0YBOeFK097+GpAA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Tue, 11 Aug 2026 at 20:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use tcg_gen_ussub_i64 for WHILEWR.
> Merge diff == 0 test with bounds check.
>
> r~
>

I guess we should have a Fixes: <whatever> and a cc: stable ?

thanks
-- PMM

