Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEECD2D0E8
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfe54-0000Hp-PG; Tue, 13 Jan 2026 08:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfe52-0000Bi-3w
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfe50-0001co-FQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768309501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdHTT09nwwgsO3f3H+vWntFgFFu/rNWG9pQ7CRobSuc=;
 b=hgegDcIgcQNuj6Z0+Hp+fNjmadXednBT7RW1wMi6swL1AmQHRZOSeSkVUJ9sBQZBU6FPH7
 xK5jFsRK3jMctfciysftmMCRL7ExYAKQ/bs2QNq0Ku7Zfg7iREVPp1Dh4yyv83n2KvUo3q
 udvLo4lmCEIXBFwsVT2sPJOXk4nXgvg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-J2tjd0XrNGKOKBEAuOMCZQ-1; Tue,
 13 Jan 2026 08:04:58 -0500
X-MC-Unique: J2tjd0XrNGKOKBEAuOMCZQ-1
X-Mimecast-MFC-AGG-ID: J2tjd0XrNGKOKBEAuOMCZQ_1768309497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC16818002C4; Tue, 13 Jan 2026 13:04:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 715C41800240; Tue, 13 Jan 2026 13:04:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07ED821E66C9; Tue, 13 Jan 2026 14:04:54 +0100 (CET)
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
Subject: Re: [PATCH v5 09/24] util: introduce some API docs for logging APIs
In-Reply-To: <aWYj7-ByD4eyclhG@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 13 Jan 2026 10:52:31 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-10-berrange@redhat.com>
 <87ms2hal4a.fsf@pond.sub.org> <aWYjHQYYeEqpnnQh@redhat.com>
 <aWYj7-ByD4eyclhG@redhat.com>
Date: Tue, 13 Jan 2026 14:04:53 +0100
Message-ID: <87zf6h8xze.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Tue, Jan 13, 2026 at 10:49:01AM +0000, Daniel P. Berrang=C3=A9 via Dev=
el wrote:
>> On Tue, Jan 13, 2026 at 10:59:49AM +0100, Markus Armbruster wrote:
>> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >=20
>> > > There is a gotcha with qemu_log() usage in a threaded process.
>> > > If fragments of a log message are output via qemu_log() it is
>> > > possible for messages from two threads to get mixed up. To
>> > > prevent this qemu_log_trylock() should be used, along with
>> > > fprintf(f) calls.
>> > >
>> > > This is a subtle problem that needs to be explained in the
>> > > API docs to ensure correct usage.
>> > >
>> > > Reported-by: Markus Armbruster <armbru@redhat.com>
>> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> > "Should normally" suggests there are exceptions.
>> >=20
>> > "Should only" does not.
>> >=20
>> > "Must" is a bit stronger still.
>> >=20
>> > Which of the three do we want?
>>=20
>> The "Should" usage was reflecting the reality that we have quite alot
>> of code using qemu_log_trylock + qemu_log, instead of qemu_log_trylock
>> + fprintf.

Yes.

>> I didn't feel it appropriate to use 'must' unless we explicitly make
>> qemu_log() fail when used inside the scope of a qemu_log_trylock().

Fair.

>> So "Should normally" is the best fit
>
> Actually specifically in the log.rs case, we have a greater constraint.
> The rust code for log_mask_ln will unconditionally add a newline to
> all messages. So this Rust method *must* only be usd for complete
> messages, regardless of what policy we have on the C qemu_log() call.

Got it.

Suggest to consistently use "should normally" in the contracts where it
is the best fit.  Use "must" for the Rust method, and maybe mention it
in the commit message (you decide).


