Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA913C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 13:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXpY-0001r4-W2; Tue, 17 Sep 2024 09:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXpM-0001iq-1k
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:01:08 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXpH-0004vd-TV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:01:07 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f75c6ed428so43029011fa.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726578062; x=1727182862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuLdNxOOuE1/68l3MCMFs4AY+pYagPyWswEZDL/NiJc=;
 b=s1CA3V0I0KiGepdxoFIFg87mnTW491l8vCC1X4FlAoOkYQiinUdoqlh7Uj9FCuXYsy
 C9JoxpLRngp3fawZhX4Ccek5goUxXoIzl0yNHBJjkF7HNS1qib4MyJTVHat7k5/97fa3
 eImkF05g9jYUVP/T2X95FqkCCU00+X5uVVkQm+fTrYsaRbHCrhDgtEGuCU8Cal8wiFXf
 5118bhBskfNBY7j/S3y9FM+sKNqvjgf9hvRjHnbdxWkc+ejKNjWt/KEKadp+3ByLb7yB
 iVgrvs/RrW1hOhXfaZF1igRN2x1jNfkHkd3rzGZpPGc/WEv/nFluulpjy9llOHT9WKR6
 Kw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726578062; x=1727182862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zuLdNxOOuE1/68l3MCMFs4AY+pYagPyWswEZDL/NiJc=;
 b=PMYxBG2T7whP3ZdligzERPwF8GtrTuoFRIDMBmI8u0l/ptjL8Oj2BfspSaRDMwNIRf
 /kHsLC8oHIwa1dC82kUZxD+10NKL6V/77iFZjv5FocTyD7hUcvkjHFtikfSCm4LTBUO+
 TIYaGMvwVUw+SQf49fLNvNCkvVLF4avuf9EAjZVVipfZJAKw415nDiPKcCmWOYZ2lCmo
 2bsJe+VJbJXd0b9kZL/T6xwweWOGpLSDkU254DVZndTPeOGBzt5MM1xhXQRmYqm783q/
 UFRdrMJDqZTtnd5Yy0QJrxRmvvx9j0+VvC/UWzAFJBIiYDm2+Wwb3wF9V/7FcK01xWg+
 WGuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDdot09tJTkeOA/9104ua4/bux/6R6mYFl2tU2iGaHuaIcjIKEnrLO+Te8YzS7VsoOban516DsslXa@nongnu.org
X-Gm-Message-State: AOJu0YzIekZCJ3VhuSFM7l9wKKG3yGj1Doyxdn9MSaH49sqpnVEfvWvl
 Y3f2Y7dogCNtMRW84/0CEllRX+6/B0d82vU9YR1lLpojy5YrpqXE2oN5gQVvA4haBRxE3vZoeC2
 M40IKropa4jEhhCjRjnnATr1+OI+4hCc1+ioQyCB/S5EIP/6/
X-Google-Smtp-Source: AGHT+IEhPfPXAvk6MhkyJVhhaYrV3SGgneag/+StN/6p9myqm3yiI2waIdUKD9sWZ/CkVOGQvJ/zwpfwqKCC8eDlIek=
X-Received: by 2002:a05:6512:3e09:b0:533:d3e:16f5 with SMTP id
 2adb3069b0e04-5367ff24fa3mr8984525e87.38.1726578061021; Tue, 17 Sep 2024
 06:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240916185708.574546-1-clg@redhat.com>
In-Reply-To: <20240916185708.574546-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 14:00:49 +0100
Message-ID: <CAFEAcA_mxQsC-vehCEqxY+2+vFeq5saWhhRg4EeqrP6Sh1xF0A@mail.gmail.com>
Subject: Re: [PULL 00/12] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 16 Sept 2024 at 19:58, C=C3=A9dric Le Goater <clg@redhat.com> wrote=
:
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb=
0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into sta=
ging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20240916
>
> for you to fetch changes up to a93bb519e683fd8f8d7945e5517fd5ad74cc41c0:
>
>   machine_aspeed.py: Update to test I2C for AST2700 (2024-09-16 17:44:08 =
+0200)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * I2C support for AST2700
> * Coverity fixes


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

