Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9496DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwoD-0002fv-I1; Wed, 17 Apr 2024 00:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwwoC-0002fl-1H
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:22:08 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwwo8-0007xn-R1
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713327725; x=1744863725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CekVdlTtx9RPuBb2l1FXZDsfnAxZV7BnPoUqZflSpe8=;
 b=XbEf2AWdDoW4YEpvqVPf4XlYA2oZ6AS48pEbF+cfbQDvhcdd67OxLpMW
 n0BCbeEG6BU4V8ILRubpTjv7gIWP74XNNnlGnyuFLmCPe/F4SOtvja2Pz
 Vp78R+yYxYqNnxzjHnzQeYfIPbd+cL4ULcGStmKEGOZBaczS+cq5JHuMi
 DFtYpL4kYYVTA4rCBYJmvetrJL+I+UMFUVyvTgel3lQ8U0gmEG+MkOixl
 d7Y39onUGMa/cYUoYX+e8JyU93LLFnosz4dKDzaYTFXtSHH6zdAhSfKdf
 v9HP/+l7KsZuCP4nVgiTtgH18xsMTFGPwVi2qcgYhe7+A4m8GX+DqTdOj w==;
X-CSE-ConnectionGUID: eHduAaYzRv+FQD+bN9YdeA==
X-CSE-MsgGUID: UreHvZdNSxu5WfqDpqMRAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8929367"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8929367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 21:22:01 -0700
X-CSE-ConnectionGUID: 0jXSYioKTeyY49UZm7j/xg==
X-CSE-MsgGUID: nQ0B3xA/QWe4qbGz/BcHYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="22971957"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Apr 2024 21:22:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 21:22:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 21:22:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 21:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHltu5gmxc3xqIepHdOKVjhqOg2mfjVDMYggatL1VkV6nlzilSPwUj6CfHpD4A7updNc/oswOwpsHI6vPW19vZP6J1bgjzgxjulV6D1gtdDBFOgoxyzadus5ePY+0zprw3bJkG9+yYi3RnfTda15eLtRl1oA8EBtghW1dNIiNBEPyAbzgkcyxalzj/JgfLwMA4g7tjDrancEnk2NMHfZTn1y8dh6Qnnh1LpNacrnKaygUs0rDeXK1k9JwEKBot+3odgngywQn9i4LFC1owVIurupXxKPHBfAFxa7YWBll3k7kf7THWVFs6nyTwYiSnnJMCiYA1bHk9A+4jbXtL0KjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CekVdlTtx9RPuBb2l1FXZDsfnAxZV7BnPoUqZflSpe8=;
 b=jlo+TuFWLt7/Xw1mytzkd/1OJGR3dklxY85EkYpC+gI3rtT848tA+7UVrl7jeLP1TH96W5brrQY55SMUpW6ZBlIoVazVrQhPSqZgdPjJdCBlCeXhjnvDJg+a4xZRMwLgpIi6NFmdItrHN3e1FnDmHXJuCyyWxKsKV69/cj6O9BOe7RI3Lukn+zg1jGLyFzRziiVCDNUrV60wSbcmNg7FnEqbpZk0uqd8fgd2us5j+EkSswzJZDh6SnPqOTK0tZz+EvHWprdLI+wD6ZwaRCIfTBu2hiwNPS/iFBLtI0hTDeg1Pm9n0U4NR8a5G0JygNkpfJruvC/I1aKl2O0oVnmDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 17 Apr
 2024 04:21:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Wed, 17 Apr 2024
 04:21:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Topic: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Index: AQHaiZFH29IOEDl1dk20/jsEyJLG5bFpgLMAgAD2WaCAAIdgAIAA3yKQ
Date: Wed, 17 Apr 2024 04:21:57 +0000
Message-ID: <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
In-Reply-To: <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4799:EE_
x-ms-office365-filtering-correlation-id: 15128a03-496e-472a-a6a6-08dc5e95eb99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qno08uIXKyg8Myz+h4CeVELUCXughBKpPYrY6RMbU+NZ+hl2OtsU3+OIrSzGeIghnUcAZ7ncenU8dSNad+gYJkN2eRRsoevC3WpcXT5neqBycxwbSKmdixifMSzJKjHBFLn1lECrRJsb4w/8KRxaDK0q3xqphujU9SptXT1NO9EYjEB4spv8bxGfH/kQWkg2syCiPvSS3mN3bQoFPhkyfVn+SNst6yfIFGf4kEnLJG/wjAUrr7QjDFKmSqSlMjYDgMdK5c1AArcPJYkfoxnyc5EBRFA2wBbkUT6DjzUG2DYJCX1hp3fHueXsEX43PtlEWQC1T47hsSGm7NdYVZiOa8QW1sJigAStUXe8uZuBor5tUCUmwgxywCqDR8+X14MxV3OCSjK+SjLuqA4/YMy9T40Go0GwvUuSJWpGV7B1r4VQx44XqwhZszOSEATJs3+mFNqvuY8MqB4HTI68E+1oLIbRoQaWH0xlfLFERT6Kwt+i9FtnbKwDHoj7vfXRFT1zQK1YWXUZSYcPGXSYBvGXXmxReOw0XAbl/lErS1NLccEtPLJKl2IqUqbvgb+h2x4CDKP5T+sdldgmjGu7nCFN0iY1M+Bnu15xpiXinUWraZ2OE03QQP9bcxWqQcrx8QXc+eDXnGnbaIPbBCWo7lRwnHTFA2G02HteatkxHK0d5OAkHK5C4YhVRcnVIOQrjwfolvSHirOyMd67iH2wv65Kxx3vEfBZT9WWAJYfTaSRCXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE9vV0c5VlZ6cUUxMzRvbExwd0NDamxqaTZBSGJ1NzY0ZmtrWkpNOC9PalVP?=
 =?utf-8?B?VG94TkNLT1BlSHFudmFlVXIrWmJaUnBkMlMvcWZhVkNLY1ZHK0RrY2w3eVJz?=
 =?utf-8?B?cmpyNWszUWxaYnFJbmc3LzZjQmZEbXdFSTlXcDFHRGNPRFlMaW5aVU02eUpp?=
 =?utf-8?B?RnZJbjFqMnhqWHJOZVMwQ3dYd1VvMWZobThjUEJxUC91RUhhQVNYcWRHMmQ4?=
 =?utf-8?B?ZFNGeEpTQ3dhTFZGQ0p3Yks5M2NaRExOTUgxVTRmdUd5NWEvV2hiNW0vWVlJ?=
 =?utf-8?B?ZkVEM0k2dHFpU2crdENKOExYMnVpTEhDQlN1d3J1Q0R5aC9ZK0JIc0JFd2Nk?=
 =?utf-8?B?OG9WaHRWSThkYXo2Vmt6UzE4bWNYTkZyMUZKMGJRckg4YjBmSWozSnQwV01x?=
 =?utf-8?B?YlU1NEJFSTIzS29tbzZsQk1jaUR0REJ6bzlnczhuTGNGV0JJaUlTUlpwdWRr?=
 =?utf-8?B?R2hlN0Rwc3ViQWpKUzQxdDFVRENqUk01Y2p3L2x5cWhGWUpuc21JTWNzWFM4?=
 =?utf-8?B?ZGo0WVRVdTJPc2ZuY0ZWNGszUS93T3FGMks0OEFMVDNWRHRSaHFCS1VaYlJQ?=
 =?utf-8?B?VE1JQzBXN1hnWVRjVS9MVllUWVYxSU5KREROTWpFYVdQekNnT1NOUFdDWHhl?=
 =?utf-8?B?ajBtbFVkb25zM082QkJwMlpDbE5GZ2lneGhPUEgxNFA3UHNrVGtUMnBBYUxy?=
 =?utf-8?B?cGI5UXlKMExld1BhTWtzZFUrZElrZFh6Rml4UjlySE5Da1ZmU0hmd1V4SHA4?=
 =?utf-8?B?YXlIWVBsNnBSUU95bHM0c0kwaGZBRXBveGFOZC9Kb2thODN3YVZkV0Y0bVVN?=
 =?utf-8?B?bkN6TmVjaE1iUXY4QndoTVh4VjJ0N0lJRjRuWHZHRlFNaG1LWUswSUVXQURW?=
 =?utf-8?B?SmUrZURLb3ROU21DQ3Z1MVdRUENSakxYVTgxeVVyU2N0QlVIMnBWdmw2Unp5?=
 =?utf-8?B?eXVxODhLczlWTEtnN2JqUGdZT0NiUVpPbE1SNTJrQ1dURnBZM0pPRkxSZkVO?=
 =?utf-8?B?RDA0SUR4dTFaajdLVWhKVFNkMTRqeGRURjZwelQxQTN5ZkxYdXJLajJ5V0d1?=
 =?utf-8?B?R2ZBTUkwNmNlYklJM043SVRLaVVvMi9QYW0vTGFpS1FTNUsrKzRlQ2YzNzVZ?=
 =?utf-8?B?WUtlRm1rNGlXT1ZlM0xHNmVzVmRGcTcxaVJ0RzM0UkZWdVU1TTNMVXNZalB6?=
 =?utf-8?B?YnNpQTF4SC83eUM3ZmwyTW1nSHJIVGRVcUlkZDFIbEZmTnJvdXNHZHd3dlhJ?=
 =?utf-8?B?ZUFLWXJpRkdKeUlMMVRXMGFmMldyaThqbTQxZEF3bk9OdENhM2NCNXkybnRn?=
 =?utf-8?B?bEdoNW1JcEJHNi80VFdqNWU3OXYzUmplM1FNc1hXamljL2orVnZ6bHpaWHhC?=
 =?utf-8?B?QlNxR1ZQSGZIV1lJV1dFaWdyaUdPSEpPQ0R3clhCUGwwN3RCM084RFkwNFM4?=
 =?utf-8?B?Q3RyWmVMRHlKUUtzbDNJbjFHZzkvcWJTM2NTQWQzZzRBaUM0bm5iSFFWcWNL?=
 =?utf-8?B?Q1BFNFNrRTR4bUJIbzJMbkhaVFFGbjZsVzYxMHUxeXVJYy9XYmNsbUxTRTVV?=
 =?utf-8?B?dGRESUIxdDdyd2RIRDVrc3RydlFHekFaSU43Y29rZDUyOGZRU0x6SU9IeWEz?=
 =?utf-8?B?b1JxdHpISmpqRi9RQS82djlOUGNyOTdOS1owdFd5K2xjSGo2VG1vTTYvQ013?=
 =?utf-8?B?MS9SU2dpMHgxcDhTTERCRkFtbXRrdFlRQmZOU084eDlqeHBnd0RLcGtLQzNO?=
 =?utf-8?B?VWQ1OG5NbVUwSkYrdlBjWnJyWFBYZG5wcXVTL2tNYUdUd1Y4azlqaGFjT1hl?=
 =?utf-8?B?WkdYMTgwZ3RJbVdyVFpoSlBzaWhVOE4wbkdva1oyWGxmdnBVTW41akF0czMv?=
 =?utf-8?B?ZmZTYmgrejM5eUFkaGNndWk1ajdBWDZQamxBaGx1K1lDR1hoTGhIUmdUMmVE?=
 =?utf-8?B?MzBlOElRajR5MmNCYjU1azhhZlpnNlBUcDZwQStCK1BJeVZIWHZodGVlSXFM?=
 =?utf-8?B?QThZM2pYUzRJanF1QTVXZ21tZVhhOVFJcExIODdENjJzc2lzWVFUWW5VM3Ev?=
 =?utf-8?B?YWVhTGVxMmR1enJlTDlWL3BpdlhlZ3ZERG0vRkw4QTViSU1BZ3c0VWlQTC9E?=
 =?utf-8?Q?+wF2KGuODOiVEvmABzCcBBnOq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15128a03-496e-472a-a6a6-08dc5e95eb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 04:21:57.5412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/fD26WnH+Oq9rOrq4N5fo+wgBZqmpNgQLesRa8bkGbx5lFFkLonjpKiaECLo+nKMpKPJkKRKGWqlJ2HnncrLGjq64Kl/BM5YHWKhMgNpUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNV0gaW50ZWxfaW9t
bXU6IEFkZCBhIGZyYW1ld29yayB0byBkbw0KPmNvbXBhdGliaWxpdHkgY2hlY2sgd2l0aCBob3N0
IElPTU1VIGNhcC9lY2FwDQo+DQo+SGVsbG8sDQo+DQo+T24gNC8xNi8yNCAwOTowOSwgRHVhbiwg
Wmhlbnpob25nIHdyb3RlOg0KPj4gSGkgQ8OpZHJpYywNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+
DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGludGVsX2lvbW11OiBBZGQgYSBmcmFt
ZXdvcmsgdG8gZG8NCj4+PiBjb21wYXRpYmlsaXR5IGNoZWNrIHdpdGggaG9zdCBJT01NVSBjYXAv
ZWNhcA0KPj4+DQo+Pj4gT24gNC84LzI0IDEwOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+DQo+Pj4+IElmIGNoZWNr
IGZhaWxzLCB0aGUgaG9zdCBzaWRlIGRldmljZShlaXRoZXIgdmZpbyBvciB2ZHBhIGRldmljZSkg
c2hvdWxkIG5vdA0KPj4+PiBiZSBwYXNzZWQgdG8gZ3Vlc3QuDQo+Pj4+DQo+Pj4+IEltcGxlbWVu
dGF0aW9uIGRldGFpbHMgZm9yIGRpZmZlcmVudCBiYWNrZW5kcyB3aWxsIGJlIGluIGZvbGxvd2lu
Zw0KPnBhdGNoZXMuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8
IDM1DQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBpbmRleCA0
Zjg0ZTJlODAxLi5hNDliNTg3YzczIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+IEBAIC0zNSw2ICsz
NSw3IEBADQo+Pj4+ICAgICNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQo+Pj4+ICAgICNpbmNsdWRl
ICJzeXNlbXUvZG1hLmgiDQo+Pj4+ICAgICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+Pj4+
ICsjaW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCj4+Pj4gICAgI2luY2x1ZGUgImh3L2kzODYv
YXBpY19pbnRlcm5hbC5oIg0KPj4+PiAgICAjaW5jbHVkZSAia3ZtL2t2bV9pMzg2LmgiDQo+Pj4+
ICAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4+PiBAQCAtMzgxOSw2ICszODIw
LDMyIEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4+ICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0
YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+Pj4gICAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4+
PiAgICB9DQo+Pj4+DQo+Pj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19sZWdhY3lfaGRldihJbnRl
bElPTU1VU3RhdGUgKnMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
b3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+Pj4+ICsgICAgcmV0dXJuIDA7DQo+Pj4+ICt9
DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbnQgdnRkX2NoZWNrX2lvbW11ZmRfaGRldihJbnRlbElP
TU1VU3RhdGUgKnMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9z
dElPTU1VRGV2aWNlICpoaW9kLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICByZXR1cm4gMDsNCj4+Pj4gK30N
Cj4+Pj4gKw0KPj4+PiArc3RhdGljIGludCB2dGRfY2hlY2tfaGRldihJbnRlbElPTU1VU3RhdGUg
KnMsDQo+VlRESG9zdElPTU1VRGV2aWNlDQo+Pj4gKnZ0ZF9oZGV2LA0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+Pj4+ICsgICAgSG9zdElP
TU1VRGV2aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCj4+Pj4gKw0KPj4+PiArICAgIGlmIChv
YmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChoaW9kKSwgVFlQRV9ISU9EX0lPTU1VRkQpKSB7DQo+
Pj4+ICsgICAgICAgIHJldHVybiB2dGRfY2hlY2tfaW9tbXVmZF9oZGV2KHMsIGhpb2QsIGVycnAp
Ow0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHJldHVybiB2dGRfY2hlY2tfbGVnYWN5
X2hkZXYocywgaGlvZCwgZXJycCk7DQo+Pj4+ICt9DQo+Pj4NCj4+Pg0KPj4+IEkgdGhpbmsgd2Ug
c2hvdWxkIGJlIHVzaW5nIHRoZSAuZ2V0X2hvc3RfaW9tbXVfaW5mbygpIGNsYXNzIGhhbmRsZXIN
Cj4+PiBpbnN0ZWFkLiBDYW4gd2UgcmVmYWN0b3IgdGhlIGNvZGUgc2xpZ2h0bHkgdG8gYXZvaWQg
dGhpcyBjaGVjayBvbg0KPj4+IHRoZSB0eXBlID8NCj4+DQo+PiBUaGVyZSBpcyBzb21lIGRpZmZp
Y3VsdHkgaW5pIGF2b2lkaW5nIHRoaXMgY2hlY2ssIHRoZSBiZWhhdmlvciBvZg0KPnZ0ZF9jaGVj
a19sZWdhY3lfaGRldg0KPj4gYW5kIHZ0ZF9jaGVja19pb21tdWZkX2hkZXYgYXJlIGRpZmZlcmVu
dCBlc3BlY2lhbGx5IGFmdGVyIG5lc3RpbmcNCj5zdXBwb3J0IGludHJvZHVjZWQuDQo+PiB2dGRf
Y2hlY2tfaW9tbXVmZF9oZGV2KCkgaGFzIG11Y2ggd2lkZXIgY2hlY2sgb3ZlciBjYXAvZWNhcCBi
aXRzDQo+YmVzaWRlcyBhd19iaXRzLg0KPg0KPkkgdGhpbmsgaXQgaXMgaW1wb3J0YW50IHRvIGZ1
bGx5IHNlcGFyYXRlIHRoZSB2SU9NTVUgbW9kZWwgZnJvbSB0aGUNCj5ob3N0IElPTU1VIGJhY2tp
bmcgZGV2aWNlLiBDb3VsZCB3ZSBpbnRyb2R1Y2UgYSBuZXcNCj5Ib3N0SU9NTVVEZXZpY2VDbGFz
cw0KPmhhbmRsZXIgLmNoZWNrX2hkZXYoKSBoYW5kbGVyLCB3aGljaCB3b3VsZCBjYWxsIC5nZXRf
aG9zdF9pb21tdV9pbmZvKCkgPw0KDQpVbmRlcnN0b29kLCBiZXNpZGVzIHRoZSBuZXcgLmNoZWNr
X2hkZXYoKSBoYW5kbGVyLCBJIHRoaW5rIHdlIGFsc28gbmVlZCBhIG5ldyBpbnRlcmZhY2UNCmNs
YXNzIFRZUEVfSU9NTVVfQ0hFQ0tfSERFViB3aGljaCBoYXMgdHdvIGhhbmRsZXJzIGNoZWNrX1ts
ZWdhY3l8aW9tbXVmZF1faGRldigpLA0KYW5kIGRpZmZlcmVudCB2SU9NTVVzIGhhdmUgZGlmZmVy
ZW50IGltcGxlbWVudGF0aW9uLg0KDQpUaGVuIGxlZ2FjeSBhbmQgaW9tbXVmZCBob3N0IGRldmlj
ZSBoYXZlIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbiBvZiAuY2hlY2tfaGRldigpDQphbmQgY2Fs
bHMgaW50byBvbmUgb2YgdGhlIHR3byBpbnRlcmZhY2UgaGFuZGxlcnMuDQoNCkxldCBtZSBrbm93
IGlmIEkgbWlzdW5kZXJzdGFuZCBhbnkgb2YgeW91ciBwb2ludC4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0KPg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPj4gVGhhdCB0aGUgcmVhc29uIEkg
aGF2ZSB0d28gZnVuY3Rpb25zIHRvIGRvIGRpZmZlcmVudCB0aGluZy4NCj4+IFNlZToNCj4+DQo+
aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2Jsb2Ivemhlbnpob25nL2lvbW11ZmRf
bmVzdGluZ19yZmMNCj52Mi9ody9pMzg2L2ludGVsX2lvbW11LmMjTDU0NzINCj4+DQo+PiBNZWFu
d2hpbGUgaW4gdnRkX2NoZWNrX2xlZ2FjeV9oZGV2KCksIHdoZW4gbGVnYWN5IFZGSU8gZGV2aWNl
IGF0dGFjaGVzDQo+dG8gbW9kZXJuIHZJT01NVSwNCj4+IHRoaXMgaXMgdW5zdXBwb3J0ZWQgYW5k
IGVycm9yIG91dCBlYXJseSwgaXQgd2lsbCBub3QNCj5jYWxsIC5nZXRfaG9zdF9pb21tdV9pbmZv
KCkuDQo+PiBJIG1lYW4gd2UgZG9uJ3QgbmVlZCB0byB1bmNvbmRpdGlvbmFsbHkgY2FsbCAuZ2V0
X2hvc3RfaW9tbXVfaW5mbygpIGluDQo+c29tZSBjYXNlcy4NCj4+DQo+PiBUaGFua3MNCj4+IFpo
ZW56aG9uZw0KDQo=

