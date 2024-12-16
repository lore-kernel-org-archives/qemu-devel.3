Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D13FE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCLz-0007n4-UW; Mon, 16 Dec 2024 09:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCLy-0007mu-2d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:45:46 -0500
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2009::609]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCLu-0004Q4-VA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:45:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSm9tsIDgcbguZZj7KEJQBpfmcdHA+ZmzeRR2fAWnM6VWKriVwIm6/5SI5d1IURKOC3clYYGdhlk6rUuin4kJ6X/nzWC7VmJ2aJftBqheoXBpB/R/hUqWEgLsjjYv1ES5+erTp6zLvmBUsLbESrMZwwZF7rgHoRyvnYz2Y+sS0BJb+hvDCQFpqLtT3YRPbiLILD/J+9ZEP1Xgo3gmYm13LtAUJ/7+xyyv52kgZwPRzQ4t7LwLmh4mtZWTcZY803fo36naC4augVuVyDx71DaqcW2lqaS1Oni4KMYLJR3SCQl8GFJXcgRN7xK3eH11W+kId3PM1dN+J+gPIADw7o9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=702XPeu+iuDkmKDXVW6kLYH6Y8OTcYRyl0FfaUCG9RE=;
 b=YbF0CAC8lFEX7x9YDS1x1FQSk1nrfMtI8Ahpcuh4jVlO5gnmeUptDqcv2Ru/VOqGMoWXjeBeUt8tWcMh6Vfo90Z8x0dhNEGEExkwUBPB0WBb1GqDIN3trcMcQvu8SYmvmt5M/nOcO0zAuJrdIG8z1z+rbzlU2GWLf0tvHrC76tQfzNHg/oNwC1HtvIxWufC+sCTx2hApIonBqAfQjA7LHtGOjiNvE+WYu6oTwDnfObMp7QgLRTIAsyMAVGin5GkGnvfTIO2LENLct6lgkM4s3M9GcJtELeKImrkfvgsZAwBpmcqJPbtVNNY+SIRBSBavReE8Du4HG7tKlPRQ0eoDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=702XPeu+iuDkmKDXVW6kLYH6Y8OTcYRyl0FfaUCG9RE=;
 b=UhgdWj3cV/aUo9YBb7vfEXtn3OE5PV3c/JaznFWoL4sZQfH3QlRWxVCAMjZtQBOzq35Tjd+oneRGuPLUzXNSi05FJigz997oK7zgx6xfyzWw2IScHnUtR5+9vPJfpHEbMYNUbg5VuEFNwdh4OXlH++fIXg980m357syGRz5sLRir7PiIaUEgDTUFU7ZCRqYueMuAp8Ah/f0scV0FUfaAjdncg2Vvoi9GUl7CW4n8JAZMgbO9BU2cDx06eTf/IQ5evAOEsJabqyGYHysUcuOXb+CpM49AfL3WlLFkqtSCRgRvuRmbDB5rDDanLhHS+PBApUM75yQmAFONAtF565Vy9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 14:45:37 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:45:37 +0000
Message-ID: <7d753d6e-a71c-4442-96e2-fbf1fd04133f@nvidia.com>
Date: Mon, 16 Dec 2024 16:45:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <934927b9-eaf5-411a-8151-7617218d0cad@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f4a9da-3419-4ac6-0fad-08dd1de04dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3RnWmdmVVVNMHBxYVVNY1lQMjNTNGxxZ2tTR1ROSXhnQml2SnFFK3kvNzhU?=
 =?utf-8?B?cVE2OUlLNUlXRG1RRFFiTnJGNStOeW11bTUxcktwVW1NM3pOaXlYWjl4T3Nn?=
 =?utf-8?B?anBWTS9OTW9hdHcreTVGcFYwdWNic29tV3pPY1lNdzV2VUNQRXc5M2hqZ1pT?=
 =?utf-8?B?TW9XM1RQTG1iRXR1SUFheG82UStyUU84anlpZVNtVUJ0L0ZleHlsTU1zV3Vh?=
 =?utf-8?B?TUptSTZaTDQ0Q3dKaGNQWTlEcjZWMnBjWWhENktFc3YyYkFkcnJ0ZlFnaHNW?=
 =?utf-8?B?TCtIeEw4Z2hVbjZLdTI1Z2J2bjNnTWtBS2Y4WGRuaXpXWlZ6Q2dVSk5zbVVT?=
 =?utf-8?B?c05UZDliamljM25BTmNqakQrUVRwV1dBclVCa2E5UWJxaVBYeFFmaUZTVWZD?=
 =?utf-8?B?azVUeDVtQ2lhQkk1WS80djN3WWpSa0dBTFVaYTJoL0VIeWY3dEl0SDRtVWlz?=
 =?utf-8?B?WmxLUmlHL3lieGJxK2szMGJLdWpSNWlXOWdia01BdjVrRlllR2toV1RRV1JT?=
 =?utf-8?B?SEZLM1VwWERBK1JmZlNvNDUvVWpZcU5DcDJzaUdSYVQvWnY2UnRLcnQzcndF?=
 =?utf-8?B?LzZrSnNDdTg4ZUNWZnRWclliNWpwdW9KeUMzclY3RnRqQjNTTCtQd0dGV2Rn?=
 =?utf-8?B?TkY4Rk1nN0QwWnI0MG43VWpEMmx6enRCem5oaVkvM0M4T2NveUFSaDhHMmF6?=
 =?utf-8?B?UnMzbHJzRnljU2tLL3NtdHV6RmVXd3cwVmVLUFNuaGJpdU12V05WeVhCUC9N?=
 =?utf-8?B?eVpBcWk1RmNFbEptN0cyMTh2bVM5UjRGTzRQVHQwaGl5aDc3ejFkRm9CVENt?=
 =?utf-8?B?OWd6UXJnNnc1dlBSZU84QzBVSjdJcTZwUzFrQm5wMGtUZDJhL1pHamZ6ZUp6?=
 =?utf-8?B?K09YWEI2cUlPbGpSVEcyYzAxRFlpMnZZOVB6clJzVzVYbSsvK281Q0lVS0V4?=
 =?utf-8?B?N0E2a3hJd1lEeVVLOEJqRHhDRjlRMEZuUmh5aTFXWTF2QjFiRmw4WjNNOGNS?=
 =?utf-8?B?UE14eWxvaXhFRm9WOVR3TmF3RWZTVlp3eHpPczM2VGF3aUwrcndXNU1IcTJr?=
 =?utf-8?B?Mkx3U1FVZXNwVFFvZHRCd0ZVYTV3V3IvV0phTVlaZU1Iay84cFVzVlc0bk92?=
 =?utf-8?B?QVlZRitDV1BrRXNhSW5JTlk3NjVnSnhNVU1BUlRBVXc0dHRKd1YrUThGbG9O?=
 =?utf-8?B?LzBnWHY2STFxTTBySUZ1SVhWSEthMjVlK2E1S1pJN2Y3aXRQMFJWREJFN05M?=
 =?utf-8?B?WkdlOTJRVFRCUzhsMHd2UVMyUzhaeUxqZFZUV2FjbzhubkxPQXpteWo5RlZZ?=
 =?utf-8?B?RnM1dW56OUFhaHpVNjdTQnRyZm9kemdjUGxxZFp2R1ExYnJlL1JGY2JtMUVr?=
 =?utf-8?B?K0dTOTExdXkwRkxlWW1BWitXUFAzNHRXNEFlek9CbnFpY1p1TlZpSk9RNFFk?=
 =?utf-8?B?ZU54eXNOclBWTnVwdWR5NUpWTlFXM2xUY2xUYTNKQ3dVVGFVdXJUVzZSaEZK?=
 =?utf-8?B?bGM0b0dLbnJnTFUrUTZ5Ly9Obmh5OUltMmR4WkNtTUhLeCtFM0M0ejhIZVZT?=
 =?utf-8?B?L2ZVdU1MajdndVZqR3BjWGQ3dW1zWGhtd0ZyOU41eE1uQXlrTWpMZkp1bUlz?=
 =?utf-8?B?bEFXajdGN3J1bDRYb2FDSWZ3cnBqWWVxZ3k1NkFaZ3JEcmVKLzZrYmJQd1Mr?=
 =?utf-8?B?RWFuYzJKM1VZbStxL0xtcnZSNEdqck5aS3ZDZ2s4STVUendMeWhqRlc5UXVN?=
 =?utf-8?B?SVNjTUh2SUpwTlF2RGZjMDcxNnQzN3loRkxjLzlzT1E4SEVQUEFTS2xOZ0h6?=
 =?utf-8?B?U2RLNk9vUUNSRlp0dXRMalZNRFZrRUFPcC9jQ3FiSjBDS1FLV1Z6YVpNa0ox?=
 =?utf-8?Q?WjbTauhTRbae+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFoSHVxeWpnK0QzUDBBYWFrc1V3YVhwQjVlVWxHcjJRU3hrdExYNTFldjk2?=
 =?utf-8?B?UWRES29ldktxdkpOSXJ5cmtaSlBRbm1sSDNvYzZuWC9jREhyRnAxRFAweG52?=
 =?utf-8?B?cjA2ZWZZdHFrOG5qYXp5ZUFCWmk4RnlvU2xFWjg4TkxHTHJmS2wwTGhRUHdE?=
 =?utf-8?B?UlQ3M0ZTbG5JWHFqZ3BHQVRwOTRFVTBJTTdDcVJiRy9BNDBlZ0MwTU1kZFJM?=
 =?utf-8?B?c295bXRBeVdxREhNRkE5VWJvczJKd0Z1NisvdUpReWJON3hpZXprVXFOaHR3?=
 =?utf-8?B?UHdTVWVZd013T0FORFc4MEpta2pqR3JDcTFBWWNBUW0yVG5KVDZOSUxITDJw?=
 =?utf-8?B?dGtRMFZQRFVJTk9zNDZSTXFyalQwOXI2V1FaYjZIamtXMzRvakxpWmYyanYz?=
 =?utf-8?B?a2VRSDExUDBsSG5xRmsxVzZwNVA4YVFlMDVURUhNR3ZBSXJLTk14MGdFTG5S?=
 =?utf-8?B?SWUyYXQ1dVgwVFd4a0lWOTB6NUxWMVlIYjhlQ1lYc2pOL0R1VnNvMUZUQlh6?=
 =?utf-8?B?YW95R0tjcGcwMGJuREd2Y0VmYk1NL1FlMWNoZkNtOEJlR2lVWTFTNy9pbDhs?=
 =?utf-8?B?QS9MaXc1T252MG1NTmVObERHWkhpcHlaWHVPeTg1M1JhcTlGcFJYWjR3TXFQ?=
 =?utf-8?B?aGNlTnZGWi9SYTRjTFQxSStUMVlyZllkczc2WElBQjN2ZG1iK3JiLzU5TmMv?=
 =?utf-8?B?dEtwL25ORS9xMjhzaHpjZFpDWE9FYm50RVJzVkJCYnFoN1dpWng3QlFyKzAx?=
 =?utf-8?B?WTRQQ1BYK0ZjZXVYNFpycElsRmwrTTN6UUlZNUdXdFFqL2FmeThNdUx3bERQ?=
 =?utf-8?B?bzdxR1ZyY1E5OEUvVnFVK3h2RHJ1TjVVbjJVdGNiblg4TUpHMzF3T21xTG1h?=
 =?utf-8?B?b3o4Tk13K0RhSDlyQ3FkWTRVN21Nam5hNkhVSmNZdU9xWEJoQUd5Uk9ZeXNq?=
 =?utf-8?B?Qk52VlFyaGpFcTM1bWhWQ3JSc1JmaDlaZWtIZThUVlNrdG5INlc0OUFxdE9h?=
 =?utf-8?B?Y3pyNkVZV01KVHV3di8rU1ZaNGRPU3E5T1hDQzdBQVhaUzlYYSt4NGFac0NK?=
 =?utf-8?B?dEdxUVVBWTF4UWQwdkdkcWlnSXhoV0RhSXlZVkZMODZNcFJjb1Z2VmVIT0Rh?=
 =?utf-8?B?bFB3VmZRQ1loelBGKy85TjdzMGRjMm5MdS9mTVk1T0NwMU9vWW95aGFqMXcx?=
 =?utf-8?B?RDNQem1TVGlqc29MbjRFdVJoUEd3dUUwWUhicUp2Q0pQT1M0YVZIc1JUVVhY?=
 =?utf-8?B?T2Izdm1wMkRibUdZeVhFWEt5SGFSdnFFMnZLc3RDYUxFaUhCSFpNL0hGWCt5?=
 =?utf-8?B?S0FjeEVjb21QSUlOWXFGUTJiYVhVN1lEZnNraSs3bmJ2L0Y2S284ZzNxSStz?=
 =?utf-8?B?eTBCMmFGL2hJSkI4R3ZicWZoYkZhd1BCOG4vZzB3a0hFaXpyZ204WU5Yai9U?=
 =?utf-8?B?ZkxSNnROTkJOT2dCMis0VDAzcDlOdUR6MXE1eVNKTmt6bzByeWVGdUpsVE8v?=
 =?utf-8?B?dHo3UTg4c3ZtZ25xNmErNjhPM2tMMFdsbDBmenpaVENKRjBDMXlWaTl6QjRh?=
 =?utf-8?B?MlhsZGY2Zk9lMWZtd1VkdkJWQVlrV0JnTyt0L25tQ293SkRpWk9HUmhSaVFD?=
 =?utf-8?B?V0J0SitHMGU0VnFxeGVuaXRzbjg4ZytRSk9QOWJ4ekFVWndNUTQwb0ZNT3Yw?=
 =?utf-8?B?VnFuWTNzZnpwdDNuZVhZbDk1STNhdE1LWEM1bmFzakc3SytzbWxzM0ZDVXg2?=
 =?utf-8?B?Tnh1VHZ1UWpWcHhxK0dpVlpkVStkZWlmZlA3aTVXMFNhYkV6cmFmcWFmY2hI?=
 =?utf-8?B?Mms4bUdDb2YvZXVESW1hb0FZb0l6Tnh3czdUTFprK1VaTlp6dWY1M1RmNVVz?=
 =?utf-8?B?VVM1RUR0Ty9GNUZRbjFKbnBuTWxZTHZDdFNuVjYyNTlMWnk5WDZyWXNLengy?=
 =?utf-8?B?d1BtK3FsczJ4TXZQV3BxM1AxaDYxOVNIeTFjUXkydzBKeWVkL0EyaFhTakdR?=
 =?utf-8?B?NTRSeGEwQkFVbCtyYXpKd1lLVk1kNFMwVmtQSzlmOVFvRW1MVFVuUFlnV0lt?=
 =?utf-8?B?ZHhvS2RPbFVhSzJRc2NzaFdNMHpDL1dMUHQ1cUhKN0IyVzk1bDI3QmdKU3Bp?=
 =?utf-8?Q?BsrhncD9gSSXR5WmvzPU0qHs+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f4a9da-3419-4ac6-0fad-08dd1de04dc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:45:37.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFvRR8a/G0G2wKAiqahu5CE2Qx0KuOe4ByK7Z7XCSbqtK5/RSCXAgc5KXtvNUPC893isrs3LOzM+XEL0MBLuKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
Received-SPF: softfail client-ip=2a01:111:f403:2009::609;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


On 16/12/2024 14:00, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 09:46, Avihai Horon wrote:
>> Hello,
>>
>> This follows up on Peter's series [1] to simplify migration status API
>> to a single migration_is_running() function.
>>
>> Peter's series tried to drop migration_is_device() and
>> migration_is_active(), however VFIO used them to check if dirty page
>> tracking has been started in order to avoid errors in log sync, so they
>> couldn't simply be dropped without some preliminary cleanups.
>>
>> This series handles these preliminary cleanups and eventually drops
>> migration_is_device() and unexports migration_is_active().
>>
>> The series has been migration tested with the following:
>> - VFIO device dirty tracking.
>> - Legacy VFIO iommu dirty tracking.
>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>    currently blocked, so I used a patched QEMU to allow it).
>>
> vIOMMU on IOMMU HW doesn't suffer from the same problems of VF dirty tracking
> where there's a aggregate limit into how much VFs can track in terms of IOVA
> space. So we can lift some of those restrictions for IOMMU even right now
> provided we implement the last remaining pre-requisite.

That would be helpful if there is a user who needs migration (with iommu 
DPT) + vIOMMU support right now. Otherwise, we don't have to rush and we 
can do it along with the optimizations or whatever we see fit.
I only needed migration + vIOMMU to test the vIOMMU dma unmap flow.

> I also have a much
> smaller series for that sort of unblockage that I can give you a pointer.

Yes, if you have it at hand, that could be useful for testing next versions.

> Though, eventually the optimizations we will do for VF dirty tracking for vIOMMU
> will apply to IOMMU HW too just so we minimize the amount of calls to get dirty
> bits.
>
>> I didn't test it with iommu DPT as I don't have access to such HW.
>> Cedric, I remember you said that you have such HW, it would be very
>> helpful if you could test it.
>>
> I am starting to prep the unblocking vIOMMU for Qemu 10, so I can validate if
> this series works as well -- but from what I have looked so far it should be all
> OK.

Thanks, that wouldn't hurt :)

> If it helps I have some pending series that lets you test emulated x86 IOMMU
> DPT support (either on intel-iommu or amd-iommu) that can help you when you
> don't have the hardware to test.

That would be great, I didn't know such thing existed.

Thanks!

>
> Regarding this series, since you are looking at the the dirty tracking 'status'
> I'll comment here too as one of your original patches introduced it as it's
> related to the use of migration_is_running(). And since you're looking at this
> exact part of the code, might as well cover that too.

