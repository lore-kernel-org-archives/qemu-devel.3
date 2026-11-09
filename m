Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F11606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iMrNc7iD;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VNmDQl2s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQJc0-0001VX-D9; Mon, 09 Nov 2026 02:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xQJbw-0001Uk-Ul
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 02:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xQJbv-0007Lr-Bt
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 02:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794208568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vw0MjIrQHwnDNCmmm8eSDAsDv++4NQFLCnT8aVSLQfI=;
 b=iMrNc7iD8cqpSkVcAEHIU62Ny68lfz/P2akIjgEQvFNLz9b1UZP3Yk4hFV04z07jj3NfE5
 tWm8w3JbBlGMECzkpx3FjP32XWDTo8lwTWuq4fIGA9gb9K07SeMjGswGVpxymPm/hzV7K+
 /JpQGXtp/lbVXkMXLpAu9iSkY0j+XTs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-QjhNB-0wN6mZ2nEpJ3J0VQ-1; Mon, 09 Nov 2026 02:16:06 -0500
X-MC-Unique: QjhNB-0wN6mZ2nEpJ3J0VQ-1
X-Mimecast-MFC-AGG-ID: QjhNB-0wN6mZ2nEpJ3J0VQ_1794208566
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2eaae8d29e0so9204345ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2026 23:16:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208566; cv=none;
 d=google.com; s=arc-20260327;
 b=S/ebtTinyC/iNHf3s2+Mma0FrN8jhFleZMgi+CK2+GTJHZSbW6DSqj3QbtBQExNjSi
 FklmcDW/ZW6TBWVhNqGFbjwT/6G+nW9gTnNBORnbBva8qLi/XBCoDkMx9CnEQW8f7mgK
 CxT3PSrGcp09H8Gf++zphE2VMl8g10Afd6Q+a/arxg/PV0lixTtffn1BW8N1FFHxEFZX
 wNu8CnQDwmtanhbla94sz40Wtm9HSv9k6wJLNQEfEU2RvlpgxLenhP+aduSdg3nx4dje
 z/6G1b6AHLgiaLCtNc8RpR4KiRF6Atxqvnk1A9j2mJAg5qvAlcQmhOY5rcv3zSgsTZw2
 IM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vw0MjIrQHwnDNCmmm8eSDAsDv++4NQFLCnT8aVSLQfI=;
 fh=1/yJUpwfxeCPDwcup+8GpKBkHpxHjfJAMlOkiio4CVE=;
 b=gHdNZ6fX5ysSnLSgg9tVGiwzYINEk2QLbBZG4SCI/xIfex6mlOqr2PyYJAbAFCyhnA
 wYbsaJhpaMt4XyBrvnKPwkc1aEsPSnfqo46N0RM7lBT15C61PvTMOV1PH2k1ZVBrlEpH
 Kj4/hKGT+iCzNOC5jF9yIP7Rpp1qBUI9hZT5nWtweUn03nmHgxpKDVffOzN0IUTlfIb4
 NXh4iGSBqfxfkntXi6UMgOw7c+qvPT5iem8gIm/DNArDDHc5/N/J0syG5PA/OgHW+Dnq
 BpPhvxgrvzyEZ4bx52OG67PdeJsUCJIFWb3oEIO/RwQXPa7GBgT/sQr2LjKA2bLCIgQu
 LAFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794208566; x=1794813366; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vw0MjIrQHwnDNCmmm8eSDAsDv++4NQFLCnT8aVSLQfI=;
 b=VNmDQl2s8bWa34/8E1xMvaLPem9D4KFugrSWGtB0k91h3HoYrtnHJAFMuQh+n/VM6v
 xc6LkVh5scEziZjl584OJLvUSTGE+V6A5tRooeSHZu2CllwUOCWRtNqmb0LogfOnFc9l
 tCHnCcjVA3oNEiOZzX8qpUK3D0JvsW+O2/sBQqJTKlIMRscpxeULToI8/uKYoDkbtR+n
 gOYL5JU/+/YblLd9y/wuKTEfbuRU4XKj1MucCVGiqHpbx9V7A4/Ko+DoqSMiGM0VOyJc
 F+aSS+wZm8Ir9ffSbhGhbjIqzPIDDKIPXUbcHvQkp5jgmW1jWpKYXpYAaQxjj/iStDGF
 ZYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794208566; x=1794813366;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vw0MjIrQHwnDNCmmm8eSDAsDv++4NQFLCnT8aVSLQfI=;
 b=g/GuXYTtz2e6QvDxikmhhbfrBEKBrEI0ok687akgepUcZ8EjsmVPZPDeAJYKdlqNkG
 s4vFwZlER+6bE204uCMzghG9tmWeXbsEFtB+K2wcjz2lIcJTQVam3ZCxEo7L25W0kDwi
 3Vmb6knsQEevtGfi/JV7aq/BLhcQ1o6xku1gb1hBZhOMiy9bMBJ1yzSRSaJFCbwsNWkk
 xhjCFHsraIjJQwuqYAl48ccbUI5GB25mJu1h/l6BR1eNRPyyP3aY1XZH9l7OFMNy+UhI
 kURgig9md7XKLNutwhiShUdZU4DCt8lENNlZ5CFnRWfMG+1gDK57VheNjAl9eA7Dr6gp
 uv5w==
X-Gm-Message-State: APuU4Z+xzeU+xW2rrA/v1yYFh7G2H41AqI2xwmIB1yHSJ75LkcTx/0Rw
 2hhvkzCCuejo8XDVJnXl3Z/NmnRYr6lzk5rUHhQuvnkwiQraWJ9QALBQ2oiuErnLkvYAWnLFMcI
 OppRvUhzVEHs0ot3GmvC1T09DfB1gKukToZ74Ac9dRhgWBkjbdoSA6A7j86Kis2HXWpu5KSHEIs
 V0FVrqYlK1h3oBp1BPyKXH76vW/O44hXc=
X-Gm-Gg: AYBFou2JOfADn94Lo8dPUijnjRBQJjdXbQcSmhwnjc/DBuudtQvBtMjx2kU4Pze9f/7
 7WUfYAltaKFk5SO6kZRPME5yHiBeVQlc0737S6bI6Owwv/XxI3r2u+QtbdVD+JkYc/RSHwJJLd/
 A847j/rvENtpMTi1P4/FZMUEp3p8WP5jE6Lm1KvOvmWMFjeKYVG8NTm0ke4nqkGTuDE7a1vCVgb
 DHCE5RTxzID3eMFR6abn8aEDZEY+l0utz+LrwGqw/Vz4IB4Q9RAxkaEkXkp9cQ42zMfLJwFM524
 pg==
X-Received: by 2002:a17:902:cf03:b0:2e2:e0f8:e57c with SMTP id
 d9443c01a7336-2ed83c13112mr29443225ad.70.1794208565619; 
 Sun, 08 Nov 2026 23:16:05 -0800 (PST)
X-Received: by 2002:a17:902:cf03:b0:2e2:e0f8:e57c with SMTP id
 d9443c01a7336-2ed83c13112mr29443025ad.70.1794208565098; Sun, 08 Nov 2026
 23:16:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-from-v1-1-019dacf55d63@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-from-v1-1-019dacf55d63@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Nov 2026 11:15:53 +0400
X-Gm-Features: AclHuK-3FNpWucgtVtbOf9setibg1bl8O7u5oiizi8FKAoRWgmIiV0YVDsOG6Uc
Message-ID: <CAMxuvawDPG7Be_DFpqRFh21kBw90=QnBEzc7K5QgMj2Yqz3H7Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch: Drop the author extraction in-header
 check
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 10:37=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> An in-body From: denotes the author when the sender is different.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 82f62f602125..2904bd691dc5 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1823,7 +1823,7 @@ sub process {
>                 }
>
>  # Extract author email for trailer checks
> -               if ($in_header_lines && $line =3D~ /^(?:Author|From):\s*(=
.*)/) {
> +               if ($line =3D~ /^(?:Author|From):\s*(.*)/) {
>                         my $author_info =3D $1;
>                         if ($author_info =3D~ /<([^>]+)>/) {
>                                 $author_email =3D $1;
>
> ---
> base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
> change-id: 20261109-from-5be249dd4996
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


