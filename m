Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBBEC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UFI-0006yH-3l; Fri, 04 Sep 2026 09:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x2UFE-0006vY-T6; Fri, 04 Sep 2026 09:46:18 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1x2UFD-0004qE-5e; Fri, 04 Sep 2026 09:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a79fN12wax3IadTz/G5/GKEw7D0c8eEs2Q7hVlCYLDPjsldOrNHWC35JLIGpnhzxvsxnVECUlpDWjZJrRfBgwEnRAHius0zEtQDP538Rt8xXe7wxKuS/mjS1fF2M5Qvbpz2SwFv+rZjyUd3AaZ47Boya1mEJ04dFBA3K6NhfyuZ5cfWz03Y93ft9CHLvXCfPh3Yv2J0VkvMcFe1jjJmPkZdPZ6uiQUoI0he2LyJeC4Rl9qgyZZoLft8PFpdLEixS+nGEc1L2TPxkPiCn2+luf4brIlqjQV/HDMwUGitTgqAG35DzTobIHTS/nGkZ5vrZcV6lCfC/2SF4nwOyDtvcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obC1kYaEj5P9+tIX2Y88w78bw7B8Z2BIT/cXpkpIseI=;
 b=iotjz5H/P5+1JWrAgdNLIq9pvCIfDwzdMm1GxrIMPrv54TDWFr5UmbghAGNosrHNahRFOeDslQFz8rwUJQnAFYb1sO0vPIoBhFvXpxmvSKgV6zhDPUP1ohy95FQ+d3W+qR51C3aTMhlMj1J7dvctIteZJJ/uvGspbt1K0WtaODcd5JA56ouSBJsXdag6VoYTcY/w6P3IFnmnRjS6WGBgGmymRe3h7YXCHRQk1vXlV0LWDN1EgpvuAOkueuiYDlYpg9J6ybAiBEmU6NOh6NIIUBDFpMEYiIsab80kqt1ZmxoKunaTL8w4kQzgzXxwXo8H6kjIbNT9upz+QFXl3hw7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obC1kYaEj5P9+tIX2Y88w78bw7B8Z2BIT/cXpkpIseI=;
 b=TjuFpmMVbKxCQKlvkO1vHgo+vPYc8E00W+H/1N9qe6pEQNl3r6yQ1/PAzg2+95IokUI7eL9P2YmP0vt1VMKnHbGz6aSb11HbDcqPX2K2WVdUbkSA5Q88OnB3ofPmUyEEVNaA8VYa4wOLpIT0MSZ1va9h1N04nPuf+K+7P1nrJZOLAvemGOKzHeXuqpNm2F4W27jikHtW1aEXSxk/0W7bBkPAE2jrzFlbCRGPOfF1Ol8G/F40bVD2j0K7KF0w+U5J4EHU0emodwmj6oGG7gjbYlzJlYmoBOsu9pmZ1WtXtC3CzOoTgHbe4nEUTOwUigQ3bk8n23s/JFo4BxehTwMSVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Fri, 4 Sep 2026 13:46:07 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:46:06 +0000
Message-ID: <c6ff4e0f-c986-4ae6-bb85-69dbe1cf2dfe@nvidia.com>
Date: Fri, 4 Sep 2026 08:46:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] hw/pci, hw/arm/virt: fixed PCI BAR placement
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, qemu-devel@nongnu.org,
 jgg@nvidia.com, skolothumtho@nvidia.com, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 devel@edk2.groups.io
References: <20260827004024.598351-1-tdave@nvidia.com>
 <ao_fX3cYersq6TRd@sirius.home.kraxel.org>
 <20260827074733.340aeb0c@shazbot.org>
 <apV1FXabgOVdAqQu@sirius.home.kraxel.org>
 <b4d51232-43a0-4058-af96-5c3ca847edd8@nvidia.com>
 <ape0Mbd7Lt4KS-wN@sirius.home.kraxel.org>
 <37f31842-e79a-4089-82ad-8003fd47fdb8@nvidia.com>
 <apk_QiR3FDiMndgI@ghoffman-na.rmtde.csb>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <apk_QiR3FDiMndgI@ghoffman-na.rmtde.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: ae93b17f-d316-40bc-5b7b-08df0a8ade90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5NzYQ0d3Rj5K7WzeV33sPmBkclbfkmtDvzTEt9XPQEGOLnqW4EhgQ+lg5+P6iI99j8DtFQ5bA5ruTY6yUiJmMJ4PVaoZ9igCgyQaTtF0NW9aClyB2E/1CnKD0v2ZdZE03kIfNuG5PBw8zxBiKMD8W2TCOhfPdJtViXD/tDFbPaufDz5jTv8TZau2i4agPnrEgcsCJIeGab8Y7RiiZ8xkkhRyGHByEnKtbr1NxCWmNW9P1LNPhMC9H4G0vZ1SSbYhm/YU4OBxQHgocQDGj4VQP1qpX2VBwdWotBPYvBIJte05lopCpDStBgmQmCAv9oTnnt1/jJPs4LbFxcIV6Q7qT0LDyCFahhRdRyotkW8uoDx44BwY07lYITpjzdIG2TekYLKrQ2t24cegPbVOT8OJNDwqcFQahLbe5rVdz45baoCWebsWqSyTaahwSCFrP0P3fok44omgcyCdTlaJI/AJk4fh/QWM+NTPX3X2PQIyrqSggbtwEiSaitY8ORXjywaU6yBm64tRYqBMMbW5P6hqPzIoctZ4afDLQ69t8m1gih01XCVW8D2cevXPH3vPsBnmPx1yGUTIpYeqb9SCn7xniSftmLc1oZevPh6km2oiA+8xbyHOKoAyBKikpuAIkcKSZXIydAySNG/ER2b7tIEfiUyxaGuYAMm2B6BNYBtAMZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1lmRUtuMm1jRXpMakNBL3dJeUhlbVBJRnBXRG8rTWd2bFp3QmJYeE16MTNa?=
 =?utf-8?B?dnFiemRnLzNlZlhTOEQvdnhsN0J2Qk4vdWlxUmdKZjFlVDV3elJpUTBEd1Bm?=
 =?utf-8?B?c0JoMHNqajBsVlVQcUxvM2xJQTM3cElHQVArUkFGNnphSEpJaVVkSFFDaEl4?=
 =?utf-8?B?YnlWcGtEZ3ZJamJkWEdYYXJUK0daRUo3ZmR4QzZLV1N5TW1lQVR6V1pQZVlF?=
 =?utf-8?B?NlJycHFLQzNvSXlWMG1KcTA2UWozQUExeEtvZW4rNGhUc2pOY2RWT1dabWJR?=
 =?utf-8?B?dXpPS1hlTjc4bGVVaTluN0NDb2J6ai9TNG5zTTgzUmFXMXArMWpjbjlQRzNX?=
 =?utf-8?B?MmtCcHdqWGlWakJCTDdGQWd3ZlZkMTZKU09GcjN4STk1TVhMdHdvbmtlTmVU?=
 =?utf-8?B?bVdTeGV6cEpiWDlhdzV5QjhKazA3Z3pibE55NWZYYUVNblZ1QkxocGk3bnY3?=
 =?utf-8?B?aUtqSUFDRG1xMjd3RUNkTUR5QVNpODdvdEJxYzZBOXgvMXJWYjMzY0FCZmRL?=
 =?utf-8?B?azlhSC9MVG9DUmxUdG1WbVRhT2J5VkJSYVJocmpIN3RQamYvc2txZDE3U244?=
 =?utf-8?B?OW9jVVYwZCswWlhURmJFTSsyS0RTQXRna3VNLzB1STBaTzhoOWc2QVNCVjhX?=
 =?utf-8?B?ZmZjSGV4OVVZSXg0d0xveGUrRUpFd2tLbzN3OVB0anhBa2l5a3FCd3BvV3NH?=
 =?utf-8?B?WUtibUwrYlAzc1JFMXhxdUY4bFBoTENHRVpKL0k0VXg0VDdmU1M3K2Z6Y2pw?=
 =?utf-8?B?dm1SWHI1TDAvQ1huNy80ckl3RzJEODZDN2owelI2ZERPK2tWZFltNFAyUkd2?=
 =?utf-8?B?dVF1cVN1VkxpbUxzc3I3NE14Y3Q3OEJ2cFlzV1lwS2tKWjRmcW1qNThRbUxF?=
 =?utf-8?B?UUJWV0VrNUJFRFFQakJzZjZybFJXd3dWNk1UTC9Ma2ptbDRVZDBDc3BQZGd5?=
 =?utf-8?B?VzZJbEwzTDZTU0g5RnM4cGNlSmpqaEYwSEJSeWhpSllSaXJ4b2Z4OGYyUFVy?=
 =?utf-8?B?RlBaNkViZ0RDQmZYSDZpd1lOTDM2Y0pnY2VWWWV1T2xBQXlTeUdTdEgvRUFj?=
 =?utf-8?B?YlJURmgyVEhVREUyL2FZekxnbzE5VG1kc01UV2tzV1dtSmJOT2xmRkdLeFRh?=
 =?utf-8?B?NEQ0ck9SSjRTVWdHaDltVVhySmtOTXpKYnpDVWhEem1QeEIvVHJhL20zY2Vp?=
 =?utf-8?B?VytTUEE3VnNCUGQvelJRNHA2bk5tanI4R1hwUUFJT3ZoK1dXcVFTTzZ1NVBr?=
 =?utf-8?B?RG94QUhvZTZnRzBJNUhlQmJlNTgxaXBSczIxc0lIdXYwVE9UMGJ0WnlXRkc0?=
 =?utf-8?B?OFg4QWt4L3pDdDY4TUFlVUtGTFh3akhsT1VkaWZ3MVVhdEdIbUY3MnVTc3Fl?=
 =?utf-8?B?Rnd2bGNCR213VEFBK0o4cmJpVHZZYWhXc0FtRDZ0UU9XUFpIZ25wR1ltOGln?=
 =?utf-8?B?NzhuemtSQU4zaWtoUzNyUmc4a3pmRG9qNUd3M3ZpSWJLenFNbEkzeVdFSmlr?=
 =?utf-8?B?K0Y4V3FzWWFyK0x0SWV3L0dOaVdEbXBVSkNEMVlnOTlyN0NNQnJ2NEtybjVV?=
 =?utf-8?B?QVpNcjVZVmFERUFNdlIvVHp3ajduM1FMQ1Y0WFhQT1hvc3NkazMxanFmQzRS?=
 =?utf-8?B?RXhkNGZtWFE2MFN6bVVGSkpiUjJvNEFRZWZhcG5TWUIrR2U3VHdtVmVOd1gy?=
 =?utf-8?B?ZWNnM253Ky9WWXM3bm9YRFZWWENrSnMwVVpXa1ErdXM2anBWN0Q1cU9zRTQv?=
 =?utf-8?B?eWNvWWpsWG5IcmZseTNwVURXOXY4ZXhrVDdNRWlUOWVkYXhHNVMvNXRaYjdo?=
 =?utf-8?B?b2IwVlVsU2M2WUpSRHAyNyt6cm9LTGdSeVdFR29FeXN3dGdGTm8ySFYxTnJa?=
 =?utf-8?B?V1dhdmdSSENMRmpyY29iY2FZR2wrTk9GWlhuZnhONzBrQWJzOFgyV2x3bTRX?=
 =?utf-8?B?UGh1bW40VEgzZEVnUmt3TlJqYUpPUGxQMFIrcTQzMG9JV0U2Q24yMGVpeG5h?=
 =?utf-8?B?YnBWeXpZc3IwWU5jV0FNaDVzbWl2UWlsS2hKbEwwQWo5MUZZV2hmK3NzTkpw?=
 =?utf-8?B?Vm5GZkw2RkpKNVF3anpackROc2JaMkMxUi9xbDdzdGgwUzZwS2U0bndkVFN5?=
 =?utf-8?B?bjM0Q0lGZFU2Qnd6ZWlCWUR1NFBiNnBUQndzb1l4S3oyanZsUFcvb2FUNjJF?=
 =?utf-8?B?dUgrbm9qMHZmcDJZMDRZcm1wTUIvM3F0SGMvZGo1Mzl1c2dENXZrT1daQllP?=
 =?utf-8?B?VVNYVnVBL3U2MjZaV0xaYnZUMitrbmlSVEZCMUpUbVNWRlRDZEVvbU8rYUpM?=
 =?utf-8?Q?eqtErEVHhrGFvou3Jf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae93b17f-d316-40bc-5b7b-08df0a8ade90
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:46:06.7804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXSq5uoCq3oa06Ryk0bxfixQRvgNAsLLSwMLFAjeziiZpOj7PKsE8+vX1jvSBOC3K2k4Q+1kr5ofXW2qPGzICw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 9/3/2026 4:47 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> Also note that OVMF already has an incompatible pci device driver and
>>> there can be only one instance, so the code must be merged into the
>>> existing driver instead of adding a second.
>>
>> I checked OvmfPkg/IncompatiblePciDeviceSupportDxe -- its CheckDevice()
>> is unconditional, it returns the same 64-bit-MMIO-preference descriptor
>> for every device regardless of VendorId/DeviceId. Merging Fixed BAR
>> design in would make it a simple dispatch: if the device has an entry in
>> the fw_cfg blob we export, return our descriptor; otherwise fall through
>> to the existing behavior unchanged. Does that match what you had in
>> mind, or is there a different integration point you'd prefer?
> 
> For the most part yes.
> 
> I'd suggest to keep the fixed-bars code in a separate source file,
> then just add a small dispatch hook to the existing CheckDevice
> function.  In case there is a fixed-bars entry use that instead of the
> hardcoded template.
> 
> The option rom tweak for confidential VMs should be applied to the
> fixed-bars entries too, so don't return early.

Okay, thanks. I will incorporate all the changes and send the non-RFC
patch series.

Thanks.
-Tushar
> 
> take care,
>   Gerd


