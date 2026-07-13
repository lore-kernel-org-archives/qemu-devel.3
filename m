Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1BBC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDvX-0006wE-UW; Mon, 13 Jul 2026 06:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjDvV-0006w6-1A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wjDvR-0000tQ-9D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783938611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KokfjhKtSvSEYLUMI2jEvq11anwkHCvAtQ2JaeaaWiE=;
 b=VaMduf0+VmCBLMuYtezkoKbchBBdSmpLw7UA2OnbucJiwockQIiYmRYTeZlGyMYYv+eldn
 lIsq0H7Co8/rxGQrQNyyGwttVKxfVSfVhjmVDTatod5E7HkFIUfK2XNSw5BFht+IPHMsRN
 wvUqwiG7M0Hyn2HCDeJQplql/+i+EGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-cPXAvD0OMx6aUuQhFUiDWw-1; Mon,
 13 Jul 2026 06:30:08 -0400
X-MC-Unique: cPXAvD0OMx6aUuQhFUiDWw-1
X-Mimecast-MFC-AGG-ID: cPXAvD0OMx6aUuQhFUiDWw_1783938606
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346331800A7B; Mon, 13 Jul 2026 10:30:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89F9A19560AB; Mon, 13 Jul 2026 10:30:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Pedro
 Barbuda <pbarbuda@microsoft.com>, Mohamed Mediouni
 <mohamed@unpredictable.fr>, Nicholas Piggin <npiggin@gmail.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: what is qemu_system_guest_panicked() for?
In-Reply-To: <alSqlDRT9L8OqAso@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
 <alSkWHw6ryhEEaDf@redhat.com> <87cxwrtgfd.fsf@pond.sub.org>
 <alSqlDRT9L8OqAso@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 13 Jul 2026 12:30:03 +0200
Message-ID: <87fr1ni3mc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=cohuck@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13 2026, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Jul 13, 2026 at 10:57:58AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Jul 10, 2026 at 05:02:53PM +0100, Peter Maydell wrote:
>>=20
>> [...]
>>=20
>> >> So I guess my question is, is it OK to mash these two categories of
>> >> "we can't keep running the VM" together, or should we define a new
>> >> one for the "unrecoverable guest error" case, or do we already have
>> >> some better thing to do that I missed?
>> >
>> > IMHO we should NOT be abusing "panicked" for cases which are
>> > not guest OS panics.
>>=20
>> Point.
>>=20
>> > Adding new QMP events is cheap and we should do so.
>>=20
>> Changing the event sent on a certain situation is technically a
>> compatibility break.  Would it matter here?
>
> What wins "compat break" or "bug fix" ? A strict POV prevents almost
> any bug fixes, if you want to remain bug-for-bug compatible with
> old QEMU.
>
> With my "management app" hat on, I want QEMU to stop sending panic
> events for things that are not panics, as that is triggering incorrect
> actions / admin activities. ie on a panic, I'm going to take a guest
> memory dump and try to analyse what is broken in the guest kernel.

That would argue for e.g. a guest exception loop being a "panic" as
well, as the admin may want to debug that.

>
> The QAPI spec says:
>
>   ##
>   # @GUEST_PANICKED:
>   #
>   # Emitted when guest OS panic is detected
>
>
> and
>
>   ##
>   # @RunState:
>   #
>   # An enumeration of VM run states.
>   #
>   ..
>   # @guest-panicked: guest has been panicked as a result of guest OS
>   #     panic
>
>
> I don't think "machine check exception" or "unknown VM exit"
> can be said to match either of those docs, and thus fixing
> compliance should trump bug-for-bug compatibility IMHO.

I'm wondering whether we first need to agree upon a common definition of
what a "guest OS panic" is. "The Linux kernel ran into a panic()
statement" clearly is; is "the guest OS put itself into a state of which
the only way out is a reboot" a "guest OS panic" as well, or only in
some cases?


