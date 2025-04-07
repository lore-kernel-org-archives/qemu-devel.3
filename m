Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E825C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 09:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1iLu-0004Ng-7U; Mon, 07 Apr 2025 05:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u1iLr-0004NP-6W
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:01:07 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u1iLm-0007r7-5y
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1744016462; x=1775552462;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=CdNVga0zpQKrUJbyUbhvnsYpTjZkKbQmHQmq5oZFcNY=;
 b=x8MQEmDoF1bKVxHO06eCK5C27WzAcwdN3m33eGaE1W5kGJNh2smCCtsb
 Pz/ZrLwMEttGiuxk+ZqIn5YcMRgc+ld0Vn0ECEnjEF4LQpOHXz4tiNFJ1
 fuOYNwEAopO8T3juw1SyJXygMv5fgylIUrTRzos1rdpyPxWKNl8QTHPVz Y=;
X-CSE-ConnectionGUID: DgJmSADeTH2MpRE/FUWPOw==
X-CSE-MsgGUID: O9MU+SZERReTPg5l8eexgw==
X-IronPort-AV: E=Sophos;i="6.15,193,1739833200"; 
   d="scan'208";a="715172"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 07 Apr 2025 11:00:55 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <CAE8KmOyBjkFhc-pa-m897S2h+G=vRgkDf69595K9NvogT_oKRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 176.149.91.221
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
 <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
 <5ef-67efcb00-537-1a6bb1a0@222476586>
 <CAE8KmOyBjkFhc-pa-m897S2h+G=vRgkDf69595K9NvogT_oKRw@mail.gmail.com>
Date: Mon, 07 Apr 2025 11:00:55 +0200
Cc: "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 qemu-devel@nongnu.org
To: "Prasad Pandit" <ppandit@redhat.com>
MIME-Version: 1.0
Message-ID: <4c8ae-67f39480-20b-1b3425c0@158944275>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On Monday, April 07, 2025 08:47 CEST, Prasad Pandit <ppandit@redhat.com=
> wrote:

> * If seeking is managed internally by pread(2)/pwrite(2) and co.
> functions, then that is independent of the
> 'QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE' flag; This flag is QEMU specific=
, it is
> not available outside of QEMU/io/ system. pread(2)/pwrite(2) are
> standard C library functions.

> * Another question is: will pread(2)/pwrite(2) functions work the sam=
e
> if we don't set the 'QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE' flag?
>
> (what I'm trying to say is: it is not clear how setting
> '*=5FFEATURE=5FSEEKABLE'  flag helps in case of QIOChannelBlock class=
)

As you said the capability is used internally. Its goal is to signal to
other QEMU code that the QIOChannel is seekable.
'qio=5Fchannel=5Fpwritev' and 'qio=5Fchannel=5Fpreadv' can be used only=
 if
the QIOChannel has the 'QIO=5FCHANNEL=5FFEATURE=5FSEEKABLE'=20
capability.

The mapped-ram migration checks if the channel has this capability
because it uses the aforementioned functions. Without the capability=20
and the functions implemented in this patch, the mapped-ram migration
won't work with QIOChannelBlock.

You can have a look at the patch where those functions were
introduced here [0].

Best,
Marco

[0] https://lore.kernel.org/qemu-devel/20240229153017.2221-4-farosas@su=
se.de/


