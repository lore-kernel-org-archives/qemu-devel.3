Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5190ACD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWKb-0000ho-JY; Fri, 19 Jun 2026 06:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1waWKZ-0000hb-0u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:20:11 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1waWKX-0001AZ-3W
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4/nIBbHZa+jj2ncsurAHg1hi03iBP4k/BIm2exR3GP8dP+V1pZlaPy+2OriCIgpiJS3aKnFfdMBHn3BESaL1VlIIxBXG1FQGnGX/DSTvtUult3SLm1u5eQIzJO9hy/UycMIp+kkBDpuNBKZE+y1mIQl/RtJXbck1LkpFLtNr5TRiJbIEsmq/NEJANwPbSglXxmFR8jOTX5P3/hiFPdyVOiVrc7ih0fAyHqW9IOim89a/Fmg1ELLuuugsYJZLWB0MtWaRswOrAbA2wY5BZiSwyal8P2j11nT7o25YxRfctx9iKVkj36wRfMJVYS4MJsRy3v+K6Orh+dmKUMmdfvr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ng0D78W03+lWysFAYu/D0DvwPG26L5BzGSeG6eZ4d8=;
 b=Paw+xxyCqTUHPuH4SL4f4ZjlM3J+TIfCFwYtP/khHEpz6Ja1Pe69ilTnlgsw1sQWJK9iAhzKTkoyJqE/xuma64hnF1qIFFzePnZLAzLf5gq3OvtS3JKZPMLBm5KhrjM++J32UaiMeQY+fpoSwkYP+UhohLfDGHRbNIzUfecLJNBbLKshaq+0ZZAUucsAzGLPsrCIYgelcjz1cM62Lq1j3O6DaeBg4Ap/f+IQYketNGwvHQu4aJ9P3tkbtgBKnEp69HmUUBeK/XTdjZhOuTb/3ODMPTq5l4GhRQmvY5RPWLAJFh0oolq1vYGcPsfqSx6hpp3/5FO2pnDtCFJ3J+PSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ng0D78W03+lWysFAYu/D0DvwPG26L5BzGSeG6eZ4d8=;
 b=NfFfrbAxikg02YKnIVuA8m7SfSX5OhPr7Z8hRC1ZV0cWihkqUXoIkAxHVgNvlzoZmuLQ5bCJRAJx8TadBEc215ByyYsUuJOY+l2DcvuCrNZrjrJDAnF7YbyrpzdcxxE0rsgv7NAvEPQprJZzdQ5YferkHMMCYWfVCFZtZdMETVj2rbYzXnqswwmprjpNjJcTKLuIklw91dsTLY/j7F1n79pddS45bV6tGMB3l3WogTVeKnRuQ6cIUgC3qYrS0Q7h59qD/09e3f0BvoAxeU11rwQLrZtDNUOa5wAl6AX0xUBsgPIzwE4m60s0L82/CEGtZZAxlflr16J/oo3c6jSbHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB11610.eurprd08.prod.outlook.com (2603:10a6:150:326::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 10:20:01 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 10:20:01 +0000
Message-ID: <7dae7b6b-202b-4123-ad50-3eacda07b5f9@virtuozzo.com>
Date: Fri, 19 Jun 2026 12:20:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dump: enhance win_dump_available to report properly
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>
References: <20250911123656.413160-1-nikolai.barybin@virtuozzo.com>
 <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
 <CAMxuvaysfdUSQyuzPpXMLRRxKsHjkjYV48S8L_HSWtWmn4ysXA@mail.gmail.com>
 <CAJ+F1C+sYiFKRHKz7Zzqe+=K-_aOa6ZzT4=buo3jTV+f714SqA@mail.gmail.com>
 <9bef9acb-3153-4ef8-b3c6-6ff6303336f5@virtuozzo.com>
 <aiL07TJlvZM8-ZAk@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aiL07TJlvZM8-ZAk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0152.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB11610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3b9488-53c4-413a-0140-08decdec5263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|22082099003|18002099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: InejQrq3TQQnOLbJs8tSyqdYsluZpoQxTmvqXu23AJadedFDQHWvnZUVz4wGk7m3kTSM6+s7DdZyqqqjuk9w+MM36bb7PWFenQUBbs6xz41/sC9ay5rGnYPqAwRUJKBsOAbKynKTVHardKndb3Zia8NCnEfxA6KMqNMOObx6vL8ghwR8QswsAP/wNoOYHaCkwK404Bz6ar+uDjhEMrsjw5dyBKREk/ANyh8v10diZH8s+/w2Ziccer0psj9k/qhnA5FsfryQV1q5thUeLusNlzLOd2/mDV7JOz04iF9Dxl1WnmOPVy1nwPMNIRIOzeURSXoKwOEiUkbx034dxuQIl7bfSmvBHQsRo02B0Z31vV6u5+3fx/0x2+v0y1KsBax0iWbhcB9PfG0GjdSN3zf7FGba0LaxTZMnDLr0jzRmkbPEibk9Jz6HLwqHoGBoM79cnFoT4fD5QfnjMFYACXfFcpxaW/TMXGRqg7ZGOcx40XFlDTZZyHR2jsxm/6W8XLLsDALULPPwaLB73PvnWkb9pvb7MJNRAoMw6BumFN+DXj4cAYnLf2Gp1l6azPlVb8vYew5Z4+YIYtyEZ33ZlbQQvoOxnuoqchR/OUFdc1z3/VqNPi+Dj8I4Sxqrk9VbI+kX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1o4YzQxaFZrOGFUaVl4eGljTGhBeE9ZOFVMYnlZU2NUaXc5SmpFRkovN1Vu?=
 =?utf-8?B?c3l6Rkp4QW0xRG5rSFpjbWp2YXZlbWNWdHlyYndlenc1NlFIUGxZSGIzTTlM?=
 =?utf-8?B?OEJOVm5GYzU3RGU2NFArdkZneTRMTXNvb0creXllQmZGKzI4M2QrMGQ0K1F5?=
 =?utf-8?B?SHdTMWZKRzFlN0QySWZZSzE5ai9Yd0JQNGtwL1VjeXJmcERQcEF2aXRzc0My?=
 =?utf-8?B?Mzh6VCtydmNYY1k0bWE3RmtwMm1UWDNQc3g4MGRFNFpqdTVKTVJvUHJKdXhq?=
 =?utf-8?B?L1A2QjFYOHBLRGQ1UmllbGJZK0lGNUtqN21iR2FwblVRTGRPbWRISjlsWU1U?=
 =?utf-8?B?c0I3MUxIcFJJaHI2akVSbkt2SGNZVzZEb3pFTllSbUNaREtxVHViaUkzZmVO?=
 =?utf-8?B?WmxyOEZsb0lpZzQ5VVBKOGg4b3JSRUVMZHNJdkpvQnlUMW80STRHYXpLR2hN?=
 =?utf-8?B?MnNMdlI3Tis5QVprSGpQMStacDNJbUhldHg1WnFUZVhpcWFpandMRGwzejU2?=
 =?utf-8?B?NEJJaVNaMlNoTmVTWlF0Mkx1enlJNnpHdDROaXFPZDY2bmhhK1VQQjRCVDJL?=
 =?utf-8?B?WllEekMyQ09kVlZxamRva3dPUkVid0p2UnV1RVR3NDJuek1MdHluK2t3eExS?=
 =?utf-8?B?Y3k3TDg4N2ZqMU94ZzFUZ3M5UHpaSXV0eEE5Y2JWYjdzQVdwRFVCelp5OTVu?=
 =?utf-8?B?Ky9kUGNUS2FLOVRYcytZYmF4MFIzVEFmdEpqR2R2VHQ0aTk2WG9Ic2V5REYy?=
 =?utf-8?B?bUhrbHcrUTlHdmtGeUxORFZWSC8xTm9iQWNQclExdzlxTWpyaVNpNGY2RHlt?=
 =?utf-8?B?Y1FFbjJ3N3VkVS9KcFFNVnVTbG9CS2RBMDdPbkxPY0dCTmtJWUd1WFBReVU2?=
 =?utf-8?B?MGlLcFdqcnJHVmVYRmEvMzRhSmNJbjdSWC9OY3h3cnkxY01pNm5wNVppT0kr?=
 =?utf-8?B?V3dsNkI4ZVRoK2NwMGNCNVNucDZUcnlHWjUrNTdJRUNYYWdXNnpiUklYUmNv?=
 =?utf-8?B?Q3lRZElJckJ3cjQxQjZhRDlzaVBkYjB0N21qRXlGRlBVS0ppYzlubStDRHc0?=
 =?utf-8?B?bEZCY3B0OW1YamJKQWk1T2o1ZUZuVk03VEtzemxFWTFuTnN2TmQyOFBIaEE0?=
 =?utf-8?B?Wko3cnZVa2NWaEhtcjNYNmZnZlFudm1KTVpYRWM1NlpmSDRRNVVRUWpjclZB?=
 =?utf-8?B?UG55WVdlMHlWQzhUeFRwakdOaTZ1YzlucW4yZGZNRnU5K0JVSk5EVlFoRUxE?=
 =?utf-8?B?ZjZub216ejd5cEV3QkJIb25yOTBXUzVpU08zdWIwcDNhVUZXWE9UN0d5cEhz?=
 =?utf-8?B?MFNDRFN2V0RDSE8xRlVNM2kyWmRTOUFDZDVlbXVxUklmOVZYcUlGVGM5bW9S?=
 =?utf-8?B?TGhUNlhZQnJvaGwvUExHOVBYK3JPaytBdnY0NmhDQk8yeEJWWTlGODVpd0M1?=
 =?utf-8?B?NVk2bW1DQkxrMHh0dnpnbEZZWmxaOEVrUEExRnVZQzdpRTdxMCtmUm82NURC?=
 =?utf-8?B?eDVHZzFmMUcwYWRJL0N3dGRpYlNlZFpNakZNeWNzUkR6UFBKTGdmQUNDZk9E?=
 =?utf-8?B?VmlTL1MySWcxL1JMZ3NoZms2b2dMK2hsTDhKaXVITFArdE14dURBclZBSER0?=
 =?utf-8?B?cVdjK1IwV01HbDVub0RFVENsTGtCZ29FQjNIQWp1VTZQRDM3blZEMEY0Vmgv?=
 =?utf-8?B?dGxnOTdiVldtYXp5ckRMeDhHSlN0Y083MkNicUlQTFJNanB5ZGxURU9tc0R5?=
 =?utf-8?B?bnBOUGI4YzhvdEFQT01RY1MxcW43aG9VMTRnbEZkb0dOb0xxTzc4eHF1c1la?=
 =?utf-8?B?dHBFVlhMQkRLR05mWHh2RFNpSW1tSW9ubXdXVHFwZ3BVaUlOSkcvLzVoRFJD?=
 =?utf-8?B?ZnRjYTJYNjRjbk93eEx4N21TTHdzeGtJSitrM3lhTmp0bUp0OEFubGNvNmZj?=
 =?utf-8?B?WW05S1RYditHNWlYaWRuV0NneTI2MVpRakJ0Rks0bVhNVFliR3N4MU81Sk9x?=
 =?utf-8?B?L003UVFmcEM3Ty9hSlltT3grZkRJVFZGZVEvWFNWaThNclVFU3hYMjh6UXU1?=
 =?utf-8?B?emxWdWpBOEVtRTVUcGh1alA2dVR4eExjSWJETmJ3WUxHV0VEOS9oM1pXWXJu?=
 =?utf-8?B?UmFsaHJqMC94VU5vZDA2R2xTWE9CckIvR0JZWklTbE1rRFlSVnZUYUFPa3hX?=
 =?utf-8?B?ajZCZWhOeHpmM1RNZGw3QS9XYmFIMWg2dlYySlNzTjUwRG5zbEtnL2UrNElt?=
 =?utf-8?B?a0YvdHBpQXl3WUxiZlpMbFoyeHNnZTFuMlYwQVBibjFBaGhWNHVERXprTWtL?=
 =?utf-8?B?UzJNV0FZOTdFS2pMeEV0WDRmWkNjRmU0SG1OWDFPWnFWQ0FZN0hqWmxPaHlj?=
 =?utf-8?Q?Dt9K2Vt3onLPzH+l1EBSUOzjkaPWcIJXm/d1NbXekkIoN?=
X-MS-Exchange-AntiSpam-MessageData-1: Y/5lBe6/wud/Rg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3b9488-53c4-413a-0140-08decdec5263
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 10:20:01.4680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeKsv94bYQvsaX+8Bgx7QojO7u/6SFZIwA0LUioXhfflIRyUKj1xshM7BQLm5SPF0IFEDcYShAr8EJmIpobBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11610
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 6/5/26 18:10, Daniel P. Berrangé wrote:
> On Thu, Jan 08, 2026 at 10:30:29AM +0100, Denis V. Lunev wrote:
>> On 1/8/26 09:11, Marc-André Lureau wrote:
>>> Hi Nikolai
>>>
>>> On Wed, Sep 24, 2025 at 12:30 PM Marc-André Lureau
>>> <marcandre.lureau@redhat.com> wrote:
>>>> Hi
>>>>
>>>> On Thu, Sep 11, 2025 at 4:37 PM Nikolai Barybin <nikolai.barybin@virtuozzo.com> wrote:
>>>>> QMP query-dump-guest-memory-capability reports win dump as available for
>>>>> any x86 VM, which is false.
>>>>>
>>>>> This patch implements proper query of vmcoreinfo and calculation of
>>>>> guest note size. Based on that we can surely report whether win dump
>>>>> available or not.
>>>>>
>>>>> To perform this I suggest to split dump_init() into dump_preinit() and
>>>>> dump_init_complete() to avoid exausting copypaste in
>>>>> win_dump_available().
>>>>>
>>>>> For further reference one may review this libvirt discussion:
>>>>> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
>>>>> [PATCH 0/4] Allow xml-configured coredump format on VM crash
>>>>>
>>>>> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Have you looked at my review & updated the patches? thanks
>> I will send updated version next week after vacation. Nikolai has
>> left Virtuozzo.
>>
>> Thank you for the reminder and best regards,
> I don't recall seeing a followup v5 for this ? Were you still
> interested in progressing this work ?
>
> With regards,
> Daniel
Finally just sent a new series with much cleaner approach.
We do not need to do heavy lifting with dump start simulation.

Den

