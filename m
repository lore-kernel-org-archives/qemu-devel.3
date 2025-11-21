Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6B3CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMciv-00007u-U6; Fri, 21 Nov 2025 20:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMbRt-0005lV-UI
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMbRh-0003ES-GM
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvfEuZqsYtGOsOMoRJb/pPk3SZPKfOA52jDeyhimdME=;
 b=aIjRLfeNRtVkFeW6yhhNVLjSBI+ttYg6f45nWMWpOg00DiPkoCrteJqoPEycz3y0IRkbkq
 ZqbWm+m32qjiCmIUqapk1BZrKyMbPPGhV25mAcHnFs+0DSaee1toJVLKRlsn0TZTotXzwr
 LX7m5Uq5bjOPe25XNgMAJSq/oAMuUlQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-ncrbj46KOaiwwNgNCoSKuQ-1; Fri, 21 Nov 2025 08:07:58 -0500
X-MC-Unique: ncrbj46KOaiwwNgNCoSKuQ-1
X-Mimecast-MFC-AGG-ID: ncrbj46KOaiwwNgNCoSKuQ_1763730478
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2956a694b47so34967675ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763730477; x=1764335277; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvfEuZqsYtGOsOMoRJb/pPk3SZPKfOA52jDeyhimdME=;
 b=BCNBdAGxV0wtP9pjF5cPSUVA3VVQKO5qfULO/5jhfrf8aH/uTMuxqH99gKMcJj1Fb4
 G7gFSO5r4d7jXhr1X/Im900PTc+32NVNPKKVfnouhHr1zdtq8Pd8VLzZwe0WhUzAZnEx
 tv3ZCNJt27ezD5qXYt6RcPEvJ+ulL2xtiUvL9ITvMbvoai/V8Wo/R0ure0uIblYLRd9m
 upBxIR+Xo1GD2I9N8OB8369feeEk0mS0YgK4aGOmavzTlhCf902m+omZkZgb/WW4oqoQ
 8uH8eV1EzInsrZovXu0E18cMl1iRjUFYa746FX6H7nuZq48uYCIE0QUwHV371l17Xdmu
 E4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763730477; x=1764335277;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HvfEuZqsYtGOsOMoRJb/pPk3SZPKfOA52jDeyhimdME=;
 b=jT8+Na/mJvzC8ee68hox3dDabBME0XM5+OVBcyDzKznH96SdD8SqNlGeqdvmio0qac
 /Yys518sxa4TvSUy/Ug1pWkXjYeiFUYLpie7w1ojw+YNK/qewujR0or9t611MKrTZpOH
 0TtqYaFn+pQhaAtU4grMPcRhLeLS+vI1fDVKB28oSxdWYUbqIXOib5P1j0yL2/4Vv0pR
 4knaMsmu/bN6XiRekYnhNg9A2OfbfblzGQva1HmhBgRZ65YN4IKEZPmq3FgRtCYLo+r2
 P7tZdaydqjLj/4puKnSYdq3MuK25Ub4mr5LTAMJyMpxScjWxS1D1335ywLftzJgNh+56
 f/aQ==
X-Gm-Message-State: AOJu0YxqPbpHk7RX+dKZAdUNcRQ3S7iMXfVYqyp+BiVAG9EXvcAqyuT7
 OBClyWILmH9d7JM+Mf0aWyiKKDAP3f/Tmks8TbW/Tukf4yzJ+bH+GqXdd4z7eyUdXX/+HbHCufw
 HX6tHQnSeaeN3THGiXHsCPNXEZbKP3D4Dqxv6hRWs4s18kLAQ1FbAaywR
X-Gm-Gg: ASbGncvt4JvWysNL7yuSmjqiaDurGyMNuAQBz8vGw5iiBrYBV/UYl8dQ6oH1YgoczvA
 Qay98CP7Otb5DBItpcMWM2Siua80KUaANV66KKfJXy9MU61Wa+vLJ5ZQ3e207YJF0PvWDEcudhx
 GdcgMzlErrv3+PLf82+/J455bCnmU8P9LqhNdGGt2tAT01q1B4u8HhNJJPsVsi15wdTCG7zP+Pp
 21QuiysM5zV0M7w4BdDQX2G+ByjG8o4zqlj3uuQPJ68W/HlEM1yhp2srpRrl3a9SbOjWv5mCUKj
 fxLBA0bRNeKwSXcIejAUT/HBDswfSQUHLPGYyWCRJFz6lpQvmaPXaapm2b9vc2Tw4pIIEEj1XHw
 T1dHIBl7mB6QwAejylVt4CMcR7ubOPN2Q0CJ/et0+GUhQEYh5n0y/ul4E
X-Received: by 2002:a17:903:2450:b0:27d:69cc:9a6 with SMTP id
 d9443c01a7336-29b6bf7f26cmr29578845ad.53.1763730477490; 
 Fri, 21 Nov 2025 05:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUrdLgpZVnB+pqYJctbNVZLzgUbKIPWyNoVZITw+yxhokcZ5qqG6O/Psx+AKJ591Hk9ULgKQ==
X-Received: by 2002:a17:903:2450:b0:27d:69cc:9a6 with SMTP id
 d9443c01a7336-29b6bf7f26cmr29578475ad.53.1763730476969; 
 Fri, 21 Nov 2025 05:07:56 -0800 (PST)
Received: from smtpclient.apple ([106.212.87.16])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd75b61c29dsm5589954a12.0.2025.11.21.05.07.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 05:07:56 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 3/4] igvm: add trace point for igvm file loading and
 processing
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251118122133.1695767-4-kraxel@redhat.com>
Date: Fri, 21 Nov 2025 18:37:41 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BCC9E21-2EB5-4D63-B2E3-923F5BB9BBE4@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-4-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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



> On 18 Nov 2025, at 5:51=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
Please add some description to the patch =E2=80=A6

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Modulo above ..

Reviewed-by: Ani Sinha <anisinha@redhat.com>


> ---
> backends/igvm.c       | 5 +++++
> backends/trace-events | 2 ++
> 2 files changed, 7 insertions(+)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 05d197fdfe85..a350c890cc95 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -18,6 +18,8 @@
> #include "system/address-spaces.h"
> #include "hw/core/cpu.h"
>=20
> +#include "trace.h"
> +
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>=20
> @@ -884,6 +886,8 @@ IgvmHandle qigvm_file_init(char *filename, Error =
**errp)
>         error_setg(errp, "Unable to parse IGVM file %s: %d", filename, =
igvm);
>         return -1;
>     }
> +
> +    trace_igvm_file_loaded(filename, igvm);
>     return igvm;
> }
>=20
> @@ -901,6 +905,7 @@ int qigvm_process_file(IgvmCfg *cfg, =
ConfidentialGuestSupport *cgs,
>         return -1;
>     }
>     ctx.file =3D cfg->file;
> +    trace_igvm_process_file(cfg->file, onlyVpContext);
>=20
>     /*
>      * The ConfidentialGuestSupport object is optional and allows a =
confidential
> diff --git a/backends/trace-events b/backends/trace-events
> index 45ac46dc2454..7a00e9bf6c16 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -26,3 +26,5 @@ iommufd_backend_invalidate_cache(int iommufd, =
uint32_t id, uint32_t data_type, u
> igvm_reset_enter(int type) "type=3D%u"
> igvm_reset_hold(int type) "type=3D%u"
> igvm_reset_exit(int type) "type=3D%u"
> +igvm_file_loaded(const char *fn, int32_t handle) "fn=3D%s, =
handle=3D0x%x"
> +igvm_process_file(int32_t handle, bool context_only) "handle=3D0x%x =
context-only=3D%d"
> --=20
> 2.51.1
>=20


