Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZm-0004US-Kx; Wed, 07 May 2025 11:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZk-0004TK-3Q; Wed, 07 May 2025 11:20:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZi-0005oG-3d; Wed, 07 May 2025 11:20:47 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5477Oke9027452;
 Wed, 7 May 2025 08:20:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=u+1U53Vh9q7ce9lzir1WAeMFQemaCMJKxcVWUI5k0
 44=; b=r1RZvyKHlPw9smkrOgDlzOFXP13voau3KEmJOwGga1HlCtngjwQvggBfk
 ilobbeObJTcdAeORDPgSk026zi8MO2vxfAl1Zb2uY2Rm58f/l7VUFvMh0LDZRTLf
 P0j2kyCIHJiQGrkrdcB2sbaEAFLTZTsVzjTNSRWKWOtJR7s0366wwFX0gvCHPPaB
 unFHg9qg0j47TL1dNq2SpJZebMOVQuzYj0drKWRFkUlSnyVtXKaXYsB4q/5Z+Asa
 BhPf8xz4qClYOkfGXf1TrFLklN+DgmAWkUME3j7iv1ILbXqYXkVdxJoJFugvD+Kz
 XJkHWX4U1gWoHOTTkCxxIowVynv8g==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djfc9bum-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7hKctxOI0+yuBZNRDyxxToVwA8JNwgoCLv8aAVdpyL19wXCnpOY5FxU+yJIGsbMp1GvWl/LCPplCYhdNMqGJtOVY04aoYqCGqUXAz6biE1OMPfsV2CIUaVKAIOSvkpzhcSrNiq/gIGrxaiHdpqw/sAsbx1yCu+eoWgvXPmOeydWpXqVo3s+w9sx4yPMJGeu7pruIGsYBfo+iOah67jNnLVR9HV7XIrLYMyW4kYsoSlbodQHG1xo+PzGrHN7DD8uf5nVB0HBFvjGXDbVbPDMSkjLbARrSfxQUkrTTL9szCs3owEELOXXVs5XSxofKUkQcjPe8KV585sexjCgMV18fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+1U53Vh9q7ce9lzir1WAeMFQemaCMJKxcVWUI5k044=;
 b=uXdpVrMpiyG4PWWYNWWqk1hHTIevh+WArzEK0+7mgai1EWgGNFoBnplLZn4VrPwtnZoLFDIjaHGsoFQYw0l1plrGR6A1ivwRJLefuzH95mxyuNWHHnY+JCWK+C/m9LBQ/BXYBaJQhL3Q4xcaLIgz2kG79CAXMZq181wlv1eoARD9X1T03dLdfj+dWlpEw7ykAzGSnxJ0erjQlTi2du7qlZZ10kwZkRguO+djzzupwAkIA/7GOO5jL3LTJnuoSpzZElMwYeU2Dd8shRRxtMwioOeks9G0w5tIMwStuWlM5nNjB9pCY7ZUL/KMo2q7bEyXkFehK1whNquM072sn6pVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+1U53Vh9q7ce9lzir1WAeMFQemaCMJKxcVWUI5k044=;
 b=HY2hkirAe4V1cH6I89PURpXxDh4+BL2IP85f/wxpLirjAh9xnbQelqOA5RKhsYDlimwJ7XcmfTJNDq8ZjamcbX+RHYnluqCVhSFatL1V5iVuB1pssmf85Wp+tGVgkIGp8Cix66Lj6iahNj2S998UFTRBCFLYY6NIa3A6xnZtdsVXpusyODznyOB0FB1GA42YBM+qr6enZ4wxyBQOoY0tkWZR6cU4FI0vGM8QkCGGbD2d+4UIcyKwlYzDkdApN9Kr5vNu8XbZ69ZKGS96i0aNuTcNBHJqXVBfrAgGHhdOe6yQNHmMcpX9oX5lMnQ0uzw94OPxIYB/mZgd+yBsB7GKYg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:20:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:32 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 02/15] vfio: add vfio_device_unprepare()
Date: Wed,  7 May 2025 16:20:07 +0100
Message-ID: <20250507152020.1254632-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a07d5c-d3d3-4720-c937-08dd8d7ab581
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHFnZFRwYnFQSUpMT2V0MDB4ZVZacE80RUJzSzA3cG1tWlpobVpqTmtZRXd1?=
 =?utf-8?B?Yyt1N3lzd1N5SjBxVER3ZzdlbWtibCtxWHBUS3Q2cHBwcXFLQktneE9US2sr?=
 =?utf-8?B?c2Z2MytKS1VDRmtmUjdHVWVSUGQ4TldnS2NHdi95VEF0YURlTk1VMUpxTFBO?=
 =?utf-8?B?YVNLa2U2ckpnZzNLM3d2N2k2K1dRbFRQSjJSTVZLVWFWWVN0bERyZFY4eHVa?=
 =?utf-8?B?QzN4T2d6blhKTWlUR1FrVFp4KzFCVXNjajFqMTFLOGVwL0pyMjh4dE9nNUlY?=
 =?utf-8?B?cExOYlpETDEwL3BZS3UraDhOc0NPZGRwUE1VSVc0WEswbUJwNlVZS1BnUDgv?=
 =?utf-8?B?Z2lVSElpaTVZMDRFRDg4ZU1hbERrbk1HVGtZdGh4NEtFb1ZKQnZlUEpuSGNO?=
 =?utf-8?B?Q1ZvQWRhVW1ybW1RL1NQLzN4RHRpNWpHQ2RvTHhzeitFY3hqdmFObUhYay90?=
 =?utf-8?B?aVFTSFl3WCswdXhLZ2VuaEw0MFErT1VWbVN4VG01RW5MQk1SbFVsKzdrMit3?=
 =?utf-8?B?VWNmODJLcFBUakdDZURnTWErTlF4K0tMbDhUdmFvRDdYbVJyd05UV0lqSWxQ?=
 =?utf-8?B?azN3K2tLWTZhUjJFRStFbGlmb1RGR2taS0VaMEwyZUlIcElSTTl5REJnV3Vy?=
 =?utf-8?B?MFJXTkl4bWNIS3ZUaktvODFHRThCS3FWdVF0MkN3YU1jbXdwcFRWUjQvWUU4?=
 =?utf-8?B?V0NDQ0hiVEpZTERSbmJXSjVaZ3VuSHlxQVU3RUtqQ0VFOWZ3UExIM2RqTU1K?=
 =?utf-8?B?S0MzRHNIQ2lEUXk1K2dxbXgzTjZIS0tsSjRlcTBVcWxMcy9SalZSUGJLTTlE?=
 =?utf-8?B?S2J3QTBNQ242a2ROaytnbHh0dVc2WnBwR0pUUm90Mlp0OW9kaGYvQWJqYkNZ?=
 =?utf-8?B?L1BtM2JpcXRFb1NBbkUxVGQ1dElieEN5THZEOEFiOUt0Rlk2Rmp0SlR3NzhK?=
 =?utf-8?B?Q05CMFdNWlc0V1VhQk5DTEZWTHMwRG85RGo4MmZnVU8rbzNMSi82UTIreW9H?=
 =?utf-8?B?dUxZbXhlOCtORFlIV2h6UHpZTmhJM3pKeW1zZzdwSjZXUWJJUDlzMXlvTjBw?=
 =?utf-8?B?dWE1V2ZBRm0xWkpJYjVqelNzQ0xPYmdNNWtwOGJGbWFlS0lTL3Y1U0UxVFZh?=
 =?utf-8?B?V2pvS0RDc29CYTNGbis5anJQVkZmRHFjSExWbTZ0QjI2ajIxVmtJMlBqNGxX?=
 =?utf-8?B?R3NnQlQzbEowY29pc0hpdWNkU2M1SVhrN2lyVDltZFoxTjJLSlZKYmJ5djFL?=
 =?utf-8?B?UEpya2NOSTEzQ1EydWFONnJWVm80QkpuMm1NS0YrMWJsMlZxTFpZanRGTzhs?=
 =?utf-8?B?Nk9RbTBBOWRLZllZRFY5SjVNYVlSUVlHWndTVDRFeWRJSmFPc3VIN3EvWjhm?=
 =?utf-8?B?MlNVNkNrMmhTRVNwdlFBaUpOZ0p1RHhpNmdTbmFDeEhITzM4MExCNnFCTnVF?=
 =?utf-8?B?bDJ2bXJBd2FhYUx2U096NG16UlZBc3FRZ0E4Ty9LM092dVhRMjFjaDVDZHV5?=
 =?utf-8?B?Zkg1YkhqSWd0ci9YTEY1SWNmVGRBSWkwM2R0RC8yTzZ4TlhjRzBWbUZNYmNQ?=
 =?utf-8?B?UXdrUzVBaXhFNkczTTZpOXJYM3lZdVpxYUJCUXM5Mk1jTy9hOGhCVXNMRmdJ?=
 =?utf-8?B?U2hZSWRUSE9HTkpzYVdncjg2dWhMN01LaWRoZ3lxSXNBbVBJN243cGlMdlRS?=
 =?utf-8?B?K2tmRU4rVEV6UUp6MVBKcko1TkQ3M1ZOR1JZdWlKcHkyNk9Cc0lkV2F6MTRM?=
 =?utf-8?B?MEJQTDVzOUcxMS9ab2IyQVZzNmpFdnpBc1h1V2FSR3pEVFJRcHF0YXFvRTlW?=
 =?utf-8?B?U1gxQisrVGt2aVJ0YmNSSWFheTJ6NlE0eVpaSmpFc2lXQXR4N1E0ZzRzM21W?=
 =?utf-8?B?OEpsR2JmVW9NemQyMVhBTWJSMjRjOW42cFJ0VGh2U2tYNGNwZEVrM0ZqQnVv?=
 =?utf-8?Q?uEc5zuIxsfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERQS1U4RjJCNFlXUnNETEF3emc2L1ZOWlBWR0M1c1BGNVUxMWZDZ1VESUFy?=
 =?utf-8?B?UUxFTm1HZ25qY3c3VVlhc2o1OE5EMXo3eEZNMmszSHZGdXA3aFlpNFk0Zkpa?=
 =?utf-8?B?b2ZyU2NvcFhEYTZjazR4N1JJVEhSY2k2dEVIZVpINzlSM3p1VEVLZFBJVDh0?=
 =?utf-8?B?ZnF3c3Q4bGtucm5jaFdwUWpuNEtKRFFzOFh0OW83NDY5elFIQ2NYeHAxUDJB?=
 =?utf-8?B?TXZaOVI0Q0pWb1hlazBTMU5EVENtMGpzRFlpUUFEK2hnKzFud0lZOUZvcHNy?=
 =?utf-8?B?MkZtL2ZUdVpwU3dHZVBHZko3MU0vT05odXNTY2NTWHFKMXZIVTlBVnRGN2hZ?=
 =?utf-8?B?OXNHWHVxQUpCTGV5VFRIUWFscGU3cDlCRFdxRzRUb0c1RVZ3MUw2dmhUUkFT?=
 =?utf-8?B?NlhBbFllMWFOM3V6bjQrVWJFaVN0L2VOUDJMV3U1U0RRT0prSUFNYlZhWGxX?=
 =?utf-8?B?b1YySUFzcXU3L1RoQnN2aU4yblY1UHN6aDBmVkhOZ1hqcytVMVk1cUJteGlt?=
 =?utf-8?B?Y3dnckVhWXBiNkkxNXhhRVlUU2QxZFFENy9FdzFyclNhajdqZGUxTDNoVnVV?=
 =?utf-8?B?M1B2aW9kbzBMVmxaMlRoSkdpbm1VSUZBdG1tYUVJUUhTbld6VXpZaGVhQytT?=
 =?utf-8?B?ZVhWZ2wyRU1idk1ydVJGVWVPcGtRYWtzdUxtRW5JQ2x3SmF1djB4WlNOeHEw?=
 =?utf-8?B?dzVYZ0pVSHEyMUFjUG51NU9VOTlGS0FsTTVGTXFaZ3NvT1RpSUhYaktuQW5n?=
 =?utf-8?B?WG1OS3hGb0M5Z20vNC9aQm1sSkdad0pEYXd3YmFXWGNtdU5iVjJuclFFdHMx?=
 =?utf-8?B?MzJVM1hnVzVscW1pQWFhRGtESUpHaDl3Y0d6S21QZEREbXlLOHI1UzQ5OUFn?=
 =?utf-8?B?cEJ2SlJ3UzZzSHVaTG0xRlFVT0Fvdnl1bnNCV09Vb242NUlqanROcHl6eFVD?=
 =?utf-8?B?NWZUS01lQlg5WWZXdkNBSmw1alQ5ZCtoU01NUnFNVjJBM2RiMjZxN1NiMG90?=
 =?utf-8?B?ai9KQ2lhN3gyMDNPWmcvby95MWEvU0ZZWm05OUp2K1JQbjdjL1Z5SXg5dUNi?=
 =?utf-8?B?Z2s1SlcwZ280WkQ3U2FhQXJDN0kyYzNiUDJGblAxS2txUHpOTlZrdE9MNHBE?=
 =?utf-8?B?MDB6TGM4d2l6SE5NTnAxdDNhWDBjVlJhNFJPQ3lXN2VWQzBJYnVWcUNiaXJY?=
 =?utf-8?B?cVdKNE1NUzV2RFVOUStFbysvSzFocVcyZVpJN3VFTHhjMytGelFJRzM2enph?=
 =?utf-8?B?aFlwVjgzNkFuZVNNUm4zSjJsZEhoNUZTOHlNMWw4eWk5Tk9xNW95bGtDMElX?=
 =?utf-8?B?U1JpbVhkOHVMMkd6RjNSWWVoWjJReWIydTNZSlBTT2JjV29IK2VKNm02WUVF?=
 =?utf-8?B?MmtmdVN3bHM1bVlQSFJVUDRIcnJIOFl3Z3p4bnlYSnViUWJVcG9ncGVjbzBW?=
 =?utf-8?B?YlBidWNIeE9BbVc5TjlmL1ZUMjA2WFd1VXVNck85ZlBPbWpRbVBWZjBDQVBv?=
 =?utf-8?B?aVdWd3M2Q3ZJa3JMZzE0bklFTzVxZmdURFhyb3loVmFyRngrNWJjRGlsZitz?=
 =?utf-8?B?ZTU4SXROWFl4S1RwRUljaE9RMGpDMkxyMG0rZ21laFdFN0dvUEUzSU9RNk8r?=
 =?utf-8?B?Q3cwVzc1TER5ekY1TWFxYTl0RFdFOTBGVFo5QW9DRVFkNko1WS9rV2lRaTd6?=
 =?utf-8?B?dngwT3hoM2lReHQva0VyTWVXSzRKaVBRajlFU3dOQU5Pd1IxWGhKTXdhQnpB?=
 =?utf-8?B?dkVnU3NXbjljRVV5a3NhM0xCK2w4Y2w1djNIL1JkZjFScmFtbzJzVUxlYlZx?=
 =?utf-8?B?UDZDV0kzMjVoVlhnTEV1Y0RSMUtmR0s1U2tQcllraXlaL2xCVFozaFBXbGVj?=
 =?utf-8?B?Y0djVjZDVC9VQ2hXWk5IZjZJOEJvaEx5eHdxVDgybC9PbHkvNDlNQ284QkU0?=
 =?utf-8?B?TDh3UXMreEhUVnBnRFEyNVVQY1pZZGc0OTkvQlMzbG1sb3hWeEpQMlczWkdT?=
 =?utf-8?B?aVRlL0hGNzhiVHNuQ0RTYWExbGNJN0NYalRlUHBqajNWNkh1Y2pGUHhSdXds?=
 =?utf-8?B?M3U4dkpJNTBaZkczTy85SWdxZUtmbk1qWW9xZGZyL1lJd0pJcCtFZFVGWitX?=
 =?utf-8?Q?RRcOtIfTO95+HZWAJMPUWbqHo?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a07d5c-d3d3-4720-c937-08dd8d7ab581
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:32.8563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMkjyk8MirVGdWQiAa0sIyWA9KWf/Q24bplvY/LU1++hlrA88ERo2gg2Xc1d8HTaLC8hYPrve64Sdcl1ZwzyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970
X-Proofpoint-ORIG-GUID: PxFVt-Nhob9gKuioPk4wiqTwHUQIQkWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX2sKizkI/VBPd
 PiBoypQU90dC/s7C/JINMWq7e7u4cmBm1CZfJ6SzSVaDuOTorht9dhoiNKb9XEx2ImcOfqyB3px
 gaxhPvPJ+obU66ADFaqDNEwd7b8kddLEyHDno4BUA0M8L91nKG2YIDUk6IKXrr1klHgXOM2EmBL
 ABpKJ3g3WvdWfzPwFyM7AOSPMMER9+BG2kdBPfrTd904PwygnGfvpebVuSpHLoZbtQQwvURvisA
 NghJsD8rvyCPVKJ8VzE3cWYEWKJW28RzFF4DYagYvx8oXrFiEpyCAymF4eUnNstGK8nBr9QlAPu
 CurJBewd4HgCXVU+bB6xVpx1fe0FOo+W5OHgNs6PXCzfdN8UEjiJzxUnrIH7lPQ4ADqAKpliNsE
 SfnpptyOiA4Nx3HaRYJ+Opii9kRkcQma3dwF5fBtmXc3ENgtbs93Gvro0ErFZ0/iBG01PjTr
X-Authority-Analysis: v=2.4 cv=Bu6dwZX5 c=1 sm=1 tr=0 ts=681b7a48 cx=c_pps
 a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=C_v9gYMq6tuos7APg4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PxFVt-Nhob9gKuioPk4wiqTwHUQIQkWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Add a helper that's the inverse of vfio_device_prepare().

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 2 ++
 hw/vfio/container.c           | 6 +++---
 hw/vfio/device.c              | 7 +++++++
 hw/vfio/iommufd.c             | 4 +---
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 081929ca4b..342c4ba3bf 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -137,6 +137,8 @@ extern VFIODeviceList vfio_device_list;
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info);
 
+void vfio_device_unprepare(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d30c1a141d..cf23aa799f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -927,10 +927,10 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 {
     VFIOGroup *group = vbasedev->group;
 
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
     trace_vfio_device_detach(vbasedev->name, group->groupid);
+
+    vfio_device_unprepare(vbasedev);
+
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index f3b9902d21..31c441a3df 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -412,3 +412,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 }
+
+void vfio_device_unprepare(VFIODevice *vbasedev)
+{
+    QLIST_REMOVE(vbasedev, container_next);
+    QLIST_REMOVE(vbasedev, global_next);
+    vbasedev->bcontainer = NULL;
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 83033c352a..62ecb758f1 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -615,9 +615,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
                                                    bcontainer);
-    QLIST_REMOVE(vbasedev, global_next);
-    QLIST_REMOVE(vbasedev, container_next);
-    vbasedev->bcontainer = NULL;
+    vfio_device_unprepare(vbasedev);
 
     if (!vbasedev->ram_block_discard_allowed) {
         iommufd_cdev_ram_block_discard_disable(false);
-- 
2.43.0


