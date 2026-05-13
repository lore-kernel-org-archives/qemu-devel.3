Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E866CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8S1-0000Vw-OF; Wed, 13 May 2026 08:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wN8Ro-0000V7-Ez
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wN8Rl-000157-MZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778674334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dn3AhAasa7MRbx7TXTKGFL3gtpzE7rqvfyxZP6w3A2A=;
 b=fhYr7FNhP8Qtw6yilBkfdeYhOdzk1I5u0NSC9vu+UpMSUkmQpWQ0OhAXtnTcevBGdvYe1/
 3hWJVe31KjWqqikYvMC62I5OPeakHa7FnnLk1w2KCJrByCDPiSNJsFW/Urj3uDmlgmE840
 RlgSuEurMKfFHjrnMvraZOr5S07gGOw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-Pr18zX4LOJ-E1sRustIjSQ-1; Wed,
 13 May 2026 08:12:10 -0400
X-MC-Unique: Pr18zX4LOJ-E1sRustIjSQ-1
X-Mimecast-MFC-AGG-ID: Pr18zX4LOJ-E1sRustIjSQ_1778674329
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7254195608E; Wed, 13 May 2026 12:12:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.129])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BD31800577; Wed, 13 May 2026 12:12:04 +0000 (UTC)
Date: Wed, 13 May 2026 14:12:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, ivy@freebsd.org,
 pbonzini@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] scsi: Fix discard_granularity for -drive if=scsi
Message-ID: <agRqkl5AvXQ-wdu6@redhat.com>
References: <20260410152314.86412-1-kwolf@redhat.com>
 <e0cc7bf4-beca-4b08-bda6-ff2b97942db3@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0cc7bf4-beca-4b08-bda6-ff2b97942db3@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 13.05.2026 um 08:36 hat Michael Tokarev geschrieben:
> On 10.04.2026 18:23, Kevin Wolf wrote:
> > This fixes the default for discard_granularity with -drive if=scsi,
> > which was unintentionally 0 (disable discard) instead of sharing the
> > default with the qdev property used for -device scsi-hd (usually 4096).
> > This was a regression in QEMU 9.0.
> 
> Hi!
> 
> Has this patchset been forgotten, or is it not needed anymore?
> 
> If it's needed, it would be nice if it lands in the master branch
> in the next 10 days, to be included in the next stable series.

I was hoping for review, but I'll include it in my next pull request
either way. (And to be honest, yes, I had forgotten about it, but after
rebasing my local development branch on top of the next pull request, I
would probably have noticed that it's still missing.)

Kevin


