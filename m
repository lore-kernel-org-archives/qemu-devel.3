Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416F8CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4f0-0000ha-L7; Fri, 26 Jun 2026 07:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wd4ey-0000h4-Hp; Fri, 26 Jun 2026 07:23:48 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wd4ex-0000AX-3P; Fri, 26 Jun 2026 07:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=uzYzz1Ai64WQEBWXWLY6h9gc6XgPCUYD1QMRqe/Yjxg=; b=lQNIoaHDu9heZ5Oy8XEUgMITN0
 ljy2rQ5WjFy3wMrvABLKHUYoHxP70ZAQvNfVRPQeG9tDEfLfVLlGUAhePPqbn/tE8TJVHxlGzJZfQ
 6ecXhrvBf4w6RFPUsEZElYi+OHVeCqlsAgEKDz9PczW/G90L3/HJVWwbI3G8EOjxk+XMRAunHKkAT
 zbpIccYkq5y77QJ9RpBgWHZeCWXSw1kol/AyPZsVjGyzSh9c2NviPtiPCMK4Sqtl8zOwNRYvY8gGs
 P0vK84uPYaQfnEeOXnXsbXdWBwVwOC6RwrNZJTdvl6tEdljrdZiQ/4PPt2bX/X7H7igGFxdDcp6pb
 iJ5b8hd9Z6x78wJK4pD7FqHP+cAOLbs7ZlhEnwZU/u/DZKanQjE3J7nqyGsi+0cyLZjoFY92mxGN2
 WZPtldZ9rhxCwIchANFoJPUAcjPbJLkm5SvZMppczmh7LWpZWvuEv7eK5MGu+FvoQEP1q5nTtpohJ
 q4mtHCyfGaT/gWzBS2HOwmLaAo8ngoe5MooDiefo3/Nh7Q7q03G8gmNgKl3onTqpgb38VspU5vy5M
 Zh6QoxGCJf2zFF5E85L+agJb938lYFVhYN+/d8DNBDbLvUfqj6fg6Z7rZtkcHBvVqxpQetzcsFuff
 HJH8e4EULuaN33HPAxQekWSG4fgoTTaUfKYrU1L+I=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 0/3] 9pfs: fix invalid union V9fsFidOpenState access
Date: Fri, 26 Jun 2026 13:23:42 +0200
Message-ID: <2836963.mvXUDI8C0e@weasel>
In-Reply-To: <cover.1781621428.git.qemu_oss@crudebyte.com>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Tuesday, 16 June 2026 17:00:11 CEST Christian Schoenebeck wrote:
> The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR,
> P9_FID_XATTR) share union V9fsFidOpenState with FID-type specific fields.
> Accessing any of the union fields must comply with the FID-type to avoid
> undefined behaviour or information disclosure.
> 
> This series fixes invalid access of this union type at several locations.
> 
> * Patch 1 and Patch 2 are the core fixes checking the FID type on protocol
>   level (9p.c) before allowing access to a FID-type specific union field.
> 
> * Patch 3 adds another safety layer by returning -1 from local_fid_fd() if
>   the FID type would not have a valid file descriptor.
> 
> Christian Schoenebeck (3):
>   hw/9pfs: fix invalid union access by v9fs_co_fsync()
>   hw/9pfs: fix invalid union access by v9fs_co_fstat()
>   hw/9pfs/local: harden local_fid_fd() on FID types
> 
>  hw/9pfs/9p-local.c |  5 ++++-
>  hw/9pfs/9p.c       | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



