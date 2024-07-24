Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA65BC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWdW7-0000Ql-5H; Wed, 24 Jul 2024 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWdW2-00008U-AP
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 11:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWdVz-0000Xb-AS
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 11:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721833369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoge/yJFeeViXjSex+u5bq32QmDqGoP9ZYclm6j+h44=;
 b=GsD+aBYIzJK8nnLyFlnp1m5QbGy1JV4dA97Glx0T32lR7aDKSB3293oVbZzoQ5vokGkSkr
 f4j0B36o6nHpJkBBoKLf2klp2JbnG21pvH8pEt5QczsROTISNUXRbvp5l715PhrdIqzKsI
 SZ/i5nSC1xdomIE7j/mHeTefXR7e8LI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-oCiTokiCNr6PdQTQTi3-lA-1; Wed, 24 Jul 2024 11:02:47 -0400
X-MC-Unique: oCiTokiCNr6PdQTQTi3-lA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef2a44c3dfso36174491fa.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 08:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833363; x=1722438163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoge/yJFeeViXjSex+u5bq32QmDqGoP9ZYclm6j+h44=;
 b=E2hHCoxvqgeCXnnft9XBrVFnZpuCBRVPXBeRVrXAhrQ5MtJ4dEKOOsYGfkFB77zjCo
 r311BTLKHRWIpt6ZUta8nKULyyTFm7KfJOs6ecN/WzPWduRiyyJaLUIbEHOHFPEJWcZr
 gSJ1klxPYuZpo6BvChlMjmQNsaNJUAGyt9iyEwZ1WHk9N/JF9lb23r47Gtryb6naNgmj
 CNxE5y0AZcBw7zGEa9nJvKWrrd3si9Lq/5bsXFocp86O/cawvsO0yksryloy0uertdVL
 COY2uWdXmDs5XZWWN2PwrzYnG9IkY2A7zeCA4ZftPsf8udUsu3XZYSwwnJhWXdFdydzq
 sUBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ogDmpcl71itz4XcT/pMjHPz/Sx6uoPwXiS3kFqm5fiaEb9A9/v/DnNtllcmHj5bAE9aj4G0pA4VDLhYJptgcMuUPIIY=
X-Gm-Message-State: AOJu0Yy0ssyFwny+n0BwySfCy6jyh+0XAJiwNTodK+nme7yTR7RVHFn/
 8qd2oe9+Il8Laon2HB0AhBFIgIeZJ03rDVptSvTw2dYjwB9rEVeoepwE/IIybTQxHLyRYk/7Gni
 pJc+SsUUbgGzYZa70bd4Q787WiHkGf9b04stfoz8HA8WfZkYvbu9v1EaIqbeCgBnlZVD9BTddzd
 Vwn+hjt4rdCQQuEl5IPkhGLlZ2Ymg=
X-Received: by 2002:a2e:b177:0:b0:2ef:2e59:11dc with SMTP id
 38308e7fff4ca-2f039ea7e78mr473131fa.25.1721833361937; 
 Wed, 24 Jul 2024 08:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz21slK5EjDe5XNiZaFmx/2TgdS8UQyCtQItTYlVoejwIOUapJGaRf7U/R2/HBOVDs7AueJD6OaQoGJlbCvbY=
X-Received: by 2002:a2e:b177:0:b0:2ef:2e59:11dc with SMTP id
 38308e7fff4ca-2f039ea7e78mr472811fa.25.1721833361454; Wed, 24 Jul 2024
 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240724080858.46609-1-lei4.wang@intel.com>
In-Reply-To: <20240724080858.46609-1-lei4.wang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 24 Jul 2024 17:02:28 +0200
Message-ID: <CABgObfYHK+N68pOamxA4nT6iZUvEDeUN-AkNwEE9jgnig3AfNw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Raise the highest index value used for any
 VMCS encoding
To: Lei Wang <lei4.wang@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Xin Li <xin3.li@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 24, 2024 at 10:09=E2=80=AFAM Lei Wang <lei4.wang@intel.com> wro=
te:
> Because the index value of the VMCS field encoding of Secondary VM-exit
> controls, 0x44, is larger than any existing index value, raise the highes=
t
> index value used for any VMCS encoding to 0x44.
>
> Because the index value of the VMCS field encoding of FRED injected-event
> data (one of the newly added VMCS fields for FRED transitions), 0x52, is
> larger than any existing index value, raise the highest index value used
> for any VMCS encoding to 0x52.

Hi, can you put together a complete series that includes all that's
needed for nested FRED support?

Thanks,

Paolo

> Co-developed-by: Xin Li <xin3.li@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> ---
>  target/i386/cpu.h     | 1 +
>  target/i386/kvm/kvm.c | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c6cc035df3..5604cc2994 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1192,6 +1192,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU =
*cpu, FeatureWord w);
>  #define VMX_VM_EXIT_PT_CONCEAL_PIP                  0x01000000
>  #define VMX_VM_EXIT_CLEAR_IA32_RTIT_CTL             0x02000000
>  #define VMX_VM_EXIT_LOAD_IA32_PKRS                  0x20000000
> +#define VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS     0x80000000
>
>  #define VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
>  #define VMX_VM_ENTRY_IA32E_MODE                     0x00000200
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index b4aab9a410..7c8cb16675 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3694,7 +3694,14 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, Fea=
tureWordArray f)
>      kvm_msr_entry_add(cpu, MSR_IA32_VMX_CR4_FIXED0,
>                        CR4_VMXE_MASK);
>
> -    if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALING) {
> +    if (f[FEAT_7_1_EAX] & CPUID_7_1_EAX_FRED) {
> +        /* FRED injected-event data (0x2052).  */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x52);
> +    } else if (f[FEAT_VMX_EXIT_CTLS] &
> +               VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
> +        /* Secondary VM-exit controls (0x2044).  */
> +        kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x44);
> +    } else if (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_TSC_SCALI=
NG) {
>          /* TSC multiplier (0x2032).  */
>          kvm_msr_entry_add(cpu, MSR_IA32_VMX_VMCS_ENUM, 0x32);
>      } else {
> --
> 2.39.3
>


