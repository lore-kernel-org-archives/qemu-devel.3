Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A765D3B7F7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVV3-0001XV-MN; Mon, 25 Nov 2024 04:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFVUq-0001II-7U; Mon, 25 Nov 2024 04:35:08 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tFVUo-0003XB-5r; Mon, 25 Nov 2024 04:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ocJ+G3CGZzpQ2NJI5F9JpE1OQOw3Cf3PEhm++MJbqtg=; b=KxBBVnj8ywYGs8nqtfIS6jZPUw
 LLAwP2uXHFMuSJOcSf1IxiE0VqeGTSYfp+OZnxVVQv9FGA+C1iLBxuXRfE9hNFSpIZprEKyir2MqI
 x0tjea5OL0ZXBqLUAkR1WLsZM0g1jPODFHlOjgsRtzFPdcXiWK33qQfoGw0kyiEE6KLEX2mSuEBFC
 9Yho966JjUSm/LCUDDXrIv4UghkoI8vs3G4qQyRZBECc0OP2nq1IBZ0KAU0MX4widTJ2m2SLEqKMI
 n7Q8bBUZdb/FUlQSt40m6cW1e7rL8jjlls4ZKVVbxv/lE4M6rJTpM2sHymmeghwm5sDHOEsGLVbLq
 izYAdaYCMLJ6c7Rn7frTtikeh8bSWC9ZK8SqHq2U3DTml5gWWWaQCUEP9z1rbNqX7ARfdow7CEBhd
 ADOUPlEYjw2bOxTgtqIEtAFcUgEYyJy8uwmE9VvOycqxK9Fj3JjG1fGclax0KPws3jUGJCYZdwHs0
 1Td1gIwMTvIYg4GOB60qmovr9knx7VJQ9xFUvS5kmNGd/4dtH6ZWKMsc8a0+6wjWVyFqkuUTGxODl
 wzW0qUg2jH3mtHl5j08S9eYD9JgWromSMHXnQzXbH7HHWZkRM4oFY43ZcBqcj/oigvFkYQNP1Gw2z
 c0Lqqhk6zs1Zn2ej1vkuKrpGOB2oILN0+9qOFvtkc=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/6] tests/9p: add 'use-after-unlink' test
Date: Mon, 25 Nov 2024 10:34:57 +0100
Message-ID: <1935071.n0I2rtNXNV@silver>
In-Reply-To: <20241125094717.50e0344b@bahia>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <3d6449d4df25bcdd3e807eff169f46f1385e5257.1732465720.git.qemu_oss@crudebyte.com>
 <20241125094717.50e0344b@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, November 25, 2024 9:47:17 AM CET Greg Kurz wrote:
> Hi Christian,
> 
> On Wed, 21 Feb 2024 15:13:13 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > After removing a file from the file system, we should still be able to
> > work with the file if we already had it open before removal.
> > 
> > As a first step we verify that it is possible to write to an unlinked
> > file, as this is what already works. This test is extended later on
> > after having fixed other use cases after unlink that are not working
> > yet.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> 
> Test looks good but make sure it is merged last to preserve bisect.

I think there is a misapprehension: this test already passed! So no need to
move this patch.

What this test does is verifying the scenario open-unlink-write. I already
sent this patch in February and was surprised by myself that this idiom
already works:

https://lore.kernel.org/all/E1rcnYJ-0004KK-LV@lizzy.crudebyte.com/

What this entire series (i.e. patch 5) rather fixes is the idiom
open-unlink-fstat, and the test for this idiom is the last patch, not this
first one here.

So bisect is already fine.

> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!

/Christian



