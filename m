Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86713C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 09:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0cz4-0007oo-0y; Fri, 04 Apr 2025 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u0cz1-0007oJ-RQ
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:05:04 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u0cyz-0006iI-O0
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 05:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1743757501; x=1775293501;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=tKKvVE4ZkE2kYyppzPX0cpQ4xPCwEV47jh1mXF+qWTI=;
 b=YRDgcC6TenjL0PWT4+Lo2hv1ZIL6T2tzn9qWfd/fvQ8DHO7JJ2kdCC9t
 eMCwRVBG+cdjGiyADT0TN9daeaO9zxu+QtpuXZm7cVcxBjlVKhqAZGMkt
 hseYwVkptdY+hJYVc9JVm5irCOfJyzumWJZsKrvypVbaLpe3wxaxEix4q M=;
X-CSE-ConnectionGUID: DHs6AsXiRy+7vXXVu60BOw==
X-CSE-MsgGUID: UB70fPtCQUSRa3Q7QV9fSw==
X-IronPort-AV: E=Sophos;i="6.15,187,1739833200"; 
   d="scan'208";a="688688"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 04 Apr 2025 11:04:56 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
Date: Fri, 04 Apr 2025 11:04:56 +0200
Cc: "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 qemu-devel@nongnu.org
To: "Prasad Pandit" <ppandit@redhat.com>
MIME-Version: 1.0
Message-ID: <5ed-67efa080-44f-38bc9540@144005994>
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hello Prasad,

On Friday, April 04, 2025 10:19 CEST, Prasad Pandit <ppandit@redhat.com=
> wrote:
> * IIUC, when =5FFEATURE=5FSEEKABLE is set, the channel I/O sequence
> eventually makes underlying preadv(2)/pwritev(2) calls, which use
> lseek(2) to adjust the stream r/w pointer with the given offset,
> before doing the r/w operation.
Almost. Unlike  lseek(2), pread(2) and co. do not have side effects on
the fd's offset.
From the man page:
> The pread() and pwrite() system calls are especially useful in
> multithreaded applications.  They allow multiple threads to
> perform I/O on the same file descriptor without being affected by
> changes to the file offset by other threads.

> * QIOChannelBlock has '.io=5Fseek' routine corresponding to the lseek=
(2)
> call. It is not clear how setting QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE =
helps
> for QIOChannelBlock streams.
It is a first step in making QIOChannelBlock compatible with
mapped-ram feature that requires it since mapped-ram uses
io=5Fpreadv and io=5Fpwritev methods.

Best,
Marco


