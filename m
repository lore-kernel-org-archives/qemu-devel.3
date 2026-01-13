Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E71D2D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe16-0007U8-DU; Tue, 13 Jan 2026 08:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfe0u-00072S-Jg
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:00:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfe0s-00017A-DX
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768309244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ss5dADgE/ADKgleMeqazN+wjHXicgkf3A/KmA/9aDQ0=;
 b=RNrqUFzCXZeyedbnennvlXMfoCRkJFT19OQ3maMwZ3iai6X5WVQr2lIt5ALUiNSbH7deB3
 HYLZToyN3xWDSiC1tGcmJnSCNFuO3fmV7/G1svbrxctGHLhry0T547hyCgzhaM/pUNgV9R
 yjKNVBu+R7hn/NK/J1ywLmWLizkYFks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-UyFqmz1SOpK80HRRhRwIbg-1; Tue,
 13 Jan 2026 08:00:42 -0500
X-MC-Unique: UyFqmz1SOpK80HRRhRwIbg-1
X-Mimecast-MFC-AGG-ID: UyFqmz1SOpK80HRRhRwIbg_1768309240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4366F1955D9F; Tue, 13 Jan 2026 13:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 805B41800665; Tue, 13 Jan 2026 13:00:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 08E0C21E676C; Tue, 13 Jan 2026 14:00:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
In-Reply-To: <aWYXt9YckvZmFCia@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 Jan 2026 10:00:23 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
 <878qe1c17b.fsf@pond.sub.org> <aWYXt9YckvZmFCia@redhat.com>
Date: Tue, 13 Jan 2026 14:00:35 +0100
Message-ID: <874iopacr0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jan 13, 2026 at 10:27:04AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This will be used to include the thread name in error reports
>> > in a later patch. It returns a const string stored in a thread
>> > local to avoid memory allocation when it is called repeatedly
>> > in a single thread. The thread name should be set at the very
>> > start of the thread execution, which is the case when using
>> > qemu_thread_create.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  include/qemu/thread.h    |  1 +
>> >  meson.build              | 21 +++++++++++++++++
>> >  util/qemu-thread-posix.c | 33 ++++++++++++++++++++++++++-
>> >  util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
>> >  4 files changed, 99 insertions(+), 5 deletions(-)
>>=20
>> Tempted to store the thread name in TLS and call it a day.
>
> Using the official APIs in this way ensures that the thread name is
> visible outside QEMU. For example when debugging in GDB, which IMHO
> is an important benefit.

I didn't mean to suggest not to set the "official" thread name.

This patch retrieves the "official" thread name back.  Takes a bit of
system-specific code, including Meson magic.  We could instead hold on
to our own copy, and just use that.


