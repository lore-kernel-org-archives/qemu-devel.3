Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E90FD4F08
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00l9-0003xl-8B; Tue, 10 Mar 2026 13:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00l5-0003xT-1E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:20:39 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00l3-0000cC-J0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:20:38 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-798374d0f44so2190607b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 10:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773163236; cv=none;
 d=google.com; s=arc-20240605;
 b=OVPba6BDWlPfo0Et9tG8M9WrMm6BnEj1f7o9S6GQbltUorIdRWjlGTLeip46OPWn3p
 c6JzCLcVkOdojl+Bxhbkoy9eDaZxiyE8eEqWSkFEISo4yqNpCsrCHd56DGysgMMSL6W5
 60t1wYVAs+q4BlXbpst5T2ChLlsxH39+R/lJPXlq9BHvwTKt5edqTDTADM3u37SEOT5E
 dhbcttRHononOFW3WnLVp9Vnr2tGh+8cjLp2/9653xRo7QOCwehIvYfmMY5cDE59omZg
 Y9Z2FUoMMWXRMcR5A3dF6Y4Et6r4iZo8nD9b2gMKz+PrSS/e7uhlGg/xJ9+Peq+V4HCO
 3zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i/1ZRwzCNkx7XBl7fOeDZrtwpTKjR104GGd6iOMqxzE=;
 fh=Ns3aSru2VPRhuB3XYjY+cle+pVsvqE6Gods3XMZJmHk=;
 b=cyNuW7t7EUYPLvR1pnlsSV2rfw/gfmrp6OMMo4M7guSUznhaYavewna/l8zZG96GAZ
 a/PAjsF45yc4pV4jGt3OL5Ospxe8JlYVjAJ/NDBhsEEqb5By0Z7RmFcVAwSAw0K0YCZ4
 8PSgxkMhRnlbbnJzQf5S/bDyMe6mUTAtSnFq4psY8HQWrpnOFTG8jWnRaagXeqSSpvYu
 ZwyjRIuuHyinKAoHejls9GghLbhJrQ4K7LETAT5hI1iFwsxuxNCoX9+E62S9VByszrcU
 jyfnr9bOPyzNd8CFrwvucVKmDvZwoyEStQC6RpGWVhBWMcunZYlm3IBSsWTx11ycd9ae
 bVtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773163236; x=1773768036; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/1ZRwzCNkx7XBl7fOeDZrtwpTKjR104GGd6iOMqxzE=;
 b=dB9syldOd6c10rxmJtgoYE/sTu7HyJxDcQL8zJy5hPvNcNX8i5HTufagixPANxO/Jh
 IFIQEKUnKQaFTJqTfgvjN7dULSLJVrmAVp4BLGMJz65mFB4Pq4mc52zNn9bHi8ATu0yk
 TlGVn4bJZvjmVGZACdCwf/sH8JliKbpkDCg0moVOqLFTQChrZJgCgWCkOMfwFUwNllHM
 mYUlA0+k/pI22pyjpRDlMLk3a4Ot5+Vi3PNpaZtgNFS3DK14DeoIJpoJk6lGmyMmXnJB
 w7TYmpJFyzoP2R7wjGC3QbhT00Tw6RA5vYs8F1dDotAf3VqbdQspSNKFey0ughlG7SVC
 mwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773163236; x=1773768036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/1ZRwzCNkx7XBl7fOeDZrtwpTKjR104GGd6iOMqxzE=;
 b=gg+9PDk+W5ytwm37OKw/R1LGQaMUSpCsnyWNpH9I3Jj1f0+0BpAS120tEe0/UvRxBk
 qkGgYHMv8HJXT0t5KoV4N1TA8zCVXm4y6kFD41u4WDwyEw3fqyr0W6kHllSQZb0duFFl
 KCNq2S0o3SFbsfa+gLZKS3/bSPy5WL9uZUgFZSTpBBcYqR+MDm9U/wwRJzdE+a4ODcsI
 f4A9vrOhU9NwSkecmco/lFLY906UxiW7WfqBm4q7pzBuHr5Ngq4WLtD488sugmjLPg3Q
 ifXzKEouSy8vqlIrURZCVHRu8ZF09pmUEo7ElA2SEv7iVB36GBnhb+rsN7fZp8oBW2sh
 SQNg==
X-Gm-Message-State: AOJu0YySrs3y4BTm9kP6eM3J/Vt2y33xyCYsP+WFQ+FBy6TBav/3qK+e
 6RlsVCIJi5sG+ygFaOHz2GlEMBsdOBTa3zepNiR/JpySGsLgF4baceAnLnR9+sbChdpnnXJLyaq
 H0SUQ+a7juetQ8Q11PiLaqlrSPuk9fxBGVl93FM9eig==
X-Gm-Gg: ATEYQzxf3z5fzXnwSMLKheV5UfX8k3xmb2R6A4ud67uoYrfD59PXp88JqBW5+W6aAEq
 9GbT8Cj+qTr+ZZQ+zyLXHypn1/oDNFc/NdAp8RzZUxSrMXeuG1nc/Vub/3mgwl7ewgffAVN6qcl
 KRy6BNsaKDCh25YwsRaVIAwIQfMemUSGaWHCoNlejw2zS6tPHcPIjFuQy8SBE/OAqkeThye59WR
 T5qu0qFINqsajzO4jozxz40DV3yfxvlwT7Ts9XnYR+Eez3Ci7BCqZBW8bXFBwMHoPWoMynR16bz
 p7s7ORgsnYjFuq7mg9kk+0akK6IQPLOGDf5OfMvTFGgoBvKLkHV1epOL3CePhh6uhsI=
X-Received: by 2002:a53:bd4f:0:b0:64a:e62c:16d0 with SMTP id
 956f58d0204a3-64d5a1c791bmr2690189d50.25.1773163235444; Tue, 10 Mar 2026
 10:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
 <20250308215326.2907828-29-alex.bennee@linaro.org>
In-Reply-To: <20250308215326.2907828-29-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 17:20:23 +0000
X-Gm-Features: AaiRm53x4DqvC9zV8wEJcz8eHYDkCn0uTD4n9vbeATn5XFzMkWMc52IMfyj_CuE
Message-ID: <CAFEAcA8M2KZZTwP8vaTfUQ-t9EOYobSoS6SGsPFh6oVMEMd16w@mail.gmail.com>
Subject: Re: [PULL 28/31] plugins/api: split out time control helpers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sat, 8 Mar 2025 at 22:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> These are only usable in system mode where we control the timer. For
> user-mode make them NOPs.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20250304222439.2035603-29-alex.bennee@linaro.org>

Hi; this is an old one but Coverity has decided to complain
about it now for some reason:

> --- a/plugins/api-system.c
> +++ b/plugins/api-system.c
> @@ -95,3 +95,37 @@ const char *qemu_plugin_hwaddr_device_name(const struc=
t qemu_plugin_hwaddr *h)
>          return g_intern_static_string("RAM");
>      }
>  }
> +
> +/*
> + * Time control
> + */
> +static bool has_control;
> +static Error *migration_blocker;
> +
> +const void *qemu_plugin_request_time_control(void)
> +{
> +    if (!has_control) {
> +        has_control =3D true;
> +        error_setg(&migration_blocker,
> +                   "TCG plugin time control does not support migration")=
;
> +        migrate_add_blocker(&migration_blocker, NULL);
> +        return &has_control;
> +    }
> +    return NULL;
> +}

migrate_add_blocker() can fail, so we need to check for that.
(In particular it will fail if the user ran QEMU with the
--only-migratable option, so we need to arrange to fail in
a way that gives the error message to the user; maybe error_fatal
would be OK here?)

thanks
-- PMM

