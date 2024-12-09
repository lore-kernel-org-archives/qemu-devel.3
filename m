Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC8CE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 07:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXqD-0007vn-GU; Mon, 09 Dec 2024 02:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tKXqB-0007vI-86
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 02:05:59 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tKXq7-000659-PC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 02:05:58 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.29])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4Y6CYt14FLz10KB;
 Mon,  9 Dec 2024 07:05:38 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 08:05:37 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006dd347162-a898-4b66-a704-3affb7fa38b4,
 C46C8AFE4D10751A84BD5E2BD3EC9A2F40A63CAD) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 9 Dec 2024 08:05:08 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>, Dirk Herrendorfer
 <d.herrendoerfer@de.ibm.com>, Yanwu Shen <ywsPlz@gmail.com>, Jietao Xiao
 <shawtao1125@gmail.com>, Jinku Li <jkli@xidian.edu.cn>, Wenbo Shen
 <shenwenbo@zju.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] 9pfs: fix regression regarding CVE-2023-2861
Message-ID: <20241209080508.1b2efc51@bahia>
In-Reply-To: <E1tJWbk-007BH4-OB@kylie.crudebyte.com>
References: <E1tJWbk-007BH4-OB@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 6b8519e4-e058-40ec-9498-f347f11798ab
X-Ovh-Tracer-Id: 10863245254871259439
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeelveekveeljedtgfduteehledtkeegvdejtdfgudfhjefgteekjedthfdthfetnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepledprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepugdrhhgvrhhrvghnughovghrfhgvrhesuggvrdhisghmrdgtohhmpdhrtghpthhtohephiifshfrlhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhrgifthgroh
 duuddvheesghhmrghilhdrtghomhdprhgtphhtthhopehjkhhlihesgihiughirghnrdgvughurdgtnhdprhgtphhtthhopehshhgvnhifvghnsghoseiijhhurdgvughurdgtnhdprhgtphhtthhopehmjhhtsehtlhhsrdhmshhkrdhruh
DKIM-Signature: a=rsa-sha256; bh=feO9r5xKRlQzyxBlDED0vb4fa2xll9Ae9S7ABNHzya4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1733727939; v=1;
 b=tc9xRAXEud6mzSu7Q0ch+qiPDyec+KISdlwMBSeKegn+wZM2jM51QQlrQYgHLrwObOj5PNMW
 EZu8qEk55fqDhZUi2fWl9APkcLk6xPP+VNkM2DhjuylITftTUcPNeDMxzRkN/JRcgIjOQWW4OM6
 REbituLQXXsTXVcNhj9EqEF9rQoF1FO26o+aa5jFHLxOYHGcCHtpto9rRk7NdAYoK8i5NIuUrQ1
 asqppSXkbOTszRvvFvvMVTfrcLu+dZF51Z8I3JcIhSN7AcSjvxg0mUhZQqqTzbZH/tfdFfd5Sik
 5acD6l96fwZOU/LQ/iAc9vdFtNPrGsQ2jFi50l6dPd3oA==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 6 Dec 2024 12:20:29 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The released fix for this CVE:
> 
>   f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> 
> caused a regression with security_model=passthrough. When handling a
> 'Tmknod' request there was a side effect that 'Tmknod' request could fail
> as 9p server was trying to adjust permissions:
> 
>   #6  close_if_special_file (fd=30) at ../hw/9pfs/9p-util.h:140
>   #7  openat_file (mode=<optimized out>, flags=2228224,
>       name=<optimized out>, dirfd=<optimized out>) at
>       ../hw/9pfs/9p-util.h:181
>   #8  fchmodat_nofollow (dirfd=dirfd@entry=31,
>       name=name@entry=0x5555577ea6e0 "mysocket", mode=493) at
>       ../hw/9pfs/9p-local.c:360
>   #9  local_set_cred_passthrough (credp=0x7ffbbc4ace10, name=0x5555577ea6e0
>       "mysocket", dirfd=31, fs_ctx=0x55555811f528) at
>       ../hw/9pfs/9p-local.c:457
>   #10 local_mknod (fs_ctx=0x55555811f528, dir_path=<optimized out>,
>       name=0x5555577ea6e0 "mysocket", credp=0x7ffbbc4ace10) at
>       ../hw/9pfs/9p-local.c:702
>   #11 v9fs_co_mknod (pdu=pdu@entry=0x555558121140,
>       fidp=fidp@entry=0x5555574c46c0, name=name@entry=0x7ffbbc4aced0,
>       uid=1000, gid=1000, dev=<optimized out>, mode=49645,
>       stbuf=0x7ffbbc4acef0) at ../hw/9pfs/cofs.c:205
>   #12 v9fs_mknod (opaque=0x555558121140) at ../hw/9pfs/9p.c:3711
> 
> That's because server was opening the special file to adjust permissions,
> however it was using O_PATH and it would have not returned the file
> descriptor to guest. So the call to close_if_special_file() on that branch
> was incorrect.
> 
> Let's lift the restriction introduced by f6b0de53fb8 such that it would
> allow to open special files on host if O_PATH flag is supplied, not only
> for 9p server's own operations as described above, but also for any client
> 'Topen' request.
> 
> It is safe to allow opening special files with O_PATH on host, because
> O_PATH only allows path based operations on the resulting file descriptor
> and prevents I/O such as read() and write() on that file descriptor.
> 
> Fixes: f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2337
> Reported-by: Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-util.h | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 51c94b0116..95ee4da9bd 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -177,20 +177,27 @@ again:
>          return -1;
>      }
>  
> -    if (close_if_special_file(fd) < 0) {
> -        return -1;
> -    }
> -
> -    serrno = errno;
> -    /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
> -     * do that with O_PATH since fcntl(F_SETFL) isn't supported, and openat()
> -     * ignored it anyway.
> -     */
> +    /* Only if O_PATH is not set ... */
>      if (!(flags & O_PATH_9P_UTIL)) {
> +        /*
> +         * Prevent I/O on special files (device files, etc.) on host side,
> +         * however it is safe and required to allow opening them with O_PATH,
> +         * as this is limited to (required) path based operations only.
> +         */
> +        if (close_if_special_file(fd) < 0) {
> +            return -1;
> +        }
> +
> +        serrno = errno;
> +        /*
> +         * O_NONBLOCK was only needed to open the file. Let's drop it. We don't
> +         * do that with O_PATH since fcntl(F_SETFL) isn't supported, and
> +         * openat() ignored it anyway.
> +         */
>          ret = fcntl(fd, F_SETFL, flags);
>          assert(!ret);
> +        errno = serrno;
>      }
> -    errno = serrno;
>      return fd;
>  }
>  



-- 
Greg

