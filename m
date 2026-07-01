Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BFEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wepke-0000p7-5E; Wed, 01 Jul 2026 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wepkc-0000ov-GP
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wepka-0007pl-Nj
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 03:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782892371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3hnywmiQL0Bty2fnaG4E5AjlbzFV8f8u4nYjX0ANFM=;
 b=JcK9pmSp4TU/epjmXAlVDOoDODCxvcvOVzrhR6O15HNM54u7z4+xGUk3Fkfnw8WyWFsdBL
 GrkEBIEOhQnx3onv/j8vFVihnxMUy78ORMLw+n5wCZTxS9qbNfr1tiJAUGaWepAqc8shar
 FZm3ukoLBOSC58LkVkpbLX1sHWi96sY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-JVIw_oj9N2qEWY9Ag29QZQ-1; Wed,
 01 Jul 2026 03:52:50 -0400
X-MC-Unique: JVIw_oj9N2qEWY9Ag29QZQ-1
X-Mimecast-MFC-AGG-ID: JVIw_oj9N2qEWY9Ag29QZQ_1782892369
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A6B1954B3F; Wed,  1 Jul 2026 07:52:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE413000C23; Wed,  1 Jul 2026 07:52:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3B0721E6920; Wed, 01 Jul 2026 09:52:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v5 00/35] monitor: turn QMP and HMP into QOM objects
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:16
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
Date: Wed, 01 Jul 2026 09:52:44 +0200
Message-ID: <87fr236t9v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Conceptually -object and object_add/object_del should be sufficient
> for essentially all QEMU configuration....if only we ported all our
> internal custom backends/devices/etc to QOM. That is of course a big
> job which is why it hasn't happened.
>
> This series started with the premise that the monitor is one of the
> easier areas to convert since we have no more than three classes,
> a common base, and QMP and HMP subclasses[1]. So why not give it a
> go and thus unlock the ability to dynamically create/delete monitors
> in QMP/HMP.
>
> This series does the conversion in a great many small steps to better
> understand the implications at each stage.
>
> The high level outcome of this series is
>
>  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
>    'monitor-qmp' respectively
>
>  * Both can be cold plugged and hot plugged. QMP only, can
>    also be hot unplugged.
>
>  * '-mon' is obsolete, deprecated and replaced by '-object',
>    but -monitor, -qmp and kept  as high level syntax sugar

Possible additional work: change monitor_parse() to build a
MonitorOptions instead of a QemuOpts, so it call monitor_new() directly
instead of via monitor_new_opts().  Observation, not a demand.

>
>  * QMP gains a concept of "close-action" which makes it
>    possible to mark a monitor for auto-delete.

I'm not quite convinced this is warranted.  I'd like to hear more about
use cases.

Is libvirt going to make use of it?

> The monitor hot-unplug code and the qtest and functional testing
> code is heavily derived from a series sent by Christian Brauner
> which proposed new monitor_add/monitor_del commands:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html
>
> I left Christian's authorship & SoB on the patches which were
> derived from his code, though the code has been refactored quite
> a bit in places, so bugs are quite possibly my own.
>
> Note that Christian's series allowed the use of "monitor_del"
> commands against the current monitor session. ie a client could
> delete the very monitor it was using. This is an awkward concept
> as it needs special casing to delay the deletion to happen in
> the background, such that that the QMP response to 'monitor_del'
> could still be sent back. This also left the chardev was orphaned
> as there's no way to run 'chardev_dev' in that usage pattern.
>
> To provide an alternative mechanism to address the same use case,
> this series introduces the 'close-action' concept mentioned above,
> that allows hotplugging a monitor to service a specific task,
> with the monitor being purged when the script closes its connection.
> This avoids the special casing that an explicit "self deletion"
> paradigm required.
>
> While supporting hotplug of HMP was trivial, I didn't do any work
> to think about hotunplug of HMP, since IMHO it is of limited value
> given HMP's typical use cases.
>
> [1] ~~~ we did all this not because it was easy,
>         but because we thought it would be easy ~~~

Heh!

Fully addressing all review comments before the soft freeze may or may
not be possible.  Perhaps punting sufficiently harmless changes to a
post-freeze fixup series could help.  Use your judgement.

We could also leave the close-action feature for the next development
cycle.


