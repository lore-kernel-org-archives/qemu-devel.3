Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F64ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkqd-0005kQ-Me; Mon, 09 Sep 2024 16:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1snkqb-0005bt-Fc; Mon, 09 Sep 2024 16:18:53 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1snkqZ-0005mB-Vb; Mon, 09 Sep 2024 16:18:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3E96DA437D0;
 Mon,  9 Sep 2024 20:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CF4C4CEC5;
 Mon,  9 Sep 2024 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725913128;
 bh=JkMKvjlcx4NoMr8dyWRElHtyferuyogh430X5YfDj0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aR0I1qqsZCU1YWxo8plF0H1mWa2exlWydH4Du913eBIJT/HZ2AiZHdV9rbRkktsVK
 OU+8jd/pHNw46zQEEvDn8gy0dH28p4P9/xW8MMI+RdSEDeZm1c3ZF2BrFXjZb5lfWR
 FoBG/lBhLJ2Gtiyz69ImFm7NeCJY+wvNR8Pj5EY55AXjVAZnluJwDCaZI8h8DKSUAm
 mjUQuw2EQbQyTKTwdF3IPi8ISNyvxD4v7ZR/if8yIGBuRm1I6hriRpoGS6RabDv7xs
 srJxWAHKemvjROOSa1BP63KmJK5bukOecHaJONScSOoPNs5mnXKQrWzYXXWmBGMnmY
 Eq610PgAdVyog==
Date: Mon, 9 Sep 2024 14:18:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com
Subject: Re: [PATCH v11 02/10] block/raw: add persistent reservation in/out
 driver
Message-ID: <Zt9YJd8ifhG8HJFs@kbusch-mbp>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
 <20240909113453.64527-3-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909113453.64527-3-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=kbusch@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 09, 2024 at 07:34:45PM +0800, Changqi Lu wrote:
> +static int coroutine_fn GRAPH_RDLOCK
> +raw_co_pr_register(BlockDriverState *bs, uint64_t old_key,
> +                   uint64_t new_key, BlockPrType type,
> +                   bool ptpl, bool ignore_key)
> +{
> +    return bdrv_co_pr_register(bs->file->bs, old_key, new_key,
> +                               type, ptpl, ignore_key);
> +}

The nvme parts look fine, but could you help me understand how this all
works? I was looking for something utilizing ioctl's, like
IOC_PR_REGISTER for this one, chained through the file-posix block
driver. Is this only supposed to work with iscsi?

