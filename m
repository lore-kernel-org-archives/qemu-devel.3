Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C010E77184
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 01:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNj7W-000788-JP; Tue, 17 Dec 2024 20:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNj7V-00077i-4X
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 20:45:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNj7T-0007GH-9F
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 20:45:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216634dd574so34716605ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 17:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734486298; x=1735091098; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooLVj43p9vkhKiKtVu2n7rlFQaqiKe5x9AtS6yKY+dU=;
 b=ZeuGNIEa95do9ks9/Oyws+XM+i7Sdfliuq5TKW4/ThxVjJihfeOg6OdF1LLKDzfqXy
 ozu/r9yLoN17MnowuGgUgEM7ucw5NFnEgo7VCl2Fp4ps9gB6w+5Wbvjklz2xVi6zFmDs
 bPYNp/oD4RUyfNbYOSIl6GJKUeZmBo/Kpio3++BqJ/T3g55hnJ68iog6FOSyFb2HglIK
 NCTKhUP6atXbeKxSmyCfeCkgouobklPQyg3hs3cm/JB0YQlPhuoTeZwhNT1yRs3z3UiY
 Z5yQtT0qhSkMNooJP4OZKfKtfsbFI4LLmJ2vnSAWkc7V6A+gx2Bfhkb6oMZski0yZQ65
 mofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734486298; x=1735091098;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ooLVj43p9vkhKiKtVu2n7rlFQaqiKe5x9AtS6yKY+dU=;
 b=wz52TXtSwhjnEhIFNl2V1ewz2Fupu3uEagN8z8YIJw2N298RFKaxlpI/P9VI3DkRxX
 HTZGyRtpiTpE4Rf4Q+SaWhC2TL5sitb15J3OCB3JyX/OBvTLpg6A82qdH8sVAH+cw8ys
 tUORW5mvqyLkC0XNqZbXgtRnZEOM6MRtv5bKTBzaI3grcReE5C1Ch3rxW/3KkHaXPtPw
 rKN9EDAQ3GX5/OBJbkZxdjw2DX8luexCarY0s6b7Lhfc/CDb6hIKxbtBGvQMK7zgjOe1
 RSHUeb3+XADjqpbt8Jl2ZkFfuOZvNRlBUzbhNnKLNanr6SxF/hEyS388ZSKJ8VfROl94
 hYXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVspZ8jZCm4fO4KRUNuCNztSC1Hqg/Kc3l5mfa4K/mZXFlLOkMwiRZAzq7FiA+fgwJej5b0fR4KBf3J@nongnu.org
X-Gm-Message-State: AOJu0YzXJsBN1xwZ7xUA9CGzHLjOVTAOSRZfZQpnUSCx9omROSPamEga
 T39nxYwueEN1MoiwOj7RrhcmM3jnL0Y7V5TrgYHg30RwceBpAmJZ
X-Gm-Gg: ASbGncuJpSEUUGXIciPXRCo3Q86jUlawNaGTl+uUuH3rvuO7LGs5tIYdIJ38LHcr/1H
 rA9ps1KVviDvdlzHg3SycLBMGetvh09dbVjR03g6oyq9xAMHrZZ82iYUe2vRFJsSNGEq4S/0qcc
 P+oH37bHBIZivxXkpWEIkC4UHS44QZeR5qJB+bLsYAjzcVTOze4G42xsWZAyDxxJPkn9W165RiR
 59K2CUW4rPs0N0xc2Q4CC1FG8q1e3+Wv7HU+9lArphwInMuagBQYa8rO6dgUggzLPt3a0N6AoM=
X-Google-Smtp-Source: AGHT+IE4tOUGRvaImZe5ju8R/fRdDrOg/hJc9lnToAuxeP/THu+EwaJt2vRi3vx7JXwtFX2ZR7bd/g==
X-Received: by 2002:a17:902:fc4d:b0:216:7cbf:951f with SMTP id
 d9443c01a7336-218d6fdcc6bmr14393775ad.21.1734486297816; 
 Tue, 17 Dec 2024 17:44:57 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc748sm66166645ad.92.2024.12.17.17.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 17:44:57 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Dec 2024 11:44:50 +1000
Message-Id: <D6EG2PWL6EFK.2I261I824YNAC@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>, <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>, "Fabiano Rosas" <farosas@suse.de>, "Laurent
 Vivier" <lvivier@redhat.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Dmitry Fleytman" <dmitry.fleytman@gmail.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>
Subject: Re: [PATCH 3/8] pci/msix: Implement PBA writes
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241212083502.1439033-1-npiggin@gmail.com>
 <20241212083502.1439033-4-npiggin@gmail.com>
 <5dd989ee-e9d3-4c49-9031-a4bc320bbaa9@daynix.com>
In-Reply-To: <5dd989ee-e9d3-4c49-9031-a4bc320bbaa9@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Fri Dec 13, 2024 at 3:14 PM AEST, Akihiko Odaki wrote:
> On 2024/12/12 17:34, Nicholas Piggin wrote:
> > Implement MMIO PBA writes, 1 to trigger and 0 to clear.
> >=20
> > This functionality is used by some qtests, which keep the msix irq
> > masked and test irq pending via the PBA bits, for simplicity. Some
> > tests expect to be able to clear the irq with a store, so a side-effect
> > of this is that qpci_msix_pending() would actually clear the pending
> > bit where it previously did not. This actually causes some [possibly
> > buggy] tests to fail. So to avoid breakage until tests are re-examined,
> > prior behavior of qpci_msix_pending() is kept by changing it to avoid
> > clearing PBA.
> >=20
> > A new function qpci_msix_test_clear_pending() is added for tests that
> > do want the PBA clearing, and it will be used by XHCI and e1000e/igb
> > tests in subsequent changes.
>
> The specification says software should never write Pending Bits and its=
=20
> result is undefined. Tests should have an alternative method to clear=20
> Pending Bits.

Thanks for correcting me. I guess qpci_msix_pending() should not be
trying to write to the PBA either then.

> A possible solution is to unmask the interrupt, wait until the Pending=20
> Bits get cleared, and mask it again.

PCI spec says

  If a masked vector has its Pending bit set, and the associated
  underlying interrupt events are somehow satisfied (usually by software
  though the exact manner is function-specific), the function must clear
  the Pending bit, to avoid sending a spurious interrupt message later
  when software unmasks the vector. However, if a subsequent interrupt
  event occurs while the vector is still masked, the function must again
  set the Pending bit.

It looks like e1000e acutally does that with e1000e_msix_clear{_one}.
So perhaps this will work just with the e1000e ICR clearing patch. I
will test.

e1000e and igb are the only devices that call msix_clr_pending. Does
that mean many others probably do not implement this behaviour
correctly?

Thanks,
Nick

