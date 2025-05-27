Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25A1C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqQJ-0007QQ-RC; Tue, 27 May 2025 05:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJqQE-0007Pw-2D
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:16:34 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com
 ([40.107.92.57] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJqQ9-0005Xd-UV
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P84afRCsn0scJkaYhN/AAoO5HfTVTgpRdidUWW2+aRqCOk5ED0qcpWKf3k1WmrzjePF5YGm8gfobUvIK0S9h3E2OtO9YFBbdh3zqoLb01lA70/UAmzstOYnNANQj0SMlAETC+rvTqmigbuRuzxR4+dFVQ4q4quRXQcX2Z494lseg+wK0AWG0L+uLIPAs+dJdMQEIafP07fVGLv6SNB1EZD+pWQzPkruAjKdrAnVGKTWgHM5B2qrSh6sjcs4g55lgS1I3FxcQ+RbFAKW+H4mYOgyGFZyjCbZwzNiYuERIHhAiRL1LCf4DEYbulfsxunLo9mC7nwCN5s25PI9yhDRpOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQ2XhhyrOb8OtoCBh7lVnGCh2+CUKa7JmA7tgJujGKw=;
 b=j82PPW96Bj/QQJrEuo9bm0xCi/VRSYlmKD42OnnFjYlMbB4l8zC9ch6tuaeD6YE8FhmlzivVoiUyrH+FrDkqXQoN5sgO5yDjzcn9B+cXoQIvrReM94+3En9Qjg9XbhQxQtuQVewsJ5F41ZWDPdyk76eszUCtUGjWS3wGz1GCYm4vg+sf+xNzlB18+hKXipw2CpkkeHRISVzxVnk+mJ2EHgxSkg2Js5WwI8uZ2FSKQh8HLyOvewszf7CWMQXYQJk+5Tww0v9P4/s3hLBem78nMR5KCWRigujUW6cpKET1vwEriDD9981yAR+Oz0X4Z++Guy2FYAIrfpAAypR6/k7Hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ2XhhyrOb8OtoCBh7lVnGCh2+CUKa7JmA7tgJujGKw=;
 b=qxWMaaA9AbY0ZD0DgRMsL9uPvdcynKaPR6QoC9Gg+p9EvbiR2ffAtxMIKDv8d5LKlkaYvj/UsMwM7Sb+LW4XYBdMQ0NTdqEOGcoTuyOo3wVrjmTdhxLjQvqB9bKl3b7vc/UDpSbjqV4z7ZWwja2rO56N9O9QCSoMnmFN+OGPBso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Tue, 27 May
 2025 09:11:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 09:11:18 +0000
Message-ID: <c6013cd5-a202-4bd9-a181-0384ddc305ab@amd.com>
Date: Tue, 27 May 2025 19:11:12 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 10/10] ram-block-attribute: Add more error handling
 during state changes
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-11-chenyi.qiang@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250520102856.132417-11-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:806:28::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1244a7-2b00-479b-68c4-08dd9cfe70f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzBDMWlTRnI4Q0VDV0N2YXVBcGtHOW12VXYxeUExMVc3YnhtVFlxV3ZwZGV3?=
 =?utf-8?B?bmpQdmlLa2lSZklqYVpjNFNjZ1J0MXRHbVhLRW9HK2lqR3NVZXVTWGhpSWx3?=
 =?utf-8?B?Z2NaSGQrNlVqVGNhR0NTakl0WXBVeURkQU8xMi9XcytVeXFkUFVTZWVtc2dn?=
 =?utf-8?B?RmZJUVd0MVFsaVN5WXFhNEpiZGFZOGFFTDYrRnd3OTRvVlNrK1cyWW5NNlRR?=
 =?utf-8?B?VzI1VjNMSC82ZjlONmhreXZPY25UcVo2QW1pbUdHMlUvOTYrck4yNVdkNXU0?=
 =?utf-8?B?VGNINDJzbitUbVJ0eVA5R2VMbDFZK0RzbUFrYmcyME1DSmhjMHVSS0hUOU11?=
 =?utf-8?B?YmI0VzQzclNNRDlZWGtOL01WMlFqOGFPTXE1VWYyUThDdDhvc2FiZlh3ZHZX?=
 =?utf-8?B?c1RIZ3JTWmJIa3Q4REVhbXdDdUZNUktsRDZaSjBpamVDY1hUNkh0VXpqcFVt?=
 =?utf-8?B?MkRvL3ZWVWVPLzFCMUl3MTE2b1BsOEU1aFA1RXlRcmZkV0FpZEZTY0srdlBa?=
 =?utf-8?B?MHBSTlpQU28xVkhWR1B1elNBTVNYRnk0cXNld3FNVXdyMkwxZUp2YjFSalk5?=
 =?utf-8?B?cTQrbWhuTW5CSnhxQnpkQ2xrTHFsVGpTZTNxNXltK0J0ZGcyWW4wNU5NT1Vl?=
 =?utf-8?B?NjB6aXZ4QnJhZnFPc3BDOHkxdXRwL25uY1l4azNXQms2bTlRbzNqWFQvVGZw?=
 =?utf-8?B?MkZoV0Jyc2hhY0FiYytDUTJmbVJxWFpBVlZiWCtKRTNpQmJoOHpzWFROMU8r?=
 =?utf-8?B?UzV0THNnWE93NUpGWmNHcHk1QWliekNMa2E1ZTZXZFMzSjdHeEJockJLaTJo?=
 =?utf-8?B?YVNWdVZKeE1xb1FTalhOTkFoMzZMSEc1akFOMFY1cWJVS053bXEyYVZQZkxK?=
 =?utf-8?B?UFNKT2tlaEJidjJoVGROSnBVNm5BWkh0VERyRWhraUlramwvenNVdWdHZDlX?=
 =?utf-8?B?dEtid1hvTWc0VTFvUnI2THh3a29tOVJ3VG1YZ1JwK216eUt2aGRDTlI1b1Z6?=
 =?utf-8?B?NDlPR0xPTThGUjJjRWRIc1dwWnA2em90c3ZKeTBONFV0T0REMm9lZGZMWk9P?=
 =?utf-8?B?Mm5ZdW44S2M0ak9CSFhKbHJXY3IvNHlNTW4yR1lOb1dlelRWNGV2RWlZaFU2?=
 =?utf-8?B?UFVZSDJqdEF3ZUs1ZjlQTVBVYUhFYXJOczdpMnN1RlU0YmdZQUNXblExRHNp?=
 =?utf-8?B?ZVpMY2xqWFNJWUdRMjZHdFA3ZlpyMVRCNndOZ1JYQWl4bUxSeks4emZ6RVQx?=
 =?utf-8?B?WEk2MGt5WGRBMEZrdjRLTDdJUE1WMWRjZ2p3VXJQc0xsbUxXSW93SE42UCtq?=
 =?utf-8?B?UFZCbHVrUHBJalVzNG4vQUJUSm9tcUIxdmxFWGJNaDFvNFpWN1g2a09kdDJn?=
 =?utf-8?B?Y3lBR0Y4WXdtV0Q2Z2JhMGI3bm1uTDVGTG9FZnJtNmROenFUWDE4dnR4cGR6?=
 =?utf-8?B?dk1VY2dBMnZCVXNMMHRyYURFcWNyOXRDdXRub0QrN1ZCaXo0WmVDdGp3dnhr?=
 =?utf-8?B?bDlZZ3BpRDZheERuNk9vTlJ1elZIU2Y4anlnb3ozc0NiWURLbFpXeXJNSFlq?=
 =?utf-8?B?R29mcDMvMjVkM1krdUZNVlhyVk83c01icS9LRFYxQUJMTXlRZ2VoUEphMW14?=
 =?utf-8?B?aENuRU92V3hqQVNyOGROa1FTaXZmS0xjeG1Wei9LY1NTbFNHbzBxOWpaeFpy?=
 =?utf-8?B?aERJU3JWSjZSZHoyNFVlY0U3dTNUQmhnbjREc21pN2EwWlliKytFeERIQ25C?=
 =?utf-8?B?M3NUOXg0YVdqd2p2QW16V1lIWVIvenNqQUlHV0pENmY3aVZPSDBUV1QzOWlJ?=
 =?utf-8?B?ajdmKzNsRkp4UVMveGh1OVhnSlU2MHF2RkV6bXBnd2dreTNKendpVFdwTDBX?=
 =?utf-8?B?ZUFpSGdGTXp5T3ZxdUwrTExXK3ArMG1EaU9Va2prK1dXcWVRWkdlQ0JVb1VQ?=
 =?utf-8?Q?s/IXtxTF2xA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SENqV2JQUStaeFFxMXpiUzF3eHJoN0ExWWl6SlB2RUFyUGtpNUdvSTd2Mk05?=
 =?utf-8?B?RFlVVDRJbHFyMHBMcmNiTGZHZUx6Y2lQVXRacXNWWUdCUUVhSW5HVzBzaHY1?=
 =?utf-8?B?ODNTZmlCeXpXRUlPbzBXam13TDF6N0lvTE1lUml6Zm5QODV5aEV6NzQ1bmRE?=
 =?utf-8?B?S3lwUDBmSUhVVGZnMS9MeXgyOW1PYjBYZWNUKy9mdTl6dmRHSWFlQWloZm9B?=
 =?utf-8?B?U1ZuY0JxQklpN1pJU0VGb3ZzVE1FNTRJY2U1MVNLeU5WblVUTmJXdXhXdk9S?=
 =?utf-8?B?bE02YTd0ZDMvVUhjWktra3loS2l4OXlJcE5PU0tZaDkzbW9DbHR2ZWRPSEVL?=
 =?utf-8?B?azA0NFJnYzNQSnhjU0pZb0h3WGgvdG5RVW9NM1dRdVo3eW9XaVNCQ3ptSHZx?=
 =?utf-8?B?aDduQVlEK0owWUV0OHBkN3V4N2o2R0Mydkl2QnZyWjBmQitHUXkzczlxY2lk?=
 =?utf-8?B?cStPMmhpUWNEMnAyUk8xSzhaY0tiU0F3ZU9HeldSb0ROOXFMNlVVcmJKT1hw?=
 =?utf-8?B?V1lYZ3RxS00ybVNIR1Z1UFo3VHRacEpEVTVYbHlwenpTNFYxbWJpdStXazFu?=
 =?utf-8?B?eXd4cm11aFJZQjcyMHR6a2NaRjNNOXhDZkVGWDdyYkpKZFZMaVc5bEhUR1Yr?=
 =?utf-8?B?bldla2FSODB5bVVCVkxqVUpVdFhySWdEQUEySk9IaUpTYnhPWjMrUEpZbjMr?=
 =?utf-8?B?NysySHRFMm82dWVHYVYvazRrN1lkU1lkcWJYcDZIYUR3Zk54Y1JBS3p0YU14?=
 =?utf-8?B?STAreS9RcUJhbkNvNUxMYjZaR0lNbDVDMERxZTBMZjMzRy8zNi84Rk5wN3Vr?=
 =?utf-8?B?amh0dWpEUFpHQXdjV1d4a2prNjlSZ3JpOUcyQkRucWpyRUFoSFV3QWRXMUJQ?=
 =?utf-8?B?ZU1pcDZWOHZXVEFtQnNjWXhJbHV1NEFjZlpsbG5acVArQ21oeXpjdTdhMUIx?=
 =?utf-8?B?OWF0Y00zM1RSVHVlT25LWmh5RXFRMTRZT1ZMNmE2cmlYNFJaeDlmZ2QraFQ0?=
 =?utf-8?B?NEtoRmZrZ0pjWm5DcnFRQnhTVkJ1eWFrSWlpZENZNlAzZ3k4T3pqbTQ4TFhs?=
 =?utf-8?B?VEgrQlZvTFRPSGhoMklscjFvd0pMV3VSUVFTZ2w5Z0xUMDhydGZnSnNhVXk2?=
 =?utf-8?B?VVRXWW14a3BsU2toZ0JaVDJWa2M1eEpRc1VXNTF1cXplTE5OdWgzVzNKazR5?=
 =?utf-8?B?UXg4SFVPQi9kQzNvTFRPTnFtbjRqRzl3aVVMSjRNNEFGZzZaZTFETVBzUTlT?=
 =?utf-8?B?d2FwWVVNR3o1WEVsNWZmbCs4OXZwNTM5NVRsOXhzbXJPYWw1WThzVjhXMGYx?=
 =?utf-8?B?SGVhYzQraHcvMnZFQjlIelJvemJtTmZmcktDQ2xucmpOckJlMDV2WkpiUkJN?=
 =?utf-8?B?NzIxcjJqcWp1clFJQmFDQTg3Ti9CK29UVGtiRkx4aGF2ZytXV1A2RkhiRDdL?=
 =?utf-8?B?UnFNNmZiWkVSbkxQWStPY2V6SHJOSk5PMU9aeUlRRzJURFBQdTZxblBZVXF3?=
 =?utf-8?B?aXN0TlVPTS9JdDJVNHBnOWZFVUcyMHhwcVZ1a0hJNFNJZWM1bVNHaG9VaWUz?=
 =?utf-8?B?ZlJzT3F2M0VDNitoRDVQMDlLUmVSY0laRUZNakxqcnd6WS8zMlY5LzJxZkZN?=
 =?utf-8?B?WTM1bVVCQTliZUlHaHpmZHlScWJwYmRmMFBJbTIzWHlFYzUyU3RZaUtTMmFl?=
 =?utf-8?B?eE5BTnhzcmY0MnQ3c1VvR0VvSG5hL3RTR05qU1NGNThSM1dnNXFybmt6eTFt?=
 =?utf-8?B?MUh6ZzFHUnhyS28wN3ZEK1djcHhpdEtIYnpqb2xZMjVTbFV2MWwzZElQbkJv?=
 =?utf-8?B?NHR1RkdCRkZGZkpyWXpBUEJNeUZJZkFKNTZyYlJsYlk3aTI5emhxdEJNVDVq?=
 =?utf-8?B?aTZocjM3T0RKNjNUYUErL3piNW54ekg1c0Vaa1VXL090M1l3djMzMmNTUnU0?=
 =?utf-8?B?YStVbWxkRVo4TFdjVW5nLzJ0czVIdnE2Zmx5ZlYvT2dvbUZZS3JsWGF5NVdX?=
 =?utf-8?B?YjdhbThLRUJMMjUwM0JNUDluakZYWjJoWW9KVnpmRmdzcGZjRXEreFdwcmZW?=
 =?utf-8?B?WkN0QWhJSUIrb3JtU3laTzlwZjJNbnhCdXd3M2x5WXhFSU1YWUNDZ0U4OHUz?=
 =?utf-8?Q?sHGYVfXNQpYQyjAqMlQGfgcoE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1244a7-2b00-479b-68c4-08dd9cfe70f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:11:18.8736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6BRkGGoGe2J7Dt2z5CwS8QH+L2ntIKNP7njfo5533objYcCvYvGbvQJnqDiGckuule7C6zIqDbEo2wolKyNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
Received-SPF: permerror client-ip=40.107.92.57;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 20/5/25 20:28, Chenyi Qiang wrote:
> The current error handling is simple with the following assumption:
> - QEMU will quit instead of resuming the guest if kvm_convert_memory()
>    fails, thus no need to do rollback.
> - The convert range is required to be in the desired state. It is not
>    allowed to handle the mixture case.
> - The conversion from shared to private is a non-failure operation.
> 
> This is sufficient for now as complext error handling is not required.
> For future extension, add some potential error handling.
> - For private to shared conversion, do the rollback operation if
>    ram_block_attribute_notify_to_populated() fails.
> - For shared to private conversion, still assert it as a non-failure
>    operation for now. It could be an easy fail path with in-place
>    conversion, which will likely have to retry the conversion until it
>    works in the future.
> - For mixture case, process individual blocks for ease of rollback.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   system/ram-block-attribute.c | 116 +++++++++++++++++++++++++++--------
>   1 file changed, 90 insertions(+), 26 deletions(-)
> 
> diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
> index 387501b569..0af3396aa4 100644
> --- a/system/ram-block-attribute.c
> +++ b/system/ram-block-attribute.c
> @@ -289,7 +289,12 @@ static int ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
>           }
>           ret = rdl->notify_discard(rdl, &tmp);
>           if (ret) {
> -            break;
> +            /*
> +             * The current to_private listeners (VFIO dma_unmap and
> +             * KVM set_attribute_private) are non-failing operations.
> +             * TODO: add rollback operations if it is allowed to fail.
> +             */
> +            g_assert(ret);
>           }
>       }
>   
> @@ -300,7 +305,7 @@ static int
>   ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>                                           uint64_t offset, uint64_t size)
>   {
> -    RamDiscardListener *rdl;
> +    RamDiscardListener *rdl, *rdl2;
>       int ret = 0;
>   
>       QLIST_FOREACH(rdl, &attr->rdl_list, next) {
> @@ -315,6 +320,20 @@ ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>           }
>       }
>   
> +    if (ret) {
> +        /* Notify all already-notified listeners. */
> +        QLIST_FOREACH(rdl2, &attr->rdl_list, next) {
> +            MemoryRegionSection tmp = *rdl2->section;
> +
> +            if (rdl == rdl2) {
> +                break;
> +            }
> +            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +                continue;
> +            }
> +            rdl2->notify_discard(rdl2, &tmp);
> +        }
> +    }
>       return ret;
>   }
>   
> @@ -353,6 +372,9 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
>       const int block_size = ram_block_attribute_get_block_size(attr);
>       const unsigned long first_bit = offset / block_size;
>       const unsigned long nbits = size / block_size;
> +    const uint64_t end = offset + size;
> +    unsigned long bit;
> +    uint64_t cur;
>       int ret = 0;
>   
>       if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
> @@ -361,32 +383,74 @@ int ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t offset,
>           return -1;
>       }
>   
> -    /* Already discard/populated */
> -    if ((ram_block_attribute_is_range_discard(attr, offset, size) &&
> -         to_private) ||
> -        (ram_block_attribute_is_range_populated(attr, offset, size) &&
> -         !to_private)) {
> -        return 0;
> -    }
> -
> -    /* Unexpected mixture */
> -    if ((!ram_block_attribute_is_range_populated(attr, offset, size) &&
> -         to_private) ||
> -        (!ram_block_attribute_is_range_discard(attr, offset, size) &&
> -         !to_private)) {
> -        error_report("%s, the range is not all in the desired state: "
> -                     "(offset 0x%lx, size 0x%lx), %s",
> -                     __func__, offset, size,
> -                     to_private ? "private" : "shared");
> -        return -1;
> -    }

David is right, this needs to be squashed where you added the above hunk.

> -
>       if (to_private) {
> -        bitmap_clear(attr->bitmap, first_bit, nbits);
> -        ret = ram_block_attribute_notify_to_discard(attr, offset, size);
> +        if (ram_block_attribute_is_range_discard(attr, offset, size)) {
> +            /* Already private */
> +        } else if (!ram_block_attribute_is_range_populated(attr, offset,
> +                                                           size)) {
> +            /* Unexpected mixture: process individual blocks */


Is an "expected mix" situation possible?
May be just always run the code for "unexpected mix", or refuse mixing and let the VM deal with it?


> +            for (cur = offset; cur < end; cur += block_size) {
> +                bit = cur / block_size;
> +                if (!test_bit(bit, attr->bitmap)) {
> +                    continue;
> +                }
> +                clear_bit(bit, attr->bitmap);
> +                ram_block_attribute_notify_to_discard(attr, cur, block_size);
> +            }
> +        } else {
> +            /* Completely shared */
> +            bitmap_clear(attr->bitmap, first_bit, nbits);
> +            ram_block_attribute_notify_to_discard(attr, offset, size);
> +        }
>       } else {
> -        bitmap_set(attr->bitmap, first_bit, nbits);
> -        ret = ram_block_attribute_notify_to_populated(attr, offset, size);
> +        if (ram_block_attribute_is_range_populated(attr, offset, size)) {
> +            /* Already shared */
> +        } else if (!ram_block_attribute_is_range_discard(attr, offset, size)) {
> +            /* Unexpected mixture: process individual blocks */
> +            unsigned long *modified_bitmap = bitmap_new(nbits);
> +
> +            for (cur = offset; cur < end; cur += block_size) {
> +                bit = cur / block_size;
> +                if (test_bit(bit, attr->bitmap)) {
> +                    continue;
> +                }
> +                set_bit(bit, attr->bitmap);
> +                ret = ram_block_attribute_notify_to_populated(attr, cur,
> +                                                           block_size);
> +                if (!ret) {
> +                    set_bit(bit - first_bit, modified_bitmap);
> +                    continue;
> +                }
> +                clear_bit(bit, attr->bitmap);
> +                break;
> +            }
> +
> +            if (ret) {
> +                /*
> +                 * Very unexpected: something went wrong. Revert to the old
> +                 * state, marking only the blocks as private that we converted
> +                 * to shared.


If something went wrong... well, on my AMD machine this usually means the fw is really unhappy and recovery is hardly possible and the machine needs reboot. Probably stopping the VM would make more sense for now (or stop the device so the user could save work from the VM, dunno).


> +                 */
> +                for (cur = offset; cur < end; cur += block_size) {
> +                    bit = cur / block_size;
> +                    if (!test_bit(bit - first_bit, modified_bitmap)) {
> +                        continue;
> +                    }
> +                    assert(test_bit(bit, attr->bitmap));
> +                    clear_bit(bit, attr->bitmap);
> +                    ram_block_attribute_notify_to_discard(attr, cur,
> +                                                          block_size);
> +                }
> +            }
> +            g_free(modified_bitmap);
> +        } else {
> +            /* Complete private */

I'd swap this hunk with the previous one. Thanks,

> +            bitmap_set(attr->bitmap, first_bit, nbits);
> +            ret = ram_block_attribute_notify_to_populated(attr, offset, size);
> +            if (ret) {
> +                bitmap_clear(attr->bitmap, first_bit, nbits);
> +            }
> +        }
>       }
>   
>       return ret;

-- 
Alexey


