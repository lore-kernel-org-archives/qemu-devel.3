Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8703CC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvQj-0005vc-Jq; Thu, 11 Jul 2024 11:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRvQi-0005v8-ER
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:09:56 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRvQV-0001e8-He
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720710583; x=1752246583;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mpnsfcs3lfA3aJ44BrBCJeMjhpfgmzH1Y+0AePPekDw=;
 b=ZnhLd3yehJcS8B42YD3ufQ3Ir1krZF6YdqMDXWd8bjMVVJSEiP+Du4JG
 N4SHhUXrJLDlDxhp1UZfhnEWVPT6qguxIIClDvk42Pd82qQNU4A7fkx2P
 ExatHee9/kT/j5cF7uSIJaWWzUZN5tlZNL/Oh7mqS8y5MCpNAkJBZD3Jx
 2v+M+kwyxtyM8PIaBIhR9jpiPb+DSoHl8bOQ/sXFU5oBiGhuUBqUE5C7D
 z92/SOR9wuokrwWblfYx4vyBmh6Zhi2u66bDMay7N/sXFEdWzYJoH3+0J
 r1CLIX/yUB6ws+HHN6ADmNbbR0mYlCKkCGdiBeb5eSlmOd6FssQM9aq+t A==;
X-CSE-ConnectionGUID: H+En7wLASRmVoo3bK06eVQ==
X-CSE-MsgGUID: Qbu+R9WqQuSi16/4XbUjnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21968548"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="21968548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 08:09:35 -0700
X-CSE-ConnectionGUID: 92m6Sa0UQAOJNBLVd1kD4Q==
X-CSE-MsgGUID: qwi4ofUWTi6LmAt4kw7Kyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="48334882"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 08:09:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 08:09:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 08:09:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 08:09:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 08:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1ne3o8w8smyrGYHVFcOFXHDEV/NMdNL2YJ+hBMnoHjppaDT7K07J46hgR1PuwXdJ4/x90VjH70w7C7v1NQ5ljX104+i8oEcvN4TEYM4ZB7BLNEA2b6U/QKZjnTjIxCwPzlg0den0CQiqiHbIXT3v7YOJZXJV6jaqMWJojYbhViyIWtVRFayTSkBQjDnT8XQ61X5YpRm7iOmU268mbP53WjuOO9leZhAGxh3qNdtUnN8YLXeppgFWdPB3jqge7UKlfyMbhHqR3QlJAg45vPpqnnUGplxy6g9aHxnKVKGzZ2p6kaFUZpESZPq3dtjAcSq3C9XE8FbAgOjG/B/mifRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpnsfcs3lfA3aJ44BrBCJeMjhpfgmzH1Y+0AePPekDw=;
 b=xM+E2sPPBgPX4MDQxBohi0F6kzeELYh6A9ZEsC0d3Y7dV9WVlNFPPrAfgcal0dmMuVoUnr6QDCYBH4weZUcN8m7VsxHQ52jjAu+hqKPlV4yDmtv1tAlG5Wr6I5QRnJ+FqZAuBJ6rKrhOm4P+Igc/Jgq/gzXItAxoWZ+OQYp7T1JPmQ+GG2FulX4Ylj5LMfLPePRGclGzC01V2CWMVbQ+f+2vxPoAlVrZqxW64Oe5se+bSbA2APWAZsg/PI0PvA/SiPN/pMRxMdNIlDRqWgOGGuc3Pqk5fmCW4lmqsVmYYO/0ogxsFvDgDmMx4cfuxm8i9w8jePhAdH/72b8c7Hx55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MW5PR11MB5763.namprd11.prod.outlook.com (2603:10b6:303:19a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Thu, 11 Jul 2024 15:09:30 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 15:09:28 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Wang, Lei4" <lei4.wang@intel.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHxdZ6AgAACIHCAAAhAgIAAGvkwgAADngCAAAvJ4A==
Date: Thu, 11 Jul 2024 15:09:28 +0000
Message-ID: <DS0PR11MB63739AE0E6F24CE21675CA58DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
 <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zo_PGVjbRHMfe-Gf@redhat.com>
 <DS0PR11MB63736018180E286CC7D36167DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zo_owsKVk32F9lwb@redhat.com>
In-Reply-To: <Zo_owsKVk32F9lwb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MW5PR11MB5763:EE_
x-ms-office365-filtering-correlation-id: b4e8663d-8a5a-4d6d-c7ff-08dca1bb75b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RFRMbVBLZ1ZOL0tsa3RuVW9OU3ltYXdVMkkvR3FHZS80cEVDQm9xRFNDd3Rq?=
 =?utf-8?B?UXk1R1hLSlRobHZxKzQyd3pDREJ3dUthQ2dITW13d3QwcGJvSnRjamFXeTVE?=
 =?utf-8?B?R2NkeTMvcVBMQ0JIekZrVWxzbXZLSzB4NysyaUMxK3pVT28vdi9sbDRSdlNK?=
 =?utf-8?B?alVKSmNlTDErZHhlTk5CN3A3MkpUb3FwUWwvL0tzNkh6YmhFa1E4aUpkbjlC?=
 =?utf-8?B?elFDS21SVGZ2NkdqZEYwMEo3QzdNRFd6QzRUa2RLcTd1b3JiZ21iQzlHTVhM?=
 =?utf-8?B?dmkxVmYzUUpJK3M5dmlnVks0bytWZmgxZjQvbUlENG5iaUhOMkpqWU5KRjJE?=
 =?utf-8?B?bGZ5MUtvS3JLc3BYcmJ2VjU4dXhQREJ1WU9YTlgxb2l5bDkzMDNDMDZLM0JO?=
 =?utf-8?B?Z1R1bWRBdDUxdCtCcHVBSnJxVkZtUGJTS0VCU25wUSs4N2M4bHh3MVQrWS9l?=
 =?utf-8?B?eGpDaUdqRFEyRDNzcHRINkplWHJmZEwzUTRwTlU0dVExajlMUE9qa0QzUlFJ?=
 =?utf-8?B?WHhPYmxFV1pFSGpzNnRncERtU2lvcElBbzg1aE5JaGw4eU9VckpxY1lGcUFX?=
 =?utf-8?B?RWJ4Y3puOVZabTEyeW83dTM3OW9XNFczT0trQjByd2prcWVHKzBpUmhLOGFK?=
 =?utf-8?B?OXl6WUtOSytyaEFyenJVN2FxdFA1VXJUSnRUbVJnL0NRUnMzMHg2YWwwU3Iw?=
 =?utf-8?B?MGptOEc2YWlqeUlSaGlWdnJiMEpZQ3FqbCsxUDRMeDBPYjhJdGg3aEJlai9v?=
 =?utf-8?B?MVc1ZGJEMWFDMjdxWkpIZVJQMStiNEswMjhNa3k0OEtmYXMyRWF1cnBqa0FD?=
 =?utf-8?B?TlpKSy9xL2szdXg5S0RtNStsaFZpOXVIa1dRYjFyamlqMHR5cUlKMVYvenZG?=
 =?utf-8?B?LzBtYnNUVTB0UnJEN3JIWWRrMzcyd3Faam5rUGRiWFFwL1N2RVZycEo3WDNa?=
 =?utf-8?B?NFJmUUJKVnB3VzJaRzdrSDJjUTlyV251SjNBaG1Yc3REMW9HRTRrUmY1dFUv?=
 =?utf-8?B?emQ3b0s2MENKRGptSWkwVWJMTXdQYzNuckFPd2VzV29mT1ZKUlM3TVFhVEpz?=
 =?utf-8?B?dTF3OUJWRWNhUmRadHlNV0JyNVdkck1EL1BoM0h6a2NNTG1PcnYzZDN0eXY5?=
 =?utf-8?B?MXUyY1RiQ0tKT1VablppSXVoOWhvM1J3WWJiR2cxMUF2cTRRVEttZThUaThz?=
 =?utf-8?B?Y3RBWkl4WVVuRStFY3NNQXBBUDIwZjBZbUl2ZDZ2dk9DN2UxZkZRV2EwNWN4?=
 =?utf-8?B?V3FNMFNEaEZ3SHozQjhhMEErMk52TXh0eWFESCtNNDBJbG5Sa0xUZnFSeWdT?=
 =?utf-8?B?bDZGWEgySzF2V28yd2FIQTQ2TVRKSllTbDMyNXZHTUF1SndVNzRnWFpuc0FI?=
 =?utf-8?B?ZmFJOVI0bytJY05kbnhFaTdVQzkxK3hXdlkyRXkyM1hSY0ozc3kzUzRMcEJx?=
 =?utf-8?B?ejQ0VUxnR0FMYTBjOFhtL0ZocS9LWHVtRCtlRTg0MWduWFBqVWpiMEp1UmlM?=
 =?utf-8?B?dmFJNFFqYjNCbWRuNExDQkYzZ0phZnRHRDE0RmhXa2ZKZWJvdzV6cVhyRlJP?=
 =?utf-8?B?QjBCWWJWbSs5ZE43ZnNoOHVCU1FiZUNkNjlzNFRVd0g1cUVMVFZEL3QxdVBu?=
 =?utf-8?B?UFJ4MGEwSXdwb0UxOTRueHA2OU0wZGtER1NBMlg2RWtvRlR6ekNkclk2RkhV?=
 =?utf-8?B?Slc3VTM4RW9FK3YvSUVBc0dIeGtTNzVxYzQxeC90ckpJcXRkb2g3QURnMlRV?=
 =?utf-8?B?TTdRNThzNndLMUdabHh4M1MyekRXTUVvRnEydGVlOTcwYWNVSkRncmV4cDRZ?=
 =?utf-8?B?OG0zamh2YU5zM3AvVFgzQlpnWm9YUGNoWEJjbVB3VFpBeGtJNHlUT21TVTFE?=
 =?utf-8?B?SWNNWXFab21MaGF1MHo4UG1RczVvQXp4c0lDUXBzeHZqcVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEFZbmIyRWttWXRrZFpkT0laaitudlBnVEFyRFhyU21lZVVwUFFrdWVkTFJM?=
 =?utf-8?B?dCtoMmlTalZYaDVGZUxYYWd3UE9yWjJmU1hOUWZjTldyQkJxQU5pQVJyaG9l?=
 =?utf-8?B?VzQ2OEt3YWVxTG55VmhXci9GVHZ1V21vV1NscFlwaDY1ZVJZbG9nTWo3Mmw4?=
 =?utf-8?B?ZjNVZ0RybnBGR2VBVVBBL3EzdThNQVlFUGFkN3NMNThTZVJDRVE5djFWSmlT?=
 =?utf-8?B?RTZPcW9oRndyRG9COVVGeHBOVWFaWndneVB0dGJJdTU5ZGVtR1ZWMHh5bm56?=
 =?utf-8?B?eGpCSVZHcXpBblkzcXpwT0RZUWNCNnRoMEU1R21XSWtCUkdzaEIreERnWjFj?=
 =?utf-8?B?ZU5jM1QyZElHdWJ0cS92SUticDZQNnl0QjJzSTc3WlFOQ3RWRWFzL0lOODBU?=
 =?utf-8?B?UUFWNEJDWlFWVVBON1VUTW9JZE80SUFpMzRKTTEyclJ3N1NadHZPYjB0b1dn?=
 =?utf-8?B?YTRxNEJuNTNwSy9EUDJJTjJTa0VYUVhnKzd4Yk1yUmRWUUphc3gwSHExdm85?=
 =?utf-8?B?dmlNZ2ZoRzNSQkdjbEhQdlJvN3RQNFJFVXdrdlluNGN3N0xOS1FjTmRKbitw?=
 =?utf-8?B?T2szcVFHNlZ0Y3RFVm1WcEhNSGg0U21XVmoxN2cxNW54dVA4WEp6U1psSG1R?=
 =?utf-8?B?dHEyOU5ZOS84K3cvOTJFa0hPK2pHb0QvZGhoN2w5M0RWTGRFTHZ6L2pnQS95?=
 =?utf-8?B?dFF4Z2RtZHVPR1M3a0EwRE02dGhsYXlhM0h5RkJDZE5BTDd0M3R3bXdPQVJ2?=
 =?utf-8?B?SlVnektHeStLTnRQRUQzaDZuWFZXMFB3WE9vSlR1bktJVE9ESHA1amswRmpJ?=
 =?utf-8?B?SHJFRjYvUTVHZzBTaHNVRUFhRkJjUStKWXhPcFpSK2hpVXZaNlJxMWlWVmJE?=
 =?utf-8?B?c0JnSkJWOTYzQ1U3dWVSakRkWDRjUHNXQzBCeXREbUVwelBRQ0pvYktsK05q?=
 =?utf-8?B?VnkvT0I2T2l6MFRxYlNRVWxMQkFObkVVcWdVWmxqd01nY2k0aEVzWHpDNFlj?=
 =?utf-8?B?Q2YxdllxNlJIc1FGZjlxSlhraDVYenEwMWplZDdUL0drcnF4alNOYjI3SCtr?=
 =?utf-8?B?R2w4M1UvenhaSm5DdGlLZWEzeXcyQXhoUkN5SXpocmQvSHRCNnRpUHpSRGxw?=
 =?utf-8?B?MFNYTWRWdmp3RFovbEJiazVBWnpSVHRLbkIrenQxOFAxZjdUYkdmRFB4Kzhp?=
 =?utf-8?B?RDViM0VKQ0JSajFJZGpER1dyTS9VUnJyeHc1Q3N5RWtkRHpjL3RXTzlSbXRt?=
 =?utf-8?B?c2tpTmN0SDRqRVhMRnBEeFlrK21aS1MycE1velppY0Zmb0xyYm1pU2tlMWRl?=
 =?utf-8?B?Ym9ZV0MxNys2Tjd0SGp3QUlvQlJOTHU5OW41VkdXVCtWYlUwMk0vUWpucldH?=
 =?utf-8?B?cm5yekpabWd0bm1Nck0zNVFhb0FKOUdnK0lJQVFLUlJzSEdJeHZlL2RQUEdl?=
 =?utf-8?B?UWFOcHJqVHBxMXNJZVY1bjlpQVdPVlhwbWxKamlaUnBOMVp4SnpWcWwvK2tD?=
 =?utf-8?B?VTNGb2VUQlVZVlhrQ2J0RVp4Ukg2VW5DNXY2cjFoWWFuSzM3aHhXR2F2bzU4?=
 =?utf-8?B?NXVJbUxIK2UrY004WU9qZ1JKZytkbWp6MS9pSC83UzhGNmJERDV6eEJuWGQr?=
 =?utf-8?B?ZFV5S0pXRXV0bEN6aVRFbGJDUC9taUdzT3J2Wi8raTFzZUhkMVNKTXdpbUIr?=
 =?utf-8?B?dUtVbkNVVUcwZzBDZlNoS1lmaUpHdzZpOGwxT0JGc1o2aTgyOGN6dDVBZDBO?=
 =?utf-8?B?K1ZMVGdSTTFpSDFnc0JDampEOWoxTllMQUs1OUdHdThPS3lQTTNQOTFMZ0pw?=
 =?utf-8?B?WGxjWHVpNFZCWFpPV1d2MEx3Q1VPZ1B6UlY4Z0ZDTGFVTjhCWkZpbFR4SUh4?=
 =?utf-8?B?d3I4MmZWY3hRbUxDVnJHWkt4TFFhc2c2aEhYV3pyV1hPVU92a0NmNXMzVXVN?=
 =?utf-8?B?UDNXRzd3TUFvd3g2Q09iVGJYdEdTU0dZcUpvVG1DZDhmSGptNE1BOXlMK3Rt?=
 =?utf-8?B?U3dYN2ZTc0F4TWNBSkFzd3BKTnJrOWVkbWJ3cEMvNFMzbmwvTUt5bHNWSU0y?=
 =?utf-8?B?VW83aEJiR3A3aE9taktJUHVNYmtBRlN4VGZLY1hsUGFkS2doWWhDNDl5VXY1?=
 =?utf-8?Q?QQO5QHgzHBCi8eUez2UvvBKS5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8663d-8a5a-4d6d-c7ff-08dca1bb75b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 15:09:28.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgoyA+YuXhOrzBBBa55kUJKH5UMOey/isjCfywdB6CL07bRyQ1w1baeRfoqwUMT7vB0+NssR1v8IdBr1Bl+Gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5763
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gVGh1cnNkYXksIEp1bHkgMTEsIDIwMjQgMTA6MTQgUE0sIERhbmllbCBQLiBCZXJyYW5nw6kg
d3JvdGU6DQo+IE9uIFRodSwgSnVsIDExLCAyMDI0IGF0IDAyOjEzOjMxUE0gKzAwMDAsIFdhbmcs
IFdlaSBXIHdyb3RlOg0KPiA+IE9uIFRodXJzZGF5LCBKdWx5IDExLCAyMDI0IDg6MjUgUE0sIERh
bmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEp1bCAxMSwgMjAyNCBhdCAx
MjoxMDozNFBNICswMDAwLCBXYW5nLCBXZWkgVyB3cm90ZToNCj4gPiA+ID4gT24gVGh1cnNkYXks
IEp1bHkgMTEsIDIwMjQgNzo0OCBQTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gPiA+
ID4gPiBPbiBXZWQsIEp1bCAwMywgMjAyNCBhdCAxMDo0OToxMlBNICswODAwLCBXZWkgV2FuZyB3
cm90ZToNCj4gPiA+ID4gQUZBSUssIG1hbnkgdXNlcnMgYXJlIG5vdCBhd2FyZSBvZiB0aGlzLCBh
bmQgYWxzbyB3ZSBjb3VsZG4ndA0KPiA+ID4gPiBhc3N1bWUgZXZlcnlib2R5IGtub3dzIGl0LiBU
aGF0J3Mgd2h5IHdlIHdhbnQgdG8gYWRkIHRoZSBlbmZvcmNlbWVudC4NCj4gPiA+DQo+ID4gPiBV
c2VycyB3aG8gZGlyZWN0bHkgbGF1bmNoIFFFTVUgYXJlIGV4cGVjdGVkIHRvIGtub3cgYWJvdXQg
UUVNVQ0KPiA+ID4gY29uZmlnIGRldGFpbHMgZm9yIG1pZ3JhdGlvbi4gSWYgdGhleSBkb24ndCwg
dGhlbiB0aGV5IG91Z2h0IHRvIGJlDQo+ID4gPiB1c2luZyBhIGhpZ2hlciBsZXZlbCB0b29sIGxp
a2UgbGlidmlydCwgd2hpY2ggZW5zdXJlcyB0aGUgY29uZmlndXJhdGlvbiBpcw0KPiBtaWdyYXRp
b24gY29tcGF0aWJsZS4NCj4gPg0KPiA+IEFncmVlIHRoYXQgbGlidmlydCBoYXMgdGhpcyBhZHZh
bnRhZ2UgYW5kIGlzIG1vcmUgdXNlciBmcmllbmRseS4gQnV0DQo+ID4gaXQgZG9lc24ndCBzZWVt
IHRvIHNvbHZlIHRoZSBpc3N1ZSBtZW50aW9uZWQgYnkgdGhpcyBwYXRjaCAtIGlmIHVzZXJzIGRv
bid0DQo+IGV4cGxpY2l0bHkgc2V0ICJlbmZvcmNlPXRydWUiDQo+ID4gaW4gbGlidmlydCBjb25m
aWdzIGZvciB0aGUgZ3Vlc3QsIHRoZW4gbWlncmF0aW5nIHRoZSBndWVzdCBhY3Jvc3MNCj4gPiBo
b3N0cyB3aXRoIGRpZmZlcmVudCBmZWF0dXJlcyBjb3VsZCBzdGlsbCBiZSByaXNreS4gVW5sZXNz
IHRoZXJlIGlzDQo+ID4gc2ltaWxhciBlbmZvcmNlbWVudCBpbiBsaWJ2aXJ0IHRvIHJlcXVpcmUg
dXNlcnMgdG8gc2V0ICJlbmZvcmNlPXRydWUiIGZvciB0aGUNCj4gZ3Vlc3QgdG8gYmUgbWlncmF0
YWJsZS4NCj4gDQo+IFllcywgbGlidmlydCB0YWtlcyBzdGVwcyB0byBlbnN1cmUgQ1BVIGNvbXBh
dGliaWxpdHkgYmVmb3JlIG1pZ3JhdGluZy4NCg0KVGhhbmtzIGZvciBzaGFyaW5nLCBidXQgY3Vy
aW91cyBhYm91dCB0aG9zZSBzdGVwcy4gRm9yIGV4YW1wbGUsIHdpdGggImVuZm9yY2U9b2ZmIg0K
KGJ5IGRlZmF1bHQpLCBmZWF0dXJlcyBvbiB0aGUgZGVzdGluYXRpb24gY291bGQgYmUgZmlsdGVy
ZWQgYnkgUUVNVSAoa2luZCBvZiBzaWxlbnRseSwNCmp1c3QgaGFzIHdhcm5pbmcgbG9ncykuDQpI
b3cgd291bGQgdGhlIHNvdXJjZSBzaWRlIGxpYnZpcnQgZ2V0IGluZm9ybWVkIGFib3V0IG1vcmUg
ZmVhdHVyZXMgZ2V0dGluZyBmaWx0ZXJlZCBieQ0KdGhlIGRlc3RpbmF0aW9uIHNpZGUgUUVNVSAo
YXMgdGhlIGRlc3RpbmF0aW9uIGhvc3QgaGFzIGxlc3Mgc3VwcG9ydCBmb3IgdGhpcyB2Y3B1IG1v
ZGVsKT8NClRoaXMgY2F1c2VzIGluY29uc2lzdGVuY2llcy4NCg0K

