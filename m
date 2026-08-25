Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC7AC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypXK-0003u7-Ci; Tue, 25 Aug 2026 07:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wypXJ-0003te-5X
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:41:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wypXH-0004Lg-Ic
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:41:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso43048565ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 04:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787658106; cv=none;
 d=google.com; s=arc-20260327;
 b=Ef1XwQOF1wLU3URFJKUviRdZ+MwbHqfKIMt2P+2ciT59QpXa/ttTIg6StOP2mVnSUg
 yX6ub2jFfjyTnmGuwacjIlISDoC0cgW6rGfhAmeqq+g9Sw1/RClr9ltyzHJHanTK1YNb
 SrQZbd7fowBVBC/GPX90gilRIVHXXqIcv35ivQzTedJ2Z55tlMoVU2E/5U8yA5vgiqqK
 729Fr2PLSl0nJUKy/v/6ME9uyoECH4xmSJaYOgPfhXCal+yCgyR/W1tY4Xk0xpSimIBj
 netNABlCjMDLcuUxxaed1uxT+i4ng8/kGLwg+gtrs2EnHzS66bZCKd/dGHL5fHqyW5Ow
 6DpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sEKpPi1gI/Bt6wuUWLLc6sKuIxbuQASgTNF7wYSkTv4=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=P4yTYS+NvgaaK940esvvLUuEp2U08+cozUgpQ9MlbTkfc7xMARe1QBGqOtV/AOg0DK
 rHdFqVHJVMkxtJhyv34T+/eym9DR3kv7/O6/QRosPadtV8J57mW0ztmkuWsKC9hI5lwZ
 GSTu1lf46u/plJdrDCcNz3JuEpZsiqEZPJSDcZaqftvdT9+9raIHUCmpi25UkXxJj6oc
 5oK0HsoK3U/F966odfoPJfpTnQnMD1iAXCKyG0HlO5AjAVnPTWQJUE+KY1ih/Q4A7MKt
 9pCOK8O3dzJYEB8ddjt2atljQgusqStqdS+RwLBF7WU1/hHTREzziKtqDc1fsvoncpsB
 gh2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787658106; x=1788262906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sEKpPi1gI/Bt6wuUWLLc6sKuIxbuQASgTNF7wYSkTv4=;
 b=lCsdhM4LsIsW6JGSYzzdMnGibBYxAfTXpXWd2+zux7EiL63QK1+QfYY2vDmyV4c3Kg
 iNK2N1EPxJ+LyyJ9rj6iPdu1+qc4xRK4kxEdSOIgmoL4rMvS0xHbfViDbDaqD9OL0/Cj
 V+/DEQyXpSmxHiR/ucRJxHQopr45RNYbYLJcS7qIG5YkqQFOar685vyG0M18SroMdbke
 vUMt3Qr1MposqufL33n197xECRV4adVvpza9w8f/6TsbX8B723NIQTGbLis5aW7oHOpG
 cP+mT+oX3flF22115vEW9Ygni+4w5+w3pb5z46H22GVa706vVXUY/9EPHxSt9nGRg3Ca
 vcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787658106; x=1788262906;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sEKpPi1gI/Bt6wuUWLLc6sKuIxbuQASgTNF7wYSkTv4=;
 b=cuYC4kw0PRl/380hkf3hgtwtjnbsYjTu4+OYS0rEHW1WSNMSAI3bLgq/hvKTGsnNYc
 RAveVKMhXlyUhXQGUiGIk842l4qJznh3acArhdfDi7evqvOerp3skJRNm/9RJj139Vpm
 hxUMB+3nOPCLHirbKo5lbtsgiERZI+IQplHzromAvp/2wX0jR9WOoUaUKzC6JA6vc9Ch
 RPm0dcrK5WjH5VXkCQQWqHM/AiNQsVmTM04vL9iGg353yli1G5MT8o8aTB3Dm+dQ73nw
 3fHnRnRFuVbTxhC93G39Dwxpht5MGwshUoVlq7WcigWSoq01x8dVZrlCAN7f76WmanQB
 56Dw==
X-Gm-Message-State: AFuF++mDqm/ZVrfw9/CFftRBlJV+cOBEk9Lt8Rq05sDT23/KoM5DkXfh
 QzM/y5n0hDhofG3CyZS5WoaxSX32XJILybZhamfeThF/2lE8Fv16/d+W9RIpubUVHvFwFBxaitK
 /HE9agEcj0faOE8/77l8bzvNzOe811HQ=
X-Gm-Gg: AR+sD104swgb/PJQdpj60MMfdmlki9MTmMTclwh+8sFtIHLvHHAjel86aKfhom2uc4s
 AZogmbhT536Fh6de0rh+0eNBRojJERttD7fsoIr75zNopBoo7XkLPcMYrOA9GAjZ/dPB8Tyr021
 akZwzui2NMX85V3gHIUXvNft5Z3X+GBshE5IQve2QVaeRC8F44Xj+NzTM0ZmF1b5swKdwpLOUiE
 DMn33hSolL+BYeWy7JPTGmtF7/jtKI4U3fpCpIU0FaMzNvSzi+SnpVJfBdEyxnwzfXJRuCxlVlb
 BzKofiwAewdVYId3uqWREKnx5Z6uxyT1M83uvWII6jglimCrMk8LQ+P5qrGTrS1s9ANIaVu6THJ
 gh2eP99ifsuQ=
X-Received: by 2002:a17:902:ebc3:b0:2ca:1479:d9dc with SMTP id
 d9443c01a7336-2d64b0427fdmr681480985ad.12.1787658105591; Tue, 25 Aug 2026
 04:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-1-24b8bbbe3d86@redhat.com> <87cxvbzj4n.fsf@pond.sub.org>
 <CAMxuvaw+_7GD5x36g0zxR+zA1pVDcK1j9dT499qa=_D1=UgPMQ@mail.gmail.com>
 <87y0dul9hd.fsf@pond.sub.org>
In-Reply-To: <87y0dul9hd.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:41:33 +0400
X-Gm-Features: AcwNN1WcZjoowTJp7sShJthpUxXR-DvHhc1ZTindW7J6OAPkIOojR9qSD7yZ3nE
Message-ID: <CAJ+F1CLmK+DX0PTde8DebZy9yPG5Jr43JpMxMg-3ho0HB=XrfQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/74] qapi: add QAPITypeInfo struct definition
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Tue, Aug 25, 2026 at 3:35=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Fri, Aug 21, 2026 at 5:41=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Introduce a minimal struct that pairs a QAPI type's internal name wi=
th
> >> > its "masked" introspection name. Generated constants of this type wi=
ll
> >> > let QOM property registration carry a reliable reference to the QAPI
> >> > schema and possibly other associated data.
> >> >
> >> > The fields are populated in following commits.
> >> >
> >> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> > ---
> >> >  include/qapi/qapi-type-info.h | 32 ++++++++++++++++++++++++++++++++
> >> >  1 file changed, 32 insertions(+)
> >> >
> >> > diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-=
info.h
> >> > new file mode 100644
> >> > index 000000000000..97eb1d7bf490
> >> > --- /dev/null
> >> > +++ b/include/qapi/qapi-type-info.h
> >> > @@ -0,0 +1,32 @@
> >> > +/*
> >> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >> > + */
> >> > +
> >> > +#ifndef QAPI_TYPE_INFO_H
> >> > +#define QAPI_TYPE_INFO_H
> >> > +
> >> > +#include "qapi/util.h"
> >> > +
> >> > +/**
> >> > + * QAPITypeInfo - QAPI type metadata
> >> > + *
> >> > + * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
> >> > + *        QOM uses this as the property type string.
> >> > + * @masked_name: Name of the type in the QAPI introspection schema,=
 assigned by
> >> > + *        scripts/qapi code generator (e.g. "368").
> >>
> >> Suggest 'Name of the type in output of query-qmp-schema (e.g. "368")'.
> >>
> >
> > ok
> >
> >> > + *        NULL for implicit types.
> >>
> >> Can this happen?  I can't see any QAPITypeInfo with null @masked_name =
at
> >> the end of the series.
> >
> > It's still optional, but it's true that at the end of the series it
> > should be set for all generated type infos. Let's just say "or NULL if
> > unavailable" ?
>
> I can't find a QAPITypeInfo without @masked_name at any point in the
> series.
>
> Either it cannot happen.  Then the comment shouldn't suggest it can.
>
> Or it can happen, but doesn't with the current schema.  Then I'd like to
> have know how it could happen.  Any ideas?

Manual QAPITypeInfo, like util/uuid.c. I used to have masked_name
omitted. I added it in the new versions. But it is still optional in
introspection. Do you think it should be mandatory?

