Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97190C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUqt-0005Nl-1S; Mon, 26 Feb 2024 01:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUqr-0005NR-Tz
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:52:38 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUqo-0000Es-NR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708930354; x=1740466354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=znJFsZHpMAkS8s4gOoCsDPtNNeSHpanFrSzJKhJSzGI=;
 b=ihiyEVSzE6MVcj8ZqY7OUjxZQ9MH0q2Rh+pYF9lIOosudPw6zsdQMJcf
 NQyzoKRkgMxpXEw2ldKrHDkdIDMbR8DAUADgzDDMYLc+7RJyiClwIw3Y5
 F5SOHrvP+GwuVkaZyGnXu1wa2yMYJ8nQ2hu+KH/pXbe5UMzPa5LJuIjaZ
 VOV/Eo2Vmu+6Jqbcp+DomEfx5v0sxIU3tczaavQlijuFpBZDjnZ1tIqpM
 vpI3pMo1lpPlcJPn3oC8qtJHqBneohYBTvyY7SnTdC5V0R9P+iusXdaNX
 gLEZdL59efVZwN5CBLHvGHDACNRlrYQBt7oKR6hN/H3ab7VfvpcGK7oIY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3059545"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3059545"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 22:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11157684"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 22:52:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 22:52:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 22:52:31 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 22:52:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2XTe9qXEEnFhbp7FN0EfTpQBPsH9E/UrDm6xDbS32uqzwyW08F7xi2u71GWRoaerlmjkWyooxV695h5EelQ6VB7G2hMjdj37TcNYqfqFuaaj7+OwEy9dBytL3NNlbqEHu0SiCAgCw/841RQ+vErUH29Z6/w390jLD4ij5iR8HQ32AXtu8EMHNoOnNt7Jf8Y2jLgTBKcLC79DQaWQJ3i71y/Q0sxkfOGTigJTUT7VFP89ev+uy2LwWBKC1C6Zhu0FSpeMDMXYRhf+PCnW4ZZcojRlT+ZHdY0fsE/Xe8HfiHfWzjMu8ya3pUW//xr0ITPpsIO55EYSrjzOTxC0v8stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znJFsZHpMAkS8s4gOoCsDPtNNeSHpanFrSzJKhJSzGI=;
 b=e2WQfeXLYAialt+/TQxiRcxi1YAibFIsSpclBgjEGkLKBakes7prIQRFQXN1i3Ybwib5IzaS1ItIs2UNsWzWpOvrzHB8pqA17b8oOixGGpHc4FV5gTVMPIWTNpymWnemRLFWF2KEgx7hpoQ1eOW7aM257dt17xOM4AWgXV0Pf1VgmjeAZ5RI7CspNfbiSGKSfAvO50U9aeOYRzhvL9iOzSJ9vPlYV7mKeEhnvSpMHzpT7zYQsbx8O5DUPXrlOmPn74AigsHpyOi4x9BE2diNLi78mb64pFX706oZdep0outlxC3u3Xp8OA6KvWLlrtgSB+HcrGQPmDwgxhRx7b6dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 06:52:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 06:52:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 11/18] intel_iommu: Add set/unset_iommu_device
 callback
Thread-Topic: [PATCH rfcv2 11/18] intel_iommu: Add set/unset_iommu_device
 callback
Thread-Index: AQHaVOCmlIs1pDPvqk6G4FYIOIRlaLESDWQAgApCiCA=
Date: Mon, 26 Feb 2024 06:52:28 +0000
Message-ID: <SJ0PR11MB6744428666AE12069816BDAE925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-12-zhenzhong.duan@intel.com>
 <5ce5af6a-1279-44a0-87ca-820021d41a18@redhat.com>
In-Reply-To: <5ce5af6a-1279-44a0-87ca-820021d41a18@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6863:EE_
x-ms-office365-filtering-correlation-id: 7898e314-55ea-470b-2810-08dc36977fa7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YchhaZF6pa9L6lcCCyeA6/Bz/MuDkAzilxv/bFtvqzH00lU1NZkvd6ObC5Oo0UbsvNtbYJNeSrlOELSZy06ifco3dCUMQe5/VCHnyK4CjvJU4KjuokK7kUnuOiVa02D25+872V0JgjNGdnbIXgmx7BTFRfk5m66c0Pe4qsmGcuK6KfNNxzyRx4J/14HuZkHV2sNYPM1OMls/ZNKKFGE5s8mpjRtAi+GIG2RSftrm6lLX7rNt7UaNmTLkoFTOt/vxZgI7PJPe82L0BGX7YLxH/5S5dlMH5UIiskROC1m/4s/XMIGmk3dubh5MJDrJ4Kel2mnXv6L39TbctkGkiYw+HUIDHU+3Gk2e9Lb++xCvEXxeqtyIlz0Iv/Ms0kAMnw2hakMDVYIN7pqalrtFMsY+KIabc1BE8yGMd+F/faZfWPzjR4Nrv1GG7H+lsJPPY8sljSSoRPpDZQrcKAIZE67tNZZ3iAUtzNIUaM+mMLSDTB9f9Ne486TajG5L8cjF0uPOvlvs/Qoz5YnzzMvd+BDD6mWNRND6Zw7u2TovghjhSECfigR4U5uQ+uqKyxrs6zokoriJ/sIML/DZFxZ9KNTHXBqxR/B8eFF7WdlstJeimFhAYzRRY9+Kf2oaO3i0ldAAxGDDJwxX9J0LzkZ3frmgKzSy3JYJ9Oery6jIyZEGuy3CTAOAVJKPHII0d/GV9HTYPyq9MzZO7B6PH2FOoSFT2+a4LGMYV1WfyCuQ70QpJKc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGM0eVM5V3hreHcxbjVkdllkN0FqZXkrM1ltQkZnTEQ5K000QTlUa3NrclUr?=
 =?utf-8?B?Q3ZXY3ZmVVNvK2dHeStxczhidEFPWHVIMkV3bU9ka2VjSVgraEE2MThJQVZz?=
 =?utf-8?B?dkxvZnYzeWNyVFJnUnBtVDBSWFBQdEh0dVUyTjhFRHg0aVhPUE1KbjlXTWZ5?=
 =?utf-8?B?aFBOTFk0bjNUY051Yk1ZYU5TRUZkNEVkL0EyejdZeVVDL2pNZ1QwZEFxVi9F?=
 =?utf-8?B?OVd1eHIzYm5TUklnZmx3MFkySnZBck5Lczg5bTExVlIzNFM5aS9BdHdQc2Rt?=
 =?utf-8?B?ZWlLK0NJWjBIWjBLUUlwRUI4aW5jUXY1Slo0MFdiZFAvb2xsSWVjbTRTVVE0?=
 =?utf-8?B?RnMvRXdXcUZxMnVlTk5EdjlMbGVOZEZpQjNpbXlSSGhwNlR4ZlFBYnVGQ256?=
 =?utf-8?B?Vk1kY3EvUlNUSjZhTXVic21VU01LVkpJL0poRlE3cExwRzZSY2JPTlc1NVhr?=
 =?utf-8?B?cjM0RkZLcndSQmRoMzdBRDgvd2Z0UWR5S2dXU2l1ZWpDNFdrOGJyY2VEUnQz?=
 =?utf-8?B?eUpmS0hJVGJZU3A2anlERW04SFhSYklCcUk1czZGOUQ5ay8zSU5YaFBkZ1E5?=
 =?utf-8?B?bHVGQzA1aW5oU1N4WGcvemNZc09MbU8zTVNaS3JQcy91OGJQU2xsRHplZlVX?=
 =?utf-8?B?YkFJTnMzdVJRSXNHN044MXdILzJLTHpZZVNTamhMNUNGS3MwNFRBS1hHOUZz?=
 =?utf-8?B?V3hxa2dXeVRkM2pKK1JLNTJoVFJ1djRibzhreGh4a09vaDF6dWlLckJuR0Fn?=
 =?utf-8?B?QUwyZ004aHdkNTVwcEtDZURvMTBnRGJ0NGE4SEdOSzJrWElmOTBGMCttbW82?=
 =?utf-8?B?SmlKaU03TnZGc3V3OFBmbHBKMHBzdkpFR2ZNRHZtaDBHaWQ1dGZoL2dCV0c4?=
 =?utf-8?B?bVljZkNLUHhQYmhseEcwZENyWFRMQk9EdTRFa2JEN2RhdWFKSGYvUnlPZy84?=
 =?utf-8?B?REhoNnMvSWpvU1BVY3orYmpzWDJYSFB6bUh0L0Zhd1A1RnRtZG04VkE2Qmk2?=
 =?utf-8?B?T3NQMzQvakxSbW03eXVqR0hlZmJHZTdYYUdzTXhzMUllNSt4M2d2MTN2aGdI?=
 =?utf-8?B?d1JRc2ZMQzFqUE1yY0ZwSnlpNnVHTmxCLzNrODlRQmR0UnVyeW1iTkJGU2t5?=
 =?utf-8?B?cGFtZXlLbGRDYkRkUXRCNTNKMGh0cVY0NjVFNlpwazQrT29UNVpsMnZ1RE13?=
 =?utf-8?B?OUNtN2RLMEdWOHJYZEVtZmxyOHprR0ltMHczaXZvekd0SVIzeGE0aVFzRjVV?=
 =?utf-8?B?b1BBWnhaYjBFeGZuK05JaTRWVkd3MTdtQ3NiM0p6VmNDQmhrSmtWRlYvYlQ4?=
 =?utf-8?B?c1ZDOVRmN0NBUUVSNkppdTE5c1lQOWhBNnRaQkpMVzVBZ0taRjVFNlJvVXFC?=
 =?utf-8?B?aWthTHhlWU9EOWlxcUgxWG4xclBjQndHMDlSWWE3YlkvTWpEQ3RYdDBpNjkw?=
 =?utf-8?B?aytmMVJtQXNrSm9QcG84ZFU5TTRWWUI2VmNiWFpBUmlzeEJiNkZkdEdpNy96?=
 =?utf-8?B?VTBONkt1Y1hiNGNMNXVuNVg4VC9CZ1pZNjNZTkIvVjFVc3cwWDY1eTZGQkJk?=
 =?utf-8?B?ZzdzY0c5U0RkekRFeVJjU3FndDJoNExFbzBtMzJoOEJSOUVYU3JMSDFxMDVu?=
 =?utf-8?B?bjg3SFBRam4vWktWQ3JIWFpLZmVMbzZEQ2FPcjZ4Skk5Q2Y1RnFQWVdFQlRt?=
 =?utf-8?B?aWY2eW52QWsyMWdib2o5ck00eC9tdkNPOWcyVVpJNVNIMURERGRGaFZyVm5R?=
 =?utf-8?B?dTlpUjlta05idkN2cHIrMytYeHBlSjBNM1luY3RGVFRPTlJSRW9obzVUM3I4?=
 =?utf-8?B?UGlmRmFGeVJYNlFmanpqMUt1VkpoNUpjQllkTTFJamxqRUN5K3pIS1gvMlYv?=
 =?utf-8?B?SFNqTGx6RmZaWC9aZ2wrZE0zYWlpNW1DamowQkJmNGd5ZlV6ejFSZUVnSlIz?=
 =?utf-8?B?V05GV2RGdy9mUlphdW43RDczQ1lLNWJnbDFFVGUxbHM1bnh4TzJkeHBMcE84?=
 =?utf-8?B?bEF3cllnVW5STzR1cW5VSVorNEY3c0YvT0ZqNW5xUFQxdXJzVGUzemtBMjFV?=
 =?utf-8?B?bHpGOFJHbjhuc3VTdHRXZ2VGYjZpcEZQNS9IQWkxTVZpVURtMUdwM1A0TXk5?=
 =?utf-8?Q?eRtAYF8IG9sZy6dQQF3Jas8n/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7898e314-55ea-470b-2810-08dc36977fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 06:52:28.8815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8tBm6pT6VTWzViKQOMk3YZY2QVK8dOqHmnfuJQLkTQJ0FInNZNIOsz5szQEQ9DlnMYwFgcJKxfbBN3zliOaZYOIzn8bR2NP5Pi1zGqhkcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDExLzE4XSBpbnRl
bF9pb21tdTogQWRkDQo+c2V0L3Vuc2V0X2lvbW11X2RldmljZSBjYWxsYmFjaw0KPg0KPg0KPg0K
Pk9uIDIvMS8yNCAwODoyOCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBGcm9tOiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBUaGlzIGFkZHMgc2V0L3Vuc2V0X2lvbW11X2Rl
dmljZSgpIGltcGxlbWVudGF0aW9uIGluIEludGVsIHZJT01NVS4NCj4+IEluIHNldCBjYWxsLCBh
IHBvaW50ZXIgdG8gaG9zdCBJT01NVSBkZXZpY2UgaW5mbyBpcyBzdG9yZWQgaW4gaGFzaA0KPj4g
dGFibGUgaW5kZXhlZCBieSBQQ0kgQkRGLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBs
aW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oIHwgMTQgKysrKysrKw0KPj4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8
ICAyICsNCj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3NA0KPisrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDkwIGluc2Vy
dGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGY4Y2Y5OWJk
ZGYuLjMzMDFmNTRiMzUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTI4
LDYgKzI4LDggQEANCj4+ICAjaWZuZGVmIEhXX0kzODZfSU5URUxfSU9NTVVfSU5URVJOQUxfSA0K
Pj4gICNkZWZpbmUgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5BTF9IDQo+PiAgI2luY2x1ZGUg
Imh3L2kzODYvaW50ZWxfaW9tbXUuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVf
ZGV2aWNlLmgiDQo+PiArI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb21tb24uaCINCj4+DQo+PiAg
LyoNCj4+ICAgKiBJbnRlbCBJT01NVSByZWdpc3RlciBzcGVjaWZpY2F0aW9uDQo+PiBAQCAtNTM3
LDQgKzUzOSwxNiBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9vdEVudHJ5Ow0K
Pj4gICNkZWZpbmUgVlREX1NMX0lHTl9DT00gICAgICAgICAgICAgIDB4YmZmMDAwMDAwMDAwMDAw
MFVMTA0KPj4gICNkZWZpbmUgVlREX1NMX1RNICAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYy
KQ0KPj4NCj4+ICsNCj4+ICt0eXBlZGVmIHN0cnVjdCBWVERIb3N0SU9NTVVEZXZpY2Ugew0KPj4g
KyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0YXRlOw0KPj4gKyAgICBQQ0lCdXMgKmJ1czsN
Cj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+ICsgICAgdW5pb24gew0KPj4gKyAgICAgICAgSG9z
dElPTU1VRGV2aWNlICpkZXY7DQo+PiArICAgICAgICBJT01NVUxlZ2FjeURldmljZSAqbGRldjsN
Cj4+ICsgICAgICAgIElPTU1VRkREZXZpY2UgKmlkZXY7DQo+PiArICAgIH07DQo+YWdhaW4gdGhp
cyBsb29rcyByZWFsbHkgd2VpcmQgdG8gbWUuIFdoeSBkb24ndCB3ZSBzaW1wbHkgaGF2ZQ0KPg0K
Pkhvc3RJT01NVURldmljZSAqZGV2Ow0KDQpTdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo=

