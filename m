Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D30DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRjq-0001lr-82; Tue, 02 Dec 2025 09:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQRjo-0001lZ-98
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQRjh-0006i4-TC
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764687131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PtI6zbtR863z7qLwM6VgSy8f8RBtjHUXBnsxg5ME/I=;
 b=hmugYxOe67z7Jp7DL/toZFWy6AS/uIdzadmrt9+5Hq1F0azuz4MoJd+zaU5SOZbxpqDYi9
 Q8/atr2Nc+Td+atfsqaexgUcp6+C+EDA28sqNwaVEt356YuyoerkRCWHVoUcpHtwuItQIx
 XUtuBcrsYG0cNd7dvQtaMLOldhLieDM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-kVTHoP2FODaRI_Cx65U9CQ-1; Tue,
 02 Dec 2025 09:52:08 -0500
X-MC-Unique: kVTHoP2FODaRI_Cx65U9CQ-1
X-Mimecast-MFC-AGG-ID: kVTHoP2FODaRI_Cx65U9CQ_1764687127
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74EE91955E77; Tue,  2 Dec 2025 14:52:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142D230001A4; Tue,  2 Dec 2025 14:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 168B021E6A27; Tue, 02 Dec 2025 15:52:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Geoffrey McRae <geoff@hostfission.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Paolo Bonzini <pbonzini@redhat.com>,  Alexandre
 Ratchov <alex@caoua.org>,  qemu-devel@nongnu.org,  Gerd Hoffmann
 <kraxel@redhat.com>,  Thomas Huth <huth@tuxfamily.org>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  dirty.ice.hu@gmail.com,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
In-Reply-To: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 2 Dec 2025
 18:14:48 +0400")
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
 <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
 <CAMxuvayp1WiqWe40Ox69DQ+R0X3VrJ_ai001Z04KbEouFGwCjg@mail.gmail.com>
 <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
 <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
Date: Tue, 02 Dec 2025 15:52:01 +0100
Message-ID: <87qztdrl66.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Dec 2, 2025 at 5:26=E2=80=AFPM Geoffrey McRae <geoff@hostfission.=
com> wrote:
>>
>>
>>
>> On 2025-12-02 23:44, Marc-Andr=C3=A9 Lureau wrote:
>> > Hi Geoffrey
>> >
>> > On Tue, Dec 2, 2025 at 4:31=E2=80=AFPM Geoffrey McRae
>> > <geoff@hostfission.com> wrote:
>> >
>> >> The PipeWire and PulseAudio backends are used by a large number of
>> >> users
>> >> in the VFIO community. Removing these would be an enormous determent
>> >> to
>> >> QEMU.
>> >
>> > They come with GStreamer pulse/pipe elements.
>>
>> Yes, but through another layer of abstraction/complexity with no real
>> benefit.
>
> The benefit is that QEMU would not have to maintain 10 backends and

Twelve according to the QAPI schema.

> all the audio mixing/resampling. The QEMU code would be simpler and
> more maintainable overall.

This matters.

The question can't be whether some QEMU feature is useful to somebody
(it basically always is).  It must be whether it is worth its keep.

Maintaining code is not free.  Easy to forget when somebody else does
the actual work quietly and well.

I'm not qualified to judge either utility or maintenance of audio
drivers.  However, I trust our long-serving maintainers there.

>                            GStreamer has a clear pipeline design,
> better suited (optimized code etc) and you can easily modify the
> pipeline settings.

[...]


