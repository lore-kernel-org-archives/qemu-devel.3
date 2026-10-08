Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FFECA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnLp-0005FA-LE; Thu, 08 Oct 2026 08:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEnLi-0005Er-Qa
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:35:51 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEnLg-0006oD-Ub
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:35:50 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-33c2520ad38so6897781eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 05:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791462947; cv=none;
 d=google.com; s=arc-20260327;
 b=mBu+ewPKpiDGlxD+p6KPQIpPe0np29ZCbjHnAXdIILZcYKpMmH2cMX4QFsod6UD4eh
 0YtK9Lx4Y9nt/0nuEg/BxMqeu1xwXi5DhieuWfsJbJ7Fjk908RcjGFiT1D171NMhMQWv
 wceZxLyrp4gLHy+Pwb3sY/XqG1D4K5P963+Yxo979x10EujKhyNwGwvykwtkam8Ke3vc
 0cf1e8a5gUS6H45uVDrmYeKUdzThf+2sXLl9gAa8U8hK5DTo6ztsbjv/Fuwv2OPcNt/y
 4gNzbwJTpJIW6/7zLaNU800LupTCIFZNrUiKPOzEVM7XkdyucpjdPqzWWtxrYfXvQ4qZ
 W5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0eZTbrU8P9q5tHNgJzHqeune9+VP8xnuZbxVCjaQhrE=;
 fh=v1jUpJ6XR3R4AvtjZYbCoa27ei7+ddPhbZGZg/7yN20=;
 b=rGsOb0x9x0ikWZE86+De85RsAPTqyoZiVonHFDpfmsWMyHWIZoHYf0h6WOnePlb1V2
 hSWkXznFFoAhEve4PdqTWWGpa/EklbQju5iI+lJonb3MZ86cCVoVxP3Kf/G148kOVRTq
 S0Vz524AgV9W7+nlW0ciHOFRBTICt+gDObvQfso/tcrJoQ7lV76ta1bgBUZNDVVBvJ3g
 BGOn/rZZEb1ltjufAzZcuZJCj0gp6mGTfxw6FJ+159ooWwH04WUuQlbg+5+BM+4tgS7o
 hY+bSw6nlY2DLWcoWaWCBEVlslxZLJz8LExgnMmXF0cRQt60e2USCiB8T8M6wfxQoRGz
 i8FQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791462947; x=1792067747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0eZTbrU8P9q5tHNgJzHqeune9+VP8xnuZbxVCjaQhrE=;
 b=fCXa4dt4ct7ZEfIYAHMpYHRkE/x2cWhSWg6AtWteNe77HHssiZwVddlYtLwEav33Hs
 wBqxsKK+iZcoIMi+Pbl1b4PDipnfGcnT8ln5vGtK23ydRpSQ0TjJHMB6uioLHytvF8AL
 knDGBOMbFYA2sHs8+EoaWbEU44BQLT00Ih6PeHCaYXOEuO9rOXxhXUEEj/qw8mzU8i4c
 mLQR5lVVrwf+ocKf39brKl2TNxhzzqhlRcXY4Y6VwAJ66ETHPseRgqpNz/CHKPXrdQby
 lNG8JFPZLXfk5HjUk91ItbQs1FVp6jkeW4+vpmCLTxXnL4nAadp5/JL4W9vUmVHJZxj/
 FTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791462947; x=1792067747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0eZTbrU8P9q5tHNgJzHqeune9+VP8xnuZbxVCjaQhrE=;
 b=0XvTI6LrJM6lMN/vAuas+QmWrOQ50fW2iUQ3QAFA90EgvH9Jy7edZpatIkBQmp++y3
 QWC9juNS3YOxqhBsBXKVagu/8VKEQYjJidekejbWB/J+2gBz4K3pNfhCQidcTj7jnt+y
 ZeSuZRYNfsFe2VljpW3mydMRrf2xZVIVANGT+nq0e4VJPNHg3Ath+COxkIvKOUetRiJK
 4pskXHEv0J/m4hoQy4fyUo0MJbON1uUnHiErH6WgqmZXeF8WzjMAHphzwuo6UJlCVKDf
 uY7JyDv9yUEE9a5hHxHQvhcF3tJ76HFILCoIL9Iud9D3TF8vhANLj0bPO47UNwrhZwh3
 tIfQ==
X-Gm-Message-State: AFq9FYJ4WBWdauKH/ED0RJs+1m34UxssRNtTz7c1lUmbraWiCsjPKh5q
 9lEktr4+Z1dFVVY1a9BzRzVHUh2yjn8jysksFYHlAstabmZACb3lXeeHKtqesAkWBSmOfvBzjUj
 x8lC5IpY+gNZpVeAzUs4v45pSnvUuTO8=
X-Gm-Gg: AYBFou3Omsrr07JW3JQLfnJhU7W+NtPmRcpq39FCrdr50VKVLpY7hH3+M5+fJmiJyBv
 bXwdbio/7eMnhlusp/LGU5AXrXXAo4hfycpoQfOxZVUUkCxdh8bgev4E0557q1MW6bOtAlcg5Zx
 j1WslE2O3/awfopO1NDaJA7nSbbL0yYnUzdXI+/MjJoz2E/S7A8n9pxp7ZKeCP3cXRBugSXsrUf
 OZ06uBf3Q2vLt5VsxOp056clsIEpf3+Hd6HcZQxItRkHcp5GYIWDJVknPrYF+YRRGWthomYqt+h
 MsG9lKLus1IzGaZFhXnXHrrRRtSXBdb0a9dD1qVA3vlyNqR9I6CnUEGcWw4X/kHHfeK+WYNqHMI
 JIb2l5wxoEo0=
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-3515da5dd21mr6119023eec.4.1791462946651; Thu, 08 Oct 2026
 05:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20261008122936.45081-1-tcalifano@redhat.com>
In-Reply-To: <20261008122936.45081-1-tcalifano@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Oct 2026 16:35:34 +0400
X-Gm-Features: AclHuK9T9gnTiCvPdNVWYR2amRGXQ6ABmalTjasK66suHoTjqQIlotQcNOV5pLo
Message-ID: <CAJ+F1CJavmABQEy9HVVmL4axN0xbp+tkiiY=cHVxDc1oG5Sr2g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/usb/dev-mtp: Fix assert crash on short
 CMD_SEND_OBJECT
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
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

On Thu, Oct 8, 2026 at 4:30=E2=80=AFPM Tommaso Califano <tcalifano@redhat.c=
om> wrote:
>
> In usb_mtp_get_data() there is a guest-triggerable assertion that fires
> when a guest declares a large object size in CMD_SEND_OBJECT_INFO but
> sends fewer bytes in the subsequent CMD_SEND_OBJECT. The assertion
> compares the declared size against the actual bytes received.
>
> If the guest sends CMD_SEND_OBJECT_INFO with size=3D1000 and then
> CMD_SEND_OBJECT with only 50 bytes (short, non-64-byte-aligned
> final USB packet) the assertion fires, killing QEMU.
>
> To prevent that is sufficient to remove the assertion, because the case
> is handled by usb_mtp_write_data() which returns RES_INCOMPLETE_TRANSFER.
>
> Fixes: 3e096650a64d ("dev-mtp: Add support for > 4GB file transfers")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3993
> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> V2:
>  - Add Fixes tag.
>  - Correct and improve commit message readability.
>
> hw/usb/dev-mtp.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 1d8cfd32dc..406793fc03 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1813,9 +1813,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_conta=
iner *container,
>          d->offset +=3D dlen;
>          d->data_offset +=3D dlen;
>          if ((p->iov.size % 64) || !p->iov.size) {
> -            assert((s->dataset.size =3D=3D 0xFFFFFFFF) ||
> -                   (s->dataset.size =3D=3D d->offset));
> -
>              if (d->length =3D=3D MTP_WRITE_BUF_SZ) {
>                  d->write_status =3D WRITE_END;
>              } else {
> --
> 2.56.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

