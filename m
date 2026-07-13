Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA7AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNMB-0000AB-1i; Mon, 13 Jul 2026 16:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wjNMA-00009v-8l
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wjNM8-0002cs-5R
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783974862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYnN9/ZnNvCiHJFphpM9o0uEDJtBWzbnzlpkMTNiE+A=;
 b=N5VqqMwT/v6G6rVl7UzRoxpZvL4Wtb2kMmUTcyGsuTcR8QFO/GDhe6kZpFsEKRgNXHYpGS
 +Tw1VBJe/OXfqbIQYxpSGN41PlF3F2rFvzYDaFjPxrrPwC5R1FjfckbUScsA+YHscbaIpW
 D5VvJoaOlKFeFVXZ6ZrxiBno9d4LOSg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-jJ8pajUcOQOSXAJ9n1MHRA-1; Mon, 13 Jul 2026 16:34:20 -0400
X-MC-Unique: jJ8pajUcOQOSXAJ9n1MHRA-1
X-Mimecast-MFC-AGG-ID: jJ8pajUcOQOSXAJ9n1MHRA_1783974860
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e63df032bso31614085a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783974860; cv=none;
 d=google.com; s=arc-20260327;
 b=peHjkgyy9TKestw8Y4YlwYl0ZZtthlOMMdzWfCKfkkk+gkHRpBbUWNlWUp9l+i/2gu
 ZvD+8E1Tj63CPFi97nF2WlcyVKRRRWdT3kV5p3ai6BrngvkmEptkZf8bhQD/SryEWFJk
 7U4Aq1LBrG1THQU1o5BDA1J7iCY84uNyfdeOp974xXvnNAVNKXDtN5ZQF3vIRTnU8Ez5
 VJ60qw+1gOjf/kbplblUyHbrOw3NnqLwuAYzJrKVQ2MU6ab992JCtBQjO5hp4YM25dfp
 Th8648O2aCX1lRr2SKwd6x78SMchgGMUtcRu89E8P+Z9zP9TVc2O1B9KMYZB5vVIfanM
 3rZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gYnN9/ZnNvCiHJFphpM9o0uEDJtBWzbnzlpkMTNiE+A=;
 fh=EH3eS9/+kZbdk6NcbVNzfPP4D1laeF23n7kmjXi9qoM=;
 b=H2Sahx0K+6OXAGjk5XZtx7DjizPab8rl06klSMpZm8X3nW0zxsWDUo46iHirqg83Pz
 +swisgdt4PaWALL5xPVeoCDo7DO1VsfwLVupvQl0WsywIg3DCin6icBRYqiJYKeT0IST
 KS+FEwAXjF4qmoX7XpSOglp6uvWJFLOi95J8By1jHXNuJR+IAVJ8U13pCfb1ewoIi37n
 zhupsldjCK9HWfYCaLZKg2ABvv38ZCcDzKSMGZ9X9FomBDwAdAQ1f9Cj6wpwW755R6UO
 Q2kA1gHBbHTiy/FC7ukFmgAlnuTwywNnmQLE15zU25TjZPV1/b6Uf2l6+IceqwYNTDV4
 JAaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783974860; x=1784579660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gYnN9/ZnNvCiHJFphpM9o0uEDJtBWzbnzlpkMTNiE+A=;
 b=icNcBsT9agIpygztsjWSpS0R8GGL458GvgVgmmR7QtFVS+r2RItKzQItzQkOyV3niV
 hgEcHCAKJGCXps7qCTzOK0aWlKJcI9sj/gOxPkLmlmN5fCEnv5STtTTXC0hL5hU24MbU
 +RLAswE0ARTax2cxQ0mt3HuSYzyNQI26v/CyT4QA9UG+/VMY5+SJbLw/43RYS8Vl5pP/
 twktsCLM2j6dEGhKcSg9hmlORY0Y14CAs94pS5S205+TQh8qFwlfIiYc0dnTxXPjp/a4
 eTkcatDODCPEFgIDL4gPww3uXe9k/ISWkVJnDq/OtcwJ7+fUbcpZSArkVL92HpHhygyt
 1jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783974860; x=1784579660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gYnN9/ZnNvCiHJFphpM9o0uEDJtBWzbnzlpkMTNiE+A=;
 b=RbkDcg1sunYHTM3D/q6QU7sJIyxWn+l3hT8xWioPvMqbi7BUuB7w4y2YiceqInV+f6
 dIQuhSmtCTCQwRIGx1/TyRUlfrGP4ZlwqT9DnMIRab1qsBAsIGGf61AC9njckx8UY6uu
 UEtWeNjpBG75MAYhZDdCa/NKvTUO3OnWvY14FJa44adn1QwPWVk16qMP2CitstzCEPSy
 5tfJI5CikNSRm5FaDoKcyuNJouFTp0fOg61rljrjv2mEAnRuSyX2L7k7S7r6bBuPLdKu
 s3vd0fFnFWcZm6kWVo20LXX/f37kYP2oPh8mJzlwb8gwns3nPtwVbiOtAy6S8QaE8YZW
 MTdA==
X-Gm-Message-State: AOJu0YxcekpFL5KiU+fFFmuKe4Tbhue1WydvqeImsycpZohqsIl6bCUK
 HqGl+V/zHtaPZA/5z8HOggvCK+C6KG06Od9xQawkeARyShVUY2RM7whw7YGsEVRL+isXOsgOfz/
 /RmJS5gtCDYg+EOGiTmBP8nONfUe2hLAJKixrIKIEbrpdg/7es+qz0J3KwaBq9E1rz6j7C4LM22
 ZrU10ZtHfzXZ/o/h9gJeUQ+mzzivfSieA=
X-Gm-Gg: AfdE7cmugAZEewiUxi2I7EWgPH0jyS8cXHxZd3uADJyK03aE8CKlsAp80qYr/vBJkX4
 HTXQ6U2mj1/xHaZVQuVxq1UuS0ik3Tt3UHJ7HEWG11Ls8NPCuhroH/BSmWDgQvmYkZSxuH+FR5s
 HE3tDnWenHBC6/0Lv/HzWNCAsk3sdSisNxWKaBuOza9K/sdFzQOVZsxPrk+6VYsJSm9nLtNyQnT
 szNqBMBxbCHsdsf8sWYZrlJGpE=
X-Received: by 2002:a05:620a:838e:b0:91e:df9f:7804 with SMTP id
 af79cd13be357-92ee4cdaf91mr1584217285a.38.1783974859951; 
 Mon, 13 Jul 2026 13:34:19 -0700 (PDT)
X-Received: by 2002:a05:620a:838e:b0:91e:df9f:7804 with SMTP id
 af79cd13be357-92ee4cdaf91mr1584215485a.38.1783974859515; Mon, 13 Jul 2026
 13:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260629213624.936258-1-jsnow@redhat.com>
 <87ech7gi45.fsf@pond.sub.org>
In-Reply-To: <87ech7gi45.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 13 Jul 2026 16:34:07 -0400
X-Gm-Features: AUfX_mwuwbfAs_MoPHnjnqOa4fh9GUzDICRCNcIN6bbmYIckyG1oo5JkOenzDZo
Message-ID: <CAFn=p-Yu9OV0LJN8rGrc6GTkJZ38XAvP296tfwBxU6CnhLYR7A@mail.gmail.com>
Subject: Re: [PATCH 00/14] qapi: convert to explicit intro section syntax
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 linux-edac@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 9:00=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2638342206
> >
> > Hi, this patchset converts some of the most trivial modules to use the
> > new explicit intro syntax. This particular patchset does not
> > differentiate between "trivial" conversions and those that take
> > slightly more liberty in refactoring, but there are (debatably?) no
> > such cases in this patchset.
>
> Looks entirely mechanical to me.  Am I missing anything?

Honest answer: I am not sure; I have edited so many QAPI files that I
cannot remember what is and what is not mechanical anymore. If there
are instances of "non-mechanical" changes, it would be for cases where
I decide to indent some paragraphs, but not others, effectively
introducing a new split as to what appears before and what appears
after the tabular data.

I genuinely do not recall if there are any such cases in this mini-series.


