Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B442FC54E41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 22:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re0fS-0001g6-3E; Sat, 24 Feb 2024 17:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1re0fR-0001fx-2s
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:38:49 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1re0fP-00018v-LQ
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 17:38:48 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5649c25369aso2337463a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 14:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708814325; x=1709419125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEluI7LvDw7LFX5VQEn063ItBW3HwsptymCLrHlIUGI=;
 b=hrPYDjD9W2Gesgm4L6SQe9RuD34TbW+1oB/B0tA0RTpfUtC0GIjcqwuzifMs4t9X3+
 TKeWGJWvk/Hn7JGMhDWNInMVANuoxEawa+rbRiZ7kVZsBe+eNo8sXh2QPnXk1IcpdlZ2
 PVBfAjRVDaQgRtpLSzC941kjtYCPKtwXiISI4PbSaoyGMLYM8BZPPI7dwBZFvfT4v941
 aLXsx3lV5DJ2HMzTCJVj6xFOko8lHyOcGLYXktrkZm9X/OQ40LeyDSKpRoRvj4MwT40p
 itipU+YDSDAm9vtVmd95ZY5Uc1zoCcJqwpFlIxbt7ZDfihzq8eImqO1X/7GHJBJ02Fhc
 mE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708814325; x=1709419125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEluI7LvDw7LFX5VQEn063ItBW3HwsptymCLrHlIUGI=;
 b=jasxeVwJ/GRf7JhZM0kDd2HI/CMjyZJqMI8x4Ud4jx1PlwtdvrDLi2sgB6fxMAvBxi
 3o2+g2p/pD9eL/wfzbHQhaui8Wr72XOQNyCm8r5+PMVH66T7xeUaAAGjiW5lrQ2sgCfj
 vnY1fehgbNCQxvPGPG2Epncuqw5SI5dTQgUqdEzcGtfZXLHVAdato3jQpOJ2iLRz/rfL
 /cgV/8xX6gKUOBIe63zdpaOuFSmNSAs4zgIQQ+hkWYVa2lk1qrEYCv8lbqQ+1dbTBG1W
 VCgaW8ATOBSWX7WHSOT9qfTo8qmWHwawhhAhkz2nwvI4WeJ71yOmrkx8hWlRuZz87Zbj
 kvLw==
X-Gm-Message-State: AOJu0Yx2d3cIWR8NMrg1MgxK3KIfts56oUY3kaZK7hkH9WRylN3wQGp6
 OzETFO9K03r4GEbJvDrLDHMY4G3FOZNCB0fcq27KumnYHsplbCpNUMrTMkxglaq07NSxidluvkw
 Bh3EJz9KKrPXE1nO+ArsNLk47+uQ=
X-Google-Smtp-Source: AGHT+IGwfCWYBQmFql5XzZmlAw8qa0O4J9dpcMXcpQCXBSN7Uguk3jfvHidORqTaQL7tfMsnLqfxDxur1pU+ccJMDvc=
X-Received: by 2002:aa7:d385:0:b0:565:9b29:ad3e with SMTP id
 x5-20020aa7d385000000b005659b29ad3emr1736557edq.6.1708814325480; Sat, 24 Feb
 2024 14:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20240219181627.282097-1-marmarek@invisiblethingslab.com>
 <20240219181627.282097-2-marmarek@invisiblethingslab.com>
In-Reply-To: <20240219181627.282097-2-marmarek@invisiblethingslab.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sat, 24 Feb 2024 17:38:33 -0500
Message-ID: <CAKf6xpsA5dDgLavGFbT1Jyd1LQS2ZEwUH9G=GdLYnA+1ntohwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] xen: fix stubdom PCI addr
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0IChmZXBpdHJlKQ==?=
 <frederic.pierret@qubes-os.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jandryuk@gmail.com; helo=mail-ed1-x534.google.com
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

On Mon, Feb 19, 2024 at 1:49=E2=80=AFPM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> From: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qubes-os.org=
>
>
> When running in a stubdomain, the config space access via sysfs needs to
> use BDF as seen inside stubdomain (connected via xen-pcifront), which is
> different from the real BDF. For other purposes (hypercall parameters
> etc), the real BDF needs to be used.
> Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
> entries.
>
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>

Anthony made these comments on a different version of this patch:
https://lore.kernel.org/xen-devel/48c55d33-aa16-4867-a477-f6df45c7d9d9@pera=
rd/

(Sorry I lost track of addressing them at the time.)

Regards,
Jason

