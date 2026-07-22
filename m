Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F98C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmSJX-0006Ca-TK; Wed, 22 Jul 2026 04:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmSJV-00069x-PD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:28:25 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmSJT-0006Ch-5p
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 04:28:25 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-81ef8255cccso44347597b3.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 01:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784708902; cv=none;
 d=google.com; s=arc-20260327;
 b=UMRk8odmt3+byg4NORIsoLX1gk0CyQPMSOMLl8RSJcflM0N2qIwWlD5Py4dLLlytWt
 f38MzUmB2kgBZOP76iwK68+ES91XFTq5kzlSY1J0Oq5eZvhLK+x82KwmGIndtd6N3jFB
 LAoiIBq0UvpLUBeDb3sf+YE7nH+wgJpDDeBonUSzstbOhd15NjV/YHA06j+WhPOxeH9i
 Vo3PIc74ziwbM43Q5IJffPW0i/lZJuLzlqnuG3uTQbSngZibTu7xrn8FhvdlqeNwTiha
 aAcLh7Cf7tD4AraRrB9UXz2qZ/mTiQnZM3gLNazncrCrN5f/O/U07IGTbfDmH6h/i+ye
 taiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IX4/AlWewffAWGWySoMQmvTyHnottXjg/RjxkYgUjK0=;
 fh=VE2/2b3qI52zUf1kltGkmF2H0Zu0Xgy0u2t7wf9yMvo=;
 b=Z2T6z5xpJy4ZH6wC3Lw7Xl07+RJSC/vodoXfCzWqGTYh8diHJcP2wQ91u0OhrFrjNb
 8rQP35g4r7Pb3mUT7lhleGsinY7XxpOOMujLy7WsSxpjn8Mu6z+91BUgl1ylqLjsPg9h
 83vEJ91QvoyJ3fxxupWpeK9RUYdgrEuG7gpqZv3VNAG4v2WE6N0xpIPuQa8V8tAuBOVE
 Jze7DmIOg5RFaJFjThbTueCNakaXEzQtmtBON0mfpfllxBF4PmvYcuLu90ROnibXjoCS
 BrlxpyYumDKbUO9C3aW0zDOPU2VTmgkDB6BgwMfHPUrczWXg8j7400dM1mTjDmecWfdC
 YqPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784708902; x=1785313702; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IX4/AlWewffAWGWySoMQmvTyHnottXjg/RjxkYgUjK0=;
 b=BRUeQaAk25nXgirzDOq7pDbbMcUZe9fNGsby8TbHeaeOnioNeKf2cxBXQtGZR/wXlY
 H1mfre4rFeqvGVA6Vk1KCOoW7yhaaz0MtJ+Ng4ckNaLH36tHkqRG89UvoC3U+Llh85Lw
 IXCE2D1N10bsMoTlIXbj1Sni2Nyp+IvKbvDM4L0jPVDsAZN1cSC3ZbMasg2Cjk6HJChH
 /Lpgc4PfwONg2rcP15QHh5jJEJFvkmxoXufACYcwAP2preDh9lDhsoEfthLBfFTdtcMK
 oVgabmLCyuzRiB7iOMCsRcO/stNxqRmubnvPC4Q+St8Xp4HB57YatyPluHAYmX4xpYnC
 7r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784708902; x=1785313702;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IX4/AlWewffAWGWySoMQmvTyHnottXjg/RjxkYgUjK0=;
 b=JGmFzp0JQfgHxpf7zAzcxkHsMI1Eo0ypICX5Rg2jKwnfs5nsY2lbitxMEwHwckhq7n
 UGcg5xMScWZYueb8KnMmHPUNLFfujI9v3rVcfNWRJcI4++FRz9N9/gWEHahTZdi8XEC8
 LcMgyCCGhzVfaDzpDtNkLA7VxNU6toUMpc1kDfuy3ZbAiWR2jNzEaarFUZ4USdpuhEnz
 EkhQqyWxEeYL2Ed+3dOVWWz9gLlJhwgOwX3WPsh6I1EY+9k1w0hcC4U+KtgaXWTMGUft
 zS2PkQJs8+vIAg3bRpNFdS5d4t7A11a8hUwJqEwIHSkLQBlCyJ8ts/k43MrnH8UVQN7M
 9CrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RruIOErMh0BFvoeCDeFRRKE4OFTV0pzcrg/UtxPG0X4bIEgkpKMhdKFMx2Gswb7Vx3yy8v3IoHQle1/@nongnu.org
X-Gm-Message-State: AOJu0YwoeX5/k40WLS42rzT7n9HPe01wsPHJMQGP1N+G7YoMIclGKLpa
 bypnF4PsBdOwNeD6Iu71/WhrVKtc8KUE1/li/QaCOH1XpaqqPK8uyRdTJvRYc6pz3mDDREBeJxT
 vty+rW65yw+Gude1AenD6EAVDW8j/JEXr0f9hHObfUQ==
X-Gm-Gg: AR+sD11QgCC2w7m6pH1Jvmo1qINBGsQNElZCO6Len4Px52AF85hHDjyVfUBF+qjnQ5P
 atvrN3paIa5tpZkqQjoOXCuYYzpcEj2/CPQ2j4SRS6zgdtBFJHv8oqHjnqiIqwAD+u6UuKK9r9Q
 bHBUleguAVzrfOoL+FXbjN1WXhlVh9srQ1szCSo4mMLcJFCuv3UyopZPxG7TOrx1kfbn5iempP4
 dpcPVZ39LVb1xuHVpZ5WH1uUmui7LloupDFWCOFRwqkjR1fCzYgeDGpHH8798tqlP4SRZRd4gwG
 ZsdTpXQdqBuzQUJqM2P7qpXeDuRaCNotCfIxp9SAUaS1QQ==
X-Received: by 2002:a05:690c:e19c:20b0:81e:fb1a:f222 with SMTP id
 00721157ae682-81efb1af3b8mr37828467b3.23.1784708901775; Wed, 22 Jul 2026
 01:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260713064617.85374-1-jay.chang@sifive.com>
 <47fb7730-adba-419b-9c85-298ff245cce9@tls.msk.ru>
In-Reply-To: <47fb7730-adba-419b-9c85-298ff245cce9@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Jul 2026 09:28:10 +0100
X-Gm-Features: AUfX_mxX0T5xPhbUX8OXwfAH3EgEtU7IQmnX98kAPMyM6sNvU75SeoXodvukYtU
Message-ID: <CAFEAcA985uQEASh4=YSvjYw_EBte+TxUfziFe4hsRvaREB70cw@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xilinx_axienet: Fix PHY register 17 link status
 reporting
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Jason Wang <jasowangio@gmail.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, 
 Frank Chang <frank.chang@sifive.com>, QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Tue, 21 Jul 2026 at 20:03, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 7/13/26 09:46, Jay Chang wrote:
> > The Marvell 88E1111 PHY register 17 (PHY Specific Status Register)
> > bit 10 reports real-time link status. Previously, this register
> > returned a fixed value of 0x8800 with bit 10 always cleared,
> > causing U-Boot to always detect "No link" even when the link
> > was up.
> >
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
>
> I'm picking this up for qemu-stable.
> Please let me know if I should not.
>
> > ---
> >   hw/net/xilinx_axienet.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> > index 970732b162..9f5f65ecfa 100644
> > --- a/hw/net/xilinx_axienet.c
> > +++ b/hw/net/xilinx_axienet.c
> > @@ -103,6 +103,9 @@ static unsigned int tdk_read(struct PHY *phy, unsigned int req)
> >           case 17:
> >               /* Marvell PHY on many xilinx boards.  */
> >               r = 0x8000; /* 1000Mb  */
> > +            if (phy->link) {
> > +                r |= 0x0400; /* Link is up */
> > +            }
>
> Shouldn't we clear this bit somewhere?

You mean phy->link ? Probably that should be controlled by the
network backend. But that's a pre-existing thing (we already
report phy->link in a different PHY register).

-- PMM

