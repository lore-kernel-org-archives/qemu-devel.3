Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FDDC52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 05:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seTNf-0001pR-R9; Thu, 15 Aug 2024 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seTNV-0001TR-K3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 01:50:33 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1seTNP-00061M-CS
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 01:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723701023; x=1755237023;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/9HvYFxnxPZ7nSqQnexWOHVUSqScu+mbFMx7Ps+CWpU=;
 b=eyT+cD9JZxjEDehrPhgkCXyHSHPDPgOSTzF4IvR1LE2YyYPy4lp7jlLO
 tEoAESBIDRFvlsBKsa8/megu2iy1Wn2BiKf17R2O1a8Ecj0JsfkfpzpbN
 41Q4NjDE153gbQrmeO3+RPIVi5QuNKp17phOA5SD6Rw+chXL4cpwcK+fS
 3bn7ZSACX/m5ZZu3/rORqnCY5//eoADopaNBAP9jDNFz96WiZLxKsFXi1
 YfE9gE/01nA8QBQr9lkcs4W3PpxG9vc3gNU/BQa8PwafQFbxMSoHw3S0m
 jdvScCktcXGO85MuBS/Fc5qJIyWhFQhisJA00gldCjk7qA8iMWHmQXzR5 Q==;
X-CSE-ConnectionGUID: cXT6kF3dQOmXcSPO0oGIWw==
X-CSE-MsgGUID: NhB9qLtvSZG2pqiq/wSZ3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21819943"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; d="scan'208";a="21819943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 22:50:19 -0700
X-CSE-ConnectionGUID: McCw1OIwTImK9ID4Ak+eDw==
X-CSE-MsgGUID: 46EpQTy/QcGnuwh0SCWXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; d="scan'208";a="59235632"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 22:48:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 22:48:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 22:48:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 22:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 22:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9BGSOVPqGFv4q2yLEHcsxk5UJOKJZ01SdDSWEGF8jhK0GzkF2G+wkFRsZcm4I1X0yn6bklj6g8ZfBhVuR5k+EQIiXih6bnZd/2HtUqHj0VfzCxMV5POcyiU9+9slBG/WZggsoy+WhsUZBYbqPC9LvNmvfVCBqW0b7uEVQo66xBJTBiYn0QadwSfu9dh8R3pBV2FGYHrb3OrXgQ0E52XXa2/d3PgfmWs5ldy7DQqt8NeaZLaWQe4BWOQ3+CvvEzLi4hLsBWeumk7GB/csgTRXe3h6lWsQvHwvtXqk+VKJV3t0DibU5r8xsKWq8wcvUE3POaJVZ+jlA7Fgu8oRPJwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9HvYFxnxPZ7nSqQnexWOHVUSqScu+mbFMx7Ps+CWpU=;
 b=gai4knUNPfCSGfSBZxt1Qpq4o1g8PbruMOXy6MuWl+2p5RqQOE3aowS7SzUsPZwC/hQ0Q29vUtAw+UujMGUyGh8lSzOhX86yD7UCsejVPv7MALl/cTQAWk9tl5llJR2ZKq8+QeLIl1bwpst75bEMkLWygvhcKkR8V8RH6bfACv8TBmoldg17URuH3ZM3tAAIcFtHkKnkvDU/ArRRKcsHh5/Mp9+xOun2pr5g+HzFhTYljQWKsMvfBkzQCKml1TlobXmAcMP7PTOgGfAztgSIwBPHCYrDg6Q7V869nYX3awU7eObdzmb8y+anDPn8Y9PD5iEJTeVbTphaTIlP+QvlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 05:48:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Thu, 15 Aug 2024
 05:48:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wEJJTBdHO0BpEOuemhd//fJ3bImvxiAgAEDiOA=
Date: Thu, 15 Aug 2024 05:48:55 +0000
Message-ID: <SJ0PR11MB674467998E806C63373E8DD192802@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <2ba9a72a-c68e-4352-90a2-918994f9357d@intel.com>
In-Reply-To: <2ba9a72a-c68e-4352-90a2-918994f9357d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7420:EE_
x-ms-office365-filtering-correlation-id: b5ec2afb-ecbd-48a9-4547-08dcbcedf32d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZlJTWVp2ZWhuZkxLbEgyQVprSE5aYzFpdllhMjRLTVZEcG9UK0dFV05zbTN5?=
 =?utf-8?B?M2RmRkdKMEUxeG5RbUlJWXRPdXo5YWtKRFZlYjBNbDBFOE1YTkpxOUZlU2Ji?=
 =?utf-8?B?M2VzK2dqMWxYbHJadUJXZ3QySDRoTXpINkkzdkY1STg5RnFwTmJwRXh2MlV0?=
 =?utf-8?B?S0dtT0MvVjI3Ym13bXZ1bk8zSWUzYmdwajkvQTl2NmVWMjQ2dVROeWZrMXUv?=
 =?utf-8?B?U3Z6YnNFc01NMnlldHZqdW1aOUNWQmZIeUR3U1NRMzVwSU9yRzUzdjVTNzlM?=
 =?utf-8?B?WklsN1E1Mm1VaG13Y0F0dnYyWHZSNnpyMkg0TS9HMno4NTBYUzNzNTlIVFZl?=
 =?utf-8?B?TXJGT3pPQldqemVTdytTb0lydFQ2bFN4TFowK3Y0ZlpxU1UzZ3hnOUtSUmQ3?=
 =?utf-8?B?dzFtY1doS3MrT09xd2dxdFNmbmR2NzRwbVNLb0NnelgyeE1NaDZ6Zk5INkF3?=
 =?utf-8?B?NUR0cU1CM1dOMXBad0JZVzJFeXFMOWJCSkdBNFJ1MlNvbjRRelNKcklkOHIw?=
 =?utf-8?B?UHRSVFRaMysrcEsyWVVzMnh6Rml3ajMxRnlFK1BQQnF2a092ZlhyOEVlVkFM?=
 =?utf-8?B?VnZUZ3dKdzNGbEp6UGVNVVkzcWY1QU1JMm5Hc0hGWnM0MDFxUEZZakIybEhS?=
 =?utf-8?B?eXJxSm1WWWd0WmcyTVRjVHVHMFVPaHdWSFBpQVkvUUpFaGUrNjQ2QTRJdVFF?=
 =?utf-8?B?RVNLaTBVTXR2bUJhTy9ZcDV2eStTYmdIMlRWSFBOajVQdzFFejBja24xS0RC?=
 =?utf-8?B?VmRhSnZuUTcrdnhRYUFxcUo4ME40WnBNejNmck1uRW5nU1BVdXhoNVRsd0Nn?=
 =?utf-8?B?V0hIOVZjV01UbnpqMHpXUGJjaFNwb3pvTkN4MU9sTXhsQm9RVUU4RDRqY3lU?=
 =?utf-8?B?ZmFUeFpjcnZLOUxScTZhOGNzTlBibi9yclVqZmcxTDM0ZTIyZDdBUVFXN3hL?=
 =?utf-8?B?UFA4bGxOYzZUY3c0UzAzVEl0blJoMDdhTG0xSTM3ZERKWHkvaW9lQ3pqUUJL?=
 =?utf-8?B?YUgzdHhmams4V2tjZmFuSW9zWEtKazVqclZTKzFSWjdYRlBjOVFIODJ5d1NJ?=
 =?utf-8?B?K2t4WDh2T3pLWmNLRFR3L0c3eHJUZ3RpSVJaWmd3b0JRWlRHMXgxcGJJTndL?=
 =?utf-8?B?VjRTcEF2YlUraUZWZmJDKzlCZGxFK3NoK1BaaDlxdnpya0VHdUJjUVZjeVdv?=
 =?utf-8?B?QmdJNEdhTGkyMWJOeFREQm5hOC9NZzd1UUM0bU5zT0d6RHczVVhqQ3I2eTJO?=
 =?utf-8?B?SDl3MGF1VTE0OUVPV2RIOEcwYUVBYTJVLy9aUHFnQWhPMDFLMXRoM0dsZzBF?=
 =?utf-8?B?Sytva0JjSHVYbWdlbEQ3cW5YZmd5QncraTVYNHZrbEtpbzM1NkVtbVIxZFdV?=
 =?utf-8?B?Q09Fbk43WDI4cTB0RlVsa1Fja1dpOTdmZnVoSmZZMVhCeTNXQloxcGxxcWdK?=
 =?utf-8?B?eVpWeVdrRG05WGZwcXNlTnJuZURuK0Q3akVDWHRKZ1pMUno2bFVDRkdDRE1w?=
 =?utf-8?B?R0c1bks1YkZJbjV5dnpSMU8xNGdEOTM1OGtKaGRrSmt0dVkvYWc2cm1FbmNS?=
 =?utf-8?B?ZERnTU5WVmhGOXRHcDN1K2U2LzYrOE9MaE1rRnkwTmRwMFpmM3M2NDBQeWVa?=
 =?utf-8?B?WjROeHVLREZPOUk1TEc0UnVxYmtxaXlXa1Ezb2NOemRocFltaWJCUStOVWx6?=
 =?utf-8?B?M2xpTUM2VWFEdjhsNWQ5cDBYYUlINkM3eEx2R1liTThyUnNWSVIzZ3FzRytY?=
 =?utf-8?B?ellsTDlGYnRyRzhONVArTmI4VDNIMnJXUzF5STVZM2F2TGFwZVZQOWl3d1Nl?=
 =?utf-8?B?NEIyYktVc1JMOUo1aHFnWVlqdHZUMmZGc3JOYzFlLzl1QVVzL01WcExxUTFh?=
 =?utf-8?B?NTZRSTdKa3llOWRNZFF1K1JUSnFyNnRUK2tHeGpuWGx5Umc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0Q0Tk1qNHhnLzNXNkRORnMxMEtuS3ZZWDFWWFFjREFmTW9YNHdpQ3ltejB0?=
 =?utf-8?B?UVFILy83cUtaWm1jUjl2NHVPZXZFWGkwTnpjOFNNTk9XcTAyZlFIZkFUTGVS?=
 =?utf-8?B?dGQ5VEdFMUVyd2U2WEhLWURQZmdCRnBzaGNuVTJSZVpaVExaOXpqSDB3Nkxm?=
 =?utf-8?B?M3pmd1hkQTFqMmNyTVZKY2QvM2RKM3NwZ3lxUmhJSTJNL21jU3BRODl2cVpp?=
 =?utf-8?B?N0pBeFNxTGFYcjl3OU5HSlc0T283S1J2QUxGcDZ3eUJ0a3YvdElHWW1ob2t3?=
 =?utf-8?B?M1Y5ajZaNGoxWENMYUZFMTVEK242K3gwblgrYWN4eStWWXczcFFrU3R4V1Bs?=
 =?utf-8?B?ZkdFd3VNL3FDelIxM1c4MmZMeUVlUC8zbUpmSFdBRVdIb3ZELzFiREVRRzBD?=
 =?utf-8?B?TVRDcUViZ1Zudlh2NVRySDJBVmZjUXdsaHpoL1hnZ0FxemVyRHQ5N2hEdjZS?=
 =?utf-8?B?YTBtenRJT0lxV1U3RVU4bUdDcy9CY2xhM3g2Tmd2Wi93aXpCYUdoR0srblVX?=
 =?utf-8?B?bnBDcHdBNlBWSHNNQTY4QmpmdVhrTTJpQloxdXFGQlZFTVMvL0RXeVhUbXVo?=
 =?utf-8?B?aHAyamYvWEVUZmF0cDBKTHJ5Z0RUMlV3T3RqOVBtdU80eFhvUkJpQnQwRENr?=
 =?utf-8?B?b0RvZzFuNE9YUDJHbDBFWDNNNGJIOUo5TU83b1dRTFlETjVyVXNtb01WZldX?=
 =?utf-8?B?UEYxcGZWTzU1K2h5SjhjbkJoS3hsTHRtM1dvY0ttWmJNV2lFVWhXNGFyQ3o5?=
 =?utf-8?B?NHNqT3VLRU9yVUVHSUFQR1piWmw2UVdvNXRrMmFtTVFYa29aY3FTK0grRmNP?=
 =?utf-8?B?dm9NUjdsWWJMdXVpSVFxb2VPN3NTMjJUMFNDSFViNkJISkowaEFLZzJmVHpz?=
 =?utf-8?B?RURVK1RZTGFDUDJ4elA1SldNdk1WeDJPMkI0U290ZVJEbnhiUmo0STVyV2Rx?=
 =?utf-8?B?VWoxOHJmZTA5cHJCcU43ZDBuOHk1V2MzK3pGN0tCd2RmVlpMcGsxZXdoWHlC?=
 =?utf-8?B?WVRqN0cyeTZocmRRRHNjTmgyNWJzN3hlZWczQTZrTnhtY0JMQzJvMmJ2T2JV?=
 =?utf-8?B?U3Fua1FwUlpFTWUrems3Wmg1cHdnZUUyaGNrU1Nwd0pidmF4MmE2L3JNcnF1?=
 =?utf-8?B?Z3BRMjBhZVp2bEp6a3ZkWkRLQWZPbllqbUREVmgxb0ROYTF2M3JYVGI2RFZz?=
 =?utf-8?B?cWlTcFByWmd0QkJMek5EVWNSck5CWENwTndJNWdobWdGdlVXRDFjNjI4bEFs?=
 =?utf-8?B?SVc4ejZJRXArVU1HZXpHdkVYQ1dpOXBSd01jY3p1YmFJdVZ3bWdlUzZNUkNU?=
 =?utf-8?B?cko1Rkw4RWFNWEJHa29zUUo4TXVhTjB6Z2pXYmRNYWJlZzZvWVFKNFNEeTNL?=
 =?utf-8?B?U0U1OXBrdkZSTlpPOWg4SFE3WlRUZ1gvY1orRDFxdmlERWN3bTBJaWNNNEhP?=
 =?utf-8?B?T0Z5ZjZwYTRXUXRSL0RxcGxzKzc4VUo5MGR2ZVRzVDFWUVpwR011Mm1hbEtN?=
 =?utf-8?B?Y25mTmRCNER4ZUNhSTZ1c2F1TUhrZUpDcHBudzYwMU8zQ2hPT3IrVFBXQlhu?=
 =?utf-8?B?L0RUVzJ0T3cwQnhSRWVxTjJnZ0ZtRjFhL09ZT2FObTFNQXd6TEwrZWJRcElC?=
 =?utf-8?B?ZDZWeTZqTk44alg2bEhPUjZoQjIydzZjMTVuWTQ2czdFUmM1R3I5RVNiUGxO?=
 =?utf-8?B?eXFWQ05CL21kbGVKUkh3N2g1eVU1ZGd0aE1rNE1Kd2M5VThUcUFDUTBCMFBE?=
 =?utf-8?B?dU91R3FaOGl4Yi9HQ0w2R1VuUGpZZ3o0VEV2bVlTeE5ieHlKNHlkSXNrelJs?=
 =?utf-8?B?NE1BWUtzaEphSnpKNklkVlFXMVlqVC9XMEdpWmJ1ZU1mOE1Ga05telV4dWQ4?=
 =?utf-8?B?b1pSQzJEdmo4V2ZHZCt2dDZsTlI1aExQV3JGMFQ5Q0pYMGt2Wk9qbmtMdnpj?=
 =?utf-8?B?dUNqZldINC9HWXV6YzA2Z1JGTGpXNXpROGs2bXFQQTlXdXVjTnl6c2Z1bHJp?=
 =?utf-8?B?ZTJremlKM1FXZitaSHRhMnZCMnpsZEQ4V1JZYUF1TmZicTFBMVJXdnk0c1RC?=
 =?utf-8?B?Q3BidnJNbXlRTHRRaGV1aldXMjdvWVFWR2tVVFVNcERIenA1WjNBSU9qMEl3?=
 =?utf-8?Q?M5IEEEd0hq+hMd6tmq4ohYIZM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ec2afb-ecbd-48a9-4547-08dcbcedf32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 05:48:55.2291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWGOBny6I1t5OwwWfW7d2xLZtyANLpUe/r3znf72IEfofvl9DT46fooIixhRV8Z+2H2LgWm0oA6shFhsYy6nW2NuNQ3J6RgZwd5yEF1RMF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTddIGludGVsX2lvbW11
OiBGbHVzaCBzdGFnZS0yIGNhY2hlIGluIFBBU0lELQ0KPnNlbGVjdGl2ZSBQQVNJRC1iYXNlZCBp
b3RsYiBpbnZhbGlkYXRpb24NCj4NCj5PbiAyMDI0LzgvNSAxNDoyNywgWmhlbnpob25nIER1YW4g
d3JvdGU6DQo+PiBQZXIgc3BlYyA2LjUuMi40LCBQQURJRC1zZWxlY3RpdmUgUEFTSUQtYmFzZWQg
aW90bGIgaW52YWxpZGF0aW9uIHdpbGwNCj4+IGZsdXNoIHN0YWdlLTIgaW90bGIgZW50cmllcyB3
aXRoIG1hdGNoaW5nIGRvbWFpbiBpZCBhbmQgcGFzaWQuDQo+Pg0KPj4gV2l0aCBzY2FsYWJsZSBt
b2Rlcm4gbW9kZSBpbnRyb2R1Y2VkLCBndWVzdCBjb3VsZCBzZW5kIFBBU0lELXNlbGVjdGl2ZQ0K
Pj4gUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHRvIGZsdXNoIGJvdGggc3RhZ2UtMSBh
bmQgc3RhZ2UtMiBlbnRyaWVzLg0KPg0KPkknbSBub3QgcXVpdGUgc3VyZSBpZiB0aGlzIGlzIGNv
cnJlY3QuIEluIHRoZSBsYXN0IGNvbGx1bW4gb2YgdGhlIHRhYmxlIDIxDQo+aW4gNi41LjIuNCwg
dGhlIHBhZ2luZyBzdHJ1Y3R1cmVzIG9mIFNTIHdpbGwgbm90IGJlIGludmFsaWRhdGVkLiBTbyBp
dCdzDQo+bm90IHF1aXRlIHJlY29tbWVuZGVkIGZvciBzb2Z0d2FyZSB0byBpbnZhbGlkYXRlIHRo
ZSBpb3RsYiBlbnRyaWVzIHdpdGgNCj5QR1RUPT1TUy1vbmx5IGJ5IFBfSU9UTEIgaW52YWxpZGF0
aW9uLCBpdCdzIG1vcmUgcmVjb21tZW5kZWQgdG8gdXNlIHRoZQ0KPklPVExCIGludmFsaWRhdGlv
bi4NCg0KSG1tLCB3aGVuIHBhc2lkIGlzIHVzZWQgd2l0aCBTUy1vbmx5LCBQQVNJRC1iYXNlZCBp
b3RsYiBpbnZhbGlkYXRpb24gY2FuIGdpdmUgYmV0dGVyIGdyYW51bGFyaXR5LCAoRElELFBBU0lE
KSB2cy4gKERJRCkgZm9yIElPVExCIGludmFsaWRhdGlvbi4NCg0KSWYgbm9uLWxlYWYgU1MtcGFn
aW5nIGVudHJ5IGlzIHVwZGF0ZWQsIElPVExCIGludmFsaWRhdGlvbiBzaG91bGQgYmUgdXNlZCBh
cyBTUy1wYWdpbmcgc3RydWN0dXJlIGNhY2hlIGlzbid0IGZsdXNoZWQgd2l0aCBQQVNJRC1zZWxl
Y3RpdmUgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uLg0KDQpUaGFua3MNClpoZW56aG9u
Zw0KDQo+DQo+PiBCeSB0aGlzIGNoYW5jZSwgcmVtb3ZlIG9sZCBJT1RMQiByZWxhdGVkIGRlZmlu
aXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmggfCAxNCArKystLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgODEN
Cj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgOTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4+IGluZGV4IDhmYTI3YzdmM2IuLjE5ZTRlZDUyY2EgMTAwNjQ0DQo+PiAtLS0g
YS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTQwMiwxMSArNDAyLDYgQEAgdHlwZWRlZiB1bmlvbiBW
VERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX0FN
KHZhbCkgICAgICAoKHZhbCkgJiAweDNmVUxMKQ0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19J
T1RMQl9SU1ZEX0xPICAgICAgMHhmZmZmZmZmZjAwMDBmZjAwVUxMDQo+PiAgICNkZWZpbmUgVlRE
X0lOVl9ERVNDX0lPVExCX1JTVkRfSEkgICAgICAweGY4MFVMTA0KPj4gLSNkZWZpbmUgVlREX0lO
Vl9ERVNDX0lPVExCX1BBU0lEX1BBU0lEICAoMlVMTCA8PCA0KQ0KPj4gLSNkZWZpbmUgVlREX0lO
Vl9ERVNDX0lPVExCX1BBU0lEX1BBR0UgICAoM1VMTCA8PCA0KQ0KPj4gLSNkZWZpbmUgVlREX0lO
Vl9ERVNDX0lPVExCX1BBU0lEKHZhbCkgICAoKCh2YWwpID4+IDMyKSAmDQo+VlREX1BBU0lEX0lE
X01BU0spDQo+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUlNWRF9MTw0KPjB4
ZmZmMDAwMDAwMDAwMDFjMFVMTA0KPj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lE
X1JTVkRfSEkgICAgICAweGY4MFVMTA0KPj4NCj4+ICAgLyogTWFzayBmb3IgRGV2aWNlIElPVExC
IEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJ
Q0VfSU9UTEJfQUREUih2YWwpICgodmFsKSAmDQo+MHhmZmZmZmZmZmZmZmZmMDAwVUxMKQ0KPj4g
QEAgLTQzOCw2ICs0MzMsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7
DQo+PiAgICAgICAgICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERf
U0xfSUdOX0NPTSB8DQo+VlREX1NMX1RNKSkgOiBcDQo+PiAgICAgICAgICAgKDB4M2ZmZmY4MDBV
TEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSkpDQo+Pg0KPj4gKy8qIE1h
c2tzIGZvciBQSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+PiArI2RlZmluZSBWVERf
SU5WX0RFU0NfUElPVExCX0cgICAgICAgICAgICAgKDNVTEwgPDwgNCkNCj4+ICsjZGVmaW5lIFZU
RF9JTlZfREVTQ19QSU9UTEJfQUxMX0lOX1BBU0lEICAoMlVMTCA8PCA0KQ0KPj4gKyNkZWZpbmUg
VlREX0lOVl9ERVNDX1BJT1RMQl9QU0lfSU5fUEFTSUQgICgzVUxMIDw8IDQpDQo+PiArI2RlZmlu
ZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2YWwpICAgICAgKCgodmFsKSA+PiAxNikgJg0KPlZU
RF9ET01BSU5fSURfTUFTSykNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQo
dmFsKSAgICAoKCh2YWwpID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQo+PiArI2RlZmluZSBWVERfSU5W
X0RFU0NfUElPVExCX1JTVkRfVkFMMCAgICAgMHhmZmYwMDAwMDAwMDBmMWMwVUxMDQo+PiArI2Rl
ZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMSAgICAgMHhmODBVTEwNCj4+ICsNCj4+
ICAgLyogSW5mb3JtYXRpb24gYWJvdXQgcGFnZS1zZWxlY3RpdmUgSU9UTEIgaW52YWxpZGF0ZSAq
Lw0KPj4gICBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5mbyB7DQo+PiAgICAgICB1aW50MTZfdCBk
b21haW5faWQ7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCBjMTM4MmE1NjUxLi5kZjU5MTQxOWI3IDEwMDY0NA0K
Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+IEBAIC0yNjU2LDYgKzI2NTYsODMgQEAgc3RhdGljIGJvb2wNCj52dGRfcHJvY2Vz
c19pb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESW52RGVzYyAqaW52X2Rlc2MpDQo+
PiAgICAgICByZXR1cm4gdHJ1ZTsNCj4+ICAgfQ0KPj4NCj4+ICtzdGF0aWMgZ2Jvb2xlYW4gdnRk
X2hhc2hfcmVtb3ZlX2J5X3Bhc2lkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncG9pbnRlciB1c2VyX2Rh
dGEpDQo+PiArew0KPj4gKyAgICBWVERJT1RMQkVudHJ5ICplbnRyeSA9IChWVERJT1RMQkVudHJ5
ICopdmFsdWU7DQo+PiArICAgIFZURElPVExCUGFnZUludkluZm8gKmluZm8gPSAoVlRESU9UTEJQ
YWdlSW52SW5mbyAqKXVzZXJfZGF0YTsNCj4+ICsNCj4+ICsgICAgcmV0dXJuICgoZW50cnktPmRv
bWFpbl9pZCA9PSBpbmZvLT5kb21haW5faWQpICYmDQo+PiArICAgICAgICAgICAgKGVudHJ5LT5w
YXNpZCA9PSBpbmZvLT5wYXNpZCkpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRf
cGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBkb21haW5faWQsIHVpbnQz
Ml90IHBhc2lkKQ0KPj4gK3sNCj4+ICsgICAgVlRESU9UTEJQYWdlSW52SW5mbyBpbmZvOw0KPj4g
KyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hczsNCj4+ICsgICAgVlREQ29udGV4dEVudHJ5IGNl
Ow0KPj4gKw0KPj4gKyAgICBpbmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9pZDsNCj4+ICsgICAgaW5m
by5wYXNpZCA9IHBhc2lkOw0KPj4gKw0KPj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsg
ICAgZ19oYXNoX3RhYmxlX2ZvcmVhY2hfcmVtb3ZlKHMtPmlvdGxiLCB2dGRfaGFzaF9yZW1vdmVf
YnlfcGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5mbyk7DQo+
PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArDQo+PiArICAgIFFMSVNUX0ZPUkVBQ0go
dnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0KSB7DQo+PiArICAgICAgICBp
ZiAoIXZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyks
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfYXMtPmRldmZu
LCAmY2UpICYmDQo+PiArICAgICAgICAgICAgZG9tYWluX2lkID09IHZ0ZF9nZXRfZG9tYWluX2lk
KHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsNCj4+ICsgICAgICAgICAgICB1aW50MzJfdCByaWQy
cGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4gKw0KPj4gKyAgICAgICAgICAg
IGlmICgodnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lk
KSAmJg0KPj4gKyAgICAgICAgICAgICAgICB2dGRfYXMtPnBhc2lkICE9IHBhc2lkKSB7DQo+PiAr
ICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsNCj4+ICsg
ICAgICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgICAgICAg
ICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0ZF9hcyk7DQo+PiArICAgICAgICAgICAgfQ0KPj4g
KyAgICAgICAgfQ0KPj4gKyAgICB9DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBib29sIHZ0ZF9w
cm9jZXNzX3Bpb3RsYl9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYykNCj4+ICt7DQo+PiAr
ICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+PiArDQo+
PiArICAgIGlmICgoaW52X2Rlc2MtPnZhbFswXSAmIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9W
QUwwKSB8fA0KPj4gKyAgICAgICAgKGludl9kZXNjLT52YWxbMV0gJiBWVERfSU5WX0RFU0NfUElP
VExCX1JTVkRfVkFMMSkpIHsNCj4+ICsgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52
YWxpZCBwaW90bGIgaW52IGRlc2MgaGk9MHglIlBSSXg2NA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIiBsbz0weCUiUFJJeDY0IiAocmVzZXJ2ZWQgYml0cyB1bnplcm8pIiwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBpbnZfZGVzYy0+dmFsWzFdLCBpbnZf
ZGVzYy0+dmFsWzBdKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4g
Kw0KPj4gKyAgICBkb21haW5faWQgPSBWVERfSU5WX0RFU0NfUElPVExCX0RJRChpbnZfZGVzYy0+
dmFsWzBdKTsNCj4+ICsgICAgcGFzaWQgPSBWVERfSU5WX0RFU0NfUElPVExCX1BBU0lEKGludl9k
ZXNjLT52YWxbMF0pOw0KPj4gKyAgICBzd2l0Y2ggKGludl9kZXNjLT52YWxbMF0gJiBWVERfSU5W
X0RFU0NfUElPVExCX0cpIHsNCj4+ICsgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCX0FMTF9J
Tl9QQVNJRDoNCj4+ICsgICAgICAgIHZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShzLCBkb21h
aW5faWQsIHBhc2lkKTsNCj4+ICsgICAgICAgIGJyZWFrOw0KPj4gKw0KPj4gKyAgICBjYXNlIFZU
RF9JTlZfREVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEOg0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiAr
DQo+PiArICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGlu
dmFsaWQgcGlvdGxiIGludiBkZXNjOiBoaT0weCUiUFJJeDY0DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAiLCBsbz0weCUiUFJJeDY0IiAodHlwZSBtaXNtYXRjaDogMHglbGx4KSIsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgaW52X2Rlc2MtPnZhbFsxXSwg
aW52X2Rlc2MtPnZhbFswXSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIGludl9kZXNj
LT52YWxbMF0gJiBWVERfSU5WX0RFU0NfSU9UTEJfRyk7DQo+PiArICAgICAgICByZXR1cm4gZmFs
c2U7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gICBz
dGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19pbnZfaWVjX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESW52RGVzYyAqaW52
X2Rlc2MpDQo+PiAgIHsNCj4+IEBAIC0yNzc1LDYgKzI4NTIsMTAgQEAgc3RhdGljIGJvb2wNCj52
dGRfcHJvY2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICAgICAgYnJl
YWs7DQo+Pg0KPj4gICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExCOg0KPj4gKyAgICAgICAg
dHJhY2VfdnRkX2ludl9kZXNjKCJwLWlvdGxiIiwgaW52X2Rlc2MudmFsWzFdLCBpbnZfZGVzYy52
YWxbMF0pOw0KPj4gKyAgICAgICAgaWYgKCF2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhzLCAmaW52
X2Rlc2MpKSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICAgICAgfQ0K
Pj4gICAgICAgICAgIGJyZWFrOw0KPj4NCj4+ICAgICAgIGNhc2UgVlREX0lOVl9ERVNDX1dBSVQ6
DQo+DQo+LS0NCj5SZWdhcmRzLA0KPllpIExpdQ0K

