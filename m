Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963DAC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regvB-0005GR-Vv; Mon, 26 Feb 2024 14:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1regv4-000565-Uz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:45:49 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1regv2-0002wl-FY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:45:46 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3f4464c48dso408231966b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708976737; x=1709581537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOv4OssCP39U8j32iXuCjiknLlSfnR6OeHSgs19p/z8=;
 b=i+37ZIPt4pwlH/JvIw1E8X4NWO/3kgDCDO0iQEOqmoWXMdTBmT0h3WLc5gOnUPQwuW
 idudDtp1UrRqqvxqyeRCRyTc0lfJzAZ2uqSroDu4cxkE3jX8JYZR14903Kw0dmAbwHlH
 yRXWrwkgGeY3/K59RJ7sW3ATfo5K7wFlvXZHJQaWkfyww4YjkOw/vJY2LA2bjC0QW9Ck
 i0L45PsWoc02Jtzj3zzYHGxCAUI6+FESGEE7lhGJUmSQrcdJTLfPb15qvECC4Q67SwnX
 1E3uxdECYiekPOjh5mNKGes/gy9uVPwSlGjP2O8GEmkZyyDiR/LJa3sSlbsH+Txc/3Jh
 R3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708976737; x=1709581537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOv4OssCP39U8j32iXuCjiknLlSfnR6OeHSgs19p/z8=;
 b=s4Oe7gDaqjaQcR3jXylgvXdxOav5u0s5bQX08em8kiX0xjUiXK2G1IQHAgjC0sNrXb
 Y76Tyojah/XFxcUWfRrRHGLEiY3NT5zKBLa5V6fFH1WSopcj8zxe8i9ozGzxQ0G7UFos
 YyY70evRHcIdbBV+7JiTb5H0v1FOlW6mFkaTJytwcZ9X4A0dzq7qM7IixDI5hLGAZibC
 dC/fOBLwlYQWtqLEayZchGJi2tx2MSwPesYQmDMvWO0rfOzaxI9NQZL3IRwBfFmMBc5f
 fJzfMn0QXt4xV3mBzh0e6PbuRZ6V0E8vCImjXWLGrgwoNK2o6jv1h1leOJ9OsBeKNAls
 q1VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4XKo8medm9+tdzG8szKM62PisqMJnY51IeeyLQLUHT6UBTjt2Yvb0TctyuD+s+NW1ifQ8NMQrBUxiPMXE83ykJV2WFSU=
X-Gm-Message-State: AOJu0Yz4WSeclDwRqXE3lUVtoJv9qB388iFfZgJaKqP7O2iWF97rny2I
 hUFU7o4dT4kCRtsYxhJpt7ZxlPo+xq/wwo3dl4NfZMpjOSqp0Zu65t0v46kdiIf/F+7h35sMPsk
 rJ03EzUTAv4ahciZ6ITMqoia0TVfgB5fTD4p5rg==
X-Google-Smtp-Source: AGHT+IGCDofZFbqGsxTvNPiQyqGzTH3pg0MaY2luJKD6gChITjghvcHzNnRBn8oizLh3Iw2GXrX4Y/1EmwKWlmLfmAI=
X-Received: by 2002:a17:906:c02:b0:a3d:78a:bffa with SMTP id
 s2-20020a1709060c0200b00a3d078abffamr5287884ejf.0.1708976737134; Mon, 26 Feb
 2024 11:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-2-hao.xiang@bytedance.com>
 <53205040-fd1b-4ced-abd8-fde5275d472f@intel.com>
In-Reply-To: <53205040-fd1b-4ced-abd8-fde5275d472f@intel.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 26 Feb 2024 11:45:26 -0800
Message-ID: <CAAYibXhV9QsbwuWEaNDhmij398HvJ=uDg7mgrF6yb0CJPd70sw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/7] migration/multifd: Add new
 migration option zero-page-detection.
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, Feb 25, 2024 at 11:19=E2=80=AFPM Wang, Lei <lei4.wang@intel.com> wr=
ote:
>
> On 2/17/2024 6:39, Hao Xiang wrote:
> > This new parameter controls where the zero page checking is running.
> > 1. If this parameter is set to 'legacy', zero page checking is
> > done in the migration main thread.
> > 2. If this parameter is set to 'none', zero page checking is disabled.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  hw/core/qdev-properties-system.c    | 10 ++++++++++
> >  include/hw/qdev-properties-system.h |  4 ++++
> >  migration/migration-hmp-cmds.c      |  9 +++++++++
> >  migration/options.c                 | 21 ++++++++++++++++++++
> >  migration/options.h                 |  1 +
> >  migration/ram.c                     |  4 ++++
> >  qapi/migration.json                 | 30 ++++++++++++++++++++++++++---
> >  7 files changed, 76 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties=
-system.c
> > index 1a396521d5..63843f18b5 100644
> > --- a/hw/core/qdev-properties-system.c
> > +++ b/hw/core/qdev-properties-system.c
> > @@ -679,6 +679,16 @@ const PropertyInfo qdev_prop_mig_mode =3D {
> >      .set_default_value =3D qdev_propinfo_set_default_value_enum,
> >  };
> >
> > +const PropertyInfo qdev_prop_zero_page_detection =3D {
> > +    .name =3D "ZeroPageDetection",
> > +    .description =3D "zero_page_detection values, "
> > +                   "multifd,legacy,none",
>
> Nit: Maybe multifd/legacy/none?

I changed it to

.description =3D "zero_page_detection values, "
"none,legacy,multifd",

Since both "," and "/" are used in existing code, I think it would be
fine either way.

