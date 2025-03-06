Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB239C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5p8-0006it-Az; Thu, 06 Mar 2025 02:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tq5p6-0006fb-LC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:39:16 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tq5p2-0003qa-EW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:39:15 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.25.119])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4Z7hBD4FVxz11WG;
 Thu,  6 Mar 2025 07:39:00 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 6 Mar
 2025 08:39:00 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006f5307a90-e618-4cd4-bcb3-6c33c31b3af0,
 37C52C01EA5DF959F069A379DC9FDBD07502A922) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 6 Mar 2025 08:38:58 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 1/2] 9pfs: fix concurrent v9fs_reclaim_fd() calls
Message-ID: <20250306083858.743ed47c@bahia>
In-Reply-To: <3429da65ff753b47654b7ae26607417c571a7cb1.1741101468.git.qemu_oss@crudebyte.com>
References: <cover.1741101468.git.qemu_oss@crudebyte.com>
 <3429da65ff753b47654b7ae26607417c571a7cb1.1741101468.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 2efe248b-75cd-4f6e-b70b-e318389db089
X-Ovh-Tracer-Id: 5842294620309789149
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrudduvddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=O1r1EjK1sIu6spFQTbTww1f7U49tOyGNQS8WV97Ts3s=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741246740; v=1;
 b=K/QYYiyNwuoH417tnu1BImb+q0jxWhvbmVGnOk2UcbOl777UW/1PHyQJEBjsml0KYGvGk/y4
 dmGoEVlid0j39nVbDW67IMJjos7me8bu/1rTN4nSo5gBGBpbebYozT7hducglYacqa/F2RKjdTM
 TeN8bKC452LDW9qBkUxPS0xuEW8oxLwqR2PYpBrmRjv9rEp3OY8fpomqHRRXD7Nt1ZizHo/Ilo4
 UMT6vGz982Gjf/4z8G95ICrgErbripzHxjIzG4Gzv+CuG/Dd/xxe8sMdtOuZO+Lk5SuJMFrVRru
 oCnSDcGCckYXVFLYxWe0lzTndLZ9mtbQHDTc2kWg5O0jw==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=groug@kaod.org;
 helo=8.mo548.mail-out.ovh.net
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

Hi Christian !

On Tue, 4 Mar 2025 16:15:57 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Even though this function is serialized to be always called from main
> thread, v9fs_reclaim_fd() is dispatching the coroutine to a worker thread
> in between via its v9fs_co_*() calls, hence leading to the situation where
> v9fs_reclaim_fd() is effectively executed multiple times simultaniously,
> which renders its LRU algorithm useless and causes high latency.
> 
> Fix this by adding a simple boolean variable to ensure this function is
> only called once at a time. No synchronization needed for this boolean
> variable as this function is only entered and returned on main thread.
> 
> Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Another long long standing bug bites the dust ! Good catch !

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 10 ++++++++++
>  hw/9pfs/9p.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7cad2bce62..4f9c2dde9c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -435,6 +435,12 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      GHashTableIter iter;
>      gpointer fid;
>  
> +    /* prevent multiple coroutines running this function simultaniously */
> +    if (s->reclaiming) {
> +        return;
> +    }
> +    s->reclaiming = true;
> +
>      g_hash_table_iter_init(&iter, s->fids);
>  
>      QSLIST_HEAD(, V9fsFidState) reclaim_list =
> @@ -510,6 +516,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>           */
>          put_fid(pdu, f);
>      }
> +
> +    s->reclaiming = false;
>  }
>  
>  /*
> @@ -4324,6 +4332,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>      s->ctx.fst = &fse->fst;
>      fsdev_throttle_init(s->ctx.fst);
>  
> +    s->reclaiming = false;
> +
>      rc = 0;
>  out:
>      if (rc) {
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 5e041e1f60..259ad32ed1 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -362,6 +362,7 @@ struct V9fsState {
>      uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
>      uint16_t qp_affix_next;
>      uint64_t qp_fullpath_next;
> +    bool reclaiming;
>  };
>  
>  /* 9p2000.L open flags */



-- 
Greg

