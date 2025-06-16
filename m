Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E16C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6Et-0001uB-OV; Mon, 16 Jun 2025 05:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR6ER-0001l2-87; Mon, 16 Jun 2025 05:34:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uR6EP-0008KB-IW; Mon, 16 Jun 2025 05:34:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3138d31e40aso4260798a91.1; 
 Mon, 16 Jun 2025 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750066457; x=1750671257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kky5anMWDkkC3OvgTSju2eCKtOUZ0uhnYs4cMprGzf0=;
 b=C+TVp3K9cwnAUymk1l+woVze7o1HtE8KMp/f+33cHdhw1W3CULiUlkkH3i8wbZCwPl
 a433vpGdOta8DSbb+lkyRs2cJ8aSrBPe70k4/IVPm1R+nRorDh43BwayP4WgfPZCHQZ2
 nNG7HRAzVrrrI4xuF4ZHlcI/sj6aIaMuq06ZdNzclmwmZv/sJJjiE3BhjCH15xdwFzpG
 XXr0ZQSrN6XKaqP1KEzchcYrw9u9MrhXsBwSMsiC2BD1kbjT5FGQi7nhT+1fBZbbWhQD
 7bQiG0KSC4BAKWcbenw0F0lEIokVMIk6EYFsOvDv6D/EE/Bv/dlZ4TRAamaZvoWf8ZXx
 b1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750066457; x=1750671257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kky5anMWDkkC3OvgTSju2eCKtOUZ0uhnYs4cMprGzf0=;
 b=CQhORNVJr7ulqB/cbYImVePttT588El/52uBcsK52e4ttlNBvJTubGk/ktyYji+s/l
 /IY88CUH8PGr91jyVbtAmYVdXe874C4aIKN0yWL1p/2dyYTV1fGHMr8EegbqR9/+NTtL
 VuTflwvoaMd8nxYVAnUEtpGnpa/4m50PMFZJd7Y2wLDhAdTKgplyQclmBeNFVlp2IkGd
 l3ZeyyXuzseyNBu7S2+2hHYCsY0A5CFojEjEvfCH/yEZmoP7YP9R40Ja+ILX94B2/BbR
 apXk+rVSNxSuAq4vXpyR+azX0sMHcs554Tibu1yQs2cNNyhNmpYp1OvcDjxpfqgj+HRI
 8C4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Yvy4l9qDE+/iVAMe9YS4alW/SAHFfkZDL8cTDu6U308GVPqXJYqrigTDYEwYmtdkEIlPwEy7tdq6@nongnu.org
X-Gm-Message-State: AOJu0YwFlcijJNFxJg8mD1UhlKRBXlh/D1eV8nI0B8wHn/uYQOKLn/C5
 XypE3p+zSQt9u2sb9HggVtilSKEN+U739QPiPj41Psiw5wjvGLPp/uLQCGBdJhxRuD0GSJ4D5uI
 6wlRc1xgaX2HDNhfntqNIWMz8P7pomz0byDmc
X-Gm-Gg: ASbGncsEAewGYtX1vUGmxJtt7ZcG8+q08owqBnJG3oOzGXzjODxhcQhyGFzOMX1WNHh
 0hUJ0Rj87uQErA1ulTfYnI6z8RADqOmlIZFwJYmGQKWpsbIsKfCiPcMOuuKRxjoFdy992r/jF/5
 k1zPcSZwgrDgt9ZBppLO/Dvw+cHRGNsZwvbI6yETtEVxI=
X-Google-Smtp-Source: AGHT+IHCYyx/TbvOxLvT0Y4HepiCC1ZOTRhett6tKf62xXXg3F8d7f6LkfsX5EgJfvhg+J2GUEeem1qWv1K6T0LihEs=
X-Received: by 2002:a17:90b:3805:b0:311:ea13:2e70 with SMTP id
 98e67ed59e1d1-313f1cfa1afmr15808798a91.14.1750066457519; Mon, 16 Jun 2025
 02:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-3-f.ebner@proxmox.com>
In-Reply-To: <20250515112908.383693-3-f.ebner@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 16 Jun 2025 11:34:05 +0200
X-Gm-Features: AX0GCFue91u_R8TVbj8SGSqwYgb1b4vDt0nZEVG-U0vew8D9Em5Pi_z7NRA0odQ
Message-ID: <CAOi1vP_kEY31-brzTfG6K9y0Wbv06e=9vH=rqD9ouwq32VaYAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block/rbd: support keyring option via QAPI
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=idryomov@gmail.com; helo=mail-pj1-x102f.google.com
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

On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> In Proxmox VE, it is not always required to have a dedicated Ceph
> configuration file, and using the 'key-secret' QAPI option would
> require obtaining a key from the keyring first. The keyring location
> is readily available however, so having support for the 'keyring'
> configuration option is most convenient.

Would such a setup have a ceph.conf file that is shared between
multiple users (or no ceph.conf file at all if the monitors are
specified via QAPI option) but individual keyring files for each
user?

Thanks,

                Ilya

