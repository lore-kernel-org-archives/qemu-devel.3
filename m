Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63913C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Qb-0003fA-S5; Tue, 07 Jul 2026 13:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh9QY-0003VX-9i; Tue, 07 Jul 2026 13:17:46 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh9QV-0006zj-VM; Tue, 07 Jul 2026 13:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=I403/UIDq8K1AkviJ2LEhkYONKX+kPYwH2uam2dinEo=; b=cElRKGu9OIPbQqr7wDZsLsjRAC
 sX+Nh6dFAQ4GFv5I8WfoWeZD1XBwQUwPbsZ2TSNUWO4C62UIRsf1oS7UdWG4/GDcFUF7x36e6Mnql
 cLu0XHO23c/MHR4kocMXK+/zP3nUEwcD/piFekEL60jLVDigyv8+U3P1sfl7EfWbo+3h/fHNaLlH4
 1YjlSmxGNMxTMWmFq6sjtyoR0wuMat/7PLbgJTm7LzBWwTbh0gPMgvKhbwWGnlzzZrsWZ6JzdNzZC
 pmLnXRfOjiRX/Ry/IlKAM6+FUoYnG9boMQeL3kY0agAZ/T12UBaTlAWsuwbR6OcMnD9uqoI2h65ti
 OLYJoVh+kj8m7qvJnQWTgTYFmABQqm6gvsKaVeGFU6oL48azXtkuSrEP32QNunAOpkUsScIZAJt5K
 +vcucfreero008El4mdUH70TR87ejXNXKnaKV0S4Ug0ctYaVRE8HGgYUyVCkaPV0A+1+WMypyANAM
 4RFO+tYPe98DOwwo+2kAIC6Gpko6ZGmpfi6Dfs2stu3zj44Z2QQe69NKtFaz/jVos5s6btfKK2yk1
 JcxAbClMx9V5OyBYTlJC2zfTm2lTct9iaG+3vchSDGtvrfT5W9VKOvKxxNd+jh+PfW2a3mST/rQN6
 /utR/BLuzg1aHNZLlzitrrAsgk+lP2GcGUehNERZQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] tests/9p: prevent potential error in
 do_local_xattr_limit()
Date: Tue, 07 Jul 2026 19:17:40 +0200
Message-ID: <2416447.ElGaqSPkdT@weasel>
In-Reply-To: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
References: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
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

On Friday, 3 July 2026 17:38:10 CEST Christian Schoenebeck wrote:
> The local fs backend driver tests require that a dummy file is
> created on the host side before running the xattr limit tests,
> otherwise the test will fail because the file is expected to exist.
> 
> The original call of g_file_set_contents() didn't check its
> return value, which might cause subsequent test checks to fail,
> making it harder to identify the root cause.
> 
> Fix this by simply wrapping the call into a g_assert().
> 
> Fixes: 04a62cdfe873 ("tests/9p: add 3 xattr FID limit test cases (local fs
> driver)") CID: 1660926
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



