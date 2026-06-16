Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63665CD98E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZI58-0001ET-BJ; Mon, 15 Jun 2026 20:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI56-00019W-CL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:55:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZI54-0001Ze-CP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:55:07 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso7694111a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781571305; cv=none;
 d=google.com; s=arc-20240605;
 b=V7H2CsdDO3xAFKm1IwaAKLtttyCUKvMdDPgYnV5qH3HoP5VKJXdLKaFu3oc946ECxA
 DUIT5NN6SasJOasZlnvnXi6+2tMb/bwFdVqVjUHUi92Ovfakn3Qtisiu7iCDyAVJ8PV0
 N0Z1jmTrIv4EDzEeY6o4MyefaMdlYZZxzTzw6jGtVnTLlCrxA4BTcqBQ/EG/US2vSEiB
 BrUfMucm4NnwDEqxorGLK11UZDbNQjAlCEUVBXYs0QUT/uLr8jj/cvKoFJwIJ44nXFdC
 HPJtnBDX59uWfOLj15Udb4TiStq5tedvPCXGnMAR7VUZbFCaR8Z8iWCmj4IDtMCt3cV5
 lioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ARFXXHDdjZu3t5KhmEsJANjeUNg+u7EbrdoJTAMg3Uc=;
 fh=VWpDDznhhkns+RBYcpzRS+HdjURLRuFdq8+B6bSxo40=;
 b=T7tf76wTGLl8fDuZAJnZa1kr1JpfVZRv28a9Vw5FC7nmYHzBXXrEvDa3QBn0IbYHTA
 bWj4661AxVXTnSf8mHqq5eWrmFuYMv69K7Z2zJyrswso8b8HmhG44ueDFm4uGClgSGXu
 DE/EuqiKjPcmVamdd9jp76Gi8YIEmfxM0SxKgtJA/8mCH/cXtlcwRBKaWh7dMC1sKjvo
 6aUZdoZHeSLXWxrBt5JooEuch1d6GvBX9VuosvemZRBCafrQYOqDzzX56P/57EmtlS+z
 ggUk074DMs1dP0uToLheDemcWqrBzVzVFHlKyXTWf6zqcV/kTY/xzoeoiLm5MrOlq/4N
 rahw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781571305; x=1782176105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARFXXHDdjZu3t5KhmEsJANjeUNg+u7EbrdoJTAMg3Uc=;
 b=FhRPIOdZVECNQgkOuoMl/LOvsJmq+PtMWPGbUaN0+58vpg7pkfxtFUHhbQit/cqN6y
 i3w+8VKM2BwEUL994I/p2X9W7quojYM+Bn121ASCPhpn3lBiTNShq9WfZmlQbCVgreK2
 +5R42g8AYhtlLzFGEyHpkrs2+73IugPr2eXjmPmYusKyRnoPCaDT6to0p5s5jix90Jv3
 nk62OIMf0lpIxHyshMmWuveH5ysLkORpAgYz+Pae5ExPEc5fJMvYgJs+I1LahoEwbClZ
 MlbywxpNvCWRI9hUXg3xjqpj1xkSPg2eMt6swuw0FYpcyPsr3haLnucyIBf6ujKk5Kxh
 WRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571305; x=1782176105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ARFXXHDdjZu3t5KhmEsJANjeUNg+u7EbrdoJTAMg3Uc=;
 b=oNZz8u6wds1kXxVIbxfldqMM989Hj7mvrBu6heQialw4U7xatdnDT6bSUsOgsyKTwr
 JF7rmAk3wgFPkr7clXq/CM0DnZe5zJl4uYRQIf+keVgQf6bB8CBZlCQRy383z76DBT4h
 0qtseTd6yklTaqSSu4WXkx+tZKO/sGI1HmJ4MzCjArbBONAOLGmyDPyBbMLG7rl4uA5g
 Tgj5/c7VnaZBsRC0Z2dP7u9ZIdO2UcxS/KvuchyMacda5DM+w1Y2W6n60tlF7xMIL5LG
 b8Wn5YAXRABPjTqijYj0KmmLMmuNdzgMS/o7xHHqJeiptp3h3uzBUnLobRqfZFsQlDPK
 tDIw==
X-Gm-Message-State: AOJu0YzvkxmUHKkFfg3IexN5XiD3PUfi34aLc3K8bMQMUDFSCUqne94d
 xV1B/ahDI/1NSCZj8cCCtTAwfDy1k/NEVdrf4zLicWVZZeQM8nosl+ZJDBwcBOvjpJdZjfxSERq
 YhRNMGoy1uY0vwYlkVVRkB4cnP0CyXxs=
X-Gm-Gg: Acq92OHMHngqB2CYVnhGdIU3Z5nEdsXW6wZgWQmaAxxkRvy9Ug3EDgP9n73n2JaKroC
 E5FyPuMeleb1e7PPswGJDxscIsYOHFmwZaAp16vdhe3IyHsqgqI83QFDXVFIOj4iI6mmGUNTW3y
 qPjyExm1sY19P5wL443iJWWkm/DuUHzWZCPRjG4IDDdpHsAaCfQP8Fd459XyCaVwqoYCUp8Ih3X
 NLzjW4KBrCaCfEMJJipWDU3YoyQGrsMcOA1nCuvRf/3I3lOG4B2ON5yaB71quT9JsqKmwR6t+KA
 q02e738lQuaGl2OC7GKUNTfMrdZR4ChyASxd6Q==
X-Received: by 2002:aa7:cb08:0:b0:691:acd4:df83 with SMTP id
 4fb4d7f45d1cf-695081b84b7mr566796a12.5.1781571304728; Mon, 15 Jun 2026
 17:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-46-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-46-cc9396b9c18c@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 10:54:37 +1000
X-Gm-Features: AVVi8Cebc1QaKkTJVDFiG_nRsnlNvZQv5e4F7FLjQN_BwUow3O1JyilM-b_kyzo
Message-ID: <CAKmqyKPOMqcvqKMU1H4F6C12Pp-iNNFNp=95PDUiGB+Ek5juxA@mail.gmail.com>
Subject: Re: [PATCH v2 46/53] target/riscv: fix incorrect QAPI types and u8
 casting
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 16, 2026 at 6:42=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> "pmu_num" is u8, "pmu_mask" is u32, so is "pmp-granularity"
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a63961bb713..98c9ebd791c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1302,7 +1302,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *=
v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmu_num =3D {
> -    .type =3D "int8",
> +    .type =3D "uint8",
>      .description =3D "pmu-num",
>      .get =3D prop_pmu_num_get,
>      .set =3D prop_pmu_num_set,
> @@ -1338,13 +1338,13 @@ static void prop_pmu_mask_set(Object *obj, Visito=
r *v, const char *name,
>  static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>  {
> -    uint8_t pmu_mask =3D RISCV_CPU(obj)->cfg.pmu_mask;
> +    uint32_t pmu_mask =3D RISCV_CPU(obj)->cfg.pmu_mask;
>
> -    visit_type_uint8(v, name, &pmu_mask, errp);
> +    visit_type_uint32(v, name, &pmu_mask, errp);
>  }
>
>  static const PropertyInfo prop_pmu_mask =3D {
> -    .type =3D "int8",
> +    .type =3D "uint32",
>      .description =3D "pmu-mask",
>      .get =3D prop_pmu_mask_get,
>      .set =3D prop_pmu_mask_set,
> @@ -1486,6 +1486,7 @@ static void prop_pmp_granularity_get(Object *obj, V=
isitor *v, const char *name,
>  }
>
>  static const PropertyInfo prop_pmp_granularity =3D {
> +    .type =3D "uint32",
>      .description =3D "pmp-granularity",
>      .get =3D prop_pmp_granularity_get,
>      .set =3D prop_pmp_granularity_set,
>
> --
> 2.54.0
>
>

