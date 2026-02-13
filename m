Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901B1EDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqQF-0000XI-3S; Fri, 13 Feb 2026 05:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqQD-0000Wl-Dj
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:13 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqqQB-0000N3-WF
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:29:13 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-794911acb04so9222197b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 02:29:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770978551; cv=none;
 d=google.com; s=arc-20240605;
 b=DFiz9TuPzXrhFO1nv2wPEQJH4s1TNADliuWEHmdQqn4RD+AVXqOnD7K15SR+jfNI1n
 F5uEr2BJJAVZu2Msy5FX5KWy65lVQcOOn5YCrnIzXzYk08IGRsR9nmY2TW/TSMBjX44A
 5rZh8p3tNGBhGQbCh6CJOv4pEwPYDGkFXqlipCSN3yZ197ys1Owb7HbYOiCCgQ2WCxWF
 m11k6T1P8cBXj1xDhK2TaFyTq44WJXNjkOiCJykVkZP9SQksTXo9loPJckS6PO2RpL+8
 RDpb81ixXfs7E8DJ0PjK1Dp6Vgvp70rVbGctEce33ih7O7JZJZeam3jEY9y7ZWZ+F5He
 5Bgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hj3NtxKyIISkqE1VuvTOWMDO1iZPqMrZ6MbKQP1LWFY=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=BySIhpIr35HeGW4y3r97XYLbl1fKqYH28AbSPJ1D42kR0I27Etq3hnB7scAexiIOxF
 QpsDZ2GTirG2/6jo6s8lHshAsqZ6agWFK6iHnKwGzrXcaJ9NopfAmdf8h0ufK+gFdk+U
 /4HKKwpVoVPG2MGA1e4r3bpM7C/HKaHw2b0UsrDeMkBTMwfRajeYspXrxH6HI175ogy/
 ZrnccjvpcWFfCbLNLtM35b/3HsALCgQGKnjyjcJmHywYOFQwSputc6Jbmfju5IBsLeez
 rDYNUF4fyTv/DGc9zWry6MsfuWLZsbKFxMYQE5HUphIwQRckCnbpoHxL5puqvUUACpp+
 ZupQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770978551; x=1771583351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hj3NtxKyIISkqE1VuvTOWMDO1iZPqMrZ6MbKQP1LWFY=;
 b=U7rIFiUeU5myPAZ6fCXWyr2Yxd9oC4vRjHGhI2OkBEEQbSwypSMy0I8hxILsNDPBD0
 uIn5IWFowAZGnQKdJc0w4DV37+z3v3pr5vSKXjIzuGvuvPRfJwXdQfXw1fi+PaGE4C/k
 sVk37Q6FBYDcwAemoncc6qNqNl02byfFoom28r8Pk3tscOuiyvmOdapGECNzw/S7ppeV
 1Nf0YiTRRSX8LhyQ4QSCFrmFCiTcitIbXUZkwwD8gnEhLecvdPnMWohcYfmtThEips9O
 Kk6DKvF0D1YFbQ56jiMXPUtu1yWVg+7B3a9j0oKVudUPSSD1tcCT3a1dqZgc+EIXpUX7
 j0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978551; x=1771583351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hj3NtxKyIISkqE1VuvTOWMDO1iZPqMrZ6MbKQP1LWFY=;
 b=fYXajSRswXrh4ToiMz198WxRz7239Mi72++bk+jzbSG2ZNxTe09K5of2PpqPIfW/8Y
 avFCKSUj4z72HbOUoHNfaWW9j4vi/Ms8O8ayu2VKYcjvN1zUJI4+6k0y9T8Ip6F/G0f1
 bJeq+2KLoMzABFf+qfurjmWFrE1ul+QbM+QxLT63UFx+NAsG5oiTp4gTeHuBzUF0g97R
 QGVE5frO9ecPK1es/iMLtNJP1S2ehlJvqW5OyuWav/jS0CaDVG4/qKwdTVswvhrIfqGA
 /namQGyvRuJhQlqp4fls7a5iMGTr9URRcFT9VdcSUqYo3fAbDzcCt1r3ftr4A1QiBsPi
 pGWA==
X-Gm-Message-State: AOJu0YwEkIh7CFd5I/G1mmzXqVrpdhm9dlr0qTY+LOGN0fMO9yfUmSiP
 2tAWtwY9n8XGRM8Kkx9CoPoC9aMgYywZ/2wSRDwnVDn5Ta/H2fjgFL7DiPaVoGqwSDqzpNaDbT8
 irBrKONNba9rqPuXiX7K4TDyC+5eCcVGrOg9DXwKxGw==
X-Gm-Gg: AZuq6aLC/iGmcV6IEaZzXx2x0iLDnlOhmCHiq3Z046NrdaLXq8nMcGlYoGKPsb0fyQ2
 MUyRbLL2X9RaUTUXYExEpDBhMtLNoELcK88dHR+mfpZ2f0EWkxIS7m5KjSWJUuCO7WfrrbYC4sX
 /b/qV0qg+diQKlPP1fGQhjZ9vMuSYXLqKNzWKd8A/WXfNkk7nasmf6a1W72W5DdbsuSFL13gUVX
 xcdHnMRGIjd+EtokV88acZuCgsS6DFHUd4C1K6kgS3xRu8DZcSFPjomR5RKILwwks1xDBZ/eqxD
 vK2tp7TyzSjr1IcMxD3hDyB3FLhuKKVdsSnHR+eXUhz0eIcnjX15uw7vSw9vnT3X50o=
X-Received: by 2002:a53:ac89:0:b0:64a:e7e0:a70d with SMTP id
 956f58d0204a3-64c197a3676mr910394d50.3.1770978550628; Fri, 13 Feb 2026
 02:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Feb 2026 10:28:59 +0000
X-Gm-Features: AZwV_QjsER107kMBzPsp4P-ehe7YUAcU3Iz8VnVxT2BAx09znD9J0J07a-psmmE
Message-ID: <CAFEAcA8mNEseopAdCm2_t=xdwn0jF+savDkQRBGwZp_w864Brw@mail.gmail.com>
Subject: Re: [PULL 0/4] Plugins patches for 2026-02-12
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 13 Feb 2026 at 00:43, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 4ed6a7f2fdc09d9fc3411e83e278da0085122016:
>
>   Merge tag 'pull-block-jobs-2026-02-12' of https://gitlab.com/vsementsov/qemu into staging (2026-02-12 14:35:18 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260212
>
> for you to fetch changes up to e82d8af3da05e5315a11d0841e40ff0ed0ce53c8:
>
>   contrib/plugins/uftrace: add riscv64 support (2026-02-12 15:59:48 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - contrib/plugins/uftrace: add riscv64 support (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

