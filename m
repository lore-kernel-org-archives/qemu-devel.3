Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A91DCED617
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKxW-0002uc-Sa; Tue, 18 Nov 2025 07:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vLKxU-0002uQ-N9
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:37:20 -0500
Received: from mail-westus2azon11012053.outbound.protection.outlook.com
 ([52.101.48.53] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vLKxS-0007gL-Fr
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:37:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOqM/S8ksxNUvtHKILA3m/oE1S45r3AJyo+0ht2KIJAEosdF4ACrIazYcs+SXLryxhhkjlqJCxfUr8rOcpgfnPLK6MqOC5rqITaalSHVl1CNdXntusUrJ1eAdcsrqCv3uUP1eJHmYoQlWTSLUu7JXN19BSRSrnqcsO2kffd1+wh2lEkxVZSr8XZBaOVkAgmAI4M/0fqPg4n8bn2gQYj13rWGCS0/n151br0ko5r6iG7qZDpG4isSddjfLC1xzgu3MI49GQUbmACZVbxokNoUUVkSHY3mAgdYV2kEmEzJsAIC13XUWIFYhqA+Awqs3oV8BJNgdC0iUFMN+BQbPK3UXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nzBm59hXInc98D9dRi2IzZbznHW239oFAezg+BcWQg=;
 b=IZ30E3hDm8WQhF4zbp+kA63dnfuBu/4zLqeOEQvszZLnrEyMsFIVXyj0bQ/2Rk8nVJwATTE+WI3GYA8vUmT1TMmmsafmpoVlWiVvjljqD4jPnTDhlAh+bTAPRH++JFKudCHYq0oiOreMXKoCQ3HGvC0WQXJT4n1l8Im3S1Q2BN3wP03lpO9c5laPtiMH5WdPEpsSU3hpDJl7YPBXcnj1LwmGIVKQq8ZyDRXKuFTGAt8HfKFChco0j2DBuMbSywABUzm5OFkIYzA81abLz/CF4rM2J0f/mPksXFHv3iMek5EGBVrvCAOj0G6s983X2pZiOCGmesidgP48xv2d1EmByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzBm59hXInc98D9dRi2IzZbznHW239oFAezg+BcWQg=;
 b=svvT/yO25gzGlnkJ72TMrXevFSETAGB2Isu33OcUZNGa3v5AmmSHRAeQ53Q/e8g1TMfSCwCBP2QQqhRp8YUuNMHn5iIoZ/oEcCYUtE+ex8XA2gUwVRwBY/rWQRl50B3ofv0t0mv4ql7/naji7+M0aBqUMadyAv6WAELIyCcTC+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 12:32:11 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 12:32:11 +0000
Message-ID: <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
Date: Tue, 18 Nov 2025 20:32:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ce52ab-58bc-4e3f-070e-08de269e7ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFVpWnlmZUF4cEpxcklXR2JjNUdsUFU4ZC9lUG5VMkxLc0Rta28raTlWb3Nr?=
 =?utf-8?B?dTlrbHltSTdWK2ROK254VnB4WTEvb083aGdTZVppNVlxQzVBRi9QQS9ZSnpx?=
 =?utf-8?B?MXdpbjdsWkpCTCt6S3RnRTNzcVJ0dkRya1QvRnprQllXR09WaTJacitocWI4?=
 =?utf-8?B?WUovQ2xmemZ5UUMvd2g0RU1UU1U2VklRNEFtWm5wakNnRThJQjY1a3lwR3Az?=
 =?utf-8?B?VVltL2pjZi84bk16b0dDZHJnRE9yd3VySlF4NHl5alJDV0RkK3llS3JxWTFi?=
 =?utf-8?B?RU5IaEE1OHg2TnAzbmloT3hzdUEzQUFRZVB6UC9wQkd6b3ZYQk5nbkdOcnBu?=
 =?utf-8?B?eXlwUjVObnN5bnVVZTRRMndkK0h0V0xpQ0t4UUJHZS9RMThYS2VYeHFIaW94?=
 =?utf-8?B?cDlBNGpqYnp4MTBpeG1EYzBBWGVSclJ1S3lYWXhrOVNBNlIvdlNPVWJNcEFP?=
 =?utf-8?B?MzdQRDBwcnhZTDNuYU5HaHFyRlhrcW9lWFdIOTVraytIOVhjWG9aWHlmcmgz?=
 =?utf-8?B?ZU9mZE5EczZWRGwzY01XMUJVdnJRRTlabUNGdXZ6YVJneVdpemt6d0dwRkQ4?=
 =?utf-8?B?S2FKaDlVWjliOWdaY0hFUkNBbUc5WjJtOU10L0V0VmNiU3NtTmVPZEdKMDIz?=
 =?utf-8?B?N25SaE41eHpvQ3J1OTd6Vmp3cmdEdUg3YUlFZEJKOWxGQlJlS3pzdkNaRWpt?=
 =?utf-8?B?ck5HRGFPUXQ3M0d4c2pxMk1WaXgzbnM3MGs0dWsxMm1WY0dlUm1JV1R6d2lB?=
 =?utf-8?B?Y056RjA4WDdmNmZrYUd6NWFDeFlzR0IzUFZFRW0zQmlWdFE5cDFabTl2Mnh2?=
 =?utf-8?B?UlJkWnhEaGlHVmo4U3Fwb2Evc3YzVHJFSTNQdWFGTk1mTFRJWHMvZ3h0bkxr?=
 =?utf-8?B?MmNLV0l2ZmpxMVY3dHd1VzV6ZEU5S3I1Z0RCb3dYSEFVcmc1VG1IRG5sQnhC?=
 =?utf-8?B?cWo3OTRLaThEM0I1TmkvWXRpZUZWd2ZadzIrUVpTM28zb2hhYVBpU0c0c2RH?=
 =?utf-8?B?eU5qVlNuZW9BNTVKbzl1Wi80TlorckNmL0xtWmNmSzhpRys5WkZ4UlE0NzRu?=
 =?utf-8?B?OXlaYkNkWDhYbUR0dHBnbU1XcUkrczJJZ2tlckRqUnJrUUEzS29JY2tXRXBW?=
 =?utf-8?B?K2ZULzB2U1NGY1JkSFZnbFNsakhZM1lEWis1RlZvT01VcmJXMEFUdy9JcUhq?=
 =?utf-8?B?TjVNbFFLaExyeHYzOGdNK0ZrVGc5aGxCUERiVVJLeTljQ3RyUWhuUjFjRm5H?=
 =?utf-8?B?S1d5RzRIdlM0QXBsZy85dHd6Y1VuTVE3eW41T3diOEVqZW9OWjJ5NWgwNGMw?=
 =?utf-8?B?dkVUelVVcDV3RGR6VWRTSDcvTXdIV1lSb2Q0RmJQdVdEak91R1RxSlR6Zkd1?=
 =?utf-8?B?d1JzOE5idFUwZzFyOE90SStESTJrelNjN0Y0Q0FnSkc0enNDdE10MmhDN01R?=
 =?utf-8?B?MVMrd3puMnpzUGtldGNCK1VGeG80VmJIcWlyVzVJQzY5MmlJTjhFdmVERkRj?=
 =?utf-8?B?TUs0YWgwYTgwODNZTVJhbFNkTTh6MDZ2Wm5TNVFtcm43MVFOM0FobnRLRTE5?=
 =?utf-8?B?aTlIcFIvdDZRdUsyTm00cGNjdUd6VlQ1dHFaNXdYb1dWNjl1MnZWaWZhMUVr?=
 =?utf-8?B?bVFucG15WENqMWFSQko0V0dxdEtOcU5tbVcwNGJ2RGlZS1NWRjhhT1hiZ29T?=
 =?utf-8?B?L2hlMjNpQnh6cmdFZG5YRll1QlFmQ3lCZ09sZjYrb1BsVWJDWkttTmpMYVB1?=
 =?utf-8?B?bVFXRDBtTUV4ckhsUWUzOWZQYWFXaGh0OVdBaDdHb1FyQ1ZTOW81NzNYY3FO?=
 =?utf-8?B?QXNKWVdnQzhCMzNvUWlSbXYxQ1lONG1kYitaQ0NQZ3JFNDg4Q1RmZUg5RDla?=
 =?utf-8?B?dnNpbWQxNXdibytqU1R1R1RBbzNDWi83akxUaUhwUVc0RldwckZIZGlLUUZz?=
 =?utf-8?B?a2dGbHowd2ZRcUJBakNvRko1TE9yWVhzZWM5OUNaSmpZL1hJTml1bG95Mnpq?=
 =?utf-8?B?ZlJBeGxmT1VRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skd3QkJVY3h0eG9oU01iUURSeDl5NjFFc3lUeTZoNXRMVjZYbFNyVXdpRjJq?=
 =?utf-8?B?eXVrOUQ4eXVZUzl4c1RiV21Db3ZGNHpMZFNlUkZGWkxmVHY4M2h4UEZKOEFu?=
 =?utf-8?B?Zyt3M2lZbXpvUXVPdEN4bmVaNmEwQWdkNitCaTA1blZBMW41YnRVU2M1WS81?=
 =?utf-8?B?ME8yL0xYdXFYTmw4MnYyMjJ6M0FBVVdPMjNMaGpaNEhtMXdGWG5DNzNyQmhB?=
 =?utf-8?B?a1Q2ajhQUmR0ejZmN2VKeWN5VnRsSExSSFB2ZFdZZHZGVHZuOHRkVWZ4RnJN?=
 =?utf-8?B?L0FOa2gzSlZxdm1nMm1DVU4xQUEwVnB2bmtZdHM1cnFjTlNjNXpVOU51NitM?=
 =?utf-8?B?aU12SGRJREY0dERlL3AzV2FuYWRPMGZ3RUFVV2ovbW43QVZpWmdkMXcxZkZv?=
 =?utf-8?B?eTFEd0dIZ1hwZ1VkT1RqRFR3Q2VvTmIrNHM2eEhwNGUycmNtQ05qL1Nnemtv?=
 =?utf-8?B?M3h0eXNjSmxCck1jSU5oOVEvVjJ4dStHYVpZTU45UVhXOGpHV0E4UkpjQ3RV?=
 =?utf-8?B?cVAzOVdpYVpUVkVUR201WEtNNmZ3TWMvK1RnemlRNzJFNjZ2MEpUTVhlUWJS?=
 =?utf-8?B?NlhMNzFwaCt6N0VML0FRWW1TSW1jZnVCWERod3FFeHhUY1N2Z2czbXBEMVBz?=
 =?utf-8?B?emsvdzJWU1R2am1zMm5FS1NIUkhiWjNyZmRKeGRxOTd3UnRKL0hmSlRubzc5?=
 =?utf-8?B?VldwdFF0MHdxZHZPMVRMUEJvbWpaNktXNnE3dXIwVXFGUnM1ZVRnc2hRNVBZ?=
 =?utf-8?B?Y0dIc3FobmV3ZGVwbWFLRldhR1NRaXNhMk1lRFFZYmhwNUV3eE9tOEFCNjA1?=
 =?utf-8?B?akQzK3NNNHZFeWpiTkNDYWRUd3FzQkxSaGcrTDIrT2F6Q1NseUlaOUFzVU11?=
 =?utf-8?B?djgxT3dDMXY4NlRjWmhnYmRqUnRvc2o4aUNZZkdzSGRyWCthbi9oOUx5YlhT?=
 =?utf-8?B?bVlrbTV1eXJReGFxR1FJeHhEVERVdHAyNmp3MVQwR2UvOXFBNEVRL2Y0N01L?=
 =?utf-8?B?YnlzK1ZBVytiRzZ2Z3RtZ0RwRVpLT3o1S29vR1ZtMllqa2s3YnMwcUl4OWsy?=
 =?utf-8?B?U2d1bGp0UE9CU0M1RE8rbnFCSkpKZjJpYnhrYWhSaUg0N1RNcWxQV0k3bCtF?=
 =?utf-8?B?bXQyVGhEaG42OU5KVEFKU1FtNndLcGJjMXN2ZXhqUW91UVJqeTc2OEJFWWFj?=
 =?utf-8?B?WlJXNWNZNjNGYlJOc2s2bWZpK044cnpLNEVhUElTNFNnVjFIbXlqTmxaNlBo?=
 =?utf-8?B?aE1yMWdOVzhaTmE3ekdTQzBWYVAzaWpJOUE3cWxiTElQTmhDb1Yxa0Rycloz?=
 =?utf-8?B?UytycE9Pb3kxeE8wc3crV0lOVlQxaklzSG81QjE2RXB1RHRvOG0xMTZGT2VY?=
 =?utf-8?B?RGMxUGhwcnBaWkx5VnkvZU9nTHZHR2wxTWVQZWptZHJmbFhmYks0U3FwRDFR?=
 =?utf-8?B?eFBIc1g5S245eEVSV3NEdHZBbUxEVlEwc0hGdVBqRy95TThvZ3dDQ2Z4S3lR?=
 =?utf-8?B?VWFCRnkyTHhvQWNZUWEyRmlBTldqODJpVWFvVmE3TWViMDVmbmxSOTZjc2Nw?=
 =?utf-8?B?VWNnU1g3cTN1cDM0ckJDbFhUQm50REsrYjRoR3B5SjM4RFdGZlk4WWxKRlln?=
 =?utf-8?B?dTBIS3BhTC9XOTRJNkFDWVBwSUVFL1haMGIydFdjbXpLamJEUk9sbmdWdVB2?=
 =?utf-8?B?eGFoME9wUHJLK2dpcTFhdUxtUTRxNkd5TVFXYUM3MEwzRzhWK1FnTFY1T1pX?=
 =?utf-8?B?VWd4OTVPcit4Uzc5VEhQbGNVTmc4SFowV3FEcjhsVWp6OWVnelIvbEgrZ0xR?=
 =?utf-8?B?QUVHWVJnTE4yVFJrc01jNlVuNUxXdGtzcy8wYjk1Wjk5QlE2Q2JzY1FnN3Ax?=
 =?utf-8?B?c1lxZDdLOW8rdGFOVnJQeHF5NUljak9DVXh1QzYvdDl3V0lzNm9ZRWg1ZWZG?=
 =?utf-8?B?SXlkWm1LVUQ4SlpoU2VEcEs0TFNodHl0QlQwczA2ZUNHM3RWcW9XYmREZTBi?=
 =?utf-8?B?UlI5czdScHoyelQrczZOYWtiek9EL2Q3WlR6Y2NEQUpjdXRxbzJZNU9jc2dZ?=
 =?utf-8?B?czU5Yzd0UDZoR1FrcWxNVlhsNjlhbTJBVEdtdms2bTRwMGd6K1BkckVlK1NG?=
 =?utf-8?Q?mbSCiKReJjXVU+E2ZltMlwc/G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ce52ab-58bc-4e3f-070e-08de269e7ed2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 12:32:11.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRvY2nZZgaVEdRlnlNyAzmxFsCC6wmZAlEP/zlYCMGWpAyFIWOEF9hjuL3bbVlQivZnXjgSSQekFzLQ6P36GAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
Received-SPF: permerror client-ip=52.101.48.53;
 envelope-from=Honglei1.Huang@amd.com;
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



On 2025/11/18 09:48, Dmitry Osipenko wrote:
> On 11/17/25 16:22, Markus Armbruster wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>
>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>>> index ed5ae52acb..ea2928b706 100644
>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>>   
>>>>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>>>                                           cmd, NULL, &res->iov, &res->iov_cnt);
>>>> -    CHECK(!ret, cmd);
>>>> +    CHECK(ret >= 0, cmd);
>>>
>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>> see how this change improves anything. You now saying that ret > 0 is
>>> okay, while it shall never happen.
>>
>> Please see
>>
>>      Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in virgl_cmd_resource_create_blob
>>      Date: Mon, 17 Nov 2025 08:49:42 +0100
>>      Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>      https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
> 
> It's a rather common bug when errno isn't negated by mistake and a
> positive error code is returned. Ignoring positive values when they
> aren't expected opens door to unnecessary problems, IMO.
> 

How about apply the v2 or v3 firstly to fix the 
virtio_gpu_create_mapping_iov() block issue in virtio-gpu?

I will create another thread for the `CHECK(!ret, cmd);` thing in rutabaga.

Regards,
Honglei


