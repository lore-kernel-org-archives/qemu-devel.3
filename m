Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93096C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW86a-00015i-Hk; Tue, 23 Jul 2024 01:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW86W-00014v-RF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:30:29 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW86S-0000zB-VP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721712625; x=1753248625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gJa1K/573Y9uZss3jqkzueZGH4JEFGVaJEd+eXbcMfU=;
 b=WYFwP+ytCiFtI5j2fxAo2jFk/R9Dt5djQUjJhgJOuvRqqsfqCePDKI22
 ezb7XKN4yFdMPL8oOctoYwjSHFG4qeUecUA2rkq1V6Mitg3h2/ZJr0QR0
 WiWLUgQQoFHzzbCG0IbKjSVfzeBFtCn4q+j7iz+mo20PfuEAFggx7h6oT
 vgZaTQPFp5A25IjpwNCVhE5KvmfGhk+ZMvf6awunehOuL37dG3RQjZojF
 f6CmXHPKvMam323Lw9CtWY/X9Ux2dDySBn4vebOim0eaQq74mxnNqPa5t
 OWdIsTApRg9Sg2WXvCyas3zT3ipWs9tIj+zLTx33pAHlQttOgZuHFRW2w A==;
X-CSE-ConnectionGUID: lvpJteTnTw2ANMB3x1yx1A==
X-CSE-MsgGUID: WK9tKyFDTlGSVMDsUqxs9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30738008"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="30738008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:30:17 -0700
X-CSE-ConnectionGUID: sdELOkpaSyq45ZPy5Jhxlw==
X-CSE-MsgGUID: LiQBJEOIQAySqET15MM4AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="89575301"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 22:30:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:30:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 22:30:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 22:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEB4BpWSYz8iYtkd8mON8T4I2Ah6J7ZWH+uVGuz0dus/8bjw7jHE7cM6m1PfuZNETNki0FIwY0Qv72moPS/y/3AogIOb0JjTaZIRLBiHBNGXB8ko1GvPN54Xkx1IMf2o9nda0G/p7G8n6+uXgooK8kiIEubzBSB1ATe+spSb9+uozy5pVkOKkJbBk2J4hMFCqxDKyhmWNKUdYT4nPCNqAXFGCVqC+mpFvHL0n9rLiR8NiG0kLeyk4XpCKJrCpSTyoBN9lnc8PMVrXnpnWYpufbOHADhYyQf+HJe+EHz93SO0mEeG7CJPAglfz55elOtW7oQUF3okty2TqvOVADnDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJa1K/573Y9uZss3jqkzueZGH4JEFGVaJEd+eXbcMfU=;
 b=pafv+Yi97qHJxVUIYbYQvjPixJ0md1Jvgd+qDn9r1ZZ0aCGgH+ZR9DcqV2HllWJSAo4TpUK48klalIVRxL/45qnFepAPOH65GwvZfhXu8qpagtVSmWZVbHzJGw/uhycSe66ghd1OkSIAsHh7JYajPmZDSACO9RfK1WSw7XmYaVQYJRvPknC9OYAX012WYsTRYPOhLp3cMF61RFeETA8Nd5Fgn7KLKaeZb7tHnIGB1BfecmOARDzd5TGJKe0AqOGXnGt/qUXKNkl2792h8mSi+5pMX1cbAcPieCTY8SL2NhOp8HIyauhZDhBaFpvW8fesU0jBXqpAPtidZkIkau0cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 05:30:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 05:30:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
Thread-Topic: [PATCH v5 06/13] vfio/{iommufd,container}: Remove caps::aw_bits
Thread-Index: AQHa2dS7Fp1HjhqdO06UX6xS/3uiLLICOU3QgAA8SQCAAVesUA==
Date: Tue, 23 Jul 2024 05:30:13 +0000
Message-ID: <SJ0PR11MB6744794EDDA407CA3AF2930C92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-7-joao.m.martins@oracle.com>
 <SJ0PR11MB67448715600DF6E75BF9315292A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <3a6ca7d1-8ce1-488d-a3ca-64aa81870c8b@oracle.com>
In-Reply-To: <3a6ca7d1-8ce1-488d-a3ca-64aa81870c8b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5151:EE_
x-ms-office365-filtering-correlation-id: e33d2b61-732d-4e09-fc63-08dcaad886e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aU1VL1RFdjl3STFqbVNuRXRJVmltcHo1NFNra2hWK2UzZkQ1WFRaRHhlNjdl?=
 =?utf-8?B?OHFUb2l0ZS9aQlAzdm9mQkxQbGVMeSthNDArMDZYWXR0Nm5GYWY0Z3RkdG4y?=
 =?utf-8?B?ODlQMEl1dFhvVkl4TlNYcDlVMnBLQzZuZ1FCWE85cjY1eE93b1lYa3RFRktO?=
 =?utf-8?B?L3plMEpxYU0xZmV2R2R3S2N6Y0IzNm5pQVVJY1N6Q1Z1NTNiaEI1QlR3N2h5?=
 =?utf-8?B?TkJCMk9tdVUybjM4SExBbUlBbVBlSnJuRlJMVTB1L1U2ajJTUmgrTHhaV215?=
 =?utf-8?B?WlJneDFOL1Z3d2toaTFaYXFuZ01MSjdpTlk2Z2RWMGttdTJkb0RqekMyMUlY?=
 =?utf-8?B?TUtUZXU2MEtTUG5SRFhpOVV0ZDJDNnFVWmluZVNCdlNMWEpoRUM4ay9UdVVu?=
 =?utf-8?B?cGdrQWxJczNRVk4veVlHbTI1eHh0TW1BdCtoMENCTUdRemFCcy85QUJQc3Fn?=
 =?utf-8?B?MGpjQVRMM0djZWRMR09NL3F2b3FwL3ROQlZ5d3BuOVNtTlZDeWtxa2JseXdw?=
 =?utf-8?B?c2JXSlV2cnEvYkNOZzFvSFZVbHNVenlkR1gxczdNV3ZwZC9QVnUxM01SOTBs?=
 =?utf-8?B?QzgyNnB3ZUpBOFVBdDZUeExLUGwvZFFKSE8zTGZreXQwYzdrRXRvOHRmbGlt?=
 =?utf-8?B?RzJiV0F5RlVseGxONW5IZFNabDRSRVNVVXJjdncwZ054bVFlUkF2WGxYZndx?=
 =?utf-8?B?c3BUMjFySzd2TWxnTm42U1dVMWtMWGIycDdzdlREUU93RkdMcDNoYUxITCtR?=
 =?utf-8?B?d1UraWd4SjF4cFo2ZWduSTFJaTBXbENYRDd5N0N4dHRLZEh0Q3NMY0k2anUw?=
 =?utf-8?B?TklyYmtBdkt2VXRBTkwvMnU2N1dEakxzcnIwSC9CcGQ1eWpRZHNLL2wzRHph?=
 =?utf-8?B?dEEvRHlJMjFkc1dCR3J6T1ZTR083QjJsSkRLODVrVGMra25oQ2UzQVpieFdz?=
 =?utf-8?B?cUhNdEk1c1dLOFBtalFZaGNnVU1kaFZCTUFYdUNXeHY2S0tFdG5ON29mMnRv?=
 =?utf-8?B?L1VGa0paZFplMXFPNzNEaGRkUUk5YmdpaFRpWUtESlF2dU1JMjFQaEpoOTh2?=
 =?utf-8?B?WFdPczV1ZWVyandoSFNMLzAzY3g4ZUdrdGY1OEVLWDdUVzVWY2hGMDJMTEZm?=
 =?utf-8?B?M0NEd056V2ZhRE5CUHNJemhyZjh0bEZoZUZrYXJFaUtwcDdZM0lwMnoxUjZP?=
 =?utf-8?B?ck51Zng0ZHlkbkp1RmhzMEdsenhadXcvWi9MMVBxTnlFRmh1RVhnZndOa0h6?=
 =?utf-8?B?eW9HNzJVRnNoVHdqVCtmT0JHcTVvekpLUHdTSitwRVRpR3lKUVMrT2wrUlRL?=
 =?utf-8?B?eXRqNmlyK0wrZXJmWUFXZlRJanQvM0RvbHk1ZVVKVjJWcWhWNzc2ZG8yMVVP?=
 =?utf-8?B?MmFmZzh3ajRJSjBZTjI1OGhkanJPMHBtVHh4enVIZGUyZ2E3bVVBVWNTeVZS?=
 =?utf-8?B?R2ZZSHhETFpwU2U0QmFwR2JVbmczeDA5OE1OZm53b0Ntc09jaWRQRklDUVY1?=
 =?utf-8?B?T0FjRXV3b092USs1RmE4eTdrUmxZczVyZlczb0h6YWZ2RXA2TzZNTzBXdVRK?=
 =?utf-8?B?cFBQbWhhbnpmU0p4WndkMkM1cTdUYkNNSVNxaDBJbUtYa2E5VlVMa1BWRVJp?=
 =?utf-8?B?UnZuMnF2d2dsT2loT1ZoQlpCaG5rOWNZVS9nc0VHNTZ4cGxhcVR4SjZIYkZB?=
 =?utf-8?B?N20yeC9Na1pRbGdRK3Vjb2Rxc3A4ZXRiOHAzcEtYRUNBMUlJZ2ZTSjZveDFv?=
 =?utf-8?B?am82Z0xtd0RNYVJnS2xRY3VjK1V3Y2szaGNmQW9ydzRQUUdoUkRLelhKL1M5?=
 =?utf-8?B?dHNWZ3JOMExhdDF4RDZDRjJpQXJXeE1rQ1VXdkkxRU83Y1VhdGYwb2VNR3Bn?=
 =?utf-8?B?WENnL1d1enNlMGJDWGlyTXRsdHV1M2RicXZTQXpKYUtjOEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhFWW14RnNBdlcrZFZWVFdEQjd1ZHBJTjhBc2xPWktFMnVjUmN2SkxCcUhO?=
 =?utf-8?B?WE1md3BvajV1SDhRU2NYcGJFS3d4MUpaRGVMZ2lheFI5NEpYc3dLdUxkNWM3?=
 =?utf-8?B?Q0dWZ0JZL0pHYzNMQkgxZGJRRVdPWXdDVmJiemQ2aDkxUlRqYUtRcUxpK2tM?=
 =?utf-8?B?YWExd2ZjUFdQNmdpV2FHSUJZTlNSRGZRcEprYlZ5ZnFPK01mb1Bab0NkbjZI?=
 =?utf-8?B?c2R0MW5hSXZOTHdwbGR0YmxOUVdNL204SjJteUhZUytvYjY4TCtwZnJzVm1R?=
 =?utf-8?B?STZWMlZvR0QxK3Roc3JmSjhJbDhDMzdFcm5zOWtYUHRTYzFQOTdaOEpxT25F?=
 =?utf-8?B?T3dBS2dNbWYxRUdGaG5HVDd1d095RkFrSThtSjcvOFNHNkNQMFJrdzZqdjZx?=
 =?utf-8?B?RGV0a3g4SXZLUm1Pd0hiRkhSVzZ0RTFsV0N0MG5OUEVIcGNxNVY4SXFFU0ox?=
 =?utf-8?B?aTJzb1doTFNOb3VaOXFwVjFmOVVwS09JeFZrTzlzWkZjRDZDYks5Q2JOYmpJ?=
 =?utf-8?B?R0VadWJWMkFkZWQ5d0UrUDJoaHJWamdLMHVFTXdCdW50bklUQTFSc1pXeGJJ?=
 =?utf-8?B?ZjhoMVQvN0JZaFR4NUpWVys4SFhaZ3pZUlE2NC9KR0lIUFUrTlJGSXFzZTh6?=
 =?utf-8?B?RklIMlc5clRpV2lYaGQyV3UvelFXT2pGaGpKNS9IZG85bjhOZUdaY1pXRklF?=
 =?utf-8?B?S1BybWFFN2ZFb040WjdDTGJlb3YrTzN0MDVpbS9VRHBORHQwakhocEFsV2Uz?=
 =?utf-8?B?dnBiSVZ4d0wrbDEvWXlWaVM3c2s2S1hXb0xDQk9WeUxkKzUxUG5WUitMdTI1?=
 =?utf-8?B?bFk5SkQrVEZBTlJPWjNabGZ6THhZQTIyVXNHVzJWV05rSUd1OGJaWUR6UEV1?=
 =?utf-8?B?d2I2T2dtbXZoVnJpTzN2R3poMktYY0tpRGtFbzhiZUtWM3Z0cGNzWnlLMGVK?=
 =?utf-8?B?TXhPZTFzRmtJbFhaWlRPMmZWQmc5eXhBN0ViaHA3MWhMVmlyTFRBNUZmV3E3?=
 =?utf-8?B?YklZM3gzaWhpODdmRCtpVmNmZytMc0xmR1lQdWVyNmtkM09IVndyclBnRHlW?=
 =?utf-8?B?cW1yVG9wSHI3eFYrOWRMUnlYUE9pTFBWM2pvcmN4Zmg0RGZUaEw1YVNyUldX?=
 =?utf-8?B?SitDeTBIZUVRN3l4V09mL0lURGpaMG91ZFgrL1VBRVQ1L1VhN0gya2JNa1Fs?=
 =?utf-8?B?ajlBWlpZNlowOWpxV0llNS9tNUp6MGdTVjNBOFpUMzh0ZWFqaklVMWl5V1JV?=
 =?utf-8?B?enJiNU91ZmVocjhoalNqUnZ1QjU5OXlHaTdPZUFVNCtOZGdOaDlnUTJtOU1t?=
 =?utf-8?B?SW9HTWh0Q0lKRGp5M1ZEMkJjSzlBeVFZaW53Q2dvNmZ4THAxcWpsZzA2RXda?=
 =?utf-8?B?MHFXUm9yd1NKQWpZVjV0eHJuNWRZZUh6ZXJNNGs4SW1rY29TVTRKY2RiVUV1?=
 =?utf-8?B?dVdScFp2eEJhZmV2cTQ1L2RnRitsQlVnVEREVjdrUjZWVFNuMGhtREF1VHQz?=
 =?utf-8?B?NXhrWjJ2SURJWFh0OFA2VG5HdmxNa3lxNlljVmlOOGtkK2dNYnVaUFM4RVJL?=
 =?utf-8?B?YndRanQ3OUVmY0FEZEpnS3ljdS9MZDMzL1hpcVB1WklBZWRiM2QvWk5yRkx5?=
 =?utf-8?B?NTZ0Qm5nTWxmWldlakE0ZytpdWxhRlZQUUp2VUxuWXpNNzE3c3MwWUlKRzk1?=
 =?utf-8?B?Ky9kYThOejNyVmdSRG93T0NZaEQyY29nSEpmNEh1T3FiOUNRZnB1QzVjRi9W?=
 =?utf-8?B?dTVNMmRIQUw1ZDdmcytWa1d6THlwRnEwcGdLK3c0dE5DbDlPSVkrUllCZ1Fx?=
 =?utf-8?B?NWNmRlU5dEwzazJ5Q3pyRWlVNWVuYU9WWkpYZ1VIaTZwYU5tMFpUc0NRVURy?=
 =?utf-8?B?Y3RqTE1PcmhBUjcwbWFxMDkrOVVsbTFQNU9ONzYrQVFJWjI1bGFVeDM5NnQr?=
 =?utf-8?B?bDcwVXNXQUNzbDdwSzQzMUlTZFdaa09YUFA2REZ4WG5RbHBMR1JSNm1RM0VY?=
 =?utf-8?B?YkNWUDRRcjhnaklUVXNTV04zN2QvVG9oSk12QWI1ak9JMGMxcWNIUm5OKzFY?=
 =?utf-8?B?WkFHUzlyY2hMTWl1aUkwR280cDZXTGpzN2R6dGVQMFlMQ3laZk5ZdUZSWk1k?=
 =?utf-8?Q?z+osQDEFF/+tEkK65K6nIt5vK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33d2b61-732d-4e09-fc63-08dcaad886e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 05:30:13.2059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGBm95YoWByT/sUJPUpc2p+rXYlf6m8YP5WE6r5lCqmYk/5U60I7ZtxKj6pOJzjpLjxw9boblnXiYM/hW7KhdJkDHmJVc1orgLmLNGdVbTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDA2LzEzXSB2
ZmlvL3tpb21tdWZkLGNvbnRhaW5lcn06IFJlbW92ZQ0KPmNhcHM6OmF3X2JpdHMNCj4NCj5PbiAy
Mi8wNy8yMDI0IDA2OjIyLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEpvYW8gTWFydGlucyA8am9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjUgMDYvMTNdIHZmaW8ve2lv
bW11ZmQsY29udGFpbmVyfTogUmVtb3ZlDQo+Y2Fwczo6YXdfYml0cw0KPj4+DQo+Pj4gUmVtb3Zl
IGNhcHM6OmF3X2JpdHMgd2hpY2ggcmVxdWlyZXMgdGhlIGJjb250YWluZXI6OmlvdmFfcmFuZ2Vz
IGJlaW5nDQo+Pj4gaW5pdGlhbGl6ZWQgYWZ0ZXIgZGV2aWNlIGlzIGFjdHVhbGx5IGF0dGFjaGVk
LiBJbnN0ZWFkIGRlZmVyIHRoYXQgdG8NCj4+PiAuZ2V0X2NhcCgpIGFuZCBjYWxsIHZmaW9fZGV2
aWNlX2dldF9hd19iaXRzKCkgZGlyZWN0bHkuDQo+Pj4NCj4+PiBUaGlzIGlzIGluIHByZXBhcmF0
aW9uIGZvciBIb3N0SU9NTVVEZXZpY2U6OnJlYWxpemUoKSBiZWluZyBjYWxsZWQgZWFybHkNCj4+
PiBkdXJpbmcgYXR0YWNoX2RldmljZSgpLg0KPj4+DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpv
YW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBSZXZpZXdlZC1ieTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tDQo+Pj4gLS0tDQo+Pj4gaW5jbHVkZS9z
eXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCB8IDMgLS0tDQo+Pj4gYmFja2VuZHMvaW9tbXVmZC5j
ICAgICAgICAgICAgICAgICB8IDMgKystDQo+Pj4gaHcvdmZpby9jb250YWluZXIuYyAgICAgICAg
ICAgICAgICB8IDUgKy0tLS0NCj4+PiBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAg
IHwgMSAtDQo+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZp
Y2UuaA0KPj4+IGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4+IGluZGV4
IGVlNmM4MTNjOGIyMi4uY2RlZWNjZWM3NjcxIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvc3lz
ZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oDQo+Pj4gQEAgLTE5LDEyICsxOSw5IEBADQo+Pj4gICogc3RydWN0IEhvc3RJ
T01NVURldmljZUNhcHMgLSBEZWZpbmUgaG9zdCBJT01NVSBkZXZpY2UgY2FwYWJpbGl0aWVzLg0K
Pj4+ICAqDQo+Pj4gICogQHR5cGU6IGhvc3QgcGxhdGZvcm0gSU9NTVUgdHlwZS4NCj4+PiAtICoN
Cj4+PiAtICogQGF3X2JpdHM6IGhvc3QgSU9NTVUgYWRkcmVzcyB3aWR0aC4gMHhmZiBpZiBubyBs
aW1pdGF0aW9uLg0KPj4+ICAqLw0KPj4+IHR5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZUNh
cHMgew0KPj4+ICAgICB1aW50MzJfdCB0eXBlOw0KPj4+IC0gICAgdWludDhfdCBhd19iaXRzOw0K
Pj4+IH0gSG9zdElPTU1VRGV2aWNlQ2FwczsNCj4+Pg0KPj4+ICNkZWZpbmUgVFlQRV9IT1NUX0lP
TU1VX0RFVklDRSAiaG9zdC1pb21tdS1kZXZpY2UiDQo+Pj4gZGlmZiAtLWdpdCBhL2JhY2tlbmRz
L2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+IGluZGV4IGE5NGQzYjkwYzA1Yy4u
NTgwMzJlNTg4ZjQ5IDEwMDY0NA0KPj4+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+ICsr
KyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+IEBAIC0xOCw2ICsxOCw3IEBADQo+Pj4gI2luY2x1
ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+Pj4gI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5o
Ig0KPj4+ICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4+ICsjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNv
bW1vbi5oIg0KPj4+ICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4+PiAjaW5jbHVkZSA8bGludXgv
aW9tbXVmZC5oPg0KPj4+DQo+Pj4gQEAgLTI3MCw3ICsyNzEsNyBAQCBzdGF0aWMgaW50DQo+Pj4g
aGlvZF9pb21tdWZkX2dldF9jYXAoSG9zdElPTU1VRGV2aWNlICpoaW9kLCBpbnQgY2FwLCBFcnJv
ciAqKmVycnApDQo+Pj4gICAgIGNhc2UgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0lPTU1VX1RZUEU6
DQo+Pj4gICAgICAgICByZXR1cm4gY2Fwcy0+dHlwZTsNCj4+PiAgICAgY2FzZSBIT1NUX0lPTU1V
X0RFVklDRV9DQVBfQVdfQklUUzoNCj4+PiAtICAgICAgICByZXR1cm4gY2Fwcy0+YXdfYml0czsN
Cj4+PiArICAgICAgICByZXR1cm4gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHMoaGlvZC0+YWdlbnQp
Ow0KPj4NCj4+IEkganVzdCByZWFsaXplZCB0aGVyZSBpcyBhbiBvcGVuIGhlcmUuIGhpb2QtPmFn
ZW50IGlzIG5vdCBuZWNlc3NhcmlseSBWRklPDQo+ZGV2aWNlLCBjYW4gYmUgVkRQQSBkZXZpY2Uu
DQo+PiBNYXkgbmVlZCBhIGJpdCBtb3JlIHdvcmsgb24gdGhpcy4NCj4+DQo+DQo+QnJvYWRseSBz
cGVha2luZyBJIGFncmVlLCB0aGF0IHRoaXMgbmVlZHMgc29tZSBzb3J0IG9mIElPTU1VRGV2aWNl
DQo+c3RydWN0dXJlDQo+d2l0aCBhIGFnZW50IHR5cGUgdGhhdCBpdCBuZWVkcyB0byBhYnN0cmFj
dCBmcm9tIGluc3RlYWQgb2YgYW4gb3BhcXVlIG9iamVjdC4NCj4NCj5CdXQgZmVlbHMgdW5yZWxh
dGVkIHRvIHRoaXMgcGF0Y2ggZXhhY3RseSwgYXMgdGhlIGV4aXN0aW5nIGNvZGUgd2FzIGFscmVh
ZHkNCj5tYWtpbmcgYXNzdW1wdGlvbnMgdGhhdCA6Om9wYXF1ZSBpcyBhIFZGSU9EZXZpY2UuDQoN
CkN1cnJlbnRseSBvbmx5IFZGSU9EZXZpY2UgaXMgc3VwcG9ydGVkLCBzbyBoaW9kLT5hZ2VudCBj
YW4gb25seSBwb2ludHMgdG8gYSBWRklPRGV2aWNlLg0KSW4gZnV0dXJlLCB3aGVuIFZEUEEgaXMg
c3VwcG9ydGVkLCBoaW9kLT5hZ2VudCBjYW4gcG9pbnQgdG8gc29tZSBraW5kIG9mIFZEUEFEZXZp
Y2Ugc3RydWN0dXJlIGFmdGVyIDo6cmVhbGl6ZSgpIGluaXRpYWxpemUgaXQuDQoNCkJ1dCBJJ20g
b2sgdG8gbGVhdmUgaXQgdG8gVkRQQSB0byBmaXggdGhpcyBhcyBmb3Igbm93IGhpb2QtPmFnZW50
IG9ubHkgcG9pbnRzIHRvIFZGSU9EZXZpY2UuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4+
IFRoYW5rcw0KPj4gWmhlbnpob25nDQo+Pg0KPj4+ICAgICBkZWZhdWx0Og0KPj4+ICAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IHVuc3VwcG9ydGVkIGNhcGFiaWxpdHkgJXgiLCBoaW9kLT5u
YW1lLCBjYXApOw0KPj4+ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+Pj4gaW5kZXggODhl
ZGU5MTNkNmY3Li5jMjdmNDQ4YmEyNmUgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9jb250YWlu
ZXIuYw0KPj4+ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+PiBAQCAtMTE0NCw3ICsxMTQ0
LDYgQEAgc3RhdGljIGJvb2wNCj4+PiBoaW9kX2xlZ2FjeV92ZmlvX3JlYWxpemUoSG9zdElPTU1V
RGV2aWNlICpoaW9kLCB2b2lkICpvcGFxdWUsDQo+Pj4gICAgIFZGSU9EZXZpY2UgKnZkZXYgPSBv
cGFxdWU7DQo+Pj4NCj4+PiAgICAgaGlvZC0+bmFtZSA9IGdfc3RyZHVwKHZkZXYtPm5hbWUpOw0K
Pj4+IC0gICAgaGlvZC0+Y2Fwcy5hd19iaXRzID0gdmZpb19kZXZpY2VfZ2V0X2F3X2JpdHModmRl
dik7DQo+Pj4gICAgIGhpb2QtPmFnZW50ID0gb3BhcXVlOw0KPj4+DQo+Pj4gICAgIHJldHVybiB0
cnVlOw0KPj4+IEBAIC0xMTUzLDExICsxMTUyLDkgQEAgc3RhdGljIGJvb2wNCj4+PiBoaW9kX2xl
Z2FjeV92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lkICpvcGFxdWUsDQo+
Pj4gc3RhdGljIGludCBoaW9kX2xlZ2FjeV92ZmlvX2dldF9jYXAoSG9zdElPTU1VRGV2aWNlICpo
aW9kLCBpbnQgY2FwLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVy
cm9yICoqZXJycCkNCj4+PiB7DQo+Pj4gLSAgICBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0g
Jmhpb2QtPmNhcHM7DQo+Pj4gLQ0KPj4+ICAgICBzd2l0Y2ggKGNhcCkgew0KPj4+ICAgICBjYXNl
IEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTOg0KPj4+IC0gICAgICAgIHJldHVybiBjYXBz
LT5hd19iaXRzOw0KPj4+ICsgICAgICAgIHJldHVybiB2ZmlvX2RldmljZV9nZXRfYXdfYml0cyho
aW9kLT5hZ2VudCk7DQo+Pj4gICAgIGRlZmF1bHQ6DQo+Pj4gICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICIlczogdW5zdXBwb3J0ZWQgY2FwYWJpbGl0eSAleCIsIGhpb2QtPm5hbWUsIGNhcCk7DQo+
Pj4gICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9pb21t
dWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4+IGluZGV4IDU0NWY0YTQwNDEyNS4uMDI4NTMz
YmMzOWI5IDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gKysrIGIvaHcv
dmZpby9pb21tdWZkLmMNCj4+PiBAQCAtNzI0LDcgKzcyNCw2IEBAIHN0YXRpYyBib29sDQo+Pj4g
aGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKm9w
YXF1ZSwNCj4+Pg0KPj4+ICAgICBoaW9kLT5uYW1lID0gZ19zdHJkdXAodmRldi0+bmFtZSk7DQo+
Pj4gICAgIGNhcHMtPnR5cGUgPSB0eXBlOw0KPj4+IC0gICAgY2Fwcy0+YXdfYml0cyA9IHZmaW9f
ZGV2aWNlX2dldF9hd19iaXRzKHZkZXYpOw0KPj4+DQo+Pj4gICAgIHJldHVybiB0cnVlOw0KPj4+
IH0NCj4+PiAtLQ0KPj4+IDIuMTcuMg0KPj4NCg0K

