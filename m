Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D35C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDjK-00017G-Tx; Fri, 10 Jul 2026 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDjJ-00016n-Jw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:05:33 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDjI-0005Cf-3N
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:05:33 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6679d88abdcso1633267d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783699531; cv=none;
 d=google.com; s=arc-20260327;
 b=Pz2QsS0/yNDRSed+7D8b4gDqqkxlxveH63XwfCz6NHiPV00sbDwZbO4xH1hSsnTgRF
 qN9p6fzP3Iziy/n4MU+K2J+VI9EXr0X5xTW7Tlmc1dOi9JxV3yrD9V350n5N0S/VLshj
 lBN4Bw7GBgT8cXNZd3Z0sMBnk46xXInvWRqnPiPvIJm6oXUmEEy/npIrF+XYZVqOJMxM
 F3cwz/KM6BptnHI0HsAms2Qqwlbn6Zz3fw0BHiFYqKvgdYHFOprqNKuuKu4bLWGdAPif
 vkLrMXvNDrrLMLmivpeQJWyrmDGsMglz2ITwxgVDA+xCcXVvFkwhFgBxFEHamwvqVEtS
 +3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JjRqBV6GD0nzOQPZYnLK57qn2ikPRZS3euqQT4WBNHM=;
 fh=Q74IszV7dBBQTCrTN/swS6sOCl7kjQtl4fQ1TjrJJlA=;
 b=Ns0mu+nIZtmCGdg9n4OxGnmJCpwE3aGOWJb0Uroxp/I8NgWU0auXaF4JXUemw2EXgo
 JethZYF78fXF9YhgIuEMiVeTuxcIf8Flod9/IeujhcPkwVCKZsf2/bUWBYxpZCg2khK8
 L6dMHMwFdCqxZOpOHw0igzg1drxE8EWwflg7RSCKqC7aq/a5xUvuKmfo3xQzWZj6G4Nr
 VC5opWY2XZf3mjsjKbJAI3t/sj0Cb+rb6DKc5bhZkSJzShh9w08vUImjiIYKoJtaDO7G
 zxlCXeyjhjr47WCTT/SzOgqxX3OYui2ZxrgC1v8gFKJyQfYvMjyw3o6YRc45WNT5BIfv
 KVnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783699531; x=1784304331; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JjRqBV6GD0nzOQPZYnLK57qn2ikPRZS3euqQT4WBNHM=;
 b=GiSI6sYF5mmLDMhHkPPZfehxV9jljS09vyV2Fq+Cs2Q4qh2lGa4RvjUxlgKTqbhUaD
 sPO0RN21SkfFKlKNzDjDfY+37oDLd2+r7HS5QZS5Atptvm12SibPQRarAyLVJWlRRqw3
 Bv+7j8WmWubuDVIAWqQUaGIdqinHoyiIR97SiKL+h27DRsEsqgrtMFZ/y6vOe697xJhS
 rLIBON8oMC7wPONqpP3dbH8GXMYgmRe14fexGXLfEHMWF6a/vOxcWJEl5K+araQMMV4k
 0u5ehwJc90/x8kvyUlIwJyoL+Sqz1SoC5MBJXBylIfF4fy8pYbxMCzQv4idxXF2y4RzR
 QAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699531; x=1784304331;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JjRqBV6GD0nzOQPZYnLK57qn2ikPRZS3euqQT4WBNHM=;
 b=g6kJD5q26fqt377wAqeIHD4ibowcuGW9QD9t+1zL6WU2Z5OuP4Lpx492gQl1VM3W2z
 dvvAvd1UkQZ05/8b//3emDS8weFllkJix+MmS7gYIbZRC4SU76YFlkRDTIgekW9XMcWi
 6UmNrU5zk46ADkxk9NPGG+/5VHb+PwM58bkzmgZ+WoP+bgm9fIpqWgRFnDPsfNDIzl8Z
 6K+tzRpy6UClCg3UwXUmZTwMQB0TmzI95D3IwV+hYFBXcPYK4xg/DPCUHGtnupwQlSem
 5mHGtjhPu+DwktrhPd6K9JU8IzY5XUesVoUblPqCkQcRq6Y5okYPfb6QuV5yUYhAMsyu
 PuUA==
X-Gm-Message-State: AOJu0YzMXiDna+prpwdvhhiz+wzw4Iy7CjXtBLGx4Yf1r47Pm5LgjVrt
 SVRRhpb+A+SC0yqQ/arYVeSPjK41hN9POP60MKeY7TP9mHoy9QrUHucSyE9oC+3cYW4qp0XGCpg
 l/KbqOBBVevXkaaQXuCSpA458svWFemXmqMP34Vi9fw==
X-Gm-Gg: AfdE7clePXOYu/8seVk1Ml/5sZlqYNbkZMxwLlZ3RqbFvgeh7zmleMHJUHN+BWjthj2
 aJ04HBINvUEuMIhyTgJdRVVKq5Tvjwlb1kALsk6lyoxUnepb/V0lI/N5F5sWOZYPH8hrkDbJiAd
 32kHAwKnkPIWQVE+mc2vPBa1WgGYAHUx9n2m4fMc3Mt9AnKytVfB6OlcBws25F5dZ1p1Gs2AyD1
 HXDWnD/ce6URJq1X07WFKCb9+tRv2CRzZjhUQ+zpkjYQnoHhDJkxyEJYnEFpkbeuYTNyZDfHgwo
 9aAXsihYOKS06Q943I7EqXfgq0qTIXGvdByd4ETE2ODH4N7weKnl61yA
X-Received: by 2002:a05:690e:bc6:b0:667:9fe4:8d7c with SMTP id
 956f58d0204a3-6679fe494d1mr8274537d50.90.1783699529167; Fri, 10 Jul 2026
 09:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 17:05:16 +0100
X-Gm-Features: AVVi8Cdip2x3LDXCNl1ZWeozoKWLNRi3-ZwZ674T_ECc_kwwScoaqc-w-PHAOF0
Message-ID: <CAFEAcA8mygA035i3VSEGzQWppCDaUz0HM5mNU9DvTsOjei1F8Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] hw/i2c: parent slaves created with
 i2c_slave_create_simple
To: Emmanuel Blot <emmanuel.blot@free.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, Emmanuel Blot <eblot@meta.com>,
 qemu-arm@nongnu.org, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 1 Jul 2026 at 18:31, Emmanuel Blot <emmanuel.blot@free.fr> wrote:
>
> Slaves created with i2c_slave_create_simple() were left unparented and
> showed up under /machine/unattached with no stable QOM path. Add each
> slave as a QOM child of its bus, named after its I2C address, so it has
> a deterministic and addressable QOM path.

Should devices on a bus be QOM children of the bus, though?
I would expect that they ought to be QOM children of e.g.
the SoC or machine that created them.

Do we do this for other bus types, e.g. PCI ?

-- PMM

