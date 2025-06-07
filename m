Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4CDC61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9Z-0002wo-Rt; Fri, 06 Jun 2025 20:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9V-0002um-Bo
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9Q-0006Nb-BN
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Lu6G9022566;
 Fri, 6 Jun 2025 17:11:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TuJSdzq/oMTOZ0c8W2bi4glELx/Lv8O4XX2pLqNHz
 1o=; b=S1ik48KhYdjUWn+7c8M6JQHmrAU/ldwnNMriIzPmt7Hb3XPHEOddgrpwx
 X9hz8fqxtItfjSJDfJNekKWIvkY8vw2iXhFt1rUuQo/y48ls+S4WCG9bFNAzkGBQ
 hwrqIG+wr6WcJhFEIin4tqEMkWfTd72Iu53f0XKyQ3VxCmW+Xu336Ck7niCiZ5Oj
 VZ4jeVCvFqpk5KrRhnIGrFEPF4AXjzQDkHwF2IMd7S4QETZXJ7khtZMgL0ADhCMS
 TvWpCLDBR+Xi104Rz7vxnNqFja0fCkGPoQHHPHWqcT5AlHEtXOEcEA9pHCjil0MB
 kIeQuEu6jI6ZQArkJ2Bc2OP7abf8A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMRc8E3onWZn/+FU9aPOZe2YS1HQPw2WOZWU2hWxZBQQmCfbOGzjSGwt02lV8+/C9l68VjKy0L1LCtZB1NDQ9mFY/u7Pd3UlY/tMdB9RUJHsNcFpsdfgNlYd0AwcsJ7qX51d404zMylGS9KX/DIrD1qVfVQ2R4/E5XLTzHo4d/WtTJXBxdOVJFzTNvbMeD0l4NXNyq1WXuLeXP+SWMzi1bcoOBaIFM1CxlTemrJgF8fiqa25t6wBZ1ceBK7klELl8Mw3Hs1FFb/AUxBLlEOLi0Tpq/V06K/tgubWW42KmSdGQ5F2r5409zuOitLj66p+PSPFA74JXQcbw1ccek+3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuJSdzq/oMTOZ0c8W2bi4glELx/Lv8O4XX2pLqNHz1o=;
 b=OVrmhDVD/KBJbZ9gTAPNRmpwxfkqHCWc21SZ+DU6CbVId8nwS1le57ZxjoEjDJzAONWoHi3t2YgFGyHuBoIx79XfUho3dQbVarRgyefTzD94/WMfadEyKwvyQ+etkfOsh8DBP6IAiq2uZnFYnKVgqy7gUb9LxtGIuezTk6ELOp9HyEZRdr/kLBjwSvEiO+mIKSnea6dtNauDCc6i2hiJhViLLZBtVfDVIxIzLve5zvMoROqfX+Dz8RQ/YQNViRvZbit5tYLUhnjGgZ8EgUSJMvshl+vaUYjiGxpDLXECbFjp1bn28CYRzKLF6Y0rkmXr+yD4U6e6h0nU8xg2Rhz07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuJSdzq/oMTOZ0c8W2bi4glELx/Lv8O4XX2pLqNHz1o=;
 b=wdn4GdKsqc0olMhEoh7wonNglTSkCWt7wn3FrNwjejVdXpklIicJkwRfiA5DkJLgwF2TR7wuYunM50sLnRn+PTx5NU8qMstnSibIeTGDtIc/6fL3gxwhuTuhyv9yO0qkSH8za3YHAYE3jnPkFSdSCCu4Dto9fuwQs2ioEhZRnI0iFlNNJUFhfBnHCD11Qe6BdOmBGomf+3xYOj1p4q/rTIw2VHS1pw02eOilkUNdL8rgW5HN869M20E8dp+/W+RCMI7cn8kbUIOzzB0H2+NMm5P5vECaM3Dv+CoA4oPm/lw/e5ME2DZQruNjGLpzm3l5xqoEEGzRCuXVNSgLH7uUtQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 04/23] vfio: mark posted writes in region write callbacks
Date: Fri,  6 Jun 2025 17:10:36 -0700
Message-ID: <20250607001056.335310-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c3a13-20ca-44b9-a836-08dda557caf2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dldNWGpOcWZWQmt4TUNYam0zTm9FVkZBWHRVRGh3c1I1bWtHT1lPckNHM21u?=
 =?utf-8?B?aFJUWmJWSGhJQlMxbFMrNjdJTTVwcEJUeHZlREZMY2RYTWRVTVh1Q29RNEFn?=
 =?utf-8?B?dTJvd3VQa1JaUmRsVEJCLzdCVEZIWU0rTmYxakcyaTQ3blBkT3AzTHFNbndn?=
 =?utf-8?B?TWRyZVVEOG94VHI4cUdnRWdiS04yTk4zSkl3RFYrVXpWSTZJR0QxWDZEaGdE?=
 =?utf-8?B?SzRVbGtPeC91M3RaN1o1emZzK3U1MGtGT3VhbmV3RlFUcTk2TWxCVmhYdTV6?=
 =?utf-8?B?VVlHLy9sT29JWlRXcitxZzB2c2RmamZSRnB4NXNOV01oM0paTktvbUlsdFVF?=
 =?utf-8?B?ekFwdXYyL09nL25HLzBKbTdwUUxpVVNWa1Y2UjMycU5MRkdPZFZwU1NobjZ5?=
 =?utf-8?B?RmxjSmJkYm5oN0kxWUFWYTFyZnpZbzJzMzVSQWE0YkN4aVB4c3pFMTRlYTlx?=
 =?utf-8?B?N2U4MDRmY1hpS0tldnR0NWZHbmI0c1UwRVFwQmQwc29JRy83cnZDRXdxemNP?=
 =?utf-8?B?VktNa0RZRnVsYVFiS1ZUNTVjN1hiZjVPd1F5M25zcTN1cXZ2MTlvZFk3UnpE?=
 =?utf-8?B?Uy9EN2FKcGtYdTdDYisvZnhrQlZzb3NleXdYZDY0ekRVdm05aUdjS08wVFpz?=
 =?utf-8?B?dHV1blZ4eDNqTnh3dUpvd2Z1VDdsN3l3NUdTb216UWZNQmFzcDZjWCtNci80?=
 =?utf-8?B?R0o0eEpHeVN5YlJUVldiM0xNUnEyUzhOamtDMjlPWUpmOERFZEhtUTNJZDha?=
 =?utf-8?B?djMxUUhEcDRwSHIrRDJOaHZCNW94QW1TN29NWDB6blBqY0tobUJaWTY1d2pr?=
 =?utf-8?B?cVprMHpnYmNic2UrRDgzQy9Sd3FWejZyQnlaaGMrd3ZDc1g2eFFSb0tBSXlt?=
 =?utf-8?B?Z082WVYrQ0NuRUV0N1dMV0lmTmllSWF5Z2l0QkZlWm9heWo4UU9YZm1jejdM?=
 =?utf-8?B?L3pKMkVxRmhlMnN2ZGZCYU91Mnl3VDZqN1BpaWJHd2hEZG9qMEdmUFBINHMz?=
 =?utf-8?B?WUNHUTYwamEzWEVQcDlNSDU2VTlJWTdoaUY2djV1MEFyZkFpZE5oTUtLM0dS?=
 =?utf-8?B?TW1aQ3FDczFUbVM4K09ISXBoM3lNMk5FQnFRcGtXYys4MHQyWitSUnJFbG9N?=
 =?utf-8?B?T0JKVGV2Q3lsSWt5WkwrdW14bTJPblIzNEpuUlNORmEzMFM4cE5ZTnk2dC8w?=
 =?utf-8?B?UGNKc25INWNRLy9VMnFFOHRiZXVZMjBVVnBLRFo4R2xVNHV0RHIzVGtzdzlN?=
 =?utf-8?B?Nk5Rd1lFRVM3VWU1dXRsb2puS285WlcvWkY2enV2TWx0dXdKa0tFUFdTL2g3?=
 =?utf-8?B?T2o2M3Q1TEZQa0E0NGFtK08rbVVWZnA2dlZrUU5lMGtTVDZrRzZxR0JzOHhS?=
 =?utf-8?B?cnI3dTE5cFI0OGdRL0pqRWFDeEkzSmFMaHZZU0g3aHFmbmJ1YW5HclJaakVr?=
 =?utf-8?B?NHN3SlJhdE14VXJXbmZqTEc2bXdNS1lvd3drTm1LSzhJRmMwSmpQZGVSL3JK?=
 =?utf-8?B?SGpBV1FLN2prM2JnWTcrRkpISk42blZ3dVBSOFlGbXFKc0Qza1ZLOTErZFk4?=
 =?utf-8?B?ZXpNZ3E3NU9Tc0ZVVllRdGFYblBqc0dnZ0NYSyt2L2hLdWJvbjhDUXIyazZT?=
 =?utf-8?B?SG1OTmlLdnJxbjhvblMxNkkwU1c4WG45OWRzbW1WWStDYUV2U2g0VzM4NmJs?=
 =?utf-8?B?b1BPRFJZVzlzeFFlcEgzNlI0RG4zU0FoMmdYMEZGajVab1pnZHJNanRPbzRx?=
 =?utf-8?B?ZWlWcGRNMHkwNi9ISktNRVFYUEF1ZTk4cjk4ei83cHI2bTMyenBMMzRuK04r?=
 =?utf-8?B?T09SUW9TOUFCLzI4WHhNUWhWQTBJZmhhTXRQc3NLNExUUitSNjUzZE1hbTFI?=
 =?utf-8?B?ektKcTZ1SUZhNnBQYzRZOVc2a2J2Wm1IZ0R4S2I2U3h0TlQvU2YvUmZ6OGp2?=
 =?utf-8?Q?ttMlR5pY4UA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlKYmpzeGNiYjhvSkdmbEEyNFh4aFhHZHBwbHJ3blUyVmlTeEg0SFN4T0RR?=
 =?utf-8?B?NVMxK2JZZWpwSGl3c211ZUxGQUpPK2xabU84bnVtMW1kQjJKdk9tNUdsN0xM?=
 =?utf-8?B?Mkt4YjlqaVZaQ0dTZjlaK1VvU1U0Y3B2TmtqNExkMHJnaC8xV2dHYW0yMWhK?=
 =?utf-8?B?MUtTREZwODdFb2tzempoYStjOU5QWVFZb2puYk05YTVac01XU2JESU5jN3ZJ?=
 =?utf-8?B?ZDBJYnhDcm1ZNjZlRThmcm50MW1hSFN1Wmpmc2RGTU15SDVpY3JGTzlZYWpZ?=
 =?utf-8?B?R1FlUEZBMDlWejk0ZTl2YTBSN1ZoR0ZSWWFIOU53enpQb1lhS0o2b1kzdWJS?=
 =?utf-8?B?M2lUNmRaeUd3NWthNkcrWksyVjFLeHhJS0ZXZ2h5WDYrd0xrdlRPcVJ5STQ5?=
 =?utf-8?B?aDVranJEV2pCM0FTZnJid0lpWE5JR1h0TEw4a2pMc3FTV0ljaTBuTFJaZGt6?=
 =?utf-8?B?Vk1Da21CeGZNRmIxR1hlRkNISE03THZlNlFiN0VmODdlcWxONTlzMjFFTE5P?=
 =?utf-8?B?ZW02VDVmc21iZnVSYldRT1ErMDRwNTd6L0N5eGRDZFp6SUNKSXJYT1hEdXh3?=
 =?utf-8?B?dUEzdzV5WU92dEFuZUxsb0RISWF0K3Q1c0Y2YWZyUjNSZ3lCQjBzWVhnekVi?=
 =?utf-8?B?SFlidDE0a2ppMWh5dndwdG1KZmFYVXREYzFRMWNKcmdHcnZlLytHV1IxeGMz?=
 =?utf-8?B?VFF5RThhNUNNWlc2d0pCQllZUkFVVHRKdFdFejc2VlI0UjdraFVEZXlDMUVo?=
 =?utf-8?B?V0FCdEVpZUxYVWZHK1hnc2hiYk9LVDFzUzZ3eFpEOWNEeE1pbWRHaS8xYmJN?=
 =?utf-8?B?SjMxbmg2WGxCcTZRTjBlTFpvOEFlTlg1alhzdkkzUEJ1cHhtUTk1UHlwUTVE?=
 =?utf-8?B?b2pUMTJjdHRyK2hGSkNKdHNLazMvYmlqNjhQV3Jhdk9zUHdvNWlYcWpjb2Fm?=
 =?utf-8?B?bTZYRFJycnhEUVQ1eHg5bkVRSTBCUzA0NjJPb3ZzZnY0VlRSd3ZuU1Y5OWZo?=
 =?utf-8?B?OFpSSXVYbVFHR2hWZTIybEFtR3VtN3ZqOTQ4SUFhWkxpTk5sUDVkRTUzeEtu?=
 =?utf-8?B?TGl1eTF5TDNLWFpoc1o2RzcvdUNJZVRaalMrVEhlcWtzSVdld3FoSjRaNTlr?=
 =?utf-8?B?Zi9UM1UvZTNud29yUnhjaG5nZlpmdUhMaE5ucjM3VEh2VDYxdDY3MWZUYld6?=
 =?utf-8?B?NnNETGlhZnhGVmlkakowenRERFJSYUo1NTg1eHFENGRadEphVFhVOXBSR2JC?=
 =?utf-8?B?ZE8vNG5GalM5R1prUUVoR2dSS29WQlNBTUErMnZUOW5VZGRvYktiVWUyS0x1?=
 =?utf-8?B?cWxVVjZFU0Z6TlUzSFZKQVZTS1ZwRVJBdVFDYjRsNW5vLy9IY0JhcWp3YW1B?=
 =?utf-8?B?OU5nWmU0dG93RGtTM2xuOEE3ait5Zk12V09EYjM4WXJkOWpVY3AvRzZFSzRn?=
 =?utf-8?B?KzBMWTVUUU85eTI4T1RqcVlFbC9mdERNYlVhU0tCWTZyY0o5T3dacFFXeFRK?=
 =?utf-8?B?U1BrTDBSS2t2SUhjcXJFYkRHZS9nM2tSZ1IxbGVRYjRYbDZqaEpMS0c1NEx2?=
 =?utf-8?B?eWhOY1l6bHM0WUhyeXBjWWZiVjA2SGFFMDJ2MGJpUjdmSWRGenBMczg1MC9i?=
 =?utf-8?B?K1BaV2tFY2J0TmhzVXAzb2NWQVI2WVBxaXgxRWdGZzlxN0Z0S3pNcnRXWEFJ?=
 =?utf-8?B?dWg1SEpua3lzb3BHbStBdEk1ZU92WnJ5WWZYU002QThON3lTakd5dTNuSnZu?=
 =?utf-8?B?N2t2U2hHci9xd0s4MTRIcThhVE9WMWNTWVR4NHB0bUpkTlJ0R1pBcllLaWpC?=
 =?utf-8?B?Y1AxWW5jb1BjeHpRbDFtbWVtcXJ5ZnMrTjVmZWN3aFJHdlRwSWEvTkhaM3lw?=
 =?utf-8?B?L04wVmxKQ0Y3bzNmdXJ5RXFnMVpxMzFEVGczUHBRTEczVzFIR0x4RnF4MDd3?=
 =?utf-8?B?MWxRR3hBeVJSdHpZT1VTUGF0Q0ZUeStUSVdQM0d4eHdkcnpsbFFjSkgxbXlZ?=
 =?utf-8?B?ejdnMkZlMTFQRTl5dFM0TVNEdmRWMmtNcUc2NmdHMCt1cnZyQXdQeHAybFZ6?=
 =?utf-8?B?ZXk3RUNHODMwSUxxQWIvbnFCN1FYeEluN2xORzQ0NUl5YmtaWE9lTEl4QU40?=
 =?utf-8?Q?Z4xJF37Ox7aD0/DERXozLr/hu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c3a13-20ca-44b9-a836-08dda557caf2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:04.3779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9FT6zoVPQnIePAZvb+I58upiXQZJAEBcOsIE+0UArGaszLf38LE8E4Ef/uMaCJwtgx5twPVdeBxgEhwX+pucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=6843839a cx=c_pps
 a=Ft05trlkDaS5pCTE1vB2kw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=2LkpXHDO6wTvJR3M3DsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iaf7qQSB7d9-6AcYK8dQLMG_2qzIxYvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfXwh11FnGmkJi+
 I5mpBVxNJLHdc/VUExljwBQqvrZNyeomRUb+GG1n2tX5Pf4h/0PWIF5XWA9TdNcieW9BfY8ZW9Q
 Tt2zBK+9DIK5vPVqXegxHnqlSk7QtGY0RpwPL0X2oz9XOkDeCPdVMKJ39X2VB1Hrce7ZdkutwOq
 MvDFsgCiVnyEXujoj0c3urt/vCx3pc8PhxaBa31y/eRu/Kpk50Rq2eROczYDQCMVdbOsHGbA5X5
 VWDSsD/GBQgbPb+k0usle58c5AiBofxPsVd7pE3gUHDcZjxcEyij4IeQ7TsyWAJtAvcVpScacdi
 06De/2ZVgZ2ytSsRppQRCitCIAjkuacDm1D66BBUDUOaV6/BqF9V4tLMi8oAsqpo/ANRJyL7ie/
 U/hhlwN4/+2zEnntK9VXC1kV64fZQXOxRb1ImtuB+daRWaLd9QEsnkOhb2JZiiRj3JUmtxAP
X-Proofpoint-ORIG-GUID: iaf7qQSB7d9-6AcYK8dQLMG_2qzIxYvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For vfio-user, the region write implementation needs to know if the
write is posted; add the necessary plumbing to support this.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h | 4 ++--
 include/hw/vfio/vfio-region.h | 1 +
 hw/vfio/device.c              | 3 ++-
 hw/vfio/pci.c                 | 5 ++++-
 hw/vfio/region.c              | 3 ++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 5cb817fd6a..a23ef4ea13 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -207,10 +207,10 @@ struct VFIODeviceIOOps {
      * @region_write
      *
      * Write @size bytes to the region @nr at offset @off from the buffer
-     * @data.
+     * @data; if @post, the write is posted.
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-                        void *data);
+                        void *data, bool post);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
index cbffb26962..ede6e0c8f9 100644
--- a/include/hw/vfio/vfio-region.h
+++ b/include/hw/vfio/vfio-region.h
@@ -29,6 +29,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    bool post_wr; /* writes can be posted */
 } VFIORegion;
 
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 29a8d72deb..ad0bac9765 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -569,7 +569,8 @@ static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
 }
 
 static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
-                                       off_t off, uint32_t size, void *data)
+                                       off_t off, uint32_t size, void *data,
+                                       bool post)
 {
     struct vfio_region_info *info;
     int ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 714d37e227..d68c1412d2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1015,7 +1015,7 @@ static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
 {
     return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
                                                VFIO_PCI_CONFIG_REGION_INDEX,
-                                               offset, size, data);
+                                               offset, size, data, false);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
@@ -1819,6 +1819,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
                                          ~PCI_BASE_ADDRESS_MEM_MASK);
     bar->size = bar->region.size;
+
+    /* IO regions are sync, memory can be async */
+    bar->region.post_wr = (bar->ioport == 0);
 }
 
 static void vfio_bars_prepare(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index cb172f2136..f5b8e3cbf1 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -66,7 +66,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
     }
 
     ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
-                                         addr, size, &buf);
+                                         addr, size, &buf, region->post_wr);
     if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
                      ",%d) failed: %s",
@@ -200,6 +200,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    region->post_wr = false;
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
-- 
2.43.0


