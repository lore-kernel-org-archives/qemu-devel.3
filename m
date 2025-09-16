Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A48CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYDS-0003Pj-7r; Tue, 16 Sep 2025 12:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uyYCh-0002xi-W9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:06:53 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1uyYCf-0007hN-BU
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1758038810; x=1789574810;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=qu60TWflWHSsMQB5IXlZjQq1FGjUBZOWJZ5msVx5Yrk=;
 b=ezsKpHKN/MFUpaKVbRFfOPwK82/ldkMddhHob4LZzbnCy8lHwNW9A4rH
 w0NgNkrhlGseUU+eAJ7H9MECOqaVgSLU6/ueP3pJuz8oS53ALpcFsqVGv
 BvELDyJTMJgJyBvwX9lYFBXTFcAKV6iH7CuRsh9kz/I/hq/VkO/mPekna E=;
X-CSE-ConnectionGUID: HakAp/RDSum5YEMnf8H6Hg==
X-CSE-MsgGUID: i8G/B7nLR66HTy2WeqC/GA==
X-IronPort-AV: E=Sophos;i="6.18,269,1751234400"; 
   d="scan'208";a="2924512"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 16 Sep 2025 18:06:44 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <87jz7rhjzq.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de>
Date: Tue, 16 Sep 2025 18:06:43 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <1b7bdf-68c98b00-641-3c30b780@162059662>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?migration=3A?= add 
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Fabiano,

On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse.de>=
 wrote:

> Marco Cavenati <Marco.Cavenati@eurecom.fr> writes:
>=20
> > Enable the use of the mapped-ram migration feature with savevm/load=
vm
> > snapshots by adding the QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE feature =
to
> > QIOChannelBlock. Implement io=5Fpreadv and io=5Fpwritev methods to =
provide
> > positioned I/O capabilities that don't modify the channel's positio=
n
> > pointer.
>=20
> We'll need to add the infrastructure to reject multifd and direct-io
> before this. The rest of the capabilities should not affect mapped-ra=
m,
> so it's fine (for now) if we don't honor them.

Do you have any status update on this infrastructure you mentioned?

> What about zero page handling? Mapped-ram doesn't send zero pages
> because the file will always have zeroes in it and the migration
> destination is guaranteed to not have been running previously. I beli=
eve
> loading a snapshot in a VM that's already been running would leave st=
ale
> data in the guest's memory.

About the zero handling I'd like to hear your opinion about this idea I
proposed a while back:
The scenarios where zeroing is not required (incoming migration and
-loadvm) share a common characteristic: the VM has not yet run in the
current QEMU process.
To avoid splitting read=5Framblock=5Fmapped=5Fram(), could we implement
a check to determine if the VM has ever run and decide whether to zero
the memory based on that? Maybe using RunState?

Then we can add something like this to read=5Framblock=5Fmapped=5Fram()
...
clear=5Fbit=5Fidx =3D 0;
for (...) {
    // Zero pages
    if (guest=5Fhas=5Fever=5Frun()) {
        unread =3D TARGET=5FPAGE=5FSIZE * (set=5Fbit=5Fidx - clear=5Fbi=
t=5Fidx);
        offset =3D clear=5Fbit=5Fidx << TARGET=5FPAGE=5FBITS;
        host =3D host=5Ffrom=5Fram=5Fblock=5Foffset(block, offset);
        if (!host) {...}
        ram=5Fhandle=5Fzero(host, unread);
    }
    // Non-zero pages
    clear=5Fbit=5Fidx =3D find=5Fnext=5Fzero=5Fbit(bitmap, num=5Fpages,=
 set=5Fbit=5Fidx + 1);
...
(Plus trailing zero pages handling)

Thank you :)
Marco


