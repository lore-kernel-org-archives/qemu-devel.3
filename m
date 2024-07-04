Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742D7C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNdM-0006zg-1T; Thu, 04 Jul 2024 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6686b06d.v1-2707964c5a064c0a8508aaceb07a50dd@bounce.vates.tech>)
 id 1sPNdJ-0006zQ-82
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:40:25 -0400
Received: from mail186-1.suw21.mandrillapp.com ([198.2.186.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6686b06d.v1-2707964c5a064c0a8508aaceb07a50dd@bounce.vates.tech>)
 id 1sPNdH-00074m-HU
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1720103021; x=1720363521;
 bh=Y8SexkBRBt7YwEfELRilHLlo5h8DYOLSv0Svo/E0N60=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=KygdiHlOYa3v+a6qwoVGZDP96JHS0jnjtCuygaTUX9Gxu7RvMRO8F9yLbTl+M9hil
 fTeIWWo/fz2Ow1kqw/FF6oFbK6hXn0RfFW8MZ5nCTQfLQtV+7bsjz8rS+PZMrYizF/
 PGr9y5MRitoxApjhfCgFUoBoVBCv3PqrjKD6kCScASXfHDe9SUB5qaj25SB3guxRUV
 kWkWPHZudNLAVkG4FP2wWf4fU8HCoFuQnpd3k3XGjAeFwJPczxP0knqFHqBkHXPdq1
 I4dvdhbRxli4U91zBG9v4ik/dCyGYgp8+73FAHXKGlmrKwBuaWv9Qr+PgNiBoc1YpO
 Lux/n3ruTtFtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1720103021; x=1720363521; i=anthony.perard@vates.tech;
 bh=Y8SexkBRBt7YwEfELRilHLlo5h8DYOLSv0Svo/E0N60=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=GczBzefL/OH+ljVSeZt928hgYLlZIjylT2YalqBsYQEKcCCgrOzbh2HAi4aT1vR9N
 5upkmX/65T1MSi1tuOcTqZ3ENumFiDd4gUdfzXvNscm8L4mdZyWC8jrx7Ip1W/y0yY
 0xiqniT5eao2HhecBg0mypoxtKg3Rdh357o9sjAcOrU+BWQWNmCmUWyT/8ATBNgi1o
 g/rAj4NGgNlhOkS6eppMNqreK7YRzEeMc4gL9qcvDm2/IXLvlQU/v3mhzrWWyFhZai
 v4yD8ff2axqMt90/6fKN8fGg3HtwsHhIuheDBP0DyhW/2+xKYhZW1EIQ7WpZGnHh/c
 C0OlyrfPVIoMA==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-1.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4WFJmF55W0zBsThVL
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2024 14:23:41 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v1=202/2]=20xen:=20mapcache:=20Fix=20unmapping=20of=20first=20entries=20in=20buckets?=
Received: from [37.26.189.201] by mandrillapp.com id
 2707964c5a064c0a8508aaceb07a50dd; Thu, 04 Jul 2024 14:23:41 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1720103020458
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, paul@xen.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Message-Id: <ZoawbAnukIBkYWCw@l14>
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-3-edgar.iglesias@gmail.com>
In-Reply-To: <20240701224421.1432654-3-edgar.iglesias@gmail.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.2707964c5a064c0a8508aaceb07a50dd?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240704:md
Date: Thu, 04 Jul 2024 14:23:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.1;
 envelope-from=bounce-md_30504962.6686b06d.v1-2707964c5a064c0a8508aaceb07a50dd@bounce.vates.tech;
 helo=mail186-1.suw21.mandrillapp.com
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

On Tue, Jul 02, 2024 at 12:44:21AM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> This fixes the clobbering of the entry->next pointer when
> unmapping the first entry in a bucket of a mapcache.
> 
> Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
> Reported-by: Anthony PERARD <anthony.perard@vates.tech>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/xen/xen-mapcache.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index 5f23b0adbe..18ba7b1d8f 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>          pentry->next = entry->next;
>          g_free(entry);
>      } else {
> -        memset(entry, 0, sizeof *entry);
> +        /*
> +         * Invalidate mapping but keep entry->next pointing to the rest
> +         * of the list.
> +         *
> +         * Note that lock is already zero here, otherwise we don't unmap.
> +         */
> +        entry->paddr_index = 0;
> +        entry->vaddr_base = NULL;
> +        entry->valid_mapping = NULL;
> +        entry->flags = 0;
> +        entry->size = 0;

This kind of feels like mc->entry should be an array of pointer rather
than an array of MapCacheEntry but that seems to work well enough and
not the first time entries are been cleared like that.

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

