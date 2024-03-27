Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AC0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOwT-00076B-TB; Wed, 27 Mar 2024 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpOwP-00075p-Uc
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:47:26 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rpOwN-0003VW-Rj
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7j0YcMrREnK3u0fvyxgGBNYdAQaM3z+OSYMSM/ZErGI=; b=CywOtvZqquTXOXJzo+Hx6Mphc6
 WYwBu7wcunsrLXjlYTAGA3eM3wu7TJQdvhM2gYGsRF1CODc3G9T10AxnEUbuh9KJxoFAXzLbLZw74
 jmMxIO+WF6sUzT3grAwgSEo0fx8buWKLcshNhwn+4rOseeye1hds/63F/xcFXE3PVWw7HakhDRDQW
 hPmXMp/0wuS+5aEZRZAnNGIJhoZPi0fkGDw+QjB9oi/b0J/v5vnnSnmfGmcP7+VaN2smtCFzQdPP1
 X7m2SGSesLoMg0kMqZOYNYQwuCSYT+Ece+3JZvKGKj1ijEUAqYmW8xfctUeau0hbHLc/nnW0BAovz
 9F+FJmAwHvsYh8BwsUskdwK6U5aFN4toYoqRbyoIq8TiegO4UBfMd3926EZCouP2e+kADvxaIlMju
 3hMhTblOwnSkG1qSddq5g2xiiYdbZP2CAFzKjaW8ZB377aVfiylPIiC90C+egpg9QuZIaZ6pnnOSy
 MZZjfygoHQp5ERNweLCYz5/S55f4jPD7hJ1zwF3mhne56GqhDKXUhRTtbGAUUZB7LPT+ur5noU0pc
 sYx2pGodoeHOrf4HsvpfOxEqoAVlm2tcwhWRpwbYXdt7YPuTQJhQDPJ0/cP/teqLSlwooKm2Ut1Eh
 UPCl4UoZfRm28iv5K43PRB4M2PFKrD3uJIY8SWvpQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alistair.francis@wdc.com,
 peter.maydell@linaro.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create
 dir, file and symlink tests
Date: Wed, 27 Mar 2024 09:47:19 +0100
Message-ID: <190171404.Ysjo4HZYI3@silver>
In-Reply-To: <1f73d065-fcf6-4466-bc86-c8fdbae7bd96@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
 <20240326180550.3072dd2d@bahia>
 <1f73d065-fcf6-4466-bc86-c8fdbae7bd96@ventanamicro.com>
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

On Tuesday, March 26, 2024 6:47:17 PM CET Daniel Henrique Barboza wrote:
> On 3/26/24 14:05, Greg Kurz wrote:
> > On Tue, 26 Mar 2024 10:26:04 -0300
> > Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
> > 
> >> The local 9p driver in virtio-9p-test.c its temporary dir right at the
> >> start of qos-test (via virtio_9p_create_local_test_dir()) and only
> >> deletes it after qos-test is finished (via
> >> virtio_9p_remove_local_test_dir()).
> >>
> >> This means that any qos-test machine that ends up running virtio-9p-test local
> >> tests more than once will end up re-using the same temp dir. This is
> >> what's happening in [1] after we introduced the riscv machine nodes: if
> >> we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
> >> this is what happens:
> >>
> >> - a temp dir is created, e.g. qtest-9p-local-WZLDL2;
> >>
> >> - virtio-9p-device tests will run virtio-9p-test successfully;
> >>
> >> - virtio-9p-pci tests will run virtio-9p-test, and fail right at the
> >>    first slow test at fs_create_dir() because the "01" file was already
> >>    created by fs_create_dir() test when running with the virtio-9p-device.
> >>
> >> We can fix it by making every test clean up their changes in the
> >> filesystem after they're done. But we don't need every test either:
> >> what fs_create_file() does is already exercised in fs_unlinkat_dir(),
> >> i.e. a dir is created, verified to be created, and then removed. Fixing
> >> fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
> >> both. The same theme follows every test in virtio-9p-test.c, where the
> >> 'unlikat' variant does the same thing the 'create' does but with some
> >> cleaning in the end.
> >>
> >> Consolide some tests as follows:
> >>
> >> - fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
> >>    fs_create_unlinkat_dir();
> >>
> >> - fs_create_file() is removed. fs_unlinkat_file() is renamed to
> >>    fs_create_unlinkat_file(). The "04" dir it uses is now being removed;
> >>
> >> - fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
> >>    fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
> >>    creates is now being removed.
> >>
> > 
> > The  change looks good functionally but it breaks the legitimate assumption
> > that files "06/*" come from test #6 and so on... I think you should consider
> > renumbering to avoid confusion when debugging logs.
> > 
> > Since this will bring more hunks, please split this in enough reviewable
> > patches.
> 
> Fair enough. Let me cook a v2. Thanks,

Wouldn't it be much simpler to just change the name of the temporary
directory, such that it contains the device name as well? Then these tests
runs would run on independent directories and won't interfere with each other
and that wouldn't need much changes I guess.

/Christian



