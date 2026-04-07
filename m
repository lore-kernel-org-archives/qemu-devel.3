Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC54FF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXJ-00009L-Vg; Tue, 07 Apr 2026 14:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTw-00042B-TN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA11d-0007za-JO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775547543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vO5U1rUKgGT19dxj0pmeESDUpJGhj+4ya/qvoLtjBwg=;
 b=Us6IeJSEEFZ2Si+Ws3/Hitcfm1k632r4+MP9cwYK2DzoTTPd8rgzPkfC6rEQJEpXfP4pKf
 EzORWA1wsvJf/RFg3ui0pzTgMEgSZDF5m2O9dk5mmHH0f1WFiRgnca9fcrtweXNOg7iqSm
 L0NHhXCaDdmgaF0Wo5dnnZmICZuoUN8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-wJ5YePUZMaei9GFu1fSP8g-1; Tue, 07 Apr 2026 03:39:02 -0400
X-MC-Unique: wJ5YePUZMaei9GFu1fSP8g-1
X-Mimecast-MFC-AGG-ID: wJ5YePUZMaei9GFu1fSP8g_1775547541
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bfd7b9cdso2181239a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 00:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775547541; cv=none;
 d=google.com; s=arc-20240605;
 b=TXYbJNdWZJ0wiomPKXOFWSShBn1+WrVnMg0wwyqKAKOv0zp4f9O90QVtAmuNeNez0K
 9Ud9yD1zsM/L9czeBLxC+DGNGeOGgWopThJ08cdYc9P7162Bm/uJlDY3uk2tAqWVFI+2
 Gh668M67GEkJ4dAhclCLDaEKrWf0Cqb5EO9TuhYjUfOWUEpgQfUB5oZpRY2lZGU8qX9f
 LPcC9zVaHPikUn+FWjTFUgARXPlLKDXqCd0BTFj5/OCO+Z02tBAxH8389eRpop8E6X5+
 9SXYGFcuFmNjG3+a64pFIypGYQDrKtgyoQ4hhY2GWwxwpxdhjCvb3fUgW1n8D5TATiKV
 QyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vO5U1rUKgGT19dxj0pmeESDUpJGhj+4ya/qvoLtjBwg=;
 fh=jujcIkqyn3FRnCbt7C3PuJY7od+eC76KIHLHCfXRwXs=;
 b=GIvShch+vxxRrstUnrSHAgbjnWL+8n0v3RJGI+nLVpcxaGDSKi6b4Q3i1iybtTm1BK
 9ht1CCXpBARB2h0uIZlHED/F+mPnzYImdCEhMWGo+X9TXCJrDQ13NCk2VYhlB/+urhdc
 5uW6+63HhIXZ1q8SLuvsQkxNfy/f99HlastaoxsJ/R3Rl56+X3OuH6bcIsCAJ/M2yZbG
 uR5pUn6xJ+vVjt7oGqd0OGooZ9YbACwyh6R29qzs7ncXh7/Ejgiu3S8f99SOiVTof/4D
 aSYSQJi8/nxlbgEZOIXF6794OevBSek92v9krkfbc/BFGSTXQmsVmYXnoAMziwWem88D
 bxHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775547541; x=1776152341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vO5U1rUKgGT19dxj0pmeESDUpJGhj+4ya/qvoLtjBwg=;
 b=lpv9U11+QWA/Z2A3HV7MtSyAeSQg46ZLr1uB2GJ2zAgOGC5+nKKtFTDubLXZGACoEY
 JnDgXz/Zep0wPY95pIBdirtuv3QJ5MO2TjdMPg1YYylK4dD0cPWzEIet0JaVlG3HYeiL
 J9PLyDJu13eoxCg3j0tKOQhDaT9aNUfR/asxeEgDtCpZ1rFo4CghosoFqgy4aTANMYoa
 dlSWiVQIozvbGxYsn6CStMXVANLg3WWljtLk+PsSYAZ5zLoNVxdujnF51AewTTzHE6Uk
 vsjIR3w7ZveLtgXie6WJWvAj7mFpqXB59q7ebAis/XLblKd3D1tvOxVS2KOj4SFIoV+m
 4gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775547541; x=1776152341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vO5U1rUKgGT19dxj0pmeESDUpJGhj+4ya/qvoLtjBwg=;
 b=TZJ5WwLNcWMhsztAeACdO1lXU+lIo417FmKypn6srC0cvX10IxMDpnGaSj2l/M2wWr
 fVulkOrqDl21iKT+Aq0SFqE9lJQfW75dDFaepCm/Ik02Sy2CZOh6/INnaejY+kHpFqoT
 QKUe5QWYddU8Mc7OBi2NfrGRvX9wZ5u6LxPQUQQpVHXp9pJWt0u4uEzv7W2Z/8x31FFi
 UwrnBXwEYhb7mTSoLwWQ7OqIjgYNHz3XwZzWV4fUlEnjy4vOKlCfomH7d380tr7aFN64
 fpaBy3ISDqrG7e/7wIbmvlPNoLgSrBS5yioZSJ5VovGg2Ri8x8fkUEFQwvnirCF3s8OU
 44MA==
X-Gm-Message-State: AOJu0YzvjTAIm/wHcavG8pMjSBej2Yn42bwhb71IN/Z1pPlAyVHLPYQ0
 rf275hlmOukhGq974N5DHcs8WDTJPRn9LDVC5RopgMigK71x3Zg8j3kIAjSVDl7zYnG/QWoggdR
 nUKsfmXUKQR+etYHjumpCGeGikr/GvZPVQEtj2nMVcgimsGu8aJssg2ueDVE1cWJxhx/iA8SvfO
 ejBJtYyI+10fDEY3yUHA2g21qTWeYwVh0=
X-Gm-Gg: AeBDiesvg4gK6iLSmL3lJ+Stp9pZuTC3sQp3RwBHZwDevurfpUm3ni9BGKJ4VjQy1LG
 qtpRXi97XmnrLwE0oBGddDzOY4HAU7KGqn+wWTUhBoOgrNjVu2QiyilLZ00hElndjYr7SynR8Eg
 y/qVVJ+MvzOxKGDvqhYEvbmBclr2IaeEd9lYAK/MtyrUlU0T0QMjSOkY+lJNWI0bA00sNTIgDvV
 IZ3i3iG4rznHrgwWcqwlWaHZppwFxogPZJ1+OL5yX2vODWIi06flbarGdtewv5AC3wAe9C0Pded
 BLw2y2ukO+i2O4njLwyP1lw=
X-Received: by 2002:a05:6a21:3381:b0:39b:ce34:f7fe with SMTP id
 adf61e73a8af0-39f2edfd265mr16970447637.13.1775547540780; 
 Tue, 07 Apr 2026 00:39:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:3381:b0:39b:ce34:f7fe with SMTP id
 adf61e73a8af0-39f2edfd265mr16970402637.13.1775547540247; Tue, 07 Apr 2026
 00:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260406115247.4879-1-armenon@redhat.com>
 <20260406115247.4879-3-armenon@redhat.com>
In-Reply-To: <20260406115247.4879-3-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 11:38:48 +0400
X-Gm-Features: AQROBzB2p-2EU6Fps2MwEkKZj6yoXnKH727-l4X35-BO_6tbCI1lBg-0skABgi8
Message-ID: <CAMxuvazf+-SLfrKqA_sovJJ8K-kQnOC0oX+yxrz+k-ESowD-sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Apr 6, 2026 at 3:53=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> Migrating a GLib GByteArray is now possible directly using the newly
> introduced VMSTATE_GBYTEARRAY. It uses the standard GLib API calls to
> create the array, or resize it.
>
> This is safer than implementing a C struct and manually updating the
> data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdaagent

vdagent

> to store the outbuf variable.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Fix-Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

It seems to be produce compatible migration streams, so

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vdagent.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index bb0c4aa14c..9206e47000 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -967,17 +967,6 @@ static const VMStateDescription vmstate_chunk =3D {
>      }
>  };
>
> -static const VMStateDescription vmstate_vdba =3D {
> -    .name =3D "vdagent/bytearray",
> -    .version_id =3D 0,
> -    .minimum_version_id =3D 0,
> -    .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT32(len, GByteArray),
> -        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  struct CBInfoArray {
>      uint32_t n;
>      QemuClipboardInfo cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
> @@ -1067,7 +1056,7 @@ static const VMStateDescription vmstate_vdagent =3D=
 {
>          VMSTATE_UINT32(xsize, VDAgentChardev),
>          VMSTATE_UINT32(xoff, VDAgentChardev),
>          VMSTATE_VBUFFER_ALLOC_UINT32(xbuf, VDAgentChardev, 0, 0, xsize),
> -        VMSTATE_STRUCT_POINTER(outbuf, VDAgentChardev, vmstate_vdba, GBy=
teArray),
> +        VMSTATE_GBYTEARRAY(outbuf, VDAgentChardev, 0),
>          VMSTATE_UINT32(mouse_x, VDAgentChardev),
>          VMSTATE_UINT32(mouse_y, VDAgentChardev),
>          VMSTATE_UINT32(mouse_btn, VDAgentChardev),
> --
> 2.53.0
>


