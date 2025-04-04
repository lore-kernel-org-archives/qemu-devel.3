Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4775C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fo2-00023H-T2; Fri, 04 Apr 2025 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u0fnv-00022q-43
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:05:48 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u0fns-00053e-U5
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1743768345; x=1775304345;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=euta8Hr+2K2Sz5Q2kfh5YqmWRZdFYU9SBrOddWPhWQI=;
 b=y+DjxPpX19+bOaZtawob9OYlxQzAsZQLcQyC5Rj3JQVmpW9BegDcWYDy
 u3emz8WqfL/5rqF/KtAMnzNE+NZUha1nqi812e/7T4d1EFXpl1PdSeow3
 T0i2/pJxfXPUAe5UTi3T45byqKh9H/1QrXihb4WgQYbU8aBZ8jz210Ojd Q=;
X-CSE-ConnectionGUID: xn692U2OS/yL3QIAimTCdw==
X-CSE-MsgGUID: 8Lxf6mIeSf2ybBY2aUuk7g==
X-IronPort-AV: E=Sophos;i="6.15,188,1739833200"; 
   d="scan'208";a="691386"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 04 Apr 2025 14:05:41 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
 <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
Date: Fri, 04 Apr 2025 14:05:40 +0200
Cc: "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 qemu-devel@nongnu.org
To: "Prasad Pandit" <ppandit@redhat.com>
MIME-Version: 1.0
Message-ID: <5ef-67efcb00-537-1a6bb1a0@222476586>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?migration=3A?= add 
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Friday, April 04, 2025 12:14 CEST, Prasad Pandit <ppandit@redhat.com=
> wrote:

> * If the r/w pointer adjustment (lseek(2)) is not required, then why
> set the  '*=5FFEATURE=5FSEEKABLE'  flag?

The QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE flag is set to indicate that
the channel supports seekable operations. This flag is more about
signaling capability rather than dictating the use of the specific=20
lseek(2) function.

> * The qio=5Fchannel=5Fblock=5Fpreadv/pwritev functions defined above,=
 which
> shall be called via  '->io=5Fpreadv' and '->io=5Fpwritev' methods, ap=
pear
> to call bdrv=5Freadv/writev=5Fvmstate() functions. Do those functions=
 need
> to adjust (lseek(2)) the stream r/w pointers?

In this case, I don't think any lseek(2) is involved, instead some flav=
or
of pread(2) is used, which, according to the man page, requires that
> The file referenced by fd must be capable of seeking.
because pread(2) internally manages seeking without modifying the
file descriptor's offset.

Let me split the question here:
* Do those functions need to seek into the channel?
Yes
* Do those functions lseek(2) the stream r/w pointers?
No, they do not use lseek(2). The seeking is managed internally by the
pread(2) and co. functions, which perform I/O operations at
specified offsets without altering the file descriptor's position.

I hope this clarifies :)

Best,
Marco


