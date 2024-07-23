Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A3C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 02:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW5dy-00018j-GE; Mon, 22 Jul 2024 22:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW5dv-00016I-No; Mon, 22 Jul 2024 22:52:47 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW5dr-0002zG-Us; Mon, 22 Jul 2024 22:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721703164; x=1753239164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oif/SAU4p/0hoq4wknLVdofx6SWr6xO7jbOwM5S+Ft0=;
 b=f5YlqA49u5OQ2g+aKH93o4kTb31YkJbqskvhn0ClbORPa4LSi8YnqcRd
 56XnfoTK8Ykb7QZ3AajWDsVSZdPIO6onim19C9Of9Wn4TVLTBJx1w1m05
 /xzN+3+c1VifTL8Fv8PhB+1QBKjKyXGpdashqCyYZlwntItuS0z9sCh8F
 YU+/IES4Wphr3m9K7hkFqcWCyyy450JWxVCDBjLJUvln7SNBQE7TxftRo
 U/v0Ogz4XBLVNB6/6rA/i/Jzu32YXaNS/LALio9ajrf/qrjEyHfZ1wH1Y
 cT1Ff8RJ73eFKOZ11knnmGzPtzT4o5CTfLXLiGDxa61rwmks3t8XP8RI3 g==;
X-CSE-ConnectionGUID: EzAcd7HuSAu8Wfsj0NbSbQ==
X-CSE-MsgGUID: aLlqtKUHQiaAR5+DatVOFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30456720"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="30456720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 19:52:40 -0700
X-CSE-ConnectionGUID: FYZAra8uRsylM2WYOpR4Mw==
X-CSE-MsgGUID: 8K+w4GUoQ7iFIpk9pQ43Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="52078309"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 19:52:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 19:52:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 19:52:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 19:52:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 19:52:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlSlUEhCOYI4nXgcIW84u5q9JBcFSaCOMk+lgEeNwWItNHtHXCUlb91EN72kI70qvVhZTURFfwcfgJ4EPH7oACYu1aPYSB94j3UtLipM2SwWWzOLGZBHdt/S1mAL3hVarHiL8A61t3NnJFbQfJtgMhQrHRSxIbqBjpXuQ5pUPjjUuyHwdRpzgug96+vj8Ypzn/7naOpwSbirIR0kKv9aooOClvhJjwezMlpef4Gkk4ygr0+0rycZWrCwo8Hw/vT450VhvwBrnOS3GP8SJHLC/Hqbo1wA8azP6AVDgsmLquvQUA5rmmdXo4H748YAmHnFzUy+wN3jiIE+ng+AV2o1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oif/SAU4p/0hoq4wknLVdofx6SWr6xO7jbOwM5S+Ft0=;
 b=QC8N8L3uXGafLLh1CK/z9rMAqrKn7F9UEzrq4hQBSojRcXElaquKwce3MLTKE2Q8ZqOmgZT99IPkYAq6qk4yrhrPvHDWVXqw1SS72M7+OryWKthDq1Gcgx9ihg7Z2PfwcLRmRZR10XsRCBdJLb1cVYzr+B36GLf3qX0FsIExxp9K+7SNvUxmdOxRTRzy4PR8+TNI+N4cQZqzkVaxOjz/uEzKGhRCI9eq+CBMnBvBnIna9ufNm3kyZ8m3TuGavaJEdm2fqg8CAtFAl3BXmVkP4kE1YzhM5FCv0XWLmp1D7ILeu316++N9b9WLAtn1Ybz5UrDYN57PFI1x7BKBfQMjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 02:52:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 02:52:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Farman <farman@linux.ibm.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Joao Martins <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:S390 general arch..."
 <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
Thread-Topic: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with
 mdev
Thread-Index: AQHa3AY5IosiDfsuPU6gILvWmBAqRrIC1uQAgAADTACAAAe4AIAAI/UAgACWHjA=
Date: Tue, 23 Jul 2024 02:52:36 +0000
Message-ID: <SJ0PR11MB6744D8419D070D5DA273B24E92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
 <20240722070713.1342711-3-zhenzhong.duan@intel.com>
 <40cf2370a1838b1aa1e9eb2cfc75a0543ceb45bd.camel@linux.ibm.com>
 <3072c39e-fd1b-4cc1-a189-2aa64a1d5984@oracle.com>
 <4369ce16-0b40-4df3-8db0-276bb0887fa0@redhat.com>
 <21b3a584cf28e56a3436ae57548a7ea57869d855.camel@linux.ibm.com>
In-Reply-To: <21b3a584cf28e56a3436ae57548a7ea57869d855.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB7660:EE_
x-ms-office365-filtering-correlation-id: a727a814-d09b-4ff5-d6ed-08dcaac2823d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TklBTHFaRVBvcm53NVdnczdpY1BLUHJZV09NZ3VTSFlVWGEwamRDQWdLRVFE?=
 =?utf-8?B?Qk96T3VhQWFvMGNmZFJLMmtzU1Y1YXhvQlRxYkh4UlV1bUEwZ1o5aWF1WGtB?=
 =?utf-8?B?QlhxR095V3FhNDd0Q1hkc2kvT3kwU3djbGx5d09kU25KRXlSV29tNXNyOThL?=
 =?utf-8?B?ekNvcHpaWUZwYkdhZzk3MWxkSU9OaXMwS0FhdlB0aUppQTdEMTMwRTJ4dmVK?=
 =?utf-8?B?blQ1SUpLZk9aY0NLREFJVVY1ZHRMaU0yVVM5SnhJOTNyNDM5VlFuSlVSdGlq?=
 =?utf-8?B?S2Vpci80R09vWStBSWpjTVZXTEVxRGZuQ1NYZVZjVUJLVGdNTFRHdm8vWVl0?=
 =?utf-8?B?MXVXU0RNbFdDQzNYdlRMZkRtQ041aW03L0JMbTVKOU5sY296NGg2aVViYmdQ?=
 =?utf-8?B?UjBmVUtKVWgwNCt2bkJOYm9HMWQ5eUtHMFIzak5rSkd3RFloWUhiUk03bHR5?=
 =?utf-8?B?SFFjaktrRGVJL0YwOGl5UGlqQUxOM0ZwRHJYYzFJOUY5QU0yK0dnMzA1aENs?=
 =?utf-8?B?RFptK3RSZ3l4d3QyUk93Z1lUcnk4RkY3S29rUm9DYVZnYWp6QU9GcDlWL3A0?=
 =?utf-8?B?TFU2QlJSMUZDeWxkNlU5Y01CcCtraW1GTVYzYkNGYmxpTHVvaG9rd084bytU?=
 =?utf-8?B?REJzOU5DWXR2Q3dUODZ4NHM5YnRtcGkzaGRSQ0R5aTIzcmpzQTdKN0xUbGZ1?=
 =?utf-8?B?cDQvVXozNXZaYndmaUhmTTBoR0Zjdm0zNFIwbWhkRGZPNWphRGZnRVFNSW8z?=
 =?utf-8?B?T2d1bCtleVhJUDJSc1NKNkR6TzUzNm5CYjZldFk0YVdaTEp6YlRYSmN3azFE?=
 =?utf-8?B?UFJlTUFLN3pWeHpZSnVrZ2I2VHdIWVhKUUlSNTNQVVBycllKYVBCY3hsZ1ND?=
 =?utf-8?B?aTVTTUhtZzd6b2ZkVmdzNjZmTXdSTFFrWnRZa0dqQmxoakZUc0FnbGlSMGVs?=
 =?utf-8?B?N2NoM2h5bDgyMXJrbjltOXNuejBERmNtQnZkMGl3RS9PbVBSem1xSUZlOWR4?=
 =?utf-8?B?TndJZzRwVTltMUlNV0xmRk1nTmM3SG9wSUJzRVZYVWZMaksrK2JUSGZQYnR4?=
 =?utf-8?B?VTlJLzNIVnBRZytKdXhjMURPNVdIK0VmR01TSUZGd3Z6U1VzdzRZYW5rNFJj?=
 =?utf-8?B?KzN5MklpbEt5c05EMk5md3p3cUVpV21JaVBaWVZmays3eVFoMzJXb3JoV3Ja?=
 =?utf-8?B?d2dzUEdVRGRKRmxLMjBma2huOGpCT1JPV0JBbTBocnZqS0dZSUM5bEN2TzlG?=
 =?utf-8?B?VkNtT2pQTitxeUpycUZZYlEwbDlNaHZKZ1RFc3hxY0d6cVZJRGRGSTR2VEh2?=
 =?utf-8?B?RDlWdUJtSTlMbS84aWsyenkwNFVHUXpCVVJodm1HdW5WT3cxTG95UDNVUjJv?=
 =?utf-8?B?RVB1bEJjRmV2V0pjN21wV0YwUzJiclgrUElVUHpSSXFCbmZjMytUd2hNbFVP?=
 =?utf-8?B?TjlzQkNMUkUrZ25uV2tRYUhPYWtyWVNqSVVENC9UdHN1N1hXbTVwdjhyRExr?=
 =?utf-8?B?Nml4WVdRYVE5em5XSWZQcVVoSWtyeFpJc3VoWXNnaXRTdFgrTjE1WHJSU28z?=
 =?utf-8?B?ZmJoVy8rdnJqQTFUOTZacHVDU3ZaQ3NoZXpuZmRXOWpnMlB4MlkyVi90VW9a?=
 =?utf-8?B?QWZjQ0dXNXJGSnBrVXprVVBuWlZQSnVTOFZMTklNSXpjbFFQSVhHZWlrWEE4?=
 =?utf-8?B?ZmtOVHhqMHFHMmtCMnFKT0xuY0k0QlZOdjhKSE1CclpVU2QvdFZZNXBhdkJC?=
 =?utf-8?B?d3E4UTlJTnBqUXRMUFNkSHU0anNEejMzdG9sTmtyMkNmNG41VXFqbDNpSCtV?=
 =?utf-8?Q?+SiKqHHbiNKqRBrbQ/SVSpGR3OYwBC3mCXlds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05qUmI4ZUhmR2pZcGRBeU4vRXNySFgwRWZzSnh4NWFYYmYwcnpydnFQazZy?=
 =?utf-8?B?Y1JucFdVelpMT3JPZHNJRk83amVCdkdybERKTFB2U05aSmpxM1d1NUNUMkZG?=
 =?utf-8?B?YU9VazdaNWdjOE03UFZGaEIwZFl1c3VwdVZsWHpMaHQ3SUE0UXZlTHN5RVQ5?=
 =?utf-8?B?NHErbkJrdVovbUtKaThSY0RHUEhLbHNSZzdsUmlNQjlLc3dwMVQwY2lsbkh0?=
 =?utf-8?B?Nzk1cTY4VDFPckxaMmFkR0YwZi9US2gwSUowbko0ZjR5dTJKL09mdlhpdGpY?=
 =?utf-8?B?Mm10VVBoQXYvT3BLdnBBNnRZVE01MjlLUU0zQ1Uwam9jZ2pzWFJ6VkxPTVhk?=
 =?utf-8?B?N0J3WDNubm5maFV5SjhaTEVQSUFwTUllMUdienh5ZHkvSXo4UzZOVThhS1Fi?=
 =?utf-8?B?Rk5ycGZXUThLU2tkWGJWVS9iZHRDWUpLZmV5WkVVRHNCKzFnUmJJekdpbWto?=
 =?utf-8?B?Q1FTTjFRZnJuYTNxSEdyejYrWEZNU2pWMVh4QURJR0tQUUhRempNR2lHeW11?=
 =?utf-8?B?Q2RPaUxoT1NRZGtvdThUd0w5SmVSYklnNUZ1ZHdlUjFncDVzTDFKeU4rT1gv?=
 =?utf-8?B?TUNaNEpPY3g2dE8vUkwydTByTmR1YkNKeDJWb1hBTDV0a2pjcXlYOXkrdXRq?=
 =?utf-8?B?OHE2TWw2NWR0b1ZIZ3Y5MER3alV5VEtLNW5jbDIya2M4alFRNGdob0JPMEVi?=
 =?utf-8?B?blRUWi95WlhKTU9sUnVlYm1JdzhwSWZScGxCaTBnZHlqTyt5SlF6czJ4OTBB?=
 =?utf-8?B?WHRCNzhsRnJzY3dTTDVYWGRBeFkwTFVIYVJGV1lFTEovNm5yWDg3SkJRVkcr?=
 =?utf-8?B?RUdvYkhnNDZ1Y0hrRVZUUnpZRU0wZER4ZmQ5bExHRXJmdlE5RWJKUHZQeVhY?=
 =?utf-8?B?dkRLcmNmRHBWalBCYzhNSGpPeXVpejNLMWlkZC9ETjZwMUZQQkpiQXJ3aGV1?=
 =?utf-8?B?WFdqSnRqQ29xOXVVMTNlY1BBNDI0dkh0NWJKbUFMUWdPUmdUZkcwemU2REQy?=
 =?utf-8?B?Y3lFRXNPZENmUkF4d0IwZGlOT1cvNXY0V3dxV0diYzRYY1hMTlRCQTcyN3lR?=
 =?utf-8?B?Y2JKRERpazRndjBGZTVRckNmallTK3JvYUdQaXRBTWRZdkpPa3pjTmFkcldH?=
 =?utf-8?B?T0JlT0htOUtLSHNQdG9udm8yb2JXSndiZXpKUGFMSXJtemM5SlY1Z1JzZWtt?=
 =?utf-8?B?TkE4T1N3VG1iVHJOTjB5dEVLc2pmQVZjeEsvTWhsdGlybVRxdlN2N095U2M1?=
 =?utf-8?B?TEZ4ZnFQNFA1SjQzRDVUa1JiTlRLU1ZRdG1WbDZ3TXlYeGtTMjJjMWdxQklP?=
 =?utf-8?B?M3lFVzZISHZ1UUE3c0o3RzIySWk0ZWJwbGFFZkozWW9qMExhTXkwOFNnbCs3?=
 =?utf-8?B?d2g3cWlOTWlDOGozMnQ1OHlHdVFBSUJPUE9kb0RLdEtjUEkrUlBSbHNjT3I2?=
 =?utf-8?B?clBrVGhSRWFBUVNsRGYwQThvYVRuUHZIN3pzMWNRNXE5dmNIeWRuS09Pdk9L?=
 =?utf-8?B?YmFWdVQ0M2wwb0NpekJPcE1OeXVjZUpEWGJKRjBlTVFaWmtvOVYrRmx4TzVX?=
 =?utf-8?B?Z3JUTGFtQkM3WlhwMEZhUHJOdmNZbEgzSGhQbWdqaHcvd2FVVGJvOE52QnJl?=
 =?utf-8?B?VUdMTDlxcFpVR1g1Q0dXNTFGQWJBcU1PajIvRG5sbHJhWXAyZmhWTWJSaXhn?=
 =?utf-8?B?dEZSZ2hOVEsrK0FkOENYenZGaHNGdWIvSVBFMEt6RXJOUTRIT2VPU2RXdVpU?=
 =?utf-8?B?cWdDVzVPYUoxUWpDNXJLSTdkQVJsbGNIZ0NUNytlSTBmTFpUbnhnN1hYQmFQ?=
 =?utf-8?B?VGNCSlRNeUp6NTM4WDRoK28vcUtsNkZjQTYydUdVdXdvTk8vdHE1Q2ZYQUFX?=
 =?utf-8?B?Z1lnams5cU5QY2Vwc2IwOFF3K0tDQU1pZ25IaXVqSWZHaHArLzdjclZVd0pa?=
 =?utf-8?B?K2VzcUcwVzZBSEdoNC9DTUV6V2svcjlBblR2ekFQeW1pUzIwbDV3Vk5XbHpF?=
 =?utf-8?B?R1Y0L0hZaWpMdUpnVG0wNUVwSlhtT0JXRTNNS01qNlJVcW00bE93TGdrK1Bq?=
 =?utf-8?B?VW5EUUY1aVlvZEFTN291YlhHNzZNbDFVOGdNSllWeFpoYm1yYVdPc3oyLzVL?=
 =?utf-8?Q?5mXQx//bxCrqz3Wix73wLTCEp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a727a814-d09b-4ff5-d6ed-08dcaac2823d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 02:52:36.5155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwitP5BZ7iUHe/X1oObNc8shtYi9kfA29eq7+ZeO9lYUG7YukjR4LEKHf6kPMHhCZytxyg8/xEVHZ5xSqm9VnUCBySZgneyyAYl8c8ruyJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgRmFybWFuIDxmYXJt
YW5AbGludXguaWJtLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gdmZpby9jY3c6IERv
bid0IGluaXRpYWxpemUgSE9TVF9JT01NVV9ERVZJQ0UNCj53aXRoIG1kZXYNCj4NCj5PbiBNb24s
IDIwMjQtMDctMjIgYXQgMTc6MzYgKzAyMDAsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPj4g
T24gNy8yMi8yNCAxNzowOSwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4gPiBPbiAyMi8wNy8yMDI0
IDE1OjU3LCBFcmljIEZhcm1hbiB3cm90ZToNCj4+ID4gPiBPbiBNb24sIDIwMjQtMDctMjIgYXQg
MTU6MDcgKzA4MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gPiA+ID4gbWRldnMgYXJlbid0
ICJwaHlzaWNhbCIgZGV2aWNlcyBhbmQgd2hlbiBhc2tpbmcgZm9yIGJhY2tpbmcgSU9NTVUNCj5p
bmZvLA0KPj4gPiA+ID4gaXQgZmFpbHMgdGhlIGVudGlyZSBwcm92aXNpb25pbmcgb2YgdGhlIGd1
ZXN0LiBGaXggdGhhdCBieSBzZXR0aW5nDQo+PiA+ID4gPiB2YmFzZWRldi0+bWRldiB0cnVlIHNv
IHNraXBwaW5nIEhvc3RJT01NVURldmljZSBpbml0aWFsaXphdGlvbiBpbg0KPnRoZQ0KPj4gPiA+
ID4gcHJlc2VuY2Ugb2YgbWRldnMuDQo+PiA+ID4NCj4+ID4gPiBIbW0sIHBpY2tpbmcgdGhlIHR3
byBjb21taXRzIHRoYXQgQ2VkcmljIG1lbnRpb25lZCBpbiBoaXMgY292ZXItDQo+bGV0dGVyIHJl
cGx5IFsxXSBkb2Vzbid0ICJmYWlsIHRoZSBlbnRpcmUgcHJvdmlzaW9uaW5nIG9mIHRoZSBndWVz
dCIgZm9yIG1lLg0KPj4gPiA+DQo+PiA+ID4gQXBwbHlpbmcgdGhpcyBwYXRjaCBvbiB0b3Agb2Yg
dGhhdCBjYXVzZXMgdGhlIGNhbGwgZnJvbQ0KPnZmaW9fYXR0YWNoX2RldmljZSgpIHRvIGhpb2Rf
bGVnYWN5X3ZmaW9fcmVhbGl6ZSgpIHRvIGJlIHNraXBwZWQsIHdoaWNoDQo+c2VlbXMgb2RkLiBX
aGF0IGFtIEkgbWlzc2luZz8NCj4+ID4gPg0KPj4gPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9xZW11LWRldmVsLzRjOWExODRiLTUxNGMtNDI3Ni05NWNhLQ0KPjllZDg2NjIzYjlhNEBy
ZWRoYXQuY29tLw0KPj4gPiA+DQo+PiA+DQo+PiA+IElmIHlvdSBhcmUgdXNpbmcgSU9NTVVGRA0K
Pj4gPg0KPg0KPldoaWNoIGlzIG5vdCB0aGUgY2FzZSBpbiBkZWZjb25maWcuDQo+DQo+PiA+ICBp
dCB3aWxsIGZhaWwgdGhlIGVudGlyZSBwcm92aXNpb25pbmcgaS5lLiBHRVRfSFdfSU5GTw0KPj4g
PiBmYWlscyBiZWNhdXNlIHRoZXJlJ3Mgbm8gYWN0dWFsIGRldmljZS9JT01NVSB5b3UgY2FuIHBy
b2JlIGhhcmR3YXJlDQo+aW5mb3JtYXRpb24NCj4+ID4gZnJvbSBhbmQgeW91IGNhbid0IHN0YXJ0
IGEgZ3Vlc3QuIFRoaXMgaGFwcGVuZWQgYXQgbGVhc3QgZm9yIG1lIGluIHg4Ng0KPnZmaW8tcGNp
DQo+PiA+IG1kZXZzIChvciBhdCBsZWFzdCBJIHJlcHJvZHVjZWQgaXQgd2hlbiB0cnlpbmcgdG8g
dGVzdCBtZGV2X3R0eSkNCj4+ID4NCj4+ID4gQnV0IGlmIHlvdSBkb24ndCBzdXBwb3J0IElPTU1V
RkQsIHRoZW4gaXQgcHJvYmFibHkgbWFrZXMgbm8gZGlmZmVyZW5jZQ0KPmFzIHR5cGUxDQo+PiA+
IGRvZXNuJ3QgZG8gYW55dGhpbmcgcGFydGljdWxhcmx5IHNwZWNpYWwgYmVzaWRlcyBpbml0aWFs
aXppbmcgc29tZSBzdGF0aWMNCj5kYXRhLg0KPg0KPlRoaXMgd2FzIG15IGNvbmNlcm4uIFRoZSBz
dGF0aWMgZGF0YSBkb2Vzbid0IGxvb2sgcGFydGljdWxhcmx5IGV4Y2l0aW5nLCBidXQgaXQNCj5k
b2VzIHNlZW0gc3RyYW5nZSB0bw0KPmJlIHNraXBwaW5nIG92ZXIgaXQgaW4gdGhlIG5vbi1pb21t
dWZkIGNhc2Ugbm93Lg0KDQpUaGFua3MgSm9hbyBhbmQgQ8OpZHJpYyBmb3IgaGVscGluZyBleHBs
YWluIGFuZCBjb25maXJtLg0KDQpZZXMsIGFmdGVyIHRoaXMgZml4IEhvc3RJT01NVURldmljZSBp
cyB0b3RhbGx5IGJ5cGFzc2VkIGZvciBtZGV2IGV2ZW4gaW4gbm9uLWlvbW11ZmQgY2FzZS4NCklu
IG5vbi1pb21tdWZkIGNhc2UsIHRoZSBvbmx5IHN1cHBvcnRlZCBIb3N0SU9NTVVEZXZpY2UgY2Fw
YWJpbGl0eSBpcyBhd19iaXRzIHdoaWNoIGlzIGNhbGN1bGF0ZWQgdGhyb3VnaCBiY29udGFpbmVy
LT5pb3ZhX3JhbmdlcyB3aGljaCBpcyBhbHdheXMgTlVMTCBmb3IgbWRldi4NClNvIEhPU1RfSU9N
TVVfREVWSUNFX0NBUF9BV19CSVRTX01BWCg2NCkgaXMgcmV0dXJuZWQgd2hpY2ggaXMgbGFyZ2Vy
IGVub3VnaCB0aGF0IHZJT01NVSBjYW4gc2FmZWx5IGlnbm9yZS4gVGhlbiB3ZSBjYW4gc2FmZWx5
IGJ5cGFzcyBlbnRpcmUgSG9zdElPTU1VRGV2aWNlIGZvciBtZGV2Lg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+PiA+IFRoZSByZWFsaXplIGlzIHNraXBwZWQgYmVjYXVzZSB5b3UgdGVjaG5p
Y2FsbHkgZG9uJ3QgaGF2ZSBhIHBoeXNpY2FsIGhvc3QNCj5JT01NVQ0KPj4gPiBkaXJlY3RseSBi
ZWhpbmQgdGhlIG1kZXYsIGJ1dCByYXRoZXIgc29tZSBwYXJlbnQgZnVuY3Rpb24gcmVsYXRlZA0K
PnNvZnR3YXJlDQo+PiA+IGVudGl0eSBkb2luZyB0aGF0IGZvciB5b3UuDQo+PiA+DQo+PiA+IFpo
ZW5nemhvbmcgbm90aWNlZCB0aGVyZSB3ZXJlIHNvbWUgb3RoZXIgbWRldnMgYXNpZGUgZnJvbSB2
ZmlvLXBjaQ0KPmFuZCBpbiBhbg0KPj4gPiBhdHRlbXB0IHRvIHByZXZlbnQgcmVncmVzc2lvbiBl
bHNld2hlcmUgaXQgcG9zdGVkIGZvciB0aGUgb3RoZXIgbWRldnMgaW4NCj5xZW11Lg0KPj4NCj4+
DQo+PiB5ZXMuIEkgY29uZmlybSB3aXRoIDoNCj4+DQo+PiAgICAtZGV2aWNlIHZmaW8tYXAsaWQ9
aG9zdGRldjAsc3lzZnNkZXY9L3N5cy9idXMvbWRldi9kZXZpY2VzLzhlYjgzNTFhLQ0KPmU2NTYt
NDE4Ny1iNzczLWZlYTRlOTI2MzEwZCxpb21tdWZkPWlvbW11ZmQwIFwNCj4+ICAgIC1vYmplY3Qg
aW9tbXVmZCxpZD1pb21tdWZkMCBcDQo+PiAgICAtdHJhY2UgJ2lvbW11ZmQqJw0KPj4NCj4+IGlv
bW11ZmRfY2Rldl9nZXRmZCAgL2Rldi92ZmlvL2RldmljZXMvdmZpbzQgKGZkPTI4KQ0KPg0KPkFo
LCByaWdodC4uLiBOZWVkIHRvIGVuYWJsZSBpb21tdWZkIEFORCB2ZmlvX2RldmljZV9jZGV2IHRv
IGdldCBpbnRvIHRoaXMNCj5wb3RlbnRpYWwgc2l0dWF0aW9uLiBJDQo+Z3Vlc3MgdGhpcyBpcyBi
ZXR0ZXIgdGhhbiByYW5kb20gZmFpbHVyZXMgZG93biB0aGUgcm9hZC4NCj4NCj5BY2tlZC1ieTog
RXJpYyBGYXJtYW4gPGZhcm1hbkBsaW51eC5pYm0uY29tPg0KPg0KPj4gaW9tbXVmZF9iYWNrZW5k
X2Nvbm5lY3QgZmQ9Mjcgb3duZWQ9MSB1c2Vycz0xDQo+PiBpb21tdWZkX2NkZXZfY29ubmVjdF9h
bmRfYmluZCAgW2lvbW11ZmQ9MjddIFN1Y2Nlc3NmdWxseSBib3VuZA0KPmRldmljZSA4ZWI4MzUx
YS1lNjU2LTQxODctYjc3My1mZWE0ZTkyNjMxMGQgKGZkPTI4KTogb3V0cHV0IGRldmlkPTENCj4+
IGlvbW11ZmRfYmFja2VuZF9hbGxvY19pb2FzICBpb21tdWZkPTI3IGlvYXM9Mg0KPj4gaW9tbXVm
ZF9jZGV2X2FsbG9jX2lvYXMgIFtpb21tdWZkPTI3XSBuZXcgSU9NTVVGRCBjb250YWluZXIgd2l0
aA0KPmlvYXNpZD0yDQo+PiBpb21tdWZkX2NkZXZfYXR0YWNoX2lvYXNfaHdwdCAgW2lvbW11ZmQ9
MjddIFN1Y2Nlc3NmdWxseSBhdHRhY2hlZA0KPmRldmljZSA4ZWI4MzUxYS1lNjU2LTQxODctYjc3
My1mZWE0ZTkyNjMxMGQgKDI4KSB0byBpZD0yDQo+PiBpb21tdWZkX2JhY2tlbmRfbWFwX2RtYSAg
aW9tbXVmZD0yNyBpb2FzPTIgaW92YT0weDANCj5zaXplPTB4MjAwMDAwMDAwIGFkZHI9MHgzZmQ5
ZmYwMDAwMCByZWFkb25seT0wICgwKQ0KPj4gaW9tbXVmZF9jZGV2X2RldmljZV9pbmZvICA4ZWI4
MzUxYS1lNjU2LTQxODctYjc3My1mZWE0ZTkyNjMxMGQNCj4oMjgpIG51bV9pcnFzPTEgbnVtX3Jl
Z2lvbnM9MCBmbGFncz0zMw0KPj4gaW9tbXVmZF9jZGV2X2RldGFjaF9pb2FzX2h3cHQgIFtpb21t
dWZkPTI3XSBTdWNjZXNzZnVsbHkgZGV0YWNoZWQNCj44ZWI4MzUxYS1lNjU2LTQxODctYjc3My1m
ZWE0ZTkyNjMxMGQNCj4+IGlvbW11ZmRfYmFja2VuZF91bm1hcF9kbWEgIGlvbW11ZmQ9MjcgaW9h
cz0yIGlvdmE9MHgwDQo+c2l6ZT0weDIwMDAwMDAwMCAoMCkNCj4+IGlvbW11ZmRfYmFja2VuZF9m
cmVlX2lkICBpb21tdWZkPTI3IGlkPTIgKDApDQo+PiBpb21tdWZkX2JhY2tlbmRfZGlzY29ubmVj
dCBmZD0tMSB1c2Vycz0wDQo+Pg0KPj4gcWVtdS1rdm06IC1kZXZpY2UgdmZpby0NCj5hcCxpZD1o
b3N0ZGV2MCxzeXNmc2Rldj0vc3lzL2J1cy9tZGV2L2RldmljZXMvOGViODM1MWEtZTY1Ni00MTg3
LQ0KPmI3NzMtZmVhNGU5MjYzMTBkLGlvbW11ZmQ9aW9tbXVmZDA6IHZmaW8gOGViODM1MWEtZTY1
Ni00MTg3LWI3NzMtDQo+ZmVhNGU5MjYzMTBkOiBGYWlsZWQgdG8gZ2V0IGhhcmR3YXJlIGluZm86
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCj4+DQo+Pg0KPj4NCj4+IFRoYW5rcywNCj4+DQo+
PiBDLg0KPj4NCj4+DQoNCg==

