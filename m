Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D05FC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6SOc-0003Hm-Gz; Tue, 15 Sep 2026 08:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6SOZ-0003HT-2X
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:36:19 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6SOW-0007Zx-Qr
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 08:36:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2A5WGOVjComLgkCU/xQMJ/Olc3KFPVMLDe/E5D0Z6Lx2pQB3A2EXsOCs3Q+jM7kCMuFZKR6O3Mc0LBrZBGQ75Cykzx8o7nnfXqdJILowUgxjUZ+ugD7K3bG3nXzxLUEE++pV+Eb49e0ls57LRwEcffQM7lxcfVXpo3qXPR8lioimttDdJuM+1xfYnvC2rcu57WRV1lLnx83/DyU1e8fysF6/tcs69TRyuJg2r0Wu8+5+ihyTIFKaFfxp15fzV+U1C3gLEMIo8DRrhdACprdk7BgTYpyiD/3iNSDCHl9c7y4ns/W8BJd3FjicRpS8ySKkRsqKVf/Ixi785Hm+05LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zI9BC7vMY2YiQtmda+xKXfajm1BSoCo1ZPIUrgcks7k=;
 b=rYO09kuUk6NaxKi3jCEMRvTRIzHm4Tsm/nsibgHCVwN7+SsGde0V2cWx9PlxvhEIDZ1ePNFH23lrMdnP/1fPc4rt3z19CjcstcOKY55LlUFK+/2kWT4uULwCgi3JbiQc0/Mp21Je4Pk8qgO6f8QRvnHFm+a0W9ONvQpWWPWkhRs7WNEPIsN7yAqHKXbBfuTqmG0MKhzyaA4Vtpkv6GFMrr6BFJ6vk/bVn3+hABef3PwY+lm3Z0R226yslpMntGOMN2tjFhdi62SQwyn5JA9Ne7ptGZIuQnXcxv6nOItOMYz/66NmaQJMiU1J8LApDc0ZVkw1YrpmIO95CVwQBZilVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI9BC7vMY2YiQtmda+xKXfajm1BSoCo1ZPIUrgcks7k=;
 b=kcKMSPmJhFs87h7odWpn/KXLeUSyT5dvAWJ00ISxQCXU7Dfj9JAddem4L8wsqfqN/5i5qgFI9tJ2vp1LF41megsS5zmKXybQhtG7f3CLc3dUlSIGS1xy+2Sv+hXVhSC+6Y3jKmLNJNJsFSQL0cGFRnJh3M0U5HivF4jpb/6gFwRNlLMkcFzHCp48yny3uZAXcmuV8Dy3zFqHWiuM8MqP94Z3u1mee+nCMKWjWPYnqRGf46j+OXt14JLQlbUbZG/i5FcbqiECtFPUGdbjyREgQtpPaj/pHPty3vJ1iOs3sLF/Bp0YzSdCCgxEs6mNayYR1hUa8tYZC0T6sdt584gLOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8419.eurprd08.prod.outlook.com
 (2603:10a6:20b:567::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 12:36:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 12:36:12 +0000
Message-ID: <a3d27ffc-679d-4b1a-aa5a-f3d9a7be155c@virtuozzo.com>
Date: Tue, 15 Sep 2026 15:36:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, farosas@suse.de, peterx@redhat.com, clg@redhat.com,
 dongli.zhang@oracle.com
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
 <aqgQYmbLk6O1Af7I@sgarzare-redhat>
 <328755e2-31d9-432f-88be-bda72d3ba3f0@virtuozzo.com>
 <aqkXTbt49bPJW7R7@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqkXTbt49bPJW7R7@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::17) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f4d9ba-537c-4ebf-a07f-08df1325ed17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: c6LD38gLMeOqMK2LoS4oPfoLUyX/3u70p4+EFJ7Jk1tRIX8X/TbZ1V1lbuohDfCZrZxWesWm/YPQc4Oq7cygpuwLUYOMR/4TA6gS9gvpkoPrDvDZqtmQGFs7vgO12/sybSaKTc4EcXewLxr6ETuvEJWRN0OLDiyQoyLllRhvjacSLISywHW2L/Rk3up8Y/1UfPtrHoNP9T9K4Ms/Gv65TpcQ0GbEjQiMB/+3ToyFUmXZNuj550QU+jNKNfzUkmzy4Rh7jJqLbs7nblX6MXrYl9lWcJoDjTTD8OZov8dGUIYKyIoNaNX35A31Tkpn6pGh1xqcxJtY9sF2b72cpxgF7LDI41XvYyvLA+/QSYimMVyo+XcucGEnf+8NIHEoSYzMGJvDHwrVQfnnfgHW/zUgMS/jd8cdsfHLQsYjaPfN0W7Fl9NNWG6YOxdIp9K5fx4GUMOXY66g1WpvLTt6ICjvajWyAY1j6uGTiKR7KvIdWaTqLBlu+urbwaAghhsXULwR+mA1zBjpLd5iPqYilroYUXwcQydbqSiaprQhXxSSRNoXjiLRrvwI5FZBUR08w2g3D5WVfI/+rX00vnP6cLF3Tp02OVd5x4CR55OzhCiF9v/BJ8jTh66nri4ZddvAYWgCvC7MDSeBa8+wLoS7oq8c6JN5f20H941J4AES3Hvm7TM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVJV1dKZ2VGV2FSaXd5SDNUS25qZ0JhR0pUNllyT0kwVXZXTlRaY3hwMDMw?=
 =?utf-8?B?WlBzRmdISitZU3Y4WHZ3enNvVjh2Zi9CVXpiTE1VV2ZXVkhzcWFhck9wcElX?=
 =?utf-8?B?YmVQWjVWR01MYVpJS2UxeFJkbDlmZ1V0MmdKYXV0aXp2c3h5aS9DZDFEMWlR?=
 =?utf-8?B?cXFHUGprTmZreDlqNUJzRjNsV2xiQ2VjZ2pBSmRodWh6SmIrUzZyQ3ZxZ0Jj?=
 =?utf-8?B?bmx0REhrU0NXT05pMVczS3RkeVY0ZVl4NDNaSFI4MUdzNzNWK2JVWk5HeGd4?=
 =?utf-8?B?SkhrZm85WEJIb3hVZTVhWWJpVmx3eGRYaGI0R3Fmd08xTG9GQy85V0NZSWVC?=
 =?utf-8?B?QnFjeEpFWTVmNmp4Ny9lckpFRlJaOVVwSGp3RU80aG9xZmZPTFlFeUZNYWIy?=
 =?utf-8?B?MkJkaUVPUW1qeVk2Qm9sbDBpMkh3citWWFNZUkFSUERpQk1xK0ppVWszb2pJ?=
 =?utf-8?B?ejBUbzdtbmZGN1ZVSFR2dmp6VmVYQ0RvZ3h5VVgxZ0FXYllhWERPSWplWTE4?=
 =?utf-8?B?R2dObTdaSHJhU2xKV0ljUXJmUEt2UHB1a0pnQVlYN1BNTlo0TXY5OE8xemJk?=
 =?utf-8?B?a0dQTWc1WmlRY2xsVFNjWUdWQlFSSGYzTHM3Q0g4Q3BoQ296R2lmTUZBc1FF?=
 =?utf-8?B?SldzK1pLUW9OalJRbXFNYXVHZlFmV2dzRERKK0NTeC9oNFAyNHpZaWN3RUx1?=
 =?utf-8?B?TStTQm45d0tXU3dwaU1ER09SWDI3cmRvQ09hbndkcnNRcUZXNCtqMkNObFJK?=
 =?utf-8?B?aVBYQVVibVZtSjdJK0Y0VzlQaWp0WVd0cllHQko2M3dmTE5temtnRU5JTTVP?=
 =?utf-8?B?VHE3Nm1SSkMraDBmU0xBTzdTcFphV21uajNJRXdSRVdqR2taQit5OXoxMWZt?=
 =?utf-8?B?MGd6Rmt4MUl2aEI5NUZ4K05xREpsOEZsOHFobURJUDluZmVSbW5sNGhQS1RB?=
 =?utf-8?B?V3BWQ1l6eE9kcDk3YTQvcDhncDl2ZGVGVnRRMitRMWRiZm9wbjFwTXh5Mity?=
 =?utf-8?B?Mk5uUkh6bmVDSEhkalNGdFdxVkFqcWxrOGZmYXlBSjhaK2FwMDlTdTc4WHd2?=
 =?utf-8?B?aVpNSmZaZVhPMTBaQ0tkY0JTK09LbStDbzhTekh1NkRQeHBEOUtWam5VOW5p?=
 =?utf-8?B?TEg5dlAyS0lUeVRlK2tRNlJiQ2h2ck1HTkpHb2owUUJBQk9mU1NrcU1qZ3I3?=
 =?utf-8?B?UyswaCtzaSt0NDlpNHJlbytBaDNOUUpXSGJDVmZSb2UwSWs1ZkhodFRzNXBH?=
 =?utf-8?B?TURBemptVUk2UCtXN2lIcE94bmNWU3ZxR08waHBOYWw2cy85WW16UXBNTDNY?=
 =?utf-8?B?c2dKZ3pFTldWV3dWMTRNUHFBUTBWV2JNQTIzOGtlTU1jWGVFMVIzUU85N01i?=
 =?utf-8?B?aFQwRHBSVjVlYTJWOWxYNHI5aE05SzcvQSt2dXdTRkV6SXFUTll4UktKUWo1?=
 =?utf-8?B?RkhqS3ZnSXExUXVlRWZSRjAxMXp0Ym5iaEwrbjBkKzJyM0grbmlabnlqVzRS?=
 =?utf-8?B?cXVNYTRMRFgyRVdsamV2ZjdKNFI2aUp5UzhJU2FXVU9WcVFZZFlsSnl3UHhs?=
 =?utf-8?B?eEZQc0pHYXd1RjBzdmY5NWVqUzBtbVlFY293elpqdmNIVysyNnNsVnNzWVRa?=
 =?utf-8?B?b2NheElaRVZpSHl5aWcxR3dvdFp2WUFJaG1kZFp3VmIrOUZndzByTEdaVG9N?=
 =?utf-8?B?WFRGazFkNnNrb1hNOUZjVENyc2NYbjRnNGxjUm9sMkdDZ2ZvSnB5VzBtOWZk?=
 =?utf-8?B?SW9CRmkxN0diT0ppaFFkdkN5MmhoWmI4TkdGdXhkMlVxMi8yN0lyYjVXYjZl?=
 =?utf-8?B?RWtEK1B0a2dsRERXZWFnbHN2K3V1bitsUjFnQ0pKVDlhL05ZN0FhbXFRL2Iz?=
 =?utf-8?B?VE0rZ2dOdnl0OHYzZkFjbzg2d3NjSVNzRWJGS01ualJpZHFCaXBjUmJlcUty?=
 =?utf-8?B?L0lyMHNmcWRDRks0RHl6WkRzdDcxUmtZZU1uVG1Ob0NuVElqMUpCUUVLRjNw?=
 =?utf-8?B?Tm1mZ0p1bUNzK0d1Rk1XNUVDYmp2TVF1TWtFMVhIWWVvNWd6VCtJOUxhemxk?=
 =?utf-8?B?a0Rpb2dGNmhucmFuVmpaY1ZZMWZFWDRrVWJUcGwzdWtiYWlpYWZjY0pwYWZI?=
 =?utf-8?B?bkVBdHZLQW0zb3VKa0F2cXJXQkkrZFlwUmhIRXhkMG9jdDVLMnY0MHE0dmpY?=
 =?utf-8?B?a293SzdPSzMzWHREQ2NSR2VvWm9vRGRLaGZoeVZuVjcxRkcwRjI5WURRVUxv?=
 =?utf-8?B?R01VaFhmc0FrTlV4QUtCcy9OWW9oeld6R05HODA1MHhhdXNwOVRTQzFscXlu?=
 =?utf-8?B?WkpEbENyY0Z5b050NVpKWTNGMk1ZZVN5Y3c0YU5MQjg2UDIxcTdJWGJyM3Jp?=
 =?utf-8?Q?T9OtgJWZ3TOr//7E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f4d9ba-537c-4ebf-a07f-08df1325ed17
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:36:12.3544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyEusZyDsruggB9ez7cTC8INU9/H8SCHA3cp64U0iu+brHD/7Oe9BapEVpI7PUs1XQ4auTNsOw+ds6+pzfpuGP+uMgJPQV7etYzgG/XpHMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8419
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 9/15/26 1:07 PM, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 12:56:11PM +0300, Andrey Drobyshev wrote:
>> On 9/14/26 6:36 PM, Stefano Garzarella wrote:
>>> On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:
> 
> [...]
> 
>>>> @@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>> }
>>>>
>>>> +static int vhost_vsock_pre_save(void *opaque)
>>>> +{
>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>>> +    int ret;
>>>> +
>>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Release the device ownership now for CPR migration.  The device is
>>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>>> +     * VHOST_SET_OWNER in post_load.
>>>> +     */
>>>> +    if (cpr_incoming_needed(NULL) && migration_is_running()) {
>>>
>>> Should we also check if vsock->owner_reset is already true?
>>> Or it can never happen?
>>
>> Actually you're right, and we should also guard the RESET_OWNER op by
>> !vsock->owner_reset.  If we fail somewhere after .pre_save() and the VM
>> was stop before migration - we don't call set_status() just yet, so the
>> device ownership isn't re-aquired, and a subsequent CPR attempt would
>> fail here. I didn't think of such a case, thanks for noticing.
> 
> oh, right! Thanks for checking!
> 
>>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>>> +        if (ret < 0) {
>>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>>>> +                         strerror(-ret));
>>>> +            return ret;
>>>> +        }
>>>> +        vsock->owner_reset = true;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>>> {
>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>>>> +    Error *local_err = NULL;
>>>> +    int vhostfd, ret;
>>>> +
>>>>     /*
>>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>>      * guest cid is unchanged, and the cid-change reset would otherwise
> 
> [...]
> 
>>>> @@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>     }
>>>>
>>>>     /*
>>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>>> -     * device ownership is not handed over, so the target fails to set
>>>> -     * up its device.  Fail the migration early and gracefully instead.
>>>> +     * With the ownership handoff in place CPR migration is now supported.
>>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>>> +     * we only keep the migration blocker for the ID-less case.
>>>>      */
>>>> -    error_setg(&vsock->migration_blocker,
>>>> -               "vhost-vsock: CPR migration is not supported");
>>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>> -        return;
>>>> +    if (!proxy->id) {
>>>
>>> Ditto about using `cpr_name` here.
>>
>> Agreed.
>>> The rest LGTM!
>>>
>>> Thanks,
>>> Stefano
>>>
>>>
>>>> +        error_setg(&vsock->migration_blocker,
>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>> +            return;
>>>> +        }
>>>>     }
>>
>> There's an interesting consequence of adopting qdev_get_dev_path().
>> IIUC vhost-vsock device inherits from virtio device and is always
>> attached to a device which is virtio device.  Then in qdev_get_dev_path():
>>
>>    bc = BUS_GET_CLASS(dev->parent_bus);
>>
>>    if (bc->get_dev_path) {
>>
>>        return bc->get_dev_path(dev);
>>
>>    }
>>
>> And all virtio buses, namely: virtio-pci-bus, virtio-mmio-bus,
>> virtio-ccw-bus - implement their own .get_dev_path().
>>
>> This essentially means that for vhost-vsock device qdev_get_dev_path()
>> can never return NULL.  This in turn means that our migration blocker
>> which is now guarded by proxy->id can be entirely dropped.  We can just
>> always allow CPR migration and simply do `g_assert(cpr_name)` whenever
>> we obtain that name, as it's expected to never be NULL.
>>
>> I'll try adopting that approach, unless you have any objections.
> 
> No objetions!
> 
> I haven't looked closely at `qdev_get_dev_path()`. Can you check if it
> includes the device type (or the id) in the path, or should we add a
> suffix?

AFAIU it includes neither of those, and it's purely the transport bus
address.  For different kinds of virtio buses that'd be smth like:

  * PCI: "0000:00:02.0"
  * virtio-mmio: "virtio-mmio@000000000a003e00"
  * ccw: "/fe.0.0001"

And then we have precedents of other subsystems appending suffix to this
address for the purpose of CPR indexing, e.g. physmem construct RAM
block IDs for CPR as "<devpath>/<region name>".  So we might do the same.
> Let me explain: I'd like to prevent other devices from conflicting in
> the future, so if we use “vhost-vsock” as the suffix, we should be fine,
> but I haven't checked carefully what it returns, so maybe it's already
> there.

Now, IIUC when we add 2 or more distinct devices which a siblings on a
virtio bus (of any kind) - they do get distinct addresses on the bus ->
qdev_get_dev_path() will return distinct values.  So we should be good here.

I'm going to adopt this approach, as well as drop the migration blocker,
and do a respin.

Thanks,
Andrey
> Thanks,
> Stefano
> 


