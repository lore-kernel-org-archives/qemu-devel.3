Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876FDCCD19F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 05:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB4tE-0004a0-4l; Tue, 21 Oct 2025 01:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4tC-0004Zs-7x
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:26:30 -0400
Received: from mail-westus2azon11012055.outbound.protection.outlook.com
 ([52.101.48.55] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vB4t9-0007AY-Dl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 01:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez9oy5GSsd4hqWxRhgF6zFBP1jzqIQse/UakzfP9WM8U+7tnftWENJCqNljslunpELU5x2Cuohpu3yz0QqU5h9nJmn4N/cW1BUHaiurIacnaQIksASmLgysMfFzCWvzpMFjvI2VRw0qj04OQel40ge8kZuKJG7r2cC7YJJIhzY5s4rFlHYalCvSckBi+vU2dIh4qgGvzUMjlWyMUfq+1T3QTZIC2S7fKgzjYP2+Cz+zUDvqaxo97Xu6iZsRMUuyjm3pN4H172nnKB4sdz3gWqVchhjFUac6CvdgebCiW52ElXPRdTIVGgh6BtOr7eW/0fRYDybzI62dw6pOgMbaQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDQs0c7Gzb0Xipl9zxGFijxXNAayYOU7a2ERbgSwTJ8=;
 b=aFvRcu6blq30QThuBWhq5LYWccBlEuLVwg6spv9PHRKd0HuX88iFArnMFAgo+ZGuEvVzAHUxglaTlPP4p3bm0Rqdo8HZlHSMGyvv/HfzjHIGSSfHz+1i3Kh6M0LxvSGEH1/b6xnXBy3uAFcoJsslmIFiNGLp+uqc3ikn6d+Ttryp99HCx2dYPlLVPeMiXoXN3s/KTRB8ioqgq6q7vdruToue9WJpycKgy2B8UpHkdpl7G+67z+7P8cP+hx5SlteZBGMgPjoDn+swGtQ1pCrMdf+hSskhFpqmnU9SvL0EHrnF5PID4akH7BHN86sjaOZuyh/w+BwO3pkevkhNxNTHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDQs0c7Gzb0Xipl9zxGFijxXNAayYOU7a2ERbgSwTJ8=;
 b=j7ScOF0TVFJhrjKI/VYWDW9mDovLpcrEWsT5x4FyjKaZUXAj+/uMGxdahkjiycK77naVw00mJaP2LAqlOk7LrME+IfprbkpclnLR5JxPUJIExDvVnVg4jikO2yYQyNaaAlyOkan7oaFK94FsvIYGS1nXUqT7HomBjWHhNeU7ii0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 05:21:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 05:21:20 +0000
Message-ID: <2f0d0718-6fd2-4c67-bd73-1b322e7a2ca2@amd.com>
Date: Tue, 21 Oct 2025 10:51:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] amd_iommu: Cleanups and fixes (PART 2)
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251017061322.1584-1-sarunkod@amd.com>
 <5a7fde93-9d36-4d97-929a-12d86b847ed6@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <5a7fde93-9d36-4d97-929a-12d86b847ed6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 257a4f42-eb70-47a4-438a-08de1061aafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qks3azVic09aZVZwZ2FPejgxc3A3RE9HdHhPMTZENTBiQVplLzZvM0IzWGRN?=
 =?utf-8?B?disydXdzcy8rVDd3WHVNS2F6M2JOQUREdWhNdUJXRWdnZHhzS0tpcWZnY2Vz?=
 =?utf-8?B?ZDJPc2tkVFBtZjhsNlJ5SStUMHYvV0lFbzE5RjAzT29BZTFXOEdnOFU5K1Mx?=
 =?utf-8?B?N2txZjNrUENKRk00R0hsYWtab2QzYkozeEdHSkFDdUZSeGRhYkxtYzZMQUlK?=
 =?utf-8?B?VTlZelpySjVEWUJBdDV4NXMxcVlCRWVHc1Zwd0VDTmhOUTVGTUFCSFJ6UGZx?=
 =?utf-8?B?YVIyRytqcWdpdmJiR2dSdytML0dHeXNkY2dpN09PaHNKek9xS0tvVEVlOEU0?=
 =?utf-8?B?anBTMlRTNGtTODl6Z3c5ZUZPVWZFUXlBQlFOMVV0N2VJQkg4NUMrKy8rQTVk?=
 =?utf-8?B?TWY3RERvYXYxa3RkSUF6L0hHd0FqTnREV1IxTWFtSzdHcGl4NkIxOGJERVRp?=
 =?utf-8?B?WDNPcURSbEhtM2lRSTc0UFFEblRJYkdReW96Um9LaTNqWmtiZmZ2V05mYnVo?=
 =?utf-8?B?L0JoWGR0VThjZThsL3BrNHYvRzFxTFgwOFlTczFER3F3czlJTXBxclNGYW1I?=
 =?utf-8?B?Q1hEeWF2UVVQVDc5L0pFck1OR3YrSkRFUUVHSGJ3ZHN0M1lYcjVORWhRbVVz?=
 =?utf-8?B?emNHS1ZXZ21LWVVOY3ZYZ2g4NTNvS3BLRjc4V1pKbzFwZ2tRSnZ5UHhsN0Zt?=
 =?utf-8?B?Mm9FbUNtTXQxNGNDSDd4NE55ZU9YcUdobTk2Wk5VcTgrWERuN0w1aWdLRVJL?=
 =?utf-8?B?dTdteFVtODIvaFFYcW5UeGRuNHlZdU1DY2lvaVRqazU4ci9xcEY0V2tuY0dE?=
 =?utf-8?B?WVVKd3BnNmg5R201ckpjT3VDTFZxUjlEMlpub0piWUtORnZhTFhCeVZKN3lQ?=
 =?utf-8?B?Nk81RGVvQWoyeit1K0pORy8vN1JVZlZUWk1JTGxzZlpXV3Z4Tms1eWMxUStE?=
 =?utf-8?B?WXpwVHVPbTBTaE9UTGFtREhpQXkrbUNMdkVxc0U1dTJURmdRK2I3bWRKQWJV?=
 =?utf-8?B?WVF1dWpaTGFIQ1RCeS9SajF2UXRWdjNVUkR6cHAvdFpDL0RqMk9HWk1rRi9x?=
 =?utf-8?B?b0QvNkl4bHU5UkxseWswMzgxbjAzb2tyOVF2NUxmekZtYndLYnlBcmhmVk1t?=
 =?utf-8?B?VWlaTkJaVVZhOWhFZVI4cEZ0cnRIcmVnS3ZJYy95L1JJL3VpcWhIRjFmMjJR?=
 =?utf-8?B?QWl2eTlmbHNKNmdGVkRGT0FtWFBya3VjeUxRcVgvM3FycERBd2hUeVlvWkFI?=
 =?utf-8?B?Q0sxeS9FWW9YSjE4UXh4QjhKVEZPNVFKdUViQlFDQ2JwM1owbStBNURiTGEx?=
 =?utf-8?B?ZVRYTzA1bGl6bVRseUVuR1FET1NSaWRPaGd6ZnY4SlZ4QkFrdXJlRkdCRDU4?=
 =?utf-8?B?R3E4NkQ5ejVRUkw1MGtyQ2d6SUR0ajRqc3poZHlYd0cxSXR3UWs2UENRNHlP?=
 =?utf-8?B?b2swdFpiVXdVc0YyL05ReG01RzQ0NjF1bmlndndTOVgrQjVlWm9GTk9qUXVH?=
 =?utf-8?B?VWFncEVwMDFkZkR2Ymg0eG0yOVh4VWllOGFSWXFaSlRqYXoxMm84UC94RGRP?=
 =?utf-8?B?TDN3dmxxYWNxTk01aFBudU9zaGRqb2dmaEtvWjNabC9FMlpIUlB2REF2RkhV?=
 =?utf-8?B?NmUzNHkwd0JwU3RPR0dUZlk2QzVCTHMyMnB3S0E2cnNXRFNmWktjUVc2Mjdz?=
 =?utf-8?B?VFdCNHBYc2VjN1d6QlNGYyt3ZHF3NG50ckxIM3lWVk9JekljNHBaOUJrU2F5?=
 =?utf-8?B?YkVzZ24rL0xTeS9lUGc5dGZSVVkzYVBSdmY0bkQxRUcvdUlmZVJZRnQ0eVRh?=
 =?utf-8?B?aVhLYmFiRHVsVURHc1FPTjFSSWNXdUh4YUxHV2FRQmYvdnloZXorQXJDRkR3?=
 =?utf-8?B?V0svSFlSWkNmMlc3a2FnK01aMWVkd29DeTNyTm1sVG81WFBmU1paNW5qbVpF?=
 =?utf-8?B?b2I1cHMwWDVMdHdzK05GeHZOdVkrVUpzdHFUbnJ1elBWYTlwYm1Qa09TUnVh?=
 =?utf-8?B?R0xsYml6d0xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnM5cm5tbk5QMEgyUmNyd2x6eTcyWjF1SjJ3ZFB6bHl0UEpZKzhldGxPYmVp?=
 =?utf-8?B?dlhrUGtIa0FoT2hRcmg3Q0JNSzZoT1d1VmxyRW1nRS9GZ2FQdDVaV1o1dVZT?=
 =?utf-8?B?cnBPTzh5ODVOcy9rcnYxWlk2aklzeExIL1kzVHBITDZTdFZnRjNnbE1DK1p5?=
 =?utf-8?B?bTdIcTFnd25GTkNxdHJLK1JZYnFFbGlEVWhJQk81NCtMMlRIZDAvTXNDbmNv?=
 =?utf-8?B?OWhHcmhqL1FrODMvM0tGUy9RR3E2cFI5ZkNubVh2NXhSckV2dmVwSG55cXJS?=
 =?utf-8?B?anFvZVZRVU1kLzdpNlhnK0NxOWhQSGIzdngxQ2w1UXRnU1Q5QWVUZVFyNVAy?=
 =?utf-8?B?RzZmRWljdFFMbWdSY1ZwK1BGYkNXUU51T2VRN1B5WXBaejR4TE04U1IzZzhz?=
 =?utf-8?B?WkNnZEpiSDgrcUFhbHgwVDhBaDQzYzB1OTA2Z1B6VUk4RnNPOGgzcHVTdHhV?=
 =?utf-8?B?Z0pQWVQyajJIMHJFYmxhU0ZBYWVOdUR5YzVXNHN2RWVlOXowRks1VDFqUmk4?=
 =?utf-8?B?SHNTeFVIN2xxa3kzeW5jallnYkJTQy9OT1BvZGRQRHlzSmhieXhaRmF0L3Ja?=
 =?utf-8?B?R3hieFFSQjVZVkFaZERPZEY3enlEdVgweU4rMTRUbXh1QUZleHdEUUw1b1Rz?=
 =?utf-8?B?Uzd5eTlQU0dlVUQwSU9lVGdtOVlJME1jcWdZM3VaM1BaQ2swenRBSWRVUnd3?=
 =?utf-8?B?czhNbExjUHpnams0YmsyNUtjUXBRTGxmRDQwWDAxUFE3RkUvNjNpaitMWGJP?=
 =?utf-8?B?MXdTaXEzSWVuZUNIWkFJL2NpNmsrcGZreEx2cDJ2TjIvb1RyU1E2SU9GL0JF?=
 =?utf-8?B?Rmp0cjF5RUlTOEJLVExzWmQxQnhSeGxtaURoNE1FeTEybEpGZjhtWmRmQlM0?=
 =?utf-8?B?YS9LNWZxd0xLeVM3MEtzbFl2dy9YZU5wdUFxenl6MEZVcy9PWTdlZjZoUzRM?=
 =?utf-8?B?UDQ0QlcvV2phd2NGMHozbi9Oc0J0NE9RSFV5czVBY1hNWXpzTzdOb0FKVGNH?=
 =?utf-8?B?bE95K04wR3lMeERvY1o3bUc0YTA2MkhONVBaYVpIWXgwVjlTeC91bTdVZ1Zz?=
 =?utf-8?B?Y3F6RXNTbitvOURHNVBJNUlkQnlDRkREVS8zNWwwRHc0VWdDVWlKdml6MVlB?=
 =?utf-8?B?Ym5waDgyQmN3UExTMlVtTFNmcTFQSXFWNXdiK2FBUGIrZWw0QkQvZ1Vhell5?=
 =?utf-8?B?eE90RHRxa2FiRTJlSFcwZUpVUUVma0NNYklqeE96MkNYY3V4U2ZBR0RuMDZ4?=
 =?utf-8?B?RDRjdFNubUxZampvVzQ3N3l0Qmpyc21xRVhSQi8vdUFObE5DVnQ3WkhsVWcx?=
 =?utf-8?B?TnBBY0FHVHNycUFPNDY4Nis4dnZKWjhJQWYrK2V0dFVVckkyRWcrUzVOYTFm?=
 =?utf-8?B?UXY1bjRZcDI3KyswVGFwYnh2VldpNVBZNHV1U2FhN21nV1ZFUWxHSlpqcWUv?=
 =?utf-8?B?TEJqYlZJRVNuVFdwVmFtV21jTytlVjBSbFZKL002Z1BYazhFYkFzN1FDV3Zu?=
 =?utf-8?B?TFp6TkxOR1VScC8wUEFneDBCeHNZK3E3bnJ5UWVadnRhODIvdTVMN0s2bXFZ?=
 =?utf-8?B?a0g1cmNKMm5qRXpYR2dpazAyVFM2VUs4a1IyV1FUb1g3cXVKUHJFcmdpMU5U?=
 =?utf-8?B?N2RkQXJzVWk5ckFrR3JVTzV1QTJRWkNEY0RPV2VwM0h2SHdRdHVnK3BMRWU2?=
 =?utf-8?B?eXh2WmZFQXlOWUpFMktpc0pLSGI2d0FBUzR3WWUvN3UvMUpJbFpnTXUxcE9H?=
 =?utf-8?B?RWxubjdNKzRmWHNXOGRmK01Qc0xkbGN3VHRCOFBZVEZIa2tXeTBTTE8xVmJZ?=
 =?utf-8?B?dGRzaFpVQzZlY1RjbldCQkhHU3M5QzgxVDdvaHV5Q1RTYWxERndEZTNZU0N5?=
 =?utf-8?B?N2FjT2NPSWJYUUIwWU5lZGhMMnpZeGthU1Z2aW0rcU5RQjl6djRjTmpCbXFx?=
 =?utf-8?B?eG5OdytDR2pZckRFYS9VQnllTjUrNS8vYk1PR1U1eEtmNFNDUlRMTll6dk9H?=
 =?utf-8?B?MUdjSS9RbU4zUUM3djVjQ3dUNFRFVExIeUorbzg5Nlk2cHBHWm9DN3ZGY1BI?=
 =?utf-8?B?dEs4Ump5M3JXN2JyWndDaHpGa0NLTkdKdmR4czUxS2tFSHVoMEIzbW9GbjZQ?=
 =?utf-8?Q?q27pfAWVYvQY/n0F7SSp6TfTn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257a4f42-eb70-47a4-438a-08de1061aafb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 05:21:20.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euSrzITuXyj0lJNxQeizfcJajzcpw4zl2gDEVYx91+gZLoPDyiqX1IggsQ/M5STr/gdwDQC6VqPYUS741w06fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
Received-SPF: permerror client-ip=52.101.48.55;
 envelope-from=Vasant.Hegde@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/19/2025 10:12 PM, Alejandro Jimenez wrote:
> Hi Sairaj,
> 
> On 10/17/25 2:13 AM, Sairaj Kodilkar wrote:
>> This series provide fixes for following two issues:
>>
>> 1. AMD IOMMU fails to detect the devices when they are attached to PCI bus with
>>     bus id != 0.
>>     e.g. With following command line, dhclient command fails inside the guest
>>
>>      -device pcie-root-
>> port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x5 \
>>      -netdev user,id=USER0,hostfwd=tcp::3333-:22 \
>>      -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-
>> legacy=on,romfile=,netdev=USER0,bus=pci.1,addr=0 \
>>
>> 2. Current AMD IOMMU supports IOVAs upto 60 bit which cause failure while
>>     setting up the devices when guest is booted with command line
>>     "iommu.forcedac=1".
>>
>>     One example of the failure is when there are two virtio ethernet devices
>>     attached to the guest with command line
>>             -netdev user,id=USER0 \
>>         -netdev user,id=USER1 \
>>         -device virtio-net-pci,id=vnet0,iommu_platform=on,disable-
>> legacy=on,romfile=,netdev=USER0 \
>>         -device virtio-net-pci,id=vnet1,iommu_platform=on,disable-
>> legacy=on,romfile=,netdev=USER1 \
>>         In this case dhclient fails for second device with following dmesg
>>         [   24.802644] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq:
>> output.0, vq: 0x1, name: output.0, 5664000 usecs ago
>>     [   29.856716] virtio_net virtio0 enp0s1: NETDEV WATCHDOG: CPU: 59:
>> transmit queue 0 timed out 10720 ms
>>     [   29.858585] virtio_net virtio0 enp0s1: TX timeout on queue: 0, sq:
>> output.0, vq: 0x1, name: output.0, 10720000 usecs ago
>>
> 
> Besides the above issues, I can also confirm that in combination with a patched
> VFIO driver in the host kernel, this series addresses the problems I mentioned
> earlier with VFIO passthrough devices + DMA remap mode + forcedac=1 on guest
> reboot. Thank you!

Nice!  Thanks for verifying.


-Vasant

> 
> For the series:
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> 
>> -------------------------------------------------------------------------------
>>
>> Change log:
>> ----------
>>
>> * Changes since V2:
>> https://lore.kernel.org/qemu-devel/20251013050046.393-1-sarunkod@amd.com/
>> P1:
>>   - Remove cast from the pointer assignment [MST]
>>   - Rename struct amdvi_as_key to AMDViAsKey [Alejandro, MST]
>>   - Fix compilation error due to missing 'static' [Alejandro]
>>
>> P2:
>>   - Rename struct amdvi_iotlb_key to AMDViIOTLBKey [Alejandro, MST]
>>   - Fix compilation error [Alejandro]
>>
>>
>> * Changes Since V1:
>> https://lore.kernel.org/qemu-devel/20251008164324.21553-1-sarunkod@amd.com/
>> P1:
>>   - Use fixed type uint8_t for devfn
>>   - Use uintptr_t instead of uint64_t
>>   - Build hash key using lower 56 bits of bus pointer and 8 bits of devfn
>>   - Use gboolean instead of int for amdvi_find_as_by_devid
>>   - Update comments
>>   - Use IOMMU_NOTIFIER_NONE instead of IOMMU_NONE
>>
>> P2:
>>   - Reword commit message
>>   - Correctly initialize `struct amdvi_iotlb_key`
>>   - Remove unused macro
>>
>> -------------------------------------------------------------------------------
>>
>> Base commit: (qemu uptream) eb7abb4a719f
>>
>> -------------------------------------------------------------------------------
>>
>>
>> Sairaj Kodilkar (2):
>>    amd_iommu: Fix handling device on buses != 0
>>    amd_iommu: Support 64 bit address for IOTLB lookup
>>
>>   hw/i386/amd_iommu.c | 179 +++++++++++++++++++++++++++-----------------
>>   hw/i386/amd_iommu.h |   6 +-
>>   2 files changed, 113 insertions(+), 72 deletions(-)
>>
> 


