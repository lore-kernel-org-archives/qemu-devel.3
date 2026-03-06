Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D9F01821
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySpR-0007yP-6h; Fri, 06 Mar 2026 05:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySpJ-0007mk-61
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySpH-0008TY-GQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772794474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2J7yrP7K6ql0nVObH6p1+KWN6oROw76uvlCKXfBMSE=;
 b=WRQ4FXgAgFzg+ibuedkDGlarJyhnPnjBv6hqrF+YvnaarXuV6Vkp7QvNABNtMiUT9Y1zjm
 2CihMxHHhp1EYHiC4vB83nsPTHDetMYuJtRB3ubHA4CQ616BkvxIKe9GaDhp9FNhY3lYFW
 IwJ8sDcFR/J7S5uyI/qtWg37w//fQiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-4q8GCp4gN0y09Ur6g99i6g-1; Fri, 06 Mar 2026 05:54:33 -0500
X-MC-Unique: 4q8GCp4gN0y09Ur6g99i6g-1
X-Mimecast-MFC-AGG-ID: 4q8GCp4gN0y09Ur6g99i6g_1772794472
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48069a43217so91045885e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772794472; x=1773399272; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=K2J7yrP7K6ql0nVObH6p1+KWN6oROw76uvlCKXfBMSE=;
 b=SfRtwXHtkxgB2XyAUWUeB36eP4pJog9StIqm7xfeZcOtaAq0cMMwcc04GGFlMQSGFO
 kTksRxnBxncDmE7g94OZBzHU9H83AWtUzW1Xx/KjaGmnS06k6ujUlDOFZ21O4KnDVPO+
 k6CZkWmABSWaC35UiWg0MPcrxtAI7Gq1NZUT8o2K5S0HphETEbxwPH1nvXm4fgeas7yP
 nRWeUBo3pjFU+KpfqYkm6GxK4jio7RI6FfMZ3BOrzWMegE8uzah5tslCXWNpQhsdgZvs
 pWRzwxB+Tc1Cdn4XMb1t8lTRlTgRT4V8ZxAx8r5yBqz/eCEjgphEr90IcfKUArq4zgVb
 G0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772794472; x=1773399272;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2J7yrP7K6ql0nVObH6p1+KWN6oROw76uvlCKXfBMSE=;
 b=cyA9bvD7c8iM9BlVZ2zqmdLIFUVyHdA2CcQ9BXKd0SYVtIHrNsW9gQMgybW8BhXbJM
 bVulunS6r6WikLNyvk6osEmtxj5E7VdXyZbTJAeTb3ehmbG6h8+319sHAEe00LR8Zeav
 JohQDTAvo3rWoXcYzJZZTX4WvRC0Tk4a/97SBYEMKe6SugUxPFbL30qSlheTJ7F6L1an
 7RK4ocPEfy/Oy9WomaLp703WOEwPV7JiYIfsmGwZLqTdnbE0EdiA/FZFCh/Q1Y/aP/DV
 Rp8nO7Q2uRk26R9GZDqFryO7Ai4/lcxW3EmZBa3Dvimvyt5pkAVfJ1SiyywJEi/uDa8v
 K+mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVbnUwoUObgp51jKWo8s6IMs4hSKe+t9nMyKytScPXT265Lfit7iNcan7cTngpXtYfgcu8C4Q40G+F@nongnu.org
X-Gm-Message-State: AOJu0YzureAmafQ3lCs6ACYlOS77+UnB5gqRT7JPdUEpo0fiqGWlBAzn
 pxjN0W8gxEppaDykJYA9CBVU5nwKqMmRcPNvDcO3ObCSKBkcIEbhX9hH40d+SAnjcB7/0+7w0BK
 AvNOKMEvL6frpyTgf8UROOs3JttaCgqggyEYmWvDIRV6AP5rDYLAIyQJM
X-Gm-Gg: ATEYQzw1a/WKH7YFPInH+T8owDSc9bmyGRBm1ZP2OxurB3LwayE2VaFZ3ZGBYsJ6ZLX
 LOhQ9ArSgmO75ogG+m3TdbJGkmdY5mvXWjRFxBBpn32ZhenMkt7DjdiTI8mb/cSeMacGjOxvaSK
 9IbvRX/nJVfi+sNqsYTyawgksg/V/BKlKRbnfZ4iPVHOviBqft3rW8WFNxUmUR8HvSiJShlKAOv
 UKnNX8z2WVJgMg6BO+bc5Y2p5A9jzrfej7GF7702H5Fj4sNOijN5MP9YWy/mzQzqvvBkTlRBYp3
 VwKqxZmfzMcA+Ek7KpDmlD5nxXrgGXBEtxOEk3MtNAWFqactDGw+2TKlT/ZkwVgB+L3y2JHPUqZ
 2dcP87syAWSkE5M8MmYPV+HF3VG7r7YsUE6Pqv63KbO+FOPAQ5DDjcizLKGD4Jqjga/aU
X-Received: by 2002:a05:600c:138a:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-485269196ffmr27190765e9.5.1772794471860; 
 Fri, 06 Mar 2026 02:54:31 -0800 (PST)
X-Received: by 2002:a05:600c:138a:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-485269196ffmr27190435e9.5.1772794471429; 
 Fri, 06 Mar 2026 02:54:31 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm2781144f8f.6.2026.03.06.02.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 02:54:31 -0800 (PST)
Date: Fri, 6 Mar 2026 11:54:29 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 3/6] target/arm/cpu64: Mitigate migration failures
 due to spurious TCR_EL1, PIRE0_EL1 and PIR_EL1
In-Reply-To: <20260304102249.1963784-4-eric.auger@redhat.com>
Message-ID: <14fca05b-b07b-e44a-dc01-76bafa087d61@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-4-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463806286-1495611457-1772794471=:10135"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-1495611457-1772794471=:10135
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 Mar 2026, Eric Auger wrote:

> Before linux v6.13 those registers were erroneously unconditionally
> exposed and this was fixed by commits:
> - 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace when
>                 disabled for guests")
> - a68cddbe47ef ("KVM: arm64: Hide S1PIE registers from userspace
>                 when disabled for guests")
> in v6.13.
>
> This means if we migrate from an old kernel host to a >= 6.13 kernel
> host, migration currently fails.
>
> Declare cpreg migration tolerance for those registers.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>



> ---
> target/arm/cpu64.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d6feba220e8..4cfddc6e8c0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -810,6 +810,31 @@ static void aarch64_a53_initfn(Object *obj)
>     define_cortex_a72_a57_a53_cp_reginfo(cpu);
> }
>
> +static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
> +{
> +    /*
> +     * Registers that may be in the incoming stream and not exposed
> +     * on the destination
> +     */
> +
> +    /*
> +     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
> +     * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
> +     * when disabled for guests")
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +    /*
> +     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
> +     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
> +     * S1PIE registers from userspace when disabled for guests")
> +     */
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
> +                                     0, 0, ToleranceNotOnBothEnds);
> +}
> +
> static void aarch64_host_initfn(Object *obj)
> {
>     ARMCPU *cpu = ARM_CPU(obj);
> @@ -822,6 +847,7 @@ static void aarch64_host_initfn(Object *obj)
> #endif
>
> #if defined(CONFIG_KVM)
> +    kvm_arm_set_cpreg_mig_tolerances(cpu);
>     kvm_arm_set_cpu_features_from_host(cpu);
>     aarch64_add_sve_properties(obj);
> #elif defined(CONFIG_HVF)
> -- 
> 2.53.0
>
>
---1463806286-1495611457-1772794471=:10135--


