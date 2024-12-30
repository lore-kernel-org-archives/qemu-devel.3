Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AE1E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSIND-00031D-Ia; Mon, 30 Dec 2024 11:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSIN6-00030Z-R3
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 11:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tSIN3-0006T1-8X
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 11:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735575114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YzLROMrkgk4neC5wsMzQj5+FEVSM5rqMUkXccS3RMqA=;
 b=Z2pD4NQpuQmM/ZT3mB3Oxometwxg6YAPLvmCD1l1jiYbaIwZBxYQj028NNlN/2MnQYfH5h
 WPcriFPU4wa5yJQaxTGUsP5Jl59VAHTYhxceSptsKi+ZZ3rmop+YMJtv+e3aGe6GPTCPJJ
 budNh5YhW/h3QhdgU3i40+uRC15xKQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202--Ec_DXXOO3SzotBXLiV-Fw-1; Mon, 30 Dec 2024 11:11:53 -0500
X-MC-Unique: -Ec_DXXOO3SzotBXLiV-Fw-1
X-Mimecast-MFC-AGG-ID: -Ec_DXXOO3SzotBXLiV-Fw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so1189117f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 08:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735575112; x=1736179912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzLROMrkgk4neC5wsMzQj5+FEVSM5rqMUkXccS3RMqA=;
 b=QtQxPS66nsaBALPLTBRmDAJib38rqi5zcvmAqE5esRZsiHGzFRH3TJ8ICan/W/kZl9
 kQDnZHhYM/SwltuV4dcLUTfBfmK0IwtiKo785P7KCMAc61B7SaREl+XUbbcIHGKgXy40
 i9VQZY6S/jSvaF5J3Wq91sw8Q8opXP52I5bBfPrgBbbe3svN42E4Wtk3u7fuJ7+kU1cv
 4XEOzTM0y/S3R3Yn4V5+lG++ZaMtIAAKbpyLw9dMHowaxg0cJiif6Tnmv3E4u4L9AcWg
 B+LB/gSurvDCqPmlLLmrpX/L1KceFnJjKwMq68maeVb28WdWO9eqDR7RBzlmrM+Ia3de
 Jw7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaxUGryin9TIRUIY3DDfjbScvIR6B3KquEyAuAALSZbo6Q//3ADwRyegGHyZm4IhDupmDG4sOnb+3C@nongnu.org
X-Gm-Message-State: AOJu0YypqOJ0eW9FvyMNR98EETuarsd0nsGX4N4Z6WOdychHnXNbD0Z6
 rkR8WDaUqBpD8q/BfDOcuLQUJ2zIRqzlgJIvXMrdzTV8oYXDNwSFwCUmaNxzsDNNW8fqA0LtnDZ
 XdmlNo92PHyGJgFpPMKp8yh+UMsBpOJ9bu45JfqlyD3GMzmFkFzfH
X-Gm-Gg: ASbGncvOEv4358TDHxdsFhYVRPaCwHj1eorHvgLJyKTDmAg9oOcZJTS3sk7TQDf0qyu
 FA0DuVVVQ6mSscxOFAxlVHfRXymwmBccoLWIg1Plx0A/mKbRjfSj9xnke67YXLjRuWEFBKj5dbe
 +A+xNik8aHTtaHVdqZzalHUQkhwN7IMcRMUmHbRVRWaLFCE03CPHNDMPJgAK5LkQSMmwrWNqhW2
 dM2bRmUpyfGCE2EO/SLhNCVA7YbW0FPnZAAByyDdv75Nc+uTbgFins+wQWCilxPeS0QZTywmPoZ
 y15Rxb5f3yb4x4VlbCw8Y1TPJh4E
X-Received: by 2002:a05:6000:481e:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38a2220120dmr32610691f8f.35.1735575111870; 
 Mon, 30 Dec 2024 08:11:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE361I6s+/oIuPBu0fkBcLWyGb/W9DnUKkDjzSS6GNy2toGPTice4MX3pIU2Uixcr5oVBRNyQ==
X-Received: by 2002:a05:6000:481e:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38a2220120dmr32610671f8f.35.1735575111548; 
 Mon, 30 Dec 2024 08:11:51 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8288b8sm30169964f8f.11.2024.12.30.08.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 08:11:50 -0800 (PST)
Date: Mon, 30 Dec 2024 17:11:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 0/4] cpu: Drop CPUState::nr_cores
Message-ID: <20241230171150.5ef181e0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241205145716.472456-1-xiaoyao.li@intel.com>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu,  5 Dec 2024 09:57:12 -0500
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> The series is motivated by auditing the usage of CPUState::nr_cores and
> CPUState::nr_threads, which is motivated by [1].
> 
> The initial goal is to initialize nr_threads and nr_cores earlier for
> x86, which leads to patches [2] and [3]. Patch [2] touches all the ARCHes
> and patch [3] looks hacky. At last Igor suggested to audit nr_threads and
> nr_cores, and only set them in the pre_plug() callback for the ARCHes that
> really need them[1].
> 
> By audting nr_threads and nr_cores, I found nr_cores is only used by
> x86. So we can introduce a x86 specific one and initialize in
> x86_cpu_pre_plug(), then drop nr_cores totally.
> 
> However for nr_threads, it's used by MIPS and PPC as well[4]. There are
> two options:
> 1. maintain separate substitute in X86/MIPS/PPS, so we can drop
> CPUState::nr_threads like for CPUState::nr_cores.
> 
> 2. keep CPUState::nr_threads and find place (or introduce pre_plug()) to
> initialize them earlier for MIPS/PPC.
> 
> I would like to seek for opinions for which one is prefered. 
> 
> This series implments the drop for CPUState::nr_cores. Though it doesn't
> help on the initial goal without the solution for nr_threads, I think it
> is still a good cleanup?
> 
> BTW, by initializing nr_threads and nr_cores earlier than
> qemu_init_vcpu(), it also unblocks [5].

With minor fixes included mentioned during review

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
> 
> [1] https://lore.kernel.org/qemu-devel/20241125103857.78a23715@imammedo.users.ipa.redhat.com/
> [2] https://lore.kernel.org/qemu-devel/5f8db586-cdda-4d00-be02-f9880a20e1a3@redhat.com/
> [3] https://lore.kernel.org/qemu-devel/20241122160317.4070177-1-xiaoyao.li@intel.com/
> [4] https://lore.kernel.org/qemu-devel/045f9cb1-2b17-4b2c-985f-3c34e3626b36@intel.com/
> [5] https://lore.kernel.org/qemu-devel/20231128171239.69b6d7b1@imammedo.users.ipa.redhat.com/
> 
> Xiaoyao Li (4):
>   i386/topology: Update the comment of x86_apicid_from_topo_ids()
>   i386: Extract a common fucntion to setup value of
>     MSR_CORE_THREAD_COUNT
>   i386: Track cores_per_module in CPUX86State
>   cpu: Remove nr_cores from struct CPUState
> 
>  hw/core/cpu-common.c                 |  1 -
>  hw/i386/x86-common.c                 |  4 +++-
>  include/hw/core/cpu.h                |  2 --
>  include/hw/i386/topology.h           |  5 +++--
>  system/cpus.c                        |  1 -
>  target/i386/cpu.c                    |  2 +-
>  target/i386/cpu.h                    | 16 ++++++++++++++++
>  target/i386/hvf/x86_emu.c            |  3 +--
>  target/i386/kvm/kvm.c                |  5 +----
>  target/i386/tcg/sysemu/misc_helper.c |  3 +--
>  10 files changed, 26 insertions(+), 16 deletions(-)
> 


