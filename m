Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB65CEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syY5J-0003d7-Rh; Wed, 09 Oct 2024 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1syY5H-0003cN-O7; Wed, 09 Oct 2024 10:54:39 -0400
Received: from mail-am6eur05on20709.outbound.protection.outlook.com
 ([2a01:111:f403:2612::709]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1syY5F-0006Pk-Ry; Wed, 09 Oct 2024 10:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQT+/aojThCSpl8yHaK+FgoUo2pV8P570eAfQ6hfwBL/VGwr12xrERmO+NxOIGbwfrF3rPxfQVJJ2WL3J7HtkEq1ucx2bYG+JrLoWtRovVOcRV1K/pMMplREVgyihz9QbnIGYdjDwdEdWtEdVS31R3re+8Y/7ij7nrGvXJPACpbGNYu7tZJj96AVujffIkifXU2/w1L7HN4ctRK6VPdbwDzBO6bTDhBMxZMVCWRIMfOnAINao87o9G6Dj+NtE03w2jOn6h9G1bubV/M5GEkhac5+wXNtMjMm77y01NMb0WxxGtuA643cMiapoa/QZ7zWx8v9vXAcpRBgkbwAFCCPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04hO7nVAdHzTRuNvVx8V3HFPdbDHcLAQrAQeJCdLBQg=;
 b=kgPxGiE7Fa3ckvQuKpvtGnVdKeT1nyVsFcxxi4/KiCWeefCKnd7TeVM4Z87iZHlC2C64dPx7irkDD3CT25/9KNNaX8WnjuvWLBPPxONFdxFhZJYMgtShs+W5ho6YndfkHYEHpPxX7iWFAHoIVBxYuAfps7er42lUvMU9xBIBdM4sbaSI3yRY8GdeMUxYaHVbd3/iIWehfZqBll4cWu7fMjB6Pj9kaRUWZth7TN4QX10cWyUzQxv/RTI/xuhy2lJ30wHIMIHaUjrcB0np2byfjzhExGtJrteAShhi6WAQVuvxBQ7RFtEB9xxfCq5Hu6LMDQD7H0mtKoXGW4L6z85dFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04hO7nVAdHzTRuNvVx8V3HFPdbDHcLAQrAQeJCdLBQg=;
 b=KZUIkOigJtcepAXr/Pi7c/+HEuvYKNp9Sl98Y5wuhI+CuE7WXcbueItEXpAlVEw+5L/uJCZ1Tsysb9ppP5yMmy6i7+HlRPav/SLG0faNwPAzN2+pPPM1LyjJysMso9n9GmyuCGH0tNlg59zvTMHi52vuUKB2b7xnlc1fNFcLSxeUYdIUgredY4g+Sey/wXodMDEWr0U30fVj7hW5npGsDvoL63cWiwb1KhcjkbucQXco30v+Et8dYZRmQkzpIr9xRZMbJ0Z8NZTD1aRMhQyQH4Dwk+XWPbzLHBhXMryY7aFWdMduFLJne2pkpOGqaFSt5Aapp+zhOoF3aeZVk7Gfng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PAXPR08MB6333.eurprd08.prod.outlook.com (2603:10a6:102:15b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 14:54:32 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 14:54:32 +0000
Message-ID: <fa460a32-77c7-455a-b339-b741f301ee57@virtuozzo.com>
Date: Wed, 9 Oct 2024 16:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/preallocate: fix image truncation logic
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>
References: <20241009140051.771660-1-den@openvz.org>
 <20241009140051.771660-3-den@openvz.org>
 <9167b2bf-723f-4ad0-a525-8776ad9e69c3@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <9167b2bf-723f-4ad0-a525-8776ad9e69c3@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0115.eurprd09.prod.outlook.com
 (2603:10a6:803:78::38) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PAXPR08MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 627c7ccb-4ec8-443f-129f-08dce87248d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlU4NFd2UUQzK3pTS3pxd2NaVWVoRE9GTzFLa0NKajNBemtnSlc2QXE1N2xZ?=
 =?utf-8?B?YzBCYlVYTmFFWHRNM0srQXBhbG5PTkFkV0VvMjE3WmgvV2RicG1nL0k5TmZm?=
 =?utf-8?B?ZVBaek1Zcnhrd0pTWjlma1RFY095ejI0WDArZ2poRWtXNTlWWXo2TU5BaGJJ?=
 =?utf-8?B?MjBROUpMamdNTnc0VE9BWG8yTjIzTlNsdndKekFHWkp3eDFuWjB6UkVFVnNp?=
 =?utf-8?B?ZHFjMXJlQ3dRaUZvb0VvMXg0bDRCRjVQZnRWZUx3b3dZVC9kaGtzY01CTE9N?=
 =?utf-8?B?cC95Mk9JaGhrTXg3VHJjVFRhRlZJdTVKWmU5WWVjb2NKZE9WbUxkZHlabDRU?=
 =?utf-8?B?SnpUbW54YncvQVk5dEo2QzVYVnpFUHEzRVBySE50YTZwZ1YwWEZXQ29lU2dG?=
 =?utf-8?B?U3RNTVM5b1FUQzVmYlp1Sm9VZTMyekZjMVpVQ3B5eVpnc2R2WDRwR2tYTi81?=
 =?utf-8?B?TmxrYVRhVkZmSFhWMVRrTDFEb2J6V0dmUWVtL2Fudk5pNWx1U0ZsYXRWUW40?=
 =?utf-8?B?WWJwV3lUZXN6UStHU3Q5MnBaOHRESnhEaWJnZ2t0R2dZSE9uNTZuNEt6NGY5?=
 =?utf-8?B?N1dTKzhKTXRSYkIvbndGQW94U05XZ3NjUkJxSkxhMTQ0VkxzVmxrZ2lXRGJ4?=
 =?utf-8?B?WS82eExnVG03TFd4Y2pmNlhZQ2ZkeUN4M0ZtNitINU9MYmVIeUhnZ0ZTUzBB?=
 =?utf-8?B?SUpMQS9FYm1BMUNJMWk0cTY5blhQSHJMbk1rdlZQZDM1K1hGNVhqNTJNZjhE?=
 =?utf-8?B?NUdqVGlRQTdWQklrL0lrQ3RSalBYTjlKbWVMTGViUndnR2RSSHNYRDRzc3BD?=
 =?utf-8?B?UlFHRmRlRHYrSGtpVXZ6QUR6eURPZ0xmc2hZZFBoZGxvYitQUkhVTkkzczc3?=
 =?utf-8?B?eXZ4T29BcGJuTlhQMFFUNXVBVWhQRXd6ZGVOS1pxQjVPT2pJTnNTU0lpZjVy?=
 =?utf-8?B?TllGTldzNjFXUGYrWWNoOEk4c2dTTXVMbDFJZm1yNFM5eVRMQklTejJnc3hM?=
 =?utf-8?B?bTJtcnFHZGdMcmRLYWt6TktFVWxFMDRZWkU5U24vcmlUNFRKMG5XL2VhTGsy?=
 =?utf-8?B?UVpEZU1hNGdJZXFRQ0ZGQk5RMUhXeWhCOEFmU0QyQmU2Zmc1VE5XN3BxOTFN?=
 =?utf-8?B?Tm80UGZrZ0V2WnpIWlZDVjluRHhzbk94QUsxSHk3R1pSQ3lGdFpWRFZvVmRm?=
 =?utf-8?B?KzY1Zm0xZTZVVzdjMXhEQjFLVTNvcDVrNm8yK2VMdVBkdVBwMEt5S1N6Tmtr?=
 =?utf-8?B?eHFWdkkveXljc214WWJhWXB0YXJHYVBrTHRYVURIV0JuRGFQdThOdS9HWlFu?=
 =?utf-8?B?dmRoR3d1V0JaNE0rM3pPOFloWm8rbjdNY2F4QTliak01L012UjB3Yi9sNXBF?=
 =?utf-8?B?NVRFaDJzTVJkYWhib1ExVEZaWVl3dmpTMmdjSEZ4aFFQbFVlbDJscXM1N2FX?=
 =?utf-8?B?T1NFMXRkc3Y1MEYxUXM5MDlkUnVpUHZ2OU9NOTVOOEd0T2k1RXRQNGJPNnhQ?=
 =?utf-8?B?K3RhSkRUcEk2MTVudVo5cmo3VzlMWEtNQVByYmxZTzFVZnlGdWtmdXM1ait0?=
 =?utf-8?B?Y05hQW5iNW9pQ2licG1kOVVkYUxGcTRSaEttS3dsUXhtcnVtTFNYeTRZOUhN?=
 =?utf-8?B?M09XaWxHcE1TaGxZTWNMTDJJdFF4RGFHNFVNenRZSFZmNU45Y0ppYVpQWnJV?=
 =?utf-8?B?OElUNWwzVlMyZlErQ0lJdTJLb3BWTC9TSGI1R0t2VExFUHh0VXJYTC93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U05KdU9kWW1MdnNTNFdLSHpHRGtJYnl2VjFEU3oxMkdoWmxPdVAzNk9Xdk5C?=
 =?utf-8?B?WHZBSWRmcFJtdW9maXpGYzJoamQ5S2FGekx0WWhDc0trR1JEMXU4bEljbld5?=
 =?utf-8?B?YVdBU3p5eUZPamFtK25uVk5qeDVnV3VzVVAvVmF6Zkp5SVJzd2N0WE0xSXV4?=
 =?utf-8?B?WkxqSTlTS3ZXRHpKRW5Ob1AvRjcyN29LYU5xSHZNY1lYU3FneWtEdVowcCtx?=
 =?utf-8?B?OEtqRUhiMDJheDNxWVViZ1A5WTF1RjQxenIyZ1ZMN2Z3RllzNjljMDhORGVR?=
 =?utf-8?B?eHZIZ2JMYnYzUVpGc2tScVRpQ3U1cC9kbWxybU84RzRGN1IrU2xLYjRKUkNU?=
 =?utf-8?B?U05pRlhTZUliMUVCbFNQVG1pOEQrWDVWZ3NNeU91QXFMZ05SNThMa2dneGVD?=
 =?utf-8?B?S0FxVjV5TTNhdUY2VGhjQTAwS1YvZ1RUN053bWJ6RjBTZVE0V2tHSCtBeHk2?=
 =?utf-8?B?Y284dmRUUHI3UUcrd0R5eGVlMDJqK2RoR3JsaFBwa1laNUU5UFlMZmtZczI2?=
 =?utf-8?B?L25lSEpoVytBVTlXdTVFWSs0NEZNWFY5RURqME5xckMwTlE5NHV1YWtvcy8z?=
 =?utf-8?B?R3VGQVJkbkNmTU5DeGpKUFh5TkpZNEdkeXNjNW1FRmdpSCtZeXg0T2Y5WStP?=
 =?utf-8?B?b3ZWVUFDOXU5ZVQ2NDVUZFdmMGMyNHIySXZtcDFUaDk2VnlGdzRBVy8vR3RL?=
 =?utf-8?B?N2dwaXoxOHhoUUEzb0tmVVY5amtrRDlCT0hkVDE2Nk9nY0Q5SFJmelVGSTUz?=
 =?utf-8?B?YjJKUjhqeFlUWGpyY3I5eWhhc0lEYS8xcXlQK0NhZk95eW8rQ0FiZ3cvVXMw?=
 =?utf-8?B?S0ZmVnZsWXNTOFE5WGd0eWhNaU95OFJBaTU0ZkcyTExWSWFZZFhvUUQ3OGtW?=
 =?utf-8?B?ZXREbXIyUFZMK0NyVFMyZkJMN05EdDRLYVFoMHdJTjBvSkhOUS8xVzJjcStM?=
 =?utf-8?B?VklCdHd1QzFCNlJ6ZXU2ZFpGcWxXb1NFRUNqOVRPRnd4V0JnTVFYT2h4ejJs?=
 =?utf-8?B?ajFNai9QdEtyRm14TFRjd1RPSkhNR3h0NHlla1JhZjZPbnQrZkRHRzFzOFN2?=
 =?utf-8?B?aXlOOXJ3WGhPdnpNQXRCalBiTXlwNk9VRHJqbm0xSDIzQVpyOTlaQlVyd1d5?=
 =?utf-8?B?Nm1Od0p0elZIYnk1UWtqbERXU0ZFNTM0bVB3SlphL00zZ0tZcXg5UXNYZE96?=
 =?utf-8?B?ZjF5VVRRcVcrM1pwRW5zZjZoUzY2Y1Z0VmNQb0E5dkhpWjJEdE1tcjJmek1H?=
 =?utf-8?B?Nm1wTnY2RkdUcjF1T2VLQVlZamN1KzdHQlVTM1gxRzkveWo5VldXNnNqTitP?=
 =?utf-8?B?K2M4MjAvSklQRGhsT0VwSmJTa3pzSWp6Umo2cTFLcmREQllmNmI1aFEyaVVp?=
 =?utf-8?B?UXluWjJuN1VXejhhczZNUDNDK05WV2JOY0FnYnhNZWxaNEZ2cDhmQWFpRFhs?=
 =?utf-8?B?TnpnL2xMMjdMNXZyWHNOdUVFUVoxMk9oVFpqNm9GRTlnTkRraTVLZTNreE45?=
 =?utf-8?B?TEMwVWxkaWFlak5nUGtrZnc4ZUdUZllIT2gxV2hSd09XMmRCdXB0Mzc1aFBW?=
 =?utf-8?B?eFhxZ2lESUR4eVhEcUtKdVFkODZMcnVQSkZXVTErdEtRYXphdE1mQ0VNUHBz?=
 =?utf-8?B?NllWTVpXM3B4L3VLdklZUmRIZVRqNC9UelVFQVFWOVpQdFZWS1JOUkZvdk9Q?=
 =?utf-8?B?eENLKzVUVUZDL2VQSEJXYjZWZnhkVFpIWkE2cHBXUndZVEJMUzJpejIybFVm?=
 =?utf-8?B?UTBGc21HNkp6NkZjbTdCbVh6SWJ6dnVXTVBZSzBLekVWSEs5amVtbU1PM2Vk?=
 =?utf-8?B?S0dkaUw1WWR1TTVLc0d3NHZ3blZmZ3QwVzZFdS9BdENaU1dVOEFEd1FRditr?=
 =?utf-8?B?WmFtK0Y2VnE1enhUbytyOHBIR3JLa2ZiUmJqdVZUOG9peDNndE5oazZkMTN3?=
 =?utf-8?B?MlkxaGZzQ0pXRDhNd3pyMjJUS3NTZVVQTnIxbzYxeTRZckRkUTVKeTd0OFNr?=
 =?utf-8?B?MEpSVGRFMGozWERVbnVQNkdVeXBvYnlOSzVxTGxLbmUvaWtKMis2c0tUM0cx?=
 =?utf-8?B?aWt0cGorczVOVXR1VGtndkhianczNzE0ZklRcHo4N085TmxzdXlqVmliZEZJ?=
 =?utf-8?Q?75YoR/t0669rcJvlyp5aN1RCk?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627c7ccb-4ec8-443f-129f-08dce87248d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:54:32.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyt1BOipjjGcdn49oj2fLopA52HOpe2kcmDxt8wLRyeADQvAuEar8ZjQUPvr7IIySyoIQ5FlL94Zcm3L0/9G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6333
Received-SPF: pass client-ip=2a01:111:f403:2612::709;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/24 16:54, Andrey Drobyshev wrote:
> On 10/9/24 4:58 PM, Denis V. Lunev wrote:
>> Recent QEMU changes around preallocate_set_perm mandates that it is not
>> possible to poll on aio_context inside this function anymore. Thus
>> truncate operation has been moved inside bottom half. This bottom half
>> is scheduled from preallocate_set_perm() and that is all.
>>
>> This approach proven to be problematic in a lot of places once
>> additional operations are executed over preallocate filter in
>> production. The code validates that permissions have been really changed
>> just after the call to the set operation.
>>
>> All permissions operations or block driver graph changes are performed
>> inside the quiscent state in terms of the block layer. This means that
>> there are no in-flight packets which is guaranteed by the passing
>> through bdrv_drain() section.
>>
>> The idea is that we should effectively disable preallocate filter inside
>> bdrv_drain() and unblock permission changes. This section is definitely
>> not on the hot path and additional single truncate operation will not
>> hurt.
>>
>> Unfortunately bdrv_drain_begin() callback according to the documentation
>> also disallow waiting inside. Thus original approach with the bottom
>> half is not changed. bdrv_drain_begin() schedules the operation and in
>> order to ensure that it has been really executed before completion of
>> the section increments the amount of in-flight requests.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   block/preallocate.c    | 38 ++++++++++++++++++++++++++++++++++----
>>   tests/qemu-iotests/298 |  6 ++++--
>>   2 files changed, 38 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> index 1cf854966c..d78ef0b045 100644
>> --- a/block/preallocate.c
>> +++ b/block/preallocate.c
>> @@ -78,6 +78,7 @@ typedef struct BDRVPreallocateState {
>>   
>>       /* Gives up the resize permission on children when parents don't need it */
>>       QEMUBH *drop_resize_bh;
>> +    bool    drop_resize_armed;
>>   } BDRVPreallocateState;
>>   
>>   static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
>> @@ -149,6 +150,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>>        */
>>       s->file_end = s->zero_start = s->data_end = -EINVAL;
>>       s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
>> +    s->drop_resize_armed = false;
>>   
>>       ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
>>       if (ret < 0) {
>> @@ -200,7 +202,7 @@ static void preallocate_close(BlockDriverState *bs)
>>   {
>>       BDRVPreallocateState *s = bs->opaque;
>>   
>> -    qemu_bh_cancel(s->drop_resize_bh);
>> +    assert(!s->drop_resize_armed);
>>       qemu_bh_delete(s->drop_resize_bh);
>>   
>>       if (s->data_end >= 0) {
>> @@ -504,6 +506,8 @@ static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
>>       BDRVPreallocateState *s = bs->opaque;
>>       int ret;
>>   
>> +    s->drop_resize_armed = false;
>> +
>>       if (s->data_end < 0) {
>>           return 0;
>>       }
>> @@ -534,11 +538,15 @@ static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
>>   
>>   static void preallocate_drop_resize_bh(void *opaque)
>>   {
>> +    BlockDriverState *bs = opaque;
>> +
>>       /*
>>        * In case of errors, we'll simply keep the exclusive lock on the image
>>        * indefinitely.
>>        */
>> -    preallocate_drop_resize(opaque, NULL);
>> +    preallocate_drop_resize(bs, NULL);
>> +
>> +    bdrv_dec_in_flight(bs);
>>   }
>>   
>>   static void preallocate_set_perm(BlockDriverState *bs,
>> @@ -547,13 +555,13 @@ static void preallocate_set_perm(BlockDriverState *bs,
>>       BDRVPreallocateState *s = bs->opaque;
>>   
>>       if (can_write_resize(perm)) {
>> -        qemu_bh_cancel(s->drop_resize_bh);
>>           if (s->data_end < 0) {
>>               s->data_end = s->file_end = s->zero_start =
>>                   bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
>>           }
>>       } else {
>> -        qemu_bh_schedule(s->drop_resize_bh);
>> +        assert(!s->drop_resize_armed);
>> +        assert(s->data_end < 0);
>>       }
>>   }
>>   
>> @@ -592,6 +600,26 @@ static int preallocate_check_perm(BlockDriverState *bs, uint64_t perm,
>>       return 0;
>>   }
>>   
>> +static void preallocate_drain_begin(BlockDriverState *bs)
>> +{
>> +    BDRVPreallocateState *s = bs->opaque;
>> +
>> +    if (s->data_end < 0) {
>> +        return;
>> +    }
>> +    if (s->drop_resize_armed) {
>> +        return;
>> +    }
>> +    if (s->data_end == s->file_end) {
>> +        s->file_end = s->zero_start = s->data_end = -EINVAL;
>> +        return;
>> +    }
>> +
>> +    s->drop_resize_armed = true;
>> +    bdrv_inc_in_flight(bs);
>> +    qemu_bh_schedule(s->drop_resize_bh);
>> +}
>> +
>>   static BlockDriver bdrv_preallocate_filter = {
>>       .format_name = "preallocate",
>>       .instance_size = sizeof(BDRVPreallocateState),
>> @@ -600,6 +628,8 @@ static BlockDriver bdrv_preallocate_filter = {
>>       .bdrv_open            = preallocate_open,
>>       .bdrv_close           = preallocate_close,
>>   
>> +    .bdrv_drain_begin     = preallocate_drain_begin,
>> +
>>       .bdrv_reopen_prepare  = preallocate_reopen_prepare,
>>       .bdrv_reopen_commit   = preallocate_reopen_commit,
>>       .bdrv_reopen_abort    = preallocate_reopen_abort,
>> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
>> index 9e75ac6975..41f12685a7 100755
>> --- a/tests/qemu-iotests/298
>> +++ b/tests/qemu-iotests/298
>> @@ -94,8 +94,10 @@ class TestPreallocateFilter(TestPreallocateBase):
>>           self.assert_qmp(result, 'return', {})
>>           self.complete_and_wait()
>>   
>> -        # commit of new megabyte should trigger preallocation
>> -        self.check_big()
>> +        # commit of new megabyte should trigger preallocation, but drain
>> +        # will make file smaller
>> +        self.check_small()
>> +
>>   
>>       def test_reopen_opts(self):
>>           result = self.vm.qmp('blockdev-reopen', options=[{
> This patch doesn't seem to be applying cleanly to the current master branch
this is my fault. Thanks.

I will resend.

Den

