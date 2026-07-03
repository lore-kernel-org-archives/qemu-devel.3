Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76D1C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdQs-0005BG-E5; Fri, 03 Jul 2026 08:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfdQi-00057D-CD
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:55:40 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wfdQg-0002Ck-Ng
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:55:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERAQbq46ynibP8naa7V8ppA41wKZMpSHuuYSI6xsciP2v+lDSIsJy8fVSYK8JPOOxUG8bEFqopDYyI25qUE/y608tRTUWOiBtesOWFCmpYP7ywjEd1g6iTEXc8j2VgCjrAyTlovMwsqNEm9XwDTfQsjSgK+lULRIJ0YArxdvtJwDsVamOkFIZZ2VKigo+jYNDT5tXTyXeFewu0SV121NFEugFVvF5aXYGXvLKpsjS2x//l2QOiXoUYVyyIpQAwlB7XKPsIa52mbvHna2+dm2stF2xdBx9c3B5fLrXIbtNnDjO8SfiR3JKxGQqwBUtVoVXsrp0PgVVZ/XOl4MOnwR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwnA8TaGZ0sxjlTWyc4iptn9r08f5vi/qA41y0cACks=;
 b=aHUoX815Vs8zaqMoI+vV1Td22/+F+hGKUuymE7f1g7Exfl3dp2RSXZ3FDdjhx33BNoxSfsiXp5SfwczvUvrks8vm5pAmCKK5seJO30G7ZOyZIPIHFELyNoLIUErvVqgqy4fKxVhj2jRTUJ8I6jVlDI2aVYpwl8V1OVkqQ6gB35XHAmg9GHLEHikLDvkcT7QVbFmFDFGC59TVQKNCnLaT48ZppCtAHVSIEm94WIQdMwFuZQXO/a4ORjks96p99s+/1c4FeoM4cUhBmKVwH6inTBe7d4C/tgp32gDfHeMRUqkAUnvSyEdUKk4/9uyEU0vcwo7c8R/qH6Hah/awExzWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwnA8TaGZ0sxjlTWyc4iptn9r08f5vi/qA41y0cACks=;
 b=I63DhrqkNZ5niocQJrYlmfI5cz7GtDT88qE4Qf0hkfgjtRisQxDOmYVSXhXV+Hivh6twIVt8Xodbqjs6BwYPAMVsjxHrrniqUCMOsZuLQi7Ea44Ni3xfIplKeRc5d++lza5zyn16GdCKpLM3MntsT55p9Z4rk7ypKXiJTPaoHjdB2VfrIB9WOU8tpC+tVaIugynOFuXspyA67E+hFAaQ/PpqaUzQ42u1USWkxZFomjPdUuiRjOn1mmz+gweP6Ky2BDrAiZzliCQ90pYSMnv5FtD0rJ0nFQfgMtny7pmGgRetaaieTsIkZhxyyiVORS7mXxLlarSxm+KEC1osfeSG1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 12:55:32 +0000
Received: from DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56]) by DM4PR12MB5119.namprd12.prod.outlook.com
 ([fe80::261:eff5:d149:2d56%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:55:32 +0000
Message-ID: <c20103ff-c587-477e-a16b-66e2b63c4076@nvidia.com>
Date: Fri, 3 Jul 2026 15:55:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/23] vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT
 feature
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-18-clg@redhat.com>
 <28c14e21-9382-4d4b-bde0-622d4dca9bf9@oss.qualcomm.com>
 <30a8d3d6-bfdb-49fc-b891-ab09c0a3a692@nvidia.com>
 <dca7072f-6232-49fa-b8c9-dbb8f82b85a1@oss.qualcomm.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <dca7072f-6232-49fa-b8c9-dbb8f82b85a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To DM4PR12MB5119.namprd12.prod.outlook.com
 (2603:10b6:5:392::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b28b6f5-4130-4538-af24-08ded9025e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mO1OUEYoJcJpOTOzWHeBAeDrfd8y5lQi1qXk1WwIVzr0mTqo9qtws1VwVHvrgvOTriOpv6zEyyrTi8oNQxmW2NowSU1K4S1gF08ieQ4RM73k/CUaAaLrY4xjV17TYT1N7BqHNjFqBq/2+lQ7iuBXIMbgFRlx60qfhoJC3v76UXN/7/aWwIix5APGNMANv2ALF7XBYgH42DZsi4sGOn5URDE/kb8p3llSWhujKmOonSnGs+tMRiis7JLiUL3fqPlAD/nlYhJTx45Lsy2jURHdsfw+O436ARVZE8yT7iVrlJ3P+/wgdDmqthhJH7F+4qOWZ/e9SWC5f+Gxz3cu30Wi3E0+X++dY0WBjak+0TI2rlZq4iwzxuJxpNnAmKfP3IXNB9yYaCrV03BbdEgCviX+3RqiTYx9wyoxM5WnDjryG/J3LBan6MgSUWI2K6WJ7DpK50s05Pf1l7oEy+gg9HQPYpH9ayBjeiRU7wTtVC3tK/iBMZOp9mGqaSpk7VpGw9FRpZL47T+7rgQea1DFL7GkC6zTSDT9nUU7gLsIA4D/VqnUX5E0xnZjqLl4dUYKoeFJdmnyYBCqv4cXO3z7EhgG3h4K2ABs2llahvEqTKg3foeBCtDhsYUcKPPh3/KWxIRHk8UB9/GCNfqcnOmKkypr7gi5s+g7TbPOMCJPWKIAjd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5119.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWYrQ3UvLys0SHcyR3ppT0V3ZHdGTExSZ2ViRXZzdG1WaFl6cVQyRW43emJs?=
 =?utf-8?B?WFBrSEtWT1IrOFlzeTZTWnpVMlVsY0VwZGpUTEExdVk0am1QK2dwckpTTXVB?=
 =?utf-8?B?dWRnRGxNcUcrajJGdmFkbXpPNmg3Rk5MM2YvY3hQR2pBSXlSME1zOGY1a3VI?=
 =?utf-8?B?eGl1NlVvTGtGWFJMZFM5RC9ORmViRHp3M3YveWpDZTdFT0M1M2M3Rmc4SkIw?=
 =?utf-8?B?RFZzQVNjS0gyaEtQQ1lPeDlIY3VRNnJlQXNxMkV3Z0xlbFJXc0J5eWRwdk5L?=
 =?utf-8?B?VVBJQ0JLQjBkSWRPaExnaWNPZk1raFFnYnNIclN4Um5TM016a0xiL2k2enYz?=
 =?utf-8?B?RnJpMDFnM2JVdnlDa1NOU0ExWXhhdW50NTV0dEdvaHhOM29qdWltWXhJdUpY?=
 =?utf-8?B?bWx5VGVaaWFZMGo3azlwVXVMMk5iS2Q0bGUvQkRlQXVjZkpEMHZyMU4zdU5Z?=
 =?utf-8?B?Z1pwc3JMWXRNOGhLclk2cGxNSWIrZXlJeGVvRjhtLzhQbmZZaWsvWitjR1Zk?=
 =?utf-8?B?WE1tci9WUlM3ZFNYaWhlYkJVZ1FtLzZoS0J3R2F2Q0xIQWg1Q0ZrN1JPUHNl?=
 =?utf-8?B?QS82U0pndDcwejVnY01vZjA0L0hjSEpaZWFIWDdwbGpoL3BLS1hiNVV6R0FL?=
 =?utf-8?B?Q0NZakpGQWN5VkozajhMdzVuM0ptMUlRQmUvdDhEbTVzaURHdTRjWnRHcjN6?=
 =?utf-8?B?bHY2d1V5U3BEd0h2ak4veTBkNVpCeWQ3Wk13ZUFpSldjM1pzTVVQQ0p5SDBG?=
 =?utf-8?B?M0F3TGxBY2FqMnpkWGN0MXBCL0cvZG5oMFduL1J5YW1WSm50bzZyL0dUZURQ?=
 =?utf-8?B?a0NoUXQxNmZQenB1eWZKK1ZPZmxvR0tHbldMei9HcCticGdQdzk5ZnByK0Fw?=
 =?utf-8?B?VDM0YXZBaHREVjhDdzkzcGJscnFqcXIvZ2RRWGk0THk3empDRk0rUGlabWRy?=
 =?utf-8?B?Z3FPcEl6N2t1RDhoa2JtMGJDY1VOS2ltZGxQNEtxeW1RNllVNktVdGxRcXZx?=
 =?utf-8?B?MDFKVy80S1lmZXJuWUVuc09PbEhPemZ0eGhKNi9JcHAyUmx1RjJoOUpGbEpa?=
 =?utf-8?B?NExoQ1REaVhuRzBGYnBIdldkdzhhVkNkb0ZQU1lsTndiVHhYSmNUM004cTFq?=
 =?utf-8?B?OFB0NW5xQys1QWFzbUlIc05KUHlMcHBVYmJyLzZLQmpFNkErUzVjUkx4dVJD?=
 =?utf-8?B?ZGtmNXhUVFVMQXRObTRqRlRaRzZuMjkxZFZPZGNXaVlvaUkvUFM5L05NVmRJ?=
 =?utf-8?B?NHBEcTlCdmkyUjZTNEFnTUM0WDBhRGhsazUyRVF3dElzNWZIR0pxTiszQmdH?=
 =?utf-8?B?V3lLYkxpQTBZWFFmTkZiZFprWjVtdzBUNStERzBKU2dGK0JWWkx1cmpiTHlY?=
 =?utf-8?B?OXJ1Q2g0bUF2YWFLcURzTVZVNllUNFJ3SlFwVW5BaDlRQ0FzdUVZZ1UxU3J6?=
 =?utf-8?B?MkJBNm9EYjBGRlFqQVFUK2ZDaDBCb0RWOXZWaDlyMTkwWFVPY01tR05HQktR?=
 =?utf-8?B?emtIZHFvc2F3bWo0elpTeEhEdVlpZitaZUorYmhDSitaSEkzbThOR2c3amF2?=
 =?utf-8?B?V1pWUFI2bzlBR3czRXhOaVQ1UkttSTk0K0tudXNiZGJjbVh4b2hOalBmRzN3?=
 =?utf-8?B?ZFEzYUVQZ2wwZzFlLzVxMkZrN2pEekp4a1NNdE5neXIvKzN5SFJMczA2b1p3?=
 =?utf-8?B?S1VzQ3FUb2szUWd3Zk9vaGZieENQNjlBWVloRlBIeVRGa0NJTVp3dWNDcTl2?=
 =?utf-8?B?ZS8yMG5UMWlDeGxYUVhmK05vR0Y4cGEwRVo4NzBwakdaM0xzSFczTUFFYTNF?=
 =?utf-8?B?ekpFdi9hdGxReXIwUm56aGkwZ1NYa01ha1JJMDlWdmlxWjA4QkREM3BhUVZS?=
 =?utf-8?B?amZ3dUdBdXlFYWFoVjhtaTh6TmhHZ2lCZ2ZCVUhXam9TNXFlY1ZaM0lUczkz?=
 =?utf-8?B?UEppU1VZWityLzBCSVhqSmRyMkFTQ0RlRTNVMVlxSVNFcW44WFdKNmM1YjBS?=
 =?utf-8?B?QmNHbFNoTUx4RzRhejltL2N3THRReHl4K3JTSkZVV2t4bHZDTEFSK0xtQkNI?=
 =?utf-8?B?eU52TmRGb0FrQXNEVFgzQ3NIQWZ6YzlyTE9YamZ0bE1POE1SUUhqaUxrcUo0?=
 =?utf-8?B?TzBWbnphZnhYSTg4RFhnU2JWMWdqd2tSTnVQanRGdXo5K2NINjZ2SVprVnpm?=
 =?utf-8?B?aG9WZTZ1Ylg3MFhzU1B6NUdXUyswNDgra3lOaUJnOUQrWnNRb04rT29YTm1j?=
 =?utf-8?B?L3Q2N0pqdVVBUmRDM3JxUkx5czN2bXAveFhIVkoyRUlzK0kxTnFqeWhGL1ZO?=
 =?utf-8?B?NFpudTM0VnE2RGdGS2lmZWYrK2dXdFpFUUp6ZEQrTHlnQm14TzRHZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b28b6f5-4130-4538-af24-08ded9025e0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5119.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:55:32.6707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK+7Lx22Dv1tTrHBEHLbLGDl2yIEYjhLIbIHWiXS5EgTz68g3H5Dkikr2X38uXIIUrpWj25Bx8nwMpzAY2YWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 7/3/2026 12:16 PM, Philippe Mathieu-Daudé wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/7/26 10:13, Avihai Horon wrote:
>>
>> On 7/3/2026 5:07 AM, Philippe Mathieu-Daudé wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 30/6/26 06:31, CÃ©dric Le Goater wrote:
>>>> From: Avihai Horon <avihaih@nvidia.com>
>>>>
>>>> According to VFIO uAPI, precopy initial_bytes is considered as 
>>>> critical
>>>> data that should be transferred and loaded prior to moving to 
>>>> STOP_COPY
>>>> state to ensure precopy phase would be effective.
>>>>
>>>> As currently defined, initial_bytes can only decrease as it's being 
>>>> read
>>>> from the data fd. However, there are cases where a new chunk of
>>>> initial_bytes should be transferred during precopy.
>>>>
>>>> The new VFIO_PRECOPY_INFO_REINIT feature addresses this and allows
>>>> reporting a new value for initial_bytes regardless of any previously
>>>> reported values.
>>>>
>>>> Implement VFIO_PRECOPY_INFO_REINIT feature:
>>>> 1. Opt-in for VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2 to make
>>>>     VFIO_PRECOPY_INFO_REINIT available.
>>>> 2. Request a new switchover ACK if initial_bytes increases post of a
>>>>     previous switchover ACK. This ensures the device is not moved to
>>>>     STOP_COPY before initial_bytes has reached zero again.
>>>>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> Link: 
>>>> https://lore.kernel.org/qemu-devel/20260622101214.25770-13-
>>>> avihaih@nvidia.com
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   docs/devel/migration/vfio.rst     | 14 +++++++
>>>>   hw/vfio/vfio-migration-internal.h |  1 +
>>>>   hw/vfio/migration.c               | 68 
>>>> ++++++++++++++++++++++++++++---
>>>>   hw/vfio/trace-events              |  4 +-
>>>>   4 files changed, 80 insertions(+), 7 deletions(-)
>>>
>>>
>>>> +/* Returns 1 on success, 0 if not supported and negative errno on
>>>> failure */
>>>> +static int vfio_migration_set_precopy_info_v2(VFIODevice *vbasedev)
>>>> +{
>>>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>>> +                              sizeof(uint64_t))] = {};
>>>
>>> What is the point of using uint64_t[] here?
>>
>> Since there is no data payload in this case, it's mainly for consistency
>> with other VFIO_DEVICE_FEATURE ioctl call sites.
>
> Ah, I didn't noticed. Does the VFIO_DEVICE_FEATURE ioctl expect
> the buffer to be 64-bit aligned?

Nope.
AFAIU, the 64-bit alignment is for userspace, for the data payload to be 
aligned, in case it holds some 64-bit members.

>
>>
>> Thanks.
>>
>>>
>>>> +    struct vfio_device_feature *feature = (struct
>>>> vfio_device_feature *)buf;
>>>> +
>>>> +    feature->argsz = sizeof(buf);
>>>> +    feature->flags =
>>>> +        VFIO_DEVICE_FEATURE_SET |
>>>> VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2;
>>>> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>>> +        if (errno == ENOTTY) {
>>>> +            return 0;
>>>> +        }
>>>> +
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    return 1;
>>>> +}
>>>
>

