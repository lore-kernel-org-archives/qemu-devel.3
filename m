Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1F9C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2e-0000D0-Qk; Thu, 10 Jul 2025 04:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2c-0008WO-U2
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2X-0003Zu-AD
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:54:06 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MA3c4020442;
 Thu, 10 Jul 2025 01:53:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d0BRxMv2AVTmI/RqCqQLXETwsopcw147SXhNq9f8c
 XI=; b=r81Ok60hxJ/us5dLW3UvDjSnrvwSMCLnRm0Oa8rp7Frpq886b63HohG25
 vSThe6rlbnP/ECkqzK7rnmnz+NTBAt5Wt3zN2xnm4je9IJyifSFA5yC2Fw4JCp33
 ZeKCU/rJJVWyCzzdIHaI/RN9stgC2OUNt/wuzeu/6UmFQQKgqxgrMXxpSKH7gbgt
 QN/Yxd6GUootaToE1qMiFZhVo/JibLLZfAqJjSEwpX4gXnzHVi0iT003ituaAlDn
 xNpbR8+OZpMr0A6dF6HUd9uTRBWMu2aIyr6ovsXpiVLwtdaL8MCOfie8UREALnBc
 5qeBjVnc6RmM8k4AcbPbThO3wflWg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvn294-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l83bI5syfseVYphP8iMbX8iOg82BMg4fCWZBmT8erAG4wR89VQA370PqrPQoa/4DW2ItRBY4qg5OWm04+N6q9GfaM1/p6ShugZ6Kf8ar6W+e9ecz7yRAFx8iKF1+Jd/0XjYNg1PBgKmkhdCdWyOlrGyqz6XYuyK2+lnDX+E0xcsoyOCUPsdltQd2OUXG9WPCLXno7hUlgV31aem6GkuHWSrakEjqS0/CTKD+d/SwQaP35ylRtn07H92YYU74ubFoA9w5FjSVGLUQgMgbTNWs5d6XSZvP704Rr4eeOvxQLTbM4yLN0DJ+3v93tvHLHnor0wBC0HwUh/XybGQbTVzBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0BRxMv2AVTmI/RqCqQLXETwsopcw147SXhNq9f8cXI=;
 b=X8awz6q8xaRp/kOQfafTM0E3RwbKt8KNefZ7PL6QURXm7bFkOPvXDD0bILrXp6/STP/181N0jypU4oHBOLfZL6M7SfJ37hvO5r/d2KinFGMsCJdjGbVB4tZuf7wHOSbywinG5Zuj4HAxmy/ltHyf0bnlHGoyuHwJb27QWl+wwpDxnsrf8PsAjKjUTJm1L+PxDrNzmC5LIb3/uEtwvbho9atcL7Vwzr5i1SI6K74OzEHSTdRITryrhtINVbbfKy2LqZf90CNJsVRa/uIUw2AQkEp/5eWpJzFq9RIXXrSS20pBis3QqJPJCqReXNp2tsLDMv/oKHSShGoYT/aaqrqYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0BRxMv2AVTmI/RqCqQLXETwsopcw147SXhNq9f8cXI=;
 b=ctmKR/+jueQ3b+1r+nS3vtil+gSrfbQRIHh0zht8cvsXnZ7yl8HY2MBbUxxl5e8EySWG04uY8YxJCsPT0qZINzZOJFDs9A9U43N0NQ8DExTRWU9V6FO4UO3t2F1ygSsfji7fdhNmYFhIuwBYszNUTjsJEs1h3v3C2Nw6gpunXhpxJ29jQeVDejhz3d8w/fkxy6PvKtrCcCrCKXTzVR1aT2/0sfQrCCmCEQs6yWeP0Bmd89UiwcQboJhREb9TS+RXm3DIkauZXGrcl9RUiflB0ioHeJOIxXRrXNzUQ8n2vxoMZol4m70NMNuIWfR0iHiW8WZGxe7yIKZkVwgl2l9K1g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 12/18] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:27 +0100
Message-ID: <20250710085308.420774-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: ef30950d-6c0a-4ffd-ef61-08ddbf8f4dc0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9mR2NQOG1DaE9iUEVXeGJXODVmem5EejVOMEpjMUlxVVVCRnBCcVpXNVd0?=
 =?utf-8?B?OUdMcUxvTUlrS0dWSUdXTFFSWUNmeEQ3QjZDQkxyT3pHc09ER3d2OElSaEdu?=
 =?utf-8?B?T0VidUpua3hWMU4xQTIvUER5OVVWN2RmSVFndUYxZTBMREp2d0J2RHJIRUNr?=
 =?utf-8?B?QVh2dENUcHpQRDZ6M3IvOXNXZ0hJcnc0bHF3d09pMmFxWWkxa0ZraE81c0I3?=
 =?utf-8?B?U0NQMTVOemQyV0NyanBFenBIMkxIL3EwWlkrSnh0dFpqMGh6d0ZXL1dreDVS?=
 =?utf-8?B?RUo1OEJWeThveVdwMHdKK1pPZjBHcGZGYmxITTlnRi96SCtTV3ZLeUx1TVRY?=
 =?utf-8?B?VXhzMEpSWmN6cVFZbmdyMGpuVXN3QXE5bVV6K2dpRDAzSDJwRThkQUc0enZX?=
 =?utf-8?B?ZTZFaTVQUTNPVzVIbzB4MDFFVWlrcEN1U2tSOExiaFg2dmdFZEt1Rzg2WVh6?=
 =?utf-8?B?MS9xWUluT3lPK3lUS1J6QUpORU8zanExdHEwQnAzd1RQWjNUcDk4bGE5cU9a?=
 =?utf-8?B?U0xWSjRnekl2T1dZNE9zbFVDdEZWTWU2SG11eElaRTJPZjZYRkxYWjdXY3dE?=
 =?utf-8?B?S29YdUtpemhhWGxuNW5Wa29RUEJkMUpET1ppQW9DWW9TUXhxZ2Z2QmVUcGhi?=
 =?utf-8?B?cUIyRXY5UVd1YlJGVUFoQjVLa2F5YjNiM1B4V0hwTGloeEQxRU9OM2ZyRHll?=
 =?utf-8?B?RVlyT0hvOU5LSFRlSVdVTVV3QW42Y1FCZVIrV0RSWE0rcmticVo1cHpQZkh1?=
 =?utf-8?B?UWhza3puU1ZaeXFxV3JxaVMzcjZDWmEwTmRiTWY3OUtsejBXWWZ1eU16N0pk?=
 =?utf-8?B?Yi9mcnFkN0FTTEwwWFNKOTNiSGNSenpUV1QzcCt5U2lKT0tPQVhINzRza0tF?=
 =?utf-8?B?RjYraEs2NUMxNGU5cCt5L2g4QTdxY0l2OEoxV1dnd2lqRjEwMVpWR0pSZjNT?=
 =?utf-8?B?SEh4WDVjWUFQR0dPT2cwV2dQSzhnbjVWbE5ndDRFaGVJS2IzV2N3dE9UVTBa?=
 =?utf-8?B?NFRxNURwYjAyTDkvOTl2OGR6cmJVWUNTdjNqdEFhSXFLQlFrQ2o1Sk16ZlVK?=
 =?utf-8?B?SkIzaG9TQnBjOU1RbHhMSVhpVk1iUzdZWnNsd3F5YlJVeTlSM2JBZ2FJbVc0?=
 =?utf-8?B?Q050OVR0cXRvUXVZdzRzZWJ2NndTd3lXUkROeG1mSDMxb0FpSHpPbCtBVDF0?=
 =?utf-8?B?UktOc2Q4QUt1OTliSzlnbWFNTTdRSGRjTGloNHV6enpmY3JDR3hRaDdId0Zk?=
 =?utf-8?B?bDQ0TnhsazBFc3hDb3F6YzdpVmMzTFNITUFzMnN2UUJBbzdpcE13TVhGZ3Jq?=
 =?utf-8?B?REJONDl1anJWNWVhczJJV1psZHVnNFF2ZmtRcEZiVU9QY3UyaGtaTzdqVXdj?=
 =?utf-8?B?cGRONWdMQjJ5bllSVmJlSWJncFVBdnZuK1YrTW5RbHd3WlU4T0VkTkVpTEN4?=
 =?utf-8?B?K0w5WFdBK1ZYam81NGRESDI5SXY3OHRaY2RhZ0ZkVmxiN3lZWXZTNGdGcmZ4?=
 =?utf-8?B?d3pDRzF3aldHK2twMk5taDVWZ3YzRjJYbmxCK1g4bndqdG5KZUdBL3FZVDJq?=
 =?utf-8?B?WjQ3bzZBQVpqQVU5cmQ3KzZaOU1EY2hwN0lTWFpKRitoQXJmWGlnTkIxUlVt?=
 =?utf-8?B?b1Z6VnZQVzA4bTFmS1ZmczB0TWlDbDlsdG8rWW01cCtVTERaRkZNNUgwdEFx?=
 =?utf-8?B?L0NheC82VkJUQVlNUUZBTlBEWmEydFJZR2tlYWhFd3IySGJNNUI2R0VsUDRq?=
 =?utf-8?B?RHJpc1NGSzNiaTM3TEk4UEtlTy90N0RjeWRpWHdRYVl0QnJxTmRLYWUzbGxy?=
 =?utf-8?B?UzREMGRrT3hpaDVwSDNUVU5Zdy92cDI0Q0lWVWNpdEpmSHFWK245K3pYeXBZ?=
 =?utf-8?B?Z29yZGpHOUg2RFNiOXBqZmdHa0N5bjdTVzRKU1AxYWw4eGVYbnQwNzg5b1kv?=
 =?utf-8?Q?CkHFkjk8EdI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlhHZ3dES3d5eXA0cWhicktMRWJrZTkwVnRCZlQzaXJOb05IREIwNXV6Q0lE?=
 =?utf-8?B?aW9ZMFlXK0plR0cxZmNIVjlwSUlhVXZpVi8zeGh3MHBVK3c2WFJmdWNJZExB?=
 =?utf-8?B?ekNBWVlGaVQ2blVBMmd1NmxGbTFFT0JLMHdOQUhGSjRsTzd6VmtjRHN3ckln?=
 =?utf-8?B?M2U4aGVyc2R4c2hDSitjbEkyTG8wUnZ2dWhzYTd0UlRISkdBTDNzTnQrcEoz?=
 =?utf-8?B?N0VMVFE1UWZNMk1sSXVzUXYva21oMDU2ZHRWSG5CZjlZT0xLaDFTSXcwRGlS?=
 =?utf-8?B?UWFta0FZUmdDdlpLNm12QTBzb0x3bjBZbGZtUmZ6Qk5OZDJ1L2FIeDNyY3l5?=
 =?utf-8?B?djd0TjF5c3NTUFgyamFvN2YzZlV5ZEJlcmw3aEV4VU40Uk9pTURkelBxaUx3?=
 =?utf-8?B?RlVEaS9tSnRLdFJ1a0dvdWlzM2xwWWtOTmdwL3gvVmlPMW9xeFVoSHZjeVYw?=
 =?utf-8?B?OHZZOTNjenc3MUpldURNWERmRlgxTXJrMDNJUHRJU3pkSFp6SCtvV0QwZHpu?=
 =?utf-8?B?UGJOL2pwV0dUdlRzMjAzUmNiZkcxV2I5SGN2SXpJZm9USjZSaGhBaklqOHZx?=
 =?utf-8?B?Snlmbi9pTDg5ZHdiZG9mVTdReUFLcjJvYlNYdkYwSWFhNkEyUHQ2TFlVVnM2?=
 =?utf-8?B?dVRtOFM0aWdnUjNMeHEzRzduVWI1KzVUcHlpMGErNWhTOXJhWlpJK2l4REJ6?=
 =?utf-8?B?Z1d5Y3MvY3hldlJlZVdabFViSmQxWnlNUmlwcmpmeGJSSmw3WFdiL1RiYW5R?=
 =?utf-8?B?R25WbnA2VEJlSThrbGJGdzdMSmxWRGFMYzFqcnM5cDV1ajVUVklsN3NWWXRa?=
 =?utf-8?B?L21IbVVJWExGaWJxc1lZMm9xRnluRStyK0FIeng5V0dxaVZ1T1FQbGhwQW9R?=
 =?utf-8?B?TjNFV21TNkV1Tzd2c212OXdyYm5XK2hiQ011M0xwWjBxMG8wSVphcnNHcnAz?=
 =?utf-8?B?RFFKMXhSQWpCMy9idzdlQjduZERjSysxUlozR2ZwSFR2WXJDQTdTU2ZWUFN1?=
 =?utf-8?B?U1pPTXFhbHUvd2IxZnVhdXU2YjZjNktpNXZLMDZnb1JPVk9rcm5yR09JWWNK?=
 =?utf-8?B?Y1VtNGZyZzBSRWVRRFlPVnhJWVZ2elVSZ2hXZks5MmhHdVg1am1YM0JrbjUz?=
 =?utf-8?B?RGtxQ083cnpHL2RUeXpWeWprWi9vVUFXcmtrczFxMTgvNU56ekZiM2VoYytx?=
 =?utf-8?B?cGhnZjZvNnZGVjhhWXNDMlVTc21PL1ZSbndXU0FVcHg4MUExZlFoRWhOd2di?=
 =?utf-8?B?WGxLbWRMQmNSc2JZNG9zTU9kLy80UVpiYzBsODYyTWdzUVZ2MzhTWkJLTGhw?=
 =?utf-8?B?WFhSa091S1pNTDFCek05bTh2NDBDdXVTNVpIMFlBZ0NiazVlL0hyUCtkYlBx?=
 =?utf-8?B?WGlxRzIvRkhpbXVLMzRIT3doNk40Mm55b1N4aTlZVnh3MEVtU0ZFUmhvaXU5?=
 =?utf-8?B?cy9jTmRrRHFkdUlmc2FGQW1aZmREcUZ3Vmw3K0g2T1c3UFlKdFlXUkl4eUls?=
 =?utf-8?B?R2NTUjNpa1BaeHpSVnNaaHZ5bmhXZWJBSmEvT1pXeGRPVG16dm9tYWxLSURO?=
 =?utf-8?B?RTBRQjkvQU1xZjZMaTFZTlQwV3l4Mjd5Qk1naHRXWXNCa2xYRXdSRUd6OXJ4?=
 =?utf-8?B?RUlha1UwUXZOT0RCNjN1OEJRNGVFajdnY1ZhYnFJMU1YYVB1UFdLZ3pscWF3?=
 =?utf-8?B?OFVTbWxXcmdxNlQrZHd3clNyNUpDdndLUGpIYlNndlREVUdqQURqeWd2Snhr?=
 =?utf-8?B?by9YNlpRc1orOE9WVUo5akN1RDUyZmo3Mkk3Rkc1dUhvbG9YNm9EdGtXWk0x?=
 =?utf-8?B?dXhaQWxuNFdCMGtLK0NWSHgwZC9SRnBoTFpWNFZIL0x6L1NiMVM4Z2NBb0hv?=
 =?utf-8?B?SXM0c3dMYWlzNjFHK1BJeVhON1lBNkJMZHdMQmRONXBzQzJFNEZTVlhUTFlV?=
 =?utf-8?B?bEJ3WER3aEVYeDJucS9QYXpGNHNoa1JLbXRlQ0l5eEVpUEpQakFXNStkMWJl?=
 =?utf-8?B?YXFkUE5wTFVBaytCZy80YmdDQjJCbkZScUdRc1RvR0NiYTR6TCswQ1htWCtq?=
 =?utf-8?B?aS8yTm5JWkpJZXZKODRXVXc5eXk3TDgySlZycGlEY0JhQjlxbFExYUlDTjBz?=
 =?utf-8?B?cElPU2xzekp0NThRSFFHbS9MZUpmNVVCSnhpKzI1NlBVTFI2blJIZFpWTzZn?=
 =?utf-8?B?T1hMSXpxZVpKbkcxZHpnYXpKMWEwV2VyQ3VhTmhPYmZpSTE1dm5SK0xOYkFN?=
 =?utf-8?B?WU5SbEY0Y3g0aE04cVBjdmcxMDlRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30950d-6c0a-4ffd-ef61-08ddbf8f4dc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:56.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unsuxvpOO6VmRVUdpnCRYK8rIghdY2g4U93dljzGfsCnK0ZUvqG0ygRK+dT9FKkplfASgyec1AFI72xsBJzfqfa109wMivV5NKkjkYv5rKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-ORIG-GUID: u7EwRlvkmZdaoWKX0bB3Z6a9yWqyVVh2
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=686f7fa6 cx=c_pps
 a=7kgNGXaSmB15KJ6u7rEBag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XqeNvJXGgvzUN9CD1PIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: u7EwRlvkmZdaoWKX0bB3Z6a9yWqyVVh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfXxDf4r0kTZlKI
 DTZ6fRBfZV7RT/YRQLgeCuaMxgiLyf4/maNFbH5CQ5/8c6Z3WoL+XXnP2Bh4OqMB7UMOpRoFYxI
 Lu/QiItFwr/+A7xHQYHx2IVYJ9f5WAzaRIjPzCyIiXszkvMzqozjtR1faBey97n33TriEXl2mCH
 9ZbIPH+QzA5DGNJr1dcWvkSnVXkA2KH99mIBvWfTl05wWPMhTI3E+t16MsPw9KfsWuf3pxmmS5a
 pFRInRxMyQLmKNGR4c/mLDI+KcLe/AVJ3+5RqXOnmHQopsVtbJEOXhnLfa5O6D+F2JZF3Pxwpg6
 6/9otsaOF+NlqLzTi9dCWCmN2WIzD++Tf2NL3FOL7gQT6oaQ7TMX29DtAVQAwnpxLjmTdLEk04b
 WK/BF3hpfQgKhvpyhoKnvPCatNi+jflQiEi00W5L8HLH/4qTaSxGrFsBdm4wqqL53hWDQoao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9832b5d6c4..7b38e37d7b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -473,7 +473,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -494,7 +494,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


