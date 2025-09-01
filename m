Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CD2CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Eo-0005YA-NW; Mon, 01 Sep 2025 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4Ek-0005UA-DE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:06:19 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4Ee-0006J3-6L
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:06:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aff0775410eso400274366b.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731966; x=1757336766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPfpb6HjmaL+6OfXuLPe5ZVPtf5dqY3m5j8Nho8xd9o=;
 b=YWKoG7mEe89ipkZjBc5xZFHe1AC2gYFNjdX1XxotFPnVsRm3UhwNCltNN18rasogID
 gUDr9SPNaAXQhvWsQYJ0zkEGhShqhYh4QWlBoZEBXDkPi/t8+dwQwKaEZNBHhOthmTXG
 G+xMYPOFkPoQv34M1ac/FLfebve/gkDx2U0MJ2N5Cfiu4/ZK1e31usZlKSByVlW3xUAk
 7kdBARplUu6i7lz2ygWS0hX06hGXOhYbxQhtIIHr8ZFn1KHZmpweFfARrlXthjNhX+Nu
 K0m0WF0yZDEKz4t2uY276YFofudS7r/hU5AIQdHGx7uUk7AqDAOZ+dc/8BeGXlaxsKvK
 Q4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731966; x=1757336766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPfpb6HjmaL+6OfXuLPe5ZVPtf5dqY3m5j8Nho8xd9o=;
 b=QtClfAlrpoIHiaryYTxOzaDQKaQhDjNj4LsNozAZg/R+5zxFBdgk/685oXu3nLFZkT
 RWRBi7D0IZPQINm1U2yKk2eReR10hcEvYBH7RT/WZmgF3bkZlLE9CVyOiBO+YC3PFqQ+
 JOj5jBiYtbRka9nHjc2Swydc4it1pNMdrDkpkc5ICoXxoRGBZr8Tpp+FlRSZJMSI5sEO
 5a2bIOrkpij5gdKO537UxGhj4Jg/XaeO1vhsmM+WuAiv6ehsqeloan+5M2QzcSmDoa5h
 rIJDo2skX3VbqIGZjouwGHBpc3pb2K5SPuaI+ipzYLR90HncHA4QbEupRkJDxkkkdyxq
 Stkg==
X-Gm-Message-State: AOJu0YzL56kXfIE5/g87hX11itXTEw0dWG6G3BrvYGGNlWG4vpRwlg7T
 bopIj5KzAcdJlfpqqBqP1dyIxAjmfbi5GU6tJWwnY9tza3wfC7QavKnUGyHchQlqSNVE9rTGmCA
 IzwF7xkJfWkP97/QNIJyquyBcocPiqUvrqp0dwUQ3aA==
X-Gm-Gg: ASbGncuhyZqmdNS5Nmwk92Zvx4r65gnnlAnjc1x862nybsERSxpCxNypxJnkIyeiTc3
 F+OYBOXZM14fUqfxQcGNlae2ZR5WRma+WcXTZhaMPn/VK+PoSr/V/RgVb7FL+NQpboL7UZVeGoj
 rxnOmkc8fBmUMZVX+1GmHIo2amd65TJuHCv7cYyEso9hQZ0Jbo5wJKi0Nwdb0ZCIVOG2ydG77zt
 sofQgMQmKp+X/mNJBc=
X-Google-Smtp-Source: AGHT+IH9jm7Xq6VGX+byduOfx6thMWGmdB+TJDIHfcIKibTqh2jbrG2PgFZiDi5USr38Qm50YJ98XAPIlvs32BEJR8s=
X-Received: by 2002:a17:907:60cb:b0:afe:834e:ac6c with SMTP id
 a640c23a62f3a-b00f67e0f14mr783396266b.7.1756731963951; Mon, 01 Sep 2025
 06:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-4-alex.bennee@linaro.org>
In-Reply-To: <20250901125304.1047624-4-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 16:05:38 +0300
X-Gm-Features: Ac12FXwJpnQw_jYWjAYNnTnocgT8O5z25Zj2lSVW9SP-bcyIpjjDBwDDs8dhboo
Message-ID: <CAAjaMXbDimt1wToH5BMCuTiEvfb3zaW=tNwRmLMTAvERb8u0WQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm: use g_auto(GStrv) for node_path in
 arm_load_dtb
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> This is potentially more of a bike-shed case as node_path will persist
> until the end of the function.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/boot.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 749f2d08341..f9d0bc7011e 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -520,11 +520,11 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>                   ARMCPU *cpu)
>  {
>      g_autofree void *fdt =3D NULL;
> +    g_auto(GStrv) node_path =3D NULL;
>      int size, rc, n =3D 0;
>      uint32_t acells, scells;
>      unsigned int i;
>      hwaddr mem_base, mem_len;
> -    char **node_path;
>      Error *err =3D NULL;
>
>      if (binfo->dtb_filename) {
> @@ -586,7 +586,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>          }
>          n++;
>      }
> -    g_strfreev(node_path);
>
>      /*
>       * We drop all the memory nodes which correspond to empty NUMA nodes
> --
> 2.47.2
>
>

