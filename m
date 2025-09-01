Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C886CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1pZ-00005f-Ar; Mon, 01 Sep 2025 06:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ut1pK-0008D0-C4
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:31:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ut1pD-0005kj-DN
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=cgnse1i1+F4zsmgiL1rkXVjVZzRegby1ZinKGpRLv5M=; b=BSlvEz1/8ifo2T64ZeXlXN2GVK
 v45GZE6vcTdN6YGQaNQ8oB8RWrRNe6UmUxSlFMb5SgPSeQUG/ji4kE7NjFluiAUnS9IvQkAeIhTCF
 3PZsxG43KDbaplpCJV5vlk0/Dy0WBr7LuHZgbf3zsh2CReA1oCvFzYskh96SjF3SoPbHsgau1LeAj
 KqUr4eDVf0PL6d/bsd1C8mA6ff57pDt55O/JWpb4LAzhCObHvHf9vjCeCnmznTZGwbk1juxMunbBG
 WOkIVxienu6aGV65/BMug8jOI8zXDSB2GUaV2IZrkPtgj8+CLPE0s6v2KswGh6xEgslnGsaxWcRMT
 ZHUVOfd0vVwN374dkL6ZOiNFPmiQZQN207lmmoH9yKLPBZsYywOGJj9jRqhW1e0ihTVWT1+Ab/ErZ
 /fE9Ge2kqjRWBf5yisPnHRmdnkio/uUbmR58CyeIpwasT6Z7TP+DqB5wfvADHMdt/FAl0QM6UyxlC
 An99NA+sQnBJsRpMGurvdLLhuXVzXrsd7I9mT7dcSCh6/02SmyesfA0tgKbLPH2o+zT3JK5L6etAw
 sDiRTLz8rIsqjnDeh9kndfQARiMBisxFHKiqU2ZCZ6v/ruxP+J25MFNz1lXu6aKTUjke92O22q4Gv
 3Xnak6yKiRTtcOnZhnbAXixBqOfPXVN/cbAEDINWY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] 9pfs: Add FreeBSD support
Date: Mon, 01 Sep 2025 12:31:32 +0200
Message-ID: <2671619.RrsIbz4Ki0@silver>
In-Reply-To: <aK8WUWSIV6Bz526v@nuc>
References: <aJOWhHB2p-fbueAm@nuc> <12113631.YhV4tvpBIu@silver>
 <aK8WUWSIV6Bz526v@nuc>
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

On Wednesday, August 27, 2025 4:29:37 PM CEST Mark Johnston wrote:
> On Tue, Aug 26, 2025 at 02:34:45PM +0200, Christian Schoenebeck wrote:
[...]
> I folded your suggestion in with a couple of minor tweaks:
> 
> commit 61de78986912b03f08354a177caf603857b531b5
> Author: Mark Johnston <markj@FreeBSD.org>
> Date:   Wed Jul 16 20:32:05 2025 +0000
> 
>     9pfs: Add FreeBSD support
> 
>     This is largely derived from existing Darwin support.  FreeBSD
>     apparently has better support for *at() system calls so doesn't require
>     workarounds for a missing mknodat().  The implementation has a couple of
> warts however:
>     - The extattr(2) system calls don't support anything akin to
>       XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
>     - Attribute names cannot begin with "user." or "system." on ZFS.
>       However FreeBSD's extattr(2) system calls support two dedicated
>       namespaces for these two.  So "user." or "system." prefixes are
>       trimmed off from attribute names and instead EXTATTR_NAMESPACE_USER or
> EXTATTR_NAMESPACE_SYSTEM are picked and passed to extattr system calls
> accordingly.
> 
>     The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
>     filesystems.
> 
>     Signed-off-by: Mark Johnston <markj@FreeBSD.org>

LGTM, thanks!

/Christian



