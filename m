Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D5CC6B26
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGss7-0001ez-1X; Wed, 14 Oct 2026 02:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xGss3-0001ec-3O
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xGss1-00012T-5P
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791960827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czt/qOysANKgcz8VTnlhYA0mfWkzn+0Uye0Xy6rtics=;
 b=Z2BDsAroIRVE4MrnGVKHRGQEdB+6NjSO6IXvJoXprptmX8iJnr5DSdboBH0Ddv/8Y6b8Kh
 3Cy9cxEgiVlwRoMBB24cfWP0DaEGPwVbO20q48MIe+h18acIjablK8UXDRNKYgf/E7jfCZ
 2+jDEHNKv02+aPiUyjGyCG5zljbr1gU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-rhU8NCopOGSOMBb83pZ1Kg-1; Wed, 14 Oct 2026 06:53:45 +0000
X-MC-Unique: rhU8NCopOGSOMBb83pZ1Kg-1
X-Mimecast-MFC-AGG-ID: rhU8NCopOGSOMBb83pZ1Kg_1791960824
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01ba12198so45157715e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 23:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960824; x=1792565624;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=czt/qOysANKgcz8VTnlhYA0mfWkzn+0Uye0Xy6rtics=;
 b=mQX0R2DouiZTzZm3BKJDJaegEvRwEGc9CTzhKCl8BkuWwtj6kTX+b5fOfalBLfVk+9
 mbvXe5rhnyHuRwvINY/cRpnDblBtVPo6ZuK5z3cZP1Nd20YlGLyAo1bt3uDzfwux6TwO
 u+Rm4R2APTJxnJgpv3yfJz3ky7owKX+PNd423282O/ewnBl2Z+jcm5GaBzwYYX/5f6dq
 ciAEYeNM8ZKKzXTImlmr/uOF+uM8ZS1Vh8qqkOl6IGbEO4Rf56vfeZlTmq4No7RZQDZc
 4T5jN4N4s+GhjEobE/plwqlzThwQ+4k+tty5NKB9SpyXxiq/Ff2K0Kz65RUQotJj2nf+
 EVBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNa/dvRM0knfnRUG5CVWcPpExNorbu2AOphdIwe1QGadul6BWeGWWj1OF1vLkupdurWoRtnTKgRru1@nongnu.org
X-Gm-Message-State: AFq9FYJqa1ogfFz0N7OSafzq0+PaBRnAurpz3a07kdFmE6pK9lpOB6rO
 QTr0g7bClTzfwJtgeRwSLvqSZ2irSvXcn85/o1ebBN7xowKMmvKlOWUHwf/d1wlxsadD0zcNIFc
 aFEZ/KBB/CrPhjUEg4cEb9lPG2KvyCptlE6U3oBnmcPkqOD4PId05R1aP
X-Gm-Gg: AYBFou2pFOUgS7svFvLl8aiHERT7DjE74qniWC6MNIAen20ZOpJzY7LPMOkDBWulKQF
 8bwPB29GxDTtSJG9qFZn+y0i6LMli5ok5jKnjCF68xBFi3bIeKhbiBdjSAuBj6nk38gA16WEYhm
 WclsZzu171YooBbTNWMurccMNmH9kEg9tE0X8DtAJDfuTC6fC6m9nu80p5BzPvLJv6eJ0gmSyQ/
 2Y2/lvToy5kFBG1FCIIEdgYU3PqMtubGfllsQ6kiOCZys7Kr1fAfyrQKtAnKozOvZ+qEQnuXVAr
 XuWf9GoQZZe98dkRr5PuCtNVZLa57cLT19YeAg07yn6r82qFvn7pH5KVIwJjeL1SyMj+cPQgYWL
 wKegRYWCO51cnW8D1IpIbzzmNRqc6vP3yuxv8nO8bR5w+EPRG
X-Received: by 2002:a05:600c:810a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a18e3ef100mr273249465e9.0.1791960824312; 
 Tue, 13 Oct 2026 23:53:44 -0700 (PDT)
X-Received: by 2002:a05:600c:810a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a18e3ef100mr273249225e9.0.1791960823849; 
 Tue, 13 Oct 2026 23:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm756380965e9.9.2026.10.13.23.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:53:43 -0700 (PDT)
Message-ID: <2acbe4ab-a5a2-4f21-a861-e43965da6d9b@redhat.com>
Date: Wed, 14 Oct 2026 08:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Deprecate using named CPU models with KVM
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013105147.1070641-1-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20261013105147.1070641-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 10/13/26 12:51 PM, Peter Maydell wrote:
> Currently when using KVM on Arm, the normal thing is to use either
> the 'host' or 'max' CPU types, both of which give the guest the same
> CPU as the host.  We also for legacy reasons allow 'cortex-a53' and
> 'cortex-a57' CPU types, which will only work when the host CPU is
> exactly that matching CPU.  This is because the original idea of the
> KVM ABI was that userspace would request a particular CPU type by
> setting the target field in the KVM_ARM_VCPU_INIT ioctl to an
> appropriate KVM_ARM_TARGET_* constant.  However, it quickly became
> clear that this was a bad idea, and now everything uses
> KVM_ARM_TARGET_GENERIC_V8; the tiny number of existing CPU-specific
> target values behave identically to GENERIC_V8 except that they will
> only work if the host CPU matches them.
>
> Future support for "show the KVM guest a CPU type that's not
> identical to the host" is going to work by telling it different ID
> register values.  Real Cortex-A53 and A57 CPUs are now all over a
> decade old and not in widespread use.  Deprecate the ability to use
> '-cpu cortex-a53' and '-cpu cortex-a57' with KVM, to get rid of this
> odd legacy corner and open up the opportunity in future to support
> named CPU types via ID register settings if we want that.
>
> For any situation where the cortex-a53 and cortex-a57 CPU types
> currently work with KVM, '-cpu host' or '-cpu max' will have
> identical behaviour.  (Though note that if you are using "KVM, but
> fall back to TCG" then the fallback under TCG will be different.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
> Personally I doubt anybody is actually using these named
> CPU types...
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  target/arm/kvm.c          |  7 +++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ccbc4219497..153fe118151 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -234,6 +234,19 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
>  but for consistency these will get removed in a future release, too.
>  Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
>  
> +``cortex-a53`` and ``cortex-a57`` CPU names with KVM on Arm (since 11.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +QEMU currently allows the CPU name to be set to ``cortex-a53`` or
> +``cortex-a57`` when using KVM; this is identical to using ``host`` or
> +``max``, but it will only work when the host CPU is a Cortex-A53 or
> +Cortex-A57.  These CPUs are now over 10 years old, and the ability to
> +use the named CPU type like this is part of a legacy corner of the KVM
> +API, which doesn't work with any other host CPU types. Using these CPU
> +names with KVM enabled is deprecated; use ``host`` or ``max`` instead,
> +which will have identical behaviour on the hosts where using
> +``cortex-a53`` or ``cortex-a57`` works.
> +
>  System emulator machines
>  ------------------------
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 3d905f8565d..de09d63d2e3 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,6 +2015,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return -EINVAL;
>      }
>  
> +    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A53 ||
> +        cpu->kvm_target == QEMU_KVM_ARM_TARGET_CORTEX_A57) {
> +        warn_report_once("Using the cortex-a53 and cortex-a57 CPU types "
> +                         "with KVM is deprecated. Use the max or host CPU "
> +                         "types instead.");
> +    }
> +
>      qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cpu);
>  
>      /* Determine init features for this CPU */


