Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFED9C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZWc-0006vk-Ki; Wed, 24 Jan 2024 04:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSZWa-0006vV-Nh
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:26:24 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSZWW-0003He-SZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706088381; x=1737624381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a19vPBQMJzd02fLOw2d4jK5myhK91KKNMhhyh6HBK1U=;
 b=KnmbyXfqtIBoFDixwho6GlUjP9hYS9OteNhDN5kHiMSq65LlWTJMXFf0
 AdkB30s3zJKaHVRF91xXaTSxqXGmp5bbDctAsjFxaFOgjHp9IOk21uDOE
 jrf070cP5AFvHi2OZWhNFsRx/85EorLyhtdY7Jr22mUmN1h5LOMAvLpFh
 bMNygKdrjLlHXi3fQp4LDHCqqsmB1OAf7d+SsbkJ3ewbn+Cr6jeD9+30+
 zCjnq+swe6+eWIo0WbgmJNy1wG6cwKNgxS2hmIcqn4rbxDXbKckvi/OMr
 Yv2eP4zXfjh//6TNHW8W9DXpjKUlnTC7j1Du08geeiZgEOWylecUt5umE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1635121"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1635121"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 01:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="34707229"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jan 2024 01:26:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 01:26:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 01:26:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 01:26:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 01:26:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgJOhopPQvijRT6elSds2INDQEKD5qaPBPVZRY1xXNrOm7XXULAdTdyJ1Hpx1k1OHh8yCeeEYy3L3EtccVdTC28ejSZTxLT/67MPgE08y0Bp8M40PtjqOZi0Y6qfOEEB3lpB/O9Jir6or4OHWwaifoWvCaq0aE12UNp9VsKgja+d93lONtr7O4DFHZVSyRx4CG//Poimj3mF1X0dWvoAxNTLLRfKKSVtx3oZ+PCSn6kLdRek7fDMra8QsXb0SVWJxYjJfO0y5wGlKM2qkIRIZOpZcE8XtsO1ow3fkyt0S4LQe0QoV7Oh7W4TjaAzlXUN7w+Ji0dDhauaWC4S4sCefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a19vPBQMJzd02fLOw2d4jK5myhK91KKNMhhyh6HBK1U=;
 b=Mxx1QWAnHcqXoVrms6sNX4zocaanbY6QH5nTgRanHb7Nw/MIwMMUruzd3EQcS6oDWwTX14j7tahi9bmjdteMM4OThwHjQXMEoBdXF4J04r1fcXcewcB15rFip4MeA0v+XTclriYB6yJjZyg33ObBYCRkRZLKREA8I2qIZ0oDP6UDEH6o+4acnAPjd28OS4EDLWzGG/mOObmDGK4FLJKn7Xs7SJGecQRVvoLq0PoZXlbfz5oB3YpU9VXVVR0+h2opJyhLG36jI0NytCetSJhCM8J4NkVrqt9oviYSbp0qylofXVhC5JW9kXAE8y+mSTCXE4E7v9X9nTxAxZI4vWOJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:26:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 09:26:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Topic: [PATCH rfcv1 4/6] vfio: initialize IOMMUFDDevice and pass to
 vIOMMU
Thread-Index: AQHaR5v0AZ3rmcpUu0e+6RYUwmKBmbDmHeSAgAEUL8CAADVlgIABTyrQ
Date: Wed, 24 Jan 2024 09:26:14 +0000
Message-ID: <SJ0PR11MB6744A59B00B625BD4CAF12D0927B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-5-zhenzhong.duan@intel.com>
 <852e8e08-1d82-49d4-a19c-36a6b256d662@redhat.com>
 <SJ0PR11MB67442926DAA9AD72F1B89CED92742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ef9e0483-b984-457f-b317-bff89241a4de@redhat.com>
In-Reply-To: <ef9e0483-b984-457f-b317-bff89241a4de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: fb74f88b-bc5e-437a-ed1c-08dc1cbe832f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CxmfJ2LCV0RpngicxCaIuvP3usVZyujI+TO9FIUtBcPGhShN4cFMM8LOEchEPROW6D/iTW/RAkgvAlH7B1yXwEIJCDuJ3+gWDLpyy0nDIrS9gkp9ahyycUQsErWH2SD11xo+Oyz+VnYnWeQ41OTMKCGmHXx4UUINyad86uqWqeTLrdCDuvGg4mA4U+XDkorxBEb3XB60luKB/JSF1pnHLpYRYYnmJDUhijAX2sWNNSlS005bBL+YDtMQXcKd7BCgm8IKmopQqPRugaWVSPAc+aQhBC8bFYJCQ14LTbaPCAElM0zj0FIueGKrrEVXzmsO0mayScDqKMRIAA9DzMxDW6GvEl8E5Kj42ggm1U60rvMC88Usfr0x7ZhUiDDTDkPb3Gj5kGQm6swL4aRR2qlYU6473d6AKY1aU+Ib8+khVcfQi/WUUXyY/7KFD/bsiuxyR16Cyu3rBcJOcBkwa9+cpFklb2n6iRWXNjkca010Gn0ztD2aj03K/idPYHN04OS/y+Nw5+JUjtSvgHx5ISIG2tU0dwKJyAPecN5w0D0dWNDPS7dGj0wP/xmdjbZrlpS3LVvrfW0NF94lhrfPOw/VklFDt3b8EISbmPkzio0jW9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(66899024)(83380400001)(33656002)(86362001)(82960400001)(38070700009)(122000001)(38100700002)(41300700001)(26005)(9686003)(6506007)(7696005)(2906002)(478600001)(53546011)(76116006)(66946007)(110136005)(316002)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(4326008)(8676002)(52536014)(7416002)(8936002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHhQNzh5eGZzcXpVU1dEaUs1UEo5Mk1pVE9zd2RIV25YR0djTVZwck1VS01V?=
 =?utf-8?B?QW1sYk04L3lOeUl4VnhSVHNzb3hmWENOSGZkemZ6cjZyTmNpZURDS05lME1G?=
 =?utf-8?B?eG5rZUphRFBmdXhkR2ZyUDI0RVpvZUJqV0RwYjFYaWNzMnBRcklMNXc2eGF6?=
 =?utf-8?B?U3NXdStnazczd0UvbzdnaXU0T0hPMFBwdUJlTG8yaHhMYmpHNkxUM3lPNUxJ?=
 =?utf-8?B?WkNCOEpWbFR4d0VnWG1YeHJveWNDUlA4ZzdsOS94d3kxeWpicC9FaEFMUHVD?=
 =?utf-8?B?Wk9MQ29lWHdLYnpRUUJEQlRJdllDanIzdmxCOFA5S0tKb0FFVWprNWxtZ28w?=
 =?utf-8?B?SkxsOUppaVdEVlMwUzlBdnJ1MlpBdHd3Y1phbFg2aFNBVnYydFRGcVY4VE5Y?=
 =?utf-8?B?Uk1jaWg2c0F2NVcxVHlWaTAwOHdOL1ROV2JMQTNDTVJKUHpvbFcxckROTS9K?=
 =?utf-8?B?YnFhM2NZdGViTnFlVFlTOHV5MUdMK0hYc1FwU0lrdjVEd1BYM2Q0cytGR3V5?=
 =?utf-8?B?ZXZPT2Y3dGpBM0xvMHF0Zy8zYmxyOUlSeGZjTE1UdUg4d2ZWVllxQkdWUFZE?=
 =?utf-8?B?N2x0eVN0cExqZEcyMWN2Wm00Q0ZEVjlmaHlNSlRTWjUyVHduNVZRb0orcVhY?=
 =?utf-8?B?amczcHBOOVJHK3R4N1Fxbk5ETm90UTNVWTV1d21pQ0lrRXRUcGxlejdNS3k0?=
 =?utf-8?B?aFBhdVAvU2JjWkFrNzI3Yk4vd0dCeXlDYksvZ3NrRDlRT0VsMjNmeUIvUndI?=
 =?utf-8?B?YVpBWSsrMFNvZVZFb1FVVkJTaDA0TThYMWJYWGV2TmV1SEQxWE9ST3lGWFFS?=
 =?utf-8?B?bHMxUTJ6Um1zNnNnUi94Q29CUnkzVVg0UHFRVUh2REk0eE1FVDFHT0V1N1dt?=
 =?utf-8?B?UzhTelhyV2UxTERrYTh2VStrMngzamdndzFuSXZ4ZDlzYi9tdkRpY0xJTGdY?=
 =?utf-8?B?dEE5cUV6QUxnUGY1MlFDVzc1V1h1SFN2MzVnTlhybGJXOHhmUEs0aCtCaVpU?=
 =?utf-8?B?STdIZjN2WHczSGlSL3M4RXNEZ0FwZHZIZE5BR3hTZlNjSUt6UHFzR2pTOE1C?=
 =?utf-8?B?VzhBUzhiTVZWNlJKUDhnSVhTMVJhYW9nZm1jeC9hZFMyYnhmUFR2di82aUF5?=
 =?utf-8?B?MzZtazdpR2tTWU0zbVpFUkZLTGtOdmk0VDdmT3E2dktVa1R6Wm1UdzA0a0Z0?=
 =?utf-8?B?d2IwR2dpVlp0ZmowRDluemo0L0RSQTNLcXpqczY5UHM2M3NMSHhlZVJJVHZD?=
 =?utf-8?B?dVE5VHBSQkN0NkFLbGxlQ0xxUFNnZUEzWFVIS0hGdkVlOUZQYTc4UEszakdh?=
 =?utf-8?B?NHZHOEVDRmF3ZmViZ1pXY1ZLQ2xkRTVrRndKWlFLMmQyYWZ0V0E0QzU2MnQ4?=
 =?utf-8?B?bnZFYzc3cDA5RkgrNzZRSnBEd3Z6QXZzenhiem9QWmN0QTE4ZzNWSm5zandC?=
 =?utf-8?B?ZjNaMFBiN1N1Nys5dkpHMzNmTDBrWm9VZEd1eGpyNDRRQ2syQlRtemIwVVIy?=
 =?utf-8?B?VUlYRVFLdjBVWmtwelVMemlaSXpoc0NjY3RtcVdhVm9XMnNNZktTeERhSFNz?=
 =?utf-8?B?NlE1bTVvREFtYytvV0NRNHp5MTB2c0VaUXl4dWlISi9ET0t5ZUZKVW5weks0?=
 =?utf-8?B?NlJjVVdCdjhjOUxXRi9KdlRORzlTc0F0ZUJoNU9DY1gzcUpKd05odGMxdnQz?=
 =?utf-8?B?cmZ4THFDMTN5NWkrUk5WWndzOHlnb2k0enJOVmxuWFRwZjkwai9lb1loWWVh?=
 =?utf-8?B?WWNpQ0IrV1IxSWpvVzVTamZPLzMrODN2QWdRYXAwVzZHUFNYR2dZSC9NSFRY?=
 =?utf-8?B?Wk51REYyTk9wRE56Q2lTM1lic3daNHZheUlMMENxNGxQVUpBYmRWRzVEcGtJ?=
 =?utf-8?B?bSt1QzYwZHhvcENSSjkzVjA5TU9WWE91ckdoQXNFZ3Y0U0JZMXovSzN6S21C?=
 =?utf-8?B?SjhwYWN2YlVVSHNBcktjVlRzVVErR25KTzd0M3lBanFONFY5RkZPMGFtdjFt?=
 =?utf-8?B?V3pLL0ZHWmpWM3I3Z3lxSzFqNVNiSjVjVnRmVkZ5SDdiN2xuVG0ycGI0RjZC?=
 =?utf-8?B?L2NwNXhMeWpXOTlJUVpLaUl4NFFwbXV2QnJ4NkcxeEVsZmhjcWVsWWNFQUNn?=
 =?utf-8?Q?3sK5piK8fdzLqH9rwwgYZYSX6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb74f88b-bc5e-437a-ed1c-08dc1cbe832f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 09:26:14.9448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNZBCd/TzOdJMd0asppYjNOJm779r/7exfbhy2pSWJx1IoOtC5k95I67LY7JtoSn0lFKPJ7Y3BsrNtFI6s7u6OZUxVhRXwGxzI0S1+VaDIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDQvNl0gdmZpbzog
aW5pdGlhbGl6ZSBJT01NVUZERGV2aWNlIGFuZCBwYXNzIHRvDQo+dklPTU1VDQo+DQo+T24gMS8y
My8yNCAxMDo0NiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCByZmN2MSA0LzZdIHZmaW86IGluaXRpYWxp
emUgSU9NTVVGRERldmljZSBhbmQgcGFzcw0KPnRvDQo+Pj4gdklPTU1VDQo+Pj4NCj4+PiBPbiAx
LzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSW5pdGlhbGl6ZSBJT01N
VUZERGV2aWNlIGluIHZmaW8gYW5kIHBhc3MgdG8gdklPTU1VLCBzbyB0aGF0IHZJT01NVQ0KPj4+
PiBjb3VsZCBnZXQgaHcgSU9NTVUgaW5mb3JtYXRpb24uDQo+Pj4+DQo+Pj4+IEluIFZGSU8gbGVn
YWN5IGJhY2tlbmQgbW9kZSwgd2Ugc3RpbGwgcGFzcyBhIE5VTEwgSU9NTVVGRERldmljZSB0bw0K
Pj4+IHZJT01NVSwNCj4+Pj4gaW4gY2FzZSB2SU9NTVUgbmVlZHMgc29tZSBwcm9jZXNzaW5nIGZv
ciBWRklPIGxlZ2FjeSBiYWNrZW5kIG1vZGUuDQo+Pj4+DQo+Pj4+IE9yaWdpbmFsbHktYnk6IFlp
IExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENo
ZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWku
eS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tY29tbW9uLmggfCAgMiArKw0KPj4+PiAgICBody92ZmlvL2lvbW11ZmQuYyAg
ICAgICAgICAgICB8ICAyICsrDQo+Pj4+ICAgIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAg
IHwgMjQgKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwg
MjMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+
Pj4gY29tbW9uLmgNCj4+Pj4gaW5kZXggOWI3ZWY3ZDAyYi4uZmRlMGQwY2E2MCAxMDA2NDQNCj4+
Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4gKysrIGIvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+Pj4gQEAgLTMxLDYgKzMxLDcgQEANCj4+Pj4gICAg
I2VuZGlmDQo+Pj4+ICAgICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+Pj4+ICAgICNpbmNs
dWRlICJody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCINCj4+Pj4gKyNpbmNsdWRlICJzeXNl
bXUvaW9tbXVmZF9kZXZpY2UuaCINCj4+Pj4NCj4+Pj4gICAgI2RlZmluZSBWRklPX01TR19QUkVG
SVggInZmaW8gJXM6ICINCj4+Pj4NCj4+Pj4gQEAgLTEyNiw2ICsxMjcsNyBAQCB0eXBlZGVmIHN0
cnVjdCBWRklPRGV2aWNlIHsNCj4+Pj4gICAgICAgIGJvb2wgZGlydHlfdHJhY2tpbmc7DQo+Pj4+
ICAgICAgICBpbnQgZGV2aWQ7DQo+Pj4+ICAgICAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsN
Cj4+Pj4gKyAgICBJT01NVUZERGV2aWNlIGlkZXY7DQo+Pj4+ICAgIH0gVkZJT0RldmljZTsNCj4+
Pj4NCj4+Pj4gICAgc3RydWN0IFZGSU9EZXZpY2VPcHMgew0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcv
dmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+PiBpbmRleCA5YmZkZGMxMzYw
Li5jYmQwMzVmMTQ4IDEwMDY0NA0KPj4+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4+PiAr
KysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+PiBAQCAtMzA5LDYgKzMwOSw3IEBAIHN0YXRpYyBp
bnQgaW9tbXVmZF9jZGV2X2F0dGFjaChjb25zdCBjaGFyDQo+Km5hbWUsDQo+Pj4gVkZJT0Rldmlj
ZSAqdmJhc2VkZXYsDQo+Pj4+ICAgICAgICBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcjsN
Cj4+Pj4gICAgICAgIFZGSU9JT01NVUZEQ29udGFpbmVyICpjb250YWluZXI7DQo+Pj4+ICAgICAg
ICBWRklPQWRkcmVzc1NwYWNlICpzcGFjZTsNCj4+Pj4gKyAgICBJT01NVUZERGV2aWNlICppZGV2
ID0gJnZiYXNlZGV2LT5pZGV2Ow0KPj4+PiAgICAgICAgc3RydWN0IHZmaW9fZGV2aWNlX2luZm8g
ZGV2X2luZm8gPSB7IC5hcmdzeiA9IHNpemVvZihkZXZfaW5mbykgfTsNCj4+Pj4gICAgICAgIGlu
dCByZXQsIGRldmZkOw0KPj4+PiAgICAgICAgdWludDMyX3QgaW9hc19pZDsNCj4+Pj4gQEAgLTQy
OCw2ICs0MjksNyBAQCBmb3VuZF9jb250YWluZXI6DQo+Pj4+ICAgICAgICBRTElTVF9JTlNFUlRf
SEVBRCgmYmNvbnRhaW5lci0+ZGV2aWNlX2xpc3QsIHZiYXNlZGV2LA0KPj4+IGNvbnRhaW5lcl9u
ZXh0KTsNCj4+Pj4gICAgICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZ2ZmlvX2RldmljZV9saXN0LCB2
YmFzZWRldiwgZ2xvYmFsX25leHQpOw0KPj4+Pg0KPj4+PiArICAgIGlvbW11ZmRfZGV2aWNlX2lu
aXQoaWRldiwgc2l6ZW9mKCppZGV2KSwgY29udGFpbmVyLT5iZSwgdmJhc2VkZXYtDQo+Pj4+IGRl
dmlkKTsNCj4+Pj4gICAgICAgIHRyYWNlX2lvbW11ZmRfY2Rldl9kZXZpY2VfaW5mbyh2YmFzZWRl
di0+bmFtZSwgZGV2ZmQsDQo+dmJhc2VkZXYtDQo+Pj4+IG51bV9pcnFzLA0KPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5udW1fcmVnaW9ucywgdmJh
c2VkZXYtPmZsYWdzKTsNCj4+Pj4gICAgICAgIHJldHVybiAwOw0KPj4+PiBkaWZmIC0tZ2l0IGEv
aHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMNCj4+Pj4gaW5kZXggZDdmZTA2NzE1Yy4uMmMz
YTVkMjY3YiAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZpby9wY2kuYw0KPj4+PiArKysgYi9ody92
ZmlvL3BjaS5jDQo+Pj4+IEBAIC0zMTA3LDExICszMTA3LDIxIEBAIHN0YXRpYyB2b2lkIHZmaW9f
cmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsDQo+Pj4gRXJyb3IgKiplcnJwKQ0KPj4+Pg0KPj4+PiAg
ICAgICAgdmZpb19iYXJzX3JlZ2lzdGVyKHZkZXYpOw0KPj4+Pg0KPj4+PiAtICAgIHJldCA9IHZm
aW9fYWRkX2NhcGFiaWxpdGllcyh2ZGV2LCBlcnJwKTsNCj4+Pj4gKyAgICBpZiAodmJhc2VkZXYt
PmlvbW11ZmQpIHsNCj4+Pj4gKyAgICAgICAgcmV0ID0gcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2
aWNlKHBkZXYsICZ2YmFzZWRldi0+aWRldiwgZXJycCk7DQo+Pj4+ICsgICAgfSBlbHNlIHsNCj4+
Pj4gKyAgICAgICAgcmV0ID0gcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKHBkZXYsIDAsIGVy
cnApOw0KPj4+DQo+Pj4NCj4+PiBBRkFJQ1QsIHBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZSgp
IHdpdGggYSBOVUxMIElPTU1VRkREZXZpY2UNCj53aWxsDQo+Pj4gZG8NCj4+PiBub3RoaW5nLiBX
aHkgY2FsbCBpdCA/DQo+Pg0KPj4gV2Ugd2lsbCBkbyBzb21ldGhpbmcgaW4gbmVzdGluZyBzZXJp
ZXMsIHNlZQ0KPmh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXQvN2YwYmI1
OTU3NWJiNWNmMzg2MThhZTk1MA0KPmY2OGE4NjYxNjc2ZTg4MQ0KPg0KPm9rLCB0aGF0J3Mgbm90
IG11Y2guIGlkZXYgaXMgdXNlZCBhcyBhIGNhcGFiaWxpdHkgYm9vbCBhbmQgbGF0ZXIgb24NCj50
byBwYXNzIHRoZSAvZGV2L2lvbW11IGZkLiAgV2UgZG9uJ3QgbmVlZCB0byBzdXBwb3J0IHRoZSBs
ZWdhY3kgbW9kZSA/DQoNCkl0J3MgYmV0dGVyIHRvIGhhdmUgZm9yIGxlZ2FjeSBtb2RlLiBFc3Bl
Y2lhbGx5IHdoZW4gd2Ugc3VwcG9ydCBhZGRyZXNzDQp3aWR0aCA1NyB0byBRRU1VIEludGVsX2lv
bW11IGluIGZ1dHVyZS4NCg0KPg0KPj4gQW5vdGhlciBjaG9pY2UgaXMgdG8gY2FsbCBwY2lfZGV2
aWNlX3NldF9pb21tdV9kZXZpY2UoKSBubyBtYXR0ZXIgd2hpY2gNCj5iYWNrZW5kDQo+PiBpcyB1
c2VkIGFuZCBjaGVjayBpZGV2LT5pb21tdWZkIGluIHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZSgp
LiBJcyB0aGlzDQo+YmV0dGVyDQo+PiBmb3IgeW91Pw0KPg0KPnllcy4gU2hvdWxkIGJlIGZpbmUu
IFRoZXJlIGlzIG1vcmUgdG8gaXQgdGhvdWdoLg0KPg0KPklJVUMsIHdoYXQgd2lsbCBkZXRlcm1p
bmUgbW9zdCBvZiB0aGUgcmVxdWlyZW1lbnRzLCBpcyB0aGUgbGVnYWN5DQo+bW9kZS4gV2UgYWxz
byBuZWVkIHRoZSBob3N0IGlvbW11IGluZm8gaW4gdGhhdCBjYXNlLiBBcyBzYWlkIEVyaWMsDQo+
aWRlYWxseSwgd2Ugc2hvdWxkIGludHJvZHVjZSBhIGNvbW1vbiBhYnN0cmFjdCAiaG9zdC1pb21t
dS1pbmZvIiBzdHJ1Y3QNCj5hbmQgc3ViIHN0cnVjdHMgYXNzb2NpYXRlZCB3aXRoIHRoZSBpb21t
dSBiYWNrZW5kcyAoaW9tbXVmZCArIGxlZ2FjeSkNCj53aGljaCB3b3VsZCBiZSBhbGxvY2F0ZWQg
YWNjb3JkaW5nbHkuDQoNCkkgc2VlLCBJJ2xsIG1ha2UgYSByZmN2MiBhcyB5b3UgYW5kIEVyaWMg
c3VnZ2VzdGVkIGFuZCBkaXNjdXNzIGZ1cnRoZXINCndpdGggRXJpYyB3aGF0IGVsZW1lbnRzIGhl
IG5lZWRzIGluIGxlZ2FjeSBzdWIgc3RydWN0cy4NCg0KPg0KPlNvLCBJT01NVUZERGV2aWNlIHVz
YWdlIHNob3VsZCBiZSBsaW1pdGVkIHRvIHRoZSBpb21tdWZkIGZpbGVzLiBBbGwgUENJDQo+Zmls
ZXMgc2hvdWxkIHVzZSB0aGUgY29tbW9uIGFic3RyYWN0IHR5cGUuIFdlIHNob3VsZCBkZWZpbmUg
dGhlc2UgZGF0YQ0KPnN0cnVjdHVyZXMgZmlyc3QuIFRoZXkgY291bGQgYmUgc2ltcGxlIEMgc3Ry
dWN0IGZvciBub3cuIFdlIHdpbGwgc2VlIGlmDQo+UU9NIGFwcGxpZXMgYWZ0ZXIuDQoNCkdvdCBp
dC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

