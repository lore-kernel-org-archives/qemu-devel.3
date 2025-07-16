Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1557BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzX8-0000TS-OU; Wed, 16 Jul 2025 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubzPG-0000PN-9Y
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubzPD-0005gM-N4
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:33 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c60f7eeaaso10122725a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752661829; x=1753266629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udL9dp1sxQFxuNLN+rJLfqt8KvbMC092zbPjEitCdYM=;
 b=PmE8e0FBEDrZraQQref7IE1LpTbk+NJxrU0KvCJuPDXdIZz/Yd3u6lRr9ONZhfHR+5
 +G6JzjUgr2L9ZUqYczmn0vjkvJoL6U7QNtsc2n9ktKZP/M79VOHEFGg1mNwcKjVRbolF
 IBKjQTTqByRbC9T8lCwuvGM86wUoNWubFNi6ACAm2pSBAp5jpDCkPSTnFRG6yMvQQnrC
 rD5W3BgsMXsT/0Hozx6HmUX7NkS5BuhpY5fIy10/Pren3y/xGQGwG/72fWFNs5/+W5mm
 WtlojobetMh23CeV14xA5P2SXTbVAPwiCUnDbDKppqB39l/FNiPOV12F337QPV1ApX9k
 BAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752661829; x=1753266629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udL9dp1sxQFxuNLN+rJLfqt8KvbMC092zbPjEitCdYM=;
 b=CEs/KSd4PynJNSw8htedfzh+EQqhR83mjTa9qAlkl0/ReylzKhDiwWcQgpsotp9t7Q
 9PYp8XZ6N7W3CfZBEudvt2TJB99HqQMHlb7XDp/PAJxZWJKsRxmW/eRedEpoyCnviV5q
 ZjVR73rejj18pzFDv9V9gVFnk4A9ielJmofx2M3FxN7U1DrNNLD/IeETI5xpCv1UOl2E
 4pw9/zkkSxl569r+8LR9JU3ln6df58DTE+GtRmxrMgguKSyYug8IfKOdeB1T1mF+uOWZ
 rHeP2MJnNnSle1p+afuWZ6sEcnM5PXqudpDwRwMARKwSdRJ+bt3Kl76lnDVIsH/7Jzd8
 DI1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVakrmzR4ULCwXA4pVVHrHtlKKchx/qxW7BdSQg4nahTgMJVfhX1U6TfydAQn25ip5IWUfqZcF4oBWW@nongnu.org
X-Gm-Message-State: AOJu0YzBTgCpkst7JTEGDZ2T/tSWqdcUCSK8ShMxLei+c113CXiDMO3+
 C/HY3j9XK76K1Vgv9eNcvu08aqtHJT/uszq01aHND7Rs2vJlz/nTwU+PU443DnRLCMwsPVzGc1L
 hvWN9Ia3V4+PwzflBbWqVC28JLGtjxAyoDQ==
X-Gm-Gg: ASbGncva1tZA6lA9xbvhB5N1XwxBJuhBJ8BXhLra7JAYGugv2omBfpM7vrqrJGh2rfD
 HRGaMz8pyVhf9co5gN2uNJ3GVKRU9HBsAwrKFUh9SU5vTVbQpsLp0T3v2BwYJyuEtK0n4g8IgY/
 g9op0G/b8hBa57a4yLl93jNF1wIyiWO5F63tsryLkWKMH1oJ+G2vJ1+8+L/kGaADmWbKg+uWRRD
 vU/sA==
X-Google-Smtp-Source: AGHT+IGSyo0uTwRwkPkBHFwVr+8rs+k/mOfRyaMcOqYPCaLapI+NPXEmPle66nPJqsEqgMcMzlCPF6chlBsGRW01c/U=
X-Received: by 2002:a17:906:730f:b0:ae0:aede:8a2c with SMTP id
 a640c23a62f3a-ae9c9ac14a9mr319298966b.32.1752661829287; Wed, 16 Jul 2025
 03:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250714053423.10415-1-jasowang@redhat.com>
 <20250715195028.GA242340@fedora>
 <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
 <CAJSP0QUOY9V=8Hkj4O0ohtz3u2nFxpbr0JxLkMiL3iRN27vXXw@mail.gmail.com>
In-Reply-To: <CAJSP0QUOY9V=8Hkj4O0ohtz3u2nFxpbr0JxLkMiL3iRN27vXXw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 16 Jul 2025 06:30:17 -0400
X-Gm-Features: Ac12FXyVghIa-NVeJV09YyhxAIGsIRSbtocmLcTOfY7Bo-tmqGWJ-zcsgR6eGmM
Message-ID: <CAJSP0QXDv7hQMGJCdKnkwvn++N4KBH7+S856KTgb8SGVgb_QvQ@mail.gmail.com>
Subject: Re: [PULL 00/13] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 6:26=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Tue, Jul 15, 2025 at 10:23=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > Hi Stefan:
> >
> > On Wed, Jul 16, 2025 at 3:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > Applied, thanks.
> > >
> > > Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 f=
or any user-visible changes.
> >
> > I sent a V2 of the PULL:
> >
> > https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg03794.html
> >
> > That includes some enhancement of AF_XDP. Considering you've merged
> > V1, I wonder how to proceed.
> >
> > Are you ok to include those three patches in the next pull before hard =
freeze?
>
> Hi Jason,
> I'm doing a final merge today before tagging -rc0 because I see there
> are more pull requests waiting. I will include your v2.

I got ahead of myself: -rc0 will be on July 22nd (hard freeze).
Yesterday was soft freeze but I'm still merging the remaining pull
requests, so don't worry about your v2.

Stefan

