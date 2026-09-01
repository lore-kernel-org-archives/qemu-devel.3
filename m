Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E89CC624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Nx9-0005Nd-Tp; Tue, 01 Sep 2026 08:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1Nx7-0005Mw-Us; Tue, 01 Sep 2026 08:51:02 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1Nx6-0002Gs-0Q; Tue, 01 Sep 2026 08:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyeoRe6pb1valOS8fWmwN7lmmb7RmA5dphlh+yZn2tSVNR4/r2AXW5zHba0QvEVQvZU5D7u00G4CmLNV+LtP/BxeOTDhu16on9sLCLWUe8PEDnzXusOM09+3oqOAumdTTfUw4k+TWA2ri6Y7E8OKJ+JfNstoVF+9jdnRF22Yos2zAfV3Bzq2wFkuZYZlL7vq/y7nyTmUneRocwdXcDhan5VOm2ExpjhzfzvHcCVskjBU55cNUM3amcPpc6B6FmJDKVc58Bs1icmlyNPqsi7Kge+samFUiUa5QEwWVlhHMxFwCb1KKba+W3r77VX54eJxhaDoG1Z9HiB7PKnYIaxAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SegLIUexXWHJ1YUZAFD9exv1dlJ1bjm3OSeapj8bFpo=;
 b=BeIe86Hg4CeaQANj5FXyfoic4Zp3m7YxiHi1S0dJVs6IZ0lGI6iC8hoe3omjuOsJOgb6I56Q0i0kzIcVrpiY5WQoiJ2xutKeREUeAHfYuKj5AqSTSKffZmQ+oli73PyaVtGr5eTZt2tzRHe6CeAKcyyrV8AnzgmKc0IeAEcE6vpSYKsvnDm8V0D3PQvVQFKaBbYhwjZD2Zpfc/Q+RZcsySo7cbYBv1nhKeCRUjeihwCGkS5au4QB2uBF42d3SQqZKqf7KOxFAxvAPhruHGcR9FSicfVlrL3t7ywOUetbM0fqpi0UYeH179m8ZNcfYC9FQBdMqmpI91CT6SrbmqiSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SegLIUexXWHJ1YUZAFD9exv1dlJ1bjm3OSeapj8bFpo=;
 b=LEqX1oLqWQy6q3O3BZ+lyO6xlvisJkFBFGgXy3GdJCSeouU0tT9zUXTFT9WKLZrC9A1opXUeQRJHRnJNqH1dE/PFHenCCVjNEdxrEG4eec3vK+FqNwX6/+uUJUlbZnJh2mcNfEGhccf1qg5U0t1keU6KHSsJMMqBuB0XK1JycGfZxk0ffRAk0hd+k90BQk4fxa2tzcFdFrwxmsFJ7tLCWjFqbx4TdefUwXh5dbcQAVViq29z6NzNyDW873HnCYVsIGKO7k0QpA6cEvJD0gjNfhevBGUpjInr0eBQfa+aMH5IzrXlw9JKax3vlazVXGgt4pii5E51GVuEfQOkI/Mp1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS4PR08MB7950.eurprd08.prod.outlook.com (2603:10a6:20b:576::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 12:50:43 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 12:50:43 +0000
Message-ID: <95e5ffd8-d193-41ff-9d65-433ed2ce6949@virtuozzo.com>
Date: Tue, 1 Sep 2026 14:50:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
To: Fiona Ebner <f.ebner@proxmox.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org
References: <20260828222005.2888213-1-den@openvz.org>
 <05df98ca-e5d7-4cb2-99d2-74a1a276f58a@proxmox.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <05df98ca-e5d7-4cb2-99d2-74a1a276f58a@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0239.eurprd07.prod.outlook.com
 (2603:10a6:802:58::42) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS4PR08MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 714dc3b0-c375-43eb-7b07-08df0827a299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|376014|1800799024|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qxvjM9SNp+XhAzQWj0jcXUqBSMk7MpdcAAR0kgl0lbDPsvs1RGwId6qcvnHErx4o4NVWLLhVDdFFO6/RuSQofjNjioAcseON6H1d3Zkrrm0OqUOUw77XvAcVzvHc9Rf8xK7usnX0LpDr/7vb74PiBuGtsZPYAPBRM36B2AZFGAJArs66RBEFBh5iVR6zNyXV+hRVunAb68p+lU8vbFisOcRPTVbRqgBmGkIWNSPy2jskN/TLmUyvEydq+pbfDvSn4OaCi7yrB4HVIfj0zh8INhPNV/v+EaU6A4AsyJWe7Pb+TA8E+/q63Hp6YKUdOOXQnN/UF3VgaqW2FOw2rnxNLuDUzWQSEIhtWBsmgjYtKPWhrsyngu8f3/0yzJBZX8U8AxEi2+dEWgcjvGl5HqpU4XDFaASNmjE4q9JYm04KNNiNyI3hb5WyYdi8YXnRiw9pjOfUPTR0k+wpz/lchoVbmQxuduGbbjLJcHPwTPFr0X+/q72v53Ojgviv5ZQvQUdv/NHG+5WTQwjuUE0Mpx3nJCoYHYzAaqr5ysjkyyLMC1SIhuYpaVRc95AsXwrvXt1/8w26wLUsBon0UAWmPnPFiINeip+uOTR2SgDKXvHrc0wV3jEqMeiYe+6frkBcb3b2kWM54y69TQkSoXT1MBfhBedVMKkEF4J4r06eKJO5HpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXp1RUo2dmxnSEJoZUp6TDZZWDVkZ3EzZy9jcDdzdTU3ZUdaNmNIcXhZekRQ?=
 =?utf-8?B?K1dsZnBqaUQ3d1JRYXpGVHJvbDBpYkNOYXk0aHNUdkhIVVFxWWc1aVgvOTkr?=
 =?utf-8?B?cVJsaTJqUHM2QUgzZFJ4bjlvcFdTU3Z2b0hVWExITTVpcDdPNHh6Wkx2aTkw?=
 =?utf-8?B?RnQ3ckF5emtJQXJqbjcwSkRtL0hRQk9wTVhZYktRdU5KNUZsek4yQzdIaDVM?=
 =?utf-8?B?WTRsTzFBS2cyWU5PTUFSNzVDVnI4QldCWGVOZk44TGdvOEt6SU9zTGVOdjhH?=
 =?utf-8?B?cWpCT2hHZnBXL1NTcHE5UUxISURjaEVXRXNNNWN4Ym9XaGFoblVXUTNEVDBI?=
 =?utf-8?B?S1FwYWRWa0M3V1BHd1BTaml6Z0tKUzEwVjJnSHpxWjJvK0ErOHcwbjNWcWNW?=
 =?utf-8?B?c3FaMU5zVEovUXpBUG5ScWpZZSs2NFdpcHRpdnVXRDRaZmFNZWlMaUlQQUdx?=
 =?utf-8?B?MUlXc0p1Wm5WUGlkZFhhejdoek1UZ2VqR3FQK3hCdlFINWJ1c1hFcjhPcmQr?=
 =?utf-8?B?OFNZL2M2Nmk3dHhMYWdjWTNaamM5dXYwc0hQaXRvM252Tm5XZE1PYmF5ZlN4?=
 =?utf-8?B?T1BiODF1RW1zVElhUk8xd2FiL2ZSdmZ3UzZpNlUzeHJPaGlrQzhlcUlNT1Ji?=
 =?utf-8?B?ZkoxOGpSdU9XYndqZ2hBdzU5cjIzSUxMOTV2RmZFQUNVOXlDUDVIZHdUVnJt?=
 =?utf-8?B?Rmw2U1BkSWRycE5ia25RNlVtekdhZXhyVUdKUlpaMmF6RkR2WERuVXFDc1B4?=
 =?utf-8?B?enpuK1hoRFZvRzVJWlduVWs4bDdZT3hUSnlIeVlUWjViSkMvOTA2RVAzS01i?=
 =?utf-8?B?ZXFpdmJhNW0wQTdjblR4L2RZZVhITTBsZzI2MlhOZEgwcUY5cW96NGdqQVA2?=
 =?utf-8?B?QmRVTDhyR0ZLUXVseVl0cHJocFpDNzlYV2lGSEoxNUg2L2tiazUzYXBoK05l?=
 =?utf-8?B?bVp3U0grKzBiaHlUcUtJZTlzdUFzSHFNTjY3OWhBRHhDMldqWms5QVdNU1g3?=
 =?utf-8?B?dVVPZ0ZvQjM2Y3dlSlgyNWNHa2NydnFwQWRHSnZQUS9hMjdnMHY3am9ZOU1P?=
 =?utf-8?B?cG5RTWhzQkJQSzJMQXZwN3R4Q2o5M2kxT0VJVXgvV0dRYjBGaWpRczFGakVO?=
 =?utf-8?B?YWR4N2NXL0UrS2ZCd1JHcjRkTjlyTUNmSmE1NzVFSi8ybTE1OWdKYXl3UThW?=
 =?utf-8?B?dHVtOThUbnY4YmhVTk5DME5PcjhqbTliU0dYZEwxRHV5bVBrQk9lbDRmZDkx?=
 =?utf-8?B?amF0LzJYNGVLUDJONDVUeXJ4bGF5UUwwMXBxUE9aMEVjRGtOSTQwdnFHdUwr?=
 =?utf-8?B?aDcwR3g4YlBNRkZqUFRCME5DNWFMa0RCMDhHYWN3c2p5NlUvT2FxeHVHR2hR?=
 =?utf-8?B?aWltMGtKQUJ4RnlFZGpHdmRWSVVoSEJPd0o3SDhkSFJqamh4UTVIYy9LcWZR?=
 =?utf-8?B?QkYrZDd1a0w4VFZmUklvVzRWeTRJMmY1SkVNeHpUYTdrZjFSbytHb2xGY2di?=
 =?utf-8?B?Wk4za2hrT3RvbjI1Zkp1TlpaQXRKUUFVeTNCZ0dOaFFFODg0UWNjVlh2ak9k?=
 =?utf-8?B?RFdSdUtqZGV2UDBoSndBdWhvdmU4UUc4WndheUVSTXBPNWdHakk5T1dXUnM0?=
 =?utf-8?B?eWcvUXZWemRHc3BhZWF1K0V1MENYZFVFdlFXanBobjN3TGxqRklOZVhDOGI3?=
 =?utf-8?B?cysvNXpsK2FEaVMvZ0o4Uld5WXZjb2JuaThLTWczS3FNaldtNUg4a2JPdS9u?=
 =?utf-8?B?S1ppNDhjYmlaRTF6M1VGeGVITGxSY25ZTEFZeFQyZmJaRU1MWjJvSDY1dGhR?=
 =?utf-8?B?VFE5a1Mxd2hpbE5OOWJSNms4VW4rRDFQd1cyUG5iWHUyKytHVXVpb1lhQ2ll?=
 =?utf-8?B?WWZnRkVreDlTSk54ZXRsdER2ZzFtcHFrWlZTSlVoSjdrb3o0U29WOXJMUmkw?=
 =?utf-8?B?UytoT0NEbVBIVXJZWklpTkVKZXFSQTBud3NHS0VPc2JtZHQycXZIQTFPSExI?=
 =?utf-8?B?d0t6bmVad1Jvak9USTZOcGk0cTFURTd4SzZiS3ZUTmNWb0xlRDlpb3U2bVgy?=
 =?utf-8?B?WHNHUzVGa2dBa3ZUQXM1R3VpSTAxU0l2Wm1nK2VORG16RXlpMlUxZmdhVDZ3?=
 =?utf-8?B?WmpGL3k3SHJJcDZyWUdmTE42ZkRSMW5MQUZtbFQwR3E0ZW5uNmJoOHpVRWFs?=
 =?utf-8?B?UCszNXdwd29NeTc2NHZQWWNDc3NnOU1pNWtVWnRlV3BienVPY29mcktCSVRy?=
 =?utf-8?B?UWFjZ2lDN05ldnVqU0JueUZYMXdYVmlUMDltMDZvMlhrWTNPc1FpclRBSFBW?=
 =?utf-8?B?T0wxR0o2ejR3V3FXaERSL015SWdROVkzQ042K2ZPalZJaXdsYkI4WXN1S1Nw?=
 =?utf-8?Q?j1Jh4jepRCRnRAJ+yJ99DrolDJwu50dgAfGygo2glQHJN?=
X-MS-Exchange-AntiSpam-MessageData-1: 6xdedqwZ6tP4tg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714dc3b0-c375-43eb-7b07-08df0827a299
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:50:43.5583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsAUN9o3GapbOTpuMPCgt//4P7CRbMaPb08bwNbuhMEH/7SFfsQ88M22YdbyPSxqMlCmAS291DVauk0KleTcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7950
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/26 14:23, Fiona Ebner wrote:
> Hi Denis,
>
> Am 29.08.26 um 12:20 AM schrieb Denis V. Lunev:
>> From: Denis V. Lunev <den@openvz.org>
>>
>> it->bs is the cursor into monitor_bdrv_states for the second phase of
>> bdrv_next(), so it has to be NULL when that phase starts. Commit
>> f6d38c9f6d made the first phase store the node it returns there, to
>> unreference the right one when the graph changes underneath. The cursor
>> is now left pointing at the last BlockBackend root, so the second phase
>> resumes from there instead of from the head of the list and never
>> returns a node added before it.
>>
>> A skipped node drops out of the vm_stop and migration handover paths:
>> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
>> still reports success, so the node keeps its image lock and the
>> migration target cannot open the image. Only detached nodes are hit in
>> practice, as these callers also recurse into children.
>>
>> Reset the cursor when the second phase starts. old_bs is taken at the
>> top of the function, so f6d38c9f6d keeps working.
>>
>> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Fiona Ebner <f.ebner@proxmox.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
> thank you for the fix!
>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>
> Should also go into stable I suppose?

Unsure. We do not know real consequences, there are no reports.
I found this problem by accident only testing migration with
big trees a lot.

Den

