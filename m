Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DFEF43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg5T-0003yB-FZ; Fri, 17 Apr 2026 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wDg5M-0003xU-T8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wDg5K-0007UF-Ha
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776420359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VuoU/4vfRh12JnF+ATnmf/X/TJTszT2MWxXRBGQ1Lk4=;
 b=M+lnC1C3jOAt90Hv7HP+ArRJkGU0eXC0lXmTtsfBvTcNJaF13FIN050U1D7YEzUUFPn+vy
 gGmTk4zgA4YKMpXqJMf+15Q7gjZ8gznydxYBIQAjnx733pDVzpTQ0FHrSlvK9qhCMZtxRk
 LZZPgX3Y+00eReMAko2J5LjQGFru0Tg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-ApysnqS2O6CNoRDriMQ69Q-1; Fri, 17 Apr 2026 06:05:57 -0400
X-MC-Unique: ApysnqS2O6CNoRDriMQ69Q-1
X-Mimecast-MFC-AGG-ID: ApysnqS2O6CNoRDriMQ69Q_1776420357
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3614272b00cso366591a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776420356; cv=none;
 d=google.com; s=arc-20240605;
 b=ghI0Bo5+mG5htsduwm+tg2je/R50sZoz31l+376zRFnlnZFUruh2CCO9sW8iJxlwav
 Jn3wii67siDH/irg2brFk9cYVp7fPFTRTFmv5RgyddPJiDB1vtpWvKTCMEATOGPwDRL5
 2Qp9FppT4kKYMrxhXJow8Li9etA87MfMrOKs2TWRcesGXPFolW+0F7PN4jkr9o4b5odi
 aGEUIze2EwcU7tTUIk2TJEozVKw7+QJUwGfqd+LSO+WaJI1iluC+M219O3UUbcFOSlfN
 OS9WcCUJqXEDetgCXj5FNKfEmzQ8Lqhwzuia42mBZ1g0dg1w1bvF9DsLrZbklTxcG3Js
 5jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VuoU/4vfRh12JnF+ATnmf/X/TJTszT2MWxXRBGQ1Lk4=;
 fh=h5FViOrhn2IDkmAFZAH5/l4sraoR/OFvdqiWrW+PL0g=;
 b=Pj5lQ1j5JKVBcH42femetGfcQZ6rinF6rqBGcnbAcIqEvpFRtWdK6jK67C9WNx5hhu
 dJ6QulLqI+mPw2EZlU2//IxgEBlqsP5g4XBZgCYYdU3OIVtTo0zQeGavCvu9pTeuVCu2
 B1bh1u191ZpJdJgBnUhuN+qIxMx+m2n3jfjYmBvTQB6P56fcKyjIDH+OLL+HXjBYYUYP
 JfPntavxe/D/AyWyGciRxiZ7h5bO76mSCV/BOmZJSvH1uh6A6LHlvEqnBScve14A7ZYZ
 qhS9tAdkKQwPMDnjLxM2Dc2UVTZGi1SvVzdrEV6iINMcCWxXQxIkh3IdbYkEgKy80qXo
 r4nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776420356; x=1777025156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuoU/4vfRh12JnF+ATnmf/X/TJTszT2MWxXRBGQ1Lk4=;
 b=LtDiuAuqGpNnzfyPDuyESc2kJiWd+nAI99/WdzYkxkULZ0icURljsj2pLnCkn5YmXo
 AONf2SFpbAzmfwxVWDaZ3uwKyoM+jbSG5nbX712P7G+D1BVWWM4ANKjUg1HSS+X5CsYO
 O7Xw7bN7gMPabjnLoPq9ZQNMUkurL0YR9pWky/Y19pyXc3gazmfsXc1rWdls5BoiVfCl
 y3sW7bE5Vr9DtJVwtxTrEL3uD7Mv9JNDdyXCC5JuW/PQcaxAfzD9aY4OUfoBFO2SrclZ
 /Mh3o1UxU7F4GKL/kF32mnqIkGlOFXmEve+UB5usKgSe6Ol7rAZ7BAlp18qln4nv8yH7
 Vg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776420356; x=1777025156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VuoU/4vfRh12JnF+ATnmf/X/TJTszT2MWxXRBGQ1Lk4=;
 b=d4m4qPsGYPZpg2St4EIC1JeU7cofwUvtMNZNfOe3Mki2KiJnZuQ4CsSsOVIc7SDYX9
 XWRJ7ua7sdZxdQBb5nJwVpSI1Y+9dmYokBNxVUjUi/cTUPRaHzul1WCQolo7fbpksqy7
 89jae3LRc5orYWSid/CIk6y/BhmDpzeV23TDy1to+NbJHsUuWLm8HPbfpiCStnQyPyEk
 Wswlsr2cpnslnfY9lRt4r517i7OBG7LaYW3SSmN8XCy2+qhONVDRWkrzSinVYnokUc2x
 cmxVUKA4nDjV/lDJyjZsJhC8msLF1TDmzM46D7OpMXDINHgDX31TbWr7TP7+DvHkywW0
 AiQQ==
X-Gm-Message-State: AOJu0YwEbncdCrHDCX2JHgsqvHqvy9GZpld1qP3nKm7kugwV1eZ11XjV
 GFaA8Bd2Qi3USsoQ2ahCJxSKHtjo9z2BMft0ZyIZUWSGjEUb7ZLQRW0BPVCAo3zQYhnQoJTyMJC
 5VTXknidR8tKd5mimIvzgLSPbKGYoMoMHVk8WxlfVrFsFNxyTUbaVL5zoeRdnUTvt2Bn+fjisel
 DGXa7uQLE1sKJ7pgjgJkN38X+OllI/TlI=
X-Gm-Gg: AeBDieuaWwWsodCCluRqP8hKikVomX13LPnYC32VkXsH8IU3LQOTz/gfjUQqqxVV6Fy
 LkQJA1r0EW5Sadq2ykmanGsiIrotKMe70PkHxeyqw+vbMC7nTiYf0BIno53iQNWTuSTFnifRr5a
 fRwBHu7B5/uBGd1SU4Y+SfcBpK9jXNk8ST9O3DKfY4GBEE33qV9dmAG6kkt17ZSvB/+5XErJCIf
 M76wW/cXHn6SydjnG5eTgjMZFTv9o7hCuHSvQwo7eZqKTZESm4OnwoR1hWWml8+xwfDNl1OB+Xg
 JBNMLSuBod2JKtXm+/zQ20cQqsau7xJNX9U=
X-Received: by 2002:a17:90b:3c8d:b0:35d:93ff:284f with SMTP id
 98e67ed59e1d1-36140462afcmr2367699a91.15.1776420356535; 
 Fri, 17 Apr 2026 03:05:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8d:b0:35d:93ff:284f with SMTP id
 98e67ed59e1d1-36140462afcmr2367649a91.15.1776420356088; Fri, 17 Apr 2026
 03:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260414082915.112122-1-armenon@redhat.com>
 <20260414082915.112122-2-armenon@redhat.com>
In-Reply-To: <20260414082915.112122-2-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Apr 2026 14:05:43 +0400
X-Gm-Features: AQROBzBvpWksEd1HXrnamFSSQnH7ih6_-sUTbeP1cBLqkKoLKeIBgFLmGd2LcIw
Message-ID: <CAMxuvaw2=uupgJFynh_-2Nkj2VV+V6CqeOOB02A_p0LkOCFy9A@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, 
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Apr 14, 2026 at 12:30=E2=80=AFPM Arun Menon <armenon@redhat.com> wr=
ote:
>
> From: Arun Menon <armenon@redhat.com>
>
> - Add new fields to the CRB Interface Identifier and the CRB
>   Control Start registers.
> - CRB_CTRL_START now has 2 new settings, that can be toggled using the
>   nextChunk and crbRspRetry bits.
> - CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
>   this revision of the specification.
> - Refer to section 6.4.2.2 of [1]
>
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specif=
ic-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/tpm/tpm_crb.c      | 3 +++
>  include/hw/acpi/tpm.h | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 8723536f93..0a1c7ecdc6 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>  #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
>  #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
>  #define CRB_INTF_IF_SELECTOR_CRB 0b1
> +#define CRB_INTF_CAP_CRB_CHUNK 0b1
>
>  #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
>
> @@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
>                       CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                       InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);

We should not expose that new capability to guests without an explicit
"cap-chunk=3Don".

It should reject if any chunk request is made when cap-chunk=3Doff in
later patches.

I don't think x-migrate-buffers is necessary. If cap-chunk=3Don, it can
be migrated with 11.1, with older machine version just add a migration
blocker.



>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                       RID, 0b0000);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d2bf6637c5..6eece21397 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -149,7 +149,7 @@ REG32(CRB_INTF_ID, 0x30)
>    FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
>    FIELD(CRB_INTF_ID, CapLocality, 8, 1)
>    FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
> -  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
> +  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
>    FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
>    FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
>    FIELD(CRB_INTF_ID, CapCRB, 14, 1)
> @@ -168,6 +168,9 @@ REG32(CRB_CTRL_STS, 0x44)
>    FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
>  REG32(CRB_CTRL_CANCEL, 0x48)
>  REG32(CRB_CTRL_START, 0x4C)
> +  FIELD(CRB_CTRL_START, Start, 0, 1)
> +  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
> +  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
>  REG32(CRB_INT_ENABLED, 0x50)
>  REG32(CRB_INT_STS, 0x54)
>  REG32(CRB_CTRL_CMD_SIZE, 0x58)
> --
> 2.53.0
>


