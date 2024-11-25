Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B046D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUjb-0007p2-5N; Mon, 25 Nov 2024 03:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUjV-0007oe-Vc
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:46:14 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUjR-0005IB-LB
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:46:12 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.25.74])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XxfS63gwPz11N5;
 Mon, 25 Nov 2024 08:45:58 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 09:45:57 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00144160b35-88a5-42e5-b03f-80c14b10ddee,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 09:45:54 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
Message-ID: <20241125094554.5e1b17ba@bahia>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: f5a9815a-bf58-4067-818a-9a0329f8a8ec
X-Ovh-Tracer-Id: 4126986110409152989
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhffeuvdegkedugeehvedtkeehheevfeefteeuveehfeetgeevtddtgefhfefhffenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeipdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=NsO8LsFnHvGX6BBMMKoGValeVIH2r7vN9LkJTXzg3zY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732524358; v=1;
 b=BDgEmPL8/GZ/K1/Tnn/T2s1TJ6XUawVSJf2P8NYqbRmhq/sRkiBWteAtoASmChNdFEGfjQSI
 g6HiOj/Od98UnNfin3OHuelsJ4BlPCMba0sbkLLfC0PH0qogvqrsGNbvtMrNrTOj9ynFX0jakMk
 skdUfVO9r3/uNmrRcv9VH2xEm+vAq+pCgEXLqbRBEq0oHsan8psNJS8NPmBqQ8Z689jWWQ51Gfi
 8k9qrIkvq5VXmQMF8grL8vdHf2JezUFKpwXDfNfrgbfNuiiL2zvcWhNTTyQzIA39oJaYMlaK442
 JFQrdFT7LA8fSwt1B2pnEWepiR02k/RVYVx4FM6dWytPw==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Sun, 24 Nov 2024 17:28:40 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This fixes an infamous, long standing bug:
> https://gitlab.com/qemu-project/qemu/-/issues/103
> 

\o/

It is great if you manage to fix that once and far all !

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
> 

When I last worked on that issue I had spotted some other places to fix.

Maybe you can find some ideas for future work at :

https://github.com/gkurz/qemu/tree/9p-attr-fixes

> Simple test app to verify this behaviour on a Linux guest:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <unistd.h>
> #include <fcntl.h>
> 
> int main() {
>   struct stat st;
>   int fd = open("doa-file", O_RDWR | O_CREAT | O_EXCL, 0600);
>   unlink("doa-file");
>   int res = fstat(fd, &st);
>   printf("fstat() = %d\n", res);
>   return res;
> }
> 
> Christian Schoenebeck (6):
>   tests/9p: add 'use-after-unlink' test
>   tests/9p: fix Rreaddir response name
>   tests/9p: add missing Rgetattr response name
>   9pfs: remove obsolete comment in v9fs_getattr()
>   9pfs: fix 'Tgetattr' after unlink
>   tests/9p: also check 'Tgetattr' in 'use-after-unlink' test
> 
>  hw/9pfs/9p.c                          | 12 ++++---
>  tests/qtest/libqos/virtio-9p-client.c |  3 +-
>  tests/qtest/virtio-9p-test.c          | 46 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 6 deletions(-)
> 

Cheers,

-- 
Greg

