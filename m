Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D366C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7FS-0007S2-KT; Thu, 08 Feb 2024 11:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7FR-0007Rh-IP
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:27:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7FQ-0004pE-3s
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:27:37 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56061ad3d3dso75388a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707409654; x=1708014454; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ib0zpQvZqce9hgQ2qOlvF0FSGeNVQok9J1UbRHD0HBc=;
 b=e8PdnSxRjY3SVVBMpcTqcD2Aaqccs3rcMagxnArEWOdKsI83Q+Us9b23QkXJ1c2k0v
 wHxIRM2yBaxN4dZbeCvJ2vI9zwNl2rbmzxq2AIQJekO8mnD/zTanG6PdEYjLFRfW7Sr9
 SommZE8lsC4SZjJhCZ6miWr/fyGEoQlWhH6INgiM27WafEom/sysKE71LZRFFr59GVQv
 M6AwQ2QBQZFt82oecr1FKBXOC6rmE9GmAGEDPzbMuL7kYvErXHzCaIlT0StCCZzAgX9I
 xtZoMSvYB3qsSSrae5f++RAcOuYk3UiLvcgsHE/yz7EoP5uaXAvcMxvjgcwaZTfabGF/
 li8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409654; x=1708014454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ib0zpQvZqce9hgQ2qOlvF0FSGeNVQok9J1UbRHD0HBc=;
 b=TGcBvogBgS4JoSFtXdXN1zF3JiLWz/gvaj5FVw81tzPt9smCPGAXp6nqeBXF4iYGMy
 PgRX4juJTA0PHd6uMlzOXWW/fIVOGMMPTpqsXmqUR5CSBp6+P2mD80SgNdpYrVkAe6XQ
 C4+jixxVRhCMM8NViSUKU6xsuo9dpqnSSkUXp805G8aCiYOtowPqBWtdsTorMrwtc6Cq
 YX7HnGa21m8RxzS9dkVjrvF2JXE5YXJUUhkbA4xrhFyIMl+nx7kRaua1U/WTp6HuFwIR
 kR0vP7seBS0LKp3a6IPRVdlD8vBpWnLEZa5A0rxHCZfG6mVkYhdpa+pyySUb44ZykgY+
 8mpA==
X-Gm-Message-State: AOJu0YyHU3YGx12B2fC8lTYr/TxkXHDnt8H+jRTj8JxmEUVuPCbUF9Li
 O2r+Al7yHZc90BpBbANAZe906ep3zD/qqynHc7ILiUZECu3mBxHVdtj27JptuB5FcOONwGjEdry
 wmCx8i2j5OmdYvz3T5SSSVyu3lPXxo5Ro3DNM7g==
X-Google-Smtp-Source: AGHT+IEdMX4eIq/B5pOhHM0PevHnUq7zkRUbH5o7hQno29IUjMcizlW/eR+7wMJj5KzLhx8rezactjmc2S/Jx+pW1Ug=
X-Received: by 2002:aa7:d982:0:b0:560:2c15:38b9 with SMTP id
 u2-20020aa7d982000000b005602c1538b9mr65546eds.4.1707409654589; Thu, 08 Feb
 2024 08:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20240207025210.8837-1-richard.henderson@linaro.org>
In-Reply-To: <20240207025210.8837-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:27:23 +0000
Message-ID: <CAFEAcA-ogsfj7+3Xft4k-0YmAuTqO0qpC5FWqdGE3ZdXuo4z1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] target/arm: assorted mte fixes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 7 Feb 2024 at 02:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v3:
>   - As if /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred is "sync".
>   - Fix do_st_zpa as well as do_ld_zpa.  Oops.
>
> Because of the above, I dropped Gustavo's t-b.
>
>
> r~
>
>
> Richard Henderson (6):
>   linux-user/aarch64: Choose SYNC as the preferred MTE mode
>   target/arm: Fix nregs computation in do_{ld,st}_zpa
>   target/arm: Adjust and validate mtedesc sizem1
>   target/arm: Split out make_svemte_desc
>   target/arm: Handle mte in do_ldrq, do_ldro
>   target/arm: Fix SVE/SME gross MTE suppression checks



Applied to target-arm.next, thanks.

-- PMM

