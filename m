Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9749E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 09:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSCQZ-00045e-Fp; Mon, 30 Dec 2024 04:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tSCQX-00045D-Oy
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 04:51:10 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tSCQT-0003Sa-EA
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 04:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=V1g+CY5MDseeuW64YOUoskf6WoUKk34ZOAZeHehWWsI=; b=h8+ljsSpelzjAZHVxe8+rWnciR
 5arkKPYKwyPkcc2aj5+dIQq95iG1Ac9Yab/LzTOWapeh6i7B/dAQnkM4G6o1tas5u3mj7AYSdb0tR
 nuygLWEfJV/99d5ISUdR/XQ9Msx7BNy9/Tsd3tnbiQibUQ3yySCM+BQqesXcU0880y2CqsY0peZ19
 W8JyKasEItQWByUKC5+2GAwuRE2n35qAuyqM8fp+XzZbKboR2S0COov86rQrX39PeXUWMz+H3Ph+y
 INercQ+qBkqNefYvLdSU2ffbx6pU18OzTPlxZLIf1JM+L18vbCXbLNqqOzia0ZREVJCyRjaNcJ8uZ
 fShR5kYrvfe5uklAC2vm0Jm6xp/wmHcuTde8cRkUBQ2syTHX303cb2qwF2OzzqG5/SPX3FlvHnG6K
 BwoJCYWny3hBcyOAwNOFctlrnSijzXDQr7rPyEQuXSUNfqBwP72NjwiJFj/6HSaNLpvpGRSa3akEl
 FgYlqahElsH5w9IrwBr06xv5f+rs0Fmcomgdvjc++ru6oI2FI266t/DiswL0/X4AyuRMm6qW14WOc
 y95zJSb/pND8qCXNXGtsSfpWoe90SsLhyZbpE8zKd1EZX6gz59C1ht3X3XooTnMtdJc7YA8Em5Z3X
 FlJfApB1LUicNNHwNxPrZvgtDoKm4Pv1uykTE5nKY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: improve v9fs_open() tracing
Date: Mon, 30 Dec 2024 10:50:59 +0100
Message-ID: <45674069.kNWJ3c3XjC@silver>
In-Reply-To: <E1tN8RJ-008jNq-5L@kylie.crudebyte.com>
References: <E1tN8RJ-008jNq-5L@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, December 16, 2024 11:30:09 AM CET Christian Schoenebeck wrote:
> Improve tracing of 9p 'Topen' request type by showing open() flags as
> human-readable text.
> 
> E.g. trace output:
> 
>   v9fs_open tag 0 id 12 fid 2 mode 100352
> 
> would become:
> 
>   v9fs_open tag=0 id=12 fid=2 mode=100352(RDONLY|NONBLOCK|DIRECTORY|
>   TMPFILE|NDELAY)
> 
> Therefor add a new utility function qemu_open_flags_tostr() that converts
> numeric open() flags from host's native O_* flag constants to a string
> presentation.
> 
> 9p2000.L and 9p2000.u protocol variants use different numeric 'mode'
> constants for 'Topen' requests. Instead of writing string conversion code
> for both protocol variants, use the already existing conversion functions
> that convert the mode flags from respective protocol constants to host's
> native open() numeric flag constants and pass that result to the new
> string conversion function qemu_open_flags_tostr().
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p-util-generic.c | 44 +++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.h         |  6 ++++++
>  hw/9pfs/9p.c              |  9 +++++++-
>  hw/9pfs/meson.build       |  1 +
>  hw/9pfs/trace-events      |  2 +-
>  5 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 hw/9pfs/9p-util-generic.c

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



