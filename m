Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFA5C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 16:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkmzA-0007jL-15; Wed, 19 Feb 2025 11:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tkmyR-0007eJ-4C
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tkmyN-0008D4-D8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739982652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBpdq2F7amubkM/x6JjMPKPbJ2DlfV5KCgs7AU0Q1tk=;
 b=Hj/s5Bk8hR2n4lVFnPRekUNQk42sVY6ruKDpDfAsPMDoNUZbEDs3URHB/24KBhh548YCrb
 ZupOx6WeiQ2qLMBi7h41KXvsMJESmL4lF6cT6m3G/Khz7oSBDk8uiS6YEWSUO+FmqDEPiO
 f0HgOW1DwBhWi8jRQAwk7Rd1FIQXIVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-bRFsMl06OBGLJy6eGtQoGw-1; Wed, 19 Feb 2025 11:30:50 -0500
X-MC-Unique: bRFsMl06OBGLJy6eGtQoGw-1
X-Mimecast-MFC-AGG-ID: bRFsMl06OBGLJy6eGtQoGw_1739982649
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so146965e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 08:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739982649; x=1740587449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBpdq2F7amubkM/x6JjMPKPbJ2DlfV5KCgs7AU0Q1tk=;
 b=RlL/3cCukLWA0Z5y1OeXnDDfO2PHccbmRHRy7C3kaB6xUCdiBk00dzN9fup5aZaSvC
 Ic3L7IoG0AS6Ny2SK+zlvN0BD54gfNsX5xmn+wUxN6ctKTuA8xhPnzxajh2MuwQ3YadQ
 L3KfAXdWdwODuPQZLMT91ln8dzNhx1E1wzc9RGwubXtHcbrqPsBFNXWgdpnCz1LczSJX
 cZVhl8uwAJX05vpcm0mLgVYR6KIuy6XOzLgeyDFIY46GwOBibCgHUIiRfWpS/L+pDc1z
 Z9WSQ6IYvlL+uAfL+qVCRZOub6bcq0bgj2tQf209HCdOch3OeAgHeoDp6Co/NWVvsIVS
 QzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5hj+gaxoT8qdV7MGYDxDBzt4egRyEaO57c0CseU5KltLYFtjX++zz5KWkdjyfZbBuXTepoY3cr1Du@nongnu.org
X-Gm-Message-State: AOJu0Yy+BXPDMG0APpliIdyih/xE5LiKUVTlEewZDob3fVcbIVn/+pam
 JBaIylTvDV06L6wdyLMU8DhUn5N6b6nlkuIneBQUMbZgF2i/mLdAO+a/jZsrprUU3+DuTcFkLp7
 YSdLwWUGqAE4S2p7rt9e36mn75DL9FA+zAxtfPkxhk9iaQp3LJ2Ry
X-Gm-Gg: ASbGncuH43Tho53PrAiuFD2RbwOQvFqmV2H3OH0ncnqc3/MXkeOGjFTesbmHQB0vkvu
 922pltvxv/gCffayFYMdJrsDZbDBHtp2hNgQrCPPrVgJqPEwCQyUKGmMZnN3RFux6Cir9igrORT
 5Qk1YEaYf/5/0zv2UoJS2AQc3AM1f5WNIARO8mqJYAsVU3QXWdbRX8JrrX4RI23wJc+0iVF9cqx
 PPtctHeRsSIR6jNnGFb4EW8/QtdQ194vJ+IqmIphL/XD7Paakj4F7WaTDOvre4flworzA3M/tU+
 Hf6QLMo582OBvgtUNYxOXL73FoKmvyxHTSG+K/nMY1EK0HdOioXg
X-Received: by 2002:a05:600c:4f15:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43999b0283amr43481085e9.9.1739982649342; 
 Wed, 19 Feb 2025 08:30:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHnkuy/b9f8Mcq0EOQR+jk8A6DD7VIc07w6GERVFJfAY6gTiEL8fVKbizWl3UTiQbjeRkF8A==
X-Received: by 2002:a05:600c:4f15:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-43999b0283amr43480265e9.9.1739982648600; 
 Wed, 19 Feb 2025 08:30:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43986b475ffsm86205605e9.17.2025.02.19.08.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:30:47 -0800 (PST)
Date: Wed, 19 Feb 2025 17:30:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Zhao
 Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] microvm: do not use the lastest cpu version
Message-ID: <20250219173046.255a7b83@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250213094100.129358-1-anisinha@redhat.com>
References: <20250213094100.129358-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 13 Feb 2025 15:11:00 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> Microvm machines are not versioned and therefore there is no requirement to use
> the latest cpu model by default. Let microvms use the non-versioned cpu model.
> Those users who need spefific cpu versions can use explicit commandline to
> select the cpu version desired.

Above says why we can do this but,
I'd also add here a reason why we are doing that to begin with. 

> 
> CC: imammedo@redhat.com
> CC: zhao1.liu@intel.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/microvm.c |  2 +-
>  target/i386/cpu.c | 15 ---------------
>  target/i386/cpu.h |  4 ----
>  3 files changed, 1 insertion(+), 20 deletions(-)
> 
> Pipeline passes:
> https://gitlab.com/anisinha/qemu/-/pipelines/1669159835
> See also Igor's comment on
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250128035526.3750043-1-anisinha@redhat.com/
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index a8d354aabe..b8be1542ff 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -458,7 +458,7 @@ static void microvm_machine_state_init(MachineState *machine)
>  
>      microvm_memory_init(mms);
>  
> -    x86_cpus_init(x86ms, CPU_VERSION_LATEST);
> +    x86_cpus_init(x86ms, 1);
>  
>      microvm_devices_init(mms);
>  }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5dd60d281..6d251c0025 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5513,18 +5513,6 @@ void x86_cpu_set_default_version(X86CPUVersion version)
>      default_cpu_version = version;
>  }
>  
> -static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
> -{
> -    int v = 0;
> -    const X86CPUVersionDefinition *vdef =
> -        x86_cpu_def_get_versions(model->cpudef);
> -    while (vdef->version) {
> -        v = vdef->version;
> -        vdef++;
> -    }
> -    return v;
> -}
> -
>  /* Return the actual version being used for a specific CPU model */
>  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>  {
> @@ -5532,9 +5520,6 @@ static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>      if (v == CPU_VERSION_AUTO) {
>          v = default_cpu_version;
>      }
> -    if (v == CPU_VERSION_LATEST) {
> -        return x86_cpu_model_last_version(model);
> -    }
>      return v;
>  }
>  
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c67b42d34f..71f150a05f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2701,10 +2701,6 @@ void apic_handle_tpr_access_report(DeviceState *d, target_ulong ip,
>                                     TPRAccess access);
>  
>  /* Special values for X86CPUVersion: */
> -
> -/* Resolve to latest CPU version */
> -#define CPU_VERSION_LATEST -1
> -
>  /*
>   * Resolve to version defined by current machine type.
>   * See x86_cpu_set_default_version()


