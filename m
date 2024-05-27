Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8AAC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU7b-0005ga-9D; Mon, 27 May 2024 02:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBU6j-0002Ka-Tk
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:45:21 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBU6U-0007ib-E0
 for qemu-devel@nongnu.org; Mon, 27 May 2024 02:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716792306; x=1748328306;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZeDQbp9uYTGNk2W4Dypos0JQv9zk7gGKLt3X9VCUQ2M=;
 b=CV+ASUvdvSXpNvjMiSnUfqUxpQ5+pVHlxu+OhkXybHN+djDwCDnJb+Ao
 I/kYxYWg1CR1CU4fohgZjm7E6YPDHjXJW369HdKOTs7OZ0TRg9/IJNHN8
 HINRQwThRHV+CSQ13VTDEVu6QuqFhnP3O1LK8wLTAa4l6PgN3ColsKYYR
 6bBMYaLmT013/qlfWpWyitbk26QPOhvZmWOpXT9CQ0n4umYAwHymUif1y
 hdxXufkj9XSohST+Pe/Ob+jAhbpTisFByOJ8KGsUHUtQ03Diz0A5ZJIlT
 khMozOgIGwLOe5YlYPN+cEKiiwSF31PO6zs2nwQT4hes/jzYBTZd2c9MC w==;
X-CSE-ConnectionGUID: sjVYpz/2SlakVuzvxh+ySA==
X-CSE-MsgGUID: VHszJSvhToWNWFdz8RAnJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13211125"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="13211125"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 23:45:03 -0700
X-CSE-ConnectionGUID: e2eo9JLCTc+3GwGhAF0hZw==
X-CSE-MsgGUID: +E+8hIpMT/m0k33hxnVQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="72069837"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 23:45:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:45:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 23:45:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 23:45:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 23:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAin3u3lz2r+Tc5ya1ZjikGaeaeHrvd5x0n3H9MrgWowPnim8wbwf/OLoxSRcEMyMRaWSD4x3wmR7QTpAns26jDQbz5nHOgrxCTNEPZxDhrNLgr64TrrkfDhe0/2JsYtcdksZhNKi2BtMs6yvcbeMTZgQtzYdRR2zwIuekyQFbXodyuAANislLYzMaEEaNCYBrpP/nOLPS7C90Ao8jpPzr0qnxuSWr5kmWje8NjRhb9l08/bU5zf3XqZu2OVCKAvyjm7+MFTZm6QphapgdrCQqmmAr2ysl59FODAmrPK2z8EVp/qtZSEj4RyFNSoWgPVFF5qaqLhPJ41QONplYI+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeDQbp9uYTGNk2W4Dypos0JQv9zk7gGKLt3X9VCUQ2M=;
 b=jp3krnZQz+0hTonW+RNwWMStOv7E1e1vNNI1sI1dJbM3ykmYkBmKbZmYlotokM5ycABnClay0oCScWRBcv9R6WFsO/28puzkZ3sSp7fyCfDd7fctyTpvF9YvhKjXIILXBuqWFJYcR+ArVu8siUTvIyHp4f6cS2tHho8Kkzysga1wah+GfSx0R58X+kxuRSoyws8FTUKJ9zzEqW0hgqQvMJbmxsn7KGlgbqWKeQlw8VOSC7A9kJzX9hOnbKB5v1rwNof2d55EPL+Ytt3CwFan3hSYVZ3Q/vfPJavsPWv+GrCm5klqaFew+Mf3Dh1Gghe+oxm4fRv5/YPu05EH0FbuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:44:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:44:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>, Yu Zhang
 <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIABefcAgAB9i4CAAW9wgIADKlPwgARf+4CAAAObwIAAMu3Q
Date: Mon, 27 May 2024 06:44:58 +0000
Message-ID: <SJ0PR11MB67448F0D3CE487F125D274AF92F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
 <CACGkMEt5ofYt12A6uKUj=QLcLbOnrGT=UkMpee=MUxO6Xy3sxg@mail.gmail.com>
 <SJ0PR11MB6744C340AAB1B786D3913F5D92EA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsV05ujKNEL9JSAsfikWGW582yvfSOdHJgRxZC_1cxgEg@mail.gmail.com>
 <SJ0PR11MB67445F7F8B79D2C2B982C1F692F52@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEuO6T-LqcZ=5oRR83LyhZ7oOtZvb70CUksZDAmC1KnsOA@mail.gmail.com>
 <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744135D8C08CEE42460CAF792F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7813:EE_
x-ms-office365-filtering-correlation-id: 2bf320b8-3650-4472-d7c6-08dc7e1886d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bWhYdGJPamJkbTVnbzMyNjgvQVRybGdwelRrSzRSeE1pL0svRTAxZEtoVDRt?=
 =?utf-8?B?WG90KzRqOVhqeFNVYk1UV3EzQWhPNnlrZ293M3Z4VjZKcHkremZZeEZlYjlR?=
 =?utf-8?B?REc2SEhMbGd5dnhzbkJwalJxdjNJQzFSUVlpdWxHaUpvNzJDNlIwYzA5RnFM?=
 =?utf-8?B?TkdsbExkVElmY0h2bnFZVSs5RzR3U2Z4TTFZeWlaZEdTMHk2KzlGWmhyeDkr?=
 =?utf-8?B?dWVvWTNYaU9aNjRKUnptZkNvWGRtQVJQSkpWQnJjRE1rUlZYb1hWS21PSWpC?=
 =?utf-8?B?ZnlxQlBJcklOVHhFVURacFBTdUdwSExIR0Rmc0lTWWJOdFpWNVFjbkNNVEdV?=
 =?utf-8?B?WDg0c3FCUVBSNHFmdllZRGJJQWFobE5FSmw1MmxLTnAyZkYvOUpJemVzbllt?=
 =?utf-8?B?K1hGUzd0bnI1aTdKU3FNaE9UbDFOSkdDK2lHNyswYzYvR043VkxyYTVEdDFs?=
 =?utf-8?B?Q2pka3lTa3FCVWZ6QkdTWUFyVmhLaTM5RVFwQ1o2MHlWbnl1MEE4YWxERzl5?=
 =?utf-8?B?aXF3clAxVVNUOXpCUWtsTnlLcnltcHBwUG5pUUt6YmI2SFlrbVJlb3ZYTTZC?=
 =?utf-8?B?aGlsdDU1OWluLzUrYjBmeWk4TnkwMWp0VllicTl2dno0aStYNlQxeFhLMU1I?=
 =?utf-8?B?RHJHT1VpQmthUU9oZWh2blNoSHJSZXFSOEpVVXVuZXBTRjhCU2RFT1AxaURx?=
 =?utf-8?B?UndHOWpnaEpSR2J3NW1ydzRpR0NvelZqelMvalRrNWU1S29Tc3BRTWlHOFd1?=
 =?utf-8?B?RVZNREhOcGxZZFZOUFJ1cERFZ0RFRENxYjlrUDFJNVpZS1JVb1RDRnJEeEZ6?=
 =?utf-8?B?OEZTSkVaNVV3OStXMFpJZkNQTG83WW1nR2o3bldVL3NQeVdRWitYOFBmOGxB?=
 =?utf-8?B?NmdhOE15QlFnU3pSVSt0K0QrZ1ZSYVRrbEp6NlB4QnlSZi8zeFF2SjBNRllG?=
 =?utf-8?B?UkNjUmV5bmtaWEQ0MllFTWZ4YUh5QXFzYkdmRktlY0g5L1gyZE5QaWphbFYr?=
 =?utf-8?B?Ukt1MGh0ZFQvS0xUeDhsRGtVWWNLMlpxOXh3N0gxcklBSHoxRWRmSDQ0K3Q4?=
 =?utf-8?B?L0JBZExvNGJSRThCUzg2Q0RpV0pGTUJtUExNMndNQ25YUjZlQ3ZZRWNXdmRq?=
 =?utf-8?B?UGFqdytUL3kySnN0eGw3Tnl0WlZIZmdBYTc1TmdTekkwSm9PNXg0WFlhdEdr?=
 =?utf-8?B?dUtKb0MwMXBKMWpSVFFJZWZ2ZlhzM0lhVXBxdlFXejEwVy80VXp4TENQSEY5?=
 =?utf-8?B?U2ZRWGplcG9EU2d2ZllvcDRUbVdzdFpxQjJSQUVzTFlZN0tVTm5wZEtkRE1S?=
 =?utf-8?B?MHVLeFdXV0ZSR3RHN2JsZUg2UXV2RWE3V1dXLzBPeDJ0YU9ZTi9KV25nZUJJ?=
 =?utf-8?B?anhuOGdKQzY4MGxRZWNwSkFDcUhidFgyZkZod24yTTRGTU10ZkVFaXhtNmQ2?=
 =?utf-8?B?Zm9ZMWVUVGhLQTh5RnhVSU1zTndzQ0hYZE4xSHJ0Tloyd014d3FJY215ZSs4?=
 =?utf-8?B?ZXQwVURzYmRNV0M3MUdMZjI3czdXV3VBdzVzanExWjIzWUd6TFljWXZFL0Ra?=
 =?utf-8?B?cU9XMW01cDZabUF4L2FhRVlvTXFCRHJGcGt4SzNHakFaZndmdzRaRDNydXll?=
 =?utf-8?B?OHRBRnlVTUgyWURwc2FaOTRSNWJJMnBNdE5MM0taTDlMSEtlQ2NGSytZanlj?=
 =?utf-8?B?TC84SGZiVXZKb3Yza2F3cW8rQlBaRUN0T1MvTk5kK29iTkhFMkl4eXVQQXlj?=
 =?utf-8?B?N0dzZmhPaFpsanJYV1dWaklZVnlqK29QVXh5VFRLVXBDTDJ6bzd6REIyS3Qw?=
 =?utf-8?B?SGV5QlhwY1BXdDF1aU9vUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkV0VS9xOFdlUGYzNzFrd28vUXhNeGhxUHRtVThHbERsZk1Bd1RnUDhtK0h4?=
 =?utf-8?B?aXVMaGlGZnhHSHBOWEhiMVFnNVNsWkFZN1BQejFQVG9PUEg2ZXJrckZ6bzJh?=
 =?utf-8?B?SjNlTVovVlBEbFFDK1lUaTdvcjlGREJpbHAvTHZCbGk4c3cxekxJVHFHb0FO?=
 =?utf-8?B?ZjYyQ2pvTWZPTExlbFZ2MkVBT25JQTJCSEhielNyMzJteVlXcHJHSC9tQ0d3?=
 =?utf-8?B?Q1lzRi9mQWNSSVgwa3FQcVRqZ0grU21PbXNjdDVZUHA1bXVNSm5wdktpTk5v?=
 =?utf-8?B?b1dHMGFFRURvUUxoeW11aGNxdkdjdVpDdno1OElQWUlKUnpqcWlPdU9uaDFi?=
 =?utf-8?B?ZG9ReFRRYWtHRDcxbGFua05PQ3F5NWdyUWpXcUlUWlJqV3lMYU84M2FlMk9P?=
 =?utf-8?B?bTBBOXJ1NjhPNlluSDlqLzRNY1lGWlFQMnE5NkZidmFXQVU5ajd1M1RPaVVN?=
 =?utf-8?B?bjRzMWpFczIyVUFXZnQrYkxvamtlK1JSK2F2UEtneGRqMFRFdGhZK29MSFE3?=
 =?utf-8?B?VUNVRTBEYnVibXlCQmIwL2g4bWFrOHJxRUtJRXJONG93WWhwL3o4OUpGeGZh?=
 =?utf-8?B?Znhzb1JGNzBFcmg4VEJwdTVaSXNHWllpcnpUbG1TbzQ0YXRWemxEMUhxcXkx?=
 =?utf-8?B?UmJmWWR0MUxPVEhXVmhBMXZyeW5qNlZnMUg3bkdacFdKWkR2NVdDL2lINktL?=
 =?utf-8?B?S3Q4aGtJQWZvazNKRTFxTDhHeGNCaDdOOHlpMEZOb0E4SUgzV2IvUHlHTUZU?=
 =?utf-8?B?ZjFtRHdDRzFtMjhiRFFoaE8vTnUvY3ZySUMxSC9id0NPNXFBWmhiZVg1S1NX?=
 =?utf-8?B?NzR4cEc4SE9tVzlXQWNYRXRpNytuakdnS3FOcEUySXpmRzVDbTlsUVZnT3RR?=
 =?utf-8?B?LzhqNnk5WVJYaGlvRFpxVDhuM3JYalpRU2NvejV0L096RmNwS3NGaTFkOGt1?=
 =?utf-8?B?bGtaTjV0VHhEaTFaNjZhZ01hM082aElLZERKV0V4ZWM5WHFtcUo2RVowTi9B?=
 =?utf-8?B?STh5RHRnTlVFUDVjR1l2V0k2elhsblE0MXdMSUpmYlBTbHJJZ3l6THNVYkpt?=
 =?utf-8?B?bEx2OFFicWFDc00vTzJWby9VNURNODMrNytKUVI4M2I2WnlZNzBaZWQ0Tmor?=
 =?utf-8?B?S3FyVXNiQTdGQ2Z5YzFnbktZTWprTXJNNnJLMDllZnR1eHVKYUllTnR3Z20y?=
 =?utf-8?B?R0ptWkdYS3cweW9XSVBlTnZLQUJoTWFCekw0ZU5GTWxUYW02MFdxdnc2a1Vv?=
 =?utf-8?B?M2wvMjR3Z0Eya2FsSFFLSzZyNmtlQkdmOVV6YXpxRS9RWTFyTVhHc2RvT1Ar?=
 =?utf-8?B?SVc5NzdNUlVCR0NLZDJubU1SWG5tWnRBeExxei9INmNTd2tGMkpkc1VyQjVK?=
 =?utf-8?B?bUorQWF3Z21KSEkxcnFqaFhDZmNaZTIxVXBZU2VXN1lSR1pJMnlFa0EzU2VR?=
 =?utf-8?B?L0M5eXZqMHNTeUVuSS9DdFJyZ2tJNHF3UHhrN0ZGQ2ZFK1RmQnE5SVFKK3hR?=
 =?utf-8?B?L0VKR01CS1M4dzh2UzhJMDEzQm1JRlpReHlGRjlqMGs4dFl6S2M0N1hBSCtL?=
 =?utf-8?B?OWxUVUYyV0h5VXRsSEljbkhKdE0rdlNxQ3dxZThmVWJSUk1JZzZXWXhScndK?=
 =?utf-8?B?czdLbG1Wd21wdXZjOG52eVVWMTE4WHVjM2VFSytybzRiRklmOVRqVTA4OFBs?=
 =?utf-8?B?dnYvUVVieEwyZmhqU01wNFZKQTFhRlRUMUZSV2tPS0k2VjNqejNtY3Vhd1dX?=
 =?utf-8?B?R1NrOUZwc0lSbUQ4MW5hQVhFYzQwZjZVVGJHK1NwdEtraUgvdzZhakY0ODht?=
 =?utf-8?B?c2RoMEpJR08wdEpnVkJTMlBCU0t6ckVXSG5TdWtWbnM1R1VYeUV6K2hNUWFx?=
 =?utf-8?B?aXczQ2JvZ1E3cHJ1ZlFIUWVWU0NwOS9GY3V6Tm4zcnZvR1JnN0RpOXBNdHpR?=
 =?utf-8?B?dzdZVnpMZGlUaldSY0pvdjVZR2ZERzE3VU5ueDUxMFZCb1EveXJUT01nK01H?=
 =?utf-8?B?QXJXTFYvVldEN3JkVUxLdFhYMHlidXpzSVBUR2VsNWNKa0FTNTFtMFN3aFlU?=
 =?utf-8?B?Vzg0Nkl1WHNvVlNrN29BeEhKODFTZm01VkxiWFlLRFBTOE8xWkR6Q2pkazhx?=
 =?utf-8?Q?LgbMsTmmEelLFaP4+z2U1tb45?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf320b8-3650-4472-d7c6-08dc7e1886d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 06:44:58.6101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlVqxmfJitie7FqjWZ43EkN1V/JCd4sd9owcpLXZIBXWEP16vsxOxwvAgRJOb3p7E5UaQH4YmhVlzuDkMVExJZqCSNFWqBycxGmykPzgJMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

SGkgSmFzb24sDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpo
ZW56aG9uZw0KPlN1YmplY3Q6IFJFOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVz
dCBmYXVsdCByZWFzb25zIGRlZmluZWQgYnkNCj5zcGVjDQo+DQo+DQo+DQo+Pi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+PkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhlIGxhdGVzdCBmYXVs
dCByZWFzb25zIGRlZmluZWQgYnkNCj4+c3BlYw0KPj4NCj4+T24gRnJpLCBNYXkgMjQsIDIwMjQg
YXQgNDo0MeKAr1BNIER1YW4sIFpoZW56aG9uZw0KPj48emhlbnpob25nLmR1YW5AaW50ZWwuY29t
PiB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4NCj4+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+PiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+PiA+U3ViamVj
dDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFVzZSB0aGUgbGF0ZXN0IGZhdWx0IHJlYXNvbnMg
ZGVmaW5lZA0KPmJ5DQo+Pj4gPnNwZWMNCj4+PiA+DQo+Pj4gPk9uIFR1ZSwgTWF5IDIxLCAyMDI0
IGF0IDY6MjXigK9QTSBEdWFuLCBaaGVuemhvbmcNCj4+PiA+PHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4gd3JvdGU6DQo+Pj4gPj4NCj4+PiA+Pg0KPj4+ID4+DQo+Pj4gPj4gPi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4gPj4gPkZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+DQo+Pj4gPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhl
IGxhdGVzdCBmYXVsdCByZWFzb25zDQo+ZGVmaW5lZA0KPj5ieQ0KPj4+ID4+ID5zcGVjDQo+Pj4g
Pj4gPg0KPj4+ID4+ID5PbiBNb24sIE1heSAyMCwgMjAyNCBhdCAxMjoxNeKAr1BNIExpdSwgWWkg
TCA8eWkubC5saXVAaW50ZWwuY29tPg0KPj53cm90ZToNCj4+PiA+PiA+Pg0KPj4+ID4+ID4+ID4g
RnJvbTogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gPj4g
Pj4gPiBTZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCAxMTo0MSBBTQ0KPj4+ID4+ID4+ID4NCj4+
PiA+PiA+PiA+DQo+Pj4gPj4gPj4gPg0KPj4+ID4+ID4+ID4gPi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+Pj4gPj4gPj4gPiA+RnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4NCj4+PiA+PiA+PiA+ID5TZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCA4OjQ0IEFNDQo+Pj4g
Pj4gPj4gPiA+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4+ID4+ID4+ID4gPkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPjsgUGVuZywNCj4+PiA+Q2hhbw0KPj4+ID4+ID5QDQo+Pj4gPj4gPj4gPiA+
PGNoYW8ucC5wZW5nQGludGVsLmNvbT47IFl1IFpoYW5nDQo+Pjx5dS5jLnpoYW5nQGxpbnV4Lmlu
dGVsLmNvbT47DQo+Pj4gPj4gPk1pY2hhZWwNCj4+PiA+PiA+PiA+ID5TLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkNCj4+PiA+PHBib256aW5pQHJlZGhhdC5jb20+Ow0K
Pj4+ID4+ID4+ID4gPlJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8u
b3JnPjsgRWR1YXJkbw0KPj4+ID5IYWJrb3N0DQo+Pj4gPj4gPj4gPiA+PGVkdWFyZG9AaGFia29z
dC5uZXQ+OyBNYXJjZWwgQXBmZWxiYXVtDQo+Pj4gPj4gPjxtYXJjZWwuYXBmZWxiYXVtQGdtYWls
LmNvbT4NCj4+PiA+PiA+PiA+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNl
IHRoZSBsYXRlc3QgZmF1bHQgcmVhc29ucw0KPj4+ID5kZWZpbmVkDQo+Pj4gPj4gPmJ5DQo+Pj4g
Pj4gPj4gPiA+c3BlYw0KPj4+ID4+ID4+ID4gPg0KPj4+ID4+ID4+ID4gPk9uIEZyaSwgTWF5IDE3
LCAyMDI0IGF0IDY6MjbigK9QTSBaaGVuemhvbmcgRHVhbg0KPj4+ID4+ID4+ID4gPjx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+ID4+ID4+ID4gPj4NCj4+PiA+PiA+PiA+ID4+
IEZyb206IFl1IFpoYW5nIDx5dS5jLnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4+PiA+PiA+PiA+
ID4+DQo+Pj4gPj4gPj4gPiA+PiBDdXJyZW50bHkgd2UgdXNlIG9ubHkgVlREX0ZSX1BBU0lEX1RB
QkxFX0lOViBhcyBmYXVsdA0KPj5yZWFzb24uDQo+Pj4gPj4gPj4gPiA+PiBVcGRhdGUgd2l0aCBt
b3JlIGRldGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVkIGluIFZULWQgc3BlYw0KPj43LjIuMy4N
Cj4+PiA+PiA+PiA+ID4+DQo+Pj4gPj4gPj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBZdSBaaGFuZyA8
eXUuYy56aGFuZ0BsaW51eC5pbnRlbC5jb20+DQo+Pj4gPj4gPj4gPiA+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+ID4+ID4+ID4g
Pj4gLS0tDQo+Pj4gPj4gPj4gPiA+DQo+Pj4gPj4gPj4gPiA+SSB3b25kZXIgaWYgdGhpcyBjb3Vs
ZCBiZSBub3RpY2VkIGJ5IHRoZSBndWVzdCBvciBub3QuIElmIHllcw0KPnNob3VsZA0KPj4+ID4+
ID4+ID4gPndlIGNvbnNpZGVyIHN0YXJ0aW5nIHRvIGFkZCB0aGluZyBsaWtlIHZlcnNpb24gdG8g
dnRkIGVtdWxhdGlvbg0KPj5jb2RlPw0KPj4+ID4+ID4+ID4NCj4+PiA+PiA+PiA+IEtlcm5lbCBv
bmx5IGR1bXBzIHRoZSByZWFzb24gbGlrZSBiZWxvdzoNCj4+PiA+PiA+PiA+DQo+Pj4gPj4gPj4g
PiBETUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbMjA6MDAuMF0gZmF1
bHQNCj5hZGRyDQo+Pj4gPj4gPjB4MTIzNDYwMDAwMA0KPj4+ID4+ID4+ID4gW2ZhdWx0IHJlYXNv
biAweDcxXSBTTTogUHJlc2VudCBiaXQgaW4gZmlyc3QtbGV2ZWwgcGFnaW5nIGVudHJ5IGlzDQo+
PmNsZWFyDQo+Pj4gPj4gPj4NCj4+PiA+PiA+PiBZZXMsIGd1ZXN0IGtlcm5lbCB3b3VsZCBub3Rp
Y2UgaXQgYXMgdGhlIGZhdWx0IHdvdWxkIGJlIGluamVjdGVkIHRvDQo+dm0uDQo+Pj4gPj4gPj4N
Cj4+PiA+PiA+PiA+IE1heWJlIGJ1bXAgMS4wIC0+IDEuMT8NCj4+PiA+PiA+PiA+IE15IHVuZGVy
c3RhbmRpbmcgdmVyc2lvbiBudW1iZXIgaXMgb25seSBpbmZvcm1hdGlvbmFsIGFuZCBpcw0KPmZh
cg0KPj4+ID5mcm9tDQo+Pj4gPj4gPj4gPiBhY2N1cmF0ZSB0byBtYXJrIGlmIGEgZmVhdHVyZSBz
dXBwb3J0ZWQuIERyaXZlciBzaG91bGQgY2hlY2sNCj4+Y2FwL2VjYXANCj4+PiA+PiA+PiA+IGJp
dHMgaW5zdGVhZC4NCj4+PiA+PiA+Pg0KPj4+ID4+ID4+IFNob3VsZCB0aGUgdmVyc2lvbiBJRCBo
ZXJlIGJlIGFsaWduZWQgd2l0aCBWVC1kIHNwZWM/DQo+Pj4gPj4gPg0KPj4+ID4+ID5Qcm9iYWJs
eSwgdGhpcyBtaWdodCBiZSBzb21ldGhpbmcgdGhhdCBjb3VsZCBiZSBub3RpY2VkIGJ5IHRoZQ0K
Pj4+ID4+ID5tYW5hZ2VtZW50IHRvIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Lg0KPj4+ID4+DQo+
Pj4gPj4gQ291bGQgeW91IGVsYWJvcmF0ZSB3aGF0IHdlIG5lZWQgdG8gZG8gZm9yIG1pZ3JhdGlv
biBjb21wYXRpYmlsaXR5Pw0KPj4+ID4+IEkgc2VlIHZlcnNpb24gaXMgYWxyZWFkeSBleHBvcnRl
ZCBzbyBsaWJ2aXJ0IGNhbiBxdWVyeSBpdCwgc2VlOg0KPj4+ID4+DQo+Pj4gPj4gICAgIERFRklO
RV9QUk9QX1VJTlQzMigidmVyc2lvbiIsIEludGVsSU9NTVVTdGF0ZSwgdmVyc2lvbiwgMCksDQo+
Pj4gPg0KPj4+ID5JdCBpcyB0aGUgUWVtdSBjb21tYW5kIGxpbmUgcGFyYW1ldGVycyBub3QgdGhl
IHZlcnNpb24gb2YgdGhlIHZtc3RhdGUuDQo+Pj4gPg0KPj4+ID5Gb3IgZXhhbXBsZSAtZGV2aWNl
IGludGVsLWlvbW11LHZlcnNpb249My4wDQo+Pj4gPg0KPj4+ID5RZW11IHRoZW4ga25vd3MgaXQg
c2hvdWxkIGJlaGF2ZSBhcyAzLjAuDQo+Pj4NCj4+PiBTbyB5b3Ugd2FudCB0byBidW1wIHZ0ZF92
bXN0YXRlLnZlcnNpb24/DQo+Pg0KPj5XZWxsLCBhcyBJIHNhaWQsIGl0J3Mgbm90IGEgZGlyZWN0
IGJ1bXBpbmcuDQo+Pg0KPj4+DQo+Pj4gSW4gZmFjdCwgdGhpcyBzZXJpZXMgY2hhbmdlIGludGVs
X2lvbW11IHByb3BlcnR5IGZyb20geC1zY2FsYWJsZS0NCj4+bW9kZT1bIm9uInwib2ZmIl0iDQo+
Pj4gdG8geC1zY2FsYWJsZS1tb2RlPVsibGVnYWN5InwibW9kZXJuInwib2ZmIl0iLg0KPj4+DQo+
Pj4gTXkgdW5kZXJzdGFuZGluZyBtYW5hZ2VtZW50IGFwcCBzaG91bGQgdXNlIHNhbWUgcWVtdSBj
bWRsaW5lDQo+Pj4gaW4gc291cmNlIGFuZCBkZXN0aW5hdGlvbiwgc28gY29tcGF0aWJpbGl0eSBp
cyBhbHJlYWR5IGd1YXJhbnRlZWQgZXZlbiBpZg0KPj4+IHdlIGRvbid0IGJ1bXAgdnRkX3Ztc3Rh
dGUudmVyc2lvbi4NCj4+DQo+PkV4YWN0bHksIHNvIHRoZSBwb2ludCBpcyB0bw0KPj4NCj4+dnRk
PTMuMCwgdGhlIGRldmljZSB3b3JrcyBleGFjdGx5IGFzIHZ0ZCBzcGVjIDMuMC4NCj4+dnRkPTMu
MywgdGhlIGRldmljZSB3b3JrcyBleGFjdGx5IGFzIHZ0ZCBzcGVjIDMuMy4NCg0KWWkganVzdCBm
b3VuZCB2ZXJzaW9uIElEIHN0b3JlZCBpbiBWVC1kIFZFUl9SRUcgaXMgbm90IGFsaWduZWQgd2l0
aCB0aGUgVlQtZCBzcGVjIHZlcnNpb24uDQpGb3IgZXhhbXBsZSwgd2Ugc2VlIGEgbG9jYWwgaHcg
d2l0aCB2dGQgdmVyc2lvbiA2LjAgd2hpY2ggaXMgYmV5b25kIFZULWQgc3BlYyB2ZXJzaW9uLg0K
V2UgYXJlIGFza2luZyBWVEQgYXJjaCwgd2lsbCBnZXQgYmFjayBzb29uLg0KDQpPciB3aWxsIHlv
dSBwbGFuIHFlbXUgdlZULWQgaGF2aW5nIGl0cyBvd24gdmVyc2lvbiBwb2xpY3k/DQoNClRoYW5r
cw0KWmhlbnpob25nDQoNCj4NCj5HZXQgeW91ciBwb2ludC4gQnV0IEkgaGF2ZSBzb21lIGNvbmNl
cm5zIGFib3V0IHRoaXM6DQo+MS5FeGFjdCB2ZXJzaW9uIG1hdGNoaW5nIHdpbGwgYnJpbmcgdmFz
dCBvZiB2ZXJzaW9uIGNoZWNrIGluIHRoZSBjb2RlLA0KPiAgIGVzcGVjaWFsbHkgd2hlbiB3ZSBz
dXBwb3J0IG1vcmUgdmVyc2lvbnMuDQo+Mi4gVGhlcmUgYXJlIHNvbWUgbWlzc2VkIGZlYXR1cmVz
IGJlZm9yZSB3ZSBjYW4gdXBkYXRlIHZlcnNpb24gbnVtYmVyIHRvDQo+My4wLA0KPiAgICBpLmUu
LCBuZXN0ZWQgdHJhbnNsYXRpb24sIEFjY2Vzc2VkL0RpcnR5IChBL0QpIGJpdHMsIDUgbGV2ZWwg
cGFnZSB0YWJsZSwgZXRjLg0KPjMuIFNvbWUgZmVhdHVyZXMgYXJlIHJlbW92ZWQgaW4gZnV0dXJl
IHZlcnNpb25zLCBidXQgd2Ugc3RpbGwgbmVlZCB0bw0KPiAgIGltcGxlbWVudCB0aGVtIGZvciBp
bnRlcm1lZGlhdGUgdmVyc2lvbiwNCj4gICBpLmUuLCBFeGVjdXRlUmVxdWVzdGVkIChFUiksIEFk
dmFuY2VkIEZhdWx0IExvZ2dpbmcsIGV0Yy4NCj4NCj4+DQo+PldoZW4gbWlncmF0aW9uIHRvIHRo
ZSBvbGQgcWVtdSwgbWdtdCBjYW4gc3BlY2lmeSBlLmcgdnRkPTMuMCBmb3INCj4+YmFja3dhcmQg
bWlncmF0aW9uIGNvbXBhdGliaWxpdHkuDQo+DQo+WWVzLCB0aGF0IG1ha2VzIHNlbnNlIGZvciBz
dWNoIG1pZ3JhdGlvbi4NCj5CdXQgSSdtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGEgcmVhbCBzY2Vu
YXJpbyBtaWdyYXRpbmcgdG8gb2xkIHFlbXUsDQo+d2h5IG5vdCBqdXN0IHVwZGF0ZSBxZW11IG9u
IGRlc3RpbmF0aW9uPw0KPg0KPlRoYW5rcw0KPlpoZW56aG9uZw0KDQo=

