Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BF5CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pDv-0005Vx-Ex; Thu, 09 Oct 2025 07:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6pDj-0005Tu-VC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6pDc-0006VD-LI
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760010832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6YRf8oi9pJTAawecuBCYX+b+4pj83/o0VST4NfE2Cbs=;
 b=Ne/51tcZ4g/RC6i06+tOrqd/V5GlFe6DsoZPj1sJhx+SVmdcaYhcSlwdUtS6XChyiceHN3
 Za/WpT3eeHfVDglos4cLQNw1d6UlLXzLAW7rKy5dLKnwgffEWNXwRhHEdBi33o1IkvDWNK
 dLoXflWwk/nOdjtrdTHSSb/fTyRlGog=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-xcZ_J_90Pd2w-3ND_jupyw-1; Thu,
 09 Oct 2025 07:53:50 -0400
X-MC-Unique: xcZ_J_90Pd2w-3ND_jupyw-1
X-Mimecast-MFC-AGG-ID: xcZ_J_90Pd2w-3ND_jupyw_1760010826
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11FA81800284; Thu,  9 Oct 2025 11:53:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B11B18004D8; Thu,  9 Oct 2025 11:53:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DBED21E6A27; Thu, 09 Oct 2025 13:53:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: salil.mehta@opnsrc.net
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  mst@redhat.com,
 salil.mehta@huawei.com,  maz@kernel.org,  jean-philippe@linaro.org,
 jonathan.cameron@huawei.com,  lpieralisi@kernel.org,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 imammedo@redhat.com,  andrew.jones@linux.dev,  david@redhat.com,
 philmd@linaro.org,  eric.auger@redhat.com,  will@kernel.org,
 ardb@kernel.org,  oliver.upton@linux.dev,  pbonzini@redhat.com,
 gshan@redhat.com,  rafael@kernel.org,  borntraeger@linux.ibm.com,
 alex.bennee@linaro.org,  gustavo.romero@linaro.org,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com,  miguel.luis@oracle.com,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 wangzhou1@hisilicon.com,  linuxarm@huawei.com,  jiakernel2@gmail.com,
 maobibo@loongson.cn,  lixianglai@loongson.cn,  shahuang@redhat.com,
 zhao1.liu@intel.com
Subject: Re: [PATCH RFC V6 23/24] monitor,qapi: add 'info cpus-powerstate'
 and QMP query (Admin + Oper states)
In-Reply-To: <20251001010127.3092631-24-salil.mehta@opnsrc.net> (salil mehta's
 message of "Wed, 1 Oct 2025 01:01:26 +0000")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-24-salil.mehta@opnsrc.net>
Date: Thu, 09 Oct 2025 13:53:39 +0200
Message-ID: <87ecrcqojg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

salil.mehta@opnsrc.net writes:

> From: Salil Mehta <salil.mehta@huawei.com>
>
> The existing 'info hotpluggable-cpus' applies to platforms with true CPU
> hotplug. On ARM, vCPUs are not hotpluggable: resources are allocated at
> boot and policy is enforced administratively (e.g. via ACPI _STA) to
> achieve a hotplug-like effect. As a result, the hotpluggable interface
> cannot describe ARM CPU state, whether administrative or runtime.
>
> Operators need a clear view of both administrative policy (Enabled,
> Disabled, Removed) and guest runtime status (On, Standby, Off, Unknown)
> for all possible vCPUs. This separation is essential to debug CPU life
> cycle flows on ARM, where PSCI CPU_ON/CPU_OFF and ACPI methods are used,
> and to distinguish CPUs that are enumerated but administratively blocked
> from those actually executing in the guest.
>
> The new interface is independent of hotplug and coexists with 'info
> hotpluggable-cpus' on platforms that support it (e.g. x86). By default
> devices are administratively Enabled; on hotpluggable systems, absent
> CPUs appear as Removed here.
>
> This patch introduces:
>   * QMP 'query-cpus-powerstate' returning CPUPowerStateInfo per possible
>     vCPU.
>   * HMP 'info cpus-powerstate' for human-readable output.
>   * Enums:
>       - CPUPowerAdminState { enabled, disabled, removed }
>       - CPUOperPowerState  { on, standby, off, unknown }
>   * CPUPowerStateInfo with admin/oper state, optional topology ids, and
>     qom-path.
>
> Operational state semantics:
>   * 'on'      : CPU is on and runnable.
>   * 'standby' : Reserved for suspend-with-context (e.g. PSCI CPU_SUSPEND).
>                 Not emitted yet.
>   * 'off'     : CPU is powered off.
>                 - At initial boot, admin-disabled vCPUs may be left
>                   unrealized (lazy realize) and are reported Off.
>                 - After an admin enable, the vCPU is realized; if later
>                   powered down, it remains realized and reported Off.
>   * 'unknown' : State cannot be determined (very early init/teardown,
>                 transient hot-(un)plug window, or no power-state handler).
>
> Migration semantics:
>   * Admin-disabled (unrealized) vCPUs do not migrate.
>   * Admin-enabled vCPUs migrate their operational state, including Off.
>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index e45740da33..3856785b27 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1069,6 +1069,93 @@
>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'],
>               'allow-preconfig': true }
>  
> +##
> +# @CPUOperPowerState:
> +#
> +# Guest-visible operational state of the CPU.
> +# This reflects runtime status such as guest online/offline status or
> +# suspended state (e.g., CPU halted, suspended in a WFI loop).
> +#
> +# .. note::
> +#    This field is read-only. It is derived by QEMU from runtime
> +#    information (e.g., CPU execution/architectural state, PSCI power
> +#    status, vCPU runstate) and cannot be set by management tools or
> +#    user commands.
> +#
> +# @on: CPU is online and executing.
> +# @standby: CPU is idle or suspended (e.g., WFI).
> +# @off: CPU is guest-offlined or halted.
> +# @unknown: State cannot be determined at this time (e.g., very early
> +#           init/teardown, transient hotplug/hotremove window, no
> +#           power-state handler registered, or the target/platform does
> +#           not expose a queryable CPU state).
> +##
> +{ 'enum': 'CPUOperPowerState',
> +  'data': ['on', 'standby', 'off', 'unknown'] }
> +
> +##
> +# @CPUAdminPowerState:
> +#
> +# Host-side administrative power state of the CPU device.
> +# Controls guest visibility and lifecycle.
> +#
> +# @enabled: CPU is administratively enabled (can be used by guest)
> +# @disabled: CPU is administratively disabled (guest-visible but unusable)
> +# @removed: CPU is logically removed (not visible to guest)
> +##
> +{ 'enum': 'CPUAdminPowerState',
> +  'data': ['enabled', 'disabled', 'removed'] }
> +
> +##
> +# @CPUPowerStateInfo:
> +#
> +# CPU status combining both administrative and operational/runtime state.
> +#
> +# @id: CPU index
> +# @core-id: Core ID (optional)
> +# @socket-id: Socket ID (optional)
> +# @cluster-id: Cluster ID (optional)
> +# @thread-id: Thread ID (optional)
> +# @node-id: NUMA node ID (optional)
> +# @drawer-id: Drawer ID (optional)
> +# @book-id: Book ID (optional)
> +# @die-id: Die ID (optional)
> +# @module-id: Module ID (optional)
> +# @vcpus-count: Number of threads under this logical CPU (optional)
> +# @qom-path: QOM object path (optional)
> +# @admin-state: Administrative power state (enabled/disabled/removed)
> +# @oper-state: Guest-visible runtime power state (on/standby/off)
> +##
> +{ 'struct': 'CPUPowerStateInfo',
> +  'data': {
> +    'id': 'int',
> +    '*core-id': 'int',
> +    '*socket-id': 'int',
> +    '*cluster-id': 'int',
> +    '*thread-id': 'int',
> +    '*node-id': 'int',
> +    '*drawer-id': 'int',
> +    '*book-id': 'int',
> +    '*die-id': 'int',
> +    '*module-id': 'int',
> +    '*vcpus-count': 'int',
> +    '*qom-path': 'str',
> +    'admin-state': 'CPUAdminPowerState',
> +    'oper-state': 'CPUOperPowerState'
> +  } }
> +
> +##
> +# @query-cpus-power-state:
> +#
> +# Returns all CPUs and their power state info, combining host policy and
> +# runtime guest status. This is useful for debugging vCPU hotplug,
> +# suspend/resume, admin power states or offline state flows.
> +#
> +# Returns: a list of @CPUPowerStateInfo
> +##
> +{ 'command': 'query-cpus-power-state',
> +  'returns': ['CPUPowerStateInfo'] }
> +
>  ##
>  # @set-numa-node:
>  #

Have you considered adding the information to existing query-cpus-fast?


