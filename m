Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B67C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlq4l-0003EC-29; Mon, 20 Jul 2026 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlq4f-0003Az-QS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:38:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wlq4b-0002sG-BK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784561907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpNyVCcyg7wjBS/7EXhxDfPZ+3WhJqSwoySt3urL5k0=;
 b=Zo99iyyoVw6yA1I1Vvy2LphI4D9C7WfrQv2LxQKJ3S7iDFZWG+DYBUmFlBQ5b9MWhmBw1a
 BaEXYbHIfJNFmCdNrcC4454JpUsj9in+dlEYl8/C7ad3FBgYg90Csikl97rz8qnYpjzASq
 xianqnL/7Pui5X/HFcRzq+Z7jtJbemI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-4CFid71dMbm-TJI91Ql38w-1; Mon,
 20 Jul 2026 11:38:24 -0400
X-MC-Unique: 4CFid71dMbm-TJI91Ql38w-1
X-Mimecast-MFC-AGG-ID: 4CFid71dMbm-TJI91Ql38w_1784561902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDA218001D7; Mon, 20 Jul 2026 15:38:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7B9E180034F; Mon, 20 Jul 2026 15:38:17 +0000 (UTC)
Date: Mon, 20 Jul 2026 16:38:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <al5A5queVo8NHs3p@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj4V6I__bCOjRTt@redhat.com> <87ech24wcz.fsf@suse.de>
 <alpIDh7WOcFsa9EA@redhat.com> <874iht4rd6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iht4rd6.fsf@suse.de>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 12:23:33PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> >> >> E) The migration source QEMU process is assumed to be secure. Compromise
> >> >> of the source QEMU process is nonetheless possible but exploiting the
> >> >> migration process is expected to grant no further privileges.
> >> >
> >> > This is the tricky assumption.
> >> >
> >> > Cnsider source host as 2 QEMU processes, one of tenant A and
> >> > one for tenant B.
> >> >
> >> > If tenant A compromises their QEMU, and can wait until a live
> >> > migration for tenant B is initiating, potentially tenant A can
> >> > connect to a dest QEMU for tenant B. I would consider that to
> >> > be gaining privileges.
> >> >
> >> 
> >> I thought of that, but I can't understand how "dest QEMU for tenant B"
> >> isn't just "dest QEMU for tenant A that has now took over". If none of
> >> the stream from source B is reaching dest B, then that's harmless.
> >
> > Two VMs configured with identical virtual hardware should have
> > the same vmstate structure, and so be compatible from the
> > POV of live migration flow. They can none the less have different
> > backend connections. So if tenant A can connect to a incoming
> > QEMU from tenant B, the live migration can probably succeed,
> > thus giving tenant A a working VM but with the HDD now backed
> > by data belonging to tenant B.
> >
> 
> Ok, I haven't thought about the storage aspect. In the scenario you
> describe, there's nothing the migration code can currently do to avoid
> such an exploit. The "migration process" seen as a larger thing is
> vulnerable and there's currently no code in QEMU whether broken or
> behaving properly that would stop this attack. We're kind of back to
> what Peter said that compromised source is game over. Unless I'm missing
> some mechanism.

IMHO the only sure fire way to stop this kind of attack is fine
grained access control over migration, to prove the incoming
client connection corresponds to specifically the source QEMU
we are expecting. And the only way we have todo that is

 * Use a seperate x509 certificate for every VM. This is a
   mgmt nightmare so not viable IMHO

 * Use TLS-PSK instead of x509 certificates. Effectively this
   is akin to single-use certificates generated on the fly
   by the mgmt app that owns QEMU (libvirt).

IOW, the situation today is that every deployment of QEMU is
pretty much assuming that the source QEMU is not compromised,
as no one does either of those approaches (yet).

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


