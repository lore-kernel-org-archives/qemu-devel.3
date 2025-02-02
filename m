Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC3C0218A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 02:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tePOE-0002kB-Gd; Sat, 01 Feb 2025 21:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1tePO7-0002jm-Hz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 21:07:08 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1tePO5-0007M2-Qv
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 21:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=K5vJnbvji/kFBCvPvGfDwfWjEaAldxVOAjvaVe+F4QU=; b=G21wQApBt/IEVhnF
 xTUsdi8hnzeBw/1SBYhidHLr0v09PuFCjpWXTStRzqQ/R/bdjHoEp/GfGYXYBLKE97AzIQLb74zia
 aAboR9mJK80itK93yfTWAUMAWG0ZTHTrurZzOVdmX+dkGVY4oCrxrOT6zTRf7Eh74dtfDsgSnqPrH
 NDo7ZwpVejBCFVAYk7XD6mvZzQUwSPos2GthJB4b05+yWdAxWjPGPjAHPXRzriPyO17eihZx0zuLT
 Jh2wr3wy5QcA4dP5MHF5Lq5w+IxdQGAwe0HYJgsFgLzOtM49wCpqoY83b2ZCfI3T7B56abE9gB0p/
 xLrlgleGbx7dYKf1MA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1tePNu-00D63o-2p;
 Sun, 02 Feb 2025 02:06:54 +0000
Date: Sun, 2 Feb 2025 02:06:54 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs
 to take BQL for some calls
Message-ID: <Z57TPqhRYY4V14BE@gallifrey>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 02:03:25 up 269 days, 13:17,  2 users,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> postcopy_ram_listen_thread() is a free running thread, so it needs to
> take BQL around function calls to migration methods requiring BQL.
> 
> qemu_loadvm_state_main() needs BQL held since it ultimately calls
> "load_state" SaveVMHandlers.
> 
> migration_incoming_state_destroy() needs BQL held since it ultimately calls
> "load_cleanup" SaveVMHandlers.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/savevm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b0b74140daea..0ceea9638cc1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * in qemu_file, and thus we must be blocking now.
>       */
>      qemu_file_set_blocking(f, true);
> +    bql_lock();
>      load_res = qemu_loadvm_state_main(f, mis);
> +    bql_unlock();

Doesn't that leave that held for a heck of a long time?
That RAM loading has to happen in parallel with the loading of
devices doesn't it - especially if one of the devices
being loaded touches RAM.

(I wish this series had a description in the cover letter!)

Dave


>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2073,7 +2075,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * (If something broke then qemu will have to exit anyway since it's
>       * got a bad migration state).
>       */
> +    bql_lock();
>      migration_incoming_state_destroy();
> +    bql_unlock();
>  
>      rcu_unregister_thread();
>      mis->have_listen_thread = false;
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

