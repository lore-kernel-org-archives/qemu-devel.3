Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614F1D41C2C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 12:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTfjg-00036y-Nz; Thu, 11 Dec 2025 07:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTfje-00036Y-Sv
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTfjd-0002uO-Fg
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 07:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765455927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/io9ePCWvclwNV6MNExqM/JG4bMpOq3UaR/Q+cLvog=;
 b=bYU8sAeJn5E66wKvs56LG61uCcLE1NDweQoD1GMFG7cVgCP7GUDjA1ZX1ULnc4ARAZyCA0
 1h09yUzICqGg6lNReQ1HYNjwsPuTc3sGnovYQfGf1qjiAHmyMSh8nOHRvHBch9hSFetqWg
 kLzYbjUkBvCt+QYk4J/ZTJ3LL69Y330=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-C4fm7-9aPQ2PuW5EiOLX1g-1; Thu,
 11 Dec 2025 07:25:24 -0500
X-MC-Unique: C4fm7-9aPQ2PuW5EiOLX1g-1
X-Mimecast-MFC-AGG-ID: C4fm7-9aPQ2PuW5EiOLX1g_1765455923
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 445A41956050; Thu, 11 Dec 2025 12:25:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91DB81956056; Thu, 11 Dec 2025 12:25:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5BAFE1800608; Thu, 11 Dec 2025 13:25:20 +0100 (CET)
Date: Thu, 11 Dec 2025 13:25:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 3/3] igvm: Fill MADT IGVM parameter field
Message-ID: <42cieknma6qfpezpu22jlwlw7yugsyxezkgo6d47fdntpfmmtg@km3ns7xdv4qj>
References: <20251211103136.1578463-1-osteffen@redhat.com>
 <20251211103136.1578463-4-osteffen@redhat.com>
 <h4256m67shwdq4aouxpqadb2zozhq2f5dfeo74c5jnet5f26kz@a3av5xjfyfow>
 <wcqcwrshe6nmz3lb5bz2ucdydwgsfxlxbua5jfaly677zsgy4h@dy3nypkedwhi>
 <CA+bRGFo=bxbKPCkG6cWY9RH501F8NF4yxZk_hu6Vqi6NkFLK_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+bRGFo=bxbKPCkG6cWY9RH501F8NF4yxZk_hu6Vqi6NkFLK_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> > >  (b) pass MachineState instead of ConfidentialGuestSupport, so
> > >      we can use the MachineState here to generate the madt.
> > >
> > >Luigi, any opinion?  I think device tree support will need access to
> > >MachineState too, and I think both madt and dt should take the same
> > >approach here.
> >
> > I have a slight preference over MachineState as it's more generic and we
> > don't need to add more fields in IgvmCfg for new features.
> >
> Passing in MachineState would be easy, but do we really want to add machine
> related logic (building of ACPI tables, and later maybe device trees)
> into the igvm backend?

Good point.  That clearly speaks for (b).  There already is
MachineState->fdt, filled in by machine code.  We can let machine code
store the madt in MachineState too, and the have the igvm code simply
pick it up from there.

take care,
  Gerd


