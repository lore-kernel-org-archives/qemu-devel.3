Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04C2C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMgl-00006b-PN; Tue, 06 Feb 2024 09:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXMgj-00006C-WA
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:44:42 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rXMgh-0007kX-O1
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:44:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKcrjNPabVHCSuGAUG+FI/eC7gEWt7j/jVSF68HPD1tky0bmg9p00C5CFaoGzfcrjbxnvL3XVP8kJao0nBjWWhheSEIMbcqUrUye7UA8nDTZmS0OBf9Ku+4W4b971Gl/bO9iScm423IfDbOgmn8ffsulBOzqv16+fP4/4j2J32vKpuGzVomlHtrj9tCdr+xTib3+lvbMNivZ0rnb2Q+j+lbrupmwfO5o7gBWG6ZFQwqhcTA/RbPxOy0p620daImNhLali5RaayYZkfhkM228e2LSW3aV2QjF1cbJATCx8wLT+/Vx7q/KbfK9PkSXWfpddo9EuB+42/cwCose46/HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGo9aYyGoDQMXx9VW0t0ufBxcvGgB9YoRX9rptSFnMs=;
 b=n6ywOODrq4ARUp85SMJ7TOsXr4lSOtuyp4SZQhJvzCkaBAx6eKzFyvWla0HCFufoB6KxsSeD5593sj5qYlSnKWpUMOx66S6h7cWH5g5ehLnQ2U41gBJi5MFwjdke6g+0dAU0IktAXwXlkhzEfIJjIAx7E37xGFcupFotUISnpjKlBe5RXPEp00jEUkCJZIB8Hhf5cZVbhoasOBLREhHCaA3/0F/GI2Kfoj1zYKqAioKplwMPkeOC2Tj4zweqbl1TsTiXFRoAIy4XnqdPJ+BtWKcXplT8I9H4F3pthCLvU1EA0hwUYFPZvqkYeXlrP4dJyIsw7VFkh5Mht/241pt77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGo9aYyGoDQMXx9VW0t0ufBxcvGgB9YoRX9rptSFnMs=;
 b=mu869sOhlMYHuTB1487TyQBBEBzsvB0boYB/ddI39SVOey2E0IoklaYP4zheRlEwaNiX2zSdvpMb0fBngdvLKVUswmYJYv+uLpJ06fPDR44wpaZfyGCQopaXnxh7lCzDqahI3l7z/1p62Jupg2NF3Fq6fX+QfVHouR304xSe0vAch9ERn22ZhsjmHVDZ6gXDZ3v1c/M4uI1uzWW5SgpKNjo90GkO2OFbaRpKA/InF6drJ8FQIhcZf1mlRL7j71EraZ11AI3PcLrxaTsTU3RrYDx0kRZUO7tmWKQ6Xjv5qqBax7mBoBTp9cJ8mtkLH/ghRlHeHf4A0lTeVqp9+16fwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 14:44:34 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 14:44:34 +0000
Message-ID: <23a2160b-4410-41e5-a760-b1052a0034f9@nvidia.com>
Date: Tue, 6 Feb 2024 16:44:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] migration/multifd: Unify multifd and TLS
 connection paths
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20240205194929.28963-1-farosas@suse.de>
 <20240205194929.28963-6-farosas@suse.de>
 <e4f9337d-ed7d-4a11-84dd-76661009c3fc@nvidia.com> <87fry57jhn.fsf@suse.de>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87fry57jhn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: d297b394-f37a-4cc0-fed7-08dc27222290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1u+YPj7WVg55y03PU1WQ7wTPrdSzbSLtv6+8Tf8tv24qSoFPJFuB61lfMKtiM6i08GHf4LLiUXibE/MXaJvhyvhVnAZJqqt0/5FhK/6QKkdOKDnvNFKCwslHnCuTN3DcLfvJ9SjimSkcS8rLC7WRUXtnZtTGCCxVtu8qIMFUgKabUcK81GtwbcHWEHwPx4UTfKuo8i4y8ymtwr45OPE/XBSF7eEtzGnSZnd2mOSaNKhWVCjTzOPDXN8l2RSHoTnEmt4Yma+500Rfm2rKkMqEvoTNiALyYX57JHVKkpcASM2iMJjUCDfZl/wRSsc7Qd7difEtt11l7cQXU/s2mlctK0s6icnBEZ2+4etCww8plTDHIiWh6M0cGoIes5M6cTzLu0te9UGOeDnGo4GlgftKq8sWZfT4/QgAdr11HzLpuH3Xt05S+z6ode9zcLCX/WEsi3nY9xuHeox1RWbw1V2kl7nGabmnjCihy4h1ffMU0gRZCwfzmwleRAMazhND+WJXZ56GUpBd8hn/Y5evuVlglyDoBXzE48yAWfzXGBfda0Oib9WM9158COoZss7di1M6tEpkY4mFAgzB3HmMTnjfq5UrVM8F+FWT6VakQrE9su3kIRiLawi08UCSrfpHGdoHbHH3L7CF4QZzojAJKiCdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(230273577357003)(451199024)(64100799003)(1800799012)(186009)(31686004)(36756003)(53546011)(6486002)(6512007)(86362001)(2616005)(2906002)(41300700001)(478600001)(26005)(31696002)(316002)(66946007)(6506007)(66556008)(5660300002)(54906003)(8936002)(8676002)(6666004)(66476007)(38100700002)(4326008)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhST0VCc0pOcmJFUWZYTW84R284eDgxQ2Z3akpKZFc2S3pNaEtkbjVvTlpz?=
 =?utf-8?B?UnE3OXViWUxZUmRySmFCK1dRT2w3V0tseUhZcWQ1eEkrdEl4b1JGbDdqK2R0?=
 =?utf-8?B?dmREZFY1RnlnYkZZU2ZNVXhVNVRlTklnTWRmWDdDVDNHZXpkNWEyQmZZTmVO?=
 =?utf-8?B?cFRwdldWZ2NyTDFOMW1qa1pMWmhJYWl3YVEwZlducDUrN1U2RUsrRjg3dE5N?=
 =?utf-8?B?d2taNC9yU1VoRjYwQXRhUUpyMkEzend6em1jbzZWTHJGZER1ZElnUzN2clNt?=
 =?utf-8?B?VmhXbVJRMWhQSzFnNVorSDdEVGFNTzJDTktnc1pOQTRRWFBnK093TFYzcTJV?=
 =?utf-8?B?VkhzL3lZaUtpQVFyTnI5V0VvNGZqcXJFVllyWVVnZndWVVM0dGp4bUF4SGpX?=
 =?utf-8?B?bjBpWllHMmgwU3A2S3lQZWlUN3A0ay9WS1VuTlZORUNFeUVPaE1aTG5zT1A0?=
 =?utf-8?B?dG5oUzFqUWJwSXlmeTRyQ0hxMVZhOVQvbmdJYW1rVFM4NVFKNVlvWlRXMmJ1?=
 =?utf-8?B?UVpGMzhZQ29yMWhOeU5hZHBNamorMlp6ZTYwK0RsV0ZVN1BQeUtJRU5kaUhQ?=
 =?utf-8?B?Qy9jRlR1WHpmY2wwU1hLamZyd1loWmxkSWExRHRieVhkb3dCT3JlQXFVSHli?=
 =?utf-8?B?ajFPSG96WWJZZ0ZlWG9IcEtnaCsyS3daZmJLdno3SmtqMXU0ZmY2cWxXYjVL?=
 =?utf-8?B?REJxYUVURVdCb0o1S3BnaGJIUXVrZHE2R1VDWG9wbVh2a3ArTVB3NGxiVGtC?=
 =?utf-8?B?QUtidTBvVnhQaFhkS2ZKbGFaUzByUDJaaGNQOU94SFZoUnZEVXBlY1hXcHhS?=
 =?utf-8?B?Y3NabXdIMEFPZEJ2YlRaWk4yRTViZ3ZGdEJLWElxNEd6dkxBOUlGS0w5NW9l?=
 =?utf-8?B?MFNiMHdYbXJ2T3lDQ3B4aEMvRHM5aFBHVXVOeXY1WUxJNDloMlZIbmhqNVJG?=
 =?utf-8?B?bGZVZ1paVUxQSGRmNy9MLytYTjZJZExEQ3hOTno0V2tZWTRXeUhCcHpXZlpT?=
 =?utf-8?B?by9lVnlMdEY3SW9Hc1VlaTNnQlVBdE5kdTJKeEs0ektqRHJXWUhkamJITEFa?=
 =?utf-8?B?RklHbEUveXgvdDlGT2U1WStmSFV0aVdzdHdvdFBqQWFycThxQSswdlhCY3Nn?=
 =?utf-8?B?cWdNTjBFMzkvcEdpK3ZLWUhoNXA0ZUQwY1BNM1dFUWVXK0dPc1l1N1Z5dlhY?=
 =?utf-8?B?a0NOMmV0NEc4TnVpMkF0WndvOHBXQURmSVdEQ2pYamFTVTU3R1ZwUlA1U3dD?=
 =?utf-8?B?NUFRM0FIMzIya0ZMMGpqV0FxMW83YStxSGYwZk56bmJNU2lhWDBveHBhTjF2?=
 =?utf-8?B?VGNQc1lGSzF2dWNqOXc1Z1VyVkUrKzNLaTd1UTZHeEFhbU56dUtKV3ptWGpI?=
 =?utf-8?B?ZUpmcjBxb2hFOC8za3NHcDBLQkJnZVdNWC9KcFJNS0dySFVyWVNQUkFmRTUy?=
 =?utf-8?B?WENOTlUwRlg2bEFLMzNjcURVQnFOU2VCUTdobG9PbHJvV1hWVXhuUm9yYXZD?=
 =?utf-8?B?Sno3clNBaHVIRTlTN2ViQlRoRVVUMFFwZWExYjM2NVBCQUdjT3hndjJFS2Zt?=
 =?utf-8?B?TUl0QVc1VUJ6dU5UMG5pYWl3cldsVjNDdGhpelV2TDc3WXMyS2lTdWY3Q1lz?=
 =?utf-8?B?Mm50aEdDTEd6azNHL1lGa241bVBRVUhxQnoveXgxdk9xOEw3NUVsbnFVQm9l?=
 =?utf-8?B?elYrRjQwbVFVV1BvRWx6TU9Kb1pjQTBXOTNwdzI1NGExVzdraktpWEp5M1pJ?=
 =?utf-8?B?Q04zWXVtcklvdWhlVHZweDBjeXkrc0hvUmMwWEZpUDYwcThsWUhqL21NOFBS?=
 =?utf-8?B?d2VnS2FBODA3UGowZkhaR29rN0VOUmpWaWErdTE5RnhISitjMzU2UElleVR1?=
 =?utf-8?B?bGdYVEpSS2x5TUZ5cC9QbmNJK0VQUHNOMjkzNS9xWjFaU0dzQWdhU21FOGxq?=
 =?utf-8?B?bWdJL1Ayei8rN1RIdHhmZWo5TmxadmprWnlHd0U2T3gxSGd6SnB0K1FGT1Yw?=
 =?utf-8?B?RkJ3VWY3MmhudG1GRlR0VmQwQmFLL3JINU5kdTFDczVBOGtOekhpdXRkNXN5?=
 =?utf-8?B?SHlZZDZyYUdvS09jSmhjWFp3MFU0anB0emttZGd5UXZuVmNXa2cxNzdSbllU?=
 =?utf-8?Q?taOHfPgxsR+H7kDcnKOcTP+FF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d297b394-f37a-4cc0-fed7-08dc27222290
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 14:44:34.7105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqR7Uk/qsabK5WswJDZFBmQBY/Q8ny9VX3frUa5jGXR/abjEJm8bNvGUSunZzkUJiYVW5Sp637B2/7uhmXHqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 06/02/2024 16:30, Fabiano Rosas wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 05/02/2024 21:49, Fabiano Rosas wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> During multifd channel creation (multifd_send_new_channel_async) when
>>> TLS is enabled, the multifd_channel_connect function is called twice,
>>> once to create the TLS handshake thread and another time after the
>>> asynchrounous TLS handshake has finished.
>>>
>>> This creates a slightly confusing call stack where
>>> multifd_channel_connect() is called more times than the number of
>>> channels. It also splits error handling between the two callers of
>>> multifd_channel_connect() causing some code duplication. Lastly, it
>>> gets in the way of having a single point to determine whether all
>>> channel creation tasks have been initiated.
>>>
>>> Refactor the code to move the reentrancy one level up at the
>>> multifd_new_send_channel_async() level, de-duplicating the error
>>> handling and allowing for the next patch to introduce a
>>> synchronization point common to all the multifd channel creation,
>>> regardless of TLS.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>    migration/multifd.c | 73 +++++++++++++++++++--------------------------
>>>    1 file changed, 30 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index cc10be2c3f..89d39fa67c 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -869,30 +869,7 @@ out:
>>>        return NULL;
>>>    }
>>>
>>> -static bool multifd_channel_connect(MultiFDSendParams *p,
>>> -                                    QIOChannel *ioc,
>>> -                                    Error **errp);
>>> -
>>> -static void multifd_tls_outgoing_handshake(QIOTask *task,
>>> -                                           gpointer opaque)
>>> -{
>>> -    MultiFDSendParams *p = opaque;
>>> -    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>>> -    Error *err = NULL;
>>> -
>>> -    if (!qio_task_propagate_error(task, &err)) {
>>> -        trace_multifd_tls_outgoing_handshake_complete(ioc);
>>> -        if (multifd_channel_connect(p, ioc, &err)) {
>>> -            return;
>>> -        }
>>> -    }
>>> -
>>> -    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>>> -
>>> -    multifd_send_set_error(err);
>>> -    multifd_send_kick_main(p);
>>> -    error_free(err);
>>> -}
>>> +static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
>>>
>>>    static void *multifd_tls_handshake_thread(void *opaque)
>>>    {
>>> @@ -900,7 +877,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
>>>        QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
>>>
>>>        qio_channel_tls_handshake(tioc,
>>> -                              multifd_tls_outgoing_handshake,
>>> +                              multifd_new_send_channel_async,
>>>                                  p,
>>>                                  NULL,
>>>                                  NULL);
>>> @@ -936,19 +913,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>>                                        QIOChannel *ioc,
>>>                                        Error **errp)
>>>    {
>>> -    trace_multifd_set_outgoing_channel(
>>> -        ioc, object_get_typename(OBJECT(ioc)),
>>> -        migrate_get_current()->hostname);
>>> -
>>> -    if (migrate_channel_requires_tls_upgrade(ioc)) {
>>> -        /*
>>> -         * tls_channel_connect will call back to this
>>> -         * function after the TLS handshake,
>>> -         * so we mustn't call multifd_send_thread until then
>>> -         */
>>> -        return multifd_tls_channel_connect(p, ioc, errp);
>>> -    }
>>> -
>>>        migration_ioc_register_yank(ioc);
>>>        p->registered_yank = true;
>>>        p->c = ioc;
>>> @@ -959,20 +923,43 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>>        return true;
>>>    }
>>>
>>> +/*
>>> + * When TLS is enabled this function is called once to establish the
>>> + * TLS connection and a second time after the TLS handshake to create
>>> + * the multifd channel. Without TLS it goes straight into the channel
>>> + * creation.
>>> + */
>>>    static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>>>    {
>>>        MultiFDSendParams *p = opaque;
>>>        QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>>>        Error *local_err = NULL;
>>>
>>> +    bool ret;
>>> +
>>>        trace_multifd_new_send_channel_async(p->id);
>>> -    if (!qio_task_propagate_error(task, &local_err)) {
>>> -        qio_channel_set_delay(ioc, false);
>>> -        if (multifd_channel_connect(p, ioc, &local_err)) {
>>> -            return;
>>> -        }
>>> +
>>> +    if (qio_task_propagate_error(task, &local_err)) {
>>> +        ret = false;
>>> +        goto out;
>>> +    }
>> I think this common error handling for both TLS/non-TLS is a bit
>> problematic if there is an error in TLS handshake:
>> multifd_tls_channel_connect() sets p->c = QIO_CHANNEL(tioc).
>> TLS handshake fails.
>> multifd_new_send_channel_async() errors and calls
>> object_unref(OBJECT(ioc)) which will result in freeing the IOC.
>> Then, multifd_send_terminate_threads() will try to access p->ioc because
>> it's not NULL, causing a segfault.
> Good catch.
>
> I'm not sure the current reference counting is even correct. AFAICS, the
> refcount is 2 at new_send_channel_async due to the qio_task taking a
> reference and that will be decremented after we return from the
> completion callback, which is multifd_new_send_channel_async itself. The
> last reference should be dropped when we cleanup the channel.
>
> So I don't really understand the need for that unref there. But there's
> no asserts being reached due to an extra decrement, so there might be
> some extra increment hiding somewhere.

I think the ref counting is correct, in the non-TLS case we never set 
p->c = ioc, so the cleanup will just skip destroying this p->c.

>
> Anyway, I'll figure this out and update this patch. Thanks
>
>>> +
>>> +    qio_channel_set_delay(ioc, false);
>> Maybe qio_channel_set_delay() should be moved inside
>> multifd_channel_connect()? It's called two times when TLS is used.
>>
> It looks like it could, I'll do that.
>
>>> +
>>> +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
>>> +                                       migrate_get_current()->hostname);
>>> +
>>> +    if (migrate_channel_requires_tls_upgrade(ioc)) {
>>> +        ret = multifd_tls_channel_connect(p, ioc, &local_err);
>>> +    } else {
>>> +        ret = multifd_channel_connect(p, ioc, &local_err);
>>> +    }
>>> +
>>> +    if (ret) {
>>> +        return;
>>>        }
>>>
>>> +out:
>>>        trace_multifd_new_send_channel_async_error(p->id, local_err);
>>>        multifd_send_set_error(local_err);
>>>        multifd_send_kick_main(p);
>>> --
>>> 2.35.3
>>>

