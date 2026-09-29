Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6B0CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWUj-0002HU-MC; Tue, 29 Sep 2026 07:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWUf-0002H3-Gr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:59:34 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWUe-0000Ti-34
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:59:33 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab42612328so5333027b3.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 04:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790683170; cv=none;
 d=google.com; s=arc-20260327;
 b=hohJ7vyEYY0nPxlhnjU/m+mF98k1Lr1+U17h5NOEKPA9zJ2IjuCl9V0XZFpp2OhSBC
 KBN7diR8p7alM1v8CeM/B9wtZwoj7FoXGhyOXNxBdr8oM78ixnDXtypu5Be4c6dYBUGM
 NIW2Ey1nF0FvQOFJyxh78wxccAoYLvhI4Aq/JfBPJWlFZ5nYZGxwGqzZ8j672lTlbhDN
 15b7yL6axoXEmsQ0RgXp0mBWU79RBEfNpRE4xiEYkcWCVwTy39WIz9f11Dt08SwYKB5U
 1ptk/gSpv5bz2aOfctS1mF1RlmMnPOrRVk6tWRIfH+Le9p2KviM4A0cVylcx1W5wGbVh
 7OnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uhUmKaNeDbkAMuwPlQwx96vVzLUgAk1GkcgWtLQ+m9k=;
 fh=Pp9jX0adaTHvd9hHphcIldRAvXtGCoFyDCqLE2UesPU=;
 b=TpBQAfJSQWPRa2EoqKS7ieKts6/wTEQUEJEFRzYlgqycV3Q89bE+2SwOVsXNFam0D+
 NZNsUN+aRdbFN7L1A8V4ZoEdVDZuW4lrMeFe0/DODwZ2hpEQqoJXyjMmJdI4oLcq/3S6
 MWIkhyuo0ghHw6cEA1zOZ9arXMLkaxBfVWGBWWaZJcWKiQ8uH9Gqel5SbvkVnOtvgiA9
 9lPC8VBKOwf3ofLO7l+K96/X+4ivoPG6pkGckc0wsuAi71LzXQJQR/WPJTPuZ3vys2Md
 07wsFqNAeXzAHDVmwVNvEnmTOnKVDkPEx+TjCxE6WzwxM8sDKoF5HlJ/01PUZhiyssH9
 zCZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790683170; x=1791287970; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uhUmKaNeDbkAMuwPlQwx96vVzLUgAk1GkcgWtLQ+m9k=;
 b=yItC6S8q6kAijaXfkQt61tuOSDxp0shsfUJmFPLvnWNX40aOJT7PPBzGKWb0D5vC43
 V5sgSHs8HpUuBRb2z0b4mzrIK5fq6/f8djJKM41Rbb7R++KVWY3dZvDA9I65Eo+RHfci
 L6cTO9IBVDVsD9W55COmlbJDV9W5fiIhN3zBs4KVRpA5DIotEE5VYSuqmoAfm8SCZH8J
 AC//fS6LFYn00Y55fY+0PPHu5JA68sY8X+VWPwvLSHANIKDit8/rm733pVZ6e/F7CuWs
 4FIX6LSXqcymURGI19U5yDPVTdxc75fk3GcYyErgCdhz5W4ZjMA3Y23cO/bPR+smzvNA
 +uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683170; x=1791287970;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uhUmKaNeDbkAMuwPlQwx96vVzLUgAk1GkcgWtLQ+m9k=;
 b=aXoIHTbXIjytWs72rFvKFMjGTdpo0Xkt3vQ4SxO7wWQjrEjuwklRC96dnoiNv0FBxN
 oBIBdnU8p9GQsNP0lcJPo0x97Tue/LvIX+rlev9nZyv/j7qRZcWDrXMuIrQMekzISQKR
 vu3Wl4ruouKb53Zht3/0UNE0Yu8Zts80TaP+faGFfHqt9PGqHrkLHMZfP/UQ6p4lkaHS
 I5HBsKflyf+ksZZu+ft4jrLhDwd/xO4YewX/XnvnSxaQJmS7U93wj/Ih9x1szBPVoIjj
 mgfCbWdNvokcmhBcgLTBOBmbgFstkIeXWH/neRT5JQXk90TaLK7sbgMWN6zsn/NzCB1b
 L8RA==
X-Gm-Message-State: AFq9FYKncZIN2oL0rF6Xo6fugrOY9Nq/AOG3KBqAbvtWUgdy6TIvyEBF
 71vako2imGjw+pvmSDBG8wRl2lQo4LNhP5eZ81k7yLF5sXDbAdbxATltavFkEnGLccG50foqvgx
 Pmvzw2mm71BOY29bEXcEuHJ6E6v+HpnYe1YoaIDhzgA==
X-Gm-Gg: AYBFou2ZszcqYmo5yKFsefM6HCmOC4Y64qnMTW4PeAhP+PHsQHwdCHaYbZKAuSEU5KG
 rAwntmabBf5nlZtuWnaOzA+CD2O0mezZcA4EK162UHV8wz0n6QuuSYMwSva+c36XTng3HUB/Ysg
 11SqNriOEdU/oM6gDIgAFf2pFM2zPZ7HGPY3mijmG1tNX4/+iBxk4fgGWlx+436O7NjyfaIv9CF
 YhlOgplNsySSEYX53KYmnIxUKXDhlMDqO2VjC/l4q41xDgZVy7pdCaISHGInQ2RFfL5oUd9vI2Q
 1xA/kMZnBzSfnrDeewiNJWsfjC8exT56B3tDGl6M4OuUmSpFD/GEy5GAnhsk5/r2C0vcFbAD5xT
 eDPl5qFk/03E5kL2CayS7rnbSnH/OZzE8rGPtrKK9P6FKnwf34g==
X-Received: by 2002:a05:690c:39a:b0:8a6:1205:12e8 with SMTP id
 00721157ae682-8a64e5bf235mr64894887b3.44.1790683169742; Tue, 29 Sep 2026
 04:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
 <20260922223045.190062-2-weqaar.janjua@packetfive.com>
In-Reply-To: <20260922223045.190062-2-weqaar.janjua@packetfive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2026 12:59:17 +0100
X-Gm-Features: AclHuK-AwSF9m43FuNRJyJYMDSdzD-k7LbVI5_kwKGaD3No356DOS_96YlHEGuI
Message-ID: <CAFEAcA9AP3RrLY4fzvsc9Bx845tiP9NXYo1CJ5Fb_iVePQKc5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] pci: Add device ID for CnuasNIC
To: Weqaar Janjua <weqaar.janjua@packetfive.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com, pbonzini@redhat.com, 
 farosas@suse.de, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
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

On Tue, 22 Sept 2026 at 23:32, Weqaar Janjua
<weqaar.janjua@packetfive.com> wrote:
>
> Reserve device ID 0015 for the Cnuas virtual network adapter.
>
> Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
> ---
>  docs/specs/pci-ids.rst | 2 ++
>  include/hw/pci/pci.h   | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359f..3f3825bfe5 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -100,6 +100,8 @@ PCI devices (other than virtio):
>    PCI UFS device (``-device ufs``)
>  1b36:0014
>    PCI RISC-V IOMMU device
> +1b36:0015
> +  Cnuas virtual RDMA network adapter (:doc:`cnuas-vnic`)

This adds a reference to a documentation file that isn't
added until a later patch in the series. Doesn't this break
building the docs at this point?

I think it would be better to add the ref at the point where
the document it's linking to is added.

thanks
-- PMM

