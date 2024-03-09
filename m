Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAFFC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 08:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirkp-0002kS-Qb; Sat, 09 Mar 2024 03:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirkm-0002k5-G8
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 03:08:24 -0500
Received: from out-182.mta1.migadu.com ([95.215.58.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirki-0002Pa-DG
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 03:08:23 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxuIhPrqwGO/zr8VPVlrgYVea/+/Q9YViFFiUKFpqds=;
 b=w0kKOCkv3wgUnoH6UO/c1qG/ISW5yjJdIpGRNcp3Te3OqdJLVYJbl8Crz8dOi/dr0V7p4Y
 R8CdtBDy//kOgdenZp4cG8fwCOaN03ULk8XTrfpu/b1T57Qy37CeyaTfxQccL/xv5Cw+OE
 1TvsOLtlbtrMUa8wdC+XiD9Sfli2TFQ=
Date: Sat, 09 Mar 2024 08:08:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: hao.xiang@linux.dev
Message-ID: <93c343ff6b1ec22490994cfb8b61c42418c34c1e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 2/7] migration/multifd: Implement zero  page
 transmission on the multifd thread.
To: farosas@suse.de, peterx@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, jdenemar@redhat.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, qemu-devel@nongnu.org
In-Reply-To: <CAAYibXiLLztnPnKkGZKgXpD8HfSsFqdmhUGcETpzQDUoURRNwg@mail.gmail.com>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-3-hao.xiang@bytedance.com>
 <ZeV1TrOvERHN_LOo@x1n> <878r2ynnky.fsf@suse.de>
 <87r0gp97p6.fsf@suse.de>
 <CAAYibXiLLztnPnKkGZKgXpD8HfSsFqdmhUGcETpzQDUoURRNwg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.182; envelope-from=hao.xiang@linux.dev;
 helo=out-182.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

>=20
>=20On Mon, Mar 4, 2024 at 10:24 AM Fabiano Rosas <farosas@suse.de> wrote=
:
>=20
>=20=20
>=20
>=20=20
>=20
>  Fabiano Rosas <farosas@suse.de> writes:
>=20
>=20=20
>=20
>  Peter Xu <peterx@redhat.com> writes:
>=20
>=20=20
>=20
>  On Fri, Mar 01, 2024 at 02:28:24AM +0000, Hao Xiang wrote:
>=20
>=20=20
>=20
>  -GlobalProperty hw_compat_8_2[] =3D {};
>=20
>=20=20
>=20
>  +GlobalProperty hw_compat_8_2[] =3D {
>=20
>=20=20
>=20
>  + { "migration", "zero-page-detection", "legacy"},
>=20
>=20=20
>=20
>  +};
>=20
>=20=20
>=20
>  I hope we can make it for 9.0, then this (and many rest places) can be=
 kept
>=20
>=20=20
>=20
>  as-is. Let's see.. soft-freeze is March 12th.
>=20
>=20=20
>=20
>  One thing to mention is I just sent a pull which has mapped-ram featur=
e
>=20
>=20=20
>=20
>  merged. You may need a rebase onto that, and hopefully mapped-ram can =
also
>=20
>=20=20
>=20
>  use your feature too within the same patch when you repost.
>=20
>=20=20
>=20
>  The key points are:
>=20
>=20=20
>=20
>  - The socket migration is under "use_packets", the mapped-ram is under
>=20
>=20=20
>=20
>  "!use_packets" always.
>=20
>=20=20
>=20
>  - mapped-ram doesn't trasmit zero-pages, it just clears the
>=20
>=20=20
>=20
>  corresponding bit in block->file_bmap.
>=20
>=20=20
>=20
>  https://lore.kernel.org/all/20240229153017.2221-1-farosas@suse.de/
>=20
>=20=20
>=20
>  That rebase may or may not need much caution, I apologize for that:
>=20
>=20=20
>=20
>  mapped-ram as a feature was discussed 1+ years, so it was a plan to me=
rge
>=20
>=20=20
>=20
>  it (actually still partly of it) into QEMU 9.0.
>=20
>=20=20
>=20
>  I started doing that rebase last week and saw issues with a sender
>=20
>=20=20
>=20
>  thread always getting -EPIPE at the sendmsg() on the regular socket
>=20
>=20=20
>=20
>  migration. Let's hope it was just me being tired.
>=20
>=20=20
>=20
>  I'll try to get something ready this week.
>=20
>=20=20
>=20
>  @Hao Xiang:
>=20
>=20=20
>=20
>  Here's a branch with the rebase. Please include the first two commits
>=20
>=20=20
>=20
>  when you repost:
>=20
>=20=20
>=20
>  migration/multifd: Allow clearing of the file_bmap from multifd
>=20
>=20=20
>=20
>  migration/multifd: Allow zero pages in file migration
>=20
>=20=20
>=20
>  There are also two small additions and some conflict resolution at the
>=20
>=20=20
>=20
>  "Implement zero page..." commit. Make sure you don't miss them.
>=20
>=20=20
>=20
>  https://gitlab.com/farosas/qemu/-/commits/migration-multifd-zero-page
>=20
>=20=20
>=20
>=20 Let me know if you encounter any issues.
>=20

Sorry=20about the delay. I have rebased and pulled in the two commits you=
 mentioned. Test works fine. I just sent out a new version.

I removed the zero/zero-bytes interface changes out of this patchset but =
will follow up with a separate one.

