Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5FFCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbzSV-0007bl-7K; Tue, 23 Jun 2026 07:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzSU-0007b8-0V
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbzSR-0007Sn-SB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782214702;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzpO7j/pd2f3IvZGz/8K5q/pQyb3e5JFNiBmJEVsQCA=;
 b=GordLijzTeLeiWZkGoLwtw9a0uVWeIT8JAdOBN+jhI3R2f4EhXJoas84Pvk6+V+EF5OpUK
 YHcL61xg84XJZDyzSDQ+vGpSjKa8/FFsEMDiRLHJZ+zt+YsZuVbsgE7gX7LTxhvZE6p9pq
 yPopMu3Q2eZMZR2hamDL3k4B7RlvZj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-i8wJaC1GNJ6BdbWkZFXkJQ-1; Tue,
 23 Jun 2026 07:38:19 -0400
X-MC-Unique: i8wJaC1GNJ6BdbWkZFXkJQ-1
X-Mimecast-MFC-AGG-ID: i8wJaC1GNJ6BdbWkZFXkJQ_1782214698
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D39D1955F1B; Tue, 23 Jun 2026 11:38:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8C283189; Tue, 23 Jun 2026 11:38:13 +0000 (UTC)
Date: Tue, 23 Jun 2026 12:38:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/35] monitor: turn QMP and HMP into QOM objects
Message-ID: <ajpwIvZ9qfSgE-la@redhat.com>
References: <20260623095551.2106712-1-berrange@redhat.com>
 <ajpoEoUcQ5IxMJy1@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpoEoUcQ5IxMJy1@angien.pipo.sk>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 23, 2026 at 01:03:46PM +0200, Peter Krempa wrote:
> On Tue, Jun 23, 2026 at 10:55:16 +0100, Daniel P. Berrangé via Devel wrote:
> > Conceptually -object and object_add/object_del should be sufficient
> > for essentially all QEMU configuration....if only we ported all our
> > internal custom backends/devices/etc to QOM. That is of course a big
> > job which is why it hasn't happened.
> > 
> > This series started with the premise that the monitor is one of the
> > easier areas to convert since we have no more than three classes,
> > a common base, and QMP and HMP subclasses[1]. So why not give it a
> > go and thus unlock the ability to dynamically create/delete monitors
> > in QMP/HMP.
> > 
> > This series does the conversion in a great many small steps to better
> > understand the implications at each stage.
> > 
> > The high level outcome of this series is
> > 
> >  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
> >    'monitor-qmp' respectively
> > 
> >  * Both can be cold plugged and hot plugged. QMP only, can
> >    also be hot unplugged.
> > 
> >  * '-mon' is obsolete, deprecated and replaced by '-object',
> >    but -monitor, -qmp and kept  as high level syntax sugar
> 
> I was giving this a spin by implementing libvirt support for it. The
> basic usage seems to work well but I've encoutered a regression in
> behaviour which happens both when the QMP monitor is instantiated using
> the new syntax but also the old one
> ( -mon chardev=charmonitor,id=monitor,mode=control)
> 
> When libvirt wants to re-connect to a qemu running with these patches it
> re-issues a 'qmp_capabilities' command after connecting.
> 
> With these patches qemu does not respond to that command even when the
> old syntax is used. This makes libvirt stuck when re-connecting to VMs.

Oh that's odd, thanks for the warning. I'll investigate this.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


