Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407BCCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvfc-0000ge-A1; Wed, 30 Sep 2026 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBvfX-0000gJ-JT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:52:29 -0400
Received: from mail-westeuropeazon11020140.outbound.protection.outlook.com
 ([52.101.69.140] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBvfQ-0006UK-8z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma9+FfDkMYvGo+ljlQNQcyU3bthHCyzxf83Wa8VhAVeqaPWiypdWVa0APBst/ZuuNZcgR/KwmLEzK1SaSQBx5iU0TpWgftjrCW/I6WD62v3hl7Mf5x2ArDRIDKktQ4djhHsrNvxmAEsY72V8LT1c+Dff4xkcXfmalX272uU1KZO/GklM+8TjUN6hbIGmxi3EydOgjJdwf2d6sR7f5DFhvVRYqw0IHkVtvgmgXBl9YIt2WoNR0ZBOFy7GSV4uLehdwCJEqbgThFSLDYjLDtHi8yGHy1C2KIv04qsmm2MRjzCGepTpQmVHHgHq0WGqjwTL73pdU95URJE2yGaPHm44ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHoy90+FRIiri6yxqQiB5EtvAKEPjH6eNnTg78MUe1Y=;
 b=ekKm80yjRsvLdpFhf+vV8PncjF1CGDTM18VLbq7lJW0pMEzV2Kop5wMTzmdNfC4OXhwLYCf08vvyv/jHXGDmWtgNWRHv7FkYS9+9wH93U7IF2urq0qxDLpv+CJjhsGHCJmS8CvbGpoyGQHC0F0+abbgEFtN7IqxiU6EDfNwbyESLxDgaRjiueNCHFZ3lDkfn2qcJkYKE7XrkbrAcE00LWBYrqARHq257BXVc0hIi8FCsPi+f9KpTXXvV1CXbvM6o/c9Sn66drWOqud++aK6IBefEwF8tSK9Ll+mRyzmBq4NxCj+K7b79d4euXI0WYhcSdDTwWfWfTKs4HMELmgnLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHoy90+FRIiri6yxqQiB5EtvAKEPjH6eNnTg78MUe1Y=;
 b=ho8INeYerN0NfZPls5e3o+CsID6ldxIOZywKCv1HwGlNuW0WgkF95JrB9t7aSMpOLT6gaYvNk+XuWl4juHRDGFMFq7cYobHI9PQI1Ur39Yaq2iK/Q4LgDJfrWAssSpW8ehXPFEL6FjBCaUpsQapmZd5ktRygnZJ9WFfJc2q+L3od+wyGIg5S8/9F8XvqoHsmMlpuMG0uoVQj68A4EVXAvSE4SUWiES+fWTv/9XXBEi2YQeQnNULsy9dPzU5Roajsqc3smjfnZbF14qEwLOIKdssWhhazJl6LCxQuq/Z3SOsA3PEF2YtOKoioIVnVdk8XLmowIAsbxuIfF1TrQSFkvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB384561.eurprd08.prod.outlook.com
 (2603:10a6:290:90::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 14:47:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 14:47:13 +0000
Message-ID: <303b3f73-b263-492e-ab17-a0e2c49b3f09@virtuozzo.com>
Date: Wed, 30 Sep 2026 17:47:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/18] vhost: release ownership if vhost_dev_init()
 fails after SET_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, mst@redhat.com,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, bchaney@akamai.com,
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, farosas@suse.de,
 mark.kanda@oracle.com, dwmw2@infradead.org, peterx@redhat.com,
 vsementsov@yandex-team.ru, den@openvz.org
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
 <20260930-up-vsock-vhost-v5-v9-15-e9096f629770@virtuozzo.com>
 <arziIHF39t15dVoc@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arziIHF39t15dVoc@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB384561:EE_
X-MS-Office365-Filtering-Correlation-Id: dd13f2e8-e63f-4e26-dffb-08df1f01b6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tWaddCu9LfVd8xtagaB+3BucHTPfXWAPzwPZRCVXN8m0b+cA0g/tZ1ZrBotRWYNBvOqxfj9U9Kwz4jN+qZjPJI/gUpByqA/PvnU5iR6QSHrTeYlpvQvSOnnyhBd3fIPpcVdNG0I86MesTboDPYWEAq9bj84hGhQTB4xQdZRgFl7zXvVqrFnu3aJ4Eqr3ztisDYEyTaPL/sfIzPmeKeY6eqjDgp3DTrq4w2XmEsA74E7ZFJqAL6NLiq/LIok3CnT93gpPH3UbpYBpt2fdzaj+lnMmsiU+b5u81sx1Ujgwpvm2MGPwI+zDUmpyajsUc1Opv2eJMV9D0C3jfeNNV9Kz3ZLW3o+sXIexPLO9SIRkh/PLe0+Q+Dm7JHbJ2dT5EHyGcJDuch4gcsR8NKhzpfrkBthA28V3q7tUC50d7MzUpN35YCXEoImtWEBZkyTiWHW7CM/wlmnTJ0ZFa+Su03iVrseb1L4mfQcI0NxJc2yoHnG3C7WGXAGcCRisznAXoe43qE2eCcEUEMeI1BXHi0J3YYnmHcp69gxFsegYhtvoyUn2zunzDXWYjqbB/cM5g+BCKR/3VTG8bT8g2Fog5c2/bED34tdAe2D5L3iSNmUTIH1XTx1FOvdDWeFZibjcNAaPmy5Kl2/n42bh4LcFlwmVB70JBIjdZGL5NXM026DinDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDRxa0l0VkdqWUc4MHJaNmFsUjdTRlIvMlIyTjJlbmx4alVmTFphVlNyU1ZU?=
 =?utf-8?B?aU1KOTNqdWhvYTluSlZheVluL3ZTM1pZZ240WUpGQklKbEU0cWVhZ1FvMlhN?=
 =?utf-8?B?Qm9qRDU0QWVlM25kanl0di9JQ2QrTjRvSUNiVzI5N2gweFQraitNT1N0MndN?=
 =?utf-8?B?Yk41YlRFc1lDYzkrKzMxa0hhQXZCSS9oVlpGWWVVUml6dE1HdWZHSFZ4cTMv?=
 =?utf-8?B?VFR2cTNNb2xSTXVIVEFZaWRwWTgvMU5LdzgxdHlKckJERlM4SmE2dnBNcENI?=
 =?utf-8?B?cW8zSE0vWmIzazd6SE41dmtzVnUwOTdnNVVraXFHZlEyYnVqWjZBWEZqMlRS?=
 =?utf-8?B?V3plTjBQTTBRZlBiblVMSjQ1b3hMWFg5K0RId1hRZTBFYjhvc3BRMi9IWG50?=
 =?utf-8?B?aWpoOEhJV3luQys3cHlNYzF3VGREc3JPbzF2THR3TXYrcHY1akJkQW1nb2dh?=
 =?utf-8?B?Sm4xUjEvcDZBb1JKejArcmN3Y0d2OUthWk1jSWlVOVhvNG5wdnE3Y3UwU1BS?=
 =?utf-8?B?U1dhUEU2U09EUTA1anhycktObVE5N1V0MERRK0N4bDB5U1VvSkxqTXNGNDFr?=
 =?utf-8?B?Q1l1SGFOTGEyLzlDbWQ3N2tHOXI0UVFoNi81MWFSRy9vR3ZxcmZ2R3RvS1ZL?=
 =?utf-8?B?cVNEemZBQ1d4RkxLVm1NdGhtUUFQa1hhUDJ6MWNnTXF5Y3dPRVQrNk5DUUI4?=
 =?utf-8?B?bjJMTWlnYkpiNVBJSlZQMGFvOEw1b0svekVSUTExTWVqeXJJcVlLNGVxb2cy?=
 =?utf-8?B?aXpKNEJKNkRwWDFpOTdKUzNKeWhDSDlNRTFnMGh0RWlMcTZjSkZ4VlU1dWY1?=
 =?utf-8?B?SUZselhBMHRoZUVxUE0rMk13RmVWaS9CWFljMzIvVDkyb3gxaTBRdkgwRUJF?=
 =?utf-8?B?czRCVERlc29ZVlAxc0w4VjhpUzlzVFEzMFpXdU1hMHNxNHFmTFpBaEFqYVlW?=
 =?utf-8?B?YWNQVlFLN3pvWG1ZOXBESXVpbmZ3VXh4cVdJSEQ4bGdQQ2FiL210Z1FNOWRS?=
 =?utf-8?B?NGFpOWZMWTRKSUN4dDlaaDVxeE01YW5WbVdVZTRIWVBBVzdjd3pveEdmYnZv?=
 =?utf-8?B?SG14dmFsWTRHTUdIQW0zRTRQaWJSS3d5WHUxcnZHOVhNekdGQ01qWThidTQv?=
 =?utf-8?B?UG5RY0NPSmwrV0pBL0diWUlLQWd6bFFyVGJxOURTWjVKSGw3ck5CWU13U2xs?=
 =?utf-8?B?R1UrUHNkMU1vaGZVc0FrUGlteWt5cC9qb3FlYUJJNy9yUTN2aVNjeGRESGtB?=
 =?utf-8?B?TlJJUitTTzNkMW1sc3hERkZTOU9xYjhORWVEaXJDOUNBRVlGeE1IYUd0L0Mr?=
 =?utf-8?B?SlNBSDAvMmFWTXY5MUFoT2t0dU9qV2JZUms2Rzd1V21QaWU0V1F4YzdIbzg5?=
 =?utf-8?B?K2lVSFVpSjZ5TDVHWURLRW5pa2pMZ2RwZ3d0N0hicDMvVERPdDVRYzB6NExL?=
 =?utf-8?B?SHBqMHJlcXBaeHZjRDdHdXMzbDc5SnlRNURQQUFsNmkwSVBSMmVTN2hSMzRZ?=
 =?utf-8?B?dXZhSEwxenVXNzJoOGVDRnRXa0xxMkNSdzZhSnVBNHFKRHlSMFlCbnMyU091?=
 =?utf-8?B?WnVpRmJ4RG9lR1NuTXFTZFhQWGs2bkR3MDVONWZySXlaMndGSFI1SWIxbUlT?=
 =?utf-8?B?elRaVmNJU3FGcVdZaTdNZHNpRGFXM1d6WUtSMFZ6WGxDSmlxOGZpZjhPQVhp?=
 =?utf-8?B?ZDB5Y1NLU1UydnFHNlUxd1NEZ3ZMeHQ5Zm4xVm9QL2UwbVlzRFNjUlFJaW1U?=
 =?utf-8?B?UHJEZWRhRm5WcEtkVG9qTk5lYWFyeHJrOElGcVk5QmlMeWt1Wnhka2RnZDVm?=
 =?utf-8?B?NUtmSi9Nd0liTTRrRkF0WGt5V0ZiUSt1cU80d1JRbkNUV2t0b2ZBVVVyRXJE?=
 =?utf-8?B?dWI2dW14K2w3N2RnUy85ZEVUUmMyUzBneVNJMXBaNjZidENSWHowbXRoNVFX?=
 =?utf-8?B?R05YbjhwWkR3bTNPRGRpclUvUUszVXJvd09vcTdLL1kvcWJ1UVhNNEVVcFZW?=
 =?utf-8?B?a3JOUEQ3eTNEYWdHMHJNUmwxYjZ6cnhTVUtvN0xHZFJPZ1BqVld2bnBwck5L?=
 =?utf-8?B?NHZMRlNHT0JTaEhzNENxUE1ZalkwMjVaSlZXOWJrb2piSU1CTXJjOEhYOGRI?=
 =?utf-8?B?d09GWGxHckFna0IvQkN6SGN2a1Q3M0NmSk9nTzlyWEZMMDFJSDJDSnEybld4?=
 =?utf-8?B?Tm13QUZJcHBObzJXSEh4UlNYWGtQK3phZnRGemRZZlB0ZGFqRWRmLzM2N1pa?=
 =?utf-8?B?WDJubEVjeHBvcDVaMTdOSGoySTZqVkJxbjU2V29tVzVuVFhGc2cvdjh1Q1Uv?=
 =?utf-8?B?VE5sMXZ2azBReXdQUUNPdXRqc2lKRUR1Zkc1aFY3OGJUczhHRVA2UDBVbE9x?=
 =?utf-8?Q?Il2J89D7Uqa/p620=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd13f2e8-e63f-4e26-dffb-08df1f01b6ec
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:47:13.5687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJuJt+IB5US0OhDBQUsx8Phq1NVvit0Cs8l+av2KbWbAm7TnWqAGupASHyDUQPDJoc5oeYeAbdkjAmaURxM++1DECUEMnphnffLrPQ3mbYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB384561
Received-SPF: pass client-ip=52.101.69.140;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 9/30/26 2:58 PM, Stefano Garzarella wrote:
> On Wed, Sep 30, 2026 at 01:13:14PM +0300, Andrey Drobyshev wrote:
>> vhost_dev_init() takes the device ownership with VHOST_SET_OWNER and
>> then may still fail, e.g. on virtqueue init.  Its cleanup only closes
>> the backend fd, which doesn't release the ownership if the same file
>> is open elsewhere.  That's the case on a CPR target: the source keeps
>> the fd, and once it's resumed after the failed migration it can't take
>> the device back, SET_OWNER fails with EBUSY.
>>
>> Release the ownership explicitly on the failure paths past SET_OWNER.
>>
>> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost.c | 10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> If you have to send another version, maybe better to move the 
> introduction of vhost_dev_reset_owner() in this patch since IIUC this is 
> the first place where we use it. (not a strong opinion)

I'd still prefer separating them: one is pure API addition, subsequent
ones #15 and #16 are actual functional change (also not a strong opinion
here).

> That said, what happen if the caller of vhost_dev_init() fails after 
> calling it? Who will call vhost_dev_reset_owner()?
> 
> E.g. in vhost_vsock_post_load(), if vhost_vsock_set_guest_cid() fails, 
> should we call vhost_dev_reset_owner()?
> 
> Since IIUC all error paths call vhost_dev_cleanup(), might it make sense 
> to call vhost_dev_reset_owner() there?

I think you're exactly right and it makes sense to issue RESET_OWNER
directly from vhost_dev_cleanup().  Thanks for spotting the bug!

By doing so, we obviously suggest that unconditional RESET_OWNER should
be safe for any other non-CPR case.  In particular, on the cleanup path
we call

vhost_dev_cleanup() ->
  hdev->vhost_ops->vhost_cleanup() ->
    vhost_kernel_cleanup() ->    // kernel backend
      close(vhostfd)

So backend FD is being closed either way.  IMHO that alone should be
enough to assume that resetting owner for any vhost-backed device is
safe.  Please correct me if I'm wrong here.

Thanks,
Andrey

> 
> Thanks,
> Stefano
> 
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index c01ccc800cb..3ff54879068 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1754,7 +1754,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>         error_append_hint(errp, "Try plugging this vhost backend before"
>>             " plugging such memory devices.\n");
>>         r = -EINVAL;
>> -        goto fail;
>> +        goto fail_owner;
>>     }
>>
>>     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>> @@ -1762,7 +1762,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                                  busyloop_timeout);
>>         if (r < 0) {
>>             error_setg_errno(errp, -r, "Failed to initialize virtqueue %d", i);
>> -            goto fail;
>> +            goto fail_owner;
>>         }
>>     }
>>
>> @@ -1799,7 +1799,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>     if (hdev->migration_blocker != NULL) {
>>         r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
>>         if (r < 0) {
>> -            goto fail;
>> +            goto fail_owner;
>>         }
>>     }
>>
>> @@ -1831,7 +1831,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>                    " than current number of used (%d) and reserved (%d)"
>>                    " memory slots for memory devices.", limit, used, reserved);
>>         r = -EINVAL;
>> -        goto fail;
>> +        goto fail_owner;
>>     }
>>
>>     hdev->initialized = true;
>> @@ -1840,6 +1840,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>
>>     return 0;
>>
>> +fail_owner:
>> +    vhost_dev_reset_owner(hdev);
>> fail:
>>     hdev->nvqs = n_initialized_vqs;
>>     vhost_dev_cleanup(hdev);
>>
>> -- 
>> 2.47.1
>>
> 


