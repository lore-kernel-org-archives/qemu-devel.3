Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D627CCE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZkw-0002rC-6g; Fri, 06 Sep 2024 10:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1smZko-0002pg-TC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:16:03 -0400
Received: from mail-mw2nam10on2066.outbound.protection.outlook.com
 ([40.107.94.66] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1smZkm-0005Ni-Fd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGYOYhOkZCsI80x2Xq0XnfQBepbCNsssidaxDt5Bk26bj4qpJND0VbRuSQmH2Xnd1UbysZUy3QVvsbcy02baFlorleiSnDIV9cRwngEdubaCU1okGfycGZHp/urW2zjVcKvvf3wv/WA4bIOKOf1suLEjDdgLchBMCZgbpJL4li1pJ/Jes7ZkGiqUcOy0jX80RxBUhaLY3lyA2xnCE1h1/q2joH120ZNtbkat5OL4kWmizhp+lfmd0FD6yrkMxQSrCvFxAT1GQDmjrGdva2GlPZETiYe5UJr9GfeHnuPF5X9GlqalvaR6UA0arQvMYXmEnLMykWepZzMA1Ek17E6VjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybqvfjho77rYw7a8QyaQprkeThL87LADc029VHgYHzQ=;
 b=fcXvD31Qa84gtQkghGoUHAT8BzHyvyJ7XoqPo9emJ2k2rjbYvZad7vWnsod6cgmGZdSCqAy0OFR0tdLDZbOub75vNyScJdQzlfltV07falSKYH91NutcRNM0Bd1imZTbFceymNDXz4qJ62QhYugLNnQeSpS0Lq85Q9DAplJ01tTp4uGnZjfiLQFVDHrEV7CXrtRAX2NJqLZFb7jky0wjS8tvNzqbbxZ5Xjk5PYrpBr5obZ1P5eteuAsDqcURPu3P6lMxt9nLHGSSIO9Bg+m5g28sImGd6Ek7J/wS8bUpZMsxEO2em6dQgsR1pDmTEPuPDZ6n7seDleCbTkgvQ5fmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybqvfjho77rYw7a8QyaQprkeThL87LADc029VHgYHzQ=;
 b=01wTvqsvaAbQ3/Ft47K3eY+bU8ZhfmtzdGxEtJu1e0sfgcb5O2wKend0qIb2kBWCgr2/ypv3wdl/vTYtRIUiiASGEQEJfO01hadlKZFYHynr5wbHX06INA6GTflKv/eicJ5D2PwVXiXmqzw7i/IZ0JavK4H/bmeyvJcaLv0zG1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 14:10:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 14:10:53 +0000
Message-ID: <e584828d-b3c4-c9d6-da9b-0c102041d9bb@amd.com>
Date: Fri, 6 Sep 2024 09:10:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] i386/cpu: Add support for perfmon-v2, RAS bits and
 EPYC-Turin CPU model
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1723068946.git.babu.moger@amd.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <cover.1723068946.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: e385352b-75d8-42f7-ffd3-08dcce7db7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bThtRk9YbmU1SW1zTEhiQlhoZVNWVTd0Q1NlVFdXMkMxWUZmNEdPOUtIcnBv?=
 =?utf-8?B?eHpnNk96OW5OU3BrL1B6aDJ6L1o4NGl6aHR1a0diUTM0RDdTL0VsOGV1OHBQ?=
 =?utf-8?B?SCtPRU56RitHV3RzR3FYcUplZldEdXJHcGYxZ2FkcGNCdzk3ZjFZWFJQYkRB?=
 =?utf-8?B?MG1xU0NpZXZmbHBpaEI3dUpkakgyb3F4aUk5UnUxMGJrQzJGTlZCMXpzWit5?=
 =?utf-8?B?dlJoYXFtLy80d095blFvTXFHVXAwU2xqbjJDNnZFUXdyMGZUcktseFduckkz?=
 =?utf-8?B?Vyt6ZEJKVmxaT01rcndhZk43MWJGcWZIcGs3dmFmMDlZaFJGTEVPcGRpTURv?=
 =?utf-8?B?VUlsQ1VuWlZ6OUFCU3l5TDJiMHdIK2FWSGJQalZmZE81OWRjTjlsK0tzQUVC?=
 =?utf-8?B?TlF4Q1U5RmRkdTRoNmtTQW9QS21Dc29nbFU3ek5MTzcxb2ptMCt0NmpkME14?=
 =?utf-8?B?RGhDT0VwTTI4dnVXcFVkV1dyUXpZaU5ZaTloZnJqcm81cXE5UDAwUExhNTlC?=
 =?utf-8?B?VlhxVXlxRDZhZ29vR1Y4TzcwQ2FkbHNmY25LNE1sVUVPK1RncWxKOU5PS3J2?=
 =?utf-8?B?eHBlVjBRckw1dWNxMFlreDFlSWx2c0lpSXFzYXBrdS9iS3hhcjcwZ3RmOGJx?=
 =?utf-8?B?ZmpUMWwxa0dCaStYbmxCY0hUeGtBUVBqUUpJdUVGdTdtMlpJbzJsTUZDY09B?=
 =?utf-8?B?ZHRTbjJITCtldG5ITzljaVROQzl4cnBsdGxlOVNCWFlyalEzYjZBclZwODZs?=
 =?utf-8?B?eXNHTFRLazlRckIrSUQ5eWN4UFZNZ1pmdDFlZ05vdUlBTjNKdVB3aVM5OWpE?=
 =?utf-8?B?NzZZQnZpNllTMEtCaSs1cVQyYzZjOEJXa3ZWRm5UOUMvYjVPbmlnVWhiSTNj?=
 =?utf-8?B?UjZKRWwwTFp5V0RVUTVacXdzdUIrNlQrRVBkbHF5SWhaUlVsUWlIY0V1WE5r?=
 =?utf-8?B?SlFMSVRETmw0aGgwSjNUanUxN0o3Ri9zdHQ0eWVaWVF6azdqNkxOSEE3L0J2?=
 =?utf-8?B?K2JRL0o5UXBRVEREWUtOUkJNOE5qdDY4L0YwTS94OFVuKzFmTnh5cEVQYkNF?=
 =?utf-8?B?Ym0zckZOZ3hCZlhFcnM3akxzWk4ycmpoMFYrMzJ2dVJoRWMrQ1dybC9wM2g2?=
 =?utf-8?B?cnd4emtmREF1ajlPUU9OTktaMVVtMHhTLzhDdklXNktkczIvNHBMU3g5RWFy?=
 =?utf-8?B?ZWN4SWV1Y0d5d2NjYmxaMVRVcURXTGJYZGx2QklzVFVTSS9hdTR3TGVmY0J0?=
 =?utf-8?B?M0drSTBCVlQxSWVWY3JrV2l1VjVWcXp0c0RPTkhjK2FkbUxwZHJ1RVZZSWtz?=
 =?utf-8?B?OVN6T21vVjdGbG5KNWpQaFlLaS9IQkRIbTZvNFd1SzZ3cXRIeC9oTVpQRWww?=
 =?utf-8?B?RVFIekIrY2VnR0U2NnVDTVRnVE1oejRzcmFSWHlaU1h4a0NWa2xpTHhZSjJG?=
 =?utf-8?B?SlR1K3F0UUlBSUkxRXFWalViU0FiQS9DNjFqNm83UTk5ZFNwWFFEVTRNSExx?=
 =?utf-8?B?Q0FpTU5jOWV4dXU2NTkwYTdvN3V6VDNiNk1Mc0c3UGdTVmEwemNGZUk4Ny9p?=
 =?utf-8?B?MHJkaUhlcmVvRytOdmQvTDVValZWRTlZdUs5T052ODVKRWhzR09EL3JEV1E3?=
 =?utf-8?B?cXByM0I5aStjMjhTNU8vQzkxK0MyZkQ1WW1qUk1WbDdRdGNyc3dueThwSERw?=
 =?utf-8?B?RjdFT0RndktFZ1FQMjhvaTRwQVpmYUV1RXFibGFnZ0pZdUJja3NUbEEzUENr?=
 =?utf-8?B?N3lhNXhGUDVZWUN2WG9CK2QyQXJBOXV1bjIreGtiZVhsWHlsbW9jQzhKWExo?=
 =?utf-8?B?UURjZ1l1eSttS1hGbkFPQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VS8xbUFCNDRpeG9YNkxEOTk1UDNFcE9yZFJrbjBTMEhldlNpVmZiek9oa0s5?=
 =?utf-8?B?c2tQdUpYQnBQM0c2c1hjOHlDNTZ0OXMxTk5tTDNuVjRWem9mbXUrc3V5aWRz?=
 =?utf-8?B?czVHbThVVi9PRUpVZW1zQ1YydEJHclRicEgzNzNxM1B3ZHBrbzNqaFY3SVNT?=
 =?utf-8?B?WDl2c2Z3eDhGeCtHbmxGdVhQeHA0Y1M1Z21ZQzc4VWdiT1BJWXB3VDNvdlAv?=
 =?utf-8?B?bkUvWmltYnFVbkwrdlFQM0V4VE9rd3RyMHNWL2RLM1NndG1zZUlIaWhFNjR0?=
 =?utf-8?B?Zi9IbC9COGhvMTJ4UnJiWjlqaE5nMHB1cklwSnFoUDhMeU55Y0RzVnhPN3gz?=
 =?utf-8?B?azQyTXdxaGtCbDVsMzR0TDVsTHEvVVYweXpDaitndXBzQzdTYmVtN25PQzBu?=
 =?utf-8?B?VVhybW5hOHIweGUxM0lEaDlqaEtXTDRUK3d5ZHlSMHhZVDFlYzYxdDZrZkhm?=
 =?utf-8?B?WTYydnBoZVZ2cFdHWnU4MElmVHRQY3RDNHBUMUFOcXM0VUJTOXgzNU5Ka0ly?=
 =?utf-8?B?bENPUVQxUlZxZWNaZnU1Uko3UXFEYkV3NlVuRkVGMTNqWjFDZ3hmUWNHRUZQ?=
 =?utf-8?B?R2VjbTFhUDF3UTNUeHZXL0c5cUc2ajAzRVY3dkt1NS9XSGtGczZvbnBvbkV0?=
 =?utf-8?B?MWdKUWt0NWhjTE5mWGh6blozQnpZazM0K2ozVkhqTy9hUTIvaGpJenZYVkxU?=
 =?utf-8?B?ZThwN1JMM0h4KzBLRTNiRzdmdEtTZ09DSktpUDFkbGJxQ1Avc0RVOXZ4Z2Vz?=
 =?utf-8?B?bXRTcWYwcGxIUTVvcnpFS1V2UW5qdkVWWlJkLzNmKzdMNHplbzJPMFdxZDcw?=
 =?utf-8?B?WUp3MzRhN0trVDhQZnVYZ2hxWVFUOUVmM3FBQW05dTlqdXZhSnFvNkFCbXRl?=
 =?utf-8?B?ckdlLzQ2TnZDamJQYmhMMURTSWh1VmtDemhqYU9nMFZHUjVhVHMwVWFVR2hM?=
 =?utf-8?B?emo5UE1majBZcjVvMzZZVEdVaDdhdEZvSGFWeTFheTlSY2dhRXN4andNcDZ6?=
 =?utf-8?B?UTI4eEpxMFkrV0hzY2FWTTFzN1BIdVhEWjBXSXI3d0ROMS9NTlZWZ1l2QmZJ?=
 =?utf-8?B?QTVKUXp4cGVwNjFMUktBcHY4TmNMbWhQd3FSNFFZUFY3bEt5L1dhQ0pMQTlO?=
 =?utf-8?B?TmNQT2hFWjh4dGhGVmdZWkU4MHNWaGJhd1F4L2xXN0dySlU3bi9GVmh0RVZD?=
 =?utf-8?B?MlFlNmc5MExxVjFZVHVuWjdDblVlem80SW1DaGZMN3Q5OHUzTUZGQzhjRlNP?=
 =?utf-8?B?TW01ZG1tM01wVjdaVUVQVXN6d3J2WFRNbU0wanI2SENFaHcrdjRsall0TzhV?=
 =?utf-8?B?NUxFSmEwT1JnbWRyNk9nRElYK1BrV2dYb1RPS1ZLS291NjN0djJzTUpwMm14?=
 =?utf-8?B?N05CTkN1cTZ6Tm9TbGV5bFYydkc3Q2Y1ZEczMUxrSzhrSVlNSktRVkhBMVpo?=
 =?utf-8?B?ZUl4WS9pT0htV2NGSHRHenhCR2ZUM05Eb0RUcUR2R2pERUtKbEZBT0JzNXJv?=
 =?utf-8?B?YVJSODlBazdnKzJ5VndPaStXeFdhMXdBNk9IaUh4aVlSLzhVdzRRRmJWV29l?=
 =?utf-8?B?R2VGVDYxTzJnZUYrS1NldVVpTVN4dXRCWDVDd0ZmTDY2dCt6OXh0T3JNWU5E?=
 =?utf-8?B?Z3d5eTh3Z1JMVjlkZ1ovamE0K0dTVDdzVzFOQTFERWhQTE1vUmVuL1BXSEs0?=
 =?utf-8?B?VGMvVy9IU0hyeFdVMGx4eXFtdWtacEVwcHRMZ3RuZ2p6bkRwcFFOTEhDZ0Jm?=
 =?utf-8?B?ZHN2azdCMEZ1aytrUGZlL1JkT2FqL0xvS1lvRmsvQmxZYjlkc1JJS2RjTVBk?=
 =?utf-8?B?K3Vic2l4dDFyZGlBTXhtUFQ5QkhFckcydVd6NWR5aHNvc0RROFZZblBRSktV?=
 =?utf-8?B?RS9uZFVnR0lxaXlKTEVxbkJoQ0Q3bGZieUlnTzN5U2k2bmQ4L2N4MHo3NUlq?=
 =?utf-8?B?ZU0rTHJpZHhUT1ZnTXA1UzcyQWRqZFUzVVNWRzQ0TnR2ajJoRThNR2dYVXdm?=
 =?utf-8?B?V3JqNlVPQkU2dDZHMlNoTFJ4bXR5SGRaQlFMOTVlRC9KR0tIN1VkTm5aK0tk?=
 =?utf-8?B?TUwvb3VLVFZSZnQ5NWpPM3kxaXdOUkUxd2szWSt3SDhtTTc5djY2MExuMi9P?=
 =?utf-8?Q?3ZZ5IHKRB6MvHs2LUr8NBCEgI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e385352b-75d8-42f7-ffd3-08dcce7db7d0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:10:53.2442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGVwsChAMUgRh1ifp9EmkDBgRkPXqaE8Y1E14GfmUchSEAoTp0iyB9YJxVzxYlAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
Received-SPF: permerror client-ip=40.107.94.66;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.9, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Working v3 to add few more bits. Will post it sometime next week.

On 8/7/2024 5:15 PM, Babu Moger wrote:
> 
> This series adds the support for following features in qemu.
> 1. RAS feature bits (SUCCOR, McaOverflowRecov)
> 2. perfmon-v2
> 3. Update EPYC-Genoa to support perfmon-v2 and RAS bits
> 4. Add support for EPYC-Turin
> 
> ---
> v2: Fixed couple of typos.
>      Added Reviewed-by tag from Zhao.
>      Rebased on top of 6d00c6f98256 ("Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging")
>    
> v1: https://lore.kernel.org/qemu-devel/cover.1718218999.git.babu.moger@amd.com/

-- 
- Babu Moger

