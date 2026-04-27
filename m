Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27951FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFaM-0000xQ-Ve; Mon, 27 Apr 2026 02:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHFZi-0000lh-S7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHFZe-0007x7-NY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777271749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bMRPfHzwN/ht0Zd2WRnAcAGiIxVoY9epHgVW1qGINQ=;
 b=T/QhbhNa8+//fxB0JY9V+Eo4EU+dAhB/Mz/NnIgGIGcKjA3ypkmD8vEThLvR2MX3nRHazk
 oybKkXgNI2wQONxrrmmb4YVklbmsHD4eANqgXnU637OfaqmwWWrmOPK/J7BJRDdM/krNSk
 dqXO0jTjsOTJXZnRD3i80maIP1wquDo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-bwisKWI_Pry6fAdmZb4cag-1; Mon,
 27 Apr 2026 02:35:46 -0400
X-MC-Unique: bwisKWI_Pry6fAdmZb4cag-1
X-Mimecast-MFC-AGG-ID: bwisKWI_Pry6fAdmZb4cag_1777271745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 010CD1956080; Mon, 27 Apr 2026 06:35:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F575180047F; Mon, 27 Apr 2026 06:35:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D299D21E6A28; Mon, 27 Apr 2026 08:35:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Christian
 Brauner <brauner@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/17] monitor: turn QMP and HMP into QOM objects
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 10 Apr 2026 17:04:41
 +0100")
References: <20260410160458.3778874-1-berrange@redhat.com>
Date: Mon, 27 Apr 2026 08:35:41 +0200
Message-ID: <87lde8lxky.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> Conceptually -object and object_add/object_del should be sufficient
> for essentially all QEMU configuration....if only we ported all our
> internal custom backends/devices/etc to QOM. That is of course a big
> job which is why it hasn't happened.

In addition, we'd need a more unified object life cycle.  See "Problem
5: QOM lacks a clear life cycle" in

    Subject: Dynamic & heterogeneous machines, initial configuration: probl=
ems
    Date: Wed, 31 Jan 2024 21:14:21 +0100
    Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

> This series started with the premise that the monitor is one of the
> easier areas to convert since we have no more than three classes,
> a common base, and QMP and HMP subclasses. So why not give it a go
> and thus unlock the ability to dynamically create/delete monitors
> in QMP/HMP.

Makes sense.

> This series does the conversion in as many small steps as I could
> achieve. At the end it is possible to create HMP and QMP monitors
> with -object and object_add.

I'll try to squeeze in review.

> In theory object_del is possible but is unsafe since there's no
> synchronization wrt "in use" monitors. Christian Brauner sent
> a proposal for monitor_add/monitor_del commands that address the
> safety/synchronization issues, but I've not yet integrated the
> relevent bits of that series with this proposal:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html
>
> My overall feeling is that we're better off turning monitors
> into QOM classes, rather than inventing more type specific
> QMP commands.

I agree!

> What's missing:
>
>  - Integration of code for safe deletion of monitors
>  - The existing -mon/-qmp/-monitor args should be turned
>    into syntax sugar around -object & -chardev

Yes.  A step we sometimes neglect.

>  - The new approach must be documented
>  - Functional tests are needed for the hot add/remove of
>    monitors and new -object syntax. (The pre-existing
>    test suites cover the static config with the traditional
>    args).


