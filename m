Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424BFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsXn-0000nu-KM; Thu, 09 Jul 2026 13:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1whsXm-0000nX-Jk; Thu, 09 Jul 2026 13:28:14 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1whsXj-0003Df-Qr; Thu, 09 Jul 2026 13:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783618092; x=1815154092;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M8qao6f8lzVhdrlH/Kt+I5Z+SqG8dceZwbcDzSv9LQM=;
 b=SjriT/OegZgmn495dTl5RyaSfn3JCES43WlWlDATfsuPytFS7S1BUx2I
 PBwTjo7D0aN4hrc5KrvqqyMNMHlKcGYWuhRgGsCU2kmcErRE6KZIwaU5Y
 OkwGdWP9ET4kk42T2Bo+VkaSvbcDLuy6eP7LjY0jIA/WUE3tLdnNfq4qZ
 jSBfwe7xu5T7fLg2xQA3H/xcs1PQictFpQOw91zWgQa4dnTe7FDO2xqCn
 YpgFHqn+A7I5oIoSW7JZ+8sU23E2QvP18fbvlwljzxsTKcpJi2c9I4Xbz
 MX58vrkG++CdUF3k/Jhie7po4G3XxV+kbgdue0kIyTPtgMiXnKQa8dMDt g==;
X-CSE-ConnectionGUID: UTe+xi+fSZmwsQeIXgZEiQ==
X-CSE-MsgGUID: eDUybfPeQbaUy4YIC+Cjrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="71832094"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="71832094"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 10:28:08 -0700
X-CSE-ConnectionGUID: Xp/7AXTFS2CRd48OjeEF3A==
X-CSE-MsgGUID: tKAspHh2R5+2RPPvAJ7Glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="258955382"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 10:28:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:28:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 10:28:08 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 10:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR4ohd+G1IMKi/rx8DkzOmMeqARVDG/Zl/jmJURoRzjf4to/q654jS20mg1HrgcP43z/wEdor/Uno/k4ZWcWoXFIwki+/3kEG5umuNJ3Wl1sOu/RlkHp/5NGD9OpiuztNt3WVb50xGXNvFWfk+0os1FonEYaaLTZeaThozNTsD47WOPesTsNubBPJHZqQTyRKLeOUOKMYLFmt2HhzZkxCi/ZK9Lnd5vhOR4e2FSLJyb1K3DnKXPYY93lWj7bPA/KH6fwNpdAXviljwSzWqtuVaBIWzNH/AIU0WWK/QjAirs9rUTZUIGWMEs4fbHZ2dhmprFu5bFi39pfjr6ZjUrd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdFLTeeMrFXcP7OoTow1O0y6Ur22guB/9bd0wlKZ2d4=;
 b=qRSeo6uWKc143INhoI/jSAdkFxJTMU5zHBUv5BYtE9L1xN0zfJ6b/z/GrJFK+H+SYHqXY8maQOkSUqeGRuzH9fVoeCt9yVf4bW1g98R+hv9fXiK2ObWVGwKZuXtGAS9Iy0Bj7GJUbcWpyIr7c+/RdqbGXI/pHGLm22mqi15cUDBsQPzmxkn/In2WfUj9IWzwTiMx8VeTP2CunwuDgsCaNpd3EAJ52AC+Ea3Az7ZFZhmMmiXvYjQt8pbvJkeCGyrbcGHtbl/8zCbKDWP7wHwHb1KGhzeXiEgqxlRGyD3gEjTue4EMxBk7kySN0ZMkET0fpssJGPjYjdkqpzklwnhdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 17:27:59 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 17:27:59 +0000
Message-ID: <7095a033-e2c6-4d60-ac6e-9d2d95add470@intel.com>
Date: Thu, 9 Jul 2026 10:27:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: Remove AMX-TF32 CPUID bit
To: Zhao Liu <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <seanjc@google.com>, <qemu-stable@nongnu.org>
References: <20260708210326.402054-1-chang.seok.bae@intel.com>
 <ak9+ZaWdzxr4eCju@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <ak9+ZaWdzxr4eCju@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:a03:114::19) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc1e6c9-7eea-4744-fedf-08dedddf6ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IUHEhXFYiXJrKZe/M/EMZ+L8bnvrAemOQdVEakrcyIs8eA4m91i/C02OsXJ7hGJoCo2Mfc1a1+TXoG0y1HpNZDQk77ja+mMRN/rpRTjgkoicziF2Tj2o8sruYkd+cvtN+XnuJFHQS8+iUk6HTL/psmdSMQLRepw6YVruOTQTKXCAwb7ZRflaoFALkI77sUADsBLCNj3QRQromlB1d/6NVbNGaNUqCmdmjM8ARYkPy4fcegrSwK1fjniLt82GvrINolxXi3QlM/qG2XyiP3qtjbW7r2m0DkyvUr4sGXVGMsLEW8wdiPSSYNyzrescED6WrxwkTbKHoc3kt7gZuAaxKPYoG9NQyAh9/DuVSTLzMMT0xu1SM3U8lJidYBTNIyv1ICWte55lvXl+kJNSlAfnjTxIRoAMc1sZ2Y2p98Gdfbp8pY2C0FzUajchg5+ig3L831hR8tc1r+BNaIKafXxiFOYQA5rTOsp5iku+HWx9UyE9S6lgQQjuEzb98nbzSDKU9e4mBEot160PpaUysI6KOWUBzUejE2TeqcMO9KKR6pDwAEq4UROF9hFHw8UUzgHJBO92x7V2gKkk5NYOoSHxWdL0GblMxItyQgTAY4NZoB/HEN6786AORZ67tEcWQ8Jthse0PJZ97z6Dw3PSmPCDDnZh2b61fuJmXw6J8NQ+H8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djEvR29ybkNqZWtMbGdJQlVBV1RuZ3FXTXFGZStwRjBsTVZGUHhXRkw2aGVs?=
 =?utf-8?B?TUxwUHdBeE5qK0lUUFd2SmF2WFRzQ0pOL1RjZFRiZDhOTkFDNXpDc2UxT0gr?=
 =?utf-8?B?aWNLMERteWdNMFVLaCtRRHd2bUptbDV2em9GS0ppMnRQS3BQTlpKSnlqSHFK?=
 =?utf-8?B?UE5mb0pzbWZkOWNHSmxhbGhjblZ2azExekd6RUx2Ulk0QnVWc0tXc0lIZ2dh?=
 =?utf-8?B?NGZWYjExTGNnbVBlWE1zdTlIVWozakVEalRkdjY0QXlkZ1lLd2RVcllVa280?=
 =?utf-8?B?eHpYSVlPSEZXRGdXaVF1dlFzSGZWU2xobEZ3RmV3MUt6K0dEYUJ2cytlUUdJ?=
 =?utf-8?B?cTNGc3VONnltUVhIdDdYN1VwRGYzSTFSWXJjT24zWmE4R1FyZlJZQjczOGNk?=
 =?utf-8?B?TDlLaUgrdFppVmtJdHMyQTEzcUJaNlNsUUR5aWozMXNyS2dWZklLODNxMG5y?=
 =?utf-8?B?ZTAyTGlmN2w1UG9adkNyNmVxRkw1N0gzRFQ0Ym5mMno0VmxxK2VSN2Z6N21k?=
 =?utf-8?B?R0RzNDJWNEFiWHBFWkVPcmx1Z1l2M3EvY2lXeGt2M05RZkpGL0U0VmVsZDYx?=
 =?utf-8?B?ZGZtdGtaZHJmYzRydW1EU3ZEamgxRUpGN2hzbkZGV3BtOEhNTzVVZDIvdnBv?=
 =?utf-8?B?Q0JkS1p3YTJYb2ZhaEFUNERvb0NMekI2RlZFS3J6R01XQnlWUnBuYVNOMm1y?=
 =?utf-8?B?cXBMWnZSd1VsRDdwWTh5RmJkNUtxWUYycUh6Y2dPMTRjOHhyTG8zUlpDaExS?=
 =?utf-8?B?RC93eFNjNzZIMVZwT2dJb2pXbDRodC96TEpuTDNXdVYzWXhrZXVnUEZEaVRB?=
 =?utf-8?B?aVJKdzdSRFYwVlRmRDlMb0VUamQyVENQLzkzOUVQQTNGU3pZVDlPYVBtWWZo?=
 =?utf-8?B?WFJqOHdiWTVrRUcraGVjbjB5ejZsNHgwTEl1K0hQUWJJcncrS2c0dUtJSkN1?=
 =?utf-8?B?RGFEOEpYQmZ1VFFXSFVRckVBNTlFYytuTjBaaVQ3Nnc3WStoTThNYjFIdFJL?=
 =?utf-8?B?Y3UvOHFzOEl5OTk4TjROTXYxdnZjQlVhKzV3Nzd0RzgrRWhhTm9CUnJhSEJ4?=
 =?utf-8?B?ZGpuT1F2TWNGd3RXQ21Ndy9BSE9ueWx0cUlSV3NzWGtOZklzSERiWUNTSDBF?=
 =?utf-8?B?R2J6ZGE2V1FzL281c3RjUGUrRkdFSlgwMVZiN0xpbXBBb2FzQ2JzNlhHdzJr?=
 =?utf-8?B?SGJXZ3lQT0hvNmJZS2l3VXN6bW9rM2Z0WStNd1dCdEliaEZGeUxRSkVoZEFG?=
 =?utf-8?B?aEFQTGhsYmk0cHFtemE0VkptaldmTlJlM1FwNG9nUmpzOHFqdStCM2dJazFI?=
 =?utf-8?B?YmRWUnpyeENWS2Q5SktqVVp2azJ3NFFoRDUrN3FFU3hWS3dzUUl3bVNlaEJu?=
 =?utf-8?B?WGxKZDBtOEhpQzFuSWNnMEFSNEpIbU5xSnM3dnd6MlNHdS83K2ZOUEhBSTNt?=
 =?utf-8?B?WGFhSUlOTnRERjRkREJmSkZVcWI5dFdmY2FUVEViWFlzL3hydE0waFpFT3BO?=
 =?utf-8?B?eHdWUG9Rc1J2K0d1QWVRSFNvMmMrbThNM0JYczVnUi9CeE5TNndIK3V1ajQ4?=
 =?utf-8?B?eWZuQ0w4NjU0TmRzV1I2WnkxTGpXNDRSb3hFNWsrVmRocmxGOCttdnkyckp3?=
 =?utf-8?B?akJLWFloK0lJdk1pR2JZYytpRHRhQ2o2ZVFlbjhVMXpVNG0vMThPNm9jeUdJ?=
 =?utf-8?B?V3VsWC94eW5uRmthd1h3TmYybFFzNUZUcUttZGtEeERNKzhsUHdHajd5aWtk?=
 =?utf-8?B?YW4wTGt5NWJDOUVBUGtuV3NKN2Zxd2lBclNZdnZMckZLamhZdzZQOVBlcW5v?=
 =?utf-8?B?NjZaaHpubVQ2dHdtckJyOGtHek11WlQrWElKTmx1dHdONVpRSE9CYno1UU5J?=
 =?utf-8?B?SDYxTjNMczYwQkNoZ2wrRVIxYWt0dFQzdGo0ZjZWU3R4VlRKVytCNWxsS3dV?=
 =?utf-8?B?eXUvc3c3QnBUSmszdjgzYjErTktNTVlqeTBrYXRBbzlwVFkzV1ZSSytadHBl?=
 =?utf-8?B?ZDhzbWVuT2l3S3BXRjVLNWY3TjdMMEFWWVlLUU15S1ZNaU0yVXM3ZUtKb21j?=
 =?utf-8?B?WXZNRGZScDRYb0ZOa0JqSDAzVFdBZGljSm1nakdPNFByMndvdExGUE1QSmdu?=
 =?utf-8?B?MVA2ZUh0QTBlQ0tGZkxvS0lyZDQ2MTZjY1BJMjB5R2pKNFp0K2d1M0JkR2p2?=
 =?utf-8?B?R2Mrc2MraFNGelQxcUpYMFR5SVk4MENBa3orRitJaWxmYmZoZ05VTTJBVGl5?=
 =?utf-8?B?cUpqNWtlWjRCK3cwR05CNTIrY2xzY2xLMmpFTzFJVWx0SVBiVi9HQUw5Y2c5?=
 =?utf-8?B?OVVDY2NlbHZSYTJIUCtmUG5zZGVKZCs0dWlLaXgvSG5XcEZyUGQ3Zz09?=
X-Exchange-RoutingPolicyChecked: VmpQMaEG6cs8qbf3rF+YxIxoTw8TTcp+1HN/8YWck/psX7guKYAdOLKMUqCQtSHC3zpaKWhVgCITgnAKn7qR0y1nCWnWneRRWvRP9PjkpAJC7UGCGA3MEPKbz8zqKaeWkMSpba3OeTh1v4z3A+3Hi4QuhkSvIA48jNhPKSAoUo9wEQmac3uls6bPZHUDbTVUVmaj1u+ckWi+LF6ewkeKhjdTD+tH/Z2hB7udipsFcpdaB3xdbXX/nMA7D+avG/o2b291k6xAILvtJ8lDRrwUV5c67bG/X+xCBUHuV7GF0ae7WbmJ/GYHOV8mxPgG2XU+3Alsq7bcepYwHzFmvF7hAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc1e6c9-7eea-4744-fedf-08dedddf6ba9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:27:58.9600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ6RrBz0igJDkAO3h2IRZ/HHL6lsjHkvF69Ss21nqrlNVdrLBZcpIZ6DPTUw8wWsfzcG8ohR8SIFnB6mZTmAc7KsohE6J2IGk8U6Im5kiGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 7/9/2026 3:56 AM, Zhao Liu wrote:
> 
> (Cc stable list)
> 
> At present, there's no user for DMR CPU model, so I think it's safe to
> drop this feature flag from DMR CPU model driectly.
> 
> But to avoid unnecessary warning on older QEMU, IMO this patch should
> be backported to the stable QEMU as well.

Yes, I think so.

> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Thanks!

