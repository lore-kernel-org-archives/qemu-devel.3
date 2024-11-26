Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E586BD65527
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyts-0004Y6-Pt; Tue, 26 Nov 2024 11:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFytq-0004Xe-UJ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:58:54 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFyto-00019g-H8
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:58:54 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.213])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XyTL9608zzyHS;
 Tue, 26 Nov 2024 16:58:41 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 17:58:41 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005aa6c7434-9339-4993-976b-5ca9bf9ba585,
 FCC27489C1BA5BDC89FB1F76958C936B1C45CC5D) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 26 Nov 2024 17:58:35 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 5/6] 9pfs: fix 'Tgetattr' after unlink
Message-ID: <20241126175835.5442c7d5@bahia>
In-Reply-To: <5608682.ghPI0kNXTk@silver>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <4c41ad47f449a5cc8bfa9285743e029080d5f324.1732465720.git.qemu_oss@crudebyte.com>
 <5608682.ghPI0kNXTk@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 38c6f9a7-b0a9-4b45-85dc-281a89149f72
X-Ovh-Tracer-Id: 18320924762250189277
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfeuieefieevffdvhfehgfdtfeeuudffhefftdfgleeuvdetteejgeeijedtgeegnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpughirhdrshhtrhgvrghmpdhgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrudduuddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=RysGIvybac7IXE4jSHy/InNOVHCghvd8Cqk3joRnxtg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732640322; v=1;
 b=dNQj/jDiGXxWNi468jwiFzBkAY16SmwH7eHH1LctBDrgFsNFbDDE6m8ypoeeR7I4afiUaDVX
 BiHlWR54XLIUoO1RduOAdGbJcBASw4EXEynJDxEO20L69CqaaUJI70WMN5yEVxMew51SIwDqULT
 ToJYGQiZFrwPC2Se/e2Rdjoh1MbjuJlpiBcU0ybzQUMVEJaLqJ6ovrbNrRFXcKS0yfcmHhD8+Rr
 U/zpvqEeFZS3nhHgadPEd0wv08JVqsjifMefElfblKfv2L3k2JbqN/N7JqijJSz54IYL6kRSe25
 c5oZh+K22ZN+lYLkasAPit7+ekYVbketWKpbbOQ2N1xJQ==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=groug@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 26 Nov 2024 17:03:45 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Sunday, November 24, 2024 4:50:03 PM CET Christian Schoenebeck wrote:
> > With a valid file ID (FID) of an open file, it should be possible to send
> > a 'Tgettattr' 9p request and successfully receive a 'Rgetattr' response,
> > even if the file has been removed in the meantime. Currently this would
> > fail with ENOENT.
> > 
> > I.e. this fixes the following misbehaviour with a 9p Linux client:
> > 
> >   open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> >   unlink("/home/tst/filename") = 0
> >   fstat(3, 0x23aa1a8) = -1 ENOENT (No such file or directory)
> > 
> > Expected results:
> > 
> >   open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> >   unlink("/home/tst/filename") = 0
> >   fstat(3, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
> > 
> > This is because 9p server is always using a path name based stat() call
> > which fails as soon as the file got removed. So to fix this, use fstat()
> > whenever we have an open file descriptor already.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/103
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 851e36b9a1..578517739a 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1596,7 +1596,13 @@ static void coroutine_fn v9fs_getattr(void *opaque)
> >          retval = -ENOENT;
> >          goto out_nofid;
> >      }
> > -    retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> > +    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
> > +        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
> > +    {
> > +        retval = v9fs_co_fstat(pdu, fidp, &stbuf);
> > +    } else {
> > +        retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> > +    }
> 
> As for performance fstat() vs. lstat(): with glibc >= 2.39 and/or Linux
> kernel >= 6.6, fstat() is Theta(1) whereas lstat() is O(log n). So fstat() is
> faster than lstat() and hence prioritizing fstat() over lstat() does make
> sense here IMO.
> 
> That's because on Linux kernel side fstat() is implemented by a simple
> constant time linear array access via file descriptor number, whereas lstat()
> needs to lookup the path and hence walk a tree.
> 
> There is a caveat though: Both on glibc and Linux kernel side there was a
> performance bug each, which were both fixed in September 2023 by glibc 2.39
> and Linux kernel 6.6 respectively:
> 
> kernel fix: https://github.com/torvalds/linux/commit/9013c51
> 
> glibc fix: https://github.com/bminor/glibc/commit/551101e
> 
> So on glibc side, due to a misconception, they inappropriately translated
> fstat(fd, buf) -> fstatat(fd, "", buf, AT_EMPTY_PATH) for a long time, instead
> of just calling fstat() directly as ought to be and done now.
> 
> And on kernel side, the negative performance impact of case AT_EMPTY_PATH +
> empty string wasn't considered in fstatat() implementation. This case is now
> short-circuited right at the beginning of the function.
> 
> /Christian
> 
> 

Great explanation Christian !

Reviewed-by: Greg Kurz <groug@kaod.org>

Cheers,

-- 
Greg

