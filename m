Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF043CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdIc-0003d3-VW; Mon, 25 May 2026 17:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdIZ-0003W1-Ls
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:57:24 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdIX-0007Uj-GX
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:57:23 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5aa2c25c632so4649870e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746239; cv=none;
 d=google.com; s=arc-20240605;
 b=Cf3RiBw9M7fedwBGz0GzMw+t7uUh6dprjjvYgJ6MPCeLrhcna8hg3SdgkXZez+foRa
 UmFmLHyP3Unbng1UthP+S96oxrU8m83AcVdEogYYdzs40afQEwM/dhKMuAECyi2Ddk8V
 MPi5ryAoL4+XL3TBt0kIclpXXki1aqT6Rkp8fx+qgoGW7lDGyGQE5Rqfwe9xagriAi8x
 WJHUpahSf24/ww1Eal7cVo3LAvlNXedcp0AgPon3wp7H3UoX02VyBM3d2iNE6lKtPOIV
 AuAfZV/WPgV/757rZemdybMUKYCvFJjy7vSHUAg2DbWzxIqUJ5zId6p1cNFamB9h1o1o
 mQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ue1+0VlXhDfpInGbVAPxq61logWIddceh99NqEfMTuk=;
 fh=1rwoE7RuipPJZEJ/nMsuZFWBBE4DJqFoz/8+CJ56qNo=;
 b=kynM2GYd1/L6y4rofSLtxdKiurThXvllz8fkuTjKmO/EK/OaxSfGVDwaMOTt7YBYD8
 4vjqDf8F/GALmbnOqsvjWQj2pn5f0Nc/7jWS9CLMXgOP2Dr18o9us54/8vOcCJxohh/Q
 hNUVgspU4jXyOw71/7kNQ3josO0v53/ZWG342ZMTU5+GxF07+tGdvPPvOxOn83nAPV05
 hqBO68Tpcic1orrwtZ0J39gQ9IeZGLpL0kquM/jSZ+W2EAjouAbNxsEPI3fP1aHJ2mMG
 7LJ4MwWNqRJI7ZhYUNS+o5qtuDf3W3p7X6mwI6oUM/Cmbz2LRBjURmXHH+PZSSz8WdCI
 P/ZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746239; x=1780351039; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue1+0VlXhDfpInGbVAPxq61logWIddceh99NqEfMTuk=;
 b=h0rD6v7YcqkNIhncNf2p2eXIra3ygx3+JTVhHFAAHcJ3116CMu5OKXG0GG/FugJFNW
 PPDsdUHSW45W74KsW0nh7oYRKTAFYC4rgvuu7Ys3cNVr3WF/01dQpBxI/c46sO5nlgyT
 KNrBFcYGzjjMroJlCTsRHAt+BbRLG3S58mUerAsFEIIC95nNODyaXedcR2BccnN04KOf
 fJO0Hh82WFd+8wbwp5EXInd1EtQmeF6p3vAjHXl27io9BBApUgPBE8KKu+qwHZvzkLLL
 ZRKbLXrcjUCPsYmYVAFP6Woo7cq1hCcrO07T7gOxwuGQr+f5bUNHgpB73SpF6xofyOxh
 Uv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746239; x=1780351039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ue1+0VlXhDfpInGbVAPxq61logWIddceh99NqEfMTuk=;
 b=YCD9fTa5nssqX6nETxI0u+Hts+ZZdXg59kkQEgQ35yIrmqObSRDRZWJB2jjeeu5YXh
 yd9yE0fGk1ssP5veD5N728WJNYwp03QLXvM7HUWc+IQ69WEgs7wiFo8WVzMxxtePTdy+
 8elsGrCnnCt0d503a6pCASDwShwglAj7ZfVzpGznZc3Lat6ApYRAUhEKUoPfcb1xqR65
 rgDqR0gMYLnLR610Hn0x4f64vdXA8EVykxp52140/7BOO9PW+KXc6aCRKgQhDWywMQ+Q
 1PyqtNDF+oe9HgTIU+Wsz2MhVkhDCgYuL5n/Han+X8DD6QPD4ShLtAhUKieznTiMou00
 hYBQ==
X-Gm-Message-State: AOJu0YwRrKUyudmuTuNnFFm3C9du7dS+CHBbEQD5NK2E/44pQiWbbKBV
 zlZVCVOsRAtPzUwujlEZ7OiNpbN1MsZc5p3n4m17FpbXPxzXzIcuAP6/XriXt4DLuLMAFLmEmbw
 qAd/R+jdPw4lLFbjASQcA6nfmiTR0Zgg+yD4S2Xs=
X-Gm-Gg: Acq92OERE5zuo/r9AX1khStP+ILhMZsJeqftauv9hmWQdaYkoM5+MQTdxJHmceHlBH0
 qLsql/6b57SFCX0e8BrkcgP+kWqCFFxPv6PcyUpHD33EklKcpXlljSxy6AggH4fA2p6eHwBeNFF
 D11I+8M5sKq7Y742Bl8o3EBgcucOCe+Uhqt/qPIruk10KInAHdpFfQGeFvSAcpSauXz3GrcaePM
 WLpJ5fZZZQ/QPvzHycYI3tj6gNcqZi0XAhHLNP3NfRWFHMFxb+ypDOG/RRefon+nKp6GgrQMpw1
 qrSUz4m/Gw==
X-Received: by 2002:ac2:53bb:0:b0:5a8:891f:b3c8 with SMTP id
 2adb3069b0e04-5aa3238ff28mr3881080e87.39.1779746238790; Mon, 25 May 2026
 14:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152210.4119543-1-mattst88@gmail.com>
In-Reply-To: <20260525152210.4119543-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:57:06 -0400
X-Gm-Features: AVHnY4J9DmL_xtZaau0pkirbTtgeS5mrxyMx8yETIX82FyXdV6iWwUH5pGar4KU
Message-ID: <CAEdQ38HygG1xE5s+d22hd96Cgmu+uYBub53gSDF_iw7_ivLSDw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/s390x: restore fpu_status rounding mode from
 FPC on sigreturn
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x134.google.com
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

On Mon, May 25, 2026 at 11:22=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
> The rounding mode bits [2:0] of FPC are reflected into the derived
> env->fpu_status via set_float_rounding_mode(); every architectural
> write to FPC goes through HELPER(sfpc) which keeps the two in sync.
>
> restore_sigregs() restored FPC with a direct assignment:
>
>     __get_user(env->fpc, &sc->fpregs.fpc);
>
> This wrote env->fpc correctly but never updated env->fpu_status, so on
> sigreturn the interrupted code resumed with whatever rounding mode the
> signal handler last installed in fpu_status.
>
> Factor the two-step "write fpc + sync fpu_status" logic out of
> HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
> it from restore_sigregs() in place of the direct assignment.
> cpu_s390x_load_fpc() omits the specification-exception check that
> HELPER(sfpc) performs; raw signal frame restoration does not validate
> the saved state.
>
> Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a si=
gnal")
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

