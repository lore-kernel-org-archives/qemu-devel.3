Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9025CD4F4E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 03:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm2vs-0003Dy-IR; Wed, 04 Sep 2024 23:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1sm2vq-0003Cg-KU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 23:13:14 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org>)
 id 1sm2vo-00025A-NH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 23:13:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E3815C3F2F;
 Thu,  5 Sep 2024 03:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95B3C4CEC8;
 Thu,  5 Sep 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="XkkRc2sN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725505978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7QHNIyCnvMM7QKjw/oeD+gvYbfW6WRa706M5QtOWKQ8=;
 b=XkkRc2sN5huhNvAz7TUYVQAYx0L0hml+WNnzbbQXybhBETvg9XNBFDuDr31V4voFDe6wxL
 k4j1Pzy2ljuvqcSCbxiOilhFGmDCa4aVa1SOJpG3sWvkKmz7pOQbeO5hvuhJrZAWeL6QL8
 EuIYglJExd4R8QV2GRdZPR49vX1WCAg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e52504c4
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 5 Sep 2024 03:12:58 +0000 (UTC)
Date: Thu, 5 Sep 2024 05:12:55 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: maobibo <maobibo@loongson.cn>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 loongarch@lists.linux.dev, qemu-devel@nongnu.org, xry111@xry111.site
Subject: Re: qemu direct kernel boot on LoongArch
Message-ID: <ZtkhtxcJUK-JediY@zx2c4.com>
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
 <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=SRS0=ehJl=QD=zx2c4.com=Jason@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 10, 2023 at 09:12:46AM +0800, maobibo wrote:
> Thomas,
> 
> Thanks for reporting this issue.
> 
> It is the problem of QEMU for LoongArch system, QEMU does not support 
> booting vmlinux with elf format without UEFI bios now. We will add 
> support to boot vmlinux directly on QEMU LoongArch side.

I ran into this same issue when trying to boot my test kernel for
Ruoyao's recent vDSO getrandom work. Is this something that was ever
addressed on the QEMU side?

Jason

