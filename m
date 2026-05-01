Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B336FF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeAk-00031W-HR; Thu, 30 Apr 2026 23:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeAe-0002xr-C5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:04:05 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIeAc-0005oH-Ky
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:04:04 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba7fd666666so198377966b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777604641; cv=none;
 d=google.com; s=arc-20240605;
 b=flNduDgzoevlqFQ0w6hztn2vvRIkoZRu8QL1yZYP+Fhc1S9esGQPsb0tqigGvkfcJp
 3K4bjAdT3nOwf7egIDo+QkuEx6HQuUecFfrLo2ABU4/RST3HHjnIqYHK7CHSdRM5XrS1
 gBXFltPKfWdBJJaS1zJdkDZP+ioxN7UKbGyzCRinvL/hLIDnA1gBOEQN8kHOuIRthbeD
 8MR64cKej9CD9pmOI5E+suMn2sM04AvzMmrlbUHbkngTIUN1G2kqRX5s7iv0i7NFqOcm
 myVMo8lSniATEa1KjwEJn4m1zKGzIGwQVZkaam5zq70sPGK40mMGKOKZRBVe7orDDDjX
 bHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UcF8qHddirl4CF1hSp9nMX5emn8otr1B4TTFv92EENw=;
 fh=V4bRS0Y0BmHnHNqZQA5ANJ7h/rENqw8ecjUR3ynwrn8=;
 b=Tf5mvUgvbME/Swl0E1mFrndbxwf/N9sJXVpBddx9wF/gjG7rUNAaqDJvI5RBgOxppB
 EbICA8UWEge55AXb1zZIWG1niyS0OaLpU7Pq0Z65JfJoohg8oY4eNR30W9nzoYKqTm7E
 TPxiYaFnoRMqzV2++85THuH5s32+2lQxVb0JvVYM8Lts6w/P2Ci1LlJLsMBZMr7eJ5fq
 0oKEOD2V0fTqVEByr8d9lX5/L/kLpfS41PGG6HU3+ytkLWgZDcrYw3ojQFB1K/i3alSS
 LSp+wvewSv238oXiNTtBbFGxC5xRPwYKgDbrZu7m5CduzqCFPmSBryrFSKOT/C7mEJzj
 LLnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777604641; x=1778209441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcF8qHddirl4CF1hSp9nMX5emn8otr1B4TTFv92EENw=;
 b=ICbwIX19T2lW7+uhRXCU9w9Nq8OU3/DHTvEoZ5fJ0lz9h3sUOfrFybEyPqYAFZZIMV
 UouMRQC4D6t6wj8g2XpvKN6hi97dFAcxrAHUVZx8PrXX2VIYhEQ0u9a0ldS2MwfeVzdE
 lCJ5u69qBQ74gXJvT+kCV66hl2Yg+7iUYpr0IHMGb4LzjNJmKr8vdsiD4hLDn475EdVW
 tBqPKLXWc3eEVWIR4GAr2AXQonq7ZFIXVhRvlbHMES1p7bpYYvSeBbbVI9kDaACLsm1H
 tKR3bqnZ0J4yiH+hqHgiZsfsGra37Q0XyM34gu8z4merr/YKw3fzC8QHhXdLXkH2Adkb
 PGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604641; x=1778209441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UcF8qHddirl4CF1hSp9nMX5emn8otr1B4TTFv92EENw=;
 b=iJqBtC7Nrkns20RYzkyE3tzGalK1LJpN63e5qNhGqzGQqYMi8v+PAfSE8MGmWSrFfb
 eJG+Y8GZPk+9SchtWZa8VeAEUq5qZtW71VAzgm1XJj//Pu36MgZZVLXqfS1aE5gXmY4F
 zN4uFYb5R/IjphSUbXc2G5wiIuzXV7PEpylEiEKUNnKZr8RSgcpsJndjXxuFbkmz32+P
 NpDYP192v7StzJvUG4rzpPWU+nFQTDEn963UAiDKs1w4Qdb6mQgnrPfGxcYgsPLjIvKj
 LAwlqxgLc7Hnufw84LdVHG7ZajPm1pEvG4OUzlR0SPDvOsB0g+KCMqf7EaXrbUIt6F6S
 s5jg==
X-Gm-Message-State: AOJu0YxZO10KU7UF4dCFwVP3nMil9ZBthg0MykM9kgiGaeWKiVZtZDgs
 6EI4Z9pvJLafZFsjFbaitUZ8cs0g1+qU15Dj69SuoLzEhIJ+co+tGtjkB7ZG41IqQh2BGLlkiJ1
 U//uoPsKdqHObOyvw3TJ1JmtS6YAIaB8=
X-Gm-Gg: AeBDievkJ9wgTFUw7h3yjZbaLDPJ7osICFGqHB4QWWVx6VXSumleLTxN+XRdZyZATdG
 i71GwTVM2WTLQbRCIRCiYnMhlH8dfp3QTNx4N9THapj2yTDE7jtkZcd1+a7+8rsVDdkV6jxtBxo
 PJNkLYLdNlwGzyAF2F4uWA84Vt9dqRo+oMnEbF5KgoDJtv6emZXKmnJreDXy/NpJhSVZiHSNOCT
 JkfgsgFJpc8Xq7quWHty83SPdgY1Mx3g3jAH0A4wB99m3+XBcWejRULg3qkBlPE4PmjWrd21s10
 N7+pNMVF40xM1F8D1m4lDBSrb4S9xBOvdA4LwUZPrS+ZmX7i
X-Received: by 2002:a17:906:c39a:b0:bab:29d9:babf with SMTP id
 a640c23a62f3a-bbac6bbd5eamr278501966b.27.1777604640741; Thu, 30 Apr 2026
 20:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
 <20260424191129.1494381-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260424191129.1494381-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 13:03:33 +1000
X-Gm-Features: AVHnY4Jh0m55FsgmwE4gIWhh0W6Y72A5_mBeoOMS6XEsMpRfnbNl3-a34WWPSYE
Message-ID: <CAKmqyKOQdsX+bWF7N5uGo6ooOehufOZJWYBDBTD_FU1gdY0A7Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] target/riscv/cpu.c: remove 'bare' condition for
 .profile
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 leif.lindholm@oss.qualcomm.com, Andrew Jones <andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Apr 25, 2026 at 5:13=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We want to configure other CPU types to use profiles as an alternative
> to adding every profile extension explicitly, i.e. a profile is nothing
> more than an extension bundle.
>
> This means that a vendor CPU can set .profile=3Drva23s64 while having the
> same handling as any other vendor CPU. Same thing with all other CPU
> types.
>
> Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a81485981c..586683b28a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2863,7 +2863,6 @@ static void riscv_cpu_class_base_init(ObjectClass *=
c, const void *data)
>          mcc->def->bare |=3D def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> -            assert(mcc->def->bare);
>              mcc->def->profile =3D def->profile;
>          }
>          if (def->misa_mxl_max) {
> --
> 2.43.0
>
>

