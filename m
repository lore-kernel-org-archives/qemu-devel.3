Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B0BC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3A3w-0003PJ-0k; Fri, 11 Apr 2025 04:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u3A3Y-0003Nl-I7
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:48:12 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u3A3V-0001qg-2m
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1744361289; x=1775897289;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=Ci4EFaAhlQ4nZiPAOrwNmNzxAUVhjqPsbAepI0Fk1/0=;
 b=t49TZjSSWi84wU7R3iAo83G8FCxbt1h9F3UPxUUyHnrCDWSJUbcwGDUa
 zA+ICNc4gzbPZBFCUyaUmweDwMxBTZ8KZVZQ/9XLrW4K7HF2RBx+4TZ86
 mtsdGe2Vll0cWIEKuIpsVXvW0TiFt5gGyhKxgpVeJVQOhQim9HPQb15rp Y=;
X-CSE-ConnectionGUID: ghYRCp2pSyW4sS21KHjF9w==
X-CSE-MsgGUID: nW8PkTegRcyLnzPCbrZBQg==
X-IronPort-AV: E=Sophos;i="6.15,203,1739833200"; 
   d="scan'208";a="803176"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 11 Apr 2025 10:48:04 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <87jz7rhjzq.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de>
Date: Fri, 11 Apr 2025 10:48:04 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <4caa0-67f8d780-a89-60718600@156698708>
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

On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse.de>=
 wrote:

> We'll need to add the infrastructure to reject multifd and direct-io
> before this. The rest of the capabilities should not affect mapped-ra=
m,
> so it's fine (for now) if we don't honor them.

Ok, thanks for the update.
=20
> What about zero page handling? Mapped-ram doesn't send zero pages
> because the file will always have zeroes in it and the migration
> destination is guaranteed to not have been running previously. I beli=
eve
> loading a snapshot in a VM that's already been running would leave st=
ale
> data in the guest's memory.

Yes, you are correct.

About the `RAMBlock->file=5Fbmap`, according to the code it is a:
`/* bitmap of pages present in the migration file */`
And, if a pages is a zero page, it won't be in the migration file:
`/* zero pages are not transferred with mapped-ram */`
So, zero page implies bitmap 0.
Does the opposite hold?

If bitmap 0 implies zero page, we could call `ram=5Fhandle=5Fzero`
in `read=5Framblock=5Fmapped=5Fram` for the clear bits.
Or do you fear this might be unnecessary expensive for migration?

If bitmap 0 does not imply zero page, I feel like the
"is present in the migration file" and "is zero page" info should
be better separated.

Best,
Marco


