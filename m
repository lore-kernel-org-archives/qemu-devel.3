Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172BC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vn9-0006CE-46; Wed, 09 Apr 2025 09:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn6-0006BE-SC; Wed, 09 Apr 2025 09:48:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn3-0005bD-KD; Wed, 09 Apr 2025 09:48:32 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539CSwlT028498;
 Wed, 9 Apr 2025 06:48:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=msJ7guzLIr2Wn
 5w5UBTY5nHoRNbtzDB/jaupuOwHxgQ=; b=dHOfWgcmwMuTTup+sCKfeFJJtEskR
 TV09IN/AG0zCdga3ggywwNiFcS5pwIyf7z3z8XfFLRbC0eXXsfKVpA//al67DHia
 sF+4YZABC/ou60mVLLauP24cZmY/7U8KBGl1GMkmmaf4+TzcJ2lnHwTZLoPzCije
 UMZ+WFfwbFQ9U6Uaywhff0lxgm4WbVxBUYEUeAj/ztDKNNogvLX84aI/OsCd1oWO
 yK5T646NWdj7S4TkegZdPtMMQyVCm2bcWGJJwDl38xoK6wkWMvwMSuCFJzhMRJxv
 ttSejsIWmcItH44UosES96ywH5tLymvvw/mObsy33zml6xn9KJh+XwkNQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u42xhap7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMS1BigbYQUyG1B4ZnY/1WpkCiAU33oJlwbxVsG0BhgRUcOyWcT/9ko5ayQmVAFoiDV+/mWieb80E3vfdLlLuUR18ZgSRMVxA9gbQmtjuVqOTjAsu70kAbTFN6TveisZk5H5ACj/xkxHIVhQIw7OT2R4T/Z5udS3gOjxZEkBRmYgCMwXVzo/V2cmSfZSkBK9z0ANVhOTew1Nhtl14Vl93fvHyZZqL1sMLVramFI3ZEjROJsP117MjhSuI0tdzio9pY8EGUFgVWtjnH4yuYjiwPVulPrxOS0idj3CrTQNld4csTUT30I+YWz5cfGEB06rALjKLmjaogCEL5fo3fjjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msJ7guzLIr2Wn5w5UBTY5nHoRNbtzDB/jaupuOwHxgQ=;
 b=nh6lz1ppfEwFzaDsLleRH472ZEjmiDoMAdbCIZ5NymkZTWtGun0420TDt7uNJvKFiGT3OuYHLm0TWne+YgNKXqD0p52sUNCxDuV/sfUSfCb0BT+A3XGPdIyprlM55EHU07AbDehAil7W+D2pAozztmjBudUP9Ouu4WuP5wQiNxIQ8o/6pCf8xJp85w08U1NvDpBoScNgdnrMQRGwzjzW1VZkhsTzXdpacDhVDxiYazHveSspzLZtPX9pyhP4UFtHRhZo8vcjGxa02F5FoKBMyRxDuo1WYKfCfWYBEpPSF2BY1flkLwQcA489EGnEAO3Rbn1wv+D89jI4bqySmsK/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msJ7guzLIr2Wn5w5UBTY5nHoRNbtzDB/jaupuOwHxgQ=;
 b=gKdyCD+zQX1sTyJXuB9fYiFmsPIhS0vDnuF9HJlHZjzkniOD4sPH4OBokQ1Z4K2FCaV5J8GQ6QCcp0jE5wH8WVLgsMgJTNWPR69EN/dv3Qb0CJySsu6L3XIB7WpLTlL9KSlwGl6KOZeVacaYm1phC11Kl4kQjtsOwYP7n5rPaRTnAw/+/359ohIPIKSDtWiiWCUP+kHHh2VfNvnorILwUbI8YAkGSX1nvQDRnhyDXo6a4Bd+NePW9Esoh2jB0lbE+huCOUtsCH4dY1iV7/KysJ8gBmyBzyNbpjyIIDhuUKBEGH7i4Hg/ZpIkipBLprxrhxRAZ0LPHqOrvC7xaO6OIw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:19 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 00/14] vfio: preparation for vfio-user
Date: Wed,  9 Apr 2025 15:48:00 +0200
Message-Id: <20250409134814.478903-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f8547b-4adc-47b5-1a0e-08dd776d2f7f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lKK2l5ZEJPTFhVN0t1MVdEYWhicXY4NWdiUWs2S0xzSnNKY2JjSFJ6VkRp?=
 =?utf-8?B?WkdRWkxLNjZwU29qY2gvNThuUmVBNUxYOGRSVXZXNXNvR3EyakY2TWFpNnpZ?=
 =?utf-8?B?ajJFbTQrT21VU1BXT003bHdkejF0UjN6RXlXalJUS3BNdkF2bGZNQm5EVHhj?=
 =?utf-8?B?UGw3OWhEeEhJbnRIWmlicDVxRGNsaUs2OFhWeHJCdHpndnBnWVVXNU1sYmtN?=
 =?utf-8?B?NVB3V2ZTZ2dDVTl6Z3p2RVJjMzJ0c2JkRTZtTjVRRTE2YzVUSEJFNlR1ZDkw?=
 =?utf-8?B?RzJiK21DRDJHQ2NNTTdxTTRVS3BmbjFZZVU5MkJyTk1wa2FKaHJoSlFPVVBs?=
 =?utf-8?B?TWo2TFZtQUhPWHduY0RVWktHeWF0NW1GSVZ3N2oreHJuSzJ5YjQ4ekJEeWtR?=
 =?utf-8?B?TnE2NVRCYlZMV1pwWFhKN25tanlNRjRXYmpneHl1VE1ML2I3WkcwMDFocm1h?=
 =?utf-8?B?Q3Y0VWlpM0U1eCtUMjBXcGk0QlN2STBjYkNadmR2dmdqUGFFNkdHZ1hWUmFl?=
 =?utf-8?B?TC9CTUtyRGFhZXllU0VaaHNydzVPSG52RFY0NXpZV21GTGNPMkIzTS8wL2Js?=
 =?utf-8?B?dENQUHNmenY0dDBXVXE2TVU2RlFJVnVjTW5DNHVQNk5oWEk5cHRoUkJtNWlu?=
 =?utf-8?B?b05zRnkxRjNFbHJ1ZXZaMW56OWpmQlVzSXp5QlpHSW5IaVBtNTEvRy9zZURo?=
 =?utf-8?B?VVJocDV5MUF3ZzRqVVZsMENYTXUveVp2VEpYOWFQTEw5TXBhWnVJOXhqUFhi?=
 =?utf-8?B?eWtkZGd2M1NvMjl0UkNHeWdKRXVXWnF5TFhWN1hzZXZxMFpiYlVHZlNSSjhn?=
 =?utf-8?B?WXl4QjUxTWtnSXNSdThibkhJaWErVkVzL2JrRmFyN25YdllDbDE3OFNmaHF5?=
 =?utf-8?B?ZDgxMXQzUS9iUEtRNTVhbFkvWkphYWlnV08va1MzNUNpa2duMGgzUmNObWJa?=
 =?utf-8?B?Y0FQT2kvZjRUSWtEbjhRZEJsd1Jzdy9aTis1UjRPSTZNSHlSM1RnUDVyc0xk?=
 =?utf-8?B?WlZNNzc0Y25yaVkxUmJPWDk3RmJXQ1hTcU9CQTFRVExDbUdLYTR2NXF4dGcw?=
 =?utf-8?B?Z0N1cmsvWlN1K0ZOQll3Vk93bjFUT2Z3WVg3TnVJQ2c5S3pXS3J6bkhFS3lE?=
 =?utf-8?B?VnRBTjFTQVZBM0lJc2pJNDdCcTBiZE9rT2JWRVNEVHRDMkEwVS80K09HVHoz?=
 =?utf-8?B?Zkxab2JGWHJjU0REVVFiWHZyOHMyb0haeWtqdG1RRWRLV2VxZzFPcUIyTmdz?=
 =?utf-8?B?d3cwbnNKUTVHcmRFM05pQ1ZmbXY4NVcxWHZVLysxNHpvRHBLSFNNUVZzc3g1?=
 =?utf-8?B?STZFcHZQbS9uUU11b1pTM253dTlrSERSekFKakNOYmxQYnZ6bUdOaElLNVRr?=
 =?utf-8?B?NW9JbUZZa0lDYTdKNjlMV3JxWTRmVHdsWFl5VDY2UzZrUWM0YXFtOTVOTSs0?=
 =?utf-8?B?WlJGeHVBOFFBQWNlaFo3Tk5ZdHZkTE1aelZ1aGtjdFVobUpFdXFkUU0ybG1V?=
 =?utf-8?B?d3VscWxxVUlBUHlZRHpGL1hWSldvcWZWeEhMU3h5UGZ0V1NVOUNJSlNsWndN?=
 =?utf-8?B?aTRUOWlnZHhsMHJndkRlZjI5bElNbDdZS25Id0ZJQnBCcm5zcXRpNEhDbkRT?=
 =?utf-8?B?R0JYcUNvRVAzdSszcFBPUGRRemE5clJUcUxhazlaTWlMM0hnemZsYzhJZzZS?=
 =?utf-8?B?YUtmUFp2TkxzZ0RFRnhZWjZUdWFQOXgyYWdkNHlDM3N2WEc4L0NWQVZtY0Uz?=
 =?utf-8?B?OUdFQ3BCK3F5ZWpuUHlFNkEySFFhODl0MDhQd3MvL3d2UzhOZU1BL1J1V3JU?=
 =?utf-8?B?L1phRnZ5cHljOS9nSDZOand5V0FwbWtnaHJtcXk5UzFmV3JvbjlQTlNTdzhH?=
 =?utf-8?Q?Ohu0UTmFy5A1t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlc3WXFuNm1wZUtoR2ZOTjF5dmQvek5QeXBUWXQvUXQrSWcwV0RQTXVkT1Fs?=
 =?utf-8?B?NlkzQW1XT0EwWjFmZUF6V01WTDdCOUIvdlp0SDdreGppUWdweVhJd2xNbzJo?=
 =?utf-8?B?VW5TUmlDMm96WTNjYnU0SlVBVGo5dEVyUXZKQ0UzK3QrVTRuNmJhUGxnQ3A0?=
 =?utf-8?B?bmtyTUlOK1VINFIzQ0wzalk2c3JDNVY5OEZCaHZKUGJCU3lsYTgybHJaZHIw?=
 =?utf-8?B?MiszTlBlbVVQdFFMM2RuUitZck1aUEJOWlJ5UTZpei9WTnRGTnpRczJHMHNI?=
 =?utf-8?B?bU1HMk5uSGRHbm9tcW95WlpXNHAvcFhUVUsrNEY3bTdjTnlRL1hJdXo4c2Vq?=
 =?utf-8?B?bHRCamtiZnRweXV1Z0M4NnlGS21JS28vU1pHV0drcHZpdHhVeVVTd28zYm9T?=
 =?utf-8?B?aUtPV1dtQTNTYmNQRnZRZVlYa1NPZUtaT3VhazIxS2F4b3ZvWlpDV0NkRUFK?=
 =?utf-8?B?T3FVcnRxaWtLRU1SZ1hWUXZlWjVpZUtjYVZkTEtrSFhMS2kyNTBEUGxNYzI4?=
 =?utf-8?B?SFBOZmlqd1FPaWljS3lXQnp3TW9hSHJuc0c2RkJRUm9EZFBVaVgzMmxCY0pn?=
 =?utf-8?B?cElib3lQVVdlWG5IbGxOOCtFWUJlN2dZc1p0c0F5NkliZklkeThYTXpIYzRL?=
 =?utf-8?B?dVI5aVAzOVROeVU0ckptSE82c2VFVVJVdm1Ea3hpdXN4SlROby9sc3BJeGh6?=
 =?utf-8?B?bUV4WCttRkpuRUprLzJabHVuY0NsNnRHY1dSSmYyNUx1WVdDdUtSOHhNOXRh?=
 =?utf-8?B?aU5NTU9FKzlGL0VIRnV6TmhPazQ3VWdMZzhnbHd1aldpWk5zallMWTYwbkxH?=
 =?utf-8?B?VUVQNDBUeDN4d05rVVNLYkxFck5OOFVKRkwvN1NUazllTW14di9tQmVvNzc3?=
 =?utf-8?B?b1A0alg1K2ZHQTJ4cHVXcnFxZmlrRytjS3luaTdpR2paUWhXU2pjVDE5Rnlp?=
 =?utf-8?B?bzVjSWNDSS9UYUZYaVo5VjlGVUF1S1U1WVA2eHJiL2E4MExsdnljQlZyd1RV?=
 =?utf-8?B?QXBaeVlKT1N0L2l4VlNYS3ZlUEMveDc5bUtmMWlsbE9zQlpMU0dKRngwMUJa?=
 =?utf-8?B?TUNST1RQd2FHMXVLTUpDZWNZVTZmN25RcFYwdUltcWNQcFNZdUJURTFZZmpT?=
 =?utf-8?B?WWZYTGNLYnhDa2p1UjhwTHZzeWxEWDUyVCswRDgzeFpJdG03Q3JVa0JZNUNI?=
 =?utf-8?B?amxadHdDZzJDT20vajJxQXVrbDUwQVE3MjllOWdBMzJPMDRzNTZ3LzM1VVZW?=
 =?utf-8?B?eUFDb1JEVlJjSzVTU2hRMlprOURPNHRhVUJ0c1M2a0FPV2UxVlNXUlJST1ZG?=
 =?utf-8?B?Z1dreXJZaVNFNkkvdFlGRUF1aFJTb2VycUhaNmMvd3drODhTVk1hNnVtN3M2?=
 =?utf-8?B?WUxScmhRdWNweVZ3R0VPbXJ5N2lXR2U2Y2NQZzMrOFQ3SGhtTURuN0VKWTlu?=
 =?utf-8?B?cjhkY3MzMm1LVTBzeXNkMWJaZTB3eEhXaER6Y3YxSy85N3A2K1dvNE1ZelY3?=
 =?utf-8?B?NUhKOW14RlVRT05mdXEwb0w3MkFrcnRBckJwaERnNGVNdVZWNnZqVmxtU0lu?=
 =?utf-8?B?L1F0VnAwWjY5cUtGM3hsWHJVY24vNE1NUjFmdXdPREsvaVd5d0FldWdQeGJQ?=
 =?utf-8?B?YUZGVmFBSSt6ditBOFF0c2tneFU4NHJWS2hOUnQ4OVIxZVNNWVljWEVXZy96?=
 =?utf-8?B?ZUtkWitSNzFxRUtkSTRvT1RZR3FXZlpZMlJ5L1B1T1dYVGVNekE2ZlRFRDZR?=
 =?utf-8?B?eFJBQ1IybGZsbTJINjJ3Y2V4eHltMUJIR3c0Q0FIZDRsVE9pZGE0T0lsbmJa?=
 =?utf-8?B?WUtpL0d5dWpYeW1rQVMzVXdkNTRPVExkRHB1d1lCa0YzNDZjMzkrRGJES25D?=
 =?utf-8?B?cXZia05vNHU2T3Z1NnNLNmVCUFJkM2RrT2JtcEFwaTd6T3BRMDRxTDUxVXFx?=
 =?utf-8?B?eEFzVjA4U2ZGOCtCZWZ3ZWpJdFhMK1dZTVRiQ1hTbCsvSGVJVXVSWGpmakk4?=
 =?utf-8?B?bFRMNEdpdHpqdGJpY1pxZGpMc0wrbkppMWdRR1NVakZheXFTeWsrWXdNS0JH?=
 =?utf-8?B?U3JQYWl6aE1iK2JKNGhNdGd1L25hY0JTQmpXUEZ0T3dlWlhjbWRoOG9XRUIw?=
 =?utf-8?Q?0Pg/Z/c1xmVi2041U5YPl8qhx?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f8547b-4adc-47b5-1a0e-08dd776d2f7f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:19.0806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRS8dFMrMWg3CP3t8QpUlUrGrAxGaMsMmwcCCmufM+Qic+7ecIOTKGav8yYkf9wxnxnVKVTmmsPSRu886I5Ymg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-GUID: FEE9WylTKaHOu9dk4JEvKO-5muZQxju9
X-Proofpoint-ORIG-GUID: FEE9WylTKaHOu9dk4JEvKO-5muZQxju9
X-Authority-Analysis: v=2.4 cv=LMxmQIW9 c=1 sm=1 tr=0 ts=67f67aa5 cx=c_pps
 a=a0mreH8AhMfks3Nq6fhO9Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=bIpqAR5UwWuSHNZiNLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi, this series is based on Cédric Le Goater's vfio cleanup series:
https://github.com/legoater/qemu/commits/vfio-10.1

The series contains patches to vfio to prepare for the vfio-user
implementation. A previous version of these patches can be found at
https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
("[PATCH v8 00/28] vfio-user client"); roughly corresponding to patches 1-10.

Please see that series for justification and context.

The following changes have been made since the previous series:

 - rebased on top of vfio-10.1 cleanup series
 - split unmap all patch into two, fixed some nits, dropped unmap all detection
 - fix two vfio_interrupt_setup() cleanup bugs
 - various renames as per review
 - new vfio_device_get_irq_info()
 - split out device ops patch into smaller chunks
 - region cache renames for clarity
 - commit author corrected for several patches

thanks
john

John Levon (14):
  vfio: refactor out vfio_interrupt_setup()
  vfio: refactor out vfio_pci_config_setup()
  vfio: add vfio_prepare_device()
  vfio: add vfio_attach_device_by_iommu_type()
  vfio/container: pass listener_begin/commit callbacks
  vfio: add flags parameter to DMA unmap callback
  vfio: specify VFIO_DMA_UNMAP_FLAG_ALL to callback
  vfio: add vfio-pci-base class
  vfio: add vfio_device_get_irq_info() helper
  vfio: consistently handle return value for helpers
  vfio: add vfio_pci_config_space_read/write()
  vfio: add region info cache
  vfio: add device IO ops vector
  vfio/container: pass MemoryRegion to DMA operations

 hw/vfio/ap.c                          |  21 +-
 hw/vfio/ccw.c                         |  27 +-
 hw/vfio/container-base.c              |  14 +-
 hw/vfio/container.c                   |  74 ++-
 hw/vfio/device.c                      | 178 ++++++-
 hw/vfio/igd.c                         |   8 +-
 hw/vfio/iommufd.c                     |  35 +-
 hw/vfio/listener.c                    |  82 ++--
 hw/vfio/pci.c                         | 672 +++++++++++++++-----------
 hw/vfio/pci.h                         |  12 +-
 hw/vfio/platform.c                    |   8 +-
 hw/vfio/region.c                      |  19 +-
 hw/virtio/vhost-vdpa.c                |   2 +-
 include/exec/memory.h                 |   4 +-
 include/hw/vfio/vfio-container-base.h |  10 +-
 include/hw/vfio/vfio-device.h         |  34 +-
 system/memory.c                       |   7 +-
 17 files changed, 784 insertions(+), 423 deletions(-)

-- 
2.34.1


