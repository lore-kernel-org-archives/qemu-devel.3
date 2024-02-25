Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59AC54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reMcp-0005U0-0O; Sun, 25 Feb 2024 17:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1reMcm-0005TX-JF
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 17:05:32 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1reMcl-0001Ls-4k
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 17:05:32 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso2934795a12.2
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708898727; x=1709503527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkKvfyrMBWj0+DlETuXifPbtp+G+CbFdvNnXMM5MeUs=;
 b=W9P2SxQ4LQ9dOKG9daaWCnPolod9YbEq2nsh115N3PbEIrT+TKlnp/ulXQ2mSKvjCA
 X9+VQHFD779BmIf/WvviGvEsYka1es8hPfW515eolZGbYFBgZArAj57CDrZxFEZVTLQA
 TJVOFblkr3xfs4jehMxyYoRXmQsL+/Xegx4IfJMCxDac0fHa2aLvSPkJZlVd/CnZ8nc5
 Y29ENflfDvDTGqvNnrD9S2fjRGyxCemBqe034vU6P+4wECvvsH+WMk+BAh2Wbu91dWmf
 92CXJuP/kpA0+mWTk5ftxXdDhZBIhllSqFg0Rdx7NISdqfuLB6GR860swD5SweSRjD86
 cwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708898727; x=1709503527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkKvfyrMBWj0+DlETuXifPbtp+G+CbFdvNnXMM5MeUs=;
 b=PgYnBzmII9awfKRlSCSB9Vg5oKr/AlnFBGZIUO7SP5Hr4OTKfvgXfCJtTeus19aBQz
 Fz+0to0rJluPq3hd1T+UsgAMfwgP4LOHmGCjh0FqtOfHuAJbAiP+THZBYxq/dCYzXsdL
 mYC+h7we6fsvv0WXWsTHJY2H87fFa0wEqnnECfpNgsAhJ8w/yk8tPblduBmg1Q2mCHWO
 OWkgKxepu4HsqLEM6QisRn9d9IdKB+L0/NKb76oHY4V8/Kht4w6q6z2BJFUP4mdrXziu
 huHa+VnPQC5GQWkNQfvp4SuZSjLfGVQ1ttw5Mlo/UJgTwvCkt9yvH1vMmNuqxdNkb5MJ
 aMwQ==
X-Gm-Message-State: AOJu0Yx6KT0kbUEnuLTG2MMH4EQC1XP0fazYoxcPEHMKQLfPNGCZcbCB
 ZvNq2jf06lklilEtMrFBrLYzmos3CgPYH5peJpCKEvfuy+Y/+DBqMaY1WlxycQ9pDWIU/m125k0
 B6k3+EK2Y52aIK/+MeDENphjTPs4=
X-Google-Smtp-Source: AGHT+IHPh56IyeB2dNiGOUUfRg2lexOS+IfInlHodGvxOzUuY8w69pmiHjOZgl3KhqRNlKV7KBSPMR5uatl6c+8GdWo=
X-Received: by 2002:aa7:df83:0:b0:564:ded0:6072 with SMTP id
 b3-20020aa7df83000000b00564ded06072mr3954699edy.1.1708898726812; Sun, 25 Feb
 2024 14:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sun, 25 Feb 2024 17:05:15 -0500
Message-ID: <CAKf6xps-wWgFiwwdAF26-HxXPdaLism5viD=NY=g5EWJGLTCVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/xen: detect when running inside stubdomain
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=jandryuk@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 1:17=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> Introduce global xen_is_stubdomain variable when qemu is running inside
> a stubdomain instead of dom0. This will be relevant for subsequent
> patches, as few things like accessing PCI config space need to be done
> differently.
>
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>

Thanks,
Jason

