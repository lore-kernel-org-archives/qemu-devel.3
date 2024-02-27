Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88253C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyHo-00086z-MK; Tue, 27 Feb 2024 09:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.li@intel.com>) id 1reyHm-00086f-Nk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:18:22 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.li@intel.com>) id 1reyHk-0004tB-5P
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709043500; x=1740579500; h=from:to:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=l95fi2e4jk+gWliBC5JHm7Qml6rV/ndVOXkHAinAAa4=;
 b=kZbUi/FY2LNw3hFoIGLoFnU6dvp+fVaDcdKe6dy7JOUrITTEtd9bt9DM
 kcqGwt34GLYnhN6htgDZJ6LVjHshL/jDAuk2/0QucyYAq6FysL6uA7t9U
 i0flvc/oAbWH4WAvVlu9X4q+3UiGXi340+cRMnIL4GYB9cxWTph5prS2T
 h3q5um9rJw11wqITAAlnIEz9N0bidcKuVgAP8L8pKztYgCWGWU+ue2upE
 xdYH7bdK329CVwGVa5TTRu/uY2PLGLxIqkuekMqQRSSBHftGXixIhBld0
 TBJp3dtavchKLo62dQPpFU4v0cdX4r3VRar6oMW/P2zBfsMN0Lg5o6Cgt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14806556"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; d="scan'208";a="14806556"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 06:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; d="scan'208";a="11787872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Feb 2024 06:18:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:18:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:18:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 06:18:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgstUEVMOSWSQh+60C2yXw6Lbfbl35uYlxJxWHcusX/5+EEu0O8kYHU8LGH/Jbf1twfoJwuEYfM+tIF6WdH1/AczrrC/9mM7lR7kBadFDTOhPi2lCtAOp+f87MoS4XgnYhTTTf4cNrJaApg9tH4Th2l7dFe07z0ehFEVj3U6Dci1xcIxi2aulHauTI6Udv3blSDtQ35nNiKE1lbIjPkUmmwei6RSsITut+DPMlNoG41VDxbndGPfHxB7i1f1v/Qk0GU/C56hf7VQptvE98xoZgboKy5+829FAyoWPFTkelY0rt27aZ0OQnUETiW4+3uVBy5otuoewkxBBciDEUQBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LQcdPDZlN6LpOwTmCkASSfW7Tj0oiCi0snrJftg1Ss=;
 b=AhnJfAfahWCOB8V6SGL66zIX5Ly7JNpMX5+UNO3B5uIXBOopYd1YLCLxFsKARUWWL/Rv1scjyfzbGaghrVk7v82wZLKmb83mU5Xh8f9wN0hnF/UAeF62jp86C/Z08xRSr3rel2gKyCNTdOUD7trsHhLVws8fB3Y6OWwahVSS/wXUwJiIZYiM1fjT6i/F9TDU6qdIyXnZ8s0QQ2i8hJ8y2oRoRIJprPaUpKHPk1HqKR56ehgcO3dWbZY52lxifEg63R7QNgjLsA/UdThj+cqdVmYSuE3kp17gIhFzS8sIm2aKZG6KUd8YOUi7xF8EjkReawvslHw5PfErSvr2xyZuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13)
 by SJ2PR11MB8568.namprd11.prod.outlook.com (2603:10b6:a03:56c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 14:18:13 +0000
Received: from PH7PR11MB8551.namprd11.prod.outlook.com
 ([fe80::a7df:f8e6:be3f:79e0]) by PH7PR11MB8551.namprd11.prod.outlook.com
 ([fe80::a7df:f8e6:be3f:79e0%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 14:18:12 +0000
From: "Li, Yong" <yong.li@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Qemu sdhci-pci device can't be recognized by Linux kernel
Thread-Topic: Qemu sdhci-pci device can't be recognized by Linux kernel
Thread-Index: Adpph69a7+BFZHioR96a+Bkn/g/92Q==
Date: Tue, 27 Feb 2024 14:18:12 +0000
Message-ID: <PH7PR11MB8551419922FD4495F89B9655FB592@PH7PR11MB8551.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8551:EE_|SJ2PR11MB8568:EE_
x-ms-office365-filtering-correlation-id: 1be58d47-ab0a-4e9a-57a4-08dc379eeeae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nvxgXjJMoSSwiFiHu8ZjkOligrVdGiw17A07Id7rdMbu86BqtLpxrdRjAZGSKu2s6Ab1HjgeiRHQ8a9cmRniKFnxdujAekZBXlJ8I5imvLwu25wVqiesVu+EQVkzjV39ws9iXv/AfEafLXtu3fjY6UCvJd2vUoTLNAWkdBC7SHC+9hPZVNyesKrdHHaMYvwhd8WhyVItSlzunEvqmY9PIOCYNYUeDN64OkGPWW3+lAjqfTzzrGtUZbjA2B9XKc0IUTeAjSM3Xq0/t+7oOly5CsJgErK+DH5cyufb2DHUE2qQ6nM832leydrcUe2XvLG0qIy3bNpjBORrdGw1viLaaF5YzHb5Cchdc8X5AKBgQkl/2gR2SKpWeidGJMDRI5EBsAvfmTS8ZU6uOvTijGBUbkhoXvnh3R9C47SXSwuZ2HtqC4RGIfqZ1BvXBqo9joTEaxf1keGyUYjnWArNeHAJP3JxF46doyLhL2t7D+OK0sLkPBIvEZ6i/txah5co/35cSE1XWk+pMpbgjD0FV183o4KO1OblxbRFAARds5gDtbaQf7+ft/FU4hvzbmkc2PGT5me4181rau1vX/q28A1BhNI5RhFs9LAsvXIj8bZeGm7WyQFyvcYEjG1QpNkZvc7zNbN2VML2gkFASHBqfnkX0EEy6hI5mj3H/Gh21lGYeK94eidzy4oRVKjfJnxmnXbmHphIBnomZZFMZIclR9qvWQWDCqyJgob08YLAaT0H9kY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB8551.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmXsyL2wf7tAaLNfd8uBzk7pGa4t/6dxYUPCu1pxfZQNPl22tGEKieXiPluP?=
 =?us-ascii?Q?aTTevkW4wT+yOCaLIR5rD+pB2mv/eA304tYT91FJE2CMliY++jPyWWqQA13H?=
 =?us-ascii?Q?9ZzeBQ6JtxwY1i9rr06KSkgm03pmR8C4LxBDwYo9+qY+o9oivpUNI253C1id?=
 =?us-ascii?Q?RBapDyueTCYMsxG7TGDKWZ+LwkJAwjGVNzZSfKrqLf9dbAlGi5ycRArcjjYH?=
 =?us-ascii?Q?xSp2agwJEUd4SMiyn/e56QPEa3jhrQ03seBnfBrFNDT86nRWXKSv2mr1cRmB?=
 =?us-ascii?Q?e19Ng3VtENqTRFQPkcjf/dXutPFbb70z9i5pT1c5cq5MIJtJvxJjwPcDzyy6?=
 =?us-ascii?Q?8JKKM4eoQuUpbX6Yc5psOZ/R4RHIA98JCRYadlUTnDLDzOrJc8aOcJFoIq0Y?=
 =?us-ascii?Q?e44o4vE7doMXcRlNDny5029EhfqUqpwlPCOKADQJWKT91DGQ2mzWNTYPRnrT?=
 =?us-ascii?Q?LNlWKW8WyEHYemCeNHvjUSJy1PT6ZOnjOOoys9GEWLeJfj0dT0G7tcLp0zOj?=
 =?us-ascii?Q?X1OJgRixG94l5fmvBUL9paxcpOorrwIMLMs3Ph8y29qFEbgiwRjXyzFbD6MP?=
 =?us-ascii?Q?v0eXy4ejPFY6rADXQ3JkSvcWk5UVBWHl7uSkzbj1H0MaGke2bNPaUi1nFCSs?=
 =?us-ascii?Q?mU0XutE4HaextEYJEBcxKdf3pH/y+rnIShgCNX7htxMLugVpMqSFjVW3qVom?=
 =?us-ascii?Q?DlCfuw4li6jPldhIH3hsrIF0PxxCbw+dbQjYlBGR0+m2AkJ7pwniEEbMQHvH?=
 =?us-ascii?Q?yol50y7J5Z4pDcNFdCB0pLVAXc6cH7zelyI9fO97g8a1PG3cBwCHL/76S6Nf?=
 =?us-ascii?Q?zyuE+ncaMdFFd0JwNi6zO3O5023uXKmo4WMgYqnytLRjQIK1nDLw9AtJMFYc?=
 =?us-ascii?Q?hg2fUDOcTLK8cBQnY166R25dn+CpBT8vsvobxXVVpWcHJ9hXdKdrCQq4oqR1?=
 =?us-ascii?Q?XD61wiMwnH/vfTwa/Qu4iziTrQ0YHCIUlmVudBeO6MNblbB2ntsQXLVGFchP?=
 =?us-ascii?Q?6/rmsRzw30+T4wX4Hx/PHq6arIn8Qfe7nN8P9fQuKUCwW4FPBUQteNeIQlSi?=
 =?us-ascii?Q?AarWae8qY7sb4sJ4XKJAiKSa4SFQa3ewcu0fctw5Cj/c6gVwJqqxe7cHEBkk?=
 =?us-ascii?Q?cg9Hy2X9umo2D+m/MhzpzyQqFwHiTgGSEEG+vx3Au23/+jfq3T4AWb/HrXBP?=
 =?us-ascii?Q?M4C6hdfBq0Ol2AvU7g+RyjVkBWS0CME1qF4aP+hMkbAQCJL5MF99JAn1ktdM?=
 =?us-ascii?Q?PYRzV9ZuV5KQRT4lezD/xIm6Q5WXxW7inywMU3l1CJ98Kj9yvUNndERdQl6v?=
 =?us-ascii?Q?lYCYv2/X4V0KVNgRQgrJAhsxaT6YjbDirPhhYkZ8d4QOULCvt67+vUf4GdoS?=
 =?us-ascii?Q?eFPUSb72U4kTlKuQsb9uqPsje/oSF9ou28HyxXpSj3RRo9KoJ7xA0hB/Jj1j?=
 =?us-ascii?Q?oKpR282eawRqRdWx5z+sTY3X8iYiriqip8WsudQDeCcSoI9/wV+WZnTOVWpW?=
 =?us-ascii?Q?n50Duf8qnq/NW3USCvGIWLKsSuqS6vE4+ICj6k/6btsC/Sd980dhMFl+wPFT?=
 =?us-ascii?Q?r0Ll28YrI1iKWBxSbUE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8551.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be58d47-ab0a-4e9a-57a4-08dc379eeeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 14:18:12.8049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxC7awacqt3oC1atmhUoQ5hUoQwe9RSv8kQImDMjHYZKHiXD1OObN8oYS9rwwQUVIc5yOyCKSyr6STc+AGkZfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8568
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yong.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

QEMU virt platform of RISCV-64 can emulate the mmc device by using below pa=
rameters:
-device sdhci-pci,sd-spec-version=3D3 \
-drive if=3Dnone,file=3Ddisk.img,format=3Draw,id=3DMMC1 \
-device sd-card,drive=3DMMC1

And as to u-boot, it do can recognize the mmc device and load the linux ker=
nel from the sdcard partition.
But the mmc device can't be recognized by the linux kernel so that the root=
 filesystem in the sdcard can't be loaded.

The logs are as below, any thoughts ? Thanks=20


Starting kernel ...

[    0.000000] Linux version 6.7.0-rc3-g2bb52284d571-dirty (intel@intel-Opt=
iPlex-7090) (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU=
 ld (GNU Binutils for Ubuntu) 2.34) #11 SMP Tue Feb 27 16:04:26 CST 2024
[    0.000000] random: crng init done
[    0.000000] Machine model: riscv-virtio,qemu
[    0.000000] SBI specification v1.0 detected
[    0.000000] SBI implementation ID=3D0x1 Version=3D0x10003
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] earlycon: ns16550a0 at MMIO 0x0000000010000000 (options '')
[    0.000000] printk: legacy bootconsole [ns16550a0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008003ffff (25=
6 KiB) nomap non-reusable mmode_resv1@80000000
[    0.000000] OF: reserved mem: 0x0000000080040000..0x000000008005ffff (12=
8 KiB) nomap non-reusable mmode_resv0@80040000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000008005ffff]
[    0.000000]   node   0: [mem 0x0000000080060000-0x000000017fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000017ffff=
fff]
[    0.000000] SBI HSM extension detected
[    0.000000] CPU with hartid=3D1 is not available
[    0.000000] Falling back to deprecated "riscv,isa"
[    0.000000] riscv: base ISA extensions acdfhim
[    0.000000] riscv: ELF capabilities acdfim
[    0.000000] percpu: Embedded 20 pages/cpu s41976 r8192 d31752 u81920
[    0.000000] Kernel command line: root=3D/dev/vda1 ro earlycon console=3D=
ttyS0,115200n8
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 =
bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 by=
tes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 10321=
92
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: area num 1.
[    0.000000] software IO TLB: mapped [mem 0x00000000faec6000-0x00000000fe=
ec6000] (64MB)
[    0.000000] Virtual kernel memory layout:
[    0.000000]       fixmap : 0xff1bfffffea00000 - 0xff1bffffff000000   (61=
44 kB)
[    0.000000]       pci io : 0xff1bffffff000000 - 0xff1c000000000000   (  =
16 MB)
[    0.000000]      vmemmap : 0xff1c000000000000 - 0xff20000000000000   (10=
24 TB)
[    0.000000]      vmalloc : 0xff20000000000000 - 0xff60000000000000   (16=
384 TB)
[    0.000000]      modules : 0xffffffff01589000 - 0xffffffff80000000   (20=
26 MB)
[    0.000000]       lowmem : 0xff60000000000000 - 0xff60000100000000   (40=
96 MB)
[    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (20=
47 MB)
[    0.000000] Memory: 4016708K/4194304K available (9472K kernel code, 4986=
K rwdata, 4096K rodata, 2222K init, 502K bss, 177596K reserved, 0K cma-rese=
rved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_id=
s=3D1.
[    0.000000] rcu:     RCU debug extended QS entry/exit.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped using AIA
[    0.000000] riscv-imsic: imsics@28000000: invalid cpuid for parent irq1
[    0.000000] riscv-imsic: imsics@28000000: providing IPIs using interrupt=
 1
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max=
_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000084] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps every=
 4398046511100ns
[    0.000338] riscv-timer: Timer interrupt in S-mode is available via sstc=
 extension
[    0.005139] Console: colour dummy device 80x25
[    0.008888] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 20.00 BogoMIPS (lpj=3D40000)
[    0.009171] pid_max: default: 32768 minimum: 301
[    0.010237] LSM: initializing lsm=3Dcapability,integrity
[    0.014518] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes,=
 linear)
[    0.014778] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 b=
ytes, linear)
[    0.033936] CPU node for /cpus/cpu@1 exist but the possible cpu range is=
 :0
[    0.044500] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.045051] riscv: ELF compat mode supported
[    0.045275] ASID allocator using 16 bits (65536 entries)
[    0.046454] rcu: Hierarchical SRCU implementation.
[    0.046577] rcu:     Max phase no-delay instances is 1000.
[    0.048704] EFI services will not be available.
[    0.050031] smp: Bringing up secondary CPUs ...
[    0.051095] smp: Brought up 1 node, 1 CPU
[    0.063329] devtmpfs: initialized
[    0.074382] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.074689] futex hash table entries: 256 (order: 2, 16384 bytes, linear=
)
[    0.076688] pinctrl core: initialized pinctrl subsystem
[    0.080864] sse: Missing SBI SSE extension
[    0.082410] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.090488] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocat=
ions
[    0.091007] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atom=
ic allocations
[    0.091370] audit: initializing netlink subsys (disabled)
[    0.094571] thermal_sys: Registered thermal governor 'step_wise'
[    0.095183] audit: type=3D2000 audit(0.084:1): state=3Dinitialized audit=
_enabled=3D0 res=3D1
[    0.095906] cpuidle: using governor menu
[    0.120192] cpu0: Ratio of byte access time to unaligned word access is =
7.30, unaligned accesses are fast
[    0.121054] riscv-rpxy: SBI RPXY extension detected
[    0.143014] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s
[    0.143168] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.147680] ACPI: Interpreter disabled.
[    0.148204] iommu: Default domain type: Translated
[    0.148299] iommu: DMA domain TLB invalidation policy: strict mode
[    0.150202] SCSI subsystem initialized
[    0.152031] usbcore: registered new interface driver usbfs
[    0.152332] usbcore: registered new interface driver hub
[    0.152545] usbcore: registered new device driver usb
[    0.154011] Advanced Linux Sound Architecture Driver Initialized.
[    0.164653] vgaarb: loaded
[    0.168952] clocksource: Switched to clocksource riscv_clocksource
[    0.170805] pnp: PnP ACPI: disabled
[    0.187515] NET: Registered PF_INET protocol family
[    0.188635] IP idents hash table entries: 65536 (order: 7, 524288 bytes,=
 linear)
[    0.196372] tcp_listen_portaddr_hash hash table entries: 2048 (order: 4,=
 65536 bytes, linear)
[    0.196668] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.196857] TCP established hash table entries: 32768 (order: 6, 262144 =
bytes, linear)
[    0.197276] TCP bind hash table entries: 32768 (order: 9, 2097152 bytes,=
 linear)
[    0.201318] TCP: Hash tables configured (established 32768 bind 32768)
[    0.202392] UDP hash table entries: 2048 (order: 5, 196608 bytes, linear=
)
[    0.202904] UDP-Lite hash table entries: 2048 (order: 5, 196608 bytes, l=
inear)
[    0.204091] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.206864] RPC: Registered named UNIX socket transport module.
[    0.207015] RPC: Registered udp transport module.
[    0.207090] RPC: Registered tcp transport module.
[    0.207181] RPC: Registered tcp-with-tls transport module.
[    0.207256] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.207489] PCI: CLS 0 bytes, default 64
[    0.213042] workingset: timestamp_bits=3D46 max_order=3D20 bucket_order=
=3D0
[    0.214484] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.216473] NFS: Registering the id_resolver key type
[    0.217281] Key type id_resolver registered
[    0.217377] Key type id_legacy registered
[    0.217680] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.217865] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regist=
ering...
[    0.218602] 9p: Installing v9fs 9p2000 file system support
[    0.221381] NET: Registered PF_ALG protocol family
[    0.221731] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 244)
[    0.221978] io scheduler mq-deadline registered
[    0.222128] io scheduler kyber registered
[    0.222306] io scheduler bfq registered
[    0.224296] riscv-imsic: imsics@28000000: hart-index-bits: 0,  guest-ind=
ex-bits: 0
[    0.224426] riscv-imsic: imsics@28000000: group-index-bits: 1, group-ind=
ex-shift: 24
[    0.224566] riscv-imsic: imsics@28000000: per-CPU IDs 255 at base PPN 0x=
0000000028000000
[    0.224711] riscv-imsic: imsics@28000000: total 254 interrupts available
[    0.227558] pci-host-generic 30000000.pci: host bridge /soc/pci@30000000=
 ranges:
[    0.228230] pci-host-generic 30000000.pci:       IO 0x0003000000..0x0003=
00ffff -> 0x0000000000
[    0.228676] pci-host-generic 30000000.pci:      MEM 0x0040000000..0x007f=
ffffff -> 0x0040000000
[    0.228857] pci-host-generic 30000000.pci:      MEM 0x0400000000..0x07ff=
ffffff -> 0x0400000000
[    0.229362] pci-host-generic 30000000.pci: Memory resource size exceeds =
max for 32 bits
[    0.229814] pci-host-generic 30000000.pci: ECAM at [mem 0x30000000-0x3ff=
fffff] for [bus 00-ff]
[    0.232176] pci-host-generic 30000000.pci: PCI host bridge to bus 0000:0=
0
[    0.232487] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.232634] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.232765] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7ffffff=
f]
[    0.232899] pci_bus 0000:00: root bus resource [mem 0x400000000-0x7fffff=
fff]
[    0.234091] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
[    0.236786] pci 0000:00:01.0: [1b36:0007] type 00 class 0x080501
[    0.237291] pci 0000:00:01.0: reg 0x10: [mem 0x40000000-0x400000ff]
[    0.239022] pci 0000:00:02.0: [1af4:1000] type 00 class 0x020000
[    0.239705] pci 0000:00:02.0: reg 0x10: [io  0x1000-0x101f]
[    0.240324] pci 0000:00:02.0: reg 0x14: [mem 0x40001000-0x40001fff]
[    0.242455] pci 0000:00:02.0: reg 0x20: [mem 0x40004000-0x40007fff 64bit=
 pref]
[    0.243046] pci 0000:00:02.0: reg 0x30: [mem 0x40040000-0x4007ffff pref]
[    0.245209] pci 0000:00:02.0: BAR 6: assigned [mem 0x40000000-0x4003ffff=
 pref]
[    0.245492] pci 0000:00:02.0: BAR 4: assigned [mem 0x400000000-0x400003f=
ff 64bit pref]
[    0.245989] pci 0000:00:02.0: BAR 1: assigned [mem 0x40040000-0x40040fff=
]
[    0.246294] pci 0000:00:01.0: BAR 0: assigned [mem 0x40041000-0x400410ff=
]
[    0.246655] pci 0000:00:02.0: BAR 0: assigned [io  0x0020-0x003f]
[    0.252094] clk-sbi-rpxy soc:sbi-rpxy-clk: RPMI Clock Service Group Prob=
e Failed
[    0.255411] irq: no irq domain found for aplic@d008000 !
[    0.338181] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.347886] SuperH (H)SCI(F) driver initialized
[    0.363037] loop: module loaded
[    0.373271] genirq: irq_chip IMSIC-PCI did not update eff. affinity mask=
 of irq 11
[    0.378037] e1000e: Intel(R) PRO/1000 Network Driver
[    0.378140] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.380675] usbcore: registered new interface driver uas
[    0.380903] usbcore: registered new interface driver usb-storage
[    0.381666] mousedev: PS/2 mouse device common for all mice
[    0.384073] sdhci: Secure Digital Host Controller Interface driver
[    0.384182] sdhci: Copyright(c) Pierre Ossman
[    0.384361] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.385528] usbcore: registered new interface driver usbhid
[    0.385646] usbhid: USB HID core driver
[    0.386192] riscv-pmu-sbi: SBI PMU extension is available
[    0.386646] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    0.386789] riscv-pmu-sbi: Perf sampling/filtering is not supported as s=
scof extension is not available
[    0.387628] irq: no irq domain found for aplic@d008000 !
[    0.387809] sdhci-pci 0000:00:01.0: SDHCI controller found [1b36:0007] (=
rev 0)
[    0.417829] mmc0: Failed to request IRQ 0: -22
[    0.421338] sdhci-pci: probe of 0000:00:01.0 failed with error -22


Thanks,
Yong Li


