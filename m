Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63330C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNX-0004CK-EN; Thu, 19 Jun 2025 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNT-0004BS-5R
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNP-0008CY-6A
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JBwK8m024158;
 Thu, 19 Jun 2025 06:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=I+gaiIVzsQ+G7ssGyHh2v17wDdt6HDwsIqmTKtnM7
 qc=; b=YULU1reXVWFJs+U5AIluGuG2btpogxUeXWli+wSbdj/ZEah5QEjyq8olJ
 haXbAGuHaxNZ/AW70xXM/3seP5DrP++j2BeSwnUKBObtfDFmdWEZYsOwswQ7hEfo
 iavmFRAX7NQqqgUI6u5Cq/3oclKMFA0dtejhcjvNK9ptGSUGcOYMnVYwC8PdQR8h
 37uF9QPlHxvX/YlD1ck8l2v/coCNYb90fSstGWLBTcEr3zXwEn1I1DknLmKvjMYE
 J7mRzDwoCqRX6wd4/JFiR2yiGfjROjWrRNGS/uAWlFZ/W/dbu2FRRVsvhw/Zt2QI
 Z/U2MmJqtWotVoYyRm9ZeU0wsI4RA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020080.outbound.protection.outlook.com [52.101.61.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47c0vfjedr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/H/P8F8RzW4Y8mMHdWHBmCnV3XWIWGof4625M+B52nqgylKmwgV/m/VP9fbsGOoKvjB0sjfFzMWnAT1M6ugl3XQ+T8ZUFnFBjxt59QG/oqKyjJWIVvyR3WGndZPlCc86+w9lWAPopLEmo20hQsxKr0XyuUY6uKhk57Y2BmEobz/T6XWaCuB5tMzlB1pKsN/ICCebLUe2JYk8gx3xv8OYYz01kYMZteRtTu2ClPw2CroUouela8vTrDSs5PAVbrXqxxTlZbyiGXjPDdooKVj+zoOpmEDRZkfpVicRmEUa8mxoYeXRRashLj9fDd6cZ2W6uj0Zvbi0OGQybok8fNUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+gaiIVzsQ+G7ssGyHh2v17wDdt6HDwsIqmTKtnM7qc=;
 b=Lnc+9xLkoxIslcL9i1pnjvqiqr42/nmROQF119CeTKGOMGWjPRDeArGBDVavo6WR+nNtXJ9i5EJquXH+PnEYtKh3VDLKhYe01HL31QE4oaUJCFGtvYlVNRXI/IruFDhW7O3OLm3gRB85Uv/H/j8nlmQvQM0a5boWenc2RDVq3qnlS4UgeHRJ0rXMfgltzNt4r+Dueptv+e+V4CHaBYpIjG5ahV41hZYSBYTXdzwg6t6JfPwRvX+jqHG61Bp7nkdx5RrkHJCFsbc7IPoyyg2W3rPqU/85DLMA8hZxGbkKIHaYkmL3jAWKR76sKxUd96kB4+LjxhGfEUtjKgF15niVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+gaiIVzsQ+G7ssGyHh2v17wDdt6HDwsIqmTKtnM7qc=;
 b=bPjgRYKWrAZaSG6De824HveoPutKU4ZqPXj9o3PuQlKyxpJ9+zYmdMmSIEk22BhYldnDwcRCMoM0CTA6o9NP0kVoGg9OIm9vewK3a+cX0NBfDSWPVfdIROM26ymNEOesS3DNyfDpa79WZxtF2/f+z8tPucVnr6bOlUw7DvA8CvGMWg7DqZQq4s89kkkJWWjP+LeuUA4IjRYN2c9m1xArfsaPWsEedRrW3JmHZUZ5Fvilc1gIXNyhKXH3hIFvEab7C3TOpKgs+UpspIaqLsJy1twjl6eDiUz2Z1cZ7p3n0PR/D6gWiLi/lcbK5ks2aKol3zi89evf/K2Wyvkriqybyg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:03 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:03 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 02/19] vfio-user: connect vfio proxy to remote server
Date: Thu, 19 Jun 2025 06:31:36 -0700
Message-ID: <20250619133154.264786-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfe2141-6739-4793-ed00-08ddaf35ad58
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkVOM0Z4YWI0d3BSV1NRTUg4VDZHOWQvTjFIWUhRam1DYUprcHVyQnNlMTNv?=
 =?utf-8?B?NVNLenlSbDIxVGRCenIwa0JneG9ab3d4RzlzYmJKaXNmQlpMY2JELzJiZnFD?=
 =?utf-8?B?QUpwSENCeGNlVmo5ZGlPeGpFbVBUT09EaWN2WWxrTXQyaFMwaENoNmpkU0Mv?=
 =?utf-8?B?UjdGcStaR2tKWmM5Sk9sVVFzTmVONzVJVGRlUlFITEl5U0JNRlQ1cmtCQUFK?=
 =?utf-8?B?ZHhUNHRCd09tZTJFclB2N0hOK0MzRVMyempqSklYT2JEcmNudHVoUk9wQXpN?=
 =?utf-8?B?eldjdTdlSCtPdlRndHVadW4yckJqVHhoZDhBYTh1TlVndG83MlZhd21HN3RP?=
 =?utf-8?B?SVVFbktRTFA4UTdqRDYyaWFtY2Y0YmZycVJaUnFqZ21Wek5Ra3NVQUR1WDF0?=
 =?utf-8?B?dURHbi83OWNLcWFQdGZna0JMMmR5MmpYNGxGNStzTW9CWDZielYrT1Y2TC9D?=
 =?utf-8?B?ZUF3dTRBaGhUMzBpWEp0bTVPL3pKc1IybGRYMW1FM08yTE5LTEdtVUtWTTFv?=
 =?utf-8?B?bXI1SWw5dnBPNlFid0F4MjgrTFIrR01IRTl1Ky9ZTXJUOVN1aTNlOFBWTjlF?=
 =?utf-8?B?dlNxeUloNU45REs1aEpITUVpV25ObmRKY0ZYM0ZZdTE4Zk5rRVRuYVBCVEtT?=
 =?utf-8?B?WlJRWjVsTm1OdDNLNnd3Zmtkem1IT3g4YkN3VS9DN1lycEFiZFpNMFBVNmpY?=
 =?utf-8?B?Q2JEMXNaamVPendQWTluQnRsbmJHV1VNODl5WUNYcGM1blBNdm1HSmlCMUJo?=
 =?utf-8?B?QndHdlJ5dmYrakV6bWJsbVR2U3dYMVdZZGhDTEdPb3N5ZFVNbkpxdUZDV0E0?=
 =?utf-8?B?WjVtUlg1TlM0YjBwWUIzeTF6d3J4Y1MxNlJWM2VzTzVTZHI2ZVlOWUhpdmph?=
 =?utf-8?B?Wkhqdkd6VEF1R1I2cEYzbGMva0Z1VFJwV0NyVUhadVFpbEdyaWl1YU8zMHdJ?=
 =?utf-8?B?VWF1NExoYXlsSkkxZTRmWkdVbDJOcElLOGhJaFhrWmNKMHJxc0RvZ2NibWti?=
 =?utf-8?B?SGdVbFhsT0pEanpkTlcyQzVuMlFYbDZPSC94cmxLNWcvejVtb0VsSVRrNkpu?=
 =?utf-8?B?dlVIWTA1cjROWUJhYllNRDFEN0ZUSmEvUlZZNFo0Ykkzc1JNTHI5M2JaRXg4?=
 =?utf-8?B?UWZwWEZBNWVzTmxzbDR2VlMzN2xkTmJURkZXSEdaeTFUZFNkVkhrN0tSOEFo?=
 =?utf-8?B?Z2lKV1JTZ1k0NzI3d0Rwd3NPMUhCZnloMHo5MDY3ZEIvcnIrUWJncmorU2tE?=
 =?utf-8?B?TFQ1NVU1blFWOU9Qbmd1SVRxVHVlRG5xNlNSUjNBZFFyZ3dPTHNET3A2aFhC?=
 =?utf-8?B?emlLVjgxdUFmck5kZUZoY2NSV0dlOGp4NVFXOUZHcGVzYnVqMWVwUFM3MUp5?=
 =?utf-8?B?QjFKaUIwRUdzS0ZIN1BlWGVJSC81dzZKZDYrUFh4aXM1SWVHUmdBQUovR2JO?=
 =?utf-8?B?L3ZDRjVKelRVY3YzVy9VeUQ0YS9XbVZqSkZXT2EwTTdydFlwR1o1ZG93OGRl?=
 =?utf-8?B?YUkwRk5sUmZSMWN3NDV5d2IxUXhlLzdMU04xdi95R1ovZjllTFlDejJzOUsy?=
 =?utf-8?B?LzR0R1lBSjBzRDdwWGhESTF0dmQrVlQ4UjZyMkpmUnVSU0YyWm52UmJab2VT?=
 =?utf-8?B?RXJZUS9hMlpSQVJMNzI3MjVQazlwd1pYSnNrazR4UWlnVTNOK1BrSUlxVFQ2?=
 =?utf-8?B?L0E0ejJ4cVBDU2JheTJDdDBrZkVmamYzQmcvOXlWTUxmSFdJLzhDWWM0MEp5?=
 =?utf-8?B?UEd2bTRsZi9NTzlXako1M2tNZnVLOUxIdnhZT1lZZ1R0M0Jha1hUOTFpSlQ4?=
 =?utf-8?B?QTBtNCtGSXdKYVZIajRyaDBrTTNrc3V2aWo2VjkvR1lVSXY0U0xkRHlVTFU1?=
 =?utf-8?B?bWpsN2VTbTVaZlR1NFI1TmZmWGFGcy9mbTdPVXBpcW1NQW9pOExLaW5JeTBZ?=
 =?utf-8?Q?faT7LX+WiQQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhFRzh3TmNjVHZZRlJXTmtYcXJYM1FhbEFsU0ZtMW9GclgvN095d0dYK0NN?=
 =?utf-8?B?RG9JeURkT2FYZ3pmTFpyL3N4Z01WczcrWkFhcXRLQU4xZDJBRkN5WDNOSThG?=
 =?utf-8?B?SzhaRmxYbElQOGkvazQ4M0FmMXVzdjU5SHRKaUtnZERVQVMvaGVib1hjRlhE?=
 =?utf-8?B?R3Q5ZVVxVUx5dEhUcDNCZTErcDBUUWRGM1VTdGhLbnpuZGRGZk9sZFZMcElk?=
 =?utf-8?B?YjhBaVJpRHFyQWJRYVVFVXVHZDg2RnVsU09aYlhYYStmVVN0QTdqMURRM0dN?=
 =?utf-8?B?ZkVPdVF4eHI2L3pNb3pyUHBjUC9WbTN5TXZpWk5hYytRRzlDTVozU2hzREpY?=
 =?utf-8?B?S21KKzRFcnRob2d1cC8vdkI2MENBNThyUUxMbU50WlQra2JKRlAzcVdzUENN?=
 =?utf-8?B?QnJCYWEybGNKSzExQmJKSk1YU1ZPK2k2RXVhM2ZmRG9Wdk5rUCsyU0VTSkpr?=
 =?utf-8?B?d3JyUktrUUpaQ3E4NjYrRW1KVS93eHdHY3l3dXVtdGxKZUtpdUFIeGh0MmNy?=
 =?utf-8?B?RjY5WTBTNXpmUzBxSFYxMTV5UERqZ1ZIRGZTOHkyZDNlRUd1a2hFSjhmTFhX?=
 =?utf-8?B?KzdqeFNyYnNSK2tTYmhRbFoxZVRCVUIvUCtPWStPcmFwaGpzTFZqQlhHZldy?=
 =?utf-8?B?Q2FSRWhmZTUwemdtZFJzV1dlcjlOZVJxbWs2OFZlai9DdGVOVW16bmUyaW1Z?=
 =?utf-8?B?WW9PeG9Xc3ZvY2c3THJkODkrTzAyYzMybit0WmtRTXRsK2hRblJ0L1o5VUhI?=
 =?utf-8?B?Qm5sK0ZmL3lXZ0MzZERlRC9lRUlTamRRdjlnckR2WTNLUU4yQ3ZIQTRlWjEz?=
 =?utf-8?B?WXJTdmUrUS9nenN4YlBDK1loY2NkZlNVQkh5QzJPSEVsZGQvTW9DQXhyTHNz?=
 =?utf-8?B?c2hMd1FIUjV5MHlnaENtWUE3cnZRMGtYYWsyRUhYZ1J1SU1oR0NQbHRGMkdi?=
 =?utf-8?B?OGh3bERHU2pSQXJ1ZXBoeXRKTEg0b0ROY1pMa1N3OXNLWlBsWHhqVnlTNTdz?=
 =?utf-8?B?NVhROG9UUXJmV0JPQXg0ZHZUQ0ZmWGhwenNYRk1PYXVWcm5teDMxQjQ4dEFB?=
 =?utf-8?B?V3dtTGltRWMwc2ZhSDRsWklMVUxzTks1Z2RYN2paSndRS3g1a3QwUk1haUVj?=
 =?utf-8?B?cXNybHN1MmlmbStrN0lGejc2Vzc1NllGaTNCY1VONDVEd1p0cWZsWUxSakJQ?=
 =?utf-8?B?Yi9QNU9sNWpuS1JzZG1FOHY4Z0M4bkRHZkU3b1BrNVhPeWF6Wkl1Wkk0LzBW?=
 =?utf-8?B?NHcvS1E4TXdqKzBZQ1RUZjE2NHhYa3haODh1WVZCcFc0N3V3M0Z3ZjVoUjlV?=
 =?utf-8?B?QVkvbWhYWWFIVkY4dUVmNXpHK2JqUXhDQ2tiYWZRbHZTVCtMK1VWQ0xvSDQ2?=
 =?utf-8?B?STdoTStHUzdibTVnSTJoTXcreS9VWXRsNDNqdHVYR2ZiK2x6dXRld1ZSUmZJ?=
 =?utf-8?B?SzNOajJrVlRLK3N3aXlRNFhmeGFlbU5HbXNlNXV5VGlucC9kbkxpbGp1VndE?=
 =?utf-8?B?ajB4ekRNRE5zWmFWTmUrQ2xwUGV0NHdCL09SV3dzbTNSUzhmY0Q0cDhHRGo2?=
 =?utf-8?B?YTVrN3JnY1p2cFpEM0ZGR1V2YkJVaHl5M3BYL1pqMkhTd3V4dVBHM0s1aWF1?=
 =?utf-8?B?eDF1SU1pemhtTWJuZTZZTFdQM3Zkb0VWcmRuRzYwWlIrWlFGM3F1WDllejdV?=
 =?utf-8?B?L3FTTlFEQ3JnV1hFcGtRLzA3djBUUHhnSUtMQ2NpOFN5a0NZSW4xTTQrS1FS?=
 =?utf-8?B?Z2YrUXRRZDU5QmI2dmJYcnBacVlVUmVycVY0akkxVjRNUjFjRGJaM3U3T0Jm?=
 =?utf-8?B?V3RWaW1wNktCcjJxZEtpQkJQV3NHN1ZHbEVsYm40YkQwVHYxaUdFeWhtenV6?=
 =?utf-8?B?d3VkTExtRlY3ek4yZStQOWV2Y3FNQ2Q3WDltOG1WNDFyUVBKRURqcm0wNHRH?=
 =?utf-8?B?U1RvWm5nYzhCM2RuamxiR1JWSEpGVHBOZnlGK1pwVXA1RXpYREFSbHNZdGhz?=
 =?utf-8?B?d3BpdnAxdzVWVWRLbGxzcm0zb1RvRTByL01xWnMzMGl5Q2dYbWkzV2hpVW9F?=
 =?utf-8?B?bXgvcTIxRExoVk9JbTdNTXJ3eGd1b1lXQVFSTjBKNEIyOWtkQVVBWlR1alVO?=
 =?utf-8?Q?3BPsUhi4jqLm5m+f8U/QXK2fn?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfe2141-6739-4793-ed00-08ddaf35ad58
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:03.6768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTmCuS1QgCoCk1kEdmOI/YPbwjAfVgav15afOQDiNw1RGAjdjkK6LcyYq58aM5E12JSCnUznFOdrwQQHQyWolw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-GUID: JPrldQ6nu35vA9ziDshJ-cmAvyeDiBz2
X-Authority-Analysis: v=2.4 cv=Tc2WtQQh c=1 sm=1 tr=0 ts=68541164 cx=c_pps
 a=UMsKb9OrGFB5W2EpWsGVZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Fsi43M_n0QUer9rQu0sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX81KPE82jWCuB
 o5c7VprAlYVxWunw1R4xmhqx2N25oq/py6NDZ/VS2zbBLwRF+dslDrrX74XtW11iUUiA6xOaW86
 Za0cDQrXxPf2rZbu09s8WnQtxZOZYacVX1a4XapbQeu5vOD/cWL+kLGzOr5H6PXkoEeXABqLE7W
 0uzmMRj2RhV7pIjLmq2RExU+D4A5l9Cwg0rH1CkIQY+ucvQ1n30fC/Wi6/1EAzNU7XcbksPKMug
 UAXbfqUWLYfKtLZphwg/rfb2N7bBzurfaU3xNi9yhpB6YktYvvY9bslW3pfi4Hxr1nVMzszg1yu
 LT+LNXeO/40EFxJ6/VVUQkWnjGBc4yrMwzrup0j9NGvJ5eH5M4mglN3jTcdnYMJOVSqA9JuZEqV
 W2NWslb8y04QLVKXD9XOjnEC7OkdRaRaREw5tQVG8jjxfCEJG+WQnVVhtXSJmlWW8gwTm7yN
X-Proofpoint-ORIG-GUID: JPrldQ6nu35vA9ziDshJ-cmAvyeDiBz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce the vfio-user "proxy": this is the client code responsible for
sending and receiving vfio-user messages across the control socket.

The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
managing the proxy; initialize the proxy during realization of the
VFIOUserPCIDevice instance.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h          |  79 +++++++++++++++++
 include/hw/vfio/vfio-device.h |   2 +
 hw/vfio-user/pci.c            |  22 +++++
 hw/vfio-user/proxy.c          | 162 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/meson.build      |   1 +
 5 files changed, 266 insertions(+)
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/proxy.c

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
new file mode 100644
index 0000000000..a9bce82239
--- /dev/null
+++ b/hw/vfio-user/proxy.h
@@ -0,0 +1,79 @@
+#ifndef VFIO_USER_PROXY_H
+#define VFIO_USER_PROXY_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
+
+typedef struct {
+    int send_fds;
+    int recv_fds;
+    int *fds;
+} VFIOUserFDs;
+
+enum msg_type {
+    VFIO_MSG_NONE,
+    VFIO_MSG_ASYNC,
+    VFIO_MSG_WAIT,
+    VFIO_MSG_NOWAIT,
+    VFIO_MSG_REQ,
+};
+
+typedef struct VFIOUserMsg {
+    QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserFDs *fds;
+    uint32_t rsize;
+    uint32_t id;
+    QemuCond cv;
+    bool complete;
+    enum msg_type type;
+} VFIOUserMsg;
+
+
+enum proxy_state {
+    VFIO_PROXY_CONNECTED = 1,
+    VFIO_PROXY_ERROR = 2,
+    VFIO_PROXY_CLOSING = 3,
+    VFIO_PROXY_CLOSED = 4,
+};
+
+typedef QTAILQ_HEAD(VFIOUserMsgQ, VFIOUserMsg) VFIOUserMsgQ;
+
+typedef struct VFIOUserProxy {
+    QLIST_ENTRY(VFIOUserProxy) next;
+    char *sockname;
+    struct QIOChannel *ioc;
+    void (*request)(void *opaque, VFIOUserMsg *msg);
+    void *req_arg;
+    int flags;
+    QemuCond close_cv;
+    AioContext *ctx;
+    QEMUBH *req_bh;
+
+    /*
+     * above only changed when BQL is held
+     * below are protected by per-proxy lock
+     */
+    QemuMutex lock;
+    VFIOUserMsgQ free;
+    VFIOUserMsgQ pending;
+    VFIOUserMsgQ incoming;
+    VFIOUserMsgQ outgoing;
+    VFIOUserMsg *last_nowait;
+    enum proxy_state state;
+} VFIOUserProxy;
+
+/* VFIOProxy flags */
+#define VFIO_PROXY_CLIENT        0x1
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
+void vfio_user_disconnect(VFIOUserProxy *proxy);
+
+#endif /* VFIO_USER_PROXY_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 959e458d7f..c616652ee7 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -47,6 +47,7 @@ typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 typedef struct VFIOIOASHwpt VFIOIOASHwpt;
+typedef struct VFIOUserProxy VFIOUserProxy;
 
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
@@ -88,6 +89,7 @@ typedef struct VFIODevice {
     struct vfio_region_info **reginfo;
     int *region_fds;
     VFIODeviceCPR cpr;
+    VFIOUserProxy *proxy;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 86d7055747..642421e791 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -12,6 +12,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
@@ -54,6 +55,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     const char *sock_name;
     AddressSpace *as;
+    SocketAddress addr;
+    VFIOUserProxy *proxy;
 
     if (!udev->socket) {
         error_setg(errp, "No socket specified");
@@ -69,6 +72,15 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 
     vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
 
+    memset(&addr, 0, sizeof(addr));
+    addr.type = SOCKET_ADDRESS_TYPE_UNIX;
+    addr.u.q_unix.path = (char *)sock_name;
+    proxy = vfio_user_connect_dev(&addr, errp);
+    if (!proxy) {
+        return;
+    }
+    vbasedev->proxy = proxy;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
@@ -112,8 +124,13 @@ static void vfio_user_instance_init(Object *obj)
 static void vfio_user_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_put_device(vdev);
+
+    if (vbasedev->proxy != NULL) {
+        vfio_user_disconnect(vbasedev->proxy);
+    }
 }
 
 static const Property vfio_user_pci_dev_properties[] = {
@@ -133,6 +150,11 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
+    if (udev->device.vbasedev.proxy) {
+        error_setg(errp, "Proxy is connected");
+        return;
+    }
+
     qapi_free_SocketAddress(udev->socket);
 
     udev->socket = NULL;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
new file mode 100644
index 0000000000..bb436c9db9
--- /dev/null
+++ b/hw/vfio-user/proxy.c
@@ -0,0 +1,162 @@
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/lockable.h"
+#include "system/iothread.h"
+
+static IOThread *vfio_user_iothread;
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy);
+
+
+/*
+ * Functions called by main, CPU, or iothread threads
+ */
+
+static void vfio_user_shutdown(VFIOUserProxy *proxy)
+{
+    qio_channel_shutdown(proxy->ioc, QIO_CHANNEL_SHUTDOWN_READ, NULL);
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx, NULL,
+                                   proxy->ctx, NULL, NULL);
+}
+
+/*
+ * Functions only called by iothread
+ */
+
+static void vfio_user_cb(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    proxy->state = VFIO_PROXY_CLOSED;
+    qemu_cond_signal(&proxy->close_cv);
+}
+
+
+/*
+ * Functions called by main or CPU threads
+ */
+
+static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
+    QLIST_HEAD_INITIALIZER(vfio_user_sockets);
+
+VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
+{
+    VFIOUserProxy *proxy;
+    QIOChannelSocket *sioc;
+    QIOChannel *ioc;
+    char *sockname;
+
+    if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "vfio_user_connect - bad address family");
+        return NULL;
+    }
+    sockname = addr->u.q_unix.path;
+
+    sioc = qio_channel_socket_new();
+    ioc = QIO_CHANNEL(sioc);
+    if (qio_channel_socket_connect_sync(sioc, addr, errp)) {
+        object_unref(OBJECT(ioc));
+        return NULL;
+    }
+    qio_channel_set_blocking(ioc, false, NULL);
+
+    proxy = g_malloc0(sizeof(VFIOUserProxy));
+    proxy->sockname = g_strdup_printf("unix:%s", sockname);
+    proxy->ioc = ioc;
+    proxy->flags = VFIO_PROXY_CLIENT;
+    proxy->state = VFIO_PROXY_CONNECTED;
+
+    qemu_mutex_init(&proxy->lock);
+    qemu_cond_init(&proxy->close_cv);
+
+    if (vfio_user_iothread == NULL) {
+        vfio_user_iothread = iothread_create("VFIO user", errp);
+    }
+
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+
+    QTAILQ_INIT(&proxy->outgoing);
+    QTAILQ_INIT(&proxy->incoming);
+    QTAILQ_INIT(&proxy->free);
+    QTAILQ_INIT(&proxy->pending);
+    QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+
+    return proxy;
+}
+
+void vfio_user_disconnect(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *r1, *r2;
+
+    qemu_mutex_lock(&proxy->lock);
+
+    /* our side is quitting */
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        vfio_user_shutdown(proxy);
+        if (!QTAILQ_EMPTY(&proxy->pending)) {
+            error_printf("vfio_user_disconnect: outstanding requests\n");
+        }
+    }
+    object_unref(OBJECT(proxy->ioc));
+    proxy->ioc = NULL;
+
+    proxy->state = VFIO_PROXY_CLOSING;
+    QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->outgoing, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->incoming, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->incoming, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->pending, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->pending, r1, next);
+        g_free(r1);
+    }
+    QTAILQ_FOREACH_SAFE(r1, &proxy->free, next, r2) {
+        qemu_cond_destroy(&r1->cv);
+        QTAILQ_REMOVE(&proxy->free, r1, next);
+        g_free(r1);
+    }
+
+    /*
+     * Make sure the iothread isn't blocking anywhere
+     * with a ref to this proxy by waiting for a BH
+     * handler to run after the proxy fd handlers were
+     * deleted above.
+     */
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
+    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+
+    /* we now hold the only ref to proxy */
+    qemu_mutex_unlock(&proxy->lock);
+    qemu_cond_destroy(&proxy->close_cv);
+    qemu_mutex_destroy(&proxy->lock);
+
+    QLIST_REMOVE(proxy, next);
+    if (QLIST_EMPTY(&vfio_user_sockets)) {
+        iothread_destroy(vfio_user_iothread);
+        vfio_user_iothread = NULL;
+    }
+
+    g_free(proxy->sockname);
+    g_free(proxy);
+}
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index 8749526cd0..cb958d0aa3 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -2,6 +2,7 @@ vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
   'pci.c',
+  'proxy.c',
 ))
 
 system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)
-- 
2.43.0


