Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AB5CF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfTXu-0005Bv-QQ; Mon, 12 Jan 2026 20:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTXk-00051c-DN
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:50:02 -0500
Received: from mail-centralusazon11011002.outbound.protection.outlook.com
 ([52.101.62.2] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTXi-0005tC-In
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luCSyH40+Y0MD/D0ivbpa/ScjYkbxwa7X4NosX8FFmGLXSWsiFPzryoP4Xv6bZ4UVRKVCtNch5x7xpIcckieDFDjCs3YbE/CNEj6SjwUObq97OaKNmFejiNL/4fjfnxkl+1DkMulsPfI7sVyn8XQnr0nPbnKD8YgSjWnd4GOZmyTFqGoizpkrymHCkOxAUN2+PRWd+UeeL+dKW6qqpzAPl6MvaLi2qKydn1DLEI/A99RaPVm1zXpPbOpuzTBjrKmhopgwe8Uj3xtAxQwZwbo27BYSXCS9cOmGnwfNFgE9cS9yyHQRCklQxkoKHf/5N9LIi+57CkpF1HbPkHWFPWnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfw+a9beZZxBlORJV2wxGOs7QyLZbQ/leNpEQ1FSB3w=;
 b=QOsNJ+ftWEyqXqNbfDWE+fihX6nzgiNt1GHI0+qKmCz2O5e9tT5wgVg8GHaXjSyGvVApUzGF2omFw0aTAObYcbU1fUQ5Z4TisOAHgCCctwlEEKc70klyJfEtMLadMa3MSB6NuWdqsR1GxclU0Q4qxtJBj26iFltHs/RPYYaRhwUVrR3AsXDH3BwzuzKyDz/ilk1Czu9scgCeh1nM0nKgX2No/Et8TKGI99KUvV1UsUW4epclcMN1zeO9haCGOdBPg3P2Rt0mbVGqG/DKJg4r8BZi/PFjm40l/VCd6A7l2a2YLFp3CW28NEy2s8UXLZOEnPVNPkYrO/S9vxaN5y073A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfw+a9beZZxBlORJV2wxGOs7QyLZbQ/leNpEQ1FSB3w=;
 b=ZtcAH5e1et8UiZfcGcHTZ5ZdYDRrdkd5nZ7YaZe9zHBEiygu/dThOagVQvfU/SGkHG5COuujfrD/ILzoP3XfAWUEXF9SPQj/y20bQtEohgoC7sp15Hl2AUyW5LOoQCRJYKDls6mymHrJlaB17PdReiGaadZ6bpYPlts9JOpCqCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:44:51 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 01:44:51 +0000
Message-ID: <42e92bfb-d258-4435-9aed-9d5fd56a89f0@amd.com>
Date: Tue, 13 Jan 2026 09:44:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 armbru@redhat.com
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-3-honghuan@amd.com>
 <777843d2-f840-4093-8928-c1f700631bde@linaro.org>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <777843d2-f840-4093-8928-c1f700631bde@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 272e5ea1-0374-4c6e-9388-08de524557db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2hHdTgyL1RQNWRWL3pSRVVTOVp6ZlhGNnVCS0ROejU1VGc3WnQ0OFJCc0pj?=
 =?utf-8?B?QVJzd1JxaTJ6bnpiNWtLNmQ5QXVlT2NZL0t3OHVmZkVLODkvVGUvUGpJL3cx?=
 =?utf-8?B?enJrMW9ybGs3OUEySEo2eDc1bnpvL2pUK0VaUi9YTmhwL2dHRzBwNDFiaTF6?=
 =?utf-8?B?eURLckpkUHBvbnlqOTQ0RkhSaWxzRkNyaDE4TnRzVStGekE4aC91RUZJTVZS?=
 =?utf-8?B?cjkreG10blNHZmFOV3dVdFRjM2hNRGJyVVB4WmJ5ZmluMjIrL09UZmhUNk9D?=
 =?utf-8?B?WjZueE50d2V0bTZCKy82YVNHWWdTa1lmVEJZSVVyR0p0dThuTzlNMHFiZnRR?=
 =?utf-8?B?ZFpjK2U0a2M0UnNBOWJrZk5vdUdGY1BCdTBpQXFLQmZpOVp4STJyd0thbEVi?=
 =?utf-8?B?NHRIS2tpMWFyT0UzbmsyOXY5QmVhMHd2bUYyS1pTdjNnTkZxbEZGOFF0am1v?=
 =?utf-8?B?NkR5ejNQUFAxVkdWdG41ZVArYTIvOWxBUndTK2ZReU5hZ0k5K2JETnlCSWhM?=
 =?utf-8?B?eFR6a0dlenAzWGFzU3E1UDM1d2d2VHZneWhyanNMNzlaS1Zob1NwZ00yQU52?=
 =?utf-8?B?R0p4WkJtdGdOS3pmMEdqcGttcUhManlsK0RpbFV4c3JrMHV4U1RxdThVVU5m?=
 =?utf-8?B?VktVWDNSSEVPK0g4SXh3ZXV5TDVkOTJLSyt4Ky84N3JLc2JjWkl1Q1lMYURz?=
 =?utf-8?B?cFgyRHdnS0VxYmJiOVI2NTBkVXQvSStqL0Q5eWhlaGRCYU44MUcxRjlzOG0r?=
 =?utf-8?B?VjRNajBBRVVxc3BnaThqeVlENlc3YlNLbE1iYVRDN2NRWlhCMVVHNHV0bGpx?=
 =?utf-8?B?OXZtY3Zzdy9VcHV0dm5GYjVGWVNkczdGaUZSSktZSThPRkZiL3g2UTlnMDlQ?=
 =?utf-8?B?ZWNzaW1uL1J1OVJ6OFZlWTZFM1hNdUFlaUF6dW8ya2JBbnFBcjZidG9QWXhG?=
 =?utf-8?B?Q1RDNnlOZjZWRjFxeW4yMWxHdmE0Rm8vbVhJbWo3ZjV5SnM1U1QvdmRzK0dn?=
 =?utf-8?B?K2NHeWY0UHVobS8xbmpEQ2dRamsyRkFEc09mUXluWDc5Y0ZGZklBVjJwMnZZ?=
 =?utf-8?B?NVEzM3RFSllmZENDUml3ejY5elhqVHdwRTA0REVwMWQzMHpjb1J1TWF6a1VR?=
 =?utf-8?B?MlF4bGlJdFlNeFB1RTlOMXBya3gzR1FLVjJCVThkQVV4RW5mcEMzRWNDRzlX?=
 =?utf-8?B?anJOT1lQaWFUZk5Gb2s2bDM3c1VlSGMxMmZHMWJrV2ZxelhDa0QzZGIwSnFO?=
 =?utf-8?B?a0FIcWM2cWxwaW5aYnNhSlpHVm5xOVc1NVptVUhpRG0rdUppempoTVBTOExq?=
 =?utf-8?B?OEYrQWFHUDQ0MUlQRGRQbUJocGRGMjI3SnRlbmdyQ1QxNzlEeC9GSUUrNHQ3?=
 =?utf-8?B?eVNqeENoLzl3R1lBdGF4R2ZkckhTTHVpeHh1bW55cG1ENVJyREQ3U3hQczQ4?=
 =?utf-8?B?NEhNVjkwbHFXTXM3Ritma1pobzhsdFM4RzdnWHBvVU1SVnlCcjY4VlBxekUr?=
 =?utf-8?B?RngybVB6Rk56UGhLcUNIRWlnS1dPMktKWWFyWXE4WnNhMG1uaWowVmZUaVRY?=
 =?utf-8?B?RkhJaUQ2MnF0MHZMd3VCRVdlWllIVkhTcXJpNXgxMUhMY21ZTWpST3d6TCta?=
 =?utf-8?B?TnJ4aUVIRW82enRldFpDNExIeHg1VkdKUlp3OTFVbkRObkxWNTFvelN6OHVr?=
 =?utf-8?B?U0VENkNLTG5wcGVTcld5Y0cvNjc1eHpWQnI1VHROb1BMNU0zTVJpSkNKajBD?=
 =?utf-8?B?NU5Dd3ExVFBlbkZyMDV0Uzg2cmN2em83NTN4R2w2V0JHWVhIemk2UDU0SDRu?=
 =?utf-8?B?K1UrSWZqUm5CQ0JTc0pmeVNmRy9jcFAvbUY4Wk13b0FHeWc3aDBqWkhiUjZM?=
 =?utf-8?B?ZkMyOW5pMXV0eFAwUlNZbW83Q1R5b3h4SCtZSVoyUFl2MWpYZUtkSTRYVXNH?=
 =?utf-8?Q?2XkgRSfd8va+Xu5aco9ZwE4hgebfRkJs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1OU3BXbGlDWmRaVWxvMjY2NGtUaWdVbm01cEUyVXErVHBBbFQzVE1qQzNP?=
 =?utf-8?B?UWxpRTNxN1JzYnVJbVRLcjh4NHRuNnNlcEFOWm5PNkZNUmp4YU9jbHFoUGp1?=
 =?utf-8?B?MWNDb2dSOHdrRm96akRWdmdnbFF6a3BMMFVkazZpRGZqaUlMMGw3QTFPZFZ5?=
 =?utf-8?B?S0JndzJnVEpOQkdKak9RMEpqMDQwcXNad0UwdXhTSitpamxNQ2FnUnZHOTBQ?=
 =?utf-8?B?T2haWlpic0grRHg4SzFGMnh6RTV2WWMxNStCY2RaOTZERERTWmRhdW40SFpm?=
 =?utf-8?B?ekk5Y1g0b3FFRlhVTms1eVIzclh1OUtLdGZ0cmVEZnU3MnhKczNGM3JsVUJz?=
 =?utf-8?B?SmVFa0MwZDlNNGw5VU0rbmVvZFNxU01leW13ZHRLbkFCSnVXMk9nRjJaUGpG?=
 =?utf-8?B?R2pOUS9Da0dWb0g4Y2lIak95SmNMWGVpTGlBajJzVlRQdFBnNlEvTStzZTQx?=
 =?utf-8?B?d1N0cVdHblJlT3B5aFhrMWlQdWp3YTRzMmtjVDVVOFNTTWhkN1RuRENqQThp?=
 =?utf-8?B?aGgzTTA4aGhiUllkRDlrSzUxd24yM04wa2VYMmYrZEtkVExBVnpVd05NUkJL?=
 =?utf-8?B?MWh3eDZadkpYUnJQNFlZM29kNG9Vc0tJZm9zQko1SU1oUzBDaVBRbU0rMXp5?=
 =?utf-8?B?c3FOQkNjK0U4NFIyMENlbDlGTEZWU2RPZzVkbkhhWG1zUlB5S2dlT2FHdlFE?=
 =?utf-8?B?LzV3V3lsWWU4L2FmVTBuOGcxY2JjQktLUE1hM2JKZUlhcTRNQ1pyZWxHemRD?=
 =?utf-8?B?RUNwRDR5dFU5VXNXY3gvZ29lMWhBSkdQYkw0ak9TVyt4aXpVMHl1NndyRjNp?=
 =?utf-8?B?cTN6eUg3V1hQWlliNjVvRkZIZjBqaGxyRUpnT3g3bEM1OW1KYzNFVWdrNUw2?=
 =?utf-8?B?eVJvYjlqbEd6R3owY1FhVWFXZnR5TGw4VnJ4VXVZVm91emF1L1MvTE11ZmF4?=
 =?utf-8?B?NTZTUmROeHNUbGhPQ1ltUWpsS21yV1RMcDFiVGh4ZDZ3cVJ0WU8yU1lISXlN?=
 =?utf-8?B?OHJZYWZqQkdtS1lxSWpLYlJadGUrT29NdmxJeEVpVVhiYVBCQTFsRHZrWFd5?=
 =?utf-8?B?MFFLem51S1J3Rjc0cnFxK3htQkw2Wkl3VWNXTnFLQmk1K0NWZkROZkNJeHpi?=
 =?utf-8?B?YUJZWHg0c0JIcVlqMjlpeEpOMHJtd0I5cENQbk5zNmt1YlhJUng3Z3Y2SW5o?=
 =?utf-8?B?R1BYRjl0VkpnekJ6Q0xkSzlaa1dVYk5iY09wbVpoajU0QmFIbE5GaGhGQnJS?=
 =?utf-8?B?TzdnYkJnVXhOWXlnbDVIMEthS1Zyc2JZRXVCS0MrTTUzRXpUcmVaendtTDJu?=
 =?utf-8?B?cHFPalRXK2VCMGFtTVdLMW1WOW1rc1UyTTFnZVZxR3ZqY1lmaWVmaWl5RUZM?=
 =?utf-8?B?SmR5cVFBTjZNd29kSHBFVkYvY1JmTXMxcE9rSm5Eekd1L0hVMkp6QXJyZ0I2?=
 =?utf-8?B?anVmcWszRFNWYW5JRDV4akFEV0kvRjNQMm5IWmk1Tk5aQktIbFpnSzRvOFdP?=
 =?utf-8?B?Z0poTDM2aFdCek4xaXVGODdQZGVIVkRrMUtteldqbWpvbHFZRGZOdlkvbWZE?=
 =?utf-8?B?N3FHeGRmRDhYZzVKbTZLWitjYVdBMDVrMXpzYVdYRyt3cW1EMGp3L2thRkJC?=
 =?utf-8?B?TUFJbno3aXBiOVhBeEN2K3FrU0Z0dnIvSzFiR1ducTZJYzc4UjdmWW0yMjg0?=
 =?utf-8?B?dHRVTEtCN0lrdU5xN2J5aXpZV2IrWEFyWU9BOURiTEFXZXhDWkNUYmR5WXda?=
 =?utf-8?B?eTV1TER5NzdVdHhFR3ZZZ0ZBZ0JQMVV0N29LSnJBTHp5OEp6T2EvajZaV0dt?=
 =?utf-8?B?QWFCS1JpTlNSNlVJSzZPSW9RMEtLUGtqeTJsOTJaVGJWYnJ1ZWpZZTh4RlN4?=
 =?utf-8?B?QUptU2ZnNm4xNUE2cEZ2bDlvYXk5dzgrMjhaWnhFM0p6MEJGcnhkTXNqMXo0?=
 =?utf-8?B?TUhUVkZmZE50TU0wc3FIelZ4c0FrakZITlM0dzdlc2U4WkpYcUVXS3BPczBD?=
 =?utf-8?B?TzRYbXNYTU81N1I2cGdvcTUzZUxBMEdURVBLZVRzUGIzdktHN3Rta2RwYlVt?=
 =?utf-8?B?L2pGRDdSeVM4bGJqVkRNYmp6cHNjbzN2bkVsUXVmUE4rNzEwZ2RhRzd1U1pM?=
 =?utf-8?B?bEFoNVV1VVIraEJCemhKaCthcGVOM1R2OVZpc0xzMHpUZDNhMkNMUnVhSWJq?=
 =?utf-8?B?TmtHNm1xWDdlOGw1VTVlOUM2QnZNWWNGNnZqL05rZy9nYldpN2htV2I1M0lI?=
 =?utf-8?B?UDR6VXJCN2ROQ1ljR3ArcHFMV1RBREM0YjZ0VU9kbk5IYnNDdGNPcHd6OG0y?=
 =?utf-8?Q?oEt5Rj1p1mSsQlmwL0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272e5ea1-0374-4c6e-9388-08de524557db
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:44:51.7753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a38cXCB5MpbVX+IxKRKl6CM4mxLB7Jc2c1ZaisVaQ/oGGW2aUEme4dgoe+bJtERWyunpKbB5OetVNnJIlFuCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
Received-SPF: permerror client-ip=52.101.62.2;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/12 18:41, Philippe Mathieu-Daudé wrote:
> On 26/11/25 03:02, Honglei Huang wrote:
>> Unify error checking style for virtio_gpu_create_mapping_iov() across the
>> codebase to improve consistency and readability.
>>
>> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
>> on error. The original code used inconsistent patterns for checking 
>> errors:
>> - Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
>> - Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c
>>
>> For if-statement checks, change to 'if (ret < 0)' which is the preferred
>> QEMU coding convention for functions that return 0 on success and 
>> negative
>> on error. This makes the return value convention immediately clear to 
>> code
>> readers.
>>
>> For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
>> 'CHECK(!ret, cmd)' pattern as it is more concise and consistent with 
>> other
>> error checks in the same file.
>>
>> Updated locations:
>> - hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c | 4 ++--
>>   hw/display/virtio-gpu.c       | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Really thanks for the review.

Regards,
Honglei


