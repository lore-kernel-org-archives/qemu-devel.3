Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2CDCD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwW0-0002PQ-Ed; Wed, 20 Mar 2024 10:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmwVv-0002NX-Nd
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:01:58 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmwVt-0002NH-J3
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:01:55 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KAOU07028145; Wed, 20 Mar 2024 07:01:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=Pj6gXs9NzXpa
 VvOjfyjcoaSJXJ55D1v/83zFfobUACk=; b=KR4FT4/fLSwpUahiw4Ok118fTJnL
 THcC1Cj0h7pNp3+ChulluH0LhBP0b0JKSZLS8wEi2Ve7mU9W0u3DE82Gl+q0R2+S
 Thc0faUPMzoL5ni9y/HlrVUSgBT89OrBpkU1KJlN8gdUDeEOTVZ24jmDXH/FYHjB
 KzpWe4pvtkCsedc1jKpfPf018ywcI7I5r5dA9AM/2iODwjDUs17f5uJNADqiNOgg
 F2MuALFbljCUyE2EkEtKrtG3lZbhlUhY/axNMqnOauVDfZRLyh+GEgP/+JA0/C9v
 GjrSD7c61YW9NYymLwITZFCepaAUDITEH/BdDZYXPihjZj0n10u5DNWqfQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqmsr8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 07:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXweywa4+fLd/H/cpyfXZvFOnUMgqFwG9wIJ+piQQexovcEftAWKr+93gGXmh1b5tBDNX9FzPQWyRCZTQT444NOZlP7yiKZVFBkJ5sLpg4KMh37yZ4RPhirvs6zbdzk5prMjwRzDsPcyDvJJlXOIw84cVgijOKF4G6KI1gSfE0L1UTbFh+Qn/mvzbc5WoaYyVC0TDnaCcatx/0jwWxnXsBqQzITkpE9iwKf+5ysjEVGOvRiyj/QwjXKZwFpb195C3OMBGnlqACSuD+UDBOte9H/uK6SvCq+6M4FOJ5sAqeJM+z2kS+xH0i7rmxX4Xg7/TCqhipcQ2LSGF3qsxgFPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj6gXs9NzXpaVvOjfyjcoaSJXJ55D1v/83zFfobUACk=;
 b=EnIuuzUV3DYfXMGRxpJz5gP4j5I//WYurYxFy3Vl6WsTQ2lB7o74nyFR0N1eB7aWr9svB8da/9A5atnwEi6nf+rmTuvDS9a2pTm7+t2dyr/zPaXVp255iNaHLg+mDr/KY4VTZrRX5JqNU+5ttxtoy0K25vXTn/MTcqIh0ewQsL9WvHZ+km5sv/KKP+E7b835ffBpKhFoDCgElx86JCH5LiOVAVNws2ND8PW6rmHiqfi9yaEkfoBCBJg2vXqwff4eSnO+ItsLRvIzHq+llioPBabeFoQfSfLqawYaNAnZH3jVJqbycD4OBhBQkKCHcAVTM6o+x7/npu5vgXhKUmZOEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj6gXs9NzXpaVvOjfyjcoaSJXJ55D1v/83zFfobUACk=;
 b=OwdpC/4cA4U7UI478SnVeDU9TJtTim/6P4sqgPqmp78mNKFg3CjN24RnSq9alt09TrDLeFzmP5cBDh18yZX8JX0wwg2Q0lKLw5iZ7tWJ1piegW1CjWajH3e9vxPIXnEPp24zdAvW4iFtgJz7fdTFym4o6mvADPqqrLGyaMxR36KFUOZIzs6eicIVRYKAphaIVc4Jw5lWiJXaGdKh1Oe0nyklS4bFw90Oohn5y8ZI2+s9MsP5OenifIKo4uKKIRIOezTEvXXiQcHbuEg/UHadi7HN4GQ3UIpt8s+dnXr3hq42evR5Ouaknu1ezABdH0Q7BSxEbwMKMCJhfD/argnDXg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB9489.namprd02.prod.outlook.com (2603:10b6:610:12b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 14:01:46 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 14:01:46 +0000
Content-Type: multipart/alternative;
 boundary="------------wP5topyujGalIlY0TsbV47wv"
Message-ID: <e96ddca0-6749-4750-9b5a-ac42fbc0d4ba@nutanix.com>
Date: Wed, 20 Mar 2024 19:31:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20240319204840.211632-1-het.gala@nutanix.com>
 <ZfoKSgJ9LN1Q7R1V@x1n> <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
 <87sf0lm45x.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87sf0lm45x.fsf@suse.de>
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d341124-37bc-42b7-e85e-08dc48e647b9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99PvY4aK07k9u9l0WdcmjxWDsoQ77Z9UACuwP+OOJDkOq3tYxNT0/mvuFltVTN+junJcz18LpNi5ejZ1wIhOTk1hGhyjuO1lL3DAd29Al4jYrqi7Rgj/7CLK4XmokEvvINdF8fd3Mr6WT5vwMfi7zgnBA84n3FkZqCe3gBPs9idKHOXyw0LWnurqYSKyL5M1GghLC2iDEsFTO5Mnb8B4WxYIhJ9i6IvzCZnbF9CS/AIwSjL6X5BcriN7qThTTYT/neOsvxhsDPL/5esROWfOBG2JQHCl3nnlwdQseKr+X2cryQzSF/MFci2rR2nf5CCNbXMmJyVl+OFEL4+4u6MTuEoGIV1D0r7jYLGM8DWhcryJw1ML6lcfa0fnKwmytTVNDqMHmZHP59TnpYI+PsHRckQRL0xUISMhJ3hKLftWqWnIVTWaIZEPAaEZEI5omzSyotOxNixDGyG1zg3BdvlbnHaNPU1Dxrhz8W02lrcxWI0v8pM5kdgBkIIBJKSxJcATkBcGJDfCiNCaPgFPJygVMVmKZAZDmCL9Fs2wxIvUQnmYG7ZKAjaQwODdeEhrIocLVGn3wzwlk1UaZSgqutGo44d5mmFxeDqLxAcQHBRyo4q2/7hEJVxQ0LXO6NoJ+nRGTEPA6+KFUw/T12Nz/Epef001acVJ3g4jiJDPxFMAqqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnlxR1RFM2JXeGs4clBrbk0vc0FsZ0RnTzZXNlpCc0VZWjFFRFd5N3Irbzlp?=
 =?utf-8?B?bitKVk1zUWcrMytNK0ttei9FRU5TeFhkb29UajRNUEtIaWNXc25XK1RubG55?=
 =?utf-8?B?b0FwUytBZ3dWZ1FBY2k1ZTBFWlNpek1OQ2EvZFl5Y2hGaE1vSHBOUkxMd3RM?=
 =?utf-8?B?VnRrM09hWEVoOFYrMVlIcDF0TVl6N3UxQXprWEhzSm40Z2pYWjRMRlBmUlND?=
 =?utf-8?B?b2NaM1RZTXZHeGptZU83MktnSG9zWmRBcUZkTHM4dldBaUFwZ2kwSjQ2ajdt?=
 =?utf-8?B?c3JMZHVZS2YvQklTZEVWYjY1Rm1YclIzMWx5QW95NUhQL3lrZTZ5VnlBUk9B?=
 =?utf-8?B?SVpTeklPNEt0WUJXbzhMYnZ6TXRubUNnbWxvMjJWUGhqa3BWdUpNME9MQUNs?=
 =?utf-8?B?ajJjUU5ibGRvN2lVM2pTYXU5MGRwUTNQQ3hhQU5JK1RkdXlpU3JzTk0ySzFH?=
 =?utf-8?B?b3M2cXlQeHFhS2R4N0wxcnVIdWpJbmxGazlLc25oc1JjUUFZczNJV3hadmVv?=
 =?utf-8?B?L1k2eTRCYmwrTnJvK01zdGFQdHdzNTdDb29BUGpCanQ2MXJDTWNIT2FQNzA2?=
 =?utf-8?B?Wi9ZcUJnYitTUHR6bktIU08zUmlycHpzaitxRy9hdzU0by80NDJYRVFyOG4r?=
 =?utf-8?B?dCtvUUtxM3B2V3hmYnJHb09KS1k3ZVVUYWNFK2IrbmFBcld4TVlrUjZaOWVN?=
 =?utf-8?B?dWEwYUptWDdRc2RiUWQyeG5hejJ1TkRXdGVZYkh4WEl6ZWE1YXZuRGo5K3hK?=
 =?utf-8?B?dlRTZ1NncmtlcTIzN3FQcU8xUlAwNjczTWxBWHZxSHM2SE9mWU1CYzBUUUhN?=
 =?utf-8?B?UFVEY1dNbktYelF1dFNjeVVNQm1wNFdoQ0NaUlh3UUd5UHB5MU5QaU4xZUxT?=
 =?utf-8?B?SDBNamhwZ3NPYVBCN0Vra3Q0WnM4T3M0TUtOSm5TRlRyV0FDSFBiRXN5cnJa?=
 =?utf-8?B?VnE5cmNHVlBkdVA5VlMrVzZwT3M2MW5kM0ZDQnZWc0pkSFAvQUFoaHpBVVVO?=
 =?utf-8?B?ZWZoR0dTVFpGNDhkL0MzVEdhMm5tblBtRFhENFFpT09sdXIxKzUvNG5ESDR2?=
 =?utf-8?B?RmNiUExpaXNDMzhkM3RvK3VzTXg1NVUzNDVacUxsT29sSVVxZmovQUpLZXZR?=
 =?utf-8?B?TllkZ3dLNmdQN1gvQnJGa2k4NUhlcldrbldDTEFIVzVyTG9qcFZHa3RGWk13?=
 =?utf-8?B?ZkRUNGlpeXZCZVI3ZjJBZ0Q1b2o3allKZGkzRXFQWHRibldRYUg1OVVSWkpt?=
 =?utf-8?B?elNoMEUxUTBMTm8rek9xVzEyeTJLTWpKeW0xOXRSeTF3MDBtTEtXbjU3cWtB?=
 =?utf-8?B?a3pOZ0F0NEt2Q2xzQ2lOK2c2ZHlNR0R1cDRpc2dndU5tb08yTEgvdURBSXBm?=
 =?utf-8?B?L1VVSVlpMy9BUnE5TUd3eEVSN3pMbDFEdVFZUDJaZTY3aUl6UGZFejhkNWVD?=
 =?utf-8?B?U0lXQ2UxSmdOeTEvbjFpMG5sMTFwaTQydUxuU3lwQXpZUGQzaGlTTVhoKzcx?=
 =?utf-8?B?dTFNTUtRd1lXZ0E4UktLcEdJRVBBSWY4VU9xK2IwVUlVOGM0M0lrdkdkQU5K?=
 =?utf-8?B?Ykd0SkJWVUcyK2ZrUC9UY2RxazNWY3p5VEJ4SnRNSW1vY1ZMU0xsbWxsT2Jr?=
 =?utf-8?B?RUpRckFuQ0Z2RDZIZHE1d1o1RUE5dUJrNzZxcytIUzV0OEN5Q3BlQkYvY1Q1?=
 =?utf-8?B?dlFZQmFzVERSVEVKRnZiQzE1Ty8vZXhHelZsNG92Mmd4WmxyQTh0SytValhR?=
 =?utf-8?B?bE5PWDltcTkvR1dOVy9qdndSQksxYm1RdEoxOEEvRkpKMHVETjhlOEorQnJW?=
 =?utf-8?B?QWpVSEU0Ym1oaUNuNmNQc2ZPRmJ3YVZHcVh2bG5Kck4yUmJRN3FJUnhOWWY3?=
 =?utf-8?B?dmo3MjFFQ25QRmdaYUhpWVNpWWV2SVJ5VXYybkhIK2VEb3JKKzl3WnhNOEJu?=
 =?utf-8?B?UnZrRGxzNUVkTkxWSnB1Y0twWkVORWkvSGZPeXFtTVFjWWxTNUp5ZUFHUGlh?=
 =?utf-8?B?VU91cG1DTmdUOEY1OXBVSzlXMk9wMXVpeUNOdXlKRDdCTEIxMVNVUlJ4VGg2?=
 =?utf-8?B?RHVZNVFZaGtqNk5UejhSZTczVW5FZWR3aHh1REp4S2Z2L0JnUktSYzRiQUhC?=
 =?utf-8?B?MmtJM0ZqWUpQdDZyZVpLRmtuNDhQZlJJdGF5a2h5cTNpTUtEMDJpQ1A0Tlh0?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d341124-37bc-42b7-e85e-08dc48e647b9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:01:46.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gewlz1Q3UCpb2DsanU7D+vuLrcpLT1mYT1NO1MTZW6b+eHbCjz3ErAEEjLBQt7/alDiv3mfoJxU7dCHWlk2tRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9489
X-Proofpoint-ORIG-GUID: 05swf-nStBtOa5hsub-CDg1ze7s-oYuE
X-Proofpoint-GUID: 05swf-nStBtOa5hsub-CDg1ze7s-oYuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------wP5topyujGalIlY0TsbV47wv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/24 6:49 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 20/03/24 3:27 am, Peter Xu wrote:
>>> On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
>>>> 'object' can return NULL if there is no socket-address, such as with a
>>>> file migration. Then the visitor code below fails and the test crashes.
>>>>
>>>> Ignore and return NULL when socket-address is missing in the reply so
>>>> we don't break future tests that use a non-socket type.
>>> Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
>>> it'll soon crash at some later point, no?
>> It won't crash IMO, the next function SocketAddress_to_str for a non-socket
>> type would return an proper error ?
>>> IMHO such patch is more suitable to be included in the same patch where
>>> such new tests will be introduced, then we're addressing some real test
>>> code changes that will work, rather than worrying on what will happen in
>>> the future (and as I mentioned, i don't think it fully resolved that either..)
>>>
>>> Thanks,
>> Maybe, Fabiano can pick this patch, and add along file migration qtests
>> patch ?
> Yep.
Thanks
>>>> @@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>>        QObject *object;
>>>>    
>>>>        rsp = migrate_query(who);
>>>> +
>>>> +    if (!qdict_haskey(rsp, "socket-address")) {
>>>> +        return NULL;
>>>> +    }
>>>>        object = qdict_get(rsp, "socket-address");
>>>>    
>>>>        iv = qobject_input_visitor_new(object);
>>>> -- 
>>>> 2.22.3
>>>>
>> Regards,
>> Het Gala

Regards,
Het Gala

--------------wP5topyujGalIlY0TsbV47wv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 20/03/24 6:49 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87sf0lm45x.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 20/03/24 3:27 am, Peter Xu wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">'object' can return NULL if there is no socket-address, such as with a
file migration. Then the visitor code below fails and the test crashes.

Ignore and return NULL when socket-address is missing in the reply so
we don't break future tests that use a non-socket type.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
it'll soon crash at some later point, no?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">It won't crash IMO, the next function SocketAddress_to_str for a non-socket
type would return an proper error ?
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">IMHO such patch is more suitable to be included in the same patch where
such new tests will be introduced, then we're addressing some real test
code changes that will work, rather than worrying on what will happen in
the future (and as I mentioned, i don't think it fully resolved that either..)

Thanks,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Maybe, Fabiano can pick this patch, and add along file migration qtests 
patch ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yep.</pre>
    </blockquote>
    <font face="monospace">Thanks</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87sf0lm45x.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
@@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
      QObject *object;
  
      rsp = migrate_query(who);
+
+    if (!qdict_haskey(rsp, &quot;socket-address&quot;)) {
+        return NULL;
+    }
      object = qdict_get(rsp, &quot;socket-address&quot;);
  
      iv = qobject_input_visitor_new(object);
-- 
2.22.3

</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Regards,
Het Gala</pre>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,<br>
        Het Gala</font><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------wP5topyujGalIlY0TsbV47wv--

