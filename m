Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CC8C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2E3o-0002gh-DD; Thu, 03 Sep 2026 16:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2E3m-0002fx-Nu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2E3l-0006pB-AQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788467360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HkxqSYnEmhZPbHSQ88dINLtxrj2fJu13zc9SE/gwn4=;
 b=Vu80bKWEfu5R/w/YvI8P9b7IQ7XSWWf6ejj7qX37HCFXymB/i4i0ensRzO/VFKSapIC0fJ
 2WJiB519eAxOj2pr85i4NNzozr0X7uU9ysQk9A29qZO342zRcIGgA7QKuNf95OTXneI2vp
 x9b5Yk3wLF94EnxEaWmgBev1S8fZ5xI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-oCl8c7QyOYOLUpsquoykXQ-1; Thu, 03 Sep 2026 16:29:19 -0400
X-MC-Unique: oCl8c7QyOYOLUpsquoykXQ-1
X-Mimecast-MFC-AGG-ID: oCl8c7QyOYOLUpsquoykXQ_1788467358
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so284317a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788467358; cv=none;
 d=google.com; s=arc-20260327;
 b=rjAHxGnMqNnaLaICYberKaarmp/SMYDD7Qhj1UNx4C3PsncB1H1wnsfEvhZW+HD9Zi
 YqaSwgKqigAbIFKBqksBo0PT4a+Igm0dpQMLgOwDUTyTh05LL0xx8LT9x1vak7pCQZQf
 noTsT+mIpoht4qwD/RCy+oTleQrzADp1CHumGWdznT2uqa+5YZ9FCnJE9Nkkmk1ZcUUy
 7iPLltyJjcKV4JT0oyrsYGLQlrQqrdmZASBTaW0gqWjuX1qQNMB2K+Odo86PTNJQwpIm
 5FJbyOr1k4bktMAbj8lHZaAk6LxbsinIRFkyIHgiwbucq2jo0OMxEB4N9D1tOy39IGn/
 CHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4HkxqSYnEmhZPbHSQ88dINLtxrj2fJu13zc9SE/gwn4=;
 fh=aYSX0L0JbPAxJKGqT0QN2He3mJTBEOQF0ihNZH/GTvk=;
 b=Oe3Vaekh046QhCh/6Y4Ss57IzMq5VHOvanKhtrYknaIVogw4OUxcMUS/hU2+jYJi9T
 /sduZYpr57bEQB+HGUKlZgQUgDBleBf9Q8mSzBOuB2UVMx2M/dDASNQYOTxUgpNbdIBx
 VtRXkLxm6nAc4StNW1D+FfvFGfVJ9XDh9C4W8xtl+WUtSlXxEWk20KMVfHhD8lLtfDNm
 g0WIJelG9TU439ZtRzGEw1vZ5ina+Bicwx7aq/vfz1DDsmJo70C30QVwWMLgroR9ySRn
 zrEFV6rNjW0hq8gy3dp6HM0taP633Vh6pAocCchS7qsM1qV6ZTdLgfDJxrJYMzijttOg
 AdRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788467358; x=1789072158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4HkxqSYnEmhZPbHSQ88dINLtxrj2fJu13zc9SE/gwn4=;
 b=k2ev0MIdS3VZN/mSyUA+WcujAn9dJ1DWaz3jS361h5K716XzuTQsCM/DIwAK1lJNns
 F3LIZYCWoDv5iM7cbg+43a80oI8QTPDo/3dKBzpFy++l1BcEboxiFHhC+6/rYCq1amYn
 dbFi2liqkAbnlD3pjGZTCCQFqLw2msN5VzEPdRtKuamWVCjni9jCTOcRHbh3SB7w6nJ9
 cPY5L4Ey40YTzWFcAPHuS/Kf8Rx7Lv8G6AM80HqEMuRqOBPSBI9WEpDJJrap7onlKkhI
 Rq7jhRfkoRAAhUVoGU4YlULOEny3BegJaQPFuwKxVH423Gw5AaCwnYjQYeGpGsp6LJ1b
 vRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788467358; x=1789072158;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4HkxqSYnEmhZPbHSQ88dINLtxrj2fJu13zc9SE/gwn4=;
 b=Nt5YfrdY2vlyjEaWB5+nxzS5GntX3dACSkyjghbBrv4MNiIBzypFFpxQ6YregcS3MR
 A6OFBM76s9z74m110KzoVnyOHNFtdCnVQDpBPgbBxeeGansjP4vgDIpTdtrJ2G7x2SoA
 KKcQM18HgMJ+q/6VKfHFH5BvEwrvKTvNJADnypchsGZxnDnhD3qUX74M6itsqw0HT7OZ
 MHTQhHRuUUikKmUrhqSa9a2Hpnljcs+Tlo2gg2vE6sBxC059edfNniTHvbsWOo6mF3H5
 J0DeaX384eN3IxFXt78AGHkVrZfKZt7cEd0zCwFxE4yp8CRhbDytd3MN/nopp6xnP6CB
 Xpkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqD4KRAT6yIK+uMvzjf2gMR6BzBaeNryO7Le9PtOVS1zR3KXalgNxpPHVrdfHgb/eTqRarQRNCG5A1@nongnu.org
X-Gm-Message-State: AFuF++l9PyFEAaAaMlTHHupWRqkMGoIthMcOthBLzbHwUU694xgLcuXx
 QTu9gy6MN0GdyCtJ2l1YPaQfH1rPFu1OVbshoEbcX3EKyHPUy30uelxIgtkXYo7h2Z0EAZ2Zi3r
 c8eYULltyP62nbpF3Vvepu9KWhK1yzLSyzyVN044cLLHtmloXftCBqpGlMY6cmVyD4qFeZYigyj
 ngXYtsPNExU8rKKk6iSDuUEIenM8C8B8M=
X-Gm-Gg: AYBFou0KpAIH99annTiRhmbFcMvU3PedAI8DoqohWrHfUI98ncXptW7elMiV1XjMjIV
 fh0Y/v0KXVgFSiWD1nzmrwutVcnWVHCEdxZ54SXZo61pCbKMIz7M6yuHxu0YzPlxE8WQuScafda
 ptI7Nb8dBOstBZ1LEy98F//DhJq+5I2bmZAh9yxw1QZhOMr1sKqTJnvM86DABg02q12u+VLTpz0
 82GF7USKYnFmx8YpKLQ1hIlnD16IXLRW559ufAQp6G8DVWjnvMf6gLn8QbPro6l9xlIc+eFT3Lg
 Gw==
X-Received: by 2002:a17:90b:33c1:b0:398:9bd1:3214 with SMTP id
 98e67ed59e1d1-39b262dfa81mr1303517a91.21.1788467356251; 
 Thu, 03 Sep 2026 13:29:16 -0700 (PDT)
X-Received: by 2002:a17:90b:33c1:b0:398:9bd1:3214 with SMTP id
 98e67ed59e1d1-39b262dfa81mr1303441a91.21.1788467355528; Thu, 03 Sep 2026
 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260822104329.42121-1-christian@quante.one>
 <CAJ+F1CJNFWBzHHxteGW8nzow7yQz0WEJ9Jq9nnb=nnZkY4hf-A@mail.gmail.com>
 <20260824112307.223856-1-christian@quante.one> <87mrtyh21i.fsf@suse.de>
In-Reply-To: <87mrtyh21i.fsf@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 4 Sep 2026 00:29:03 +0400
X-Gm-Features: AcwNN1XH5KXMQRSVnHVuczE-myp2bMZBXmzOlE8WP7Id10Bhs-CnXAdIiZ1n20A
Message-ID: <CAMxuvaxdnUQNhCsgapy6HRFdygxpZmms6YRUtveowfOXMAmw2Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] tests/qtest/fdc-test: give each test case its own
 instance
To: Fabiano Rosas <farosas@suse.de>
Cc: Christian Quante <christian@quante.one>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 3, 2026 at 5:56=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Christian Quante <christian@quante.one> writes:
>
> > Hi Marc-Andr=C3=A9,
> >
> > thanks for testing it.
> >
> >> Series lgtm, however it takes ~10s more now.
> >
> > I can't reproduce that here: fdc-test goes from 0.8s to 2.6s, so
> > +1.8s. With an --enable-asan build it is 3.4s, still nowhere near
> > +10s. The series takes the test from 2 QEMU instances to 16, at about
> > 128ms each.
> >
> > What are you measuring, and on what kind of build -- fdc-test on its
> > own?
> >
> > Christian
>
> The timing looks ok on my side as well. I'll queue this series for the
> moment. @Marc-Andr=C3=A9, feel free to object.
>

No problem, I couldn't immediately reproduce it. Yes, I was running
with ASAN, and another without it, and noticed those +10s. But I was
probably doing something heavy at the same time.


