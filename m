Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501E2C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEJj-0006qh-7p; Wed, 26 Feb 2025 05:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tnEJh-0006pv-GP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:07:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tnEJe-0000mS-8Z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740564415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYmnIimy2+L/WEgWeB/17gfu7rGAE/Qq4yQT6fHxQtA=;
 b=IhhhN4PXSI+mEA6QVLwOVgmXdt7si0CD8KoeSNgaZoVvk490W9t96fT8xinPCnreW/uYcw
 hZbp4MpQTDdzwPmgSHhVktMT2n3pXlJUYjYK+7qHJA37lEYFSCqms/J/bPpWrWT+YdscpF
 pcopi6ZK7EwssXx1lBCAzmy7JdX9dCo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-MwIrgST-NwyqsIyfVhhvVg-1; Wed, 26 Feb 2025 05:06:53 -0500
X-MC-Unique: MwIrgST-NwyqsIyfVhhvVg-1
X-Mimecast-MFC-AGG-ID: MwIrgST-NwyqsIyfVhhvVg_1740564413
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e867ab3537so53110446d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 02:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740564413; x=1741169213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cYmnIimy2+L/WEgWeB/17gfu7rGAE/Qq4yQT6fHxQtA=;
 b=P16QZGGNv8Vp2wVEl7Jdfzz+8VM8ohMnYM33XPely/XGFRXWryPaxagAjR74WyB2Jj
 Q2THajVbutY7tA0F5nD216mwmQBmj5u45nKm9f1iaBd1C1eMb2kosDlRmtAM/29C71Tl
 4SkCkl6GV2Yub9MWgvg9+hBC3ehpcqYznIGiuG0viBp1X5wtryOMYzdQY82LYqZ2TyiZ
 hmD8JAkTHGJ/eCvzLQHQvAoeetcMFw6ir4XDoVA8Nm+HecKuBRrSFd7EOphA6NUnqJUc
 weNeuw71OfNU/w7hDsZxop5ipymd+7fW9UUsqnjodIIu9zX/562GDNx1oEnNXLKeZey7
 uOUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRY6d669HGxgmcKoxQCeI1W/udHqew8XBzHjZaXbUbpbex4uiMpdiSyZTEfoQy0BdAE1Ss04znVY6B@nongnu.org
X-Gm-Message-State: AOJu0YwXBiXHNu+N+UZOKll0JDIcMbipNlQQ+lhU8AcVyfa2FV0C9r4B
 5ztRP6Y36Mm9Why//OfX6VnU6zSUKTz3NWejlPnBac7HgVTH65ImRgy17zopN685HLLYWW6zLnW
 IryT2T+uP/s910Jqya55VzRv8YP5sRUtc02E/eaRcyuSKkHW/b+4sojLwOeZIQ9BIT+N/sPIA72
 7jWDHtrWyop+LE4JJJDFWDcxpMexg=
X-Gm-Gg: ASbGncvKTymJLX1puBnG1VUzs6Xnz+ENtBxHuUyHq4f7QnB30YHTxIEnOz360m4eN/V
 r635iXieQBQVXyFv/GNB5VM5tP9AUKKTUW32HEIwa3lUiMHQVgGM0w/7Y2MAPWd0XqDM77CpI4g
 Of8OAdcnFmzrEs2abiyEVZ6Xl6YCBPmg==
X-Received: by 2002:a05:622a:347:b0:471:fe62:9627 with SMTP id
 d75a77b69052e-47224716d1fmr310488511cf.3.1740564413406; 
 Wed, 26 Feb 2025 02:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIv98qkgiQRlsiNcI16G3tmg/iar8KE0LDCJY6abqmfRKkrDOUq8gGUuz3EozTbEamG9FG6w6816tfsHke/Zs=
X-Received: by 2002:a05:622a:347:b0:471:fe62:9627 with SMTP id
 d75a77b69052e-47224716d1fmr310487981cf.3.1740564412653; Wed, 26 Feb 2025
 02:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20250226075913.353676-1-r.peniaev@gmail.com>
In-Reply-To: <20250226075913.353676-1-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Feb 2025 14:06:40 +0400
X-Gm-Features: AQ5f1Jo7n_otPNf46VYeiXkUDJy4kGMvIllXp_Uu8lKwm1CPCzc4Jnb82Ot59bs
Message-ID: <CAMxuvawEAXpTtUUHsdi-jX6pMRTD=LD5UTu0iN_7-nqf4F09Uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ui/console-vc: various fixes and improvements
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Wed, Feb 26, 2025 at 11:59=E2=80=AFAM Roman Penyaev <r.peniaev@gmail.com=
> wrote:
>
> This patch series brings several fixes and improvements to the QEMU
> virtual console (VC), making it more usable and aligning it better
> with VT100 spec. The updates include support for inserting and
> deleting characters, better cursor handling and correct position
> reporting. Without these changes, the console is hardly usable.
>
> 1. Support for DCH (delete) and ICH (insert) commands
>   * Properly handles character deletion and insertion as per VT100
>     specs.
>
> 2. Add support for cursor save/restore (ESC 7 and ESC 8)
>   * Implements legacy DEC sequences for compatibility.
>   * Ensures cursor attributes are also saved and restored.
>
> 3. Fix cursor position reporting
>   * Reports cursor position relative to the screen instead of the
>     scroll buffer.
>   * Fixes issues with tools that rely on accurate cursor placement.
>
> 4. Ensure DSR (Device Status Report) responses go to applications
>   * Stops terminal from rendering responses to the screen but instead
>     send reports back to applications.
>
> 5. Handle `ESC ( <ch>` character set sequences
>   * Makes `top` output look clean by handling the character set
>     commands.
>
> These changes improve the virtual console's compatibility with
> terminal-based apps. Without them, the console is quite frustrating to
> use.
>
> v1 .. v2:
>
> * The VT spec and ECMA-48 standard are somewhat vague about exactly
>   what attributes should be set for the ICH (insert character),
>   but various terminal implementations reset the character to the
>   default state. Instead of inserting a "space" with the current
>   attribute, call `vc_clear_xy()` for the inserted character.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org

lgtm,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Roman Penyaev (5):
>   ui/console-vc: introduce parsing of the 'ESC ( <ch>' sequence
>   ui/console-vc: report to the application instead of screen rendering
>   ui/console-vc: report cursor position in the screen not in the scroll
>     buffer
>   ui/console-vc: add support for cursor DECSC and DECRC commands
>   ui/console-vc: implement DCH (delete) and ICH (insert) commands
>
>  ui/console-vc.c | 154 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 142 insertions(+), 12 deletions(-)
>
> --
> 2.43.0
>


