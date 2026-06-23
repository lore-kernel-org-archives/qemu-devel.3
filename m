Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE5CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0vP-0001wm-Vj; Tue, 23 Jun 2026 09:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wc0vN-0001vs-Rp; Tue, 23 Jun 2026 09:12:21 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wc0vL-0002l8-U0; Tue, 23 Jun 2026 09:12:21 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 746AA1520C8B;
 Tue, 23 Jun 2026 15:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1782220335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ctfU68kf7nh2gCoCxbynLOYxsqB0wGojZIllMVL0uY=;
 b=G8jKHOUjuLr026PuNh3u0MsQDBzXGZbpMGwXrcxDTpRquNrUok0KXt7UOy8B966FqkgQy8
 mDVCiBKMTS7uqRmb975Ispzz79Oqbjv9fK1rJdEakLh4PGSHhS5kUYTC4usdzHCSrT9Ft6
 X8yowHTg9WJOf7RcKVAAF6Cv+uZN6F0QQbGUrkmch9+Rq0WO6m7ssXvMnCbPyZdbbNYdwg
 zTzVi/02qgqPxS/LLmziMlrSn4jBtIfcVecakndcxdE6UWhSpWYaJvtHRyC3eBUJHgHM25
 aLSCEcIciyYHLxCXzsMo06JaIhDsPVRC2SdfUzIj9tN0iyRnjtbq+9j1U7WXSQ==
Message-ID: <44b1d1d6-7e13-4c18-9d60-da73b9507e1e@dupond.be>
Date: Tue, 23 Jun 2026 15:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] qcow2: add a way to repair bitmaps
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
References: <20260522224335.1286291-1-jean-louis@dupond.be>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20260522224335.1286291-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Kind ping :)

On 23/05/2026 00:43, Jean-Louis Dupond wrote:
> A v5 (and hopefully final :)) version of the patch.
>
> The only change since v4 is that QSIMPLEQ_FOREACH is replaced by QSIMPLEQ_FOREACH_SAFE.
> This to avoid a use after free when we free the 'bm' in the loop.
>
> Thanks
> Jean-Louis
>
> Jean-Louis Dupond (1):
>    qcow2: add functionality to repair bitmaps
>
>   block/qcow2-bitmap.c   | 42 +++++++++++++++++++++++++++++++++++++++---
>   block/qcow2-refcount.c |  3 ++-
>   block/qcow2.c          | 16 ++++++++++++----
>   block/qcow2.h          |  3 ++-
>   4 files changed, 55 insertions(+), 9 deletions(-)
>

