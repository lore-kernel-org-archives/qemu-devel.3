Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6E2C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWi-0005hq-G7; Fri, 11 Jul 2025 05:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWg-0005dI-Kt
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWe-0004nY-6M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:42 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8UJkq026118;
 Fri, 11 Jul 2025 02:58:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=aHCHF4ZoZc+/RdpXMdrFR5mJCRLMp3UlYBKDQGHZc
 MA=; b=iKAKx0/m0vplEIVDqaCRUdKg9hRv2mraSM94rVhLsNopFiZ+/DAOtIGm1
 3H5UF5P7d8Fqga4fxvDDiKa0jNfs9DcLTZVOvpaKBtp+Rv026hM+e5xjok5FE2XQ
 Xuy34f1YIYnaRUnvkKoWCvjXkpvhWz5noRUPm1Iwla7HuKF3bx7XMLHligQYa2cn
 0CFgLoY8fJR8uP6OK29NYWS0bPMbgHPABD71OwZ6n/yyaLEhqGUKiopielkVsd4b
 rD5GsR2nUWhcYPOiffK/BlxsVdwafD/bwffXHaMUKCeJYONFuDPHYsUQ/Aw2id1+
 +d5eCkneeUG95k4/nA8Rt2DfX9S5g==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022126.outbound.protection.outlook.com
 [40.107.200.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q0cvr2bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIwViield2Qu/qpCAqO2DfzYz6huqu+q12CLz6Bu0VpYR4zmTpesKxm9B8moocHkCz5feF3jQyaVvVr7cFBoNeAPPbx3Tx2IXtTqZq4eLCBaXJLYdzxKdbX3MOdU2HV8BP25eVLTZr1S7/BbNaIZmKzzFufziA/ssBkUk0DWxhXDHSPo74wgC2aLuwejHoUlKbfl8Vrx7cLM8nYWIS9vc6zu4OGnfC33n1/6DivfBkPd2L459/VaImbbpeJod2XK6reC6oQxuaGWXDmXLclA/wM9L1rIo0hlb7T8VoskSTI3mfWGUKEuvjrh77RASt95GkGMAU8Ig8t6RguxsG9Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHCHF4ZoZc+/RdpXMdrFR5mJCRLMp3UlYBKDQGHZcMA=;
 b=yoRHyevBA7fOTqZheuETNl3+xRSttqIug7zviCXimZ6a4e8W3obmnxWMJM4lBDrFbXVf79cxZMDoQokHtrb8J0j7yOmo3ZhWsESgr9UPEVF8rM02MY9hTLbJkwAzt1xkdpjcWAs3x23fFCBRbK3AYWDmm3F82LcFQ8J25OXhOeWi2g75uZbyJ2DUnEhQXsilNxDLgEmJADGFTRC3wddFiJNtbxt3zZ23LmXJuYOdSIZHHMMvKezXmXmLTO3XMruBwtI07zljDvToV5fAup5XMyWnetZXiwcLylSfm5q5jkgSrICNrVhbm37QGSH3m+uj2Gx69U05z8VR3kabIjDYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHCHF4ZoZc+/RdpXMdrFR5mJCRLMp3UlYBKDQGHZcMA=;
 b=pfmRqxXJkwBiKmzcuqQG9LhMMbKNBkCz+0yGNPfjSJMK6toJ2wuGid7A/pg+blqkTgI7RbUyBpWyn4n9ZNUh3eJPzZyDqyrZ3c5VubfRGTML3nJ8bkuhWcJRc+5F9gopZH0OAARQILO/IZnH7CmLHxsdSjatt7JJKnsCy/7y6M3LCOyNOsOofTnn+D1qLG7iXZzPpfS3JlrigdBdKgtdx/Ve3SuobVBKEuUBthpKZ2cb1Qhl7UrBQ4Wqh6+rqCvw8okT/L6GR5L0qVbwWtG4qaDjfydAv9+TD7tSQVXybLgPu1zDlAjFT8XHFWKTCyOVZLHeyOe13zi78WN7MKBJWg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 05/19] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:07 +0100
Message-ID: <20250711095812.543857-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: cda38968-73ba-4670-56a1-08ddc0617fbe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1pYUkVPODVJeGVzekpRY3BCSmVNQzBoaFVSakNxM3pCVEE4WmZoWjVJTTgz?=
 =?utf-8?B?VTlDa3E3WTYrSkRJeVZLOGlKaXUyRkprMTg0c1hiOWlkK2ZDMzI0WC96eXVa?=
 =?utf-8?B?NXBERnpXKzJRaUg2QVZLWW83QVgvVk05OE02K3FnTU5DNkpoYUsxWSs3UDho?=
 =?utf-8?B?ZUQ5WHcrT2Fvdm1KZmhIYkphSkt6dFpXN3RVdWNMT1hHTXd3Wk1SeGJUcWJN?=
 =?utf-8?B?WXFyVDE1SGphMzQwSXB4YkNrNkFEdnBZL2ZzbDVFTXZ0ZGw2TmFNMzJGOWdh?=
 =?utf-8?B?UlM4YzFZcG5UOWFMR3cyRnkvUW1jcFgyKzFuemYrZFJKRk10bm9hdWlXYU04?=
 =?utf-8?B?Wk0wdDg1UDAxV1I3Y3VxUG9lMmNJckhyU2luVDRFTkMrTlZQU0lQNDduckxY?=
 =?utf-8?B?dlMyNVRUODVPaDUyY0huMjR3a2wxYVVUeFprcWdPZmJVa3RPbS9MSlRjNXZV?=
 =?utf-8?B?c3YwQ29WTDlaK1Iyb3VuREphcmJCQVc4dVR3M1VCcWlpYzJzZU81K0pBVytC?=
 =?utf-8?B?L01iMmVuOHJQNk9aK09PUEpSeHMrNlBiQjJmT2JIa2dheXdReVpWS3pvOGpl?=
 =?utf-8?B?aDErQkN0WUFTRUY5Skk4QmlWWWxBVnhpYkFpK1pJSVh0L2xjdHo4QkRyd3dQ?=
 =?utf-8?B?QmhlWTgyYzUxcmxRYUxIelBxSERFeDNGVFNnR2ZKZWtQV1l1WGFzUE1WMGtq?=
 =?utf-8?B?UXUwTmIzRE81bXBWNGdYUmVvNFJqM2M2Z0Zpa0orbTRUUW5KQUlFU3p3bTdT?=
 =?utf-8?B?ZFczVmNaczFKcmtYdnlQMFcxR29pUmFYK09nbTVERVE0Z1hyQU9XNHNuOHht?=
 =?utf-8?B?b1ZzSXM3aXBRa2xNT1FEUUoyMnRreUtoaExzUit1UExOZ0RybndkYVNIc2tQ?=
 =?utf-8?B?TUdzZFAyZktyOVB0LytXTmJ4cUE0T2N1cW5qeU85RlNoeWtyK21DUUdPNUNN?=
 =?utf-8?B?b0lKQnllekdWOVdkZUoyQTlxU3JhcVFvTUQ5SXRBZXFkSUlES1lLeWVDZlNB?=
 =?utf-8?B?L3pPZmprbW56MVdnb2RQYjZHMkh2d2Vya05vSng5ZEQrWlFWOHRaNDlZcnRN?=
 =?utf-8?B?VWNRenZwSld4bUNuejM4WnFOSGRsSngrRUxnY3AyWFRwYlY3b2xicHVmVjll?=
 =?utf-8?B?QjJSdG9OUlQvMnYweXhRNUd3byt4UXIycWZmNDVCeERXcnM1d05jOG5lVEtx?=
 =?utf-8?B?NVBuYzlpUzJmVFExWWFud0NramFlWHZzTTgvdW5GNXZuK09SeXUzaXBnWFcv?=
 =?utf-8?B?Z0hjR1VhSFBkcExjQWJKbFh2SDZ2Mnp1SGlOdlFlRkRXLzArZkw3emYxb1Vt?=
 =?utf-8?B?S1VIY0FHYkltbWVoVVZPdUwrTFB2TkYrMGhnRlFJRzFaL1JHREtGNW1IWWhF?=
 =?utf-8?B?RmRpU2FrUncwdjdScXd6RlU1SElNME1sL0IvS2puNkRORlFwWWk3VGdtRzBZ?=
 =?utf-8?B?Z2RWZ2JQbjBZOUFiUHNrOTRhS2pDdkVkQUpYVk9mZlR4SmljUGZoWGJkcHZZ?=
 =?utf-8?B?OFlpeGU4ZVloN3c0Y2MwbDZIQTdzZDNJQjNRaWg2VFJYWGc5eU5HZEJmUFUw?=
 =?utf-8?B?a2FCU1dFUEhSSW9zM2EzTXJCbktNbmxvdVF1OXM1a0JDM3JtMTJuN1ErazJW?=
 =?utf-8?B?NFpFS254VGxXRGhVZ0dScjlpSnV0azJjNE1BbzdUZEpIRzZFaThkUDRFb2Fn?=
 =?utf-8?B?RDBnOE1DQ2FzMktmMkE5clgrNWEzM2lPNmV6YjVSUXJhQXdCZm8vemVQbFoy?=
 =?utf-8?B?YVc5amhIQnQzWnk4N1pJUldGcTZtNW9VdGhHZkZBZUJvcVhHdEFmZG1DSWZV?=
 =?utf-8?B?cTdVSU9OeXcrejczaThVU0t0aDhQaHQyMllONU40c1NFa2dRMVBjRDRCMS9v?=
 =?utf-8?B?d1NaRWdhOGpTNkRLQ0NPcVJyMzd4TjYzVWZRc3ZORHVTeURRQkltdlc1NC9q?=
 =?utf-8?Q?0eOXmxKnFg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEpkdWhYRFJMdFVlYmhpQzhVdGxHZlNxcUFtWmRyMVJjNnh2QWUzazA1YVRK?=
 =?utf-8?B?WkV2RS8yWFhWa0IrbEcxWXZ0WXZpL3lLdWkreGFTdFlzTFRCYXNESE00bzBU?=
 =?utf-8?B?NmtkdmMrcXpMdFBNWk83UkxEbU1QUE9kYk9wRHFFRTd2bnYvQnpWT1JUZEJ5?=
 =?utf-8?B?WWNuNWE5OGdsVHF1Wmo3L0FBZFR1NXpvMFdnSWdhNXFTVC8xTm4yU09NK00z?=
 =?utf-8?B?RUZ4TTZLUnFmOEV5OFVvV3Z6YmczVDFCeCtMSjNjSDlEeWR1KzZ5QTBQc0hP?=
 =?utf-8?B?N3lDT2hDVnZ0VTg5N21ocUxCNVgwMk9DVUlQMFcrUVcwY0FybUszS0IyUWt1?=
 =?utf-8?B?ZjRxYUdsQi83VXJJOTZhQWVxWlhoSnF3eWFnb1o2SndJOFMrWHdydmJVM3hh?=
 =?utf-8?B?MDhRejhLYUphYUdsb3ZyaXVKOFo2OGZoUUEwNU91NWVrN0FBcmlIZTF6U3pZ?=
 =?utf-8?B?R3BjU0dKTlVjQTZPcEc5eUJRMGZjUXpUSWFTaDM4TTh2YTdSRGZvdWNTYTVD?=
 =?utf-8?B?Yk9ZanRqUFBQVVdmMzljcXR6REJ3aGxpbXZGQjFEcDNGTUlWZG9nQWkzLzN1?=
 =?utf-8?B?SjlBdkV6amdUcEtvZURTUUpMUE13aEdHWTNxNHo2RDdubndZQmNYWk9vUWtw?=
 =?utf-8?B?YlNRbFZzdHUyY0VKWHJlM2NJSStOaHZCSXlWWkhQYWpTL1lyQjhFL3FaOW92?=
 =?utf-8?B?MnFHQTNQWTNpcWhuS3lxby9YNjVHcnZhTS9oYUxmOXJUSW8xRmdHTGZxeWwz?=
 =?utf-8?B?cytLYnlMaHp1YXRsQjRHMEhiL0pkbWc5RExqQjBkaDhtQ0REZHRXRTh6SUdL?=
 =?utf-8?B?Sk50WVBlOElLUjFneDRlOCtld3RZUTlBbFhWeVBUZm9Ob1hEWFEzbTFYQ01N?=
 =?utf-8?B?YkM2SmltTEFZOUczOS8xMlN0dVp2M1h6UGN3akY1ZFpLenN3NS8yN0pON1Zs?=
 =?utf-8?B?MG9RVVhVTTJ2T1F3VmtGcUpsUklGTGJrVzd4emwvS2ZOUUZQNjk5endNdDFO?=
 =?utf-8?B?K0FnV2I4dTAyRG1qSlhkS2Q0S3ZlaVVzNEozTTlPanNkUlE1ZmhwUWxLU2N6?=
 =?utf-8?B?aFNwaThWN2ZCTjJ2WEZTTXIrYjY1cXN6ekxzNUZJeEl4VitwWDhXdHlSZkYw?=
 =?utf-8?B?SXMyc3NlRnNoY1FGcXFyRDVQQTB2NjFBcGdFYmZvRk0rSnRMNFhiT1ZYSEli?=
 =?utf-8?B?ZUhhNmtQVnVsYUZiTzY2eWR3bVhXSTdOcjVOZkgxR25na2paT0dQMWVuak9h?=
 =?utf-8?B?S1VBMTZjbmFvZ1Q4eVhFN014eE0yemNBR3JyZ3ZsSEtUWHhaQjFTWlNjTG45?=
 =?utf-8?B?UFJVdDMydUp4dnBXOW91ZEVZcXh1SmxScnQwakFNeGdjZFVZNnJGb2ZxNWI2?=
 =?utf-8?B?Si9XajBrZCs5M1FZMTArSE95Z3dWVWpDYXZreXJnd0phOTc3L01yTUJpR2xL?=
 =?utf-8?B?ODduNG40RDJTTmtxTnVSZ0pRcU5MeWJ5WDI5dFVrRFJ2WDhJcmo5bWhpK1NB?=
 =?utf-8?B?UkdIZVE0QXRiVjFhTTY4V052bUJVQml4a2xlRHJxSitWK0VkT1Fsc295WDg4?=
 =?utf-8?B?eE9QRGVjSFNzOWM2NVRlSHZVS3Q0aFdDTU8vaHYvUXFpS3U1T0wxN1VzL0ox?=
 =?utf-8?B?QjIxQTRPcW94TVdSOUMxczA4ckExS2ZiK2NXcmZlaE9ZMUF6dGJkWW10aGhF?=
 =?utf-8?B?TkJScWxiSmk4WmNXZ01rbkk1QnNQTGpEa0s2OWxNOTBzeERDWFk3UWR0Vm1j?=
 =?utf-8?B?WHRsaDBwVGJuTVluMnFGVWZNajR2OUtNUXJKaWtqeTd6dUhLVU1TYUNtZnEr?=
 =?utf-8?B?S0JVc1EwbDdZcXFjL3NYYndRNko5bDBuUU9FbWF4Vk03TnM5MzhWUStNZDVx?=
 =?utf-8?B?d3RFbm5xeWVpVnEyckFWM05ybFIrOG5EMEZrcXZ4NEZxNnVkSng5dGc4Q21Q?=
 =?utf-8?B?MXBERkFHd0h4ZTdySjN3ZG5qL21jZ0VMcVdPdlp5YmY4MUcrT1J3cW56RXRY?=
 =?utf-8?B?UmNzTTR6L2g1WFJRWVAyLzAzbGk2Z1E5eDZjd2pRM1NyVk5rZVN2NXQ4QXNF?=
 =?utf-8?B?QVhrQ3RIdzZYdVBwNVJoV1QvV0ZyMlpTQyswNzBBb1lGR3h2emFGWEVWMEtP?=
 =?utf-8?B?c0FsWmY4NU43RXJqdVRHYWNlM3BlRmF3NjFFdDZ3N3Y0aWRmNUgwTVluNTF1?=
 =?utf-8?B?TDluY1BWekROa3lhTWlKaDA4ektSK3F2Z3hONElyNGZYRzN0cmIrUUVzY3Vv?=
 =?utf-8?B?RjNxdnRSdkJlZUw4MVAwelNDT2lRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda38968-73ba-4670-56a1-08ddc0617fbe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:34.6014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqYi06ls+sa3kSfjMMPnNdZpbigI/vDCt1b8srRtupwIEn0FGFra9aA+uL3uHlKb+9hMp6A6ZMcvzvawB1uWclnbB+2Lw533Fa0PGiJO85Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-ORIG-GUID: xQbxkz_HnySuuY1OwstXRxRcW0CHbaOR
X-Authority-Analysis: v=2.4 cv=ccXSrmDM c=1 sm=1 tr=0 ts=6870e04c cx=c_pps
 a=LXS4Agk5KWHItNnKvyvmYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pDVciPHeplB8fhom_mUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xQbxkz_HnySuuY1OwstXRxRcW0CHbaOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX5QB8sfc4sC6J
 EdijdkZny+0Y+ZX7xlRk4WulYOWXB4VDqrUR+YE4dP95TBAweTDNXid0xGsA/zBr6ZfJhYS7f7T
 HS0jStdvZCfvtt5CQvB5MtlZHN/xCrbr3yEOHE6DWjs/foyjpEKA2YqP2hmV9rq+vJWNxHGAScc
 HYLPjpsaGz5ieCt//zqSohUa/lgfY185xA4klUTFTPDzxGOW6MY2gG64zlZDkgRGW8sr3ms90Yt
 jlR8DLKpobqns3DNPMltTGpulvHkK0gymI9G9xGIMKfLeriEV3kN7NGfsgJqees/L4FurWUfi1G
 9pKafHjZJVVsBhRzsuHdaxSr0pwMuMaJL1JOSwTd+Bm5ZjA1Vf3uMMYZgXo/5JX1mAOLKlsvsXz
 BJdRKZMbCCE83WGohLYcxp1J3W9BmyFMmZJisXO+YTvCrR9ERvdI89nOukAPvcIM7wGcoTdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PCI code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f576e98727..1a4b14ba0b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -417,19 +417,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -517,39 +514,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -566,74 +530,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


