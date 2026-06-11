Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE1BCD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjzM-0004jX-8t; Thu, 11 Jun 2026 14:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjzL-0004ih-Cv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXjzJ-0001BH-Kd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781201924;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSnr4ghLlpQTuqmrvth0k+rEuACL6irXxJ+fyFfL5kQ=;
 b=VRKbXEjYRYRTVGoqcGkum8Mx3noivNETg8sry7dj0UXTbBS/SH1+wKgh7H9vN2BrP7EY4W
 Z1/o7ixTF+tDDVIzCcaV15sUoqbzOkhk/N0tOXkMSSnP2lCfIqNTDCl1mdjTaxxwyR3a/A
 FnJATzqMFXR4tRBaeh85qc+dO6mhHME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-LYTgURqUNLqohqv6uIiz8Q-1; Thu,
 11 Jun 2026 14:18:41 -0400
X-MC-Unique: LYTgURqUNLqohqv6uIiz8Q-1
X-Mimecast-MFC-AGG-ID: LYTgURqUNLqohqv6uIiz8Q_1781201919
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11A9919560BE; Thu, 11 Jun 2026 18:18:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88D10180057F; Thu, 11 Jun 2026 18:18:34 +0000 (UTC)
Date: Thu, 11 Jun 2026 19:18:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 33/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <air792IafAOVAC7L@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-34-berrange@redhat.com>
 <178112600406.209622.17677163019319157418.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178112600406.209622.17677163019319157418.b4-review@b4>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 11, 2026 at 01:13:24AM +0400, marcandre.lureau@redhat.com wrote:
> On Wed, 10 Jun 2026 13:34:13 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
> > index 03087faafc3..f7d72a77c2e 100755
> > --- a/tests/functional/generic/test_monitor_hotplug.py
> > +++ b/tests/functional/generic/test_monitor_hotplug.py
> > @@ -118,6 +124,45 @@ def test_self_removal(self):
> > [ ... skip 30 lines ... ]
> > +        for i in range(10):
> > +            cdevs = [c["label"] for c in self.vm.cmd('query-chardev')]
> > +            if 'hotplug-chr' not in cdevs:
> > +                break
> > +            # Sleep upto 1/2 second to vary the races
> > +            time.sleep(random.random() / 0.5)
> 
> /2 or *0.5

Looking again, this one doesn't need to be random. We just need a
fixed short sleep waiting for the chardev to go away.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


