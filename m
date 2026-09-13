Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E02C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 08:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5fvv-0005oa-KY; Sun, 13 Sep 2026 04:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x5fvu-0005oR-KF
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 04:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x5fvt-0007V2-0c
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 04:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789289488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEDnZK2M5MZLvR5ufB4E1ctCpfVdiqMg96TBTZznKnY=;
 b=Ahg/3TMnkg6ge7YBpDh07kcIlBApK825wlV17AQbUiGvYDqcfeplXOzrEae0IxINJNoWUf
 /j2j4HfJ/efJLI9rTkAT78pm2tY6ph8LyyzqGJ2Vqm5rlOccVsOiXVUyKO3iC7cK96851r
 jtALItWzmI9YvqalpCpzLu4/3w684bM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-5UXudFarPh2XfG2TxNjzUA-1; Sun, 13 Sep 2026 04:51:27 -0400
X-MC-Unique: 5UXudFarPh2XfG2TxNjzUA-1
X-Mimecast-MFC-AGG-ID: 5UXudFarPh2XfG2TxNjzUA_1789289486
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so5045965a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 01:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789289486; cv=none;
 d=google.com; s=arc-20260327;
 b=nPGup97xvUfbDv5dd5721CUPhabBLK0qc5hTniiMMF4VvHWbjilr1fN4+j6qa/HrrD
 IHsQKuMn4iTrsDHo5k604l/d0ImAc4oeVCWEVdgXT6Q9dNm9Ps9G04I2xepg0AgXqmDg
 3Zo3fIxkAZ62emqaoSkB6IU4i/vkIlO3ZhPRQ25PsKpz2ZQpmSpSgaq8BpFf7PJNt8jf
 3MVh99c916C8SP9JpzWIUFnRaZ2wcCKK8NxwEMYqUyiwg2I8ZFvuuSX2ABYiBLmb4jMG
 iVt6FQ9GJi+yQnHtu7j0RALUvLtt451ZR79BjHBcWRzld2nMDzaXYsk/S6H+eiNq5yrX
 bGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DEDnZK2M5MZLvR5ufB4E1ctCpfVdiqMg96TBTZznKnY=;
 fh=GIU+FyOM+eiO1tYKbHGSJ9iUu0d9Nn25uUBQaeMGCdg=;
 b=NksEk5CnGz1l503UuozJszWWTOhLXcYbe76T1ZC3ORlPjzG9JgTzZUZ4U9Bo1pOpYP
 q+NUwjhvDMjiDTupgmJ1zDCzBiUEgLuhdev1uwVFQoVmIvTvrxz47GdvXOe9PscQT3FK
 2lvxIu5rI7cCRnleNXNm60hc1zm12tu8E1op0SzU10tL5N4Scq46FT2ADMVQbUfzJfjv
 ImEmBufHUF8WuuiHcZeDZyHaKJ1nehI7ysEjXI8VGK8rw4wJnJegJaKRJcUaX8kVotQp
 qben2AAATRkTmAeqIdaqzdPMmx/k4BGqkpwwg2P0e8i7dCwQzrzGaryL+P6xo6SyXrjK
 NWTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789289486; x=1789894286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DEDnZK2M5MZLvR5ufB4E1ctCpfVdiqMg96TBTZznKnY=;
 b=WERI9l4wccJUwMxllFAcCZxWghEBmW8GBktexoH8w3ChvBke6nCc6C7dGocAxFccZV
 C+82V/dygsk/gvhAbdrCQH2NoumiqGmW7gIJop67okeg1VAH3KXlFiGvk3+beMWDYj0Y
 QKcMfRWrxkF3g1kk9LDmFJnPtB1acVm6wfMq44nIhFlUVgLgl4sOPk7iJN9O5ZRPzJbs
 n/K0QV6MFRNHpAOXkps6xxRapWKmidS9acENNS4O6G9E9YPMtNGGmCghZFCxtsUsE8Z4
 j7nhjzPTRZjI0gfwISIOi2FDHjQBTBvUMfTZOko0+2uMH32YUCkvdnHeA67Q90ct2UeY
 Y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789289486; x=1789894286;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DEDnZK2M5MZLvR5ufB4E1ctCpfVdiqMg96TBTZznKnY=;
 b=SMhyjWjp9pE1pfHW5w3G1LlNwO7qdyCv3VhmxytgTlTMZ8SaOBpoDrHQiQqnSsgStE
 m01YXnVGqva/ZqcZ00NjKW6X6uZcqkBPk8dwCgLk52kJ3UQ8G3DovFeOW5IDzSTKbKb4
 Td/vUxYYGvWq+YkqvsB/HdL1/Oi2IZmGOzUYg4SBuP5twmORxKgqOa49Punidpg69zQj
 GWVYWHdtMi0kngW2ZZwlxkXbbqzXqUcgrmkZhdISUrM4iNUpp9reqXd7SlUjH/GX+1R8
 xBTal7Xk3Nkc6OKElck8eMdNkQsl7YumBicmWE3SCTvadnIGCfyS0ChEw3AXTuNrk9Qd
 2pXQ==
X-Gm-Message-State: AFuF++lngtGaPwHcjFGCnfmpaIkEKt/1kjBFqJBhuPYx/UbfMaLTBKaZ
 U2i68irNuyMjc5aqHb8VO5WQKdCEFZvC2Xm6bpgDjEBv1N8J2ukL2SICRPd1UCj5uLJ0RoqwISn
 0pJ+o5MTSlZ0xus4s0nF3XNOogHF51hOM3+vQB+yBJ/sTDv0kumtQMj0tcMq0BX4fCBCk0SWJAZ
 fr5xR37j29lrLZZJ913vws8L4mirtGVHnCtXH41anY3A==
X-Gm-Gg: AYBFou1T2r9WyvF7wG4upcLlHa5SnISbDYFHebKxVP3XCm14QIOkRIb+KFEqmQIVB1D
 Kjexuhsrx0jqT7SUUvmAqF4n5CgUYEImnB0VaPqoMAH73DhBJJ0tLoRGLaGQMSr8McK9Q6zOdr2
 LTQJPYQQ/N7pT/c/BDZ3ebViEACp0veQgfGBpE6LCj/2yZvM7DD8PTUY85G7+AyO3doWyZphPqT
 mcRFsLw2wgbeFT7PDOoF39WkyB16HJBhrAtWrp853QIzJw05j3gVxwlHn5rN5eSydgaKCNAslq1
 uA==
X-Received: by 2002:a17:90b:4990:b0:396:4cbf:45a2 with SMTP id
 98e67ed59e1d1-39d9c0acc23mr21789154a91.14.1789289485924; 
 Sun, 13 Sep 2026 01:51:25 -0700 (PDT)
X-Received: by 2002:a17:90b:4990:b0:396:4cbf:45a2 with SMTP id
 98e67ed59e1d1-39d9c0acc23mr21789130a91.14.1789289485479; Sun, 13 Sep 2026
 01:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-gtk-v1-1-3e4ac542e054@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260913-gtk-v1-1-3e4ac542e054@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 12:51:13 +0400
X-Gm-Features: AcwNN1UlfaawQaNGD3AZEGxmcggIlNKHtImD03lbkZU5h-PjWJCuPC2EhnJ2krg
Message-ID: <CAMxuvawfKaBsigaf1Yfc+xGqrm2Va73tk-CwkwSH4yBx-FwkVQ@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Work around the gtk-menu-bar-accel leak
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi

On Sun, Sep 13, 2026 at 10:45=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The implementation of the gtk-menu-bar-accel property had a bug that
> leaks memory when the set value is an empty string, which was fixed
> with:
> https://gitlab.gnome.org/GNOME/gtk/-/commit/44bf10c4a2a0463891884a105fa27=
cf36b73f119
>
> To work around the issue for old GTK versions, replace the empty string
> with NULL, which has the same meaning for the property.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

good catch :)
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index c615d35451b6..ae28f1fbb89b 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2645,7 +2645,7 @@ static void gd_create_menus(GtkDisplayState *s, Dis=
playOptions *opts)
>
>      /* Disable the default "F10" menu shortcut. */
>      settings =3D gtk_widget_get_settings(s->window);
> -    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", "", NULL);
> +    g_object_set(G_OBJECT(settings), "gtk-menu-bar-accel", NULL, NULL);
>  }
>
>
>
> ---
> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> change-id: 20260912-gtk-2ab3b3ab846e
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


