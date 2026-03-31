Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169A0FF60C8
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SJI-0002HT-QA; Tue, 31 Mar 2026 02:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SJH-0002H6-Hg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SJG-0002ww-2z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774937440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fgxq1USlPnSAQHxXOt3EXC+WBwp2t/YszPAfuajTRrU=;
 b=Kw4pi/floyr0mO/LFXQQr/F53epA16pdr/UGe2ckudCd8woxol8Ho4Sc05X85KP0hgKXBK
 tLoByN0Di4Ue+dlbSD2sqhXM09sFpQCEGEq7zaU9ymGEPXBfo6LerSK6bITJFA/7SdpoVC
 ivaDkyge8FihLwEE3KiMTHYesGGc1+U=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-e2kRdAxgPM-KU04NL-p37A-1; Tue, 31 Mar 2026 02:10:38 -0400
X-MC-Unique: e2kRdAxgPM-KU04NL-p37A-1
X-Mimecast-MFC-AGG-ID: e2kRdAxgPM-KU04NL-p37A_1774937437
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82ce0a9e558so92636b3a.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774937437; x=1775542237; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fgxq1USlPnSAQHxXOt3EXC+WBwp2t/YszPAfuajTRrU=;
 b=Q82AaRzwGWD/4W4TPBTn5uyP2b2UZmiwX++sQ3RTrCEuqbOVRtVSQuU+42kvqulOh3
 vvqmR5CBUnDEiQktiD3VjL+W5VdGqdV7k7xAbp16fz+7akt5q2ZExDY1CQVIePEGKOkX
 X4x4iR3AViRZCB87baI552bm/Ls6A6/q/xF5H1D4YwFVgN8lBKiJJQu+9HbK+Xwu7XQZ
 gQyx0EJ3Q+d4M3Db8AamU/qrdx18K5sH7guECFhvQXJ/5l9RZBJf2Pk0UBCaxeAAkq9y
 eSCNavzAc2R2kR7ienx5zx1p3LrbbBHHjg5rQq0I9P+Bo56nMJxCpik51bkJ30Q/pbxR
 SoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774937437; x=1775542237;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fgxq1USlPnSAQHxXOt3EXC+WBwp2t/YszPAfuajTRrU=;
 b=kZJAKsZL1mZOa6fD77IvljxFPU3ynO4zDSwz2eMYDrW/NvYz9aLE8NOAf4/QzjGohE
 /9ovUPGfMBlvwOhjTd0MlfKRtUd71L7B3CxLfxoq62gnhoKe6olEx/X2PWUMiZF88Ufm
 uSAqOGrbvnuQpY16EwdpSftLqvlKM2VomXLg35udIIWiXODJ85cmoE7dVxS3xQWC3E9B
 LvZXvZBEnsElJXq4valEzKTiKI82YDq2sAIv1bRAzjOIu2xzTM7DwrxvJhaOLkrVRtDG
 abdCExaqnG11g5l7guq1jBB7kQIE1BBDA+fuSNkQ8TLwx5H31age2gdr4jEwN55Id2G5
 hYug==
X-Gm-Message-State: AOJu0YwTPICRYMBdC5XvFaKvNK/GA9ChBuON0dIdWyi2/1RvovV7XZdA
 8nKclSexyXwZZAS/KVqNnn5fx05Qc/S/B6WRS0cIJ1uF9MNTeJ1PyxKxx2/TlFYDJW2q//cIAl0
 gqwas+8O0GGVOUqOlfZm0a6EV3j0rj3InbBe+8sBnvyUJyd/c18cYPiU9
X-Gm-Gg: ATEYQzy0hQeZr4XzxSasuPieB1b+II9WiUmUL6PUY+A1Q2439Fqo21IW0iPTSgXIrZ5
 JQLMH/jpWc231niY0jt0F1qMIHFBnZcXqiuX1KoJAHhmjlevqPLexrtWIoD65nJxnFSZ31RCVUI
 mslOCA6gHjfy6UgbwaHZ+U7478bb91KMySoYvsZumX65vJUMr/oWsfAtfKC7IEuQZDpwrzgHuGP
 r1dHeozS/VFIl/g40Gq1aO7i/fwdCUEWNFNWjWmGRUaATVyHa81j4zsjMuq94MTSdsaRBR4/3o+
 YumMy3ZslP7j1bYo20KLPQlJXt64wXwNUdZYY8vU0rZ9CYTk2VuIk63vRzsTWp0LR1/+c6h5TR4
 BxgBCeq6mF8wHl3KDnl9zQczz1ffHmyQW82b03yk/wx76j4T2UD02UHUg84GIMRba7pfE2Vzgkv
 Y=
X-Received: by 2002:a05:6a00:a113:b0:829:7f7f:cbcf with SMTP id
 d2e1a72fcca58-82c960e364cmr12978441b3a.56.1774937437478; 
 Mon, 30 Mar 2026 23:10:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:a113:b0:829:7f7f:cbcf with SMTP id
 d2e1a72fcca58-82c960e364cmr12978415b3a.56.1774937437039; 
 Mon, 30 Mar 2026 23:10:37 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cd7d0410bsm1219046b3a.33.2026.03.30.23.10.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:10:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 1/3] igvm: switch to PRIx64
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-1-03587a5a808b@redhat.com>
Date: Tue, 31 Mar 2026 11:40:22 +0530
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C93EE43-3AEE-4EFE-AC1C-C9E4742AEC0A@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-1-03587a5a808b@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 30 Mar 2026, at 6:13=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Use the PRIx64 format macro instead of %lX for uint64_t values.
>=20
> This is to improve portability as %lX is not necessarily 64 bit long.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index =
3b5edf15213c845132d0d4c05144a18992f1816e..50f0d6fb9a7bacddce91f095b6e2710e=
cbc79c6f 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -187,7 +187,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>             error_setg(
>                 errp,
>                 "Processing of IGVM file failed: Could not prepare =
memory "
> -                "at address 0x%lX due to existing non-RAM region",
> +                "at address 0x%" PRIx64 " due to existing non-RAM =
region",
>                 addr);
>             return NULL;
>         }
> @@ -198,7 +198,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>             error_setg(
>                 errp,
>                 "Processing of IGVM file failed: Could not prepare =
memory "
> -                "at address 0x%lX: region size exceeded",
> +                "at address 0x%" PRIx64 ": region size exceeded",
>                 addr);
>             return NULL;
>         }
>=20
> --=20
> 2.53.0
>=20


