Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7920DE92FD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 03:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaPy6-0005rS-NV; Mon, 29 Dec 2025 22:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vaPy4-0005q1-GM
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 22:00:16 -0500
Received: from mail-westus3azon11010057.outbound.protection.outlook.com
 ([52.101.201.57] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vaPy1-0006Fx-Qa
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 22:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxCzuROTjnFjTHwllfA705P74fFU0E93TOJXfS8kSALsrP6JdvYABZZ8wpd/4Db0ooyrMFUbpSWTXfPxbFENmOg7gq1JIuYm4OzGOvPhZOQB8QlLI4/rHqGwRUCeDIMMb0KuLjwQEbGOvHQ6syOk/FeJJ09/xAtpiYujLpHIxiGeXB+N6jbXOJhYYFJr81+w52EmBcRNkuqeh/Y7EDimlWZ1/DQWa03VmipJQdePn3AbJ1emk/YsHMCgj4BlrEmDrwQxwtfd1P/aMFtiyCDaBlW8vCo+yzHcm0N+yzQjuUONyVSoqcHePk0Y3CvXvS+V0oYsixrZ/HKqgt0Nq/NrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qrpqyf3Hf9e/6vDKrmZ/qRjW7ZgN0mX0nG83i/RfRF0=;
 b=TiFMM4zZnFdO5qkPVcrwKoG/7nqTBxDBm0l34lRqVUrJaXeQgQewzf5w91AAbHmufJ7oCcdgrlbCE14lQ9Oru/Hwezq7rbqi+3vK4OrPs3UR8v0bKG3do5RarTjXnzoPrNlxPNrk9IEuZ84BfRlX5L8CwasOXfa+LsCq0M6XVLQmEij5CV7LFLaDwic82bVm78k+GHsDcJtPJslzZQvoz5k5so3/A7rAxda7CDsjYDMs4AWqNEmCsIvBxyl9nXRwSK2zxCYkjr5QRXnb0ucQKycI+21uVNTci63LZTkD6b1SiveXt8Or9fzlVU18eP6hz9d0B1AmDQpoLSrNBeVYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrpqyf3Hf9e/6vDKrmZ/qRjW7ZgN0mX0nG83i/RfRF0=;
 b=thMnYj7Et/HSeW3k61wA5KJOPj1SoMIQ4ZOurOl1CSBp+yINck4r9/UMQ+O1ZipDzRgl1eNnlOnXdm/8rD1qsdHNGHoSainjOF80TMMdJ3kzed7zqdSchn3yc+YWFqgGeUo2xrqL6qo7kgnaoN5R9MDXvq6eI7doDxQTC1ntePo=
Received: from BY5PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:1e0::40)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 02:55:06 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::56) by BY5PR03CA0030.outlook.office365.com
 (2603:10b6:a03:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Tue,
 30 Dec 2025 02:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 02:55:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Dec
 2025 20:55:04 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Dec
 2025 20:55:04 -0600
Received: from [10.65.99.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Dec 2025 18:55:02 -0800
Message-ID: <8123efd8-73cc-4dfa-9f1e-6d9a95f66984@amd.com>
Date: Tue, 30 Dec 2025 10:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
 <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3999cc-94eb-4174-a443-08de474ed67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFI2aFA1QTZGUnNGUGs2NjI2eVVIb1NCbWhMSm1sVDVYUHBtOWFSdTB6SlJr?=
 =?utf-8?B?MERtMDBmaFh0RnpNdjVweWI2dm82Um05aFZsS256dDFZeURrb1IybzZqTTdY?=
 =?utf-8?B?THpWZmx5UHp4eTRKN3lFMnd3RTludWg2cnU2b3NmWmtnT1ZqN1Rkekk2Vjlo?=
 =?utf-8?B?eUtVeE83eXltN1hGR3NPSEtlaE85Vm1McStCd1h5SytYaWZlamkxT2Vzd1F2?=
 =?utf-8?B?NWg0RGppZE0zczZGaU40S3lGV1ZXdUZtL0dlakdtYkxtK3A5YWZlZERaTWZi?=
 =?utf-8?B?UUFHNXcwOTNwblAyKzg5ZmViK3gvMEYzQUNBQlRMcTNiWW9PQjhQNzNjWGtK?=
 =?utf-8?B?SkxiVG4xdXdvRUErUlk3YlMxc2VMc21hcDBCZVpNWnBGU3lGZWVCb2FvSkxi?=
 =?utf-8?B?TTdXQ2RUWTh4QmhDUzAvbmp1RnQxMVdFNzgvZHlSUHlPZFYxK1B5cHZ6ODls?=
 =?utf-8?B?dDVFTkFNMnNPZUNNWE9ER2JDNWhEWkN5aW11SkxOSnpGQTZuVFgyaHNxRHYy?=
 =?utf-8?B?NnFXcW8xOWhkQk9RTkVmd05YblJKelVkamhwRUtneEliTzEyZG9TcllsaEtk?=
 =?utf-8?B?ZkpnSm5DYVh5MUhqZDM4OXNBS0NzTU5uWHNIK0RTSmhhYzYrangxWFBxNDVM?=
 =?utf-8?B?RUl2TlZvbGFsL3YwNEhMc2Uzd0g0dzdQR3J0NUVCRmFZLyttTDlmSmRTN0tO?=
 =?utf-8?B?aS9Ic1hEWmphakUwbkUxU0VHa0JKL0ptQ3ltbUhrWW8vSHJ3d1o4bS9IVXpo?=
 =?utf-8?B?Tkpaa0NlVnZtS3RQOFBHczQybHpBWjdTQjJ5aHlKZ0xCVUgyNFZsT3JHYmU1?=
 =?utf-8?B?bUd2ZGF3cGcwWXZCRFc3RzdkM2p3QklNRlRjRjdYSmNtNTlXaS85UjhyNnRJ?=
 =?utf-8?B?K3RublhaMEd5NThXcENlSElsSjZjN21TeWdPTHVBTlNBQ01neWR5UWs3TnZ6?=
 =?utf-8?B?VU9CSWxsZkRXNnIwSnFOeU8yNTh4aDRybGhzOG1pTGVGd3VMR2hzMEY4ejZT?=
 =?utf-8?B?TnFBZkhHVmIzY3VJcVhqVCs3L0l4bnFGV1VKSXF2U2hIRG5WQW9XdC83cWRQ?=
 =?utf-8?B?NzdPVTgvRmRXUUNCeEplS0xtT2ZXaEdFblRkMVdaMlJqSUlKRkw5YVJwa2th?=
 =?utf-8?B?WnJsb1F5S1VFeXQ3eXlERHh6N2p3NDR3UU1VSXY0MFlhbWI2Y0NwSjdEcHlN?=
 =?utf-8?B?QWV4UE5ISGxJWDd5UmdCa1JnTEUrNFo3OGJtRVE5UEdBS1hrYnFGNk93Vlpo?=
 =?utf-8?B?L01Nck1JS3NDOTVlcFphaGV5NjVMWlZ0YVk1cVE3M0VEQzZCcjNBUU56NGNu?=
 =?utf-8?B?WnVjdTNPRXlaR09odk5lL2ZMZzNvMjRpdWo5aCsxM2hrd1dtem10U1BZQmow?=
 =?utf-8?B?UWFFNFZYMkxoNndtN3gyNzdFV2g4L0tzUStoSzd0MEc2RVF4ZXFhMFZPZFhn?=
 =?utf-8?B?OXFJVXhNMFBwZ1Yza2h2dnVybHFQaFozckdBOHZXbC91QUtISWRsQklyZ0Fi?=
 =?utf-8?B?UmxPWWJjN3Flalg0aHkwYWQwL2w1VTJrWUUwWkFYRC9KQUVXcnpkMElzNDJF?=
 =?utf-8?B?TnlzZUUrM2dOUlpXanlRNWQ5aWlYRW9iaWxXTEFDWnZWQW5POE80SVFIWGx2?=
 =?utf-8?B?dVB5VzVCQ0orWTdOem1Id01IU0ZHMG9GTDJNY1VNcjIrOHlNNW1oVjlVajlS?=
 =?utf-8?B?V21mUEdYQjdXbmdxSzRoQkVWZ2ZDSTNUOVB5cWJML0VyMDZaWFhkREtMZTZH?=
 =?utf-8?B?RnllelN2SHI4eDFiMjZSNFdEeEpqaUMxZnA1K3FFZzcwMzQ5RFRoeEN6UEZY?=
 =?utf-8?B?eDlBTFovRU42UjVlUndHQ1BrOVUrWGFMY1h3LzZaU0Z6OXplMlM5ZWR6cVBq?=
 =?utf-8?B?eHBQcHprQzVYVDlsZm9VVkpoaFJFcU5aTTBCZG9hQURVenRwY0FNd090VGMz?=
 =?utf-8?B?VW1zblMzQVk5MjFRbDFUZmxaTm1KZHZ5MEZ4cXAzZVU4dm9nekFjb3JOakNt?=
 =?utf-8?B?SkNrcm5McXBDaldEdHVIZXJLMHc4OUQ2SW9oSUNZUHpNMHpVQlJDZVBNVWNr?=
 =?utf-8?B?aUJOczJPQW5qNFBKZU9sS2NkVUl1UVY3eWhVSUZmT01BalducENXZkt5dTZK?=
 =?utf-8?Q?Vouo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 02:55:06.4082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3999cc-94eb-4174-a443-08de474ed67f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
Received-SPF: permerror client-ip=52.101.201.57;
 envelope-from=FangSheng.Huang@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Gregory,

Thanks for your review and good question!

On 12/30/2025 2:26 AM, Gregory Price wrote:
> On Tue, Dec 09, 2025 at 05:38:40PM +0800, fanhuang wrote:
>> Example usage:
>>    -object memory-backend-ram,size=8G,id=m0
>>    -object memory-backend-file,size=8G,id=m1,mem-path=/dev/dax0.0
>>    -numa node,nodeid=0,memdev=m0
>>    -numa node,nodeid=1,memdev=m1,spm=on
>>
> 
> Interesting that you added spm= to NUMA rather than the memory backend,
> but then in the patch you consume it to apply to the EFI/E820 memory
> maps.
> 
> Sorry i've missed prior versions, is numa the right place to put this,
> considering that the node is not necessarily 100% SPM on a real system?
> 

The decision to add `spm=` to NUMA rather than the memory backend was 
based on
earlier feedback from David during our initial RFC discussions.

David raised a concern that if we put the spm flag on the memory 
backend, a user
could accidentally pass such a memory backend to DIMM/virtio-mem/boot 
memory,
which would have very undesired side effects.

> (in practice it should be, but not technically required to be)

You're right that on a real system, a NUMA node is not technically 
required to
be 100% SPM. However, in AMD's use case, the entire NUMA node memory 
(backed by
memdev) is intended to be SPM, and this approach provides a cleaner and 
safer
configuration interface.

> 
> ~Gregory

Please let me know if you have further concerns or suggestions.

Best Regards,
Jerry Huang

