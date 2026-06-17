Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F659CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZlLg-0001b6-TM; Wed, 17 Jun 2026 04:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZlLf-0001Yn-4O; Wed, 17 Jun 2026 04:10:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZlLd-0001sj-F4; Wed, 17 Jun 2026 04:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Vjb8kcQ579DVw2LGRp6Thwua9v24wEAc4wb6Tl4xdRE=; b=vVZt1Tok68d4yMYpGh9lariYlX
 eyLdDLPulMiU5vuQV3KdE2KIkRfdxCZ+r8cPBh7msNRV3St5fFVEKSLaPQAREubp///605qp1eZ7V
 pP1/yZeIkjmgUf3ha7ilrKgqVDjOAywkPszlGgb62p4ozaaD8w6DzNkOulCYBviqFkvHO+577vCMc
 h/U3LxvBG9CKQvHPL41MMKpFDVJYW3LDxSHFNsdRqk/AnbtZzyPFhSCSU2L99CjJmiObrJ/JWAgR/
 NDdZ6anpgr+ohoOiqV614D3/uEw/AYAw0ZZorjP50Z839RDGSB1zVCQETqHZnxenViktfbIXKbaab
 3SRdo3Q7pXph46kVNR/iAma5fz0t1MZ90OdknefMXKXgiUo39UpAceZvQ+z+ljETYRjrWhD6M7+OV
 deUJkTuxcwMy6u6EnBV6JpTLQd2eeeD1N/M2DXhg7V6gnZ6AyQK2fnMM6FQ+0MM7grHeV2ue625P4
 IJ42ZV2eDnjQiO21KorufqJCaIxrL0dnKyn9vdD3b0Wo8wmd2g43ZFmp4k8P84PECvObmVbtnU+aH
 O75WiEj4bSLR5G3vujstAM830q+hoLK3VCfyCe76532m378GNVqJIbi7ds96axu05pnefYuUl49Op
 15Lu+oYQRomenRvOnRBKzhDiiLrBN4BBddlmkXydU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 0/3] 9pfs: fix invalid union V9fsFidOpenState access
Date: Wed, 17 Jun 2026 10:10:02 +0200
Message-ID: <5079251.GXAFRqVoOG@weasel>
In-Reply-To: <d5724c37-9e03-40cf-9679-0c0ed783be2d@tls.msk.ru>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
 <d5724c37-9e03-40cf-9679-0c0ed783be2d@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wednesday, 17 June 2026 09:27:31 CEST Michael Tokarev wrote:
> On 16.06.2026 18:00, Christian Schoenebeck wrote:
> > The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR,
> > P9_FID_XATTR) share union V9fsFidOpenState with FID-type specific fields.
> > Accessing any of the union fields must comply with the FID-type to avoid
> > undefined behaviour or information disclosure.
> 
> ..
> 
> Hi!
> 
> Next batch of qemu stable series is scheduled for Jun-25 (patch freeze at
> Jun-23).  It would be great if this and other 9pfs fixes landed in the
> master branch before the freeze.  As far as I can see, we've several
> issues in there.

Oh, that's quite close! What would be the next window?

This fix is already queued on my end:
https://lore.kernel.org/qemu-devel/cover.1780072238.git.qemu_oss@crudebyte.com/
https://github.com/cschoenebeck/qemu/commits/9p.next

And these fixes are yet to be queued:
https://lore.kernel.org/qemu-devel/cover.1781287774.git.qemu_oss@crudebyte.com/
https://lore.kernel.org/qemu-devel/cover.1781361555.git.qemu_oss@crudebyte.com/

And of course this series here:
https://lore.kernel.org/qemu-devel/cover.1781621428.git.qemu_oss@crudebyte.com/

At least I currently don't have further reports to work on. So all bugfix
patches are posted.

/Christian



