Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1668CE83EF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 09:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnYrK-0007Uh-Vm; Wed, 04 Feb 2026 04:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnYrK-0007UN-0c
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:07:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vnYrI-0007ef-2A
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 04:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770196054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAtUhEcCKZZszsfB8dyIiFJl10MlToo1zx3SL/WPXHo=;
 b=D1o5Q4sV0i2+qLbioMGkiHAUhHO/08UebGFMzGsNz9AwZEGBF4RdDSn0HpKG5KN62d3n2r
 uKAlIjgxmNB7VcRSeaRxCeKNjxEHyAPWvDmoveL7lMFngnDXi2q3oK1gAMh5MfbH9PdTu7
 pyf/A9yWJpfiTOaOB7HZdHu47oyV98Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-pUijXyVPNTSryFLK57qKog-1; Wed,
 04 Feb 2026 04:07:31 -0500
X-MC-Unique: pUijXyVPNTSryFLK57qKog-1
X-Mimecast-MFC-AGG-ID: pUijXyVPNTSryFLK57qKog_1770196049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4682F1956064; Wed,  4 Feb 2026 09:07:29 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.80])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 084BB1955D85; Wed,  4 Feb 2026 09:07:21 +0000 (UTC)
Date: Wed, 4 Feb 2026 09:07:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: Modern HMP
Message-ID: <aYMMRuWGYe96rpZZ@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org> <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de> <aXJJkd8g0AGZ3EVv@redhat.com>
 <aX-boauFX2Ju7x8Z@gallifrey> <875x8d0w32.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x8d0w32.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 04, 2026 at 09:08:49AM +0100, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> >> On Thu, Jan 22, 2026 at 12:47:47PM -0300, Fabiano Rosas wrote:
> >> > One question I have is what exactly gets (eventually) removed from QEMU
> >> > and what benefits we expect from it. Is it the entire "manual"
> >> > interaction that's undesirable? Or just that to maintain HMP there is a
> >> > certain amount of duplication? Or even the less-than-perfect
> >> > readline/completion aspects?
> >> 
> >> Over time we've been gradually separating our human targetted code from
> >> our machine targetted code, whether that's command line argument parsing,
> >> or monitor parsing. Maintaining two ways todo the same thing is always
> >> going to be a maint burden, and in QEMU it has been especially burdensome
> >> as they were parallel impls in many cases, rather than one being exclusively
> >> built on top of the other.
> >> 
> >> Even today we still get contributors sending patches which only impl
> >> HMP code and not QMP code. Separating HMP fully from QMP so that it
> >> was mandatory to create QMP first gets contributors going down the
> >> right path, and should reduce the burden on maint.
> >
> > Having a separate HMP isn't a bad idea - but it does need some idea of
> > how to make it easy for contributors to add stuff that's just for debug
> > or for the dev.   For HMP the bar is very low; if it's useful to the
> > dev, why not (unless it's copying something that's already in the QMP interface
> > in a different way);  but although the x- stuff in theory lets
> > you add something via QMP, in practice it's quite hard to get it through
> > review without a lot of QMP design bikeshedding.
> 
> I think this description has become less accurate than it used to be :)
> 
> A long time ago, we started with "QMP is a stable, structured interface
> for machines, HMP is a plain text interface for humans, and layered on
> top of QMP."  Layered on top means HMP commands wrap around QMP
> commands.  Ensures that QMP is obviously complete.  Without such a
> layering, we'd have to verify completeness by inspection.  Impractical
> given the size and complexity of the interfaces involved.
> 
> Trouble is there are things in HMP that make no sense in QMP.  For
> instance, HMP command 'cpu' sets the monitor's default CPU, which
> certain HMP commands use.  To wrap 'cpu' around a QMP command, we'd have
> to drag the concept "default CPU" into QMP where it's not wanted.

Surely the isolated HMP monitor code can just keep track of its view
of a "default" CPU, and then pass an explicit CPU to the QMP commands
it runs ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


