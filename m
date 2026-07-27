Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00C3C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGc3-0007oE-Nz; Mon, 27 Jul 2026 04:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woGc2-0007o3-Ty
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1woGc1-0003m3-7q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785140579;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lOAHrr1Dw2w/S0fTULvS6UvPR8X5P8fRAdv/0dmbxQ=;
 b=P1Gs5tIZeiaACN1dfrKsdJZlDCX/nmuFUCAafA2+Nz9JKmtvPD+1RLKyoaf0kJQaKAJF6C
 sRsz7IeLn+Jtpw2Ko6SHcq5ONfwvH6hAIN1RCl2m+yFMyjnHhdoXt3iaN1qVrOhaL0c1dy
 NfeWtM6YWVHTQRhQadACYkXtX8u857Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-K8_tC54rPRmlHLiiIGIOig-1; Mon,
 27 Jul 2026 04:22:55 -0400
X-MC-Unique: K8_tC54rPRmlHLiiIGIOig-1
X-Mimecast-MFC-AGG-ID: K8_tC54rPRmlHLiiIGIOig_1785140574
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF842180135F; Mon, 27 Jul 2026 08:22:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16673429; Mon, 27 Jul 2026 08:22:50 +0000 (UTC)
Date: Mon, 27 Jul 2026 09:22:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
Message-ID: <amcVV5g4ENihVXpk@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
 <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
 <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
 <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jul 26, 2026 at 09:53:05PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 9:14 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > On 7/26/26 20:07, Marc-André Lureau wrote:
> > ...>> Unfortunately this (additional) fix does not mention the
> > >> previous fix, so there's some confusion about which commit
> > >> actually fixed this issue.  It looks like the first fix was
> > >> incomplete and this additional fix were needed.
> > >
> > > That's correct, we reused the same CVE
> > >
> > > Daniel P. Berrangé said on the issue:
> > > We didn't release master yet. As long as we also didn't release any
> > > stable branches that claimed to fix it, we could re-use it IMHO.
> >
> > Heh.  This is exactly what actually happened - there were
> > 2 stable releases on Jun-25 (v10.0.11 and v11.0.2) which
> > contained the first half.  Now there are 2 more stable
> > releases from Jul-24 which contains the second half.
> >
> > Unfortunately I haven't noticed this duplicated CVE#,
> > or else I'd add a note to the second half in the stable
> > pick-ups.
> >
> > I know you don't like me rushing things to the stable
> > series, and this is an example why this might be bad.
> > Fortunately this is not a regression, at least.  And
> > usually security fixes come in faster anyway.  Ohwell..
> > I'm sorry to disappoint you further.
> 
> for the record, I do appreciate your work, and I make mistake too :)
> Next time I'll check if a release was made already with the CVE#

Or we just declare a strict "never reuse a CVE once a patch is
merged to master" rule.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


