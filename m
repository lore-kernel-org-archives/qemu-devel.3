Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3281CC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGsb-0000Fx-I5; Fri, 24 Jul 2026 10:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnGsY-0000C8-I7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnGsW-0007xo-CZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784903273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZnu0Fk6qsH48lVP9kgYEiY6q8J4zd7E5hKp/LfN3qo=;
 b=CPowYEXkUfOXcXgEJAm1lpo8a9OvSdR1vciEnmUEOyS2Sk5xkxRIDsVA7lpw/Ry9rWFM8J
 S1a/g0/14MRugxmJDoq6jMksO9sYTaV8xIg/fIFGbSHqejYRCGVoVNM2V3S2pqfZRhNwFJ
 CgUnRD8anV78udZLNa5ABSCTi07PzcQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-eH5h0mFbPUiz0x8Ujj8h5g-1; Fri,
 24 Jul 2026 10:27:52 -0400
X-MC-Unique: eH5h0mFbPUiz0x8Ujj8h5g-1
X-Mimecast-MFC-AGG-ID: eH5h0mFbPUiz0x8Ujj8h5g_1784903271
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A616518011FD; Fri, 24 Jul 2026 14:27:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 475261800902; Fri, 24 Jul 2026 14:27:47 +0000 (UTC)
Date: Fri, 24 Jul 2026 16:27:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, boy juju <agx1657748706@gmail.com>,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH for-11.1 1/3] dmg: fix out-of-bounds load in
 search_chunk() (CVE-2026-65929)
Message-ID: <amN2YcIgQuUsrFOa@redhat.com>
References: <20260723144519.364701-1-stefanha@redhat.com>
 <20260723144519.364701-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723144519.364701-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 23.07.2026 um 16:45 hat Stefan Hajnoczi geschrieben:
> The binary search in search_chunk() uses s->n_chunks as the (inclusive)
> upper bound. Chunk indices are in the right-open interval [0,
> s->n_chunks) so it is wrong to search all the way up to s->n_chunks
> rather than s->n_chunks - 1.
> 
> The worst case security scenario I can see is convincing a victim to
> hotplug a malicious DMG file to a running guest, potentially causing
> QEMU to crash when loading from memory beyond the end of s->sectors[] or
> s->sectorscounts[]. This could be a denial of service.
> 
> Fixes: CVE-2026-65929
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3844
> Reported-by: boy juju <agx1657748706@gmail.com>
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/dmg.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index 33dcb3a3498..e325127d144 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -609,7 +609,10 @@ static inline int is_sector_in_chunk(BDRVDMGState *s,
>  static inline uint32_t search_chunk(BDRVDMGState *s, uint64_t sector_num)
>  {
>      /* binary search */
> -    uint32_t chunk1 = 0, chunk2 = s->n_chunks, chunk3;
> +    uint32_t chunk1 = 0, chunk2 = s->n_chunks - 1, chunk3;
> +    if (s->n_chunks == 0) {
> +        goto err; /* should never happen */
> +    }
>      while (chunk1 <= chunk2) {
>          chunk3 = (chunk1 + chunk2) / 2;
>          if (s->sectors[chunk3] > sector_num) {

Fair enough to keep the fix minimal here, but is there any justification
for manually implementing binary search instead of using bsearch()? If
not, this could be a follow-up cleanup.

Kevin


