Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C393CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 19:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRbDp-0000J6-Az; Mon, 25 May 2026 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRbDn-0000Hr-W8
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:44:20 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wRbDm-0003Ai-41
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:44:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso1367044a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 12:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779738256; cv=none;
 d=google.com; s=arc-20240605;
 b=T3M22ak0D9OXWoMzInasncuEsmZp2MiZCRM3kkTVhW9F0kUAU3ZRW08qVEjVReED11
 hNRoaJv3nuVCelO9uUOJjmT2NJoGadjCKVjTl0/fP9OBGUAIrHSdIjV82cstp/OaLdjY
 UbGpFeOXGppoOASjp2M/wSQZiIW1Zk4cgylW8zX5fsYIVF1yvFPxK2ZEa2zwh0V8Jyk6
 gSOY+BfuQ3KBbOu+3YrgFNXGN86fqVPMnoamfAlFezVq6Iz0bCctMMtGRlLRhyQiy+l4
 wzm4lVna5pOgQ3FJps00FnRXrcLDUNAm1UAyKd9d95BbWqxfCagopLqwGuIYqAlQV07A
 M62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sKC/ixGWpb76RhQE3+CVK+mwqiEhCuUvYSJQNZ4GMqo=;
 fh=Vs/Rc61f7guqBHDlprtyeV/mAT1TbKbX3zIIP+pap/w=;
 b=g4GmQRLRLI9AYZZwh+j5BKIlb6ypwLg3KGiOnOSxIuy7yW1TWKtXAVxw7YnrOXbS/x
 Qm52PHux9f+6O8KpDsLlh6lf7y4jXK/pcxWwosTffp6CU/ACDeuHl6YozSB/uk21dUc1
 Qt2SMbDD7kXAL5DSEQu31BU6JEQQdZXz1NWJh8Grsx2HA3zv2CMC9x1ikQziOJM0wPH9
 wxLUkJQxMGr5yhnr+/OB5Z2Fs07KjD1ECS7t/DhkDp3T68LDlgAVBAiD84sNEOLKXtJT
 L+MtYB3+QBvy5+Qv1ud70zETuqDeqoNYzBktT0OHQZY85s3zmwUe2ddlq/BIhz6OkIxS
 cklQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779738256; x=1780343056; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKC/ixGWpb76RhQE3+CVK+mwqiEhCuUvYSJQNZ4GMqo=;
 b=FqHcU4dBsLMHMVnQGKBaOIonszDmVrrQath1kd3zf2GKq0pGi5HkvGA+es/NFy0RLw
 2EwslHVdGhiYEOQ5D206kict7ZaJW8mlux178yQBckdYt95NqYDNCbYG0RJ4ybplILd0
 fIq3E5Pi97olVRPumCsr1dzxhkSlMHRIK2kAWD5/VbAdOqhWkB2ho3MkAsU9caOaYZNL
 XCTxeI/tAcZ5j0e8n4/3h/f4Hn7AXBOt+iur4Pu/jqGqVL/Degp4olxE5BMzgqzNXk+k
 iaszifStL3cfrnns/qDwUAbmBfDN1LVtpyitWK2h5oyRuS8Ak6wqNajZ6Za6KbFiJTn+
 fn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779738256; x=1780343056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sKC/ixGWpb76RhQE3+CVK+mwqiEhCuUvYSJQNZ4GMqo=;
 b=JEVcb0H48MbdIaNe6OJp91VUde26JYXQYoK2wNYv9nuBl+da9+EEunNTX7ax0nPCxK
 Uu0carDe+UHl9euo2tegIh1NpgMjfFQ+03DyOHpt3OZvZGQI8ZLt6x/EnKG0MCSaF6yU
 AAZhW1AFx7Uc6E3gQ8q6TNS7/57jMotX+Txb9D+r6CTYMXfPnJV49DY/iKBeAuUAM7cb
 81wA2WG3lcwCiAwuiG+fZFk+wIgKNtsXI89DHiwgnZjWdVwCQN8sY+Lt1GR3AVj9Rr+y
 4ncsFbGLV3PZydjZOAn8MI0UGBMQBJ/GHKdcofgeCWbvNbBMuAId60hsmCv7PHJUwJH1
 lhog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/j0Wn16zuWdckwj4VdiX54lyVIJTg5VLJE6p7UWIr/bLfULp/w/gUurs+tXBt7YrbYhJiZ7qfDPPPx@nongnu.org
X-Gm-Message-State: AOJu0YyWKZcEzRqr4/zdC1DeB9KUbfgvzkRhrXPgbE/WUDiUsIdrxRwG
 ZB3eAoJzG+cSTdBTl8zsGoZ+p7iXyzFg+JLSjEeeMRW7sjXnGKiOv/ZQHrQs427M7c4BL1oTkko
 cXjyGk7mtt/nFaVHIOyFQoC/fBc9+utA=
X-Gm-Gg: Acq92OHmpwYhlat3NMzi+hLGeoEitO6uWSb1+RDhsTRXlRvru1f1ooR6+Eifum01Che
 UdqEoBfv15PRrIhjTj7eCx42LVdYwN1DXRf1sTR9d4S6XfaOFNkX4H7W4wDRiiDPXhny45zbffK
 Ty37tmOpfHmXR0xmqOTi4odJzt2j/zabt8tDdb9OfCfbx+FhxZpbqjNLxfwfeDFTEA51pBTwONJ
 a0pvHLs1BwHpioO/o7JxlwgpAxcXDDgtzVm1Z0Va5+3WDpgST5Yb3pO8XmGzAinb+4XIHxOcGCf
 z3cKaHE7GHo14T0rHjm0Cu8gGsWEWapmzV06YgQ+MLzZU9CtX0YX
X-Received: by 2002:aa7:d951:0:b0:678:a5d1:ca74 with SMTP id
 4fb4d7f45d1cf-6882f1dc379mr6052456a12.16.1779738256254; Mon, 25 May 2026
 12:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
In-Reply-To: <CANCZdfrn61yr5k=3=E_zE11dw3j2vVsg0PPn0PZ7RAa2agM8kQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 May 2026 15:44:02 -0400
X-Gm-Features: AVHnY4JvX4nOUETka8-HxIzuVLzp_p9IY9qE2x0T7q56GqZ6jnF3VshXmKFhBYY
Message-ID: <CAJSP0QUmh4RLFUg9-5Uky36Tjhr_cLkrE2VAC8K_MdSY9p0WZw@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Warner Losh <imp@bsdimp.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, May 25, 2026 at 1:17=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
> On Mon, May 25, 2026 at 10:34=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>> On 5/24/26 14:42, Michael S. Tsirkin wrote:
>> >       How contributors could comply with DCO terms (b) or (c) for the =
output of AI
>> >       content generators commonly available today is unclear.  The QEM=
U project is
>> >       not willing or able to accept the legal risks of non-compliance.
>> >
>> > But, since this was written, Red Hat's Richard Fontana and Chris Wrigh=
t
>> > published this piece:
>> > https://www.redhat.com/en/blog/ai-assisted-development-and-open-source=
-navigating-legal-issues
>> >
>> > Saying, in particular
>> >       We understand this concern, but the DCO has never
>> >       been interpreted to require that every line of a contribution mu=
st be
>> >       the personal creative expression of the contributor or another h=
uman
>> >       developer.
>> This is not the objection or the worry; rather the question is, what if
>> the contribution is a creative expression of someone that could claim
>> copyright in it.  In fact, looking at the Linux policy...
>>
>>    Signed-off-by and Developer Certificate of Origin
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>
>>    AI agents MUST NOT add Signed-off-by tags. Only humans can legally
>>    certify the Developer Certificate of Origin (DCO). The human submitte=
r
>>    is responsible for:
>>
>>    * Reviewing all AI-generated code
>>    * Ensuring compliance with licensing requirements
>>    * Adding their own Signed-off-by tag to certify the DCO
>>    * Taking full responsibility for the contribution
>>
>> ... the question is how humans can actually do the second step.  The
>> piece you posted above says: "with disclosure and human attentiveness =
=E2=80=93
>> and oversight =E2=80=93 aided where possible by tools that check for cod=
e
>> similarity, AI-assisted contributions can be entirely compatible with
>> the spirit of the DCO".
>
>
> The code produced by AI agents has no copyright. You can incorporate
> public domain code into your work and have the absolute right to license
> it (see all the Diseny movies). The notion that LLMs wholesale copy origi=
nates
> from the earliest days of Copilot and turned out were contrived. No recen=
t
> evidence shows that plagiarism is a concern. To the extent that I modify
> public domain code, I have a copyright that I can choose to license
> however I want (and the SOB says it's compatible).

There is an active field of research on memorization and the status is
that LLMs do memorize. A paper from 2026
(https://arxiv.org/pdf/2601.02671) shows that production models can
output significant chunks of Harry Potter, although the research
deliberately extracts training inputs rather than doing so
accidentally. I am sharing this because I don't think it's correct to
say that concerns about models outputting copyrighted code are
outdated.

I do think that the risk for coding use cases is low as long as LLMs
are used sensibly. If not, legal cases would have popped up by now.

The example of ext4 for OpenBSD (https://lwn.net/Articles/1064541/)
comes to mind as a case where LLMs were used in a risky way and
maintainers decided to reject the code. Even though the output of AI
has no copyright, when there is no suitably-licensed information to
generate the code from, then it is risky to assume AI generated code
is free from copyright, license, patent, etc effects.

As long as we keep the usual practices around intellectual property in
mind when merging code, then I think the risk of copyright issues is
low and not a blocker for accepting AI generated contributions.

Stefan

