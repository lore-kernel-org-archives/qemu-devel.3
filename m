Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CED2B941
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Ll6-0001la-Q7; Tue, 05 Nov 2024 10:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1t8Ll0-0001lF-Qe; Tue, 05 Nov 2024 10:46:14 -0500
Received: from smtpout4.mo529.mail-out.ovh.net ([217.182.185.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1t8Lkw-0005zj-Gl; Tue, 05 Nov 2024 10:46:13 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.17.92])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4XjXk40mwnz105G;
 Tue,  5 Nov 2024 15:46:04 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 16:46:03 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0041ecec86e-c3b9-4250-a135-900b05e68133,
 C95E100A97937737B80BEC9A66A832088BBE6DDA) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 5 Nov 2024 13:13:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Akihiro Suda <suda.kyoto@gmail.com>,
 <jan.dubois@suse.com>, <anders.f.bjorklund@gmail.com>,
 <qemu-stable@nongnu.org>, Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Subject: Re: [PATCH] 9pfs: fix crash on 'Treaddir' request
Message-ID: <20241105123803.0923c22e@bahia>
In-Reply-To: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
References: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 6dae6638-5ccc-4f49-b1ea-c4a3f97bec9b
X-Ovh-Tracer-Id: 4448430533422258537
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegffevudduleetgeeftefhtddtkeeludeuudevtdeuhfdvffeggfevfeefkedtkeenucffohhmrghinhepughirhdrshhtrhgvrghmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsuhgurgdrkhihohhtohesghhmrghilhdrtghomhdprhgtphhtthhopehjrghnrdguuhgsohhishesshhushgvrdgtohhmpdhrtghpthhtoheprghnuggvrhhsrdhfrdgsjhhorhhklhhunhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhgvmhhuqd
 hsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhhuthhtihgsrghlrghjihdrvheisehgmhgrihhlrdgtohhmpdfovfetjfhoshhtpehmohehvdelmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=Idlo+TpZqxumuwn40MHDGxg665Zn+q4F3p8uTXi/J3g=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1730821564; v=1;
 b=gu7jEIrl2TPSaZ7tbrp3cMVfiKJtPkES/BFOvVuBIs+bSnMp//LZeh6AzwPFHxIHL9SZmY0G
 sA8O6kt66Xph+9jVdQBnfIng2a+Dro6famlkr3WMxHmNqdajVnkbI0VvvM5LYJQAoNF4UI6a3ms
 iCS2kHxujaDZgrLL5o/jtUXdI2i8CuxsirnUAv89qsEGszoTcZg5HHiLtzB1WPIOw749KeKO1qw
 RwJnrqtq3N4KnwMyJ9LCZ8Tv/yXsjeGP3RtFupPi1EZ9yexeS8UrD5B6H02QTDnhPV+DjWupe0m
 WY9bRWIAHY9mv2Pal/wkW85e20ldv4qFs0OLtSN6GJxOQ==
Received-SPF: pass client-ip=217.182.185.173; envelope-from=groug@kaod.org;
 helo=smtpout4.mo529.mail-out.ovh.net
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 5 Nov 2024 11:25:26 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

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
> ---
>  hw/9pfs/9p.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Wow ! And this is there since pretty much always... I'm amazed how
it went unnoticed for so long :-)

Reviewed-by: Greg Kurz <groug@kaod.org>

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index af636cfb2d..9a291d1b51 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2587,6 +2587,11 @@ static void coroutine_fn v9fs_readdir(void *opaque)
>          retval = -EINVAL;
>          goto out_nofid;
>      }
> +    if (fidp->fid_type != P9_FID_DIR) {
> +        warn_report_once("9p: bad client: T_readdir on non-directory stream");
> +        retval = -ENOTDIR;
> +        goto out;
> +    }
>      if (!fidp->fs.dir.stream) {
>          retval = -EINVAL;
>          goto out;



-- 
Greg

