Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1EAE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfqK-0003nv-1r; Thu, 12 Dec 2024 04:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tLfqB-0003na-Ln
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:50:39 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tLfq1-000341-8r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1733997029; x=1765533029;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9vTLWE/6yf/Epnx4V7/QORs2N5c1UCwjyAFz+ZaTohE=;
 b=kuo6FN9wx8QDkn4WT8RzwW/yjEVigj/TOiGLzRpwSvzMByLCDDSr1SOe
 jNgU0rVJGei/LGOciarKeHW7BYtOUbic9KTXUphAWWdXn4lcD3ml9fzz1
 gOJK17YWvYxzRO8aA0tW0GIycUAo5MXUHUhV8AZKUljtv6SMw80n27Uih
 oy2IYA+ET/jcRKS/wg10W+Uy3nKqO8WuUiQ3+OAk3EEaX4mWC8PTeCoX+
 tZyr2uxZBoZvEq0xxXU/vyO4fyk+Eq2ItRvz+3OwNtDQK/cQ57OdA+2PA
 Z6YrHwzqQDWOjr1dBWtvEt1WLhZScE/ujbrJ4T/X755Ai+iXMHvhgnWx3 A==;
X-IronPort-AV: E=Sophos;i="6.12,228,1728943200"; d="scan'208";a="26576701"
X-MGA-submission: =?us-ascii?q?MDEhj4m/+isD2+D+3mj2IIYOQP71HA4dt1fxws?=
 =?us-ascii?q?lHC1wRHEYMsciNRe/TjWHkQFNIqhoonT7PsLKkLJ4YVfUvfoA2hK4LVg?=
 =?us-ascii?q?3YHhWkob8onoKHkfaJgG34Jbft+3p5WAZEQ+eW48FKt7tguzhMUCEbGk?=
 =?us-ascii?q?mxC5xIa0VALvsrldkVfB6KkQ=3D=3D?=
Received: from mail-francecentralazlp17013079.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.93.76.79])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 10:50:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R11D6R61Mgd544FluyYnyhzfCYZ4MiNZ/KdQuxtwdHbXXiq48lcYRAbhSI3uDt36G71VAahtJ/tN+KBTVGjxC/cS6ZRRpKUcsApxR365xR9UR6RqHuNWt5p3GDlT4RP6arYBAYcOhLyeIkTe3fxE1N31IPj9fyOiH/gRJSStvE8omBi6ZqcxqeOM2w6vMaSlQ9hxvgWnRmIb9mBF5ByYZdXoPkys1EXVq6hK7FPhS3TDyybSalUHA5mCqbJqU/yl7uybI0G1DwkWM9Uc5cVKUdO2pCERME+dQWsupi8egkvvYXKglklS3aWdT/YHs15X8DxXZHgwnICdknCfJuFYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vTLWE/6yf/Epnx4V7/QORs2N5c1UCwjyAFz+ZaTohE=;
 b=nlhYjoMYLnlGfSJIz/FC8fAiS6FvM/lJYHEuyqsjgEzXO64mHDVOcdzqeDBEG3XmezoBbqSz4iuvEzxhl0Gt6Ovft2RWT8M4kbe3nttiHjsWxa8tmVZU7u5kCC7rVrn6WSuMb6h+PaWXcwgSXH1hpE3sivZ00jhZIonXnR7MuiXChZzqLkCnFO0uIETNi0irVYTLeCBmyZRvF7LC9Wo1WsfTer20H7NmBDZbOARTChXYmNfnOEDtyR+mVuPoad/+l4+h1fQ82ivvCdHuN1LtEmaty0+NgWPopRcVdw2EWUNWrE7YMJWJAUMAeXytAXBK6pmSDgutzQhxpGqXpHt2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vTLWE/6yf/Epnx4V7/QORs2N5c1UCwjyAFz+ZaTohE=;
 b=Ozge5y5RseVdzYrUcDuLgO+21tY0WcHk7012W/rUiildNdYhyo2FouCm0lAyLwlVyR7/WeGiURV7oewk1kdGA4RXdJoSC2IBfZ69fcp8tmFhukGqeLNKZgbKueBjlYArVQOHLhJywhWuN1B9Gosu/EsQbFpALXeyINzjuX3KB75o7KeeZBWlQbyHeKaW/469fDIR629TQmgnkEj4pJgTGQWeauWAjuukI7hu8yiy4l75DATVZJzgE2q+B4oBERw0GFOSu7af7he4oc5Eb2vzQU64s65lmeXZDY3FZvSeLgVzr/xQ7iShut2EjZgKoopid6g0OoqI5XcbxN08wpGXMQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6400.eurprd07.prod.outlook.com (2603:10a6:800:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:50:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 09:50:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>
Subject: Re: [PATCH v6 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH v6 00/20] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHbTHGdsnYz8yfr+0uZAKmPdDkQILLiXZYA
Date: Thu, 12 Dec 2024 09:50:22 +0000
Message-ID: <a9f91dc0-a424-453f-bd8a-7777e269b961@eviden.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6400:EE_
x-ms-office365-filtering-correlation-id: 6ae36e39-b4f0-4f82-0ebe-08dd1a926584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SG5RMHc4dWtqVUpGSnVtd0FCVDV0WGlmRCswQnJZOHJlY1V2aGNFdFJtS0tP?=
 =?utf-8?B?U3BqamgxUUNDUUNKTGdPdFd6c2VTdnp4TDF1ZkhvZHlpZEwwenc2TDZlUk1a?=
 =?utf-8?B?aGx0UXZPVnRnVkJtTENXUEFTekhzU0FoT3QvVzZwUWcwbFJPSmFjTHZ2QTBQ?=
 =?utf-8?B?cUhLV005VXE3cTV5RnlnblVaTkgyUUVGNVpGN1huNlIydnZzT1dFOHp0WFFU?=
 =?utf-8?B?dUhiV0QwZ1ZHbzkxL3RtandVVjE2WC9ZZGZycXphOFJPck9nSmlDTHVocFpW?=
 =?utf-8?B?Q2lIa090YS9rVXdXOWxYd3NqZzBxMlNwcHZiZlJsWlFORm5DSnY2MHNDWWtz?=
 =?utf-8?B?V1hnVWpxVTlDZnQ4VGNXYVFEMnA5M0E5bXhsM0NyUlhLN0Nxa3YvWjFYMWx4?=
 =?utf-8?B?bjU2TTZVS2oxcU1XdjBndGpaUSt1TTVNN0lsMTdUQzRPMDY4UmVpZ1hKUFFo?=
 =?utf-8?B?MnZxcS9uSFEzTTRuaDNlKy91OWx6SXJvU0FXVEF1THRQVlo1S3FDd1BFSTU2?=
 =?utf-8?B?U0I5UWhxL0dhWStLYjB4eS9ic0ZwS3RaeTVoZ09IU0wyUk1SdlhRNjVvNUp2?=
 =?utf-8?B?anRDajRVMlhJeEM4UCt0ekNncElmVnJybjNMb0hOOHVRcmkzQ2JkQnMvaTZk?=
 =?utf-8?B?SDdteFNiWGNxQk5tazlZTFRXby9sYUdCOThWTTl6NlZyK0NkbWNRZzI4QkFj?=
 =?utf-8?B?ZXBSUGtyZ2tSWkpTNUdncHRYYzJEdUxDYXFBSlQxMUh4Z1pzQzdDb0pGbEJX?=
 =?utf-8?B?RFFXcEJ5Y1VFME9vL2RWZWhXNEY3ZytvaXZ6b3VuVGRLckFJTEpxOU1ZU25l?=
 =?utf-8?B?WEllcDBqeVJPVjFHNXVuYjF1OXhqaFlHWEp2bFkzc0UvMHo0a1B3eUZ6MkZp?=
 =?utf-8?B?Z04wNjg0NmM0OEQ5aWZOVnJnWXRVYTI4dVJDOHFFS2FxOENMR2p6Ni9JT3M3?=
 =?utf-8?B?ZHVIaDBabFVmZjQ1RzkrNWtld2FYMUdiTzdmNUtJdkVHcWFjQXNSRzg3REVL?=
 =?utf-8?B?SlZQdXNmK3hTTlJlTlhzazdBZWFMdVhzQkU2eWtLVEpEdWIwcHZMWXorcU4v?=
 =?utf-8?B?K1pLVzFXSUF1bzgrZldycmFVY1R3TTFRT21rRXpKdzJrNWJzUmtHSHpBaVF1?=
 =?utf-8?B?QUtmMC9yazBYRytkM1pSdHltKzBKZWJJYXVkWlZVOWpLTHA3RUpoV3ZINmU4?=
 =?utf-8?B?d0RLNVVHU2d6QzJGcXZRM0ZHYWdpVDBQWXJ5bUF1bGVUMjNYYm9HR1ZpK1Q2?=
 =?utf-8?B?cWxYYUlwZk45eWpaMVVvVzRIZjFBenowTmFaZ3lQQUpMaXpRd0FVRWYwU3Bm?=
 =?utf-8?B?cnpON1NNOXJJWGplVDdRWFVzb3pWbUtrUnZONHF3ZFJYMHJUdGdpYktrTVNh?=
 =?utf-8?B?VXI2MDN5WGNaRWNXTnFSSWtBTDBsRnlaaXRLbFhacVRhV091WG5RK0pWOFJt?=
 =?utf-8?B?bHk5QVlsSHNHTDVKQ3NNZmtJK3FqSG9tbndHYVpNejVzeHg4cDNUMmpuc2NG?=
 =?utf-8?B?RmtJcFVGVzhPL3p6WjJJNnhKQUtlWW5jL3kzVWJxTlRlQzdRbWl3U1ROeTEr?=
 =?utf-8?B?OGkrbXBTSjZXd3ZIQ215TkJRODBJREp4eWlYcy9qbllwMmtjMEN0azZhNlhL?=
 =?utf-8?B?ZEdDZnc2NGEyMXRNRzNydElBZVUyelBhb0RwOEVBYTM1MTd5K0M4ODJJbHRO?=
 =?utf-8?B?Z2U1WmJxUzE3Q3lYMDR6SzlScEdqVGNlYk5ZbitWVC9hRlBzMzJOOWVJcWRB?=
 =?utf-8?B?Skg0UVcxQk5JSGZoNnFGY3ZRYVViZUJjVS9vTjA2MVhIb0RJUjBzM0VQamYw?=
 =?utf-8?B?OU8rRkhJM25RKzRmc0FXZm9icG10a1UwMEhmQ2ordnRBdytFeTZPSmVSa0t1?=
 =?utf-8?B?Y1BDRVdaUGttTHBHOGFZc2JRVkc5bTBtWm5qd3BIeFlxblZ3R29BUzd1ZG0r?=
 =?utf-8?B?TVdSNVNhY2lTQXRiK293V0pCUzRUZlpZeEJQK0cvT1pTN1FZbDY5Mjh0N1BD?=
 =?utf-8?B?NmpjSFQrZGtnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlEMUt5YXpLWXVGdVhza0ZiZkx6ei9IZDRjS0x1RGt1ZHBzcmlqSnRQWUxZ?=
 =?utf-8?B?Qytob2JMSHBXTW9ZR3pVeWYxMkFldTl5SDU2MTEwbmRGbld4YzFGc1U5MXZ5?=
 =?utf-8?B?QWFHQnUwK3ZUdWFWa1FtWFJCVWp0dkROTC9KUVpFdDBLRUIreEVSdHJ1L2tp?=
 =?utf-8?B?SnNrM1JLb1JrcldobTlmVE1ZODYrcmx1N05tcW51UmVHZkNWZmxkVWZpY2dT?=
 =?utf-8?B?NWJuaS8wL2huS1ZHVUV0SFU1UEFpU1ZWZXhpUkdnM0V2WjFYNDhNckI5Q2pL?=
 =?utf-8?B?bUFPei9rdzg1MmF3Uk9vanpPeXN4dUxNcW0wVzVsV3N0Q01hZVFIdTA2ZlR0?=
 =?utf-8?B?M1hVazltemVGc1UrY21WR2hBVGpnMml5Tkh3YW5oWE5rSnVWQVZ6eDUxNzB6?=
 =?utf-8?B?Qkt2WHA1SzZUTS9kSDlISWI2dGtkRkd4cUwxb2lNT3pUalE3VFVZWFJLU1dG?=
 =?utf-8?B?NUFYZGhqTmM5WS9uN0FPTmRERXJjV2IzVGNTamNlTk16R0VqVXlDeTNrK1E1?=
 =?utf-8?B?K2J4aDNpUnAyOEFoei9aRURLVkxLNE8zc0g0YjU1RzdjdmpqVVFVeUhrVGxn?=
 =?utf-8?B?OGVRM011azd6d2wzbzF0dFdWR1BpOGNJYWJDOEk0Rzl3SzZkK0pvNDNVVGZu?=
 =?utf-8?B?Z040NlVETnB2cUZwVjQ2YnBnZlBhMjRCbjZCMUZEQ1Jjb2FuWWkreldaZUlI?=
 =?utf-8?B?dWg2WnVoTkdMT0NkN3lJaVJpUUVPQXR1Y3BSUXpHdCt3WGJ6ekdUTmdtZXBx?=
 =?utf-8?B?QTVkb1FZYWIxbEFBc2NhU25sZVRFMExQZ09FTnhIamdhUWx4WEtpVlpnd2c2?=
 =?utf-8?B?aDNJMlY2bVlNNUY4bzF6YUJXN0JlbnlvaU1DSm9rWTQ1TW8zNjE4RW82blE0?=
 =?utf-8?B?ZXhtOW1oM3dPY1ZLQ1ZrVDNGbWtqRVFkMEZkMEFHN09JRGRaWC9mZHUvRHQ5?=
 =?utf-8?B?M01GSHNwVXJiKy9qNHc2c0hJZHRrUlk4Y0NZNzN1a0o1TkNmd1o1NkJjNWhh?=
 =?utf-8?B?Qzd5bS96cUlUOHllZkVBTU82aU9kMUhES1gyVzQ4clVFMUtlSTN3QlJDU2M3?=
 =?utf-8?B?Z1RIZGVuQkZ3bTlIUWZTb2llcjJMaWlwcUk3WU5jZDdaaytUbHhPSStsNFh5?=
 =?utf-8?B?d1gvSHhQeEdpdTRBSU1Mamo1QlRGSWJoZlVwRnFIcFFiRFlDTG83Ymh3TXpD?=
 =?utf-8?B?UHg2cm54UENBVVcvb1BDajEzaHRlMzkvZmVwRjdPOW9ieldnK1Y0TVRaak0r?=
 =?utf-8?B?L1ZMRGJVam5LUFRkMmtiRGlWTUFqVHdyYXViUjlHTms2bUVLLzE3T2M2cUxU?=
 =?utf-8?B?OW1mczlRTUdWbUpQZ3NpVWg5dURZR2lkdk9VekhhbFFicVVxV0hHOWZBM28w?=
 =?utf-8?B?TTErSHdXZnU3MG4zbWgxbVoybzRVeC9vM2pETGRuVTM3UGFpaG5jVzByN1Zr?=
 =?utf-8?B?ejBSZ0wzZmcrR3NIU3JmRVVSRDI5Zkd5NWxjSytuQjQ4SmQ2dHZveXdqSHNC?=
 =?utf-8?B?Q1owS2t6c2FlTXM5U2NRSVNPVmp4WVl2YVhtV3hhUndjdk02cEtWMmlWa29R?=
 =?utf-8?B?S0haTDJOZWJSRFBPU1R2VXRPY2N5djMvcVcrZmtVQllTRHpYdktDRHFzaG9Z?=
 =?utf-8?B?VzRjY1dEbXA3OVlPSjhGUTRLRkNRWEpZSU0vTXlLVUdpSEpHT0UxR01ZZklk?=
 =?utf-8?B?MzA2VmVvTW8zWjJ5bVB0S2RzdnVjL0dYWHg1T2NRQmxtWUVSVHc4aklqejdp?=
 =?utf-8?B?SFhPZjFCTXUyc3RvMFRlanZwTWNPWUpSSGNEbEhzeVFtdERGMVhxS0tmLzNX?=
 =?utf-8?B?VWhjSWluYytzNXBtVzFtVWxnL0ZIRzBudktDVWlGdnNKQytlOG1PU1hPbkhh?=
 =?utf-8?B?ZFZXdWRZVzI2ZmpiNlZ1ZXJmaXVmLzZkdkRLcHZOdnlKRUJuREgwZGpuelRX?=
 =?utf-8?B?Ykt6UlR0OEtHdllDQUhONTNKazlFZzQrYUZ5TVRsd25iNkVZcUx2YXRQenFz?=
 =?utf-8?B?cWFQSzNybVR0Z1oxZ28rS0N4QzlDTDZzVm9WQVRlcklBbUN6a3pZeVA1czZ0?=
 =?utf-8?B?bTBhQkVNT0J4eEFXdHZxdmZsbGdnMGlaYkExbXBOT3o3ZTcyTHU2eTdHa3hB?=
 =?utf-8?B?amlsM1VQM2o4VXdWNVI4cHlPZmQzVVVVNStUbTlSeGRydlJEZ0JsejREN2pC?=
 =?utf-8?Q?7i5yjV6Mxby/LD87Q8sLbTY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D32334D79E4642AD78BB27E57A1C8E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae36e39-b4f0-4f82-0ebe-08dd1a926584
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 09:50:22.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXUj0Q+SY9hZO4TJ/uLO1+a7+fp7L0WFpAIGL3dfwECnDUKQ6Cs6OfHkkz2KgSQIODGpqz4EJjDagwPJ82ZlQTxK4sw2ovTg8hyTWdYfpmViWwLyV8T9QSGLYfR5R+9m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6400
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGksDQoNClRoYW5rcyBmb3IgdGhlIG5ldyB2ZXJzaW9uLCBjaGFuZ2VzIGFyZSBvayBmb3IgbWUh
DQoNCkBNaWNoYWVsIEBMaXVZaSwgQEphc29uLCBkbyB5b3UgdGhpbmsgd2UgYXJlIHJlYWR5IHRv
IG1vdmUgZm9yd2FyZD8NCg0KVGhhbmtzDQogPmNtZA0KDQoNCk9uIDEyLzEyLzIwMjQgMDk6Mzcs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90
IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVz
IGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+
DQo+DQo+IEhpLA0KPg0KPiBQZXIgSmFzb24gV2FuZydzIHN1Z2dlc3Rpb24sIGlvbW11ZmQgbmVz
dGluZyBzZXJpZXNbMV0gaXMgc3BsaXQgaW50bw0KPiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRp
b24gZm9yIGVtdWxhdGVkIGRldmljZSIgc2VyaWVzIGFuZA0KPiAiRW5hYmxlIHN0YWdlLTEgdHJh
bnNsYXRpb24gZm9yIHBhc3N0aHJvdWdoIGRldmljZSIgc2VyaWVzLg0KPg0KPiBQQVRDSDEtNTog
IFNvbWUgcHJlcGFyaW5nIHdvcmsgYmVmb3JlIHN1cHBvcnQgc3RhZ2UtMSB0cmFuc2xhdGlvbg0K
PiBQQVRDSDYtOTogIEltcGxlbWVudCBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBlbXVsYXRlZCBk
ZXZpY2UNCj4gUEFUQ0gxMC0xNDpFbXVsYXRlIGlvdGxiIGludmFsaWRhdGlvbiBvZiBzdGFnZS0x
IG1hcHBpbmcNCj4gUEFUQ0gxNS0xNzpTZXQgZGVmYXVsdCBhd19iaXRzIHRvIDQ4IGluIGFsbCBt
b2RlcywgdXBkYXRlIERNQVIgdGFibGUNCj4gUEFUQ0gxOC0xOTpFeHBvc2Ugc2NhbGFibGUgbW9k
ZSAieC1mbHRzIiBhbmQgImZzMWdwIiB0byBjbWRsaW5lDQo+IFBBVENIMjA6ICAgQWRkIHF0ZXN0
DQo+DQo+IE5vdGUgaW4gc3BlYyByZXZpc2lvbiAzLjQsIGl0IHJlbmFtZXMgIkZpcnN0LWxldmVs
IiB0byAiRmlyc3Qtc3RhZ2UiLA0KPiAiU2Vjb25kLWxldmVsIiB0byAiU2Vjb25kLXN0YWdlIi4g
QnV0IHRoZSBzY2FsYWJsZSBtb2RlIHdhcyBhZGRlZA0KPiBiZWZvcmUgdGhhdCBjaGFuZ2UuIFNv
IHdlIGtlZXAgb2xkIGZhdm9yIHVzaW5nIEZpcnN0LWxldmVsL2ZsL1NlY29uZC1sZXZlbC9zbA0K
PiBpbiBjb2RlIGJ1dCBjaGFuZ2UgdG8gdXNlIHN0YWdlLTEvc3RhZ2UtMiBpbiBjb21taXQgbG9n
Lg0KPiBCdXQga2VlcCBpbiBtaW5kIEZpcnN0LWxldmVsL2ZsL3N0YWdlLTEgYWxsIGhhdmUgc2Ft
ZSBtZWFuaW5nLA0KPiBzYW1lIGZvciBTZWNvbmQtbGV2ZWwvc2wvc3RhZ2UtMi4NCj4NCj4gVGVz
dCBkb25lOg0KPiAtIHR3byBWRklPIGRldmljZXMgaG90cGx1Zy91bnBsdWcgaW4gbGVnYWN5IGFu
ZCBzY2FsYWJsZSBtb2RlIHdpdGggeC1mbHRzPW9uL29mZg0KPiAtIHZob3N0IHdpdGggY2FjaGlu
Zy1tb2RlPW9mZg0KPiAtIHdpbmRvd3MgMjAxOSBWTSBib290dXANCj4NCj4gUWVtdSBjb2RlIGNh
biBiZSBmb3VuZCBhdCBbMl0NCj4gVGhlIHdob2xlIG5lc3Rpbmcgc2VyaWVzIGNhbiBiZSBmb3Vu
ZCBhdCBbM10NCj4NCj4gWzFdIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVt
dS1kZXZlbC8yMDI0LTAxL21zZzAyNzQwLmh0bWwNCj4gWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS95
aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9uZy9pb21tdWZkX3N0YWdlMV9lbXVfdjYNCj4gWzNd
IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9uZy9pb21tdWZk
X25lc3RpbmdfcmZjdjINCj4NCj4gVGhhbmtzDQo+IFpoZW56aG9uZw0KPg0KPiBDaGFuZ2Vsb2c6
DQo+IHY2Og0KPiAtIHMvIkxlZ2FjeSBtb2RlOiBub3Qgc3VwcG9ydCB4LWZsdHM9b24iLyJ4LWZs
dHMgaXMgb25seSBhdmFpbGFibGUgaW4gc2NhbGFibGUgbW9kZSIgKENsZW1lbnQpDQo+IC0gZHJv
cCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBjb25jZXB0IHRvdGFsbHkgKEphc29uLCBDbGVtZW50KQ0K
Pg0KPiB2NToNCj4gLSBhZGQgbmV3IHBhdGNoOCB0byBjaGVjayBpZiB0cmFuc2xhdGlvbiByZXN1
bHQgZmFsbCBpbiBpciByYW5nZSAoTGl1eWkpDQo+IC0gcmVtb3ZlIHVudXNlZCBwYXJhbWV0ZXIg
aWggZnJvbSB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZSgpIChMaXV5aSkNCj4gLSBkZWZpbmUg
dGFyZ2V0IGFzIHBvaW50ZXIgaW4gdnRkX2ZpbmRfYXNfYnlfc2lkX2FuZF9wYXNpZCgpIChMaXV5
aSkNCj4gLSBzL3gtZmxzL3gtZmx0cyAoTGl1eWkpDQo+IC0gc2V0IGRlZmF1bHQgYXdfYml0cyB0
byA0OCBmb3IgYWxsIG1vZGVzIChqYXNvbikNCj4gLSBmaXggcmV0dXJuIHZhbHVlIG9mIHZ0ZF9p
b3ZhX3RvX2ZscHRlKCkNCj4gLSBtZXJnZSBwaW90bGIgaW52IG5vdGlmeSB0byB2dGRfaW90bGJf
cGFnZV9pbnZhbGlkYXRlX25vdGlmeSgpLA0KPiAgICBubyBmdW5jdGlvbmFsIGNoYW5nZQ0KPg0K
PiB2NDoNCj4gLSBzL1NjYWxhYmxlIGxlZ2FjeS9TY2FsYWJsZSBpbiBsb2dnaW5nIChDbGVtZW50
KQ0KPiAtIHRlc3QgdGhlIG1vZGUgZmlyc3QgdG8gbWFrZSB0aGUgaW50ZW50aW9uIGNsZWFyZXIg
KENsZW1lbnQpDQo+IC0gcy94LWNhcC1mczFncC9mczFncCBhbmQgcy9WVERfRkxfUldfTUFTSy9W
VERfRkxfUlcgKEphc29uKQ0KPiAtIGludHJvZHVjZSB4LWZscyBpbnN0ZWFkIG9mIHVwZGF0aW5n
IHgtc2NhbGFibGUtbW9kZSAoSmFzb24pDQo+IC0gUmVmaW5lIGNvbW1lbnQgbG9nIGluIHBhdGNo
NCAoamFzb24pDQo+IC0gcy90YW5zbHRpb24vdHJhbnNsYXRpb24vIGFuZCBzL1ZURF9TUFRFX1JT
VkRfTEVOL1ZURF9GUFRFX1JTVkRfTEVOLyAoTGl1eWkpDQo+IC0gdXBkYXRlIHRoZSBvcmRlciBh
bmQgbmFtaW5nIG9mIFZURF9GUFRFX1BBR0VfKiAoTGl1eWkpDQo+DQo+IHYzOg0KPiAtIGRyb3Ag
dW5uZWNlc3NhcnkgIShzLT5lY2FwICYgVlREX0VDQVBfU01UUykgKENsZW1lbnQpDQo+IC0gc2lt
cGxpZnkgY2FsY3VsYXRpb24gb2YgcmV0dXJuIHZhbHVlIGZvciB2dGRfaW92YV9mbF9jaGVja19j
YW5vbmljYWwoKSAoTGl1eWkpDQo+IC0gbWFrZSBBL0QgYml0IHNldHRpbmcgYXRvbWljIChMaXV5
aSkNCj4gLSByZWZpbmUgZXJyb3IgbXNnIChDbGVtZW50LCBMaXV5aSkNCj4NCj4gdjI6DQo+IC0g
Y2hlY2sgZWNhcC9jYXAgYml0cyBpbnN0ZWFkIG9mIHMtPnNjYWxhYmxlX21vZGVybiBpbiB2dGRf
cGVfdHlwZV9jaGVjaygpIChDbGVtZW50KQ0KPiAtIGRlY2xhcmUgVlREX0VDQVBfRkxUUy9GUzFH
UCBhZnRlciB0aGUgZmVhdHVyZSBpcyBpbXBsZW1lbnRlZCAoQ2xlbWVudCkNCj4gLSBkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9HIChDbGVtZW50KQ0KPiAtIG1ha2UgZXJyb3IgbXNnIGNvbnNp
c3RlbnQgaW4gdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoKSAoQ2xlbWVudCkNCj4gLSByZWZpbmUg
Y29tbWl0IGxvZyBpbiBwYXRjaDE2IChDbGVtZW50KQ0KPiAtIGFkZCBWVERfRUNBUF9JUiB0byBF
Q0FQX01PREVSTl9GSVhFRDEgKENsZW1lbnQpDQo+IC0gYWRkIGEga25vYiB4LWNhcC1mczFncCB0
byBjb250cm9sIHN0YWdlLTEgMUcgcGFnaW5nIGNhcGFiaWxpdHkNCj4gLSBjb2xsZWN0IENsZW1l
bnQncyBSLUINCj4NCj4gdjE6DQo+IC0gZGVmaW5lIFZURF9IT1NUX0FXX0FVVE8gKENsZW1lbnQp
DQo+IC0gcGFzc2luZyBwZ3R0IGFzIGEgcGFyYW1ldGVyIHRvIHZ0ZF91cGRhdGVfaW90bGIgKENs
ZW1lbnQpDQo+IC0gcHJlZml4IHNsXy9mbF8gdG8gc2Vjb25kL2ZpcnN0IGxldmVsIHNwZWNpZmlj
IGZ1bmN0aW9ucyAoQ2xlbWVudCkNCj4gLSBwaWNrIHJlc2VydmVkIGJpdCBjaGVjayBmcm9tIENs
ZW1lbnQsIGFkZCBoaXMgQ28tZGV2ZWxvcGVkLWJ5DQo+IC0gVXBkYXRlIHRlc3Qgd2l0aG91dCB1
c2luZyBsaWJxdGVzdC1zaW5nbGUuaCAoVGhvbWFzKQ0KPg0KPiByZmN2MjoNCj4gLSBzcGxpdCBm
cm9tIG5lc3Rpbmcgc2VyaWVzIChKYXNvbikNCj4gLSBtZXJnZWQgc29tZSBjb21taXRzIGZyb20g
Q2xlbWVudA0KPiAtIGFkZCBxdGVzdCAoamFzb24pDQo+DQo+DQo+IENsw6ltZW50IE1hdGhpZXUt
LURyaWYgKDQpOg0KPiAgICBpbnRlbF9pb21tdTogQ2hlY2sgaWYgdGhlIGlucHV0IGFkZHJlc3Mg
aXMgY2Fub25pY2FsDQo+ICAgIGludGVsX2lvbW11OiBTZXQgYWNjZXNzZWQgYW5kIGRpcnR5IGJp
dHMgZHVyaW5nIHN0YWdlLTEgdHJhbnNsYXRpb24NCj4gICAgaW50ZWxfaW9tbXU6IEFkZCBhbiBp
bnRlcm5hbCBBUEkgdG8gZmluZCBhbiBhZGRyZXNzIHNwYWNlIHdpdGggUEFTSUQNCj4gICAgaW50
ZWxfaW9tbXU6IEFkZCBzdXBwb3J0IGZvciBQQVNJRC1iYXNlZCBkZXZpY2UgSU9UTEIgaW52YWxp
ZGF0aW9uDQo+DQo+IFlpIExpdSAoMik6DQo+ICAgIGludGVsX2lvbW11OiBSZW5hbWUgc2xwdGUg
dG8gcHRlDQo+ICAgIGludGVsX2lvbW11OiBJbXBsZW1lbnQgc3RhZ2UtMSB0cmFuc2xhdGlvbg0K
Pg0KPiBZdSBaaGFuZyAoMSk6DQo+ICAgIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVzdCBmYXVs
dCByZWFzb25zIGRlZmluZWQgYnkgc3BlYw0KPg0KPiBaaGVuemhvbmcgRHVhbiAoMTMpOg0KPiAg
ICBpbnRlbF9pb21tdTogTWFrZSBwYXNpZCBlbnRyeSB0eXBlIGNoZWNrIGFjY3VyYXRlDQo+ICAg
IGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3Igc2NhbGFibGUgbW9k
ZSBzdGFnZS0xDQo+ICAgICAgdHJhbnNsYXRpb24NCj4gICAgaW50ZWxfaW9tbXU6IEZsdXNoIHN0
YWdlLTIgY2FjaGUgaW4gUEFTSUQtc2VsZWN0aXZlIFBBU0lELWJhc2VkIGlvdGxiDQo+ICAgICAg
aW52YWxpZGF0aW9uDQo+ICAgIGludGVsX2lvbW11OiBDaGVjayBzdGFnZS0xIHRyYW5zbGF0aW9u
IHJlc3VsdCB3aXRoIGludGVycnVwdCByYW5nZQ0KPiAgICBpbnRlbF9pb21tdTogRmx1c2ggc3Rh
Z2UtMSBjYWNoZSBpbiBpb3RsYiBpbnZhbGlkYXRpb24NCj4gICAgaW50ZWxfaW9tbXU6IFByb2Nl
c3MgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uDQo+ICAgIGludGVsX2lvbW11OiBwaW90
bGIgaW52YWxpZGF0aW9uIHNob3VsZCBub3RpZnkgdW5tYXANCj4gICAgdGVzdHMvYWNwaTogcTM1
OiBhbGxvdyBETUFSIGFjcGkgdGFibGUgY2hhbmdlcw0KPiAgICBpbnRlbF9pb21tdTogU2V0IGRl
ZmF1bHQgYXdfYml0cyB0byA0OCBzdGFydGluZyBmcm9tIFFFTVUgOS4yDQo+ICAgIHRlc3RzL2Fj
cGk6IHEzNTogVXBkYXRlIGhvc3QgYWRkcmVzcyB3aWR0aCBpbiBETUFSDQo+ICAgIGludGVsX2lv
bW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB4LWZsdHMgZm9yIHN0YWdlLTEgdHJhbnNsYXRpb24N
Cj4gICAgaW50ZWxfaW9tbXU6IEludHJvZHVjZSBhIHByb3BlcnR5IHRvIGNvbnRyb2wgRlMxR1Ag
Y2FwIGJpdCBzZXR0aW5nDQo+ICAgIHRlc3RzL3F0ZXN0OiBBZGQgaW50ZWwtaW9tbXUgdGVzdA0K
Pg0KPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oICAgIHwgMTAxICsrKystDQo+ICAgaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmggICAgIHwgICA4ICstDQo+ICAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgICAgIHwgNzMyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAg
IGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgdGVzdHMvcXRl
c3QvaW50ZWwtaW9tbXUtdGVzdC5jICAgIHwgIDY0ICsrKw0KPiAgIHRlc3RzL2RhdGEvYWNwaS94
ODYvcTM1L0RNQVIuZG1hciB8IEJpbiAxMjAgLT4gMTIwIGJ5dGVzDQo+ICAgdGVzdHMvcXRlc3Qv
bWVzb24uYnVpbGQgICAgICAgICAgIHwgICAxICsNCj4gICA4IGZpbGVzIGNoYW5nZWQsIDc0OCBp
bnNlcnRpb25zKCspLCAxNjAgZGVsZXRpb25zKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPg0KPiAtLQ0KPiAyLjM0LjENCj4NCg==

