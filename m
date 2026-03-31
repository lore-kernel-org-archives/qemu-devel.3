Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39B3FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Sn9-0002T0-VC; Tue, 31 Mar 2026 02:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7Sn8-0002So-7z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7Sn2-00076q-1I
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774939285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DghDs9ZVoH8DRSSlcF6wj1wIRFTJzBU/x5DSrtI1xk=;
 b=VB3GTHuSy9H296uYHBjwoHDxNaO31Cox7Kf8pj0j/a/jcw1Jm1cl8wEPMWrdFmMbwIdmLu
 sO5BEnP5DC25o9Db4kORqp9LCtxTr7+t3e4dP94HaC0m5GqFh5x6XRDeFoARFoVtf/RF4t
 7k4DOcYYUMXLWp1GNF2AYwqcmKGrGQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-mASYUSaSOEm9kmiZ5lQR0A-1; Tue,
 31 Mar 2026 02:41:23 -0400
X-MC-Unique: mASYUSaSOEm9kmiZ5lQR0A-1
X-Mimecast-MFC-AGG-ID: mASYUSaSOEm9kmiZ5lQR0A_1774939282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87A1D18005B3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:41:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1367E1954102; Tue, 31 Mar 2026 06:41:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B0AC818000A2; Tue, 31 Mar 2026 08:41:19 +0200 (CEST)
Date: Tue, 31 Mar 2026 08:41:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 2/3] igvm: fix memory leak on failed memory region init
Message-ID: <actsWgsnHAuQ2lf9@sirius.home.kraxel.org>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
 <F98D82E4-5C4B-4A36-A386-1B2FF91034DD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F98D82E4-5C4B-4A36-A386-1B2FF91034DD@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 31, 2026 at 11:45:55AM +0530, Ani Sinha wrote:
> 
> 
> > On 30 Mar 2026, at 6:13 PM, Luigi Leonardi <leonardi@redhat.com> wrote:
> > 
> > When memory_region_init_* fail, `igvm_pages` is not freed causing a leak.
> > 
> > Free `igvm_pages` in the error path.
> > 
> > Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
> > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > ---
> > backends/igvm.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/backends/igvm.c b/backends/igvm.c
> > index 50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f..c347d0c17e7ee744e450d42e677946abad8a7211 100644
> > --- a/backends/igvm.c
> > +++ b/backends/igvm.c
> > @@ -216,11 +216,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
> >             ctx->machine_state->cgs->require_guest_memfd) {
> >             if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> >                                                     region_name, size, errp)) {
> > +                g_free(igvm_pages);
> 
> Why not use g_autofree? That way you do not need to explicitly free it.

autofree does not work because it must be freed in the error case only.

take care,
  Gerd


