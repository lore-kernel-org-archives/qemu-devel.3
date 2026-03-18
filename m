Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A37A10775E7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2uEF-0002eb-6s; Wed, 18 Mar 2026 12:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2uEC-0002cR-Sp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w2uEA-0000rx-Rd
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 12:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773853118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF+W7Q1FPVM8eF/BO26ApBMvg7uNOHbrVev761rVyUM=;
 b=blRLsBhAJywk+czdIM6dHMSPDRR3scIQl0IVgkdbNRfwro0wXUNkp7KgzB3/aI+CyQAZyx
 VgUYLMxxD4tBlJ9sAD2fkEbRUbUTD/EL34c4eSEqU9yBBdUC+4GvMnr2q79mK4JjnJidVw
 /ioyXSEPAmpvLSHD4XfDSsArAylCfVQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-sEI-Us4cM8mCCX4c1DeQUQ-1; Wed,
 18 Mar 2026 12:58:34 -0400
X-MC-Unique: sEI-Us4cM8mCCX4c1DeQUQ-1
X-Mimecast-MFC-AGG-ID: sEI-Us4cM8mCCX4c1DeQUQ_1773853111
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8A7B180060D; Wed, 18 Mar 2026 16:58:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.194])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE8F930001A1; Wed, 18 Mar 2026 16:58:28 +0000 (UTC)
Date: Wed, 18 Mar 2026 16:58:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pedro Falcato <pfalcato@suse.de>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
Message-ID: <abrZsaFWDwnbWbKL@redhat.com>
References: <20260318162951.1060969-1-pfalcato@suse.de>
 <abrY1aC1RjG7P2GR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abrY1aC1RjG7P2GR@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 18, 2026 at 04:54:45PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 18, 2026 at 04:29:51PM +0000, Pedro Falcato wrote:
> > According to the ATA Command Set specification (and the SATA specification
> > too), SATA drives are supposed to set word 93 (which for PATA holds hardware
> > reset results) to 0. As such, clear it when ncq_queues > 0 (which is only true
> > for SATA drives).
> > 
> > Doing so fixes a quirk in Linux where it thinks the AHCI QEMU drive is PATA
> > over a SATA bridge, and thus limits maximum transfer sizes for individual IOs
> > with a:
> > [    1.632121] ata1.00: applying bridge limits
> > 
> > While at it, bump the device's firmware revision for IDENTIFY. This makes it
> > so Linux can avoid enabling a quirk for fixed QEMU releases.
> > 
> > Link: https://lore.kernel.org/linux-ide/20260303183337.1013474-1-pfalcato@suse.de/
> > Cc: qemu-stable@nongnu.org
> > Suggsted-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > ---
> > Note: I understand the version bump is vaguely controversial (particularly
> >  exposing the QEMU version in the string) but I don't have a much better
> >  idea. Logically, bumping it to 11.0 for stable releases doesn't make much
> >  sense.
> 
> Bumping the version string changes guest ABI, so such a change should
> normally be tied to a new machine type version, not unconditionally
> changed.  That would also in turn make it unsuitable for QEMU stable
> release branches which don't take changes which affect machine type
> ABI.
> 
> IMHO Linux should just assume any actively maintained distro that
> cares about this problem will fix their QEMU releases and not try
> to add a version specific workaround.

Having said that, possibly the functional fix itself might need to
be tied to the machine type too, given that it is triggering a
behavioural change in the emulation and guest driver ? If that's
the case, then the version could be changed at the same time.

> 
> >  hw/ide/core.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index b45abf067b20..89f62f301e94 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -211,7 +211,15 @@ static void ide_identify(IDEState *s)
> >          put_le16(p + 87, (1 << 14) | 0);
> >      }
> >      put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
> > -    put_le16(p + 93, 1 | (1 << 14) | 0x2000);
> > +    if (s->ncq_queues) {
> > +        /*
> > +         * This is SATA, which is required by the spec to return 0 for this
> > +         * field.
> > +         */
> > +        put_le16(p + 93, 0);
> > +    } else {
> > +        put_le16(p + 93, 1 | (1 << 14) | 0x2000);
> > +    }
> >      /* *(p + 100) := nb_sectors       -- see ide_identify_size */
> >      /* *(p + 101) := nb_sectors >> 16 -- see ide_identify_size */
> >      /* *(p + 102) := nb_sectors >> 32 -- see ide_identify_size */
> > @@ -2660,7 +2668,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
> >      if (dev->version) {
> >          pstrcpy(s->version, sizeof(s->version), dev->version);
> >      } else {
> > -        pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
> > +        pstrcpy(s->version, sizeof(s->version), "11.0");
> >      }
> >  
> >      ide_reset(s);
> > -- 
> > 2.53.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


