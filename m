Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEA4E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 06:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXaNc-0005C2-FD; Tue, 14 Jan 2025 01:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tXaNa-0005BZ-2S; Tue, 14 Jan 2025 01:26:22 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tXaNX-0004Lr-6w; Tue, 14 Jan 2025 01:26:21 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so6798000a91.2; 
 Mon, 13 Jan 2025 22:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736835977; x=1737440777; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEZ/nEeVCH7QYNb1rvCb5yYHxjzkDfqHnJevB1lUwUU=;
 b=AxpkCHFRMI8XrooUSLB1mdBr+pjSZAitkuGtHi6B1+nmawmwwk+ZjYHvKnZEq2eQCd
 7fL6kxDkdp8DeXhYa3hlYbOtjCDQomJYbYx0KpdOhAWlF+5MKIvsAf0zmRrgnrC2CBIJ
 XqpZNPRBlIJq+E+Om+MkxJtUIHle4FOwhuEhq4pwfqO1uHibWLLHjQ4qbRXSpzZA+DGf
 O2/LpaqRHULWRSrr04ygeDZoh7O2492wN0N+YH0mCzZ2TLEhSN30Nwwgdw/BYUiLTxz0
 YeARf01QyylFQI6lUCG1kh9GV4BOan9UlCMrHio/mKsAOh0PSCr7kP0n83rnWXxx/z/Y
 D49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736835977; x=1737440777;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vEZ/nEeVCH7QYNb1rvCb5yYHxjzkDfqHnJevB1lUwUU=;
 b=F3v6P8NNMfHQXc/S+rM3fGGbzULYcPd9mEKeZqJbSfzUV5zIHgjhu6hvH4lXGvM2SN
 1drDupybAfoSNzt5V+3/sbFVA/K886b7XusGpnS+ONnKmrxAlnYHmd/MyDjZqZad7n7L
 g+2Lt2gb5698sjqowL6efDX1sYncyiZTzb3YlAeFs16xKYtrtHfDY1T4jtl7jKZ5zvVT
 T37qJ/UwZ8W34046ke19HzI9EB8rO+1qzvdFIG6NiPMaauH4sWRLvWok8AkiYUjx1c9+
 oRgp9EMNQA+zLfMgQMAL5nQYVvZmDKCGVJaI1nCOeYZuO/0p3gPE5SmeXKYBnqsPJgqV
 qpPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDV3NKzivWekIv7Gr61pZ0T7JedytdBb2Qoy7mZlUW+w8IW9vw1IncNRUyHiDLaV7G5Z8dEaQbYw==@nongnu.org
X-Gm-Message-State: AOJu0YySHuaUrdTmIZzSc0ps/4cL0B3GBRaLv6+wxvBrohBAQoCWH/zd
 o16R/eyjMkQRZTekzOIdvhBTtTYGA47DW+LlYxCLs0bH0OuW22LN
X-Gm-Gg: ASbGnctHVK6P6N8cJtUv4xBgc68zvYuo+qw2b/oJE1woYI4uihvFJOwuxZT6dH0d4yM
 m4ketJ0ZHb2uOueX8LziR1r2yaO2d6c6mG3D1zQ3nlfvLhMZ3G6lSRvaw8u2U/C5ngBakY6JErB
 u9PQGqhZ/mZ7rUckRpgQcr1n6ZfX1SR8OMdsDWsjjQG04Lm/fCPpB7LdvMemcABzJJSXj0aT4FO
 miD19gR1UIIOgW7ScfYyJDCjVyVlyov6UrCs3iSzs2fv3Ny
X-Google-Smtp-Source: AGHT+IHDZZQG66wlpUrAAt0wc19BQPI1JhbA2HNe9VXcVUByZsCtNbZ4MCGR81WVNkMvsmhHRMXMNA==
X-Received: by 2002:a17:90b:258c:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2f548ea5b95mr35802308a91.2.1736835976905; 
 Mon, 13 Jan 2025 22:26:16 -0800 (PST)
Received: from localhost ([1.146.73.114]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a2ad291sm11050778a91.23.2025.01.13.22.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 22:26:16 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 16:26:11 +1000
Message-Id: <D71KYU8XRDJQ.2Y0PO1ZGNMLLQ@gmail.com>
Subject: Re: [PATCH 0/9] ppc/pnv: HOMER and OCC fixes and improvements
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241210030451.1306608-1-npiggin@gmail.com>
 <5690ed2b-366f-450c-b724-98f0b474123e@kaod.org>
In-Reply-To: <5690ed2b-366f-450c-b724-98f0b474123e@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue Jan 7, 2025 at 8:00 AM AEST, C=C3=A9dric Le Goater wrote:
> Hello,
>
> On 12/10/24 04:04, Nicholas Piggin wrote:
> > This series makes a bunch of fixes and improvements to the HOMER and
> > OCC unit models for powernv. It gets OPAL OCC code happier again,
>
> Nice. I had similar changes exposing pstates and sensors for QEMU.
> I am glad this is now possible.
>
> > but requires this series of skiboot fixes (which I will hope to get
> > upstream and then into QEMU in the same release as this series is
> > merged.
> >=20
> > https://lists.ozlabs.org/pipermail/skiboot/2024-November/019013.html
> >=20
> > Big changes is moving HOMER from mmio register implementation to a
> > RAM memory region which better maches hardware and is much easier to
> > work with; and the addition of some dynamic OCC behaviour to the
> > device model.
> >=20
> > I wouldn't expect any review of OCC details. It's neglected and this
> > series gets it in better shape than before. But anything on the
> > basic structure and QEMU details is welcome. I will add some test
> > cases to help ensure it doesn't regress in future, I will have to
> > juggle the skiboot fixes as well though, so will do that later.
>
> Have you considered modeling the OCC in QEMU ? I am asking because
> I have a series removing all 405 support in QEMU 10.0.

Yes we are looking at modelling some of the microcontrollers by
emulating them not just simple state machines. I think starting
with SBE, but OCC is on the wishlist.

Perhaps hold off the removal for now?

Thanks,
Nick

