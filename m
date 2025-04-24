Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5266FC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 17:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u80Xz-0003RB-9I; Thu, 24 Apr 2025 13:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u80Xu-0003Q2-SF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:39:36 -0400
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com
 ([40.107.21.102] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u80Xr-000182-RE
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:39:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLArq9I+xRMWwFQJT4sesjof/1mDuxihVZDOjXvHG0MXeRjtX4qCaVW7/UBef+o/VsEwarDejdVZnYbO27wXJLDU9v4dFDJc/2J0cASRPJEjq+K83UwhcrLQJk5IKm2BlC68ADUpG0HTKYfMPYzYzhM5PpFLBLYTdOxqwfTULj9fn0Tmq6ybf3QhYEiJRFkCa9Y1pTFJumvJecbNDULdt85pDIjfU22LTUSu0bBuk1F8c4rRAYxbW1SZ1fXylJb0qP1LM/rK4P0cUt88zp0nkZ8rNk1G0Y2zvP45LZVspT/2ik6i4kPSr+srdyBcIA+xbdXK5fr1EJwdz0sjtgVT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMp7sZlONO/Ob4zh6gSRsUqfRZY3S8gATgsmc4tkVxE=;
 b=pImIrX7B/aw83oc3BKqwrTf/jteq8XGR44k3G/wwCbCHAyYB2wbzcXsuCji1SgLBLZQ9nmRLV6XqBhuB2CkOgvJjXvLsvjWY13zqKiBU8xuuQPQht2Zu57k+HBejpIoLNgHr0Nb29g0O4guWaJwtNL/shKd3y71tOhO7DBsmgiWSGtA+tXyHsviWaGBD95b+CJIl2ZVWOgYwp9jdQk5taAveCqTgLKaHHAJyomnNbjq5uRoUM2IgNQVs79doxANJLqCtz/3GpbOq2eoZltxtdk4uERDJUM7IoLMOpZai6ft/PhW2JYs/j/NyRVeNlIAZNW9cZllCO7SveZ6gr4icBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMp7sZlONO/Ob4zh6gSRsUqfRZY3S8gATgsmc4tkVxE=;
 b=Xvwps7MQj7pOlIl3iC+8OfTzdOXsomkgzaa3GyjHuJryHxxVKtrF/c4x+vH9K6lmUtmQa3msEin4JqQPXvpklsmHfMhqD6FFEY6hinFHOb8J4Q7fI2m+fztBhE7VtmGESrFoEdhPIzOOtaXsgepsJNQCps2/twmVs1idZ/VdcKJWhZCDBzVPan4FaXpLuvq162iP70VgY7mHkP948yAcsnC5dU3edAeEjeSb0ih5c4gy3fHwpSXDaUUMmYli7u9T0men9HQLwnG9RWvfbUkKMlqhHYinbMqxCfTiKrtbU4xwoDmfyOI/5NPKlqROLsrINJ1r1Xwlilr2mUs6BYAWFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8208.eurprd08.prod.outlook.com
 (2603:10a6:10:3b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 17:34:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 17:34:24 +0000
Content-Type: multipart/mixed; boundary="------------r0jFAlT0We0BpNFBzF0DyGNm"
Message-ID: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
Date: Thu, 24 Apr 2025 20:32:55 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [BUG, RFC] Block graph deadlock on job-dismiss
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 145cf54b-b4ef-44a5-66cc-08dd8356412b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajBwUllMWVlZUUtCbm0vOHBVcTg1dFh6dVJZdXdtRy9PeG1JUkQ3KzZUdlFI?=
 =?utf-8?B?UzRQM3g1SzBIOEdpWHFqUkhwenJPNU93NXVubExaSVhFMXI1d01tamNuZXho?=
 =?utf-8?B?KzVpYlowVG13cjJWZGpRdmhtZkJrK2lJRlRMbDNXVjNOREdoS3hFMStuR3Fs?=
 =?utf-8?B?dHFYWDdBcWtyK0VDN1Uxc2NzZ0xLOTB3bG4rbkV2bmFkSUFUMHc4d0VYZjNt?=
 =?utf-8?B?c09TanJNbDZBKzZibGl2UjNIaktLM2ZnUTA3V1N6TFJoRVgwME1ORks2Z240?=
 =?utf-8?B?SVdIbCthT1NENVlWNWRpa3lKa3JSQzJQeTlIR1AvZXZrTDcyOHJWVXlyK3ZD?=
 =?utf-8?B?WWRyS01PaWpQY1YxOU85ZC90Q0ZiYk1zR2VEK1RuN2pYczY3NVdZL0hjenNW?=
 =?utf-8?B?ZWk2VXMxWVNWaURCTUVTQlRXRzZXb1ZqWW1jR0xqZkk0b1RpNVJEUGp1eHBw?=
 =?utf-8?B?MHFBNm05N3hsOFVZNVFmZXY0bkV6RklrK2lIcG9ScWl0WlY5bm1WNTlsVFQ0?=
 =?utf-8?B?Y1J2Tll2ZW5mL01YYzI0b0swTjZxM1o4c21qeXd2Q1pTTDVudzAvL2poMElW?=
 =?utf-8?B?akl0OUdlZEdHK2prV3h1RkcwOFZ6alIwR2QxdndGN0Y1cmFQSEgvR2ZGTmhT?=
 =?utf-8?B?UGF2ZndzblZZUk4zWjlqcTBLWUc1bnd4Z2tuc3BjSnNrbEI4MU5XUlpqQWt5?=
 =?utf-8?B?U1JlUk9QbEh6UU5vK2xqVmlpWlBzMThBSDNLRU9HWHluMHpYRG1ibElMVVR5?=
 =?utf-8?B?YWQyZU11UGEwK1NLeW9GYmYzNTVyTjI2YW8vZjVzc1dlWlJuUlRMeDFwVUFz?=
 =?utf-8?B?aUNjSENCVHRiTTRxbWZ6Rzl1TGg0SkxvRUZZZUN1VjRVNit4cXQ1cllJbGV3?=
 =?utf-8?B?NHc1TFVsV1hJbHpFYVdUTEYwRG1JWjIxQXRNNWZuREd1eTNabHpMMlUxZzFq?=
 =?utf-8?B?eFJ3akY4YmJVa0NxUlAwQWl2cFRPaU1zNnlGZTN2bjJiK1BGenNXNURaRXZ3?=
 =?utf-8?B?SDl3YVFsSjlrS1pibjJWK1VpYzgwL2w0Y3JHTWhDNmdNR3lJSVZqVys0Z0w5?=
 =?utf-8?B?dUZSYnRIM1h4dkg5ayt0TFBvbmRyWFdITFplc3BBSDFvZG41alcvRDNhaU1a?=
 =?utf-8?B?QVArOXA1eVFVNHdJUkVIcWk2K0VpejRvcWFjb0Z5QzBnUGk4NVUrT0Nrbmk1?=
 =?utf-8?B?eDd2Tm9FWGRKUGl3WGhGOXhrRVdHcFJoa01NbktSdktCeHR0RHhJNnI1S2hr?=
 =?utf-8?B?Y1U0ako5WmVMQi9VUGpic29nY091R0o4SG9KclNGeGIyMHFtNi9qbHV3bkFx?=
 =?utf-8?B?N3N0Z0RvRmZyZEo4NjZUd255U3FFV3Fxa3lkOTJCZWxFaTRFV3hqY1FXTzFN?=
 =?utf-8?B?dkl3L1dtMXowYUQrSUtJWGZ3M2VBcVlLdWdZQ3F5VUlFZEp6R3RjWXV5Rnly?=
 =?utf-8?B?T0RGRmMySXhudm0vQ3cxS0tQRjBlb0syRWJkbHlkOUFHODdINEliemcvOVNr?=
 =?utf-8?B?REJDRTBVNW45aURaZmdiYXp6dG9VUzErdUk5WFFyaFFWaTZJZCtzZkRJS3Vs?=
 =?utf-8?B?R1E5Z3pGVVZLUmNTZ05XSGRVMGdaekpYcHhzUFphaEFCUEI0UjFwOEkwSDNu?=
 =?utf-8?B?Ynlka29TQk5ramJXeGVaNlBWMEtxbkR0bzNtNkVqejduSFNybkY0Qjl1VG51?=
 =?utf-8?B?RCsvVlRqc252T1VPOENUZDlzR3B1RXpLc0k4dU1jTEhVVnBqUCt1UmlKeEVC?=
 =?utf-8?B?R293TGdud1ZEQ3QzcUxmYVVOUmlsWmF5bi9PZWdlUFJQU3V3eGRCcnJFVzl1?=
 =?utf-8?B?MkFRR0xtWE5CaHhXN2lwaTVHT2Jkb2tMZkpHNStVLzlWYS9UTHlLZHY1dWwx?=
 =?utf-8?B?bEo2QmJrMFBrYms2cHluZzV4Q0tGd1lGRUp5cmpSR0hubUtEL1VSazBLZ2g3?=
 =?utf-8?Q?o/WaJsHbpbc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4053099003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpyU25YMVk1NWJsUkpSZ3h4aFdHZEJVMGxZL1Z1V09mSFFCRE4wZGJkQ0JN?=
 =?utf-8?B?bHFRR29Pa1VGME5TOXhTNXhzakJLeWswOHM0dnFuQnROVXQ0a2JrZVRhaUhT?=
 =?utf-8?B?UEVxMzJuTmc2Z2prUGczNHBjSlZuT2RQRjBuc0UyV3I0bDllMHhxQ1Fic3Zi?=
 =?utf-8?B?UXoxQ1IrTGxMV1Q2dVNIcmI0UmxIcDJXby8yNEtxTmptOVZNM3kwWDA0a3hX?=
 =?utf-8?B?YUI2ZDVsaDlSWUg4Qm1hSHBpNTdCekRueVVGWEpPc3FjanB6cjcvcnJGTGZq?=
 =?utf-8?B?NXcreVdYNHIzbVo4MEhBZlpIQjJJN05EYWFyV3NFbXp6QjBhQjJnSHFoaG5Y?=
 =?utf-8?B?d2lxd0hjdUZieVBhQVVmc09Eb0piR09Ncy9DaFhBeC9GQUc4bkdXQ1J6UDl5?=
 =?utf-8?B?eDQ2Wjl6ZVJJSy9KcVVjQldPUW1DaWZWeHluVlFQSzdMVmpFWFUzVnBRek9B?=
 =?utf-8?B?WWNkRk5sVWRUWjFxL2RtUTc2bTFsU29GdGRnUTdXZ1pMRllNMzNsaXpuR0Ru?=
 =?utf-8?B?MmdkMHQyeUdqc3RESWRVaUpFUEFvT0x5TFM0N2NhZ0QwZmJXTU5WRjFiM3pl?=
 =?utf-8?B?a2gwamxCQ3oxaEdudnE3NTFORmJ6aks5STVrRUE5NGkvUFIwM2R6UTlSVFFa?=
 =?utf-8?B?elZDVHdyK0ZBaVJGc240Szg1T0RvSnUvVFRlazBrb3RueTI1RmJKZDhjbERO?=
 =?utf-8?B?NldoWnh2U2xKNkk1Z1VMM1RqaVBhZitFdjNkdFlwQi9SME1qV1YyczlyZHNs?=
 =?utf-8?B?aDhBSmJXakRqMjNmWDdOS3ZnMDBLcGVCUjhKWERJenZFYXRxQXFKKzgybXR2?=
 =?utf-8?B?QVdNVG1ra3pPSzYzZURpc0k3QUhRK2MvTFJvbXlOK3RQZGN4VlA2QWs2blk0?=
 =?utf-8?B?bDZHcEYwUFl6NnhwMjVVdmhzTWxTUEU5d3JHdmRxMFd4cUxmeURxbVJtTVZw?=
 =?utf-8?B?MldSRDFtVnAwaXZBckk1ejFqTmM2M0d4aW1RdnFpazJuWFdNNDRPbHBQQm1H?=
 =?utf-8?B?dGJqZzI0d1YwNndoZis3NjFITUhvMWZLTFd0UHFPOUpxSk9OQ3NZL0FnWHFa?=
 =?utf-8?B?UDJuNldlRC9tbjRmNGdERm1OUm9KUThOdnA1QjZMWFdsWWRXcTJXUmFEVjR4?=
 =?utf-8?B?V21GdXdGM0NMc3VzZmpERFNJcmlpZk9ZbXl3QmxLYldmVFF6R0VaamhpR0R6?=
 =?utf-8?B?VGJLRFdraUFUQ3ltckFsWGxJbEIzTG1ad1g1enNDa1I4cC82RkZtM1JqK3Vy?=
 =?utf-8?B?RVpFa0pKS3lPQ2NJUk9NRDAzdWNTWTlvM3drTEtDdnBEcnIwWVdPYjZHaW9H?=
 =?utf-8?B?ZFFzdTRjNzRjUmhOYVJYZFJzVDY3VHpJY1l3WVRPejUwWU5GZGxSVklac0J6?=
 =?utf-8?B?RXpISEhXQ1hHTlRkYWVXcFhmSHMzNXcvdEs3M1FQVXF0b0FHdUNqUUppVXpl?=
 =?utf-8?B?cEFrRTlEdkk5M1huV2VZWnF2YVEvVk9CVU05Q3p5WHNOKzdvZy9oSEZQNjFp?=
 =?utf-8?B?UlpWRXl5cnVyU0lqSWJnMUw3cWVpaGxJTWJmV3JocUg0L2RPaWJkdlVST3lU?=
 =?utf-8?B?OEs2ZzFISVc1SG9rNnR6bEdVaXZodHFMTTJ6bllScmVzcGNsWHQ0K1JWWmgx?=
 =?utf-8?B?R3lxQlE0eHNNR1pGdFQvYTJVTjBNd1hHWG5wYVdPbHlxNm9JaDB4Z1NUNlJv?=
 =?utf-8?B?Wm04TDFwWUxHQzlZWGIxNlFwQmxJOS85TkpicDlINnNNQ0I4YnNGVm1qb1pZ?=
 =?utf-8?B?SGJGdERpOXNpK0tsWVZySzZuUFFaZmk4NlpGMVIwNXJEYnpiY2RlZmVsaWlH?=
 =?utf-8?B?U2JVT0Vua2RqaXN4NjhOZjB2azJLM25NYnZSQk1NRzd4Ky9NWG9rS05xQjhI?=
 =?utf-8?B?TnJHZzBnRERxanpDUGhPUmhENUlUTCsxVnh5b1NCODNZcEhObmI5Z0FJcHcr?=
 =?utf-8?B?am5mMnFTVFErRExrZlJ4QUJiS29XdnpqNzZuYllQNmNTUFV2b09BRHhYYmVJ?=
 =?utf-8?B?bXNDZjJNRnVITTI1eXFqUWNvaDErekJZL1VEYjJaaWI2R2QvQ2pLaDEwMkhT?=
 =?utf-8?B?Nm12R1hyM3J5dldXeHEwcDVIbGVsUWlkMG54dTNqTkxUTm9mR1pFNVg1WkE1?=
 =?utf-8?B?S3pyL3V0L2RLeWVYQXdJblJmWmJNNHptWXBFZFU3K2JTR1B1QXpra2VEbnV2?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145cf54b-b4ef-44a5-66cc-08dd8356412b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 17:34:24.2729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw28SFOtzONXVOi6K0gsfDds3683+z11ACYDXrvb1QadVakQDTtcbehdJftWQzY8rJxQaVcpY2poeNo33xvQxyw080uSJppYlUmxk5QF1gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8208
Received-SPF: pass client-ip=40.107.21.102;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--------------r0jFAlT0We0BpNFBzF0DyGNm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

There's a bug in block layer which leads to block graph deadlock.
Notably, it takes place when blockdev IO is processed within a separate
iothread.

This was initially caught by our tests, and I was able to reduce it to a
relatively simple reproducer.  Such deadlocks are probably supposed to
be covered in iotests/graph-changes-while-io, but this deadlock isn't.

Basically what the reproducer does is launches QEMU with a drive having
'iothread' option set, creates a chain of 2 snapshots, launches
block-commit job for a snapshot and then dismisses the job, starting
from the lower snapshot.  If the guest is issuing IO at the same time,
there's a race in acquiring block graph lock and a potential deadlock.

Here's how it can be reproduced:

1. Run QEMU:
> SRCDIR=/path/to/srcdir                                                                                                                                         
>                                                                                 
> $SRCDIR/build/qemu-system-x86_64 -enable-kvm \                                  
>   -machine q35 -cpu Nehalem \                                                   
>   -name guest=alma8-vm,debug-threads=on \                                       
>   -m 2g -smp 2 \                                                                
>   -nographic -nodefaults \                                                      
>   -qmp unix:/var/run/alma8-qmp.sock,server=on,wait=off \                           
>   -serial unix:/var/run/alma8-serial.sock,server=on,wait=off \                     
>   -object iothread,id=iothread0 \                                               
>   -blockdev node-name=disk,driver=qcow2,file.driver=file,file.filename=/path/to/img/alma8.qcow2 \
>   -device virtio-blk-pci,drive=disk,iothread=iothread0

2. Launch IO (random reads) from within the guest:
> nc -U /var/run/alma8-serial.sock
> ...
> [root@alma8-vm ~]# fio --name=randread --ioengine=libaio --direct=1 --bs=4k --size=1G --numjobs=1 --time_based=1 --runtime=300 --group_reporting --rw=randread --iodepth=1 --filename=/testfile

3. Run snapshots creation & removal of lower snapshot operation in a
loop (script attached):
> while /bin/true ; do ./remove_lower_snap.sh ; done

And then it occasionally hangs.

Note: I've tried bisecting this, and looks like deadlock occurs starting
from the following commit:

(BAD)  5bdbaebcce virtio: Re-enable notifications after drain
(GOOD) c42c3833e0 virtio-scsi: Attach event vq notifier with no_poll

On the latest v10.0.0 it does hang as well.


Here's backtrace of the main thread:

> #0  0x00007fc547d427ce in __ppoll (fds=0x557eb79657b0, nfds=1, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:43
> #1  0x0000557eb47d955c in qemu_poll_ns (fds=0x557eb79657b0, nfds=1, timeout=-1) at ../util/qemu-timer.c:329
> #2  0x0000557eb47b2204 in fdmon_poll_wait (ctx=0x557eb76c5f20, ready_list=0x7ffd94b4edd8, timeout=-1) at ../util/fdmon-poll.c:79
> #3  0x0000557eb47b1c45 in aio_poll (ctx=0x557eb76c5f20, blocking=true) at ../util/aio-posix.c:730
> #4  0x0000557eb4621edd in bdrv_do_drained_begin (bs=0x557eb795e950, parent=0x0, poll=true) at ../block/io.c:378
> #5  0x0000557eb4621f7b in bdrv_drained_begin (bs=0x557eb795e950) at ../block/io.c:391
> #6  0x0000557eb45ec125 in bdrv_change_aio_context (bs=0x557eb795e950, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7682
> #7  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7964250, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7608
> #8  0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7668
> #9  0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb7e59110, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7608
> #10 0x0000557eb45ec0c4 in bdrv_change_aio_context (bs=0x557eb7e51960, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7668
> #11 0x0000557eb45ebf2b in bdrv_child_change_aio_context (c=0x557eb814ed80, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7608
> #12 0x0000557eb45ee8e4 in child_job_change_aio_ctx (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../blockjob.c:157
> #13 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb7c9d3f0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7592
> #14 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb7d74310, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7661
> #15 0x0000557eb45dcd7e in bdrv_child_cb_change_aio_ctx
>     (child=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0) at ../block.c:1234
> #16 0x0000557eb45ebe2d in bdrv_parent_change_aio_context (c=0x557eb8565af0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7592
> #17 0x0000557eb45ec06b in bdrv_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, visited=0x557eb7e06b60 = {...}, tran=0x557eb7a87160, errp=0x0)
>     at ../block.c:7661
> #18 0x0000557eb45ec1f3 in bdrv_try_change_aio_context (bs=0x557eb79575e0, ctx=0x557eb76c5f20, ignore_child=0x0, errp=0x0) at ../block.c:7715
> #19 0x0000557eb45e1b15 in bdrv_root_unref_child (child=0x557eb7966f30) at ../block.c:3317
> #20 0x0000557eb45eeaa8 in block_job_remove_all_bdrv (job=0x557eb7952800) at ../blockjob.c:209
> #21 0x0000557eb45ee641 in block_job_free (job=0x557eb7952800) at ../blockjob.c:82
> #22 0x0000557eb45f17af in job_unref_locked (job=0x557eb7952800) at ../job.c:474
> #23 0x0000557eb45f257d in job_do_dismiss_locked (job=0x557eb7952800) at ../job.c:771
> #24 0x0000557eb45f25fe in job_dismiss_locked (jobptr=0x7ffd94b4f400, errp=0x7ffd94b4f488) at ../job.c:783
> --Type <RET> for more, q to quit, c to continue without paging--
> #25 0x0000557eb45d8e84 in qmp_job_dismiss (id=0x557eb7aa42b0 "commit-snap1", errp=0x7ffd94b4f488) at ../job-qmp.c:138
> #26 0x0000557eb472f6a3 in qmp_marshal_job_dismiss (args=0x7fc52c00a3b0, ret=0x7fc53c880da8, errp=0x7fc53c880da0) at qapi/qapi-commands-job.c:221
> #27 0x0000557eb47a35f3 in do_qmp_dispatch_bh (opaque=0x7fc53c880e40) at ../qapi/qmp-dispatch.c:128
> #28 0x0000557eb47d1cd2 in aio_bh_call (bh=0x557eb79568f0) at ../util/async.c:172
> #29 0x0000557eb47d1df5 in aio_bh_poll (ctx=0x557eb76c0200) at ../util/async.c:219
> #30 0x0000557eb47b12f3 in aio_dispatch (ctx=0x557eb76c0200) at ../util/aio-posix.c:436
> #31 0x0000557eb47d2266 in aio_ctx_dispatch (source=0x557eb76c0200, callback=0x0, user_data=0x0) at ../util/async.c:361
> #32 0x00007fc549232f4f in g_main_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:3364
> #33 g_main_context_dispatch (context=0x557eb76c6430) at ../glib/gmain.c:4079
> #34 0x0000557eb47d3ab1 in glib_pollfds_poll () at ../util/main-loop.c:287
> #35 0x0000557eb47d3b38 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:310
> #36 0x0000557eb47d3c58 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:589
> #37 0x0000557eb4218b01 in qemu_main_loop () at ../system/runstate.c:835
> #38 0x0000557eb46df166 in qemu_default_main (opaque=0x0) at ../system/main.c:50
> #39 0x0000557eb46df215 in main (argc=24, argv=0x7ffd94b4f8d8) at ../system/main.c:80


And here's coroutine trying to acquire read lock:

> (gdb) qemu coroutine reader_queue->entries.sqh_first 
> #0  0x0000557eb47d7068 in qemu_coroutine_switch (from_=0x557eb7aa48b0, to_=0x7fc537fff508, action=COROUTINE_YIELD) at ../util/coroutine-ucontext.c:321
> #1  0x0000557eb47d4d4a in qemu_coroutine_yield () at ../util/qemu-coroutine.c:339
> #2  0x0000557eb47d56c8 in qemu_co_queue_wait_impl (queue=0x557eb59954c0 <reader_queue>, lock=0x7fc53c57de50, flags=0) at ../util/qemu-coroutine-lock.c:60
> #3  0x0000557eb461fea7 in bdrv_graph_co_rdlock () at ../block/graph-lock.c:231
> #4  0x0000557eb460c81a in graph_lockable_auto_lock (x=0x7fc53c57dee3) at /home/root/src/qemu/master/include/block/graph-lock.h:213
> #5  0x0000557eb460fa41 in blk_co_do_preadv_part
>     (blk=0x557eb84c0810, offset=6890553344, bytes=4096, qiov=0x7fc530006988, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1339
> #6  0x0000557eb46104d7 in blk_aio_read_entry (opaque=0x7fc530003240) at ../block/block-backend.c:1619
> #7  0x0000557eb47d6c40 in coroutine_trampoline (i0=-1213577040, i1=21886) at ../util/coroutine-ucontext.c:175
> #8  0x00007fc547c2a360 in __start_context () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:91
> #9  0x00007ffd94b4ea40 in  ()
> #10 0x0000000000000000 in  ()


So it looks like main thread is processing job-dismiss request and is
holding write lock taken in block_job_remove_all_bdrv() (frame #20
above).  At the same time iothread spawns a coroutine which performs IO
request.  Before the coroutine is spawned, blk_aio_prwv() increases
'in_flight' counter for Blk.  Then blk_co_do_preadv_part() (frame #5) is
trying to acquire the read lock.  But main thread isn't releasing the
lock as blk_root_drained_poll() returns true since blk->in_flight > 0.
Here's the deadlock.

Any comments and suggestions on the subject are welcomed.  Thanks!

Andrey

--------------r0jFAlT0We0BpNFBzF0DyGNm
Content-Type: application/x-shellscript; name="remove_lower_snap.sh"
Content-Disposition: attachment; filename="remove_lower_snap.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKClNSQ0RJUj0vcGF0aC90by9zcmNkaXIKU1RPUkRJUj0vcGF0aC90by9pbWcK
U05BUDE9JFNUT1JESVIvc25hcDEucWNvdzIKU05BUDI9JFNUT1JESVIvc25hcDIucWNvdzIKUU1Q
U0hFTEw9JFNSQ0RJUi9zY3JpcHRzL3FtcC9xbXAtc2hlbGwKUU1QU09DSz0vdmFyL3J1bi9hbG1h
OC1xbXAuc29jawoKZnVuY3Rpb24gcW1wX2ZpbHRlcigpIHsKICAgIHNlZCAtciAnL14oV2VsY29t
ZXxDb25uZWN0ZWQpL2QnCn0KCmZ1bmN0aW9uIHdhaXRqb2IoKSB7CiAgICBqb2JpZD0kMQoKICAg
IHdoaWxlIC9iaW4vdHJ1ZSA7IGRvCiAgICAgICAgcWJqb3V0PSQoJFFNUFNIRUxMIC1wICRRTVBT
T0NLIDw8RU9GCiAgICAgICAgICAgIHF1ZXJ5LWJsb2NrLWpvYnMKRU9GCiAgICAgICAgKQoKICAg
ICAgICBqb2JzdGF0dXM9JChlY2hvICIkcWJqb3V0IiB8IGdyZXAgJyJzdGF0dXMiJyB8IGhlYWQg
LTEgfCBhd2sgJ3twcmludCAkMn0nIHwgc2VkICdzL1siLF0vL2cnKQoKICAgICAgICBpZiBbICJ4
JHtqb2JzdGF0dXN9IiA9PSAieHJlYWR5IiBdIDsgdGhlbgogICAgICAgICAgICBlY2hvIC1lICJc
biMjIyMjIyMjIyBDb21wbGV0ZSBqb2IgJGpvYmlkICMjIyMjIyMjI1xuIgogICAgICAgICAgICAk
UU1QU0hFTEwgLXAgJFFNUFNPQ0sgPDxFT0YgfCBxbXBfZmlsdGVyCiAgICAgICAgICAgICAgICBq
b2ItY29tcGxldGUgaWQ9JGpvYmlkCkVPRgogICAgICAgIGVsaWYgWyAieCR7am9ic3RhdHVzfSIg
PT0gInhjb25jbHVkZWQiIF0gOyB0aGVuCiAgICAgICAgICAgIGVjaG8gLWUgIlxuIyMjIyMjIyMj
IERpc21pc3Mgam9iICRqb2JpZCAjIyMjIyMjIyNcbiIKICAgICAgICAgICAgJFFNUFNIRUxMIC1w
ICRRTVBTT0NLIDw8RU9GIHwgcW1wX2ZpbHRlcgogICAgICAgICAgICAgICAgam9iLWRpc21pc3Mg
aWQ9JGpvYmlkCkVPRgogICAgICAgIGVsaWYgWyAieCR7am9ic3RhdHVzfSIgPT0gIngiIF0gOyB0
aGVuCiAgICAgICAgICAgIGJyZWFrCiAgICAgICAgZmkKCiAgICAgICAgc2xlZXAgMC41CiAgICBk
b25lCn0KCmVjaG8gLWUgIlxuIyMjIyMjIyMjIENyZWF0ZSBzbmFwc2hvdCBpbWFnZXMgIyMjIyMj
IyMjXG4iCgpxZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgJFNOQVAxIDE2RwpxZW11LWltZyBjcmVh
dGUgLWYgcWNvdzIgJFNOQVAyIDE2RwoKZWNobyAtZSAiXG4jIyMjIyMjIyMgQ3JlYXRlIDFzdCBz
bmFwc2hvdCAjIyMjIyMjIyNcbiIKCiRRTVBTSEVMTCAtcCAkUU1QU09DSyA8PEVPRiB8IHFtcF9m
aWx0ZXIKICAgIGJsb2NrZGV2LWFkZCBkcml2ZXI9cWNvdzIgbm9kZS1uYW1lPXNuYXAxIGZpbGU9
eyJkcml2ZXIiOiJmaWxlIiwiZmlsZW5hbWUiOiIkU05BUDEifQogICAgYmxvY2tkZXYtc25hcHNo
b3Qgbm9kZT1kaXNrIG92ZXJsYXk9c25hcDEKRU9GCgplY2hvIC1lICJcbiMjIyMjIyMjIyBDcmVh
dGUgMm5kIHNuYXBzaG90ICMjIyMjIyMjI1xuIgoKJFFNUFNIRUxMIC1wICRRTVBTT0NLIDw8RU9G
IHwgcW1wX2ZpbHRlcgogICAgYmxvY2tkZXYtYWRkIGRyaXZlcj1xY293MiBub2RlLW5hbWU9c25h
cDIgZmlsZT17ImRyaXZlciI6ImZpbGUiLCJmaWxlbmFtZSI6IiRTTkFQMiJ9CiAgICBibG9ja2Rl
di1zbmFwc2hvdCBub2RlPXNuYXAxIG92ZXJsYXk9c25hcDIKRU9GCgplY2hvIC1lICJcbiMjIyMj
IyMjIyBDb21taXQgbG93ZXIgc25hcHNob3QgIyMjIyMjIyMjXG4iCgokUU1QU0hFTEwgLXAgJFFN
UFNPQ0sgPDxFT0YgfCBxbXBfZmlsdGVyCiAgICBibG9jay1jb21taXQgZGV2aWNlPXNuYXAyIHRv
cC1ub2RlPXNuYXAxIGJhc2Utbm9kZT1kaXNrIGF1dG8tZmluYWxpemU9dHJ1ZSBhdXRvLWRpc21p
c3M9ZmFsc2Ugam9iLWlkPWNvbW1pdC1zbmFwMQpFT0YKCndhaXRqb2IgY29tbWl0LXNuYXAxCgpl
Y2hvIC1lICJcbiMjIyMjIyMjIyBDb21taXQgcmVtYWluaW5nIHNuYXBzaG90ICMjIyMjIyMjI1xu
IgoKJFFNUFNIRUxMIC1wICRRTVBTT0NLIDw8RU9GIHwgcW1wX2ZpbHRlcgogICAgYmxvY2stY29t
bWl0IGRldmljZT1zbmFwMiB0b3Atbm9kZT1zbmFwMiBiYXNlLW5vZGU9ZGlzayBhdXRvLWZpbmFs
aXplPXRydWUgYXV0by1kaXNtaXNzPWZhbHNlIGpvYi1pZD1jb21taXQtc25hcDIKRU9GCgp3YWl0
am9iIGNvbW1pdC1zbmFwMgoKZWNobyAtZSAiXG4jIyMjIyMjIyMgUmVtb3ZlIHVubmVlZGVkIHNu
YXBzaG90IG5vZGVzICMjIyMjIyMjI1xuIgoKJFFNUFNIRUxMIC1wICRRTVBTT0NLIDw8RU9GIHwg
cW1wX2ZpbHRlcgogICAgYmxvY2tkZXYtZGVsIG5vZGUtbmFtZT1zbmFwMQogICAgYmxvY2tkZXYt
ZGVsIG5vZGUtbmFtZT1zbmFwMgpFT0YKCmVjaG8gLWUgIlxuIyMjIyMjIyMjIERvbmUhICMjIyMj
IyMjI1xuIgo=

--------------r0jFAlT0We0BpNFBzF0DyGNm--

