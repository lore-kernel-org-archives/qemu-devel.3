Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1505CE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Jl-0006TS-Go; Thu, 19 Feb 2026 05:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt1Jd-0006SV-6L
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt1JZ-0005pw-Ou
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771497080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LyQNA8MfxC+gdRaJejrXp5+qJYC1z7cZ1QgL2HRqhmA=;
 b=a8rlNmhH6epL/5YdrPiWJnlZZG03pCBk9McpUxZfc6g8Lasj3UJqaB2Z6ZuzNqb5RsQhKz
 ctQHMC4scPzFM2yzeNpjB2shPfD/SXa5lodbqXFe71wBGRTSB/u/TYJpc+DFSy824HGNS5
 SmykSw5inTsQuj5ed/mtg/u4VVVnKAg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-BuIAEaYROIay_3UZ2QDx1w-1; Thu, 19 Feb 2026 05:31:18 -0500
X-MC-Unique: BuIAEaYROIay_3UZ2QDx1w-1
X-Mimecast-MFC-AGG-ID: BuIAEaYROIay_3UZ2QDx1w_1771497078
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad6045810so7954255ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771497077; x=1772101877; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyQNA8MfxC+gdRaJejrXp5+qJYC1z7cZ1QgL2HRqhmA=;
 b=M9aItRZfo1HRlh8cdsUhkyKFYs3gERe2Hiy/g5hX4vv5Eh3HA9YNS7OmKe1++e5KIz
 3fmIgIBziTNAoXS9iXYinBuM5WNYwg8lujP/uHnAp6h0KDETzHm4g7KxW4oV0jn+vQvp
 nl+G9/C+lHe8pC3wf4t7ZKog1PTs9my2MnjmvAeUe7rGj0lQHyZntfYm5AXkIHKWrXm7
 gKlySHZ38QiA2dPOFMI67P0R4F07Z/5FxHVnFzkKti4UiLD5asrTzvJIHCFDgaAQ88pX
 u9bw8mEeiSRlyw5muRxk3W5/yQDa5PnWe++HX34W9/p0nzGRWSsExCzwd9BKe/CpaCF4
 x4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497077; x=1772101877;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LyQNA8MfxC+gdRaJejrXp5+qJYC1z7cZ1QgL2HRqhmA=;
 b=qbzBJ4tqgfCTCVeI5ts373OWqGPLm519g4NQ3NcTmiTo8QvFU9865LVVl5uWJEofr6
 dhNPUwYouW3HT8SNp+HHV9rQv8wo6XvK4BgSSiFGa4JU2BDCsHfR82JdvZ/XXD8Fs9jd
 ZccGP1vXwkL4afKSHr3zxGhMTF8kODVNLS2zAgXWUnICfRnhK93hOrRGcAagtCEyLwTr
 GqCstGFBTIz5SgFcaOi3CJANiet9jlD9hkxeuE4vQFIV0HC9sINSjkYNAuxUgZAyoCr2
 6g9Qitym6EeJxW6V+S28d0HtZkNRIITsvj5hmw+cjkkDNfIItrMq5RYhsx82axFCotxQ
 9djw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIMcIK1gL5hD1rz7fKi69KWRdmZnWqcBZhA82KSiCym/UQIJEnr8RhjpWbbcmWOouYCGSKEIAaEQ7P@nongnu.org
X-Gm-Message-State: AOJu0YweOPFciH3PN0MfPTxOH2NIf9sxOYH8IHCuCzH0zXylfvDfXF1x
 d2Z7dfvV9EWM3/EBt6fLXEVv0Io6pNhePCgk07j494UYxFnDBbvT3KunWzdkfa7Ha676iXgHoWh
 C6sDz6fJ9HzoS8QUVrhmomNaJR6bkJMIKPcg8Vov0PzBa9y1gqcsaEmxcCVL7Exim
X-Gm-Gg: AZuq6aJ2sN8TtGBF3Oiji+uNfzGpg/niHkC7qC6gn0zztIS20Xj5pAxZ6W78+JLRZup
 61whogoGXmHklR9/EMsoVW2H/XS0joTok7pjB9bimJApgIZM/HkrZ7tW0REgR6fnMuC4zvxMFcz
 nslgzARml5Ma/AkIR0rOE+ZAPAXOD0JKbqNFO6EUFN6G8yuBjyoCQKoS56cUiFJgbwpYxMqtKll
 cPKeUYcB2leOextNLFVJr0QB+hxsxEfkJ3Qm+aaeAbSpQ8lSe0A/ryRarEg1wE8g3jAQKjg8x71
 NypD0JbBfr52a4Q8VmCE3XVmbrSP6WMNjB94HpgMRaGqNPj+F5OWRCHUwdmp/G68j2tZOI4xfi6
 SVroe45Hp7G98uDSlcgjAgp/eKzVUF+Bj8UZTU9Ej6QbNTRP/ve5xxr4UO6ZDI9YdDhw=
X-Received: by 2002:a17:903:2a85:b0:2aa:e3f7:a945 with SMTP id
 d9443c01a7336-2ad50fb5db7mr45393415ad.49.1771497077482; 
 Thu, 19 Feb 2026 02:31:17 -0800 (PST)
X-Received: by 2002:a17:903:2a85:b0:2aa:e3f7:a945 with SMTP id
 d9443c01a7336-2ad50fb5db7mr45393105ad.49.1771497077034; 
 Thu, 19 Feb 2026 02:31:17 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm157285875ad.82.2026.02.19.02.31.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Feb 2026 02:31:16 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
Date: Thu, 19 Feb 2026 16:01:02 +0530
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <793B549F-F866-4BF5-ABAF-A0537BA8713B@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-28-anisinha@redhat.com>
 <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
To: Paul Durrant <xadimgnik@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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



> On 19 Feb 2026, at 3:09=E2=80=AFPM, Paul Durrant <xadimgnik@gmail.com> =
wrote:
>=20
> On 18/02/2026 11:42, Ani Sinha wrote:
>> On confidential guests KVM virtual machine file descriptor changes as =
a
>> part of the guest reset process. Xen capabilities needs to be =
re-initialized in
>> KVM against the new file descriptor.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  target/i386/kvm/xen-emu.c | 50 =
+++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
>> index 52de019834..69527145eb 100644
>> --- a/target/i386/kvm/xen-emu.c
>> +++ b/target/i386/kvm/xen-emu.c
>> @@ -44,9 +44,12 @@
>>    #include "xen-compat.h"
>>  +NotifierWithReturn xen_vmfd_change_notifier;
>> +static bool hyperv_enabled;
>>  static void xen_vcpu_singleshot_timer_event(void *opaque);
>>  static void xen_vcpu_periodic_timer_event(void *opaque);
>>  static int vcpuop_stop_singleshot_timer(CPUState *cs);
>> +static int do_initialize_xen_caps(KVMState *s, uint32_t =
hypercall_msr);
>>    #ifdef TARGET_X86_64
>>  #define hypercall_compat32(longmode) (!(longmode))
>> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState =
*cs);
>>  #define hypercall_compat32(longmode) (false)
>>  #endif
>>  +static int xen_handle_vmfd_change(NotifierWithReturn *n,
>> +                                  void *data, Error** errp)
>> +{
>> +    int ret;
>> +
>> +    /* we are not interested in pre vmfd change notification */
>> +    if (((VmfdChangeNotifier *)data)->pre) {
>> +        return 0;
>> +    }
>> +
>> +    ret =3D do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (hyperv_enabled) {
>> +        ret =3D do_initialize_xen_caps(kvm_state, =
XEN_HYPERCALL_MSR_HYPERV);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +    return 0;
>=20
> This seems odd. Why use the hyperv_enabled boolean, rather than simply =
the msr value, since when hyperv_enabled is set you will be calling =
do_initialize_xen_caps() twice.

I am not sure of enabling capabilities for Xen. I assumed we need to =
call kvm_xen_init() twice, once normally with XEN_HYPERCALL_MSR and if =
hyper is enabled, again with XEN_HYPERCALL_MSR_HYPERV. Is that not the =
case? Is it one or the other but not both? It seems kvm_arch_init() =
calls kvm_xen_init() once with XEN_HYPERCALL_MSR and another time =
vcpu_arch_init() calls it again if hyperv is enabled with =
XEN_HYPERCALL_MSR_HYPERV .

>=20
>> +}
>> +
>>  static bool kvm_gva_to_gpa(CPUState *cs, uint64_t gva, uint64_t =
*gpa,
>>                             size_t *len, bool is_write)
>>  {
>> @@ -111,15 +138,16 @@ static inline int kvm_copy_to_gva(CPUState *cs, =
uint64_t gva, void *buf,
>>      return kvm_gva_rw(cs, gva, buf, sz, true);
>>  }
>>  -int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>> +static int do_initialize_xen_caps(KVMState *s, uint32_t =
hypercall_msr)
>>  {
>> +    int xen_caps, ret;
>>      const int required_caps =3D KVM_XEN_HVM_CONFIG_HYPERCALL_MSR |
>>          KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL | =
KVM_XEN_HVM_CONFIG_SHARED_INFO;
>> +
>=20
> Gratuitous whitespace change.
>=20
>>      struct kvm_xen_hvm_config cfg =3D {
>>          .msr =3D hypercall_msr,
>>          .flags =3D KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
>>      };
>> -    int xen_caps, ret;
>>        xen_caps =3D kvm_check_extension(s, KVM_CAP_XEN_HVM);
>>      if (required_caps & ~xen_caps) {
>> @@ -143,6 +171,21 @@ int kvm_xen_init(KVMState *s, uint32_t =
hypercall_msr)
>>                       strerror(-ret));
>>          return ret;
>>      }
>> +    return xen_caps;
>> +}
>> +
>> +int kvm_xen_init(KVMState *s, uint32_t hypercall_msr)
>> +{
>> +    int xen_caps;
>> +
>> +    xen_caps =3D do_initialize_xen_caps(s, hypercall_msr);
>> +    if (xen_caps < 0) {
>> +        return xen_caps;
>> +    }
>> +
>=20
> Clearly here the code would be simpler here if you just saved the =
value of hypercall_msr which you have used in the call above.
>=20
>> +    if (!hyperv_enabled && (hypercall_msr =3D=3D =
XEN_HYPERCALL_MSR_HYPERV)) {
>> +        hyperv_enabled =3D true;
>> +    }
>>        /* If called a second time, don't repeat the rest of the =
setup. */
>>      if (s->xen_caps) {
>> @@ -185,6 +228,9 @@ int kvm_xen_init(KVMState *s, uint32_t =
hypercall_msr)
>>      xen_primary_console_reset();
>>      xen_xenstore_reset();
>>  +    xen_vmfd_change_notifier.notify =3D xen_handle_vmfd_change;
>> +    kvm_vmfd_add_change_notifier(&xen_vmfd_change_notifier);
>> +
>>      return 0;
>>  }



