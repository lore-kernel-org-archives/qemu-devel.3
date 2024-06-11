Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDD0C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGx9x-0007Wy-IN; Tue, 11 Jun 2024 04:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGx9v-0007WE-Ga
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGx9t-0007aw-PD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718095632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kYGcTorhz9i79ZL8G7J4cyUm2bGewgHF3EMLvPOCeQ=;
 b=S3e3U2KNToQTn4Usau5iRkDdY1fXjPLOpUW5Q7I8s8SOdrs9we5tTXJuGki6GbpLNscik0
 I2RX0i0dzEJmEnTIrnKTCMXkf+Ll/2CDB9HCdJEo+tB2phXEjlZjDvl98vllQ1U5kTrGyG
 J1M5d4l2gzu1nrkY4GONsuhhpOpKifA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-_AnxXhC1NOifNqSiAYYmFw-1; Tue,
 11 Jun 2024 04:47:06 -0400
X-MC-Unique: _AnxXhC1NOifNqSiAYYmFw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F95F19560AB; Tue, 11 Jun 2024 08:47:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.73])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B43719560AA; Tue, 11 Jun 2024 08:46:58 +0000 (UTC)
Date: Tue, 11 Jun 2024 09:46:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Examining device state via monitor for debugging
Message-ID: <ZmgO_-VlMIAE3xSl@redhat.com>
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org> <ZmgDXJ7Zt9AI2Z_7@redhat.com>
 <887ef788-53b2-469d-bb36-d4a9ea795a38@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <887ef788-53b2-469d-bb36-d4a9ea795a38@ilande.co.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 11, 2024 at 09:13:00AM +0100, Mark Cave-Ayland wrote:
> On 11/06/2024 08:57, Daniel P. Berrangé wrote:
> 
> > On Tue, Jun 11, 2024 at 07:49:12AM +0200, Markus Armbruster wrote:
> > > Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> > > 
> > > > Officialise the QMP command, use the existing
> > > > hmp_info_human_readable_text() helper.
> > > 
> > > I'm not sure "officialise" is a word :)
> > > 
> > > Taking a step back...  "info via" and its new QMP counterpart
> > > x-query-mos6522-devices dump device state.  I understand why examining
> > > device state via monitor can be useful for debugging.  However, we have
> > > more than 2000 devices in the tree.  Clearly, we don't want 2000 device
> > > state queries.  Not even 100.  Could we have more generic means instead?
> > > 
> > > We could use QOM (read-only) properties to expose device state.
> > > 
> > > If we use one QOM property per "thing", examining device state becomes
> > > quite tedious.  Also, you'd have to stop the guest to get a consistent
> > > view, and adding lots of QOM properties bloats the code.
> > > 
> > > If we use a single, object-valued property for the entire state, we get
> > > to define the objects in QAPI.  Differently tedious, and bloats the
> > > generated code.
> > > 
> > > We could use a single string-valued property.  Too much of an abuse of
> > > QOM?
> > 
> > Yeah, I'd suggest we just keep it dumb and free form, adding a
> > callback like this to the QOM base class:
> > 
> >    HumanReadableText (*debug_state)(Error **errp);
> 
> I think that's a little bit too restrictive: certainly I can see the need
> for allowing parameters for the output to be customised, and there may also
> be cases where a device may want to register more than one debug (or
> monitor) command.
> 
> Currently I quite like Manos' solution since it allows a MonitorInterface to
> be defined, and that could have separate methods for registering both "info"
> and "debug" commands. Longer term this could allow for e.g. TYPE_TCG_ACCEL
> to register "info jit" and devices can add whatever debug monitor commands
> they need.

The downside is that this wires the monitor APIs into the internals of the
devices, instead of having internals work exclusively in terms of QAPI
types.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


