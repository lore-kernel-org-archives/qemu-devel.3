Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AD6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJ6i-0002oV-Ch; Mon, 15 Apr 2024 05:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJ6g-0002oI-W7
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:58:35 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJ6f-000145-CT
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713175113; x=1744711113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=alM2aCGstHNQOqdvDvzEeKiUEpEGtNivmHMD0MSD5hM=;
 b=iWxupX7FeMl/riIeG9MK0NVOH15L8aFK9rYLRMc2gaB/v0h0owIUpjWW
 3VX9wYVtyBwwUheqrz984uzusVm46w2EwoEFc4V9rUVA44zIELJJd9HVC
 s5UUDEIXT8Pl8pc/JRzDdCAowuCHcno/cA/X8dIS+Y/IjUoNx7QWdCBue
 JsxTFApMkefO/V6qRS8475e//L/lt4jPvk0ElT8qeFAU0VFBDf2fLmkxa
 UYR2P1nDusTRuLEHBU4m9wwfjwupIiD8LNvSceLmLJhJSQYFbKKhY5UjA
 zFru2i+iLoCAe6VnHvfcpReW8eKICwGW+HuifvIvN7lcEw8dKF9T62p1a Q==;
X-CSE-ConnectionGUID: PV4hx69+TvKHVVAQI2fTjg==
X-CSE-MsgGUID: hyFP90POTeSCNnQTNlTU4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8775593"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8775593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 02:58:31 -0700
X-CSE-ConnectionGUID: hkz51mpvTPKXNuRd4bk1Rw==
X-CSE-MsgGUID: u087kh6yRImEMFMIl7153A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208";a="22432582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 02:58:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 02:58:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 02:58:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 02:58:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXXUPJ2HGqeg5ERoHNRgBExYZyRiDCGCCJBQpyVNVZ7VFi5wL/PHa05gkJbCnhpKeNpBRbE8ynez1EBAF/t1RKkvxjQE2CO966iMtRgZV/IzPWyuf9LOJeJp2LkgFvvE6C2iWI4etqYrYdD9pxmKyYFFlSSx1RvsMGDFxqq/4RM28L3fZOyGAfPTxB+12XkRDzTCf4Y8RasxZaYhx+Z0ptFd0v/pyRIu2bEI90WLWtxaQt5BPgzWYY4A+NrQ7913dq9lJ/fLMCFQbRRmZcVLWn0xvtT9PPINc8AAJLClcIkVxsbjKXStSYGtlH9pjisY+tKDnVbY/wNePCZfDPF5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alM2aCGstHNQOqdvDvzEeKiUEpEGtNivmHMD0MSD5hM=;
 b=hxSJlo+kUs6oQsZQL/Is3RJZHC7kF4N3T9FZMTsL8jDXLdx29BmQikdRLaS95vP5u3Ft+ijSC7OBSftIyWBluZjj90jbYFbqZZ6trLgd6ivTWBypAQ3q3MyO107EDOj7MxwxdXRSuKeV+kAaAk8EKhEeXEj18IxduLnZgNBDRNLp1jAHXJvLzvP7OUmsfio1U2qn11TPxGz3SxiUIzfg+fmSfiAD8ipVhRwlpcIPTyE2SML2mRi5sApKXSfwLIq+djPb2/Nu7oufd8sJXDe7xsqNnPBrUzfJdKUhPvS4ZD2G7UotSncaG/X2bIfiUAo4hy7caD/vtysr6baGZdrwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Mon, 15 Apr
 2024 09:58:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 09:58:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
Thread-Topic: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
Thread-Index: AQHaiYzk06tnPwLhp0Oyp2E1dvnOG7FpGLOAgAAK+IA=
Date: Mon, 15 Apr 2024 09:58:28 +0000
Message-ID: <SJ0PR11MB6744C49963705051AE06C0F992092@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-2-zhenzhong.duan@intel.com>
 <3203dcc8-294c-439d-a38b-b71ba1dbfc5c@linaro.org>
In-Reply-To: <3203dcc8-294c-439d-a38b-b71ba1dbfc5c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8430:EE_
x-ms-office365-filtering-correlation-id: 291e74ae-3b6b-4bbb-6f27-08dc5d3299d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXR5T09eYVQJzgiCBBgRNvc/QIvDtjnsApnjAWBJSfRZHnhc//ewDGU23A4hgkDiHlBxKdk98GUnWPSw2TTkaMBps+sCID0DFGBD4clGe5y+ggrxDRPTGSsfI3mICgeGHLRXMujqSC9GxTlYSMHw2oBp8LLf1hc1mt52O+52uJuzMsi5hIN44keeE4ZV5zNoN62kd2MrhLmUzOcEaqP0KgD39mkaYg4D1CN2IHiXi/oOR6xqXg2iPYg0aab8Z2JdwVCY/RnTxy28JSQVL6mfJWlQlfWzXgIYy0FPZimr9wOcu0QUDmqCO7GuQazbfW/624U+rwQJXIGJ1rJ6boRkUBAexwHJ+hh8dwgA+D3vRDKemJlH1xlVPXVaGxii+qyUAQ90yCYqb69glNaXGyAjU9jwxXL8zvI0iDizb8cjufZaPxCXsrWqKOTG7WJpLRgBtFLaYf6TP8ewqzr/lI0hm9LjnnmNEUUCRrP69B3dzPeXwWUFdh7f4q5SxfBl2vZnPrS+Zbpr9ZgmbOhBnW7OSBn8QomLSnh5iFqO3J3OCOvmxlpW2Ju2GaHb29k7FTD/zdrQHdWcYWEQNIeQ2GSyzFyDRoufa9wOVGhG2PhPMgYRf9SeV/LeY3bV0VBZf5PC4mY1aWWC58aWvE6bW18FIhBndAfUgdlDP8HeHXjENf9rrDkfpSJgUYqcgf7f7cTwcej37KbXIyOqMqeOdjDeUYGzEtipS2tBAM83B0NOrMc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmpiMWRnWk5vb1Y2Tm9IU0RWbllTdUlpb2oyS0JlamtraWpaU01tTHk4VEpx?=
 =?utf-8?B?NEhRVFVJV0gvQmxhNmdJdjVMdEpaTXJhRXZVQWpRRlIwb0pOS1RRZmJMVG9l?=
 =?utf-8?B?L0c3eEtheitSUUhKRExITXpJeWs4bHBYa3hVYmF5a0YwNndmWVpaWnZSUjdB?=
 =?utf-8?B?azNMRmd3dGx6MlZhUVl2eU9DV3p4dHZvK1haOHRDejd5Z0orK01EamoyeDB5?=
 =?utf-8?B?Rnd0RzVIRTl2c3ZWdXI0OVpVRzYxUS9lRGpQbUdQVEkyQU5XVE1GUjBVUkNV?=
 =?utf-8?B?UkZ0bGczYzhtWnNKNThJRlhyT0lHUHpFRnNvQkRVemozYlpkWUpTMm5qa1NR?=
 =?utf-8?B?NmM4MkxrRzUyaHNKNVBCYi95V2FoWVpXbGlCR1F3OXZTQ2c1end1eFd2Y0hB?=
 =?utf-8?B?cHZEN0wraktkQy8yaHBrZlZYTEFWTkppWEE0Ym9IUjZUUC9KRlhwZ1RoaVIy?=
 =?utf-8?B?TmwrUi9BWVdWRmtiQmxwaHVKcmJ1WFlxM0E5Wkt5QWtyS0JzNm8wYVhha1ov?=
 =?utf-8?B?M2VYQktkK3UyeDR1WVFlWm5LQzRHUlRMeGM1S2FJcFpaMHVCY09lVS9XeHp5?=
 =?utf-8?B?aDhCYlZtUFduWnhXTE1OeDBiZGRaemp2MnJ5dzBwMlFRajNKUzFyaGFMMm56?=
 =?utf-8?B?N1BXV1lZOGpzbzVUM24rVTg2YkJJbVVTU3IvSmpicW5nSW9jdUJNUElUOE5U?=
 =?utf-8?B?ZkYwYS9rSXV1aHFjcXowd1h1T2Q4R01SeWMydFBBdFVpNDhQSWpOWGl2dzZS?=
 =?utf-8?B?a0J0azZCZTdvVFdSNTVuVXFjK2o2Sk5Ed1p3cWRnYlliN3d4V3hTUU1EYWRS?=
 =?utf-8?B?MmlWeFVsb0xuMzRjTElNeWNUR3pCSVhRM292Zzd2YXNTMkdoY3UxSi9nb2Nr?=
 =?utf-8?B?UmxFTlBIeS9OaTNNQnNYK1V4RXc2ZzRGbGZQcUxWd01NM2pVN1FzWTMyMVk4?=
 =?utf-8?B?eHJRblorS2QxKzhoMFUvOTRleE05UHBURXBJdzFqMlJYV28rSFg5VEoyMjZR?=
 =?utf-8?B?dnJlR0ZaajFWK05LSUZRS1ZmVVZEVmg5QTlQVnlocmxnQVJ2ejh5cWZvSDRm?=
 =?utf-8?B?UW0vV0hmVHdCNWJBSTFQdllvVTIwNXQybkVaQkpZWUNMVUN6RTBWME1BM2g0?=
 =?utf-8?B?K1l2WVZLUWw3cWtnQWlaNVI3dlpBSmJ6QWNNakxRY240dlM0bnlLTkVHcnlB?=
 =?utf-8?B?VkJZZERUWWV6NzJXck9WVUZicXBjWGtvczB3U2t6NnZpKzVleVpxYVNjNGFM?=
 =?utf-8?B?Q3B5T05wN1VSeFpBME1iNmJ0OTFvL20xRFluYWI4MmhyOGxiM043bURxbzdt?=
 =?utf-8?B?dkdhd0hUOXBYdEFvR2x3SEsrRFA4SXNzd2wxV3dTU2I2Mm5RUkw0c0FlK0ln?=
 =?utf-8?B?VW9oMStRZU02YUpwUjN5SEJRdWgxT0tDUHZ4ZEZSYU5YL2VrUEhGWGpHMWpJ?=
 =?utf-8?B?UithUzI5YU13TXpPZXhRaVl5ellyYzluUGJsSS85V2Z6eWNlSmp1cjUyUWpz?=
 =?utf-8?B?U0puNDhsUVo3WnBrUjBxdm1jWnRHNitaZjZnOTRKZG5wcElNY3c4WU1mYlR5?=
 =?utf-8?B?ZlJHSXNMLzA4YUdoUm1QUDl3b3ZlZEZrV05vc3ZEZFBHeFpGMU9UVXFFWUtW?=
 =?utf-8?B?N0xLdjJGYUxudWc3TVF5RU8yR1N5dG9tSTN2bXp1dUV2Y1pRcTBFRWxRcW1T?=
 =?utf-8?B?T0RpWU81NHB3MTViTVo3YVAzeUViZVFhY1RHTFU5cVhiRi9WMWk0S0JVbmRl?=
 =?utf-8?B?VG41WUdKYWE2S3p3dHUybWRhQnR0WDRnb0hTcmcwL3EyVk1SZHpESnNVUjhZ?=
 =?utf-8?B?aDZEaGZRUmt3Sk9BR2hzS3R3VEl4L3Y3Ujd4VGtrWHl6ekVhOEtRRlIvSHJG?=
 =?utf-8?B?QWtPR3B5MnVzNHZJVE5mNGhVNlNrcnNVUVhvL2tMSENIU1JkQVU5TXJXRU02?=
 =?utf-8?B?VVhZNE0wd01QcC9Bd3lDdEc0NHl3V0VIc0NxUUJhQ2c4djBRK0lqWWg1RzFG?=
 =?utf-8?B?N0QwMERmMWg1T204VXNOWTc2TmpqMVBvSjE3aEw4REpOSjZSY0N6cDJ6VFhL?=
 =?utf-8?B?c2pucTBBbjhQUG1ReVJ3bkRYUlhmWGN0cHNnM1hmWFJtdmRWR2ZjNkZiTkVU?=
 =?utf-8?Q?2cmg4NMnFUkWN+K0ZmYsIVQ1v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291e74ae-3b6b-4bbb-6f27-08dc5d3299d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:58:28.9921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh5C9wZXTzimL/Vm42JoOUs8Hh+VH83dlRvgztdtUf9s3B4h7dqroyCRySi+8N17QqtVDBalZf0lGXveGDtC4+nCAio7+PfkwINT46AoRO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAxLzEw
XSBiYWNrZW5kczogSW50cm9kdWNlIGFic3RyYWN0DQo+SG9zdElPTU1VRGV2aWNlDQo+DQo+SGkg
Wmhlbnpob25nLA0KPg0KPk9uIDgvNC8yNCAxMDoxMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+
PiBJbnRyb2R1Y2UgSG9zdElPTU1VRGV2aWNlIGFzIGFuIGFic3RyYWN0aW9uIG9mIGhvc3QgSU9N
TVUgZGV2aWNlLg0KPj4NCj4+IGdldF9ob3N0X2lvbW11X2luZm8oKSBpcyB1c2VkIHRvIGdldCBo
b3N0IElPTU1VIGluZm8sIGRpZmZlcmVudA0KPj4gYmFja2VuZHMgY2FuIGhhdmUgZGlmZmVyZW50
IGltcGxlbWVudGF0aW9ucyBhbmQgcmVzdWx0IGZvcm1hdC4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBt
YWNybyBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UgdG8gZGVmaW5lIHRoZSB1c2FnZQ0KPj4gZm9y
IFZGSU8sIGFuZCBWRFBBIGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKw0KPj4gICBpbmNsdWRlL3N5c2VtdS9o
b3N0X2lvbW11X2RldmljZS5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPj4gICBiYWNrZW5k
cy9ob3N0X2lvbW11X2RldmljZS5jICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPj4g
ICBiYWNrZW5kcy9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDUgKysrKysNCj4+ICAgYmFj
a2VuZHMvbWVzb24uYnVpbGQgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAgNSBmaWxlcyBjaGFu
Z2VkLCA0NiBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3N5
c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBiYWNrZW5k
cy9ob3N0X2lvbW11X2RldmljZS5jDQo+DQo+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNl
bXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPmIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZp
Y2UuaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjIyY2Ni
ZTNhNWQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9t
bXVfZGV2aWNlLmgNCj4+IEBAIC0wLDAgKzEsMTkgQEANCj4+ICsjaWZuZGVmIEhPU1RfSU9NTVVf
REVWSUNFX0gNCj4+ICsjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNFX0gNCj4+ICsNCj4+ICsjaW5j
bHVkZSAicW9tL29iamVjdC5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgVFlQRV9IT1NUX0lPTU1VX0RF
VklDRSAiaG9zdC1pb21tdS1kZXZpY2UiDQo+PiArT0JKRUNUX0RFQ0xBUkVfVFlQRShIb3N0SU9N
TVVEZXZpY2UsIEhvc3RJT01NVURldmljZUNsYXNzLA0KPkhPU1RfSU9NTVVfREVWSUNFKQ0KPj4g
Kw0KPj4gK3N0cnVjdCBIb3N0SU9NTVVEZXZpY2Ugew0KPj4gKyAgICBPYmplY3QgcGFyZW50Ow0K
Pj4gK307DQo+PiArDQo+PiArc3RydWN0IEhvc3RJT01NVURldmljZUNsYXNzIHsNCj4+ICsgICAg
T2JqZWN0Q2xhc3MgcGFyZW50X2NsYXNzOw0KPj4gKw0KPj4gKyAgICBpbnQgKCpnZXRfaG9zdF9p
b21tdV9pbmZvKShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKmRhdGEsDQo+dWludDMyX3Qg
bGVuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0K
Pg0KPlBsZWFzZSBkb2N1bWVudCB0aGlzIG5ldyBtZXRob2QgKGluIHBhcnRpY3VsYXIgcmV0dXJu
IHZhbHVlIGFuZCBAZGF0YSkuDQo+DQo+U2luY2UgQGxlbiBpcyBzaXplb2YoZGF0YSksIGNhbiB3
ZSB1c2UgdGhlIHNpemVfdCB0eXBlPw0KDQpTdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56
aG9uZw0K

