Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D060CD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUECi-0003P6-RY; Mon, 01 Jun 2026 21:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUECh-0003Ox-JP
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:46:03 -0400
Received: from mail-northcentralusazon11013070.outbound.protection.outlook.com
 ([40.107.201.70] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUECf-0002kP-QR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:46:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTYU2XveSUxE71LwTW8jCnNKynOhdMoghIX5IrXqHCZSgCSZ0s5+uVqb2/94KQ1MJJ7euzOS3SSVcu7Hcqd3Iv9/gdFAZvm0QRF+F5kECtMUjinHKt0Onga5nzYmw0GG5KPcAhEyHHFVY0cM84Fsk9JvHlbvrRiErOg8c5M3PBPDmiQT+rBtDHONrwoyy4AkEqMfsg0MHsSOcU7HJGa1tBC/ZVnBPhckfLOXFFF7PHaUcHdtEMMt8BGe5izBYGUbu16+AzQH2Bv79wLbF5ML+XHHcn+ugbFerJ6tLyPyMvbkMsKMLW2D1OHJgXcT+axuNcaY7h9RPLptCIGlN2ovdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGFIECxN/0hiiUkZtghF34P4jFyxMYa7inIHQQabiZ8=;
 b=RtavG39GFGosE2RFUJkhYJqyG9l4s1J+sl1qZitWPn/Be9itIrHrxNRimJsj5biSiSo6myegsFtC8AcHjAoOKIjPo0i5KmVYEZ1KUUbfD+0GdmVgR8PCtBKj1O67qwKj3+W7GZ70THPkd+HAIkWCRW1F9yiZSnCr2GcOngoygaxzpUlUuq0VCgoTsVcLDUOoJbnz3vXJnxWOWtGWZ2Kzf2eg70zeBI0LB6gGA6mMIBOk9dvfZtVxtMNNRuXoCvmqiZ4wPs+ol8UO2SvDlB42YuM9O+4LG6aucbMHVykFFm61gTfpDAy/Iic/cyBi7yzG/2p0secOKD93F5nE8o/1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGFIECxN/0hiiUkZtghF34P4jFyxMYa7inIHQQabiZ8=;
 b=Ca8KozX6hiU5tSrprcX14exJK1o5r2zPpcaW75TycY8iRtcIb/toiY0EpsQUNaTmiXcK4t9oSaIrZXJSipvN0N4FsE0dlwJ361GUS69zRrcgjciNS71lt/wQhbTsiTQorqxnBMtlfY/7bqKL7vYAQuOgMS/e+yR4iIW9JFiQg4o=
Received: from SN7PR04CA0236.namprd04.prod.outlook.com (2603:10b6:806:127::31)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 01:40:54 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::37) by SN7PR04CA0236.outlook.office365.com
 (2603:10b6:806:127::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Tue, 2
 Jun 2026 01:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:40:53 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:40:53 -0500
Date: Mon, 1 Jun 2026 20:10:51 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Message-ID: <yfvgjtob2xbldl6avdcay6lzbjo435bqhvhazqeekn6tombyqx@c66atubduqm3>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-2-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: b4050bc5-a52e-41ce-57a3-08dec047fc35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yDfoeBwUrIlm3yU4934e9Ick3GUzA/LolJMNCPIdc/AaA0o8Os5TdcG7KdIAXCN87dFRWmOIYLknExnc7VyjZxlF/fn7r0DasrS9EzgaOwKDAficLf3jgdZl730C4nu6XS68NHOLcdEA7rOLJeBaR3+LhPWWmZN8MrLn6/g3DTk4cmBhhSkYsa6OZluDUIwh1WbHLX1crkqDsk3EVQkQNVy/ujUQUnNbNdr8R17VBLpo7AVVO4pcrCfdmOBNSYLn/MPME3x7XSVlHLyn4lBzZoSXE8/6SHHtMu5iEEJkaSRXvF6P12EtwfAA91ppRMTnaVoHyR6Ek0IV79cHfU2CkPfZlLKrjptL2cqtWORrv3gfkP6i3XP9i8KqlNM9/yw0qnBhb5jkRDkic1w0/eLF/+EQXeocacrfdJUQsYY6LewZK2geAeeEHJBdnPrlSOrOmEX1b3P3D0/aEd9qX+ravxzP3JDKbBaaLb1RtXk5Hpxx1m0myi0wmAPHYAuZ4PwpgLb8wi4b5SGdqiuqOEKHXCZh8siyKCEgOa/DyaZb0l3bscaZMhQGE7tw8rAPVEN8A6uQE2e+z09Rj3bk4fVf7CxF/5YBsA4EXzvdfNf1PB+G7FMJ+rr7aEe5k/MSNOS8PwsHVuzTUfWzp6JoS+vra/buigSWNwcaH+B4RrSH2VgZgLB3DEE/5c4nXyHNcvIrG3LCkWkWRnUQi47ud1pBO5ZOJY0k1pg6AwR8pWpS+1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3yPX39FkaV2BY8cn/oie3OXPnYRc7vIJg6eNG0ZICE3HZ00zt5nGnugRf/knrHQs2boVubGqI2w2RVuEj3sUzV64LoixanLOHy67QFbr3BF0a7GW1YOutNrdlsHFXlEeU7FXLUPSIGElF9NGNjL/mv4/0BH2Mnu4Hm14pxIWgbSQlMhipp2ljfrS/8w2EnZIsPTMWpLjIBrqBgH4wQ8wZiiljGjHNesIxtjX4vj2wY2H+zfUaJ7lHiImj+n6TyIY2qCff5oBUdlNay1yacsfE6MDP0wZdh33f1p9vcP137hH4kAjl5370vLmkYRPMsbrCaz9pAY676UqrQYFw5PEYnH0QFhBzanwzxyoGSIaDyg1YDyrh302dMC1MPet4sTYY+kYqYNBeSEFqp0tZgIG2As2PL3hAScqalhr8lbzowI9H5BGlXjUOHks2obuGoa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:40:53.9439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4050bc5-a52e-41ce-57a3-08dec047fc35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
Received-SPF: permerror client-ip=40.107.201.70;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 03:51:52PM -0500, Peter Xu wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> With the mmap support of guest memfd, KVM allows usersapce to create
> guest memfd serving as normal non-private memory for X86 DEFEAULT VM.
> However, KVM doesn't support private memory attriute for X86 DEFAULT
> VM.
> 
> Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
> and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
> requires guest_memfd to serve as private memory.
> 
> This allows QMEU to create guest memfd with mmap to serve as the memory
> backend for X86 DEFAULT VM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/kvm.h   | 1 +
>  accel/kvm/kvm-all.c    | 8 ++++++--
>  accel/stubs/kvm-stub.c | 5 +++++
>  system/physmem.c       | 8 ++++++++
>  4 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 8f9eecf044..b5811c90f1 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -561,6 +561,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
>  
>  int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
>  int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
> +bool kvm_private_memory_attribute_supported(void);
>  
>  int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
>  
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 28006d73c5..59836ebdff 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1501,6 +1501,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
>      return kvm_set_memory_attributes(start, size, 0);
>  }
>  
> +bool kvm_private_memory_attribute_supported(void)
> +{
> +    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +}
> +
>  /* Called with KVMMemoryListener.slots_lock held */
>  static void kvm_set_phys_mem(KVMMemoryListener *kml,
>                               MemoryRegionSection *section, bool add)
> @@ -2781,8 +2786,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
>      kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>      kvm_guest_memfd_supported =
>          kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> -        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
> -        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
>      kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
>  
>      if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 68cd33ba97..73f04eb589 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -125,3 +125,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>  {
>      return -ENOSYS;
>  }
> +
> +bool kvm_private_memory_attribute_supported(void)
> +{
> +    return false;
> +}
> diff --git a/system/physmem.c b/system/physmem.c
> index c9869e4049..3555d2f6f7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>                         object_get_typename(OBJECT(current_machine->cgs)));
>              goto out_free;
>          }
> +
> +        if (!kvm_private_memory_attribute_supported()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: "
> +                       " KVM does not support private memory attribute",
> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }
> +
>          assert(new_block->guest_memfd < 0);
>  
>          ret = ram_block_coordinated_discard_require(true);
> -- 
> 2.50.1
> 
> 

