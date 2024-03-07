Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2115C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDCE-0008KX-Sd; Thu, 07 Mar 2024 07:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDC4-0008Gu-Nf
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:49:54 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDC0-0002oo-CG
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:49:51 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so1243348a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709815786; x=1710420586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJ7VaqbJclpxZItJ5O2/a9RjPhH7hcEalo9E3OydZ4M=;
 b=xuZUiDuQA+u3xFAYoRA3vwSBrKDdo01chT8dd/TOShkuZYgEvwpc/ErkYJ6pJLNU+U
 zNYdGwnLbjy6b10JQ8ZNhpvZUWyeL1EWscND59X6OB3c5OMS/SaYXJgoUa3a29EksuZY
 H+GZeuO4HHUmn5FBgkourQ93ANandX1BBBm0MgbrTljxZWcJqvpLIFJpd6Hc11b2lksw
 5CDZUKspy1/AFVzaBnVuht7PKQdoCzoLAOaQr7oOxR4IbZZmBGOIA5Kdoi8nJeA1a40J
 MKI/bye3627si6tteIqZCzQHTq3O34samvbp3hyLC8qQEnzAMI3eqWEpogsvGisTavQf
 9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709815786; x=1710420586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJ7VaqbJclpxZItJ5O2/a9RjPhH7hcEalo9E3OydZ4M=;
 b=jYToCGM+rZuNdlH43NdddmU5ec/wCLB6UpBCMROMPEchjN2kYHtWovCQdl8ZhbI2VI
 tX7TEe3h8agbMC4CpFw+Y5o3GL48pBj1ufbaAkXOxPEX92CE2eeOX8zP8GCtzcDMmyn9
 CPIfK4XZokALlIDo25fk5CHrik5zDeelSA2RBmbLrLN2fA1Zzqtzic5aeBIf4jQ5uZSB
 PqK9Redod6tPjiFyn2kN5WYtTm6KpuvBE2ltfwGTYegD4pMmQ1qRUFEuZO90yU6bkrCJ
 BP67wFT7HXiHNWxcU1QeEbIZhEGim1M/vM7zuKQvmO04RIz/TpvnZnfXBsGb4e5xYKw1
 oalQ==
X-Gm-Message-State: AOJu0Yzs99J6qrCpPbvRJcgbq3dIfjOM7fZQAQE4/D0+gMEFiXzNKtLQ
 /mwvA4A+AjUAFQv7ONf9wo7/veTgJBahY1EhGeZuHHwE5WMcRer78yiwoqxfZyosTuE3sL74iKi
 JJYwh4qGXeOaR1BK/TP080Kfz6Cp5JUYjYci6bg==
X-Google-Smtp-Source: AGHT+IHMUAgvIJdRNuiXI5k3LnNcfr1/KeQ8j8HSLqSLlfszZFhW6G4nztrbntuSJA3j5n7OSx9nKupFRKb+A3T5zYA=
X-Received: by 2002:a05:6402:8d1:b0:567:fb9b:37d5 with SMTP id
 d17-20020a05640208d100b00567fb9b37d5mr2280052edz.32.1709815786335; Thu, 07
 Mar 2024 04:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20240305163931.242795-1-richard.henderson@linaro.org>
In-Reply-To: <20240305163931.242795-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 12:49:35 +0000
Message-ID: <CAFEAcA-uhJy2jVyNqc=774bW70-FByPOXVJoQUH5jw-aAS2YcA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix 32-bit SMOPA
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 5 Mar 2024 at 16:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While the 8-bit input elements are sequential in the input vector,
> the 32-bit output elements are not sequential in the output matrix.
> Do not attempt to compute 2 32-bit outputs at the same time.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> v2: Fixed endian issue; double-checked on s390x.
>


Applied to target-arm.next, thanks.

-- PMM

