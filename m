Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4ck-0007hI-7C; Mon, 01 Sep 2025 09:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4cY-0007Wo-FK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:31:03 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4cU-000238-K3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:30:52 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d6083cc69so36945537b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733447; x=1757338247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wewDKBxoOFdqvc7S2uy/Z6NBdCATlYzXKB/aUZXycw=;
 b=w4A8f9loqfEbJJavg5DEFKucvR0+F0gc9YKrnoDt14kcVq8lz0t79eDDdmhRcMsiNu
 bfX8sbpIdcnJnULMEM3FDDVWa7k8Lq8lJ7DbCHGGy+6abXu01xkoVxDheV3VELC2MfqG
 tLcn0oHL9L8knrjaP37IJqfquU8cktD6VA1k36nJYS3fqVPO5zAbe+WsiKX/cD1qokdU
 +uGModhFXO2pCmIit0/X1LKZfJ+7WAzxkdTR+39DzZ/4tENR7xS+OectAZ3I5FgA9S+Q
 cl2IX0GPX3lYzLOfGNrssScU+OzrsxlhuYy4IX/MVDHzYMX5BEMVUy2R2hLjwQE+XIvz
 RcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733447; x=1757338247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wewDKBxoOFdqvc7S2uy/Z6NBdCATlYzXKB/aUZXycw=;
 b=KZMm79NlM/LMS6eNJ5jkbf6OTHnA4EVooRZExRZxOYijYNYH1OJGbpz/QnOOozIcey
 UU03cuQTPd+FeSA0kzrBel9xVCQQdXPZOSeBmtLM4h9kt8r/sT7bAYx61phmjq3zwD7H
 ftXjpkMIwnNiure0PmR1NqO9wwc4a7MP1ZxY2hcHDLcRRBE4HAZYJAMdoMz4fAbu/KvU
 6BWd1SeUTBA6OB0o+EAHm0hBMNc6WkAPIKr56Txp44SKxAo/uWQem8YrNmH4xfyR0Nlj
 UwjkbpEZ3F32lcuC4C2eJdy/5T0S+nGNi220FUih8TW1awiiFes4S/lYSejDb31w9RtX
 PRMw==
X-Gm-Message-State: AOJu0Yz9Xp0NIXu+4+judKbPh7vcBIUJy+DFEOwYmD5P5091HSsDUe4p
 wL0FtcT0K/dshUhzDGIXaQj6dPX5btgOHw1349G6N4xx2RH37y4A0ypCxjb6jFZOXfuYHZJfELn
 1Z2lJ7WzeAP9brKyQCqKZo6n+xY0Ev1NUysNlFew8sg==
X-Gm-Gg: ASbGncuHWD5UwbjpY4m2xnThzMv0wEVU0+J54UhxO2Qsj/GKYgURoXWRiVfBiUeDprO
 gy9iJCjYxbIblSnUNbii7HZZHz1l0x+pDP6i+qwu4+2TloAHCSMzXULhAX5N+foQlpRn/MeSUyQ
 rTLdiVH3+n7wjEIA5Wz/ok84Z329Na7S8ziprTzYHTzJFW0H+YJDGWy9TjXbVMD1OCD2RnkxZGl
 sFx8FUJ
X-Google-Smtp-Source: AGHT+IGzjinj1Be9uhF4e9coeqgVzYuT4x2ZSFoce3lK5RZMIpoiIrsyrN+OSeim8sWHmwNEAkHYp47S9Ww/3rxmKDs=
X-Received: by 2002:a05:690c:dcd:b0:721:30a5:3bf1 with SMTP id
 00721157ae682-7227636c956mr97919527b3.16.1756733446963; Mon, 01 Sep 2025
 06:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250901132626.28639-1-philmd@linaro.org>
 <20250901132626.28639-2-philmd@linaro.org>
In-Reply-To: <20250901132626.28639-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 14:30:35 +0100
X-Gm-Features: Ac12FXwmkA9tdz4_ZeSzqYzgko3ZQfxuJ-MQJ-B3TXNsqo3Nq-CJMU_3_X1R4CI
Message-ID: <CAFEAcA-AysYGvuVL07DBaRvhFzRpCgO8cO6oeQUXEPRNhRoCGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/ppc/kvm: Avoid using alloca()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 kvm@vger.kernel.org, 
 Glenn Miles <milesg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 1 Sept 2025 at 14:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> kvmppc_load_htab_chunk() is used for migration, thus is not
> a hot path. Use the heap instead of the stack, removing the
> alloca() call.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d145774b09a..937b9ee986d 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2760,11 +2760,10 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t =
bufsize, int64_t max_ns)
>  int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
>                             uint16_t n_valid, uint16_t n_invalid, Error *=
*errp)
>  {
> -    struct kvm_get_htab_header *buf;
>      size_t chunksize =3D sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
> +    g_autofree struct kvm_get_htab_header *buf =3D g_malloc(chunksize);
>      ssize_t rc;
>
> -    buf =3D alloca(chunksize);
>      buf->index =3D index;
>      buf->n_valid =3D n_valid;
>      buf->n_invalid =3D n_invalid;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

