Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C54EC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUszY-0007z5-Ty; Tue, 30 Jan 2024 13:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUszX-0007yk-IO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:37:51 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com
 ([40.107.237.42] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUszV-0003cl-4o
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:37:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8u50lgcljkK6yFQ6Clv0VyudCCb1XopZOjxHMfozzhbZ25v0FZGtgeh/m7VHXsxGqyGU8UvA/qJgqZpKLEy87rTDSyjF+yRZQfjtDHOseLA5vQBVqM1duaZ3RnQ6RZNePnGTixskbn8chZTVgXeCOzlzN44KwW10E5r4as7Vf7t9jgv8lzw3s2tRu53wNLkokzTC+FvVRcqR/JeXRvnFFeHg03E4ZQRAwcsWdjvjq716yXaUEkXuq9mI0/fIt6EWpV8fRpMdelc/n3sG6n4Ig5kPKMhhGyobVqrilGD+rm3m2PI0U2lrLjA51VlfoSvEOKOE5GLBpITfe2Uu8kKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fubFFLoKtXZktnCK9UTts7tTxtJjfJbypq+9YHGrXlU=;
 b=JvZQffOV9EhHQqSw48eJWKvAvMQj+ix2YevbaEf7+AF7UU0fc18QMyjbzB+rYDnRUBL6ZuF8KieghN/DWfc8NpDw5vzMexPvaP8dufeq7Tji1YqKzwd5R0Wx+Xu71bDf9nQwoVAFO24g9CbVLUMVcpjs+vxEBH1Sk2JwODCjmra7yqI5wBT93bYJHoc1HdVNTZKlgPa/6eKvEHFko6FmrgVUpe7NfxJdCwr9jYdfPFXHSQOwUSjUirJMu13UJmtN+fK1eW6KiLzPwRr6YIT5/rf89sZOlhVqaoAp1yQhHaxAyWGp3GQQrvs0rde6FFTthu53GonXKPgs+ANeMyJYFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fubFFLoKtXZktnCK9UTts7tTxtJjfJbypq+9YHGrXlU=;
 b=L+g6811XBamDpgfHPnAcf8qh0BEfjWQi/cNRvuY6eD94+7Tbp+oOSOnHS+KtwyvHd+QearcO5Ir+OXFAsCnnVPerVwg4FOtQNccU7DaOHspxKdBuHmr9haDRgpry/5MI5YTFaBi9RIWXL1U6CWR1hduaMhevYoIeZahGyjj0TnDAYLgKvWWS1Xr26C9WKdVqp7PfVOuEvUEtjrUInPsjBmOr57lLSUzuXXBrDmLddvBCmCwuhbnncFfeMimiCzqtPzhBaeDX3O5VgvST8kO11s613kwTNLv0zErQctbmlPR/YQ5OEmOd2inrrawUK0Z8nvVf7OqeRXgRqy09kE5tIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:32:42 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:32:42 +0000
Message-ID: <a54d5dec-6103-4e10-b732-2156573c4ad8@nvidia.com>
Date: Tue, 30 Jan 2024 20:32:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] migration/multifd: Wait for multifd channels
 creation before proceeding
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-6-avihaih@nvidia.com> <87cytkdx7z.fsf@suse.de>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87cytkdx7z.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::32) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 21331b4c-daaf-4c46-aa95-08dc21c1d897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4VGzGiN1IicGoSBuSaZEGMFM01N7bEECdiN/eMOdz17s4OMvM+1ekKPFa4+HLE/Fxk+va4bNBFmcL/5mG+3PujppQMOfhkk3LanUDXuUFMqZ4uUDNyOG6+KkX/PqkyWws7awRsgXOMxNjsXVvlXthVXRu496co5EXsEAbg5At/LHeNasbMatuJi8XPT4/h9tJfiKwjvWhmKZfQ/nSjKkp/n0cZZdpffESfC1C/rv4y7VvkDAQBl65KaN55GRo081wmW9lyuS4tgv8dThFdU7RqAPthGnrawU0HjV0DIffJ3Fbu8xUb+ukIjyKIiXPSQQuU1xsSe3NB697dH3+/K9vYIWz2VMjO4CoSJzz0ux7RzyWyIuCebpO1hSL+zBkpAjYJmKKoqyxMj/eN5svXeq3QxqOHXH3A2sXHSfZVctiDKBh5LeqkQ0NXA7f1fNDk7ZGozmWZRBuFucTKOk5m4eiYJZ/qs7YvkA3YisvbOaglkaxWoWrXt9WlWGSSNHLAX5zdDE/kPD7aR/O7+t8rYaa/7O4LspVsZUzXi4vmlM3fbFMQ/LOZTLRzJWX+TqYyIuU0e5SMNlGqdre/UEIem3Jx/Hg6K5b0xnouZbVvpdxGqXhgUFYxf2FvPBpDbpR/npHNnG/PIrZ5WjtqzP9rGnQkwa4TZZKCJx0QxZL3VTIJBlMxG5l1kBaxmyzbUKSFI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(64100799003)(1800799012)(8936002)(8676002)(4326008)(5660300002)(86362001)(31696002)(2906002)(66946007)(66556008)(66476007)(316002)(36756003)(26005)(38100700002)(53546011)(6512007)(478600001)(6666004)(6506007)(83380400001)(6486002)(966005)(41300700001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blY2c2FxR3NDZDdlMVdvenNLb1Z3MzNJWU5kL1RwTlNrTmJtN3pVZ1VKWUM5?=
 =?utf-8?B?aTl0Q0J5T0psWTRKOEh2ckFHODR3amQ5eGxLclJlQnJzd2pDMUNMNEZaQTJY?=
 =?utf-8?B?QS9nalRScEp5SW1GS2hoSUVycXNlY2tzcVdncEdMaHVEUWJJNFdEZEdocURF?=
 =?utf-8?B?WXFKYjlNTysxL0tRYXlEb29mdXRlMFE2UUpTcGgyTk5yZis0TFFtY1Y2TTB4?=
 =?utf-8?B?YmtURlVTUk1LcEV6WG5WTmN2ajZxVDN3TWlMQXNvbVZmZUVYWXVyZ29SNWUx?=
 =?utf-8?B?Rk9OZWc3d2s0cHZkcDBMdms1RUpVRHRIK2JiL1hBaU1tQ09tU0VOU3Fzem5V?=
 =?utf-8?B?WmVLblg5VkV6V2dJVmNWRlR2cE55M1FhRGZMdzJEZkg5R2czaTNjc2YraDdR?=
 =?utf-8?B?VDltQmtodFMyV1hoV2xYTTBPajV5S05RZkV2ZURlR0hzLzNnMEdRVXE0b0lw?=
 =?utf-8?B?bU5uWnY2ZTdabmRFM3NteXJ6NncrTGZFRlVHR1NZWHE3dU9mUFhTeE1kVDk5?=
 =?utf-8?B?N3JORWJUN2NVd21qMUoxRDFOQno1NjN0d3RxbmVwTnNuT3RLMGNLWGw0Q1Bu?=
 =?utf-8?B?QnVydWhabG5wdHlJNTZLLzExbFN2dnVJNklxZXdOVEYra3NoWG5ENjgvaUJE?=
 =?utf-8?B?NElkbklFMzdvaHdiTGR5RkxWUzNQT0Z3RGU0RmR5Z1FKZmczaG5FeWxpdDdQ?=
 =?utf-8?B?NTlnRHZFdjRzNFZWQVk4enR5R1pmTllHQ09rRVRsSFJYRC9WV3c2OVVJSWg4?=
 =?utf-8?B?MEJGQ2RwUVgwZmdlMWx2VWFvbzhyclJqZllOWm5NNmhMSng0K2pybElZdHpL?=
 =?utf-8?B?Q0hWU0hKeGQ5YndlNHlURTNQUjVmcVZqVVZDQWRVeUNwL3pDSGZyMWowL1Jy?=
 =?utf-8?B?V1F3Q3BDeU1CL2llMHZmanEva1dmWnlaVTlqNlI5VWE3bkQrWkczeDkyQUxJ?=
 =?utf-8?B?K01kQmdiKzhTNmhRS3ZHOER0MjE2eUtXVFM3WkFlMUpIaTZUMkE2SzVhdjFr?=
 =?utf-8?B?OVFxVVRsYjRJbncvcWR2V2l4eDJIL3M0MWhOSkJUanV1eHpnNGQzWnJ0MVRG?=
 =?utf-8?B?RXFZYVFlME9ZeThId2tLbzZaNXljdVg4dTZyYTNPUmJpSWFYMVBFT3RTTW9z?=
 =?utf-8?B?SVVLcHRieXNoZ3RuN1gxU2lUbmEwWkFXeFYzbHc2ZWVtQmJScVg0MDNBL21R?=
 =?utf-8?B?bndUTCs1UFVkMTMxYnZqWDFUd3FaSlNvTUhpYkRVSkwxRWVZdFFxaytzWWZl?=
 =?utf-8?B?RVE3WDRkVE5LSGt3Y0l5eGs4MG9PaGh1QWg5UXh1RG9iWXczQmRmSGVUMVRn?=
 =?utf-8?B?aDAzQlo0QWRpbENyWUEvUWEyK2gxV2J4UmVuOEQvQVJpZjdhajFVUlR6anJK?=
 =?utf-8?B?cWJEN3dVQ1dRSmswSE5JSUkwdGovN3RUeHp0QXQ3TG9YL0VNSDV3aVBtT082?=
 =?utf-8?B?Wm9OWjlSMEwxQWlJeXVKK1EwSVkxekdQQ3htUk54ditiem1OVFhDSERTRS9h?=
 =?utf-8?B?Y3hzZFp2cVJKK2pzRU1LU0cvWTR3bnN5RkNyam4rM0xVNEJlNXVtZW45c2JY?=
 =?utf-8?B?aHd6QVVkN00vQTgzSExlbUlGblo2cXJLZW5Zckt1MHJCV3hSN2JQTmQ1alRt?=
 =?utf-8?B?aUE0TzlZTlJRdEJRVUEwTS81ZzJ6ZnFoMU5TeVd2aGFWMy9hVmM3K2pnZmd2?=
 =?utf-8?B?Q1ZIRm9SSzVTRzczYkpYajIveGtwdEYrN3F3SmswRUs0bWp0RDl1U3FORWRT?=
 =?utf-8?B?MFNIZTdYM1FWU3lvRmJJOVBTQWlpNFJYK1Y5ZGNnRWg3c0hRNVhXQkNCVGxp?=
 =?utf-8?B?Zm95NzNablcwZU53aFVobDYrdWxoTHlJOVJLUythclJwVXE1Nm91VVZWaGZo?=
 =?utf-8?B?Z0dYa3R3WWJydzNiT3U3SFBmY3BHV0RkMXZGNkY0S09WRmxFdjhka21xc3E0?=
 =?utf-8?B?UXlNSGFVNnpmVUd4ZWRaY0NrWjlFNFkvN2s1UlJhcldURFJkbkVNZ0trajlt?=
 =?utf-8?B?ZExEMEVmbEtiZEI3bERrdVgyVk9RcktneElIc2M4WDExdDZGYW5BS041SGs3?=
 =?utf-8?B?RHhiQ1U1THloOURNelpoUVZoeGFRNlBHem5IMCtNWjV0OHBpUDhvQ1lXQXRZ?=
 =?utf-8?Q?oAr9v9fkdtH63oQINpad5/m2X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21331b4c-daaf-4c46-aa95-08dc21c1d897
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:32:42.7952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxGIgcpsPSTOiXE2hDR9cN3aD+zklPalN71Mpx1tw7NcjxPhUyenCSbaUXrsf8QVIc8Tyd4Rza81yysWKCONJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
Received-SPF: softfail client-ip=40.107.237.42;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 29/01/2024 16:34, Fabiano Rosas wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> Currently, multifd channels are created asynchronously without waiting
>> for their creation -- migration simply proceeds and may wait in
>> multifd_send_sync_main(), which is called by ram_save_setup(). This
>> hides in it some race conditions which can cause an unexpected behavior
>> if some channels creation fail.
>>
>> For example, the following scenario of multifd migration with two
>> channels, where the first channel creation fails, will end in a
>> segmentation fault (time advances from top to bottom):
> Is this reproducible? Or just observable at least.

Yes, though I had to engineer it a bit:
1. Run migration with two multifd channels and fail creation of the two 
channels (e.g., by changing the address they are connecting to).
2. Add sleep(3) in multifd_send_sync_main() before we loop through the 
channels and check p->quit.
3. Add sleep(5) only for the second multifd channel connect thread so 
its connection is delayed and runs last.

> I acknowledge the situation you describe, but with multifd there's
> usually an issue in cleanup paths. Let's make sure we flushed those out
> before adding this new semaphore.

Indeed, I was not keen on adding yet another semaphore either.
I think there are multiple bugs here, some of them overlap and some don't.
There is also your and Peter's previous work that I was not aware of to 
fix those and to clean up the code.

Maybe we can take it one step at a time, pushing your series first, 
cleaning the code and fixing some bugs.
Then we can see what bugs are left (if any) and fix them. It might even 
be easier to fix after the cleanups.

> This is similar to an issue Peter was addressing where we missed calling
> multifd_send_termiante_threads() in the multifd_channel_connect() path:
>
> patch 4 in this
> https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com

What issue are you referring here? Can you elaborate?

The main issue I am trying to fix in my patch is that we don't wait for 
all multifd channels to be created/error out before tearing down
multifd resources in mulitfd_save_cleanup().

>> Thread           | Code execution
>> ------------------------------------------------------------------------
>> Multifd 1        |
>>                   | multifd_new_send_channel_async (errors and quits)
>>                   |   multifd_new_send_channel_cleanup
>>                   |
>> Migration thread |
>>                   | qemu_savevm_state_setup
>>                   |   ram_save_setup
>>                   |     multifd_send_sync_main
>>                   |     (detects Multifd 1 error and quits)
>>                   | [...]
>>                   | migration_iteration_finish
>>                   |   migrate_fd_cleanup_schedule
>>                   |
>> Main thread      |
>>                   | migrate_fd_cleanup
>>                   |   multifd_save_cleanup (destroys Multifd 2 resources)
>>                   |
>> Multifd 2        |
>>                   | multifd_new_send_channel_async
>>                   | (accesses destroyed resources, segfault)
>>
>> In another scenario, migration can hang indefinitely:
>> 1. Main migration thread reaches multifd_send_sync_main() and waits on
>>     the semaphores.
>> 2. Then, all multifd channels creation fails, so they post the
>>     semaphores and quit.
>> 3. Main migration channel will not identify the error, proceed to send
>>     pages and will hang.
>>
>> Fix it by waiting for all multifd channels to be created before
>> proceeding with migration.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   migration/multifd.h   |  3 +++
>>   migration/migration.c |  1 +
>>   migration/multifd.c   | 34 +++++++++++++++++++++++++++++++---
>>   migration/ram.c       |  7 +++++++
>>   4 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 35d11f103c..87a64e0a87 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -23,6 +23,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>   void multifd_recv_sync_main(void);
>>   int multifd_send_sync_main(void);
>>   int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>> +int multifd_send_channels_created(void);
>>
>>   /* Multifd Compression flags */
>>   #define MULTIFD_FLAG_SYNC (1 << 0)
>> @@ -86,6 +87,8 @@ typedef struct {
>>       /* multifd flags for sending ram */
>>       int write_flags;
>>
>> +    /* Syncs channel creation and migration thread */
>> +    QemuSemaphore create_sem;
>>       /* sem where to wait for more work */
>>       QemuSemaphore sem;
>>       /* syncs main thread and channels */
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 9c769a1ecd..d81d96eaa5 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3621,6 +3621,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>           error_report_err(local_err);
>>           migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>                             MIGRATION_STATUS_FAILED);
>> +        multifd_send_channels_created();
>>           migrate_fd_cleanup(s);
>>           return;
>>       }
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 564e911b6c..f0c216f4f9 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
>>           multifd_send_channel_destroy(p->c);
>>           p->c = NULL;
>>           qemu_mutex_destroy(&p->mutex);
>> +        qemu_sem_destroy(&p->create_sem);
>>           qemu_sem_destroy(&p->sem);
>>           qemu_sem_destroy(&p->sem_sync);
>>           g_free(p->name);
>> @@ -766,6 +767,29 @@ out:
>>       return NULL;
>>   }
>>
>> +int multifd_send_channels_created(void)
>> +{
>> +    int ret = 0;
>> +
>> +    if (!migrate_multifd()) {
>> +        return 0;
>> +    }
>> +
>> +    for (int i = 0; i < migrate_multifd_channels(); i++) {
>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        qemu_sem_wait(&p->create_sem);
>> +        WITH_QEMU_LOCK_GUARD(&p->mutex) {
>> +            if (p->quit) {
>> +                error_report("%s: channel %d has already quit", __func__, i);
>> +                ret = -1;
>> +            }
>> +        }
> There are races here when a channel fails at
> multifd_send_initial_packet(). If p->quit can be set after post to
> create_sem, then this function could always return true and we'd run
> into a broken channel. Possibly even the same bug you're trying to fix.
>
> I think that's one of the reasons we have channels_ready.

I am not sure exactly what bug you are describing here, can you elaborate?

>
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static bool multifd_channel_connect(MultiFDSendParams *p,
>>                                       QIOChannel *ioc,
>>                                       Error **errp);
>> @@ -794,6 +818,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>       p->quit = true;
>>       qemu_sem_post(&multifd_send_state->channels_ready);
>>       qemu_sem_post(&p->sem_sync);
>> +    qemu_sem_post(&p->create_sem);
>>       error_free(err);
>>   }
>>
>> @@ -857,6 +882,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>       qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
>>                          QEMU_THREAD_JOINABLE);
>>       p->running = true;
>> +    qemu_sem_post(&p->create_sem);
>>       return true;
>>   }
>>
>> @@ -864,15 +890,16 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>>                                                QIOChannel *ioc, Error *err)
>>   {
>>        migrate_set_error(migrate_get_current(), err);
>> -     /* Error happen, we need to tell who pay attention to me */
>> -     qemu_sem_post(&multifd_send_state->channels_ready);
>> -     qemu_sem_post(&p->sem_sync);
>>        /*
>> +      * Error happen, we need to tell who pay attention to me.
>>         * Although multifd_send_thread is not created, but main migration
>>         * thread need to judge whether it is running, so we need to mark
>>         * its status.
>>         */
>>        p->quit = true;
>> +     qemu_sem_post(&multifd_send_state->channels_ready);
>> +     qemu_sem_post(&p->sem_sync);
>> +     qemu_sem_post(&p->create_sem);
> Do we still need channels_ready and sem_sync here? The migration thread
> shouldn't have gone past create_sem at this point.

I think you are right, we can drop channels_ready and sem_sync here.

>
>>        object_unref(OBJECT(ioc));
>>        error_free(err);
>>   }
>> @@ -921,6 +948,7 @@ int multifd_save_setup(Error **errp)
>>           MultiFDSendParams *p = &multifd_send_state->params[i];
>>
>>           qemu_mutex_init(&p->mutex);
>> +        qemu_sem_init(&p->create_sem, 0);
>>           qemu_sem_init(&p->sem, 0);
>>           qemu_sem_init(&p->sem_sync, 0);
>>           p->quit = false;
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c0cdcccb75..b3e864a22b 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2937,6 +2937,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>       RAMBlock *block;
>>       int ret;
>>
>> +    bql_unlock();
>> +    ret = multifd_send_channels_created();
>> +    bql_lock();
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>>       if (compress_threads_save_setup()) {
>>           return -1;
>>       }

