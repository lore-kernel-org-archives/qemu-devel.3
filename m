Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60527C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9c-0002z6-58; Fri, 06 Jun 2025 20:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9Z-0002x4-Pf
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9W-0006Op-EV
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:17 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556J65f9008460;
 Fri, 6 Jun 2025 17:11:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=tIKtr/+mn1tAXBrtC42SicLWuIuviQ4ynt6E9Khvg
 9E=; b=0KolF5O2IEW0fZhH4VRdkeuphXK4jN4XvdspLhlJvX61SzaueLxlClZR+
 +goiJjJFsAZs/V2+0roeupCByM/h73bbfRm+s3PFO7Fhu1HLTTNbo0Q2ROtwzwCm
 FVaVTQt70huU/bF7AzfO9TvD4tmCE198NnusMFgEj/+Zq2Cfomd2+iBfto0sEmjm
 vIuoq7tYrk9nFtU59cnfuj7Xw0euPHO1Q3mP7NXVKKoRx9gOde+X2l7qw11uB35F
 9jT8DnEsKQbaN7f4nP6M2/DaqTw83aKP25iS4+uUBm4U+mkb4RScm75HO+i9btcH
 5K5ykoddG8iZRAZJphaaq7b27rhLg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2108.outbound.protection.outlook.com [40.107.223.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 471g843x7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy+CAOCcxl9Nh4NVNyCWmbKV/Tqek1Jh2eYwdt+KJrXnuRT1/TqF8D3aZ6XJRTkYp3gxZawGYkNw493hPZQaiN9klvuHCLbTakYqPlT8XPkH2I7Nbycoz3i0+3D/zz9cfhf+2UXjCV2cXrT+YMJqxT5KMOca+cnM0WV+kOrpELmx2Aut3YJjWnac4sJ9JJrvimoYzBMkJtanFf7cJdBkIvgI5xUXAMtZEVYMCEXMsz8YJM5D3T82LPdz9UxTYaFrqz2wijHkSTA++xEGtg7dYoK6TMVFRM3ZaeqifJS0LMP9FagRzN6Jh3Nh5AjxTbdIc6jDtpyy8pjrxiXq3/iTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIKtr/+mn1tAXBrtC42SicLWuIuviQ4ynt6E9Khvg9E=;
 b=dsdiMdD2G8UJTXRydVUdvv16UCW9c90wrZD1xFJe9k+QkLrsZdU3wVjfcNxkve9UDiFXLdKnYqL3WSTHxQViXJVprQPX2tL+eywIF/9cIo91p4dhifpF95VeLr/7kUEMjbZ1UaKpjuIkArYUMtS3X18lLXaQVyNTOXJ8/yIQ89TMJB+8wRJD4TGlwBFnCsRAe45hL6RUsIh0OEqvSFADV+pG4+vzeyqKmpMpLaSgRrjd7gC4l1ygDkF99bS0ZZzfFTtEZFp0VBlSjLg79+l4xGke1i480RgM584xfbpqIKTlulcBzUe4zBjzPYSJ47Mof04bokfhS7x1wXYDPD08Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIKtr/+mn1tAXBrtC42SicLWuIuviQ4ynt6E9Khvg9E=;
 b=DK3Mjw+taSCaY6lFmVBPRQ1cZDYlrW/7TmMCktJQFk/UD/PbxUbo0oTgzXBuavM9AJhuKUYj2U0ugt77tawFDitzqsumFIuJFqIV6DaEVwVMBQ/RjDRr3srQz6Mexljavmm/iruqPuP9pUi4e24qLTmvaYompbnnEY2A0NFsMpdkx1wwCXT2LGyw8GS7HDhrcfo5ttz3KA+RuP56oOqHMJMTDnz4qH+qZOshWvMsL1AAA66+pBXmcyNWSRwcPl7BOdyMB9EJiWSjuAlRKacSyBq1Z3B8jibe1juYTV+oEfi4SNcqbLAiZ3B+rDzg2V+ZRKIGelTn0qCCxmIQBBaAaQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:10 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:10 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 08/23] vfio-user: implement message receive infrastructure
Date: Fri,  6 Jun 2025 17:10:40 -0700
Message-ID: <20250607001056.335310-9-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 530f2422-5645-4209-7af7-08dda557ce65
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWZ1TGNvV2dZSmF0SmhrVGNORllNdzZDS2xqZERTbVczY0ltZlZrTENwZGVX?=
 =?utf-8?B?Unp6ZE9XRmN5WHJrQ1hDMXFHZTFMaGRleW9GMi9BNCszMkI3MG5xbURyK2pT?=
 =?utf-8?B?dHJkRDBLcXNkSU5yZG5yZkE1dGUzM1ZvUjhiM0pKd3lFODlUNk1aV0RZQW16?=
 =?utf-8?B?blI3dnpMUVZEUUFxS1JtWEJseVF3MlJUbEZjUEVycGhGQWptYlhzRXF0eXlX?=
 =?utf-8?B?WlN2ZkkxWHU3NG9xRVlyTjgwR1M4S0lEQ1NLN0VNUndINXRHSUpqZzFDQnZr?=
 =?utf-8?B?RTliQm50Z21JMklCUHVCR0cyY2wwZVloa1BGbXNKM1R6Y3pESm03cVM5WGRD?=
 =?utf-8?B?VzhKRTV5VnBsajEzam5WQk16VTdpU3JsMFhLbUNRSXVXZHM0WFNDK0VMbG9K?=
 =?utf-8?B?KzVvYW56bDFONzROcTZDWmI4YzFZcDRnamlUK2JMM09lblBoYXpmMDdCYlFl?=
 =?utf-8?B?UHJuTVlsZWhkRjRyeUtIdVdMWUoydmk3NGJ6QldQdTNTcjJrWkZYZTdzVzkv?=
 =?utf-8?B?STVFTWlVT0F3RDU5Tm9lc3IxYys1VmJuYjBWczJkK1poNWV0eXFIaW1EQS9G?=
 =?utf-8?B?MHloTlZMNmFSbHlhQm5EbFNYbjJXM2hMQnF0TnhpbDlMd0owSUhxQnNiVmpw?=
 =?utf-8?B?RTNoMGJmaU1IYjVjUzlRKzhxa0RvNERHWDJFN2J0Z1RIWjd3ZjE4UmZJN2Q2?=
 =?utf-8?B?akRqb3ZFUkJDT0xBdEhDQXlvWGl5ZWxoVFJDVVkxM3J6TlVNMDBzSHdxcDdn?=
 =?utf-8?B?L1JUendndkxqSDhOeEEvOGxTcHRZeXM3c0ZLTGFiZFp2L0YyYzJhaG82ZHZC?=
 =?utf-8?B?OC9IMEx5ak9iaTNXNFlyMXZacnQweTNrWlJ1NXYzeVZkUTlpVWh0OGFWamVZ?=
 =?utf-8?B?OEFGbVVHSlZ0b1ZJSWpuaVpxVHRycXJtREJPSjVrdGQ5Z3Vsb0ZYZ2RyOW1G?=
 =?utf-8?B?NXpnNDdXVHV2Qzl6bDg4UnpvWjYwb0s0TFJBZ2tKZ3VzanExNmNiRVFNeXJQ?=
 =?utf-8?B?WWZNUVBWMEpidklCL3JoK05tdm45TTRaQmpDM3hzRXR4WlJEVURSMy9MR0Rs?=
 =?utf-8?B?WmxxNWRoT01YZVEzMXlrdVNRZjV5SXM3bjROb2xDWHlUUHoxTHNmMFlZSk0w?=
 =?utf-8?B?K3Mza3lPUWIzNURlZHVpVkNEZkdmZHZGMHh5Wi9KQklvZXZlNTVHR1lNdklZ?=
 =?utf-8?B?ejQrYXBpeHhrNmpWdlJDK212b1RKWWladlg1cmV5UTlsVjB6TEZZNE5FVUJK?=
 =?utf-8?B?OTFoRXZVbndndkduQ3dnZEZIZC9uWWkwRHdUbnUwTTdvYXZaNDVTZmJQRy9j?=
 =?utf-8?B?cWlWUkxmcmg3SUhqbCtRTnYvMXVNaG9yRkVnMHJLUEM4dlRqdlp1K0Vwait3?=
 =?utf-8?B?bytPbUFlNTF1Q1ErTXZScFpyV3lyaUIzcXQvY3d3R21vRndOMi9ycGcrU2x0?=
 =?utf-8?B?cDNrWHorSUQ3WjBDK3FJS2wyN2hnUHo3bjZoZ2oxZzNPeURTRStYeVJscU9q?=
 =?utf-8?B?RHg2bEpHYy85VmpYTEpNR2FIaTV0WkZ1QkJwcVppNm5xa1JqcU9rYVlGTHNH?=
 =?utf-8?B?TlhpUUVrbENhVGhFUnM0bW1Jd2toOWNMai9OSWVUbUpJL1E1SGlSa1JKY1Iw?=
 =?utf-8?B?cEpaVjZmUTVkV2hMUlpnKzloaW16TWdCTHBBWUk0cVY4WlNLN2RGQkk1UUdV?=
 =?utf-8?B?QURjSDB6TGwyY2NCdERZem1JTVhFTUFpdnhwbFA1OXRIeEVsTm56citGSllV?=
 =?utf-8?B?YW1oMnFZeXY1QVdPU2JUZS83eWU2R01XOE9ZN1dFS3pJYmNMVDNTbnZRK0I4?=
 =?utf-8?B?dDkyWkQ0WFBQaExDU1ZtUHVnU3Y4QzJOeHMxNkd1aXhqZ2s5UzVlbmo1Wnpq?=
 =?utf-8?B?SU1MOTQ2YU5Rc28vSHlpQkpBaDZ1YktmWFhua2gxYis2YkR2cXhqQktTZDBD?=
 =?utf-8?Q?zlpwg6XgNyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhGSlFlU1hYSU13WGRiV2tNajEwWkRXZkhackhIQXZrcndDTXc5TXV5OE0z?=
 =?utf-8?B?dlRXSEZvMlNzTFFDK0VPbGRBTlZFVW5QMTBIT3h1Q0Zqa3MxR2RIbitlNkRu?=
 =?utf-8?B?bmRWaUNCMU84ZURtMGVhZTNYT0ZqZmFRSlA3d1c1UjEwQS9Ec1p4dUVFZDI2?=
 =?utf-8?B?Zk02UWUxRVo5a2pKcmtEL1BZekFrUHVwYTVVY3hoc1VEbmRkNFR0QWFMcmhZ?=
 =?utf-8?B?SGdybzRDWEtEdlU3SGlaQ3JLTzJXR2VZYkZOdDBibzE2SE40VnBUd1hYQ0dJ?=
 =?utf-8?B?dUdKTitFSW11M2JSdWY4STBNajA1T2JQelQvLzBiSGo3Vk9DUEE0Vnc3UHJt?=
 =?utf-8?B?VlpoYlR2OSsrdUVCb3NCd2N2QWxYaENFb1JBd3REa0l1SktUajkyTFlNbG00?=
 =?utf-8?B?eXVVai9BWXFrSkcvYmZLZHVwQko1R1h0TXBlNllYVHovWURvRngzQm9FRHpP?=
 =?utf-8?B?czNJcWhDUVc0eVpwTy9sR05MdGZPTGZxU3hzMjRVdnZpSDFyOTR5TVNQQlg5?=
 =?utf-8?B?UW1GZkllNlRURHdPdU5lc1VLUXNRR2xGNUlKMCsxMGJYenFiWlFYbk9ab2JI?=
 =?utf-8?B?NFUwYmNvdVVMT3VuOXlDeEUvdkVXQnlsd0U5S2hoYVd3dWw5L212OUJjTURC?=
 =?utf-8?B?bDgzTFRWL2ZGV1ZMWU1hWXd3RjNYV2JwdUVONkpleHZ3YnFOcHo2UEVZTHdk?=
 =?utf-8?B?ZUlWQlZpaklQdTZmRjlIRUJvMXBMNWRSS3lOaXZwbXhDcnFyWWU1czVYRXdr?=
 =?utf-8?B?Sk0vVC9nRFoveXlyaWFzVXhDQTBkRWRDZm5tYzA1ckV1WU1xZ1g1MU5vcDhD?=
 =?utf-8?B?Tk01RlpXRnU1U2EyNmlmR3ZCb2lLdkJaUUliWEZuZ0hRNXdvMVhPSnNTRkhG?=
 =?utf-8?B?UDd5eG5jRk0xUUdPOGtzUlh0eGhNeUh6T280ZzlneDBTMEZqWWJid0wvR0E5?=
 =?utf-8?B?OW9UK2N5aEJ6N0crZ0tIQVBZaUZBbThwdEpXbWZhVDNZNXAyQzkzRVFoQVJU?=
 =?utf-8?B?VTVrdWJWVmVWME9HZVhQYi9UZExza0dHZW4zYnlvNDY4YTJBRzdpWkJzc3hV?=
 =?utf-8?B?QU4wRjlNbGFRUHF5a2JwS0NhbTIvWXhKZjdoL3BodTJ4Z1ZUUWNweUsrZFRX?=
 =?utf-8?B?QTFKckJ4VHFMT0Y3QnY0VVprNlR6c0lMMWhlZUVOQzZ2a0g4Y2Y4RWpCY0VR?=
 =?utf-8?B?NktsTmJIK1JFZGZVU3dlZjBNeWQ1blRmbWRXaS9Ob0JJbzk5R1pESGNBNWM5?=
 =?utf-8?B?TkY1L0hWRWhrU3B5UG43ZUQ3eUNPLzFMOEUvTjRneUFKYU1BcVRzZlVVSzNK?=
 =?utf-8?B?R1pVaEpZVVdTTXB6UnNXVGI4bDN0Q3J2S3RvMzRtRlRZRUxYZThWMFhYYkMr?=
 =?utf-8?B?SmxncS8yKzR5M2hLY2xSN1NsWk1oZEIvQ0UraXNnbkhoY0x1bUl0OUdveHVX?=
 =?utf-8?B?eHI3d1dpVGo0aldoZ1BJNnJHNkp3NVZEdjE3eTBsOTBYUFRQR0c3a3cxOFFt?=
 =?utf-8?B?QWNHUWVDQXJJQ3JBVEtBOWxOQXZKK01ORlNwcHVGTVMxUmRFb3V1M21DSzhC?=
 =?utf-8?B?Mkxkb014YXhmbEJ2dFN0UHl3RDk1Y294bXhzRXRFTDRJdnV2cnRqTDRCWURM?=
 =?utf-8?B?WlpUNGVqTWd0QnpkT2svS2hORzhnazN2ZnNydC9YdGtoT2lMeThIMjlxcHEx?=
 =?utf-8?B?SCs4dGh1TnVVU1c2bnFCUTNVdWxVeDdaVVFyWGdOdEFJTk5Sb3cxbUIrMGJr?=
 =?utf-8?B?MlA0MVA3V2RMM3FkTDJETFNQUTJPM1NjSlREM2Y4NXQ2dUZUQ1N0Z0U3bVBS?=
 =?utf-8?B?azcvSnNmalhVa1doMThiWHp2S1FJSnJzWFNkTzVsUU5FOU1uRkRNdWswMzBr?=
 =?utf-8?B?Q0JWdkZkWU16YVZzSzVsTVNSM1NCRjR1QzBkRGxRbmlFbUFtZlhnR2lldHlM?=
 =?utf-8?B?MXFRaVFER1hUWEk3ckJrbjdFVzQ4eFlWaVJFYkQ3UDBIREJJL1dzWXNadWpm?=
 =?utf-8?B?cStKZVhTbCtmczkydjRJWVRjY3VHY3h3aDdtRzYxMWJCMEFweDM3NmV4ZXJC?=
 =?utf-8?B?RS84OEdMaTd1KzNDYnFMc2d2WUJVTHB2VVlWdHJaUG5IKzc3aGRoYWVmSXRl?=
 =?utf-8?Q?OTQGKrf+odvEDq8yjKThoO+o8?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530f2422-5645-4209-7af7-08dda557ce65
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:10.1562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypjxwYWQvFtEeExG3wPZD0VKNSn5b1P8n7rRPLmfvJ2S/mw4+DZdDrWQGhU1GUqwKABte8A75KkoMIseUapH4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX10DK+soCtGx/
 ClRf2Luem/ckI05dtFP9gPVpXXk4sDlL7VkeaYRT5ZSplqu2+Gn2NVdXQl/wonUugpvebxg3PV/
 t+t9g/D+ikwPb3ciQZOA/uu6rrMGdm+86LLiSFbTLU4mwkHmMdxs8JGPKS+fR5Mp54HGsugRFsj
 LyGEiN06cV35Sfjz2Kd4Y/NXYYQu3NgCOtoRE0ZePAPULShI7RYW2hUEoYi/UvXzPBQKuE/yFew
 ItCM825A5DsFz4zDYbuuMhClUGzlh3S9/L4lOfbLMbS4obBJoRS/ND3s5l9kwdfwFLtm1m4iD0Q
 J0ZJbSpUk0QlGLH0spm+pEINWd7k9ltDpBprTb6CGL0iH4CxMcHGDa4H9z/tCIBloOvYmI8Ame8
 E1h+0JbzEilNrzswgGChb/Leak6+blYLBrgo0hN79IUooysrVCjzWq7sGCJtKUX/y0sUe6GJ
X-Proofpoint-GUID: cBWnFcLjvHADbPed9oRull-RBXRBHqMY
X-Authority-Analysis: v=2.4 cv=TvXmhCXh c=1 sm=1 tr=0 ts=684383a1 cx=c_pps
 a=A3LX+wu56ikakVX7ADtWTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=vXCtUE0a-urccVGwgxAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cBWnFcLjvHADbPed9oRull-RBXRBHqMY
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

Add the basic implementation for receiving vfio-user messages from the
control socket.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 meson.build               |   1 +
 hw/vfio-user/protocol.h   |  56 ++++++
 hw/vfio-user/proxy.h      |  11 +
 hw/vfio-user/trace.h      |   1 +
 hw/vfio-user/pci.c        |  11 +
 hw/vfio-user/proxy.c      | 409 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   6 +
 7 files changed, 495 insertions(+)
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/trace-events

diff --git a/meson.build b/meson.build
index 967a10e80b..45aec2a4ad 100644
--- a/meson.build
+++ b/meson.build
@@ -3679,6 +3679,7 @@ if have_system
     'hw/ufs',
     'hw/usb',
     'hw/vfio',
+    'hw/vfio-user',
     'hw/virtio',
     'hw/vmapple',
     'hw/watchdog',
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
new file mode 100644
index 0000000000..6300c681e7
--- /dev/null
+++ b/hw/vfio-user/protocol.h
@@ -0,0 +1,56 @@
+#ifndef VFIO_USER_PROTOCOL_H
+#define VFIO_USER_PROTOCOL_H
+
+/*
+ * vfio protocol over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Each message has a standard header that describes the command
+ * being sent, which is almost always a VFIO ioctl().
+ *
+ * The header may be followed by command-specific data, such as the
+ * region and offset info for read and write commands.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+typedef struct {
+    uint16_t id;
+    uint16_t command;
+    uint32_t size;
+    uint32_t flags;
+    uint32_t error_reply;
+} VFIOUserHdr;
+
+/* VFIOUserHdr commands */
+enum vfio_user_command {
+    VFIO_USER_VERSION                   = 1,
+    VFIO_USER_DMA_MAP                   = 2,
+    VFIO_USER_DMA_UNMAP                 = 3,
+    VFIO_USER_DEVICE_GET_INFO           = 4,
+    VFIO_USER_DEVICE_GET_REGION_INFO    = 5,
+    VFIO_USER_DEVICE_GET_REGION_IO_FDS  = 6,
+    VFIO_USER_DEVICE_GET_IRQ_INFO       = 7,
+    VFIO_USER_DEVICE_SET_IRQS           = 8,
+    VFIO_USER_REGION_READ               = 9,
+    VFIO_USER_REGION_WRITE              = 10,
+    VFIO_USER_DMA_READ                  = 11,
+    VFIO_USER_DMA_WRITE                 = 12,
+    VFIO_USER_DEVICE_RESET              = 13,
+    VFIO_USER_DIRTY_PAGES               = 14,
+    VFIO_USER_MAX,
+};
+
+/* VFIOUserHdr flags */
+#define VFIO_USER_REQUEST       0x0
+#define VFIO_USER_REPLY         0x1
+#define VFIO_USER_TYPE          0xF
+
+#define VFIO_USER_NO_REPLY      0x10
+#define VFIO_USER_ERROR         0x20
+
+#endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 60fe3e0b6d..0105479d02 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/sockets.h"
+#include "hw/vfio-user/protocol.h"
+
 typedef struct {
     int send_fds;
     int recv_fds;
@@ -31,6 +34,7 @@ enum msg_type {
 
 typedef struct VFIOUserMsg {
     QTAILQ_ENTRY(VFIOUserMsg) next;
+    VFIOUserHdr *hdr;
     VFIOUserFDs *fds;
     uint32_t rsize;
     uint32_t id;
@@ -70,13 +74,20 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    VFIOUserMsg *part_recv;
+    size_t recv_left;
     enum proxy_state state;
 } VFIOUserProxy;
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
 
+typedef struct VFIODevice VFIODevice;
+
 VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp);
 void vfio_user_disconnect(VFIOUserProxy *proxy);
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *reqarg);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/trace.h b/hw/vfio-user/trace.h
new file mode 100644
index 0000000000..574b59aa89
--- /dev/null
+++ b/hw/vfio-user/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_vfio_user.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index f1a2d4374d..93bd0e1361 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -24,6 +24,16 @@ struct VFIOUserPCIDevice {
     char *sock_name;
 };
 
+/*
+ * Incoming request message callback.
+ *
+ * Runs off main loop, so BQL held.
+ */
+static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
+{
+
+}
+
 /*
  * Emulated devices don't use host hot reset
  */
@@ -78,6 +88,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         return;
     }
     vbasedev->proxy = proxy;
+    vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index ac481553ba..4a654d7597 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -14,15 +14,32 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/proxy.h"
+#include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "system/iothread.h"
 
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds);
+static VFIOUserFDs *vfio_user_getfds(int numfds);
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
+static void vfio_user_recv(void *opaque);
+static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_cb(void *opaque);
+
+static void vfio_user_request(void *opaque);
+
+static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
+{
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = err;
+}
 
 /*
  * Functions called by main, CPU, or iothread threads
@@ -35,10 +52,340 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                     VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+
+    msg = QTAILQ_FIRST(&proxy->free);
+    if (msg != NULL) {
+        QTAILQ_REMOVE(&proxy->free, msg, next);
+    } else {
+        msg = g_malloc0(sizeof(*msg));
+        qemu_cond_init(&msg->cv);
+    }
+
+    msg->hdr = hdr;
+    msg->fds = fds;
+    return msg;
+}
+
+/*
+ * Recycle a message list entry to the free list.
+ */
+static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    if (msg->type == VFIO_MSG_NONE) {
+        error_printf("vfio_user_recycle - freeing free msg\n");
+        return;
+    }
+
+    /* free msg buffer if no one is waiting to consume the reply */
+    if (msg->type == VFIO_MSG_NOWAIT || msg->type == VFIO_MSG_ASYNC) {
+        g_free(msg->hdr);
+        if (msg->fds != NULL) {
+            g_free(msg->fds);
+        }
+    }
+
+    msg->type = VFIO_MSG_NONE;
+    msg->hdr = NULL;
+    msg->fds = NULL;
+    msg->complete = false;
+    QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
+}
+
+static VFIOUserFDs *vfio_user_getfds(int numfds)
+{
+    VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
+
+    fds->fds = (int *)((char *)fds + sizeof(*fds));
+
+    return fds;
+}
+
 /*
  * Functions only called by iothread
  */
 
+/*
+ * Process a received message.
+ */
+static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg,
+                              bool isreply)
+{
+
+    /*
+     * Replies signal a waiter, if none just check for errors
+     * and free the message buffer.
+     *
+     * Requests get queued for the BH.
+     */
+    if (isreply) {
+        msg->complete = true;
+        if (msg->type == VFIO_MSG_WAIT) {
+            qemu_cond_signal(&msg->cv);
+        } else {
+            if (msg->hdr->flags & VFIO_USER_ERROR) {
+                error_printf("vfio_user_process: error reply on async ");
+                error_printf("request command %x error %s\n",
+                             msg->hdr->command,
+                             strerror(msg->hdr->error_reply));
+            }
+            /* youngest nowait msg has been ack'd */
+            if (proxy->last_nowait == msg) {
+                proxy->last_nowait = NULL;
+            }
+            vfio_user_recycle(proxy, msg);
+        }
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->incoming, msg, next);
+        qemu_bh_schedule(proxy->req_bh);
+    }
+}
+
+/*
+ * Complete a partial message read
+ */
+static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
+{
+    VFIOUserMsg *msg = proxy->part_recv;
+    size_t msgleft = proxy->recv_left;
+    bool isreply;
+    char *data;
+    int ret;
+
+    data = (char *)msg->hdr + (msg->hdr->size - msgleft);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
+
+        /* error or would block */
+        if (ret <= 0) {
+            /* try for rest on next iternation */
+            if (ret == QIO_CHANNEL_ERR_BLOCK) {
+                proxy->recv_left = msgleft;
+            }
+            return ret;
+        }
+        trace_vfio_user_recv_read(msg->hdr->id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    /*
+     * Read complete message, process it.
+     */
+    proxy->part_recv = NULL;
+    proxy->recv_left = 0;
+    isreply = (msg->hdr->flags & VFIO_USER_TYPE) == VFIO_USER_REPLY;
+    vfio_user_process(proxy, msg, isreply);
+
+    /* return positive value */
+    return 1;
+}
+
+static void vfio_user_recv(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (vfio_user_recv_one(proxy) == 0) {
+            ;
+        }
+    }
+}
+
+/*
+ * Receive and process one incoming message.
+ *
+ * For replies, find matching outgoing request and wake any waiters.
+ * For requests, queue in incoming list and run request BH.
+ */
+static int vfio_user_recv_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg = NULL;
+    g_autofree int *fdp = NULL;
+    VFIOUserFDs *reqfds;
+    VFIOUserHdr hdr;
+    struct iovec iov = {
+        .iov_base = &hdr,
+        .iov_len = sizeof(hdr),
+    };
+    bool isreply = false;
+    int i, ret;
+    size_t msgleft, numfds = 0;
+    char *data = NULL;
+    char *buf = NULL;
+    Error *local_err = NULL;
+
+    /*
+     * Complete any partial reads
+     */
+    if (proxy->part_recv != NULL) {
+        ret = vfio_user_complete(proxy, &local_err);
+
+        /* still not complete, try later */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        /* else fall into reading another msg */
+    }
+
+    /*
+     * Read header
+     */
+    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
+                                 &local_err);
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        return ret;
+    }
+
+    /* read error or other side closed connection */
+    if (ret <= 0) {
+        goto fatal;
+    }
+
+    if (ret < sizeof(hdr)) {
+        error_setg(&local_err, "short read of header");
+        goto fatal;
+    }
+
+    /*
+     * Validate header
+     */
+    if (hdr.size < sizeof(VFIOUserHdr)) {
+        error_setg(&local_err, "bad header size");
+        goto fatal;
+    }
+    switch (hdr.flags & VFIO_USER_TYPE) {
+    case VFIO_USER_REQUEST:
+        isreply = false;
+        break;
+    case VFIO_USER_REPLY:
+        isreply = true;
+        break;
+    default:
+        error_setg(&local_err, "unknown message type");
+        goto fatal;
+    }
+    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
+                             hdr.flags);
+
+    /*
+     * For replies, find the matching pending request.
+     * For requests, reap incoming FDs.
+     */
+    if (isreply) {
+        QTAILQ_FOREACH(msg, &proxy->pending, next) {
+            if (hdr.id == msg->id) {
+                break;
+            }
+        }
+        if (msg == NULL) {
+            error_setg(&local_err, "unexpected reply");
+            goto err;
+        }
+        QTAILQ_REMOVE(&proxy->pending, msg, next);
+
+        /*
+         * Process any received FDs
+         */
+        if (numfds != 0) {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(&local_err, "unexpected FDs");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+        }
+    } else {
+        if (numfds != 0) {
+            reqfds = vfio_user_getfds(numfds);
+            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
+        } else {
+            reqfds = NULL;
+        }
+    }
+
+    /*
+     * Put the whole message into a single buffer.
+     */
+    if (isreply) {
+        if (hdr.size > msg->rsize) {
+            error_setg(&local_err, "reply larger than recv buffer");
+            goto err;
+        }
+        *msg->hdr = hdr;
+        data = (char *)msg->hdr + sizeof(hdr);
+    } else {
+        buf = g_malloc0(hdr.size);
+        memcpy(buf, &hdr, sizeof(hdr));
+        data = buf + sizeof(hdr);
+        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg->type = VFIO_MSG_REQ;
+    }
+
+    /*
+     * Read rest of message.
+     */
+    msgleft = hdr.size - sizeof(hdr);
+    while (msgleft > 0) {
+        ret = qio_channel_read(proxy->ioc, data, msgleft, &local_err);
+
+        /* prepare to complete read on next iternation */
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            proxy->part_recv = msg;
+            proxy->recv_left = msgleft;
+            return ret;
+        }
+
+        if (ret <= 0) {
+            goto fatal;
+        }
+        trace_vfio_user_recv_read(hdr.id, ret);
+
+        msgleft -= ret;
+        data += ret;
+    }
+
+    vfio_user_process(proxy, msg, isreply);
+    return 0;
+
+    /*
+     * fatal means the other side closed or we don't trust the stream
+     * err means this message is corrupt
+     */
+fatal:
+    vfio_user_shutdown(proxy);
+    proxy->state = VFIO_PROXY_ERROR;
+
+    /* set error if server side closed */
+    if (ret == 0) {
+        error_setg(&local_err, "server closed socket");
+    }
+
+err:
+    for (i = 0; i < numfds; i++) {
+        close(fdp[i]);
+    }
+    if (isreply && msg != NULL) {
+        /* force an error to keep sending thread from hanging */
+        vfio_user_set_error(msg->hdr, EINVAL);
+        msg->complete = true;
+        qemu_cond_signal(&msg->cv);
+    }
+    error_prepend(&local_err, "vfio_user_recv_one: ");
+    error_report_err(local_err);
+    return -1;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -54,6 +401,53 @@ static void vfio_user_cb(void *opaque)
  * Functions called by main or CPU threads
  */
 
+/*
+ * Process incoming requests.
+ *
+ * The bus-specific callback has the form:
+ *    request(opaque, msg)
+ * where 'opaque' was specified in vfio_user_set_handler
+ * and 'msg' is the inbound message.
+ *
+ * The callback is responsible for disposing of the message buffer,
+ * usually by re-using it when calling vfio_send_reply or vfio_send_error,
+ * both of which free their message buffer when the reply is sent.
+ *
+ * If the callback uses a new buffer, it needs to free the old one.
+ */
+static void vfio_user_request(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+    VFIOUserMsgQ new, free;
+    VFIOUserMsg *msg, *m1;
+
+    /* reap all incoming */
+    QTAILQ_INIT(&new);
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &proxy->incoming, next, m1) {
+            QTAILQ_REMOVE(&proxy->incoming, msg, next);
+            QTAILQ_INSERT_TAIL(&new, msg, next);
+        }
+    }
+
+    /* process list */
+    QTAILQ_INIT(&free);
+    QTAILQ_FOREACH_SAFE(msg, &new, next, m1) {
+        QTAILQ_REMOVE(&new, msg, next);
+        trace_vfio_user_recv_request(msg->hdr->command);
+        proxy->request(proxy->req_arg, msg);
+        QTAILQ_INSERT_HEAD(&free, msg, next);
+    }
+
+    /* free list */
+    WITH_QEMU_LOCK_GUARD(&proxy->lock) {
+        QTAILQ_FOREACH_SAFE(msg, &free, next, m1) {
+            vfio_user_recycle(proxy, msg);
+        }
+    }
+}
+
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
@@ -92,6 +486,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     }
 
     proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
     QTAILQ_INIT(&proxy->incoming);
@@ -102,6 +497,18 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     return proxy;
 }
 
+void vfio_user_set_handler(VFIODevice *vbasedev,
+                           void (*handler)(void *opaque, VFIOUserMsg *msg),
+                           void *req_arg)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+
+    proxy->request = handler;
+    proxy->req_arg = req_arg;
+    qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                   vfio_user_recv, NULL, NULL, proxy);
+}
+
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
@@ -117,6 +524,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     }
     object_unref(OBJECT(proxy->ioc));
     proxy->ioc = NULL;
+    qemu_bh_delete(proxy->req_bh);
+    proxy->req_bh = NULL;
 
     proxy->state = VFIO_PROXY_CLOSING;
     QTAILQ_FOREACH_SAFE(r1, &proxy->outgoing, next, r2) {
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
new file mode 100644
index 0000000000..89d6c11c4c
--- /dev/null
+++ b/hw/vfio-user/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# common.c
+vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
+vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
+vfio_user_recv_request(uint16_t cmd) " command 0x%x"
-- 
2.43.0


