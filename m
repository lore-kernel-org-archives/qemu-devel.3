Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE65CA0EE4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmHd-0003hS-BP; Tue, 26 Aug 2025 01:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqmHY-0003fY-OT
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 01:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uqmHT-00056S-JX
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 01:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756186294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arzY1zaiIadmcE3kE+Cl9U2WIt3ZzJN8rNJ1N+aTBZU=;
 b=DqAaD8EJUNvnddb4hedGVCsWTm22tfSXV6g9mrMq5DAb/FgaTU5YNYarDeMvIP4+nm2fLG
 xDDBh9pl820DTlzaFsD1zZUuZxv3uLn3YSg6EeRlMpbjQF+T2HFLxdM8odyqqGgaYjvjb9
 1uzK4TbQE/vFXzQEPS5hjqi3FMiHpnc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-TBW3rqB5P0m5LYJCfUeZEg-1; Tue, 26 Aug 2025 01:30:12 -0400
X-MC-Unique: TBW3rqB5P0m5LYJCfUeZEg-1
X-Mimecast-MFC-AGG-ID: TBW3rqB5P0m5LYJCfUeZEg_1756186212
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71e7d652a65so60629667b3.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 22:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756186212; x=1756791012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arzY1zaiIadmcE3kE+Cl9U2WIt3ZzJN8rNJ1N+aTBZU=;
 b=saF9RytKlAZN+R9C8vZ3U+kgTz/kmmhcNuak7Ussa1uafi/N7qA7jn1iOgo9A6etVW
 +rawIKSZlWjkh6pX+ehegFxyiZX1xnyUn5CB0EG2+BBWMCuMV+NQjn2DMsLrMmPuaB1R
 gUTMvEXRhGZrJfVDPDA2hbYn1Wk9Ps105PnWKc781mZaRvwDxGULmMsylQedacUqP1MW
 o3+PhkxFK7BoKMqLq8v5337ybJGqaWz6JLWtny0laSQuRG1w3WeFJl9Ol4KEzpMTw0E2
 b3kMV5knDGnrTyFxV4EdUnv01I2N+OLp3kqUK+/JWsX/ix6Quodtj1+PZj/o/CMlQ7vv
 1aeg==
X-Gm-Message-State: AOJu0Ywk5f9MPwg5BtGt6HkbE+Mmhe44OhkH3B9AVchy0Nabrd3Zxg6z
 PsU4Ex+ky09vpF/SYN1LONl2fMO4h/Lybv/QjMNTA4m+EpC4LyIS4GgF4tI7p3ogu2W13ME8k1f
 0BgL97lF3DdZJzfKAceNzOXNuB1kWa2JX5DX57RhPky1+2uCWavy2Hk+4Uoa49klKOUzxYl6yT0
 8kUwtgzrEWrdw3la1hS6700zO39gS9mpk=
X-Gm-Gg: ASbGncuOPgWpaPx/mvEDprLbBwNBSrN4jrEaUGgEUsBmUP6zVa+mmCd+ihwYd7B1Rxb
 GNSvQwOb70zgQMgs13Qs7Wo6mXTkdMyyRReFVmtsuCUrzvTcwKPcZlQh6liWrL+vDoCDFqhcMd5
 D/aznpyokX9McgLfFAOChHbtMd8a2tJbFBfLVTr+8TGolfcThHh/a8+FwF0u2HRBKBkykouFofv
 FCv/kduq9EM
X-Received: by 2002:a05:690c:a041:b0:71f:eb2b:83e0 with SMTP id
 00721157ae682-71feb2b8887mr120812337b3.13.1756186211744; 
 Mon, 25 Aug 2025 22:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Vp0aCeFGb+5zUvcapRValTo1OLGGqHogcY06tTLt0Uo9X0dE73nInnraY2gi2OjrMgIqkAuLSbmQfNieuRg=
X-Received: by 2002:a05:690c:a041:b0:71f:eb2b:83e0 with SMTP id
 00721157ae682-71feb2b8887mr120812157b3.13.1756186211124; Mon, 25 Aug 2025
 22:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250825145241.170717-1-kkostiuk@redhat.com>
 <20250825145241.170717-3-kkostiuk@redhat.com>
In-Reply-To: <20250825145241.170717-3-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Tue, 26 Aug 2025 08:29:58 +0300
X-Gm-Features: Ac12FXxaA6e12cf5I0S_hAuEA_bHdCZtxciCtzsO1furTsrfdQmUAvlVBLwFG0I
Message-ID: <CAGoVJZwcqsuOQaD2m_DvcsvgXRS0fCx8T+3VyE3+ViH7chGHfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga-vss: Remove unused dependencies
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 25, 2025 at 5:52=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/vss-win32/meson.build | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
> index 0ac918910b..a6b810f12a 100644
> --- a/qga/vss-win32/meson.build
> +++ b/qga/vss-win32/meson.build
> @@ -13,13 +13,11 @@ qga_vss =3D shared_module(
>    link_args: link_args,
>    vs_module_defs: 'qga-vss.def',
>    dependencies: [
> -    glib,
>      socket,
>      cc.find_library('ole32'),
>      cc.find_library('oleaut32'),
>      cc.find_library('shlwapi'),
> -    cc.find_library('uuid'),
> -    cc.find_library('intl')
> +    cc.find_library('uuid')
>    ]
>  )
>
> --
> 2.50.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


