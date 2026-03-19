Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2ED1088E70
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w33zs-0001GS-1c; Wed, 18 Mar 2026 23:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w33zo-0001FP-NC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:24:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w33zm-0004sm-Nh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:24:28 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so77095066b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890665; cv=none;
 d=google.com; s=arc-20240605;
 b=EgNxF115HDWeQH0iUF59BNfNnddVun18hxAmSj1iBsH+Uh1y8WpZu3R3eKsM8+614k
 VcKjPDS52RGCHdaRGkQ1H7ow2GhIDBGegKUtSXpNj2Z9Xea1omsuQheQs9JhpiwDGXxw
 uqTRzaof9QGYxDb1pe5gGwJiVSU18jg/GYcALz5hkZlkzx0ZnQkQAsWNnrjf+QUigabC
 OJzkSXA5mWCKekcWrnw8e1BA89P4wR1C8QnjZqdVhHVN0JMxVf+d5+BT1FBBV+1aJ+CA
 X+pela/oTFIahPOqkXCGvTc66K928iwdFnEWmqqMyhHnufk6W4jceH3bp8kGHtisoy/z
 nh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x9l1O1GiurfrzMGAs/zSYgLd60T4mxF0TXNyJDQTt6Y=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=arS5egUdwWhB7ikRfrf+P32QQWm5Br6CAz3xLJ2LOV80nEHzfDPOaVv4dPeeEbkM1Q
 gZ9e+D1bT7oW7Bb8DUOK1IfN1eZPybpMf+0VqEueVxIX9oy/eczditDaHhRYl/k+M4G7
 l6OkGP74XbXeH4t/nhmsge2jTQV4+BoMsz0R+GcmcFv3Fvr+8pYIWrvqY5id5owFB4Mr
 xPCFAj1o5SXpoLRMT67/I6sk/A7iFf1SzzNN9hOPOmvqQLoEBv+5c+jaWn6ivD0CuC6d
 TyH7FhytPSSkuHtJG6iQ6JEf6Y7saOj2Urmz2+7r8SZeXrdL/XwdHkSgx0c/0vPPv6qu
 qjWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773890665; x=1774495465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9l1O1GiurfrzMGAs/zSYgLd60T4mxF0TXNyJDQTt6Y=;
 b=kqxgvgEXuC1WpaGfX6LOpeyldAtlsNAeI0WzIoYaMVrJ3f9qs6IG/cjNqzpVxqoQHz
 7c48N6rwfrQCPnDZ64ZiI8CrbGCxoFdLPY79ojIOMKreTbW7dQJ5zLUMQ27Juwh3HaLY
 nyw8fXQ/9Nhb2oyk3Gzfy8vaHMZhAiU4OPrvaUn4P79R/7p6xpX9Ca+9JWFZZ2zpU350
 Ctki7OfJueDzcagXrVOSPrzKLuLMZZYzLSOArdKrLbPvjnF28j+6gt53tHYJGD/jzKPO
 kPHBg9RhArCn2rZCC0YNIZdKK6X6aRiqqvjYIIXd2nBooaO3dUDdk1nrh9/g1bHeXj/C
 NzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773890665; x=1774495465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x9l1O1GiurfrzMGAs/zSYgLd60T4mxF0TXNyJDQTt6Y=;
 b=emAGNL1Lp5mgTMZktyCmw4CL5XB0YOxCADf/Gi/KkAgJzHoWKrhSBa0oeoBFYeJWkG
 IR3/waiTNxB0lXcd6Sqfk+rF5AuBMNjD+HTewlyoPLNbKfaYiX7ICRfkgz0Izziq64+7
 ILVa/vYtJH/KaC1uTtqucRzef+4vCXzc94kP0DzjvVLruMBzXvsYjRJYnv4pk/wD/51L
 8qltJrOV0jrY0+S5tPW/y+WjS/wVoHG7gv/D/aHJFdYS1rHcSLD5H+WnTv/2eexDT8Xu
 W7Mu7gwv84JXDsp2zRWNCEb2AopRJ+5XHsDUIEN6fVodg3eG2L6GBCq1aI/ijEaLcOXM
 3VJA==
X-Gm-Message-State: AOJu0YycpAUuRm9W7RrrzO/lRdaWgf5fVdKjCuhhVPXkJOH/56TU7UYJ
 /u0HoihYjno+BjLCiFGOstQRd1jOHgpEZoEuGVCR4c8PwBgWqjsPcZ/REagpawoqmVE80YSpl7/
 VP1MHRc3idx1C0G0VJOU7c2UxQVsF8KY=
X-Gm-Gg: ATEYQzyAYRa4REanWJYy5KE/anrJv6sIryq7eABl88pg8U96/yOBNbh+28q1KnMfPwF
 S+jt4iSqBQM7viuvX+rkl5BG848sT3rqgY4yhQeaoDsClS5is64yxT9fIfGykest7fJ5eZCkc6H
 1YfqifDLB3rruqWfRyvOjzKHmfOEMZ2L3PVn6CZkUvKLVVsHeHzGT3wLGQwTclAlK+a/JqiZ7k/
 cYWjUQQ7FN96Gas173pudHuQdqBV1eedVnXoz+KHJdgcUiHrZjXYCnuyLRE5OGir4NgMVWiSTv5
 iBp8TNZhYa77G1rL+2zPSU5z/VMoixpxJzVPfA==
X-Received: by 2002:a17:906:fe0e:b0:b96:e796:135f with SMTP id
 a640c23a62f3a-b97f4b3420emr342017066b.47.1773890664594; Wed, 18 Mar 2026
 20:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260318013805.1920377-1-max.chou@sifive.com>
 <20260318013805.1920377-2-max.chou@sifive.com>
In-Reply-To: <20260318013805.1920377-2-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:23:58 +1000
X-Gm-Features: AaiRm524xRxln3bf-RwTviZ3YzhEEU4gY0jC89VhyhKTuGYu_QxaYC6mrvlzTno
Message-ID: <CAKmqyKNeydJiQHHcpG8KkEonmcGWNd9a84pQdsxDE-2RPjcSug@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: rvv: Fix missing flags merge in
 probe_pages for cross-page accesses
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
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

On Wed, Mar 18, 2026 at 11:38=E2=80=AFAM Max Chou <max.chou@sifive.com> wro=
te:
>
> When probe_pages probes a memory region that spans two pages, it calls
> probe_access_flags twice - once for each page. However, the flags from
> the second page probe were overwriting the flags from the first page
> instead of being merged together.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 3334662dcd..a74ce70943 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -265,9 +265,9 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,
>          addr +=3D curlen;
>          curlen =3D len - curlen;
>          if (flags !=3D NULL) {
> -            *flags =3D probe_access_flags(env, adjust_addr(env, addr), c=
urlen,
> -                                        access_type, mmu_index, nonfault=
,
> -                                        host, ra);
> +            *flags |=3D probe_access_flags(env, adjust_addr(env, addr), =
curlen,
> +                                         access_type, mmu_index, nonfaul=
t,
> +                                         host, ra);
>          } else {
>              probe_access(env, adjust_addr(env, addr), curlen, access_typ=
e,
>                           mmu_index, ra);
> @@ -275,7 +275,6 @@ static void probe_pages(CPURISCVState *env, target_ul=
ong addr, target_ulong len,
>      }
>  }
>
> -
>  static inline void vext_set_elem_mask(void *v0, int index,
>                                        uint8_t value)
>  {
> --
> 2.43.7
>
>

