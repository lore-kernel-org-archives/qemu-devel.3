Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E169C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0Oy-00042l-Df; Sun, 28 Jun 2026 21:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0Oq-00041j-SS
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:03:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0Oo-0008SF-FM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 21:03:00 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-697de335c18so5317653a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 18:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694976; cv=none;
 d=google.com; s=arc-20260327;
 b=ohtNSb1fXcxdkW46nNnVrqmIqODVtw4DrJl5+emcAvUw0KC+TM7G9RAIwrtUA+s4s9
 xznP77j5u+brjIUXTSXmKgYWCPohQWNLCgx4/zw47Cma/wWWONpGoSj2WWxtxyw6VJS7
 Fbi+Wux91v8308WfcBk2q0xRhfc0WfyYwexJj9ojXS2aTAAqdzp212tIR7lXPn42Qr/i
 YxjMBj2zUQLBAjtBB8es/Mcl6sxA6Kd/Y3Vx/D0JLg2aq3sWkt4iuYPeR6UpWPUKcUMK
 kIrvCuG2ZnIzbzZmfhmfYH9u7FtePradp3WXhSHRnu6MM3UEftCl0CPW3lTdpO6VLhol
 D+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HXeThzPRQlbC7Deg8yJSMmt16h9NKwjC+NX4T58zivM=;
 fh=yQaNYF+Oz7ksFoYGMjQ09yNPixHDFFscKkD1kIOJZgY=;
 b=brngG1JdfVGos11bdzTjP3A18GxVr2gS12EhHdQRSYOa12tlHirj98PTR9Ic99HFjC
 VRtMFzpFo3Hk4fyWAt62NyanwPFCnKiz83FZkRQtL417Fl4i8jV7iQqFQmHaeQdfemFC
 mbl7nswWajvsi/MJrbtSv0cwKybtmaPTHGwxsRz2SY9ZKQIx3Psd3GZqj1Py3+zpxJyl
 2v3x4ZLsN3KRWbi6dq9lrP4ug8knCTn34NoUu6NIX7ac5q7pYYD4Aot7a1dWoMPhtlVU
 pj4XgkSy3/KUvETYFVvvsxUruT5l1B7PtBeZ4Y8QPHHufXSzxca4f0vH04WcMg2hVnlO
 OFTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694976; x=1783299776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXeThzPRQlbC7Deg8yJSMmt16h9NKwjC+NX4T58zivM=;
 b=ovCIR8duAqcsM8dOoRACtOcVn2nmNs5WzfSiS/032o/BOvaZGXiwpjEGNCBW+ZitQk
 bB+AGIgu9lovlndfwmG0DVDldqMeO0a4K8nQWkZnUriOOoKEYBL9VCiFvmnsxhKm932l
 5thPux0azIwQ6WZeF2Xhwmr819qUMp3gPHViv5ZRlpFt/fdNl7UoecVfFpZL3Q8qSQbD
 hirVjN9VOGBOeALFQm+EDyKFSg7emZvNVuAXd8oaL1bpeQBhbr9zoq/Cf1FG7bnoJsd+
 6I7tXrZrFFiamKVXgKid6NM+BXzCMm1jgy1tw4DLqqtT5HiFEiXQ+OOhWmcgH9QzIvO9
 tO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694976; x=1783299776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HXeThzPRQlbC7Deg8yJSMmt16h9NKwjC+NX4T58zivM=;
 b=TLVn47bkJYTINJHidmbm1w7mAgEIictq7+J9zg44uN0JvsqxHAGxO6JeSTfAYvFm22
 /0RtW4To22PU2VS/jVCBg5MGaJHticpUjAdiuveluZNeJmgjBRNDa1F01RyYC/IMvoVX
 LzmjobFQHPC8lYlj/H/nR9K7VkeiTG26lcE6LVqn4Orrn/g6vZuRFBm3Wn8U0xu1NoDA
 xzSbxH4Lm+uJWBptkMaj1Wn6oKA8Mk/a9zcTlsioKibM+XoztyD15RCNB+wb/2v2Rzkx
 u7mCOY8BKhJdXf7tujlTrsUveDskR7r+4QV7NiMu9nB/BIeoK8aVsU9vqUCkNIBiafyI
 KvFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkSa2Pn+PMRcvhBYEpYU9C5atDm3tnY475CbQE7q43a0bzq3DL2qikvDDYqrmMFD+ecJq2RGRYkmB8@nongnu.org
X-Gm-Message-State: AOJu0YzdvFVIM+U0sy2Ik5YtmbHzRjIoF0TxQW7+4tgS3MYlpCjEhzKu
 U4Gcexm6Tr0Arl9/5hrReMse5WE6x5HJhWAhzjQNz3XHMMn9FSKgdRmOFoUxqBfOgLTV5/r4Tff
 jlRMEN+/H4Cifst9wj2EVavbbyYBvrV8=
X-Gm-Gg: AfdE7cnqbAiOkT/yZfQNGohJ3lz0hU2Vct04w9FmZKiQgLTWh+I9nnvIUrfwENjb1mf
 T2TEcenIKkHZZnr3A8UAG5x2mD/usBUTBqaNRhFgquhZxcI8lIp651jF+EEOJwBSq11uPO9ZO9v
 eXzg7NCssoOCYE6r2S8tdb5vYQrYnQqySakIOuZ2YzjB52hWTZXqXJJIhjYbvYjmSNacj0vcc3S
 hfcSoCaQN2WbfyJ28oUAMF+d4EojweVaRMfMWxfoNweCEAVXUjqTvZSivaKOcnugkDACcMu3Sq1
 4Itlk6/poN1f1fm/qTBjnqwM5vTO3s17+FWgZQ==
X-Received: by 2002:a05:6402:5113:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-69810a45891mr5285524a12.4.1782694976070; Sun, 28 Jun 2026
 18:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260622113402.563196-1-inochiama@gmail.com>
In-Reply-To: <20260622113402.563196-1-inochiama@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 11:02:29 +1000
X-Gm-Features: AVVi8CeEJ8aKXqngsxtjy74Tpl-17M24re5WU-YMY3sESK03fk-TjPvK7loMl0o
Message-ID: <CAKmqyKOaS3rzSmvM0FPkH8uMV441qxes_5-sbQwc8T5J_jsYjw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Check PMP before updating PTE
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Mon, Jun 22, 2026 at 9:35=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> According to the RISC-V spec, the PTE update is a supervisor write
> operations, and it should also follow the CPU PMP configuration like
> the PTE read.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changed from v1:
> 1. Separate code statements and declarations.
> ---
>  target/riscv/cpu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 59edcdd370..2db07f5dfb 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1655,10 +1655,18 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,
>
>      /* Page table updates need to be atomic with MTTCG enabled */
>      if (updated_pte !=3D pte && !is_debug) {
> +        int pmp_prot, pmp_ret;
> +
>          if (!adue) {
>              return TRANSLATE_FAIL;
>          }
>
> +        pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_addr,
> +                                           sxlen_bytes, MMU_DATA_STORE, =
PRV_S);
> +        if (pmp_ret !=3D TRANSLATE_SUCCESS) {
> +            return TRANSLATE_PMP_FAIL;
> +        }
> +
>          /*
>           * - if accessed or dirty bits need updating, and the PTE is
>           *   in RAM, then we do so atomically with a compare and swap.
> --
> 2.54.0
>
>

