Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDECCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyFHv-0007Ur-L3; Mon, 15 Sep 2025 15:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyFHt-0007UU-Ck
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 15:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyFHg-0004rO-IQ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 15:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757966074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiTdltcZAf63/8za+FWhkX79CP4oy4KcSVYEi99loNI=;
 b=Ge5W0JKCLC+mCvRCbuWgdg0tNDrM3sLMl8t9zi5A4QZEULn0PPO4TkaVrT6T5XaYom9wX8
 Q8eDm0MDMoK53ZT9Xd7JpY+fTyA07oMbzy/K9bBgPn72Uu/10mQs4t3jLQp/swUOU20xB1
 Rc3sevDjJonBUe3jx5wGFz6f7v2ewYo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-bSRqidpINEiFn4fgLJe22w-1; Mon, 15 Sep 2025 15:54:33 -0400
X-MC-Unique: bSRqidpINEiFn4fgLJe22w-1
X-Mimecast-MFC-AGG-ID: bSRqidpINEiFn4fgLJe22w_1757966072
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-267a5c98d47so9841765ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 12:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757966072; x=1758570872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TiTdltcZAf63/8za+FWhkX79CP4oy4KcSVYEi99loNI=;
 b=NNKyrV05rYd9BK2okmr6Zw9nnC4VF9xynj+ISSlQ3lDAczXzdA2lZG6or9gtp3y1Id
 C3aHGwYgUTH/0j2YO8qwARaMO7jYXlCBiXSMW6fOJ91qbbQrKTJh+hOunXQIx7oTaiUp
 lpZRqvkRMkErEuutqDYRV8WnONd/kKE7C2ueLW//ccDUHc9GpPpwUY+iRiRO0o5dBqsJ
 DI/d+5o2EF9w9wINhgEEd8AfGOdJ0kLpC93xs+qF4H3lbHOWwr3eiz/PYu08bz+kvcFj
 mRk8v88nIxQaOFCf7Y9Q+F2auM4q5UYRRtXzmyRAWKV6n5tHP2t5QHTJc8Olri32hFf8
 e76w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy8vnyZYuFdIMy+PAAa/tf5bJ/wNIU6+mc3dXWOY/dRNKw4wUXRVz8sZ4/pHKRCZ23Ea/z/Ax7eFKV@nongnu.org
X-Gm-Message-State: AOJu0YyJfxcyJOIP3QWa2p1g7F6J+rgxDf26giglKHjHl2Kn0P0+EqAA
 vat+qYMpIca8gaTm2FZmnFBfh2xswdykWXyji1gTzeMazpXOOifiB4ej+NcFSbuVYu1hmQFkHaj
 4FM13fiBg/cUoRqe013fxiE+kT7M8sfRqYLu+9NX072IZDsnJgdhHvgjZX9dnB/OoaMyEG5U1q7
 cNYdQsT0+Jn9mz2VAOlM0Inis3Ms+yKkc=
X-Gm-Gg: ASbGncsPHsprIapm8Q7vyxauMUbjMaqrPHZbWQjiidy3fvVGLTqe9i72UNTrzY6/OI/
 yL7KojifGjzvbTOxr2SjmQ2OAX+Q6rZljlf0CYkxH+uISTWlRMwiRGUUjjQcJRE1qaJCkJ1vlxb
 vsmsjEILk0qXMw0kbo195rriP2qq3ZTYTVPo9/Wopl2indkS0YFTri
X-Received: by 2002:a17:902:f542:b0:25f:2aeb:2f75 with SMTP id
 d9443c01a7336-25f2aeb32dfmr155929615ad.12.1757966071924; 
 Mon, 15 Sep 2025 12:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTDFA4/ZUgbBMncN6SIVoRVuesCYzA/DdNpC7+QbU4fZiWbZVb7JwN4boX7kiFeU2pbTULkKsqld76ULcSqnE=
X-Received: by 2002:a17:902:f542:b0:25f:2aeb:2f75 with SMTP id
 d9443c01a7336-25f2aeb32dfmr155929445ad.12.1757966071554; Mon, 15 Sep 2025
 12:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250716-functional_tests_debug_arg-v1-1-6a9cd68318bb@linaro.org>
 <87ms93xl69.fsf@draig.linaro.org>
 <CAFn=p-YTFYr-cxz0B8jay=-HVpjyo9To72DZAg5o45SRBR0wnA@mail.gmail.com>
 <f208a06d-2dfe-4cce-a848-938b3e3b6a31@redhat.com>
 <CAFn=p-aZA0_DhBEFohK6TS=xev459S2YGPm9N3X5w+QDi0noEA@mail.gmail.com>
 <147a8aaf-5895-435d-8394-ef6a5e03b638@redhat.com>
In-Reply-To: <147a8aaf-5895-435d-8394-ef6a5e03b638@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 15 Sep 2025 15:54:19 -0400
X-Gm-Features: Ac12FXxQ8jlSHLtRxEsha2JlmuFodiVPEzRDQamiM9ZXTGuBPjJtf9dzbxfrGGw
Message-ID: <CAFn=p-Z_Du_xbOKg+2wMPzshgOT1MX+AKLNNE9FLpEp+gkQLhQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: add --debug CLI arg
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 9, 2025 at 6:37=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 07/08/2025 23.46, John Snow wrote:
> > On Thu, Jul 24, 2025 at 3:47=E2=80=AFPM Thomas Huth <thuth@redhat.com> =
wrote:
> >>
> >> On 21/07/2025 22.38, John Snow wrote:
> >>> On Thu, Jul 17, 2025 at 4:44=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee=
@linaro.org> wrote:
> >> ...
> >>>> Am I holding it wrong?
> >>>>
> >>>>     =E2=9E=9C  ./pyvenv/bin/python ../../tests/functional/test_aarch=
64_virt.py --help
> >>>>     Traceback (most recent call last):
> >>>>       File "/home/alex/lsrc/qemu.git/builds/all/../../tests/function=
al/test_aarch64_virt.py", line 16, in <module>
> >>>>         from qemu_test import QemuSystemTest, Asset, exec_command_an=
d_wait_for_pattern
> >>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/__in=
it__.py", line 14, in <module>
> >>>>         from .testcase import QemuBaseTest, QemuUserTest, QemuSystem=
Test
> >>>>       File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/test=
case.py", line 26, in <module>
> >>>>         from qemu.machine import QEMUMachine
> >>>>     ModuleNotFoundError: No module named 'qemu'
> >>>>
> >>>> I thought the point of the venv is we had all the modules we need
> >>>> automatically available to the PYTHONPATH?
> >>>
> >>> As Thomas points out, "qemu" is special since it's already in the
> >>> tree. There has been some dragging-of-feet by yours-truly because
> >>> installing the "qemu" module by default when running configure
> >>> introduces a considerable startup lag time, and the module is not
> >>> actually needed for the simple configuration and building of QEMU -
> >>> only testing.
> >>>
> >>> It's something I want to fix, but must admit to being a bit stumped a=
s
> >>> to how I will bridge that gap long term. Currently, all of the module=
s
> >>> we need are in the tree with no dependencies, so it can be fixed with
> >>> a simple PYTHONPATH hack. However, if I actually remove the QMP
> >>> library from the tree like I have wanted to, then we need pip to do a
> >>> real install and process dependencies, and this creates some
> >>> complications and extra startup lag.
> >>
> >> Wouldn't it be possible to add the module as a wheel in python/wheels/=
 ?
> >> That's maybe the easiest solution, isn't it?
> >
> > The qemu.qmp wheel, yes, because it's purepython. The part I am
> > worried about is that by removing qemu.qmp from the tree, you cannot
> > just use the PYTHONPATH hack anymore to use the remaining in-tree
> > goodies, namely the machine module used extensively throughout
> > testing, because they will now rely on an external dependency.
>
> Would it maybe be possible to add the machine part to the qemu.qmp module=
,
> too? (Gerd also ask me at KVM forum about this, so there is certainly
> interest for extending the qemu.qmp module with the machine part)

I could, can you explain a little why we want it? It would involve
cleaning up the interfaces a good deal and while I don't think it is
hard, it will be a lot of clerical work and shuffling for a little
while. I have some drafts somewhere that add an asyncio VM appliance
to replace the existing one in the same manner as for what I did for
async QMP to help solve the complicated logging stack we have for VM
console scripts.

Having a solid justification and guinea pigs^H^H^H^H^H^H^H^H^H^H^H^H
beta users would push the project over the line for me.

>
> > I'm sure it's solvable, I just tried once a while back and hit a wall,
> > got distracted, and haven't revisited it yet... Maybe a good
> > rubber-ducking session would help.
>
> For the (removed) avocado tests, they had a dependency on the "check-venv=
"
> target in QEMU, so its python dependencies were only added when you ran
> "make check-avocado". We could maybe do the same for "check-functional", =
too?

Something like that, yeah. I'm going to send a patchset soon that does
the dumbest possible thing and we can chat in review for that series.


