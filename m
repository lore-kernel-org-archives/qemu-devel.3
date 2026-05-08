Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E1FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMlW-0000aR-92; Fri, 08 May 2026 11:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLMlV-0000aG-M0
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLMlT-0007ZM-TY
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778252719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OoFnjAHhowIO6m6LzIzKL+ZWdYdORr4ETUx9xbtF6I=;
 b=RGXuw27d4XZ9fg8ttfztgzChPW6t0XiFsQJkoc+Az79qQYJhdtt4uX8sl5zNPmtt33Ig/D
 hiBF7zLhB0Huo1SKybw/1Pf61R7rCReRInGSPu5wz42vGfmjEUyc4bg/lJaEtYlh5MvS0c
 /2iUqlFj0DTlaxP6U55MskpfHH4uAZQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-MSBgGx2lOsCmfx2j_t0TaA-1; Fri,
 08 May 2026 11:05:14 -0400
X-MC-Unique: MSBgGx2lOsCmfx2j_t0TaA-1
X-Mimecast-MFC-AGG-ID: MSBgGx2lOsCmfx2j_t0TaA_1778252707
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDE7819560B8; Fri,  8 May 2026 15:05:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D211803A8E; Fri,  8 May 2026 15:05:03 +0000 (UTC)
Date: Fri, 8 May 2026 16:05:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Levon <john.levon@nutanix.com>, Jag Raman <jag.raman@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "clg@redhat.com" <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af37nA6d8Jdysn2I@redhat.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <CAFEAcA_sQahkspZ15NP0Hmw9AedH1pHUv__YL_ww3UtmX=LPDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_sQahkspZ15NP0Hmw9AedH1pHUv__YL_ww3UtmX=LPDA@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 08, 2026 at 03:39:35PM +0100, Peter Maydell wrote:
> On Fri, 8 May 2026 at 15:29, John Levon <john.levon@nutanix.com> wrote:
> >
> > On Fri, May 08, 2026 at 02:21:37PM +0000, Jag Raman wrote:
> >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 0a90204ae9..ce2b494086 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4429,7 +4429,7 @@ F: tests/tcg/aarch64/system/semiheap.c
> > >  Multi-process QEMU
> > >  M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > >  M: Jagannathan Raman <jag.raman@oracle.com>
> > > -S: Maintained
> > > +S: Orphan
> > >  F: docs/devel/multi-process.rst
> > >  F: docs/system/multi-process.rst
> > >  F: hw/pci-host/remote.c
> > >
> > > Thanks for the reminder, John!
> >
> > (Just for context, Cédric suggested this after my patch to update the
> > libvfio-user submodule for the compilation issues.)
> >
> > > I’ll send a PR shortly removing parts we are not longer using.
> >
> > QEMU maintainers can correct me, but I'd think it has to go through a
> > deprecation cycle first?
> 
> That's generally correct. Apart from features which are clearly
> unused because they were actually broken without anybody noticing,
> we have a deprecation cycle where we first list the feature
> in deprecated.rst; then it is in the deprecated state for
> that release and the following one, and can be finally
> removed in the one after that.
> 
> However in this case as I understand it the multiprocess
> feature has always been "experimental" (as marked by the
> machine and device names "x-remote", "x-pci-proxy-dev", etc
> having an "x-" prefix). So if we really don't think this is
> likely to be being used by anybody in practice I think the
> experimental state allows us to remove it without waiting.
> Dan, Paolo, what do you think ?

If it was always marked experimental, then we do not need to apply the
deprecation process, though the maintainers can choose to do so at their
discretion.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


