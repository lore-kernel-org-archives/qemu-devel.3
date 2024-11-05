Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA43D12671
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8GGV-0005yX-SJ; Tue, 05 Nov 2024 04:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8GGN-0005yA-GF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8GGL-0007EA-Gd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730800451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLK8CGodL7ScRszYLizC0fSmOUX6I2Ja8rM/oIftHTU=;
 b=FDKSgLVij5Gtwg2FurOCc8N2qrBQJdQRHBI9+CugLx+Bo825SRuuTYQEJpOl551WaDQCA+
 13TuGGr2gklu8Q/Wesj223CmGxsJDOcDVY2gMISCePPdKJ5hMKrQyfeGDBDLZqqDyXMM1e
 pTKjjBVhjUIpIgdsRUHerRSBA4YeuBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-YgDzi1uwMNajxSbEBpd0BQ-1; Tue, 05 Nov 2024 04:54:09 -0500
X-MC-Unique: YgDzi1uwMNajxSbEBpd0BQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso34763685e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730800448; x=1731405248;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLK8CGodL7ScRszYLizC0fSmOUX6I2Ja8rM/oIftHTU=;
 b=pSIcSz2DahhkPHKinrEYhUMVT1yr7FIjoYEN+50rQ4p8A3UOqOkaE6R5J7NSyJdG0g
 OfGFNNnZ1RZFRqtwocDHFceOANY0Ixd3+TA84f2aIZxUosKm7pa1BU9BLSHZTU8Wuri/
 Ho0VSjULtdfpGaIH5Lg9pg97nw55oeWyZpv5cQvxQGqruDUVg7f5+C7qag0Zm9d46kDr
 /PdL4FtdF/xHBZByIqhKjnZNIVfMui2wdKSSIXYwE1jt7g3z9KbUMurOzU3JDBxYIuyz
 gQ/MqYvPWKt4cfoENM8dTrMxRd2f3jkiUdRZztkzkXAlgtA3plPGHLhTN9JEWLc8t6t/
 7q4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9qxl2PsdDJeQaViy0QO1CSSLvbYcUzTIeOS25OAiAIfI0IBEZr/NclvBmuM035xfcLvwvujxQqoM2@nongnu.org
X-Gm-Message-State: AOJu0Ywf1MI1LS5We43NfvvSzFDz2CaRMY/wQztg6Rf6JNCRGJ2xhjNs
 mA2tXtiTx8l6LaO19fN4PzdL93hgFPgl0OlK8N0F/pnJzxd8dKPW4HP5QRX3o6TunxTlqw673ur
 FbW3/GD+CD0sQVYjIzWcw60X1UOpFW1hHyiL1h9O3wqpTvZzG8yXreDHCPe+Q5Pnx1Tevp6yWqQ
 Q+0p5BwAmTqsyqK0d2mTpnFYHpRWY=
X-Received: by 2002:a05:600c:450d:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-4328327e02cmr123290675e9.24.1730800448570; 
 Tue, 05 Nov 2024 01:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrChRQ/ANVarKuoF1a5YBsEYToVHl9GfWnLHSr4UjYEhuQT5OIeXUXcDgIqDDfSOWWLHjauEoFpQ+GOgeBvLI=
X-Received: by 2002:a05:600c:450d:b0:431:4a5a:f09a with SMTP id
 5b1f17b1804b1-4328327e02cmr123290405e9.24.1730800448232; Tue, 05 Nov 2024
 01:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-60-xiaoyao.li@intel.com>
 <9601f5a1-f1f1-47ab-a240-30331946b584@redhat.com>
 <08939cf7-f27b-44c2-93cf-d0951d2d2141@intel.com>
In-Reply-To: <08939cf7-f27b-44c2-93cf-d0951d2d2141@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Nov 2024 10:53:55 +0100
Message-ID: <CABgObfZVxaQL4FSJX396kAJ67Qp=XhEWwcmv+NQZCbdpfbV9xg@mail.gmail.com>
Subject: Re: [PATCH v6 59/60] i386/cpu: Set up CPUID_HT in x86_cpu_realizefn()
 instead of cpu_x86_cpuid()
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Nov 5, 2024 at 10:33=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 11/5/2024 5:12 PM, Paolo Bonzini wrote:
> > On 11/5/24 07:24, Xiaoyao Li wrote:
> >> Otherwise, it gets warnings like below when number of vcpus > 1:
> >>
> >>    warning: TDX enforces set the feature: CPUID.01H:EDX.ht [bit 28]
> >>
> >> This is because x86_confidential_guest_check_features() checks
> >> env->features[] instead of the cpuid date set up by cpu_x86_cpuid()
> >>
>
> It seems I mixed it up with no_autoenable_flags. /faceplam
>
> CPUID_HT doesn't get enabled by x86_cpu_expand_features() for "-cpu
> host/max". It won't be filtered by x86_cpu_filter_features() either
> because QEMU sets it in kvm_arch_get_supported_cpuid().
>
> yes, the comment is wrong and comment needs to be dropped. The code can
> be move up to just below x86_cpu_expand_features() or inside it?

Inside it seems okay, and you can then remove it from cpu_x86_cpuid().

However, let's also add qemu_early_init_vcpu() to the realize function
from all targets, and remove

    MachineState *ms =3D MACHINE(qdev_get_machine());

   cpu->nr_cores =3D machine_topo_get_cores_per_socket(ms);
    cpu->nr_threads =3D  ms->smp.threads;

from qemu_init_vcpu(). You can resend patches 58 and 59 separately
from the TDX series.

Paolo


