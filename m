Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC4FCD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWiV-0003Aj-VK; Mon, 22 Jun 2026 00:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWiR-0003A6-TE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:57:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWiO-0007fi-2J
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:56:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so394199a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782104214; cv=none;
 d=google.com; s=arc-20240605;
 b=C/GcXeTn1Y/YQHVqz1WJYhSB1Vnfq9bwdfyNU3ecVnqwq2/ZM4BmNNJsHFz4BHTIgm
 xwJf+AHBUhOiriKRN8QzuZYMI1loZRuZe+q4csJZS+2h/obqCerOI1Rk6N2ShC/Ljo9W
 UlBU68VtmG6uYbfX5UGy3YiAsMLAKgp3WK3oky6Xy4ZZ2XuAfs0/binzdp7ukK1Kv952
 GcY5pCB7jUAz9OLZ6C0TivMlMlds1rNh/XiZo1/oV/e2JBga1+AHr0XnYQCMDmIHGCu1
 xIObyrm+6OWdCkWyLeH8JGS5yFzMrq4IXNHyXcaIdTsOLXc4sfehxOeeSSKlQ/dzJ5XS
 FP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f7OJYeOPHcWl/Wtn51Bn09NIIxQpIHKERg9Wj2AwMpM=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=h4fB7juHfZ8pUK3Y3SEuRT/R19RvURTHu4mzFiOxXOZ0gsbzxOWbYR3hCuFMYrIPRW
 s5iNSIx5dbDF/cPCor6BRF7H7V+WKJjPV8U+oVNl/YA+xDdfx75nukrWkWf95SAgZorX
 KNiagdwGam4+hEmYYHZ8nTwknvrZKXtp4+vACi/cxWYs9PidpbaJd6NaJhCI3U+Y/gRl
 8cGuBz1ozoYCvw7iqzYgupuel2Z9WoGkRUiUb3IdocPfQk7Kp/FoMAJDbeIQS8r/D6Jx
 JtSnfVhFaVR7Hv8PKOrIwrK1Bd8j5GiniBPFHXD27if2OQAw4E0tpIizJ3+PLqxq7E9q
 8RGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782104214; x=1782709014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7OJYeOPHcWl/Wtn51Bn09NIIxQpIHKERg9Wj2AwMpM=;
 b=HgwmSX42Sn8rb3vPnH/o/A1hxmndEa7WxtXakkV4yqgp6GJ5SQE730O+bCcUw9NtQ1
 J+JEvFLUsAkaNC0HqtHmxptGmWSdl3tAEsw1qD/Epo37Dtv+sua6gLTdy3QGm6AmlD62
 I469LhWwEsI4XQHaGV9Q7MAMzGyFIGnL5ITtJ0TtUcMMsJCbpCvO5U8eGk+a28leNT2h
 1b9clIq/TFXScKfffAPM7SeNopfiv9iKckUEp/wTrN1f1ArjkCitUY0k/8tBe1t0j94C
 N0MhP7XmuSLyLZI5FRDNRiNAfzijuvZg2TYk+vanWzvCuBcAVxDhI9JZ/VC3L0X2ywMr
 nVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782104214; x=1782709014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f7OJYeOPHcWl/Wtn51Bn09NIIxQpIHKERg9Wj2AwMpM=;
 b=GiOFTrTY/9UpxRQDb4JekgNGWMNOgc+D+hnQLk0AtrRxnf0zpyIbfGCV8HbPH+GO8J
 oz/rauN9HsZ6pTtZ1Vp7ceHOjbYI4MzFbASrBvOTtLttxeouM6IlQ3ROlCbZJNsaIK0+
 FyqqNMWPc2xL97xBG4zD4B7+oTWkInByA7N1iC1b//SD4ByPpjYQbUxeHKi9Q3c15Lot
 7GH1GkfPnsMoEnP70Mod6/6TfFzHZW1FzjuGyJvbjRqBR4Z/boxQgUUNV9bMdHqNVtPw
 40DeMDbjbdsrR0nolL5QQUlsnckACSGd+FMpL7SyyeI+YpdrOuVKhaQeul0YrmKQhwR0
 06kA==
X-Gm-Message-State: AOJu0YxIzGEq1DOOU8W0vmjkbH3aOiAX410DtCEmMqQSLZ5mGsf3Jk4w
 ofkjA+1TjbS3Sp9C3kljLAC9vEltrW48fpUhpiClDDu/IowiUNL3Ysewt1A3tSaItd074UUXQ8c
 z3bFr69M2bxmCpVr5J4S2dDkF9fFlxhQ=
X-Gm-Gg: AfdE7cl81Siek1QRimesknys2FGeboaK6yqoXHflpKBifoy+CioWT2yfTykHvZvCuxV
 Tzw+3bV2bBBnLB3jPprV90cvbhlMVBWRvH1l0uZL4A0i/Dl+umqA1nxwQW0zH/TIEcVm7t10QDK
 N/KaVWo0MSimsyNYJynY35S9ooPrgWgLfoyBYYP9kRmR/wg4LJvDttlLGbneldQjuFPZeSoaUHk
 g51KybOEx74M9FIgDjF1sOIyQPMPPop2nPn/Pvc+81uIEeMRn5PO2kKfRneAsoKLLM4j8cq5LMh
 ehgwgKkcR48yg7hL/lEnP26Tvno=
X-Received: by 2002:a05:6402:3901:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69711de7a5bmr6220949a12.23.1782104213703; Sun, 21 Jun 2026
 21:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260616235939.1358663-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:56:27 +1000
X-Gm-Features: AVVi8CfMGsRFhOjctSr9OkRxtxhNABRI-GBYV1hYBn8OZmCQdmWpNfkoaUTNhoM
Message-ID: <CAKmqyKO-zPHfa998Wo7aTOeO_5g2yQS=BRhr8VQw98pegw3_aw@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/riscv/sifive_u.c: remove unneeded
 qemu_fdt_get_phandle() call
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Jun 17, 2026 at 10:00=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> create_fdt() has the following code sequence:
>
>     plic_phandle =3D phandle++;
>     (...)
>     qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
>     plic_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
>
> What this is doing is assigning a value to plic_phandle, then use that
> as phandle of "nodename", and then fetching the phandle of "nodename"
> again in the same variable that already had the right phandle val.
>
> Here's how it looks like in gdb:
>
> Thread 1 "qemu-system-ris" hit Breakpoint 1, create_fdt
>      (s=3D0xaaaaac162a30, memmap=3D0xaaaaab8f70c8 <sifive_u_memmap>,
>       is_32_bit=3Dfalse) at ../hw/riscv/sifive_u.c:199
> 199         plic_phandle =3D phandle++;
> (gdb) n
> 200         cells =3D  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
> (gdb) p plic_phandle
> $3 =3D 12
> (gdb) c
> Continuing.
>
> Thread 1 "qemu-system-ris" hit Breakpoint 2, create_fdt
>     (s=3D0xaaaaac162a30, memmap=3D0xaaaaab8f70c8 <sifive_u_memmap>,
>      is_32_bit=3Dfalse) at ../hw/riscv/sifive_u.c:232
> 232         plic_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
> (gdb) n
> 233         g_free(cells);
> (gdb) p plic_phandle
> $4 =3D 12
> (gdb)
>
> Remove the extra qemu_fdt_get_phandle() call.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0c6e4204cb..fda9a09f06 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -229,7 +229,6 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
>                            SIFIVE_U_PLIC_NUM_SOURCES - 1);
>      qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
> -    plic_phandle =3D qemu_fdt_get_phandle(fdt, nodename);
>      g_free(cells);
>      g_free(nodename);
>
> --
> 2.43.0
>
>

