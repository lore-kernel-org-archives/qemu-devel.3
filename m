Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E2CC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNZt-0001LZ-AL; Sun, 25 Aug 2024 20:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNZk-0000pr-MD; Sun, 25 Aug 2024 20:27:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNZi-0003Fr-Da; Sun, 25 Aug 2024 20:27:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5beb6ea9ed6so4134905a12.1; 
 Sun, 25 Aug 2024 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724632032; x=1725236832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/gbMb2SsyU6QT9E3rH6hADA1c5E+mlqPQb0z4Adc2Q=;
 b=e7Pp1gvkpB8dZyBf7BSG2dzlOVp/wHHAHFXX7L9fKW4XyoBAmhre0X943ZhI4/1gbc
 kWBXmzTvTv1EQKTyNt3Xhx5y4VccDbsJJGG49WncXh9GpcB6SAN+dMow49K6R+ipt4RP
 raCxe1BMbc8paIOw+rw+KALqf3e6NzRZVKFUStJ5XqhXmR+1CiIVuP0a4sKWhNr6IeuF
 hBUkf7VmvqCcp7hgUXGz4TVGaN+WfiNifCG07J/xvV1G59ydjstfmJWhcDwbKbcIPdOL
 trU0FDIG76+1oQ14MeOpVOfgBSyWWGh0SnpCrxUg5IFLtk+Gpc+xXtC04J/36005NEKQ
 VFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724632032; x=1725236832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/gbMb2SsyU6QT9E3rH6hADA1c5E+mlqPQb0z4Adc2Q=;
 b=nEOW/whCWeU0jIxAokcyjwHl5FZQfkc3Vi2LXrlqtOmrZIm2DnsNlW0MZs/RNW5M36
 i4lJ7aHhnytzeJ19roHPaNtqR3sQONEZBiA/51Bs0kR6Iu8bch8tziGHGMdz0OcaaqS2
 uysNg0ebi08QJunflDxz6Dac3w9dSp0yqLYZTR93xzgJOzqYxSCJtjRUzLzs+3U83kVp
 tQOxH0PQtARPSEI4NCD9WEKLpsT2QLSGSzxFPKPGgTzTxZlBrAtQPyiMS/kmUhohUzof
 xlDvCHgOJUHuV8c8wHI8RUMAHAPJvFjZnXpgu/rTD9wEhNAZh0vRhWOXb641KPXGFkLU
 qdIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuDNj5ohDm6XDunfkh8GRlku/F+7iWXxxYC7YXIGYR0BX8OcDj3JMk5sRww6VCRL2Q9GVnjSOOYB9JtQ==@nongnu.org,
 AJvYcCVE/nssRH1TeIrt9+iXrqsNv+5FYjnPJkjS/jM0/QUHXxnrT0GnHujm3uCU0EhT702FwscVPcUFtXQZ@nongnu.org
X-Gm-Message-State: AOJu0YxG/I1wm7aiTbwCk1xb70tErEzAmSMoi7JGiJjwibPueqvOsK4B
 fmi6XEj3stfcu9F7hCrSmU6MaJmIGc9jJBTxWezDrHgDkG645066yJi1aQxTv1K7sJEvpG4235O
 KoMRsimdnb5WL3jIArXFXByRi9NQ=
X-Google-Smtp-Source: AGHT+IEMzTkpCXwGqG20fnSe3rtViCNfhSS+QvsgjFaUcHkwEf4fTwnl+55+khbjR8XBXZkNHD0usDGrXWmAWvXoI/I=
X-Received: by 2002:a05:6402:4404:b0:5be:ee3c:54b7 with SMTP id
 4fb4d7f45d1cf-5c08919f049mr5645419a12.30.1724632031249; Sun, 25 Aug 2024
 17:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240823113142.161727-1-jeeheng.sia@starfivetech.com>
 <20240823113142.161727-2-jeeheng.sia@starfivetech.com>
In-Reply-To: <20240823113142.161727-2-jeeheng.sia@starfivetech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:26:43 +1000
Message-ID: <CAKmqyKNWeRZrzutpc5Lhq2EUiwfa07vyFzBnoNRFNAfVWkw2Hw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/3] qtest: allow SPCR acpi table changes
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Aug 23, 2024 at 9:33=E2=80=AFPM Sia Jee Heng
<jeeheng.sia@starfivetech.com> wrote:
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..aae973048a 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SPCR",
> --
> 2.34.1
>
>

