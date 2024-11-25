Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732B6D58067
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXND-0006NJ-Kz; Mon, 25 Nov 2024 06:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFXN7-0006JN-Fj
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:35:18 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFXN3-0003zG-Ls
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:35:17 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.2.162])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XxkCK1MXvzyb7;
 Mon, 25 Nov 2024 11:35:09 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 12:35:08 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004ecf68c51-6fd7-4511-9918-cbd6166b82b3,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 12:35:05 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/6] 9pfs: fix fstat() after unlink() (with a Linux guest)
Message-ID: <20241125123505.06ab0568@bahia>
In-Reply-To: <192504804.CgdclvVjum@silver>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <20241125094554.5e1b17ba@bahia> <192504804.CgdclvVjum@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: fb02b864-27a6-4b39-b871-7265fe3c2330
X-Ovh-Tracer-Id: 6984238597570337245
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfffuedvgeekudegheevtdekheehveeffeetueevheefteegvedttdeghfefhfffnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=HfU8Yww8hGX8I9O7l/9Jtuy7OirpsAnG7B+gCgsB6eU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732534509; v=1;
 b=BKcM7NZ2PLIZEWjQSd47b3vBkKtH/F8j2CCYfLr5350ZH6Bp6GTy0g11McivYhF+o11XMo5g
 FLPMysxDBAfzVne4/xnd0TG0o5fGkOce+NC+SJRJuXqDezWdIezqFloU1zTj1Uy6bashl+VYuDY
 vsobX+ri0Xczy5fqucf3iV2Y5QTcb/wmFTIWr8PVHWm+2Xq41icQAktIfoo+WLpdW39uw3zGrst
 B/yKcxpp8pW+7zIbYEDwhp486zT5/YTzg08FkHOCNrp0A6kvKxxmY9o+YXq+biovhXWzk9Thkfa
 /s7i1wOc+0msLdtD2ExM5K06w9vFb/SM+1GaEKTaPIhvg==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 25 Nov 2024 11:23:39 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Monday, November 25, 2024 9:45:54 AM CET Greg Kurz wrote:
> > On Sun, 24 Nov 2024 17:28:40 +0100
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > 
> > > This fixes an infamous, long standing bug:
> > > https://gitlab.com/qemu-project/qemu/-/issues/103
> > > 
> > 
> > \o/
> > 
> > It is great if you manage to fix that once and far all !
> > 
> > > * Actual fix of this bug is patch 5.
> > > 
> > > * Patches 1 and 6 add a test case to verify the expected behaviour.
> > > 
> > > * The other patches (2, 3, 4) are basically just minor cleanup patches more
> > >   or less (un)related that I simply did not bother to send separately.
> > > 
> > > Probably there are still other 9p request types that should be fixed for this
> > > use-after-unlink idiom, but this series fixes the mentioned bug report as
> > > described by reporter, so fair enough to round this up here for now.
> > > 
> > 
> > When I last worked on that issue I had spotted some other places to fix.
> > 
> > Maybe you can find some ideas for future work at :
> > 
> > https://github.com/gkurz/qemu/tree/9p-attr-fixes
> 
> Was there a reason why you left those patches on the attic?
> 

Lack of cycles

> What I am seeing is that it was not fixing Tgetattr (i.e. fstat() on guest),
> so it wouldn't have fixed the original reporter's scenario, but they would
> have brought things forward. So just wondering ...
> 

Yeah the fix for Tgetattr was in some other series I had sent at the time but
I did not get much feeback then...

> /Christian
> 
> 

Cheers,

-- 
Greg

