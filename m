Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=WlsXAbqE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqho-0001JO-8w; Tue, 24 Nov 2026 08:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVqhe-0001Ih-TM; Tue, 24 Nov 2026 08:37:00 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVqhb-0001c2-OT; Tue, 24 Nov 2026 08:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795527401; bh=8/aruCP7cSMSq5Z/emheyre1G6ZvOspS5m5x/o2PctU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WlsXAbqESrI9GN5UBb+8r8hqm9Aem2SkC5FzNye9oF9L7MdrsK1leOXLnG1xyAA35
 zRQqXQ2TsIQXj8ug5O9fWUkZXo4fvpawLc+7QOmENvUVqM81WRZ8LSTgRHnQFxvP4J
 Co1nZZV8Ic6nPL87nnU/D33BcLjFicGcFxcGe/M8=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 64E8620595;
 Tue, 24 Nov 2026 14:36:41 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93D1821E6A04; Tue, 24 Nov 2026 14:36:49 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>,  qemu-block@nongnu.org,
 stefanha@redhat.com,  afaria@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] file-posix: Add 'accept-read-only-device' option
In-Reply-To: <awWD_4Y9xsYMKdS9@redhat.com> (Kevin Wolf's message of "Tue, 24
 Nov 2026 13:33:03 +0100")
References: <20261029164522.103918-1-kwolf@redhat.com>
 <20261029164522.103918-2-kwolf@redhat.com>
 <au2qCGy-CttBaXoI@angien.pipo.sk> <87cxruh857.fsf@pond.sub.org>
 <awWD_4Y9xsYMKdS9@redhat.com>
Date: Tue, 24 Nov 2026 14:36:49 +0100
Message-ID: <87pkvue4ge.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kevin Wolf <kwolf@redhat.com> writes:

> Am 24.11.2026 um 10:48 hat Markus Armbruster geschrieben:
>> I almost missed this.  My apologies for the delay!
>> 
>> Peter Krempa <pkrempa@redhat.com> writes:
>> 
>> > CC'd Markus for QAPI generator input.
>> >
>> > On Thu, Oct 29, 2026 at 17:45:21 +0100, Kevin Wolf wrote:
>> >> The host_device block driver refuses to open a block device read-write
>> >> if the BLKROGET ioctl tells it that it's actually read-only. For such
>> >> devices it's possible to open a read-write file descriptor, but any
>> >> writes to the device would fail.
>> >> 
>> >> There are valid use cases for which this check gets in the way, as
>> >> explained in the bug report:
>> >> 
>> >>     However, this behavior prevents a legitimate enterprise use case:
>> >>     running VMs against storage replication target LUNs in a disaster
>> >>     recovery configuration. Enterprise storage arrays (Dell Powermax,
>> >>     Pure Storage) set the SCSI Write Protect bit on replication target
>> >>     LUNs, causing the Linux kernel to mark them read-only via BLKROGET.
>> >>     The VMs on the passive DR site need to start with these LUNs
>> >>     attached - writes are expected to fail (the application middleware
>> >>     knows it's on the passive side), and after a DR role swap the LUN
>> >>     becomes writable and writes should succeed immediately without any
>> >>     VM restart.
>> >> 
>> >> In order to allow such use cases in which a currently read-only device
>> >> is deliberately opened read-write, add a new option to the host_device
>> >> driver that allows the user to skip the check.
>> >> 
>> >> Buglink: https://redhat.atlassian.net/browse/RHEL-186136
>> >> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> >> Reviewed-by: Eric Blake <eblake@redhat.com>
>> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >> ---
>> >>  qapi/block-core.json | 19 ++++++++++++++++++-
>> >>  block/file-posix.c   | 23 ++++++++++++++++++++---
>> >>  2 files changed, 38 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> index 741c8165c06..80272b878c5 100644
>> >> --- a/qapi/block-core.json
>> >> +++ b/qapi/block-core.json
>> >> @@ -3390,6 +3390,23 @@
>> >>    'features': [ { 'name': 'dynamic-auto-read-only',
>> >>                    'if': 'CONFIG_POSIX' } ] }
>> >>  
>> >> +##
>> >> +# @BlockdevOptionsHostDevice:
>> >> +#     Driver specific block device options for the host_device
>> >> +#     backend.
>> >> +#
>> >> +# @accept-read-only-device: allow opening a read-only device as
>> >> +#     read-write.  If this is false, opening a host device read-write
>> >> +#     requires on Linux that the BLKROGET ioctl considers the device
>> >> +#     writable.  If it is true, this check is skipped.  (since: 11.2,
>> >> +#     default: false)
>> >> +#
>> >> +# Since: 11.2
>> >> +##
>> >> +{ 'struct': 'BlockdevOptionsHostDevice',
>> >> +  'base': 'BlockdevOptionsFile',
>> >> +  'data': { '*accept-read-only-device': 'bool' } }
>> >> +
>> >>  ##
>> >>  # @BlockdevOptionsNull:
>> >>  #     Driver specific block device options for the null backend.
>> >> @@ -4777,7 +4794,7 @@
>> >>        'ftps':       'BlockdevOptionsCurlFtps',
>> >>        'host_cdrom':  { 'type': 'BlockdevOptionsFile',
>> >>                         'if': 'HAVE_HOST_BLOCK_DEVICE' },
>> >> -      'host_device': { 'type': 'BlockdevOptionsFile',
>> >> +      'host_device': { 'type': 'BlockdevOptionsHostDevice',
>> >>                         'if': 'HAVE_HOST_BLOCK_DEVICE' },
>> >>        'http':       'BlockdevOptionsCurlHttp',
>> >>        'https':      'BlockdevOptionsCurlHttps',
>> >
>> > After the two hunks above the 'host_device' type in the resulting QMP
>> > schema will no longer have the 'dynamic-auto-read-only' feature which it
>> > had when it used 'BlockdevOptionsFile' directly rather than the
>> > 'BlockdevOptionsHostDevice' type which 'inherits' from
>> > 'BlockdevOptionsFile'.
>> 
>> Reproduced.
>> 
>> > Markus, after chatting with Kevin, we're not sure if it's intention that
>> > features are not inherited in the above case, and thus the
>> > 'dynamic-auto-read-only' feature would need to be propagated also to
>> > 'BlockdevOptionsHostDevice' or it's a mistake in the generator.
>> 
>> The generator does what the programmer(s) intended it to do: 'base'
>> splices in the members, and nothing else.  Further evidence of intent:
>> the explanation of 'base' in docs/devel/qapi-code-gen.rst talks only
>> about members.
>> 
>> Should it do more?
>> 
>> Kevin, did you expect the feature to be inherited?  Or did you simply
>> not remember there's a feature, and therefore didn't think about what
>> the generator might do with it?
>
> I simply didn't think of it, and when Peter pointed it out, I was unsure
> what the behaviour really should be. I think inheriting would usually be
> what you want, but maybe not always.
>
> I think we have two options to fix the regression: Either change the
> QAPI generator to inherit features from 'base' (and avoid similar
> problems in the future), or just manually duplicate the feature in the
> schema for BlockdevOptionsHostDevice.
>
> Which one do you like better? I don't mind too much either way.

Let's duplicate manually at least for now.  We want a fix for 11.2, and
it's last minute.  I don't want to mess with the generator this late in
the freeze.  Manual duplication is simple and safe.

Bases with features are rare.  I can see three instances:

    Base                 of                         has feature
    BlockdevOptionsFile  BlockdevOptionsHostDevice  dynamic-auto-read-only
    SevCommonProperties  SevGuestProperties         confidential-guest-reset
    SevCommonProperties  SevSnpGuestProperties      confidential-guest-reset

I'm reluctant to accept generator complexity for something as rare as
this.

On the other hand, all three need the feature duplicated, I think.

On the third hand, we can manually add features, but not remove them.
So if we make the generator inherit them, we're stuck with them.

Would you like me to post patches?

