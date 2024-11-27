Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644C2D609C1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEpI-0003Wq-NJ; Wed, 27 Nov 2024 04:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tGEpA-0003Wc-MF; Wed, 27 Nov 2024 04:59:09 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tGEp8-0003lh-VY; Wed, 27 Nov 2024 04:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XiYHx7wUQlXwYsdXF8aUhuJSh6dNJXBDiBaTD+AoVyg=; b=isjCpQOelVPSotvf62MgxXRM8m
 zXjf8ZjW4Pxg9qofkW+XP9vP2mZoj3kNyrtjOkTY2Dp5MhnOCp+rFPcI9mxbK4qCBZHScHqADqAs8
 PIz4lxOd0rau4UwsMRvv1Qoak7cBKr2pdPlZW/zxqIr1A8Hs523AbAIGXBkBtCWrj1oUvdgpkTW5+
 4rjoFw8VFl9pl3hPpmJ0rmnUJV35vO5UNtKbS9QB8fuQ7VjuKimBsw2f2tkQ+BGGV7Sn0u2jCJgy2
 EWd1iqWwDrjIh8UOt9edwZSIcFGqqx9SDxbEBizlTyE8PPq0x2fvMHyP+UoqIUtPNchtE7iM6wnkZ
 RRBsut77T6L/01zzCQkO6eAanprKcykuy6/6lDDsMup4F+Thu4lq14tqfutw1q1ea8HFsWHIjNCS0
 uCFshhCyiifKudiKVtBzYQR6fnvdCWAL9rugYeyvS0Gg33UYFR+EnJ2jBO34fby3EbhRGEoNc9GXc
 EwoYeBMzu4ETO35wuQQYdyO3bgAOVrkjOnM2X+RC94eTuigZnky9UPsJoRqSHFjsFEPXYbwW1Z+ys
 ej+D7o4+ZkX9XClPdGlI8PzxsFGLlLxEq/sYl19l364avhf8+HFLbf10mRsAFY7+5KWcTwh95W3lL
 yqqvsdbv3KHHD7V7Epb7N16z0z1hfHqhAbHAMzeyI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
Date: Wed, 27 Nov 2024 10:58:58 +0100
Message-ID: <3046646.7BtKmjSr7u@silver>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
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

On Sunday, November 24, 2024 5:28:40 PM CET Christian Schoenebeck wrote:
> This fixes an infamous, long standing bug:
> https://gitlab.com/qemu-project/qemu/-/issues/103
> 
> * Actual fix of this bug is patch 5.
> 
> * Patches 1 and 6 add a test case to verify the expected behaviour.
> 
> * The other patches (2, 3, 4) are basically just minor cleanup patches more
>   or less (un)related that I simply did not bother to send separately.
> 
> Probably there are still other 9p request types that should be fixed for this
> use-after-unlink idiom, but this series fixes the mentioned bug report as
> described by reporter, so fair enough to round this up here for now.

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



