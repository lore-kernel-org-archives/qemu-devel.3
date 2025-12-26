Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E97E8FDA1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 07:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2Q3-0005WN-Jr; Fri, 26 Dec 2025 02:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2Px-0005Vg-FX
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:39:21 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2Pt-0000xy-Uu
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 02:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766734758; x=1798270758;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Am4zTHwbcCxEQAAd+1jwgWjhZJ0mH1U5SiZyt6qCJX0=;
 b=eDwPkwmCteHUaHLAqaNDi37WlFr/GKDlwGEKifVvLfjQIJFafWw9DoeZ
 wehA2kYsfcvrJj7fUHJmspFQ7KXC5qw0MllAz93J9hcrYrVWVtN95n2jK
 j8vs0D6RwKo1d8gczptXvvL8c1bV71M9wldIwVfmgzQyvcykNh+4yqfi+
 mcGVd3ZMWtQaTFljeBVDxXlB+vpJqbuSYNcbivDsxHUek9tXFP6jIH8JQ
 ++UjiiK3xhlyFSdlP0DcLorQKbIU91iNpW7loYOAlpmwqvqaCCScxme3j
 JwWi1vgFaiK16ykzIP4XPN1jK0Op9H5za/jvUoQRF7s34SRIHyoNUdkxb g==;
X-CSE-ConnectionGUID: 8vvphhNiSpqnN6Pg0HJelQ==
X-CSE-MsgGUID: U8eu0Ns2TRqLEVX14qZBGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68482831"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="68482831"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2025 23:39:12 -0800
X-CSE-ConnectionGUID: 2uZrSWwLTbWDLggdLN6ePg==
X-CSE-MsgGUID: N7PUitL1SviQCTjGDcxwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="231412205"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2025 23:39:11 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 25 Dec 2025 23:39:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 25 Dec 2025 23:39:11 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 25 Dec 2025 23:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJargA3mypsKBe0N792A0xyl6vlFV8BYBW4bwCPaLOLQxjg1R1Z+7P9S1Jd68q7TafXudJf75VHbcKAaNK0FQJon5i25FbtHr9NuOYROI3gv2qcvdkA1VqydxgmDJNM5lxMmNKddDqP1OGUcs8cndtS/8gc/duy9oVaGTDwnqqdn//Gp+b3faqlwrcI+lPxEDta/on52+BlkX9/DlP1aqTZ7praVi4qMeSPo7O9QhTcCiWvdKXq1Z4navxZNBfhlAIfBRwGTN8nKCHnI3DdekPpjz9pGWRqcUHT0KB9NhaVoWlI2aWPYGbWqORd+x1exBcNK23iSVCtGM0Dv/BMQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Am4zTHwbcCxEQAAd+1jwgWjhZJ0mH1U5SiZyt6qCJX0=;
 b=hPFOFIfhGVBZ9FWhiSkrnJCloqvSfZ4aVFzbBGUfhTctvur++B+fSecpsh2wjz6t5E6ldVfcBE07F74XVkhw31mFxMU9HWIrtmdRZZ9HE73U3Bb9tVgmwIPEUcEYyDjbDBtOeiwgFs2FXkCOCbP22wR5pOjqZUJEQWOpvqO0BkVszK7QHxlalcalKrNjt1bzx0pN3tEyFqfZaLi13g3tLpgsWA9qTFFR1C/x2e6Q/Ga86GX/M9H30i38hRylfc4amzsgWS+HNypQ11ibC3gdBORQjzF5mDGKd7BPwt4gTZ3+cGgCe9B9H+ZSleTnaT3buobVoU95yxgVCMPBOl73ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 07:39:08 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 07:39:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "devel@lists.libvirt.org" <devel@lists.libvirt.org>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "clg@redhat.com" <clg@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/3] conf: add support for 'scalable_mode' and
 'first_stage' attributes to intel IOMMU
Thread-Topic: [PATCH 2/3] conf: add support for 'scalable_mode' and
 'first_stage' attributes to intel IOMMU
Thread-Index: AQHccA47qXi9zJWsN0mX4CQPdSE8gbUnQj8AgAxQ3XA=
Date: Fri, 26 Dec 2025 07:39:08 +0000
Message-ID: <IA3PR11MB9136424958A27E048C9CFF0D92B0A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251218110449.53658-1-zhenzhong.duan@intel.com>
 <20251218110449.53658-3-zhenzhong.duan@intel.com>
 <aUPk4f8PU1uenVN-@redhat.com>
In-Reply-To: <aUPk4f8PU1uenVN-@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: 9c338456-bc5e-4d5c-6434-08de4451da9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TnlvSDhYMUpvMlIyL3htaEdCMEJqa0I3dWptY0xUVGJIQVpidGxFbGliWktJ?=
 =?utf-8?B?Z2JqSWFrVmR4SXB0aEplWUlkS3BhQmtjL1FVN2Y0WkQ1RS9kNUZDZVRYM1hw?=
 =?utf-8?B?MTRiV3dzWVNyc2F3WmhjeTJhdVNlY05KRTl1TVIrNlZvMGd1NVRmNStqdW83?=
 =?utf-8?B?eTJKVTFsZWVjbGVscS96d2VQSk9PQjlyVVFnaTZOUTduYmN0VnAxK0h0WmUz?=
 =?utf-8?B?QjBoMjY1dkNDVkVsUVJJa2M4VGhMVGpHMUwzekZsZW1TNTlDWFdpVjREUUl6?=
 =?utf-8?B?dXdtR0VXZXZnQW1oMkdHM2RDYUREdWU1RWdKL0MxaysveENva2pPelRvNVls?=
 =?utf-8?B?ZU9wY2N5dWxSTUtKSzFrQ00xZ2g1N1g3T1VqOXhRR0lxdHQ0dmVqN2tDZnVN?=
 =?utf-8?B?V2RrTkF0SXZQM0V5OGVWSlFiNXlPNmQ3TS9ZQVp3UlIvL25ocG5ZTVRHS1hQ?=
 =?utf-8?B?YUN0bFRCWEliak9zV285YitYS3cva3lWUEVUblIzUnJ4S1djblR2Nkw3aEsr?=
 =?utf-8?B?cUZDR2ZUb0RzY3hNNC9idC83VFhXOWltQWlKYkdVVlFnU1dYUm5aWEYvcUtN?=
 =?utf-8?B?RmNGNzMyYVVJWkFWYkNaU1E3bG5qZXVmZjh0WFJnSkFYYTBoN042dVhWR3hY?=
 =?utf-8?B?UHNqZVlMS1VNSEI1UGt2SW1lRFpmVElrUDRhTUpZNzliOGxWcDI1S01QQlVq?=
 =?utf-8?B?YkcwR0Z0UGd4MnZHdzZVSDdzQzBvaGZNc2VaWHd6ZHd0Ulh6VFpKRGVwdC9P?=
 =?utf-8?B?UXU3SEFYQUJ2WEtWRE9LYkVWV2pWVGRYaXhKN1hLQWE5eFBkMmFoLzFqUmJ6?=
 =?utf-8?B?ZDhFSU5ySVVFS05nb0VOUmVnS0l1ZFdXcXJQQ0d4eld6dE0xUTNQZ1pIYWF2?=
 =?utf-8?B?VFBiWGtCQnYxanM5clpVYXB0T3hmR1BFSFloZWxIcWxNd29XMGpJRmtnNXlR?=
 =?utf-8?B?YkRyaThIMlRTVFN5b05vTmlTSXFmYkg0bDJDVTBTUVF1TkdLbWZBNHlvV00y?=
 =?utf-8?B?UWJ2MjFqZWlQcFRjRVlwUW9tNHltY0lRenRCQzNXRTJxRzJsZk5OQTY2Y0JJ?=
 =?utf-8?B?Yy9teWR5bUIzNWpaV1hPdThUdjhBdnpSbjVBdm4ySHlQSXhYZkx4cDJGdFFL?=
 =?utf-8?B?KzhqdWJuSWlGMVFPcVRNanYvK3lEUk9sMHJTUEhZbEtKeml0bzAwZEUyMU5r?=
 =?utf-8?B?YVkrRXFMMEduUHZiR2NPUFJKKzVFWkhuRXpzUXdhVThUMXlXQk4zeUNsSnBn?=
 =?utf-8?B?YzlSSkdTVjJkYjN0aEVRaGx5OEhBcHZZcGhxVXcrRzE1aGdWSGFXMXpuSU9T?=
 =?utf-8?B?UjFndUkrTzYySjdXTVNNSk1aYi9vZzRpQ0lSSE84Y1RqRkxId3loUEJyakxM?=
 =?utf-8?B?NHYvWFJXeHM3ZkNhS1J1MWpGRW5EMmh2N0kwN0FocDU0MTJYY1d0SzJjaks4?=
 =?utf-8?B?ZTVYd3h4Snd2VjJIZnNoWVh6U3FqWFFOTUNQSFVsS09jdWhudy9IOUg0SUdH?=
 =?utf-8?B?bVk4Y2M3TzM0Mnc0Rnhxa1hZM3Vzem4rNmtvWkZ1S1czY3RYbGtncytMQmdQ?=
 =?utf-8?B?M0ZMYzQ0cy8vOHhHMVdibWF3bEQ0bUFWb1lSWmlHUzdXQnFoU1dDdko0MmdW?=
 =?utf-8?B?ZWx1STRDSzJzTVQvMVgzbG1OazIyZjAyRXBwVG1BTEtlL2M1RTNMUXBKS1p0?=
 =?utf-8?B?UkxETzMrTFhFR2pKcm00UERxeXhXVlhiMktoNEZIdjZnRzdITE9JWXhBOW9J?=
 =?utf-8?B?MTlMQVBFMzlzTFBzOWpQYUs3dVdkWmZ6cUFzSjUwV0dXM1dxaDhJOGN1V1Ur?=
 =?utf-8?B?eFFRNFQyZE1pM1lMR2ZaaS9mdVlITFEyeXk0ZERyZG5zM09BWHQzUE5BeFBo?=
 =?utf-8?B?L2hCUzh6dzFHMjhrcWtaOW9RRGMvd2hmMnRkWVp1OFV1b0pyelpERURvNFNp?=
 =?utf-8?B?UFRhRWtrUUxXREhJL3ZVbWQyajUraTJNeHRjbEcrL1BPNEY0UEc1N0JOZnl2?=
 =?utf-8?B?OHU5SW02T1Niay9sbVV4V2lCOEZSRGFIVExyeXptV0hxNDc2YVFadFphemUw?=
 =?utf-8?Q?VREfic?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFEwck9ZU2QvVEI3ZGgyVGdSN2t3S0E0dFVtMkYxUzN1YlBPSnFRaWFkanUz?=
 =?utf-8?B?WWFKZlhFVk1aS3hKb3BZODk0SklXbGFnRnQ2ZzZKMG1MWk1ad0ZoWGtENytB?=
 =?utf-8?B?L0czZXRwMTA3d0lGeStNQzBra1lScjFtK0E5ZDczaGN3aytlSEFBUWkrM0VE?=
 =?utf-8?B?ZzJZeEphYmcxYzhiSlFLZ3FPcXlkQis2TXZEQzkrWW1xNmJoTHlkaEFrK3JO?=
 =?utf-8?B?ZEw0VlJOMENmRGdxbUZYZlVwZlRSdlAyWXh4c3AzZEJTTmxHS0pxRTZHc2wv?=
 =?utf-8?B?K0tIUnh3TUtqdVdsN0hNUXZ0T3hnMXNBa3JuRUJ1bUU3S0hyZjlVR3orbkM0?=
 =?utf-8?B?S0RnY2VVRjR5dG8rV3JUQWxzOURuYTZUQWJPdWYrTUo2VU9yR1BSZDQ5Q1VO?=
 =?utf-8?B?U2xzSk1iYitFS2FYUGFYSVhORTZkalZlMXJNVGVsTGJlQ3J6TzE4MjR5LzFD?=
 =?utf-8?B?Z3ZmZTNxMGNGWlFIRjNpSkxxdDdLQ3pPTlJiRUtyMGFMUE5EUU5JNnhaSzNq?=
 =?utf-8?B?cElLK1Y5QVo5T0tITDVQdDNZQUhJSy9wcG53d0hPWERsdDhKWE56bldUQ1FT?=
 =?utf-8?B?aVVJeWdEOForQ2Fwd2djOHNQUzE0VVYvU0JXVVdsT3B0YXgvemEzbzdIbTJV?=
 =?utf-8?B?QmUzb3pwNmUzK1FwZXhBWDVSVU01RmRnVU9lb0hzZGYrclNDSzBTUlBsV1hn?=
 =?utf-8?B?bmo4MWFvcXlzYTNNQTRiM3hHTTRTTytMajQyUU1wckZQR3M3NEY2dFlJb3ky?=
 =?utf-8?B?NW9ETUZTcEl5Q20ySWVMT0dZRURNTjM4T1VKV1owbytJVUtFNDJRaWJPU0d6?=
 =?utf-8?B?QUxLbmFMZllLS0JycmtKTmVvMjc2OURZeTZQN3VHU01sLzVuZTFJVVhjQ2Rp?=
 =?utf-8?B?YUY2ek9LMmVmZElwT3hjalVmSHFnWExaeDQwamFvMStLRkJlQ2VqeTlVNmor?=
 =?utf-8?B?OUJYTGdOc2RsZFQ5b3BlUGtnL1JRRWFhVE5HbHdwVFYwamViS0wxaWI5S2Yw?=
 =?utf-8?B?OGNza3VkYm5XQS9pWjNJY0EwNXNyd3U3Vk9yNkdlaFBKRzFvTEI5S2M5OTBB?=
 =?utf-8?B?OHFRZmJhSE5INDg2ZlFHLzIvbWZkV2VHY1lSaGJ3ZDhjdmtIdnZ6OWpUR0NH?=
 =?utf-8?B?anExYi9uU1FDMDQ1U3Vidk85RjN3dkY4c2txUXBsVjRDaUl0SC9vaFFLaTJ6?=
 =?utf-8?B?eG8vSWlLYkErUDViQWJsanVTckRyTGxiU2hvTURSZUpnajlSNVdFMUpiekE4?=
 =?utf-8?B?bUp0V2dmcWg3TjUwNEc3YVpjVFczdCs2YXRZeVd3UEx1Vm1HK1pNRURVUUJL?=
 =?utf-8?B?dlZYL1Vabk5meXlWNzVHdENZWjRsQ25TV1dlb1pHeXpRTGZLV0hBcFo3Q09v?=
 =?utf-8?B?U1pJdUhBVkNCWGcyVW5UdldrL250b2pDNDRJYnJiVWpsZ2I4MzJzQXpCSTlI?=
 =?utf-8?B?ZnFXdnp0YmpveEtTNktIcHlTN05pQTVoaXRSUVQ0ME1TVU5od2k3dlROdmN0?=
 =?utf-8?B?ak9Vc3JmRGRUSU81MHJRWHBlTzYyck9VT1VXb3NjdFdLdlhvRWN0QWdrYVo0?=
 =?utf-8?B?dzM1QkdkTFRKcDUwTG1uUmFRVnNUM3YvL0NzbVRyMy9XU013bnpoVjFQU09H?=
 =?utf-8?B?UW91Z25XelpSUkowOEZlRjZqZENsSXQ1K0VVMnJpV1VjckM4b3d5c1VEYXFI?=
 =?utf-8?B?Y0pFeGt0MjdWU1ZyckVZNVhaeVM4c1BSRC9nM08wdUZ2akxnOThIek95VFNa?=
 =?utf-8?B?YnZ3cE5IdGlMV3lIMEFqellwWi9LWm96VmNlRlZQNXJ6TmM1WUhibGxOaFJ2?=
 =?utf-8?B?VElIRUlobU8zRmhqSDFNSVFpZEJyRFZnVjFMU1dxcWpBeXF1amdSRUZJeGpk?=
 =?utf-8?B?d2N5N2U0RlBBa3RIZDcrbE4zT3R3a24yL09PanIxSUt3WVVLaTliTHg3T25E?=
 =?utf-8?B?WTZZYWRkRlR5WGJnSmVZeC9mTXQ1Y1ZDaS9Mc0kybWROZVJsK3ZBckdNcS9l?=
 =?utf-8?B?U3FaVnBLTUx3WXZSWUk1dWdLcjV3azl1NEtYTFhYK0J3RDdROFY2dDgyaExH?=
 =?utf-8?B?R3ZhcXlaK2IxdEN5aWw3T0ZGYUdmdlFjK3hVc08zcUkyNnBYUzBKcXNuUWtt?=
 =?utf-8?B?NDhYOGcrd1kyd2hZckRPQTE5VlE4UHJPYW94THhIalZ4QjQ4V3lOelRlcnZ2?=
 =?utf-8?B?ZlRUUWNsSzhXTEJ1SXNXdWNiMER4aHUxMHpNemgydFF3OXZyMEp0Q1ZCaC8w?=
 =?utf-8?B?MU8wWWR5WCt0Z2hJMXFWMlZlS2wraVkwUzdORzIvRWhWak5RL0l1b3BVOURR?=
 =?utf-8?B?L2VMaXl6aG9xT2tzM3o4aFJmZUhqTWRGMnA0SGltSlZSbmZXOEdTQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c338456-bc5e-4d5c-6434-08de4451da9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2025 07:39:08.3647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: senepmgKBOyXwiedECe10y2LdalRZmf+AXKgtw3SkMfspPG7dQzU+yeFc0HVcJWeDkBPAqeT71CU9aMfkOfCzEIwRIzAmyWM3LbemxcjbuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvM10gY29uZjogYWRk
IHN1cHBvcnQgZm9yICdzY2FsYWJsZV9tb2RlJyBhbmQNCj4nZmlyc3Rfc3RhZ2UnIGF0dHJpYnV0
ZXMgdG8gaW50ZWwgSU9NTVUNCj4NCj5PbiBUaHUsIERlYyAxOCwgMjAyNSBhdCAwNjowNDo0OEFN
IC0wNTAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENvcnJlc3BvbmQgdG8gJ3gtc2NhbGFi
bGUtbW9kZScgYW5kICd4LWZsdHMnIHByb3BlcnRpZXMgaW4gUUVNVS4NCj4NCj5UaGUgJ3gtJyBw
cmVmaXggb24gdGhlc2UgcHJvcGVydHkgbmFtZXMgaW5kaWNhdGVzIFFFTVUgY29uc2lkZXJzDQo+
dGhlbSBleHBlcmltZW50YWwgLyB1bnN0YWJsZSwgd2hpY2ggbWFrZXMgdGhlbSB1bnN1aXRhYmxl
IGZvcg0KPmV4cG9zaW5nIGZyb20gbGlidmlydC4gIFdlIG5lZWQgdGhlIFFFTVUgaW1wbGVtZW50
YXRpb24gdG8gYmVjb21lDQo+ZnVsbHkgc3VwcG9ydGVkIGZpcnN0Lg0KDQpJIHNlZSwgdGhhbmtz
LiBJIGRpZG4ndCBrbm93IHRoaXMgcnVsZSBiZWZvcmUuDQoNCkNDaW5nIHFlbXUgdnRkIG1haW50
YWluZXIvcmV2aWV3ZXJzIGFuZCBxZW11LWRldmVsOg0KDQpEbyB5b3UgdGhpbmsgd2UgY2FuIGRy
b3AgJ3gtJyBhcyB3ZSBoYWQgIngtc2NhbGFibGUtbW9kZSIgbW9yZSB0aGFuIDUgeWVhcnMgYW5k
ICJ4LWZsdHMiIG1vcmUgdGhhbiAxIHllYXI/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

