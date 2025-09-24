Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5E0CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1S4f-0001zB-LW; Wed, 24 Sep 2025 12:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1S4c-0001yH-J3
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1S4U-0004cv-WD
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758730219;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AqnhL2B36mwyvI3Hblfzg1Xi+lOXoyJq5C151SoWKFE=;
 b=IJMhSZSmXRGRNZO0XmrI0AfYMsK1fk7Ve3AQO8D/+YSqkqRMsc1e9Jjo/45oR0Aqb+3N4u
 /0IYJIDwhvlufH9vQdLvFHw/FEOqE4LC6PXQSxCqKLlKIrVTPEigroz2QxigP96MTzzoH6
 wDJQyxJNNVu2zOQaqFhJrDGIT0kCcK0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-bQ5eBMNDNhiGGUR2ozDybg-1; Wed,
 24 Sep 2025 12:10:17 -0400
X-MC-Unique: bQ5eBMNDNhiGGUR2ozDybg-1
X-Mimecast-MFC-AGG-ID: bQ5eBMNDNhiGGUR2ozDybg_1758730214
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1913A195608B; Wed, 24 Sep 2025 16:10:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7E28180057C; Wed, 24 Sep 2025 16:10:00 +0000 (UTC)
Date: Wed, 24 Sep 2025 17:09:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 12/20] monitor: introduce monitor_cur_hmp() function
Message-ID: <aNQX0R0qBGtglJ2K@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-13-berrange@redhat.com>
 <87zfaqwr2a.fsf@pond.sub.org> <aM1aq1HNV7qJdrqI@redhat.com>
 <87ldm9txg0.fsf@pond.sub.org> <aM6WB4c1sMtfqM9p@gallifrey>
 <87plbinaos.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plbinaos.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 10:38:59AM +0200, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Fri, Sep 19, 2025 at 02:43:41PM +0200, Markus Armbruster wrote:
> >> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >> 
> >> >> > A number of callers use monitor_cur() followed by !monitor_cur_is_qmp().
> >> >> 
> >> >> "A number of"?  I can see just one:
> >> >> 
> >> >>     int error_vprintf(const char *fmt, va_list ap)
> >> >>     {
> >> >>         Monitor *cur_mon = monitor_cur();
> >> >> 
> >> >>         if (cur_mon && !monitor_cur_is_qmp()) {
> >> >>             return monitor_vprintf(cur_mon, fmt, ap);
> >> >>         }
> >> >>         return vfprintf(stderr, fmt, ap);
> >> >>     }
> >> >
> >> > Opps, that'll be referring to the other use of monitor_cur() in my
> >> > patches that I then removed when I re-ordered the series.
> >> >
> >> >> 
> >> >> > This is undesirable because monitor_cur_is_qmp() will itself call
> >> >> > monitor_cur() again, and monitor_cur() must acquire locks and do
> >> >> > hash table lookups. Introducing a monitor_cur_hmp() helper will
> >> >> > combine the two operations into one reducing cost.
> >> 
> >> I think the actual interface flaw is having monitor_cur_is_qmp().
> >> 
> >> In master, monitor_cur_is_qmp() is only used in monitor/monitor.c.  Both
> >> call sites have the value of monitor_cur() available as @cur_mon.
> >> They'd be better off calling monitor_is_qmp(cur_mon).
> >> 
> >> Note that in master nothing outside monitor/ cares whether a monitor is
> >> QMP or HMP.  I like that.
> >> 
> >> Your series doesn't preserve this property.
> >> 
> >> You move the first call site error_vprintf() from monitor/monitor.c to
> >> util/error-report.c in PATCH 11.  QMP vs. HMP is no longer encapsulated.
> >> Slighly irksome.
> >
> > How about a slightly simpler approach, looking above we have:
> >
> >> >>         if (cur_mon && !monitor_cur_is_qmp()) {
> >> >>             return monitor_vprintf(cur_mon, fmt, ap);
> >> >>         }
> >> >>         return vfprintf(stderr, fmt, ap);
> >
> > I think we could replace this with:
> >
> >   ret = monitor_vprintf(cur_mon, fmt, ap);
> >   if (ret == -1) {
> >        ret = vfprintf(stderr, fmt, ap);
> >   }
> >   return ret;
> >
> > monitor_vprintf already -1 exits if !mon or monitor_is_qmp(mon)
> >
> > Keeps the encapsulation, and is now 'print via the monitor but if it
> > can't do it, use printf'
> 
> monitor_printf() fails when passed a null monitor[*] or a QMP monitor.
> Reporting the error to stderr then is probably better than swallowing
> it.  Same if the function somehow picks up more failure modes.
> 
> I like it.

I've tried this and it works nicely and helps me with some other
aspects too.

> One could perhaps object that it makes "report to HMP or else stderr"
> less obvious if you don't already know that monitor_vprintf() only
> prints to HMP.  I'm okay with that.

'error_vprintf()' itself is already non-obvious, as you'd never
guess it implied any interaction with the monitor at all :-)
A little comment clarifies things sufficiently well.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


