Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B298BC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17Ao-0008MX-TB; Mon, 31 Aug 2026 14:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x17Af-0008LU-V1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x17Ae-0007s8-14
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788202550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
 b=Bxzp6/tkKPPMUCXjaSTsypmTAWO2TodBVOVXZcnfZ4Y1Nt5c5tLh8U4CyLJrTe8x91Y3E5
 yYXXhdTz/qSMn12heqjLbBvgro9cshINp8kKKjsCWCRyfrcTCKbt9Qvx4F5OD2RyWvBj3D
 +G0wAf24dCXGllvMgNWU7eL9iiBICjo=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-p5Q0tknFOB2hY1rn1WyNiA-1; Mon, 31 Aug 2026 14:55:49 -0400
X-MC-Unique: p5Q0tknFOB2hY1rn1WyNiA-1
X-Mimecast-MFC-AGG-ID: p5Q0tknFOB2hY1rn1WyNiA_1788202549
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-66ce373dc9cso4536771d50.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788202549; cv=none;
 d=google.com; s=arc-20260327;
 b=PZ1ViHvFAW7sLKcnLJGQwyle41hOHOctXeLwUqQw3kbCnCP9mVKxtMil0dJHB/G9vz
 QJsaqRF8NUFTSKAY0dR2gu8U1673pzbEgsMNNB7R27jLmDenmtJU9nuZ6E6o8GACZR99
 oU50EvEJEPcmAtBAbPdxfOXnyMcV4p29ISN4CC1NTviJCBrPAKJAP+E+0iFQVsKjg4O1
 jH2crJGzTGiKuMZjk61O1pKNd72ypKFXNueDQOZ6aon4f/5IbOUeyz12QS53zTx1lePx
 73L8OrHpeRnFKMddCxKLjHHLZm55o9IjlC3/yH+06hE9H9b7P0b4yNzX2aAOH9UwoHPX
 tmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
 fh=Cp5280I+N/+SdjVt88oMjWVT6nDY6EErbO1MSWQuHJo=;
 b=d4bkG8VzK0gtbmQpNu8GNPHbnbVYv4UzQFvNA13rci21ZTs/MYKAgOUWDb18tAknJb
 PXQG0aUIAhq+T4XxmHp4TbPki6i5H0tIzYPFKtnsto9oZyf1g5VO0pwHEe4Q3cZd1MHh
 g4rVeTIZTS6C96la2EuVeuo0oxFQvcRvVWXUmADvwxHIbaL0Eh7wSE6F4dQrzTd1Cm6F
 E2p58K5r7lMAw4h3T2d1oA03FkAMHOhcmMus+tK799HcLWoQY0Sh9W1zbu8+YXHSi+aA
 r1ra6Oa8LxUwcsXqGhIXP+kexsP75XNmClXHPh8cKfK+qslzMT57dMGcDf/hXYuifco/
 Tx5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788202549; x=1788807349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
 b=kuqUlJkJO1gAbBavFS05zSWg8KtdEC1IFO12LfjfDdxUvppnJ2p8V20pVm4jNKaM2u
 waJyTRY79dF0P7rhvv97nnvoUAoune4+XAlOYE90/jSwVgq24YkMpwNIkUSa0VyLWJ7t
 6L1ZYsaTX6Z/Myx8wH9xcHMpaWT3NKmkEZzJgFB/xIwhIjDqicB/ujLSjCwMXF28C9S8
 IWxsy5kGEqM3WpVNLIV+kBVx/OrcVRgO7GY4ahpGTQNYppRNWDbVCilAQxv9Hn6puWE0
 0q2kqh1kdsseoT1x7XSqAkLnnJam5Z931azB3Sp/AcOWQMVY3V8Hdd2WmEamS7vnvvrD
 nz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788202549; x=1788807349;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJ5EPZcsW3BeU/Du4PIisPviXsXnrKzOxO6xL0idyrw=;
 b=biyh0MayVAiCLqlXzsaHXPQJBkFjVO5sOdfkWNrNwon0bKGJEwaIb77hAgA2GS3Ei0
 JRcBS+oR2K/jqndpKBYuFnv3CXLeCYGjMdPOzHo55QOHKm3fPh1sPoPD5Vn2OUmAbj1I
 C2WRLDkymoX0Gz5nm2pAAJmhtnJvAotSyGg9xIMy08WysJz/MUXLB9KQh6K5SO6zvptn
 XGSgKrduP2rKEQSx/YbYojqVOdmvakN69p5RRUPItkKP3vUxHmv30o3VW3Yxhn1w7WYW
 /8XYrZYGMljHzkKw1eIO7NjQy5jP0tNSxVuDA46gWlIcES0CYzOIiueUeKgMXkqAC6yh
 WjvQ==
X-Gm-Message-State: AFuF++mjBbWXfhnPAmrsfk8+S0KXZmUJAUQI7S8Yad6sIt5Kf57fBc6r
 lMUhwAysNZFpfu8FK8clntgqRui/vAsvNndjl3OCbLqOyzF2hz+ubZ4KoVWR96S5oKxkIzOt5z+
 +bQl4Pw6+j1nj4PK50mzKqxqO12GFFAwJe58EyC/Nk/G0FQ0FOC7+tc6GVt8XAbUVU9oLiKorrV
 83ntFTEkr4hv/v3GcxhsS7IuIAtu/Oe98=
X-Gm-Gg: AYBFou2q3jx9RPx9KMLk5i92zBtkaEhiD76qamfH8ADnmKqR2fZ0ZPB5q6HTspJvUOX
 USbekghdyBAg4rbJ+W3/6vbvIxqaQdfRxYWrZuyTAFo/alWJT2U8NIgOCZDdvEPtxXlaeWJE+ka
 Oye9TfZkfvvkBCAtE3YplYt5/s7SV5+olAlxx7MxK/m8JaaOmWIq7TNZv8Fbd/QbP+9JPpbgCXi
 YqQeXu1fKT+6sqS
X-Received: by 2002:a53:c30f:0:b0:66f:8731:8d1 with SMTP id
 956f58d0204a3-66f87311ba5mr991086d50.39.1788202545345; 
 Mon, 31 Aug 2026 11:55:45 -0700 (PDT)
X-Received: by 2002:a53:c30f:0:b0:66f:8731:8d1 with SMTP id
 956f58d0204a3-66f87311ba5mr991075d50.39.1788202544932; Mon, 31 Aug 2026
 11:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-32-jsnow@redhat.com>
 <877bl6e6so.fsf@pond.sub.org>
In-Reply-To: <877bl6e6so.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 31 Aug 2026 14:55:33 -0400
X-Gm-Features: AcwNN1UG_VbNhAzp5JMRR0NLbU9hcA9dfPYFAhsnI6iviTHK2XjRUfYMif3KYDc
Message-ID: <CAFn=p-Y7AO1QRXGHFsahnWtiERbDuBtFtAj0c6wphrLdZmy4_g@mail.gmail.com>
Subject: Re: [PATCH v3 31/43] qapi: convert trivial intro sections for
 block.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 linux-cxl@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Jiri Pirko <jiri@resnulli.us>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 linux-edac@vger.kernel.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 31, 2026 at 9:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block.json | 41 +++++++++++++++++------------------------
> >  1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/qapi/block.json b/qapi/block.json
> > index 46955bbb3e3..189f2e28204 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
>
> [...]
>
> > @@ -314,12 +310,11 @@
> >
> >  ##
> >  # @blockdev-change-medium:
> > -#
> > -# Changes the medium inserted into a block device by ejecting the
> > -# current medium and loading a new image file which is inserted as the
> > -# new medium (this command combines `blockdev-open-tray`,
> > -# `blockdev-remove-medium`, `blockdev-insert-medium` and
> > -# `blockdev-close-tray`).
> > +#     Changes the medium inserted into a block device by ejecting the
> > +#     current medium and loading a new image file which is inserted as
> > +#     the new medium (this command combines `blockdev-open-tray`,
> > +#     `blockdev-remove-medium`, `blockdev-insert-medium` and
> > +#     `blockdev-close-tray`).
> >  #
> >  # @device: Block device name
> >  #
>
> Not sure the parenthesis belongs into the intro.
>
> I'm okay with keeping this hunk anyway.

In this case, it will be fine as this is a command and the precise
split between intro and details is a lot less crucial. It can be
adjusted later at our leisure.

--js


