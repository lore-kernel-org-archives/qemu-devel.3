Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98157C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 18:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpYPH-0003U8-4H; Wed, 27 Mar 2024 14:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpYPF-0003Ty-N1
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 14:53:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpYPD-000410-Cv
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 14:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZPGKChcZRnms/jKSik1dAe5ShmNBKtWVj+J2inXp0/Q=; b=ENrtSB25LeDKQf80+aCfftXxds
 UyG1hbRCMTdVrvHuxKA99YhubaEfa8SvxK3/5PEt+pB+g4RTpVyw90RkFS3JYa6bRsK1NxWxtZptE
 EyFkVwdDa01/BkUoo9bCAr5gBg1zkJT8x/EVfLFhcBKqXlbATt6CzFDvYndN0P6g53lAepsY0kJlS
 uiZPIv+h0U/zutFBw1QpyxrNaQyDeTHtPQFDRkvddXp6U4NztpNsb8g8+0tCTTeKODV0iwrYlRi0j
 GheOkpH+BcHAgBlFfgPwXLh008vxvomXdLqlZ935RwjQ9MyV60uJ8Oz4ZvU8kfTwqgplKcRbTflwQ
 uuxF8vM78w6ggH9G167Ih/pMhVsxADlqM17Br6SeTxrc0g+NKznZSEJFEoRmLjpMJ+n7BQ3ibQwHD
 C2mfAWeClx712hZq1BBf50c11VRZrvzeZUKThSimaF1EcoGne1+IZXvDyU8F5B856gXR6m1dvub+O
 Xu762KyzwuDNZMzrjhM5aN6ZPOlD1i5krQyN0DiBBDeUn/ViedJUVk1Ao81A04cZvjYxcSBcl2zWO
 Cz87lWSCM1rFPPZdHLgo0bEn1BndpskcC9xENjYsHI500sN5wf/w8HC+n5YKAzoUPAuBayr6CB9WI
 DtJUf7W0llBU5z/YLfNmpu+vWrutikreVMY1rZplI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
Date: Wed, 27 Mar 2024 19:53:42 +0100
Message-ID: <3153513.lVJF6dkNTK@silver>
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wednesday, March 27, 2024 3:20:09 PM CET Daniel Henrique Barboza wrote:
> Hi,
> 
> In this new version we took a different approach after the discussions
> we had in [1]. The tests are now untouched, and we're addressing the root
> cause directly: the fact that we have a single temp dir for all the test
> execution in qos-test.
> 
> We're now creating and cleaning temp dirs for each individual test by
> calling virtio_9p_create_local_test_dir() in the .before callback for
> the local 9p tests (assign_9p_local_driver()). In this same callback we
> queue the cleanup function that will erase the created temp dir. The
> cleanup will run after the test ran successfully.
> 
> This approach is similar to what other qtests do (in fact this design was
> taken from vhost-user-test.c) so it's not like we're doing something
> novel.
> 
> I kept the revert of the slow test gate because Gitlab seems to approve
> it:
> 
> https://gitlab.com/danielhb/qemu/-/pipelines/1229836634
> 
> Feel free to take just patch 1 if we're not sure about re-enabling these
> tests in Gitlab.
> 
> 
> Changes from v3:
> - patches 1 to 6: dropped
> - patch 1 (new):
>   - create and remove temporary dirs on each test
> - v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html
> 
> Daniel Henrique Barboza (2):
>   qtest/virtio-9p-test.c: create/remove temp dirs after each test
>   qtest/virtio-9p-test.c: remove g_test_slow() gate
> 
>  tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> 

Awesome!

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Are the riscv patches already on master? I.e. should I push those two patches
through my queue?

/Christian



