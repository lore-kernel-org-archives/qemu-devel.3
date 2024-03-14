Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133FC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkbom-0004yc-Uo; Wed, 13 Mar 2024 23:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkboj-0004ww-Nj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:31:41 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkbog-0006Wy-Dd
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710387099; x=1741923099;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5JVIqHcokRI5EAkb/w+2liQondXi8CuYslxFXFA7EwA=;
 b=aL8i6RoT//8yBKD0ri0zg4zsVGY5A4ccKWfKFIFrHG5am+poyBdUya9V
 VLyhw6MzmyS+k9blBrbKlsfPMVRuyMng7KX1sHYULi6tVh/E25cUfFRoM
 eDw5LjKElzrc0ae6/v/VJI0h/UTPDlqLXyj9vwCn06mPmYZFgwriB7F1w
 ct05k01gNdq3aE/F36H2I1dWuOlm3QFSWUzqLSL/aEs+Xs61Mh8bpaALP
 bpxML/Z4IFYYUPzfzSmxG2mcXJT96Vrs5CJzPFjFHa3euc/EuD1EKNXE1
 20FJAiAj6hJvLL7/DE+GsseEO5KDJR1hDA+Aa3pC6ccF0l+mTkjo5vMty g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5371135"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5371135"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2024 20:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; d="scan'208";a="12219206"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2024 20:31:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 20:31:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 20:31:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 20:31:33 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 20:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2cd6phAkVPZGdyVc8JCqRwZMsPtGgc/Z3EH4lnoYTnAREj/1+8VxZbI79ZzW1wzsLdzSy7OArWuf09VHYgHCRJy7t9TjOO/b3X3D7JO4oNgueqSuXKiozor8T+i7QjzccwIA/QoJxnzUrZw8i+gRajG2DOAI0hVhj4JoYJVtFC1Tp7xFJoPvGCXIMd+X8XNKf9mvRYGNnsHpgZJNZOZfam5cFQkRKtA6t4ysm/LEJtquS2yMrWQ5PAfnYhPKKszTh28MHwfqE37D485HvKKrDbg9NCIwoC5IYrPzHtpl+ZpQimnV5cLVIgeM0Bq/5EgpmaJCG4OW5HHCyZSBkX0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JVIqHcokRI5EAkb/w+2liQondXi8CuYslxFXFA7EwA=;
 b=bH6x/mUn2zc8Ko9zGrT6+J4kyJu+DWOq0l9G28xMkfW2a5yz0AHrucDHOEioiISAcLG7nF6zvopjLD/njO0bSpkvSoBJa8MgprsSMprpBRgBxhckcqlHsLSYvcn77aOrxqBhAjww4ooIXZANdLUloqEAguhqPZOSIsGIeiYbzDSBQFwCB9RldOhWPq2pU8O/VEE+nuPRJddOK3/zibJglc/iKMK+mVURO6b+QrPsymMXPwJEaJIQtuQimYytnOMsi8kPcrCOFLCX1t4ba5dD+y/LAKcCGiMaEXUtZ4abnkgxpdCvDSylGC1sJE+s4ZoKseqvVk9PjEfHN/i9kSt4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Thu, 14 Mar
 2024 03:31:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 03:31:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH] vfio/iommufd: Fix memory leak
Thread-Topic: [PATCH] vfio/iommufd: Fix memory leak
Thread-Index: AQHadYpuCLE0+Fn1mkC2OIR8I14Ih7E2k1Hg
Date: Thu, 14 Mar 2024 03:31:30 +0000
Message-ID: <SJ0PR11MB6744F04B74DE66C9A4A3B46692292@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240313210628.786224-1-clg@redhat.com>
In-Reply-To: <20240313210628.786224-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: 41cd029f-3a66-495e-e238-08dc43d73d5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CDSGDJegzYOCCHbnC6AOud8RVhVaO74MoAW/kqf3hR3Rr+CnRZhZIMgqTu3FQuNjG0eeMaQ1F8SSu+u2HZMarRWQoG1VQ745dn9ONVEuPmP1QY844l8AAyJKn2CskdZ/RvtV2ouDDLLYt5IXmCLORfEGOR44A+DZDuBIbifrfcdvk0P3ixAH67bAvr6Oai3c8EqnI4J4riosVmZZTIe4nCUcEoaZ2BK4KMTYrbGfqJk3ngEAEdiv+2R7xMT6xB4FsjAsQPn3FGpiOEPuGcsGWxfNLAmd1Kn0PtYJj9w6Ze68vOybPZte5IV6s5Qh4f7iuGFhnR8ZBokMF3ixWB6noX+KgN24M7C/kG4C25YVA8tjC1Wh+o0cflsHiTsUczuU342YBCh08BtXJ+rUSjb5MA/anQzpcYMX2AZXMBmkvhl215hVdi7Mssyy15YVao/2sSlxpjWmpmgBUsjJK31rb7Q8sOe1h3zpKWWO72TW/54WW1s0jF1ZT3MYWPr8VeZ48D4zPgVHQVoill0Pd9svavSAeJ64WQwSSRHLeRuVfds7okc26ap7ezhEnp+mH+DOsw0K+ZcKi95HvUb2ksDlJrjdRA6Z1awAEpFUnwjzNQ2a1rCfltwhy9KlTVewEhlLxUToLaJC8DSnS8EfKfHywP3gwSY0gN0dwKgIIJZRovEaegTjDi0vlZxD47M8buFlI5//NHuX43JyD8QDXIcYVCaA78Onb5A3XG9JXI0duQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFhKcjg3bGRkSURMcm5WYVEwZHNJRkRRVk1UYWNTWWhTWWQyZkJLQmMyMW1Y?=
 =?utf-8?B?K1RTSXBYSTYrbks4WGpyN1B0aVlXUjhwK3lmZFpTeUpwMVl1TEIrdUxtWW16?=
 =?utf-8?B?WjYyUHNxMXNPMVhKN1FSd3ViMVQwQkdRRS9JbWt1Q3ZhaGdVRWQycXhNdWtN?=
 =?utf-8?B?QWpBbFBsVzIxc2lVQlNHNzhuRUpTMndPdUV3UGpvaDZ1c21PSFVaRUJSYUdY?=
 =?utf-8?B?SkEzMEZ5cGVpNk55elN6V0NkSzB2eUV4RUtKbGR6N05mZ1Y3ZUd2Q1J0cnpU?=
 =?utf-8?B?Rk12UXNEbDlJbGZPK3UzeHVZN2FDMWpleUNBcGx2aWtxWEwxRmkrU0RVWERi?=
 =?utf-8?B?NHNJRStUdlgzb1RaVGxQYnZHRE1VK0ZLeTNNY3hmQ3hibTBsNFlyemhBYjBs?=
 =?utf-8?B?dDFFMlFSSyszZk0wdzN2ZlQwaVgrRHdQR0h4R0w2MkUrenJJN1plL1lobENy?=
 =?utf-8?B?c25FY0tEak96L0xQdXFONVN2eGVlOWo2aFlydmhWMEhBR3UxVm8vUnp0dmox?=
 =?utf-8?B?Qzlhbjc2Zk9aOXhiVitHMVFqeXBYSklZNmVhdUJITE5wWExaS1Juc09ud2lV?=
 =?utf-8?B?ZG9UdE5tMkF0eUFqWWpDcS81NTZidk8xYzVTbzFYOFU2UGppZWRiTTJnYk1I?=
 =?utf-8?B?Y3ozMW1YRkpBTGdaK080TmUvVDNGRnl2WDJ1OUZHaDFxb2Q3L1VlbUYzOC8x?=
 =?utf-8?B?OHhoMnZJS2E0c3piY0xpTEZjNHZKT1cwNm9aOVBwN2dlSjlhMVIzekRGRnZV?=
 =?utf-8?B?WHpsUHRKN0FnbGZ2d2RxcDRxZ1YrdUFLRzBkYnlFNVRONjVnZ2s2L3IzMlR0?=
 =?utf-8?B?cEczWWdwMXVCRXNqd1dsR1AydFo5TUhROWk0SlA5QUJlTlk3Zmo5MVdwTkxq?=
 =?utf-8?B?YTRnVXhMelFGd1YwY0VPaGJ6Y1lEU3p5WlJJL2tyM0xJVndKZWN4bURhSlJs?=
 =?utf-8?B?OXc2aWFmeERrVHM4NnpHMGU4Umo3aEsvTnNjS2I4UkVWWUhNVFFXS0l3Z2VF?=
 =?utf-8?B?OWNkQUx0OUpaTDcxTENtSHZzZ2pKNGV6c05aUE1RaUw0NGR1WVBGVUhuRWh5?=
 =?utf-8?B?bVlaQUNtZHl5Y2FRRlJlV2FoUmtyY0J3WWJZVUdkRGhUUE1nY2trYlg1Ymdp?=
 =?utf-8?B?dWlsV1NVL2U4bVk5VG5sbG8waGU2VDFjY0hWSkVjdUlacXdLalZYSThmMzA0?=
 =?utf-8?B?T0svaWNiNHZBS2pLMURNRW82amY0ZWhJeUVOZVVmRW15dGpPbytOTnNITzli?=
 =?utf-8?B?Z0tPWDlVaFd2d2FObGdDeU4rUzdTUWlrWFZ3M29VdTlNaSs2MTJhVXgrZ1J5?=
 =?utf-8?B?aXV6R1BqSTU5M1FoV2p0OG05TDNTVVk5UWQxSXkzSGVzNkV4aDJKTWVFUWI2?=
 =?utf-8?B?K2JMWEF3WmpYRHYyVTVkRjRRbTlVVExyWTc4WkUyYlhzcXZITmQzUFdzbzJu?=
 =?utf-8?B?dUIwTzNROU1uTE5OOVhPVXRiVFB2UEZWV2l3dHhEbUxoNFprZzJtR2dMU2dq?=
 =?utf-8?B?T25jcGl3S2dZblFTcytrQmdEcXZEZiswRzdmcXcxd1FLbWFqTjVvZk14TDVh?=
 =?utf-8?B?cXhwczY5bmRuOXgrT1ExczM4N0VwVDlQY2J6amxpRU1kaVJwek1PQ0wzUlo3?=
 =?utf-8?B?T0JNVVl0d2J3R2ptMDlVYng2Tkx6YXVmQVhCWGFDQUZJWTVTdmdzQ3d4Vmo5?=
 =?utf-8?B?YVlxQXpaWjJYYXVCMjNYSkR0OUZPazI3VHYyUVpDdk9nQ3o4cmFjaWJSNU1M?=
 =?utf-8?B?Rnd0QUk3OWgyMHhVMlhJYTJGallLcEZHQnFuL1Q2OFlVUGU0N3ZtaGk0VVRi?=
 =?utf-8?B?azZENkZoYUN5K1lxRE0yVWlIZjYvT2NiSG1aVHF4cVdHMmllOUlnOCs5aEZ3?=
 =?utf-8?B?TWNuRGYxSnplRmZHRTA0dVkwMlR2bTJJSUVXRng1L1FibzNhY3o5dnd2Wkl5?=
 =?utf-8?B?NW9iZHdEcGxLVXdnQUZ2NXRGdm0wM1MrV3ZQQ2xITGJCVXRVMXhWT2VvOEJk?=
 =?utf-8?B?S0xNbnZjb2pDMVFiRFZvbU1MdWpNbm9nMnl5NkM5YzR2NEFiZkZadXBNeXJ5?=
 =?utf-8?B?SU9SQjY3L0JneXBoYW5ycU5aZ0lQRmhRQmJqcVJoTkhQUlVSUDdQdG9SNUFG?=
 =?utf-8?Q?3oCWvB3+rc1l+YCIL7+w50sgj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd029f-3a66-495e-e238-08dc43d73d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 03:31:30.5717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyri5p5G2IVBEapU8PnXFRtrDiyTUjKKC+R+BexIxhqKiZ64qkW0nvMW7UJyu+ibLb/vx7VnCm4X1cEhZFpposvrpppKXJmgrk6/CiG1WJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTWFyY2ggMTQsIDIwMjQgNTowNiBB
TQ0KPlRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj5DYzogQWxleCBXaWxsaWFtc29uIDxhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbT47IEPDqWRyaWMgTGUgR29hdGVyDQo+PGNsZ0ByZWRoYXQu
Y29tPjsgRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPjsgTGl1LCBZaSBMDQo+PHlp
LmwubGl1QGludGVsLmNvbT47IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPlN1YmplY3Q6IFtQQVRDSF0gdmZpby9pb21tdWZkOiBGaXggbWVtb3J5IGxlYWsNCj4N
Cj5NYWtlIHN1cmUgdmFyaWFibGUgY29udGVudHMgaXMgZnJlZWQgaWYgc2NhbmYgZmFpbHMuDQo+
DQo+Q2M6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj5DYzogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+Q2M6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+Rml4ZXM6IENJRCAxNTQwMDA3DQo+Rml4ZXM6IDVlZTNkYzdhZjc4NSAoInZm
aW8vaW9tbXVmZDogSW1wbGVtZW50IHRoZSBpb21tdWZkIGJhY2tlbmQiKQ0KPlNpZ25lZC1vZmYt
Ynk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClVucmVsYXRlZCB0byB0
aGlzIHBhdGNoLCBJIHNlZSB0aGVyZSBhcmUgZm91ciBnX2ZyZWUgY2FsbHMsIG5vdCBjbGVhciBp
ZiBpdCdzIGRlc2VydmVkDQp0byBjbGVhbnVwIHdpdGggZ19hdXRvZnJlZS4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg0KPi0tLQ0KPiBody92ZmlvL2lvbW11ZmQuYyB8IDUgKysrLS0NCj4gMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0
IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4DQo+YTc1YTc4
NWU5MGM2NGNkY2M0ZDEwYzg4ZDIxNzgwMWIzZjUzNmNkYi4uY2Q1NDllMGVlODU3M2U3NTc3MmM1
DQo+MWNjOTYxNTM3NjJhNmJjODU1MCAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0K
PisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTE1Miw5ICsxNTIsOCBAQCBzdGF0aWMgaW50
IGlvbW11ZmRfY2Rldl9nZXRmZChjb25zdCBjaGFyDQo+KnN5c2ZzX3BhdGgsIEVycm9yICoqZXJy
cCkNCj4NCj4gICAgIGlmIChzc2NhbmYoY29udGVudHMsICIlZDolZCIsICZtYWpvciwgJm1pbm9y
KSAhPSAyKSB7DQo+ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZmFpbGVkIHRvIGdldCBtYWpv
cjptaW5vciBmb3IgXCIlc1wiIiwgdmZpb19kZXZfcGF0aCk7DQo+LSAgICAgICAgZ290byBvdXRf
ZnJlZV9kZXZfcGF0aDsNCj4rICAgICAgICBnb3RvIG91dF9mcmVlX2NvbnRlbnRzOw0KPiAgICAg
fQ0KPi0gICAgZ19mcmVlKGNvbnRlbnRzKTsNCj4gICAgIHZmaW9fZGV2dCA9IG1ha2VkZXYobWFq
b3IsIG1pbm9yKTsNCj4NCj4gICAgIHZmaW9fcGF0aCA9IGdfc3RyZHVwX3ByaW50ZigiL2Rldi92
ZmlvL2RldmljZXMvJXMiLCBkZW50LT5kX25hbWUpOw0KPkBAIC0xNjYsNiArMTY1LDggQEAgc3Rh
dGljIGludCBpb21tdWZkX2NkZXZfZ2V0ZmQoY29uc3QgY2hhcg0KPipzeXNmc19wYXRoLCBFcnJv
ciAqKmVycnApDQo+ICAgICB0cmFjZV9pb21tdWZkX2NkZXZfZ2V0ZmQodmZpb19wYXRoLCByZXQp
Ow0KPiAgICAgZ19mcmVlKHZmaW9fcGF0aCk7DQo+DQo+K291dF9mcmVlX2NvbnRlbnRzOg0KPisg
ICAgZ19mcmVlKGNvbnRlbnRzKTsNCj4gb3V0X2ZyZWVfZGV2X3BhdGg6DQo+ICAgICBnX2ZyZWUo
dmZpb19kZXZfcGF0aCk7DQo+IG91dF9jbG9zZV9kaXI6DQo+LS0NCj4yLjQ0LjANCg0K

