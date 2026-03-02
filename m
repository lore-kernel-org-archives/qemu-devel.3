Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EB3EB362A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 18:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx86U-0001qV-OL; Mon, 02 Mar 2026 13:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx86Q-0001pg-BN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vx86K-000221-0l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 13:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772476467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzFZ0rIRKNTUJLwLhW4dYH6YvnevBdHAWrMUCI3xZgE=;
 b=b3iEetDNzsoBgh1wLKd2ViQJlskpZHsMDsU5IAR5iwiYOC/h0bYo/Mdqlon0jNs8i4vg39
 vG6sFkpDBNuPg6Ef/wECw7LYJauEftQ+4TzhbU8Mhe+RWUunBAYOS5CchCvwXazc6shpFz
 NXDXdJ0k8Lj1yqbt68Asx9YLf8l1ne4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-kB-EFSv8OZGT4TtPdE_4Tw-1; Mon, 02 Mar 2026 13:34:26 -0500
X-MC-Unique: kB-EFSv8OZGT4TtPdE_4Tw-1
X-Mimecast-MFC-AGG-ID: kB-EFSv8OZGT4TtPdE_4Tw_1772476465
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so34416935e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772476465; x=1773081265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzFZ0rIRKNTUJLwLhW4dYH6YvnevBdHAWrMUCI3xZgE=;
 b=ARxfR9fK4JY/zD5NIUygLt4UIxczSR6bT06ex3eoVoNntEtWKEo67aaUmYIEpDxnly
 Ym7jNpEPKNjhyTPzYakinEGUF78S1oU4c771P4Jm8gNu3upB/FTl3WRTnqvL2e9ZehBq
 J6WnzXWZQ9QwwUiL0FexVevPQG0k6+0fbNYsbW/qNt1XwHno9DZ8q5pj02ILopPqEFyB
 jE2Q/rFwW/tabBIOgf/c19DKjwW6VQ8kDEaQes/K2FAYgzI1N+qtfAQc1yjs1/6n7Ces
 MCJusS2Tfx93YR463RpOHdjJGa/KWFzCozAtfYFHb7pXLsfoULBatG6yJJXM1Bm/NSUV
 OQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772476465; x=1773081265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzFZ0rIRKNTUJLwLhW4dYH6YvnevBdHAWrMUCI3xZgE=;
 b=FznWImLnpXZbMv62YBSK0PLJ7joH7bo0epbe2stEFdwbaapOKo6utO6W4GsYUp0pXm
 tOhQ3oOKWCOf78ZCr7Uyfa4YfTDTkDc3r9cpr+T0DBepg9QC6ycl3PzoNurxpO+v+4nX
 6SozKlz6Q2kRkE4DLY5+bAxnoYINRolaM9Kh/4C2zOP1+CYcWiifv6tH7ZFoDUuqLGqQ
 zx5KqQ9C2zp/5Y6Q7V+oiJArrGN4JvHrbYWrLqGw1lv+uFgtZUln3e6KWWTUy3se5I8E
 bU/LkH0t7kbzZvA4sjyz7n1l6Ge/f7qdLH6vxTL7bxX8E0BcIwKKsxfr288XKNSjNcRB
 jZdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqQU8Pm/jpmBvuEkSametaJm9O5RC78gY88NJD4SfOsLCvwK+zv6aDcvTwBYxjK10wXb+J3UXluwtK@nongnu.org
X-Gm-Message-State: AOJu0YxMnkibZSi7dT2rqpDbh4K/R9lkTaQSVYFhSEAFlHKgIlbIh5cV
 aZqEdDBbTCZ+g2DBDsK/lmFP41NP09ode+BfsWIlL6omZZyxDlvDLWgNtAoWp1H293ArXevX5Ri
 eHTi1ZomA8QErSFk8lSps995cMNt8I/C4f9NzZbHDWB3VL2VuXJmckvSd
X-Gm-Gg: ATEYQzzVBUXPg9ba1UP5iqSwFkHHzzVmf1QqaRULz+31u6a5vzs0Qps4dJPzrzA5sn1
 uXKjRxkqJqOjdU23o6BXPO/ciTjrDl0zuY851PBB//+GOvj5PL1Ke5uJaysrElnw9bBT577X90U
 9Km4BI4akw68awRsPGI6V3LsrwCBt8UforNHygjRhRZI/q52nJ1vNT5klR3jcSp6duMSferUH5g
 6Nh0CSUguAWN98gg/XqAI1x8UQ8Vmlk4edX9gxC7S5udvVFeLJPJytASp/AZQf7nXKzlvQyQnI9
 Ct63tgAEl0lGEfOl7MyDqLlKYbR1LeUevmSKud5D13MGHUCFt5zLNK9d3AooHC/MY4pshHuQ1dH
 aKyLqM4Lhjxq5UY5A+8xNyp0Hh8rPmSh+h8xQRTITsWE5NvGpux4pMXlbVEzeUjOLysc+STzBQK
 y0h1d84Z0bgYWm4Jh8vjqYEzj1ROU=
X-Received: by 2002:a05:600c:6309:b0:480:426e:9d38 with SMTP id
 5b1f17b1804b1-483c9bc5b70mr224255045e9.27.1772476465029; 
 Mon, 02 Mar 2026 10:34:25 -0800 (PST)
X-Received: by 2002:a05:600c:6309:b0:480:426e:9d38 with SMTP id
 5b1f17b1804b1-483c9bc5b70mr224254615e9.27.1772476464590; 
 Mon, 02 Mar 2026 10:34:24 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm687655225e9.0.2026.03.02.10.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 10:34:23 -0800 (PST)
Message-ID: <aa442c69-5dd5-4a3a-b42a-299a30aab881@redhat.com>
Date: Mon, 2 Mar 2026 19:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Support QEMU cpu models in MSHV accelerator
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Magnus Kulke <magnuskulke@microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On 2/11/26 16:54, Magnus Kulke wrote:
> Hey all,
> 
> In the current MSHV accelerator code passing CPU features via the -cpu
> flag doesn't work as intended yet. When using the MSHV hypervisor we
> either silently discard the specified model/features and leave it up
> to the hypervisor to provide a sensible set of features or if the user
> selects -cpu host, the hypervisor might refuse to create a partition.
> 
> This changeset introduces a more comprehensive support for passing
> desired guest cpu features to the hypervisor. It's also a prerequisite
> for Live Migration support, in which we have to roundtrip CPU State
> explicitly
> 
> Known issues:
> 
> We will probably have to iterate a bit more on this, since recently
> support for CET_U/CET_S xstate bits has been introduced in QEMU, which
> doesn't harmonize with our current approach of configuring the
> hypervisor with static responses to cpuid queries.

Hi Magnus,

I went back to reviewing this series.

More or less, using "-cpu host" should work because MSHV already runs in 
a partition.  Therefore, it should be safe to assume that whatever bits 
were allowed in the current partition's CPUID will also be allowed in 
the nested guest.

However, you still need to mask the features corresponding to MSRs that 
you do not save/restore; this includes for example TSC deadline timer, 
AMX (XFD), FRED, PMU, UMWAIT are the first few that came to mind.  Or 
alternatively, just add them to get/put_msrs.

Later on, we probably want to share some of the code to handle MSRs 
between Hyper-V and KVM.  Please add some comments about the hypercalls, 
since they are poorly documented, explaining how to find out which MSRs 
are supported by the hypervisor.

With respect to live migration, here are a few bits of states that 
should be migrated:

- the FPU registers (MshvFPU is dead code and can be removed; I missed 
it during my initial review).

- the PDPTRs.  That is probably okay (because you never set nor read 
env->pdptrs_valid) but please check if Hyper-V supports reading them.

- KVM also has support for migrating in the middle of an exception being 
delivered (for example if an EPT violation happens due to a write to the 
stack); this is handled with fields such as these:

         VMSTATE_UINT8(env.exception_pending, X86CPU),
         VMSTATE_UINT8(env.exception_injected, X86CPU),
         VMSTATE_UINT8(env.exception_has_payload, X86CPU),
         VMSTATE_UINT64(env.exception_payload, X86CPU),
         VMSTATE_INT32(env.exception_nr, X86CPU),
         VMSTATE_INT32(env.interrupt_injected, X86CPU),
         VMSTATE_UINT8(env.soft_interrupt, X86CPU),
         VMSTATE_UINT8(env.nmi_injected, X86CPU),
         VMSTATE_UINT8(env.nmi_pending, X86CPU),

please check how Hyper-V handles this situation so that it can be 
implemented in QEMU as well.

Thanks,

Paolo


