Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8073FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jpQ-0002J1-29; Mon, 22 Sep 2025 12:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0jpI-0002IG-6f
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0jp8-0005Na-PI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758560131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8TCxc6De8pu8x3tU+eSM2cFUCj9I7fvmv/de+WxR34=;
 b=Miio0+cW4oI6HXT20Z8z9CtSCafE01fNQ+hi3URGGscvmKOTHcV0K0p8U8qO8asEENYH3E
 VS7bUwbpk4DDSwjJMyiN8LEbqwC9FPU18PVsa+85IpCh3NdNrT2VafROuGayDkff9loFl1
 pmp13/vsFK9izED0sBzVi2h6EqOeb7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-n27QSG9gPPCvd9vM7RPZOA-1; Mon, 22 Sep 2025 12:55:29 -0400
X-MC-Unique: n27QSG9gPPCvd9vM7RPZOA-1
X-Mimecast-MFC-AGG-ID: n27QSG9gPPCvd9vM7RPZOA_1758560128
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f924ae2a89so1514371f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758560128; x=1759164928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8TCxc6De8pu8x3tU+eSM2cFUCj9I7fvmv/de+WxR34=;
 b=EH4hiSr5W46Tf/c5igLf+Y87R9Y62p0mC+/1yo2DZRlMDkEUm82px+VfbrBSir16l8
 mdzP1YaUhRsmHVGvOMDykry0admX5bI35aAlD/Jdk5FHnCEQrg9O/vLtMJmlBQmUBVCI
 4FP79s2UTA7NXEd6n6yZrilmyj+4l6Mb6kQDpfbx3c7gwXPo8iyqq58c2XBB2S0V696W
 896k2IkQG/3QYvIPannxPPjqMhAxw0mcScNRaKwx6KdwjmLtHvukqfyj1T/aj4cEbLPq
 ZeDfdxykSoKHX1IJ+VfElt7C8PHyq1cbvrDRdVs/BPl6heVoCWKJ/ljhJIYYDsFqhuto
 /uCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX9lOlURHHLLqYoHqGFJ4sx/vL3wUEotMcjJwr2taDN/ux8yfrzCBRAcEhm1mSappKfp6KSNeXXMYX@nongnu.org
X-Gm-Message-State: AOJu0Ywh3greNb6BVzSz5rlLWz7YqHBeJLvfa+g1xq67WCIBjOti8F3x
 LmyC1W57Ff+5slwxPKjoydZaP/iaz7FXLgmkeRNhDI8POpb7gnrKo53oMkpuFfGOLtb91okvLeH
 QvwuP+lC8svXLXM/XDAwr+vB1YkW/jlqAlrckOii5S70CCl2DfSZusmPo+481eY0mL2gHRkLDVt
 inB2E459WPR4nLmPM+ISlrJRNp6pJG10c=
X-Gm-Gg: ASbGnctBeRqgAYQVuqPtCZJNMB0IGSkajmZ49hRVO5yJBHwXk5BTG63pMrfvhTdVZcL
 1k6eIugcnAQwvVlPeAv61pW0RhrPeoyTnCucteK7fBhg+J2IeaCb5NIqzoiUkdjR2TWxEUYaO4+
 Vaugcyjc22M92M73vj2LnDNt+WGBJZVoV6HUxdPNskv6SyomacXczt6KNaN33z7OoQrveADQDPT
 OdzL9eZ5anSGwSJx7mIKxnW
X-Received: by 2002:a05:6000:2892:b0:400:4507:474 with SMTP id
 ffacd0b85a97d-4004507084bmr2063151f8f.18.1758560128043; 
 Mon, 22 Sep 2025 09:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIoa9QGeFeBIF/mF+AY6qFPnF77EGdPSe2u3L+//VJi+0WfNGFmQn9rHfazeLNkOXgDR+PfaixWXqO9bTQViE=
X-Received: by 2002:a05:6000:2892:b0:400:4507:474 with SMTP id
 ffacd0b85a97d-4004507084bmr2063131f8f.18.1758560127638; Mon, 22 Sep 2025
 09:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
 <aNFJVrusgEUaLuDW@redhat.com>
 <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
 <aNFXJtQu9gFkIwLg@redhat.com>
 <ffaf300c-4f41-4741-899d-f0fc148ab2a2@redhat.com>
 <aNF7J6jpviFhwJPX@redhat.com>
In-Reply-To: <aNF7J6jpviFhwJPX@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 22 Sep 2025 18:55:16 +0200
X-Gm-Features: AS18NWBDliQ8ZTPmSJu4d5PEo5eUL9rQ2ruqZO1cwVnD7KVLHcyo2U0gjBMFau0
Message-ID: <CABgObfZsj1dBMoNtW38LpFqe0OhE7Tu6ddn6+qSjvA0apHB-_g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 6:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> On Mon, Sep 22, 2025 at 05:10:24PM +0200, Paolo Bonzini wrote:
> > I have no QEMU example at hand, but let's look at a commit like
> > https://github.com/bonzini/meson/commit/09765594d.  Something like this
> > could be plausibly created with AI.  What I care about is:
>
> I'd agree it is something AI could likely come up with, given the
> right prompt, but in terms of defining policy it conceptually
> feels more like new functionality, mixed in with refactoring.
> [...]
> you wouldn't express the new class level properties, or the new
> get_or_create_cfg code as an algorithmic refactoring. Those
> are a case of creative coding.

Yes, I agree. Those are creative, and obviously not part of what the
LLM can produce with a pure "refactoring prompt". In that commit,
clearly, I hadn't made a strong attempt at splitting out new
functionality and refactoring; I might even do that now. :)

> When we talk about "limited / non-creative refactoring", my interpretatio=
n
> would be that it conceptually applies to changes which could be describe =
as
> an algorithmic transformation. This prompt and the resulting code feel li=
ke
> more than that. The prompt is expressing a creative change, and while the
> result includes some algorithmic refactoring it, includes other stuff too=
.
>
> Describing a policy that allows your meson example, in a way that will be
> interpreted in a reasonably consistent way by contributors looks like a
> challenge to me.

I agree with your reasoning that the commit goes beyond the "no
creative change" line, or at least parts of it do.

Inadvertently, this is also an example of how the policy helps AI
users follow our existing contribution standards.

> On the flip side, you might have written the new property / getter method
> manually and asked the agent to finish the conversion, and that would
> have been acceptable. This is a can or worms to express in a policy.

Yes, a better approach would have been to change the initializer and
ask AI to do the mechanical parts. Something like, in a commit
message:

Note: after changing the initializer, the bulk of the changes were
done with the following prompt: "finish this conversion - i want to
track the PackageConfiguration object per machine, with pkg.cfg
becoming pkg.cfg[MachineChoice.HOST]".

Still, putting the two together follows the exception text encouraging
"to not mix AI- and human-written code in the same commit, *as much as
possible*". Again, this is just an example, and in practice the amount
of non-creative refactoring would be much larger than the rest.

Paolo


