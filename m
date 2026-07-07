Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D13C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9LG-0002Z0-4x; Tue, 07 Jul 2026 13:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9LE-0002Ye-D3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9LC-0003ZE-5K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783444329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNx9K17WOWFucW9tdC83ortvH5+t0CR83QSdIqhR4rs=;
 b=S+nbDjoYsZHkqBR9Uthh0rgxH+WRnKKCeww8XQ5LPX/hUf3ymfolUN3ZaOY8olYY3xlJAZ
 Goc4+zKE8TjjSl6HtfXm9nvyWG/qAlJiLrVz/Y6G5DfdDGw14QTG1LDF5BXS7tWonVB+Wx
 AjRKtCxcyS33J4V2rvh+pkGW/jcygbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-0jUgor4sPpCO_GNrpRjxGA-1; Tue,
 07 Jul 2026 13:12:04 -0400
X-MC-Unique: 0jUgor4sPpCO_GNrpRjxGA-1
X-Mimecast-MFC-AGG-ID: 0jUgor4sPpCO_GNrpRjxGA_1783444320
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D14E6180895C; Tue,  7 Jul 2026 17:11:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.142])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A92703000C13; Tue,  7 Jul 2026 17:11:55 +0000 (UTC)
Date: Tue, 7 Jul 2026 18:11:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <ak0zWH3TMS0IjZbq@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <akzyfcnwchjDV_to@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akzyfcnwchjDV_to@movementarian.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 07, 2026 at 01:35:09PM +0100, John Levon wrote:
> 
> Thanks for pointing me towards this Cédric.
> 
> On Tue, Jul 07, 2026 at 11:59:27AM +0100, Daniel P. Berrangé wrote:
> 
> > Beyond the overall virt/non-virt use case classification, there are
> > a number of scenarios which we have decided will not be treated as
> > security issues. Start to document some of these to give consistency
> > in our treatemnt of incoming disclosures.
> 
> "treatment"
> 
> > +* **vhost-user/vfio-user backends**. The backend processes have
> > +  shared memory regions co-mapped with the QEMU process. The intent
> > +  of the process separation is operational resilience & flexibility
> > +  and allowing for independent software suppliers. There is not
> > +  considered to be security boundary between QEMU and the vhost-user
> > +  & vfio-user backends. Thus flaws in the backends which can cause
> > +  crashes / undesirable behaviour in QEMU will **not** be treated as
> > +  security flaws, but should be fixed as hardening bugs.
> 
> We're OK with this for vfio-user.
> 
> We don't have this properly documented - and we should - but practically
> speaking, right now, the QEMU vfio-user client has at least some level of trust
> in the server. It's something we would like to improve at some point, but we
> could update this statement at that time.

Yep, can certainly be tweaked later if we want to bring stuff in-scope
again.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


