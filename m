Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC64E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 08:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLHwh-0007qE-2t; Wed, 11 Dec 2024 03:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLHwf-0007py-NU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 03:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tLHwe-0003kn-3t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 03:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733905182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tUPMdcfyJQCNhQoIiB+vQL68aNfDnewoT+gujEg8rw=;
 b=OuCCpSPjPXF1T9hfKrOBj1eIX4JZ5AZ44qy8GktfzvFipVQR9et1aNRRWOOTISKBUV7a+5
 gQ0nBbS9krnZySnySxaU3PGe3B7ljjE+OrjSxg14kCoy2p18qD4BTFxTxfkE60RGaDC0yc
 vBKCYZUuhZcS/ozHmmGiRl+uiwqZKO0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-1faKOpuGPSeYDoRGDU7Xyg-1; Wed,
 11 Dec 2024 03:19:38 -0500
X-MC-Unique: 1faKOpuGPSeYDoRGDU7Xyg-1
X-Mimecast-MFC-AGG-ID: 1faKOpuGPSeYDoRGDU7Xyg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84D1219560B3; Wed, 11 Dec 2024 08:19:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB241956048; Wed, 11 Dec 2024 08:19:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A38EA21E66E8; Wed, 11 Dec 2024 09:19:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,  Igor Mammedov <imammedo@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Alex
 Williamson <alex.williamson@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
In-Reply-To: <ZyEVwFaTbqtw2Vx6@x1n> (Peter Xu's message of "Tue, 29 Oct 2024
 13:05:04 -0400")
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
 <ZyC8MmM7k6df2Awi@redhat.com> <ZyD1BarDJUSA7Nen@x1n>
 <ZyEHoj3Mrm3OGtnX@redhat.com> <ZyEVwFaTbqtw2Vx6@x1n>
Date: Wed, 11 Dec 2024 09:19:32 +0100
Message-ID: <87o71iy6ln.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Looked at this thread again to refresh my memory on the proposed
singleton interface, and found I have something to add.

Peter Xu <peterx@redhat.com> writes:

> On Tue, Oct 29, 2024 at 04:04:50PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> I tend to feel that having MigrationState exist for the whole lifetime
>> of QEMU is a bug, forced on us by the unfortunate need to call
>> migrate-set-parameters/capabilities separately from the migrate
>> command, and by the need to query migrate info an arbitrary amount of
>> time after it finishes.
>>=20
>> This puts libvirt in the awkward position of having to manually reset
>> all migration parameters, just to ensure earlier settings don't
>> accidentally affect a future migration operation :-( This is a design
>> that encourages mistakes.
>
> I think it would still be easy to add "cap" & "params" arguments support
> for the "migrate" QMP command without breaking the current API, iff that
> helps in whatever form.  When present, it simply applies the caps and/or
> param list first before invoking the migrate command, fail the command if
> cap / param check fails.
>
> But I'm not sure whether that's a concern at all for Libvirt, if what
> Libvirt currently does is having separate "migrate-set-*" commands prior =
to
> the "migrate".  I may have overlooked the real issue behind on how that
> could complicate Libvirt.

I think Daniel's point is that the interface's reliance on global state
makes it awkward to use.

Migration configuration is global state.  It's split into "capabilities"
and "parameters", but that's detail.  We have commands to query and
change this state.

When Libvirt connects to a QEMU process, it has no idea what the global
migration configuration is.  To get it into a known state, it has to set
*everything*.  It cannot rely on defaults.

It even has to set things it doesn't know!  When we add a new parameter
to QEMU, libvirt needs to be updated to reset it to its default even
when libvirt has no need for it.  When you use a version of libvirt that
lacks this update, it remains whatever it was.  The migration interface
becomes accidentally stateful at the libvirt level, which is
undesirable.

Compare this to the more modern interface we have for other long-running
tasks: jobs.

There is a job-specific command that creates the job: blockdev-backup,
block-commit, blockdev-mirror, block-stream, blockdev-create,
snapshot-save, snapshot-load, snapshot-delete, ...  Each command takes
the entire job configuration as arguments.  Libvirt does not need
updating for new parameters: these simply remain at their default
values.

Bonus: there are generic commands to control and monitor jobs:
job-pause, job-resume, job-cancel, job-complete, job-dismiss,
job-finalize, query-jobs.

[...]


