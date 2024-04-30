Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479B7C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kOI-00041u-52; Tue, 30 Apr 2024 06:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kOG-00041F-RJ
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:07:12 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kO8-0001hy-3I
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714471623; x=1746007623;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CTOnAIIYM3oFNa+sp8bJq7DN95Q57wzTKGx2EY/d6II=;
 b=kxGy5hiFGkRB9WXy+H9hO9bd7jhM/upDcRHRcmgF4om833/8bFkhcWl3
 3HlaEteEqhnJp/xg3lL9wGtmivm3LBxEVZFP3sz1GcoVllFXPP4oZCmrj
 LXyv5pRtjYrYSORqJDBXQnLYekq5PNhKLd8aQqCZ4v38tsZoT5XoS8J1h
 6sZc9oEXIA8P06V/n1CdwZfNWmEmeWH8AyF2I8o69SS3bTugymaMx1V6J
 t1SZQddW1x1ZfpZfZ14Soz3tSBarLrVdtZiMgL8UKlI6ryNZXgjArniyN
 q07N3wsMxiR4NG7LdX6BZs9SrVz4HhKG/vTHOaJRbh7jKSvFgbLARpOuZ w==;
X-CSE-ConnectionGUID: gB2aNfzdRzW6N2bzxFWOEw==
X-CSE-MsgGUID: jNZSZMB9TJ6bM2lNecgvIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10019060"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="10019060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 03:07:01 -0700
X-CSE-ConnectionGUID: jh/SsHepQNWM9ve25braPw==
X-CSE-MsgGUID: vjm+cb/eSI6ZUyLScLQn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="26496952"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 03:07:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 03:07:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 03:07:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 03:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+5Kk12dMarM3+f3x3GL2GGkF7YKdiyNKXLHNHmfEVn+HnygBi488fqH8GXUKfi481twyzWmkFmQEiRKr7+qQhKStGvqmUlhx/CuRrL91AeGEpZPlywucQG/a8ZSueKNaiGo31CQOpFHGjh3oDGPc9A5W9rMmmKMT++YrcWo3xhY1wQg2idmFQ/NH58Q3Iordv+WWBPut0lWEMZ6ntAS0yM4hYVfltZyNEn3f5qaCa2dPV7XAKKNgMMsm5BQpGPtpBir8QWBQ+A7MBzBY6j4ywk4BiXNRbwiI9nOndMRmzQYb82K5vXfM5ws5rdMBCXCKyXVStIxm25biGlDDDQVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTOnAIIYM3oFNa+sp8bJq7DN95Q57wzTKGx2EY/d6II=;
 b=NwbQSc+z39t7up+shW8Nt4f2NxN+bT6HHbdEfU6zJ+mnrRkxNjjtdu86gZSH8/WH8oa8dZxNVi0zahG6q3A8V8ebtAfethE+XEc6M3+L+0PuH6VM0zBsNmr0yfgNBSxjZoVe6o5Fk7m23VUlLJEG7KSJRCi5lwvQrukLkPGgdUJqt0WwMhGSiBPdPL4NaS03/2EP/Xf6DwbzZWY5hTLtYfDeLy/8FPXW7QwSU3hhKYOF9Y713HbvzER6RLpLazkRPT1p8ZWo8DPhaoKB/r0m0tWycRU6hfuyXWbwD8JB/uSfi3rRFiMY+4+6lcQ4VCehQ/7cki2W2CvG2pYI5C4tog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 10:06:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 10:06:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Thread-Topic: [PATCH v3 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Thread-Index: AQHamgIaHWAuSjDxlEifM12XfpSBz7GAkSWAgAAG/jA=
Date: Tue, 30 Apr 2024 10:06:58 +0000
Message-ID: <SJ0PR11MB67444A28721DF3DA94E04668921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-9-zhenzhong.duan@intel.com>
 <44765b34-c4f7-48e0-9e74-5b8a8d427766@redhat.com>
In-Reply-To: <44765b34-c4f7-48e0-9e74-5b8a8d427766@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8387:EE_
x-ms-office365-filtering-correlation-id: ce2b24ff-39d7-4247-d0b3-08dc68fd45eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?dm14V2hUM0k5SHo5QUhhUWZGWWpkUlZVNmFtSW92V2hENW5MQmNWb2lubW5G?=
 =?utf-8?B?YWhLRWtpMVZJelBKT0owekZGeWdHMkRyMXp6SjNkTWdUT0FJL0RNamRzMXJF?=
 =?utf-8?B?RC95RnMwVkQweEN5WExuKzRMekthN2cxNjlmSTlDODNydWRjb05HcGJyeEhW?=
 =?utf-8?B?WStkTUF6dG80M25XMlN3VllFdCswQmRjbG9ybXlsVTdpQ2tYM1c5ZFg3TnJE?=
 =?utf-8?B?Rmh1dDVYT0VXa0NBY21FQ0Vtb0JhTHQyeDN0ZU84OWV0TzFIYjZTOFhOem1O?=
 =?utf-8?B?cEducVhMaFdCOXhiQ2NyL1pvemdsSk95MGR1N050SzJpYlQyd3lLYXV0SVdn?=
 =?utf-8?B?T0JxZTdzbHZHMjJLb3BmYS9uQ1dXMnd2WUdQWHJsMTZtdUJCMGUwUFpVWFpU?=
 =?utf-8?B?Q21Tdk41OFpHVWUrd1o3ekVoVDRzelRDZmthMG9nWFAxSUVWcjYwaEtsSFlS?=
 =?utf-8?B?ZWQ4OE1JK0ZEaEVnUHQvMEtlYm9mMjRBQjlweUh5Nm5QOE42cjZpVDZTaWQr?=
 =?utf-8?B?djd2bklXZER4UTFNbmhsQTlJajg5T1MvdjFqOXE5Z2FYU2hsQjkyNGxMSE1q?=
 =?utf-8?B?MFFxMmoyMjMwcURxODJyazFjRFhTWTFaQWNicGZuV0dHUW41bWEyY1B0S2Js?=
 =?utf-8?B?dDVKNVU4RGlrdXVXbXpneklxRTlqQXRkTUZDbmVTZndpTmV6S3o2TTAzdHVo?=
 =?utf-8?B?MFB6S1BDNWI3anhYWm1nbmh1QkkzSEZhQjc4NkR0YXhuS1N3YTdwdnV5dnZX?=
 =?utf-8?B?WEwreGlGSjAvWFVBSENYVVJQNHlSUXBjd1oxUlROVW1xM1VvOTNGQlM0S1dC?=
 =?utf-8?B?MTFRcVlLU3p3RVR6d1VIUjlpYTc0WmY2V2svUTczK2ZONk9wempINjRiQzNi?=
 =?utf-8?B?YTdiNkhBc2p5cWszakZZdCtOcnBiMitzMkxJYXgyNHpmakNKRldaTVF0NHdX?=
 =?utf-8?B?WTR4SWNCMzVsUzhmWFdjeVV6bnJkMEpEdTVXV3pVQ2N6N0NlNVJzZnlZNzdR?=
 =?utf-8?B?V1BmU2UyQ284RDZQclUzWEtpNmIvUmx2cFNPenc1NVZHRW4zSXI1VnZ4UEFx?=
 =?utf-8?B?NHE1UDR5UDF1dWY5K3FtbnRxVEk2aHYwZElrb1Azb0JvMlQ2QmdTeFVGOXoy?=
 =?utf-8?B?K050a0RIWlBlRkptWVNWNCtHbXVsc3dVZGJmNDI0WkRyS1ViOUo4UFhqY3lr?=
 =?utf-8?B?SG5zVzY5dm5lbU5weVE2Q2M2d0hUcVRzWEpBSjluUzlBV0lYRklScVlETFVn?=
 =?utf-8?B?bEZXS0d6bmZ1a0x6cGp6SlR2Sk1UY3lQOVVpRDNKK1dQOFdPOUhZNklUVTRz?=
 =?utf-8?B?VDUrRElVRURPclh3bW55a3lSek1DaExmbmZLbnByaU5Ra3JoQkJQZEZhcnBN?=
 =?utf-8?B?Y2ZjWFYrd05UMTJXbFdEdnFKVGkrc21vR0p2TENIcmJpVGZaNkwxN2JNNzBz?=
 =?utf-8?B?eDJoR1ExdnJ2SFVkMTV6RnRWVE5yaW1VSFhucUEvbWI2YjZTRTV0ZEE4VVJH?=
 =?utf-8?B?bHJQbk5jb1hQTXk4SW1ENENsWkI3ZnVlNWpFL3pxZ044Zm55WjRTRS81Umxv?=
 =?utf-8?B?aURjdSszSStmYURubzdiQndsODRWUU5qVVhkRHJtZkN5aHlSa0EyeDViNEs4?=
 =?utf-8?B?S0w3RTgyTDFmeTdQODBVaHZaTEFrZ2dIMThYNThGSGtidndXZWZ2eEtiMnFu?=
 =?utf-8?B?Nk1CVGtYN2U4NU1ON1FyOWhjY1RHb1pIWDN3MUR6Tjg0SVhMbWVLbmJzQVVW?=
 =?utf-8?B?YW44aTRNYzJId0N3RVpRNUJCaUJlOUVVaEE2WHZYclo1K0dNWVNkWjhIOHVX?=
 =?utf-8?B?d21pZEN1SE80K09rcTJZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnhxKzgzV1ZqOEJPYUlqenNxWlpzUGswODNtS3NmVmlhVjlNWm4vNU9ROEtu?=
 =?utf-8?B?QjNJMlpsMFdNM1pjL3pzRDlPb3dlYWlNejBhRCtEdnVLY2l1cWMvZHU5UXhx?=
 =?utf-8?B?c09MY1c1S3ltZ3BHOVJmVWkvTUJiL1ZMN0JrZm9PbitOOTM0VVlzTDJzS3R3?=
 =?utf-8?B?QkcvYXh4d3B6Vk03WjRuamR4QlZOd2ZuTUpCOXUzSU5SbFVrQS9nNU1RSEpq?=
 =?utf-8?B?ZkZsMkM3YzFISFZoQi9hTm9mM3hSZE5DWXhRQkNia0YwT1BMT0FsS2p1Vy80?=
 =?utf-8?B?RVo5SkxsaEY0M3gvVUhRRzVrQThBaDI1RTJGM3g3c3FhMm94RHRVYWRxVXZ4?=
 =?utf-8?B?ak5zNWt0WVF2R01LOHhLUHo3eklxL3ZLU0lzbVkvV3JyaGk1a1JLWVFNZXJ6?=
 =?utf-8?B?ZFlIUURPOWp2QUtUVmtnR1dYY0lWZmhqcDlxUXllbUtGWDUydmRoSXZkU3RE?=
 =?utf-8?B?cWtXSVZ0MVF1cS90WHgwcmY1RlJ1YjFtUUtLRmJrSmp0aWkyQi84RElmS0xy?=
 =?utf-8?B?M2RTRW9lN1EyaUZ6RkhSdTBXSEdtU2VEd2ZwcHJNVnpEaWN6SGU2UkVvN1VS?=
 =?utf-8?B?UmRqYmozaW00OWk4MEQ1a0NLKzk0bHlpb25DTm10b2d1MDFVK0VyTkpLVVhH?=
 =?utf-8?B?L1pnMUF0WmhXNnB3UlhiMVVPamExMkpTSDM0S2xXbGpvMVZkSng1NjdRZDd2?=
 =?utf-8?B?WlhqaTJiV0MvZGIrNGtac2dhMGsraFRkWnhycE9pR0pzbFBNR0xMeEltcDBM?=
 =?utf-8?B?OUNhWHNHVUwwRStxMkJpYXZDbVJBSGI3TkIwMHduaDBMVjZZUlVwL0g4L1k2?=
 =?utf-8?B?S0JEQ3U0N1BydU5XQWQvRnZneFg3cE9oN2pUQnZxU1VmU0Z5bWdmTFM3NG9p?=
 =?utf-8?B?b2pNdmpMSmFVaVFDZTV3THdDMlZmSk9LMjhtbmVnbjJlZkZ5QXIwOGlRVXUx?=
 =?utf-8?B?MHhhSUJVK0M3Z05zdEhXaWVmRmRkeitoVlh4aHNTbmxWZExZcmJlSjM2UDZq?=
 =?utf-8?B?SEdzWUJmSkZHejF4cmZqVlJxbHNiU0VLbjFUM2VGRHBjd1V2QzJkOTFFRElR?=
 =?utf-8?B?WElSS2lMVjUvbW1CellPLzNOSWJpVHhpbklxa0JRazBuSnM2RTdxd0xGZ1RC?=
 =?utf-8?B?RXNpN2plRzFXVjVhT1RCUjhSczFkWE85ME94SU9XL0tuYWpQKzM5SFVVckxa?=
 =?utf-8?B?S04xM0N3b0JsZmZFT2dMb240ZUtpRXd2NkJTMzlLbERNZVBsTFpXd2ZuTllv?=
 =?utf-8?B?d1YxMW55REVsbTMrOWo1NGN6ZkZKL1M5emZabXlkVkF1aHFQZGNiWTZPMmVy?=
 =?utf-8?B?UDNhaC9BZEtlY1NhaUJHRlRGQjRKQ3RDdkIwZHM2dVQ2Y3pWNnh3bEZYTGZX?=
 =?utf-8?B?Mmg0cWhSYzNjb3NhTG5Wa1loYmJmbjVvNmVsM0JoWVJuS1VVcFcyTnRqbHBp?=
 =?utf-8?B?KzFlR3VZUWpJMzZNYzFHT2N1ZHlpQlhlcGoyOERTbEpMQ1BnSXMyZ0F0MUd1?=
 =?utf-8?B?alpRd3B4YytOYlA4NVNEeHJweEFxdDJGSk9CekVYV2xoaHNiU1YraTZ5ckJp?=
 =?utf-8?B?M1FtQXRobi9mVTByNTFjZzJxUGx5ckR0RG13cDZoU2ROcU1WcXo2RTRzbS9u?=
 =?utf-8?B?UkQwM09CRkJIbXdmZkNYa0NtUWlsakFodDY0bkRQRkJHR3lMVmZlcDczUlBv?=
 =?utf-8?B?TExJTHBHUWhlTmU1ZzV3Ym93K1BNa2U3eHU0VmVjb00xRUdCVUhtMXp3czBk?=
 =?utf-8?B?bFZoMFMrZEVxeGd0WlBha3JqeHNkNlYvNDBGMDFXVWc2ZzhXR2d5S1dlMXVh?=
 =?utf-8?B?MGZ4V2x0OXQ3T3N4SkMwTlNaNmxyUE03THZTWkZSejhMSTIvK3ZXaEo4QnpR?=
 =?utf-8?B?dEpGdUxIKzkvNjJyMUl4L0NCT2xtMG9XTzZ2bzcrcE5GZjgzU0I2bmlyZC9M?=
 =?utf-8?B?UjdGV2N6LytIQlJiNU9VbFBVWTJkdlJhMmtYT1c1YnEzckNNS0JFMWtFbGVn?=
 =?utf-8?B?dFRsQnpIdUxlMm9zL01rSE9DdzI1SElGak0zYjZPOWw0Nkh1ME5IYXJqTmti?=
 =?utf-8?B?NjBSWEdJMzZUNFJJWEpDQ0dLYmpsRDJQR1E1QWdVdHBQaTJSRHZmbWdMNEk5?=
 =?utf-8?Q?66rX8u+GuMAj2awB0cKETUWq9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2b24ff-39d7-4247-d0b3-08dc68fd45eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 10:06:58.8260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FB4NKBTz05M5yvmUM8SZ+ddVnAHzkoV3os2brdOz9qhtdcLRnKmY/sAxQbfeS2IRgp/MNbwyZlSMsvIKmjBkcMXNjgFYEiFmK/ph3XQzrKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA4LzE5XSBiYWNrZW5k
cy9pb21tdWZkOiBJbnRyb2R1Y2UgaGVscGVyDQo+ZnVuY3Rpb24gaW9tbXVmZF9iYWNrZW5kX2dl
dF9kZXZpY2VfaW5mbygpDQo+DQo+T24gNC8yOS8yNCAwODo1MCwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gaW9tbXVmZF9iYWNrZW5kX2dldF9k
ZXZpY2VfaW5mbygpIHRvIGdldA0KPj4gaG9zdCBJT01NVSByZWxhdGVkIGluZm9ybWF0aW9uIHRo
cm91Z2ggaW9tbXVmZCB1QVBJLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5p
bnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8ICA0
ICsrKysNCj4+ICAgYmFja2VuZHMvaW9tbXVmZC5jICAgICAgIHwgMjQgKysrKysrKysrKysrKysr
KysrKysrKystDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmggYi9p
bmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+IGluZGV4IDZhOWZiMDAwN2EuLmU5NTkzNjM3YTMg
MTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+ICsrKyBiL2luY2x1
ZGUvc3lzZW11L2lvbW11ZmQuaA0KPj4gQEAgLTE3LDYgKzE3LDcgQEANCj4+ICAgI2luY2x1ZGUg
InFvbS9vYmplY3QuaCINCj4+ICAgI2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiDQo+PiAgICNpbmNs
dWRlICJleGVjL2NwdS1jb21tb24uaCINCj4+ICsjaW5jbHVkZSA8bGludXgvaW9tbXVmZC5oPg0K
Pj4gICAjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgiDQo+Pg0KPj4gICAjZGVm
aW5lIFRZUEVfSU9NTVVGRF9CQUNLRU5EICJpb21tdWZkIg0KPj4gQEAgLTQ3LDYgKzQ4LDkgQEAg
aW50IGlvbW11ZmRfYmFja2VuZF9tYXBfZG1hKElPTU1VRkRCYWNrZW5kDQo+KmJlLCB1aW50MzJf
dCBpb2FzX2lkLCBod2FkZHIgaW92YSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJhbV9hZGRyX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpOw0KPj4gICBpbnQg
aW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+
aW9hc19pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRyIGlvdmEs
IHJhbV9hZGRyX3Qgc2l6ZSk7DQo+PiAraW50IGlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2lu
Zm8oSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdA0KPmRldmlkLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gaW9tbXVfaHdfaW5mb190eXBlICp0eXBlLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEsIHVpbnQz
Ml90IGxlbiwgRXJyb3IgKiplcnJwKTsNCj4+DQo+PiAgICNkZWZpbmUgVFlQRV9IT1NUX0lPTU1V
X0RFVklDRV9JT01NVUZEDQo+VFlQRV9IT1NUX0lPTU1VX0RFVklDRSAiLWlvbW11ZmQiDQo+PiAg
IE9CSkVDVF9ERUNMQVJFX1RZUEUoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCwNCj5Ib3N0SU9NTVVE
ZXZpY2VJT01NVUZEQ2xhc3MsDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIv
YmFja2VuZHMvaW9tbXVmZC5jDQo+PiBpbmRleCAxOWU0NjE5NGEyLi5kNjEyMDk3ODhhIDEwMDY0
NA0KPj4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiArKysgYi9iYWNrZW5kcy9pb21tdWZk
LmMNCj4+IEBAIC0xOSw3ICsxOSw2IEBADQo+PiAgICNpbmNsdWRlICJtb25pdG9yL21vbml0b3Iu
aCINCj4+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+PiAgICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4N
Cj4+IC0jaW5jbHVkZSA8bGludXgvaW9tbXVmZC5oPg0KPj4NCj4+ICAgc3RhdGljIHZvaWQgaW9t
bXVmZF9iYWNrZW5kX2luaXQoT2JqZWN0ICpvYmopDQo+PiAgIHsNCj4+IEBAIC0yMTEsNiArMjEw
LDI5IEBAIGludA0KPmlvbW11ZmRfYmFja2VuZF91bm1hcF9kbWEoSU9NTVVGREJhY2tlbmQgKmJl
LCB1aW50MzJfdCBpb2FzX2lkLA0KPj4gICAgICAgcmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+
ICtpbnQgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAqYmUs
IHVpbnQzMl90DQo+ZGV2aWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW51bSBpb21tdV9od19pbmZvX3R5cGUgKnR5cGUsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdWludDMyX3QgbGVuLCBFcnJvciAqKmVycnAp
DQo+DQo+V2hlbiB0YWtpbmcgYW4gJ0Vycm9yICoqJyBhcmd1bWVudCwgcm91dGluZXMgcHJlZmVy
YWJseSByZXR1cm4gYSBib29sLg0KDQpHb3QgaXQsIHdpbGwgZml4Lg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+DQo+DQo+PiArew0KPj4gKyAgICBz
dHJ1Y3QgaW9tbXVfaHdfaW5mbyBpbmZvID0gew0KPj4gKyAgICAgICAgLnNpemUgPSBzaXplb2Yo
aW5mbyksDQo+PiArICAgICAgICAuZGV2X2lkID0gZGV2aWQsDQo+PiArICAgICAgICAuZGF0YV9s
ZW4gPSBsZW4sDQo+PiArICAgICAgICAuZGF0YV91cHRyID0gKHVpbnRwdHJfdClkYXRhLA0KPj4g
KyAgICB9Ow0KPj4gKyAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICByZXQgPSBpb2N0bChiZS0+
ZmQsIElPTU1VX0dFVF9IV19JTkZPLCAmaW5mbyk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsg
ICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQgdG8gZ2V0IGhhcmR3
YXJlIGluZm8iKTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIGdfYXNzZXJ0KHR5cGUp
Ow0KPj4gKyAgICAgICAgKnR5cGUgPSBpbmZvLm91dF9kYXRhX3R5cGU7DQo+PiArICAgIH0NCj4+
ICsNCj4+ICsgICAgcmV0dXJuIHJldDsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBjb25zdCBU
eXBlSW5mbyB0eXBlc1tdID0gew0KPj4gICAgICAgew0KPj4gICAgICAgICAgIC5uYW1lID0gVFlQ
RV9JT01NVUZEX0JBQ0tFTkQsDQoNCg==

