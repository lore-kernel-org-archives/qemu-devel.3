Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108E4C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y76-0004Dg-Bc; Tue, 22 Sep 2026 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y75-0004DX-12
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y73-0004VF-Bt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03uVU2448500
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=X7J7kRRXIWaEJVAfJj6LJr3nSJu+1xhUpIsGcIKq3
 Jw=; b=B2rSxhrYCDGNZBPA/rLCy9kZf8wEjS78e20rf6VhdB9pEu21nHlj9Pu2t
 XPvJ2pcFcATU0+mtzjrqf93RikAUwt//GBypsUblUZENWL9ti+SlZycdlamhbJu1
 82yViQrSJvNgmq5FeDHLZfkKZtobwy7ad1frBTKxR81SXyYYuwWxHQVDOOtzhFTS
 foqenf7OSJA5SvW13CaaxqZkDjMXhYtvb0znJ13PXr2HwiM2+2OlHz9Xm0erZ9st
 /LvWISlIGl/o+CSiWFqkVWZjiFPyhuusIKz3o7y85fs2uLUpynGa51wbrgW0DrBN
 9a1JsdeoK8OuP6WDRU1jDhDMSPgeQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021088.outbound.protection.outlook.com [52.101.57.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5sx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5VtFkELdbDhaIzCfSVRtSWVg6mSSb41cN/DDhvDoMy/CkGKCCy+Gn8sROqlVFd6L0wDxy1BWbGQ2Vd5EsOsUrfgg3ris3mNALoVqmexVOwcTEozyy6V7ndXoLmbdn7nDat463yACks4K40A1aGUsYpPspZDacNbnYbRCFdV95amjgynjnzz+648Ks89cD6Z6vtwxsxjPSNQ0kTG6cd8lhD+R3HIdDOsjxkooaTXSG7SeGlk6lv1MJzOZSCGOGB0/3DDnVbSguNNeeo60vxA9pBslK1JXptvCHNWup8frkKH3TWxCywsWU1WZ57f6tdy3396j5Nvkn8v7fncBplfhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7J7kRRXIWaEJVAfJj6LJr3nSJu+1xhUpIsGcIKq3Jw=;
 b=dWCM9BNDSETlQmYD5PrX+udfiEPG3GrsdaoZ6t2SVdxHzb/W3Up/cpG9tV9xQObzDX16ri654uXy7sWLiPsyVJcaZkjc0yRz6o3jx5Y5PB8FQV2YDvW6/0H/pkEmGHQo2WSrk9PbeHLXeuWP6U19dTfAhxqgYBU62cO4GN2QYKnK/7BxxXOQO3bwMq97jRBSCQszZ8MfwMY1XRMcFz3fbSNTB0enBp0BaFBFokbwXiFqcH2hcZXKKXYcDtIw/MnR9ffD9XFSEAblpVvXpaM2sCzO+UeYWJnpCt2L6Vbuy7/rMC3o09N98SGRYa2W13mylj4KpQn7jZDtzvaGxM/EuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7J7kRRXIWaEJVAfJj6LJr3nSJu+1xhUpIsGcIKq3Jw=;
 b=L30H/WTP2WG9X2Akez9J548MHIBhqYtwt3bN5PpGfYHTwiMSUS96jU9YpGOynZPY4iXhbSClMjWKbWwse+Bbb3GnBSYCf3DuLJb0i9axxfin/Nf1df3JTquOTv9uS8MrIaShq1LCb1EJN7olzXizqwTxd93q6TjFL+QBWCRXnVZCZC8yjiAlBXokfNhOGG4TzJTsFecptKEhdRmKfWeGv4V2uVsvN3kP4iDM0WefHefassoi4eISHMz11S19Aqzu3kW2dxhXD3vGyMvNsd78i3ececnRwMXusTKKPxLx9PagpduvPsoat/Xzv87AoJq37VuirMnNaBinlLsj0k30/Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] qom/object.c: improve duplicate class property detection
 assert()
Date: Tue, 22 Sep 2026 11:51:30 +0100
Message-ID: <20260922105223.1607725-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c49f7a-fc21-4325-98d0-08df18979b7e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dsbZFJ49M+4Lc2qnox8QABT2/0uikCPDoyhQCz218tOXXJtpTm8NDIC98M+5jIfO8gYX7xQBWVd+AMovriYVykNTQ7wZN0mAuBxmJ6ZVsOBsHSUKPM4yMgcRLkD1JJkqCjEt2cUxHWnwjYBRgHqTNt4nxCAOBuncBGxcLti1hCtht3B9DIKSBjRmj2lxNdZbOaiqmkLNwE5yHuawUPJzBJqTz1ooB5JZ0Pk15/Scn9Xm421uqZP7Wm4CjyT34RMJRV2lWRxT0sr3oW4Po38uYAqv+/VhvvjhXzBH8Y2KJ0Jg0eXm693Std1Y431FGkNj5pxGzQAGUovC3WLj2G/10tTqBABt25AmAUHlhEsYZjSJdl9jLSYe0kkEmw3QLD4PFa1lOMZBW+7psB4uxyA8vGEwVYr6hhyJuKQE7vZYJ7tR5vkzrxZVwXfYOsEt6+gcrLPkxeCEevPB8dwVaNjWnDsfGN0aLNP3sPa9ZnPqgJX8KuGI9FGLUaKO6YuBaRKZ/7aR7GCGrLj8IVt3lwsv6ck/XwCVYF+ahAhs4w4n8/lIEmUNTLcXlC6VlDM1+3wIn3nUDASpsXpPVY3jSassm8QjPWG83j++nj9FEZHOcQiRccTq3q72dja9GLLcnUiD/Irq+Npu3UBwX85xzWwxpobO+/5Z3AE8rGriir9nz9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm1ET3RKVVJLVVk3UUhkT0d5Ri9aQ3J5RE5QNXBCcFA5WjJYR2FHSjU1cTlS?=
 =?utf-8?B?VFJYdzA1dFE3bGNhY0R6RklCMzBZRS9pQi8rQjR5bzZnSnlRTnJUemFGMkZS?=
 =?utf-8?B?K0RNNUJGelNlM3FwK21Qd1ZBVVRtTkhkZWxjZ21vSlFmRStWZmZ4WWFTVHZt?=
 =?utf-8?B?T3U4dDJ6WFh6cFNZOUtKbnpPcEE5MkJqalBEa1dYcEowRThJNEpxMll1ZytU?=
 =?utf-8?B?ZkUrWExCbXJRaGpnNlMxMWhkMTh1TGU4MDc4STNsbldRV1ZIdFdlczM1QjN6?=
 =?utf-8?B?cDVNMDVlZ2dXRFJNaHY3YWIwazIvSUJTcTA3QWlPK0hzejU3T1R6SVlmT1Fl?=
 =?utf-8?B?aU03cm1nRkllVEd2RmdhUDRFcGRHRE5VcVpaRy9oakNCTktkaTFxTUcrdHgr?=
 =?utf-8?B?VjRjNFdNNUtvZ3FZTTlTM2JVMWFaY09VR2xhb3VpU1JsNWp3dW4vVWl0eHA1?=
 =?utf-8?B?VlBsU3NsZThLaVA0eFFWdnYrSWIreDFVY2JPVWxFc3BoenpxRUtjNFNhWkZz?=
 =?utf-8?B?MGpncXNRYmRRRGFoWVFmZnNZbGFKM2ZtSGxEaitaOENWYmk3dnVWSXdTT2xs?=
 =?utf-8?B?QVQvUFVUZkxHbnBsbE9ieXVOWVg4WEJFbUxFenpZTWJzaVhwRmU1bkJEL0pq?=
 =?utf-8?B?Z0I1QlpqVGYwVzNqUVVla2RPRTVRVVNEUWk2YVFqbjNVbi9RZFhDZ1Q0Z0Fu?=
 =?utf-8?B?OTVXOWpmSUxpVDNmOS9WeUo3czgvUzl2RHJ2QkVYRXZrVDd5WGFkeTFPekRx?=
 =?utf-8?B?c1lMcE90Nks4V0NhQkF3dE0vb2c3TlcxS2JxY05Tb0hETThMZ2xXVEc5MGc5?=
 =?utf-8?B?THY4eWFucjE3YmU3Qm5TK0pCN1R4QjE5Ymw4RHdFQ25mdHl0Yzk4SjJKeFZk?=
 =?utf-8?B?ZUlITDluaWV5YXVMSFEyMnpxTDlUSUNmY0VUWnJmbCtnaWV1dDQ1ZUUrcENm?=
 =?utf-8?B?ZnVvVFZTaXBET2VMQzFlMS9kTDFrUUtQTnpiM1lHcTJUY3NmdURBc3NBSlZm?=
 =?utf-8?B?TURZUjVCZkw4RTZudEljTHJ2ZXBHS2JCWSt6WUx6MlpreDR4NzhoZGxMNUgy?=
 =?utf-8?B?Mi9hSUE1SW43Q1hhcjk1dUZNdWpPWStHK2JUeVBqTmpBVDYzUVZEVkI2WExQ?=
 =?utf-8?B?MUZYQmdENVg5SENsd3RyT0hXTHFXUmVXU0tJWEkrNC9vN2JpRDFBanpkMnFa?=
 =?utf-8?B?NTFJZWZBdXpLL1BIS2plWHpnMStBbnhKTlBlU0x4SmNBcnU0OG5ucWVSS3Vz?=
 =?utf-8?B?UkFWbVR0ZE5zWlpLc1k3aGE0bUlRTytySkRlWjNac1YyS0U0YVZoWVo1Nm5Q?=
 =?utf-8?B?UnVHR0lMSTF4WTdrSCtWak5semw4U2NMU3p6NDJ2WndXNXF6SGJtM2svaUhJ?=
 =?utf-8?B?SlFSdE8yd1RUK0V4VUpjb1JKM1NlU0poNDgyL25md0w4U0l4SWV2SnRRZ3Vm?=
 =?utf-8?B?TDRSSmNJdnFiMTAvR1pBSlpCeFRabTN0akI3Q0JIcFM0S3FyM1h2VG03U3BH?=
 =?utf-8?B?emlwaDdQMTg0L0t1N0tWa2pqRmI5V0JFaktoYnE3U1plQWJkVnFrdlpkZFFN?=
 =?utf-8?B?VVlkSmJrcGtzN0RGUUNRME5JRjNFTHhtMU82bjduVjlGcWIrZi9kWDZubFdF?=
 =?utf-8?B?ZFZmUi9Oem9MNzdqdnh0TUtXdGFaOFMvZ2pwTnpvVEhIY210RFIrYjBya2NM?=
 =?utf-8?B?eXBwdjhNamtDejBhUnJPalZ3MENVZmFKMWFhTzBSYS8xNW1kV2xJYm5CRE5p?=
 =?utf-8?B?OHk2V041S1lQQzZ2REhDMFhsS1NwNVJ2cVBzekUwQW5uMkl0NDNUM3VxNFNP?=
 =?utf-8?B?L1ZLeDhRVmYvYXdZRzViQjJCOFJWMHdsMUNWeWJsdFVvTVhrQ1M3Q1NaNkJr?=
 =?utf-8?B?R2RqVjhOVW16SnNwQ3JsSVU1aWRHdlA0TXgyOTJsUWl1bWh0OUtCcnZyZVlM?=
 =?utf-8?B?Qk13VWVZWnN3NXIxTFVna3dXWWllUWVLV21LQVhvZjZpa0wzcnZaSmVnaU0z?=
 =?utf-8?B?dGZwdVBjOGZIQW5reUZySW5WOGJacytwV1JpczBReWd6RTlEd3pudnpRMkVh?=
 =?utf-8?B?ZXEyQWNOQ1BTcHJxMHhvckllbHJra2ZTZ3ZibllaT0E2ck9XZlBaQnc5VWw0?=
 =?utf-8?B?UUZOWk51VHkwYSt4UklnNDc4SXlaRGorNDBkZVg2d09UK2FTVDdIRDlYVkxK?=
 =?utf-8?B?S29UQVVHQlV1WnhTSGdlSnlaR0kxQWVDZGNRZEtLSkJySTdYTzlTbTd1RlRQ?=
 =?utf-8?B?V21EWVFWZHljRUkwZm5BRVNGS2hraUlCU0ZVbkFZQUd5QlVJWkk1T3JSVGpC?=
 =?utf-8?B?MWZnUVM2eE83dFBvK3ZkQStZOXllRDFDTGNNa2lrb2J5L0lEVlo1WkdsTUlX?=
 =?utf-8?Q?/mQUch97FkAvMQV4=3D?=
X-Exchange-RoutingPolicyChecked: k3Q3RI3N94b7XJNZFdI7kBiyGry0Lmb6XXWgi/UXMl91Vwg06pJQOahfRh9K/CDy1cDM1PHBgVRRT6pdgcv2PlgZzp4gVPPvGFX0P/hZvxdfWxqGGPf4uDcyQBUjlt+A4C+RAyz8AjUqmBIdJzbi80PQUPFSvj6ZsOiuT2zuO/FrgcS8NcvvLO2XE+fqoLUOYYditXBHwF96j+RhxJkMsEEEKlg8NE2JvBDGinPWbzFnDx0WyE8DKfC7yNBJ8MuZW/ZI+8cggP3qjA47vWbrs6Rz/qQhexZASyzDEsDiQm48V3a8tePt58URKfrlUBea/0ANBmEkUIiQibaq/lPjfg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c49f7a-fc21-4325-98d0-08df18979b7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:34.0025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjMlEy23uMGM6UhGfVp0tOZPn4es9xPoXJdXhsH9ybTmsxTvvW9HRfqp8FB7fbVHkaan9215Uyjq1KG+0SoGDa0mPrYL+zMxcZlbojYtNEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX2ZCnNqtsNqWC
 0oU2XFPuib+H4pzzfKxHYFbBntrTP6gvFlpC4rcyq9YFhrNHz4ZXBtzIAY74VvqS8HOPBNPEZyr
 63bm9KDBmggPKnkLwK/BxHVpqy7x3yNBK4UWXCUBMI0pUvfDbDXCwitrXFA1QLGuzq1Z5m3zyzM
 SJ2FIvv+PttZh02fRThBDrtmVQmohr/hJZubvzzjOUZ0y4HIYL2Ek1QeQhB/0g5Txj8xgvCj7zE
 /jXTx3QISw0zuhAKa4q4wUFFCBRq+qmTo5eIzzDYXbWWZooA3UY5+qX4Titm6GnZr8JXm9vmCZN
 KR4fPAqb02T5Q7w6cIvG4Su7wn2zmzDtSMIb5dR+hMXM5g0iqqazPEVYwhSbq47a6/P5B5G67Fm
 0iMSxaZUl0eVpyyvzbjCNoDrKiofOn8Et5IIYSp/ydPjhN1fRh3K0+hVrzGDeKpccTiHZxk/vVI
 8sOYD4dFaeUUHqSu/tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfXxLHnw/xAnxEr
 YrXiuiL5jjh0EU8S0HixRmtCIMGYg5NbvQUdak9L76y46wQ1V/jUaijJtYstE43eHPRV9Ort9nS
 6GmM1r5U2ODt+w6JIyT/iRseQ372dto=
X-Proofpoint-GUID: lo5x6OFNq4z8lDmmfrtmG94M5g7gv-Cl
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25df3 cx=c_pps
 a=cORLsCLt5K7u5uR9RT1HqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=au0SpCjCm0hkZpqcSZMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lo5x6OFNq4z8lDmmfrtmG94M5g7gv-Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce an intermediary boolean prop_already_exists into object_class_property_add()
so that it is obvious to a developer if they inadvertantly introduce a duplicate
class property:

qemu-system-x86_64: ../qom/object.c:1417: object_class_property_add:
  Assertion `!prop_already_exists' failed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260921113559.1299740-2-mark.caveayland@nutanix.com>
---
 qom/object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 41b1ec81d4..914d1228ca 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1410,9 +1410,10 @@ object_class_property_add(ObjectClass *klass,
                           ObjectPropertyRelease *release,
                           void *opaque)
 {
+    bool prop_already_exists = object_class_property_find(klass, name);
     ObjectProperty *prop;
 
-    assert(!object_class_property_find(klass, name));
+    assert(!prop_already_exists);
 
     prop = g_malloc0(sizeof(*prop));
 
-- 
2.43.0


