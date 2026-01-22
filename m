Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2B9D3EE89
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vix6x-00032Z-RC; Thu, 22 Jan 2026 11:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vix6r-0002vo-0W
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:00:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vix6o-0001JN-DP
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769097632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jHh0MFWSMKz2Mm8GLTGEiKUH5WEgc8+dxDyDtFMoWFE=;
 b=FOvOnXrQ4dbDjOb1woJNePDJLvybsqnXLooQHMDFIuw/YkHoZnfHb80kRNVdx3xQWVpB0A
 zZGQ5iKzu8baMFK4ZzT8x6BLvDTdRxn6XIdH2rCzMbjmQkwXSEiU0OldlRdt3iSGwUMPr9
 Nvh0vHGyZwZykGFb/0SNNGcOvM0OS/E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-CWeYt54yN8yqA20RDrVH-w-1; Thu,
 22 Jan 2026 11:00:27 -0500
X-MC-Unique: CWeYt54yN8yqA20RDrVH-w-1
X-Mimecast-MFC-AGG-ID: CWeYt54yN8yqA20RDrVH-w_1769097626
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B39F118002CC; Thu, 22 Jan 2026 16:00:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B339918004D8; Thu, 22 Jan 2026 16:00:20 +0000 (UTC)
Date: Thu, 22 Jan 2026 16:00:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,
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
Message-ID: <aXJJkd8g0AGZ3EVv@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org> <aXIWLi656H8VbrPE@redhat.com>
 <87ikctk5ss.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikctk5ss.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 22, 2026 at 12:47:47PM -0300, Fabiano Rosas wrote:
> One question I have is what exactly gets (eventually) removed from QEMU
> and what benefits we expect from it. Is it the entire "manual"
> interaction that's undesirable? Or just that to maintain HMP there is a
> certain amount of duplication? Or even the less-than-perfect
> readline/completion aspects?

Over time we've been gradually separating our human targetted code from
our machine targetted code, whether that's command line argument parsing,
or monitor parsing. Maintaining two ways todo the same thing is always
going to be a maint burden, and in QEMU it has been especially burdensome
as they were parallel impls in many cases, rather than one being exclusively
built on top of the other.

Even today we still get contributors sending patches which only impl
HMP code and not QMP code. Separating HMP fully from QMP so that it
was mandatory to create QMP first gets contributors going down the
right path, and should reduce the burden on maint.

At some point we are likely to introduce a new non-backwards compatible
QEMU binary. Perhaps when Philippe completes his "all targets/machines
in one binary" work. That would be an opportunity to carve HMP off
into a separate out of process facade talking over QMP.

That's only possible though if we get existing HMP into being a layer
over QMP with no backdoor parallel impls. So anything we can do today
to better separate QMP/HMP will give us more flexibility when the time
arrives to create a new QEMU binary without backwards compat cruft.

NB, introducing a new binary does not imply that the old binaries
go away. They would probably stick around for legacy compat for a
good while. For anything using libvirt though, we would be able to
switch to the new binaries pretty fast without, as libvirt can
translate app XML config to either the new or old QEMU dynamically.

> Does the new program becomes basically an external project unrelated to
> QEMU, that simply talks to QMP like libvirt does?

It could be a separate project under QEMU on github, or it could just be
binary in qemu.git. What matters is that it is out of the main QEMU process
eventually.

> I wonder how close to tools like qmp-shell, qmp-tui, etc that would
> become and whether we might actually be looking at a substitute of
> qemu.qmp.

qmp-shell is rather too crude in terms of its data input/output - have
to switch to JSON way too much, and there's no mechanism for formatting
complex QMP replies into pretty human friendly data.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


