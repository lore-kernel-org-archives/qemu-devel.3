Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE34FC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDQE-000823-0S; Wed, 30 Jul 2025 16:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhC6H-0002C6-Vw; Wed, 30 Jul 2025 15:04:44 -0400
Received: from mail-dm6nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2417::610]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhC6E-0005qK-9l; Wed, 30 Jul 2025 15:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOvrZB77yIK2b4r3O3+Z1oM2wFxuunwOsDCd9414XnrW88Gb2i9atYmZxXtzcEROqZ8VC8kgfKviiyLDsnA+LCTwJKLnk9TEcbHeLm3UTWdo1FTFAS4eN3euN9a9xT7LEG0Gl9JQaamC8QZceBbUmoELAeYcl3r4w6rqoND/z5Iu0lCa6cmI4D9vtv/EX+QFAsGLLepuP8YlWfYDckaoTYzj3zUyvj6yjLFBeBqfivwx+7I946p7cSskhfd7+fNeG3u/azXZClrz2CJUw9P1yUzyYi+AVNCayFoS/NH8xz6z8vSp+40vIXyvMbn3fI6gMyTd+IK/izBIrVgHBhlNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07kzzpFdGouZzAjekYFf8F54M5WQ8sLgVPlNAjmulIg=;
 b=y/IMH1zlSNoVpTHhGJkspvwT6fCMNn3xMpybIh2h/WSJKfQfaYdG6xwnkjYaG0YNJu4XQQaxOVB+7msbYE/u5X9yBrmfVNQp0BCKL4cOnd+ZYxqZ01/YUsE5YRotFxTcny1FqKHu7k007UNdF++SIm1kSclE2nf3wMqjZxqywswHUHMuAZn4ZUDeH+gOnY2dzddieYIn2iMEidKtXhEMD6VkTTk7jxUR1Fkqnh8yavPeN8ins0H+rXSb6+T3hzWKMcUabk3mUUOU+YXN0TGFUW4sX1/U2Qs9Vr95iVCo922CroK96TgeTDXSRKn5SZAy8Bhu5zZkFFKUwb6fb1AMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07kzzpFdGouZzAjekYFf8F54M5WQ8sLgVPlNAjmulIg=;
 b=iCc0MZiT+H+NvqbL5dhlQI4kir4L7CNXbEb4UjQLSNHR9733wKHI4KhKZ3bHU8T/u+g5wrrORW4YBZEqrjz5OsMiHYTXPvfJ8a6TJQVOGplo3oZp5l1aV4HuryJOZF7RIzB74XZh2SlaHcoMZnk9qEs9D2ryKXd8uff7g7fTsCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 19:04:18 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:04:18 +0000
Date: Wed, 30 Jul 2025 21:04:12 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 28/48] hw/arm/xlnx-versal: ocm: refactor creation
Message-ID: <aIpsrIRn42fNF0sW@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-29-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-29-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::7) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b51cf7-89aa-4b76-658b-08ddcf9be24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qk4xcjgvT1JQQlpIcXB1cDJ6YXcvWUFZUU94MlRBTnJYdmpUWitQTko2ZXgw?=
 =?utf-8?B?TDhhTWdsU2R1S0JJZlRhZ21oMmg5cmhZc0dESDNUNFNFOWt6OFB2QWdTWkVD?=
 =?utf-8?B?bUkyQnlQODIveUQ3YmV0WXFXOFJJTkJKaE43QUxZQytEOWRRR0RSNkxWUnlw?=
 =?utf-8?B?UlgvVHlJTFlVSXJSQnExL1Mxb1JEVGJvd0I1WjgxcXJwZlN0TUFYQ29Kckx3?=
 =?utf-8?B?K3hKMGlSQzlGTi9vVC9GRlZzdjk0QUZ1N2xWVUJ1R3NiZEZYSXY0U3pjK3pO?=
 =?utf-8?B?SXJkS3A0ZWtvM2dudjNhQ2YvRXAvbFVEcGpON0wzQVpyREFyMUpGakd2QU8x?=
 =?utf-8?B?TTFrY0ZyNFZYUk5YaWtUaCswVFg4RGozWFdyVkVDZGZkK1hPc0sySjhLTXIw?=
 =?utf-8?B?ZFlIck9zelhza0orbGk5MXJLUWhxZTQySTFXckI3OHJiM0cwekpWcndXaUJV?=
 =?utf-8?B?TUgxWUlka3FHbVpzOURMQVFJaHVWNi9PUXhzcFpRREFBTXFoeTFxeXZ5ZDhs?=
 =?utf-8?B?Z0VReXRZYVZtbEQxamYwM3RSenM0S1R5M0ZjNzNtZmZDWTlRajR3V1RFdHBB?=
 =?utf-8?B?STh0ZHlkTjlOUmk0OVBXOE9UYmpLcHE3TW5UNy9RY0VYenFlY0ZFK000aG8x?=
 =?utf-8?B?L1ppNjlpK3ROQUtLMnNxTVdRSXNJZkRjK3p2ZG9WRGhPalZHSk04dWozeWtO?=
 =?utf-8?B?dzNwNXp0cDJDNXNsNUZUNzRXK1ZYSlNLWXdXb24yM1lsdEo5djBiMmdHTS96?=
 =?utf-8?B?KzlIS1dwd0JXSlEvU1M2M1JvTHdLR05qeGI1RkRLa2lvU2g5N3JYUVBMekNY?=
 =?utf-8?B?WEg1VW5VcXdrV3VUSjRURkJOcXlteDJmKzlZOGU2MHYybmRHV2tNNVhFenBK?=
 =?utf-8?B?Rkk4MFpVOEl3U2Q4TEhwSEdxaFdBZXRROUZuS2g2V2w4RTlNZmhmSnd0dEdu?=
 =?utf-8?B?WnhkYmd6Rk0zbXVReDVGZER6WmlKVWlJbm4yWHVDb0wxa2F6T0tFWTRwOUpy?=
 =?utf-8?B?RVF1dzFsVnd6bGRHSXNzQ0lXbS9CWjVQUG1pcmNqS1J2NTAxekkzbU1WWkxk?=
 =?utf-8?B?ZUozcVFTNmtwczZva09hV0w3RGljWXBKK2pkbzZ4NGRyUTVBamJqVXlyckVI?=
 =?utf-8?B?MzBPUDI3dkdwaFNHc2Z6M3RSaVRsRktMUzkwSy82M0FnSklaWjlZeGtqdVZn?=
 =?utf-8?B?NndsNXR4c09sUWdrWWZCREl0bmQwV1lxRjlXMXlCY0llT0grRVBUQnYzbzdJ?=
 =?utf-8?B?WWU5VWQ4eHgxc0RMRm1GTjJPaVJJTmE2Tnd2UnFISnFjOFBwQ3oyQjVsdGJ0?=
 =?utf-8?B?N21TS1E0Wkt4U1F1bm5US1dXZlJuZFdNYlZzTkNENXAxblJtNzFLRENKZ2RN?=
 =?utf-8?B?dFIwQXcwL3BDTTc3VG14Y2NWLzUrS3dLS3hVUi9zMWo2ZnRiVGplRnB5VE5k?=
 =?utf-8?B?ZWJRK2ZLaFl0WitIWlBJdGRkcTBudlhrL25XTUtxRXpnS24ySDJQQzE1dXdm?=
 =?utf-8?B?Q0p6VHVCclBZa2taTllLTjRMVkZOMlQzay9iTjhtRi96ZWtTQ2hOcndBM09j?=
 =?utf-8?B?bjZrR3dDWEFFZ09MOGpLS0lHd2dQN3hmRm00c1lOOGE2aGgzeXlnUkQxcko2?=
 =?utf-8?B?c1ZoeXlWWDV3WmpXd2huZ3FIVFVrMVNrT3Nwd0Z4NVk1OEhaWkt1c3Jobm9L?=
 =?utf-8?B?M0tvemtMQ1laVDRVbGZMVFBIVTBYYm9HRFp1YzVRdUU4VHlTYWNJSXlVUVNJ?=
 =?utf-8?B?aEZmWFc3bTlQYmVaQTlmaDZkdEl2YWJqL1lYNXh1RDZDSFJSRWsrVGU3eHJ5?=
 =?utf-8?B?ZS9GYThxNlkxZ3l2bDJ3MDRUK1VsUFNVcmtQbGc2UldjYlVwV3ZtYW5WVngv?=
 =?utf-8?B?Z1JVV0V3Sk5IQ2Y5MERla2h0NnZwRUc4Ylk1NGpWL0FuL0JYMFdZcC8vUjM3?=
 =?utf-8?Q?Ec64dBxlq8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDBGK2F6T0tSU1BNT2VMUkhTb20yeHB4RDdFNE1EMjdBSXg4L0o5TE13K0Mr?=
 =?utf-8?B?bzNHTkJ1OG1pNW1mR1RGTmQrRjlHMHhHVktQbTNwOW9EeHk5akY1WTA1T1JK?=
 =?utf-8?B?VjA4SmJTc2FFOFp2NGxEaElQMnZ1SWhEQ1JmaktiM2h1ejVKMWlpYjZKZkhE?=
 =?utf-8?B?b2lDQzFCY0NmaG5UZWw3OXRScVFJSndJRHZXSHRUM2hwRCt2S3lMcC9McFFh?=
 =?utf-8?B?OEZCT1ZSSkczbkRadTcyRERQTU1OaUZ5TGZvcGhYS1NHS3lsaGdCYWxWTncw?=
 =?utf-8?B?WFU0WGdxQ3oxOURoN3BKR1VlUUJ5ZmdnbWtocXJodTBmZ0grbTA4aXRoWG5j?=
 =?utf-8?B?ZWVMeWFZa1F1T0kvM21OSHFFN2piL1Q4QnQ2TzhvOGdOd2Y1OXc1YjRpY29C?=
 =?utf-8?B?b1hKYU1yQXkybWNHTUw3RmZoZG5MUk0xME5IbDhFYUZVUXdNcTRvSjc1S1ZB?=
 =?utf-8?B?bWpqMnhSMjA0dTEraVI2NXArZW5XcXlzQnMwbWtMSDFHRWwxdURJOUg3NVor?=
 =?utf-8?B?a0xYdy9ZWU9MRi9JbHJmYytzUTNVK0pvMUJ2K1ArbDk1WjJVSVZnUXRpWDFM?=
 =?utf-8?B?blRTUHk2cDZVNURlU1RmMFJzTU16TVhDWjJOdzRLRSs2TlBlZG52WWllbUk0?=
 =?utf-8?B?R1dtdXUyMlNoeGZYOUFBMEw3S09za1phdzlpcGdXTUpaMitkOVlMSTBLbjFT?=
 =?utf-8?B?b2o4UW5VV003dENhVGNPSHV0bExjcklwNjlDVjdMRnZVbm15OXhjUGRTZ3ZN?=
 =?utf-8?B?YkZ3NEZZb3ZWRGRYcU9EMHJZc1M5ekc3V0pMcy8waFZ4Z3ZySTlXS1hFQWg0?=
 =?utf-8?B?TE5JcGo2OGx2VUpWdXliaFYvY1hUdFV5ejhOWEV4SElBWE1NY0RnK2w1T3Qx?=
 =?utf-8?B?eE50bVFzRDF5VEtxaThSdDZERnZhNzVrWHdnQTBHTm5jRXFsYldyQS9IT1FO?=
 =?utf-8?B?Uy81bUZnUWZFL20yaENEbm1DS1RmMnBnaG9Yc2wvQytBaCs1UHZPL2J3ZzVs?=
 =?utf-8?B?N1UzQmwrZk1mN250aXJicnQva0NtT1BDTHRLdzgvTzZSUFpQUW5tbkkwVDdR?=
 =?utf-8?B?cytJWnEyQ09acE5ldVpIU1RFS3U1L3FlKy82YzI1UldzMFFwOWJjRGFPTy9p?=
 =?utf-8?B?eEhCV1AxNWFLcElPQ2s1RkoxTnE1TS9OcGRTcmdGQzZOV3MyUUNyb2RneWNZ?=
 =?utf-8?B?ZDQ3NDhKVElDckliM2VWK08zOHNGdWZEUXRjWjZJSDVYYkJPT3YwandscGdm?=
 =?utf-8?B?K29wckxwOGduak1ieDhzVTFGd1hhZkx0b2cwRXB6WnZrV3lORmVaNmtkQXdx?=
 =?utf-8?B?WWE3VUp6c2k4aUJMaW9mMjlQVDlWUW1WT2lwVm1ybXdLblBKeGlZMnArOEdG?=
 =?utf-8?B?dURuWHY3SGZ2WHVaVlFrRDZzbFZ0SEpnVDc2Mm1taHNLMWR3TXh5VklvL2kr?=
 =?utf-8?B?NUN6d2xKRVJQNGlUTmZBemRQQm9qRlJCLzNhQzFBZnQ0MnJzcWRmemRCWWdM?=
 =?utf-8?B?OEpITzVHZkZNVVBYZHZNb1N1NHBFL052Y2Vwb1VCN3lUSE1PdEtTL3ZiYlVO?=
 =?utf-8?B?bDBGaFRBSlJXKzI5T3YxZGxWWC9Cb0lJRklCWW9YSlpQVnlFNENZSW5XaFdq?=
 =?utf-8?B?REplVzc0T1pVRWNOWW9Oc3ZOMlozQmN6VC9zUk9EMDE5NHh0emVZYjMwT3pT?=
 =?utf-8?B?ZXVLekVmUXhEZnNRZ0pJeUFSRWFrQXBVRVNKWGxldnYzR3VoYTgvWFh6Rnh2?=
 =?utf-8?B?eXMxR1ZSWko2QldGOGZyblArZlNpR3VKZlFuMmFTZTV0OGZLSDFyb05WZVZn?=
 =?utf-8?B?N3FUaVFtSnp1N1pJQXp6WER5SGx3T3FyS0FnajVabW5kRTIwZys3dVh6Y2tv?=
 =?utf-8?B?OFVOVmtiUGtrd1ZDODRxckxoMTNWZXI2R1lMQUNFWUNzYVo3SldxdXdhQzcx?=
 =?utf-8?B?S21SM0FxMHRSc0YwVXZ6bFpNdmdwemJrNzNsdlZZd1cybzdPNTFSU3Y0dURI?=
 =?utf-8?B?aEtkdmJzZFYxT1dUa1BwejFNRzNVR3VPVFQ1OHdVMTRwU1NyV3hPQkJabHpV?=
 =?utf-8?B?NWFSRHlXRE16YlhUTmxIWkFiYUNuZWVKbUpiNGhndWsxNWN4UTZiMXdFS2dK?=
 =?utf-8?Q?XDtlD/O929V3IDumHVsk+PgVZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b51cf7-89aa-4b76-658b-08ddcf9be24a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:04:18.2679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfgf9fBHALZHvcIQ18E7NL8tP/UsR1ws1PJTgdsRKUkuCt1Fvw/AFVyCIXOj7mgUNoRcq68/0dZtFxNHyU6qaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
Received-SPF: permerror client-ip=2a01:111:f403:2417::610;
 envelope-from=francisco.iglesias@amd.com;
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

On Wed, Jul 16, 2025 at 11:54:10AM +0200, Luc Michel wrote:
> Refactor the OCM creation using the VersalMap structure.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  4 ----
>  hw/arm/xlnx-versal.c         | 20 ++++++++++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 62b8d234ecb..7be5a6ccf4d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -46,14 +46,10 @@ struct Versal {
>      struct {
>          /* 4 ranges to access DDR.  */
>          MemoryRegion mr_ddr_ranges[4];
>      } noc;
>  
> -    struct {
> -        MemoryRegion mr_ocm;
> -    } lpd;
> -
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
>          uint32_t gic;
>      } phandle;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 3905549b32e..f46c73ac8e7 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -71,10 +71,15 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
>  typedef struct VersalSimplePeriphMap {
>      uint64_t addr;
>      int irq;
>  } VersalSimplePeriphMap;
>  
> +typedef struct VersalMemMap {
> +    uint64_t addr;
> +    uint64_t size;
> +} VersalMemMap;
> +
>  typedef struct VersalGicMap {
>      int version;
>      uint64_t dist;
>      uint64_t redist;
>      uint64_t cpu_iface;
> @@ -108,10 +113,12 @@ typedef struct VersalCpuClusterMap {
>  
>      enum StartPoweredOffMode start_powered_off;
>  } VersalCpuClusterMap;
>  
>  typedef struct VersalMap {
> +    VersalMemMap ocm;
> +
>      VersalCpuClusterMap apu;
>      VersalCpuClusterMap rpu;
>  
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
> @@ -207,10 +214,15 @@ typedef struct VersalMap {
>          int irq_num;
>      } reserved;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
> +    .ocm = {
> +        .addr = 0xfffc0000,
> +        .size = 0x40000,
> +    },
> +
>      .apu = {
>          .name = "apu",
>          .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
>          .num_cluster = 1,
>          .num_core = 2,
> @@ -1605,10 +1617,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      DeviceState *slcr, *ospi;
> +    MemoryRegion *ocm;
>      Object *container;
>      const VersalMap *map = versal_get_map(s);
>      size_t i;
>  
>      if (s->cfg.fdt == NULL) {
> @@ -1678,14 +1691,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
>      /* Create the On Chip Memory (OCM).  */
> -    memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
> -                           MM_OCM_SIZE, &error_fatal);
> -
> -    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
> +    ocm = g_new(MemoryRegion, 1);
> +    memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
> +    memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
>  {
>      DeviceState *sdhci, *card;
> -- 
> 2.50.0
> 

