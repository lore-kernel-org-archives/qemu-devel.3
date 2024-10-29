Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F3CD2AB3C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5mKe-0003J9-8m; Tue, 29 Oct 2024 09:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5mKR-0003Hp-V8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:32:13 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5mKO-0000Ud-1s
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730208728; x=1761744728;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HaVrdgGgqQPXSXUY44YMa+892zcw9wTSvc8pVZSze+w=;
 b=Op7KcCQQgNshaQf+XP9OasImgpJ97GsCo3iban7GiA3PjzxXkHtdT08p
 ESU7osivhMtQNJX94lCd/5sLxatVS5GHX3GdZykfkxSWAiq19cUIuJtqe
 Otl4s800TDkP86FJ99lD4FSKeqPZ0IYBgjfJmRVQ1va9vwBljuDcmdbq1
 DPZiV0wNyCka0elTD/CkmYFTVNmjrhgoxlRUBS4Il3N+33H1ASJ8c4Dgh
 T9z78TN5hmGY6HSVd94HFi4lJkvCf7YjzlAtXEYxO/ZimQEWTCycxv97o
 uiMI5d7oAxXmqgMzdTqueN1e0EfW82Mnz6XxmPsr4tYGMUhhcg7hwrXLC g==;
X-CSE-ConnectionGUID: uFkIAVNnQsGy9ijUZgcKdw==
X-CSE-MsgGUID: fIhUh1BSQVmgnj373Fsuyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29956575"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="29956575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 06:32:05 -0700
X-CSE-ConnectionGUID: 8aatswU+TfG1TWnG0N1Bdw==
X-CSE-MsgGUID: +0GKjFZSQL2P3uAbdOzI9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="87099807"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 29 Oct 2024 06:32:03 -0700
Date: Tue, 29 Oct 2024 21:48:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 4/4] hw/loongarch/virt: Enable cpu hotplug feature on
 virt machine
Message-ID: <ZyDnpk3tmG4KECWc@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-5-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029095335.2219343-5-maobibo@loongson.cn>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

[snip]

> @@ -1382,8 +1384,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       }
>  
>      if (cpu->phy_id == UNSET_PHY_ID) {
> -        error_setg(&local_err, "CPU hotplug not supported");
> -        goto out;
> +        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> +            error_setg(&local_err,
> +                       "Invalid thread-id %u specified, must be in range 1:%u",
> +                       cpu->thread_id, ms->smp.threads - 1);
> +            goto out;
> +        }
> +
> +        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
> +            error_setg(&local_err,
> +                       "Invalid core-id %u specified, must be in range 1:%u",
> +                       cpu->core_id, ms->smp.cores - 1);
> +            goto out;
> +        }
> +
> +        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> +            error_setg(&local_err,
> +                       "Invalid socket-id %u specified, must be in range 1:%u",
> +                       cpu->socket_id, ms->smp.sockets - 1);
> +            goto out;
> +        }
> +
> +        topo.socket_id = cpu->socket_id;
> +        topo.core_id = cpu->core_id;
> +        topo.thread_id = cpu->thread_id;
> +        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
> +        if (CPU(cpu_slot->cpu)) {
> +            error_setg(&local_err,
> +                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
> +                       cs->cpu_index, cpu->socket_id, cpu->core_id,
> +                       cpu->thread_id, cpu_slot->arch_id);
> +            goto out;
> +        }
> +        cpu->phy_id = arch_id;
>      } else {

Here you allow user to specify topology IDs, but "else" still indicates
user could use "phy_id" instead of topology IDs, right?

Is it necessary to expose "phy_id" to user?

Thanks,
Zhao


