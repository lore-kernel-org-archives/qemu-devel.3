Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77D3C35FF1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 06:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tumfa-0005if-BG; Wed, 19 Mar 2025 02:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tumeq-0005WM-SZ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:12:07 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com
 ([40.107.237.82] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tumeo-0001By-Fr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 02:12:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9BppmhIH4gpsboifY3a5IMKdK78U7Gq6X0Lk501EtO2JqTFswh0P/fHGDvoauHpgrVuUHLSidf8TphiXgtgz81zDF870U7k7IIO5MeA3xg2fVd3Qn1ZN5dmUz1yQsvZ0aEyIUVmqGjbcyN6WX5oHZq6psIrpmJlHlcqpGZiklXnqN3EmrzbO6t6Mu8Zd2FnS85jylDvs7qX70BSfFhhTV4OlTriUEY9YgrONWT0heSfSlQx4KK3PO4lCNlQVbz5cnwMn6TKsbLFa2OqudzJ/lqmY8fm3yeVHjy8Erw6mcqC0XDbhyv3VEC/UammuLCcun7K5W81s/zCr8rokFcosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ym4+B1k5T2QQGd2xHgb34GQVYOTB8iwlLyzTTV2/2J8=;
 b=uDe9H/EV+9xd4MmAswoEMlqQt8+P4uSMs8TF88cfa8Iq2+9wYw1Bv2fpccQzNmhgS34X4ucgKsoMhviXia9M1/0BispuMAzm8VKg8bZWvxMe/ZJh9FJT5Vw24cRPNpnKrkhXT3zHWP/3LdTRDiY+ivxT5Ccei55PUXyakpz/WJGF7SxqcogRFcw78gghQU7EydMMPorRd0rNYQyNWqLbUJv4glCSqze7wXbaHAzfx3dIr0btXAJ7ccZRLg67CGb5ToCXJh8VXmw+5rpKNp5hOxgLSBy8DA0+1nPwyhlHiLuiPz8H/K/qB4b76ovVlCNnXPZE90Tqo839bJ8Y/1EuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym4+B1k5T2QQGd2xHgb34GQVYOTB8iwlLyzTTV2/2J8=;
 b=jWPbaRu2h9hhcKzNz0UOEwTklGXOuJzXXOiKDUZNYNUv9fs9vYF3K0IcaS+jVF+TnvI7X+qYPUTFDSyWroKCZJ1c/gBqp82rZ72q3PPb4+z4HqqKBonVh/EAZSk8A0XLkracFsw4BcLpW4erPOw3x8R3/Beu4S8I6rmAQv7GqFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 06:06:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 06:06:54 +0000
Message-ID: <1c69c44f-6e94-4c44-8fae-8216c66f0a4d@amd.com>
Date: Wed, 19 Mar 2025 11:36:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] amd_iommu: Do not assume passthrough translation for
 devices with DTE[TV]=0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-7-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a426e0a-673a-45dd-70cf-08dd66ac3f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmE3NnpjNERuaHhJZVJ6OFBCV3pyMVQvTUVaVGo0Lytwa3BYVVVicGVzdFQw?=
 =?utf-8?B?N2JDdHovR2JweGlFRkFVUGFtRTY0bG42L2RaRi9vV2I1ZkJGa1R6ajBEcS8x?=
 =?utf-8?B?ZC9ENWQweUhuaVdlY25jVlg2YzYwenBkejJnV2JEQkdTdzhuaEtwY1JybDBj?=
 =?utf-8?B?aFZtcVEyQnhZTUdCZFhoVDlQRmFoSVpDU1I2ZWtaR0RvRDNwMnE1a3FwT3Ri?=
 =?utf-8?B?WkRGTW5XZVNuUXkwMEFJWVZVNHlnY090ZHpBUDdiZWxqQlZsVnlISTZPZlhv?=
 =?utf-8?B?ZkxuTkdGYUhZSHU1UzJRVzdjRFJ0eWNGejJWSDdiajRXcDdQTSs2amkvQUkr?=
 =?utf-8?B?U1hBWHRqZW92Q0NxbVFBUzZYL2h5bTBpYTJqZWxzMElZeGdRcUR2N0tnZHRU?=
 =?utf-8?B?bTlHdDEreVpQOWVqazlucm1zUGFBYTFkT3dyUG9GdUJVbzdZTis3S2pyRTBJ?=
 =?utf-8?B?RWdFZGVLSG9DTFZWcTQ2QzVvNVhNTENMODRWUFZVUENMZVFNR2ptZUYyYzdW?=
 =?utf-8?B?M3RFblRVTFJnTFFMQXpVR0s4WVhObnB0N3FBN1BFcUdjcVFlTnlzaWRUK2Fw?=
 =?utf-8?B?WWwyVGJ1ZzlFR1k1MmhjOUVHUTQybjQya3BBVExLdUNUeXMvdm0wUE5JaWRC?=
 =?utf-8?B?T2xwME9FWmFPeVlxZzhPZXcvV0tWSkVkR1loVHA2ajh3MXJIb2YzQ2F0aTM1?=
 =?utf-8?B?ZVJZUjhLMnJDbmJ6UUtjcmVMdWY4N1ZDN0R6Y0c0d3h3UkZaTGhzMjJFTDBE?=
 =?utf-8?B?RFhjTUZuOWp4VTFjTExhNXpQeU1vVnNWWmRJdDZWOXFWLzdSMnZBNllob0RJ?=
 =?utf-8?B?QW1DZEJvZGF2RHN3M2VJVWdiakR5UXNpUyt4dnpDV1Rwd0NiQ2lyanNiNWNa?=
 =?utf-8?B?U0lIaXowK3RqNHQvTGh1c0lJZGMzTWVRUHIrK2ZjbWdqZER6aVNCMURMSkxt?=
 =?utf-8?B?bDN3dlRTeG95b1ptT0NqK3MrSExGNGFtM2dLc1hzZ2FxazhZbWJTUVBQdzd2?=
 =?utf-8?B?RmRWOEhlblJRL0xTUHlmbkQxNUlvNUkxRm0xSDVvYXdnVXUrNUo2Qy95clRR?=
 =?utf-8?B?NEJKNjlwRi8ycTdxSVJLUVVvSS84VkV1S0F0cUNoeXJqd2dwdkRDdEFHbTQv?=
 =?utf-8?B?ZFByM0dLaFhhWE9wSitwd0NDNklSOVVpUFpZa0dGbkVWOGZWN2d4RTgydlc4?=
 =?utf-8?B?cjRnNm9UWUoyVUZHNUhpd1BMSVBLS0pxRnNzMUdnZThLamVwekYzRUsyaXZN?=
 =?utf-8?B?dkJTZUo5Y0xocWNOOVliL3RoTmNUdFNYbmN0bUhpemhXNkNPTVdYbHJhNGtr?=
 =?utf-8?B?c3JjZXJtajdxdktZTkRjaUNxNDNraTFNZjJpWlV1SnFUN3NOK1dHS2wwZHRs?=
 =?utf-8?B?ZjU0S1pjNGpUQTVQZ3J1c0FNQ29jVkRlaEErbGZSNndLZ2hMVmE3Q3NtWmox?=
 =?utf-8?B?NU05VFpvQTUxcjN5dU9GZmdaTk9zdng3cS94czd2bGI5SXA5QkFVSnNIRldx?=
 =?utf-8?B?OC9tZ1VXMjM5VkpGcmFTejNZLzQ3c014SkZiSHAxQlRiSzh5emlmbXhOMUhi?=
 =?utf-8?B?ZTg4V1JCeHQ0U240UTJFb0IxVWkxd05sNU9nTWFTVGxNTzBJY0h1NGJKSXhF?=
 =?utf-8?B?OE42T095ZzU4anBSR3ExVlVnSktvS0Q3aURWS3NtT2pqeUc0dnowbU16SGVK?=
 =?utf-8?B?Y2VYTFcwbFVwNDlKRmh6TW85azMvVGFpT203d1lKNlgyckFBU01rWHc0M08r?=
 =?utf-8?B?cGNab2diSWxGNkd2S1ZyUzhaRWZYWFFuTHpQQkhIdFhHVHloTkd0MEZEVHFB?=
 =?utf-8?B?cGFoZjlPQm9GZzdESWxLY3ZqQ3JEY1E1Ulc5MVhmUjl3SUZ3RUtSVm9DU250?=
 =?utf-8?Q?K0kEMXI8GOl3s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk4wRHVNc1FERUhIa3RPNFAxUTg5NVVkU3I4SUxVR01CMGhhL1BWR2N4SGlN?=
 =?utf-8?B?dUNLKzhKWHNWQ3Y4VGs4ckhUWEVVZmhBcVp0MUZUWVZlYldYT3dGVWU1eVRU?=
 =?utf-8?B?WlFicDVXWUxNVU5iQjNkd0Rwa3dZNWZZNDAxZjg4OXZaM1BOV2pZTC9pTmxI?=
 =?utf-8?B?ejhNS2xvdUI3VWM5L3hzdmFoM3NzWHJ4Tm5ycDZ4ZTBqdGZuQVNRNVAyZm9q?=
 =?utf-8?B?K09xenJKWFJKYTBpK0JYRW0wYng3V1c3RDdvWTZyWnJ2K0orQUd5a2t1MWt2?=
 =?utf-8?B?Z2pVc0FCRk5HUWs2THlXdmRobE5kRzdveHo5VEtBUEVTL096V0taZ25yMW1w?=
 =?utf-8?B?WHQxY1p4SzhvR0p2OFFjQ1hRVy9oTmlwQkdaZTNqUllqd2dNZ1NMNzhodFpp?=
 =?utf-8?B?RUtxenhzOFVMa2U3SitDRXBZTFN1ZWZhUlp5Sk9paUxFMHNVa0pQeGxaQ2Ux?=
 =?utf-8?B?SHlGMzJrRlZEd29pU3duaG9PN0R4NXNoWUZTV3pTeEY4MDRmVmFDN09rWTRC?=
 =?utf-8?B?aU9ZNjl0VVNFL0F6NHg2elZ6M1hmSDhJMVNtZm52TkQ3L2dlVllXbjZ4bWI5?=
 =?utf-8?B?ZTU4aGhxVW9ja0U4RklHc3NFcDkvQnpXU2MrZlFBYTJYajZ1UlNGalJ5TFBI?=
 =?utf-8?B?dis1R2hpVHVKOVk4cEpVSUtqZkdsOWdJUHA3ZUsvSDMya3paWVdmZmFMbTBO?=
 =?utf-8?B?emhVVW55TEpPaUkyQkhMM1RXL254Umw0TjZUdjJhZHMrQ3ZHcDBwYzB5QmJW?=
 =?utf-8?B?MkNSaGd4eDEzenloRjRYbFVWbHJzeS9pOStwWS9ZTDQ3cXdaelB5RGVmU1Ey?=
 =?utf-8?B?dG52dHIrNFU5OExxZzhsRXlFalE4cmdUQVp5VnQydGlWU2YyYVNXQWxZN2xz?=
 =?utf-8?B?aWV5ZlJDbm1malVGa3plc0VFM2dkYlN1Q1BaWElhOWZLK2Q5dWE4NExxYlh0?=
 =?utf-8?B?L0lZUVFCV2ppd1o3TkRhMWpKc1M5NDNLYlJEbzJ2WitieHUwZUM0Y09iSTBK?=
 =?utf-8?B?RUxVRmk5UCtZU3E3cTR4bElmeWZCTEhKRkdjWHR6ZHFRWGlUMUwzK1ZiWnVN?=
 =?utf-8?B?M2xFWEdsMzVFaG1BOHhuMndTOWlNQzN1SEJGTmtUQTVFekJqQ21rQ00rRGtH?=
 =?utf-8?B?M0pDSXJCVDFpRHdLZHlzQkViYi9RRHNibWNWWWlYZUkrTldkU2NZc0tYbVIv?=
 =?utf-8?B?SzRYVkFVNUxkSlpPV0QrRElWNk16QVhneEYxcHMxV1d2dGx4WUJGZ2VXUVhV?=
 =?utf-8?B?dVVJRzdoVlhqdEVxTEt3YnE1UFFzRGdiM21ocGgrTnVzVlJBZ2h4Z0hwUENY?=
 =?utf-8?B?Zi96bUZjdU9YNysydTVGL1NDbkxFbmRsdzA3aHlIZHNuU2FHTGR3YktwcWg4?=
 =?utf-8?B?UTlsdE4xeFR2VmlOZ1BmUlpnbktaRlVLU1BiNnYxT05QM0tSOThQVEp6WkN0?=
 =?utf-8?B?Uy9tSks0VmwvV0VQa3NMUWVadjFRUTkvdUdoU1FiNWpob2FILytxRlZRREl6?=
 =?utf-8?B?NUtBWmpINE1manV0WVpjOE80WUxaL0hxS3p5aVRxaW1NMWxXZVJtWEpJNlBY?=
 =?utf-8?B?UjFuajZVRytkQVdyNjlQK29XUitCa212aFU0M2ltSndBTUtHaExxa0dWRnE4?=
 =?utf-8?B?cFp6bXQ0RkQwSjJtTElHTUNUakRRdE1Uem13MXlJMGZ1bm1adklwa0RtWHpH?=
 =?utf-8?B?Z0hOMGVPMm1WUDE0RGhpTWw0Vy93clZKVGp3N05QeWVrbFBkU1ZwWGU1bU84?=
 =?utf-8?B?S0ZXZ2JzTHMrTUJtQllKUmlmNFJ6VGRtZ3l2UkNQNmFvenFzbWxCVzNOMmd1?=
 =?utf-8?B?WmJWTC9UOWpoUFl5TWJoNi91QUx6M0FoQVBvT3pLWXptdUQrTVFIZUJKdDh1?=
 =?utf-8?B?VHozVlJ6K1JyVDd2M1JBQkNBbzJjaTRveXB2dUFhbU1jcFpDTzhENzF0b3Rj?=
 =?utf-8?B?M2xUaEtvTnkwZ1VHajZHWnl2MHNmRlFET1FmNWlBdHA2SUpoUE9HS0FjWG56?=
 =?utf-8?B?VS9oNTZkdDA4K3dKVzlaZlpxb3pIWk96ZytxY2xvSE1JUTA5YVExdFNtU204?=
 =?utf-8?B?SHI0TTMyU25USEVQM2JGMnR6ZU8zZVh5VDVueXdmd3VPRkIxTFAzc2dtbHhJ?=
 =?utf-8?Q?n4ZYXffR6Ct+BWl6fM/fINZHs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a426e0a-673a-45dd-70cf-08dd66ac3f6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:06:54.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1pA2KNpk935iQanO5sGmyTRT7K9a83lXVYhp3+l1ZPh5Hc13iVzdmYh3lfg438UXAIX8eajxTq36ceiy4wPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
Received-SPF: permerror client-ip=40.107.237.82;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Alejandro,


On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table 8: V,
> TV, and GV Fields in Device Table Entry), specifies that a DTE with V=0,
> TV=1 does not contain a valid address translation information.  If a request
> requires a table walk, the walk is terminated when this condition is
> encountered.
> 
> Do not assume that addresses for a device with DTE[TV]=0 are passed through
> (i.e. not remapped) and instead terminate the page table walk early.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

I did double check and I think this patch matches HW behaviour. I did run few
tests w/ this series. It seems to work fine for me.


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>



> ---
>  hw/i386/amd_iommu.c | 88 +++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index cf00450ebe..31d5522a62 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -932,51 +932,61 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>      uint64_t pte = dte[0], pte_addr, page_mask;
>  
>      /* make sure the DTE has TV = 1 */
> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
> -        level = get_pte_translation_mode(pte);
> -        if (level >= 7) {
> -            trace_amdvi_mode_invalid(level, addr);
> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
> +        /*
> +         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
> +         * An IOMMU processing a request that requires a table walk terminates
> +         * the walk when it encounters this condition. Do the same and return
> +         * instead of assuming that the address is forwarded without translation
> +         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
> +         */
> +        return;
> +    }
> +
> +    level = get_pte_translation_mode(pte);
> +    if (level >= 7) {
> +        trace_amdvi_mode_invalid(level, addr);
> +        return;
> +    }
> +    if (level == 0) {
> +        goto no_remap;
> +    }
> +
> +    /* we are at the leaf page table or page table encodes a huge page */
> +    do {
> +        pte_perms = amdvi_get_perms(pte);
> +        present = pte & 1;
> +        if (!present || perms != (perms & pte_perms)) {
> +            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> +            trace_amdvi_page_fault(addr);
>              return;
>          }
> -        if (level == 0) {
> -            goto no_remap;
> -        }
>  
> -        /* we are at the leaf page table or page table encodes a huge page */
> -        do {
> -            pte_perms = amdvi_get_perms(pte);
> -            present = pte & 1;
> -            if (!present || perms != (perms & pte_perms)) {
> -                amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> -                trace_amdvi_page_fault(addr);
> -                return;
> -            }
> -
> -            /* go to the next lower level */
> -            pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
> -            /* add offset and load pte */
> -            pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
> -            pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> -            if (!pte) {
> -                return;
> -            }
> -            oldlevel = level;
> -            level = get_pte_translation_mode(pte);
> -        } while (level > 0 && level < 7);
> -
> -        if (level == 0x7) {
> -            page_mask = pte_override_page_mask(pte);
> -        } else {
> -            page_mask = pte_get_page_mask(oldlevel);
> +        /* go to the next lower level */
> +        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
> +        /* add offset and load pte */
> +        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
> +        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +        if (!pte) {
> +            return;
>          }
> +        oldlevel = level;
> +        level = get_pte_translation_mode(pte);

Unrelated to this patch.. We may want to add check to make sure level is
decreasing. Something like
	if (oldlevel <= level)
		error out

Otherwise bad page table can cause the issue.

-Vasant


> +    } while (level > 0 && level < 7);
>  
> -        /* get access permissions from pte */
> -        ret->iova = addr & page_mask;
> -        ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> -        ret->addr_mask = ~page_mask;
> -        ret->perm = amdvi_get_perms(pte);
> -        return;
> +    if (level == 0x7) {
> +        page_mask = pte_override_page_mask(pte);
> +    } else {
> +        page_mask = pte_get_page_mask(oldlevel);
>      }
> +
> +    /* get access permissions from pte */
> +    ret->iova = addr & page_mask;
> +    ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
> +    ret->addr_mask = ~page_mask;
> +    ret->perm = amdvi_get_perms(pte);
> +    return;
> +
>  no_remap:
>      ret->iova = addr & AMDVI_PAGE_MASK_4K;
>      ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;


