Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED10C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCP4-0003Vu-M5; Thu, 20 Mar 2025 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCOv-0003RO-CQ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:41:22 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCOs-0002i5-Kw
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742463679; x=1773999679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/mx+27kVIN/oPP3kpS4EfH7afKir5Hx2RswlgNA+750=;
 b=OoN4GmHAUBBFg1eZqi5ScRjXWMWrmMu8F5QcYjhj2Tb0n8Q9aJP3frNm
 DXkirYCGOTty3/B4UQWYP1vE3+jDGuqts5en2UtNVvS3RswaAntG5/Lvn
 U9Jm/orZSKNPb4NC3SsUTbtheZqvGMek25sQuv9cv8bxVEaU/dBT7ZGIh
 PFwDFHPcweb1zM7VjlKSujWWbcD5HEn98q5/kV+cfvNRlu9FhOg8SKxEZ
 X6+rejxTAp4PaZoY2Z0bgJXa1a3mhLYwaOy14DyqSZlT10Ld6hm22fvKj
 tdGPOKtpwJjGpVDi6fmJLGa2N9gei76KFMG7LXOmLbHVEnz55IzC3cXzK w==;
X-CSE-ConnectionGUID: MLghk1+zQPGcNLmobc7UmQ==
X-CSE-MsgGUID: 6bafvc06RtGbRxID9koJ/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43797016"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="43797016"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:41:16 -0700
X-CSE-ConnectionGUID: gp2uMnZMS6uIDLyKoHWV8A==
X-CSE-MsgGUID: n9Hrifo1QiqPNvy+Wc70uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="123213085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:41:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 02:41:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 02:41:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp9y5aWn7Xj0CJnRp57eQXIyDen+AomERBAO1Z0xH4FeP6U9kqGyUclatDC76bzCNGAGH89eVZsAUn5fa/Ezyq/mGegm7lh18gjwsWMzVt/k/8Ri8k04Tger0sMO5lsdbGaRQutj7smD8j9ZDF4wA7FpVfaiheFWlMdAQPTYsZFuCcRg/a7Y6Lj+GpaAHfXSd+slWtTmMd7eRuKsQY0IqfsST+s3PkIEqM/QQOgzF/x0gyT/E69efM+OQ57w8+KqLX0bkcA6hqlyViLpJ1UTBeZK/tWixhLkD9cmV1YsERdEN3wd02gQPTFWY4RH17ksTZsMTUc1OfvEFeFG1QZfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mx+27kVIN/oPP3kpS4EfH7afKir5Hx2RswlgNA+750=;
 b=wQ7c7K9SVkZJbIR/r0v+xZgCpuxHWlRarIeIk8vQ4PgWu990WWb0K2nTSCcvakihhWdqhzrdtBbPJU/kix9904KywzspbsYxXK+jQvGnAbN2974BTZb5wX0sMv/5fC9osDPMQI7EfWqlhZraogfnF/X7v58jwax8VGVAem+1nc4Pwxm9AuRJyPeaW7iAyrbXFObEYdwHpbX3nIIdbsfXnDLglMeV4l3I7fhREqlsY+x5vYIkjV+BC3KG8kovbLVZ/hpq6WTb8WPo6uEUfR0jmmxg5yqd/55QQv42zybI3NgDNYUz4JShXyLsh38bEmA6yTKYhj+oYHWHEsuF0EEd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4541.namprd11.prod.outlook.com (2603:10b6:806:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:40:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:40:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 17/32] vfio: Move vfio_kvm_device_add/del_fd() to
 helpers.c
Thread-Topic: [PATCH for-10.1 17/32] vfio: Move vfio_kvm_device_add/del_fd()
 to helpers.c
Thread-Index: AQHbl+vyCIWUHL80YEWYzpjIGfWAkbN7yEKQ
Date: Thu, 20 Mar 2025 09:40:29 +0000
Message-ID: <SJ0PR11MB67445B890D1042381EB3D0E292D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-18-clg@redhat.com>
In-Reply-To: <20250318095415.670319-18-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4541:EE_
x-ms-office365-filtering-correlation-id: 9c8be192-611e-4b0d-c3f0-08dd67934090
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U2w0SmM0K3BLSU5OanY5b2w3bHJLMGl5N0MzN21ONlV1SXFCZUJ4emN4ejly?=
 =?utf-8?B?dFBOajBtdzg0K1EwVXJNUURJL2w4UHhSY0dPY2toZ1BZV0hmVTJYKzZCdlVW?=
 =?utf-8?B?dldqRzAzUkU5VXgrQ2tYMmdZdmk1U2J2ejdTTW5jYlNqWldnSHphVHBrR1Zl?=
 =?utf-8?B?QllhMmN1aHVZU3l3YUpoQ1ZuRWZBWFZoZjJscE8zNFBGQUNWeXpQSXE5Tk1y?=
 =?utf-8?B?dzdBNk5TTm5EUGRmRWhYeSs5d011RnVpL1NUcTFDVUlObTJVaHJERXFMWDVZ?=
 =?utf-8?B?TWV3QVYwcVVmalhmQWQvaFh3RHNsMnB0ZnBWMWUzb0lyYVh0TUFaM0x5UzZY?=
 =?utf-8?B?Wk1hdjBGRjBoN1F4eFlYL1B6OERqTzFUNU1XQm51eU1UcTV2SUVMN095SWU3?=
 =?utf-8?B?U3p6Q2xiV3p1QmYvWHRrcTJlZDIvV2hLVmVmZVFrbE1rRmR2T2lKalVCZ1M3?=
 =?utf-8?B?MUJMSFZSOTl1dDBUTEVBS2JURVlNc1VTejhjbitvMWU0bVQ1YXVob0hWcTM0?=
 =?utf-8?B?SmI2MElkRUFjZGhodm9DSFBEZzJWMFgySzcxSVJiTXppbkZ0YnpxeWg0T04y?=
 =?utf-8?B?V1hTeXZOblRqbDZQQ3dmWnpWazd4ekF5OURNSHpnNzZpcnRBSURmbUQ2M3lr?=
 =?utf-8?B?MnVVVEl6K25ubzZJWnA3dmNiTGVaZTlHcExuQWdKcG15VWZNd091UWJIQWxB?=
 =?utf-8?B?TllDVlB1UDBET3hRUGVqeXAvbCtZdEZzNWpjN3pZdUtlZTZKb0E4QnpudHQ1?=
 =?utf-8?B?VUlBUmtPK1BXajczMVlSNUNiYUVMMDF5REZ1U2ZjOGFLbTNONzhKaTJ4VUR1?=
 =?utf-8?B?Y2ZQTFdHL250WU55QW5tVnZQSHl1UFNBUSs5MExqOHVaWTZqaXgxcktBOFVY?=
 =?utf-8?B?MnR4dUUrcWcxOG52U2w2OEsrc0FKMXBrUndhaXBvWFV5WE1jcXpHRHBTeUtE?=
 =?utf-8?B?dFhaNGQ3WVZRbnBmMU8rRnlDSWJTS2JMOExoNEJaVTY3RjJ5QVhHakZiaGtv?=
 =?utf-8?B?SkFkbWxoUmxNWEhlUzQyalVkaEM0K24zeVAxVjZQYnZCRDl1SzI1M1cwcUlG?=
 =?utf-8?B?Nlg0N1hVWTRwSERWT1QwcHJBYngrTkJ4T3ZhVEpiOTY4bk9ZOURreGk3Vitt?=
 =?utf-8?B?TURSa2pZY29zZm83UWJJWlRiQ1Y4MTNseDEvQW44YytKaStLVkcrWDZ6cVM5?=
 =?utf-8?B?cGNjWWdMRk5QSDZwcStuTDNhSWdkRkphd3lVWWZZNUJCRTRaVUEvQk9seXg4?=
 =?utf-8?B?VTdvM2dFS2EvS0lqRFc1M0Ntb2ErRDd2cUhoN2pGMDRHY0JzQ0tkSlRLYVRZ?=
 =?utf-8?B?em95YTdSeXYyWlE2YzR6dDhaNjRjRDUzU2xvQzVVdDJWTnhya1RkcGV5NGlx?=
 =?utf-8?B?S3ZESHVDeVVPRkxsZTUvMUVaTXRkajMyTVJ1L1VMdEFkMjBiTHZZd1ZaZkg3?=
 =?utf-8?B?MmlHVUJmWGdLTkNqbVpZOXBmVXJtY0o4WlRvSzBjL1VZOWVlcFFhZTZxMS85?=
 =?utf-8?B?UHlVYkY5U2hzL3NzYlQ0MFVETUxIbFZDbk9UU0I5QmRvZnZEQ29WUGhVa0hT?=
 =?utf-8?B?V2laMnhxNlYzUmpDK2pGd2JobkpLSWxNSkpGYXdPVW9zNmczMm5DNUlWcDI0?=
 =?utf-8?B?YjVCdmVZY0QrSjE2V2JiZEFISE9XV0V0cnRhbko2engzVzNwRU9YOHVyU09y?=
 =?utf-8?B?QitnSWpyQVA1Q2RnWFg3djQ0WUMwVkJld3lPaFg5UmhXMlQ1OSttaGFJYlVE?=
 =?utf-8?B?LzA0b0dPZTVWNks5c0c1Rkh5V2JTS0tCSnhCREhCZHZYVWszN05YOGc3MnBj?=
 =?utf-8?B?SUZqVmdEUm9nZFBxbjJGZ0ZMT2p6QXNGSTY0OFAvWHVBRUxIaUJvWEpmWWV3?=
 =?utf-8?B?cjdXNU9lNkcrY1d5cW5kQ2JqNUdWK3dGM1k3bkx1RXFMcjhaNm1VYXEwWW1Q?=
 =?utf-8?Q?f6+co8ib6pq9ef1KcrL/jGqOFk52yNEv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0EvQ2lEdmpVQjFUeUx2WVZEUlFQZEFoTWpaR1JKK3VUV21EY0JsZzJpK2gr?=
 =?utf-8?B?SVBOeWpYOXlvNmNBbmQybUhycWdDQ1haclREOFJaSjBnWnhhNWtndXNucW1h?=
 =?utf-8?B?VDZlWDBzUU1zZGxDNmRkNERtUGFYNDc1eXE5VmIyN0FEVVZ5TGhxYmtKdWtG?=
 =?utf-8?B?eGpJeEsxSWV2VXQ2bmRvQTFxWWF2OGFTZEZ2cEI3UFJNQWlOeHgycEN6R3lJ?=
 =?utf-8?B?MFRjMzM2cXErR2txQW8vSkZBNEkwblFEM1J4QUVYK3Ywc0FpM01tTVp5ZWor?=
 =?utf-8?B?dnRzQjBBRnlyengwVUZrSUlpYXhuUER2VFVXS0NnMDNBMXlENU0vdXlOTmhq?=
 =?utf-8?B?emlUc2N0UUJsU1BzUHV2U1d1NUpJdEFoblZ0UW9KcGE2a1hyUTA4c0lQYkp5?=
 =?utf-8?B?K01GZnRCVm9ndExOcGQ3cEtxNnlLVFVma1JkODB5Zm5TVk1aL3l5SXRDRnBM?=
 =?utf-8?B?SDNzMGk0TDQxSndYK0cyY2llVGhSR0JpVVh3TWJoMis0WUVjbFVHNmdhVk12?=
 =?utf-8?B?V2xxWXh1RXRiUWdXZEE4NnFUOUNYT05Ra0F3enFkK2RXNkFDMENLdWh1VlY2?=
 =?utf-8?B?em55cVIrZk82YnJRVXJzQWlzcmZNb1Z5NzBkZjAzUnROWjc3cDJrZEFjVVoy?=
 =?utf-8?B?MDVjNkVqeFZMQXp6cmJmRGU1bUV3RE1EVlptaUM3ZFN3TklWNE5oNXFQdi9l?=
 =?utf-8?B?VUJ0NkwvYjBlSmNIZE5uYUhoTDd3LzVKOGVyZnh5VUIvYjN0WUdtUWt0T2t2?=
 =?utf-8?B?dHpLdjJpNHR6d21KaVhPWnZTcDVJVEJ0bWRkUnM3ZCtHNllsT1JhMXZLTTZ1?=
 =?utf-8?B?RkIrdmEvU0NBUEsvOWhpSFVuVnZCOFZZQk1IMm5pb3NRR1RLNEtQR1BQTytU?=
 =?utf-8?B?RVFKWE1QUVlleHN6cjdjd1pjOGU4ak9PSWhFdDVIYWVYNDlvUlBLZEJlQ2gr?=
 =?utf-8?B?cE9aRERMVFc2QkNwN2VtbW1qdUZPRXR3M0QvcXFCcDZHRS9jZFJTQ29NOXIv?=
 =?utf-8?B?em9IVjR0d0YzWkhWd21vT3U3RWZqMFNUeCtXRkV2aG5aZk42eWRIYk9ZM0F0?=
 =?utf-8?B?aExDU1VIRkZMSDB1VytKZ1htSWZXN2hTREc3Z2VkWXR2OHVZY2wwMUR6QW43?=
 =?utf-8?B?QmNoTGY0UERSWDVmRnd3UHh0YWY0UkxTUmF2bkE3NytoRjUySEltZ0Q2QjhE?=
 =?utf-8?B?RlE2TVlpdkNjOEJrMVNLbHFkT0cxdlkvbUtWYjhBTGFkV3VXZTZUaHhjMGZp?=
 =?utf-8?B?MHUvMGNXTW1aQmo5YnUxazF0YnZRaWI0dWhTb2dRalJPeFd1a24wR0ZIN2Jl?=
 =?utf-8?B?bkVCZndVRzhRcFZtcFFlVUZzODhXMk9yR1pQa3lQYjdKZ29ubWxHMmc2Qzls?=
 =?utf-8?B?ZU51a2ZnR0RGWkVJazA3eGNsV0tYS2Zzem9HTlJBTnVaOHBaSTV4M1F3eWFv?=
 =?utf-8?B?S2MrNVM3TGovZ2VMVGtVVHlZd3FGMjR1RERpajVHN2plSHJ1QnRqRXM1cG5F?=
 =?utf-8?B?L2hwZEJMOGdwSlVFR0FPZlpRTHlpTjZTQTREMWdIbDROek1rSzZUUE80WU1I?=
 =?utf-8?B?QUQrOHJhWXM2Wk9IcytKOC9XdGsyTXdic2dlYit6S3dkbjBKQlowaElWcTJ1?=
 =?utf-8?B?STZYTE1SQ1NYYUpYZVc1ZDlDMkljM21pUWUzdU10emVRTWQyR0NLMmY0UG5Z?=
 =?utf-8?B?OUZXZi9YRi9MVFRMUlNRYmFuQkxsUE5xejJ4M2h0TzJUNVdyNkRnMUhOdVF0?=
 =?utf-8?B?ZEpPVk9URm5hMWgzaStPbWwxMGg5cEo0SXJYd2p0WlMvRG1INXd0Z1VzM1ow?=
 =?utf-8?B?aCtYV010ZFFrVFhZeXlZMWlnM2tIVnp1bElWcHVwbTI4RkZISnBlSzYvbnNH?=
 =?utf-8?B?TVd0Q1R0SWFBVEFGRy8vM2xHcmRBUjJvRnkyUHUvVm0zL0VoT29YdlpOelFE?=
 =?utf-8?B?RjI0dFZ2a1JWQ1F5bFZIdXpjVFErcVVkeUcxYXZQY0VweDJmQlB3a3R5VE1n?=
 =?utf-8?B?VG9Hd0xyZ216REFSeEZzeE1mVHNUcUdlQ0ZzSFNyRlZNMUltTWlCNVNHeW5U?=
 =?utf-8?B?TkEzZXNpVTluUmllZGJ2dzludlR3eWVlZVg0c3I2ajJESVdaT0c2YUhQY3Rx?=
 =?utf-8?Q?f5iSZorbCzlSZKcUWps94HbeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8be192-611e-4b0d-c3f0-08dd67934090
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:40:29.7090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOVtoi4NWxZgYGARQpP5r73f8G1LiAqiNzUiuUBo7z5HPv7FCVYe1I9ZxiuTgCkmN9GkA7pWlStIscp4lrwuEe2PegYfwN1R/CLZknfsKYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4541
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgMTcvMzJdIHZmaW86
IE1vdmUgdmZpb19rdm1fZGV2aWNlX2FkZC9kZWxfZmQoKSB0bw0KPmhlbHBlcnMuYw0KPg0KPnZm
aW9fa3ZtX2RldmljZV9hZGQvZGVsX2ZkKCkgYXJlIGxvdyBsZXZlbCByb3V0aW5lcy4gTW92ZSB0
aGVtIHdpdGgNCj50aGUgb3RoZXIgaGVscGVycy4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0K

