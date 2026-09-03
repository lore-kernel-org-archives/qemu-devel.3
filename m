Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E69C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x236O-00084a-IJ; Thu, 03 Sep 2026 04:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x236N-00084O-Pe
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1x236M-0007ET-Al
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788425236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
 b=QEIsktfc1rbGxOSxeukhAdzAsbAZEyqFoUA8S+ut8CtKzZsuAhlUFqzaUNuWQ49rEtvXf1
 7tzWM37Tf5XCaHTl76FqmeQGIMsRq1XXNHBxt68ZzEEWy1F+mu7nfFDYtIqlqTbhKyvXh8
 gOQ7v8+x4HYcIc0lKOLY89Zvabc25Zw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-AuugVl8RNByNG-X0aEeyeA-1; Thu, 03 Sep 2026 04:47:13 -0400
X-MC-Unique: AuugVl8RNByNG-X0aEeyeA-1
X-Mimecast-MFC-AGG-ID: AuugVl8RNByNG-X0aEeyeA_1788425232
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so4508202a91.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788425232; x=1789030032; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
 b=UX8Kgjz+hj63IEAkhC5sQwXWC9jbBPNUGhSiHkG545zV2PKG+yyRE27x7hCs22AyHX
 TBgpgpMn2lU78pNWXJv7ve+3i6G3DJII5ja2T1zFsAR6fBOe/uxgOoaemKeTmw2ooKf3
 TQ6Sj8sbi1mELFUoVjrTR1x3ZhZtBE3SIb7gZONMr0vH75kiPOY30xi1UZZNBNOZrpLK
 0qfayaTeUN/KfynfSI1PkrKDqy3ZlL2qQMFyFCot88GrdGESmNgS+ahztMzx7MW0Lq3u
 KEMmjkB0W2XG9tRFAKL38E/VSS8sVWWcwH6hyA323vYoMQUNxl2Xb62YjnAgw+GQfWsD
 cSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788425232; x=1789030032;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QSusju1pkpd9GhS5C6FBQjPzNYyvC0nJfUY5xeLk78U=;
 b=iSxbFUZIRgrO+AK8HZJ2H/h2/QQrBznTukz3Dsbp+ibpobww3NqirsIBG1P8hJK6iZ
 7c8uYkSulL8zlUq5jB0yVJJHOyOEN30lX7kKZAgPkv89p4jUgQw10RJjYAksLygVtViy
 Q796O74PlMn3LSUADS/L+NqHqHuvwa2s3No6VAhzgqrkFMr+8FYXuWFx2xsHWeTtoCW8
 YFays8vJcqOEJLWMmHCm0A7C0B4Vmb5rv0AwSwd3I5pJ7m7MN2Rn30+IJObam8qejX6J
 VJPuiG0z/l0Bg8NtBSSnDKY7lKQz2LkXknuV2qFKdSc07Ml9uThdUGU0PomZFz5wz4Lo
 FTtg==
X-Gm-Message-State: AFuF++kWI8r8oBQJR+eO9pglz3x69GPIPN2yL2EybCnrEbSoVWvym27p
 XvQ4j0CrIMZoiraQ0R9NL4CexTyCC5olOUluZ6g0MyessIubL44PboLQWt7Al31BDZFBj05Ntoe
 7GoAjCaGdBPKcMyTEJNByO2iEDNxoe37Dr4fOI52YaGgHSk6PphVLxlX9
X-Gm-Gg: AYBFou1W7OwZyn1eCF0jcY3krPWOQHVhD7d0jAYgsGZy4GaN1nHe8bKZiG3xeEn8heB
 0B4MLAQvXmvFFKsem8TZaknCMeCuJGeGPh7nwlEhUO0U2RFhvEQzmUu+tzPDWdPwVALSAs0yiNE
 S4eD/7ooRSUIyIEUG56q36PrsiBXQrnbSWByG4DQneyTzL1iMGIsk7RxUfZZrPEVms4WgcLAElA
 MvbvkqvKmb7wQN6x2Id4FfHlxXTdO5EhuFZ2N6h2OU3seYOFZAZyHLv2UncKQPwDgcXpbagJYLx
 qzpGbdHr0qDx4cV3C62DW8X5stAxwnruOwHIo6Yy+7M9otcR2lC8kT9byhA6pvDeOavAE0X23nZ
 ybkAVwlxjX6MOaN86YsPSm4oGhVRp+8ly8dcl5XfW7zc1aqE83g+4p/M=
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39aee04acdamr18160209a91.14.1788425232341; 
 Thu, 03 Sep 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39aee04acdamr18160115a91.14.1788425231825; 
 Thu, 03 Sep 2026 01:47:11 -0700 (PDT)
Received: from smtpclient.apple ([106.219.132.168])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431994db8csm4119845c88.9.2026.09.03.01.47.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 01:47:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 3/4] i386/sev: convert the guest policy properties to
 custom accessors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
Date: Thu, 3 Sep 2026 14:16:58 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <005FBE44-E87B-4CA7-8BB3-5A8A3024A00B@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-3-e93a6cf8c5ac@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



> On 1 Sep 2026, at 3:39=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Both SEV/SEV-ES and SEV-SNP expose a "policy" object property. The
> SEV/SEV-ES one was registered as a plain uint32 pointer property, and
> the SEV-SNP setter ignored the result of the visit.
>=20
> Give both properties explicit getter/setter functions and check the
> return value of the visit in the setters. This is preparation for
> tracking whether the guest policy was set on the command line.
>=20
> No functional change intended.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> target/i386/sev.c | 30 +++++++++++++++++++++++++-----
> 1 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 465415c535..c76cdba8d2 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2956,6 +2956,22 @@ sev_guest_class_init(ObjectClass *oc, const =
void *data)
>             "use legacy VM type to maintain measurement compatibility =
with older QEMU or kernel versions.");
> }
>=20
> +static void
> +sev_guest_get_policy(Object *obj, Visitor *v, const char *name,
> +                     void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp);
> +}
> +
> +static void
> +sev_guest_set_policy(Object *obj, Visitor *v, const char *name,
> +                     void *opaque, Error **errp)
> +{
> +    if (!visit_type_uint32(v, name, &SEV_GUEST(obj)->policy, errp)) {
> +        return;
> +    }
> +}
> +
> static void
> sev_guest_instance_init(Object *obj)
> {
> @@ -2964,8 +2980,8 @@ sev_guest_instance_init(Object *obj)
>     sev_guest->policy =3D DEFAULT_GUEST_POLICY;
>     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
>                                    OBJ_PROP_FLAG_READWRITE);
> -    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
> -                                   OBJ_PROP_FLAG_READWRITE);
> +    object_property_add(obj, "policy", "uint32", =
sev_guest_get_policy,
> +                        sev_guest_set_policy, NULL, NULL);
>     object_apply_compat_props(obj);
>=20
>     sev_guest->legacy_vm_type =3D ON_OFF_AUTO_AUTO;
> @@ -3004,9 +3020,13 @@ static void
> sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
>                          void *opaque, Error **errp)
> {
> -    visit_type_uint64(v, name,
> -                      (uint64_t =
*)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
> -                      errp);
> +    SevSnpGuestState *sev_snp_guest =3D SEV_SNP_GUEST(obj);
> +
> +    if (!visit_type_uint64(v, name,
> +                           (uint64_t =
*)&sev_snp_guest->kvm_start_conf.policy,
> +                           errp)) {
> +        return;
> +    }
> }
>=20
> static char *
>=20
> --=20
> 2.55.0
>=20


