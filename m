Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4428CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xImTz-0000Fm-CL; Mon, 19 Oct 2026 08:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xImTW-0008GD-NL
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:28:23 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xImTV-0000Mp-59
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:28:22 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ab395abf79so14608967b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792412895; cv=none;
 d=google.com; s=arc-20260327;
 b=qUS5dIydJ+1dcOlNxtXLh0Wv48mxJYNIWLgxNgLKYCJu0+TLcAGPgjCH50yhSc004V
 MpetAlpDiam4wcEyHvsKCRIIYK320ENK6jbfaFiiXiRi+VhyuDI5tdVSWcpDM/MVmGPn
 Fg0E1IlEEV0Cls+Zuy0APChff47Rts2UzKNHKRWKF3b3vWOgEPRPJmPw/KBrJS5MKTZi
 myMTrQ0+Ujd64ubGMwdZoRDiTFGg0Ddw+7QOsgtoWWieGWyajJqODpyVfqJCYZkn5l0Q
 Y9OwNvJZOY8D742M8Lf+DqOKOkN0RGBjSqPRnqTi4F38/E/KQMIQAaGxpRuLWeuIFUaJ
 e4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=34RLzC1wwpQpXbpSrIIoSB+wn/VWBsthmUohL+T38AE=;
 fh=tjh95WMBNrJFBejVBXqqhOTDXWAx3lAkDcv2fmegKkI=;
 b=F6+igiPhTLlUIauuTvBx0tbiNgFKxoj6NkJnQqvNYrYLoODNIK8cTzBQTIm4HAGpJk
 JrFaMDH5oZwy1dy3LAu3N8PTngNIt2nIwtvTFkDzz95nu2ujcI7Ztbyespb6JQ1YSGsd
 DQn5/tztxd8+Vw/UFfrCK1ZIH6S+3xw8SWJ5aTAJP6LD+j5ZiA7cXPJDwoT3tAGuSs8K
 FtbAYByS4FFMeB3FVVhDJyj7d9TA/EUvc4c/qsb6+rtAgZwDHqIAJpRYgNrokgrs4QFU
 sDSPEIasbGW0MVtgJsZAMbN7LD+SQ+cD+A2OZNCVOLrvYtJ5kXZEZ0xan09mhoztgDU7
 aBGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792412895; x=1793017695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=34RLzC1wwpQpXbpSrIIoSB+wn/VWBsthmUohL+T38AE=;
 b=RfUAqB1RN/ecjr4kXv4z//pTVie80l7mg+yqf41qsBXDlNnd7xcJOMkE5StjCNUKeu
 eDPTJtEpVUI0mg/0JxyDbMXkdHH8eMsLCZp4BdquItWsvCQ7HbpdJC4DPLLe3KxA7Bhe
 X6ch/IUxJg8PliFyjbT/m4TcqA1VCPOIc636Igp48bKD3njZrQtAs6gYSIpJC75W0g79
 HF18wnvGxMi3lcK5+2iD5ctcQj3FH2yGH8AgVPOnNacNI2KYk2O2KBirya/mv8Mzkc0i
 UIRGir7qjC05X4GFhb/dViap9B50/UHQEBLEPtuIadcb7H98zLiFzFKvTow4RAde/Cqy
 qK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792412895; x=1793017695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=34RLzC1wwpQpXbpSrIIoSB+wn/VWBsthmUohL+T38AE=;
 b=Qnm54cbEB6FKAEKKzkGJ+wF3xeZLOab2wiULsxaFCQs1kMGUHSSoovVE2wf7ySvGYB
 IIRZTMzRYMU6eq9L1QSfMzrX4qRwjJwLspt/CHyRX+10zXXlUEl63wFIh1/CssMZ1bfc
 nCJ5idTi0j3VlcnhHC+XwEQmjakX5wxgQ258Vz7qzuU68ddZEKO96pwfFhmCPWZe1kT0
 2LoRSxgHZgQJLrfHJg1HxE4mI0pqk8wqnvl5C8Lcz1DYoW1jfpmTiry5XfHQtIjSAu1T
 hOjOgVwalqsmtgwMtWcA0lADS5s4y4G0vfB1I0WaWb6cmUprNo6l3iqSuySO1TP/3e04
 CXOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+dBCSVznDHStRmyUkcduPrOnCg3fQqB2dITDDJUdkf5KDqotj8EN1eZfXJRHBgbVpWsj8IPGHcpOa@nongnu.org
X-Gm-Message-State: AFq9FYIx+2Zo+TUvvl/GDjDT3KrCuKlbiL/4BvPpSGpDCl6WAzpiTn/f
 KQSY6YYNsMnS4W5ZLUSUJ1LuGTENlXBGjgeGllkoU9Nl2sj+8CbMsgQxeq1EAmYPuQi3bGLBfNL
 EXF4grKNgrIqJUFFJj083oyHgEwCJCs+1NRre5bDTUA==
X-Gm-Gg: AYBFou0KCNTiT9T1YPuObVmXeS8Sk0TSEO6o1XEWxaFJemknMgLex3JOdna3YUdAJnB
 /fe9oe5YRm979ICG12dDhGba7bZu3/EDlVsiuYVxi/+qzzb9AqodBV8RmBni/EM+CWfuu8us3Pg
 xvE4o52ciTqN/eMhdIDYpKptYk1vf3tafF6cWxPiRgOoGROCI+i+8DOdmyVSFYTr6bXJL5eualE
 30BBrrSe47OwrYNP3gXScIbVNUnpkfndHWdSBtp4cURCaXug5h7Y0ozQ5qPz51UE1SsbMFVqfEh
 6RhyZnd8/RRHLIqSPZ4xnOqbvo85NcBD6qJhL8AFzuxXSVIKZct38iuQWysDIKSvec+Ti2kcaw3
 5QhxprPD64UzDNZBifUVZd3LSHdMtZmxdZ5Ura2g=
X-Received: by 2002:a05:690c:c68b:b0:8b0:6d14:23fe with SMTP id
 00721157ae682-8b0f2202eb1mr17282667b3.52.1792412895483; Mon, 19 Oct 2026
 05:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
 <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
In-Reply-To: <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 13:28:03 +0100
X-Gm-Features: AclHuK8AlgJedZqd6BbTphQbtwDFjtnseZ0HCECBuB6w6tYGBjx3P18DkS2-zjo
Message-ID: <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jinjie Ruan <2118537295@qq.com>, anisinha@redhat.com, armbru@redhat.com, 
 eblake@redhat.com, imammedo@redhat.com, michael.roth@amd.com,
 mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 19 Oct 2026 at 13:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2026/10/19 20:01, Peter Maydell =E5=86=99=E9=81=93:
> > On Mon, 19 Oct 2026 at 12:46, Jinjie Ruan <2118537295@qq.com> wrote:
> >> One honest caveat
> >
> > Please don't send LLM output to qemu-devel.
>
> Sorry. Here is my understanding:
>
> As mpam_csu_value() and mpam_mbwu_value() below done, the monitor code
> scales the base value based on the software-configured PBM
> (Partition-Based Monitoring) or MB MAX values, rather than just
> returning zeroes.

Thanks. So we report "you're using the full amount the system
is configured to let you use". That seems reasonable.

> And most of the code are to expose the many MPAM registers, constructing
> the ACPI tables, and building the hardware topology of the memory
> controllers and caches to correctly expose the MSC (Memory System
> Controller) components.

OK, that makes sense too -- I guess there's just a lot of pieces
of hardware in there.

thanks
-- PMM

