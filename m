Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B55EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL8b-0005kf-G9; Mon, 03 Jun 2024 23:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL8W-0005kP-Cy
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:47:00 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL8U-0002nN-2j
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472818; x=1749008818;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IMRQFTL8LeMBQ58sc1mUvfgnv/cD8QTJ7W+rh+sHbg4=;
 b=hmpS+nRqZF5Up9H2D+O29rB9my7TDxuM0hdzpDVaLzUFaexuVkQuS5mE
 Z+URRi0oQb5U2S59Z3rIffSyqJvenEEeoNO8GsXtpdzZByMqZmdfrcEgn
 FSjJlTuDI5OHMy/WrUpAhTK06zZDs5ibZGbWcsA3L7o6OcI6qkX3Hc88O
 s5YAh9rA1SxPcUx//ujnveJapP2Y1Fa9HXOuHRxXeV38XRmIMDaauukFF
 /EG16KeE8FulATgAyTtvn5N/F9FzOWCcYof+b5nheSmaQXX+wpeDPTw0y
 oOMlMdIDLXRjOB4s8hmqa50uGRAceeSmhdlSQOt3TE94iPof5w5U0qLuZ w==;
X-CSE-ConnectionGUID: KBNGZSdrSCW1OrJiDKtfgg==
X-CSE-MsgGUID: 8QdZgVj3Sde9xtnmYzCDug==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13800152"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13800152"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:46:57 -0700
X-CSE-ConnectionGUID: +7rzF7Y7Q2qhbZuvcVDs/Q==
X-CSE-MsgGUID: O5rzKkQdSY23O6XLFGuLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="41549936"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:46:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:46:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:46:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:46:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxZDPEEMJMS0Pp8oXbl5me7ompC9zKMgr3i2UcMUpiualPcHx6TLSWejsaHb0EpanP/8Mpi0VU0TwyG68ibLTwSR0FrbixWPsjPju2c+orNZZG2/r408P7wpZK7+kgPXk6Zulo/e7fdpiXxF8+ylauXCfWaW/11bjtmgHWva4HkqSE5sz738tDN++6u29PzQQaj5zgNBU/BFALQnuZY3vCSeNChFzFc1mRXjWbUgR7RXOe+XfoVoQhXfHOhLH5GT6UGrQAgKZOL7TLyYUd0d3xWky+7VutYkoACMu6Ory7kpp0MlPA+V1Ly6K6B0sjuChF3k0qZDPyZcNz60kRjZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMRQFTL8LeMBQ58sc1mUvfgnv/cD8QTJ7W+rh+sHbg4=;
 b=ZSDz8xm3hPXbzTVCS+8U9cwG1G1oXOs/sYLlavHohl/i8nN9yQC9PcSENrUJel5wYe59e/aK137EIYtakeg7fcaTEcIdPeIL+u5+jz0Ic7aW9Ww7mrLc2TyDDU1uYZS4FdRXWpks1ONsaEmXCte1RFQl7tB1P7wco10i6sI5ZcNYYBJ6QvV2mW6ah8bG/KZSY3dfkDFLL2HBE97+SIVfSp5C1V5uvR7Q2hjygxFHjeK5Ule9zdIneA6Ly7YFjEIJYOutqygUGFOsQnUPe0GMq9+IODT6KVqI4royJNZL4oCeXp1gkSh5PN6vRgntLliRtK1g1BtMYVqMH372eBlT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 03:46:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:46:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "CLEMENT
 MATHIEU--DRIF" <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G10h8AgAANccCAACB7gIAA9/eg
Date: Tue, 4 Jun 2024 03:46:53 +0000
Message-ID: <SJ0PR11MB6744784726D2300A7E54B87892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <6cfdde68-a138-4ac3-ab3c-29f6a94a1045@eviden.com>
 <SJ0PR11MB6744E89A1A959BE312ECE5B592FF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f07bd445-f1f8-4395-baf4-ddcc847d428d@redhat.com>
In-Reply-To: <f07bd445-f1f8-4395-baf4-ddcc847d428d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6445:EE_
x-ms-office365-filtering-correlation-id: 2ae1f3c7-e17c-4a36-7a74-08dc8448f979
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?bkpxV1lvT2IyV0dBVWNjeHlQYTEvdlRzVUorYjlkK0lSU3BjQ3JnS1c0akw3?=
 =?utf-8?B?bDdNbXM2ditmZmhHQWo2WkJpOHZKOFU3MUZPZS9hUFZ4UDNtd0NPVHZacHB4?=
 =?utf-8?B?aVFqNDBzMC9PUEdaRmNleUoxME1NVnhpQUFUTVROQURNWTNyb3g4MmJoV1hn?=
 =?utf-8?B?RkhuWDJmVVhLUVdEblpxa3VZK1FiYkV4amZ2UTVrT3MvUXh2aFlUYjBFZ0Fw?=
 =?utf-8?B?VS9XQkJRY1JlOUl0MlFnSm9HaTZtNzRweEIzVkZIcTJ2bXVTNnJVU2JIQlcz?=
 =?utf-8?B?em92cGRUQ0Z4Y0thL1FNNEZ5M1VhWW55MC9Tb2F0djA0djhIVXhmYUY5Szk2?=
 =?utf-8?B?TG9kVnNxcnNTNXYrMkZ2cTRFQWxCODZEWTZuWHlUWEdzZTgrdWxESXdqNTc3?=
 =?utf-8?B?SDlCK3pjdUt6OWxMbTU0K0lDSWIvcWdLUHVBeUlCMUVGSWhlVWdOZjRBbFoz?=
 =?utf-8?B?QmpTMExrS2NGVmhzazREWWxIMk95OERPZTNMU1VuYm02YVhiT2NmS0M2a2pR?=
 =?utf-8?B?ajBoZDNKV3V0WHNxcHB6SWVudUw5VGRYZm1DNXdHeU9kWmxXRk8vYXgxdnE2?=
 =?utf-8?B?dEhJa2FCaGRVQVM5Y21rWjNTMkRCbVcrTXBlK3dreFNsc2kyT1ZlVXcvTWVV?=
 =?utf-8?B?Vit6dmhyL29TMkJyMlVmVG5YQjhUcy90ckYzVlV5b3lHQmhqbE1DdmxyTWhj?=
 =?utf-8?B?SkovWWJMa295VENCMllqVmgyMHE2VTZDZ1cwYWhlZDNXTHA1SzVEODdmalZS?=
 =?utf-8?B?dWhSRGFNZHd2NmpBTEdsckZxaFUrUHRKZzNmUEtHSGE4ZFNQUllJRlBHTStP?=
 =?utf-8?B?ZVhCVjNuVG85dVBid0VyZHAwcjVXNGIxODVwemNaM2tEZkwzZDQ1cWlKZ2pD?=
 =?utf-8?B?RWJMK2RKR2cvcC80VUwvQmRyODI1ZGtZQVN1aGprM3RCalpCaWp4UkdJK0xW?=
 =?utf-8?B?dkthSzNHN3NtOHB0REhsNnN4Z1ZSTERsRGErWEF0YVdhVFQwUWVRc3BWS0VE?=
 =?utf-8?B?V2pRbnl4NVJBQlE0S2FXRmJ5K0djVERYYmozM25rNVdCVHY0YXE4V2NVMjd6?=
 =?utf-8?B?cGVaTUN1MU9hd1hUSzdIR1Z0bzh4czFnSkxLREZycFZCalZ5NFkxRGZYdDFT?=
 =?utf-8?B?TzBzenZLMUJKdWtTaUxRTWtwVlpwUFBTQlQ1N3lmYnNpMmw4NDRKdk9KR1hO?=
 =?utf-8?B?YlNQR2E0VHRMZUtST2hSdExiTEhPWm53bzVvSmtZN3ZPRnNtRTJEY0tBNkhW?=
 =?utf-8?B?a3lwOXBtcEY1aFZiSk82MmpEVDI1MUVhbVFNUS9QVjArRGp3N2hvSG4zUFJy?=
 =?utf-8?B?MER3WnhWai9reXZPdlE2dEtydzNsZEVsRXR4cG8rcTNnbmF3d3ZJenVtNk53?=
 =?utf-8?B?eUoyc0RzdWxPcFVOaUlNdHI5Q3R0TDNRSlpIYjhoVllIS0ZzbEJCMUtDZUMr?=
 =?utf-8?B?N1BqS3cwRTVsTGpaQjlaQUlpNC8rQmdrVVR3bUk1M0RjdXovVlNvMjFCSCtm?=
 =?utf-8?B?QU1iUzhDdUhtUFlELzRCMW9IMWZWTTA1b0NLeUJhMHJJQytuVXh1MWpJS1Vz?=
 =?utf-8?B?Z0hFKzl2eGVjN2dpVjZXTkdoUzFudER0TGQvU0Myb2JlMUpHekdBY2dOajhW?=
 =?utf-8?B?UnZnd2FQaWxtU2xmRjlNd3N2L1diOHowZWlUdlZ3YzFGOWhhTXA2TXhGNTl2?=
 =?utf-8?B?VzREOFhaV3NHRGpJdFZjRFV2RDFMcjJkNXBUb0QrTHozaXRUa0ZMTDdlS0dV?=
 =?utf-8?B?TTJzd2dpUFIwTkpaV1ZhUzhMakZvTHVXdy9jZXovdVRoWkRWYWtzM21McWRa?=
 =?utf-8?Q?6XWvrGIBzmc+TL4KPz9X3jULBkMqzKgrUp4NY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW1teTFneDZmMVJhdkZLNW1iZlA1TFR1azFLeElUOUVPeU13ejNkK3dWLzdo?=
 =?utf-8?B?VGg2MUM4SnladGd1Zk9lUmpsZGR6aDl4c3BZcnZ3dGNOTUw5R29uTGR1MVhj?=
 =?utf-8?B?R2M4Uk9CSEszOHlJL3VJd1pObW9yU1NtdGlpMlQ2eVZSZ2FTMERydy8rSWMy?=
 =?utf-8?B?U3hzMDZQWVV5NFU2SDVKemhFb2xzazhFODFtV2V1YS9hTkFUWjB6UmY5TDYx?=
 =?utf-8?B?NlBtWWpva2Mzd3ZWWERubkMyYjVYUDRQRzdhdlVaOFZxNE5DdmlLYjNXc0ND?=
 =?utf-8?B?bGd5bGJHb3djcWNTNjhUbm9oS0ZGM2tUQXhMdWJFb1V1RFRzZ3BXWFNLR1l5?=
 =?utf-8?B?aUZvOHlsUStJV2IyVTFMb0paRG1NSGFWdGh2c2s2emhzVUdyajRPaEc2ZGk1?=
 =?utf-8?B?SFNraU9SWEYwWC8rVU4wck5XdHdkL2JTUmluTzZad1VPbjVrbzVzUUVtcWFR?=
 =?utf-8?B?QUJjNUpZaXIrc3dYcVdpMEc5SnJQL1AxQk1NaHpBWUlKTzU1ZllqMjVZdG9Z?=
 =?utf-8?B?OGZDVHUyMVpUSHk4aGpqYyt5d1dMK29FZUJ2eEhXbWU0WnZRTkVIdVBIa25s?=
 =?utf-8?B?Z3FvTWlzV2tSejBMd2pqdmdZQjRvZWFCV0diSFh6Y0NGZ1NJRkpIbGhzcXJS?=
 =?utf-8?B?WnRMVzFvTS8rNDlnRktxQnYvVjZxWDQ1ajRGZVQ5L1VwUkppOGlTYkpJWW5q?=
 =?utf-8?B?eWJMajZwUlo2MlJxYVlCeFVyUE0xZUNvVURUeTFzRktkeXRvenFHT2hNTnFj?=
 =?utf-8?B?aG03M2NmTnJOZ0ZuL3RZVExBQTNORzl2SUxtK1R3WTN6RHdycHhYaXRVL3Rj?=
 =?utf-8?B?dE1sSkxUditDMGhzOGg3V1RTYU9uQ1ZsUWQ4Zk1rcHAwem80bGZ0RUZPVUVi?=
 =?utf-8?B?blhTbllpTWV2MU81VjVkOG95NFNlWXhTbW5nbEhiVUE2bnU0ckM3V2RsQ2Fo?=
 =?utf-8?B?YzQvQ0hTdEhWazVFMHFtdlg1d3h6TUExQ0RxSGFYcFNaL081WVJMZEt1dmxv?=
 =?utf-8?B?VWFCc2E0SWI0NVRjVE05WXFJR21FdWNnSFpBazdqZzhsbWVXQWd1T2xNYU5k?=
 =?utf-8?B?eDZhWElkRTc3M0VMK3oyOWc5Q2Q1ZzlrWHJHTks5VnBheXZhd2pmQjVOaGZX?=
 =?utf-8?B?ZklLZ0dXUnhyTUllNFFrdEJobG9qQkdDODJadnozb2lITWNBYVlnV1dpZEEr?=
 =?utf-8?B?K3dTdG1wU3M4SHdHQkFBRlI5ZTFqUUtvQjVOK1ZVN05SSnl6Q01TRG5VRVBv?=
 =?utf-8?B?dXJaYTNxMUlTL0IyNEpuVlNSRWttcHpPQnM5MlpPWkpFT2wvMVVuNHRQTm1p?=
 =?utf-8?B?VXo4YTlVQXdiL2VRMVRHcXk2cGlLTldIN2NMbHE3NHJTNkEwdFh5cUpkVnFY?=
 =?utf-8?B?QVZNWElPWDVoZnhlaDJOV1NtYnBhOUxWVjA3WmNEUFRtb0xzQVdaVXMxeUFl?=
 =?utf-8?B?SUdCMWNNTllzV0ZUalVZTmNybElwSWVwL0M0dXd3V0tvMW5qUXBQT3FzMk5v?=
 =?utf-8?B?bENHejBJS0lhSVM5Wi9teXNpeVU0V0RLMStmLzgrRVJnZjRNSGJuOHJtZllN?=
 =?utf-8?B?WmRKSWhNYysvRERNYm1iUG16U21za3NRYU15b2RiL0tOMlR3TmhYdldNMEda?=
 =?utf-8?B?UzVjcm5KZWxBRzlTWUJOTktjN0JLMUtGNGU0eUU5WWM2VURTL05hbFBXYmdO?=
 =?utf-8?B?dk1jMnpqeC8xRXNKMGFCNWJPenhseVRYNE9BbTlrSjh6elJjUElzVEs1MUZl?=
 =?utf-8?B?cGFtYStCajhxek80VEd1R1lTS3pzcGtjMlR3dmpHVHMrV0VwaDZjNFBVVy9Z?=
 =?utf-8?B?Z25TdjlibmxXUDZZZnl0WUh6OFduMTV5TmZreTJTbWcrN2RLcEVVRDVwUEl2?=
 =?utf-8?B?bStUeXFBUUFMOVRmRFVCc2h2NmgzTURXVlV0QUx3czRmZDRJaFNYOVNoVDds?=
 =?utf-8?B?ZGNsVithaW94TE1HeXFhaUdMSkFIRlE1OGNLbEx6aGs1aXFnR1dEZDVteFQw?=
 =?utf-8?B?VDdBdlhMaU5TOVdKRHhleFJmMGIwUEVOKzdLSFNBL2VNc2FXWGRPZmV3UkQ0?=
 =?utf-8?B?eHJCUk4zK2ZrMzYzWG1YQWNpUit4bEtSbnErZmJNK1A3Z251ZnZUSVFRRjFY?=
 =?utf-8?Q?y5GTmjVZrHMs+OoyCkhw11imx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae1f3c7-e17c-4a36-7a74-08dc8448f979
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:46:53.7237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkfn2cUNS+iDDNdVS+XCcp5k5VZ96f8mThMkoBSqz3td62kqwMaKEftf/KIKQhKrmr7Q/449PbU7p8ZREK3/qR43+xtBm8lz/SCjHN3/Nbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE4LzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50DQo+W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzDQo+
DQo+T24gNi8zLzI0IDEzOjAyLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJ
RiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NiAxOC8xOV0gaW50ZWxfaW9tbXU6IEltcGxlbWVudA0KPj4+IFtzZXR8dW5zZXRdX2lv
bW11X2RldmljZSgpIGNhbGxiYWNrcw0KPj4+DQo+Pj4NCj4+PiBPbiAwMy8wNi8yMDI0IDA4OjEw
LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERv
IG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MNCj50aGlzDQo+Pj4g
ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4+Pj4NCj4+Pj4NCj4+Pj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+Pj4+DQo+Pj4+IEltcGxlbWVudCBbc2V0fHVuc2V0XV9pb21tdV9kZXZpY2UoKSBjYWxs
YmFja3MgaW4gSW50ZWwgdklPTU1VLg0KPj4+PiBJbiBzZXQgY2FsbCwgYSBuZXcgc3RydWN0dXJl
IFZUREhvc3RJT01NVURldmljZSB3aGljaCBob2xkcw0KPj4+PiBhIHJlZmVyZW5jZSB0byBIb3N0
SU9NTVVEZXZpY2UgaXMgc3RvcmVkIGluIGhhc2ggdGFibGUNCj4+Pj4gaW5kZXhlZCBieSBQQ0kg
QkRGLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAgOSArKysrDQo+Pj4+ICAgIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAyICsN
Cj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgNzYNCj4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgODcg
aW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4gYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4g
aW5kZXggZjhjZjk5YmRkZi4uYjgwMGQ2MmNhMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4+PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4+PiAgICAjaWZuZGVmIEhXX0kzODZf
SU5URUxfSU9NTVVfSU5URVJOQUxfSA0KPj4+PiAgICAjZGVmaW5lIEhXX0kzODZfSU5URUxfSU9N
TVVfSU5URVJOQUxfSA0KPj4+PiAgICAjaW5jbHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0K
Pj4+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIg0KPj4+Pg0KPj4+PiAg
ICAvKg0KPj4+PiAgICAgKiBJbnRlbCBJT01NVSByZWdpc3RlciBzcGVjaWZpY2F0aW9uDQo+Pj4+
IEBAIC01MzcsNCArNTM4LDEyIEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290
RW50cnk7DQo+Pj4+ICAgICNkZWZpbmUgVlREX1NMX0lHTl9DT00gICAgICAgICAgICAgIDB4YmZm
MDAwMDAwMDAwMDAwMFVMTA0KPj4+PiAgICAjZGVmaW5lIFZURF9TTF9UTSAgICAgICAgICAgICAg
ICAgICAoMVVMTCA8PCA2MikNCj4+Pj4NCj4+Pj4gKw0KPj4+PiArdHlwZWRlZiBzdHJ1Y3QgVlRE
SG9zdElPTU1VRGV2aWNlIHsNCj4+Pj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0YXRl
Ow0KPj4+PiArICAgIFBDSUJ1cyAqYnVzOw0KPj4+PiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+Pj4+
ICsgICAgSG9zdElPTU1VRGV2aWNlICpkZXY7DQo+Pj4+ICsgICAgUUxJU1RfRU5UUlkoVlRESG9z
dElPTU1VRGV2aWNlKSBuZXh0Ow0KPj4+PiArfSBWVERIb3N0SU9NTVVEZXZpY2U7DQo+Pj4+ICAg
ICNlbmRpZg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgN
Cj4+PiBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+IGluZGV4IDdkNjk0YjA4
MTMuLjJiYmRlNDFlNDUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9p
b21tdS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+IEBA
IC0yOTMsNiArMjkzLDggQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+Pj4+ICAgICAgICAv
KiBsaXN0IG9mIHJlZ2lzdGVyZWQgbm90aWZpZXJzICovDQo+Pj4+ICAgICAgICBRTElTVF9IRUFE
KCwgVlREQWRkcmVzc1NwYWNlKSB2dGRfYXNfd2l0aF9ub3RpZmllcnM7DQo+Pj4+DQo+Pj4+ICsg
ICAgR0hhc2hUYWJsZSAqdnRkX2hvc3RfaW9tbXVfZGV2OyAgICAgICAgICAgICAvKg0KPlZUREhv
c3RJT01NVURldmljZQ0KPj4+ICovDQo+Pj4+ICsNCj4+Pj4gICAgICAgIC8qIGludGVycnVwdCBy
ZW1hcHBpbmcgKi8NCj4+Pj4gICAgICAgIGJvb2wgaW50cl9lbmFibGVkOyAgICAgICAgICAgICAg
LyogV2hldGhlciBndWVzdCBlbmFibGVkIElSICovDQo+Pj4+ICAgICAgICBkbWFfYWRkcl90IGlu
dHJfcm9vdDsgICAgICAgICAgIC8qIEludGVycnVwdCByZW1hcHBpbmcgdGFibGUgcG9pbnRlcg0K
PiovDQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+Pj4gaW5kZXggNTE5MDYzYzhmOC4uNzQ3Yzk4OGJjNCAxMDA2NDQNCj4+
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4+PiBAQCAtMjM3LDYgKzIzNywxMyBAQCBzdGF0aWMgZ2Jvb2xlYW4gdnRkX2Fz
X2VxdWFsKGdjb25zdHBvaW50ZXINCj52MSwNCj4+PiBnY29uc3Rwb2ludGVyIHYyKQ0KPj4+PiAg
ICAgICAgICAgICAgIChrZXkxLT5wYXNpZCA9PSBrZXkyLT5wYXNpZCk7DQo+Pj4+ICAgIH0NCj4+
Pj4NCj4+Pj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfYXNfaWRldl9lcXVhbChnY29uc3Rwb2ludGVy
IHYxLCBnY29uc3Rwb2ludGVyIHYyKQ0KPj4+PiArew0KPj4+PiArICAgIGNvbnN0IHN0cnVjdCB2
dGRfYXNfa2V5ICprZXkxID0gdjE7DQo+Pj4+ICsgICAgY29uc3Qgc3RydWN0IHZ0ZF9hc19rZXkg
KmtleTIgPSB2MjsNCj4+Pj4gKw0KPj4+PiArICAgIHJldHVybiAoa2V5MS0+YnVzID09IGtleTIt
PmJ1cykgJiYgKGtleTEtPmRldmZuID09IGtleTItPmRldmZuKTsNCj4+Pj4gK30NCj4+Pj4gICAg
LyoNCj4+Pj4gICAgICogTm90ZSB0aGF0IHdlIHVzZSBwb2ludGVyIHRvIFBDSUJ1cyBhcyB0aGUg
a2V5LCBzbyBoYXNoaW5nL3NoaWZ0aW5nDQo+Pj4+ICAgICAqIGJhc2VkIG9uIHRoZSBwb2ludGVy
IHZhbHVlIGlzIGludGVuZGVkLiBOb3RlIHRoYXQgd2UgZGVhbCB3aXRoDQo+Pj4+IEBAIC0zODEy
LDYgKzM4MTksNzAgQEAgVlREQWRkcmVzc1NwYWNlDQo+Pj4gKnZ0ZF9maW5kX2FkZF9hcyhJbnRl
bElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4+PiAgICAgICAgcmV0dXJuIHZ0ZF9kZXZf
YXM7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBib29sIHZ0ZF9kZXZfc2V0X2lvbW11
X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj4+PiBkZXZmbiwNCj4+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmhp
b2QsIEVycm9yICoqZXJycCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKnMg
PSBvcGFxdWU7DQo+Pj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGRldjsNCj4+Pj4g
KyAgICBzdHJ1Y3QgdnRkX2FzX2tleSBrZXkgPSB7DQo+Pj4+ICsgICAgICAgIC5idXMgPSBidXMs
DQo+Pj4+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4+PiArICAgIH07DQo+Pj4+ICsgICAg
c3RydWN0IHZ0ZF9hc19rZXkgKm5ld19rZXk7DQo+Pj4+ICsNCj4+Pj4gKyAgICBhc3NlcnQoaGlv
ZCk7DQo+Pj4+ICsNCj4+Pj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4gKw0KPj4+PiAr
ICAgIHZ0ZF9oZGV2ID0gZ19oYXNoX3RhYmxlX2xvb2t1cChzLT52dGRfaG9zdF9pb21tdV9kZXYs
ICZrZXkpOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKHZ0ZF9oZGV2KSB7DQo+Pj4+ICsgICAgICAg
IGVycm9yX3NldGcoZXJycCwgIklPTU1VRkQgZGV2aWNlIGFscmVhZHkgZXhpc3QiKTsNCj4+Pj4g
KyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHZ0ZF9oZGV2ID0gZ19tYWxsb2MwKHNp
emVvZihWVERIb3N0SU9NTVVEZXZpY2UpKTsNCj4+Pj4gKyAgICB2dGRfaGRldi0+YnVzID0gYnVz
Ow0KPj4+PiArICAgIHZ0ZF9oZGV2LT5kZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPj4+PiArICAg
IHZ0ZF9oZGV2LT5pb21tdV9zdGF0ZSA9IHM7DQo+Pj4+ICsgICAgdnRkX2hkZXYtPmRldiA9IGhp
b2Q7DQo+Pj4+ICsNCj4+Pj4gKyAgICBuZXdfa2V5ID0gZ19tYWxsb2Moc2l6ZW9mKCpuZXdfa2V5
KSk7DQo+Pj4+ICsgICAgbmV3X2tleS0+YnVzID0gYnVzOw0KPj4+PiArICAgIG5ld19rZXktPmRl
dmZuID0gZGV2Zm47DQo+Pj4+ICsNCj4+Pj4gKyAgICBvYmplY3RfcmVmKGhpb2QpOw0KPj4+PiAr
ICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCBuZXdfa2V5LCB2
dGRfaGRldik7DQo+Pj4+ICsNCj4+Pj4gKyAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+PiAr
DQo+Pj4+ICsgICAgcmV0dXJuIHRydWU7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2
b2lkIHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUs
DQo+aW50DQo+Pj4gZGV2Zm4pDQo+Pj4+ICt7DQo+Pj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpz
ID0gb3BhcXVlOw0KPj4+PiArICAgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hkZXY7DQo+Pj4+
ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4+PiArICAgICAgICAuYnVzID0gYnVz
LA0KPj4+PiArICAgICAgICAuZGV2Zm4gPSBkZXZmbiwNCj4+Pj4gKyAgICB9Ow0KPj4+PiArDQo+
Pj4+ICsgICAgdnRkX2lvbW11X2xvY2socyk7DQo+Pj4+ICsNCj4+Pj4gKyAgICB2dGRfaGRldiA9
IGdfaGFzaF90YWJsZV9sb29rdXAocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCAma2V5KTsNCj4+Pj4g
KyAgICBpZiAoIXZ0ZF9oZGV2KSB7DQo+Pj4+ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7
DQo+Pj4+ICsgICAgICAgIHJldHVybjsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBn
X2hhc2hfdGFibGVfcmVtb3ZlKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSk7DQo+Pj4+ICsg
ICAgb2JqZWN0X3VucmVmKHZ0ZF9oZGV2LT5kZXYpOw0KPj4+IE5vdCBzdXJlIGJ1dCBpc24ndCB0
aGF0IGEgcG90ZW50aWFsIHVzZSBhZnRlciBmcmVlPw0KPj4NCj4+IEdvb2QgY2F0Y2ghIFdpbGwg
Zml4LiBTaG91bGQgYmU6DQo+Pg0KPj4gb2JqZWN0X3VucmVmKHZ0ZF9oZGV2LT5kZXYpOw0KPj4g
Z19oYXNoX3RhYmxlX3JlbW92ZShzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkpOw0KPg0KPnlv
dSBjb3VsZCBhbHNvIGltcGxlbWVudCBhIGN1c3RvbSBkZXN0cm95IGhhc2ggZnVuY3Rpb24uDQoN
ClllcywgYnV0IEknZCBsaWtlIHRvIGhhdmUgaXQgdG8gbWF0Y2ggb2JqZWN0X3JlZigpIGNhbGwg
aW4gdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKCkNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

