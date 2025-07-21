Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8E7C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsRP-0008Iu-4u; Mon, 21 Jul 2025 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udsRM-0008GB-Cn
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1udsRK-00088c-7V
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753111706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIYOG6eMK68bbz8MtSCsQjXM3HKWyNXqF8tskWvW3xk=;
 b=bu03ERs55RUkQUTC0sOZwqrOQx6bmqUsI5w4XJ708Dyz7rojhWGkgHoPq4putVw2Qt4a2+
 cf2BgC2G3j4kfeuClZClrODy3kLgdVqgj6bVULRxiMUCzV58P0mDxUshE5KuKnFHn9PqX8
 Nf4hGihgJJBgal4NtH0T30goZjl1JAE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-YmWtZOfWO6S2QZyubJjWtQ-1; Mon,
 21 Jul 2025 11:28:23 -0400
X-MC-Unique: YmWtZOfWO6S2QZyubJjWtQ-1
X-Mimecast-MFC-AGG-ID: YmWtZOfWO6S2QZyubJjWtQ_1753111702
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8F031800365; Mon, 21 Jul 2025 15:28:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B407519560AD; Mon, 21 Jul 2025 15:28:19 +0000 (UTC)
Date: Mon, 21 Jul 2025 16:28:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/4] migration: workaround GNUTLS live migration crashes
Message-ID: <aH5ckDkR_AILCHOm@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
 <871pq9lhiu.fsf@suse.de> <aH5WwXbqF0JzTjnU@redhat.com>
 <87y0shk238.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0shk238.fsf@suse.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GUARANTEED_100_PERCENT=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 21, 2025 at 12:14:51PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Jul 21, 2025 at 11:56:09AM -0300, Fabiano Rosas wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > TL:DR: GNUTLS is liable to crash QEMU when live migration is run
> >> > with TLS enabled and a return path channel is present, if approx
> >> > 64 GB of data is transferred. This is easily triggered in a 16 GB
> >> > VM with 4 CPUs, by running 'stress-ng --vm 4 --vm-bytes 80%' to
> >> > prevent convergance until 64 GB of RAM has been copied. Then
> >> > triggering post-copy switchover, or removing the stress workload
> >> > to allow completion, will crash it.
> >> >
> >> > The only live migration scenario that should avoid this danger
> >> > is multifd, since the high volume data transfers are handled in
> >> > dedicated TCP connections which are unidirectional. The main
> >> > bi-directionl TCP connection is only for co-ordination purposes
> >> >
> >> > This patch implements a workaround that will prevent future QEMU
> >> > versions from triggering the crash.
> >> >
> >> > The only way to avoid the crash with *existing* running QEMU
> >> > processes is to change the TLS cipher priority string to avoid
> >> > use of AES with TLS 1.3. This can be done with the 'priority'
> >> > field in the 'tls-creds-x509' object.eg
> >> >
> >> >   -object tls-creds-x509,id=tls0,priority=NORMAL:-AES-256-GCM:-AES-128-GCM:-AES-128-CCM
> >> >
> >> > which should force the use of CHACHA20-POLY1305 which does not
> >> > require TLS re-keying after 16 million sent records (64 GB of
> >> > migration data).
> >> >
> >> >   https://gitlab.com/qemu-project/qemu/-/issues/1937
> >> >
> >> > On RHEL/Fedora distros you can also use the system wide crypto
> >> > priorities to override this from the migration *target* host
> >> > by creating /etc/crypto-policies/local.d/gnutls-qemu.config
> >> > containing
> >> >
> >> >   QEMU=NONE:+ECDHE-RSA:+ECDHE-ECDSA:+RSA:+DHE-RSA:+GROUP-X25519:+GROUP-X448:+GROUP-SECP256R1:+GROUP-SECP384R1:+GROUP-SECP521R1:+GROUP-FF
> >> >
> >> > and running 'update-crypto-policies'. I recommend the QEMU
> >> > level 'tls-creds-x509' workaround though, which new libvirt
> >> > patches can soon do:
> >> >
> >> >   https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/LX5KMIUFZSP5DPUXKJDFYBZI5TIE3E5N/
> >> >
> >> > Daniel P. Berrangé (4):
> >> >   crypto: implement workaround for GNUTLS thread safety problems
> >> >   io: add support for activating TLS thread safety workaround
> >> >   migration: activate TLS thread safety workaround
> >> >   crypto: add tracing & warning about GNUTLS countermeasures
> >> >
> >> >  crypto/tlssession.c           | 99 +++++++++++++++++++++++++++++++++--
> >> >  crypto/trace-events           |  2 +
> >> >  include/crypto/tlssession.h   | 14 +++++
> >> >  include/io/channel.h          |  1 +
> >> >  io/channel-tls.c              |  5 ++
> >> >  meson.build                   |  9 ++++
> >> >  meson_options.txt             |  2 +
> >> >  migration/tls.c               |  9 ++++
> >> >  scripts/meson-buildoptions.sh |  5 ++
> >> >  9 files changed, 143 insertions(+), 3 deletions(-)
> >> 
> >> Hi, thank you for getting to the bottom of this.
> >> 
> >> Do you think it would be too cumbersome to add a test for this
> >> somewhere? So we don't regress the workaround but also so the test tells
> >> us whether GNUTLS is fixed.
> >
> > The reproducer scenario is very expensive. I'm doing it with a 16 GB RAM
> > guest, with 4 CPUs, running 'stress-ng' guest workload. With that, it
> > takes between 10-20 minutes before live migration gets GNUTLS into the
> > potentially broken state, and the failure is not 100% guaranteed at
> > that point.
> >
> 
> Makes sense. Thanks.
> 
> Will you take the series or should I?

I presume you've already got another migration pull request planned, so
feel free to add this


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


