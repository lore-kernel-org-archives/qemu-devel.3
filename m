Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B1AC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scOay-0001GO-J2; Fri, 09 Aug 2024 08:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1scOar-0000sQ-Tn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:19:42 -0400
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com
 ([40.107.21.117] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1scOap-0008W2-P7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPTBGIjtSCLF9pB00wng/oYoOhTN1FCS16a2E3Py508EoQfsvbwSry5XFXKV3umcTyX4gHJ54TrvD1QwBWp908mAnuSXy1kf5LL/rOl6Xzizv4rQwFgBl44rjVcbpnfm+Nmw1b34cZ5oDbuhh1RFjy4GDIUx3jeyhc5On2X49bu24jMm82qkIClqaPRxlzP1KsOT/BZ5cB1A17UKg/ykePqtg8PVpIx9XJ7rByNbKGtt4vUBNTzrTrs84Cfgh+sDXZBninZ2JimGiQcYJ5w0/t3YPogOY6so6z/Dmeahj+zSOnK1wc5Q4u5jZTrEZfWAl9ufTrEh/0EX4eJBaa1V/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSgsCPhKemxyvT1cfJia6nAcc5KDqpfuJbEwDWxNrKw=;
 b=IIPWyRiDJLJsfSl8t7/Ir+A1MG94WQFXVgqnr/2eFTeWFsi66Pb3QtP4m9tRYQ4gPe7zwAIoiuo9SWsFArfPsKqZfVY6Ou0aXKOPpGGdO+LEfh/HU7vt8C4LxYBz6oZlN/qFQaVZlOSWX7EU/kIzRUpi8+RGpAR7wyJPf2Ojc/auwymA61pSOxFyZVSLNqxs2InyiyRlikbvmC9dGjDJPfiSWAhQgzO0B0Sh2X8eybI71MohVYASScXlLMxMtS7Y+NYOhIF3eH3BUIht6mybdrcBZifTH+mz106CN2OYu+CbgcLna1SO9Znpiy6oARWxXGIxNYwGMTM+exyFHvfNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSgsCPhKemxyvT1cfJia6nAcc5KDqpfuJbEwDWxNrKw=;
 b=sVPKrrDXbUJwTWimqovBOwmYNHIY0wuYSrPtPxlBNGW1AE1TCfWxSP3Pngh47et+TOgt7qUe7UE3v5MdBudU4zhjIm8Y0rR4APx+vwhA4jEgQIUXSPS8nuDnhCV6ADaEpvQq+QqgfcNHjNg/D8iObOaK5aQrttxu6ZXuejb+Hg3edUMAvgZQvn2V8zc4fLUinyEJoBytYBjIs/R0GKm0QQ9ZPDjEQ9CDFvo7rxodzWyY4BgSh+AW9pVylMnzh0X/6ZgulE1KKc2ZbCt9SOgsy7LEDG/OdOvROYjG6npVksPlHTAQHLQq8XRdgFUXDmHrTUQU3tNv8816JZLWb3VbOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU2PR08MB9990.eurprd08.prod.outlook.com (2603:10a6:10:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Fri, 9 Aug
 2024 12:14:33 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7875.007; Fri, 9 Aug 2024
 12:14:33 +0000
Message-ID: <c889b1e6-22e8-4086-b7f1-8fbacd91fae2@virtuozzo.com>
Date: Fri, 9 Aug 2024 14:14:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, cfontana@suse.de, kraxel@redhat.com,
 laurent@vivier.eu, mjt@tls.msk.ru
References: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
 <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0250.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::23) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU2PR08MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: 82163319-989d-4e75-b9f9-08dcb86cd418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NndFMFR0NHNVMjZVSHAxSHYzTWZuQmhVZTByOUZPNDdGekl4UlUvbEhGRzcx?=
 =?utf-8?B?a214aXEyeURiK1l5T2lrNHVZY1pxbmZtZy9hZmpSeUZSU1N4NHpBNFJwNk9O?=
 =?utf-8?B?aUMrTEpRK0V4YlRQMjBLZjB1ZTlKczdVcVQ0Zm9hZklGTlVVUE1jTndhd2FT?=
 =?utf-8?B?NzRmWjhudysyaW9ZQU0vbkw4ZzJsL2pZcnFTaGZEOVZwVUlEU1pxKzVrM04v?=
 =?utf-8?B?bk04Qy9RL0xiUDg1VlBMQS9TSXI3d20ybi90dmt6MWNDakNkTEhHNXdWVXJ0?=
 =?utf-8?B?d2lFdjNKNG5SUDZuU2I3VEp3VWlFV0xwajRQVVkzeTdDeEgzZEhVMElwcHpN?=
 =?utf-8?B?UWdMRVVlYUZ0YnB5SEhYenR2Uk15U3BJa3prdy9jaVc2SlFGdi9IQXVIVy9i?=
 =?utf-8?B?cXZFQzR2ZTh2dEo4bklncG8zdHdhU3FBdmd5ek5ybVNIbzdrY2hxWVRBd0Ur?=
 =?utf-8?B?ZFpIYXdaREc0cmk0Z3FsQmxVUjRpbVZEK0lXQjRLUU02Vml1VmlONkZrdGNv?=
 =?utf-8?B?eFhOTERMa2ZqREJTM3k2RlArNVNsSkRHaE9UNmpIL1BkZWxWd0RxSlJ0MzVF?=
 =?utf-8?B?WkhTcEZXL1FyazIvRzhpbW9qaWxIcEJPWkFkN1J1ZFRvMVNJeXNvUyszTVVP?=
 =?utf-8?B?cEpLZkVDOG9WVTRsSTFSUUsyV0tTYjNhT3NWOXpRZ2FZY2FpdXNRWlRjYW5Y?=
 =?utf-8?B?WWF5NStSbytabnlKeFkzaGR3ZlI1Nm4vMld3T2ZheWpXT25sTDJEQUw5THZt?=
 =?utf-8?B?ZXFOaUozNFZHM0w1cm9zdm16RmR0bzlZVm5LdEFuTVlqRldqM0F1Q3o1azBU?=
 =?utf-8?B?a3ZLaERGZFFOcWtKR3hubTJBbFNRTjhTL3ZDb2g2SWszR0VETXc5THJBSHVT?=
 =?utf-8?B?Zmt0Ym40K0lRK056SDVmRW8rMlhKaVNNQ2FRcUN6MkhZUWQ2RGRFWjdBYzhF?=
 =?utf-8?B?eGYvb0dVWWo3c2M1V0hLemxNVTRFVDFHNTcxWEMweDFqQzdHYXp2T2N6TUd5?=
 =?utf-8?B?aG10NW5zd2FyY2RoMFl5T3d5Skw5eVhFQTlMb0xxaDhWZktiZ0RlbzV5eXRO?=
 =?utf-8?B?NTV6K0V4Z0JYNFNSeTNmWWFpVThjamVQRlFPOVNPTFhGcDFLZFkzTVdwQlFO?=
 =?utf-8?B?Z1ppVHJUS2oxaWxIdFdGQXFTQ3IzVkc3dUdkR0dQSTdreWpoWmVqZWZLM1l5?=
 =?utf-8?B?Vi9zeVVwREFtRzROYkltNlZqZU4reG82YWt5dURuRkEyTWZOcXZwN0RoZnNh?=
 =?utf-8?B?S1dVaWQzTjlmV05TZ2JuYmQzTVVYZHVyNGNRd1BZQTh4TmVTOFJmUk1BZ2ht?=
 =?utf-8?B?Q3FGRkVFblpIRFdsdHBCVmRFRUpKYThjcjVxT3VtVFVTK0kyTXFRRjBTb3hD?=
 =?utf-8?B?bzdNSW1vOVR0cHVYOHBENXNrMEZBUitlSGtVREJGaWxWaUdnQXVJOUhRRlFO?=
 =?utf-8?B?UHJWR05DTVlrNFhKUGptZnpleksrcVlnalVPdWJ0MExOZ2VTcGtZWmJMTDVO?=
 =?utf-8?B?aUdWL29jTHJJSUcrZTVPdzFoN2ZnbXg0a3oxYldMeHA4dExyVG9HQ2lTUUQw?=
 =?utf-8?B?bmtqcjlLKzJMQ1dpL01aS2ZWenMxZU5LWGlMY3h0WVh3SWVhQzh1K3B0YXJS?=
 =?utf-8?B?dUpyTVBBUmM0aGd6c3U3bjFTOXpKb3RLekExWHBJdk4xVDJZMkp4OHBMQmFL?=
 =?utf-8?B?N2NTZUEyeURUWHFlbGdIbEFRekhacWs5YUJmUEROTTRmUE9ubFNNS3NiK1Rs?=
 =?utf-8?B?QXVrVE00NVBzMExnSVUvNjNWUFcvdGN1QlRMVUxSa0d3YzFERE5IWG56R0Zo?=
 =?utf-8?B?QU1SVnFVRWpiejh2UW1BZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNZNitTTEhYdC8wb3M4U2hndU5kVlMrZmFZRVd6ZXVFRGtuWElFMjdTcHBK?=
 =?utf-8?B?bmpQUlBoZW03MkZyZWYxZ0dJdlR2UTliTUQwS09Ud1B5UDhMRW9yYWNvNS9J?=
 =?utf-8?B?aDJlM2tMa1ZkM1ZqaGdFVlZlSk9YUHpIaHg2Q282RzdUSkVtUnNaU3lYSXE0?=
 =?utf-8?B?V0lYVFV2WUYwVngwMkJPQmFzRU5uV2EvMFJrZUZuREI5N1B2dGRWcm9kL21k?=
 =?utf-8?B?WVhUMUwxUVdDbnFaZ05ua2ZKK25NcjAyc3dBWFdhcmtzSk82Um9KZWF6MEF3?=
 =?utf-8?B?OE9ZQ0RhU2NCZjg0c0VNeVZWNUdIUXJQVzNDeUNhY3R0SC9ydjlhMzJvRzBo?=
 =?utf-8?B?aDYwQXNLamZJZ0tLMzhnbTgvbnlFU0JWN2czRDcyamQ3YzdOVjVVTzBJTEJz?=
 =?utf-8?B?NUJXQ0RBdkh2cGJ4U1c5Rk13R3Z4MklnRW1pYmZNVkFMQ1hTbUNCaFBGeWNX?=
 =?utf-8?B?V0FBQ3ZQeVdrU1pTa0ZNb2toUkllUlYzWGc4S21PQkdUNEFNNkdoc21EQWM3?=
 =?utf-8?B?eXo2ODBGaTdnSy9yYTU2VnZ3THpKY3ZPV3JOMko4SWJwcm1YVE1lV3REdkxX?=
 =?utf-8?B?cEd5NlpLeVJaazVCSVhiYUhPbVBsZW9mVkRZc0pIR1JjaEdNdmllU3Q0ekFT?=
 =?utf-8?B?T0FYZnNRYzlSVDh1NEI2bjNtQ09zaWpwQWhhYjhWdWJtTUtNYjhkQi9rd3la?=
 =?utf-8?B?OGU0RkNZQzlnd0NjYmVUS1c2NGlVNHA0VGszbmcwQmJzYkZxTXRhZ1l2eG14?=
 =?utf-8?B?dXZ4RVhmNHZtZk85ZWdqOVllMmhna21Ib2d2Z0gzUk1OYXQrR3FpVVV6Z0hV?=
 =?utf-8?B?RVh4ZkxucUpORFRBa3MyTWZueEwzaDVCN2liU1E1eCtpQ016VXRsYXBUSm43?=
 =?utf-8?B?b1RwdFhrTklhTmFaVVRTdmZ1QjhBSjBINDFCSGc4NXJ4d3UyMm9zdG1BSHZt?=
 =?utf-8?B?am5hSmFqSkpXT1ZPRTczVU82bXoxQnE4aFJGNXM2RFlQRW11MWo0WHh5S2RI?=
 =?utf-8?B?MjJnZG54QlJIYjV1Nit5dXk5NWxNckdoTTB0ajdiSFRqTGhNUm1vWFljZzZ1?=
 =?utf-8?B?dm84ZDk2Mmtrd3VvQTVXVmordVgycTlHTGlaQW5SYnVwcUROamVvUmV6eUE1?=
 =?utf-8?B?Z0JsT0N2WW1zWnpFeE5mdDhTaUsybXA0azF2dVhweXNnemZGUkdwVy9ieTVU?=
 =?utf-8?B?QXlxMG5CSjdmcG5CZTV3bnNPNUk5bTZzWGg5ZWFwTzR6dnpXV3FTRTFPUXF4?=
 =?utf-8?B?ZXQ0YzR3bHFSTlVndzBJMVJOOWtIRHNpUlVyVlJqaGRpQjQrTXhLempTaXNS?=
 =?utf-8?B?SEwwenR6blE4QnZVd29US3JXY2tOK2hLU2pFcFZCOVRLNDhHNldzNWRFbkUz?=
 =?utf-8?B?Zm1hYmJoQXZvVWJhRkUreDViVGJFbmxnNUtseURLRVJQblZrVVloMDV2eWxC?=
 =?utf-8?B?RmR3YWpTR01IMWZhWWJHTmRBUHc2dlZYNWlEQ1JMcnAvOWdBcUsxUWJqSDRp?=
 =?utf-8?B?azNPQTRqNEZSRDR0MkQ1RkY5VGxjWHhPK3pBN04vS2puS2JkQ0E2LzlBT3Vm?=
 =?utf-8?B?Wm5XaVFMRXlaVGF1ekU1Sjh3QzhpL2ZwVUY3dGR5SGNkOHNZZUJJNTdmUzBC?=
 =?utf-8?B?MlNmUGdwamN4d3k5ZXpiUFgyZHhuejFsN2hTODdSbGRXc2htR3dTMmZFcVRV?=
 =?utf-8?B?ZVE2NE9OOW5WRG5nTFZ5MTZ3TFRMU3c2cFYxVnBwbHRHTkUvNjBJYUpmeUtB?=
 =?utf-8?B?c0dVLzBHQ2hQQzgxRzN5eVQxRzIvOXFabEFHb2R6Vlc1SHFORmtqOVIxRFdB?=
 =?utf-8?B?aWEvajNkQ3RwOUppVEZnUXVvc3BQSm1QWkd0OS9KWU9DMUZldDh1Nm9jVDZr?=
 =?utf-8?B?TUgzNEVpbkk0V3EzclFsYnF6TVQ4TnJkZU1iWHpMU20yUkwyOGxYNWhvUTVX?=
 =?utf-8?B?NlhEZDUzUFV4WnZFZG1Fa1lCQ3A5L2c5NDd3SU9WczhaMlR2eTFwSk5nNVVX?=
 =?utf-8?B?OVEvdHpGRUxpakZ2WTZEV1YzN1V1UXBmREtGbkhCL2l2bUU0a204VnU3Wmtv?=
 =?utf-8?B?YUc1RW9QOVFaQmE2K25UcGdwdnVDaVR3UkZRUmxJc0t6TkcxQXZ1K3JYMGVZ?=
 =?utf-8?Q?gNFB+xOOn5l8VvoslZk9S1f/r?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82163319-989d-4e75-b9f9-08dcb86cd418
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:14:33.5178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vd1gpoyZnBNPe1rLcv+d240cim5xIk4Wf9akmpJPxX4YwgY9TNQtvrtv1f9kYgzHlj0IWO6sZlCrJTrXUZ8HqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9990
Received-SPF: pass client-ip=40.107.21.117; envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/9/24 14:13, Alexander Ivanov wrote:
> Set local_err to NULL after it has been freed in error_report_err(). This
> avoids triggering assert(*errp == NULL) failure in error_setv() when
> local_err is reused in the loop.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   util/module.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/util/module.c b/util/module.c
> index 32e263163c..3ff4aee2ca 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -369,6 +369,7 @@ void module_load_qom_all(void)
>           }
>           if (module_load("", modinfo->name, &local_err) < 0) {
>               error_report_err(local_err);
> +            local_err = NULL;
>           }
>       }
>       module_loaded_qom_all = true;
Reviewed-by: Denis V. Lunev <den@openvz.org>

