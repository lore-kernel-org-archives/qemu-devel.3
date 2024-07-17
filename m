Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B45C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 03:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTv0F-0000iN-QB; Tue, 16 Jul 2024 23:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTv0C-0000hF-LG; Tue, 16 Jul 2024 23:06:49 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTv08-0005Yr-P0; Tue, 16 Jul 2024 23:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721185605; x=1752721605;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vnzvdo1qvM2XdkuuaWXRwZKxFs9NJKzVivEBp04hPQI=;
 b=ekZYz01loIhCGB+G97QWXofsdCf1eu34O2ZoMrXD8ZHCf9uGYqmExIrt
 UlCjxIO/9aWebMEFNgpNLj1VyOP8n6k1WPWeR/en3AkYtscU+8JTzPPsM
 TqRpTQitXLtzjVQEeN5391BJ30jOFminQilrVvCxDBAj+/XCnLTCoyrvc
 g91sGThs/1gXJuVhrPnaYKQ8yCle1j+153rUsJBbeOr2ECEKyOJjg7XI5
 xklQ3l25oo0QYmmjH4BePyXG/cBQ84z8rwtpyCq+KdcGDpd9Bfw+zxmk5
 vH7Jozha8ZdbW61f+QaR7fE7kRdRACuzofGTyyLqndxWkJvUxvo8OY6tc w==;
X-CSE-ConnectionGUID: HV1tyQEfTCy2nFyFJj7N9A==
X-CSE-MsgGUID: uAZXNVa3RLGTeQ8Bn3uZVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18618308"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="18618308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 20:06:41 -0700
X-CSE-ConnectionGUID: EGjFzjS8T5y2u1XWROvBsA==
X-CSE-MsgGUID: iVXMXRzHRiy1Escp+KeIKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="54561936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 20:06:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 20:06:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 20:06:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 20:06:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 20:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFj+kczoN4ZzEfj2SGaa2CwFDL+zow9T712bmUKYHtwxu0aHzrKAjBM9T8LV0BsX4TioVOJJpptKucPxVnSPD8AT4TotxWk1jn970SZSFaOG3y3WChL4fjjPqjP1sf49OApS9ntAi/FeN9QH5sC1HFY9MpTNOlJ38W7HnFbKWX1bLJrpVkxE1lk8p6z8iIOwq/vUFfD/gsvIV5rGeqs6KPZi6sF0Sib1kqe+WTdjpQxSinqB8W+0Hrf1nJUKQyd1nlihJzOrnyMC62gEHMWrW1P7O3szZhtmK8096nxqz3NHkZg+98MAVHcQlw4xrw1FiYrrc+O6ZKLfOdTJftt1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDULMDVtTAePb+EUhrK4VjTEkk4VQYLquhQ2HGZzVqU=;
 b=jdC4TtVnRP5LdytNOCQqNq1+UB0ouKnv1E1g9Wd2ThPjvnyAGIlfbn8w4Utte0oMqBl8OGzG1nl4mKdCmzXgi0nYOZ6J3OjJXOPGF72rP8N5jJT3n3icBE7WZf+JUmMxFRNuVgLXJ0T7lxBJdla1+3XSOeJ5/GfNTelzh4JVhFUmmGIeX2CM8ytztQq5YCi7KjiVwcPmYRlgMG27MErFhppLRqZpdcTdytkhxbjbf0bXGVAG4uWXdTdqCLv4k4KyHAMcOGBKvZNuabrHSsNNuBdErmSX1Qa2E9aJwdjWJmc5yb/viId4gc+xqNJJcWcpBEz+sExtgJgqyN9cOQll9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 03:06:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 03:06:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
CC: "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Thread-Topic: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Thread-Index: AQHa12UbO4rn2UclD0a3Gm+CKXWFyLH6PYMQ
Date: Wed, 17 Jul 2024 03:06:35 +0000
Message-ID: <SJ0PR11MB6744D54C9B81BD1AD2BE5E1A92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-4-eric.auger@redhat.com>
In-Reply-To: <20240716094619.1713905-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8237:EE_
x-ms-office365-filtering-correlation-id: 2b7ec9d7-fd81-48e6-52ce-08dca60d77eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V5XETgTOYvIiF/o+ma9WDzQWG60U0DIvdoBtyKRYKiRJhLojHGSfelhcYRaW?=
 =?us-ascii?Q?/FVmTXh3mtdF11pkfnRRLn1oHOEV8+tWe3uIIsbVKhcZfHH2kDxwbeO5xadu?=
 =?us-ascii?Q?dVtwQrZBIvhVASzSqRzAaGE7YFWiWgLgl8g1CN9bfy73538EvgSmT41ydhKs?=
 =?us-ascii?Q?4N9Nu7EEVqeZjT9oUnLLQqffInl9WMg6ReQY3Q1r+W1qiv85U6UWZaD1VgEB?=
 =?us-ascii?Q?rKYbHXV32LfrAMD1MRZMjEY9eWYWhQ40fbv/hjDUvlkb3zPPDfGIneVNlJ0H?=
 =?us-ascii?Q?VvaQIeQAlyluPRJ6SGPQHGQmPyDaeE1VMq9XeSiwfiSUfUml4cjoxmX/vNOh?=
 =?us-ascii?Q?rJpaubjEvTlXFu+gkWNoiLkL/Yhyzd2P5BVUKNjfqeDlsBujbLPEnD6zl9Q4?=
 =?us-ascii?Q?OhtbOxyY2zkF0vXzdoKZk66mz29Kk7DopAruo+Be2TopgOz8bKYgbBNqo+kU?=
 =?us-ascii?Q?KnUuR3mPp0J9T88Ww+8QpigWnb5ELSz114TLlU1BH92tml2zZ813z3/l4wEs?=
 =?us-ascii?Q?0/H/2XwjjxBfzSDTEpQeVrvLyOcCa5qcMEhw9tV1ZLobXGR5+lhpSCVeROkr?=
 =?us-ascii?Q?9vI/OcOplGSEkm0MGJo6PJwfBfvTedcSZ/joL2TIP/P+AuIseK0GNjSfg8e1?=
 =?us-ascii?Q?2vLmLSvYXbG1y9LLol1wii8vm91FqjXbkwUa2mMsiOKzJele6sl1uQuIUAC1?=
 =?us-ascii?Q?da6g+6TjhxxvYKkZqwTQuhiksm1s2D0zDV2H8ojiRTqfyDHgm97T6yO7J5m3?=
 =?us-ascii?Q?c8QtYNO+JM/PdYBctVuL7j5A075bAqsXYDatm+doiVFcLAFrsjSu6ACmVVGq?=
 =?us-ascii?Q?nUIOM7kgaNxWECLZI+Uj7Wl6Eer97EJEMRIuMtqR/plFyBminuHPjxeAixdT?=
 =?us-ascii?Q?xzRu1ssTR94gd4Idpoj5Xb+1K6FWBl0wDSRTfX8KloULeF+xFzLKCDjsVwOq?=
 =?us-ascii?Q?DuBA2a4m96kFevDUfg68yebqPyD8AUw5GaKuWVN+0o3RJNH01EHTWmxwwHZx?=
 =?us-ascii?Q?GrPWQMGcHEQ9KOPhZbZg2ij3+MNp57+hEgEqUGJ7yjwOgMciPey/lXqXeTKK?=
 =?us-ascii?Q?M0mwUYgLRjW3962XruZdBaa8H0Ab6qnpMtZDUq4dKkXhnV2gOx/D0FNudqoo?=
 =?us-ascii?Q?skVK9lNjMl4Po/k34NY8WaEvKkK5+X/33L6Zm0ACW5sa0zZ0gpRsS+6ZD7Al?=
 =?us-ascii?Q?eUpMICGhsLe5RUI6dLIlOowqooC1IAPaTDgBmC2uFlZhvFmKUmIhize5XZDf?=
 =?us-ascii?Q?zrMrBg0XBcvsdgR1g1B4lcHBoz+aDeV6rE/cDEJIUsRMTWwGS41V+miIekok?=
 =?us-ascii?Q?Gu6G0SL++58x9tKFkSbBgfYlRHw+fvJwFsAs+f12EzYQASsffhoDFAEiHvdh?=
 =?us-ascii?Q?14MK1/i1PsjPPjSiI0FuMEuTh7pynCyLliaJYJy6/WViZXo4FcrBgfcm96HT?=
 =?us-ascii?Q?88ApmacjqFY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gp00qPlZXaEATxo/yB3/0bY5A8/vOlN3uYqw3dE6s0avXstouYA+4+AfHbY/?=
 =?us-ascii?Q?v3UoP29VCdjFasLcSv9Af+2YEhW4DiUltpf+7b50WdIUwPct1CqA3UycQA77?=
 =?us-ascii?Q?XSbnfNnK8EtDWsOEs3ddOB8DourHaCJs/bgE0ICo7l13AiUoWLUqwLcDXAX6?=
 =?us-ascii?Q?xtS9tw+HMfuOqctP+NCXM8LPGNM5GbAvcnAq1+lP1ghuZitgYRi+cbqfaVoM?=
 =?us-ascii?Q?tPmV2k/XmoDtgvPU97Bccq0/eKEgM3W+P4B83hTxEXGj6EBP8OMdG/e8+sy6?=
 =?us-ascii?Q?X0FmagYYIEzSExxdAcvuh00NnpGy5vfw8QToHHA36QJzV/GHFQjqmpmZvPIb?=
 =?us-ascii?Q?fx3ra+26CVVn/3yli8sx0kwptNtmAQ8wZQQNO9d4LOrXYGSp2l+A9X/HzeqK?=
 =?us-ascii?Q?aXf3YkRtZc3DF8QF4LrDcEmpFZplrHnVEKbUm5Ap7pOkr+Uz/QDjB9oIfZzK?=
 =?us-ascii?Q?GJ/Vsc/ctkCMiqayBvVvrn8S8FoeHngIH0XmrLGnT9SKV7CAivVFth2/XE1e?=
 =?us-ascii?Q?di4XcDGL95G/NQGCwSwAdjAmuLrgbrGKme0RdtzliRn/SxsOP513kRRW3jrI?=
 =?us-ascii?Q?WL3lFfZ3DrEp4UPPMcf6jArOqhODaeuDDVDPx6DXqCOAKjR3ktjKDJYSQutc?=
 =?us-ascii?Q?SaC8apMLhgJ5KNGsZ0Ltv8W4GfCK82SKOHBHKbPCALYKUZZKTekR/MdqVfEW?=
 =?us-ascii?Q?D9n/rOOZ42ICxeQCeP4+DPUiZAmGH+m0wXzljzC+PL0eg3lzoILqEKyAjGHZ?=
 =?us-ascii?Q?gbwlO+UcY4XuKmWIm/xjTIsxD1mZGiFCGQ7CwNW0KmdqXUKmuRgsKo4pEls/?=
 =?us-ascii?Q?QLrukr6rwJ2R4nAwhlh8ruTj0cx8T6EBtMrnacwk19jeSgT6JTuih9Rr7eX/?=
 =?us-ascii?Q?om/1KsdFoF/DWnwOklkIdKhEFfmRKkYFctDRxQrAAddPOipq9jd1wELyAYXD?=
 =?us-ascii?Q?gx4x1yNZsXpX2q4wCiCMP+3n2oZOA3Zwm8s0SNFa9JQlOogmXdDjhvbCOExN?=
 =?us-ascii?Q?AGdLsaw/G5gYTMLHa4ZXyLUbgZwK0okjq0qumXUjxUsxNkh2Ttbpo9ri8MgP?=
 =?us-ascii?Q?1STewhRiSnbGfEjeyCG892NvuNxVIOlC+Bdk7JTimen/KKyyLp5N6Ao2Abu8?=
 =?us-ascii?Q?ETH/6aGBtHXzeoY4t5MPU08CQQbqv1y6ilOK9EtSviAG7TsBXVe/Pq1ZYvtC?=
 =?us-ascii?Q?hqCDsGUYTlYiN1jfs5U6hJDeRTCUOhs4/k3JxHGBW+GwPnRkW0yS4zmahWeV?=
 =?us-ascii?Q?00s8kTXrzc2G0g2dDsHUJMlOeDqzMu48ccMb/Fafk9Iu6UnHu+MpjZUnjW0Q?=
 =?us-ascii?Q?UN7DETyjWGjwdWjRF7z1P/Z5eWuBOlVgxY9OLcFHNZGcjSeeuo3eQvs7PPc7?=
 =?us-ascii?Q?dgqY3qmJ6RE2UIfkNZiljvaj8lJxdGIrGjsQ99FK2Xq8hE+BrrTJjw8+LbHB?=
 =?us-ascii?Q?+oF0MQP47hAoNyZ6ACtnLfTX2X2fupidZ/RoGjnkfDc76FPZKmXLQMRm3VBg?=
 =?us-ascii?Q?Keu25KgEXchc7jNpUMVrTCsca68CC5BkP553xZuBOsQSSq4NlzmAcYKcmA7j?=
 =?us-ascii?Q?BrPHpUQ5gnulBz42ltUJg7W0egWOa8/Lq0/Q8oo2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7ec9d7-fd81-48e6-52ce-08dca60d77eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 03:06:35.6242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOtFFWD4/TPYY+pwAebd3PkQtqUpRx53LCg2jGu4YHQA6bSBGQRkwipPYCP2MQBalQmigIhRz6i/TE5RVtuQJ27mFHFagmOMPWHb5KeHpl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
>unset_iommu_devices
>
>We are currently missing the deallocation of the [host_]resv_regions
>in case of hot unplug. Also to make things more simple let's rule
>out the case where multiple HostIOMMUDevices would be aliased and
>attached to the same IOMMUDevice. This allows to remove the handling
>of conflicting Host reserved regions. Anyway this is not properly
>supported at guest kernel level. On hotunplug the reserved regions
>are reset to the ones set by virtio-iommu property.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/virtio-iommu.c | 62 ++++++++++++++++++----------------------
> 1 file changed, 28 insertions(+), 34 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 2c54c0d976..2de41ab412 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -538,8 +538,6 @@ static int
>virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
> {
>     IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
>     IOMMUDevice *sdev;
>-    GList *current_ranges;
>-    GList *l, *tmp, *new_ranges =3D NULL;
>     int ret =3D -EINVAL;
>
>     if (!sbus) {
>@@ -553,33 +551,10 @@ static int
>virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>         return ret;
>     }
>
>-    current_ranges =3D sdev->host_resv_ranges;
>-
>-    /* check that each new resv region is included in an existing one */
>     if (sdev->host_resv_ranges) {
>-        range_inverse_array(iova_ranges,
>-                            &new_ranges,
>-                            0, UINT64_MAX);
>-
>-        for (tmp =3D new_ranges; tmp; tmp =3D tmp->next) {
>-            Range *newr =3D (Range *)tmp->data;
>-            bool included =3D false;
>-
>-            for (l =3D current_ranges; l; l =3D l->next) {
>-                Range * r =3D (Range *)l->data;
>-
>-                if (range_contains_range(r, newr)) {
>-                    included =3D true;
>-                    break;
>-                }
>-            }
>-            if (!included) {
>-                goto error;
>-            }
>-        }
>-        /* all new reserved ranges are included in existing ones */
>-        ret =3D 0;
>-        goto out;
>+        error_setg(errp, "%s virtio-iommu does not support aliased BDF",
>+                   __func__);
>+        return ret;
>     }
>
>     range_inverse_array(iova_ranges,
>@@ -588,14 +563,31 @@ static int
>virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>     rebuild_resv_regions(sdev);
>
>     return 0;
>-error:
>-    error_setg(errp, "%s Conflicting host reserved ranges set!",
>-               __func__);
>-out:
>-    g_list_free_full(new_ranges, g_free);
>-    return ret;
> }
>
>+static void virtio_iommu_unset_host_iova_ranges(VirtIOIOMMU *s,
>PCIBus *bus,
>+                                                int devfn)
>+{
>+    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
>+    IOMMUDevice *sdev;
>+
>+    if (!sbus) {
>+        return;
>+    }
>+
>+    sdev =3D sbus->pbdev[devfn];
>+    if (!sdev) {
>+        return;
>+    }
>+
>+    g_list_free_full(g_steal_pointer(&sdev->host_resv_ranges), g_free);
>+    g_list_free_full(sdev->resv_regions, g_free);
>+    sdev->host_resv_ranges =3D NULL;
>+    sdev->resv_regions =3D NULL;
>+    add_prop_resv_regions(sdev);

Is this necessary? rebuild_resv_regions() will do that again.

Other than that, for the whole series,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+}
>+
>+
> static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t
>new_mask,
>                                  Error **errp)
> {
>@@ -704,6 +696,8 @@ virtio_iommu_unset_iommu_device(PCIBus *bus,
>void *opaque, int devfn)
>     if (!hiod) {
>         return;
>     }
>+    virtio_iommu_unset_host_iova_ranges(viommu, hiod->aliased_bus,
>+                                        hiod->aliased_devfn);
>
>     g_hash_table_remove(viommu->host_iommu_devices, &key);
> }
>--
>2.41.0


