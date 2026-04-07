Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD164FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXF-000070-TX; Tue, 07 Apr 2026 14:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTw-0002LR-Jt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA1CM-0001J8-D9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775548209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvobOrqEAkaiqENsEomLroTZGJRyqRO8/LE7QH9QcTM=;
 b=aKETjzmeUXVFTFoexmG9o88B2/GD5MzFzCsiJfxRGBhVzIrXsjHf3T6Ged0HtFgA4MbKkh
 +WzC7wL6enTcQ9SAbWpYf3TJw5QvbNgYa16GGbeuCAaKBj9buM5a1m/jei0dlUuw8aOno1
 xrEqhJFgah5lNOybfdx5rr3MkuqhsjA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-6i4XUjr-NCK6TDY4md18Ig-1; Tue, 07 Apr 2026 03:50:07 -0400
X-MC-Unique: 6i4XUjr-NCK6TDY4md18Ig-1
X-Mimecast-MFC-AGG-ID: 6i4XUjr-NCK6TDY4md18Ig_1775548207
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c741b950511so2559060a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 00:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775548206; cv=none;
 d=google.com; s=arc-20240605;
 b=hqmdTCqztbwdF1CzJjU9uFasJKyaHKYKOXiRunNL3nu4Fyd29PpvPNcnGHx1wYlpI7
 pGtzd2MNjL0yRLAhZK2MQnBkeiV1fPpXjz8HQJppKEmN7eeQMfnDPq4BVo14HOYn0h8O
 yWgXxCTxzYHc4R6clHgMaiWCu6YuGCtfoKIRXfTEipTrTNECX3TqZB6tee2F6FTYDXkJ
 u6a5Un/NnXwnqHUasPlvqxCA2Ga2mkcdFUvm3LgnWnqzUaLqAcSsNvZxgHp9MX6bLH/e
 L3YlqW1yXQL2GCAXLy2HbZEC4Q2BrGjaCp+UbgiqTkkyqZQf6z5H7Qq/aqL0aP2oxzXL
 MiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZvobOrqEAkaiqENsEomLroTZGJRyqRO8/LE7QH9QcTM=;
 fh=I3Rojz7Rj7F7zAuh27Zv7NEdlY6RHgtmEIjZ7Qkr/EI=;
 b=dG45oXpi5t5kMos/4NbAuxhQS+GejfQFjIY1N1kwvKyH7OxG5w3mKWuj8PMCqx+dVl
 IlDqFTi9/lx5T7YjfxgcnOgIrTK1IAzb0rUZFdcmkS0YV+uXm6k0GcT95U3v4WlZWuoq
 cShJbp8fnZV5SLYph1YJpzmFKLYGVmwM/2cLr34P4YsPfgT+pLFWvtvZcNfUjWsEYIcO
 eq3e2AcigYXTwfF0gQm+o8hTyA0zTIk40LFnGnVHbp7ClPbqiTdkxqqZAkFonAffAc/v
 x1aZn17hGAUMdjRfSx/1a7r15ppw9DtPkTbMasgOzpFQP7ZT63b/whLbqjrY9Ik99f3x
 Uz1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775548206; x=1776153006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvobOrqEAkaiqENsEomLroTZGJRyqRO8/LE7QH9QcTM=;
 b=WuZExjdtJAjG1sy+p9yH5/b/ZiqP8aUwmA28CfrDeeaNaurQ+YYJvVx8mL8XfLQQWN
 LyaaorQadv1DeWu64+pMfQW8n5y93JsLHDGhyosubdbk+Olh/5NOV9mxYL7BbZGlgiPi
 K96BdJd2m1022SL4rwcTb6ys9et7ImzRAO7ohNqnsr1Xt7vcymhqwKWdPInFKDx2ZfEM
 +mUuQKhpriFpKgL/t7Q3ptO8AJtocLO5l/f8GnfDW/JJTNWExqweXU2dm6ts9OZppiQh
 rx7jpg0oZ/fkJEpuLCmrO+BW8cXSfEK32tVQPL/UcEGvE+EA/8p75La84jmccrLSlNJy
 tb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775548206; x=1776153006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZvobOrqEAkaiqENsEomLroTZGJRyqRO8/LE7QH9QcTM=;
 b=BfchatWQaZu5e0ZD63ug7DThcwgZl7KLWEtbcYdkjP6JZ58Jj+RCMCjkPhqSVWwtSG
 mrLThhI+q4aLPuSlpJ5b6YuEtPSPPhSAVQQjfRotsAKGWUHa9tRksNfWcnKA1wuR5wew
 hHUEnDo169uoIunX56/b253C+MgkDJ/hwmafo73FDcFlvb0nrsUwlpjw7ejCauZgIJlK
 K3N5P5GPd2xkrmYOO0DTmmvAChgDd0QxGqoy8IP8ag4PIXSBFQXzkRPTBra+A81YQHl3
 TjwgSAZsrLQCmlKIWupSpX42H6QIjHsDEwQqCJZjzVl4pMlG2vc2w2R3j+RCDrYGyI+y
 xSCA==
X-Gm-Message-State: AOJu0Ywt80VnDzNutnnKAuFFyRNyf2UsS33ZhK1ndniSePaF9laa/v9N
 sAFLNeOTw6C58Z+rZybB1SbpNjuk5Xt5i+f3EFReJj0hA0jCRWvlDm/7bni8qfczwRNYBiHQkBY
 xBAxi87dqe8ln/p+H5E0I8aBFwI8zPq+LVQ8UOiacCGg3hmpoOWnDGx7CYrdYSNpTkAHHKVXDuu
 d+W4bmWOWNy97YQVWkrkzhxTIAJUeOWoc=
X-Gm-Gg: AeBDies/EiXZe/mN1vU1nIxlxFZM13fj3UOqlWNHYKRVe9yPF4r/gmd6J4XDNMAEVK1
 0niZ2i54kSUgVT6shRLkgAR4PNHqKwzpbkO+rRN+FkmRFpUMTO8LgIlkPitNYRQKiwXpHTjITHN
 OUYCSLPRDMor6YE7oowZKTedNc2YNJ4rJRK8sU9ApGQ2V2mBJBv3E4SLtS1NknLfQcRpiDcdvV2
 Mvb+lnsW/PNfCCAs0V0JgFr5BKOOFfWIgQzvTu/+aPUO0QuDsooaMkltdpkjzI8xN4u6XXb+vqj
 akYQKswZ4Pti23+m7c7ihVU=
X-Received: by 2002:a05:6a20:a11a:b0:398:c170:1c7 with SMTP id
 adf61e73a8af0-39f2f12b4f9mr16041170637.26.1775548206523; 
 Tue, 07 Apr 2026 00:50:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11a:b0:398:c170:1c7 with SMTP id
 adf61e73a8af0-39f2f12b4f9mr16041148637.26.1775548206065; Tue, 07 Apr 2026
 00:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-2-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-2-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 11:49:54 +0400
X-Gm-Features: AQROBzDtwowtje3Ysgx5ZrasJVXquCi1HvuR-yY3xK0f6JBPSt7--7MiuVf7900
Message-ID: <CAMxuvazscrXMNc+VV_jpTLY1aRjCKAbmBoZ-LCcsZ-4iazBfvg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/tpm: Add TPM CRB chunking fields
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.ibm.com>
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

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
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
ic-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

You may update the link to the released version
https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Pla=
tform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
>                       RID, 0b0000);
>      ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d2bf6637c5..03d452d2b5 100644
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
> +  FIELD(CRB_CTRL_START, invoke, 0, 1)

Any reason to diverge from the spec "Start" naming here?

> +  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
> +  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
>  REG32(CRB_INT_ENABLED, 0x50)
>  REG32(CRB_INT_STS, 0x54)
>  REG32(CRB_CTRL_CMD_SIZE, 0x58)
> --
> 2.53.0
>


