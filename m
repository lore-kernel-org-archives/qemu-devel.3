Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EEBCD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 19:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRbAX-0007zk-L1; Mon, 25 May 2026 15:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRbAV-0007z8-Qp
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:40:55 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRbAU-0001TT-2y
 for qemu-devel@nongnu.org; Mon, 25 May 2026 15:40:55 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6587cee8b57so10827397d50.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 12:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779738052; cv=none;
 d=google.com; s=arc-20240605;
 b=KmNgZBWjB6e4sbZKtWWj6Qj1CQpvE8jlFNlFhwD7WGTod9mN+f+K3+5fD60ihBjykt
 M+GwwfaT9HH0K4S2nxQcQ7B8WAwKPDWRKPW9N3wkDV9pUu686ra+aIfqz4JR+HLWcuZr
 Ay7kkZp8j16F/hIGDUcui2pAIwDHVkQLEhSFOpsA+rej5jeNToSHHWQhXMcN0fwTezIw
 EiMLC2UmFv5P+ekDsAOfWmJhakoufojo/wHkxvEGu6LdczVfkvxJJaRASSwFtV/Zfydk
 vfaK7kb7hZ/4iq0cF75IVPXKy9/ts+o+fGBRZnDC5jrur5gjq+RVPlxlSHuSXlbfWQ7B
 htkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ySPI+6oIqjaqvDqydjkeUroelxvZcDIYDhuewE7RqXc=;
 fh=0Z487XFnP/Hsl5nh1yufk8WE6IiFCozoHaPPzoxlsKM=;
 b=irAeAP7iY2mufSd8bIo2u2MQTeS2pJL+xK+vxHMeTz7Hrgbr2MN7UAkzDMQD8Gpf0M
 yKgpnQXK2MO2ClmbFrTUc/mYtHnZh81XpYoVeE7CQnaSSP4TxeZzT2ootQdFyEa+ChVR
 YLIXppxIHPYlww5ZOGxfVAFfHaxeXBGwft19Zkc98H+LvNqhSbLEQPONAV7FMpJBY512
 V/Ls7RVq7GABMweh5xmfLeOIEHy499JRauQPkGQ9uRRez2aEp4yU2tBc0XosuUouP/bI
 Hapwo3yuEq8ohzq+jCw4KEmxgR9ZTikafeAXISS5OcV1XTahDyPocMgxJTs+hTMFoMwX
 phsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779738052; x=1780342852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySPI+6oIqjaqvDqydjkeUroelxvZcDIYDhuewE7RqXc=;
 b=t2tQgi/pR0/zQjev+k2oL0VvVlMaP6P7lNbQfzfrKRawhbQmIGPJqF9xHxub20IpBu
 A/IETX0T1I4gznvT8fy9nyJNv0bejOkxfq9Ajr0QQBF5YaVQAOUKPD1JzvPrYUHnoxo+
 NMeMJ7igmbE+nK7VQzu+n8xrhawChPVv1a7ISYr/9xuevG+nL27xIknUY/VS9XDOwg0B
 2HBkmXoZX3VRYfu2a89ZiQ2umYwR4VDWOPdnIP0Yd549m1uF0KrfC6BPm1n9dp2dU2Z5
 U48U6R57NvmooOmdJK0MiLO5blR1rhnmbEEqirDTx39uXd9XsWRKOew6a9BakcSE1TPF
 uqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779738052; x=1780342852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ySPI+6oIqjaqvDqydjkeUroelxvZcDIYDhuewE7RqXc=;
 b=JuWbKU5rffAbpQSh1IwZro/zBUulgPI8BjMl+noNn/wNW9Ib/GnFaw8WbzNeg+tEaq
 z2kBNGI9tPK1eDhw0DRlDsBSgVqXcOkcIxXOFGR9sXXk03gbfrYxTWWkOEmV4DwTtoXf
 FDTV28u7tPES9UgeOykRJQOouRKDugnAGdS6Oxv4ao2ww5eJzjRZmfFbcS8xVJhjDB0t
 l/V5lUVtMDF37WWDdkLbd9fa3SRIftCWNWg6Irqnoxi7+YBDMn8xM0IBcuKToYqgP3Uq
 p6u7DGC0XdSCipE0QLz/dSwujwCg+tLqqg4aKpkL9ZyWBvj3xMq0eYqW3GVyqX4uEqoh
 wOCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DNO/BO1cDh+9hBxmmFyUWm84nHrBUSp8pWtfoAHWvGdtCl9381gBH/zol+ACevrjQNvOLuizi2wCQ@nongnu.org
X-Gm-Message-State: AOJu0Yw475BpJKth5ohyCwYRxiiWAuBnM8zC4+gvNmGg5ujPL/+RwRlh
 rtYQ/jIBPiIixI7teNPwAuIrlpA17xY+VESpvohwXQaMJChIL51l9cZhOEtC/rOfsxo2P4Cj3ax
 eTlOkLb00pZPVI9GwP+AjtnGMr+qwiv2sC+U6M730/A==
X-Gm-Gg: Acq92OGk9rTh+JkxNbH5WGycsogishbu4hrBWXbcGyp2m4xgOBH8k65yNEOAbBWPyu2
 E3YzmJfV3ZRjtaZatvrCutIpRIE0EKNcBqSmVH3rwsC317TF6LhCQ8tqk/vcAix65pevwnnXzzQ
 nZNzt1v8r1t0l5RlMbNR/6X2pY1oYFwFf+GJ5gh3l9BrHpc3WQ4GOjPAYLV8ig5o2JblYefTy0m
 U/pfpOrIdZMXRmU9IqAp/huFnamkJQxU+lUQf4Sx+DA2i5pnq2gtIJ9uYVObsy9xUzoz+fdwnkb
 SNc4juhyH6bE+Bsb2lwJD4XpO2640CRhjG8UzFs9GrKKdHGTIHxysuCDB+xkjOXKk1Y=
X-Received: by 2002:a05:690e:d4a:b0:65c:2738:c6ad with SMTP id
 956f58d0204a3-65ec97cb3ddmr17477037d50.17.1779738052132; Mon, 25 May 2026
 12:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221017182005.43015-1-philmd@linaro.org>
 <87pmeohtj1.fsf@pond.sub.org>
 <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
 <5de52cde-3872-4b5f-acbf-28ca300b7724@rsg.ci.i.u-tokyo.ac.jp>
 <CAAjaMXYCt=3G4yzNNtGWa1gSDW=kCRtXO4TQt41hN-N32DnBJA@mail.gmail.com>
 <871pf1e2t0.fsf@draig.linaro.org>
In-Reply-To: <871pf1e2t0.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 May 2026 20:40:39 +0100
X-Gm-Features: AVHnY4JHTvIToEVXfYLeNfte5kxxNJYRhwitqKgTlTjnaecVauEtwglEVwr8aQA
Message-ID: <CAFEAcA-vOgf8Yp2Eii8_zsr554MH7T3Lzj-1VToarC9-ZPzi7A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Replace my amsat.org email address
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sun, 24 May 2026 at 07:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> > People who wish to use git log for employer attribution reasons must
> > use --no-mailmap. The original commit author in the tree does not go
> > away!
>
> Shame there is no way to split the mailmap - because it is useful for
> identifying people with corrupted Author/email fields. I've fairly sure
> a bunch of entries were added in one of my clean-up passes while
> updating the giddm metadata.

It doesn't look like there's any way to say "for this command, use
this other mailmap file" either -- there's a mailmap.file config
setting, but it only lets you add an extra mailmap on top of the
default, not override the default file...

-- PMM

