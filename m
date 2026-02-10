Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF82DEA3F3E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplUl-0005ZG-Vs; Tue, 10 Feb 2026 06:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vplUk-0005WN-IA
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vplUh-0002H1-Ub
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770721282;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAkwU+sQeCltjyDreY30E+tvRx2T4g7fo7pt48nallk=;
 b=bHJbUrqW5Zrki4nn4m+JjYZPlyqL/WHgneYbHDAeH60TVm6ymPlZQ/DgsXTl55khKWxfgJ
 J8UX5WBcR679sM1gJqxfR/4/X+KpIY3ny7ufrQikgc2fmahuwm2oGzm+VgGnO9MTmE9S5b
 x7vnH75OAMPG0dhKpT5Xr7cl/UbbMEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-hpxPYUWgMxG46Fs9br4nZQ-1; Tue,
 10 Feb 2026 06:01:12 -0500
X-MC-Unique: hpxPYUWgMxG46Fs9br4nZQ-1
X-Mimecast-MFC-AGG-ID: hpxPYUWgMxG46Fs9br4nZQ_1770721271
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2F78180AC48; Tue, 10 Feb 2026 11:01:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA15C30001A8; Tue, 10 Feb 2026 11:00:58 +0000 (UTC)
Date: Tue, 10 Feb 2026 11:00:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <aYsP5xRouGmJFU4X@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com>
 <20260210054244-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210054244-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 10, 2026 at 05:44:50AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
> > On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
> > > Hi,
> > > 
> > > This is the v2 trying to introduce property flags to detect user's
> > > property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
> > > RFC v1 [1].
> > 
> > This says what the series is proposing, but IMHO what is more important
> > here is explaining why this either desirable or appropriate to add as
> > general facility in QOM.
> > 
> > The idea that code should take different action for a given fixed value,
> > based on whether the value was set by the user, or left on the default,
> > makes me very uncomfortable.
> > 
> > There have been a number of situations where something that was initially 
> > a boolean flag, actually needed to be a tri-state instead, to provide
> > semantics like "On", "Off", "Auto".
> 
> But "auto" is exactly a property specific way to work around this.
> With this, we could allow "auto" for any property (except strings I
> guess) without per property code.
> 
> 
> > This "user set" flag could support such behaviour indirectly, but since
> > "user set" is an internal concept we'd still be only exposing a boolean
> > externally, while using a tri-state internally. That does not give the
> > full flexibility of a tri-state, because internally if we wanted to
> > have the default to be "yes", it offers no way for the mgmt app to
> > put it back to "auto".
> 
> I do not get it. Of course user set is an external concept.
> It is user controllable!

If a property is modelled as a tri-state today the user can explicitly
request any of the three values

  -object  foo,prop=on
  -object  foo,prop=off
  -object  foo,prop=auto

If a property is modelled as a boolean, and we have this new internal
"user set" flag to represent the "auto" scenario, the user can only
do

  -object  foo,prop=on
  -object  foo,prop=off

we're missing the ability to explicitly request the "auto" value,
which could be needed if we decide the internal default should be
either "on" or "off".

This "user default" flag concept is special casing support for
tri-states in a way that is worse than what we can already do in
QAPI. That feels like a mistake / bad path to go down to me.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


