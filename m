Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7617C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lIH-0006LR-JI; Mon, 07 Sep 2026 22:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lIF-0006Kz-K2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:39 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lID-0002e9-Vc
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788833438; x=1820369438;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=j4d2rkVZ6JAMPtZOeXvhDn5pTiTlSZh5cP1UECV53Oc=;
 b=mkomcSnC7qN7elSxDMyhx4RUdMlrFkcZJWObelb4x1qp8txR+2cb9vTq
 cnGTRtvb9Rzwx5pJZbRVS64tWJU4gvyNLFgkgg/DYsxdlB/GYh4W5ks3I
 9kN4/M4AsdflfEfVL1rr9rJdZn+5N0PgEBFUBMWLBD06J9m0HXuY3Z6KQ
 46JjwpBbxJY5i4MBMubgwfv/sVdGjkx37VAuRrwSUOJbMZqno0Kf2TUMG
 esfGGUW6vw9ewktXCukgVpWW1qbH+WkbxNhuaCWZgFkLb6/uv49QITH16
 Scfqymau9+kYsT6QNf7xHAFRA+S4ajY5PjmUDa+LuUcT/aEcoCQHd+sjz w==;
X-CSE-ConnectionGUID: nDzSBvFBROKlVpRiHUcFNw==
X-CSE-MsgGUID: MLVsTc8GTUiBugbvZyJRDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88377498"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88377498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:35 -0700
X-CSE-ConnectionGUID: FXpSBWOaQWa45jxdZ7refA==
X-CSE-MsgGUID: MqdWvaFhS/eoUubRjv70eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269531453"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 19:10:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksC+Z5WsVHbUXvmMHOXdvhMaPrtzoUgct4KKIjbYMYHqCVOpAWgOzJ7WkpZWOUWb2x/WJJVDotXDyxylSXLZ4CJ2R5ZkB9hStzRkcX04/0Qyq2LQWQJUxRlsaBV1DuHnS61kGnDhSon2Cjy5NOFpzhEKiNt17gS81UzF4++YnNwRBEVrqh5YxDKYrauwzCRrmixVRA1dyXiJeq/0tc7QlX0be6YTdlEmrS21PQYKiU8E0BJOvDNqyJ2IZKFikrLsFqQxaXao59QUo7qb8wZzNRcjfG9zTpU48OixhFXKq3kFH1B23n6tvPfrZuQwE+Heu7TM6nSiiGvamUW9l5wUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgpCntDPT5gX0H9ItBfsFsOedn+HXRU/nLuF+HvjUq0=;
 b=xHyKgSD4OPUKyLAJKnEpwqOselz54YP1r5n9GU2VhsNgSYtYF+B1opn7k+IUTP9jB6+gXQW5KXAKv9/Yb9T5US2OD6PbZoFztSkJ46Z0jU1XhsCq+2+pKWvqODGKNsgFjILPnwoQrnTED7nPD+x32KSVb94B9syaNzE6aiSJQtxz+BoN8vhUjcttloqZCGvNLsTQou6Xp/OTPK+RTRUNWjkYqMG239Z8HtZjI8b5pEcbNqfI/C6xfBM6KTIM3y7CxtIBvYo3f/iD2I2LTgIwku5xj/kvo5AkiGCN+jAQDb+iMbj26qTJQncb9d4styTIFodmZRL3NpwBvHbukZObmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:10:28 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:10:28 +0000
Message-ID: <29157ca3-d125-42c8-bd4f-76da3cb07af6@intel.com>
Date: Mon, 7 Sep 2026 19:10:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] target/i386/tcg: mark XSAVE* as not allowing REX2
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-9-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260825122921.431739-9-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d780a93-e109-4ec2-2d74-08df0d4e5a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4eA0vUK1dsYnJEbiTGDa3s/9mul7IO22ARKh2NC00WnFqM8GvOyh+bqPdT/XlXhxdowZRkZH7R76MIMd3GZwzM++WiiyarzfDLDKscMAoqjraZUjoEkzITsO+JqF8sd5pM8anqW366JA7lFtqxzCDS9Ms2m73otS/Q6fHV63DTIH/vWS7lrdeOP0m7e1AzK4CzfDSI2wDgVm19wITrRYgoRvehOcMaWnqtdajHL0R/4v+hZwMAAmexkQfEbG8KB3srNYgRCoHcORqZA2HC8yDGi5Ypn8q/2Ck8X5eVgNi2lNqZRDeYfF/609ssw6z+kTbg6Hf/UT1CqMkGucY80UohvDq5pWagptAonh+2PVSzexoUY+k+OhRpA/6ogNqr//Zfvr5guuNvqidMZXNKO9eiY7WCYF3WMoX+PIuY2AFBcNQ6SmF3soCyOMjFIWMxtStdymJXg0mAyU22UiNKQq8xozwf2o0gjCCwyqRuxSoAhEESw8VONiHHYTfcFV9XBDzKkic/DwgPqgQeGdxZgCviWTUXsWLOvNhvqEO+mEPJs6l+ALBzc/WlyVLIlTNaUd8KLsxXMRmv8m4aWYh7SLWswCfjHKjE8WXeWh7c5vSUgq2UDPc/h15VDYNHldb03mJnV9Un5+E6+csJvol6fBbVqaurPZcHifzex06kPbmZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1nSGptZGgyZVBPOStxTlRUc093QVE2OXlkRllmbDhMMFgvcWV1ZXFIdlIr?=
 =?utf-8?B?c2ZrZHI3NFV0U3BlaVFWMGZETW1BWlVMTTlmbUZ1U05QYXpybzlZK0FoVjVK?=
 =?utf-8?B?Mnd0eldXMHVTeGU2a1cyUFlVcDRWek1jQ1dpOUx3dzdBejBtL3NyWWxTMUU2?=
 =?utf-8?B?MklJakd3cExXSmgxMExidVRIazBYalpXSUVlck9VVUVmOWt6U1phaDlZdEV0?=
 =?utf-8?B?SW1vUm1rTHdhcVBMN2JvSmN5RmdkUktKUkhaZUNkM2czcE9WSS83MitSL0FK?=
 =?utf-8?B?ZURLblBCMUVNSEYrNzZ1dlpYSE03bWFreVU2K3A0cVBqMXdrS0VUYUVjZDhY?=
 =?utf-8?B?dmsvWUxlMFlDblFwWkFBd3pheGE0dFZhUUpkRlhjSmtuaDZGcEpGcWV1ampM?=
 =?utf-8?B?TVJxRGkwajRQNUlqZHZXTE1XVFErWWR5VDRFa2tQclUrRVgyRHpNek5yaVBW?=
 =?utf-8?B?VjYvUWZKeXlIZXJPVTl5aFRUdFFodURNbUJhV0lWcHpHaUJXTUt4T1ZvNUV3?=
 =?utf-8?B?djYrMkZNaXRRVng0V0hGdi9PUmR3TjJMN052QnRlRlMzcytKMVNhMTNISHBt?=
 =?utf-8?B?SlpjaDU3MXVhSHhPaGlKRjJRSElzSDY5R2RWOGZuYlVTQXgzamliS0NaVXpQ?=
 =?utf-8?B?SlBieXhXSisrVWx3RkJoZUtpamMyamxMK0kzMEVQakdUejZpb1FCb3llV25E?=
 =?utf-8?B?VmJPLzdNT3RmMTAwSmYxRER2OTBaN05pNWUvYWVYOFBDbElmN25NSk5hNDA5?=
 =?utf-8?B?N3h6NjJKc084OFV4QTFmUEMrMG9XeFhGd2JocnVVbHRQMFVnUXlWK0FNcGk4?=
 =?utf-8?B?YXlaeHl3cjZpdGRDTFhkVkVIbEQvV1pXVGlFdnhveG1ESVFkZGtNRGRBdW1P?=
 =?utf-8?B?Ky9DVHEraWdxeEhYVFZCMFQ1VzM0YmdVZjlUS1UrMW9JMmZwdEowMVhCTy9y?=
 =?utf-8?B?Z3NIQnJWSWhLekpRbTNXeFdoUHBRYkYwYklNNW5TVVlPUUR0blB4K2F0ZUwv?=
 =?utf-8?B?Yk9RdGRNVVZnV1FTMlNzNXBqajBYeXdHeGt6NVorYnp4Skx6Sm9hYnBJMll6?=
 =?utf-8?B?N1FtNTErSzJVbElYVzRYdUNvVXgvcVovdVkxM0hFZ0VtQU9xcUdkbG4vUXEx?=
 =?utf-8?B?eEYwMExlOTBoMTZ0aGZnaWxzNTR1M3lROFFObHZHdWZBa1JlQkFKd0RMakpi?=
 =?utf-8?B?VENTU0tzK0Roa1Vsa20yelRiNWlEdjh1ZE5EMy83SExra3FNRGdHTlo2dTZG?=
 =?utf-8?B?NmN5UkszSk1oUXZMN2Z5cXgrOUN5ZnZRVWNtR1RvWms0RnZvR1FiWmZ3aU4z?=
 =?utf-8?B?WGFHSldpLzRLTk42Tmh5VC9NcmdZQmhSUER3VmwrNVVKbkduaEFlOXZQTE5x?=
 =?utf-8?B?T3RUd3BCYjdtN0Q5SlVKWUZYMks4eDNvTXJFMTlhMzJCU2hnU3h1MkRmRW0w?=
 =?utf-8?B?MU1KQitwNjl0T092SzcrWWk0Y0RIWG5tMHVPTkJ0UE9EbkNkd1ZSY3N2NzVm?=
 =?utf-8?B?S2l2VUdhWkRVUGp1cFFCWjNDbHRMdXdBbGxGcnBTZ01QTlJyNGM2Um1YRTJW?=
 =?utf-8?B?a3FtYzZ3dnFqREN4NVZOcnVxTVNoQnEycWVTaVdxbndydENiSVVYeVdZR1Fa?=
 =?utf-8?B?ZFBLTGlVWm0zQmQxcTJnMWU1Z2VqZ3o4LzQwWC95Um9hcThPR2lTaFREMTZ2?=
 =?utf-8?B?YnVGc1JEWVdqbG40aGFCT201cnVIU3M5b2l6OFg5dEJhcmRHbndYSDZQS0NE?=
 =?utf-8?B?UHEva0dYYXlBNHhkZ05Ma3JqZkRNcUtkNnFUeGV4U1drVldIL1dBSVR3b2dv?=
 =?utf-8?B?SzVJVWsvclFsVllmYzl1cjRKZGdCWU9zMTBReHQxMkE4T2hPY0tpRzV3TFYw?=
 =?utf-8?B?SXJ6ZVVMdmFlSUVNTitTc0FONm8xMTdSbjE1UXJxQjA5R0V2TllCT3Fkelht?=
 =?utf-8?B?ZHhTbEFPR1pja3o4Ny9ydk5YNzhsamlyencxRXRRTUgrQUF4T1ZNeTJhRU8y?=
 =?utf-8?B?bUNaUkduSkNCT3dyTldkTzQ4WU0zRGVRbjJUT0RudkgydzZxbEJlT0pWM0sz?=
 =?utf-8?B?bmkxQkdGTTdSNkx5eGJwck0zQUpmekJLSDU3MkZXNXFFcGY5SlpqRVoxN1Ba?=
 =?utf-8?B?aGdpSE1rZHpHQnhiSWlUTTJmWnluSzhHalEySEhLbVdhOFpyaG1vZzR3S0Na?=
 =?utf-8?B?Y0NFaTVId1h1eTUvdm9SMElidGlkTVJ5Y0d4a0NtVnp2amM2dnVucFQ5VEda?=
 =?utf-8?B?QmVoYktFVU9LT1V3R3p4V1k2MUdHdzlEbmNXZ3BJVGxGVDY4VUk3YUdYMWR1?=
 =?utf-8?B?djRZb2syMENrR2hEdGw2dDZMbXNFQXJRTDZmWW9lRTIwWktudFdOdz09?=
X-Exchange-RoutingPolicyChecked: ea3rxES/69AnDHfkARJiUoJRLWzZrpgPw9HGLlRplbChOy0aXnYxta+jLCXs0bEFKLpzfngzPr1UQWKklpOK4jWks0MhcLiI8hq420ET9IZlTX9kHGqVmIzqI1SJvKEeiRTOByJ2i/ej/kgSLAI3UJMH9r2Kgo0TH6Mm1g4ZQnZHvwqt3czrBupi1O8rLhKAW+CVsqlfl9D0saG4CfB42LC2CVZVch6FLcIjLR7lozzLMy7dkMfYpYPCY6jeemZQfnKD73cS/dRzFAuhM4Sps8BVotmBAG7n8YKsOav77dj5ralHBDBtT6ocJlJCAF755jweG53iA3Sy+UJhM4JTHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d780a93-e109-4ec2-2d74-08df0d4e5a4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:10:28.5363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpxuWylJqiY2i09CSrjVYhn+V7EmghrM4zg0GVS10gaZR23YwM6eVKmbyQhH8eAUV+mYewMmfU9yY90PCQg6BS0zmdmYZ2o2UiE7mNrCO5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/25/2026 5:29 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  3 +++
>   target/i386/tcg/decode-new.c.inc | 21 ++++++++++-----------
>   2 files changed, 13 insertions(+), 11 deletions(-)


...

>   
> @@ -2972,15 +2972,14 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
>                   goto illegal_op;
>               }
>           }
> -        if (decode.e.check & X86_CHECK_prot_or_vm86) {
> -            if (!PE(s)) {
> -                goto illegal_op;
> -            }
> +        if ((decode.e.check & X86_CHECK_prot_or_vm86) && !PE(s)) {
> +            goto illegal_op;
>           }
> -        if (decode.e.check & X86_CHECK_no_vm86) {
> -            if (VM86(s)) {
> -                goto illegal_op;
> -            }
> +        if ((decode.e.check & X86_CHECK_no_vm86) && VM86(s)) {
> +            goto illegal_op;
> +        }


These folded conditions don't seem directly related to the main point of 
this patch. Just saying...

> +        if ((decode.e.check & X86_CHECK_no_rex2) && (s->prefix & PREFIX_REX2)) {
> +            goto illegal_op;
>           }
>           if ((decode.e.check & X86_CHECK_VEX128) && s->vex_l) {
>               goto illegal_op;


Overall, the change looks quite straightforward and sane to me:

   Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

