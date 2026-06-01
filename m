Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B83CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2La-0007NV-5I; Mon, 01 Jun 2026 09:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU2LP-0007MJ-6y
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:06:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1wU2LN-0005Uv-LP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 09:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780319171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3EOOtKkYtNzlyL7wJDq11Tzx8zN1iGmDGeYtUEcaj4=;
 b=NdmChDLsvZ6AYkcQILSxao1ajTxjxHNQNLu4mj8gMzfDruUGtDoOn5RqPsm3yraPJFSvM1
 mnju3ThDK10o4gJVg0gdkkIOZ+RMKWhxyCeJxdIb5EvHCVJ65YRRrKX38nPSdqh2eBoL5J
 P5NwgQt5N5/NpxGjILWycID4UmskGMk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-F9lXw4YMOXuAzozWq3emKw-1; Mon, 01 Jun 2026 09:06:07 -0400
X-MC-Unique: F9lXw4YMOXuAzozWq3emKw-1
X-Mimecast-MFC-AGG-ID: F9lXw4YMOXuAzozWq3emKw_1780319167
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7dc407c707eso70016687b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 06:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780319167; cv=none;
 d=google.com; s=arc-20240605;
 b=eWY1THbh5Owdppir96qsF1Z2jFq4PoLAk0sbkOVxZP4yHLPGVeuQJu/vMK5ZdxvF95
 0FlZnHVhiNHMCTy5rgn5ls4IRafvD6+bHWQQqJVcKrvIsh16eNfFVvRsp2/8WBJPpkqw
 GQWqhOkgdmWrFZQ6+h932QU9zKMZaoiU+zT04MJ0Wv6kvRfblNlEf1+BJZa0ysr5b+kW
 uB9pBnKYamjhrkLt39nwgMLpFGmY3x4+oMVz0QxfRRBb6nucnCcY5EEbIL43u0yvqt/s
 1OnjRvXOBLApLJGTKCk7CWv95/oFYxeqWzGk+wg3yN2Uklr3NDkltO1zdYOJyrup8Zf9
 8Iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a3EOOtKkYtNzlyL7wJDq11Tzx8zN1iGmDGeYtUEcaj4=;
 fh=Evf3d5FlozXjAsB0VmS2bSCpk8yAb866bzU3WfB6+no=;
 b=gZuuP/zK3ms/lcGol2xjwd+iC56Q5D47cSxXdVSMRPxaCHMwqTSyuh8el4NlZKecUJ
 iOkjeegCAia+ryf3pa/6ivcnMupbhC4PHr7D7z2KLGDFcbvcgtIJF5lo7fBez+GqeoTL
 9RvEddrCiidWyHeVvi1Eh+a/eFmpyxVbTDvdFq1Txq1U59xUXMgehithX58jSFFQTkNc
 6QFEimaTmFkRQhZZnxt2Sud2CruRpEtdhUlOKubfd8PWWN1dDYR7sOyoKXviqHhLHhA1
 zem2bpSsfc6nZf7ZPPEzXY+lLMQNQE67NFkXok53oAtbNXRr3jjscSCq6DlZSAfAU4cr
 0Uhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780319167; x=1780923967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3EOOtKkYtNzlyL7wJDq11Tzx8zN1iGmDGeYtUEcaj4=;
 b=Oo9Ypy8YsPAIhBnq7fuiqMbutVrif2VUFtNh+KstlRwPABpE4d4F1SkOw0jAAytvxQ
 dfMPzhexreJQ7Fcl7LJSPOGuxp0O2nvDxkrb5D6VpOHsiZT2hUePG42dPP2klxhHjQAv
 YijZ1jdXD0oTjOeQlKC2AQENNbn3/58feoRdeIBJNIzLYv4oF+39fa/f0traeLBKY3Kl
 xxLNVrtrwYoDV82/J5lguhMfq9feThG9MgP+GUVkiobBGxrgFfFjCp1kd2Xn9XVJnc6F
 ec2ua4qGJ6g7Kd52jqYvQ2ZLbCPTo1ynhZAfFCYMDVgqijfKz6i+tH54/G/anNcIgje0
 cKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780319167; x=1780923967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3EOOtKkYtNzlyL7wJDq11Tzx8zN1iGmDGeYtUEcaj4=;
 b=ZKtAgBiMjsHOLLm5+Yx3ZHQRooKwSgeqcCZNvDe0yBEHxOuluIW/MWlblk6N5vaqJR
 w5CkMpTAbSgaxy7R+6uboXbCohK18zVXPETGY/WsfhvonKzO1IVYSRC+9EipchQTpKa6
 Qr2Rity4n5dvTzyGFu2eF+LUariy0n+LcR5OaTg3yuDKLapg2sIulmAHeWWSMJmirWDx
 hhOMMkFhvH5BMg2aY2tkhOUITQyFXlpkjFvzDLclBeasGhwg0+FfOyWMz33B35cABrMD
 V/fqkMOnIaPIkJA+Onmj7X4GZkYAZJ7jdVyoVXJH5EJip88nZOJ3oBbgjKrDBE4Oz90Y
 z4Cg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lpETR0tjeM8q+96MLvemVQTarEUeFxzybN2iS4h0nTRmNxNJMPgcMBL5O3ORHMsbYGsOWfu7ebRjv@nongnu.org
X-Gm-Message-State: AOJu0Yz4o4cN9ArDWaLrDpqowaACa/B1QrMZXGJmSVwlw8rmpK3gkYIG
 gS1N4DqbG5Q9QowBJM0/5zPGGJTc/2xRpDYjHYoYd3bVbTv+vsQ2HaUGAArrrSmdB3Mim4txZe5
 S07VAe8HAXcO/lLhEm78Co6lkPY8wHbzJVjkTpzwmoFurT9LYsu5s8eqZS6d/9g6TuBmasCPXzM
 xnq+cOIg9g54ka2+DKnb1UIuQi/7FV8FY=
X-Gm-Gg: Acq92OEt5NGh2K1X43nhKveKO3fxelA3AXcvLPNam8i4rAvg3DaExvRdD4LBg8DtqQs
 Qa4Eq7PjbO6vQmb595NBd6ak9XaNFubn4YryH+pEVcHf/EYeuePLNix3bjO50q3IfWfQsH5pOlR
 H49hcxKOidTzzAiV2QWMn4et5hdDGPVWB3iBoh8R0DjO5dCLYFk7l3i4BpXK7zJfGoFd/uWGsF1
 i0ifoP+AVrR/gbk
X-Received: by 2002:a05:690c:3391:b0:79a:c40d:b734 with SMTP id
 00721157ae682-7e05ea48534mr91668387b3.48.1780319167179; 
 Mon, 01 Jun 2026 06:06:07 -0700 (PDT)
X-Received: by 2002:a05:690c:3391:b0:79a:c40d:b734 with SMTP id
 00721157ae682-7e05ea48534mr91663157b3.48.1780319162192; Mon, 01 Jun 2026
 06:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <874ijtz038.fsf@draig.linaro.org>
 <CADSE00+RdBUhFVBDSXtVd1J5SaccqWy+RBxqnxuLKUYcitFMPw@mail.gmail.com>
 <20260601083628-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260601083628-mutt-send-email-mst@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 1 Jun 2026 15:05:50 +0200
X-Gm-Features: AVHnY4KxqNrVCAnBvGqVDNl4sx_O6LVtLUuikZg1pVoCVm_RBbEptTRzSNfWocM
Message-ID: <CADSE00+kRnEC08LLVu6H065u2KaxBm-KnSN_8y6+964-FLbJMA@mail.gmail.com>
Subject: Re: Where should the vhost-user specification live?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev, 
 dev@lists.cloudhypervisor.org, rust-vmm@lists.opendev.org, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Demi Marie Obenour <demi@invisiblethingslab.com>, Alyssa Ross <hi@alyssa.is>, 
 Mark Burton <MBURTON@qti.qualcomm.com>, Matti Moell <matti@qti.qualcomm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Dorinda Bassey <dbassey@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, Rob Bradford <rbradford@meta.com>, 
 Zhengyu Zhao <zhaozhengyu@bytedance.com>,
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 1, 2026 at 2:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 01, 2026 at 02:32:11PM +0200, Albert Esteve wrote:
> >  But also because, in my opinion, separating
> > the specification would improve development agility by decoupling
> > specification development from QEMU's review and release cycles.
>
> Generally for QEMU this will be less agility, unless I misunderstand
> what is proposed)
>
> Because presumably there will need to be spec releases then?
>
> So
>         new feature -> spec tree -> spec release -> qemu implementation -=
> qemu release
>
> is surely longer that what we have now.

I see your point.

However, we do not really need to introduce a heavy release management
layer. We could just operate it as a living document, where the main
branch is the authoritative source of truth.

For the workflow, development doesn't have to be strictly sequential
either. A contributor can propose the spec update while working on the
implementation, much like we do for VirtIO updates. Actually, this way
one update/change supports the other.

I guess my point is that a dedicated repository could lower the
barrier for new changes AND keep QEMU's own development speed mostly
unaffected.

BR,
Albert

>
> Whether there will be more agility for non qemu users will depend on
> how often spec releases are cut.
>
>
>
> --
> MST
>


