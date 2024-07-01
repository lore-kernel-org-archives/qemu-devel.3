Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1BC30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGqj-00060R-9o; Mon, 01 Jul 2024 09:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6682a742.v1-3817fa9c32484dec8c19c638b7468323@bounce.vates.tech>)
 id 1sOGqf-000605-5V
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:13:37 -0400
Received: from mail145-25.atl61.mandrillapp.com ([198.2.145.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6682a742.v1-3817fa9c32484dec8c19c638b7468323@bounce.vates.tech>)
 id 1sOGqc-0006Br-QH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1719838530; x=1720099030;
 bh=VpP23dnSGMr3v2CEKMNAe5zKPZgSu5ZxiHq/Xs24dYc=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=Ny83Y58m6oWh5I6f3VeENNyv3VxXEXSW24lNptMduvW4qTVrjEA/fxVJNto/58P/S
 mQaIkHgH06OJNaPo4/6v1wWBj4bNSByv1fpFQWLVo2LzMgy57fk2kjep3dJlMnknct
 /PnGSu1kSfY8s32Z5OctqjPRuNry9mlbWy3trEjZsqaCsfO3l0MHiaGIrQvnqW9OK7
 QY3E3+6Nq/5Es8I4meZCQfxwQxsuWpBxXO0g/E5PA64n0F8WdZ6BjyWK+XNfK7Cfxb
 ttJeyuXLAYTk0ShXDWsTHibrngnb9fK09YQk9i+MDIpbBeW1KlfLdu/+fnRo/6MNg7
 4QpPL187QVfyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1719838530; x=1720099030; i=anthony.perard@vates.tech;
 bh=VpP23dnSGMr3v2CEKMNAe5zKPZgSu5ZxiHq/Xs24dYc=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=crfnrwXanFZzzSdUZuH07VYdfXSaI4knD3yJ8OMVtpslUNeomgrJHcvlWhezwlGj8
 4NywvViCMP86r7o/pJcasi8uB2o/+S1ZWBqDlCJtSaSrFHG+gebNeZf+ZI3mwn3gfH
 GRKp9t/INgxMMBCooj3Schu9RP3mg4m49kaslan72HRXHIKMFAu+4LAYql1J4G2jxG
 zAtuyk7+r68Aj+Ian56o0soN8laHSLB6bWd6SsKD15O8nUj8snCdYjmctXHMYiFB2P
 5RZBXRlddaOsRhFXIIdMzJIMfW+4lP0AZkoM0FQ4eeJgf+SFaVWe0KHGOs3WVi5umz
 GZtBHi5ZK7gSQ==
Received: from pmta06.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail145-25.atl61.mandrillapp.com (Mailchimp) with ESMTP id
 4WCQxt56z6z35hZM5
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2024 12:55:30 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v8=202/8]=20xen:=20mapcache:=20Unmap=20first=20entries=20in=20buckets?=
Received: from [37.26.189.201] by mandrillapp.com id
 3817fa9c32484dec8c19c638b7468323; Mon, 01 Jul 2024 12:55:30 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1719838529271
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Message-Id: <ZoKnQLBwIwh004yy@l14>
References: <20240529140739.1387692-1-edgar.iglesias@gmail.com>
 <20240529140739.1387692-3-edgar.iglesias@gmail.com>
In-Reply-To: <20240529140739.1387692-3-edgar.iglesias@gmail.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.3817fa9c32484dec8c19c638b7468323?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240701:md
Date: Mon, 01 Jul 2024 12:55:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.145.25;
 envelope-from=bounce-md_30504962.6682a742.v1-3817fa9c32484dec8c19c638b7468323@bounce.vates.tech;
 helo=mail145-25.atl61.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi all,

Following this commit, a test which install Debian in a guest with OVMF
as firmware started to fail. QEMU exit with an error when GRUB is
running on the freshly installed Debian (I don't know if GRUB is
starting Linux or not).
The error is:
    Bad ram offset ffffffffffffffff

Some logs:
http://logs.test-lab.xenproject.org/osstest/logs/186611/test-amd64-amd64-xl-qemuu-ovmf-amd64/info.html

Any idea? Something is trying to do something with the address "-1" when
it shouldn't?

Cheers,

Anthony

On Wed, May 29, 2024 at 04:07:33PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> When invalidating memory ranges, if we happen to hit the first
> entry in a bucket we were never unmapping it. This was harmless
> for foreign mappings but now that we're looking to reuse the
> mapcache for transient grant mappings, we must unmap entries
> when invalidated.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  hw/xen/xen-mapcache.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index bc860f4373..ec95445696 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -491,18 +491,23 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>          return;
>      }
>      entry->lock--;
> -    if (entry->lock > 0 || pentry == NULL) {
> +    if (entry->lock > 0) {
>          return;
>      }
>  
> -    pentry->next = entry->next;
>      ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
>      if (munmap(entry->vaddr_base, entry->size) != 0) {
>          perror("unmap fails");
>          exit(-1);
>      }
> +
>      g_free(entry->valid_mapping);
> -    g_free(entry);
> +    if (pentry) {
> +        pentry->next = entry->next;
> +        g_free(entry);
> +    } else {
> +        memset(entry, 0, sizeof *entry);
> +    }
>  }
>  
>  typedef struct XenMapCacheData {
> -- 
> 2.40.1
> 
> 
-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

