Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DC8F3C9AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvc7-0005FK-2X; Tue, 24 Feb 2026 11:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvc4-000591-7q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:50:21 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvc1-0002Xl-VT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:50:19 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ca4dfdd88so389278d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:50:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951817; cv=none;
 d=google.com; s=arc-20240605;
 b=PWs/vG/d0eY5oQWYpTem9EmbvCfv6COiSnFF41zlrbjsQZ10mo8p6BcQn2g17TpRzl
 NrgZCKbQNMoyebQhwYzNb1ldSqEp010H9GwS8U8KVvhT7zItvP6LMaC9dQzWpkTm5rXj
 SVEspu7XbqHuS02JqRivM4+ofuENXPsBAfiw/uXCoVIwrY4mmfavGjMJLw/tTvq+lz4C
 C3jY8iPUnfrYoUvjJ9pqq0WN4rJkleF2CtIrfpMM2LbvCRN0tvCpp7hHNfOeqzKx3dCM
 ZhayZKZLa8EtzTpfsoFEN629UDAGVLCibhUDsWWhSgjL/XS20fMATIGY+1AgxTHV/ebW
 eMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kx67n+/CcFLUBCkkr9HdFv2LwV/RRcO5knepctnIpak=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=d6m7DsRlub/XVkRt8q5LqH7tigcYJZWsbpej+GKENmzDiA9s2GYXHslRhXmzSFbQzM
 MuXWq3shqLdD1g3Kl0sm2ZLugzricIGF/rr5RfDgMMfCgOMnycatTXFFGaIeqd1IqCRm
 zIRn955+JhLaZ4IRd/rvVAKk+AnwALQrRF+14dk+1hbvJeppDTDWmyqHj8effZPyRfbu
 j5Q189W28V3A7tA8CLBlsiFpmpAenQnmjh2d/GpSlu/Er3ZqMpQ2CHOFJGAL653fr0am
 CopKEkSGhQEk8R5yYyUdEJ70a0JetrsnXxwdkKJ96s6gME/Ytbd/8VW2lmWmaNnAWQqV
 g2zQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951817; x=1772556617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kx67n+/CcFLUBCkkr9HdFv2LwV/RRcO5knepctnIpak=;
 b=YNQIGFBW0jqKw47iLxUENKjJy4ZATK1CEwplo+TgMTUfBK2FqldYnoJdf9MeIEBjvs
 rMmuxy8auEDYDgvmyhwPn0a6IpYGjrTemQd74NC7Y1MluEKGIT6Yo/L8FzXu9/Usoukz
 TNLQ/re8GSTBEI/sEfwMgoYz/8mrZCCtpEtVJM7+5qXpW8+eK79zjYYMc6x5Dq3HWAzq
 Ae0k9jgoRSgHWi/Obu/km2/Bk7yZamrHHMP6JgnsUXg6hNw27OPSbB6JF1mZddVTPZoH
 +gwCQLvQAnA6r7L8JkKkQwiaVculIUMBZzSUD73t0fYimADeuYjaE3Czbn6XOIqZNIkn
 oShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951817; x=1772556617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kx67n+/CcFLUBCkkr9HdFv2LwV/RRcO5knepctnIpak=;
 b=lsdssOtOSDgYGen+zkZlwiRIAZwKJzhI82zPWQp5QMsYk0qyFewdC4lpOhlj1JRKg5
 pc1jwg1VLORrrJMVXO7QN4zvw6Wc5Ozq2II5cehqX6DEpRb4L2EMWXK+mHjwv12qWQq/
 ke+9Pehy3qEgPSk2xdwHrwqnsCUU65X8AwS3Q4w62Noefw6J1dPfwJJg5h/VDbqymfQ6
 aAvIKuK+vu9lCmWX3mySxErdcDXIWrFXImLOHxWWrdjmOWj9bQB1tV6jYioP4Gu4q6p9
 L/WYwxW0jy9cH6ALA8mvcgF4ZyzpqB6zJhUusWiYozSbPa8ZufqQwAkGFl9zmXg6oIcz
 7OyA==
X-Gm-Message-State: AOJu0YyTjg/vNS+9kLxMIzvu+n1yN1FF5kXZOkqTHJmF54fByrjU6CDo
 kBRVAxH28a/o3cE2LpSLhgo8I/jTwDBINRdtuyBgrjz+nqkYqGx4k9+Te8wsEAY1YTUCl3iDIUO
 hLgWflOP3wE4w1uRoQwZryQqzwtHf4yM4y+85JC32lnZBxFS0bnZK
X-Gm-Gg: ATEYQzyFROqZ7Q/wH7P2lc6IkYabei9ZAssZWhWVNkljPjX5HM5iTtRZQNlQvHlewKh
 Zi4t1gvNthI0f6oN0intJD100s64F0kmubdn1SUmErwPMYvHWPBHprcGdMO1EG5CO1Mdr/bxgrd
 qy5dyeGt/IqCrotVWryIbYr30SfaZ/pkzEOzoOYy28hvnEGBGkBTxNw1Z+DgCrfWKQwB1GSQZJ1
 bXJe4iPPjRXnmqh4hvUoVnO6CUhpV/FIhJzWy41JvkAKiqmfk6lzHtFd9Q6hSpYqDk+AzasIyaF
 Q8KYrW8ft1j/GTcSeBzC5mQoA6eakPO2hWal4uuCGbS1og78TdCR0mtHs7OYZP2Q4F61SfDXvYI
 eLQ==
X-Received: by 2002:a05:690e:1917:b0:646:7a21:f03c with SMTP id
 956f58d0204a3-64c78f6bab4mr9611908d50.81.1771951816828; Tue, 24 Feb 2026
 08:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-8-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:50:04 +0000
X-Gm-Features: AaiRm53OxoDMFxc37TU0aEv7wC3c5QH6Cp-2FWu0B450Wjqh0JyzujOgnh3Q3-w
Message-ID: <CAFEAcA9TLaXNY_o8RFUDpkvOg86swqCdR9J8y-sAHgqGss8d5g@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] target/arm: Remove kvm test in arm_set_pmu
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In kvm_arm_get_host_cpu_features, we only set ARM_FEATURE_PMU if
> kvm_arm_pmu_supported.  In arm_cpu_post_init we only register the
> "pmu" property if ARM_FEATURE_PMU.  Therefore, if kvm is enabled,
> we can only arrive in arm_set_pmu if kvm_arm_pmu_supported.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7542444b18..16ce5f300d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1218,10 +1218,6 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>      ARMCPU *cpu = ARM_CPU(obj);
>
>      if (value) {
> -        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
> -            error_setg(errp, "'pmu' feature not supported by KVM on this host");
> -            return;
> -        }
>          set_feature(&cpu->env, ARM_FEATURE_PMU);
>      } else {
>          unset_feature(&cpu->env, ARM_FEATURE_PMU);
> --
> 2.43.0
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

