Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5556D43366
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93PS-00059G-WF; Thu, 07 Nov 2024 09:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1t93PQ-00058q-Iw; Thu, 07 Nov 2024 09:22:52 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1t93PO-0005pc-2K; Thu, 07 Nov 2024 09:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=AebFJCDqDCCpaKzJthVTbR5niLWp31q33fO+ibOdTg4=; b=ANNI2DJ2UlAm5VMvWZFs9G2u+r
 hIu3gWxbAw/N1y1vuPpBn4MN7DBg/r5kOri2XtPVmfu57rMg9cvxqFmm2/r+nFjwFPWlSZ1wizFRU
 CJr4jSTrakKuuvwfTEMsLzt+oHIX6ZjFTPxUx4K8CizdvHyl7xbz1cJE827XGi1ta85cFIQGvdPzH
 fZWV5C0DK4n+SocNfZ2E5lauKx8UqARprZOB31QGDBaedk51Q9HZxcEtPfL4DAIV9R+6HMrlswN9+
 QkgOz/F7xQEmNmpMr67itp47fVu2s9ATlbclrrNd9APFINPGNZUJLjhgNz5dvgYkxbtQeCb3ifDul
 5Eu5yLOvsMSJEXyIatLqFbb9p6SaRntMuGQ4s+YEgu6p2fIqbcByqMlVYfUi/p8IT4bSaqQceVgPr
 NA+dgompJuBj80NOVTgFzqAUJEZEbQweKhGJFo0hg471p8XcXrxAen7bmb59UYLJ2bIt6KojLuUqF
 kRhS8Pq0L85FdSamJ2czs1ihVx5rEYeMWcp6X6Mz1Hpm58xxB2rErf7Gbr9V1ccMLzPmIydCnWB2J
 RuutRJxSPaZyrVFSbMW9Lnz0LgAlhIQbauWk11TtHJfbxTsieIngFkEpIiXd22hg3UMnV1OM1EWtp
 FVZSKpFtO5vKxpxbg5+HwyNN3g6f8Gq/svDzGqIt4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Akihiro Suda <suda.kyoto@gmail.com>,
 jan.dubois@suse.com, anders.f.bjorklund@gmail.com, qemu-stable@nongnu.org,
 Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Subject: Re: [PATCH] 9pfs: fix crash on 'Treaddir' request
Date: Thu, 07 Nov 2024 15:22:41 +0100
Message-ID: <16029121.fLRzCXkQJr@silver>
In-Reply-To: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
References: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
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

On Tuesday, November 5, 2024 11:25:26 AM CET Christian Schoenebeck wrote:
> A bad (broken or malicious) 9p client (guest) could cause QEMU host to
> crash by sending a 9p 'Treaddir' request with a numeric file ID (FID) that
> was previously opened for a file instead of an expected directory:
> 
>   #0  0x0000762aff8f4919 in __GI___rewinddir (dirp=0xf) at
>     ../sysdeps/unix/sysv/linux/rewinddir.c:29
>   #1  0x0000557b7625fb40 in do_readdir_many (pdu=0x557bb67d2eb0,
>     fidp=0x557bb67955b0, entries=0x762afe9fff58, offset=0, maxsize=131072,
>     dostat=<optimized out>) at ../hw/9pfs/codir.c:101
>   #2  v9fs_co_readdir_many (pdu=pdu@entry=0x557bb67d2eb0,
>     fidp=fidp@entry=0x557bb67955b0, entries=entries@entry=0x762afe9fff58,
>     offset=0, maxsize=131072, dostat=false) at ../hw/9pfs/codir.c:226
>   #3  0x0000557b7625c1f9 in v9fs_do_readdir (pdu=0x557bb67d2eb0,
>     fidp=0x557bb67955b0, offset=<optimized out>,
>     max_count=<optimized out>) at ../hw/9pfs/9p.c:2488
>   #4  v9fs_readdir (opaque=0x557bb67d2eb0) at ../hw/9pfs/9p.c:2602
> 
> That's because V9fsFidOpenState was declared as union type. So the
> same memory region is used for either an open POSIX file handle (int),
> or a POSIX DIR* pointer, etc., so 9p server incorrectly used the
> previously opened (valid) POSIX file handle (0xf) as DIR* pointer,
> eventually causing a crash in glibc's rewinddir() function.
> 
> Root cause was therefore a missing check in 9p server's 'Treaddir'
> request handler, which must ensure that the client supplied FID was
> really opened as directory stream before trying to access the
> aforementioned union and its DIR* member.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d62dbb51f7 ("virtio-9p: Add fidtype so that we can do type ...")
> Reported-by: Akihiro Suda <suda.kyoto@gmail.com>
> Tested-by: Akihiro Suda <suda.kyoto@gmail.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

I'll send a PR tomorrow.

Thanks!

/Christian



