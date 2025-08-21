Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5257CCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6Gr-0005HL-M3; Thu, 21 Aug 2025 10:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up6Gd-000584-5k; Thu, 21 Aug 2025 10:27:52 -0400
Received: from mail-dm6nam10on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2413::624]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1up6GZ-0006eY-C0; Thu, 21 Aug 2025 10:27:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb/350hb8j1y8RrSvzd16N2veEvGmzGOwKZhjgQjGy5aZj8qteeic7QZN6COpRAo8e9+ZPd5jwKMPLBTtEb6k8pPDuZQOoFI5uUrw6/f/9vSuhzA2A8snifRQe62Gr/mO0j8TQGHK16zUDYV45czsgq+zh4XamWg9egC81yQtWV0wj+n98wbo45hI8Pv2zNR9KWDH8w+AxCZvjWWjrmsaJwSxi9uStty+bOJPTtCJFFvaC2xI03usviMxfgJ0PhEPGskFbwsMMYOBJ1d5eyU0xINvM16+IzlwZHtRyk6hPa8tIQy3qpgc50XS89nyYJYkaw4Kt7hRFIWy6hY5O9Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cluX/t3v46bGPLuZ1zIEQ5aZW9XTEkRpjo6DOWkUSzo=;
 b=UbHEiaIFacXIVFE28fCgNtU5H7wOWseMyfFXSzndgBfIx+AODh3kmmUInZuDGZ5LShbnUthaRasg+qEYOGLXu2X+4346wAm6x0ZcJML8euK/0EF8El5/QP28nf5M2NzzkfjX2xuqCHUXygjQR0HUla1kOguOUkhEdOs+QbIS1fr4M8f0FVz8DCA8MIQ2TPPLWXWlT+V/Ys8UNeMq8MCFmQjhb1xNIoxy8s71BOQWntMFsZ/Amear2ojJalYAy13bWKrwNpLn1jgN+u4IT5bV6wx1r96DgdAuormmLG3pZDZMAJDM778muPEbwIohteJ/9mRMCVvqxdWekMr7N3y5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cluX/t3v46bGPLuZ1zIEQ5aZW9XTEkRpjo6DOWkUSzo=;
 b=bbsonoCvCHEiPlNj1C4SISuf655w+8mHeIXWVA2eOj5639bctGeyzI8+ra+LzD9h6/I5+U+SXyuoetNz2Ex6c6wTu/ZMlpOS7cbV8fSUmRLAMai0b/Eljch72Bqvr4VgUbXLNxtjXTxgnAU4v6ed+oDJv5z2dMQ05A7FtNt+iM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 14:27:38 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 14:27:37 +0000
Date: Thu, 21 Aug 2025 16:27:35 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v3 00/47] AMD Versal Gen 2 support
Message-ID: <aKcs16vxzC93K1Ad@zapote>
References: <20250821130354.125971-1-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b06cd8b-e6e1-44fb-7bd4-08dde0bee0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jf2K0wTRaLWVPXATii980585EJ3dp2MvF5W+3Prn3kwdn/6unaoRlZN/Ammq?=
 =?us-ascii?Q?zumOd1+VhYGKz/piCg+nIGV/MXCAsBpLDb8IcB42T68A9dbYZ2J4NUEDzZ2y?=
 =?us-ascii?Q?ywj2f2otxlt46ksvNxhvo1KvCewV4WAhY1EBVKDshtjBA4zZPUuKw5GIX/2T?=
 =?us-ascii?Q?guuhj63Zx4mYgEzJVkQ5MRXl1NkMYhHx9NW08h9nW2B6mfrs1UPUxggPr5R7?=
 =?us-ascii?Q?Ujg471e9lqDvu0PxpQPDR/LQ4o8GFYSpGH3e2qluEbo5Hz7vdkVwBXqWY9sT?=
 =?us-ascii?Q?mhKQyHf9o2Lgq2goyNmhe2KsOt69LPf+TJIFTbXxA5M5XfMPfnBbp9x4NEMx?=
 =?us-ascii?Q?3MES74ef9K77lP9QVPcEqqLjwc15HeEi6wndyenreNF6k81OP0CjltwNGkrH?=
 =?us-ascii?Q?HHe3P1gu/nuIPQrNucC7halMbSZk+d/CML9LvppDhzrpPCnaQYlUqUbGADQ0?=
 =?us-ascii?Q?dt7rxoZMbcgMDG50ACpDZxKc5498ajKk4w90+MGIshijJu/IImbu+rxBA1l9?=
 =?us-ascii?Q?n7vF+OjOjUvCNUgzpJhRDm1+i45h1JqXTnhRQ/ljmKCcB9Gw5ojYBHhsOW4j?=
 =?us-ascii?Q?DUPlu1kTFHLy3aSnkU0ayLWHqaSJCGjfN2OoqkbLWgWaCyd4URI11AwBsmY3?=
 =?us-ascii?Q?l6LT9oY1j7JVCVGppNaj3p9oLI2patKQWaBKNTTF+x2+6hUOUD3zrtF8F9nT?=
 =?us-ascii?Q?PKmEfNL3IF60SvX7be5zt/J7Dnh5zlI+mAyC9ZkgYuN2qQLKd4r8U3dNxiO7?=
 =?us-ascii?Q?koKh5MfxjoF0gZTgIBG3utN3GigNmLQf3CDrlHCYPvFUjlsLPkZY7/YuxYWC?=
 =?us-ascii?Q?rTFgMHvvbIraw6JhYnjbD+jMBNizzKAL3Tn7gflAedzZDnmSfWeuZAk2yBKF?=
 =?us-ascii?Q?bJ5xCZ7bELNmGS9Hu++g/g3yVef7MWkS+93S1CCZTf13Scob8iQpQPRGXBj+?=
 =?us-ascii?Q?wp3i3OdH3wIIMC1ICrJIwgQsLrWbFEqf0SIrzc6PH6sDWBL3uNf5vf/tK31g?=
 =?us-ascii?Q?WjYA0yNKiDRwugjoOShmIkjB8vCVpleEuhN4UShhh+PdpfLPCizEaM5tA6bf?=
 =?us-ascii?Q?ANcx5bGex6AOZCBFwVNm7lxI9CH/IraNkoAIGD4hFuzYckzaYEpkpjHiIX+0?=
 =?us-ascii?Q?3Vh2NwtpCBf/FcLAQeSuwUdmPpPcF4HNtUwjK+9rBdvCZFNtIlapuxHrujli?=
 =?us-ascii?Q?FhRcRvr+hKknnwBrJmWDHMlkUEsR66tsRZ86APBR1kEcP+ILSQAaZ/+xjRe9?=
 =?us-ascii?Q?fD4YjZWp6zj3hIAc0xye5D0z8VsvJKPbcRkSCiCAM43KkJt7/PbcHrm+9Z0c?=
 =?us-ascii?Q?0/UtZYcKRrHzkyP5x8z+rK/HfHU+GSOqeDmYHklaQDChoFXSCM3Y7pIQzVcf?=
 =?us-ascii?Q?HgXJw0SCw9ql6Ir+QBEN7x4LWHEI4Fd3WxAsEWXGNneMxrJUdUcqB3qXaBSR?=
 =?us-ascii?Q?iKai+RMfwzE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HSF4rk9VQ4oSrdsULIzbaDMveLmgM9ecqpaSRu8xbvxDxkoVXsyFjqEgmzS6?=
 =?us-ascii?Q?AiX1EuubSkgT2CCYuHJC60wdG7lFLn0Noisje8hScx742Yayt9uTsignxtbl?=
 =?us-ascii?Q?AiESJXailxdMaAqCFGFLMi+2+5zYxnXPz63amh2RPILmYozJatNDDVkYhFiv?=
 =?us-ascii?Q?aGW4iS+nXD9Z8mrXWV69uOEVvPKfpyt2gWMwTfh+qAAXCG71BHa2n/BpBd8W?=
 =?us-ascii?Q?nTRnJRwG1/zbax5828qIj82l0/HM/lT3LNILb89X374pxlXH80FJkejIsg3R?=
 =?us-ascii?Q?qA111M0CfCcz/vbdnxlHkdTEXLBvklPj1brTdb2UlaH+U+IhzxlvAMoP60t/?=
 =?us-ascii?Q?gQb2Kkbrj23xBjnBu7gAyd6NHHnA2LRUxtXrjvFJEB/c4bAKc1WW1Q7mCGDe?=
 =?us-ascii?Q?IgVOvYYO0A4HVb4CbppFzZUDG+KEsPtMpvXXhavSr+Y/M0jyEOYk1yr8oI/U?=
 =?us-ascii?Q?8agg8ECwsoJKKsEZsRCE0J9aRtWh7hVJU+/+K5/zW+hYriwR7TUR9QwGTvTQ?=
 =?us-ascii?Q?tih6+nZw1lAxKKqXJQvV0BegyCl+O3QqiaI0duDLs3D8kxK8BXvkeLa1yL9G?=
 =?us-ascii?Q?1z+4euTZFpU/tpYbY0N1GNBxXfl6Gnm+VLgZDOZT9POGa0qRhNgQpqSoMxoc?=
 =?us-ascii?Q?xvrAdX7ZDhi0WH/tABdgetB6FNVx17Z+3CmWUHPV9RDlU5eMUzkc5zVbrPUj?=
 =?us-ascii?Q?X8sTe4LKLkTKUbFRUI7umlDUEL+sxHKO3HYolk8p4q1WT3jDU4T/h0FBRDyo?=
 =?us-ascii?Q?1ytHQk3RiNhPtd4Ru5AIj7Pugd5F0DsopaPlGHyN+6/gLY+FkiGK1cTy0NVi?=
 =?us-ascii?Q?5RwizaRGNijI3K6IAqzgdmqmEYEI9Ayih+5gXyr/2dVzd9NUyX0uBVZ9NuZw?=
 =?us-ascii?Q?UnjRqxDkzfJXch5DLfktv+uXOw++zTbldGIbc68eYxesMup09bQfcpWx06SQ?=
 =?us-ascii?Q?FRHsVUcpbuaSm6FoeQoyF5Y+b3uPFyyrtdzfcEczjXdUmrVuyNW83xZ6qME2?=
 =?us-ascii?Q?VT+GrKMtVtQT5CY4IBjwWAu005Uj5tqO40m9nEchB3fRdSLW7LbQG/maA1EW?=
 =?us-ascii?Q?/VG7sVHGNTTkUk40i8X8fw32yGqKNVohs4APFqw2vDkKdGQz2bWDLVJyK76b?=
 =?us-ascii?Q?4bKazzvSfAGXN+vvuqt+uMTqDPLQ+5OFceyrF0khqMsax3OqGWwws2tu19aR?=
 =?us-ascii?Q?EHv5qPWujWM6oMGB3G7KA1qq+nboTRVd0tHv++DdeOEKq8eLQ+jKAc3620SM?=
 =?us-ascii?Q?UI5rPF54R+IEtWek9dAexq3WaIPaH1wPKkTYuFKZFFGZj0eLVPuG4PvuAzZx?=
 =?us-ascii?Q?dKwmrqLfmwekYv0dwMsqz5Csm5Txg3HmwYgI+0VFmP1xZu4nhKgxhM8X6vJ8?=
 =?us-ascii?Q?sEtjDwsZoDCLu69OxdVyDxTvnuhRPDI/1lPavjx62WLqc4jwF+McZMC1J5vr?=
 =?us-ascii?Q?jM3WaMIr87Fg/lRveddXp3GXwffIdy4ag0kPa3WpcyZEy5SUNAVi9Z5OasJc?=
 =?us-ascii?Q?ejn5JoGHS67YFKjez3hwb3Tg7PYOQgppgJo62ziIvKzfr0Kh/Ct3K0THj/bS?=
 =?us-ascii?Q?OlwTZAuWzgDgKNmjtbo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b06cd8b-e6e1-44fb-7bd4-08dde0bee0b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:27:37.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2959mgxjvf43J3eAUFBgOeH0cPIPkXewvE86AzzpDL2ITzv+MLM3FRfjV9DGVZPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
Received-SPF: permerror client-ip=2a01:111:f403:2413::624;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 21, 2025 at 03:02:59PM +0200, Luc Michel wrote:
> v3:
>   - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
>     the SoC interface to retrieve the boot CPU instead. [Phil]
>   - Cleaned the mp_affinity logic. Drop the mask attribute and assume
>     it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
>     ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
>     description. [Phil]
>   - Avocado test renaming in patch 41 instead of 47. [Phil]
>   - Documentation tweak. [Phil]
> 
> v2:
>   - Addressed formatting/typo issues [Francisco]
>   - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
>     out if not 0 at realize. I chose this path as I don't have a clear
>     view of what it means to implement that for KVM. It seems to make
>     sense anyway as this property is meant to be used for modeling of
>     non-SMP systems. [Peter]
>   - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]
> 
> Hello,
> 
> This series brings support for the AMD Versal Gen 2 (versal2) SoC in
> QEMU. This SoC is the next iteration of the existing Versal SoC.
> 
> It is organized as follows:
>   - The first and biggest part of the series performs refactoring of the
>     existing versal SoC implementation. This consists in:
>        - splitting existing device types into base/concrete classes,
>        - moving from an in-place to dynamic device creation approach in
>          the SoC code for flexibility,
>        - describing the SoC using a new structure called VersalMap,
>        - moving the DTB creation logic in the SoC code itself alongside
>          device creation.
>     Patches are split such that each device is individually converted to
>     use this new approach. Behaviour changes are minimal and are
>     emphasised in the commit messages. This gets the SoC code ready for
>     versal2 addition and leverage the fact that Versal family SoCs are
>     quite similar in term of architecture.
> 
>   - versal2 SoC support is then added by adding the corresponding
>     VersalMap description. This allows to reuse the existing code
>     without duplication and almost no special case.
> 
>   - The amd-versal2-virt machine is finally added, following the same
>     idea as amd-versal-virt. The documentation and tests are updated
>     accordingly.
> 
> Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
> follow current branding guidelines and stay coherent with the new
> amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
> to amd-versal-virt for command line backward compatibility.


Hi Luc,

I run with this command-line:
qemu-system-aarch64 -M xlnx-versal-virt -m 2g  -serial stdio -display none -net nic,model=cadence_gem,netdev=n0 -netdev user,id=n0 -kernel Image -device virtio-blk-device,drive=d0 -drive format=qcow2,if=none,file=rootfs.qcow2,id=d0 -append "root=/dev/vda1 console=ttyAMA0"

Before these patches, ethernet comes up fine but with this series
applied, ethernet stops working. The kernel finds device and the
driver comes up but it looks like it can't receive packets:

eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:57
          inet6 addr: fe80::5054:ff:fe12:3457/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
-->       RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:4988 (4.8 KiB)
          Interrupt:17




> 
> Thanks
> 
> Luc
> 
> 
> Francisco Iglesias (1):
>   hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property
> 
> Luc Michel (46):
>   hw/arm/xlnx-versal: split the xlnx-versal type
>   hw/arm/xlnx-versal: prepare for FDT creation
>   hw/arm/xlnx-versal: uart: refactor creation
>   hw/arm/xlnx-versal: canfd: refactor creation
>   hw/arm/xlnx-versal: sdhci: refactor creation
>   hw/arm/xlnx-versal: gem: refactor creation
>   hw/arm/xlnx-versal: adma: refactor creation
>   hw/arm/xlnx-versal: xram: refactor creation
>   hw/arm/xlnx-versal: usb: refactor creation
>   hw/arm/xlnx-versal: efuse: refactor creation
>   hw/arm/xlnx-versal: ospi: refactor creation
>   hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
>   hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
>   hw/arm/xlnx-versal: bbram: refactor creation
>   hw/arm/xlnx-versal: trng: refactor creation
>   hw/arm/xlnx-versal: rtc: refactor creation
>   hw/arm/xlnx-versal: cfu: refactor creation
>   hw/arm/xlnx-versal: crl: refactor creation
>   hw/arm/xlnx-versal-virt: virtio: refactor creation
>   hw/arm/xlnx-versal: refactor CPU cluster creation
>   hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
>   hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
>   hw/arm/xlnx-versal: add support for multiple GICs
>   hw/arm/xlnx-versal: add support for GICv2
>   hw/arm/xlnx-versal: rpu: refactor creation
>   hw/arm/xlnx-versal: ocm: refactor creation
>   hw/arm/xlnx-versal: ddr: refactor creation
>   hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
>   hw/misc/xlnx-versal-crl: remove unnecessary include directives
>   hw/misc/xlnx-versal-crl: split into base/concrete classes
>   hw/misc/xlnx-versal-crl: refactor device reset logic
>   hw/arm/xlnx-versal: reconnect the CRL to the other devices
>   hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
>   hw/arm/xlnx-versal: tidy up
>   hw/misc/xlnx-versal-crl: add the versal2 version
>   hw/arm/xlnx-versal: add a per_cluster_gic switch to
>     VersalCpuClusterMap
>   hw/arm/xlnx-versal: add the target field in IRQ descriptor
>   target/arm/tcg/cpu64: add the cortex-a78ae CPU
>   hw/arm/xlnx-versal: add versal2 SoC
>   hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
>   hw/arm/xlnx-versal-virt: split into base/concrete classes
>   hw/arm/xlnx-versal-virt: tidy up
>   docs/system/arm/xlnx-versal-virt: update supported devices
>   docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
>   hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
>   tests/functional/test_aarch64_xlnx_versal: test the versal2 machine
> 
>  docs/system/arm/xlnx-versal-virt.rst         |   80 +-
>  include/hw/arm/xlnx-versal-version.h         |   16 +
>  include/hw/arm/xlnx-versal.h                 |  342 +--
>  include/hw/intc/arm_gicv3_common.h           |    1 +
>  include/hw/misc/xlnx-versal-crl.h            |  378 ++-
>  hw/arm/xlnx-versal-virt.c                    |  742 ++----
>  hw/arm/xlnx-versal.c                         | 2455 +++++++++++++-----
>  hw/intc/arm_gicv3_common.c                   |    3 +-
>  hw/intc/arm_gicv3_cpuif.c                    |    2 +-
>  hw/intc/arm_gicv3_kvm.c                      |    6 +
>  hw/misc/xlnx-versal-crl.c                    |  602 ++++-
>  target/arm/tcg/cpu64.c                       |   79 +
>  tests/functional/test_aarch64_xlnx_versal.py |   12 +-
>  13 files changed, 3057 insertions(+), 1661 deletions(-)
>  create mode 100644 include/hw/arm/xlnx-versal-version.h
> 
> -- 
> 2.50.1
> 

