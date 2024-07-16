Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0659C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgN1-0001nc-37; Tue, 16 Jul 2024 07:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgMx-0001Ug-TG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:29:20 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgMk-0003s5-5q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:29:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so6955464a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721129344; x=1721734144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=noVFkfv9hSGerHgQRa8ex8s8rIJyLdiXzsYUcNYuafY=;
 b=y+/4vU65xBJaMtOjW0HmjYL1fpaEChGzf3VwLrusvehm5qh0SmVfGLB7ecnUqzbuur
 0uV+i2bH3/TIMNvISfsZCXnMa3XlWYw8GwEqL6WJRPpxlf/JHm7Q8XpKI3Lz1JV77HlP
 oPP1Nz9FGSqmdlXr8KlQmf1POcRy+SoO2VRAmTwfr/uyi9iqcGhr4JBU6D69oBbwM3iF
 OpKnEOxnMk0j2kwvtPZTj2pqjaZUuxF+7Q1OFCPHfTYgr3evDUTo0RCr5qBvb+ZycYlN
 0beWJuM5smSMeDekYmLYSqlDsQcLSr4Zl3kyZCdNmzAw52DxQ2oVlZODQKR93IupoP6o
 BrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721129344; x=1721734144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=noVFkfv9hSGerHgQRa8ex8s8rIJyLdiXzsYUcNYuafY=;
 b=K80+OU6V78a5XtImi2qHFyGCy7c+L2VD38tPSZL4W4Y/MJEJ2yGU2Vuc/ecbanyDR8
 58jmLV/9/nAeDVi9S2L7YVte+1cejjYYwlGvdcuZjJxgTjIpWTKPufFYdZ+phPJ1JKcY
 FnDur2IR2s2ZNQnENFNPyA6kI9M69fhzNGawyOWih3ez1j+Q/fwBw+ZQzH7Uo9VCgbFl
 AJ10ryb90zQqvj2mF7mFqSeNj+JjGqJ2A7Pr+SCuq8hkxQJtI1RE+ZbXAHjBw8a9bH5C
 44IFXoPjNvo3uB7a6rAmQsFb6JPUs/v+DBS9yom7u6aiMhzFoPaTFUxtRnMy3mMbuT0J
 6iFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7jZuvdeCdCTvRAgah01vUDb4Ib2SVILVvCCmM/luN25YcIAi7pmgTqj/gVai1jY5m96bWplBnxYjRe1X8z/rhAGy2S9c=
X-Gm-Message-State: AOJu0YzKB7SD0aQ5wr0mSyLiwmjJApkMkF+0cAoKaPxP2/P5KFRzMdnK
 SY4VaonD3EkI+3V39Y0vTqgwZBKe9N8czjT+hQtnzHodAni+2Hztni4SEACyHZtsA4bHv2Xv9VW
 28nWh1NrSKlWyGSmljIp1rTJhXWf658WsVvn1SA==
X-Google-Smtp-Source: AGHT+IGPOAxJmAk5wg1MK+6VsfmkOIqu1xy7VK6Jb4SiocFk0kazzWOCso+3VlU3RwvJPqRRCse/E5nW4XauBiYPMfc=
X-Received: by 2002:a05:6402:4316:b0:59c:2254:fcea with SMTP id
 4fb4d7f45d1cf-59eee14a85bmr1379462a12.1.1721129344113; Tue, 16 Jul 2024
 04:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com>
 <20240716-pmu-v2-3-f3e3e4b2d3d5@daynix.com>
In-Reply-To: <20240716-pmu-v2-3-f3e3e4b2d3d5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 12:28:52 +0100
Message-ID: <CAFEAcA-uGXSvv1-+jjwtxEg3oD2a6umqtsNqnLvnkJ-RGnTL4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/arm: Do not allow setting 'pmu' for hvf
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 16 Jul 2024 at 09:28, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> hvf currently does not support PMU.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8c180c679ce2..9e1d15701468 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1603,6 +1603,10 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>      }
>
>      if (value) {
> +        if (hvf_enabled()) {
> +            error_setg(errp, "'pmu' feature not suported by hvf");
> +            return;
> +        }
>          if (kvm_enabled() && !kvm_arm_pmu_supported()) {
>              error_setg(errp, "'pmu' feature not supported by KVM on this host");
>              return;

Typo (should be "supported") but otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

