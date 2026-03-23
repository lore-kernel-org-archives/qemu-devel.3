Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D651D58CDD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 06:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4YTO-0002cS-QT; Mon, 23 Mar 2026 02:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4YTN-0002cF-8e
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 02:09:09 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4YTK-000052-Ht
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 02:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774246147; x=1805782147;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HDVhs9y/x0mPVXysgvBWHhjESSNZEWDjajaS+JllsFA=;
 b=PfgHcGxGCMcgVdKS20X1nCC6BZlnPGbLYUjIEqQTE8l6LNIRqSvnU040
 FKzI8REQs2Vatw1OTLZkNVnKZPqsA8Rme+dFEwj8yMt4jwvcof8oJT1IV
 L75jm+MS8junjT/ye6zdgnlWIm2V2uVZbKGYi8omG01Gx/pUu0RetQyH5
 8CPYBTWFvxslPq71GO5EhK7Y5Lm0X22h5ID7WA/QKTrZ/jX2J/GmIGqgW
 kHWqdVcSoX0pxf62hB4KkGKcOC8P8byQzLSUCMAO5Xd/nOWtGdJ73kbtM
 xfzL11d7+wwW4JeKpcY62pB6Q37HD5ExWDlsTV37hu+PkR6NK8k+pbGzR w==;
X-CSE-ConnectionGUID: rgxzjt2ASbq9nVuAyDetuw==
X-CSE-MsgGUID: UrOcZRjVTRGdu5Xy4V4h9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86310694"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="86310694"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 23:09:02 -0700
X-CSE-ConnectionGUID: HjHxyKrDRKyvVBKZyTLDkQ==
X-CSE-MsgGUID: 3qrhOXRORfWYyLQqySph/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="225669337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 23:08:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 23:08:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 23:08:57 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 23:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBHg4dyonKmv4ALEoNHtAXDVIqqAqdlFlfP2LV73mAvpEX+vEILu43OPPn7dJIu1os3EeLju2dR1BPEU+y5O0m64NW0f9knM3Blh4P9QIcpc3zHEzdel27XIN6Yz9r9SAJ6YgFQX5LASo7IFSdfRehSjpMIdI7kpKHbk4ZR1kE9/LMG1M0C0kFYk5Kq6lmp1vGM0f6HUKyarqH+Gf3vTT/2MCjknsDSzMCrViRWCCM0mB/I/sDbRS6t64jO6+dcC9d6ozlYvs5GuFjFUMQU+Ldjbp0XE6Bdb5fKJgEAmaOs6DsnSx+EMvv1MzhIzeyxuv3Du8amuYwzTV2YKzuLthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDVhs9y/x0mPVXysgvBWHhjESSNZEWDjajaS+JllsFA=;
 b=B6P6eSH0Lq0nE2iDRGsU1U0rBCxFdGwIqSgYThSIJmvSY+Br/7M+TjoYaUV6HX69eFHxPl1bIsrnkmlDbYqKAzo2NsXJCBa/LEmza0NAmCX3KBOFnySpBABmZ5Ugbh75wVaXcM+a7UXecmbvYqq6R0sgupLcTYzRQiK47xiFivnzNL+9x406raF1CYTYqNed6A5dzr3cVVH4DQcDHkRPJFmAUyc1PtTNQeFobuiXftmaafWCdkxsayvcc9ukEB+EdkcyeldHM1iRr6GlbGTWoOnaJuEVeO2xBI3++njW2g3WFbOrVt4KAQt6qHGHtKB5PClvL58Pldkd1m9PHEoNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:08:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 06:08:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Index: AQHcrRuagpYoYycHDkaeqayzx0ooOLW3SNUAgARywmA=
Date: Mon, 23 Mar 2026 06:08:55 +0000
Message-ID: <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
 <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
In-Reply-To: <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB8206:EE_
x-ms-office365-filtering-correlation-id: 8f3779c8-0a4d-4b3a-eaa5-08de88a2aa5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|3613699012|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: y4KYkXFFnU2fQ/qM7q5HmCy+4aJH6k10v2qn8dDjZSaalNK4mjF1kpsqbgN21/gCtyEG1jseSbRGNnEbjpb0ZKwPH8m4Y9E5l9RK9PMFuTA16TZpb96f5VwlJaDycaeI6msrTAVkjeIOzIGyK3cVDA+dX5At54fpAyIYD3P3JeDi+FwV82sVIckgaReAWsJbwHR7trLJX4/G2GZrD7sXSG1kFuqulJoKiHQssVCaMzAvQ8797/5RlNrQIKvW1i0kO6OdJIEz91Z68pv3cQ3vMHHMEkHrjfCGxsO3/b5DpS2dAm+8CHXaAcqbg9I/gTfiOOfVtaQgwzBmqh9+OItaThKG4bGWhhmEOfvvSfArmcmU9ywama2znbaEibvQnNAiglKqTjXpoAHUx5VGp3y8ED+B7cWwRlMIDHfNRgC/ey8tSMFCa4JpiYUulKIuj1HyjnA5Yanh3Xf9Z4DXppc9LN6dsOT88Iz4gnJpGE8rWmpi1DTt15odVaASODrM8jpZ54BVx5MYHjJL4+eILtqtjO4q+izHiCCULlRm0cJ7AmYY+XXRCIlRecizwBMJm7ptCkeeL4HHzPa1zF9RH/Kiv64fiSc6Zhq4kbczkEASpbFv+OZA9EzGMds1xOAzULWP7fCOOMW6Z0OrdIi+NvNLa7ThnyqV6kkljouXredkkmeU8jbRjZlEot//yeVTrErCjfhmzvC8SpWLmo9seRoiCAT88tTbjf+WAb5VwMj23M7cOx2ay6QhR4rLGPlP4aRygUsL8pJNZbFSqdD02e7X35zzUkHI3uUBZVJ6w/ZOBTVH/P6n+046oI+OAUkoySXB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3613699012)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3VWY2JPS1BDV0pXNWd4S0djVC9DTldKNXpiRFNrdUp1S2VrQjJjWTdXNEc2?=
 =?utf-8?B?Sk5Sdm8vSFRFSEhXWUZkSFZmSjQ0WkdIMkFkQUZMMjZQclZVK3N4QjdPM2ZI?=
 =?utf-8?B?UmFPWjdBR3BPUUtIbGcyOFhqY3pHYjkwRHlzbHhMNC95MUtKYlh3RlVieEhJ?=
 =?utf-8?B?bG9PZEl0RUtISW9rUG9wbHBObmhRUGJvRDg5VnhRcCtNbWtEc3Q1NU0vQ2p4?=
 =?utf-8?B?OWtUUTg1elI0dkJmYlVUcDJod2NqM0Y2K1pzUk50R0VEYUdnMHBoS3U2KzVa?=
 =?utf-8?B?YWNLU3Jsa01XVXBaTEs4MG5rdVFCd290UEZzelFQSGdFenphYkJWdHFQN3lZ?=
 =?utf-8?B?VXpha0lkZmhTSUhXWXlxUUxlTjRxWk1RTGNLZXFwaUs4M1VVb2N4d21qNlNn?=
 =?utf-8?B?Mjc0djdiYzlONC9vNTZMd0YwZUd3UXcyMDlqd1VUZGQ4d3NJZC8xV0hFQW4w?=
 =?utf-8?B?R2lFaWZGM3oxOFNlUzdXZXZJdU8yWjV4OWFLMHNKdGhueUo1SkFWMnRrVXl1?=
 =?utf-8?B?UkNZZ0hqSnZ5QzQ2TEhPclFVQ3JPeDc0NlczK2o5aDRuQkNIVHpUN2JINEF6?=
 =?utf-8?B?eEl1M3kzNGNqRXhaVXdJbWRsZEhBSXhpSWRpWkJCTk1CL0RJQ0dQdkFmOVh6?=
 =?utf-8?B?L2Y1cVJESlhSV0lvR3k1WTBEcmV0bEJXVGZJMnFZVnFwSWw5UGVOUEVwRWln?=
 =?utf-8?B?akc1RmZiL0xOMW9SMGZsa1J0U1BxMUs1bXMyUXYwK0IrRlRUSnNIbzFxbU44?=
 =?utf-8?B?OFdJN01DMllSVDFmZE9yYXpud3AvalJtSlZkRzRRNC8xSXV5OWhYbll0d0NX?=
 =?utf-8?B?aHJ5VzZUUkpBN1ZDcndBTzNtK1cyai9zeDd6VjJTUDVhTUM4MzFCQk9MdDlI?=
 =?utf-8?B?eGEyQytMTDR4UlpxYXliNWlpZGxaMEE3TTNBTHB6Y0lmOVdTL2RHeXpydk9C?=
 =?utf-8?B?T0RvNVhGRFI0d2duVlJXaEd0NVZ4ZlJRMGlpSFZjcXY2SE5PS25WNjA2dkV5?=
 =?utf-8?B?OXV3OUdEc3cvbDRZTjh5b2tnQ01xazBYOS8vQkhVNFE4dzdMOTRDcXVuaEJM?=
 =?utf-8?B?VHh6eVVDQ0N1bjlEbExuZGcxT1kzSXlDb21pai9Zc3RPTkVPWlJUYUtna3Jv?=
 =?utf-8?B?Unp3NHR3eWlpNzNOZG9tbXdodmdOQm1yRnFsK2NnbWYwdEczZ0RON3BabUJx?=
 =?utf-8?B?WmgxWDMrZytERUdheVRKeXo5Rjd0RUV3TlJ5NFVGS0l5aW43UnlUR0tQdTlo?=
 =?utf-8?B?QVRsSFJuZXR4Znh4Q0o5dkpsbno3aGQ3Q05BaWtFbWZsOTVUZXI2bXdHbER3?=
 =?utf-8?B?L1YxdmRpa0hLRFFxYUdkWXRIQi9jOUVHUWFkaW1RUVNyS3YxYnZqbVFkb2lI?=
 =?utf-8?B?dDVZdXdBYUZkZmM1ck1KSzM5eEx4S2N0Vi9ZWXJRM3FhV2lJTVA5Q0dRdGhv?=
 =?utf-8?B?MnZJRWhFWFNHRkJQTTNLWmM3VDBBUStFTVJIQWFwTzhqcXdlcGozL0xBNnJW?=
 =?utf-8?B?ZkVubHgyTC85VkM5dWxwZ0hSWlE2RkNXTGFCLzFFYnVDV2lyK2NSbU5jQ08v?=
 =?utf-8?B?clhxTzVvcG5Qb2FnVStiNUVvbWdSOG83RmpuN21TcHM2Qk1HK2F5bjBmUzBC?=
 =?utf-8?B?SUcxK3B3ck1YZ2htMisrRW80dXh5V1F6NFkzMkgrL3hNK3Q3dUgwQjZkamRT?=
 =?utf-8?B?WEw5SFRLVFR3NTVqQUtJTlJSaGRFckQvKzIxTnMwbTV2SHd1VEo3UmkydTJj?=
 =?utf-8?B?NkZpcGpVWVdwMkE0cEYra3FHRlZsV1cyT2FBZlhKbEhDTnMyUkEzUFNSUTNM?=
 =?utf-8?B?RDVqVlBYeFhETUZhOWNlRGc1TVhwY0Y5bVJBNlh0OXhjUGRiREpUaUhtQXk1?=
 =?utf-8?B?bWprWm85VmJMWUhrMFZHN3VNZ2dJaTRFbWk1NHlzQ2s2K0lkTEdpTTFkSXpH?=
 =?utf-8?B?NTVLb01WMVI3ZEhJUnByb3lGTm5kTzJQTXpOL015a2daUUh1c2dzT1VxNDdW?=
 =?utf-8?B?SmlERkVCSXBKRGROMnFJQjc4U25pVWRQRmJ2WURHcTh0MDA4YzRMQW4xc1N2?=
 =?utf-8?B?V2czREVBZjdJZWt1QTZWYXNtTk0rVDVGRGlsVHI0dytmOHdPLzdNTzNSZWhl?=
 =?utf-8?B?YlNrNTNrWStYK0hWeVU5MFBjTlpvQTAxTGFzQWpmZW51a2p4U1NEMm94dFBx?=
 =?utf-8?B?MHJLYmRGSEs0bUNieXBIL0hMNkVPNG1FLzRYV3EyQmNEcDZFRVBvcUFYakxS?=
 =?utf-8?B?Z2pvKzdEcUt5d1VZL0JLMy9ya0w0NEVoMmxFS29scTlUb3JhQ25IcGVFWnB3?=
 =?utf-8?B?NWIzb3crclBUbmhOb3d3YXAwTCt4RGs0bXlqaE1UcEZjTTBKeXVHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lrvFl+5c8O+fo/SX7qzegF3F4CqzSxyUTYobvcfpErdTUSf7SWC+C3Lek2iZEPiiKhLRNexYLtAv7x7/uffdnZoR/kcuF0usoOZ6NubutkNNvKIm/oKk7IXG4+jjiKW19aqRszwPVbbmk06lYYIjpjOzX0tdytqpTKw69wq1zJCOXjEBv3X4nHCy0ixwFJ10c36PedGdPzLjQjYl7wrBPaD8xz+W9WeiX/jj8MDPR0Ga0JR6tPXBm3a/nfwPdhzBkPtlJM6GVbI266X220r3bUF+4DGaIwM1I+1qXJXRffNpolmrAv+/ej2xXfPcnII1KnPVWOS9DhqPBg1MiBw3zA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3779c8-0a4d-4b3a-eaa5-08de88a2aa5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 06:08:55.7082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xFHwvRf8tP3Tc4udhrv8Ww5v7A9pHUtr9BsxqAAdu75jEIh2doIE9OXyN2g+M5yK2YhmhKBiDg7096c/38E9kH+WT5Pz9FASRLBK5bECL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVlc3QNCj4N
Cj5PbiAzLzYvMjYgMTE6NDQsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBndWVzdCBk
ZWxldGVzIFBBU0lEIGVudHJpZXMsIFFFTVUgd2lsbCBjYXB0dXJlIHRoZSBwYXNpZCBjYWNoZQ0K
Pj4gaW52YWxpZGF0aW9uIHJlcXVlc3QsIHdhbGsgdGhyb3VnaCBwYXNpZF9jYWNoZV9saXN0IGlu
IGVhY2ggcGFzc3Rocm91Z2gNCj4+IGRldmljZSB0byBmaW5kIHN0YWxlIFZUREFDQ0VMUEFTSURD
YWNoZUVudHJ5IGFuZCBkZWxldGUgdGhlbS4NCj4NCj5BcyB0aGUgY29tbWVudCB0byB0aGUgbGFz
dCBwYXRjaCwgSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBoYW5kbGUgYm90aA0KPnVwZGF0ZSBh
bmQgcmVtb3ZhbCBvZiBQQVNJRCBlbnRyeS4NCj4NCj4+IFRoaXMgaGFwcGVuIGJlZm9yZSB0aGUg
UEFTSUQgZW50cnkgYWRkaXRpb24sIGJlY2F1c2UgYSBuZXcgYWRkZWQgZW50cnkNCj4+IHNob3Vs
ZCBuZXZlciBiZSByZW1vdmVkLg0KPg0KPlRoaXMgaXMgY29uZnVzaW5nLiBUQkguIHRoaXMgb3Jk
ZXIgaXMgbm90IHF1aXRlIGltcG9ydGFudCBhcyB0aGUgY3VycmVudA0KPmltcGxlbWVudGF0aW9u
LCB3ZSBkb24ndCBoYXZlIG11bHRpcGxlIHBhc2lkIGVudGlyZXMgc2hhcmUgc2FtZSBjYWNoZQ0K
PmVudHJ5LCBzbyBhIGdpdmVuIHBhc2lkIGVudHJ5LCB3ZSBlaXRoZXIgYWRkIG5ldyBjYWNoZSBl
bnRyeSBvcg0KPnVwZGF0ZS9kZWxldGUgY2FjaGUgZW50cnkuIFNvIEkgd291bGQganVzdCBkcm9w
IHRoaXMgbGluZS4NCg0KT0ssIHdpbGwgcmVtb3ZlIGl0Lg0KDQpJbiBmYWN0LCB0aGUgb3JkZXIg
aXMgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbi4gSW1hZ2luZyB0aGVyZSBhcmUgbG90cyBvZiBwYXNp
ZCBlbnRpcmVzDQppbiBwYXNpZF9jYWNoZV9saXN0LCB3ZSByZW1vdmUgc3RhbGUgZW50cmllcyBm
aXJzdCwgdGhlbiBpbiBhZGRpdGlvbiBjb2RlIHdoZW4gd2UNCmxvb3Agb24gcGFzaWRfY2FjaGVf
bGlzdCB0byBzZWUgaWYgYSBuZXcgcGFzaWQgZW50cnkgYWxyZWFkeSBleGlzdHMsIHdlIGNhbiBp
dGVyYXRlDQpsZXNzIGVudHJpZXMuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAt
LS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgNzANCj4rKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3MCBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gaW5kZXggMGFjZjNhZTc3Zi4uNWE5NTZh
ZjkxNiAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtMTYsNiArMTYsMjggQEANCj4+
ICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnVzLmgiDQo+PiAgICNpbmNsdWRlICJ0cmFjZS5oIg0K
Pj4NCj4+ICtzdGF0aWMgaW5saW5lIGludCB2dGRfaGlvZF9nZXRfcGVfZnJvbV9wYXNpZChWVERB
Q0NFTFBBU0lEQ2FjaGVFbnRyeQ0KPip2dGRfcGNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gK3sNCj4+ICsg
ICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCA9IHZ0ZF9wY2UtPnZ0ZF9oaW9kOw0KPj4g
KyAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSB2dGRfaGlvZC0+aW9tbXVfc3RhdGU7DQo+PiArICAg
IHVpbnQzMl90IHBhc2lkID0gdnRkX3BjZS0+cGFzaWQ7DQo+PiArICAgIFZURENvbnRleHRFbnRy
eSBjZTsNCj4+ICsgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgaWYgKCFzLT5kbWFyX2VuYWJs
ZWQgfHwgIXMtPnJvb3Rfc2NhbGFibGUpIHsNCj4+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1JU
QUREUl9JTlZfVFRNOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldCA9IHZ0ZF9kZXZfdG9f
Y29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfaGlvZC0+YnVzKSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9oaW9kLT5kZXZmbiwgJmNlKTsNCj4+ICsg
ICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsgICAgfQ0KPj4gKw0K
Pj4gKyAgICByZXR1cm4gdnRkX2NlX2dldF9wYXNpZF9lbnRyeShzLCAmY2UsIHBlLCBwYXNpZCk7
DQo+PiArfQ0KPj4gKw0KPj4gICBib29sIHZ0ZF9jaGVja19oaW9kX2FjY2VsKEludGVsSU9NTVVT
dGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gQEAgLTI1Nyw2ICsyNzks
NTIgQEAgdm9pZA0KPnZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVsSU9NTVVT
dGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2xvY2tlZCwgJnBpb3RsYl9pbmZvKTsNCj4+ICAgfQ0K
Pj4NCj4+ICtzdGF0aWMgdm9pZCB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZV9vbmUoVlREQUND
RUxQQVNJRENhY2hlRW50cnkNCj4qdnRkX3BjZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+PiArew0K
Pj4gKyAgICBWVERQQVNJREVudHJ5IHBlOw0KPj4gKyAgICB1aW50MTZfdCBkaWQ7DQo+PiArDQo+
PiArICAgIC8qDQo+PiArICAgICAqIFZURF9JTlZfREVTQ19QQVNJRENfR19EU0kgYW5kIFZURF9J
TlZfREVTQ19QQVNJRENfR19QQVNJRF9TSQ0KPnJlcXVpcmUNCj4+ICsgICAgICogRElEIGNoZWNr
LiBJZiBESUQgZG9lc24ndCBtYXRjaCB0aGUgdmFsdWUgaW4gY2FjaGUgb3IgbWVtb3J5LCB0aGVu
DQo+PiArICAgICAqIGl0J3Mgbm90IGEgcGFzaWQgZW50cnkgd2Ugd2FudCB0byBpbnZhbGlkYXRl
Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgc3dpdGNoIChwY19pbmZvLT50eXBlKSB7DQo+PiArICAg
IGNhc2UgVlREX0lOVl9ERVNDX1BBU0lEQ19HX1BBU0lEX1NJOg0KPj4gKyAgICAgICAgaWYgKHBj
X2luZm8tPnBhc2lkICE9IHZ0ZF9wY2UtPnBhc2lkKSB7DQo+PiArICAgICAgICAgICAgcmV0dXJu
Ow0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICAgICAgLyogRmFsbCB0aHJvdWdoICovDQo+PiArICAg
IGNhc2UgVlREX0lOVl9ERVNDX1BBU0lEQ19HX0RTSToNCj4+ICsgICAgICAgIGRpZCA9IFZURF9T
TV9QQVNJRF9FTlRSWV9ESUQoJnZ0ZF9wY2UtPnBlKTsNCj4+ICsgICAgICAgIGlmIChwY19pbmZv
LT5kaWQgIT0gZGlkKSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAgfQ0K
Pj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmICh2dGRfaGlvZF9nZXRfcGVfZnJvbV9wYXNpZCh2
dGRfcGNlLCAmcGUpKSB7DQo+PiArICAgICAgICAvKg0KPj4gKyAgICAgICAgICogTm8gdmFsaWQg
cGFzaWQgZW50cnkgaW4gZ3Vlc3QgbWVtb3J5LiBlLmcuIHBhc2lkIGVudHJ5IHdhcyBtb2RpZmll
ZA0KPj4gKyAgICAgICAgICogdG8gYmUgZWl0aGVyIGFsbC16ZXJvIG9yIG5vbi1wcmVzZW50LiBF
aXRoZXIgY2FzZSBtZWFucyBleGlzdGluZw0KPj4gKyAgICAgICAgICogcGFzaWQgY2FjaGUgc2hv
dWxkIGJlIGludmFsaWRhdGVkLg0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAgICBRTElTVF9S
RU1PVkUodnRkX3BjZSwgbmV4dCk7DQo+PiArICAgICAgICBnX2ZyZWUodnRkX3BjZSk7DQo+DQo+
Y2FsbCB2dGRfYWNjZWxfdXBkYXRlX3BjKCkgYW5kIHZ0ZF9hY2NlbF9kZWxldGVfcGMoKSBhY2Nv
cmRpbmdseS4NCj4NCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICsvKiBEZWxldGUgaW52YWxp
ZCBwYXNpZCBjYWNoZSBlbnRyeSBmcm9tIHBhc2lkX2NhY2hlX2xpc3QgKi8NCj4+ICtzdGF0aWMg
dm9pZCB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZShWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9o
aW9kLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lE
Q2FjaGVJbmZvICpwY19pbmZvKQ0KPj4gK3sNCj4+ICsgICAgVlREQUNDRUxQQVNJRENhY2hlRW50
cnkgKnZ0ZF9wY2UsICpuZXh0Ow0KPj4gKw0KPj4gKyAgICBRTElTVF9GT1JFQUNIX1NBRkUodnRk
X3BjZSwgJnZ0ZF9oaW9kLT5wYXNpZF9jYWNoZV9saXN0LCBuZXh0LCBuZXh0KSB7DQo+PiArICAg
ICAgICB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZV9vbmUodnRkX3BjZSwgcGNfaW5mbyk7DQo+
PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIHZ0ZF9maW5kX2FkZF9wYyhW
VERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLCB1aW50MzJfdCBwYXNpZCwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4gICB7DQo+PiBAQCAt
NDIzLDYgKzQ5MSw4IEBAIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfYWNjZWwoSW50ZWxJT01N
VVN0YXRlICpzLA0KPlZURFBBU0lEQ2FjaGVJbmZvICpwY19pbmZvKQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQpKSB7
DQo+PiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAgICAgICAgIH0NCj4+ICsNCj4+ICsg
ICAgICAgIHZ0ZF9wYXNpZF9jYWNoZV9pbnZhbGlkYXRlKHZ0ZF9oaW9kLCBwY19pbmZvKTsNCj4+
ICAgICAgICAgICB2dGRfcmVwbGF5X3Bhc2lkX2JpbmRfZm9yX2Rldih2dGRfaGlvZCwgc3RhcnQs
IGVuZCwgcGNfaW5mbyk7DQo+PiAgICAgICB9DQo+PiAgIH0NCg0K

