Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CFCFEFB6A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Mk-0002PS-MM; Fri, 27 Feb 2026 12:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vw1Mj-0002PF-FK
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 12:11:01 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vw1Mh-000140-KJ
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 12:11:01 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-506251815a3so19675911cf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 09:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772212258; cv=none;
 d=google.com; s=arc-20240605;
 b=GUdLFVfwauFOJxjZ+5E+qnW6KFadpAbArWIG1HH/zzbxLJSVaPt+UeaUC3r3OQt3cA
 od148ZIkxlOR44WsAscniwqPqHecFfOnpy01czQq+CAlJ/rv7pVthzt8MGTdf1az6Iwk
 t1wmOf3KGGyHKShwOB0ywOFBuouUtjE+N7N5svl1+G0OIOFSwiYq6alITPjFEHTtc5dB
 8zUuMVhDiOht8h/+Qbpc993A+Ak5LRrDxaHOwgunnqu0WVUEd1t1XO1uPyjFaqsFxeSt
 C4gYInGUuH+foZip3P+x8TsoZ1oKNGuqw6rl12T0WVOL56O3SiiTOKc5B3D9mPO0yEQc
 WhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4jkB89qc1VzhOh0RayZ1MFW7zsWsHWB61Akofa84qd8=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=lQHOyzRpgG67KC4Xc0hEQHI+NBlD17onJqmPywYiZbUoKIgVOg9WbCF9VeZbocdwvM
 stUsFSxAO9TnZO8D/jRLZRH4zfZLuv1PY/J6iYknHbiCy/mR4ddHwypobvDIw4nDV2fQ
 hpuWgM1XZBNzGSA15D2TbpgUX+GVsMf8Vjuw5tmN/CzMuGBU6wm49bukEk9x+p0/z/bv
 rCMtEjGZslotZjn2waW1ce1CpFaU2e1Q/4rVqWe16Q0nuGU61lDoUsyO4IMLAqtzhRUd
 Jf5uRqUmovQs724nmEqh+gY7G4RhxghayZAt/4I10houVF/BwrfTGD+xpaDDi71LgMSq
 dnMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772212258; x=1772817058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4jkB89qc1VzhOh0RayZ1MFW7zsWsHWB61Akofa84qd8=;
 b=G+4UKP0XaQNhkRxRStCeZ8k/LDKdJIKF7rfQJPgVCRHaNCqSXD2m75ak2wAOokoFBu
 +D+6wfSO5CJwuwW3SR1XhITBTNI+ZjPpdiFqEM9cx71wys1sv1fkqxiNluhYoniP1HNo
 m5IZgmnna9jj4ttBlOX2KKHuMKYqJT98YnKg3RjCIEAQLTdwqeD1rgeiRVdm9WBdC00/
 JEmxkpVHI0rIuGQ7RdFBJJ5GZ9rmwchSZHp11CQyObuOF8wjJwvZFedOImKUd/LgBZQh
 D/Wq2EGVaNtVeQKmbLGYlAg8bZ8qPYXpmlzOJKDjzBC9831hch49ZoQlU/X7d/Lh/hGu
 QwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772212258; x=1772817058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4jkB89qc1VzhOh0RayZ1MFW7zsWsHWB61Akofa84qd8=;
 b=sEt3mA5bI1za1fnmHW0Tl8gszvL1RseiCwhreigMGWJJrUMQRCT6jnLS6XznGHCYRV
 c6+F8nP8b9gOkL3Ag29WmcwsxubJDtL1JdPSc+QnCFj9NNFEvKN5Hrmwe+uGOSH6qRyt
 4LZA75DL8IvyfC9HN+M71uAcU7Mim5LgVToPM9rqUqNp3gEvrnYzqvU6ciiqugWFUzhx
 9bj/Gfl3T8/CCBXt8MbA2ZXSV3WActYHWYsKrEoTZ9KQDZ80fmCLm9v76s8uucmRBWh8
 /Aq810qEpu5UjIQd0l/2BxQoCtXzWBWxJVKSvzM9SmKpodiOlDGx8GHY+KC3/c+QZ+Um
 D5GQ==
X-Gm-Message-State: AOJu0YwpjXnSJMIxiXU5lcwyxW0XBvvX8eoJ+SAOvVJrq/CVXu1J9eoW
 pKedNq3ulUijZSXTyOUbs6yG6s7lK0StT/LLV9jYnou6VAWy1wKe9NPe3dEZOkaegvcInUC41Z8
 LczeFA9Bu4qWUaHe7+6IO7thya72Nebc=
X-Gm-Gg: ATEYQzyFL/eVFCcYbumcBM9Dh0b/gg5jVm4/IRd7kZFe55ra6cEiihOGamyp1u99Xl8
 Z1kKMW1Fdl0oRyzSw4izIcarzNCeSLQSnIOH9eYraVEKsii8acNTvOruv9BwV+DM655+MAUUbvC
 VoQktxrzEIo40YkWTnA7W683RyJV6+GinCt6j/NnLdxoXkW+fnwoxKP021+kNBoQa+xyLCLbkmg
 Bu78eA99Z67jpk8aUuzo7WOCzDFk5Cd00d3C1x4b+PCVUHQXDvH/c30RfCxY3vJgH4M3pXH87YI
 CTO/0LDBqecyja/Zu8pDM6g=
X-Received: by 2002:a05:622a:4ce:b0:506:9d3e:67ed with SMTP id
 d75a77b69052e-50752a1efcbmr42539211cf.70.1772212258284; Fri, 27 Feb 2026
 09:10:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOkKuiOpVZwn7ZwPDPxJWmQ2SovUUTf2eLwg9dWFgEEhi3_NFw@mail.gmail.com>
 <aaFRigrJ-uiYcmUi@redhat.com>
 <CAOkKuiN_RsOQTREhAvQT2aJf0XJ4Mxk8XRK6MrXrWcoNdGhr4w@mail.gmail.com>
 <aaFd7GASyxLikTTC@redhat.com>
In-Reply-To: <aaFd7GASyxLikTTC@redhat.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Sat, 28 Feb 2026 01:10:46 +0800
X-Gm-Features: AaiRm532n-9oA_9NS_0YuDZK650pnO2f7u7t4SQX3Y4XjYOEDOzHJYBdXBjR1Uk
Message-ID: <CAOkKuiMeb=SxjZnytCAbPtJQrHA8zHyDaQkKwd++aPAmCQ_7-Q@mail.gmail.com>
Subject: Re: [HELP] Issue running test cases in Qemu
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Dear Daniel,

Thank you so much for your guidance!



Best regards,
Choon Keong.

On Fri, Feb 27, 2026 at 5:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Feb 27, 2026 at 04:34:23PM +0800, Choon Keong Teo wrote:
> > Thanks for your reply. I would like to start by focusing on the unit
> > tests and qtests. Is there any method for running a single test file?
> > Thank you so much for your help!
>
> Just directly execute the binary for the test you care about in both
> those cases.
>
> For qtests you need to also set an env variable
>
>  QTEST_QEMU_BINARY=3D./build/qemu-system-XXXXX
>
> for the target you're testing.
>
> More guidance is in docs/devel/testing/
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

