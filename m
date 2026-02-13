Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C82EF48CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 05:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqlfn-0006bd-UF; Fri, 13 Feb 2026 00:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqlfl-0006bQ-NQ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 00:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqlfj-0005bh-JI
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 00:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770960292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0C0FXXrGVXZpHqHXZ3+JbaTnbwZe/jsvwm276zl4xU=;
 b=KisZj8rvjz8IlIYbIylcin/5WoHnG9F6jDuV+NtNBi1/ja/UrOsw6c8bI4hZ6myTzMrtsR
 zTfsa+gg3o1Ma3Sz2WIgSgQhVo62pjNALsCrbUqAxPqYc733cyDNjFYyR73AIX10MFlrH0
 2fHiBsMfJw+si7ZR5vv4MXYI7Kz4eYg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-JcYWmEJqPtyAop3XQ6xj_w-1; Fri, 13 Feb 2026 00:24:48 -0500
X-MC-Unique: JcYWmEJqPtyAop3XQ6xj_w-1
X-Mimecast-MFC-AGG-ID: JcYWmEJqPtyAop3XQ6xj_w_1770960288
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad3f8367bso7523805ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 21:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770960288; x=1771565088; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0C0FXXrGVXZpHqHXZ3+JbaTnbwZe/jsvwm276zl4xU=;
 b=KoK2gLmU1jCVQnw92WnTs3tHM+RW4fTQSV3snZN88SLSBq+mtsusNIALv1IAsWQAl2
 NbyRkWoXs5BjKOsa593Ysg+KhCgvQaEQysqvucOsB9VcafxZ7IFNYQfGHfsoFvmQlWy+
 9CIfzKyy+Z7Jt+bSv2q7fzTsduoc1yNC+APTX5mMxa9gNQdoSN8uUMg6j1p42yN50g+P
 tBU26ZVlYCD/eB3Q4Usih3+o/XoF7NpkMXENEabqEnHQp7bTf8IMAoaVT24D6B6y6bW9
 HMYUNZzVQi7E4FTdiYMfIawHW2KXPttkmKbzLKiFkaaHb++MvGXhUplyGVUzPvCMhB9f
 h28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770960288; x=1771565088;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0C0FXXrGVXZpHqHXZ3+JbaTnbwZe/jsvwm276zl4xU=;
 b=Rkzgdwr5WtrFs/ZQcrpgtonBbN5/dfJ4ovhriM9H9HKmRNdXZBKDhj6sByBXiFP8OB
 1MENGZ1LF/jTJGP/U0KuY0cctleEM/JhIuqDjok0q3Y3t43gKI4cQL6v43kdPNS1ZUeA
 msxE+hUKFXnHPm+6KwMhSjlBouVme7tGxW2TPGpHmxpwCoNyHz55Gj1pw9D02icc9jNc
 WIH0DKZToDm6jKiuG02RZYgfwwCebC242qwlJDnMR090cmfJzDPXE1N2K21AxLoDvdDx
 7oH8fMcLpH5twKZO8iicNNQ0ZYGTfvd+8Q+ON93mXm7h07pbmJzIay2zRLT+DpoTgG7G
 f7Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcge1/z/R0qf94QBqaHKc9aHK14849QlB2KZZtA+VP3+sc9Ay1DdUgKm81CXZZaOCSAuB7UKx5PQyC@nongnu.org
X-Gm-Message-State: AOJu0Yy5jb94qKlZNfyPMd00xJbJVKnwqatkJr+5v2ziqqfW3X6m7wbj
 QsvhBZgscejV1vRtvDS0MI8KSGgo3N2bZDpoesknCeXFt5HcCKJhr28+VLqath21pWMIBN0LcYs
 /RDX1Ml2+Hbq/2gym1oBstzMbmTwjpJx5Joc/R5GIVQ72Yl8cT1I7z9Za
X-Gm-Gg: AZuq6aKGCKj7oz6mOlxefqUAcpbSgNYym36oLchfUWkXZDEuu3P7KWX196+sO0YQM3h
 SBUhVbK3P935+KirxLCkic7eKIj+WwhwpFehYGoKalgB8MSqSTdMnT8JxnsQ7qGv7EUCJR60cO+
 XADPSrgon99njbSgWzdCKGpIBYHaUC4CX4vK8bWH5kZroOgBw3njN8m4kk8qVaT9J/fFt7ZT4s3
 VVcbbacFrqBC1B5+/11gjMGycN/oYMUkVaxpi+SDwtcLCtj5SBtMoNAX19G+3O1WSAhhlcXm0Tc
 vjHczdKJWji38zcpqbUTvkX2xTN6QnMRKgYZTUeJsnbpDS1YciCFPH1wbnMN8Ad6T2zJIv9KhSq
 LZRBztZhEG+1Mhc7D45fmazpMmYnJm7jsae9zV2jEsXdTX/9BKaTisbnY4PJm95LEIv5ckQ==
X-Received: by 2002:a17:902:d511:b0:2aa:d2a7:ad2e with SMTP id
 d9443c01a7336-2ab5057c009mr9489375ad.36.1770960287839; 
 Thu, 12 Feb 2026 21:24:47 -0800 (PST)
X-Received: by 2002:a17:902:d511:b0:2aa:d2a7:ad2e with SMTP id
 d9443c01a7336-2ab5057c009mr9489185ad.36.1770960287392; 
 Thu, 12 Feb 2026 21:24:47 -0800 (PST)
Received: from smtpclient.apple ([122.164.27.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29998cd3sm68000975ad.85.2026.02.12.21.24.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Feb 2026 21:24:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v4 03/31] hw/accel: add a per-accelerator callback to
 change VM accelerator handle
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
Date: Fri, 13 Feb 2026 10:54:32 +0530
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAFC646D-DA07-4C09-BA33-2153799F882B@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-4-anisinha@redhat.com>
 <0d4b92f6-1220-4301-bf38-6b15e910aa47@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



> On 12 Feb 2026, at 10:23=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Ani,
>=20
> On 12/2/26 07:24, Ani Sinha wrote:
>> When a confidential virtual machine is reset, a new guest context in =
the
>> accelerator must be generated post reset. Therefore, the old =
accelerator guest
>> file handle must be closed and a new one created. To this end, a =
per-accelerator
>> callback, "reset_vmfd" is introduced that would get called when a =
confidential
>> guest is reset. Subsequent patches will introduce specific =
implementation of
>> this callback for KVM accelerator.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  include/accel/accel-ops.h |  1 +
>>  system/runstate.c         | 37 ++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 37 insertions(+), 1 deletion(-)
>> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
>> index 23a8c246e1..998a95ca69 100644
>> --- a/include/accel/accel-ops.h
>> +++ b/include/accel/accel-ops.h
>> @@ -23,6 +23,7 @@ struct AccelClass {
>>      AccelOpsClass *ops;
>>        int (*init_machine)(AccelState *as, MachineState *ms);
>> +    int (*reset_vmfd)(MachineState *ms);
>=20
> So far 'vmfd' is a KVM concept. Can we use a more generic name?

This is more like a hypervisor interface to manage the VM. For example, =
for Xen it would be what xc_interface_open() would return.
So I can rename it to something like =E2=80=9Creset_hypervisor_interface=E2=
=80=9D.

>=20
> Please add a @docstring description for this handler.
>=20
>>      bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
>>      void (*cpu_common_unrealize)(CPUState *cpu);
>>      /* get_stats: Append statistics to @buf */
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 5d58260ed5..0a74e3ade5 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -42,6 +42,7 @@
>>  #include "qapi/qapi-commands-run-state.h"
>>  #include "qapi/qapi-events-run-state.h"
>>  #include "qemu/accel.h"
>> +#include "accel/accel-ops.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/job.h"
>>  #include "qemu/log.h"
>> @@ -509,6 +510,9 @@ void qemu_system_reset(ShutdownCause reason)
>>  {
>>      MachineClass *mc;
>>      ResetType type;
>> +    AccelClass *ac =3D ACCEL_GET_CLASS(current_accel());
>> +    bool vmfd_reset =3D false;
>> +    int ret;
>>        mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : =
NULL;
>>  @@ -521,6 +525,29 @@ void qemu_system_reset(ShutdownCause reason)
>>      default:
>>          type =3D RESET_TYPE_COLD;
>>      }
>> +
>> +    /*
>> +     * different accelerators implement how to close the old file =
handle of
>> +     * the accelerator descriptor and create a new one here. =
Resetting
>> +     * file handle is necessary to create a new confidential VM =
context post
>> +     * VM reset.
>> +     */
>> +    if (!cpus_are_resettable() &&
>> +        (reason =3D=3D SHUTDOWN_CAUSE_GUEST_RESET ||
>> +         reason =3D=3D SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
>> +        if (ac->reset_vmfd) {
>> +            ret =3D ac->reset_vmfd(current_machine);
>> +            if (ret < 0) {
>> +                error_report("unable to reset vmfd: %s(%d)",
>> +                             strerror(-ret), ret);
>> +                vm_stop(RUN_STATE_INTERNAL_ERROR);
>> +            }
>> +            vmfd_reset =3D true;
>=20
> If we need a such flag, please rename it generically.
>=20
>> +        } else {
>> +            error_report("accelerator does not support reset");
>> +        }
>> +    }
>> +
>>      if (mc && mc->reset) {
>>          mc->reset(current_machine, type);
>>      } else {
>> @@ -543,7 +570,15 @@ void qemu_system_reset(ShutdownCause reason)
>>       * it does _more_  than cpu_synchronize_all_post_reset().
>>       */
>>      if (cpus_are_resettable()) {
>> -        cpu_synchronize_all_post_reset();
>> +        if (vmfd_reset) {
>> +            /*
>> +             * If vmfd has changed, then vcpufds have also changed.
>> +             * Need to sync full cpu state for non confidential =
guests.
>> +             */
>> +            cpu_synchronize_all_post_init();
>=20
> Calling post_init() in reset() is dubious. It might work with KVM by
> chance (because only KVM implements .reset_vmfd), but by design I
> don't expect it to work on other accelerators. If you really think
> this is the only solution, then you'll need to document cpu_sync*
> methods very carefully.
>=20
>> +        } else {
>> +            cpu_synchronize_all_post_reset();
>> +        }
>>      }
>>        vm_set_suspended(false);
>=20
> Isn't the confidential_guest_kvm_reset() API more appropriate here?



