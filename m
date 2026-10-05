Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083D9CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 05:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDbej-0006xT-0X; Mon, 05 Oct 2026 01:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1xDbeh-0006xJ-Ho
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:54:31 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1xDbeg-0004t5-6O
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 01:54:31 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5bcc5ed351aso38297e87.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 22:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791179667; cv=none;
 d=google.com; s=arc-20260327;
 b=JzXtmMHCpFJZiau623CkcX4wf31RBrFHjc9QNYnKL6eYF1tbDUN1KzFfDl3TuF3GKu
 GHMh9RScmWuYWhszTiK2ts6rrLxE7JrvAaTcgN5oN0MhPYssEZ8Dj9AzoDS8LxuLSGK1
 f/e2NWKODIq5yn3Zd/K6Bac4/g7sB1sP/rykpTYTDDEgeV4VUNIYFJE6fWWFoiP4K2OT
 dW/KCNiFIvF4PKKqKHcTf3WyS0iu8H/yO3VE8oM+9L8mNx6laKXhm2vYkqTtP4qm8NLA
 aXHCPIWa5ZHFuiu7EsoD02waCzgaZjKxgS6+moYdm0unB9BWSXjnzpj45VHPbCEng92/
 /PPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mGCo2XXupJSecwhLwBD9XtNlB5krsNjARinl5bnH2YE=;
 fh=Gs0+7zaMh8a9SJFlKztesr9k2uez6uSrcF4K3+ppkak=;
 b=Y+IDECNb+LZG+ii3xs/qepZJSqkvraVBH3U2upDTA4mGcEVfLT0gU1BgVQqHzeBmcV
 fED+RAyitPlQ59rCy0EBvaA+nC4S9CyiB4JpvnSFgnVNP1xDAwzlJW8m/zZmvUxWbvli
 QjQv7LQFhrHYOsWFO6CU8c/z+EX1BNLG1rXEELi0pmgZleS6q/vtiCzaReTjLzUrOaIV
 5fEcQmAf1IvH7UsAbbbmd1VyNgXhR5zjm8twpRammJT5jOdgkXhbHmUOX9k1p+U0lbZE
 YufCkasdgU1BUYysPrUhacRIO6c99571NMNE9jq6vTyaWpliXOXegSOSFFkN/KRjZbBr
 lOoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791179667; x=1791784467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mGCo2XXupJSecwhLwBD9XtNlB5krsNjARinl5bnH2YE=;
 b=XYTuKES0BXAy0hp4K2BPhhgDNbWiLqjv92NfddDeoOQZiETNEzD6jWLjwvxu/Gxwa7
 /mFgMu0zAixniA/cDZZoDwCjLuNRWqsGF5awiCtwTYzQPUB4PMi2bqV0oTF+iFDS1hKP
 Y8QfAJ5MN1OVwT8tJ0aLGafmuk606d3xz3OsUCl5avIEd8XH1xAfp0QKU43MFVkPY/12
 f01F1qmdHVe1/rYYgTbTuim5OVfLog20/sPgJ2AHEn2COG/yIizqfNGYun6IDK/W7/SO
 MnijEruIQV2yNq0AjXWKIhGAI9jsNvPDP7YJXycJXUTB/0VTCqBGrO6+IXXQ0alrfzwO
 wtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791179667; x=1791784467;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mGCo2XXupJSecwhLwBD9XtNlB5krsNjARinl5bnH2YE=;
 b=mmsyGoAniIlKr0d47rxT0xRAWxhIRdb+3c5WIQzqSoHKIEaMdXlQ294RqgaKEsCp+L
 C9Wej0QfTVQKhifYuVwSGcQjSiBaWKyrVTkeUKHYUEjJrwkidjipRxXKbz18X++iKwRo
 93imdhP/Ay5kywbxDB3OtNk9d34NsanXzDFhif7WyXU0Xm5SfvVO0SGCfX+3IKpjlu3y
 kaxMI4AIqPN+bjDgT+OdSBPwOjaz8L8DXfVenVPwDArq3J7XU/aFzdH5mB8NIONcZXRG
 ALFlBFJa1ylMxs5vmxylkiWUw16JYNuwktsaoxz0QKPshYVcm+U6mOXq32jbjv3on880
 cM+A==
X-Gm-Message-State: AFq9FYKjH2UYXXzfQQQhhxgTHDVrdc9yb6cuL1Zlt5WuQ4a97FNa2HBP
 q5K5w7m2UtGTvUu0ruMrMFOZui1gBrvQF1/zZ/w5TxBNUMr2vtI2jXRrdNTavHUpLaQeBPqDUJ+
 /wA5RVjhOvS7b3A6G/JMaIjVegYbEE1U=
X-Gm-Gg: AYBFou04UsFjU2GCyjoCDPB/RC+/q6XUZaS+nUFSk5+C2P19gOwf4QZqOEOnKGo+o+Y
 rXFmMILt2KidQN4fazCvTriFZ5JikWHuSUwDUCVjDxIe30dE0SngF1TTYl2nJ97KVa4szK6rKAk
 EqW9wX7OkbxSEADsSUqUDhrtDpDDFQtw6gRiVvQ/QWuJxxQq0sV4YNIHdiC5e2GgUu4JE24lPnB
 3NQ9cfPJ8NMJTQtZetLMUVPDqZ4ZAjATKbocSxuH/2hTi5gZ4585EEGeBFm0PGtYSeihr3afX+h
 MIN82TTGju0DVureiliDhcbpa3teI0TQWQUo5tQqrn4nU2SQkzD3pWk=
X-Received: by 2002:a05:6512:b0f:b0:5b8:f0a4:3501 with SMTP id
 2adb3069b0e04-5bb93810f38mr3050806e87.2.1791179666818; Sun, 04 Oct 2026
 22:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
 <arPkoItGqH5MY7TQ@kbusch-mbp>
 <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
 <arVkj2tPEtYtM-w3@kbusch-mbp>
 <CAO-Q3bzJWY7tmaz708VUd9=i2Uiqw6zB-KstdwJBDkriyCzoaA@mail.gmail.com>
In-Reply-To: <CAO-Q3bzJWY7tmaz708VUd9=i2Uiqw6zB-KstdwJBDkriyCzoaA@mail.gmail.com>
From: =?UTF-8?Q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Mon, 5 Oct 2026 08:54:15 +0300
X-Gm-Features: AclHuK8GaGzAULFbupGwKQ_PF_CpWSJFr6_1-wMC0xMUG24WfgqeEZ_lnx7DvUc
Message-ID: <CAO-Q3bzaFyzQ8md_NBKLV4t_e5j1kEjz1_XMFu3P-4YYF4RikQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
To: Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x11.google.com
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

Hi,

On Fri, Sep 25, 2026 at 10:32=E2=80=AFAM Markku Ahvenj=C3=A4rvi <mankku@gma=
il.com> wrote:
>
> On Thu, Sep 24, 2026 at 8:57=E2=80=AFPM Keith Busch <kbusch@kernel.org> w=
rote:
> > Are you also using shadow doorbells?
>
> Yes. The ioeventfd calling nvme_cq_notifier() handler is only
> configured when n->dbbuf_enabled =3D=3D true.

A gentle ping on these series. Please let me know if further
clarification or changes are needed.

Thanks,
Markku

