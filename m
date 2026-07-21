Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9EFC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5wd-0006gp-B0; Tue, 21 Jul 2026 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm5wV-0006fL-2e
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:35:12 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm5wQ-000424-IB
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:35:10 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-80bb41f7f3cso73815727b3.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784622903; cv=none;
 d=google.com; s=arc-20260327;
 b=Uqa/8NH+G6CvPJvpiECxtSczwM4Df7QZQGwSI7HGI3/CjndSp3Celo2gmie0THJhU7
 V3lCM3achhHF8m/rbUPeJSCBmPtCYds7i8flMYDssrUWaTyCC5yWiwXzvuZUyixxvlmk
 zEWkZ3z27YJUHI5qwI+HQjWr4ux/ZziPwUhfh5efS/ijR4FAPgLOsTx8KQpL+IawaE+U
 ZRn7emVM0kXt8YkTTzniodCYY+s5mPawnFqhIEat0GnoszMCiD04sazzVS0FWWb4JS7L
 qph2Wh0V7UkJceH9tF3XrZIvRpRoqUiC3Ian5RQ4undDtoe8vZnIearyRTblLF1W46Iy
 G1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IrmkLwf4+67aWn5qzOqm/gDr9cMs2HkMDKGuT/jGPfk=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=B6LBV18T3I3IWxOwj5JpeSKnwTlAsmyU1KBnPz8SPKQH3wMDKbjq1AXaxUzDqlSLQM
 vo+rpkLVrGSsrnfqMH49pqOJzBClzssyAcOBH6KkvKRGaXyphGRDjhU76qWq3rAtFKje
 iQKslgJ1LrBuiJtKNC4sjRiHzfBK8npqoo1QAE+K3BiFRCyLKsTOKbnHV4NNSKrtP1FH
 5dwKT8bGk2FDBpfV/UFfMFr0BlraVwCPP8/qK1vrpEq+1s+ACW+PXTNKgtQngNxre4R3
 aSi/mSpEm6afeVU2aJmIErzfDKJM7xvkcDJiR+4oLLixXPOjPr2+H7dVjdgSAVdekfgS
 EWSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784622903; x=1785227703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IrmkLwf4+67aWn5qzOqm/gDr9cMs2HkMDKGuT/jGPfk=;
 b=Ma7uxXtGJWdwJt44CweKoa5h7Pe2tkqG/7LnB2lfOYV3nW8s2b1fDZz6WZg5BSkEuB
 y3NsJJjXVKY34Stj8FUAcNrU3svxLXB1wqHvtAlZlyJigP2l/eaE/zx/tlO3Fum/FuBz
 DimyvfXwsaOUGsNzhXCtO9a8Od3Bk69U5FjcA2lGKdW8UOBfSYtZKsxrwVbwvcmfbgTw
 43mc0+fFxxBtZCRx1Svor6HJayWOiWLxP/kkN84RV+BosoRD3SfUO9vPEm4dziKK8+qP
 /+i5WiPMlffXI3+RrYoyhivcupCAaZz3ypLJlmzP537Wm4ry1aNdjMBTF17sFC22gY0Q
 zuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622903; x=1785227703;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrmkLwf4+67aWn5qzOqm/gDr9cMs2HkMDKGuT/jGPfk=;
 b=kcPvz1D5cV0nZ3pFpovv6PrdUo9+S3xBXNAZFTZaDkEEa0HWzpWVWljN8YqLbTc99p
 yg1qgNLv3jbRBAKgNufa0oMBZHV8OXVnfgMyV0lH7FTLZllp21zUpKvnqt8Qlf8ebRlE
 ZSE4cKqGCQ2z/xmeeOT4h8YCt8nmqubeM0rpj3mMZA0+Gi//bNtm9xqPrWfIDUUEpvBq
 bV+e5UezQN2+w3MJP8meI9KWp7Fu9baWEEfZwZIRfAxWjdnfEzx8r3qDKz2HVcjLZtRA
 CQ/dMMCuuK30PPEnT3ySlSgnNjckQJmY6k8zdTn8FLXlqw4pzJRp1bEmyshnzXyGaubi
 D61g==
X-Gm-Message-State: AOJu0YxUKcVo8m6Dl/Ra81wA4TAffEJatFkNFE411nwrjZS1SDvwl4XH
 j4apz9XILkvo2F2IG6nmTXcuTQ/DTSOo2aeqHo+isAdyn5CzQeucZCgdxeGTr7xNEQdgCHVyjQa
 PfN/tkWAuSuhEfZAMZb24Q55lq+ZS8v+lJP9J31QmsQgdavMuxFUx
X-Gm-Gg: AR+sD12OMoSGU6jf0sISABGe/NQaKruXGY00Qmt0kUxBf1SB+CdAQ81fHnXsTOawx1K
 plD9wHXKnoR/of0S1r+gIi2+M/KoWMXlCw+Jq2AnMrf5SbJIXqXFL5RI7ZbfEoS4tqomEqoYmzJ
 bS6jtqQ9dhRuscsC73p/df4Vu6XbvJ0yucon6f1JuQbUmSmkmQQkmb7V5Ol9MoE6/Uuu0g0boRe
 tl7XTsw0GB5TZ0jmfZTSXBDWpUMDrfBcRjKB4qQHXPGtIxhmgak5nxWLkwZIZcR0Sf/BjmvVV4B
 1+0pF4lZ7PiRwX8nbl8dFy2/lA974h1C5xJv6qilpXpnMIIXd9EH/vJx
X-Received: by 2002:a05:690c:6c91:b0:80a:9f2a:fca2 with SMTP id
 00721157ae682-81ef2601168mr54427907b3.54.1784622902821; Tue, 21 Jul 2026
 01:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
 <20260717-fix-v1-7-cb9f7d49dc52@redhat.com>
 <CAFEAcA_jkg8G=hQdsS-FEaHd658SbJqTzMAWrmvjREmXXbx1hg@mail.gmail.com>
 <CAJ+F1C+mwgu_m48L-uGmuPuzmMr2W7jCPZeMQP00mxBx66wacw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+mwgu_m48L-uGmuPuzmMr2W7jCPZeMQP00mxBx66wacw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2026 09:34:49 +0100
X-Gm-Features: AUfX_myh7WBoqgWqy8mV15k5c5-zT0fb-72NDeUnpiyFCvS7gnt6cqSglF6VjFs
Message-ID: <CAFEAcA95uVJzgOf0wNFUCPoOrUmR3KVzZ4xzdbQW2qRANfFesA@mail.gmail.com>
Subject: Re: [GIT PULL 07/15] ui/vnc: fix out-of-bounds write in lossy refresh
 dirty marking
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 21 Jul 2026 at 09:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Jul 21, 2026 at 12:18=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Fri, 17 Jul 2026 at 12:54, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > > +    rows =3D MIN(VNC_STAT_RECT, height - y);
> >
> > Hi. Coverity points out (CID 1664010) that this added line...
> >
> > >      rows =3D MIN(VNC_STAT_RECT, height - y);
> >
> > ...is a duplicate of this pre-existing line, so it does nothing.
> >
> > Were you intending to clamp a different variable here ?
>
> it's a rebase/merge mistake, original patch:
>
> https://patchew.org/QEMU/20260710134921.2321027-1-marcandre.lureau@redhat=
.com/
>
> Are you sending a patch?

It's probably easier if you send the patch -- I don't have a
setup to test VNC at all.

thanks
-- PMM

