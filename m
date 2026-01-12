Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCABCF45B4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLTx-0004hC-F1; Mon, 12 Jan 2026 12:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLSA-00031B-V4
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:11:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfLS7-0007eU-Gm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768237897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeffuZkEBfflLSw4ZjTzFu7MFv/30yg8h/xlp/3ODDI=;
 b=a6P4skvYxLKvB3iFDTnB+y7f4wWBXbme1nz4i77DG9Xi+q0cpE5jYLJfj3prvmoZZeIf7F
 Elyz1p7NLMzzF76OPrniT97sz2Ws4FUjb+3t+YSLA9hAHa5EHnKSCB91AgvnAzYHtsCDOR
 Kef5ebpp01SKiAfuHYenHuJGi8w5Wyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-NOH9vgjIPSWsNIuG_LCOZQ-1; Mon, 12 Jan 2026 12:11:36 -0500
X-MC-Unique: NOH9vgjIPSWsNIuG_LCOZQ-1
X-Mimecast-MFC-AGG-ID: NOH9vgjIPSWsNIuG_LCOZQ_1768237894
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d3c4468d8so42868505e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768237894; x=1768842694; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeffuZkEBfflLSw4ZjTzFu7MFv/30yg8h/xlp/3ODDI=;
 b=cmqoxZoJStcG4tVXabkLYrQ4RY/CEFwUB89c0GjkNuuaaspujOqIozy3haV5TEigKt
 vTSUNur/rMsE7z7P1xhcuLPXAVWoOIVDGCpHDUlSmew3M1nM3RzngmBGAIVlcSISNPou
 OPqJSFU5UlHmAPeb7Hn8Xgb7tfJIal7yVuxnLOCOgPd8ZHt9F9y5CEVCb3IGOzhfTHxh
 FkCcEVyCOvG8TZ/gcxhzzpnbRcVclpK2C5oY+n0/bxsG0iJCXQ09UVmTTQFx/3TlgpPY
 rECiPauEUvlqZcPp4bQebWhqhlE5vm167yMq/My6OqewFNd60oZcrKS797MiME99bESR
 MSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768237894; x=1768842694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jeffuZkEBfflLSw4ZjTzFu7MFv/30yg8h/xlp/3ODDI=;
 b=wSQDpiO4zMeKhVfckFw9Xr2rmD0xXtUjZ6srWxUNHK+Ch8mW2ogC/uj+Ky6SMJcd2e
 zW7mUpU1kuSaVOXPUdDmSsiUDxt4rIJvTX8gcVF8Gq96klk1lVo02Ja2o9wVaNjviX/h
 MOJrovlVYiL1KKeKOceyuGhNvBJvKm6iIBxvBo+CfmTkVpf4yST2SgC6PLFQGD4Zcizp
 Fn5dQPsJQ69z+eRMDIilfczOBvVVysHK+Cj51+i90XKeBYXJGcRFrvgI6qp4iWubhhz3
 IK0lFmCH+d88T0Xc0zGdl1kavSZ7WraKCatkLUSJWxFbzFl0Agpln3ypF8jw+wDozi4K
 NU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9vaJysulWC2QdQuyPTrzzKZR5hHjD2lGD2YMvXP0rZnGeXwKrlvmzmMQnUUvYETI7KAGmmuTpE2s1@nongnu.org
X-Gm-Message-State: AOJu0YxJdEOU20EmotDjCyYOFSmV/Rksls2yn8BfjbT2gLEvZt4KHQe6
 fGHUKj51siYq5eVNZi3BJCQXZbCDDvEXKnTk3faLUKJR8n/q/TpxJ5E+nX6pGsho3rMCTq4/eed
 UIyDUrG3cP2pMgZV3ZJWQLkGh+SmtYCVQ2iSSFvCDqA9sBEoPiz6c4vZHU5t0+Y5CPV3/TkR6pO
 b8VCaTBoXaSM3g5GbEws7hhDLZSEXc57A=
X-Gm-Gg: AY/fxX6NUtoLoQpq5X8AXp4cPV9ZUdgU+0mpeJ6VX+S04y0vGaNeMWIiWJwvOAQJJl6
 7OJNqU3AiDMx9MWDRYGrEehx69agZdxoBCdkfZiqCgP8wNsnN7aoUfxp8eaPtxgCuRB+wFHBSI7
 HiundAGOP2tI8vklWJcpHZGoNg2SYj9WuD/WoutGBe+lZB4SnPr35GbLXrmmEgyjexAv6h2dQTk
 hTLPxJ+sPqhyBKCB4wog7s/vbo1WovhCds03SgpTnThGusIEpuURxRPqI4S9LXnWl/GlA==
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d84b3b8b9mr198369495e9.32.1768237894405; 
 Mon, 12 Jan 2026 09:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbj4ph0kqZXQYG+6hVJBWnZOnbRQ5gOzRPnLbag3DhtIZbvTfxen4++f86lHcI3uy+ybhCs5jQjvzZk2f2Yv8=
X-Received: by 2002:a05:600c:4447:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-47d84b3b8b9mr198369255e9.32.1768237894056; Mon, 12 Jan 2026
 09:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-25-anisinha@redhat.com>
In-Reply-To: <20260112132259.76855-25-anisinha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Jan 2026 18:11:21 +0100
X-Gm-Features: AZwV_QgoeN4vU_XnIQnrItPwiaLkf6qjTWDTE0Y07V15XachaTAf23ut68EpYsY
Message-ID: <CABgObfYWjQ2FwZZ5Evwdfh4aCdK2cJxO71U+KBgpzB6Jh18zyA@mail.gmail.com>
Subject: Re: [PATCH v2 24/32] accel/kvm: add a per-confidential class callback
 to unlock guest state
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jan 12, 2026 at 2:24=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
> diff --git a/system/runstate.c b/system/runstate.c
> index b0ce0410fa..710f5882d9 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -58,6 +58,7 @@
>  #include "system/reset.h"
>  #include "system/runstate.h"
>  #include "system/runstate-action.h"
> +#include "system/confidential-guest-support.h"
>  #include "system/system.h"
>  #include "system/tpm.h"
>  #include "trace.h"
> @@ -564,7 +565,12 @@ void qemu_system_reset(ShutdownCause reason)
>      if (cpus_are_resettable()) {
>          cpu_synchronize_all_post_reset();
>      } else {
> -        assert(runstate_check(RUN_STATE_PRELAUNCH));
> +        /*
> +         * for confidential guests, cpus are not resettable but their
> +         * state can be rebuilt under some conditions.
> +         */
> +        assert(runstate_check(RUN_STATE_PRELAUNCH) ||
> +               (current_machine->cgs && runstate_is_running()));

You can remove the assertion altogether.

> +static bool tdx_can_rebuild_guest_state(ConfidentialGuestSupport *cgs)
> +{
> +    return true;
> +}
> +
>  static void tdx_guest_class_init(ObjectClass *oc, const void *data)
>  {
>      ConfidentialGuestSupportClass *klass =3D CONFIDENTIAL_GUEST_SUPPORT_=
CLASS(oc);
> @@ -1596,6 +1601,7 @@ static void tdx_guest_class_init(ObjectClass *oc, c=
onst void *data)
>      ResettableClass *rc =3D RESETTABLE_CLASS(oc);
>
>      klass->kvm_init =3D tdx_kvm_init;
> +    klass->can_rebuild_guest_state =3D tdx_can_rebuild_guest_state;
>      x86_klass->kvm_type =3D tdx_kvm_type;
>      x86_klass->cpu_instance_init =3D tdx_cpu_instance_init;
>      x86_klass->adjust_cpuid_features =3D tdx_adjust_cpuid_features;
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index d45356843c..c52027c935 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2632,6 +2632,14 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t=
 *ptr, uint64_t len,
>      return -1;
>  }
>
> +static bool sev_can_rebuild_guest_state(ConfidentialGuestSupport *cgs)
> +{
> +    if (!sev_snp_enabled() && !sev_es_enabled()) {
> +        return false;
> +    }
> +    return true;

This is always true, because if both are false then CPUs *are* resettable.

So I think .can_rebuild_guest_state can become a bool member of the
ConfidentialGuestSupportClass, instead of a function.

Paolo


