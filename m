Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F88FF6E8C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mPN-00030X-8h; Wed, 18 Mar 2026 04:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2mPJ-00030P-MK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:37:37 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2mPF-0002Lb-Gw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773823053; x=1805359053;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KZdb0CMKZtGxrjv+uOHKLtrXySxwUnyFaefbuZ0XRTI=;
 b=Jch828usKSsjbGsUKjZEh4nB+7fWmmcz0PsjdG9xhgk+32R4IOUqWEmd
 e/Zf8LkSi00jkVXCC7HfrL1WEJ1IhAha4zpIOHkmhdj4vLEO9dX49cyCc
 xnTFRwHDqSggeDs61bfPHNiKOCVLRshN3I+HKz/k6w4NVZKNjNdVkvdic
 av4Qi9aNxn7oGIxZeB3dZNSm8ZZVZlpigzL4de6TlvjtnaKzXi/CY4f4U
 Wue2CwAosaTS67fjoidqWgZJ+l2UU4wXa8n/wv0aZdIobfm547J29QdMh
 KQh47uS7l4RSKfm1dehtKgYvipCp4p82XNnQQnRTqPYbWZhe++256XC9H g==;
X-CSE-ConnectionGUID: xUoujPbkRySyk/ADdOP3dg==
X-CSE-MsgGUID: o4HpZnvRQvmzMZz6/nYgWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73891005"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="73891005"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:37:30 -0700
X-CSE-ConnectionGUID: U7J348DnSACpPxMimxPJvg==
X-CSE-MsgGUID: 6DwtWx0eQuaiPA9KaJh1dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="221637271"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:37:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:37:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:37:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:37:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOiz1orYU/HVi0Ag7QrQsRkflokCNa9HvF6APCkD+0bSsOg3D2nALwKrDsI6yv1OPMQGogKPfbJtOotKpHVPA1el2vtZMPPDArDyEkrmLJ7vGnU47oE/l1Op29Zg2cnqtY9l0wOdp+FWdcN1AYAWs6G9T+xV8yt1pn9qriGbLSvHN9zzVoaC53KfYB++Ff7ze5jzVBrgu3KHlmQ/cSndT4vWsB+kDR6zolbZuV1A7NMjdU62yTNJ3etoGFfgKtFqJ5Ec+SWnOPeEOXYKLxlgvmg/sgij3am8SJM+LJOGuaeGoQGU1FLr5eagyx10dJdH/sbeItfeCJpid7RZ5GoLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZdb0CMKZtGxrjv+uOHKLtrXySxwUnyFaefbuZ0XRTI=;
 b=WrhNVcPquFFkTDhTWiLOPGMwx8dx3BT+fDqjcectrMx+UfIx9wW/2rz2pIbK5NjANjcFaThC+giPCL4qsojTK2zT5s+pmxmzEnad99IcfVe6YWcN1LFcZOPxlSOUzHd616YhSBgILkS1aH0cE3hn19gHfxIHaXBzxgNQUCKJBluHD88TsmS07V5+sstBdSbw0cbB+drL5rIr6mo4wE4+4tDT/uk4dGKvgYlwEYl+QdHr6PArPVXs6KHif4FvZfqAqGDWbg4x0I0sRwfd9WDNCJ+iKzSp6RI8MIUsamR+4MPWaB+yt+Gi5qojuUkvwW/PI3T0ZuPJ1qakmI8YakxhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 08:37:25 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 08:37:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>, Eric
 Auger <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Thread-Topic: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Thread-Index: AQHctmGHiBHM8iMR00eLUFzvqqaWNrWz5tXggAAJFgCAAAPtEA==
Date: Wed, 18 Mar 2026 08:37:24 +0000
Message-ID: <IA3PR11MB91364D3734AA30AB6C474E1D924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
 <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <068a3098-4e4d-490c-9cef-ac39a7e9c29f@redhat.com>
In-Reply-To: <068a3098-4e4d-490c-9cef-ac39a7e9c29f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6516:EE_
x-ms-office365-filtering-correlation-id: a2792017-67eb-4b94-bd1d-08de84c994ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: AfkHEFtIva32UOmJmXCzAQaVQkVhYVeQr/1M/xkZtC9Rxmqqbv3jRfA/eRwkn0TfQRT/eqW0MWV35NlyIEJxLiLz4MLes3eC+c+DMobPOFd95+ypNALHGOGD6p7/NoVrPFh7RgRgj+wawYILqn9zjX7INx9kqLs5OmgZ9N2Ge1e4NdhV8hWOTis7m5FqUIT4aC5BHbq9N5EeXN4NU1+O0x1Nd2pksMe75i4AX7VvHChfpVwvRPaTXVE7M/emJYiDAIgOf2zujWeW/b8QkXCs9VbOzm/dry0VNL7eH0Ra+ZgLFxwMzb1ZcpNE+/5BoIRxecUcwos+oOBAILH5hvUEsm2sPSOT7XZJ57fE+lWxMvTG15zinpVMj6aCvxdkAcrmkUTVgn9Dh5spjtgsIcKV0U2PxA3opwUyoN/sySNiB9u/KHxKqB89FZ5h/HfAbzkLf/JdC7dE42yXAjmpQ6ugE48PEpRhgF2kBY58pgTOwCDqIpYKpEv0dT+9Fz3kw1dWfwfgRr55i8/24LWJqGABkiBnZT3hgBGvTGVS3nfcU2XhCAYWsG/Z3VpZO9bLPxy9KFLDWR0wM3vd85RVP0UZ8bmoyCLZ/HHYQtjk3o3CPWCyvun0QH4O8THaZPaiEaLIHFY96skfwmtJ0WibuSvnDp5kLZ1sYCBSVOK+HMhfoijGft3JtPgOmfZf5VdJeqGhu2mnSn1FRdX9S9MyXe0F8X7CL8lFPaho+kmd65AOPpr6OAAExv4cOljOk9m6Ij0eLIovDLNn1p3QA4uX2DaoSuperDUTnpQS7imhgAg0MmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjFyVWtqb3RTSFFtUjlZeUJZOU9nSC9EcFdsczBJMnRVL1VEVWlvaVl3QUNW?=
 =?utf-8?B?ZkVlcHN6WEwxSldhK1ZLUDg0L1I5M281cUxIMzlaN1lMbWhTR3grM2VCMmx6?=
 =?utf-8?B?ejFSbWVGMk9NNzlVa0V5dUJyajljM1dFMG9Wc2E0SVpoK0Ewc3V4M0NkbTVm?=
 =?utf-8?B?bG05RlRFaWZhb1lxQ3BBYmFWd05kNjVyNldGR2RTTVJWd05xdm1Peno3dU04?=
 =?utf-8?B?Vm9PV1pZRmNpTjRIdnlQOXk4cUNLWS80RG11cXgxcms5Wi91OXNyL21BZ01R?=
 =?utf-8?B?eGFjUVVNNDdzMTdCRk5pRUFPTWthY083RWM5NjhMWTVRSTl2RmtCaWJveTRJ?=
 =?utf-8?B?V09mRlVxa0RGdzAraG10ejhsQWJyYVpRbzZQQjE5czBQSWxpYzRIaGk0T2pZ?=
 =?utf-8?B?RTFNbEVQYXlyM0xMNXlhWXNXUWNrRzlQeVh6RnFGRGNieUJ5Y0hoYURSeWl3?=
 =?utf-8?B?Z3VKMzlobmJNMHlQYmZldXljRUZKalJNdkx0L1U2WHQxSm54ZHpoVjFMcmda?=
 =?utf-8?B?UW1WZmtKVXZKV3dKZFZnYTBqWk85QzRzSW55aGNJUzJpWkVUV3l3K3FHTnRZ?=
 =?utf-8?B?Ylh5dFZwSjhKL1Jia3lsU21iV0JtU1plTXlQUnB2YnZITWEvRlhvOGlsazE4?=
 =?utf-8?B?bjUyRU0rdE82VGIyWUROaGhQQm9INnpjNStPUXFiR2krK05CREU2VUF6NGVE?=
 =?utf-8?B?N1ZDRXgzU0x0UVdndytaSjBQVkQxbjRJY3RaWmJxYWJva0MrZ21CRVo0VlU4?=
 =?utf-8?B?c25lU2pWMXpxVmsyeEFyTVR2c2VyVjhFeE5CbVB1RzQvODhBankvZTVxNTdj?=
 =?utf-8?B?U0RxTXBzZGl0c3crdWp2WE1XelpWYk1URTY5elNXTUZRZUJGQ1NHZEZYZHlp?=
 =?utf-8?B?YTUxMHRINGIweU5NWXo0Yk1SSDVVaFJTUjl6eEJ4UG90bVMwVXJ2bUZYWmVP?=
 =?utf-8?B?ZmxBeHZLdW9ocGVZYzRyL0NBWVpPZUI1ZHZuWjV2YUd5V3VkYUJXUVJESVJL?=
 =?utf-8?B?NW1yUlJYSENvbU43cGpCUzFZQTlkMWlTZnZXM0NOemNvM3VvTDRqZnRWQyt6?=
 =?utf-8?B?SmZVUThVZmN5d2Q4cHRXdmRSMlUxeXcwemJpamY0QVBpamN0eWJVdG9GdTdG?=
 =?utf-8?B?Ui9jclFpLzdINnBiT1AvUEoyRlpkUGVmYnNaOHV1SU9EQy9OVGp3YUN5M01x?=
 =?utf-8?B?ZWpSbEVrc0JHcjBPbjIraUNNWjRwVnFvSCtGV1BXMDg2OHpyWGhvR0pyemtX?=
 =?utf-8?B?eEk5ZTVhSHlWQUhQM3drR1VNV1QvUnQ5MUJ0SU9hdGdWY0hpV0RDdFR1UGFD?=
 =?utf-8?B?cEY3MVZMRHZyM24vcmhVZmd3VUVuekJTRVRRY1hSVVNjUGNCMVhoM09OQ3hi?=
 =?utf-8?B?SXptcjZ6SXN4T0NzTGNIaXZXQTJPd3NocUF0VmxKNTZYb0FXWnlHU1BJR3Nn?=
 =?utf-8?B?cjFpaTIyOFdISmVGdEozU0NFTDNlaDNpL25RQTYxVGxqdU1EbmF2YnRvaHZB?=
 =?utf-8?B?OU5BWVMxSkhKNUVpRnAraXBVUktvdG5WRnAzdlpWUW1xSEthL01WbmxVd1A4?=
 =?utf-8?B?WStaUjNrNGVBell1NnBNOWFhWmVRNkRxR3pKWXFYb1BHeFFWWTRVQ3hHaUg5?=
 =?utf-8?B?QW5wZzJZMXFYUUtwMWgxNDlUUUNVU0JhOFV0d1ZhaWVCaVZCNGRzSGVLcVhZ?=
 =?utf-8?B?NGNQLzJ4ZGN6MjhzWXhOb2dwYzVYNHA1VVJzNFJMR3o2N1p5TURMTzRhMnJk?=
 =?utf-8?B?aW41SmhOQTJYa1o5RS91bU1HQjdwNnhFK2NmS3E0cVI1YXlST0NBQUdCSG5k?=
 =?utf-8?B?blhwTVV2YUlYdU1PcGYvY3VBSkpDZitVc0NSUTQ4SXV1ZUJmeGNFWjVRdnIy?=
 =?utf-8?B?Wk4yWTAra1VrL0kzZ2lzSTVuZ2thU1A4YXB0dWVsVWhwRmdRUFNwODBFYXdu?=
 =?utf-8?B?YlVJazdDcktlRDN3M0EyVUl2OEFhUkJET0dQcUVHbm1FOUZBY2t1L3R5V1lO?=
 =?utf-8?B?WHB5WHpMN1FMK1lGeFVYdkV4cUo1bXpQTDQ5K1NuNjlpZWMwOXYzaHo3M05l?=
 =?utf-8?B?d1dEbVY3SGpNT0tiZlhrZysrZGd3dUFFVXpjcTY0UW44ZjJEMCtML0JQc2Rv?=
 =?utf-8?B?WUhvanpTK2I3VzcrMTdoUUZkOGFNN1RtYXBnOTFOYlEzSDVUSXZoTWJVZW9j?=
 =?utf-8?B?cFYvWWI4akVIMWdqZ25oODQ5MVI5YjRMdmFVOG9qRUFLYUNBVEZVdm05L3pL?=
 =?utf-8?B?cGJxYTJheUxYbVpHSnZ6SFdsbStLdDNnU3lNT256MmMyZ1NjdkRHcDFpS2t0?=
 =?utf-8?B?NG9FVzlPN0F4cnFrWEwrM2ZHbVV5WTZvQjR0SmJKWUVRQWZTUGFHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NhfNwK8xtNuGYdWyJ1yO+2G0i/2Bq3OVE9TDNEBNdz2Zrm+mhp8uZ1saKkYpA9jlYfhcQNEx1g1Gxu7a5cJu/XO7h9zBEpnnxUjzLBqWkyvciPFg6wcVwy5bHjIR+UeXKe3tJCcdosVpOctnWG7+Hgxjk2ttKvhD9YLkfYow5CeZW/bf8B0I8iji2sqOpejW1/gnv14GCqhqKmSFQP8NfA1NuoV2YRzET6nBfphTEiPmdl+WCmJ+j8Mkg3WhWg0KA38Mbsz2gAVmddPpoB9uU/fkS9NOYppW3l87+hPCSqiwWuDKszUrho9stTSFSLiPUOiUFGrShZH0sMSvZNm4vw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2792017-67eb-4b94-bd1d-08de84c994ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:37:25.0172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQjLg5Xq8Eku6YTGSPu9UX2dQgGdHJvsPIeJZyiefZLG0uqhUWcCrnuAgAFUFnwY2ZErAr3IVXs1xgGBB2WPzI6085F0gl+KwQRBrhV57e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gYmFja2VuZHMvaW9t
bXVmZC5jOiByZXBvcnQgZXJyb3Igd2hlbiAvZGV2L2lvbW11IGlzDQo+bm90IGF2YWlsYWJsZQ0K
Pg0KPk9uIDMvMTgvMjYgMDg6MzYsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGJh
Y2tlbmRzL2lvbW11ZmQuYzogcmVwb3J0IGVycm9yIHdoZW4gL2Rldi9pb21tdSBpcw0KPm5vdA0K
Pj4+IGF2YWlsYWJsZQ0KPj4+DQo+Pj4gSW4gY2FzZSBjdXJyZW50IGtlcm5lbCBkb2VzIG5vdCBz
dXBwb3J0IC9kZXYvaW9tbXUsIHFlbXUgd2lsbCBwcm9iYWJseQ0KPj4+IGZhaWwgZmlyc3QgYmVj
YXVzZSAvc3lzL2J1cy9wY2kvZGV2aWNlcy8qL3ZmaW8tZGV2LyBpcyBub3QgcHJlc2VudCwNCj4+
PiBzaW5jZSBRRU1VIG9wZW5zIGl0IGJlZm9yZSAvZGV2L2lvbW11Lg0KPj4+DQo+Pj4gSW5zdGVh
ZCwgcmVwb3J0IGFuIGVycm9yIGRpcmVjdGx5IHdoZW4gaW5pdGlhbGl6aW5nIGlvbW11ZmQgb2Jq
ZWN0LCB0bw0KPj4+IGluZm9ybSB1c2VyIHRoYXQga2VybmVsIGRvZXMgbm90IHN1cHBvcnQgaXQs
IHdpdGggYSBoaW50IGFib3V0IG1pc3NpbmcNCj4+PiBDT05GSUdfSU9NTVVGRC4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4+PiAtLS0NCj4+PiBiYWNrZW5kcy9pb21tdWZkLmMgfCA1ICsrKysrDQo+Pj4gMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2JhY2tl
bmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+IGluZGV4IGFjZmFiOTA3YzAz
Li5jNGViM2RlMTMwNyAxMDA2NDQNCj4+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+PiAr
KysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+PiBAQCAtMzIsNiArMzIsMTEgQEAgc3RhdGljIHZv
aWQgaW9tbXVmZF9iYWNrZW5kX2luaXQoT2JqZWN0ICpvYmopDQo+Pj4gew0KPj4+ICAgICAgSU9N
TVVGREJhY2tlbmQgKmJlID0gSU9NTVVGRF9CQUNLRU5EKG9iaik7DQo+Pj4NCj4+PiArICAgIGlm
ICghZ19maWxlX3Rlc3QoIi9kZXYvaW9tbXUiLCBHX0ZJTEVfVEVTVF9FWElTVFMpKSB7DQo+Pj4g
KyAgICAgICAgZXJyb3Jfc2V0ZygmZXJyb3JfZmF0YWwsICIvZGV2L2lvbW11IGRvZXMgbm90IGV4
aXN0Ig0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiIChpcyB5b3VyIGtl
cm5lbCBjb25maWcgbWlzc2luZyBDT05GSUdfSU9NTVVGRD8pIik7DQo+Pg0KPj4gSWYgaG90IGFk
ZCBhbiBpb21tdWZkIG9iamVjdCB3aXRoIG9iamVjdF9hZGQgUU1QLCBtYXkgdGhpcyBraWxsIFFF
TVUNCj5pbnN0YW5jZT8NCj4NCj55ZXMuDQo+DQo+DQo+VW5mb3J0dW5hdGVseSwgYmFja2VuZHMg
YXJlIE9iamVjdHMuIFNvIHdlIGRvbid0IGhhdmUgYSByZWFsaXplDQo+aGFuZGxlciBhbmQgYSAn
RXJyb3IgKionIHBhcmFtZXRlciA6Lw0KDQpNYXliZSBkbyBpdCBpbiBpb21tdWZkX2JhY2tlbmRf
Y29tcGxldGUoKT8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

