Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F717C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUqow-0007SC-Gk; Thu, 26 Jun 2025 13:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUqou-0007Rr-FU
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:55:32 -0400
Received: from mail-dm6nam12on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2417::627]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUqos-0004UB-Ay
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:55:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlgqE4cOjbWQ2KAZp4iL33Qeg/wtcyaYdx/GcZCaqFs1Uy6KDUExba4BaYZoRonLyd+3CPADg+syILPKbRqQSiURCCWw7eXHleKklRT9ONpOaWi1c+GfNV0pUKqlaeWlhQfunnAmPRApaxaDMSOLvb6dAqoX+6ZWGnWcP29a0bnvWzpT3i6+/VLIkHuxWDDApI/N7StRj8xviVABQ7CUl3bac6TYwSSjl1pCc2pivfOHQfarIrpt5heDloudgW+ABhbrCekJToHDqCXJUHiAJhVXdIgounT1W2XzuUhL8IEXW2JSzhXopclOu5EplTNjrQZyBt+Wl3jqXQazCQsQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y57xlAbt8p0n/Vtu+qJUjakzYLZIntOTaiGxitNH8E=;
 b=GDTquDwNypK/DAZkhWDWuS6wuhpgA9sf2own211aS/cz61+htETwNa24kW7mU73zcaJlg8XSzevR4FThOATP21/0m1EFadKf9C7dlerKi7HtxlfCr8m+3bkCyuia2ryjlmeTfLHJRgYcBsHM67ymOYQ+bTLGUCTZcXRx+gPKrV6frx99z4SprWkIURYwr1zF3seCC0twQRCiaNv5UTWf+R8zGe5g0WbrfUM1lw+z7rzG8Pw3Vmh9WKKErtgmmwdtgFdtnFVTIa4mehq4WXbt80U8xxq1ah4ULHh1MlIxj5V9f2qMPfBsZcjtMBP7ntn128IaC2DFQDtreYsZXsNu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y57xlAbt8p0n/Vtu+qJUjakzYLZIntOTaiGxitNH8E=;
 b=J+jttrVQK0DxjXlUq70vcUW0QIinEpvDh+rcPhRQszCtb8mW1OHd0tdhR1fXfzigaD/YLq0Xw8ppg8uRL3agrg3nCFUqAOLbdm2Jsroo6Sm0Yv37+GX6B3gzzboOvCRj8GMniuB0OWfOO5wz8WHqaNo60zdF1PZhN4/ubOglA0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 26 Jun 2025 17:55:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 17:55:25 +0000
Message-ID: <fe6c2d75-1662-462a-9bba-9296d9747baa@amd.com>
Date: Thu, 26 Jun 2025 23:25:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] amd_iommu: Fixes to align with AMDVi specification
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, philmd@linaro.org
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c51e3a-f779-4f29-b88b-08ddb4daa094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEFHdk5xUHN6T2ROT1hxYVY0Y1BEcmZuZWllSUYwTEFxNldqSkhYVThSZ2VG?=
 =?utf-8?B?ZmhzZ25mL3o0c2kwYzNXQ0VDQm4raCt2QkdaM0lFVFZoU2IyY0FzbDNYemhW?=
 =?utf-8?B?V2szdVFLVjFTMTRERHJETVkzVGRtYTJGQVFYZ2NhNFFHWU1URXgvb3pDWk5G?=
 =?utf-8?B?a3BSbDdyNjJESlIvTEViemdZQWp4MUhVdDdpamRZdFJVMnArUG9nN1FpYXpt?=
 =?utf-8?B?VU9mRklZWVRNV1VvQ0s4dkxXRi92SXRnUEFqS3l6UHp0ZGVBNDZhNDdaQ3ZR?=
 =?utf-8?B?OXRnZUYrc1hCUjdtYVV3dTFwOHlVOE5tVGY3UVAzK0hSWWVvZHExZzJ1aTJj?=
 =?utf-8?B?YWZ2RFJCdXVrNGYrdVZsQ0MwbEdoY2NPSU83bk5tUVZPN1J3dW9WTHY3U1hZ?=
 =?utf-8?B?WHZ3aUhjaTFkWDRMandNUTJodGFyNUdyVWNmR2g2RG1tdXF5SlhEZ0d5cTN2?=
 =?utf-8?B?ZEZaZWRBMUNjS0pYR3NoQU5HM3dzREJqRkhHZDV1and0UGJwbVh1UnhCWldi?=
 =?utf-8?B?REZ6Uno2SFVzZTlvRnA2ZThGV2E0TGh1ckFxNEF1UXRRM2lzMVQ0V0c3c3lG?=
 =?utf-8?B?dXdab0I5REpTNHg1VnRFWjNuMU1BR3JpWGFyWko4cjRXcko3bGNQajQwbHlT?=
 =?utf-8?B?Y0tkNC9vcitqM1ZkazBpNVROVHlaY0FYLzNLeU5udGJlVUE2MllMREhLKzJx?=
 =?utf-8?B?Q0E5NWYveUNkSG5VUjdLNHN4NFNmck1pa0xMdTNxT2h4VE1JUVRETk4zMi94?=
 =?utf-8?B?SThZRS9aUy96V3RGTHp3WUpBdHZUVUJJVjEwOTFKT2F6bEx3VzV6dFVISXVl?=
 =?utf-8?B?Mnc2azJ6REJBbXV2ekxRVzR0aiswbWhubEhXRzA0NmpNS09uQ1NaL2RQdGFo?=
 =?utf-8?B?TTVnc3p1dDNKOFpSUlZXNkFkdmtxMmNkdGY5R1ljVnViNG9lK1BFVjlMVzB1?=
 =?utf-8?B?dnI0eEk1SDNCcFVmZ2ZsVE4rVVY4QTljRnQvSTlHUmNwc3NFQXZsRUFtYklu?=
 =?utf-8?B?UVg4Lzd0ZWFENWszb0hlZUNGWWkxdzlpV21jd2I2M0FCdEllaWZhWUhqc3pi?=
 =?utf-8?B?UFAweEMzOWg4NFVwbGYybk9va2F6MlQ2QkMwbCtMSEE4WEhvN1hXSTVnSFN1?=
 =?utf-8?B?ZXZJRko5cC9DTUlGMkQxdnFXSzZhWTFhMmx0ZHprN01DUXplY3VXa0wwV0d3?=
 =?utf-8?B?TUNybnNYenE5akVpTElFT0l3cTE1Z1EwbUZzMUxOZldjTGw0QmY0YXl1dFA2?=
 =?utf-8?B?NmhqUXM1Ky9malEwZkp3a3ovbmpZdnNVS2lXZ0RBZkVVeHkzRmRoOGVQUGNr?=
 =?utf-8?B?V1U3cUtESDh4b0taZnY3K1pUN3lrZzYzL0M3dFI5VnFNK1E2RW1PWlljNlEz?=
 =?utf-8?B?QjVwQ3FCbERYNGx2T1JCcm12V2xEMkhZam4vNTQ2cmJkelFwSit3a1ZpdjhN?=
 =?utf-8?B?cUlDTExMcW9GL0Z4cGFkSmdSUkpYWHRoV2tvbGtXdVhveEdyOFlrTFN4RnNG?=
 =?utf-8?B?VldpTkdLaDd4cEtLdkI0eEpDM3hSRzB3aS9JVnhpREtscHQ2VUZxODhBNSta?=
 =?utf-8?B?OGJvMWNVQXoyQzBySnpINnNlNlRLNWp3L1JVMzN2cmlXZmFUUFppNmIvK1Ir?=
 =?utf-8?B?eXFmdmNudHhEMDNaYmYzOHpBcmtUZWJJd0o2SXl6V2RyTGRobmVLQTIxZ0lR?=
 =?utf-8?B?RmZ0ZE9CMUtpK3l6dUpuZ1h0bFZoc1hNSHEycjVVeDVTUTkvbHhFMDlLMUdk?=
 =?utf-8?B?eWVIQmlvekhtVjBFRDVDL1Z0OUJTTzlXOWNtcGtILzQ2aUN6ZkljVjVtZDBz?=
 =?utf-8?B?akxxMVhySE9hbTU1RSsycExCdEtETjBkRGdhMWhKa2xPVkJ4S1YwaUtjM2I0?=
 =?utf-8?B?Uzc4LzVtRldQU0krNHVoVkJ0V2haa2hUTzdrMFdBYjRER0c2ZGk0NWIwbDhy?=
 =?utf-8?Q?0n2rh9/vpPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtoUVY0R3djdHkxRGREWVZ6WTNYYnMrSW0ydlVnc0dQb05mSmxUQXNLVUZw?=
 =?utf-8?B?RmVjYi82RDFRY3lIWE1QTzBGWTdiWXY5NWVCYldCTTZZMWVrdzd3czIxbkdC?=
 =?utf-8?B?dENnK1lDcSt1ak1PMy9xa2dnZjh5UFhpYnJOVCt0bjRpTklDR0JRbHhxbVk2?=
 =?utf-8?B?S1BMT1VlMHNJVlJab2x2ZGppTHpHakprbDdsbW1mbENWcVNpRFZQVHNRaTg2?=
 =?utf-8?B?MWxRM0hhRzlvWGZObzQzWUdualpmaTMvNFQ1ckVvVGJVZ2NoTUtFKzdNQWgz?=
 =?utf-8?B?L1ZYRGJWZkNxcWl0d0xpMEUwamNsTXpqSWJ6TXY1YzZGV0NOVlIwMmRKRWZI?=
 =?utf-8?B?NUxqTkdEMGdRdi9hRVVTMC9zSW56VThOV3VwV3M5dk9vZGxpS3RMOUczemd0?=
 =?utf-8?B?ejRTNndJbThmck5JK2M0Nzd5MC9YbmxpRHVYZENTSUlmZXlsSU5sc21KSEV3?=
 =?utf-8?B?bFRybVFuU2ZwTklPUi9DeUJKeit1WHF6UzM3TTNkQkJCMHBRWEZUR2xIcXY4?=
 =?utf-8?B?ZDlMUmZlVzRxSDhaTEovQThUTWFQeVlpU3hST254YXZOQ0RNSXFMZk9SQjBh?=
 =?utf-8?B?SzhGcXdYMk1XL2dSZWY5cDFpaWtzekhnZVRZbjduVHI3NHBxeks0YUY3bWI4?=
 =?utf-8?B?V3RPR2t3ZkVFdHF1a1BUa3BwQUxXanRRdG9TTDIrdkFjU1lJTFZhTzhKVXBR?=
 =?utf-8?B?MklaZWpycUNXd3o2T0RUSkZEb3plY3I3YWJVQnBDYWptQXBabmtTK0Y3WEVu?=
 =?utf-8?B?NmJ0bzBkdDZDczFYTkRWLzRFUnBPeG95MUxucU1ZNWJCSlpVeFpJTTduWHRJ?=
 =?utf-8?B?S1Q1YUJjU0lZelgwcU1aNjVNWHpnL21MNzZyUlZlKzdmaDdVbmZtQm8zemcz?=
 =?utf-8?B?dmlTSk9odzdwdkU1QXBvcXE5OG03VGFxR3MyYzBMOG9MUGlRTkF2SGpWQXZL?=
 =?utf-8?B?ZTZJYmdCcUgrNDBpcERpVE1LUlpXU3hsbWU0b1AxRmx0K3lLUXA1VXBrU21Y?=
 =?utf-8?B?NWlwMFBaeFVTNFZsLzFwMktkR2RDZStCd1gvb1NHL04wRzZRN3pZU0FWUWtF?=
 =?utf-8?B?cEZwMXhzTnE1cWR4QjR5U2JRWVBUdTZuSStxbU9EOEJNUTVlZGtQU0hHbXBr?=
 =?utf-8?B?K1NaRHp6RHgyVnF2QUZzVTRkVmF4YWRtUi9LYis1dkVXMzl1aWIxZE83NFZ3?=
 =?utf-8?B?UTdVcEYzMVpFbUNSR1d5WVl3N3RoMVJmOVhweGR1NnNpYXcxcVFBMzFCN1NC?=
 =?utf-8?B?a1hiRGExblhGLzZMRnNBMzZheG95SDZNdHdQR0J2VlJoY3VGTm1xZnUvdnZ2?=
 =?utf-8?B?aFZNZHBId1ZGV01meWtSd2JPeVBGak1YcnF3cUNjblZZRVhiVUgwTHJBbnV5?=
 =?utf-8?B?clhuV1UyWWVzVkl1Mk1Tb0tiZzNNS1RsZFplQkxOQmZ0K2tKd0s4dnFNN0k2?=
 =?utf-8?B?TmxoNU01MmFJaWVldlBXWEtxOWZvVWI3Rm1JZklZT2w4enpuTkkzYlZPeTdN?=
 =?utf-8?B?T0RzYWwrRmxISU8xMWtzeFl6aUpvcERLMGtVOXFyMktjTk9VNDdLeExMdmU3?=
 =?utf-8?B?Mm1qUUFDRDF5MndjRzRVNTd5dHN4TVZybnhMMnYvWmtzZzdycGY3enJIRkZS?=
 =?utf-8?B?L3o2OUNBZ0I4eVZRNjhTSkdNMlh3L3JqaEtPaStOd2xPdFcwMEJOQ3VxMjFG?=
 =?utf-8?B?WWZvNzdvSEhycXdtMmlsS2ZiWG85ejhCTUtHWFQzNWY1cWgyRzFlZStDZmtS?=
 =?utf-8?B?cTNhUlp6ampYc3BEUWdEdks5eUlyanVqMHJCR1hoUVNxd0JYRENTMWdqY25J?=
 =?utf-8?B?cGhJb1VnV2JlSFRWbXVCeFNiV1h5TVd3Z01jVThNWFphUWRTYW9QNDVQRzZG?=
 =?utf-8?B?ZFh0ckE3UFpBLy9VM3Ezcml1alNnUG1yNG5QV0hMR2xoaE55MXNJa25sdFdX?=
 =?utf-8?B?aHJhaFRZblZSNDk2bGtnVGJtSkpPc0V6MHlmNTBzL3orM0xaNndkMjFmNCsw?=
 =?utf-8?B?eGhGTWdvUk5ueGg2NUF1T0QxaVRGYzNIaTd2Zm41bTBXczg1em43U1haZmcw?=
 =?utf-8?B?cDR2WVhtZkszT2hDYXc4bXBaN0UyYVMyVnQ2aFlVeFdlOUcrU2svNjFteXFm?=
 =?utf-8?Q?kq4tqVDco4LsQwNJ4m0CQa0ag?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c51e3a-f779-4f29-b88b-08ddb4daa094
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:55:25.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is2Zm5LgjX0pty/S6pyl7EU99E9xJxluMqRB8N7kiqwtQ2Acj117pE9mpn/bGiT+A5FVQBIkjD6VjcNHh7/sdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
Received-SPF: permerror client-ip=2a01:111:f403:2417::627;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Hi Michael,


On 6/17/2025 8:34 PM, Alejandro Jimenez wrote:
> Added two new changes based on observations from Ethan. Like the rest of
> the fixes in this series, these do not trigger problems today given the
> limited feature set supported. Re-tested the series with emulated devices,
> VFIO passthrough usage with amd-iommu is not possible since merge of commit
> 31753d5a336f ("hw/i386/amd_iommu: Fix device setup failure when PT is on.")
> regardless of guest kernel iommu mode.

I have reviewed this series. It looks good to me.

-Vasant


> 
> Changes since v3:
> - Made an additional change in PATCH 1 with correct encoding for
> AMDVI_MAX_GVA_ADDR, adding Ethan as co-author. Dropped Vasant R-b.
> - Added patch by Ethan fixing truncation bug.
> 
> Thank you,
> Alejandro
> 
> v3: https://lore.kernel.org/all/20250529193023.3590780-1-alejandro.j.jimenez@oracle.com/
> 
> Alejandro Jimenez (7):
>   amd_iommu: Fix Miscellaneous Information Register 0 encoding
>   amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
>   amd_iommu: Update bitmasks representing DTE reserved fields
>   amd_iommu: Fix masks for various IOMMU MMIO Registers
>   amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
>   amd_iommu: Fix the calculation for Device Table size
>   amd_iommu: Remove duplicated definitions
> 
> Ethan Milon (1):
>   amd_iommu: Fix truncation of oldval in amdvi_writeq
> 
>  hw/i386/amd_iommu.c | 17 +++++++------
>  hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
>  2 files changed, 38 insertions(+), 38 deletions(-)
> 
> 
> base-commit: a6f02277595136832c9e9bcaf447ab574f7b1128


