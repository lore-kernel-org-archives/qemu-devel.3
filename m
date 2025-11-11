Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6DBCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIjYM-0002oV-ET; Tue, 11 Nov 2025 03:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjYK-0002ng-JN
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:16:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjYC-0003k0-Va
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762848988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/hjfnqtPB0ycFkBvTPYtn6DdGBVA+Bq2DY9HJ781dZA=;
 b=VDT9qrdnKApWg3XP9L+MCPPKQRHRw1Qbkkaov3O/2TC9kJoPdkcvniDke93v312BQzUJMi
 m72To0EHJrRYfzvlOBgjk8KQhE6i2I2fp2wArmC/AcTGlIpebM13tH6vdjWbY5U1g/pEPu
 I6E9t5HJLT+F9qWO7DGGAS+zoX2xYmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-ip42MtTyOFGjY9XS3kipKQ-1; Tue,
 11 Nov 2025 03:16:22 -0500
X-MC-Unique: ip42MtTyOFGjY9XS3kipKQ-1
X-Mimecast-MFC-AGG-ID: ip42MtTyOFGjY9XS3kipKQ_1762848981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A78401800650; Tue, 11 Nov 2025 08:16:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60D9F180035F; Tue, 11 Nov 2025 08:16:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C824521E6A27; Tue, 11 Nov 2025 09:16:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
In-Reply-To: <aRIE8ACbqWZ2MPdE@redhat.com> (Kevin Wolf's message of "Mon, 10
 Nov 2025 16:29:52 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-3-chigot@adacore.com>
 <874ir2nqr9.fsf@pond.sub.org>
 <CAJ307Ej8oNXjOZt2fkBMjR6bKSf=C2M6ncFFLCfy=Wk6+KMhNQ@mail.gmail.com>
 <877bvykp3q.fsf@pond.sub.org> <aRIE8ACbqWZ2MPdE@redhat.com>
Date: Tue, 11 Nov 2025 09:16:18 +0100
Message-ID: <87pl9pdlwt.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.11.2025 um 14:13 hat Markus Armbruster geschrieben:
>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>>=20
>> > On Mon, Nov 10, 2025 at 11:09=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >>
>> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>> >>
>> >> > This allows to handle the default FAT size in a single place and ma=
ke the
>> >> > following part taking care only about size parameters. It will be l=
ater
>> >> > moved away in a specific function.
>> >> >
>> >> > The selection of floppy size was a bit unusual:
>> >> >  - fat-type undefined: a FAT 12 2880 Kib disk (default)
>> >> >  - fat-type=3D16: a FAT 16 2880 Kib disk
>> >> >  - fat-type=3D12: a FAT 12 1440 Kib disk
>> >> >
>> >> > Now, that fat-type undefined means fat-type=3D12, it's no longer po=
ssible
>> >> > to make that size distinction. Therefore, it's being changed for the
>> >> > following:
>> >> >  - fat-type=3D12: a FAT 12 1440 Kib disk (default)
>> >> >  - fat-type=3D16: a FAT 16 2880 Kib dis
>> >> >
>> >> > This has been choosen for two reasons: keep fat-type=3D12 the defau=
lt and
>> >> > creates a more usual size for it: 1440 Kib.
>> >> >
>> >> > The possibility to create a FAT 12 2880 Kib floppy will be added ba=
ck
>> >> > later, through the fat-size parameter.
>> >> >
>> >> > Side note to mention that s->sectors_per_cluster assignments are
>> >> > removed because they are overidden a few line further.
>> >> >
>> >> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>> >>
>> >> Is this a user-visible change?
>> >
>> > Yes, just "floppy" will now result in a 1440 KiB instead of the
>> > previous 2880 KiB. However, Kevin mentions in V1 that it would make
>> > more sense and vvfat being known to be unstable, this would be fine.
>> > FTR, here is the complete comment:
>> >
>> >> On Wed, Oct 29, 2025 at 5:06=E2=80=AFPM Kevin Wolf <kwolf@redhat.com>=
 wrote:
>> >> > In general, our stance is that we can change defaults whenever we w=
ant
>> >> > to, and if you don't want to be surprised by changing defaults, you=
 need
>> >> > to specify the option explicitly.
>>=20
>> Hmm, where is this stance on defaults documented?  Question for Kevin,
>> of course.
>
> Probably nowhere. More importantly, I don't think a compatibility
> promise that says otherwise is documented either. And we know that
> defaults have changed before, and that libvirt tries to be as explicit
> as possible to avoid being impacted by changed defaults.
>
> Do you disagree? If so, is there any way to change defaults or do we
> have to stick to the existing defaults forever? To me not specifying an
> option means "just pick anything that makes sense", without any promise
> that this stays the same across versions.

I'd love to be able to change defaults.  Defaults can become bad over
time.  I remember arguing for changing such defaults unsuccessfully.

Looks like there's differing opinions / uncertainty on whether our
compatibility promise covers defaults.  That's bad, we need clarity
there.  I'll start a separate thread.

[...]


