Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E23D31762
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8MDi-0007Va-UY; Tue, 05 Nov 2024 11:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1t8MDZ-0007PK-Ao; Tue, 05 Nov 2024 11:15:49 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1t8MDX-0000v6-Cu; Tue, 05 Nov 2024 11:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=YSBRjl7lMHgSWA0GbUBXdQatEPliZjED/nu+YTV1fvg=; b=FEfxZNm7sR6A6X1vZSWYfUi6US
 jhVb3+A0oMmON71C5kVRl1620lyU/GZ1jQAkN2VzI9AihzRLUS4Qwfzv2kaddO73NqsQlI5u0KJJP
 vSMdy1YbE7KAIMREwpyVCXX1+I3V1zVNeu1C9tVLxLpx4M/zKDdRJqi96jUHKN2MMJFbS9I8DOAKA
 ltOxVSey8d+B8Rhs37EfZ27QzO48cPvru4zxHg0Elm+89FnP/Bg7VZMLCbW7deiruH/EYpDAodKXf
 V3kh2usPa02fOjJPKcTUhzXi1/o4i1TMN3weKuoUYp5w9+HqbOcdbpQSXvC/8jpRejIxngEAQTU+Q
 zS0XvoSKcGIMoj1HWzkZFegQroM0oi0+diqEdmUQVwunWX0HUI5x85gi4OOgxplTE8d7M1GcZ016e
 2+Z/2AaKmfLVtR7ZUsLWlP9G0lhQQabGZFwN/LLioMhYbqVHFwhEoiUVt+kpeRBVK0R59te0eDzUj
 /FeofKZGJX/8ndc0rpvGp/lDlZAUu5sSLMxEaF4DaMBu6PTZUYodmIKGK0fK1NNbBVb6XaP2AfdgE
 RSwrZX7R2GJFcuniz7jCCNHFyrTD1XZ3lYywSpoORENUtzpFQcYIuqU9ud3Mf9P8VdhQKScY8qA92
 6dnZCd6wgApe4rkLhy1ARyi8E96eAR2dAcJSHcEo4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Akihiro Suda <suda.kyoto@gmail.com>,
 jan.dubois@suse.com, anders.f.bjorklund@gmail.com, qemu-stable@nongnu.org,
 Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Subject: Re: [PATCH] 9pfs: fix crash on 'Treaddir' request
Date: Tue, 05 Nov 2024 17:15:37 +0100
Message-ID: <1897217.tevHOsptmc@silver>
In-Reply-To: <20241105123803.0923c22e@bahia>
References: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
 <20241105123803.0923c22e@bahia>
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

On Tuesday, November 5, 2024 1:13:14 PM CET Greg Kurz wrote:
> On Tue, 5 Nov 2024 11:25:26 +0100
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > A bad (broken or malicious) 9p client (guest) could cause QEMU host to
> > crash by sending a 9p 'Treaddir' request with a numeric file ID (FID) that
> > was previously opened for a file instead of an expected directory:
> > 
> >   #0  0x0000762aff8f4919 in __GI___rewinddir (dirp=0xf) at
> >     ../sysdeps/unix/sysv/linux/rewinddir.c:29
> >   #1  0x0000557b7625fb40 in do_readdir_many (pdu=0x557bb67d2eb0,
> >     fidp=0x557bb67955b0, entries=0x762afe9fff58, offset=0, maxsize=131072,
> >     dostat=<optimized out>) at ../hw/9pfs/codir.c:101
> >   #2  v9fs_co_readdir_many (pdu=pdu@entry=0x557bb67d2eb0,
> >     fidp=fidp@entry=0x557bb67955b0, entries=entries@entry=0x762afe9fff58,
> >     offset=0, maxsize=131072, dostat=false) at ../hw/9pfs/codir.c:226
> >   #3  0x0000557b7625c1f9 in v9fs_do_readdir (pdu=0x557bb67d2eb0,
> >     fidp=0x557bb67955b0, offset=<optimized out>,
> >     max_count=<optimized out>) at ../hw/9pfs/9p.c:2488
> >   #4  v9fs_readdir (opaque=0x557bb67d2eb0) at ../hw/9pfs/9p.c:2602
> > 
> > That's because V9fsFidOpenState was declared as union type. So the
> > same memory region is used for either an open POSIX file handle (int),
> > or a POSIX DIR* pointer, etc., so 9p server incorrectly used the
> > previously opened (valid) POSIX file handle (0xf) as DIR* pointer,
> > eventually causing a crash in glibc's rewinddir() function.
> > 
> > Root cause was therefore a missing check in 9p server's 'Treaddir'
> > request handler, which must ensure that the client supplied FID was
> > really opened as directory stream before trying to access the
> > aforementioned union and its DIR* member.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: d62dbb51f7 ("virtio-9p: Add fidtype so that we can do type ...")
> > Reported-by: Akihiro Suda <suda.kyoto@gmail.com>
> > Tested-by: Akihiro Suda <suda.kyoto@gmail.com>
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> 
> Wow ! And this is there since pretty much always... I'm amazed how
> it went unnoticed for so long :-)

Yeah, a true hero, lasted for amazing 14 years. :)

Probably a good wake-up call for looking into that fuzzing environment
somebody made for 9pfs. I never tried it myself.

> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!

/Christian



