Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF1FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnrF-0003bx-SH; Tue, 26 May 2026 05:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnrE-0003be-Ei
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:13:52 -0400
Received: from mail-westus2azon11012008.outbound.protection.outlook.com
 ([52.101.48.8] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wRnrC-0006Cm-Uw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc3jxs8t05TPYYIR0fujkrs+w2eU0GJ1hZIL6/t3VpOk7a9IJZDN+zNtQwDdkbwmuzJh8BnVT5nJWy6miqvXEveFJ94HQ+qxpJAI9KSTfvGLE8vfX5KJYWahVl8PYLrhmlfExoVa/JiYWrJmVZ3ja7pSEUlHlthlhrDPu8nzRTgN6yPIcPm+qtlIA9jVJ9iqEsXmaJTfwbmPk2PoyjPmzBA7RmWh/gdgopAJ3mc+1B0vCCQULlOcGjdvY28fOQ6aPgZYjJrPFh8LlSHQXKGOTyItOifnMV9/znvR5t76ZQV2atOynvdHT2imjc36Fs6ky6QTeGWmpxA3HrWP5X5yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4NUSUWenEtUbWArbrJHCCTBmABhjGVR1U3zvPrfr78=;
 b=gaWu0424GcFFOjU1w4CPYkBfMubqQPV6O+fT71m7b2//i1kBNfK6x/Yitq6islbLbCwiAX9+rtsdcQmcSrRUyGoluqfgntpYLPxRY4wwIP0jMHt9mNSyVLcSyAH3/o/OuWDVLEFh7S2IR6PVfqLr2CU4y9PhSrUqmsFjR3axnsUetzKNd0/D6dSfzaS8BAozy7x0OyYLxh6v27B3TqoT0/ZJlRblP+Vyjhi3urVrXuT+bIp9GCIORX8w6hFLEBDoQRBlIfz/MCQHF525hBA4TWZF5PKSPZf/F6A6+/XA+weOret6fFV/0DhtI/88gAROCyqKMtYr4AbysY00t6zaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4NUSUWenEtUbWArbrJHCCTBmABhjGVR1U3zvPrfr78=;
 b=hsJc3x2RI+TjjutrOM7d/dvS3eyH/lFqJEg7axejR5kD4BMw6iVAjslPiQBDivlRdeRNWjV4IGlczMqn5IhgjicvdHzSzoyM1YdtcNNiCrC1cuoW4LwO5ijjBkAv9vxtydDFTlvtWAwe3o0rrvLe1PxoYqOLoWkkTnkwmNs9vDae9tvPCV6vpPwgYonSuVHgF6agudhDiKbdf57bMjUvdZwsmfrFkIAi7VYlvGnz9nwJIy9nDSpJJtbe1orzDsKHP1fs79n9IynyU8JwhzgbrhcJhS1neTjaLPzP+MocRFMbGvkY2fbHGTYRVE8n3T8bR0Nl0ehSPOaGg3j0b4xheA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:08:42 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:08:42 +0000
Message-ID: <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com>
Date: Tue, 26 May 2026 12:08:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-8-avihaih@nvidia.com> <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com> <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com> <ahRkT19AVwi4SQA9@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ahRkT19AVwi4SQA9@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bb23ee-afa1-41ad-7584-08debb0661d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 7OZ4mXBJhyDOP9sCn1fRfnDV6k1gWjTqoW+i08qa8NobzIr+LuQu10w502hWUEeDEcfGTCsKeAvLw7hprwz5Az5pigyiLaPUfmRwkNA8Q/k/uydyiY/iy/NFJjuzP9yB7u99j2udbDBWsBIaFsXMOlbSzIW2MnQWcxf/WupyXbEH2uE2LU4MA+Jqjkqs3WBDPNK31TO5EmvYUr9jRwIqHiU0AR9dORRaac5crJ31PZptttabx8x2lg+1AKFvjfMQTnHX22Z+XMDLqBdWLnjNdDuvVXAghtZMzTz8QAhSjdXPnhznZ6ohRxJEnNirCpqUVIJXHUXqrhusTcN9eLP+kLMVN1CsHRRQFQM1KJT3Oj0oyoeSXpAEXyH0ockMRbx99AWcPBVVVR6Mu5C/nj1p+wau0qJZpFQbdczulfA2TZ9/KMztjMsoDEF+AF4j9mmSq9xunDtlwa1d5K5Z8/vMKhc+n90uXClmF5xwixapnLBhfXumo9K53oeCyzA3fjYDw/jB8gRdt1XFMS2IAgjiXZynMsbcSlOQb6vkgdHaVAsSqKsnqVfGnhrSbaB5I73AFmHIL5m5CfKwTpuwPsxk/nU3BGElhhh5uXzX9JiH8Kq+D0I6PqHrlC5N/B3sSwpaO5L24x61vJqS0bnR900V3gjyMJnBQjP/FPc8NJl2aZ3i8jtUDr2610dNF7Wa7QV2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2oxdHZHLzhLUlZSMXlZL0k5QVg2R0dyVjZLaHZzeTFMdlZmbWgwZTJCK3dR?=
 =?utf-8?B?NVdxTWR3emkzUFF2OTE5eWEyeDFIQzBxSGdKWVdadUczbzZqR1ZBeEh6TEMx?=
 =?utf-8?B?K25KVCtiYUZHeTZxTVVIcy9JbDY0QTRWaDhpVkcvc0pzblNicjRhcWtzQW1s?=
 =?utf-8?B?RVp5cGRwaExoaU5zWjRENzcrdkZNZmt3M3pWcE9iU25SZytpYXVnZS8wSGgx?=
 =?utf-8?B?N1dFdGZCaEhydzJGYlJmeGxQM1BTUHFiODZjcmwyUmNLOUNSVTU4V0JrUG5D?=
 =?utf-8?B?SVlleEtnZnhiVGNJbGVMQnlsa1lmYWxMWnpLcDVXVnVFNytqdDZlSHRqR1hG?=
 =?utf-8?B?NkUwMjZCc2J6MUhZRUNpeUZoL05rOFpHb1k2MVVYS0x1bVFyQmE4OU5EdVJq?=
 =?utf-8?B?ZXJCKzFBK04wZWdoZTlkclcxNXBDNFJaTmdCWThwK3VJVlh5RVZDMjB2VndN?=
 =?utf-8?B?dGIyRU9wNU1FUXNwZHNsZGJvSVphc1NIVXNJYTM5bGhmaWVWVms5TDZkeWR5?=
 =?utf-8?B?S0syQnRtN2ZpME5hWXd5b2lQeFRYcnhWNFJzY0xZY2tEd3doUWZicWV3Uisr?=
 =?utf-8?B?Z3dXOXFqYVd4S3ZOY25DQ25nbWxUaE4zckp1c0VGaVRnenozMVFCUlBiWlRx?=
 =?utf-8?B?ak5KT1R6eVUzZEF2RWVHOTE5OWNxZnNtSm12c0N4N1YzTUc2bWdZUmVwTXB4?=
 =?utf-8?B?YlhnTmlYQ2NjUGtLNTQxL2JVRS9SblB6U21KSkVnWnJmZG1DZUw4dGZsSlg4?=
 =?utf-8?B?bnlkQTBSVE5UZ29QNFZiamNFSk9PUDRvWkE0NmV5dk5HajYyVkEra3lMbjlX?=
 =?utf-8?B?Nm5MdWhFNDVpQXVZcWVUbDRPMW12b1NGOXN3STM3dTBBR3N2d1p6U3hnMGEz?=
 =?utf-8?B?dy9pNG84MHB6QXN1bkx6ektpVURJeWthWE15WXZGczBNTEMrb1czV0tpQ01v?=
 =?utf-8?B?NzVUejlIeDQ3bm1Da29GQ3RHNDlxeWZBbDFrVTY1RlR0Q3FWczZ1YjNWQnpB?=
 =?utf-8?B?Wi8zNTJ0NmJLQnRxT1p5eE5JRkhmYVIzTG9hYVl5a0hyNWRkMlJEa2VobEIr?=
 =?utf-8?B?dVhqK2o2UlRvQjhHdXplaFNVWkZOS3RvdjBteVJPNUtvRGFCNGpQN0I4eXF6?=
 =?utf-8?B?UzBUZzR1RGpzenBaaFdZRE9sOWFxTmVnekF2NmpIOEJKRWxYOGMvU2VLdUdF?=
 =?utf-8?B?OVprZ0VaK3BITzhtaDZhMnc2K0xxVmlBMmZrUUxxcEFTY2g2eXVqU2ZhUTJw?=
 =?utf-8?B?cng5RHZxa0wwVW4zblc2MVBxWXo0MStUcWtQSVdFR0dIbGRIdXlUektoZ25z?=
 =?utf-8?B?OHhMb0p0YjVPV1p2Rml3eElhZ3NsakRnVlhvV1JaMVdEeWR3bGdNcWpHTlBL?=
 =?utf-8?B?Y2VjeTJYZnVJQkxXZ3FBNlc2MGV5Q1VSVHJsdHhoLy9QWFl3M3RyZ3NRQ3By?=
 =?utf-8?B?QXl4ZnZSSVJLTk1OdFdBa1FZWk9BSzZXNm0wQjdndmVDMTdUSjF3RHZTZ2gz?=
 =?utf-8?B?bWtGMUh2WU1hODkwd09YK0tmeXJJVjdJV3cxMnBxM2N1QjRqSHU5dS9EUitT?=
 =?utf-8?B?N1ZTdUZ1U1htako1TThSbnZ0VkhPTEx0N2w4UWc4bU9jQW9pT2NHR1lkR2Ux?=
 =?utf-8?B?VksyQ0hMeTZqRG1LMmJ4a0FETU9MbXpGMGhIZlE4SWNHNkxVUmpUekNSNjNz?=
 =?utf-8?B?NmR1bnc1SVBabTBuR1F2U2xpcDJCNVQ0dUdkSW0vRWRneU4rd1J1bHRwR1lU?=
 =?utf-8?B?OFp2N0hRNHJrTFJWenVnUStxMk5MU29QeXprWnpWaEZiSm41aVJrc1RSL3lW?=
 =?utf-8?B?dWQxd0h2eGpyWUNmRWZQM0Q2YXh0TnoxbTdMVUc0cnRLcjNDOG94NDh0a1p1?=
 =?utf-8?B?M0ltRk9sVU1sYmNqUE1wZ0VNRHgvTFo2Ni9DUkpaNjFaUmJXdjJQWS8yU3NB?=
 =?utf-8?B?RGQ2Q0c3OEFSVlp2c3A1YWI1aTlJcjl1cXlmUm9tcmRIY0E4QnMwUkl3Z1po?=
 =?utf-8?B?TDkwR0EwdHJ3U1ozUTlJU3BXc1MyNmMySEpSTFBSeG9RbEUrRlVjcWFxa1pF?=
 =?utf-8?B?cEI4S0JNNThZM1NheDI3azRvV1FIcmh5STFCQ09ONkNhV0E3MU1EdEVtOFFL?=
 =?utf-8?B?dE9MRmZUN3JrUzhia0dqNVplM29sUnZYVHZLeHBkTEdkcjlMd0dPTy9QdWVU?=
 =?utf-8?B?dEI5bmdxbHR2Tll0S2l2NGFwWDAzL2xIbThyK2JCdEIzZXJWdk1iMWxoSjE0?=
 =?utf-8?B?OHc1b0ZkR0RUWnR3TUhDRmhybDZkT2dWaWtwLyttOHI3YVV1YnB2TjhUZ3NX?=
 =?utf-8?B?cUk4MlREcVZkbVlYelFPelN6cFhUL2grZ0gwaTFDdm16S01pS3p5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bb23ee-afa1-41ad-7584-08debb0661d1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:08:42.0463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Crz6ojJ78Y/Cv6/z4E6lJRkuvv4fGdk1UtL+4dQ677Y74Kru2EQgYjnrUv/tGtuLZF9dbxxfvGnp5ZR5bOlCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
Received-SPF: permerror client-ip=52.101.48.8; envelope-from=avihaih@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/25/2026 6:01 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, May 24, 2026 at 09:34:48AM +0300, Avihai Horon wrote:
>> Yes I think so.
>>
>> We just need to indicate modules that it’s the last query during switchover
>> so they can handle it properly.
>> Do you think it would be reasonable to add a "bool final" param to
>> save_query_pending handler?
>>
>> For RAM it will be used to indicate we are running under the BQL (since
>> currently save_query_pending runs only outside BQL) and to pass the proper
>> last_stage param into migration_bitmap_sync_precopy().
>> For VFIO it will indicate we should not do a query precopy info ioctl (which
>> is only valid in VFIO precopy states, not while VM is stopped).
> Yes, a final boolean sounds reasonable, implying both (1) last sync before
> switchover, VM stopped, (2) BQL held.
>
> For VFIO, I double checked the complete() that does not depend on the
> precopy_bytes fetched, then it should be fine indeed,
>
> vfio_save_complete_precopy():
>      do {
>          data_size = vfio_save_block(f, vbasedev->migration);
>          if (data_size < 0) {
>              return data_size;
>          }
>      } while (data_size);
>
> It's just werid to see that it doesn't depend on either precopy_bytes or
> initial_bytes, even if logically it should.. this will be confusing to
> whoever start reading this code.. but I understand not much we can do with
> the current kernel API.
>
> Side note: should we still better update these fields to make sure they'll
> be zero after migration? That means vfio_update_estimated_pending_data() in
> vfio_save_complete_precopy() too, with/without further sanity checks.  That
> seems to be missing right now.  I'm not sure if it's intentional.

Yes, it's intentional, since we don't use these values after calling 
vfio_save_complete_precopy() -- they are only used for downtime 
estimation prior switchover.
Precopy_init/dirty sizes are zeroed in vfio_save_cleanup() though, but 
not stopcopy_size (however, that's benign, since upon new migration it 
will be reset before used).

So calling vfio_update_estimated_pending_data() here seems redundant to me.

Thanks.


