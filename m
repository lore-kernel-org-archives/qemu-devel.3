Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBBC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 23:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOlxV-0006j8-SP; Mon, 09 Jun 2025 19:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlxT-0006hd-7y; Mon, 09 Jun 2025 19:31:15 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlxR-0004qN-Gp; Mon, 09 Jun 2025 19:31:14 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-52b2290e292so1654899e0c.3; 
 Mon, 09 Jun 2025 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749511872; x=1750116672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJYX73VgIcnjjopdzxng+W5a8XlUsRa83mw1kU0NiM8=;
 b=cgBks0ofceGXDZchacuiQJu/13GQlZ9cfNQst6dLbdcE7vuKGhpIC0UkbC5gV4hOxv
 T5wj9sI/t/JtYoN5a7yIf5wL1cHwUDlW9cV/Tdro+alfi+p9eWMG/3t10f/Qs+5Fipl0
 R6TOKk8lln66SKNFxdsS1zjKdO6GR//dgL682gcPAdjWho6M7lhKaTGI6L6fNqD4iHQ8
 XM8mTlRoI3sw6e3EVCgKz5qtWZU98/AC4AhIcJvKs+CHJZtZT0zJvyd6qYdlryqzMQ52
 FC9muOY1m1cBz3gqU+kzAp6Ro2Qnv0tVhxB4FcUgP1WWCFgqJ65H3qmZQWwXWTrB41wk
 51Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749511872; x=1750116672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJYX73VgIcnjjopdzxng+W5a8XlUsRa83mw1kU0NiM8=;
 b=Ie6ExaingACjmtWWGbEThBqpOPQx8ykSIzCzvt+fc75rbn+iXrCJl2GDDS4OOMKBkj
 lpBBRT4AFNFOdpX1OY9+zzV/E+tHIzZoR+eiP4WnjAMvmFjMAfLgzfNSDI0VLpyjjOB3
 YM/g5ztZ4RKA8xqYCzNX/OLU4czcS8/X0IvWCiv/PXmTdwZKDpjGedUyEgrR5dWWiw/Q
 9QkEpE67SIweSucsP3bu6y7BJXVqIRgflRqVqP8WDhxuxIqnSIhgnEtf/2ILQVM+Dvq9
 qeI/fQZfuZA1NfmECyecT58FvB9MAHiMNbn1IwnBboWQjtgzGTnQk8xqjwtl1iryRQpl
 iyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL9OHrHyIOGjeKP4sPr+KAgyE4yWugBRWtNBEjSFNQFhj5iCgLk7aCFewaRmHzUwFekF7tOtYcDOjv/A==@nongnu.org,
 AJvYcCXEZXkSeMgFUtdS/yg+GKEfr8UNTbXv0cYhz0OAFXugcV75yJ0By3211tsc6X61/dZlDy7zGg7UIPQX@nongnu.org
X-Gm-Message-State: AOJu0Ywn8sr5CF3hfUDDgmNRhzXk4YgICWXEJC33oReUuibaBTFVATea
 zuVxrV3O58NEFujuNQRbZEfSWMiz4mNFyDZkEf98UcyyuneB6MzkzAUo4W/KoxBZXYb82xjnXxv
 Hd0oCWzSV1Taifhvprj3QXrCQuaTp1sg=
X-Gm-Gg: ASbGncsyDF7CGi2GM39DLgtfX47CBXAoU3gYvAZjP8gFWDwDrlZtZK4u2C0RiK9+cQ5
 NoTPQH5H9pRbpku4y2ViHEJ5EKEx9Bmzq/wi+J0QJHUerxEveGzgGRSPAuUZ8YRclVu8RWRsm5G
 cqxF9k2VO2N0ZMVfW//qc72H05PQkQKMh+rPBwuPKpd41aiEm4O9rLR6zV8iUimUKq+GxaK5UoU
 A==
X-Google-Smtp-Source: AGHT+IGQRBD/kvbnhoJERWnieIKSYkhTE7jrkGCUXqYPGnki71vhwTyiAn42849hwxQbMoe4ztinCkrxJAJPzDErWDw=
X-Received: by 2002:a05:6122:7c7:b0:530:6bcb:c97f with SMTP id
 71dfb90a1353d-530e48ae8d8mr11342459e0c.8.1749511872022; Mon, 09 Jun 2025
 16:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
 <20250609131731.1464616-4-ben.dooks@codethink.co.uk>
In-Reply-To: <20250609131731.1464616-4-ben.dooks@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 09:30:46 +1000
X-Gm-Features: AX0GCFvywzm4k4xnm--zajL8NckkIwnFO1HEk_af4-uT_gQxydV6zR4-sjYgKjc
Message-ID: <CAKmqyKPt+Qim3b1DYyVdrOBdF4g=ptxUoW8OUTF4HEHZFQZ-Fw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/riscv: set cva6 to use TYPE_RISCV_CPU_CVA6
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk, 
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Mon, Jun 9, 2025 at 11:20=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Change to using TYPE_RISCV_CPU_CVA6 once this is merged.

You can also just change the patch order to not require this patch

>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/cva6.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/riscv/cva6.c b/hw/riscv/cva6.c
> index 3adfa8b5cc..e6fd0ebafc 100644
> --- a/hw/riscv/cva6.c
> +++ b/hw/riscv/cva6.c
> @@ -83,8 +83,7 @@ static void cva6_machine_class_init(ObjectClass *oc, co=
nst void *data)
>      mc->init =3D cva6_machine_init;
>      mc->max_cpus =3D 1;
>      mc->default_ram_id =3D "cva6.ram";
> -    /* start with "max" cpu type until we sort out CVA6 type */
> -    mc->default_cpu_type =3D TYPE_RISCV_CPU_MAX;
> +    mc->default_cpu_type =3D TYPE_RISCV_CPU_CVA6;
>      mc->default_ram_size =3D cva6_memmap[CVA6_DRAM].size;
>  };
>
> --
> 2.37.2.352.g3c44437643
>
>

