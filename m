Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1050DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXz39-0006DP-LQ; Wed, 15 Jan 2025 03:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXz38-0006DH-Q0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tXz36-00089V-Cm
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736930807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6uIurpLRMFCMfe6HezrOV/WPAVhPmgVEcPBHpkOKDHg=;
 b=aXRA3m2jDRnEmIhHAxf757JogzU2SBm5x1AEeTT4Ec67vEkFKKDEcQESUQjANpcY0Zb4SA
 B+vr4WVQiQP1aG941/c+JWCHAY7DT5MNxkWqMnnMHGgJQx33Vd3p/MO4tAuH910lp0xcyW
 xkC37Zjb0Fl6XBJNd8hGgDiEKxsz5k4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-ZpnQgwLQOPmo9swfQM_V-w-1; Wed, 15 Jan 2025 03:46:45 -0500
X-MC-Unique: ZpnQgwLQOPmo9swfQM_V-w-1
X-Mimecast-MFC-AGG-ID: ZpnQgwLQOPmo9swfQM_V-w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so48754945e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736930805; x=1737535605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uIurpLRMFCMfe6HezrOV/WPAVhPmgVEcPBHpkOKDHg=;
 b=rS/mFEj9WeEZJSRB0whuaWRv5n0n6QdO5pZ7ywROicEdIxCYw0LVzCK+eigPJ+oq56
 AomcAEp4RIgEYaoQZb/3/LMqOC7uumtFOm3ukBqFfP9Dt+woXMrCjJg9LdJITG4cOooL
 r/wfdIYgVBwIPjXf0mbHQ9vHZ4xLXVIjv1msO5MU4xBZ5xqMtvC3FpDJHZWWO2/6vyDV
 gqkecg0kqG0zsFvngU2mpR8J8Smojbz4+ebInOyzkUwAeBjxAdLqMDOiOC4WvRv24PJE
 njfOC+Yuw4C7YAB6N7ULbTYl55GLXRUZUJNJuykAVa3Qpv44Z3vmjP2mkXfx9g4N1Qkr
 91dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmSGpiGiW2dSG/jD/vczyzVfFGUtZ+6l2BIoJtOa2F2EdbRdR6wY4m02iEep/kEoZCnvrkURLSgUsE@nongnu.org
X-Gm-Message-State: AOJu0YzOADjhSTEvpBFy4CGkSmqkGUxsohscXrDAnXwYPIqpKWwaZ8T7
 ZTcRw4NY3/eQ4VQZdAq77TuFSw8/0zYL1crxgAqnaRprTvuZ2aSnPvSEeblVwZvwPl5vshtRPeM
 Q9ZsE/2ehy95unCjRBTyMyjHqMonkC5I3DfRv6HpFzeSqv/YaG/sl
X-Gm-Gg: ASbGncs0x50lN5Sid+mKugtPop6RlD32CqCINfgG+og+LdeYLm4dZ5wyMaTqr8U60vd
 oVbAoC9DeReU1EaPG3cWx9Qt62EcFkHjGYNA6UvQui966b8uGQUp08V6oX3abN/FdDmQ0ubzr/P
 p05yLJRE9At5AgJpblYQ74Ys7x5DR0HVCNbdaTUxct6uotqCquXHsBQBPI3QRuDwfFTzLgpXL6b
 V5PBaQAbwyyji7pR8Usf5umyDArN6XK9nVuQNAOaE10jmH2IA==
X-Received: by 2002:a05:600c:1d1f:b0:434:f99e:a5b5 with SMTP id
 5b1f17b1804b1-436e271cf4amr210679775e9.28.1736930804660; 
 Wed, 15 Jan 2025 00:46:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxGvE+CDIhSH3P3PgxaDQ/+MCGDWQX7KRPeVqMQKhQyZvKlJZedQEYQ5HUXKL/lwArB29ZQQ==
X-Received: by 2002:a05:600c:1d1f:b0:434:f99e:a5b5 with SMTP id
 5b1f17b1804b1-436e271cf4amr210679545e9.28.1736930804243; 
 Wed, 15 Jan 2025 00:46:44 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:8f43:2a76:9f8c:65e8:ce7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74aaffesm15429435e9.10.2025.01.15.00.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:46:43 -0800 (PST)
Date: Wed, 15 Jan 2025 03:46:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7 RESEND 0/5] i386: Support SMP Cache Topology
Message-ID: <20250115034612-mutt-send-email-mst@kernel.org>
References: <20250110145115.1574345-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110145115.1574345-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jan 10, 2025 at 10:51:10PM +0800, Zhao Liu wrote:
> Hi folks,
> 
> This is my v7 resend version (updated the commit message of origin
> v7's Patch 1).
> 
> Compared with v6 [1], v7 dropped the "thread" level cache topology
> (cache per thread):
> 
>  - Patch 1 is the new patch to reject "thread" parameter for smp-cache.
>  - Ptach 2 dropped cache per thread support.
>  (Others remain unchanged.)
> 
> There're several reasons:
> 
>  * Currently, neither i386 nor ARM have real hardware support for per-
>    thread cache.
>  * ARM can't support thread level cache in device tree. [2].
> 
> So it is unnecessary to support it at this moment, even though per-
> thread cache might have potential scheduling benefits for VMs without
> CPU affinity.
> 
> In the future, if there is a clear demand for this feature, the correct
> approach would be to add a new control field in MachineClass.smp_props
> and enable it only for the machines that require it.
> 
> 
> This series is based on the master branch at commit aa3a285b5bc5 ("Merge
> tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into
> staging").

pc things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> Smp-cache support of ARM side can be found at [3].
> 
> 
> Background
> ==========
> 
> The x86 and ARM (RISCV) need to allow user to configure cache properties
> (current only topology):
>  * For x86, the default cache topology model (of max/host CPU) does not
>    always match the Host's real physical cache topology. Performance can
>    increase when the configured virtual topology is closer to the
>    physical topology than a default topology would be.
>  * For ARM, QEMU can't get the cache topology information from the CPU
>    registers, then user configuration is necessary. Additionally, the
>    cache information is also needed for MPAM emulation (for TCG) to
>    build the right PPTT. (Originally from Jonathan)
> 
> 
> About smp-cache
> ===============
> 
> The API design has been discussed heavily in [4].
> 
> Now, smp-cache is implemented as a array integrated in -machine. Though
> -machine currently can't support JSON format, this is the one of the
> directions of future.
> 
> An example is as follows:
> 
> smp_cache=smp-cache.0.cache=l1i,smp-cache.0.topology=core,smp-cache.1.cache=l1d,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=module,smp-cache.3.cache=l3,smp-cache.3.topology=die
> 
> "cache" specifies the cache that the properties will be applied on. This
> field is the combination of cache level and cache type. Now it supports
> "l1d" (L1 data cache), "l1i" (L1 instruction cache), "l2" (L2 unified
> cache) and "l3" (L3 unified cache).
> 
> "topology" field accepts CPU topology levels including "core", "module",
> "cluster", "die", "socket", "book", "drawer" and a special value
> "default". (Note, now, in v7, smp-cache doesn't support "thread".)
> 
> The "default" is introduced to make it easier for libvirt to set a
> default parameter value without having to care about the specific
> machine (because currently there is no proper way for machine to
> expose supported topology levels and caches).
> 
> If "default" is set, then the cache topology will follow the
> architecture's default cache topology model. If other CPU topology level
> is set, the cache will be shared at corresponding CPU topology level.
> 
> [1]: Patch v6: https://lore.kernel.org/qemu-devel/20241219083237.265419-1-zhao1.liu@intel.com/
> [2]: Gap of cache per thread for ARM: https://lore.kernel.org/qemu-devel/20250110114100.00002296@huawei.com/T/#m50c37fa5d372feac8e607c279cd446da3e22a12c
> [3]: ARM smp-cache: https://lore.kernel.org/qemu-devel/20250102152012.1049-1-alireza.sanaee@huawei.com/
> [4]: API disscussion: https://lore.kernel.org/qemu-devel/8734ndj33j.fsf@pond.sub.org/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Alireza Sanaee (1):
>   i386/cpu: add has_caches flag to check smp_cache configuration
> 
> Zhao Liu (4):
>   hw/core/machine: Reject thread level cache
>   i386/cpu: Support module level cache topology
>   i386/cpu: Update cache topology with machine's configuration
>   i386/pc: Support cache topology in -machine for PC machine
> 
>  hw/core/machine-smp.c |  9 ++++++
>  hw/i386/pc.c          |  4 +++
>  include/hw/boards.h   |  3 ++
>  qemu-options.hx       | 30 +++++++++++++++++-
>  target/i386/cpu.c     | 71 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 115 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1


