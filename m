Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5495CD6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfo-00085S-Vz; Fri, 29 Nov 2024 02:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfc-0007zG-NZ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:11 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfY-0002nD-Br
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866244; x=1764402244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NaZCpvqgA/bH2itIriVIa+Uv+Dy5+DrbRgkIjSU9Tfk=;
 b=iRX/iBPoIH3zLYdr6D5dNJtcXash2W/2KhNyPsv0kF4pi+JjH0xn/8mr
 muUTapVN1rAMcEY7qUJaFz7Ps55KJeMokO2UHf2S7KDjyXHtYht8PoKuv
 NGUviQOb/ROn7iKbm638KxfTsGVZkL4x5ohQTONhS7SedcsJDtZolNuDC
 YK5eLtsOxLeVDn91s5M9j42V0lnEFpH44gJ3+qcuri37MT9N26ebcl/Qe
 Lpi2VdumMpe2J7PlJAEkfbGz8V0ZljfW+v8pzL8T8MTn5qSjQv9TJSvyr
 c32rq/BIsrOXzIO8gHIivSAJlLFgY58maGu5nJrDY8fzi5QGxOMo0l7Ys A==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670810"
X-MGA-submission: =?us-ascii?q?MDHhzpIxOaufYw7nCy3yoe3Y/z2Qcku/f4IKrv?=
 =?us-ascii?q?rXByE50bD13DljUALXbNy01fK77V9YNjRSFz0gUUKG0UiRXWFpw49v7d?=
 =?us-ascii?q?EA+ULluG5lwwKGN/psNEJp1NBoRS7yDczdm49HkjTmW8VPGLOF+qqMEu?=
 =?us-ascii?q?RN9fKQGLhCAwOtDYtbjRcDOQ=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:00 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFuHAD7DFS5Con8bsYsUKwNhbHjUSPZqmbW/zg3WbnZOffn0EiY7h0e3IjJA/dLD1x+bSFXhOumRC1V7X93eVU+x3XD1AYT5InBACkCdkU8Pfu8TBjyApwzOq8H+djvgTNz40mCXglpGWAg89b6Jmfh5//B+ULN+NlaxPQwGv91bJJSOYbCYe6znW6ym5NekcynG08CcD9IggNySsxZwfBXcLhasa4gIyzFdVJv41O5KdNi+nAyqYoIN4jFXqU/g1OWmA9kFldB765Lndu5rz7D+fe7iZ5KIhkPtBoFemkLYdfvgz7eqqOTjShfNf7eWXy6sz9Qup+2lx4ZMvT2q3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaZCpvqgA/bH2itIriVIa+Uv+Dy5+DrbRgkIjSU9Tfk=;
 b=n/Nbnj2rW1ewPGN+jxJXR/cEjPn6KnCdhxLcN9Gl1we5JqtlIpUCoTxnUuSoU8sTe+h6EaLmlgmLYnV/nnCNquInqWrg8HmQy7m5pRBF9NIysASxXRoQZKRTLK7RNwRWa2bDeMEMQ0dNY97oeFRg0OYMruLUxbJ5u7ojkNhV7uXAIf/6ir8J3bx4Z1tWdBfqXTc6F1dyI4hE7QTc9GilkLqDI9MdJOZPPNVUMYArhL6MFQRlobOUjC7rPb/7cyYk5UK8qCGfwyf12NEVGfXTubWGb/gwfWiTKsJqXTkjepjz25M86Gkgzj/HUadTPTXSAA2bfG7WR8H/xgoNWbuBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaZCpvqgA/bH2itIriVIa+Uv+Dy5+DrbRgkIjSU9Tfk=;
 b=atDvQhT3HJsJxocG9SOWw1otbflWngM639j6JNpJMCaTQNVmlDXAMD1KNFrxGJTKsHy0xyu+/x6+/0QhgFvKQqnmAKvqyHdtfc427aHljbhOW4AjiY22LejuL07jgkGaIykVA459KS42GW8qJ7f2sWiUfxy3Jq2O09J1mFPjMrptCELW5ImtdFsj0IFa11rTlvhX8CC5xVuBejwl2ijF1jHuo40fDXtOqgzdagggYrc1F5oBJJ8fS39AYZX0lY0wv94zqoaSU7qz8zKnlx+bO6xc3CPb1r/MZIJ5FR2JfI+CIwUjDWs0EGtojn9q6Rxi3lL4ZhMURwZmuOAvTJNO3Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 12/19] pci: Add a pci-level initialization function for
 iommu notifiers
Thread-Topic: [PATCH v1 12/19] pci: Add a pci-level initialization function
 for iommu notifiers
Thread-Index: AQHbQjJycOMVY49bv0uPDEfnaCo52w==
Date: Fri, 29 Nov 2024 07:43:58 +0000
Message-ID: <20241129074332.87535-13-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: 13ae6722-06db-41dd-5d11-08dd1049955c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?R2dmek9yVUt1T3ZtZ0V1WkxxcHM5MEx2OVFLTFlGc3pMVEs0T2p4cDl5VDVI?=
 =?utf-8?B?bWlrbWtDcTNVczV3MGhpSjJ6WWM5RTFXcTBON08rSzRkbWJGUGtQY3N0ZXJr?=
 =?utf-8?B?S2VKR3VCQ2phYmtaMktrR3pPZHdscWRhREhtOWh3dkJURVNKOWNBVUJMQlg1?=
 =?utf-8?B?WTNoSTU5cWEwZDR0c0l3TERpMjl0YkJmSDZTNUVVbUdSSXg4d2JQMDRqQnFh?=
 =?utf-8?B?YTdXdUsvd0p3QUpFdklvRlhEdy9rclpmQVlaWkNhbjU1NTA5Y1A1MjU4aWlW?=
 =?utf-8?B?amdFYTNsT0FOSW5mWXpYL1B6dW5GY2tCWkNFWnh6ZFRiS3Y2S1NuVmRzZzRC?=
 =?utf-8?B?M2h3YjJRNE00ZUg4ejBQRXRMNTRiSTFwb0xnbWNpZjdTY2hzT3BRUi91Yi9h?=
 =?utf-8?B?c1FoTzNVVGVLbGRPZ2xVTUdDR0RpU3ZLNDB6VjhrOGQ1Wm84VW13b0RqNG9m?=
 =?utf-8?B?bDhzOHkxR0dkR2wxNlNXV3JTM2cyZkliVzJaK2FCVVYxcGZ4aTYzZjNVb2M2?=
 =?utf-8?B?RnhWNVdxU1Q4ZmJhZzBQcmZMNUlGL2cwTFJIYjF4emE2aEdrZEt0MkVpVDlw?=
 =?utf-8?B?OXVmMDhOZndVK1RoaGY1OG4wU1cyWjk5Z2pHU0tXWEswdEVsSUhmQkxhTW85?=
 =?utf-8?B?WHdpY2xiVWo0bFg0bVIza1I0WkNsZzZhTnErVEkrNXJYN2pCelRaVEhpVnVP?=
 =?utf-8?B?M0d6VGxMYmRkMW5PVUp0eERPZ3g3dTFqTE5TZXdNMzl6K0pDOS8yMEowWUFu?=
 =?utf-8?B?MGI0NGFPN2NEL25zc01BQUhucVE1V3dtbFhoWE9wc0c1WFdzNjhkZ012MTlh?=
 =?utf-8?B?Mm5WRXVrc1ltRGE1OStJdVRqN1ErWDY5ZDh0ZTk4bVVuam5OcnVHMENTY0Q3?=
 =?utf-8?B?Ull6cUNDUllqbGxEbnlTM0VuZGprTzNucUNOVGdSQnBId25UbjNDNEw2MlNk?=
 =?utf-8?B?cmhkN1lpcG1xNmZvcUJFMXFRMGtmV3ZFM25kQk9mQmQzWmVQTjU4QStkb1FY?=
 =?utf-8?B?dTVwTUpmR2dKUkl4cVdYWjZhenI5Y1k3ZUs0V21vWFNJZEdrMWphTVl3V20x?=
 =?utf-8?B?ZEh4RllQM3IxSkgyTGcva3dDSSsyS05HN2RWRE5OR1FRNllsSW5CdkhmRDFJ?=
 =?utf-8?B?Qnl0YnVKbUlGb2g3ejByRGc5TFRMbGxjNDNTTkkvSDFQQTVzcWdxVndtNnJ0?=
 =?utf-8?B?Nkd4eVl2MHlTZE9qVHN0SUROZFdaQjR2UjZyYmhWOTlsUmNNeXNhYzRDNTVy?=
 =?utf-8?B?SDJVejlDeG0vb1crQ2JkazIvL2hCR2FyWk5vL3F5QlIxSU9HNlhJcnhTcnpG?=
 =?utf-8?B?c2U2Q1U2c3dlNkM3MDhtQXY2Z3J2OFAveXpzN0ttR1cxWXhubW42RHNtditu?=
 =?utf-8?B?SVpHSE50YmlJRENBMSttbnFrdXl6OWNtR0Y0andPV2V3R0twa3dqaitSNXRZ?=
 =?utf-8?B?eitMWkp5QWxoR3Q5ZEZrQVJMOWlUTUJQVFR3ZUFHR3hONHNPUEdNOWRUc2JX?=
 =?utf-8?B?dHhldG5FUnZETEwxNzc3QTh0M2ZZMjhOVXN6b3U3NzBRa2FhdHdhaklOYWhM?=
 =?utf-8?B?MnN0RWVvTjNCUzdyd29LMUNyQUY4M3RIYjFtTFJXRVVZYzAwVnJyM2RJZGdr?=
 =?utf-8?B?cDYxMy9OSmxpMVR3RnNKUHkvdEZlZkx5YnR2cXBwdDMrb1pBZGJkR3FhNW5u?=
 =?utf-8?B?Rm5pQVR6UzZ6WkJTeENLQ1ZkL08yaGhRay84cmlXZERqWmFoRDRnb2E4REJq?=
 =?utf-8?B?VjlyS0cyRFFvcXdWQ0g1eDNvaFBjemxQK09hTkw4aldCbHFSM0xZR21YbTcw?=
 =?utf-8?B?WTFJdE9ZZjdkY0IzTEFObTVxcDhQRHBhSHRHSXFaVVhCY05HdzY4MHFCWHUx?=
 =?utf-8?B?c1VRMWRQTWtaL2pqRjdHSzlsckNnR1dDOXBwa0k0NzFiZmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1VRWE13dEZCZzNiNTB3WEFLTUYzYlBBVDBCdDlxZjZCK0RING1FeGpPRmNv?=
 =?utf-8?B?ZmdJUG1EZGlRTWlvUXlMeGVjeU9ieFFkeUlla3I4N3VJNDdpT0JiS0VBbXRQ?=
 =?utf-8?B?bWFzazVtakhEZmNDOUVPWnNBQlJtV0dENTBEcVdwUnhoL3FCVzNXeGFWS3pO?=
 =?utf-8?B?U2svRCs5bVpEcHNZTy92VjV2NlpxQm96NW5UVSs1c1VJSUpEd2N4dHpKTVZZ?=
 =?utf-8?B?d3RGLzNpTE5TM2hlK09SYVdZcUxHczZSMDRGd3BkUEtrcTg3ckxYNHpTclMr?=
 =?utf-8?B?SG5MalpBTmVISWcyK04xOFZ1SDlYV253U0ptcE04Nk5XcGRyU01Gc1VCT0tn?=
 =?utf-8?B?S3JNREFZRmVtZFFGeWdRNUlyWTBFUEFEanpPeGNUUW5YSHB0eTB6T2tINlJW?=
 =?utf-8?B?emx4WnJHRFk5UXNib01MWTMvVEprZnAyUkVibU1EM2JySy9td3BOUjcwalpp?=
 =?utf-8?B?dXJobFU3SHlISVEzZXJQTHltbGtoL3A5eThTaW9TRk15VXRVa0FFTVVuK0xU?=
 =?utf-8?B?UCtZV0cxcCtSQldZeWFDQzhEZUNSb05WbS9FU01rK1l3NTNpclJob2toMXNs?=
 =?utf-8?B?SVRENUNCVHNyVTBuWXp5cG4rY0NtSXpZZXgzUjUyKzFmdGpFM24wY1pxZldv?=
 =?utf-8?B?cVVvMGZGRXVhOXRkZUhkTjUzRlFSQ2c5Q2tQUmlWRGtMZU9MSVY3OXk1OEJH?=
 =?utf-8?B?VVlvT0xQOFEyNS9ZajFrYTQzME5lUzY3M3pmU0VKTVlLN2VTQmc2cUJsdUM0?=
 =?utf-8?B?cTQ2alYrN29IYWh0VDFidFQ1bTh3V3RYbXp1OWZ5eUc2OHdBVWZKOEFNRGFj?=
 =?utf-8?B?aGZHNHhRMDk2V1hra2pET0d4SVg0ZzlTbk1POGtzUUpNRmtzMHVGRkYvWmhn?=
 =?utf-8?B?NjF1clYzdGI1SCt1Nk1vZ1c4YWlMWHBiSmpGWUd3LzN6aEJxbStta0pHbzNB?=
 =?utf-8?B?SnRFMC81K1c0MDFqRkZRaGNCWWZCYUlPY0t0QWlhZ1BTbFlLTkp5THg1eHNW?=
 =?utf-8?B?L1pvcWJpbmRraklQdm1xQmJDR21rMFV5TWRsVHJia1R2YUFPeWJ3TW91ckNB?=
 =?utf-8?B?Q1d6U09nU3UvTmxibzlpSXIvM3RuakJPaHdMemkySWxUK0JvS20vSTJXUTB6?=
 =?utf-8?B?dWlIWlN3WjZFRXRqcG1iTDgxbHU5ejZXTHQrNU9FOFdZTCt4ZklGV3FTRVlJ?=
 =?utf-8?B?M0gzWHYxUXgwMFNTQ2xFOWg4WjZUUVNxdTl4a29JdkNaVVNuZ0hwL24wL1pa?=
 =?utf-8?B?MVBaNXR0RHUxcExYcUM4b3czL1c2VXZxNG9SNERqZkhxcWxCWTRyNUIzYTl2?=
 =?utf-8?B?dm5YOGM2b3I3M0t1OUcyQ1VmTU9DRURtTHZLb25tbDNkK1NvalY1RHZKbnp1?=
 =?utf-8?B?aVJ4VTcxdkJaYlBkejFOZDU0UkNtYnRidzRldlRKSW53ODFQYStrM0RlMzEw?=
 =?utf-8?B?N0NuVjJNdkoybUxKekNGMkY0eHZXYXpmSENuQkxwcFF0Q0JqazlBaHdGTkpX?=
 =?utf-8?B?dFNCU3ZLZkhiaVhsdUtWcldlMUVUK1pVK1R3aXFLTHVEeTZGNnRFcXhVa2U2?=
 =?utf-8?B?ZzR6aWpONjYxcEt2cXFkNTFiZHZ0b2svTXNGNU5iUXdVOEhtOGFpRUVUYWZQ?=
 =?utf-8?B?Wks1dXU5QU9BaXdvODhndTJVaVpyR2gxRHk2R1dwakVNSnp2Wm83cHUrSUZq?=
 =?utf-8?B?dCtud0RtbjJPUTZPSUVxWEdJeDZIUTZPUTNQVG5xTnhzb1JXeFArc0xkdUpn?=
 =?utf-8?B?Q2hQMmNuVzdLaTlmSHYxelF2aHVtWGlvNXFWaVhsTmw0b1YyV0lVeW5oeVpO?=
 =?utf-8?B?dThlWmhlYjdqSEZXcXdEbFVtUlUrcVQyZm5NU3dpdk9BNndEU0lZR29UR1dk?=
 =?utf-8?B?Q3JjNHRrQk1OUm9SZzVxSXp2WU1kSDhpOTVyM2RnOXQ2c2gwaTdydWtRZUk5?=
 =?utf-8?B?alRlVmpiLy9wY0dSNWQ3R0xUM1J5MXp4aVJBZFdmT015Zm15Y2xBcFdmNWNZ?=
 =?utf-8?B?bzRPcUJ6UGtOZXJ4cnBTcXVIRnNyRE5PbGpBUldSUzZGV2xScmZmdTBBMk1l?=
 =?utf-8?B?bS9Lcm01U0ZBdUxWMzZ2WExCa3ZNNnphUWhwUTBpZU1uU0lReVZ2R04vbjc1?=
 =?utf-8?B?MDNxNWdXb3FEZzArWEJkeSt5VWlSb1Q5K0xtR0FwVFJnWUJwU2h1clNuRzRm?=
 =?utf-8?Q?6Szsz5f8LV4WAn7eEsZ/lmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <750E06CB7C5B7F43A4EDD02A20EA90F3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ae6722-06db-41dd-5d11-08dd1049955c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:58.0740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5h0Om059H5steIy5pfb7YaE7h7CetVgN2gfALDheRYylhQFdk2P4iisAQ/bC2u9p0XJzyJh5YdLmDznXkMk5WN8E2EUZcr5Stv82wY+RwtHakH5CYzMJQRDVlyumRPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCldlIGFkZCBhIGNvbnZlbmllbnQgd2F5IHRvIGluaXRpYWxpemUgYW4gZGV2aWNl
LWlvdGxiIG5vdGlmaWVyLg0KVGhpcyBpcyBtZWFudCB0byBiZSB1c2VkIGJ5IEFUUy1jYXBhYmxl
IGRldmljZXMuDQoNCnBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZCBpcyBpbnRy
b2R1Y2VzIGluIHRoaXMgY29tbWl0IGFuZA0Kd2lsbCBiZSB1c2VkIGluIHNldmVyYWwgb3RoZXIg
U1ZNLXJlbGF0ZWQgZnVuY3Rpb25zIGV4cG9zZWQgaW4NCnRoZSBQQ0kgQVBJLg0KDQpTaWduZWQt
b2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMTUgKysr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4IGJkMzZjNTIyN2IuLjQz
NWZjYjZjNzggMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBiL2h3L3BjaS9wY2kuYw0K
QEAgLTI3NzMsNiArMjc3Myw0NiBAQCBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRk
cmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZhZGRyZXNzX3NwYWNlX21l
bW9yeTsNCiB9DQogDQorc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICpwY2lfZGV2aWNlX2lvbW11
X21lbW9yeV9yZWdpb25fcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFz
aWQpDQorew0KKyAgICBQQ0lCdXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAg
IGludCBkZXZmbjsNCisNCisgICAgLyoNCisgICAgICogVGhpcyBmdW5jdGlvbiBpcyBmb3IgaW50
ZXJuYWwgdXNlIGluIHRoZSBtb2R1bGUsDQorICAgICAqIHdlIGNhbiBjYWxsIGl0IHdpdGggUENJ
X05PX1BBU0lEDQorICAgICAqLw0KKyAgICBpZiAoIWRldi0+aXNfbWFzdGVyIHx8DQorICAgICAg
ICAgICAgKChwYXNpZCAhPSBQQ0lfTk9fUEFTSUQpICYmICFwY2llX3Bhc2lkX2VuYWJsZWQoZGV2
KSkpIHsNCisgICAgICAgIHJldHVybiBOVUxMOw0KKyAgICB9DQorDQorICAgIHBjaV9kZXZpY2Vf
Z2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21tdV9idXMsICZkZXZmbik7DQorICAg
IGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1vcnlfcmVnaW9u
X3Bhc2lkKSB7DQorICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1v
cnlfcmVnaW9uX3Bhc2lkKGJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
b21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsNCisgICAgfQ0KKyAgICByZXR1
cm4gTlVMTDsNCit9DQorDQorYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lE
ZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSkNCit7DQorICAgIElPTU1VTWVtb3J5
UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChk
ZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7DQorICAg
ICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisgICAgaW9tbXVfbm90aWZpZXJfaW5pdChuLCBm
biwgSU9NTVVfTk9USUZJRVJfREVWSU9UTEJfRVZFTlRTLCAwLCBIV0FERFJfTUFYLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW9tbXVfYXR0cnNfdG9faW5kZXgoaW9t
bXVfbXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKTsNCisgICAgbi0+b3BhcXVlID0gb3BhcXVl
Ow0KKyAgICByZXR1cm4gdHJ1ZTsNCit9DQorDQogYm9vbCBwY2lfZGV2aWNlX3NldF9pb21tdV9k
ZXZpY2UoUENJRGV2aWNlICpkZXYsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQogew0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4IGMzNGVjNWVh
ODEuLmIyMTQ0OGJjMmEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KKysrIGIv
aW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC00NDMsNiArNDQzLDIxIEBAIGJvb2wgcGNpX2Rldmlj
ZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhpb2Qs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCiB2b2lk
IHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2KTsNCiANCisvKioN
CisgKiBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcjogaW5pdGlhbGl6ZSBhbiBJT01NVSBu
b3RpZmllcg0KKyAqDQorICogVGhpcyBmdW5jdGlvbiBpcyB1c2VkIGJ5IGRldmljZXMgYmVmb3Jl
IHJlZ2lzdGVyaW5nIGFuIElPVExCIG5vdGlmaWVyDQorICoNCisgKiBAZGV2OiB0aGUgZGV2aWNl
DQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgdG8gd2F0Y2gNCisg
KiBAbjogdGhlIG5vdGlmaWVyIHRvIGluaXRpYWxpemUNCisgKiBAZm46IHRoZSBjYWxsYmFjayB0
byBiZSBpbnN0YWxsZWQNCisgKiBAb3BhcXVlOiB1c2VyIHBvaW50ZXIgdGhhdCBjYW4gYmUgdXNl
ZCB0byBzdG9yZSBhIHN0YXRlDQorICovDQorYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3Rp
ZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSk7DQorDQogLyoqDQog
ICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElPTU1VIGhhbmRsZXJzIGZv
ciBhIFBDSUJ1cw0KICAqDQotLSANCjIuNDcuMA0K

