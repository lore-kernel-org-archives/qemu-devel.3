Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF27C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERNR-0003Bz-AW; Tue, 04 Jun 2024 06:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sERNO-00039X-Qa; Tue, 04 Jun 2024 06:26:47 -0400
Received: from mail-he1eur04on20722.outbound.protection.outlook.com
 ([2a01:111:f403:260f::722]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sERNM-0005lh-HX; Tue, 04 Jun 2024 06:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/QFjpWwiHmX8SO6lS2Eej6aLdgOdpRJW2s4iDIE2aMIT9KEmPrzJQHWiXkYwZXozQkDz74O+VW1EuKIKGpZry0C2w0ZCqc9UhPZKmYzTeVYdHND1T3sIiE2A/UtajK/62Q6X+4fPW2QCmcrjw3p4PLhW9+FkjQphUrJKIz+KPpWezi5H43DWAtFDXtEO0XdEf3jnE7gwJV3WYJ4DgCQWNlqh5ij3joDO5cjBt/K/NWdcaCRwhCiITEtg6oItH00M6Wvj/GTRB8tGZWoK8sh2m5tqViT5AjqS9/zPwzzfdI6ZQPCr/mQh9fUp3Msq6lES0WTg0MrBJdCgksmsdZQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULwDOrQH0qb35fOeLGWJmnUWd8DsChq/bvM87kJrqT8=;
 b=SBC+l+LOQzO/2aBo0lXufZn3lviB9fPKP5cBksowb+WsFWoPDbpMcGO79XCSfOY314rhIAprxD5HFwhszbkarCcUkxonLrXj4W7eRYDDphm0/BL0bBcjAI2feej1b62qkjcOTqg0twM7slRbpoYcIheu8y1QsuOhGZmffg2eemgwZds2k4CVScR42fsLlszfnvv/g9pUuMLmcoyHMdDdCYQYnRHPTeuHf0Ab2Ue+F+PL/bqgANmJ/F83gczNCGxh4hrrYJY7Jtups2QkPCPdetm30mo/RX/vFw4T2Wf3iusn9jHyN2UQxUel1qxYcXd0m/s4tshw0/RlZwhGt8hNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULwDOrQH0qb35fOeLGWJmnUWd8DsChq/bvM87kJrqT8=;
 b=FMeNnA0zh+DNxZWDEe4Fh3HhgqlOvQolNDX/qMSWkoDUIgE9IQaZa7KveS7VfBVngs2ykW8ao+NN3Mx1FRIhSsOpBrEZKX0qllNti5Rn5DTJAUqLrEUEfkerwtbVr+6ApdHgVxhNKjchuvUXiloBmjO2KAjedskQMYy5b4L31+7MyDf2Bp1ufmZzqk43Rb1pksrzl8hj6rdvdm4mi6/xqM/2iT5IV0ffpyEu8tiZZvhM1AmLknS1SgV6pnnQG/4IYhFFtxkKdGQ7hIwI/py4fvZ+IJMEsTDK4DpyomBra3dGzKa2LojnojB8rIGGgyVQnPK9/KmKcKL6daGbbjjiCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DU0PR08MB9581.eurprd08.prod.outlook.com
 (2603:10a6:10:44b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 10:26:38 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 10:26:38 +0000
Message-ID: <0d488aa5-4cda-44d1-ab51-5279f865cd9c@virtuozzo.com>
Date: Tue, 4 Jun 2024 12:26:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: Use LVM tools for LV block device truncation
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240315085838.226506-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DU0PR08MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b90b75-a535-40e6-2509-08dc8480d116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3hwRklSUmhJWkMwalhDQVJIS1lSRzVoQmJ3RGdYWUJpcGhQblI2bnUyUTQ0?=
 =?utf-8?B?TzVYRXpKMUVLKzlEWGFNVE0vY1RzclBMZmtUYkluN01Lb3Q0WmlJOWR2bWJM?=
 =?utf-8?B?b1JCN0krSFJhR1UzYWZqdFNrcmFOK0MzNlRvMGFQN0NPSThna1RNMjJuYkY4?=
 =?utf-8?B?YXpWQUxldkZHMDZjYUVrRGxCcHcxc3dnL1pzbWRtY3JVbGZsTEdmSGYvR1c0?=
 =?utf-8?B?dEw4U1p5bXFPTUN6d3BVWkY3MWdNSHFWcjl4WGpoRFdLTi96RGRhNmJteDhJ?=
 =?utf-8?B?VzUvK0pmSzRvMGVqaWlTVGRDMmZGRkQ0ZFdDd0VJQ05LV3JOVFlXWVJpTk5B?=
 =?utf-8?B?NjNOUFBrdXpIWis4eTYwVjg0Y0liOVNvaStITzU4dnNUYSs2TDBrRzRkUkhn?=
 =?utf-8?B?ZFNqbEg2bzhsOUJINmtNMzE0MzBhMGpRRk02ZlpXN0Z4RE1UMzQ5L2xjSnFP?=
 =?utf-8?B?UUhoQXNSVVNGZ1VOZGkwQkdxcjlOaHk0UDl4bURpaGhnRUdZYy9OQjV6dngy?=
 =?utf-8?B?N1RvQk1wYVhGY0tEYm41cW9jcDRPRHczZUZFWUtYNnY2TE9aSkt0Ym1GQzZv?=
 =?utf-8?B?UmxDREdvcVN0UTBRZmNNcGpGSkJ4T0sxMXNKTnJVNjJXTGlYdDlXMmZHTjBu?=
 =?utf-8?B?V0lPTmYydm1xKyt2WmxrdnljUjArdUR0ZG9hSGRHaTY5L09naXc4YS91Y2NS?=
 =?utf-8?B?MU5MalJIWjNXcWo4SSt2OTh0NjZ3UFZJNGRmQWpzTG9NMGtEKzN4VWNUWkNq?=
 =?utf-8?B?SmxEa0puU3dYNFpZUkVCSy9zNEhCWlZMRVFJMWR6emRjdmh1RHVZUW1EM1ls?=
 =?utf-8?B?M3JZTzIwN1pLRmVDOFJ0MXdBcVBZdmEybklDTEVWYVdOT2pXdjdNdHJMYnBm?=
 =?utf-8?B?QTlqV2xFa1Q4WklLTzdwY0IyaERmVytrRlZ2VjN2OVhGc256T2ZRWitRT0VX?=
 =?utf-8?B?VmgvZGh4dU9FYVFObVJkMWVUTnZ0a0tJOEZ2UGRQL1Uwa3lSMFc2TWN4aldX?=
 =?utf-8?B?dE5UYmI2TTJIYTUreGVwTTQ0QzBVOGdQM1FrbHkydVpLSGNvdmhmQWorSWV1?=
 =?utf-8?B?cmR3T3JGcHkxM3UybDU5eGJjU1FjRG42dHNmK0xVMURMVStZMW5kM1ByK2t2?=
 =?utf-8?B?dnVtcEp4ekxrd1BTdVNUcFRkZmZBQkJ6eXNXN3RlanVUazI2a3hZUDFGWWVr?=
 =?utf-8?B?ZFBmcEs1SWhXd1ZmOXdmTkNPLzJzRC96VXhtWkJRSVhZTjhFQzVvWE1RZ1Bk?=
 =?utf-8?B?dVd6RXQ1WFFycyswZnh3TkI4bVJuMWF5cTVxSEpWSnV6MjdVOVorMmE1T0l2?=
 =?utf-8?B?dVEyMTE1NXpZNXFVVFF1VjhjT0hwdXRYc3dEcW93SVVkWW1WeDBCUWJ2ZVNL?=
 =?utf-8?B?MDcraXBPYlV4dTY3bnVvM3RTQzJYTWcxTHh0bXl6OTRwWkJVcU9ock8rdFEw?=
 =?utf-8?B?Nm9jNDRSOVpwN1FEMHQvWDYxUUxFdlA2OHpEK2FBaUVIeDdzQm5nUlBaQlN2?=
 =?utf-8?B?a2I5a2FxbmZWVm1NaW9Pay9oa0NiaVJKaEg1Nll3a2tGOHM5WnZYbU1uQzdZ?=
 =?utf-8?B?V0MxbHJ6TXByTlk5WnlZSk5mMmtKZ0l4WU9wRVdFeVU2SHFQcjNuMzY2VHV4?=
 =?utf-8?B?d0ZFQWNsVWppVy9QK3ZzUTJDT2VnWXUxMHhNUG43RW43Z1cxNlgxN2h6NUM2?=
 =?utf-8?B?MXM1ck9WSDhTYy9zdTVrWXJWTy9tTXdpYUV5MjZoQi9qSTFwZ0U3azRVVHFZ?=
 =?utf-8?Q?XhvpiyyK4ew4dqB9LifCqgbuZ8tE6IkIue8yMXi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmVpdGROMEtNSFdrVnF6ZUxWb1RVUDhKS2c1YzB4M1pVQmpRNVNtNVMveXVo?=
 =?utf-8?B?N25TdlVqbG5QWCswSFpIbGFxZGJienkzQjUvU2JUeXBRSFVEcUNEaUxwMldP?=
 =?utf-8?B?TTRBSjlxUnBURzNjSmRzMVRyc2dRczIrbmxLNUw4cEV1cUd1OUp3cmZiZWxy?=
 =?utf-8?B?UWRDeXhkV3RNeis3YkJjU1M3aXd5SzQ2bGRWc016MWl0a3FLQWdyZWtmNldu?=
 =?utf-8?B?cEdkS25KbkRmZXZwUUlzakwxOXlUU2YxM1F6Uk1FR3NxcThXSEJSMVVINStK?=
 =?utf-8?B?SG9sRmdDY0NHSDRqbXQ3NUdCckhzUWpsdVdkSzFSclRZR3N3YW5aOWRrUjBT?=
 =?utf-8?B?SVBVOTlEMG43L1d1b05DSG5hSG9XcTN5OVVJU1A4ZTRMN1ZFZ1J4K1Via3k3?=
 =?utf-8?B?U0ZLYnFFeXNoNDhjMjVyVTdzZEVsNlJSM3A1M0VWaHBaK1RaVkRNSEZuSWxP?=
 =?utf-8?B?UEZySVdDUzRZWlhIVjB6VnhONVhYbmlIUlJTNk9mSHVpNXZnT2ZBRmQzeTFG?=
 =?utf-8?B?UmZjSWEraEUralRGeEprZEdzS1BKMERiamFiajN6dGE3OHNFNlJna0QxQ2xt?=
 =?utf-8?B?SFJvbFRXQmpUZFNkTGREUGRyb1V2R0J5b0x2dEkzcWszcDdZTDF1VFpFMk1i?=
 =?utf-8?B?ZkRseS9PNitIMkZMMEU5amhlMWJIdHBsbXlQTDk1anNOdjh0RitOQWdRam9V?=
 =?utf-8?B?NU04TkF0SVlDWWRhZkRqVHpEZGg4TGk3cWdNT0o4T243VzNGcGh2c05tNEdL?=
 =?utf-8?B?REJUSXR4ZlNTWEdMN3F1MHJRSUhyV0ZoNVhQUWdRTGlxbU9Iamx6ZG5uVDA2?=
 =?utf-8?B?U0h5bi9QbDdTVmcxejZoVWFId2p4RGZKYjhBYzRjQ2lpQkJlWER5OGptTXVU?=
 =?utf-8?B?TURaUyt4OWFqNFhsQzFuMy9YTEQ3akRPZG5HakJjd0xBd0Z2TStWRjNpaW5X?=
 =?utf-8?B?OHZ6aHVtdU9mWWkrY0lUZVIyTXlKbUV5c1BwVG5XQjhrb0lkRmMveEVxVDdj?=
 =?utf-8?B?dFRTS0NSQll2cUs1WTFxendobXJGNDcxSjZWQmpvR1RRNjhndjhRZjV2RTM0?=
 =?utf-8?B?VEYycFd3ZFlreVl0S1Q3dDFEUFM1ck9oK2pmT1c4OVdRK2h4ZG5mbW1SMGpI?=
 =?utf-8?B?NlZMOENpTEVCbDg3N2JQZ25INGMyMFl3VTVGTWdRaEFjRUNvVEhRakxreXU3?=
 =?utf-8?B?dVAxNjVWT1oyT3I5SmpXOFhxMXB2THk1ODlRQXBSVFp6UEhaNTlxbUEybjhZ?=
 =?utf-8?B?ZlVoY0JwNHpNWHBiQlRNeVUzS21xSk4wRDRpRGJSOHJMQkRQeGN4OGZjalYr?=
 =?utf-8?B?cWFJNXVZNU41SDlZU1BHOXFMWUc5cG9NcjFndnlReE1mTzQ0OUpFOW1WbnVY?=
 =?utf-8?B?WEovWDhoazdSSWI3d0Nzb1VaRnVQOGQvTXE2a3NhRk83eXkxWXUxVXJZQ0tQ?=
 =?utf-8?B?UHErV1R0ZEo1b3F0UGZaRnlUR1J3dmt1ZHVQQWhnclBrc0cvTkRwTzk4VWJo?=
 =?utf-8?B?Y2xHTkgzMU45SEdHNDBMeXJOaS9sVElvajZYS2FKSzl4MmRsSHRVZzFoS3k1?=
 =?utf-8?B?ZkhyYWsvbnN0TXhhb1lBcWNjUjJxMEEzUFBBdUUxUGJTdFpyaU81d3RJd2dG?=
 =?utf-8?B?UHc0ZTRuakpzRWR2V2dQNmtOTlQwcExLRVp2SkVEZ29QbXhFck9RZlI0RTJN?=
 =?utf-8?B?Y1FnMndxdWZXSnFnSzQrczdEVTNvcUxWRHhmb0E2NVVJQzdUTmEwYjBXWXlU?=
 =?utf-8?B?Qll1bTEzN0lvM3NBRDBYT3dWTlpyZzJRc3h2bEt1aUQzQm5RM3FHWklLMEEv?=
 =?utf-8?B?RW1VMEczYlZZdDh0SnVHZHFKbW1RSStiM2M2RXA1bEkxSkdQcStMTXA4emdl?=
 =?utf-8?B?Zm1ycWtHTGZuVmFOSmhxekhtcGZUY0dCOEJnZktCRzZKbFFSUmUzT0JlWmdz?=
 =?utf-8?B?eWtLaVArWTROcHVlNStKTjZiTkxvZmJSS3hkclZnSnBTek5KM2VGNU9hUGY1?=
 =?utf-8?B?anFtNHN1QllvLzVNZDh0U3N4M0w0bm93cUVKZUdEZHRySTZxVG1SMXNLL3lk?=
 =?utf-8?B?cHNDR29pVGtBODFMNm45NERMRmpNUmhkekZoKzBiWC8zWkhGV1E3Vk9Cc2o3?=
 =?utf-8?B?RE1EckdERzlXeEdxOTcrc0VxZkJkRTAzMDZ2dStRSjNqZ0Vtc3pDYng0a1dO?=
 =?utf-8?Q?CShPCuKtlGkPJm8Y8nKs9XA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b90b75-a535-40e6-2509-08dc8480d116
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 10:26:37.9880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2MEdlrsFX+IwiJXnak4IKActphVUKHqD3BhlgamkYffdHWPFK8wzQSD7myNsSCbE+2oSy1F7i8Amz8FayF8rmOoK+63ZyT+J/D4D5Ghhjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9581
Received-SPF: pass client-ip=2a01:111:f403:260f::722;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

ping 2

On 3/15/24 09:58, Alexander Ivanov wrote:
> If a block device is an LVM logical volume we can resize it using
> standard LVM tools.
>
> Add a helper to detect if a device is a DM device. In raw_co_truncate()
> check if the block device is DM and resize it executing lvresize.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..af17a43fe9 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2642,6 +2642,38 @@ raw_regular_truncate(BlockDriverState *bs, int fd, int64_t offset,
>       return raw_thread_pool_submit(handle_aiocb_truncate, &acb);
>   }
>   
> +static bool device_is_dm(struct stat *st)
> +{
> +    unsigned int maj, maj2;
> +    char line[32], devname[16];
> +    bool ret = false;
> +    FILE *f;
> +
> +    if (!S_ISBLK(st->st_mode)) {
> +        return false;
> +    }
> +
> +    f = fopen("/proc/devices", "r");
> +    if (!f) {
> +        return false;
> +    }
> +
> +    maj = major(st->st_rdev);
> +
> +    while (fgets(line, sizeof(line), f)) {
> +        if (sscanf(line, "%u %15s", &maj2, devname) != 2) {
> +            continue;
> +        }
> +        if (strcmp(devname, "device-mapper") == 0) {
> +            ret = (maj == maj2);
> +            break;
> +        }
> +    }
> +
> +    fclose(f);
> +    return ret;
> +}
> +
>   static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>                                           bool exact, PreallocMode prealloc,
>                                           BdrvRequestFlags flags, Error **errp)
> @@ -2670,6 +2702,35 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>       if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
>           int64_t cur_length = raw_getlength(bs);
>   
> +        /*
> +         * Try to resize an LVM device using LVM tools.
> +         */
> +        if (device_is_dm(&st) && offset > 0) {
> +            int spawn_flags = G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL;
> +            int status;
> +            bool success;
> +            char *err;
> +            GError *gerr = NULL, *gerr_exit = NULL;
> +            g_autofree char *size_str = g_strdup_printf("%" PRId64 "B", offset);
> +            const char *cmd[] = {"lvresize", "-f", "-L",
> +                                 size_str, bs->filename, NULL};
> +
> +            success = g_spawn_sync(NULL, (gchar **)cmd, NULL, spawn_flags,
> +                                   NULL, NULL, NULL, &err, &status, &gerr);
> +
> +            if (success && g_spawn_check_exit_status(status, &gerr_exit)) {
> +                return 0;
> +            }
> +
> +            if (success) {
> +                error_setg(errp, "%s: %s", gerr_exit->message, err);
> +            } else {
> +                error_setg(errp, "lvresize execution error: %s", gerr->message);
> +            }
> +
> +            return -EINVAL;
> +        }
> +
>           if (offset != cur_length && exact) {
>               error_setg(errp, "Cannot resize device files");
>               return -ENOTSUP;

-- 
Best regards,
Alexander Ivanov


