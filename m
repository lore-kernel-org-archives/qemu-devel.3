Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7A4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevCZ-0004Kq-QA; Wed, 01 Jul 2026 09:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1wevCY-0004Hv-4m
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1wevCW-0005T0-DH
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782913322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1P5GMvHzVWNoaL9xFj8wTYseXKhCxICkCWDzhIGgChE=;
 b=at2kOmTicGU7dQg2ncKJMXYCVCjtxA55HW9M3Zv1l1YwAh1Q+k7vkRuSjX1ewFDciy0y+L
 1q5rDOshCU9q+X97MnE86plQnLtIkK/CaNeycQvGHZPkH6NlCX1B6ACVBWAIIhM4Y9cEqs
 ZLKhVlJfjMYQSqtu+ZgyvWQVtIqXvRk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-iRKJpQmyMA6cmYDXLLq-GQ-1; Wed, 01 Jul 2026 09:40:42 -0400
X-MC-Unique: iRKJpQmyMA6cmYDXLLq-GQ-1
X-Mimecast-MFC-AGG-ID: iRKJpQmyMA6cmYDXLLq-GQ_1782913242
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49260d6eaadso4499115e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782913241; x=1783518041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1P5GMvHzVWNoaL9xFj8wTYseXKhCxICkCWDzhIGgChE=;
 b=sPS78M5MbzBN7n9N67V8qvYBDWpO0KHJWfOAI8KpAv4B4T1G5taZ2dAoBSyG2c3eCh
 qt3ynpUSQ2sA0zj4vwxy36FSb9Xjqinaoj8p+3mcQaBWc5UHgBrwlg+xz2hlF6b6kjxz
 NIBA4dZRUjfJv7wYl+WDlVfUyzSREQc1fhbGGJ7u/JPoWZJ91UzO7A9z+ql9+ncMI4+l
 rQC8xAmD93gwzFDbSdU60GS33UQFTwdj3Tf/4OM5THbjgB3P9AUMNoJqy1B++UCPGyOi
 7cMGoaVQElYSszDSIsHcPnzGhIZ8uYJD68exKDdOR8bLSro6m7ZW0ZR5X4OI/aGXKAwT
 uQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782913241; x=1783518041;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1P5GMvHzVWNoaL9xFj8wTYseXKhCxICkCWDzhIGgChE=;
 b=W8WHiJp35GfKbaqMthcBKBVF8c4mOHJ5xIqErLKpg4agTSGN7+6uucpkW70xCtKYEu
 865wbBDUen4LIDJkxt+nFxcMxGsG+9dQbd/nafReUfbNIlIxFZAJlgc4/mcdA/TgayBx
 OKklTpppBUxFq74CE2NRgJQPSefwHo2Ivqkd3MawRHtarPGPtszgs1iVGgId2F2LrEDa
 s9AWLY9Jqkibpf6MXl9LN3R6cXgoxzJkSsWvHjFL2ExkUTheiqUSEGV7+PGI8J5Gfjbg
 9FawE2CvsgthCSavm9+JlEMGL9UqmgI3TRq3H6mK4OpUxwEAasEsuvzUFLpmGDdws/Eg
 nuaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZmKw1BIRms5dvhhV9Bbu4RVIlPItqOK6J4MU0tRStnOqi1XMpASDjoBTBaR4ZnP33kQPE1FtzcCta@nongnu.org
X-Gm-Message-State: AOJu0YwBC4UPEf8bphVUfuNN2sBjsmzf7a8mwyQkbXi37KHYsEVtXDCF
 nPxjMCxiKEWzHV5c9VC/XDuPmDR2oZIKrMj1C5YoFifJhyZwpK/0GYDZB0NjVgFd9LdYjtiumzY
 s5uOiqMzzgnXdLyVzXPydb8tYvg3CVhEhs7XJAjC0f/JOEpbacl2StREI
X-Gm-Gg: AfdE7cn2Z+yyj7xHz1ZGB2X4q+tRB9FFg5sTLUJUlo5G+yVDp1bTi4YLiCFrOwzPxkH
 E225nUGDXagtcT2c7f23fLTVPTwZVVgNi9AlmE4r26CXGiTgKCkIj6pXMHE1r+WcpGzgoBUnvLg
 A3OIitip57Fk211efHEs0I3ab4kuoK/TjK/h+uRmS9Af4Hj4f7nw3NXXuyAl50nhD9w1NUZyXdY
 QtfrUFAVJD8zC7uXYmV3gWynR/QabHPKu5r/cS7hHKFrmc06gpOJNzcU5xe3QLmpMrtb06NvNIi
 DsYuFF98lBcWdyvBXC9w08tKn/cCJ50aPwc3CoxoN6Dt5fAn4+tuspZaWZVxYUcY2a+kiXhvXIl
 ZvqLw+pI6seLY
X-Received: by 2002:a05:600c:4f86:b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-493c2b99b19mr25624775e9.31.1782913241522; 
 Wed, 01 Jul 2026 06:40:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f86:b0:492:32f3:a344 with SMTP id
 5b1f17b1804b1-493c2b99b19mr25624185e9.31.1782913241067; 
 Wed, 01 Jul 2026 06:40:41 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4540aesm78099605e9.0.2026.07.01.06.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 06:40:40 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo
 Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/hyperv: fix misleading hv-crash shutdown description
In-Reply-To: <20260701122135.3168729-1-marcandre.lureau@redhat.com>
References: <20260701122135.3168729-1-marcandre.lureau@redhat.com>
Date: Wed, 01 Jul 2026 15:40:39 +0200
Message-ID: <87pl16hlpk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The documentation stated that writing to HV_X64_MSR_CRASH_CTL
> unconditionally causes the guest to shutdown. In reality, it triggers
> qemu_system_guest_panicked() via KVM_SYSTEM_EVENT_CRASH and the
> resulting action depends on the generic panic action policy
> (-action panic=3D...), which defaults to shutdown.

Indeed,

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/system/i386/hyperv.rst | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index 1c1de77feb6..e1babffb0f9 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -71,8 +71,11 @@ Existing enlightenments
>    by the guest when it crashes, HV_X64_MSR_CRASH_P0..HV_X64_MSR_CRASH_P5=
 MSRs
>    contain additional crash information. This information is outputted in=
 QEMU log
>    and through QAPI.
> -  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL caus=
es guest
> -  to shutdown. This effectively blocks crash dump generation by Windows.
> +  Note: unlike under genuine Hyper-V, write to HV_X64_MSR_CRASH_CTL trig=
gers
> +  ``qemu_system_guest_panicked()`` via ``KVM_SYSTEM_EVENT_CRASH`` and the
> +  resulting action depends on the ``-action panic=3D...`` policy (defaul=
t:
> +  ``shutdown``). With the default action, this effectively blocks crash =
dump
> +  generation by Windows.
>=20=20
>  ``hv-time``
>    Enables two Hyper-V-specific clocksources available to the guest: MSR-=
based
> @@ -304,8 +307,9 @@ currently implemented Hyper-V enlightenments with the=
 following exceptions:
>    ``hv-version-id-snumber`` can be left unchanged, guests are not suppos=
ed to
>    behave differently when different Hyper-V version is presented to them.
>  - ``hv-crash`` must only be enabled if the crash information is consumed=
 via
> -  QAPI by higher levels of the virtualization stack. Enabling this featu=
re
> -  effectively prevents Windows from creating dumps upon crashes.
> +  QAPI by higher levels of the virtualization stack. With the default
> +  ``-action panic=3Dshutdown`` policy, enabling this feature effectively
> +  prevents Windows from creating dumps upon crashes.
>  - ``hv-reenlightenment`` can only be used on hardware which supports TSC
>    scaling or when guest migration is not needed.
>  - ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overco=
mmited

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

--=20
Vitaly


