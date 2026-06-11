Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC3BCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjsI-0002ol-7P; Thu, 11 Jun 2026 14:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjsF-0002oT-Va
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjsD-00041F-ON
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781201484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iY3aM3N6Nkk7CYATMfBPG7j0KntZLps6ny1x91imVDw=;
 b=dShxU157SeNDSaEVYz6S6JSc/WuMBqcXwCHZAV/zkwauEyEOzHRNdbi3fsyLwFtEnw6fC6
 YKqVOgetBXpT2laRECwHU37ZthIb+gij6ZrVG35XhGK2X5IHs3aqSBzgt/bbYWlIl+s6Rv
 ccLRBtmt/PwU+KwTC66U7/0L2/lYl+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-SVEtUb07NsezQ-hOSAU1og-1; Thu,
 11 Jun 2026 14:11:21 -0400
X-MC-Unique: SVEtUb07NsezQ-hOSAU1og-1
X-Mimecast-MFC-AGG-ID: SVEtUb07NsezQ-hOSAU1og_1781201480
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBC5F1801302; Thu, 11 Jun 2026 18:11:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77B801800583; Thu, 11 Jun 2026 18:11:16 +0000 (UTC)
Date: Thu, 11 Jun 2026 19:11:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 30/35] tests/functional: add a stress test for monitor
 hot unplug
Message-ID: <air6QMJru-0zq7GZ@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-31-berrange@redhat.com>
 <178112600396.209622.4725663320926497079.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178112600396.209622.4725663320926497079.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 01:13:23AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 10 Jun 2026 13:34:10 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> > index 5d8a159eb00..03087faafc3 100755
> > --- a/tests/functional/generic/test_monitor_hotplug.py
> > +++ b/tests/functional/generic/test_monitor_hotplug.py
> > @@ -163,6 +168,63 @@ def test_events_after_negotiation(self):
> >          qmp.close()
> >          self._remove_monitor()
> >  
> > +    def stress_mon(self, sock):
> > +        async def main():
> > +            qmp = QMPClient('testvm')
> > +            await qmp.connect(sock)
> > +            # Run query-version in a tight loop so that the
> > +            # monitor thread/dispatcher is very busy at the
> > +            # time we try to delete the monitor
> > +            while True:
> > +                try:
> > +                    # A command which returns alot of data to make
> 
> "a lot"
> 
> > [ ... skip 38 lines ... ]
> > +            sock = self._add_monitor()
> > +            print ("# stress cycle %02d/%02d" % (i, repeat))
> > +            stress = threading.Thread(target=self.stress_mon, args=[sock])
> > +            stress.start()
> > +            # Sleep upto 1/2 second to vary the races
> > +            time.sleep(random.random() / 0.5)
> 
> * 0.5 or / 2  for the intended sleep

Opps, /facepalm.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


