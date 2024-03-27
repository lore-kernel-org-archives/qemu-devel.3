Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59AFC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSMt-0005zw-QE; Wed, 27 Mar 2024 08:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpSMr-0005zm-Pv
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:26:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpSMk-00082S-UW
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=LCBQLPBcybB2Z1bQAOQfWou6bpLro87l7pcPnCvFEsA=; b=Z5bi9pRzaQjgr1hJf3vxUDYFrd
 SeWZTf56IV6lTUq0gu488SqBvUfLydZ+9ze0maXeRD4y6zv6oWPzi/vbA1wevyOfyPuyJ6oICOyvA
 9v6/ICZp7t0ZGzn2d58NYImDXvpMOORfwMiq3cKVYqKS5ylnewnP9opu7gZ38fpILZ01kwWmqOVdh
 DNesMhDdVYDXMGMM3TNhEcHCVrXbad7lLuPNEBckKXpAZ9cCDX07FB0WrPKN+V1mBd9LRL0vp5YSQ
 55O3bdiK1KhCBdir5IbY9EefvElPPQ0ycvCPCGI9MrTEM85yCcwVp4nMZUi3s49LobQ65HLO398xx
 6rZJEzcVJnOe2z67lteIwUkDsAwzdbCJdxBxHQRdx6RGdZdWUn52+7YWmPXfT0RrMCAMAjdQO8tAe
 sqrOO2gBCNNlEi8uXUianiytPUXc/HgwROQZPJT6DTawaEPCi8/673sjokcRdSuUhZGePB6PUmxpO
 zt7zCVM+pmN3XBvD/4LY4seczoZ3wTIiNCOWgmPneucNjJF4kVDh1KUojwIIPio1awK8AFgDth+QG
 ql3rmKEgfTIQybQfb8DINDwZP14Xl/cC332RwxezuPr/NQN0GrBqOgEux01V0ZePxVu3Fb2h/Oq4E
 4lYweUKkH4gRCsNlgw6qx5HryFijcDbDiwsLPKqzE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
Date: Wed, 27 Mar 2024 13:26:45 +0100
Message-ID: <2696794.aGCxZK9GlV@silver>
In-Reply-To: <067a79d2-229a-40d8-9a88-28535c2e015d@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <8350437.9EvD175kdC@silver>
 <067a79d2-229a-40d8-9a88-28535c2e015d@ventanamicro.com>
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

On Wednesday, March 27, 2024 12:28:17 PM CET Daniel Henrique Barboza wrote:
> On 3/27/24 07:14, Christian Schoenebeck wrote:
> > On Wednesday, March 27, 2024 10:33:27 AM CET Daniel Henrique Barboza wrote:
> >> On 3/27/24 05:47, Christian Schoenebeck wrote:
> >>> On Tuesday, March 26, 2024 6:47:17 PM CET Daniel Henrique Barboza wrote:
> >>>> On 3/26/24 14:05, Greg Kurz wrote:
> >>>>> On Tue, 26 Mar 2024 10:26:04 -0300
> >>>>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
> >>>>>
> >>>>>> The local 9p driver in virtio-9p-test.c its temporary dir right at the
> >>>>>> start of qos-test (via virtio_9p_create_local_test_dir()) and only
> >>>>>> deletes it after qos-test is finished (via
> >>>>>> virtio_9p_remove_local_test_dir()).
> >>>>>>
> >>>>>> This means that any qos-test machine that ends up running virtio-9p-test local
> >>>>>> tests more than once will end up re-using the same temp dir. This is
> >>>>>> what's happening in [1] after we introduced the riscv machine nodes: if
> >>>>>> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
> >>>>>> this is what happens:
> >>>>>>
> >>>>>> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
> >>>>>>
> >>>>>> - virtio-9p-device tests will run virtio-9p-test successfully;
> >>>>>>
> >>>>>> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
> >>>>>>      first slow test at fs_create_dir() because the "01" file was already
> >>>>>>      created by fs_create_dir() test when running with the virtio-9p-device.
> >>>>>>
> >>>>>> We can fix it by making every test clean up their changes in the
> >>>>>> filesystem after they're done. But we don't need every test either:
> >>>>>> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
> >>>>>> i.e. a dir is created, verified to be created, and then removed. Fixing
> >>>>>> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
> >>>>>> both. The same theme follows every test in virtio-9p-test.c, where the
> >>>>>> 'unlikat' variant does the same thing the 'create' does but with some
> >>>>>> cleaning in the end.
> >>>>>>
> >>>>>> Consolide some tests as follows:
> >>>>>>
> >>>>>> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
> >>>>>>      fs_create_unlinkat_dir();
> >>>>>>
> >>>>>> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
> >>>>>>      fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
> >>>>>>
> >>>>>> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
> >>>>>>      fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
> >>>>>>      creates is now being removed.
> >>>>>>
> >>>>>
> >>>>> The  change looks good functionally but it breaks the legitimate assumption
> >>>>> that files "06/*" come from test #6 and so on... I think you should consider
> >>>>> renumbering to avoid confusion when debugging logs.
> >>>>>
> >>>>> Since this will bring more hunks, please split this in enough reviewable
> >>>>> patches.
> >>>>
> >>>> Fair enough. Let me cook a v2. Thanks,
> >>>
> >>> Wouldn't it be much simpler to just change the name of the temporary
> >>> directory, such that it contains the device name as well? Then these tests
> >>> runs would run on independent directories and won't interfere with each other
> >>> and that wouldn't need much changes I guess.
> >>
> >> That's true. If we were just trying to fix the issue then I would go with this
> >> approach since it's simpler. But given that we're also cutting half the tests while
> >> retaining the coverage I think this approach is worth the extra code.
> > 
> > Well, I am actually not so keen into all those changes. These tests were
> > intentionally split, and yes with costs of a bit redundant (test case) code.
> > But they were cleanly build up on each other, from fundamental requirements
> > like whether it is possible to create a directory and file ... and then the
> > subsequent tests would become more and more demanding.
> > 
> > That way it was easier to review if somebody reports a test to fail, because
> > you could immediately see whether the preceding fundamental tests succeeded.
> 
> The current test design is flawed. It's based on a premise that doesn't happen, i.e.
> a new temp dir will be created every time the test suit is executed. In reality the
> temp dir is created only once in the constructor of the test, at the start of qos-test
> (tests/qtest/qos-test.c, run_one_test()) and removed only once at the destructor
> at the end of the run.
> 
> It's not possible to add a 'device name' in the created temp dir because we're too early
> in the process, the tests didn't start at that point. So, with the current temp dir design,
> the tests needs to clean themselves up after each run.
> 
> Here's the alternatives I'm willing to go for:
> 
> - what I just sent in v2;
> 
> - add cleanups in all existing tests. We can keep all of them, but the 'create' tests
> will be carbon copies of the 'unlinkat' tests but with different names. Can be done;
> 
> - if we really want the tests untouched we can rework how the 'temp dir' is created/deleted.
> The test dir will be created and removed after each test via the 'before' callback. To be
> honest this seems like the best approach we can take, aside from what I did in v2, and
> it's on par with how tests like vhost-user-test.c works.

Yeah, the latter sounds like the best solution to me, too.

Don't get me wrong, I didn't want to burden you with more work. It's really
just that I think that restructuring all test cases is contra productive.

If you want I can also look into that. Just let me know.

Thanks!

/Christian



