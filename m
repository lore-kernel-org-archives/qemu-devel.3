Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FBAC55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpQVw-0000m5-Ki; Thu, 30 Jul 2026 09:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpQVu-0000lt-Mm; Thu, 30 Jul 2026 09:09:30 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpQVs-0001Un-S0; Thu, 30 Jul 2026 09:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK44qQ97BG1p4cv2la1HIKZnzm+aT2XTlExjXgIWrRc5M1ny1TIQTBhg8DvU5YMGmRiVjIG9KCVwZBuRRhe/wFWmI35oo4JAhSZYlQ7MdrOPf+++E9y7mvVDKPh3gANDAS3lGetT3mOzigYWJ79Q8DtItAdKaxZ6bO7aLwPyGMLsQBk7rgRoEfpFXeZi8Sn7m4BqxuQTRE5fB3aKdqUq9ta4Pe4kVa8UeH0o8xCswCs09SzAyHUVltZsiqlZJynoVri16CRqIY6ESMRnfQkA8zEnBILmT4zbQJGQ+rGKEjuuIOYY9jb1DtkUK11h2LgWIPr+C2lh47IgfSCgGINS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTm8tbUl4Q2gleO/d+Ge+M2CY8kkWX4RHPCpPqPq7W0=;
 b=TaHpewev+SExDB5AjSG9y5fZqOOibhSIfIyJLg8TwfAcG3yEYADLa1hdP6wZ6MZBodW1dnmulC/vFR+UmbFE2ocNHnPP9qZdUDwUBAvbQFFJRCWFKY0CHV8NPUbwcoOmZxXJtm+1zn6U44CdSaiGsD3ajhfAEq/fWDGIVayt5U0hNqnaq7LnFEFc+5CBA+vxUSzmNjWmVRkzhq5As9xw/qdWI6RWNL9tBdg5SRq74CyWO8BL/tYLYNK4L9ILvMqn9VCrmkWXDpotgP1RCVhTVBrymoX+POPYRHslNJssKswRUuzk+ij/18L/nZQtDcYLvK4LQR/3s2SyubuX95LZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTm8tbUl4Q2gleO/d+Ge+M2CY8kkWX4RHPCpPqPq7W0=;
 b=qqZ6ZJfq7a8sZ16bRI1w8uFMHKBDowVdTWXb3KSLzki3y+rzMEf6jcWzgEBo6KeMwoCR8dnBTRGcKWvjD8PcjYCuKwNP8uU2uzMzlqWBajtjs2nYvJNIxJfUNsOYoYzSoaUCRsOlJsEnbwwbicB3jjqNnB3Ie9jEe7JQFN/gDhszs+KZ7+zuoxh/lwUgmEOtBmL33GEVlUtLJnlDtjss2K3oJmQ8g8nDOHzgDPn+Zkkequl/jWu/fkqmWUYH8obCpzt0+x49C0IOCOJDj2Y88SyBIcNl274QW7fqJWHnXznY2psFDNrErR1ARfzW9AASon0PsQTgHUhRPG0DUyb7WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB10319.eurprd08.prod.outlook.com (2603:10a6:102:332::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:09:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:09:15 +0000
Message-ID: <e76747a8-7d99-4c06-ad58-865ed92cbb86@virtuozzo.com>
Date: Thu, 30 Jul 2026 15:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
References: <20260630104249.2533126-1-peter.maydell@linaro.org>
 <CAFEAcA8J6-QbqAT-=kfEx2mAvkMucGJiyWC0_zMmVeSrmQw9Jw@mail.gmail.com>
 <CAFEAcA_cGNhZ5JB3-13YXhptYknwiwERQDOS6RMfH17voorgeQ@mail.gmail.com>
 <878q6sbpdr.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <878q6sbpdr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0106.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::7) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: f8400609-6b4b-40f8-76d1-08deee3bc1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|376014|56012099006|3023799007|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MADOK6QErTYfyUzdL1RkOGo+Guyhs5mHgnEiOW0/TGicPTE0eQK9uw+EV/PFiris/o51GglsLvaj+zW0CKZeV33FOr++/P3t80eQj/FUMEe6/n0SoSCj0ZNQ4qAycppTtkhYA31AadXs/8CECZtZOiZeFb/2VXkJAheen6LLjiAeNGyci3wORxkxB1x9q/9K8iAPb0hJfwg1muVatz7Ro8G6PoBQkqgWgDEiOSF+pKQpX+q0CVGTFAqepTfG2ouNQrF/8+ccV+cKz4z1Ysbmc49pzK+Am3QJ9SDkGAvxoBZvZ/ZTwu6JJThlLLttdcYGzJ+04pU6JGZFsdkmWlJpTNTD5ObNfaHC/v/hTwiDITHxtegrONzfrWTRg7rk8I0tRu6cx3a/mXI6CjYa0HMxJP0OgxGY+HGmM0V7DEXdgE2t27PxmaYvU2QU1KwhBstAjaxh7uTnAhokaXoovVYKsmtO8sIJ6yxk6RUAVyXZnrwT01fIjQ/3F6VoKP9b9AKNyaXYTTA5bBYDWhr+nmI0OB7+j5dAnZBmXIcQ5G+4rY7Nx8wqi45/6TQhZJayDkBQRxejKeu5kpRIP8bm7wLO1g4cBvuNos3P/o7GqHGKadNZlNljLleMDymAfIZTRD7PLsGZfgdy8a1jZ/rnf2KWmUOETp0B9YhOqqStuVeYNFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(56012099006)(3023799007)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hFaUN3NkJES2dPWFJuSU90SXJFMStURk1wV0pBaHlWQzRSNVZuM21NMlFy?=
 =?utf-8?B?ZzE1UldkMUdPVFgyNFhaekpkdlpKOG0zOFVwYnZZVWNiWmhWM2hBdUNrV1Zk?=
 =?utf-8?B?bDVOektIelY3dWg3dS9FczJ4Smpwby9BOFk3aWI4eTdsQkFRcTV0amh4RFpu?=
 =?utf-8?B?ZjFRSmgzZjVDb0hUVjQ5dm9ncnhTQ3MrNHNSV2FObW1YLzBLSGVZa0UxRjg3?=
 =?utf-8?B?VVI0eTJqbGl4QmtxK2VRWCtWYWsyYXh4d3dHTC9ZYzAwSmFhaE1lQk9wRkw2?=
 =?utf-8?B?Z2t2YlJIWHRhVjJ3K1FKaVF4WVNNUGgwSWJEWWNyU2c0citFUk1GZDNCbitn?=
 =?utf-8?B?djA5MDRadVp3OE1NNnVlcjRzcmZybk1lU3lWQnpLYmVMN3JZLzZPemloeGYr?=
 =?utf-8?B?QWFVaHF3REFiQ3h5LzdrbDJTTjBpdDVGam9lODlxY2FvLzVVWldPc2ZQcHRU?=
 =?utf-8?B?ZnFSaG9zWkZhVCtORU4reWhhaHhTZzB6Z25mM3N0SU5IM1d6aFU4a25Pcm95?=
 =?utf-8?B?aWt1WmptYW5nb3dLcGJ6eHMxQ3NONG9pVUxBNDRKVFBhS3NRdjVjcFBmOS9k?=
 =?utf-8?B?b1dvTDZMeURNQTNjTzdzbzR1cXpkdjM3ZGc0Tkg4YjFTbGJZcHFDYkFQZE5m?=
 =?utf-8?B?M2dBQzFabFBGZVdMQ2QvWFRGQ1lhZGpFb2xNMXhqR2M5UHJyaTc3SFROSjJM?=
 =?utf-8?B?cFFxSXkvWFFuUG9xd1JzeURlREZkd0EwRHFUY3BhdTYyK0dmVXVXOTdMYURQ?=
 =?utf-8?B?MkxMMGI3dWtoSTN3WGUzQ0VZL1NmeVlReDRYY2RVSFdRK0JQK0xnRzRvNVJr?=
 =?utf-8?B?ckszMnNxMDZHS2VUdUplM25YcFVnZnorQVhxcUQwSW8xZm13Uk5BeUw0dm1y?=
 =?utf-8?B?ZmpxNFdHd2xseXFBT3NrcVRWVjVxcHhYRGJrR3h6SExNdlRjZk9BUHlhc0dF?=
 =?utf-8?B?ZXF0Z2JsVlg1RWMxd1RtK2FRZ3dJeFVRUTF0dzIxRFFIa2h5RitDU21sUlgv?=
 =?utf-8?B?dFlUUlM5aTFyajcyQ2FuNnVWdmV1R25vUkUxTmxyMWF2SytJeHZQUEdyRkFX?=
 =?utf-8?B?Y2Nvc1ppOU9ieEtRNUhTNnZ2SHcxUDhVMG1RK3FQZ2Fxc015YWtwUys0UkVO?=
 =?utf-8?B?ZGJxMGpZMWE5TlYyODFqdmJtU0pJTnVWOU8vMWpPMjZwTFA0MXhhWnV4aUtE?=
 =?utf-8?B?T1p1eEZYeDJPbjgvM3A0alhrV1JOMERLM1ByYmN6dHlJSW9RaTlvbndDOVVp?=
 =?utf-8?B?TlVBM012U3Zpc3EzNHpQZk5LRHV1dUo1U1hDTm9Hd0dGeDc2bDM1Tmh0TEdH?=
 =?utf-8?B?TEVjck9GakZBVHh0dWQ2bUZqUUlTR0ptVnpSMW15TGFLVHl2UkRucCtrc1FC?=
 =?utf-8?B?c2FZVm5uejNmUlREcGR4RmQzTTBIdHk3ZmNCdEwwM1R5Y2szTWJIQjZNUWdH?=
 =?utf-8?B?bmRaUjg5d0kyRFZuczFGb280RlIya05vQkVzdk4wbWIxMnpmUWx6K0lwR3Rw?=
 =?utf-8?B?SFhPd1NlMnM5K1BvbEd5N1NFWHV2STZTOGllVTAwNnpsVDZ3aldDU2crU1B5?=
 =?utf-8?B?N0tBNmJjZnV1N3NqbDB1OHc1cCtwY0FHT1l6SUNGc3A0eEFXN1Y3a0pnaytz?=
 =?utf-8?B?YUpNQ01yUjljSWkxT1hwbUIrclpiU3ZiZjUya0ZvUi9yeVFrN3JacEQ5OXNn?=
 =?utf-8?B?anN0VFJwR1IrRWRrdUc5c05KcWRpWlh6NDhFVUtoc0tiejJsUHNFa0JHNnRD?=
 =?utf-8?B?ZDBTNUZCMWJXSXArRzgxdU95WDZPcVJHOGZTSmdlc1l2VU1OckRYckhzeWY3?=
 =?utf-8?B?TmEzWlRTMTZKOWxlRHYvNE03YTRLUk0xamlLV3NEUTBndWVsSHNsa3hkNk1o?=
 =?utf-8?B?bUVZbFJFU3o0amUwMFlsVnhkbTIwNVJWOUJEQW1EK1VLdFlHVHE5S1VSbHV3?=
 =?utf-8?B?N05DMHZaYmxpOXB1Nnd3cHB2M1FzNUg0eWVHZWlGTi8vbC9IYm8wYmVXWTR0?=
 =?utf-8?B?OHkvam44U3FoT3ZjdnlnWDJQbE52UVowUDBlUFhiR2RoVWZXN05DekhWUk1Q?=
 =?utf-8?B?TWdKVVV0cWgyOG9NY21wMktIbUxSdnNPaHhJQWVYclBhUzBIK0hlakx4M3Jv?=
 =?utf-8?B?WXIrd2diRUp3MllMc1NTVFVnclQzcjlQT0cyRlFJTldDbkx0OGlyUk40bDVo?=
 =?utf-8?B?dTVpYllHdVl0S1lObi96VE1DVUZJRmdNMDNvRHpHMnhuaktxL3htZ1hRUkJX?=
 =?utf-8?B?bG1EaGpJRnBOMmZFSVVWcFZKRnRDOXFJdzJwSjEyMEhydVNnVGgvOTZodHpH?=
 =?utf-8?B?Wlh2Vm5tNVVZVkxrT3UzV1M3ekNXcnA1dy90OEw3bTNwdkJHYU9NUEE1QzhO?=
 =?utf-8?Q?xIvYPE8QZ7C6cO1E8nrHJu/fM7sKcaePNnje5X9knsTM5?=
X-MS-Exchange-AntiSpam-MessageData-1: 0CCyC/U6Hht/jw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8400609-6b4b-40f8-76d1-08deee3bc1a4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:09:15.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUGN8dweE65ClXMhUuH121J2uogh59V3ojd3NBiM768koQ+Dg2eLoE8msF+vc46Mgn7u0Syiae5WcY9dPmkamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10319
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Sure. Thanks.

Please let me know if we have something else stalled.

Den

On 7/30/26 15:04, Markus Armbruster wrote:
> Denis, would you be interested?
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Ping^2 ?
>>
>> thanks
>> -- PMM
>>
>> On Mon, 20 Jul 2026 at 09:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> Ping -- would anybody on the qemu-block side like to review this?
>>>
>>> thanks
>>> -- PMM
>>>
>>> On Tue, 30 Jun 2026 at 11:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> In ide_set_sector() if we're using CHS addressing the way we update
>>>> the drive state involves dividing by (s->heads * s->sectors).  These
>>>> values can be set by the guest using the INITIALIZE DRIVE PARAMETERS
>>>> command, which means that s->sectors can be 0.  (s->heads can't be 0
>>>> because the command passes a heads-1 value.) INITIALIZE DRIVE
>>>> PARAMETERS is specified to not check the input values for validity;
>>>> instead no error is posted until some other command makes an illegal
>>>> access. So we have to cope with a 0 divisor here.
>>>>
>>>> Special-case s->sectors being zero.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2399
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>> We don't seem to ever actually check that the guest's read/write ops
>>>> are within the CHS limits it sets with INITIALIZE DRIVE PARAMETERS --
>>>> ide_sect_range_ok() only checks against the underlying block device
>>>> geometry.  Maybe we should?  Then a zero-sectors misconfig would
>>>> result in our reporting the error on the read/write as the spec
>>>> suggests we should.  This patch fixes the division-by-zero, at least,
>>>> though.
>>>> ---
>>>>  hw/ide/core.c | 28 +++++++++++++++++++++-------
>>>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>> index f78b00220b..b030531534 100644
>>>> --- a/hw/ide/core.c
>>>> +++ b/hw/ide/core.c
>>>> @@ -646,13 +646,27 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
>>>>          }
>>>>      } else {
>>>>          /* CHS */
>>>> -        cyl = sector_num / (s->heads * s->sectors);
>>>> -        r = sector_num % (s->heads * s->sectors);
>>>> -        s->hcyl = cyl >> 8;
>>>> -        s->lcyl = cyl;
>>>> -        s->select = (s->select & ~(ATA_DEV_HS)) |
>>>> -            ((r / s->sectors) & (ATA_DEV_HS));
>>>> -        s->sector = (r % s->sectors) + 1;
>>>> +        if (s->sectors == 0) {
>>>> +            /*
>>>> +             * s->sectors is under guest control via INITIALIZE DRIVE
>>>> +             * PARAMETERS and can be 0; this is an error but can't
>>>> +             * be reported at INITIALIZE DRIVE PARAMETERS time so we
>>>> +             * have to cope with the bad value here.
>>>> +             * (s->heads is always at least 1.)
>>>> +             */
>>>> +            s->hcyl = 0;
>>>> +            s->lcyl = 0;
>>>> +            s->select = s->select & ~(ATA_DEV_HS);
>>>> +            s->sector = 1;
>>>> +        } else {
>>>> +            cyl = sector_num / (s->heads * s->sectors);
>>>> +            r = sector_num % (s->heads * s->sectors);
>>>> +            s->hcyl = cyl >> 8;
>>>> +            s->lcyl = cyl;
>>>> +            s->select = (s->select & ~(ATA_DEV_HS)) |
>>>> +                ((r / s->sectors) & (ATA_DEV_HS));
>>>> +            s->sector = (r % s->sectors) + 1;
>>>> +        }
>>>>      }
>>>>  }


