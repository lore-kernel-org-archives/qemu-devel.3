Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BD5C48285
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT0BW-0007js-U8; Thu, 25 Jan 2024 08:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT0BP-0007g1-Gv; Thu, 25 Jan 2024 08:54:20 -0500
Received: from mail-db8eur05on2070e.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70e]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rT0BL-0006M5-JV; Thu, 25 Jan 2024 08:54:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSO1UqATrSAW2sKXLuTnKIN0oThd5mz5PCLSEmisFgGTnqxTK1hHJxF/Glw8Lrp6zzW3Kt42r7zxZTIv59FSbs1EEet6UV1jqia2Q/APDhJOFjXXlHZ20hKxUyaHHRhR+7+jKgyXcLkq+gP+l2QRfEWntgIan2EvpQjgQzVOOhtvqdfgrrjRezU2XNzX//+JMIIgfJfcXm3J8NLkxd9rUkZOPPrREMhgkhEOK9fLlZqxB0cyZQr/hnJZ2Z7Dlpf15SMoSLI49OmKJxmdrj96bASAJfF8OqLhYmnGuoQ/GfUS3T0FFSjLr5HteUC7Y+bnEDNM8UfngZ0/XVd0reS4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msNMc9H/UqCqwuqGAOVuCFjTv6XAkptJuSRxMZxKpIk=;
 b=Hdlf2ZLdSCfg4ymtK0ORkSI7Le5mig3+Jg2G1tmD3beD3QDDECU1QzG1W/aSNvJLCthsWM5u1zrV8cehvx5Hbv7Ef99TmsLpsfcYgPo49IcLciDwDioudbeSv6sjlCvhrb3PETRcManvlRwxl2Puda/0B03thDBmkerU/icrVe4eriQRC/M3q6iKJcyuEuldjVl/DEhCxiKkqveizLnW+SV2RfxU+jxdMf/ZHKOTu8vRxAuGxZ0/OAMp6p7NCOJwIF5DkT/dcjIYz/+7qTi9PBLI5HKx+GHLn1pJ2c8wo0p3MZgSljS0Tno09xKxBsuoPSJvCfUaoaso+WAZup5TnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msNMc9H/UqCqwuqGAOVuCFjTv6XAkptJuSRxMZxKpIk=;
 b=TqUsAksgsVug5/dNTTLFTQHY2n/h5pAEgb7e/XHIRRKC4vvuP06wXz+J37viYKX9Jcu01TTLL8uA3wWpm9hFypKwwY/56oReCF0PgM0C7smI8+93e9YD7JyykqW+PXCInwfiTQNusHeXY8WyIXVMZe1rO7fjLrduYimrumOtbBBqDXZbiw/npzucgM8b2ei8Vufxdv5VJVy+ncdoX1/CWk7pL3aio1k4FVrmfZ3gLtngd3HaEvyyfXQYFPDSSOW9GN0+HYY7N9CqcF6B7RG1YEvmCoPVAxYze8jVmsT7u3GtlQgHiBWMZjTdGP+6u8xt4p5yQVsRTFMdF8QLEURJng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB5474.eurprd08.prod.outlook.com
 (2603:10a6:208:187::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 13:54:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7202.028; Thu, 25 Jan 2024
 13:54:10 +0000
Message-ID: <0a5b6c05-253e-4675-9d60-37e238b713e4@virtuozzo.com>
Date: Thu, 25 Jan 2024 15:54:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests/277: Use iotests.sock_dir for socket creation
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com
References: <20240124162257.168325-1-andrey.drobyshev@virtuozzo.com>
 <3v7hvc2kt7obfhvnfrgmtwk4ofvy5dmrkiho3cbqsm2vnfhnl2@6n5i47olcp64>
 <e513bffc-636e-4921-b87d-be67a52457f1@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <e513bffc-636e-4921-b87d-be67a52457f1@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fdfa5b-76dc-4c92-1e2c-08dc1dad1b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAtYjhtHmUXhRirxn+QlBjxcmwDMldHYSyWBNO1wQ28O9gUOR21SKjSBucfHYmSLYukY6owKFC4HdNA5UWFQbR2YRPuDtRnTB4clSeXnqnfKFRgQgBmV9KWSaxNwpx5BTbSrn0BVEVgw00RUbJcO4O5X1fqNr1LbH4nETZFlxaz9lUGtFFLZeK4n24gzE+vrjbqCFUaqQEf6FSebMWbhpbf8dl/wcMubMH8LjYok+gArFyNeeMkVkdwDKUccLXfoZcdQYgE78sd/m8mcFUWi/E5tpDBtFFq7TFKjuGlusFxuyYq+e5pmlKTA0t0C01Zx3FKe6G7pSi4yEqvaUDSLU8sbR+az85696xureQrmrqHQoMZqen7PF5TlaT0/9kYhS2qEZ8mpchTvOC+3AWmGTt6GRYvo5Huo/i7rntuUWBNSIfafCWlW4s1G80+mDkqqR8V+p6daUIc+K+E0uTLZCmAlYiq6CdBJX+mJpCzRXH7qtSLyq/WM7PJVUObTe/ZH4T8mOpRlg8eKa6k8OydF62l1hdnDfPj1zCjgyC1CvDwPcDb/76GjfysPYBKkoUflLhfmUTnfwSbq97K7rQxMOQKEgwgjLFJ0z3NX6IPwN4LIryhOHJbqf6ZBpHHH2f7T2Cav/VsI73N5U9JcICkq/IKfRQrbUDdmJS/xn3bCxj6Z02DkLxM2E58J8F6+jpZK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(39850400004)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(31696002)(110136005)(66946007)(86362001)(66556008)(66476007)(41300700001)(38100700002)(316002)(31686004)(6486002)(478600001)(55236004)(83380400001)(53546011)(6506007)(26005)(6666004)(6512007)(2616005)(43740500002)(33290500001)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9LU3NOTlFTRDBhTDdGUWNMRGkzMnhPRUpidG1ZK1lKNlBMZTUrNnE1MzZW?=
 =?utf-8?B?SE01WjduVjJ4MjExZzkxOFMzb1ZaS3NTRkVycjFmalhWL0xwc0dFY1NaNGwr?=
 =?utf-8?B?UlEzYXMwbnhwdHprVmVpRXNqTE1DTEwrMUNHNVBtbWxLaS9SNU9aMUFBNkNp?=
 =?utf-8?B?cWFkTlBJaytJR3Y3cTBqUXJjcFZLYVFhVFJlcy9zZkRxNVp4QkZ3MkxFN3dw?=
 =?utf-8?B?aHlGQldRa04vRkpXZ0FkamZtZm1Eckw5TXhSamtCSEFnRVVyNWlpb1gxNFpH?=
 =?utf-8?B?QTh6NVBralhsSEJ5N2dSclhPSWtQYk9KM0pYWEQwWDdOaGliNlpaQld5TGti?=
 =?utf-8?B?QWhST2hHblJWMUFpcWRKT0hoR0hWVVh3WW81dEREeURsNWp0MXpYZ2EvZ3VJ?=
 =?utf-8?B?Zzh3UE1Odi9nZmtSVWFrS2ZScFZaeDR2aThnMWxQeWdmL3lNM29Uakd0WC81?=
 =?utf-8?B?Z0RSa3BTeW5Qc1JGZmFNOXpTK2JUSVlyUnV4TGMycDUyanc3Wlc0U3BFdTBO?=
 =?utf-8?B?ZDlLU1FwVEtPbnpTK3RtbTZVNDdYZWhRak1JaTU3NjFpVHBFZU96dW1wNEFT?=
 =?utf-8?B?WU55YlFQTFppN2M4WFZKVHNQYm5qSVo2UktjSGU4YmcyWEthOTg0SWRNdmg0?=
 =?utf-8?B?SXZwZWQ0cW5uZXFyQStScU5Qb0hkZTVXSW1mUm1odjJYVTYxa1ZVZmpEV3kz?=
 =?utf-8?B?UkphaWpLR0Vaa2dYZ1ZmL1Ira3JSV3lUQzg0SG04eU5UcVFkWDNKY3lmRlB3?=
 =?utf-8?B?YUJDVXlhWjF1Rm13cEVDaVZXUU1pTHgyVlBwK0p1ZmpCdzJSMDJ6M1NRM1Rl?=
 =?utf-8?B?ejh5b2g4OHN3bkZQdVppZ012MXo5MXhFeUtUWFd3dy8yNXFPQ3ZRL3hFVUE0?=
 =?utf-8?B?NlVQRHFQMW5weldXZ1VtZ3pYT0kxb1ZaRlJKNzllbnJ2UkgxZEVjU2JKaHd6?=
 =?utf-8?B?T09wTnpLTjNvUE9ScU42NDRRS3hRSGk0YlQ1VXpPZ3M0eEtvaC8ySkpVeGlH?=
 =?utf-8?B?Rkp1QllnWUp3WklLc0hLZDVuRWc5YmtDWWhwZWRoWkJBUXdtY21TZlZ6TWlo?=
 =?utf-8?B?S0ErSUJPOEEvVzlWU2wwL0RET21lRkhjMExwZGZtcnJsdHhNN0dpdVVrMXVN?=
 =?utf-8?B?WkJrYlJoMHZSK0dYYWwvWjA4aVpZWnN5ckhhUTBQWnkvK285RmluTzQ3ZEl6?=
 =?utf-8?B?Q2xUOFFKLzk0eEFEdUZNaW5XYVVCYTQxcGpSVzVMWlJXY0FPTzhoK1hVQmVn?=
 =?utf-8?B?cFgzYlIySzlPN1JuUkFpUXBOTWlMelIrV3lOTDU2ODhNbGc0L0RIbXR4bDhy?=
 =?utf-8?B?N0NGWlRFUjlBb2dxOHNsNTdGbm92eVVqQXVTU2pWSlh0dkE3Wlo3MmhoSHAw?=
 =?utf-8?B?VFc0NW9qS3ppVjdFMnk3QWtubjB1ZHdwSTJDRnZadERoUHNQTG80TG93ZndE?=
 =?utf-8?B?RUZkT2N4dHJkQnczMmFJR3MxaTRwakdBakdWczFEeHlGcDVRbDJSdDkwakRX?=
 =?utf-8?B?UENhZ3pRMjEwSnBJeEV2RkpRU3I0QzhPTWc3T3d4U3paZXJITVQ1M3NRellD?=
 =?utf-8?B?VjIvbUlFY2VsUExuaFp2YlgzaXk3S2czbnVKbUI1SEUyVXRIQjBvZXZZc3pu?=
 =?utf-8?B?UlZJemFvZ0tTZ2VlQlBSNmtlMHRzTU1XL0VjRzRGUUZRejFsOUxXdFVseEJQ?=
 =?utf-8?B?K1NsVVRGdHZScWdzWld3cEFZNjlWbm1obVVaWXZMei9Ld3dPalhkSEEzSllW?=
 =?utf-8?B?WERpcStpeFhyUFJoL1FEQ0lvSE9xYVVRNk41dmZpTWJucURxS1RKeFZkeTFX?=
 =?utf-8?B?emMyY0FiQ1J4eHlwdEhsNElSRGhpRVlobWdPdEZzTkhmbkdYRTVWVVVJcTEy?=
 =?utf-8?B?dWJSNWsyaFN4STVEYy9wOWU5T3A1WjJpMUJLeGFnZmVWc3Jxd2lmOUJad0VU?=
 =?utf-8?B?NThqTXZPK1ZVaXRPWmtUWi95M0pLbVM3cCtqSlZJT2pibnpvaDc5aEpJcHFt?=
 =?utf-8?B?YmQwRkozcW9weDJUam9mL0d2Z2xJdW1ycjh5clozenAwenNObCtabXRrL3Rx?=
 =?utf-8?B?V1d3cEVzN2FlVkFxTDF4WDB1ZElqSE9Ra25PQThqL2crZjBERUpPL0wrMGFC?=
 =?utf-8?B?OEtFcEw0eUdUaWJpYkovSFZpOEVidmlwWXhkakh2d0krMFd3U2VnR0NoNDhB?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fdfa5b-76dc-4c92-1e2c-08dc1dad1b2c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:54:10.3992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 447gXlo2GIW10zcVLI5tgMyEfBhdgK8w2UItBu9Wzqzo75Jh2u3aRWEPyb1tM5T0D+s9vYy6penK0BdeEhLy0xczYNxJtR+q745+YriTQ2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5474
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 19:59, Denis V. Lunev wrote:
> On 1/24/24 18:43, Eric Blake wrote:
>> On Wed, Jan 24, 2024 at 06:22:57PM +0200, Andrey Drobyshev wrote:
>>> If socket path is too long (longer than 108 bytes), socket can't be
>>> opened.  This might lead to failure when test dir path is long enough.
>>> Make sure socket is created in iotests.sock_dir to avoid such a case.
>>>
>>> This commit basically aligns iotests/277 with the rest of iotests.
>>>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/277 | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>>> diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
>>> index 24833e7eb6..4224202ac2 100755
>>> --- a/tests/qemu-iotests/277
>>> +++ b/tests/qemu-iotests/277
>>> @@ -27,7 +27,8 @@ from iotests import file_path, log
>>>   iotests.script_initialize()
>>>     -nbd_sock, conf_file = file_path('nbd-sock',
>>> 'nbd-fault-injector.conf')
>>> +conf_file = file_path('nbd-fault-injector.conf')
>>> +nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
>>>       def make_conf_file(event):
>>> -- 
>>> 2.39.3
>>>
> I would say that potentially the same code is present
> in 264, it is :
> disk_a, disk_b, nbd_sock = file_path('disk_a', 'disk_b', 'nbd-sock')
> nbd_uri = 'nbd+unix:///?socket=' + nbd_sock

Thanks, have just sent a separate fix for iotests/264.  Haven't found
any others.

Andrey

