Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFA5C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 13:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umB6S-0000We-0f; Wed, 13 Aug 2025 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umB6K-0000ON-At
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 09:01:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umB6E-00035d-LF
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 09:01:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so61071925e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755090059; x=1755694859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8d+OEKMNQLXkS+0JIZdWtkIaUy2MM8WLDGkj3FgK9A=;
 b=uhzO4efPOXaZ3xz0CqluCfSmVk9XCq3fUxT2ME5mRt8ak/tMuwYTykvLyMTegzfLCZ
 ZN9Rdg8ZASurvMURnJCWp0Ff857oDVkPiD0mbkgGE7q9xlunH+qX0CLkKSqlNPsouvg3
 CYSnUEN1g/A/svwhfHM4e0xxClRfzKjprU/Ww7ebKuClHR7OeiLSFGi9NPPa8KyjXi41
 XPIwHHKPj3rt1yqsriykpb6RkxPI8ipYMn4QhRHjNbBrxMRwKs7OyhrjhmfkfpG0TxAS
 LOCN2E6JseQcO9mkVuE6QWlk7uEE06qNcSI+pOpM/vcZib1jdJPGU87kcoJ+4QWdydSH
 KsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755090059; x=1755694859;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r8d+OEKMNQLXkS+0JIZdWtkIaUy2MM8WLDGkj3FgK9A=;
 b=kDKE3VU3oUlU7XhQQNiGFJtRfVClgcS2kPsSFnEHUewna/NoBLLV8suF/m6VLkZyuO
 ef4NKDoa0pKv4DjLBnGB0cCPmde4E+UHUdVA+r7lWzjnBVCNTP5HF6OEa+mC152yl3tt
 Y2s0z4V37amr+vheD1yKTexOXymynnUUL00R26Ri9VItLvfreDYjCrw/KSyYZZqX+TiQ
 bkBetT5ggRzD4Y/4dOOON0MUPnS3mYHGqpU8WTk/+c/UCtff4kNccaTan4HVRCelxRG8
 Y7sbMlY8Abtgw2U2rIKGl/4YiefTljQW1fQL9y0L9gV8hXTPsMEiZpV4Wp7lxWOdtYp7
 IuZg==
X-Gm-Message-State: AOJu0YydLWYxG2ib4JeWPvqFbSJQZChad8+MSr2Ox6WmBCkxBWp1bKyE
 NB8Y81y9BNEzamIfl9VSxWlvOKri4nrMt2kT2qFvO4/BCBhdciyBZP3qezV/bHpkHtI=
X-Gm-Gg: ASbGncucDslNcgRV831RTSWF6Y5y+Y9NYD686/coOP8U1N4vo+NfyMYZuJSV35zy1Vd
 PqcPoB0Y9+wheQb9ixYTGH7p4uSnXcjtRabL41HRY+f/+CLYwhsLVx/6skshsqAScenuVK0PpUg
 o7d0GwyMZwNpuuscaZFF/bSJcrWHNnfzr9HaMDukv0fj7wH5B3Nxpg4BNmVpiPdYpx64kpGPpKz
 eiZcaavCBIP/5jGuBCsxrRpfJx1ErayavhYFI04RtYND5Venz1kgGHXB1iM7kPSiqFcH8CB3sKE
 vhWax08UHhAFVrXnPZYR/cpjRHUWHQ4yPysA/3ekHbT8CVcwJ0C/Y02mZbwlIUGXigtXtItmSyR
 3Ayj7iNLjPllsjcEI3dwxKaXvvwyLV/5obg==
X-Google-Smtp-Source: AGHT+IG78kweVihePeGXobK5ZACONta50Di2ozuW949GOhIjFKfOUdB11BptV5ajC0j06Cvdxo35Bw==
X-Received: by 2002:a05:600c:4f8a:b0:459:dfde:3329 with SMTP id
 5b1f17b1804b1-45a165f7e8fmr29149335e9.31.1755090059156; 
 Wed, 13 Aug 2025 06:00:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a517d49sm2013365e9.11.2025.08.13.06.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 06:00:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12C2C5F7AC;
 Wed, 13 Aug 2025 14:00:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: ~myrslint <myrslint@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~myrslint <myrskylintu@proton.me>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH qemu 1/1] Default disable ignore guest PAT quirk
In-Reply-To: <175506686028.15648.7602021948044277748-1@git.sr.ht>
 (myrslint@git.sr.ht's message of "Wed, 13 Aug 2025 06:23:24 +0000")
References: <175506686028.15648.7602021948044277748-1@git.sr.ht>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 13 Aug 2025 14:00:56 +0100
Message-ID: <877bz75qbb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

~myrslint <myrslint@git.sr.ht> writes:

> From: myrslint <qemu.haziness801@passinbox.com>
>
> Addresses this issue:
> https://gitlab.com/qemu-project/qemu/-/issues/2943

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943

> Most Intel CPUs in current use have self-snoop. The few added lines of
> code also check for availability of the quirk disablement option so if
> some CPU does not have this feature no change of behavior will occur.
> ---
>  accel/kvm/kvm-all.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 890d5ea9f8..c3d06ae2f8 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2682,6 +2682,32 @@ static int kvm_init(AccelState *as, MachineState *=
ms)
>=20=20
>      s->vmfd =3D ret;
>=20=20
> +/* if target platform has no notion of this or kernel version does
> + * not have it there is no use for compiling this in */
> +#ifdef KVM_X86_QUIRK_IGNORE_GUEST_PAT

architecture specific changes should be in kvm_arch_init (in this case
in target/i386/kvm/kvm.c)

> +    /* first check for modifiable quirks bitmask */
> +    ret =3D kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
> +    /* next make sure disabling it is allowed */
> +    if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
> +        struct kvm_enable_cap *cap;
> +        cap =3D calloc(1, sizeof(struct kvm_enable_cap));

I few things, style says:

  Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
  APIs is not allowed in the QEMU codebase. Instead of these routines,
  use the GLib memory allocation routines
  ``g_malloc/g_malloc0/g_new/g_new0/g_realloc/g_free``
  or QEMU's ``qemu_memalign/qemu_blockalign/qemu_vfree`` APIs.

And to avoid manual free you would do:

  g_autofree kvm_enable_cap *cap =3D g_new0(kvm_enable_cap, 1);

However why not just have a structure on the stack, e.g:

  struct kvm_enable_cap cap =3D { .cap =3D KVM_CAP_DISABLE_QUIRKS2,
                                .args =3D { KVM_X86_QUIRK_IGNORE_GUEST_PAT =
};

In fact looking at kvm_vcpu_enable_cap() you should probably just use that.

> +        if (cap) {
> +            cap->cap =3D KVM_CAP_DISABLE_QUIRKS2;
> +            cap->args[0] =3D KVM_X86_QUIRK_IGNORE_GUEST_PAT;
> +            /* if intel cpu does not support self-snoop this is a nop */
> +            ret =3D kvm_vm_ioctl(s, KVM_ENABLE_CAP, cap);
> +            if (ret < 0) {
> +                error_printf("KVM_X86_QUIRK_IGNORE_GUEST_PAT available a=
nd "
> +                             "modifiable but we failed to disable
> it\n");

I think this should be error_report

> +            }
> +            free(cap);
> +        } else {

You don't need the else leg if you are dynamically allocating as g_new
and friends will abort().

> +            error_printf("KVM_X86_QUIRK_IGNORE_GUEST_PAT: could not "
> +                         "allocate memory\n");
> +        }
> +    }
> +#endif
> +
>      s->nr_as =3D kvm_vm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
>      if (s->nr_as <=3D 1) {
>          s->nr_as =3D 1;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

