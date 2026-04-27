Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139E2FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHts-0003qD-LY; Mon, 27 Apr 2026 05:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHti-0003p7-9Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:05:02 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHHtf-0007PT-1r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:04:57 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79a46260385so111547437b3.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777280691; cv=none;
 d=google.com; s=arc-20240605;
 b=VSvhO7VHNo5HXwggrHwISw0DKyajUsXU/MVsjHKM2D+pQ2Smk+3nY+ZGVtPWvViVd3
 U+dz4Sz76HWTDU6M0pXDV5e4ero1JOCHQOXOaahAf7xHqDTTX1WdDGOg99y9c687KWWc
 5M1czR4HnkaZ/EaG01hbpFkEueN9i6q+rI4WlnDtYHK92XwzhiqshN7WC2Oe9otT7h34
 f5htsy+vlNxIpuzcCd0N18gQl6SD0WnNuAo74lLsArBkYNtDlm2f5GIb3qsjhhr5Y9VT
 sjd7cHfdk5pMjZswMd5lnWC8NFwe6NIM3QRJbJMr7I68BKtZYN68SE8u7wEL+GIEg6yn
 rMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LpYw5xfAKYbUjRA2dLrJ+YsP9hBfmAiCQXc93R3jdiY=;
 fh=GsqRHuRXCQaQ0M0mZZP9bl+1hFWXqZAloEQeMpLtTjc=;
 b=HVVpTMuVW6B/dTxIcth8NGvilgfaCj2OYgX2xopTGVj6Fm2C4uHR8XsIMpjs4L7QUM
 B14k2duvN/SOg6aRipUOcSEdB/9I45rpurxlPbJXvSbxcjJobuTygp/SVUffX+nwaGeT
 PrYQbjs1iPEj+Gl9TeqHhzlnPY0IRZVMJycr3ECZp7rH8uZVPe5nXnA+l0mm6/bzIEGt
 3fc3xdzkRcy6t90h2XqRRPRruELIQrldZw3T8srdzuyEdEjNPCdZCYZcapy/Dt3k2PK0
 aci1PvGnfmogDwhPZRp1UcVwhOFKnFlnuk0ij8fjjrq5u9weu0oe9DPx5jMG+K8J0lAS
 454g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777280691; x=1777885491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LpYw5xfAKYbUjRA2dLrJ+YsP9hBfmAiCQXc93R3jdiY=;
 b=GKm1PBxQGfp0sJR9ISwJ5GeFBGDneDIK48DUBmMniNkVa+zRqSi4LJ7DkHeO2vG+EK
 +RAodchHR9fFjs3fzo6STaeTEYx9ZMaYdktIOBoPQuLeOyuc7PHJnI3a0bcqDYc4BIdq
 Z9XWm2ZXhw7Db+W23NW1ETU9yKCzh92UEaKNKWZYRIddOC2VrjjbCj05grmV35erEOkY
 YUIW+LWxfyj1H/PGXByCsK8apv1Vqewey9Mtw+xkt/0kp11iZwukuKjz17ZQ/UlrvAXf
 Ql1EYd4kSxkaBz5qiBfv9IwxEBZ8M+l4kP+SHYfxEa5BYjMIxdj9qo0UK1LJLyAXrgxx
 EAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280691; x=1777885491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpYw5xfAKYbUjRA2dLrJ+YsP9hBfmAiCQXc93R3jdiY=;
 b=aQgWp45AVFg06eZNzHpHU638EZeMUfkH1TLhXMCc49hbJiX7dAjNPmySXczQf5VRzr
 1DZJqkZuwfGTrjs1CpMOwVqcNm1fsG1+sp+bbwWEqnSAP8T/I7CAQ7ntLit01m86hfvL
 A9BY5VydhXtTcabE0bXESuvITnRnAZf3fpc9OpCrUONL47AgtCd6MuCjSyb5ubG78aBC
 BcB/ghbjqH9TpNqUbefNIp06st8GKZkIu+uLk7bsSnb2IigK+wVDgIyO3NxYP0FM1BWS
 V6Jp45lcIjnEms48xXlXY1hfkMRM01QqRxJG/napHwhyio/EjKgdC5+oz6sxmXIMI/z2
 o0ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Gt2oQCI1il6DgcTAwlDp3/JYu9aOwrEuKAEkCihDB+G0K8SGV62yzb3GHbhzNCG5yRIaSf9ZJFaaM@nongnu.org
X-Gm-Message-State: AOJu0YwkWzOwhp0qf24YmhY2dq+VHkK83uW2l8BHvPjO+hfhP3njdaL4
 PpcAzm2AC8UlR0IRUf37OTlsxlIc6XvP0KJOHDVWgqkBZGzhEb0i1TQq4JePW7l9rT0u/DnOj5S
 CrcDaSXtqdED/KEfLuwr72neIoCiijbS27dXBd5r8Vw==
X-Gm-Gg: AeBDiesF63JuIjY5CQbKffSDs4XmhP59tgL2YVVMjPA+E+vKPvJ8OqTn+7SeEVdANxi
 dqE3ooKO5MhaKfRxD3fZKKKalWFYDDrN2USuINKyLkCXE7lYalS2ENOCrVRhQqhCYANLdIAGGVe
 7fJR6zqbWowe3oun3WOy6pps2KwCjiBnGhe13DioCK8Avy11OORR/yUzKv9mNRSUKWWxPfNNnF0
 VUI9EiXt7Y7SEBkGE83A0AiK0LrWfXZ5SCa+/MOdpbJZHtJGKk5qdOaRZE0wOFt6V6X9DLk0K0F
 m1fpRhl4YmrEEjxmihSwShAYw1i+U6QXliPpSEtiN7/hwG/nCTeHnSXjAeB6fS8kDf3E4yn2jul
 ih5l5evKXNqCC
X-Received: by 2002:a53:d017:0:b0:656:7c25:8927 with SMTP id
 956f58d0204a3-6567c258f1emr8733456d50.11.1777280691143; Mon, 27 Apr 2026
 02:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260420064933.64765-1-thuth@redhat.com>
In-Reply-To: <20260420064933.64765-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:04:39 +0100
X-Gm-Features: AQROBzAzJ-_Tfus8JWz8Rfv-y3VIBYCwlAqJFBCYhS0rJbK6xCvWyUywjPwL14A
Message-ID: <CAFEAcA9nuHHRKjvv+o7k6Zyi2AUUea3=trrgLY-9Lwp2kjuagw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Remove hw_error() for the unimplemented
 CM_LMBUSCNT register
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 20 Apr 2026 at 07:49, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> When writing to this register, QEMU currently aborts:
>
>  $ echo "readl 0x10000018" | ./qemu-system-arm -audiodev none,id=snd0 \
>     -M integratorcp,accel=qtest,audiodev=snd0 -display none -qtest stdio
>  [I 0.000000] OPENED
>  [R +0.001907] readl 0x10000018
>  qemu: hardware error: integratorcm_read: CM_LMBUSCNT
>  [...]
>  Aborted                    (core dumped)
>
> This is bad, a guest should ideally never be able to kill QEMU like this.
>
> Now, according to the "Intergrator/CP User Guide" from:
>
>  https://developer.arm.com/documentation/dui0159/b/porting-integrator-ap-and-im-pd1/registers
>
>  "The Integrator/AP CM_LMBUSCNT has been removed."
>
> That means this register does not seem to be implemented on real CP boards
> at all, only for older AP boards. Thus it should be fine if we simply
> ignore this register in QEMU and handle it like all other unimplemented
> registers in the "default" handler of the case statement.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3407
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

