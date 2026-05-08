Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23DFCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 04:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLCbQ-0005do-UH; Fri, 08 May 2026 00:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wLCbK-0005d7-9z
 for qemu-devel@nongnu.org; Fri, 08 May 2026 00:14:13 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wLCbI-0008LB-Kg
 for qemu-devel@nongnu.org; Fri, 08 May 2026 00:14:10 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so256245066b.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 21:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778213647; cv=none;
 d=google.com; s=arc-20240605;
 b=beA7+00cm1fWRQv7EP6PxcDQPDLSjvHmtzc5nvQSF285JEKg4+VAeYn/yMCplN3vb2
 Q41agWDoRkYWecMnV3LlkHZXx/0OJhWthMohAI0cuhdAhPGNhIIQHTnx7Ih6f0Mep9lO
 owNgYVnhPLQpyObMxYOHgKmhvtiEsUXYgMXQQG9AmUz3c8dMOR8ouvjB0583JtdWo7ju
 fKnJL6zBNGIhYk8Nu+9GVwUrqUmcnQz2jizk9oD5CuV8ZBMfChJdv7KdnbkBffHM15Op
 stUUaBK0dNd5/uIAP3kv0R3DWUcQpp1srExij8C9IptZS4ybJSwZ3rG3ri24AWx+n/SD
 thOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1hJNz5iBock1rKLqnR4wHIgveHF/z3ztpxUvCdidGpk=;
 fh=yRiJeqAL6obqpptWolneSAkL0LCo1859F8hAWfT6Qfo=;
 b=TXHRcTBh8e2eV34a23+9yAtd81t/4/HIwt2TawLkhg/uAS5Z9vL6KPaX1hcKybb5z7
 dE4XGJC3evdQfhuAAUn0CsMBx97Tioc7YOTEa31UsG9UPnXUmRb7ANMxq9gv//bul4Is
 zMeEFSLjbwGWW3IEduTjdl/aHJMBtcAVrSkcgeMYwZvebIlNmieRqYkuXuBdwFBXzB3n
 LwvY8yjXz0PQQBcNxydprLLOrCJNqAvO8bQCt6uak0t0MjAJgg7XS8wDCCMH9ywoQEII
 iu87gJAD8d2E4V/TFzNi07AivK0a+Jynh2bpLAByj3aJf+co5pgqHa/Dha77ubhwk4pA
 zwWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778213647; x=1778818447; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hJNz5iBock1rKLqnR4wHIgveHF/z3ztpxUvCdidGpk=;
 b=rs9LdHb7gDigZNowN2hz/OiKuK8FR3wPfXrUMR+JO9aO13N07eSqzLifRBtLVmJS8w
 odHhhjHA6Wy0z4Vt6fcavmWFB0ANUfMbmNseupWVm51Nm8YOybIWPHT08zvbvYNQDUW1
 mQVNMjpvQNqKeR8VbYTFYAjnnEbFZckL5d67reLhQJpjmElS7ERpyhnyQvTeOzvYV7Ye
 UlKCP/jwP5879z7AqKnPloCBorM2lGZvxLOjL0rUesZ3ar8flJJgBDrVGYAX7Qc8pxeR
 5Q46DPT7lU/u1iC2i3n7VPRtqtbZ+d7cbHwnKGPZhNV3KJCjEBWem35dYusAdCMaKWZm
 zdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778213647; x=1778818447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1hJNz5iBock1rKLqnR4wHIgveHF/z3ztpxUvCdidGpk=;
 b=d3b6aHh0gZTf6xMZTUeRsv+gywfK9ks7kWHM5AHv+2OjP4+vaKLfLJnMUvE+s5Dxw9
 AKlwSEymAkS3/2rdd9/Uwn5Poha9yjvGJA0afEeogZuLeUJ/Wujez2xgBJc2E79oxpQ0
 vS7lp8f3SqL8GKQFM5klLD/qQ6IPRCrKejkfTriClUbcOcn64tqfLp78okWK57NLKcl3
 GLqyQAF/Pf8YORz6f2m4Vhetus5x3sA8rhRBtD2WdNeo6eAPSgvSA8rmbAhnkKDcbay+
 MHaIpCNq8S74Zep4xEd1o8WS55t4wOkZk0fae/Dl6ZvF6aGcQ+N6oBwgfAoijle57s7g
 5J2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vUtP8y/AvqOFNelR0e5lGESSWGGfmK6eGA68KeK0NlCK18cP7t9Ohl5mskds+UakPdt9n6Tv2Vw0d@nongnu.org
X-Gm-Message-State: AOJu0Yxxcf+v7PJVvg6xPUoI/iRbX831yssaN7Xoagx1Puzi7BN5UIl7
 g4pnPFv0mRZ2q2TuLtzzI5HPEAgHi9tVZxJ0RZOQmc7cpTEQWjq9gdfiziSH93pnhVjB/fYql+x
 6qCW4pcM2qltPSodfwtGv3lA6++IKNuw=
X-Gm-Gg: Acq92OFbOcl1rsx/GrhuhsKPNYQ6jeaJkoGCzoE2J+5eGkw6v6QnKSAkhW9JNYV5u7a
 fIUTWN3c16C68RCbY8QZKxyNMRzaTdpQbhYQAmLJYw/DhMYSXLw9ynnrPsYv1z6wDAwsJ5AWj1l
 3GyUtwIq2C2I5ELAksx2hWFNAlteKDVQac9HJgtvh24wQwasSOK2dIoKeC2vBQwa3R8WJ3fpbcY
 osb2Qc6X72fSrX/pn3CGJv7Xgr8sJ8EDJxdE6DrKMowvYMZEAWcQKqz9R8nIDaeC07CA/wacJ17
 sqwPrBAHOvMNu/pcm3DRHUx6aXGr9BXcWzsAmg==
X-Received: by 2002:a17:907:2685:b0:bb5:8532:af4b with SMTP id
 a640c23a62f3a-bc56e40f24amr619567866b.26.1778213646404; Thu, 07 May 2026
 21:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
In-Reply-To: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 May 2026 14:13:39 +1000
X-Gm-Features: AVHnY4LBW6EylcBew5SQXK0Re71gJu9Q1V4gFkbAeLFGGFCzFa-CeYBeZj3vF68
Message-ID: <CAKmqyKO7yQk3eKm87FvJ0gM9BnOgnwLEegGpdTJHsYGE+HnEPA@mail.gmail.com>
Subject: Re: [PATCH] riscv: virt: avoid RISCVCPU copy in PMU FDT setup
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Mon, May 4, 2026 at 4:04=E2=80=AFAM Mohamed Ayman
<mohamedaymanworkspace@gmail.com> wrote:
>
> Use a pointer to the hart instead of copying RISCVCPU when
> passing pmu_avail_ctrs to riscv_pmu_generate_fdt_node().
>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a1c323e66d..085971eedc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -722,11 +722,11 @@ static void create_fdt_pmu(RISCVVirtState *s)
>  {
>      g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
>      MachineState *ms =3D MACHINE(s);
> -    RISCVCPU hart =3D s->soc[0].harts[0];
> +    RISCVCPU *hart =3D &s->soc[0].harts[0];
>
>      qemu_fdt_add_subnode(ms->fdt, pmu_name);
>      qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
> -    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
> +    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name)=
;
>  }
>
>  static void create_fdt_sockets(RISCVVirtState *s,
> --
> 2.34.1
>
>

