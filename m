Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D2606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ahUow9oj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlyT-0005Kx-5p; Fri, 30 Oct 2026 08:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMlyQ-0005KD-HM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:44:46 -0400
Received: from out-130.mta0.migadu.com ([2001:41d0:1004:224b::82]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMlyM-0001mt-KH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:44:45 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=QtRt0ves/wBA9PlBFoIyVL02XOI83JkkfiRXPN+Jr1Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364279; v=1; x=1793969079;
 b=ahUow9ojKmXIdw0tqigoj3h3cYo6WBg8Ws7rp/XwQh+rMo+1JTghANKsZs72Jw6UMwh47pRO
 Fea6UORh/U2OD5ehcsvnFHXjq3cWrODI9TqLfoXUgSnFcOwv2CW9FprHXvbcltCBNGyVRWalebL
 R6TUgH7j0zXCHb0w3O5c11GI=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 5c66046834214a38;
 Fri, 30 Oct 2026 12:44:39 +0000
X-Mizu-Trace-ID: 5c66046834214a38
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, jic23@kernel.org,
 philmd@oss.qualcomm.com, linux-cxl@vger.kernel.org, junjie.cao@linux.dev
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
Date: Fri, 30 Oct 2026 07:44:31 -0500
Message-ID: <20261030124431.1066454-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
References: <20260729144645.1552511-1-junjie.cao@intel.com>
 <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::82;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

On 30/10/26 14:35, Michael Tokarev wrote:
> This patch series has been Cc'ed to qemu-stable@.  It is interesting how
> it's been Cc'ed, and I think there's some error here.  From whole series,
> only patch 2 (destroy primary CCI before re-initialization on reset) is
> tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
> to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
> qemu-stable mailing list, but are not tagged for-stable.

Thanks for pointing this out. Only patches 1 and 2 were intended
for stable; I copied qemu-stable@ on the whole series. I'll keep
the stable Cc limited to the relevant patches in future.

Patch 1 carries the tag both on the list and in 259b877eac, and you
already have it as 4a39c7d61e in 11.1.2.  So for 11.1.x patch 2 is
indeed the only one left.

> From this list, I'm only picking up patch 2, and only for 11.1.x series.
> The other active stable series, 10.0.x, - apparently it's not needed there.

Neither applies to 10.0 as-is since cxl_destroy_cci() only exists from
10.1, but the leak is there too: ct3d_reset() re-runs cxl_init_cci() on
all three CCIs, allocating a new timer each time.  I've just sent a
10.0 version, "[PATCH stable-10.0] hw/cxl: free the CCI background
timer on Type-3 reset and exit".

Thanks,
Junjie

