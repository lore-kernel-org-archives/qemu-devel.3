Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B181C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllpJ-0007c5-P7; Mon, 20 Jul 2026 07:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wllpG-0007WB-Hu
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:06:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wllpE-0003VU-PY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:06:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so306970a91.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784545579; cv=none;
 d=google.com; s=arc-20260327;
 b=Jdv02sDsBz3nSKHcUrGnL7jaFaFCx85O/QkqUFSMa7zXKyeK9E0UGOEvurNMvGHRV2
 crHZdCG3gwW6win9hcF751yeYOmEKvx4FoXVrbqe6UuQdjmx11K4sH37mz7l7AS8eiDq
 pWim1oRvuBdbeX6M20PmvIjTx8fUXB0KEX7p/brDHIfZm3Zb3HC/xE3PwxOWcZHyUOfa
 ZH8OaFOYXNiHr9AWWRxkcBs3g77/Jhjbfot6FEwV1jT/y/pHQrH4JDyHAVWPLpC9qW7c
 fGJ+M9MG97UJ4c9QvOO7w5l7tMFROowGAxTbyx5MTlXcF8pT7Z28ZmGIm2YJ5V1wHjhD
 rIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zyANhnZ9k+RcyOnHxj62+row/oJiquHJv3MGzBwUxgg=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=AtbJsidEbwbiMspfuF1gIaQFdjG/teco4wRzik1+q1rMMUoy0W75PhWrL5584fXPxS
 aRF6+mvE3/IgVfsoaL4bpL7RGTpDPoCBJcUgCIzB5g/2lr3Ade2f/Q8Q+fN+SCS4GSSU
 z0lHOflSF08xRmUOLR5NhEwyAf7u1owqSCPhmBCTLJE+IWVF6hWcUBwTU9V/kfO3GRT/
 ahiLmwgeIIODkLXMjRDAY8mj2cydqK5Z26UyM0s1aL68caaDOcXYcREPrMNH+ZP3JB5k
 eG2vaf6ATv/ZmrfRdLTNaAhqGl1WA0ny6zjUeaosCbsvS7fwVQzN/+ohmrUrFyyiqJS+
 ZcmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784545579; x=1785150379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zyANhnZ9k+RcyOnHxj62+row/oJiquHJv3MGzBwUxgg=;
 b=g3j2n7WmEjDj18ERX/iTOpPLXExtyb7G4fYRCsDZIo1kIYCEua764xhYFvUMQ023el
 Rg8VhDCHOv5pgcnLefFVCDuxqk1PrQPPNmYLR+jL1shmS2Js+AX6lbap/895LA6srBw4
 /LwlnVvDilKt8WbUAeRILLZ1RtLbVjf0GOo98TsTxEmtHFT7YHIogx+6U7I3uMgAsGJZ
 AUdNMtCle2pb+7Ojxu+aH2nzbcyeQuQcXGIeudwKQ5eDK2cPIXczBIsZRPgqeTVFP/tK
 hn+2qYvNvUbpt3JoP6ujthM+uBN7BEoyRIk4rE3czg6bioJ7kJsqoyjlxtuV+J6zrqwm
 CE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545579; x=1785150379;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zyANhnZ9k+RcyOnHxj62+row/oJiquHJv3MGzBwUxgg=;
 b=KA5Pt7rm+tZX3Qf1d/MXHpmxyaqo+I4On53DXmtkNNHnDWqLnDNXI/4KYmRfdalh7j
 KU0u2YlFDjhZnwlb9nMGHwt6FabQmd9vUAnJtM0m2176fWT39ZYo9GAyv3AamodCr+mE
 K4y4zOIRI9nQaXozJO0HfiIt/cFoFmG8+6cFzIISgrc0igGipmR2hKeFtCPRQrjjTE7y
 soYU7sLtT2eMvWT4RVY+oevZbuWTUm3rpEoiQ0ruEii2MrHdLe1o/aYD1YNgfbE+PE1t
 xeowTjapYOsEpyfyI940Nn/0AwtfSnV9SkZp2kCsUbjkcPdrevhg0LO53juEC5y+gxgl
 U7uQ==
X-Gm-Message-State: AOJu0YwGqa7tpkl61IwPclk/cAK7pI2MDkG6XfDYMphkqHiN7NQ2BRvn
 pc0HmVp5VfFx8QWrqCMpDp7Bd+5wPRxVTTts0IhePR/C2UU04Ot0hfIpw5lo39JNAd6xx151yNG
 DMJ3gor69n13TaHJLEKlS5oqddYxnYEjOH5RIlSE=
X-Gm-Gg: AR+sD12XMZ/jtk3oYIY/oeQNF2RSdvnrCJlDKn0r3a1DSRp1GKzsNVWI0BucVyMU3zF
 k/DrSDUHAwjW2zUZwNxi9nG67WyWX5OLpFwtSRPNwX2ZXf3idfmojvO2hIvY0Y34IuBR4b7Gvsa
 aM8MS0TH51JuBh+tAtElJsAcV/3rBTwfwJ/dEpxNy6Kk8QqCN5h8agH+CWzJZXt/AV8TdqUSt7G
 JPOqymHyyMxxZ0f/a4PRyKZzSS9dHiNOY18EB78hTesbIQQIn3O8d5r5mIlBi0qDx1RuOP6qhEU
 UT+0afYsTVoHAiUZLQ==
X-Received: by 2002:a17:903:b8b:b0:2c9:cf5d:d9b8 with SMTP id
 d9443c01a7336-2cf349a4e71mr157269105ad.33.1784545578880; Mon, 20 Jul 2026
 04:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 15:06:06 +0400
X-Gm-Features: AUfX_mx9NgWJXVbIuPQYXDWmEekPJZkizOl5WKyK00TZTlmgulIWJ288zT9YNbU
Message-ID: <CAJ+F1C+pNG4HWNDL9a8D4EU4HDW24eg8S6eVHgLs+=nE3H3Y6w@mail.gmail.com>
Subject: Re: [PATCH] hw/display/qxl: validate monitors_config heads[] in
 phys2virt
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Hi

On Wed, Jul 15, 2026 at 11:28=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The qxl_phys2virt() call for guest_monitors_config only validates
> sizeof(QXLMonitorsConfig), which covers the fixed header (count and
> max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
> buffer size to qxl_phys2virt()"), but not the flexible array member
> heads[]. When count =3D=3D 1, heads[0] is accessed without its memory bei=
ng
> validated, allowing a guest to cause an out-of-bounds read.
>
> Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
> the first head entry is validated within the guest memory slot, preventin=
g
> guest-visible memory reading.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
> Reported-by: Tristan @TristanInSec
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>

we are receiving multiple reports of this issue, can someone review?

(why the code only cares about count =3D=3D 1 here? to limit the area to
render. in case of multi-monitor, it's the client job to handle the
monitor-config areas - tbh I suspect QEMU -display doesn't handle that
well, but I didn't check)

> ---
>  hw/display/qxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 74258afa582..3df796175c2 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -270,7 +270,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDev=
ice *qxl, int replay)
>      }
>
>      cfg =3D qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP=
_GUEST,
> -                        sizeof(QXLMonitorsConfig));
> +                        sizeof(QXLMonitorsConfig) + sizeof(QXLHead));
>      if (cfg !=3D NULL && cfg->count =3D=3D 1) {
>          qxl->guest_primary.resized =3D 1;
>          qxl->guest_head0_width  =3D cfg->heads[0].width;
> --
> 2.55.0
>
>

