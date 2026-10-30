Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F867606A33E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjJXIL4j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlVs-0000xr-6W; Fri, 30 Oct 2026 08:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMlVr-0000xS-8m
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xMlVp-0007fA-U6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793362513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmKjCOZQzxDWqcFC47fyckSHz9GbHVBurcW4t4ttodY=;
 b=cjJXIL4jl3WcFo7IaprSinNMhp6O0BGEX5PhDIjMrV3pbef80RCGfMhYkXOFRm+SBdCFKa
 WvKbY132ouN99alIwollfURhsw8sfWe53Z2zxAP8VKhQkMUVpgciFseP4tJiovJX5dLQRV
 58Eav/w9TAOZ3nMHSy1SeBcIRztV1vY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-papJdpZ_PzycoUb2HLb1aw-1; Fri,
 30 Oct 2026 08:15:09 -0400
X-MC-Unique: papJdpZ_PzycoUb2HLb1aw-1
X-Mimecast-MFC-AGG-ID: papJdpZ_PzycoUb2HLb1aw_1793362508
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C4591955BE1; Fri, 30 Oct 2026 12:15:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D3F01800480; Fri, 30 Oct 2026 12:15:03 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ui/vnc: recover a job dropped by vnc_abort_display_jobs()
From: marcandre.lureau@redhat.com
To: Dax Kelson <dkelson@gurulabs.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20261028223204.86741-1-dkelson@gurulabs.com>
References: <20261028223204.86741-1-dkelson@gurulabs.com>
Date: Fri, 30 Oct 2026 16:14:58 +0400
Message-Id: <179336249895.1418662.12044528262600590958.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=933;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oE+/jt1hF/jXyXgX3ZnP12tpiyW3Ij7YsrGNogEqMT8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5IpFU5yuq0l5QiEW4H3OvH/FZJ6AZDsdQZ1s1
 lz58dKGODmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauSKRQAKCRDa6OEJdZac
 5Wp2D/9zzGWNJqHxRjecs92n7UclPLHqmDv6CNBuywOwl/iV0IBqw0JR9VWLbIoEh6jMiE6ik+y
 u6PrCuT721O+jEhjKKy7wzwDNB8pEcPPDOQZ2HeM4t/1A9Ls8vZyW0UOLceG8THQB5ozTU411Hr
 1vGe76YGhvJHMfJZIvwrojQFNJ+Wsz1zq+BsDeWqBSwgt4jp4ljbAnEY2nspRTkLJ5N2dgnM/C2
 wwlduXP9bs8O7VotHHbQtmWMrkmgQg1Zf4gbRsGMMeCjX/BechuY+9krXJSlKb8o3xMhllfdtYw
 bJnh0XHjDFbfmU2B1I0/EOVkXQkLKc7J2824EzH4bNyDyWft5eVhziDZMAmt+GkPwrRBuS7+Mz7
 66sXdHeEZjRXF11ogpdZQwNQcRNOS+8el+TYxzjN7Ia9o2k7vY/IhWhVLCZXeE4APmI3U+X2y7b
 MdtQVpMJAJ5W1XoU6eHwYueys10ro9Hlz4hhCs8kTB8rYbvAEH1stFTeYmQL77JPLNBb6RT7uB5
 bQ56itRr4zq2oAse5iNjdhbGMyB3SPZJeffi+BVL1vwKiC0ZtzHUyoAjKknh+HYlcV6u/XQgiTt
 1orwdtKes+lltz4M2fGQjiMhwaSqe4k+bf8GbLV4D9DgPpNX2vk5pfNqB8UUhqmFexUPyTquSuv
 caozmwVwXEh2zRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 16:32:04 -0600, Dax Kelson <dkelson@gurulabs.com> wrote:
> Fix a race in the VNC server that corrupts a client's display output
> (the client keeps stale pixels because their update is never sent), or
> stops updating a client entirely, when the display surface is switched
> while an update for that client is queued but not yet encoded.
> 
> virtio-gpu guests with a double-buffering compositor (GNOME/mutter on
> Wayland) switch surfaces on every frame, so they hit it in normal use:
> fast scrolling in a terminal leaves scattered 16-pixel slivers of old
> text that stay until the client reconnects. A reproducer (a
> page-flipping virtio-gpu guest plus a VNC/QMP harness) loses updates in
> 35 of 150 four-client cycles on master, and in none with this patch.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


