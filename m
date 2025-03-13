Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E17C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 07:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdA7-0004SS-RN; Thu, 13 Mar 2025 03:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsdA2-0004MR-J9
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:39:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsdA0-0004aF-Un
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 03:39:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so929627a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741851559; x=1742456359; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybYI4W2/94CcpuKAo8+bvKpYrrGq4SKV64P2ULK0m6k=;
 b=FzjOV5Jp41LLWqwK5EmdUkF2gzapkNXCBjghCdb3urNI+6ppVemPkH7/SFtgH3V9v4
 xqPXyJbcmrUWE3kAS93CRp8t7bcXL8zJPcm3yuKunWwV2v4cV4IH7XGiSZ5pJeXV087k
 h2QAq2H7a8uCcBSWGpSR5T+818XoJZ7bnqEFvOqoscbWNkIYVIY7Whl2F2lAx5yCjETb
 fZ+H5lXRNGuJ3BrsyRFpILDXiEZEXOsDN7PZlkCHERc2/k7sjCgTATapM4tsXOYjirC+
 CYbJNwa44E3cJDQhwxajETGGFpMxEF49LH/lLEKl6JAP41abxnHEhEcNP9Zhac8xJCvf
 CfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741851559; x=1742456359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybYI4W2/94CcpuKAo8+bvKpYrrGq4SKV64P2ULK0m6k=;
 b=sJjHjbIwQr1oIeeBSUk55vpo1zqAaHYsTfFo8sBNR7s0uCo5nSr9JctOWLNa1QAH3L
 U00bzxz6nDsjBfAID9sA0wnDSnfv2oByE+eEH1R/KqqXO+BX3wdY3AMZRtt2vu8QduyY
 JPdvPhDDf3NY3KBbLx85InFU5LAoXIr3GZ0Tfi+TKDptEJabOyu6GCia+dhdaorzpQLb
 x+Mlan/8erOm7BirC0pQjxprJm8DbzBeYnZhYuC+awRJT9zOUj/UHGQ8/FWRoxGh2UlL
 wnsYXHjFz0fG27LK7A5BtQXMARS+ya2OgcCI9BJQJrouW9cLvUHIKe+HnHynblplu+JN
 v68A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ETs/ZwkXSUTwunRIzEh4D2pOGLqbAULHw4iZ45YQM4M60E8DcEmDPfxMwfZyF8+s4zxXjVgU7a7c@nongnu.org
X-Gm-Message-State: AOJu0YxXVO6+KEBeie63S56yIIEpDUEQdwl8KhjH+jL+NooaUcXK7EZc
 Vu6mf0McRS1BBNADhIL9S/OwEEKg5rLTfo9nRd09tO+m0Wdd+pMREHvsWEreQxwTeHTH6St2ns2
 Mw//zHdQo7D5os/bgKgj2qoMLJg4=
X-Gm-Gg: ASbGncuZtA8qQ3FlYEsB55nIbxwfYbjpBM1ldIXfkL7QDFvPpETKt2DTgNZJ/saVfgp
 1ZidrasjChsgAOJ9TfN15uOZlLnKkNc9i5jBtp6wOApTrGhdtmIs2NTuazRqpOoMR/Cx0+CO7Un
 ngCG8XWHQpdz0kc/CYvHqi/MN5zA==
X-Google-Smtp-Source: AGHT+IEl64K0mpPwVl+fV/DXX76TY+Ra55Qnytex32CYfcyEd2SW9/IgckMvsGPF79buqXQ2iluvC3pRkuwyEJyhYy4=
X-Received: by 2002:a05:6402:2392:b0:5e6:1842:1346 with SMTP id
 4fb4d7f45d1cf-5e618421a3amr32280843a12.30.1741851559064; Thu, 13 Mar 2025
 00:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWKnLDsVUbqO_kNB7GiZPU0-YpOU8T4BNCgyNBi54dtDQ@mail.gmail.com>
 <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
In-Reply-To: <12d09c42-e6b2-49d1-9b06-e5a26acc2c5b@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Mar 2025 15:39:07 +0800
X-Gm-Features: AQ5f1Jo9380-lQVVMcmnByQ-54KUAGrv-0BF_x-HA7USRFcVQkHZROX6e6tc3TM
Message-ID: <CAJSP0QUWkeaSsVmdfrXNAaSqB_uMUxqAD+GR7Xm4FHEgwYArNg@mail.gmail.com>
Subject: Re: Broken NetBSD Orange Pi image URL in QEMU tests
To: Thomas Huth <thuth@redhat.com>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Mar 13, 2025 at 1:48=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 13/03/2025 03.22, Stefan Hajnoczi wrote:
> > Hi,
> > CI jobs that run test_arm_orangepi.py are failing:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9390048284#L1138
> >
> > Please consider how to resolve this so the CI job passes again. If you
> > are in contact with the archive.netbsd.org administrators, maybe
> > contacting them will lead to a fix. Otherwise please update the QEMU
> > test to use a URL that works or remove the test.
> >
> > The NetBSD Orange Pi image fails to download cleanly:
> >
> > $ curl -O 'https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evb=
arm-earmv7hf/binary/gzimg/armv7.img.gz'
> >    % Total    % Received % Xferd  Average Speed   Time    Time     Time=
  Current
> >                                   Dload  Upload   Total   Spent    Left=
  Speed
> >    0  303M    0 2048k    0     0  1098k      0  0:04:42  0:00:01  0:04:=
41 1098k
> > curl: (18) end of response with 315646186 bytes missing
>
> FYI, Nicholas already provided a nice patch series to skip the test in ca=
se
> of such incomplete downloads:
>
>   https://lore.kernel.org/qemu-devel/20250312130002.945508-1-npiggin@gmai=
l.com/
>
> I'll try to assemble a pull request with these patches today.

Thank you!

Stefan

