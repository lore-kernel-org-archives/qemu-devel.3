Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10565E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 10:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLKLK-0005Cw-AY; Wed, 11 Dec 2024 05:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tLKLG-0005Cm-AX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 05:53:18 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tLKLE-0003Tb-9t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 05:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Au16iehiqvk+wk8r66taDS3tCs1KccCO1AL3eQAkGwE=; b=ThhhX5sLqtAs1NzBhYpFO1v4HU
 Bnp5LnsLCrVoO2gagfkOtX3SMvguXEhi1c2ALwQJwWFhY2cRQXI3OPm74eozwfMV77iXGKNi3MYfR
 sX8Vkk8l/AvKTqbW0nD2igShbPrpEuWN46u554ih2JkEyyfyo2+Y/FW7CZEd1X5Fd9obYXSKOqe5s
 wIUth8FBlmHfMMv+8bHTA+Xw3MAlHBiy3x5cT9dTmOVfey3AcQB0JBus0ljN7zppELdVCp/S7Q0Tp
 F0O9S7nLJj+uJyiyodMlqb0ZlBbDFr08B8u8umo/J4NieZIUAi45i4RUHSyxP6B4QgeDtpjAk1kYD
 6RQtjGkiB6mNpOHIFVvTuvNREYKw6hXE7gNncv8iAsxyscEDnC/MAOfiVghldn7jDv2ff+RUlhEP5
 qXIl2fEh70Tm2pHyuNZdXrSNwAtQM1sYAi1rIJ4Yhyw4Mu6Uh2uXnTnV2zJ0ibbVCs2qEOR1HD2b8
 kMBipAf9al0FKULa+r700R3QzYbxt9wGit+igONDes+aWMnwVDD7ep4QCATQqeB3srCakx6jSgICT
 RQmFIbFwaePTf5OpfRJiCx/4ILPR/ol9RX/bd1Vkgy1ka9PNU+5poo9RHR2EGOhPsy9nF/IbySHkh
 Mq+XY3NYv7OuZiPprtovoVpQhV8I7C0CFdoL9HCfo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2] 9pfs: improve v9fs_walk() tracing
Date: Wed, 11 Dec 2024 11:53:07 +0100
Message-ID: <8337596.dz3T9txbhL@silver>
In-Reply-To: <E1tJamT-007Cqk-9E@kylie.crudebyte.com>
References: <E1tJamT-007Cqk-9E@kylie.crudebyte.com>
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

On Friday, December 6, 2024 4:56:40 PM CET Christian Schoenebeck wrote:
> 'Twalk' is the most important request type in the 9p protocol to look out
> for when debugging 9p communication. That's because it is the only part
> of the 9p protocol which actually deals with human-readable path names,
> whereas all other 9p request types work on numeric file IDs (FIDs) only.
> 
> Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
> to "/home/bob/src", then improve trace output from:
> 
>   v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames 3
> 
> to:
> 
>   v9fs_walk tag=0 id=110 fid=0 newfid=1 nwnames=3 wnames={home, bob, src}
> 
> To achieve this, add a new helper function trace_v9fs_walk_wnames() which
> converts the received V9fsString array of individual path elements into a
> comma-separated string presentation for being passed to the tracing system.
> As this conversion is somewhat expensive, this conversion function is only
> called if tracing of event 'v9fs_walk' is currently enabled.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  V2:
>  - Use trace_event_get_state_backends(TRACE_V9FS_WALK) instead of
>    trace_event_get_state(TRACE_V9FS_WALK) && qemu_loglevel_mask(LOG_TRACE).
>  - Move that check from helper function trace_v9fs_walk_wnames() to caller
>    function v9fs_walk().
> 
>  hw/9pfs/9p.c         | 36 +++++++++++++++++++++++++++++++-----
>  hw/9pfs/trace-events |  2 +-
>  2 files changed, 32 insertions(+), 6 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



