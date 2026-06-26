Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F755CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvI2-0000pk-2v; Thu, 25 Jun 2026 21:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvI0-0000o2-Cy
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:23:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvHw-0006CA-P7
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:23:27 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso748033a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436987; cv=none;
 d=google.com; s=arc-20260327;
 b=sSCmQWwpu6VkHcq0B51puqrT2d71Ln9fuccNkrYJdB772slx2ukekSboYIx4A1uTGn
 JVVs6iFiocdrL5M6xWBxv2iVYKLvIiNmeRH0IzSAWbfI9JJLmknA3V3XMP5jYKRU2DDy
 qUqCyE9j/5Fr0EXaWU9zJX+sxEi3OByGZ6Xmw4o5iMU0nxx5YbBBqpqjzQH3z1JTUrN1
 8UtjpDEX7i2mkJhYwvaHwp+zXAHAZ+Bcp03niyVApWKAPCN4hGzxAhnMjCFGAtckyOJj
 OjKFhiY4LC1/mDnBa8seEu7Qxsvc3Ogpmf8EF6MvywQazLbayV+v8UnqxEwVrTwPf9it
 njBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hbsim/OmqBEq5Y5SAScIk83QXaU3bbpggnMY4QgzNag=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=Oz/xvYw7RZiAYUIfLFrohodP2fKy3suWga9xR/C24wuz7cb99SwG6BY8mIfNLDXx4r
 XbYPeRqyP3nf47OWUE2YbmRf6iAsTPOxUb6N54YkO7pKiBGBYzIjblFv4No84pCheljV
 s1PqK295KaFa94IqAK27leDYlCReNezLpUju/lxwS0N7P77/BfUU0psRjnrQjUjzAqUs
 CaXRKCTXUYDcnX8B8VNJXWJPRJ9rBDozrtANLiw14Ev3JUu1JH2E0U/ZitxcSzIdq6fG
 16ZwFk0FMp2Z1L6QjJCg0Rs0hOf55IiPmkz3p6VxPYtTgW3CwTK0HLq9J5+Z4T8eSTEy
 EufQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436987; x=1783041787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbsim/OmqBEq5Y5SAScIk83QXaU3bbpggnMY4QgzNag=;
 b=eSh7xQgJdPxOIuUw3pqQ363hMbpDCS6RVPylwTJFDDfvYml8q3W+x5m6+wMuZusugJ
 Y1dwEIL3/IwdwhoopGHpX84R4DtEpi5ty40ZTZ6wGMuILLOQLydpEPLzBLtlO7p2ZM5C
 9kG8rzy5xsVyQ1j80nhWBHanqlBXYiIpt6DSTaLBirrbYg3cJE4d8p1F/GiwqauHOXoB
 wZjm/CoPrRrW386h8UZRBiWRi4+tqt7154zY1tibpBlLSF5sLjnQ8omT+1Nn2cTwTnJc
 Rp75ulykbxU2mGxkiKy+VsusjkExf8ZMX4VzWkTdeU9fBDdvu0+Nk/Z0YButBVR9j2Mn
 +8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436987; x=1783041787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hbsim/OmqBEq5Y5SAScIk83QXaU3bbpggnMY4QgzNag=;
 b=WFLnNycPNBh/uLXB53OKdMRqsugXFmKcFCHSI5Oaohn7LDbydf00+fLeZKVbBFtWwy
 QpUfFRvovNau/c6MYkTPpz2ullKBNeCsdTG+0y0aUP1sMXQdA5BAKlPK8039xMbJRs97
 b6NwxK4pwGla5OWfA3N12pN13Y3RmSaOBqVgoGhRrbX/NWnVLWoJS24LFjA6Gg8LeT+E
 QEtxs8pasvnOQMk+7kJvAxsYjprdunI93y9KDFpWpbURcpTZMq/ELfY6Zu/STxZ8/bs7
 1vJBWerlJGocOixHHKdXQ7dEpIJkwh7++Ps3TroCQqijN9JJvjg96DH97feSAXo56Fh5
 oopQ==
X-Gm-Message-State: AOJu0YzEfCJ/BdoOOFpkVSMTnLXamR0nYoqMs36E7zSm+ba8is9+2s//
 eN85M0UJzE+cNu4gVfWEtsXTlE3fitplnxhkYOeJXqi6ve4rZBLsSaL4lOO8B/1jxBtcZpxPxDC
 LXjZTWReF44itHSkIY7PFmRdH1ogMdyo=
X-Gm-Gg: AfdE7cnUZfVJDsPWJ81ki/wVf3x00CKKj4xth8HUqKM+m0OpwYC8HO/FPqnihJPARc+
 QdlW5hIxg9GNVH56DvPZFy3P75FfFoh21N0LIxTbhCoxBdORqbepXJKSoBp1z7PdQXNdCXdO/NE
 UkuM0NU6yyzwp7bwzurGfmB6GFG3Y+xwNRbhvgDkAui4E3FcZ2R+1fkb1lD1k/SRInfn65qKcX8
 OEVUY0CfQxuZ8YqIfyolapv/6AEe9TjJ8OPuqktn/6TMiyBrHc7kT7fqsFHxRkLV5GyEv+yl7QW
 3VSV2dekAyxvtnx9ezr43AcZGaHDUI2Ueduw+Q==
X-Received: by 2002:a05:6402:5113:b0:697:b86d:809c with SMTP id
 4fb4d7f45d1cf-6981087601fmr881308a12.0.1782436986598; Thu, 25 Jun 2026
 18:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-22-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-22-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:22:39 +1000
X-Gm-Features: AVVi8Cc36hGXf6rRr4QhHWxuQuSZNvi_1jwi0t8tXOcN4jkD_eRY4PXMf5yN2CM
Message-ID: <CAKmqyKM651KZ_PAohGaboDQ5tyrN6E=eb+sLQLrQREXv_KWSuA@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] target/riscv/tcg: remove unused
 riscv_cpu_get_geilen()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 24, 2026 at 10:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> No one uses it.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h            | 1 -
>  target/riscv/tcg/cpu_helper.c | 9 ---------
>  2 files changed, 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d6c5d6c1db..7618110412 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
>
>
>  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> -uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
>  void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
>  bool riscv_cpu_vector_enabled(CPURISCVState *env);
>  void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 822c9fe483..baf5cace2f 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -526,15 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *e=
nv)
>      }
>  }
>
> -uint8_t riscv_cpu_get_geilen(CPURISCVState *env)
> -{
> -    if (!riscv_has_ext(env, RVH)) {
> -        return 0;
> -    }
> -
> -    return env->geilen;
> -}
> -
>  void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
>  {
>      if (!riscv_has_ext(env, RVH)) {
> --
> 2.43.0
>
>

