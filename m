Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A65ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zvi-0004rX-5m; Tue, 23 Sep 2025 06:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zvY-0004oE-6Z
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:07:17 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zvQ-0001U3-Et
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758622029; x=1790158029;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bx7AX2VTVFtiz+4i3mmb3OOydJxRbqVx+t5WgcBECtQ=;
 b=CEMbxpdr3MkNc8b+jc+xX40MF7mC187+vw8E60l/wZAQ1tm6woHkhfrT
 48utlAeZEawyNHFjj71Hsz2lzlxBiH6+6nsZocbFMhwOLAf4CDgGrv48S
 2d7orfesXoKaIl9syl0l2CGovRZWGYq1tI9epLmeJ1Ubx7BhjiE1c5KVN
 mxM88i6xUEj7oTqECSedWWczAQgwFSV3nvG+YFApHc0HRdGA/OEA8eYfS
 DrTuVLnD3EULn/C+o6BAaXO/J8OaxOgz/9aVGISWOr3YGksNBh93nXSl+
 H5uhA0OqxU0t5lmec9XA1GovL2AhbF/pKu77amqAJ9zVoGAeFSg6potkz g==;
X-CSE-ConnectionGUID: 9pO+NcdcTyK5shBdcb3//g==
X-CSE-MsgGUID: rtoYQJEgSN6erAIb03x7jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60837367"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60837367"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 03:07:04 -0700
X-CSE-ConnectionGUID: l5VhHXrEQ8WU9k/ZM/3qhA==
X-CSE-MsgGUID: oEIqXS4VR0OBuw4HhHXIjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="181024885"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 03:07:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 03:07:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 03:07:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 03:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbDhjbiiAme+uc08ovefZhRp0s+BXmkEn3jtbpXP9l7hTbnVQcRAz+my4n1NaOYPp3dXgh1rfa6YS5A2QyIgHToz659Rvxcnhpaz/SdkykhRw3Vp9KbgOI5CORbzMs4YZ1TtMpHlrw1x1LjX9SLehJzg4Kp123gVxjypbtGUFuALkw8keJ+ZhUEbDMDhZHvisODU/WOkAeLrCxtLFaCCWGSG2sGS3yKOOwXWnn5esK+3s6EpyS0cX8sG/fi5nIwKw2Cz41+Dmog/XajgmuKUDBO6gx9SH4BKkJSJcHfc3qeB1+hscNz3dGZCHu5NEEXwW4FOsk7eQB34cL8ORm+o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx7AX2VTVFtiz+4i3mmb3OOydJxRbqVx+t5WgcBECtQ=;
 b=W4+XFjbBDFCW6ioOibUJy7m0EKeU9VFCv9QUT2p/lazQU3WFGBTNMDHJUn73IMNg0L/NDPaJmO2rS4nSbKyxrur4FBt9zopIWMRySJRz9WxIfji+s9m/VjmpF81rQq2HgPU/4zfXe7mRQb6Unu8IcQt+JnfGIIiUX+r3ePuwo6FkPH7zjbas8SfNU7zPR+9k43CvEh7BsdSd6JW7LCEre4NlY3kAY2OM54C5zKhuUIBJ3zFUXDS8HQ/l9/OilxgjnOpyTIIbYa/jVrOy5uEeBZnZugoETYEVjt6+Ua/+xVJyLaSk2tXByU0o7x8PZ4tKfmb3UgbrYiWuyziDe/KYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5099.namprd11.prod.outlook.com (2603:10b6:806:f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 10:06:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 23 Sep 2025
 10:06:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "avihaih@nvidia.com"
 <avihaih@nvidia.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOCAANsXgIAAATaAgAAPTgCAAKChkIAAcAiAgAAJPECAAAO7UA==
Date: Tue, 23 Sep 2025 10:06:58 +0000
Message-ID: <IA3PR11MB91363D704481F36A2F2A005B921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
 <4120d83b-9f84-466d-b359-d73a3e7192a8@oracle.com>
 <IA3PR11MB91368B78D35566353217B544921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <54480877-bdda-4acc-be44-b09ed141a00b@oracle.com>
 <IA3PR11MB9136C05AA0D42A3010D7C3EB921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136C05AA0D42A3010D7C3EB921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5099:EE_
x-ms-office365-filtering-correlation-id: b8cc6361-cb43-411c-6d7d-08ddfa88eeef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SnNDY3lFTmxsdDIvb0piS0J2Z250NE5pSVpqZVZoRG9vdUdWNTFPb1JJRy91?=
 =?utf-8?B?QVdQRWI4S1M0aEdobkxVc2UrWCtoaXRGdUxSdGZBSXJzYTYyeUwyU1NBU2s2?=
 =?utf-8?B?anFDemlLZWVLdWZubHJhV0RzcEFIb0czd0JuUlovVkhQT1RrSkdRYms4eDZ2?=
 =?utf-8?B?RlhCUDduTU13Q0h6TTVBYUtVbk5BV0xiaTdVZlpnb2FFZG91MEJObjRSNWl1?=
 =?utf-8?B?SlFPdUhJeWUzTDRBbkV6TW50WHlnV05rK0JXWGpEVk5jRDdYMHhTUzBXQjdI?=
 =?utf-8?B?Y3J1Zi82NFo5Rm9jOGh1clVqdkU0TzdwcDVSbGVoTGZNYVBGanpCY1dtdTIx?=
 =?utf-8?B?VWNsL0NYRndNd3JlYWRjZHlVbnVoT1VKRkVod1lNRXdEclExaEJzengxbDAw?=
 =?utf-8?B?NHg0dE9yQXhyaVYrMi9CSjhPdGFsRjZpM0Y5ZXdORGxBWldoeFZSUitucHVB?=
 =?utf-8?B?ekhVMFMwZnMzUExDWEI4cjJIT1E0QkRnczllVTdHQnZlQXNqcklhVnhHR1VU?=
 =?utf-8?B?cjB4ME9NVThCdUtWWG5LK1BCME41eGdVNS9mYXlVT0szbzQxWC9GS1dENGJI?=
 =?utf-8?B?Y1l6RUp1dFN2SUZvdkdPTWtVTE9pTFkzTlFUc1pVeHU1K1lkU1JOcjZ0eVFF?=
 =?utf-8?B?MzR3bVRUMU1NRnVXaFNnb0RkdGhDVVFPa2dLL3YxQytjNThGem96M1VXZ1dj?=
 =?utf-8?B?aVU4VFowNVFXZ2ViWWM0OEZOckVFRUY0M1JYRHhMM09ET1lRT2xyMTFJVGhP?=
 =?utf-8?B?V1BveUNORWVDT1FLenY4TFhkc21WNU5mR1l2Q3Y4cXNLL0thT3RTNk93dzdB?=
 =?utf-8?B?b2RIN3grZ1A1aU9oaUFUT1FsZ0IrOXAvcTNudlVuYnFPcEN6U050NC9Kd20y?=
 =?utf-8?B?UTVvUlVYOVNyZC92N1NaOEgzOEF3SnpOVmNXUXh5eEprYzdzb2w1ZWhMYVk5?=
 =?utf-8?B?Y1RGSnpwZlVwVENpWmgrT2lvcXlhK3hyREFUem9IV05Cc2FhOVBNYW9CL3Vr?=
 =?utf-8?B?TWVEQVR4bm5ob3Z6WjUzN1EwZE1RaDJEdENZdlhhb1pyOXBUZXJuK3p4ZU9E?=
 =?utf-8?B?RW01R3B6N3Y1UHJxa3ZXVXl3cHNsT0JRNzQ3WUZZLzBZT05zbTJPTGdLenlp?=
 =?utf-8?B?WWdPc3RJWHhvVHlUZkNHWm16ejZuamFLWmpJNk1qYXYrT2RhT3YrazdMV2ZY?=
 =?utf-8?B?RndkNzA1Vk85ZGJlUVRwYWkzVGZXN2tUSjArbWo2VmtuNldOMTZkdi9vWWg3?=
 =?utf-8?B?bExubEk0c1NySk1wOWU2V2NXbEVCOVhOZnl2UnE5ZWJrWTlZY1FweGxYY2Vl?=
 =?utf-8?B?KzhQbEJsdHhxb0ZQTTVJU3NrODhNbXRCMlBFdm5ndVBwcCtMOS8xOHBESFBX?=
 =?utf-8?B?VkpISytWL1ZkRld5NlY0WUQ2a3owb3BGZ3VpVHZMeFFkaTBxSHNpaVdtUE5q?=
 =?utf-8?B?SnRVRERWckpINENuSnRETEt5VllpeDBTSVd2VVlDT2g3WnpMVVprZHg3aDRj?=
 =?utf-8?B?bjgvTTBxNVlBWUhXclRrbC9XSGZVcUR3cjNpQ0NMUHQvcjBlcUhaOEVUckpM?=
 =?utf-8?B?NndBaGtZdXN1STZDN0hnMCtvdmRzaldCZHRZeFB5NC92bk5mZFRaSjFad0lB?=
 =?utf-8?B?S1d6Ynh2eXRqcnRLSmNaLzZ1d0Q5anMra1lySm9nTklsNCt2dzFSUStLVlRH?=
 =?utf-8?B?TGhjbUZXbW84T29jWWs0UFN3M0RZZVIrVHR3UFd5b3ZQSm5jNDQ3aXlaVEdk?=
 =?utf-8?B?OEpaSk9WaFdKZ3g0Mm5RVU16YTJFME1mT1VXZVJtUzQzL1BSZ2thWUo4TWtT?=
 =?utf-8?B?aEJmK1FrOVlEYTQxNC9GYkx0Vlh3MzNxVzgxTnFxSFJqbVJrQVA0bE9kZWEz?=
 =?utf-8?B?aVVYMHJxTDl2dHE0dENZOUY5cTNEa1daV2xQNEtvZWdEeU1CVm9uekNxSnNo?=
 =?utf-8?B?OWdaaGRtRWo2bnpoaVNiWmN6VFdyUlgrUWpCUk5wM3NBOUJRWmRpWmRKRnQr?=
 =?utf-8?Q?WjrvaN7Dklq4tp5Xqi5c8haTA22IGY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekNLS25RWjFTaEVnVWVIbUczc1Rwd0k1OHFZMmhNc1Jra0tyNXc4U2s4amRn?=
 =?utf-8?B?WDFKa09aVG1Oa1JkTEh2ZGxGS1BteEQ0NEx1Njg3VUI2SE5aNHR2dkFMWjYr?=
 =?utf-8?B?SDR0dWxHWkhGUGRLOWVuTnpxK2E2TE9qa3o3K3BEL3JVaGJGK2pObzBEOVVB?=
 =?utf-8?B?eDByamRBVG02SVgrOUUrUDZXajRKd1k0cm8yR28rd1ZwZ2djUkhGYVU5RkYx?=
 =?utf-8?B?em8wSU1ZQmVVQ0lWdER1SmxYZTROeEZEYTl5bE4rcTVNR1EzOFRWeFVJTWdJ?=
 =?utf-8?B?TnlTeFV1dFQ0ZE4zQTR6L2FHcGdmT1NiNUlkNGRHVEkweTFGNmhpbGVMLytz?=
 =?utf-8?B?VGNOWTBZd0h5WEZualRBSGE0eWRaSHZjS1NvY2QrdUgzT1BrbjVhSU15OHJh?=
 =?utf-8?B?SzRocXFoR1JEQzhscC9TOG1LZ0cwTHJEU3NDSTRIUHN3U1gxaW9ycGl6Znc1?=
 =?utf-8?B?a0k4M1VXRDh0RFhhKzkwQlo0MmQ1R1dBKzV6bitKZmpiZ2YvSnZXMkdtVnBU?=
 =?utf-8?B?bjVETnBNYW9OdjdJRkN6aFlRVzVCSUNqSmRIYXcvUERCMkxRU3hoa2taTVU2?=
 =?utf-8?B?OWZvVURuaDVPeHYzbXI4R3I3MFlCV0lZQXltMnNaeGh0eXlseUxKMTFoVHds?=
 =?utf-8?B?Nm81akdRTElWWi9oZ1NGUitXSXdMbEtIV0N5WHhvSWVXbi9jWDFpQU1VSHJW?=
 =?utf-8?B?dm95ZjhTaXJxcStyYVRoTzI5elNHRHpPVENPeVBjaDJsbkJ5bm1iY25EWkhN?=
 =?utf-8?B?RDFuQmlMcERNNndDWVNhbGFSWEZDSTlEVytQQlpBdTB0TVZpRGdHd1JGVHJj?=
 =?utf-8?B?MzVEYUYxeTJuU1YyVGFYN0o0aGNDcGd1dVVocHdnUFRtWHNBc3VmdGxsQm5y?=
 =?utf-8?B?UHBmSnBqMUFYQnNWV3ZsS2ZnMy9XZTZHc0Z0RGxkdmJrRlVGRjhJc1phT0FO?=
 =?utf-8?B?YjIzZHdpbGxoc3lIaXlJVkw4em1MT3lCaE43ZGdEeXJGLy9YQWIzZTAxTEh5?=
 =?utf-8?B?bHQySURIUFZHVVdxVndnYzZWbi9KY3dzTGtuUjk4YU9sbVdwKzZNd2FDdXFL?=
 =?utf-8?B?MDBjK1dLaDZKT1BQdWtaTFVJdjRZTTF1UXl5eVJZa01YcFZCdDU3Ti9tSFVD?=
 =?utf-8?B?ajlvM0lIVyswQnBHby9yNS93cEdubFJ0RjRFdDhaaERNcW5IM3hRTVJvQ0Mx?=
 =?utf-8?B?RUdkRW9yMnA0WkNqcFR2bDlDdHVoMmtCT1ZHMVJkK0tIalFzNWJLTG9UZTk2?=
 =?utf-8?B?a05oNVV4RUdtRjZWTEpOREZidFZYWm1NcnVnak1XS1NpNnBsb1RVdURyRG9P?=
 =?utf-8?B?bmVTWUw0SVBLcTFKaHBIQU9QeW50WndjNEJ1dHZMcngwdUhROURILzg3NkRz?=
 =?utf-8?B?VG0xNVdQalAxYzVjMmVFMUV3WHNlQUdqREt6NGdWblZQbGlEdUhrdWlKTGpk?=
 =?utf-8?B?Z3JXckNBNFdNWU1yMzd6UEQvcVdWbmQvWlg0citGVmJjNERnempSMzJFNGoz?=
 =?utf-8?B?cC9qQXA3OHJqck42SVRTVnc1Q2NLMjhPK2pQNnRpRlc3Si8rSkNJdUlpcWJO?=
 =?utf-8?B?MVZoUDMrSlpNMXU1dUlPbE4vaE1yTkZCUk9hek9qazZmMWZzaFhkMTFFcDZY?=
 =?utf-8?B?dlRlZHR5dXcrYzlocTF3R0JlNFpLMkphOG0xa1JUejUzWlVXWEZqbWYzMXla?=
 =?utf-8?B?Wll3RkhVZXp6bi9oaFB3ZzNYbkNLOWQ3QnVkazBoQTZqaThJc1BWSWpTYlFP?=
 =?utf-8?B?TVdnVDcvOGhzdElCNk1CcGxoMC9nc3FqWGdCaHhEOHdHM2hhb1lDNVQwa3Jr?=
 =?utf-8?B?WjJzSGhwSThpbWVlaVJSY0ozYTArZ0lVNFJlaCtVQWpubHhLV0s0dGxzU2ZP?=
 =?utf-8?B?dWVpNXh3ZzFoS3hYajRFMVBLNS9hWCtCc1ExVlc1R1NqMnNRd0YxQXQ4cSt4?=
 =?utf-8?B?Sy9rWjBBUkJoWFhQVktYUXFMRzhCcENxbDRJUlFQZnRVMEZiTEpXaytYYzNR?=
 =?utf-8?B?Si9VaEtxZWQxYTRnVTUyUFpMb09WS0tvWVpXcC9MUUFudGxObjk1UEdTa1Jk?=
 =?utf-8?B?S2hLTEgvM1NGNHJRTFczNHpuTlRza0dtWnhWdFRNVjlKTU1tdXpRb0ttdk5r?=
 =?utf-8?Q?xyS+2hfVT9//LMJOaRgSXOaqw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc6361-cb43-411c-6d7d-08ddfa88eeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 10:06:58.7015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHzQ38fsh6jw4Na+2QAhTGF0vhF/RSSGPPbtmZ7C97SNGGAIw5KuB6D30jTQabfW+Mu0EJVIfsj1rIDeDnhRWIoDOUqSHukB99tV/F+WARk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5099
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZw0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0ggMy81XSB2ZmlvL2lvbW11ZmQ6IEFkZA0KPklPTU1VX0hXUFRf
R0VUX0RJUlRZX0JJVE1BUF9OT19DTEVBUiBmbGFnIHN1cHBvcnQNCj4+VGhlIHVnbHkgcGFydCBv
ZiB0aGUgYWx0ZXJuYXRpdmUgaXMgdGhhdCBpdCBzb3J0IG9mIGxpbWl0cyB0aGUgaW50ZXJmYWNl
ICB0byBiZQ0KPj5zaW5nbGUtdXNlciBvbmx5IGFzIG5vYm9keSBjYWxsIGludG8gSU9NTVVGRCB3
aXRoIHRoZSBkaXJ0eV90cmFja2luZ19mbGFncw0KPmlmDQo+Pml0J3MgY2FsbGVkIGNvbmN1cnJl
bnRseSBmb3Igc29tZSBvdGhlciBwdXJwb3NlIHRoYW4gdW5tYXAuIFdlIHNvcnQgb2YgdXNlDQo+
PnRoZQ0KPj5jb250YWluZXIgZGF0YSBzdHJ1Y3R1cmUgYXMgYSBhcmd1bWVudCBzdG9yYWdlIGZv
ciBhIHNpbmdsZSBjYWxsIGFzIG9wcG9zZWQNCj50bw0KPj5zdG9yZSBzb21lIGludGVybWVkaWFy
eSBzdGF0ZS4NCj4NCj5kaXJ0eV90cmFja2luZ19mbGFncyBvbmx5IHRha2UgZWZmZWN0IGR1cmlu
ZyB0aGUgdW5tYXAgcGF0aCBleGNlcHQgeW91IHRha2UgaXQNCj5mb3Igb3RoZXIgcHVycG9zZS4g
QnV0IHllcywgSSBtYWRlIHRoZSBjaGFuZ2UgYmFzZWQgb24gdGhlIGZhY3QgdGhhdCB1bm1hcA0K
PnBhdGgNCj5pcyBwcm90ZWN0ZWQgYnkgQlFMLCBpZiB0aGUgY29uY3VycmVudCBhY2Nlc3MgaXMg
YWxsb3dlZCBpbiBmdXR1cmUsIHRoaXMgY2hhbmdlDQo+d2lsbA0KPmJyZWFrLg0KDQpJIGZvdW5k
IEkgbWlzdW5kZXJzdG9vZCB5b3VyIGNvbW1lbnQgYWJvdmUuIFllcywgSSBwbGFubmVkIGRpcnR5
X3RyYWNraW5nX2ZsYWdzDQpvbmx5IGZvciB1bm1hcCB1c2FnZSwgbm90IGZvciBvdGhlcnMuIEkg
ZGlkbid0IHRha2UgaXQgYXMgYXJndW1lbnQgYnV0IGEgbm90aWZpY2F0aW9uDQptZWNoYW5pc20g
b25seSBmb3IgdW5tYXBfYWxsIHBhdGggb3B0aW1pemF0aW9uLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

