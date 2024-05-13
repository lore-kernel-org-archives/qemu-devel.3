Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A644C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vd7-0002H6-6Y; Mon, 13 May 2024 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vd5-0002GW-2v
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:22:11 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vd2-0004io-HK
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSydyhelDcZHRhGR50zYyjwc0xgGuy0OpBFiaU3gdduLKM/b2EBQTAcmWFvPrwVEKzsR1kRuovJsyL3hi+v6xr3goiPru9RpdbksMGMUqA6548PXdkjAMRPpEexv6rBxTW+HDYWVvn0CZHtQxbC6OhYK3VPPUMBfJy2Rj7xJC7L7DKcTvZetqn584QZlCEMM0ENtyDjtZa76OQIqw15+ZvjVvPEDer94H3Ho1qjN7BDl56j3+RSRKkIY0yY+RixBpSuU1qR8ADO8IwkeCmR4hOTZOMK1y39/2L3GOckutaoCtDwvhI9wTc0L/FGUBIDifibL36KjDEMlK/I7KwTPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFW8bfey1bGRcIfgZRyJCA/8f/SXsnWfb6GwPZVwn+c=;
 b=E99ElO9tFT3Nd12ausZjaTMnbmoWBJO+5+f618AaTKTxQlXhe0mi22O1OsJlmnavkNcu9ljg664MWLaB5fRs3yW9C6tVcKKVAroEpF6sno/y3rahw3T9JOqaBKcnRE0zyslcHavYpIPqqdmL9DXsTsGZ1BwQLxoyRaWDa9+AjvLoVhFSgjJUOC/AUcXG5avg4n5vAxyJ4cZwJrX0esAgzYxCkEQ+VvGuh8P9w6fm3izvv4C7D9TO+Qe+82BVicOt0wBVz61WdXdeegiFqkbTkxi5bu7Zyq/BRW/AmM8scutVBaXtrEu80oRFtRkOxInTniHiAfqcKU24c0ACApVBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFW8bfey1bGRcIfgZRyJCA/8f/SXsnWfb6GwPZVwn+c=;
 b=as7Tvy3LCe+y+HP2wTYslXTfL8UCNrZ3BJ5OmbTdqJZUPfkWtXKskctqiImI+YJ3ebQH0TJiAmdzabdtf+JAUyCZ+nL5lJ6oP6VDxM5esibMXNAF3xjtu4vYOauIXNGqItxwDi7jTyUR7I1VfE7T5/3PBE2871H3O25rVGR4NsXRSgTzSgsDZI83IXOlbLtd5yb6awN7N9/jghDNBkGcc06O4PlJPQmN/S7U+BMyAp4ye8TFJreTkNu6/G6Ora5r16rQx8U6425BUNkC5PyP1GYTY9hDo6ACfjB3Ihj7fEDlFhC/IsHtC5eHn/XoQhQfZnRyYpbGa1rv/HGIeDGJwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:22:04 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:22:04 +0000
Message-ID: <ae441889-a640-4ed0-b455-10a13bc46047@nvidia.com>
Date: Mon, 13 May 2024 16:21:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] vfio: Use new Error** argument in
 vfio_save_setup()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-5-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0479.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8550b8-1aa3-434c-b69f-08dc734fadf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3QyUzJjRzRudHZmUnFINWZqN0hJRGdmaWFNTnhiR05mdmN6MFpidU1LOVlr?=
 =?utf-8?B?ZzVXZENrVUhlT2RCQUtzRjBqV3ZjV0VEYjArdmZ2VmwwUElRQWFibGRzZlZ1?=
 =?utf-8?B?R2VLVTFMNDdPTUFEZ0dUWjZqdkszWFJpYXhHWE5HTk1sdkdlL0c5Y1JiRXI0?=
 =?utf-8?B?RXZVZW51Z2RXN3hmWU1wcGNQa2g0YmFsZk9LSkU5dWk3b0NyM21NMXVxM1lz?=
 =?utf-8?B?SjFEVEV0YUtjb29hT2VxeHZvditzZWV5Rmo3RVo0blBLQkRDSS9oOUhxS2dB?=
 =?utf-8?B?djA4RDlzSWNKSmZWckxyVGVMVzcvb21EZXlFSlBpTE9xWFBNZytxYWJqdXE2?=
 =?utf-8?B?a2hmRUZvcUFNb21Xd29jK0hVOXJkVUhCcHN6UGRwdUdqa2NCV2Rhakc2SEVH?=
 =?utf-8?B?UC9KRGZRKzBKaCtEbElaWEZ0SkM5OFVkMHVYZGRmYVBTSUp5NFRDcE10dG1q?=
 =?utf-8?B?VEhDRkRpUWxGdjJlNlBNRHVqWW9FemMrRk1aOCs3Y3JHaVpmd1BFZGNGR09O?=
 =?utf-8?B?THA1d0QzYzRvazJ1dlFLeEZDV2MwNHM1U1hVeEhsRnZ2VzRFR0xEQTFuWU56?=
 =?utf-8?B?Tkt0RnlTcFU5ZXR5ZmlhWG5SZGtqQzNUVEJ5bzdWaldtVDF5ZDZRMmt4bjBk?=
 =?utf-8?B?eE5qWnNyMlQ3aW1RMGpIZzE5bVYrcGVmRTZTa2dhRTBxS1JRaTZyazZkL3FX?=
 =?utf-8?B?eUpxNTR0dyt0SHZwRGFEL2wrWHE1UkNhVFY2MC92Y1RQQzZXREdvMzVoeUxN?=
 =?utf-8?B?azZRS1hXWWFHaDNXYkt5LzVrUEduUUFaSENVSEY1RDZLYzE4WTJPcWhoUzVu?=
 =?utf-8?B?cUJ1ay94RDRzTlA3VzRwdHpXUk0raHBzdTVNZFRUOFpLdW9paUp3SGdJVlps?=
 =?utf-8?B?dEtmWVBLUCt1RmFqVVNoN1RlZUdlUFZUUnh5cGxPQURnWS9KbEVhK3MzaTlU?=
 =?utf-8?B?T1ZaV0Z2TmgrNnprZGtVakg1L3lLenNCeHkzRXFaTUFZTitMTFM1TGl5amRH?=
 =?utf-8?B?UDY1L1RLZjUwTzVtSUd0dldnS3laMGFpakNRUkc2ZkpxZVFiU3pEZnhiKzA2?=
 =?utf-8?B?RDdGNklOWTZ2VGk1UVY2dzBCTjNFZHQybUVxYkZvZEZ4cFNkWkU5QUpnK1VZ?=
 =?utf-8?B?M3RvTzVjeXYzR1NhRVpRQ1BPVS9MQzJrRDVySFh3Njl5WHViTGNES0dCVjBH?=
 =?utf-8?B?MFlPZHh4dTRrQlY4MWJxT1pKRm14QXhuSlZFOE41cUhpcUdjYmxYSGlXL0VE?=
 =?utf-8?B?dm10c3dCVUhpbUNNZmx3UlQvT0htUUFxZ1JIR251SGJ3a2xISDk0ZU16czlR?=
 =?utf-8?B?RmZNVmJpSUNFZWFLeVExd0JyeG5HdzZxcDh2VjZkdW1qaHA3WFhyUExEeWhC?=
 =?utf-8?B?dDd5eEVHSUlma3FWYTZ4cEUwUUdVL2U4WWZueVVKUGFaSVhIamMrRW9iNmhu?=
 =?utf-8?B?anBnMDMyUDA4UDQ3NTAzMXhPcFlrZW1tc213cnp0VmZGVHlRUlFkNi94b2hW?=
 =?utf-8?B?allIeUU1eG5ocEhMYjlLMnJndHZicDBvT25WUzJIbThOVHdYbUU0QlNuaFVP?=
 =?utf-8?B?b2JvcGpOS1haOTl1SlNCV0toZnpESllodjZwSm5MemEzbnR3V0VMUDBJbk0z?=
 =?utf-8?B?elhySnF0RnVKS2ZYNTh2S0FPSWVsOWZqY2NEREM2TzBmTk5kVjBRQzBOdjQ0?=
 =?utf-8?B?UjJqUEl0cFdxQzQ1OTZSMTBYQzJpdER4NkVWdGpsSWdKMXhOOGpOeHZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJCeXVVWWptNDM2K01OQjRRYU0wdWVjVElpeGJXdDE5NE8zMFJLdjdNdmpw?=
 =?utf-8?B?S0htNjNsZ3YxazI0ZXNXZk9hTkVHNkhWNDNvaGJBdTMwY2hzNVJ1K1EvTlRX?=
 =?utf-8?B?b0dBOG9NQzhVTFBkYVNxcStlZWpCZnppd2lWWEdTZEhZNjJ5TkJoenFob0Ur?=
 =?utf-8?B?SGRQUHMxaE9jeEIyRE53QVpvUHJ6cklzY0dSYm44emF3UjlScExPWHAxM25y?=
 =?utf-8?B?bWFYZ0w2ZWliU2VxcVp1STNtMWRNa3RBUnhlb2pTb2F0blh1ZkxJeURudXJT?=
 =?utf-8?B?TnRtMUxObkRCVEphSExlZ1RQNGRvWEMwNVlSNGJERSt4cElidHZVN2lOcTBz?=
 =?utf-8?B?azY5a3pSVjBEcVlQcnFsRXU1RFpTc3ZXeGdPOG9jVldxS211NVhONVVnZW5H?=
 =?utf-8?B?TGNRa1ovZnZMLys5SjlaKzYwd2lId0VaN3FMbndSY1hBOWhFa2V3WnIvZDJU?=
 =?utf-8?B?SFpJdThLODN2UmRGSmgzS21QWk5xK01GeVJqOW5pelZwRW9USFY5RG1uTldr?=
 =?utf-8?B?V1JmNTkvWnVBZ3pOWWo4blZyNlRCQVVHOUo2aWl1ZHh4V3JPWHlFbzhYYVZm?=
 =?utf-8?B?bjhBMU9wNlluZWdKc1E2SjRkK3ZZRGNaT2FsVTZSQnM1NXZsckREVWdvUDlE?=
 =?utf-8?B?d1BtVms3VGw3RXc4UTVscnQzTEsvVTRaU0tSYTlYcUEwazJiSWZudEYxVExa?=
 =?utf-8?B?N0ppQ1BISzJFaVpHbXhiUEl2RGJsT1dsa0xNUG02TzZqdHF1amhkVTZVSmpo?=
 =?utf-8?B?SWZibFd6N2ZlTEZDbGxYbmxCSG16Yk1VTFNmdXJuZ05JM0RYZzkzY0szQUxP?=
 =?utf-8?B?UXJvWHRIQnNBaG1aVnZXQ1hoRkN1QTU3bVp2R0NGbkJSUFVUc015QThVc2k3?=
 =?utf-8?B?ekNJSkRzTUpZRFUvNGdsRFppRVRpTkpPQzVxRHc5TXZBS1pndko4V1V0dlNN?=
 =?utf-8?B?ald0SitpUmd4Nk5wazEybitwL0hCOGFzOXZCcUhWbWpoeDRLZ0lNTXgvVDFl?=
 =?utf-8?B?Y1p0ZVYzaDJaeEtuQUFPdkVvUVZGQlQzUXdvMXhUVEY1RWFCOTYvR3Fwa240?=
 =?utf-8?B?RndNbllmK012VWplcTdjTndUZnJrSm5mMXdBbTlEamJXaWJPL2RpYW84S3h6?=
 =?utf-8?B?dEhuR1BnWWQ1ZkFWTmhMVVVVdCthQ1ZzUDgwenA5YVBidkYrWWYrdFFLcTNx?=
 =?utf-8?B?RlE3WW52MjVrbm5oSjAvVlo3bWRDRllnZjBFMEoyVkNzdDFZem9YbE1icUQ4?=
 =?utf-8?B?QmdNbzhWLzhGOWZ2YldpZ1dBR1RyMDdCZTc2cE80RXNXbXE1NXROZSs4TWFh?=
 =?utf-8?B?RlJYb25rNUYyRmh0WXhNbHdJdWRCOXNVdllwaVA4SHFyczBJUDNNVWw0aUt1?=
 =?utf-8?B?KzBMR2pwdkkzd0MyVDhNVGkzMVFIQ1pkUWZLQ2pnREhTODNxdHB4d0xGY0V1?=
 =?utf-8?B?eXBOem9sNGQ1RjZxZm5UeUMrN0ZXWlRXUEdGSDl2MDh0eTJhTU5nNGNaMGN3?=
 =?utf-8?B?eVhpcXRTTHg0TjRZT3V3ZkxQcWliUXBLUTArK2JWV25HVzJhQi9OTXJ4T09C?=
 =?utf-8?B?bTJIQ2JqVjFDSmxnV1ZON2RNUXlva2VmWEd6QUwrUFFBZTBXYmw2blhCTlpi?=
 =?utf-8?B?b0VLNy9yS0NFVWRIOVFZUmZoQ0RaeGdiR1lmbkdZWGJzb3JPWmo1WVlsTlJa?=
 =?utf-8?B?VjNFK3d0dW5xcXB0NjJORVVabGlOUG1vWGZ0dzdGelhDaG9jUUsxZlB6OTBC?=
 =?utf-8?B?Yy9YdGg2c0Uwb0dkcXFqNnpNMnhNbDAxdUUrUENJSE5NNTBvaEhiTFFNRGN4?=
 =?utf-8?B?RDU4SmUzQnRKUVNPOVVlQ0svbzJrd2FHdHJDUDE5d3NGRlZhdmhxM1NtV2I2?=
 =?utf-8?B?M3hKZ0RkWkZhU0tNVmlrS3F3ajRnUHJONTdEamt4OTRIUzFKZStWZ05yUzRK?=
 =?utf-8?B?NVpRWDl2Vm04OUhHZ1l4MVpZVkNrSFJ2UTh1NVNjZWJ4anpyaHNHS1Ntb3Bh?=
 =?utf-8?B?MEJmRDhESHpWbDZYazk5ci9pWlFKY1poZ1lVbDRiQ0VaczBlQm5oVkJvNmRC?=
 =?utf-8?B?UUxwbnZuUjVMYWhIOWNlUUZmRkFIaXovME52c1I2Rlk1R0JKRUp0N3VRb01W?=
 =?utf-8?Q?2+T646RZjRzdriFoTfSHCW8o/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8550b8-1aa3-434c-b69f-08dc734fadf9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:22:04.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dW+xhuuolacoWseXd12cLlk2j8xFWOwgA1UPD4OC484kja3AXxlv+us+9RZdyv6Xnd/ublOIUGQCYhNQkAIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments

Nit: change commit title prefix to vfio/migration (also in other patches 
that are closely related to vfio migration)

Plus, maybe change subject to "Add an Error** argument to 
vfio_migration_set_state() and adjust callers" as it's the main subject 
of the patch?

>
> Add an Error** argument to vfio_migration_set_state() and adjust
> callers, including vfio_save_setup(). The error will be propagated up
> to qemu_savevm_state_setup() where the save_setup() handler is
> executed.
>
> Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
> store a reported error under the migration stream if a migration is in
> progress.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v5:
>
>   - Replaced error_setg() by error_setg_errno() in vfio_migration_set_state()
>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>
>   hw/vfio/migration.c | 76 +++++++++++++++++++++++++--------------------
>   1 file changed, 43 insertions(+), 33 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4..9b6375c949f7a8dca857ead2506855f63fa051e4 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -82,7 +82,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>
>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                       enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state)
> +                                    enum vfio_device_mig_state recover_state,
> +                                    Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -102,25 +103,26 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>           ret = -errno;
>
>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
> -            error_report("%s: Failed setting device state to %s, err: %s. "
> -                         "Recover state is ERROR. Resetting device",
> -                         vbasedev->name, mig_state_to_str(new_state),
> -                         strerror(errno));
> +            error_setg_errno(errp, errno,
> +                             "%s: Failed setting device state to %s. "
> +                             "Recover state is ERROR. Resetting device",
> +                             vbasedev->name, mig_state_to_str(new_state));
>
>               goto reset_device;
>           }
>
> -        error_report(
> -            "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
> -                     vbasedev->name, mig_state_to_str(new_state),
> -                     strerror(errno), mig_state_to_str(recover_state));
> +        error_setg_errno(errp, errno,
> +                         "%s: Failed setting device state to %s. "
> +                         "Setting device in recover state %s",
> +                         vbasedev->name, mig_state_to_str(new_state),
> +                         mig_state_to_str(recover_state));
>
>           mig_state->device_state = recover_state;
>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>               ret = -errno;
> -            error_report(
> -                "%s: Failed setting device in recover state, err: %s. Resetting device",
> -                         vbasedev->name, strerror(errno));
> +            error_setg_errno(errp, errno,
> +                             "%s: Failed setting device in recover state. "
> +                             "Resetting device", vbasedev->name);

Here we set errp again when it's already set.
Maybe in this case just:

error_report_err(*errp);
*errp = NULL;
error_setg_errno(errp, errno,
                  "%s: Failed setting device in recover state. "
                  "Resetting device", vbasedev->name);
?

>
>               goto reset_device;
>           }
> @@ -137,7 +139,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>                * This can happen if the device is asynchronously reset and
>                * terminates a data transfer.
>                */
> -            error_report("%s: data_fd out of sync", vbasedev->name);
> +            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
>               close(mig_state->data_fd);
>
>               return -EBADF;
> @@ -168,10 +170,11 @@ reset_device:
>    */
>   static int
>   vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
> -                                  enum vfio_device_mig_state new_state)
> +                                  enum vfio_device_mig_state new_state,
> +                                  Error **errp)
>   {
>       return vfio_migration_set_state(vbasedev, new_state,
> -                                    VFIO_DEVICE_STATE_ERROR);
> +                                    VFIO_DEVICE_STATE_ERROR, errp);
>   }
>
>   static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
> @@ -399,10 +402,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
>               ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
> -                                           VFIO_DEVICE_STATE_RUNNING);
> +                                           VFIO_DEVICE_STATE_RUNNING, errp);
>               if (ret) {
> -                error_setg(errp, "%s: Failed to set new PRE_COPY state",
> -                           vbasedev->name);
>                   return ret;
>               }
>
> @@ -435,13 +436,20 @@ static void vfio_save_cleanup(void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
> +    Error *local_err = NULL;
> +    int ret;
>
>       /*
>        * Changing device state from STOP_COPY to STOP can take time. Do it here,
>        * after migration has completed, so it won't increase downtime.
>        */
>       if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_STOP,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +        }
>       }
>
>       g_free(migration->data_buffer);
> @@ -549,11 +557,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       ssize_t data_size;
>       int ret;
> +    Error *local_err = NULL;
>
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> -                                   VFIO_DEVICE_STATE_STOP);
> +                                   VFIO_DEVICE_STATE_STOP, &local_err);
>       if (ret) {
> +        error_report_err(local_err);
>           return ret;
>       }
>
> @@ -591,14 +601,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
> -    int ret;
>
> -    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> -                                   vbasedev->migration->device_state);
> -    if (ret) {
> -        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
> -    }
> -    return ret;
> +    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
> +                                    vbasedev->migration->device_state, errp);
>   }
>
>   static int vfio_load_cleanup(void *opaque)
> @@ -714,19 +719,20 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
>       VFIODevice *vbasedev = opaque;
>       VFIOMigration *migration = vbasedev->migration;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
>                       VFIO_DEVICE_STATE_PRE_COPY_P2P :
>                       VFIO_DEVICE_STATE_RUNNING_P2P;
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>       }
>
>       trace_vfio_vmstate_change_prepare(vbasedev->name, running,
> @@ -738,6 +744,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>   {
>       VFIODevice *vbasedev = opaque;
>       enum vfio_device_mig_state new_state;
> +    Error *local_err = NULL;
>       int ret;
>
>       if (running) {
> @@ -750,13 +757,13 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>                   VFIO_DEVICE_STATE_STOP;
>       }
>
> -    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
> +    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>       if (ret) {
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
>            */
> -        migration_file_set_error(ret, NULL);
> +        migration_file_set_error(ret, local_err);
>       }
>
>       trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> @@ -769,13 +776,16 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
>       VFIOMigration *migration = container_of(notifier, VFIOMigration,
>                                               migration_state);
>       VFIODevice *vbasedev = migration->vbasedev;
> +    int ret = 0;
>
>       trace_vfio_migration_state_notifier(vbasedev->name, e->type);
>
>       if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> -        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        ret = vfio_migration_set_state_or_reset(vbasedev,
> +                                                VFIO_DEVICE_STATE_RUNNING,
> +                                                errp);
>       }
> -    return 0;
> +    return ret;

In MigrationNotifyFunc declaration it's stated that:

/*
  * A MigrationNotifyFunc may return an error code and an Error object,
  * but only when @e->type is MIG_EVENT_PRECOPY_SETUP.  The code is an int
  * to allow for different failure modes and recovery actions.
  */

And indeed migration_call_notifiers() will assert if this notifier fails 
on MIG_EVENT_PRECOPY_FAILED.
So I guess we should simply report the error locally and return 0.

Thanks.

>   }
>
>   static void vfio_migration_free(VFIODevice *vbasedev)
> --
> 2.45.0
>

