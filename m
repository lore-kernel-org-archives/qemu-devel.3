Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E326BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W8O-0007h2-Bx; Mon, 13 May 2024 09:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6W8L-0007gn-1A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:54:30 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6W8J-0002st-5O
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHE7eZi1IcVnXIxN+jptMG9cAp1DVCVayOrhNyVDNwULN5OXRCJ3X11hmE6IyOhAccE577J9zFhrKz6yj8xt24va1tHF/KdnltaECQ5c1hWCIFxAt5UVL1dXaSlzaTETnFbOVZNxgKW+G2zrBjw0z2cUnQYJ6VLH5xfQUR/oEpNRxC0QX+9bBwrAZPqGGAzrlNPMg2yyc2lmrUL8GpHnV/izA6soi252EecFyMzZdLh2sjh753usVsyac8utKVTsXD390Rj/g5/8b8C0nhZO93z1eylVfQ6VDlBAef0aWfQ5w6JP4VYw+LTGuqVBh+C80c/Q7SOcg7CklOo1/sxzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lH8E63sdEvzd2ZY9aIIzLPtsQczyPAgbKc/2QZc8Sk=;
 b=NmViBlpvjjFpq2rmLvCrZSl3WJwgRuEncOR5xr/TwNtJlXvKw0IMY0N95e4nueIVBQHlKll+Z2Q7Wdu9huHfiqcDWKT2HjXFBssaDVTYBoqqbnfQAhKpWfBVXRsYWvxO1xLPLuxThmKQ5Opo+Zlc4Q1N+RlergwocfYaiB48akFmTfP6um8ZltSK/BnkUXEPsscDUUcC8hK/9tTTULzBkcytiswCw6eMSNbDjpC1IdyQp8AuxHE+4ph4wVIhHCFpHkXfh8WTWL693kvBN+FdurvGK6+xtGT4K+iFBB7/6mae9xNMB9vYUKtmzeM4QUVDqjfctl67w1Nl724CnWJtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lH8E63sdEvzd2ZY9aIIzLPtsQczyPAgbKc/2QZc8Sk=;
 b=nnsV58Zlok7D7CfBEIDz8uF9mzQSWxuVS6/mVZG38VA6rtFC9MNMIf6EdBPY5J52nDYEtnIEdKTI5qW+cIaO+aRwSnwdoNjRyCGuNbhHmEG1U9HSjG4DiVW+Y4NcJZr/vIQIxp2Jcx2lehtRzyz6M9rGNSBzGmDwibh3IEndt940ypmEcE3w5ir9ZNM4+FvwiAu6zEI8L3u9dAwXJh5+rQNbjCMYZFGAqMpuEc5t0JlytCnUv3sVzY/scfiwOt/iFBz5akkX8WzYIzMrhYEurv+j6YE+50eOoRZCnWxyKGMLd2cdM14990kM6gc7mpF9H+801m3BnvOjXT+7furTpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:54:22 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:54:22 +0000
Message-ID: <5d76b49c-8d47-4488-91fb-8736f80ba17f@nvidia.com>
Date: Mon, 13 May 2024 16:54:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] vfio: Also trace event failures in
 vfio_save_complete_precopy()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-10-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0405.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::33) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: e23661f5-5d96-4c0c-d662-08dc7354312d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlduWE91NGZWcGExTzBGKzgwcm1uMEVDQ2hpUmtNaENRaHozbE1ERVJpRlls?=
 =?utf-8?B?alVsREphMGdERHQvUWlMSkl6b3BWejVmcTFESURucFE2UUUrdWRlejVZK25P?=
 =?utf-8?B?b1lwdDZMR3RPYmFQOWtwNk1tYXpCRUZlSnNXeFBhS04vTk0xNFh2MXVDNEFM?=
 =?utf-8?B?dUh4VDZoNGxlYkRJSm1KMjV4ZDNGMlJPT3VIWWFVcFVkdUNPQXR3OEJ3VUJL?=
 =?utf-8?B?ZUJtZkczZ1RrL2VjOWtvenlxOHdkRkZjYWtXOUhONDhTVUxUNjJmamV6S3l2?=
 =?utf-8?B?aS9TL240ZjZORDNJeGRQcURWOTZmSjZvQ3piZ2N6cmVMMUVHbHkxZmd2elVV?=
 =?utf-8?B?MlNUeXBzbnFDZEVJY0VCeHBXMi9Dd1RDYnN3cnhxdDc5dkVIWlg5T28xQjFw?=
 =?utf-8?B?QVpydE4rYXVFUXNsVlgrWE94ckVEYnpaZVlteGs2SGlmb3N1dnZKcTJ0emR4?=
 =?utf-8?B?bURpMitsWTE2Nm83Q0QzeHdrZ0ZiZFkyQ3Z0VnlBUExybm10UTdMNEtvSVVY?=
 =?utf-8?B?dU5OQ0pUcWhpMC9sVHlDU1ZZeGJTcDhnS1VOYUw0SVlobTJOamFDMm53aGph?=
 =?utf-8?B?VGhPczNFa1laajI4eCtMUmZ3TzNwTDFyTWh1VkExTkFhTjZPRTg1SlRreTFJ?=
 =?utf-8?B?a01Ud2tyTm5RWnZocVUvM3NmT0Zzc1ZuQzdJc3FRR21qdzZ1Zy9yV3hKNnFC?=
 =?utf-8?B?Zyt2UTV1TGtuQmdaMDZLUEY2Y0tZc3djd3VyZmZMcXdjd2llWEZ4Vit4ZUt4?=
 =?utf-8?B?ZVJ5RnJYeVNHdGxqbXE4dzVITmkyckNRbVdQd1pBT0FyQ1d0SkJ4R3ZibGdw?=
 =?utf-8?B?M1dNaDRlT0VUcVBEZGpKY050bUNCMFYycGVSK0FYd0NRTjRSVDVsVnhwenMy?=
 =?utf-8?B?ZFdld01PRlp6a0ttNHVwYXJhSEZSdHRicmRYZG00dEpCbU9ya3hHRG93Wmw3?=
 =?utf-8?B?ZlhHaTMxOWxJNDRvbWFkaTdXZElpL09waW5jWUIxazNTVTE0MWlLUVFoVVlm?=
 =?utf-8?B?UFFCMllXY3ZNV3lJNGlvMG1uY1dqakZOai9Ea2d4QUxReFoxU0xkaGRKMFhQ?=
 =?utf-8?B?QlRGYTFveVM2WE00eEtUUi9wdE5GTUhDRkh6Q3hYVWRGdG01K04zNGZ5WE1q?=
 =?utf-8?B?VjN4cDY3RUFiZU0zZWx3YnBoaXJpcTd6OU5ac2s3UTZYZXB6c05iKzZhdlAy?=
 =?utf-8?B?SlVkUGZVcWdaTjRick1acW1TY3JNRG5IeDNLNnVaQmJQMzNpR25BU2o5YktP?=
 =?utf-8?B?UjZEVmNVQjV0VzRKQVZMOTVZaWlkL2krQ09qV0VJVHE4ZjVwZ242MDVUY2tj?=
 =?utf-8?B?dDNxN1dORDY4a2lEU1VFOG1STjIyaFBCWlJOVWhYaExwNUg2d1M5LzZJODdC?=
 =?utf-8?B?Q2p0U1NTNHFaTjdIUW1taGZHc1MvTmRqZkZmVkNPVGI3aUFpUWVibzRpaWM4?=
 =?utf-8?B?R0pzSUI4NDc2T1JsVS8ra3dtRkh2eE4xQ0xVOEZOZGVRZ3lXRWR6eDV5di9F?=
 =?utf-8?B?ZEFrQWRQVndrU1JJekpidXBNRXhkc2pvS0VaZ1RhQ0wzK2p3Wk4zdGk2Vkdj?=
 =?utf-8?B?UmZGR1RkUzJ4TW8yWUt2V0ZxUDBKVFZ6R2srUVJGR1l3Z0pQU25yc2dHRU5P?=
 =?utf-8?B?RjdOMXUvZVpZbU0zc2tST1Nvcy9maVBRbWs5TXVwdjlzbHFSR3J2U3RHU1JP?=
 =?utf-8?B?cW5NeGtMU1NTVFQ0R2lhS2paTmw0NkdtWkV0MmM4UTQ0cnZ5Tm91Tk5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXlPQm9Qdk5VbVYrckw3MEJKdG83VFViYmdxY0srMFFrTEN0SW1PWThGLzRF?=
 =?utf-8?B?TXNoN1o5S2pHNVk5RG8xZ0N4anlPUThBM3dvbmtEUklhbE5HOUxRcjJrdWc4?=
 =?utf-8?B?clBzOHRHak5MbUlSS3BKZzdhZ3lvWTdYdUtvOXZhTWRpYVFYY3UwU202L3l4?=
 =?utf-8?B?b1gvSWIwVWhTUUZNQkhuckhTaE9MOWtoVmQ5L0RJd0xCLzBCcEtWUEZCY2RW?=
 =?utf-8?B?aTZSTGIwYlF4S1llYy9BcnNlUVlkRWlJdURsMzAzcTZ6RVJSSkVpLzgvR1FC?=
 =?utf-8?B?L1BzaktZcG8xKzFCV29sL0hXZUlBYU1OQkkzTlBwcXRpV0xPT0t5K0M5dldy?=
 =?utf-8?B?OXlWancyOE1FSmJpdzNWaXRmSVNkSkxvWS9BZ0o1ZW1EeTJseUt3WG5aZWNF?=
 =?utf-8?B?YVFYTGtMakgxSmdIeDQ3Y3BHb0JRQVpZdGxWaEFkSlFyWlJIQW1zdFczL09B?=
 =?utf-8?B?QUxlZWMyMWkyRXpYenRsdDdhMkhwdW1rTW5WQTQySXZLa3BHVTNYWW5haFAw?=
 =?utf-8?B?WVl2T0RlaFEwMGFjTFRUREJYanBLQkQveUFFNTNpVHVwYThIVFFhM0ZLMWRj?=
 =?utf-8?B?TThCaVIyS2Y5elhNN1Bjb1ZBR3piaWhrT2dQMTZrMlkrLzhYWXh5QmlhL3Vj?=
 =?utf-8?B?T3B4S0xnbXJOenhnZDBCZys3amxBWmlEdDFVemJ1MGNaTjhXc2V0Y1h1aHF6?=
 =?utf-8?B?aWU2NTIrWTZBcHlROUgrN2JqSnNqY3NPVDY3OXpuZ0ZrZXkvRnNnc1hBMlUy?=
 =?utf-8?B?cDE4YzQxNzNFT0tyTk9DajFicFN6UzBsUkFBN2NqZlhpYzNMSWw0azY5czVu?=
 =?utf-8?B?bU5LSnNCN0o3NTlLQS9rdUVsYmF3Sm1XVmRWdG1TOW53TVgwSVRZM0tUbS9q?=
 =?utf-8?B?TmNUK2VDYjJPNW9yZTNjK0dTWTJqZlYvQWFqZDEydy9LWkVtbjRLVkJES1FO?=
 =?utf-8?B?V08zRXBhVnZYSGV5V2VpeUN5c043U0QxRXo3VzJlYkZUazgxTi82WUc0NkdS?=
 =?utf-8?B?dE55dThrcVJUWGZGVkFnUmZUQkN0S3F6NEdVaXlPOXEwK3l2MFZSSnFQd1VL?=
 =?utf-8?B?RlA1S0ZURlJ1aGt0OCs4b3ZTL3MrUHBoREgwdGFMcEoyNFhkb2xORjc2R0tT?=
 =?utf-8?B?ZHlnZ2RIclBUWHJ0MHVzRkJoWDRvMGV6bjZySW9RWGFtYjhFNzFneThvOXhi?=
 =?utf-8?B?UXdWS1o5NDJ2Wkt4TEZwanMrSlFxNzVSK3ovRFVacVZXTVY5MlRLQXlUcjJu?=
 =?utf-8?B?MjBEVUV3UitVWXBNV2RpYVY0RjZmNkRsTWJib2NqUkpUYnBCOW9NT1J2azFa?=
 =?utf-8?B?VmVYcWhwZHdyNEJVbDZTZHhvT0ZUQ2RBUk16NFY3Yy9mc1VGQW94SWZHVVZ5?=
 =?utf-8?B?emdVYTN5K3Y3TDU5TG9Fek84OHVNVy83azNCNi9pVEVmSzNSVDBBanFzdlM1?=
 =?utf-8?B?MWlYQlFWTnFCN1cyUnI5SkZ0L29yR1NmSEkwVWtDdG1Qakd4dnFsbjk2cVlG?=
 =?utf-8?B?MnFVVFV4UFBwVU9JSjd6bzRPU0lFR2kyMEFFNFRPb29YUDZTTlpVVzZQQzVC?=
 =?utf-8?B?VVZjT25YY0pnMDF3WkZUSEVNSitRT2kxMzUrQVlZRUl6dUVYOG00YlBBd1N3?=
 =?utf-8?B?bEF2bHF3cjg5YkhaeU1tR20yUzhaK2ZNYTBrWFhINXhLTm0zNWNLN2N5eGE2?=
 =?utf-8?B?YS9JR09FdzdFTUZvd29EMnN3UnBQcFJ2OUIvWkNiNDUxcWZZMkJxZmtEUFg1?=
 =?utf-8?B?czljdWN0elNlRlY5UnJqb3FkMmk2Tll1Z1pyUHNSN2pyMm13NlN3K1lhemlH?=
 =?utf-8?B?bVB2UE8vSXd6d1h3WXFRcGV2R2U4dVZEcjh0S05GOVNiZmRaUkJieEZlODJs?=
 =?utf-8?B?ZURiamtuWnZoV2h3WGRDcEcwY21DVmhzckhZUnBZMmwxZ2tsY3JwbWV5KzNz?=
 =?utf-8?B?cUxOcGRKWSthdjlxTklvU3E0SUZnSEJ4Qjc4bEw0LzlnUW40dy9sNWxQU0lY?=
 =?utf-8?B?S3FoYXFkbEtZeGhKNWhDQXB4WEFnaG5xbzljTGxuYmh3VlJtWXBpQTN4TGJ3?=
 =?utf-8?B?dE5rTWZqWlFTczdad0E5TkNyVFRja2RackI2VzQ0d2hIa2JQSS9rK05keFF5?=
 =?utf-8?Q?OGMi+WGCWzXHnqQO3zr2U2t5Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23661f5-5d96-4c0c-d662-08dc7354312d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:54:22.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDcC78rzjB2D2czeVXTdVHYBTcL2Cxq90ehukbMBWShJunxP7UWjNO2lJblV/505NZOXTXHVSfaI3ZcXFf697Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
>
>
> vfio_save_complete_precopy() currently returns before doing the trace
> event. Change that.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> ---
>   hw/vfio/migration.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 87437490bd50321b3eb27770c932078597053746..88591695a7b61c1c623c707334c5c57f5e54c58a 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -581,9 +581,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>
>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>       ret = qemu_file_get_error(f);
> -    if (ret) {
> -        return ret;
> -    }
>
>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
>
> --
> 2.45.0
>

