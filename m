Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD929C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSSA-0007PX-5q; Wed, 27 Mar 2024 08:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpSS7-0007PJ-QN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:32:24 -0400
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1rpSS4-0000am-Ko
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:32:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.148.37])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4V4QzM3GqTz1JXs;
 Wed, 27 Mar 2024 12:32:15 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 27 Mar
 2024 13:32:14 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0042366d515-e66d-436b-a54b-87d756272179,
 E5A1EC0EFFE5CD3CAD84611DE318B77B5DFBC549) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 27 Mar 2024 13:32:13 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <thuth@redhat.com>, <alistair.francis@wdc.com>,
 <peter.maydell@linaro.org>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
Message-ID: <20240327133213.7bc9cf31@bahia>
In-Reply-To: <2696794.aGCxZK9GlV@silver>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <8350437.9EvD175kdC@silver>
 <067a79d2-229a-40d8-9a88-28535c2e015d@ventanamicro.com>
 <2696794.aGCxZK9GlV@silver>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: eab8fe5a-0137-4a6c-8e21-9cabdea48522
X-Ovh-Tracer-Id: 1283244422125164838
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomhdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopegusggrrhgsohiirgesvhgvnhhtrghnrghmihgtrhhordgtohhmpd
 fovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.33.254.192; envelope-from=groug@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 27 Mar 2024 13:26:45 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Wednesday, March 27, 2024 12:28:17 PM CET Daniel Henrique Barboza wrote:
> > On 3/27/24 07:14, Christian Schoenebeck wrote:
> > > On Wednesday, March 27, 2024 10:33:27 AM CET Daniel Henrique Barboza wrote:
> > >> On 3/27/24 05:47, Christian Schoenebeck wrote:
> > >>> On Tuesday, March 26, 2024 6:47:17 PM CET Daniel Henrique Barboza wrote:
> > >>>> On 3/26/24 14:05, Greg Kurz wrote:
> > >>>>> On Tue, 26 Mar 2024 10:26:04 -0300
> > >>>>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
> > >>>>>
> > >>>>>> The local 9p driver in virtio-9p-test.c its temporary dir right at the
> > >>>>>> start of qos-test (via virtio_9p_create_local_test_dir()) and only
> > >>>>>> deletes it after qos-test is finished (via
> > >>>>>> virtio_9p_remove_local_test_dir()).
> > >>>>>>
> > >>>>>> This means that any qos-test machine that ends up running virtio-9p-test local
> > >>>>>> tests more than once will end up re-using the same temp dir. This is
> > >>>>>> what's happening in [1] after we introduced the riscv machine nodes: if
> > >>>>>> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
> > >>>>>> this is what happens:
> > >>>>>>
> > >>>>>> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
> > >>>>>>
> > >>>>>> - virtio-9p-device tests will run virtio-9p-test successfully;
> > >>>>>>
> > >>>>>> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
> > >>>>>>      first slow test at fs_create_dir() because the "01" file was already
> > >>>>>>      created by fs_create_dir() test when running with the virtio-9p-device.
> > >>>>>>
> > >>>>>> We can fix it by making every test clean up their changes in the
> > >>>>>> filesystem after they're done. But we don't need every test either:
> > >>>>>> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
> > >>>>>> i.e. a dir is created, verified to be created, and then removed. Fixing
> > >>>>>> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
> > >>>>>> both. The same theme follows every test in virtio-9p-test.c, where the
> > >>>>>> 'unlikat' variant does the same thing the 'create' does but with some
> > >>>>>> cleaning in the end.
> > >>>>>>
> > >>>>>> Consolide some tests as follows:
> > >>>>>>
> > >>>>>> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
> > >>>>>>      fs_create_unlinkat_dir();
> > >>>>>>
> > >>>>>> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
> > >>>>>>      fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
> > >>>>>>
> > >>>>>> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
> > >>>>>>      fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
> > >>>>>>      creates is now being removed.
> > >>>>>>
> > >>>>>
> > >>>>> The  change looks good functionally but it breaks the legitimate assumption
> > >>>>> that files "06/*" come from test #6 and so on... I think you should consider
> > >>>>> renumbering to avoid confusion when debugging logs.
> > >>>>>
> > >>>>> Since this will bring more hunks, please split this in enough reviewable
> > >>>>> patches.
> > >>>>
> > >>>> Fair enough. Let me cook a v2. Thanks,
> > >>>
> > >>> Wouldn't it be much simpler to just change the name of the temporary
> > >>> directory, such that it contains the device name as well? Then these tests
> > >>> runs would run on independent directories and won't interfere with each other
> > >>> and that wouldn't need much changes I guess.
> > >>
> > >> That's true. If we were just trying to fix the issue then I would go with this
> > >> approach since it's simpler. But given that we're also cutting half the tests while
> > >> retaining the coverage I think this approach is worth the extra code.
> > > 
> > > Well, I am actually not so keen into all those changes. These tests were
> > > intentionally split, and yes with costs of a bit redundant (test case) code.
> > > But they were cleanly build up on each other, from fundamental requirements
> > > like whether it is possible to create a directory and file ... and then the
> > > subsequent tests would become more and more demanding.
> > > 
> > > That way it was easier to review if somebody reports a test to fail, because
> > > you could immediately see whether the preceding fundamental tests succeeded.
> > 
> > The current test design is flawed. It's based on a premise that doesn't happen, i.e.
> > a new temp dir will be created every time the test suit is executed. In reality the
> > temp dir is created only once in the constructor of the test, at the start of qos-test
> > (tests/qtest/qos-test.c, run_one_test()) and removed only once at the destructor
> > at the end of the run.
> > 
> > It's not possible to add a 'device name' in the created temp dir because we're too early
> > in the process, the tests didn't start at that point. So, with the current temp dir design,
> > the tests needs to clean themselves up after each run.
> > 
> > Here's the alternatives I'm willing to go for:
> > 
> > - what I just sent in v2;
> > 
> > - add cleanups in all existing tests. We can keep all of them, but the 'create' tests
> > will be carbon copies of the 'unlinkat' tests but with different names. Can be done;
> > 
> > - if we really want the tests untouched we can rework how the 'temp dir' is created/deleted.
> > The test dir will be created and removed after each test via the 'before' callback. To be
> > honest this seems like the best approach we can take, aside from what I did in v2, and
> > it's on par with how tests like vhost-user-test.c works.
> 
> Yeah, the latter sounds like the best solution to me, too.
> 

+1

> Don't get me wrong, I didn't want to burden you with more work. It's really
> just that I think that restructuring all test cases is contra productive.
> 
> If you want I can also look into that. Just let me know.
> 
> Thanks!
> 
> /Christian
> 
> 



-- 
Greg

