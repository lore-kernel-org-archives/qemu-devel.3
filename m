Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EECF46449
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25WB-0001vi-OK; Mon, 16 Mar 2026 06:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25W9-0001vW-Kz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:49:49 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25W8-00059E-3m
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:49:49 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad8435f46so4490869d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773658187; cv=none;
 d=google.com; s=arc-20240605;
 b=KXYJEunnEQBKP1bSBc2ZQzVuK5qtknR6GeaUX9/2ycTg8o7VtAjELZoXMcfXlONxoY
 kuDr7+Stx0pUe+v0dEeM2cG7Lty7BpeTpLKB8niOpqMXT8FvEb86TwBEjXb/gIyumbm/
 7Q/rIBNJ3o3PgMRrtFXD98qsylbCnt2SfwrnmxaM7ap5kn/D/rwZOaYNvxsnPSWa9JX0
 AdD81J2qcvd8/hD/1VpEdYb+ICAklTNSuZ3z0gO8b/VGW6gq2JMwVWa3SgERWKwJgbbk
 bJTWOeM/yzXf8zh6iwAWQay1Kxr36NWk3nR66Xu/sqkgkfSe4Tg9LbAaCqIVEVaQQDkK
 r4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IyIhvvdLRp4COz9LPPwITJ73L6CqX9NEBBVUKWi2cMs=;
 fh=6wzDiqNpiYCPPQ8lnTlubvQhBt2ujIJNeO9O+API970=;
 b=RSiOwkaPRZCWD5JdjHdLy1GO5imboesaZtn5XcBzMg1+RUv9qzHTPFRnobuBB0iAA7
 HiJUnFCf7wBYJ8r6BFNhSvX8cYmkJ458+VLk2TauG/246/uZtiit0xfEuK75410k5gRk
 +/aEu9VV5jpm8T7Np4uscXuq/8zGOiPnKsJ+aa4FRrV/IEhiCRUN5NBg6rxyYkoRGigp
 uuweVndg0t+iRgekY21xpZa2yIBs+woapl8ByGDYqblXx3pEscba2q0WQrDaLxLDUJKL
 djprnkATGUEO5cXpFYD64tp3m5CAiJzcb4Sa8a5oXbzwuT1UbXwZZay5qwt/u+1lu4gd
 sGzw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773658187; x=1774262987; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IyIhvvdLRp4COz9LPPwITJ73L6CqX9NEBBVUKWi2cMs=;
 b=DgehXGaX6rSu8P5a3EFMneU004H2Kbijq9Y+8HHoLAybgfNdQWU8iujxaZ0Lry7M3z
 iE/QWld0ZFRR6yU89xpHpNZuaWd05PxG4P/HMFRTiwyhvfGxiFRR6DMhvv5IFoD1b+HP
 D8npQcqmvacDFpRzCix1zinDTb/KAavJRtX8thgjgZRmz/LkzJlmOvGAvhLn2kGnyaA4
 Go2St78IjBl5bpCLox8AbRlW27O3ASq94Yn/goCcWKJM+vndqDVsk4ONIGypr0kQAIhX
 Ww4E5wunNlq6M18dWCEKpdId05HYI1ymai9QXXTZnhM9iB6D6ZvMW1aNZpQ6hd8H76ud
 VKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773658187; x=1774262987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IyIhvvdLRp4COz9LPPwITJ73L6CqX9NEBBVUKWi2cMs=;
 b=ftPbq9rtJwJeHU2zbxgxNjktAct9o0KXuJSFoz/OZVOvT5IWkgIavRgMoawkcOcAHq
 FqzkTVFSB6n7axRbHZJMxEa7B9jr5l/DF3uYKz2XjEqhh5lrVFY72IL0l40kDUfXBA+T
 /w7+yevJNdUsaf1/liI4YopxfPjDvld5Zky1rWGhl3zRFgPJqrEcVUIj6F6uHYohkFGD
 X2LTbvhjbFlF9DERihTNWOOv38vqjIFC++KDmLRzaywto4/Dd0J+YO4mTiOv4NmEgu3Z
 kRZ/gOXZEbNOdRRj0exoxLTeclsYWjeY6QVV8WxZo47w4hgx/9TKS3B2QrPBupgzcu1l
 oFfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2c10q9GqSVMcJDZ2JyK4AJMXKmQDiMnmd3GbnsqDnpqwsvM9JJEVvp7PFGZCiSq+Jh5NkZiZKrsWC@nongnu.org
X-Gm-Message-State: AOJu0YxHR6fqwrO8pVEVwUzenh9uOARyGMIgvYWc8sxkulBmlI8JUqdK
 b5QX21uUVO5YeNZooHg11GKzOA2xlf3S5o2griM/jmNIEeqyPEdogcfZipt2pHqQTI9VWCO5/zX
 Nb64wJzPt2OpLMTObJIB8M2pG2M9aBS+hAKBQZ/BgHg==
X-Gm-Gg: ATEYQzzrOrdUFs1k4VMCnKYhTcn63Ig3fkkIJq6orH2Ovlp2OAdMqz0N7WQpUETyK2H
 z/pmLYEtukhHj10HCkr8Jiy6tBaXHZL0C2pIYprEASeWpQjmjL7aPCWY84EJpO1uCOX3cwa4lqj
 dxe6UjReYg78k8x1u/KDYlBaOAU0cpvkAw0KJ43bqQjifk+DJPQuKj3mUWMUugih6N8TevdFeIp
 W4cJ2lj4TqDXcdFDufvGHqPG1eaEpRZwHQnnzcGbbN1/nCyCCRqcEMrplGN/03piBKZOPVR9Z14
 /xFGcG27FAyYCvRzSf/qdHkzX2boRC4a4K+Qf4R8Euv+xoQY4zz4t3G6JgrUfiOM7o4=
X-Received: by 2002:a05:690e:24cf:b0:649:ccde:d6fd with SMTP id
 956f58d0204a3-64e62f9d8cbmr8246736d50.24.1773658186698; Mon, 16 Mar 2026
 03:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-4-farosas@suse.de>
 <CAFEAcA-2mcfjsngURah2jGvz0kib+-JYCGWjUPGWF8W262HJYg@mail.gmail.com>
 <8e124f96-b6c7-4e9b-b11e-f0f3e387eaf4@ventanamicro.com>
In-Reply-To: <8e124f96-b6c7-4e9b-b11e-f0f3e387eaf4@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 10:49:34 +0000
X-Gm-Features: AaiRm53BAfAGQzzKqbvNZ-VEowsn83-A96Pf0xk0oY-YsYNmqfpbh9ltj0ti4SE
Message-ID: <CAFEAcA8m9gq+5paC2GxDZeS7eO-49+VOoF1sjbZ3sCndu49FyA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 16 Mar 2026 at 10:42, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
> On 3/16/2026 6:56 AM, Peter Maydell wrote:
> > This doesn't look to me like it's sufficient. These hash
> > tables are used to store the values of CPU properties.
> > Those are per-object, not per-class, so surely the hash
> > table needs to be in the object, not a global ?
>
>
> This hash is used as a hack to determine if a QEMU command line option was
> user set or not (i.e. a global setting).  Back when this was introduced
> (and I assume this is still the case today, need to double check) the command
> line support in QEMU didn't provide this information.
>
> Most QEMU targets don't care whether a given CPU property was user set or not,
> but the RISC-V target has a lot of code that automagically disables stuff given
> certain conditions (e.g. riscv_cpu_disable_priv_spec_isa_exts()).  The result is
> that we were reaching situations, Gitlab bugs being opened and what have you,
> where the user was doing things like this:
>
> qemu-system..... -cpu X,extensionA=on (...)
>
>
> But so it happens that extensionA isn't compatible with the existing extension set
> in X.  The behavior back then was to disable extensionA during realize() and be
> done with it, leaving users baffled and frustrated with their cmd line settings
> being ignored.  Now we're able to error out in these cases.

OK, but why does this require the hash table to be global? This sounds
like it's a per-CPU thing: if I have two riscv CPUs and one is:
 cpu 0: has extension X
 cpu 1: has extension A, not extension X

that's fine -- A conflicts with X but we don't have both of them
in the same CPU. With a global hash table we have no way to distinguish
this from "one CPU with both A and X".

I would have thought we only want to error out if the user sets up
a single CPU with a conflicting set of extensions.

I'm also not sure why you need to care whether the property is set
by the user on the command line or by the board code with C code.
If a board or SoC model tries to create a CPU that has both extensions
X and A, shouldn't that also be an error that we want to bail out on?

> > There are also other hash tables in the TCG riscv code
> > with the same problem (using a global variable to store
> > property info that is per-CPU, not global).
>
>
> Not sure which hashes are you talking about but there's a high chance that they
> have to do with tracking QEMU command line options that were set or not and we
> want to know the difference.

riscv_tcg_cpu_instance_init() calls g_hash_table_new() for
misa_ext_user_opts and multi_ext_user_opts unconditionally.

thanks
-- PMM

