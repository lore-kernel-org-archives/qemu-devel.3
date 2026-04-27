Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A005FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHI5s-0007jR-4n; Mon, 27 Apr 2026 05:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHI5q-0007eC-Oi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:17:30 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHI5o-0003fB-Qi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:17:30 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so8622747d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777281446; cv=none;
 d=google.com; s=arc-20240605;
 b=ENYAD3iDMRe0uf+QD6YvTQ5rwZ6B8SzNhzaWI7yCO1FZ3+BRLlszfiaX6Q0VDjywO6
 qLTJvNKj5lT1XDd/17nA/Z6DnwYNEJ2smz+zv22656in+miCaMzZPKV9tvkSux66Y5/Z
 hVDYNDqSC+kZv2dNU7e+2KgURzEUPf2AjNBoIlcnDIMLmaUWyJUqN0Y1Xxk/i7PYVNe7
 G7xqHJXl/yjZ+b7kZUXf7Y5GqO8dpDijEPdlpEAfgz+qf/UmGmWMqN/FGPl87j9O88g9
 AOt50hJHk6ot5ACw6GHtlxsIBr0U7W/dxwqnsQG2La/HOnaSGqvzcxt5wCGVy4LPMHA3
 aFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=drNCgVfz0s4LsuWyXJ5uke4sGBIfgQAtfANUdTvKA7Y=;
 fh=mvcQcK6WgyS5lmoWF5NrtWk62GFG2LZogC/YAoO59zk=;
 b=Lojc8a3QJNSYHfuz9zI7WwwifXLWAmUeskU+9lHM/gJJ8dZlzP8CiiNUQMXVcLY9xf
 RiMECxD7TlrVauB5CaaXC5qn94NxZ/4HKvZntrxmF3hDS0zKRzcfVYSolBNLDCAY5TYc
 9LeGsro5OgEa8UWmn7eJNJUST6pQcZ07YAz7W4IDCX5ThRaMFZxrdghiPpkmgG5eX/ct
 1HQngRq/GqEK2QgoV6+rtpVhG5XCN9LwUsjpNPhxn8yaWUKxXzz1MKvnvOPNbNHwdt1G
 2axdBvC/uB0PF0SpsP9OUu0LV8iNXOQYM9hyCdkusePunJVr4clmtGYg6VHbFVN3KPgs
 bMMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777281446; x=1777886246; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=drNCgVfz0s4LsuWyXJ5uke4sGBIfgQAtfANUdTvKA7Y=;
 b=Jqn6VxkTRFplPuepuF2ptzPUguXwMMKDUz1iEpHTZZNxuIZitg+ZTUfQ62A2Fpl4Vw
 gNhTxOlGkoYKDPmdQRLsXsub5lOahrYYaPlOPxkiAZLswrIudYtpZZDXpJ8HshuRZTEz
 y7iQzXUAbYJvEd3IwP6YBLZbPdVZXNKVDIO0uvrxBlwbTiMJOAWABioJ1w9sxAqZll2E
 DhvLFbZnz3PYt6a4EUwW3ZFjU/eCpKoX9QWy5V99fWd2LjcWS+2rH22aTeP9K+559Wtx
 KWkghI7YkurAS1fjFg9siWpD8c0a/aP+dkp5hRj5OeC8OECwfbDICrjfpzMUvsaFfxnE
 iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777281446; x=1777886246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drNCgVfz0s4LsuWyXJ5uke4sGBIfgQAtfANUdTvKA7Y=;
 b=KcINlucc0JmcbxJ93fRcpgXJmA2LDOCeNuElfQq9Xs6AE4scTvoEvbHdJUIk77S9+Q
 fuHNj0C7oLZlQWcgfp3Gof5zqyIp5DMVKbXJaFiB9Itnxj0DF8q4sq35SKd6Y15xVrfW
 tfwCyv37ffCJtDUlDoA9aM6Wau27HGhihltQP4QGG88Cd450vgisq8FWNyAGnmqAz0LO
 4V42STYRDbxCOP7jOcPp40uP9ua8ISG2K/JvR47YA9ZWJUYOd/fyQCBHrXy5Ts6wIlvh
 sDppQx3x36y7bxpH5XwS+ESFxHzJDRRRWok3Ts+apSEmPA47+BScq8cSlJLoOxyHGhfZ
 LHOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/McC4WhTTM+4rN4iNAN3NzZneRdSpSJJns6xLc1eopxveWLftEm9xxbxTcWM2f3J4l7Q0gULqPVopU@nongnu.org
X-Gm-Message-State: AOJu0YydyvUxRVbmC7vWibK4l7tvH+v4y8xjhrVza1a+zg8kOngH1H9e
 IXW/6Cwtf4W09W/j7W/zc8SHpmcRtv2URa1sOGypujLPBwGe18LmtTOv0OlEUlyYrZIBlsEqQEz
 0BKb8vuUEhIqldisrm7W5g+i1UiYLD9ZqOcOZyR81vA==
X-Gm-Gg: AeBDietz8kbUno/7+n2GDbDMN5FVcjwgoaYZZPSVI92N2LlLSihftTTylR2BGAL+UqH
 zYRkmqCJHZz0kQjuDfvlPScRrsm+qI1XTKfzy+4Bzkuh56wRYA1S0KhMC2mYMJXK19RRnCzuc5b
 3YFDvKxM4FcrgZzumYd3au1E9eVRaEMMnrq4LAlzSmHSX5M7RV6tVzBPNapgXgizWpdiSqbZwLU
 47xt1QaeMB8SqV61UuFIxkSXeql8PY9IMXyh/hnz4R7bp8RMUS0h8pkqf/ek+0b+OGQvvqqGqbs
 t8iCdSg2XlIBmFd8kuVBbBvVusNzA8kpiFl7UNmShh6rs61rn5+IoGU5lErthbPG+m/Y84j9OGB
 QCw==
X-Received: by 2002:a53:d016:0:b0:654:fd9:2e88 with SMTP id
 956f58d0204a3-6540fd943d2mr21267311d50.31.1777281446128; Mon, 27 Apr 2026
 02:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260420140552.104369-1-eric.auger@redhat.com>
 <20260420140552.104369-7-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:17:14 +0100
X-Gm-Features: AQROBzD2j5W-nVHU8rVmtUyCDS8WzT54HLDhw1z-ez_L5it19FUfHfx-oJm1Npc
Message-ID: <CAFEAcA9Qu6updLns8yxR8xgNZ9+aP51w_BfoprqBayPF8zsSAA@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] target/arm/helper: Define cpreg migration
 tolerance for DGBDTR_EL0
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> We want to remove AArch32 DBGDTRTX which was erroneously exposed.
> This was attempted by 655659a74a36b ("target/arm: Correct encoding
> of Debug Communications Channel registers") but it was discovered
> that the removal of this debug register broke forward migration on
> TCG. Now we have the cpreg migration tolerance infrastructure, we
> can declare one for the DBGDTRTX. This allow to revert the reinstate
> patch.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>
> ---
>
> v9 -> v10
> - Adding a comment explaining why we want a migratoin tolerance
>   for that cpreg
> ---
>  target/arm/helper.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7389f2988c4..d80899cd096 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6426,9 +6426,24 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              .fgt = FGT_CLIDR_EL1,
>              .resetvalue = GET_IDREG(isar, CLIDR)
>          };
> +        uint64_t dbgtr_el0_kvmidx =
> +            cpreg_to_kvm_id(ENCODE_CP_REG(14, 0, 1, 0, 5, 3, 0));
> +
>          define_one_arm_cp_reg(cpu, &clidr);
>          define_arm_cp_regs(cpu, v7_cp_reginfo);
>          define_debug_regs(cpu);
> +        /**
> +         * AArch32 DBGDTRTX has been introduced with a wrong encoding.

I prefer the phrasing in the old comment here:

"We used to incorrectly expose a non-existent AArch32 "DBGDTRTX" register
with this encoding. This was fixed ..."

> +         * This was fixed by commit 655659a74a36 ("target/arm: Correct
> +         * encoding of Debug Communications Channel registers") by the
> +         * introduction of correct separate cpreg definitions
> +         * for AA64 and AA32 versions. However the old cpreg definition
> +         * couldn't be removed without breaking the migration. From qemu 11.1
> +         * onwards we can use the migration tolerance infrastructure to
> +         * remove it.
> +         */
> +        arm_register_cpreg_mig_tolerance(cpu, dbgtr_el0_kvmidx,
> +                                         0, 0, ToleranceNotOnBothEnds);
>      } else {
>          define_arm_cp_regs(cpu, not_v7_cp_reginfo);
>      }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

