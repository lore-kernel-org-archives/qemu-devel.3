Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6994DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevC7-00043L-IS; Wed, 01 Jul 2026 09:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wevC5-00042u-JM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wevC3-0005Nn-Oa
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782913294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZThTu9Ed/AICfoo2zchGGtcBETGBvqIqCacme2T0sQ=;
 b=LQ2dhzQ6z35ITjrhsfqHjHpZbg5iIy9QBpu/rZKqABnFkFdtmfeeZjHC//LMu37jhczqOG
 GMmEZKsNL5npxX4Ijfd4TkB5v9oQJzbM86fYEsjkqEMBfg5qron1IYJl33tqXDIHQYa8Sz
 c9S1+H8M+mZD8DguSOuxxa9ggHZIH3w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-BGk9UrgJP_CYKeNcvK0m0g-1; Wed,
 01 Jul 2026 09:41:31 -0400
X-MC-Unique: BGk9UrgJP_CYKeNcvK0m0g-1
X-Mimecast-MFC-AGG-ID: BGk9UrgJP_CYKeNcvK0m0g_1782913290
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC17418795A5; Wed,  1 Jul 2026 13:41:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6CB4180076D; Wed,  1 Jul 2026 13:41:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7022D21E6920; Wed, 01 Jul 2026 15:41:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v5 00/35] monitor: turn QMP and HMP into QOM objects
In-Reply-To: <akTOGzFdz3_0Np-U@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 1 Jul 2026 09:21:47 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <87fr236t9v.fsf@pond.sub.org> <akTOGzFdz3_0Np-U@redhat.com>
Date: Wed, 01 Jul 2026 15:41:26 +0200
Message-ID: <87ik6y4yk9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 01, 2026 at 09:52:44AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Conceptually -object and object_add/object_del should be sufficient
>> > for essentially all QEMU configuration....if only we ported all our
>> > internal custom backends/devices/etc to QOM. That is of course a big
>> > job which is why it hasn't happened.
>> >
>> > This series started with the premise that the monitor is one of the
>> > easier areas to convert since we have no more than three classes,
>> > a common base, and QMP and HMP subclasses[1]. So why not give it a
>> > go and thus unlock the ability to dynamically create/delete monitors
>> > in QMP/HMP.
>> >
>> > This series does the conversion in a great many small steps to better
>> > understand the implications at each stage.
>> >
>> > The high level outcome of this series is
>> >
>> >  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
>> >    'monitor-qmp' respectively
>> >
>> >  * Both can be cold plugged and hot plugged. QMP only, can
>> >    also be hot unplugged.
>> >
>> >  * '-mon' is obsolete, deprecated and replaced by '-object',
>> >    but -monitor, -qmp and kept  as high level syntax sugar
>>=20
>> Possible additional work: change monitor_parse() to build a
>> MonitorOptions instead of a QemuOpts, so it call monitor_new() directly
>> instead of via monitor_new_opts().  Observation, not a demand.
>>=20
>> >
>> >  * QMP gains a concept of "close-action" which makes it
>> >    possible to mark a monitor for auto-delete.
>>=20
>> I'm not quite convinced this is warranted.  I'd like to hear more about
>> use cases.
>
> Replied about that inline to the patch. IMHO without this facility
> the series does not fully address the needs of systemd that motivated
> the original patches:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html
>
>> Is libvirt going to make use of it?
>
> This wasn't motivated by libvirt's needs, but indeed it could be
> useful for libvirt. Currently if apps want to access QMP, they
> need to use libvirt's QMP passthrough, which means they need
> special client code to talk to libvirt APIs.
>
> With this libvirt could dynamically add a monitor, with auto
> close, open it and pass the open FD back to the client app.
> libvirt would not need to watch for when the client app is
> gone as dropping the FD would cleanup the monitor.

Alright, that's fair.  The management application doesn't spawn
something that wants a dedicated monitor, it makes one for a client.

Would this fit into a commit message somewhere?

[...]


