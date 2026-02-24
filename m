Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B4EF3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuusL-0002iQ-Pn; Tue, 24 Feb 2026 11:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuusH-0002XX-NQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:03:01 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuusC-0001pD-Qo
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:03:00 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so924348066b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:02:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771948965; cv=none;
 d=google.com; s=arc-20240605;
 b=cdFGEezL0tbHNJWD2CAfmqfAxDIIKzfJ5CR5NwFzBkYoyiFaGdoXa+1ymlF2XigWcw
 kFksecqe+UUJP7LXIQkuH39UFlUrJE9WLq3XGFOk8fjARE8QzWmFi4+W8JjyJSJTUvga
 7KGtxt3AgMe615idg/OpWULCRLXE/+7/Ps9XsAM4oRkiYW6mBXbqyRrXts3rSyANH5+F
 pEPuGywFhnBaKB93e66joj02gmxQqVWUPkletirP/5rQsADAz34xERgnCV82jlS6SZjj
 E6wI/PWd2dZgNTScM6DT1JB3XDI0/GnsfkrlZuPJ+h6TSoJmaX3fmhf0tIkxM1caVYQi
 tv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u7sPKV3brofakR1UEqXphmFxjaegh21/9ejPoGpH5zM=;
 fh=DaSAIivXX/C4o8kfUhBlmXGwFHGIlaD/jncWGJseTBA=;
 b=MbjnYTaLpTn5X6LYittUuy7XVB0a6X/DNsTCO0FgLdnrT/bQxZs4MznuBA799K4A6d
 sYA76pJ+Ni+/J09xMcWaMej1fVEM0PZ3dUAec3HzMSeC+hA3m6FKdjx3nAYMk/UC+O/e
 AzMcFYnbE0MozXdYt31nBPBnjDBsyE3dA4lQZtvKyQcoqC389fN9Nul7qpoFpGOsW91K
 0Q/BY5Er0ZYfGZY7F4vWCxYsvbmZcul7CHBAL8yRRqnqfH8ff9od7jx9HhE3Vxl8A6Hq
 9ZiuabzJX/Ar8La5QHIHUGpqdwwkHTjttwGlAABMRbRDzHJx0ENcT1U1zDYW0fSiysBq
 D9ww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771948965; x=1772553765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u7sPKV3brofakR1UEqXphmFxjaegh21/9ejPoGpH5zM=;
 b=rPVxuaPrlEInPAFq4x44mAi3Hjb4Y70TLfvzpM/QT7fw0m/Knp+SNeOcQ7FH1zMBfw
 84kMaY61X5LfQ7PuP85AN06YvvUO5HawF90HRhfmeRVdC4QfT0mPGGH9b+aQTuzjSURN
 eKILpjh2eFSTVQspNWHlLKqLSFQWlBj07c1Z5rgHgmJBuPHxcbVDLoGm1a1HVrXjzAt6
 NawWtaO+VSScR0xaiOgvTO+zKT9dOsrCaNY/MJAL7XhbyWXJ0ib+A4PBrYIb7ApK3r8q
 yivVXNuHmH7sUamBv2au/hYm4FqSaL5+61aepWW4GqWwSxqOE2qSu2F6XgOu/+QxXuAV
 VQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771948965; x=1772553765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7sPKV3brofakR1UEqXphmFxjaegh21/9ejPoGpH5zM=;
 b=G38kMH2RATeeGVujuTTu/D+5Drf8pZDYKQFnaQmh8sfQJkda9aXFiGsO/meF8JjOMR
 BxYmbeZRHMaiU0dVaUh1ygpypPDeda91+N1fN2xvsfkmTTEgee0UjOKjAcZ+n+bdbfa8
 xY1eWrgFw+HRxmSFQGYx2p/bnX5TD0XIT1UWyRRELoZeHnMBEGE5bWMhHSaBx+Hm6PHk
 fEkZzczMiSlkRgyj0gf+tmT6p6X0BGIF3j/1McJyWBzXBlWJ1MdZ9Uc5SAjwohL68mfS
 69fyZdYKxQRr4ckQTiVc14yqq7RR0dogJDk568SF6of8cnhv6dbDc7Z+x8wJ77RJsx9t
 E1tw==
X-Gm-Message-State: AOJu0YzGEQqM+8R0wbgi06toKGNusOlANTFIGUFPUAJD/5P68LYEJtuR
 UoSiryLcahK4IRzIYzYEYDhHOzBYKAXBvnWPZmWeUPknUoGYrdvzMubPJarsCKrKNWayVzqt7dW
 MzMQNg7bPa1m4hv1UopAnI0I29JCRa896LB1O/HUwjA==
X-Gm-Gg: ATEYQzxlcDdvfPftqntE6/dqBGYpCwX0gNoSGcufbFHLcxJ8aT2Oc5pGHUdNSRrn73A
 5j4DEsvOPg09iI1R7mE3P81FdYBYVKyEVltQ8AIF/UQRzIINhwt2baWkmWnU5j698VXpTSxkeNg
 +IhCAmSZY7EjsyIOoc/jISKm3t9YvobzAKEsPH6ZH+soQpkKlIVohgTri8QMcWS9SF7Zc+ZZlga
 fieoCac81TCjLAef1MICNqOzuYckWYyPQ0rJvrJ41CbXn1TijefjXt/hC7plsadobeRW+M8h7re
 7RHRRUEvxyHwQKhhodE4uR5p26V1rBLUX/tZscXGLGa9GPldB8udaYBgMfO7qceDyFs=
X-Received: by 2002:a17:906:ccc7:b0:b8e:12fa:ff2b with SMTP id
 a640c23a62f3a-b9081b4d924mr570141566b.37.1771948963351; Tue, 24 Feb 2026
 08:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
 <20260215112543.4817-2-mohamed@unpredictable.fr>
In-Reply-To: <20260215112543.4817-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:02:30 +0000
X-Gm-Features: AaiRm53uaqUzd4MwsSPn8k1-CBW-0DmoQs0pO6vJXn01wDPs4seH__B43Cfv4rE
Message-ID: <CAFEAcA9VjwDW8qdR3xQaqaJqge6LP_fvuBg15N9N09JcOsR8cg@mail.gmail.com>
Subject: Re: [PATCH v10 01/14] Revert "target/arm/hvf: Sync CNTV_CTL_EL0 &
 CNTV_CVAL_EL0"
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Sun, 15 Feb 2026 at 11:25, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> This reverts commit bfbea371ef2cabc47effac5a286e2644d727a8d6.
>
> This commit breaks VM save/restore:
>
> Assertion failed: (b), function hvf_arch_get_registers, file hvf.c, line 667.
> zsh: abort      ./qemu-system-aarch64 -m 8192 -M virt,accel=hvf -cdrom  -device virtio-gpu
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> --

As this patch is a revert to fix a regression, I've picked it
up for target-arm.next so it isn't held up by review of the
rest of this series. Let me know if you'd rather I didn't do that.

-- PMM

