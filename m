Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7315FD064D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0E9p-0004Ql-2e; Wed, 11 Mar 2026 03:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0E9j-0004Q2-Om
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w0E9c-0003CS-T2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 03:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773214731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
 b=Ytwr/B6SJWNRciXwC2kI2LmtCDW+2rc1OVMOLi5Eah0hBEEYQmtYS6GDxhaNlRtiM7Dvh2
 xznEcYMnhyfeRrAaazPdquSt2c+vwwJbAdoRVzlylATNM6+p2bbybxONZXk7MaGSwG59hV
 VRGTBbgf4fktD3ErcMCBvxdOQwWjwn4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-dftPJwRUP1CbLQp7WjKojw-1; Wed, 11 Mar 2026 03:38:50 -0400
X-MC-Unique: dftPJwRUP1CbLQp7WjKojw-1
X-Mimecast-MFC-AGG-ID: dftPJwRUP1CbLQp7WjKojw_1773214729
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354490889b6so48033647a91.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773214729; x=1773819529; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
 b=BjhGsJ3JtL+rxhypVuSgRI2aBucz0lKYlADt1sLH7pn5wPpDX48CKJi6ylbkbP1UsI
 I+byGM3pRdtFqgw/nX4dkuXcWJIZid7rEpS8Pw8ka66++7UOmnLoK8EqqAVLLaTOPPaO
 BbhxLqcCY+rZsivFJmCLHFnDr4Xbxx55zqAqIRHJWvJ450mYAga2dGBlORgGS8XMcmob
 7GxSNUd88Q2c+flitLXbvOdqHsHNj10X5zqEWH81h+hbFuA1ru18OKbwmtIjOs8BxSFK
 iz8CBkUvh3Z6um6S3HtYpRT7t6/b4NbjMOH56hFbuJx1hTXLx43YxhcgPF3F+kicUhpk
 KXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773214729; x=1773819529;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgd9oM6xhLN40jOEiECQu2rTW8IXyv8HdUzwIF8sY9s=;
 b=JBmwFKZKt18iCnQezm3f8WiUKygTcJe8OYHuGIN+2SF9iSbFMDDlhRApjvDrcnXMHq
 NuIWkg4+DvWhmTNOppSaq+q8TDaADVB2DgioYDpLiVkAhFCJT/b2gDj8cQKc4UG6rDcs
 kcEpBkdYXeI/svG3PRiLqarrnicvI1Gqm/4KW9+e6RRJltf2DPCIMv0wuNbq7Y66GsJZ
 A42rZo/YLdaQK6mfG6xtPNPsXhrnjBE80lVS7jVJ7ghKcVDPbHosuzuNhMbmy1My4tso
 Tz2oihA0iuBDQBkZhEDrYnrsr1RHDcU5YVjSJglNIIp7lxKF+VwyJc96IqHsXlJ2Myn8
 z2gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLMfIQkBYT0pqAsNpGAyLDHtCN9qqh9x0PMFkf4ezHZ9SMEHjxbRGSjdGf7tI3JQJJYtnxjzEaBXFk@nongnu.org
X-Gm-Message-State: AOJu0Ywd5628+uFBnhK9jEZ+P/XMjhyX6Epkd1mv92Zm4t5bmlqmqYMR
 TK52IJOkqXCcM8uP96Tzft36Fd1nxG8o3EroYckzjcFEXxY2OIwMkjw0jhEkc/Q03r72r2C5eJs
 ffOvJyUVZSfjLwdk2F8+ZfcOpzrMbYg57+/MKdYp15IZ7efZtM/JD8Da6
X-Gm-Gg: ATEYQzxv0NxZ58v4muRR8ni/Gw7pAjTWGlzh2hJlfeCkzT+gN3vd0ja+bKkrClxuNu2
 KpEljLcrMP9rK+9SYh4yluAiPnteC6zT6cQQ94J2LXeyg4EY1glg012LtArhO2jexBwOHWo8p0p
 h6nxlvMXabL5ZnF90b5tqSxiYyK22btc/aYkdVSF7edZUxK6anrthZAnxQMRlkgq4s65xhB7sf8
 wO9YKBjiiC5+wh1+HIOPm2QU3vQTA9NKYiEaXmKmHuJr8bxYkDOVf6/vGooMtlI27aG1kjmFuOQ
 m3Tb1YrvZ/m2dSB4Ug5yqIHQbo7s9mJUd1iHdEAf1w3+7eeJNnQYb/VHhz7DD03GJfLV2ukH65i
 J3MwFL67ttkBMPF1QaDdE+EEgdp6OwtixiiMjAWWjxxdWu1Zs9oDS3djaDcYcLDcns8iW0Q==
X-Received: by 2002:a05:6a21:3994:b0:394:586d:1540 with SMTP id
 adf61e73a8af0-398c618471amr1341961637.72.1773214729117; 
 Wed, 11 Mar 2026 00:38:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:3994:b0:394:586d:1540 with SMTP id
 adf61e73a8af0-398c618471amr1341942637.72.1773214728725; 
 Wed, 11 Mar 2026 00:38:48 -0700 (PDT)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf92ff3sm1314383a12.17.2026.03.11.00.38.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2026 00:38:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2] coverity: fix coverity issues related to confidential
 guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260311073551.61147-1-anisinha@redhat.com>
Date: Wed, 11 Mar 2026 13:08:33 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA24744F-71C2-4586-98B0-887ABE9D9888@redhat.com>
References: <20260311073551.61147-1-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11 Mar 2026, at 1:05=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Fix issues reported by Peter.
>=20
> Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest =
reset")
> Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option =
'x-change-vmfd-on-reset'")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

^^^^^^^^^^^^^^^^^^^^^^^^^^
Sorry my bad. Will fix in v3.

> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> system/runstate.c | 5 ++++-
> target/i386/sev.c | 4 ----
> 2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/system/runstate.c b/system/runstate.c
> index eca722b43c..ca6730d111 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
>     ResetType type;
>     AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>     bool guest_state_rebuilt =3D false;
> +    bool force_vmfd_change =3D false;
>     int ret;
>=20
>     mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : =
NULL;
> +    force_vmfd_change =3D current_machine ?
> +        current_machine->new_accel_vmfd_on_reset : false;
>=20
>     cpu_synchronize_all_states();
>=20
> @@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
>=20
>     if ((reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>          reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
> -        (current_machine->new_accel_vmfd_on_reset || =
!cpus_are_resettable())) {
> +        (force_vmfd_change || !cpus_are_resettable())) {
>         if (ac->rebuild_guest) {
>             ret =3D ac->rebuild_guest(current_machine);
>             if (ret < 0) {
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index cddffe0da8..9dde972c11 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, =
ResetType type)
>     SevCommonState *sev_common =3D =
SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>     SevCommonStateClass *klass =3D SEV_COMMON_GET_CLASS(sev_common);
>=20
> -    if (!sev_common) {
> -        return;
> -    }
> -
>     if (!runstate_is_running()) {
>         return;
>     }
> --=20
> 2.42.0
>=20


