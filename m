Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E531C54755
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFalO-00066U-Pm; Thu, 15 May 2025 11:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal8-0005pU-GV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal3-0006BK-HI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:34 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7pI1j006017;
 Thu, 15 May 2025 08:44:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=JD0r5CleKnUNe
 v9ZlqLwRN6y8ZeWJbRaCKy4rrtl2WQ=; b=ZmRDVvVN5gq1rgBV8192cyhhOnCSD
 DkzqDnCwrvdChrTj7oieuqC0BuLWyAeBzHL/wmYauva/4e/u1DhhvZEES3bia3Yo
 sUULnogWnGDkx12fntFPnrWeaQ1v+R+5DI4Y/yxfyaAgg0dxtE7OwnLtArPcrh9L
 cjGxsjmiF76jQSCCBaUUiiNfir5oeSl+dTz9BK5IRSX9jmWpOxruORxQD3GfJQl6
 dpcMY2QttE3Y5SGuSoyi6eijohqxF2EyNVXiT1a8uVQwlxcRsQmuT7wtRj0+BrLI
 gU7/RtYbpDT2k7BEMXtl788R490nuYOt6D9/Fxd4caABYa8zlATbRZdIQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mxh0k193-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUlcrYxOaeV7ux2nSVWeRS9svgGINIOMETVARae7QM4BEp2DWZBIKZ8Ti8q7nl7NyxfRWA7If7OsrBXLYGnWbDcr/+LJ0aRBHVVuygkf4OR6BiTZQXj7BKw95MFa/vKx09wH3EuHDrj3CSAuP7vcLNCSWPptWwHpIImDCHJZ3wbtT41ndnrjaqgzyY7W8Y2k/3Mf6Zx3FZa9oOC7R1ZJgTNOtq233JwcSrcs+rXZhLCrD/I5bwB1gjJTrhu8E/+qnRmqH8ENGWwU30/Iw9YSEXJmrC4caZuVUvbW2P6SMO+SaojXgBnzNbGB/UQBcimp2j/N8DLrrUxgG587KxB0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD0r5CleKnUNev9ZlqLwRN6y8ZeWJbRaCKy4rrtl2WQ=;
 b=OU/ZUNVRaPbVmS3beM8lh4amG2xoRJy+AWTZBZ51X3JZVDsODRElpGW6Q3+wEiiqTsfLLKFbFgr3ReQIqLDcNOn41s1vxBVUQGrn1XI4UPf9NUbtsGcqmoV+otMQzeH90X24z7UWGb0YG0/bYhUljkfb4OcprFp8lkm9ndHLmf+04Rh4j+zUAtZvO9v0rPc0CfI8rtfN1jXzxp3b0WJzQS74aiebK0evndSYO19OcU03RC0K9Fl6R+Oomy24j2GEbWc7V/SCRWeViFPRbk3EJ2eiLWe+1nbao/hurV9aPL1Cp2+6s4RdM41PHPohYTtytvyDdfALtfj+PlNi/KBIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD0r5CleKnUNev9ZlqLwRN6y8ZeWJbRaCKy4rrtl2WQ=;
 b=WynEvxD+eRrx5z43RAbJm8pLA2s5wuBZJL1knjcIZ1VDHe+MyB9tI3IyMN7JZEn3u7KKBQRFYIhXpnOFLiHY4vsDm8Exc+JmbG1fDYvCOOS5PE1WFdrLDJ5O2rywW+KupMnQeavxmyFzhbIpJcCv7+d3IV7ZpNiu1CzVd8meDV8EvcgT1/2GkVBemPdnK0uSebM4kpcAjSFcMKK2WHB6TN8SoWdYHIqiLiw70Wu+emtGZXcHS2RUDSE9ndI6ZDyINBmA/XOBmqA4zf8Z6HJJJX/dGUfSXc+h1XAlDSQatiD95j6nuqZyQrelucFeWUz2JWNXTTFHiFRdvtg28/5ezg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7241.namprd02.prod.outlook.com (2603:10b6:806:ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 15:44:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:19 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 00/27] vfio-user client
Date: Thu, 15 May 2025 16:43:45 +0100
Message-ID: <20250515154413.210315-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be2ca80-8374-44d2-c643-08dd93c75b48
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHoxbEpVT05qR2NQZDkvbmNFYkFtS25zbG13V1VGdkoxQjFqd2hJeEhNaU9U?=
 =?utf-8?B?NTFzby9HWHdwRHI4Q0lIYStBcmFObjVMWUk0RXo1UXRUZ3B5bzlwdmZKc2E1?=
 =?utf-8?B?aWtIZHpNQjVxT2ozT2p6S2R6c2t3NTM0clM3RE1hWWRqWi9qZGh5d2M4S0Vz?=
 =?utf-8?B?TVdpRGtJWUJ5bTZnK05FK3NhWHUzN0lDellFNEJGSkR0TmgrNE50VSszSWFt?=
 =?utf-8?B?MmpsUE5nN1hGR2JOZFgyeFVJWjE4Y1pkKy9WRDNkZmttV0FJZVVYRVFOWFh3?=
 =?utf-8?B?Wkt0Yk1UOGVBY3lrWmRmZHlFeGhiUVhEbnZncGhmRmxWdTRNcHdIcTlJTHQ1?=
 =?utf-8?B?NmNHQnptM3dGRkhsbnVUR3RNVzl3b1pGaTN4REp4cWlCT0pNTDhldDhHVmhI?=
 =?utf-8?B?SkpydXVYejZUUWRXalV4SWxBY1V4Wkt2K3pYcitidUd3YVFNSDdMeG92YmJI?=
 =?utf-8?B?Zy92bDlOMGkwbS9xZUM2VFkrUWRPb1lMcjc5T1pSWDdYdm5PNmpjZStnSW5j?=
 =?utf-8?B?ZjhJNkcxNWhhS0Q4VUlFTmE4U3dJejJLZGloblpBSUhtZENxQTdvQmVlTDlV?=
 =?utf-8?B?V0xVZkhKb2I0VW13NG56S0dkTjJEMlpuL0Y2R2JUVXV0SWIvcnRWUGRtOTJo?=
 =?utf-8?B?ZjRpU3JreHVtdU0vUVBySUdIUU4ySms5MWw5Wi9yQUdiY0VuM2ZoRkpQYUlT?=
 =?utf-8?B?cFVYVXJ3cEkwVm9EM1ZxbGJ3QmVzemhoekJSNU0wbEZTUkFoRnp0My9GekhU?=
 =?utf-8?B?cnR6Ykh4VGlBSmw2MkZva1kvaERUT2FKU1hlRGVXTWdRT0xOcjNwZlFXUk1L?=
 =?utf-8?B?YWlSQjVOMEFISnhlbk9HUnI0RHJkaTNycjl3MFRBOGtwbDRYOGF0cjZDTmd2?=
 =?utf-8?B?eVFqTlFNSE92V205VHpYaGtpRjQ3SG1yR3A3cVZOTVVtL3FIcFhZbG9PK1dE?=
 =?utf-8?B?U2NqY0VNK3BnTDZ4Zk51UWlQUmE5KzJIRlRUQXZYYmJSWERxT2lGYUVCL2Q1?=
 =?utf-8?B?UkNFRzhnREZyNjFIVVVHV1haaHpUdlVjSWl0dGFLSkROVGt5Z3ZUMTVuejQ3?=
 =?utf-8?B?c0dvR0ZmWklHOXVDSjZtc3RYcURMQUlsb09YTXVZMDRYU0xKZWhKMDgyaTV1?=
 =?utf-8?B?RFF6cTZoRlE0V2h3QXl4aEhMVmg2T3VmcHYweXhzVFJldlIwTmJXOVNQNVN4?=
 =?utf-8?B?WnpmZnJXZ1IrTGh1azJYZWU2WlRmQ01pa1JWVDQwNTFwcXFiRDFMM2NkRXlY?=
 =?utf-8?B?N2sxdnB2b1h1UTFXSXBUZDBDMW92OG5mbUFsS1QwRC92WldmNmxlZklvK3pr?=
 =?utf-8?B?YjlJQzE1QmZWQ3dGS2srRlQ1UHhwRlN2NUxJZ3RONVFsTFp6aFZuVUdXT2pj?=
 =?utf-8?B?M1l2WXkvRnFmcmFKU1BJTXBTTTFlMWhaNVRETzREQ1VwKzRNZlR2ZEFlVHBn?=
 =?utf-8?B?ZmRwdFNTNGg2emFVSFF4eVovYU1BYUdGQ0w1NzNVS3NSV2ZwN1ZVRi9OQUNo?=
 =?utf-8?B?WmRiM2RKOFc5dkRrdmh4b1VoMDFFbUtVWWtteHEvdzEzdXVRSkNOcDRlVmFW?=
 =?utf-8?B?ME5WTGs4dUlEK3BXN01YWDB4d0J5NkFWM3UzbTFnQlh0Ui9DNTM2TWViQVdX?=
 =?utf-8?B?OHQ2N0U1VEM5dHR2ekI5MExFY3AwR0UrZENucDhQODE2aVI5d3RZVEdZbnFz?=
 =?utf-8?B?NFh4ZFR1TzNuN1cySWlTQW1PbGdlVDk0VVNjNnN5Q2xFcHZPV2xyZFk5Sm1m?=
 =?utf-8?B?RkpMeXRqOThTZEFTYnhXSW1taDNBcG1pQVppU0w3dXl3TkJIN2QxVEZFVFkx?=
 =?utf-8?B?WS81dUVQWDgzakJmN0dQK016aGQzOE9pYzF6UCs5REZXcVIzYXl1blBuc1Bi?=
 =?utf-8?B?R1hYRllna0FwQW9ZV0U1UXBDRFpmWEwvN1hEUkIxeVRIelY0UVI2NzlPaTdH?=
 =?utf-8?Q?bREXCcFVwoI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9uL0hQNG1UUjM2V2VkbGdLRjhGTEsxQVZTSXRJSUhwaC9QY3d5LzdabUpw?=
 =?utf-8?B?bElxWHVIMGRydzh0dzc5WkVpNnJjKzg1ak9xdThQWExmWWppanFYaVFJSFBo?=
 =?utf-8?B?bEtaVk5uQnhyV0lMMW1qWFVRUmk2UzIwY1dlM2kyVjU1Y2pkdUM2WkpLMG1B?=
 =?utf-8?B?cE5Saks0dDd5UjgvRnFkL01rQnc5RHJjOEk4bnpwRXBWV2FJUXlxTkpKR1NN?=
 =?utf-8?B?Y01seXFXN2F0SE12STNaaUIvUnBNM2hQeWdpQzh2ZEtTYXpYSDZuSUdDK1lU?=
 =?utf-8?B?ei9UQ0pnUnVkb1gyL1V0bmd3eW5lQmhEcjBGZkd5M2QwdGpUMXAya1NPVEVV?=
 =?utf-8?B?UTRWUUNNQkJRVUpqOU5lZ0RSZkxnK3ZCWTNRRFI5cjNkbVJnNXpPcFh1QzJI?=
 =?utf-8?B?bm5udysyZ2trZmtHbkxsaUhDdmJ6WVhYc0JCWmE0ajBWV2hROExKTmo2UjNJ?=
 =?utf-8?B?dDJ5SUFTRnRXbnhSVm9ncURFUGpxVnNvSlphUkgzR2ZXZGxYd0lhc2w3S1FS?=
 =?utf-8?B?MlNkWkZON1Z2eExRNDVla0JDVXpiTXozamtIamxlR2RpUkFXMDZvci83L3lt?=
 =?utf-8?B?R2R0bnR2cnl5VDNTdHJDblRUUmcxcEo4cmxXUm9DUzg0TmFBRUdkL0pVb1Ft?=
 =?utf-8?B?d051Nk5EVnhuTGZVcnNyYnplWmZZbHlQT1p3akcvSmhJMlY0ZEJFdjAzOGMy?=
 =?utf-8?B?clpwb0ZBeStnQThxUFp6ZWdnUmRhc2V5THUybitFcWt2MkFGdW04TDRpTGxk?=
 =?utf-8?B?Ukg2WVRjQW9CNWpxZ1dtM2p6U2YwK0hjczRFdVpMem9YQk5KTVlCeW1zTFZ4?=
 =?utf-8?B?RGZuTTBkdEpDUWFISVJNaFphTzRxYjVEQVIySWt2MHg2RHM0cGpYWnN2YS9o?=
 =?utf-8?B?K042VnFGUFNJUVBTQVY5dkVDTGFHblFjdkg4K21xdGhqcVNEdDlsSVJCeUdw?=
 =?utf-8?B?YWgwa21SNHFiL0dlYzk1ZGlkVFY2bVJzV0cyTmRYSGdXaEM5WTNkMkUvTGw2?=
 =?utf-8?B?RDQ1SXdOdjR5OHphYnVBZ09uQSt0dEt6TGxCaDNHUlFIUzN3ODk3SUhJQ0pE?=
 =?utf-8?B?cVptRElZcVJHdXdTbnlyMXBaM2QzajNiQUZNd1BuTXNBYUxSU3RTWUh2M3Jr?=
 =?utf-8?B?clM0REZVVGdjN093SEMzUVIvM1VGT1dSbXNLR20rbW5VY1UxOCtCZUFOcmNa?=
 =?utf-8?B?UWVTelhFMms2cG13WEhGWmd3SEc4UnNnaFpRQ3hneXhnSGZSTVYyZ0ZtUS9z?=
 =?utf-8?B?MHE2SzNZWGQ2TTFjaE9iNDQybmFRS2dvL2JIM3RmcTExaDZBV0p6TnhrcjNM?=
 =?utf-8?B?dDNvemNpem0zYnJtUThzVzc1RmR6SFR0QUlWaTN6TlVENnJkaVovYTlhT2cw?=
 =?utf-8?B?OTRIU24veGtsNnVxWW12NFIwSVZqekpUWkVjY0xHcHF2bkt2UWFOZUYvVnJa?=
 =?utf-8?B?bGZVNmswM3JhUnRqanVYdHJLNUlRdm1YSHJCcmNTamY1THN4aWhNbkFiMFh3?=
 =?utf-8?B?dVA2UFlobmxPV0ZGVGxvdVpFR1hBeDVWYnByMTV4RzYxclpaODZRM1RwZTF6?=
 =?utf-8?B?UjVNQmZjRUltdGRpTG5MWTV3LzJkSTFtYjhQcTB0UG5RVnI5MFRDNzhQeWdB?=
 =?utf-8?B?QlN1Y1lUVmJRbjViUXJJR3JJc2haQ08rOCtTcGxXNExMZS9lWHNTdjRQcEpr?=
 =?utf-8?B?S1hCdWtyTmZQVk9VaWJzNFZJSWdFWkkwMC91bFlwZ2w5bmdqbXJ0MlNxdEln?=
 =?utf-8?B?QTgvaThKcUpZRFhTUzlSV2JEQTA4eG1xekJ2Wkd5RXR1dXcvTm5leGY3Zmg2?=
 =?utf-8?B?TThwWkdQRFVPMitHTGt6bXhxWWljMFJtS0FYSXdGbEtFRXlvYlNNVVMzQy9j?=
 =?utf-8?B?eHlZVTJwb2YwTFd4WTZxSnhtaDZDK01VRWpZQzNOMWtaS1JhWnJzRFJiMHJL?=
 =?utf-8?B?b1lRNVpGVjlKN3NXSU1kZW0rTXdZWit2djVqUlF0ZWllaTdrSnV2SzJUMnlt?=
 =?utf-8?B?SWY3VWlLaXY5bUJzNVhXUDk1VHRlL0FMVkMzWWxLakpHUFdYcnRrajgxeVJC?=
 =?utf-8?B?SWVvYzVxZTBoa3V5ZisyU0liV1ZCWXVqNE53M0pQL2ViTzRuUXRGOHM4Njhm?=
 =?utf-8?Q?o4hYvFZ8jtoUGVLgQLsJO57i3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be2ca80-8374-44d2-c643-08dd93c75b48
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:19.8515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPF/4ej/ABdiDTgYYDW94bjUsR5TrmtXYToeyZS88fn+5TJAhkDq9iuqUbxvYQOAHg+F+/VxIZbax+q41APU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7241
X-Proofpoint-GUID: 2ZN10uBONkLsD1MzcKv92s-HtQBxXs7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX1zCADD7pzQPv
 YkK12/3ZeDNKMw5sL9gyHlD4zGbxg8g5PKhoTX18UN0JoTtH4Cs0pZ3/ODxY1YEibEFZzwmn77H
 qZTl3VQhIK3xf0sTY2T1HdnVzn0xy6gyd2sj3Bgzz7MDLyTaovanbr7EpmOI6CQ4grWX26wvWUj
 FTpz59va8Cy9znzF3cx3cxdlBAeChuHKeYa0WXpdQwAs7ekiVG/ErcHSesHkQIg5D6T95S3QxL8
 c5rcqmZ5xWZQTCPKI1564UwnviJyvbECSl0evQ5aqkOKS34UhRRsT6tOGjz/4gTckHQCTXh46RO
 8biE9LHwA64lW7CSWDSqTpy+tGx52zT84OZaxogXBW+iqOCQMVxCiWg+PK+d1hJ+zL/fD9RigrS
 YZNe9MPzZnQ1wi9IZqISxItlt5ZEwInbDkHCb9hlmjMqTIIyXbWDH49NKDztVsre8PoOcq5s
X-Authority-Analysis: v=2.4 cv=cNrgskeN c=1 sm=1 tr=0 ts=68260bd7 cx=c_pps
 a=zzjaJ2HwkiRAih7KxKuamQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=8AIfw2Nou5Z3Evfhx1sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2ZN10uBONkLsD1MzcKv92s-HtQBxXs7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

The series contains an implement of a vfio-user client in QEMU, along with a few
more preparatory patches.

The vfio-user protocol allows for implementing (PCI) devices in another
userspace process; SPDK is one example, which includes a virtual NVMe
implementation.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been tested against libvfio-user test servers as well as SPDK.

A previous version of this series can be found at
https://lore.kernel.org/all/7dd34008-e0f1-4eed-a77e-55b1f68fbe69@redhat.com/T/
(I've reset the version as it has changed significantly.)

thanks
john

John Levon (25):
  vfio/container: pass MemoryRegion to DMA operations
  vfio: move more cleanup into vfio_pci_put_device()
  vfio: move config space read into vfio_pci_config_setup()
  vfio: refactor out IRQ signalling setup
  vfio: enable per-IRQ MSI-X masking
  vfio: add per-region fd support
  vfio: mark posted writes in region write callbacks
  vfio-user: add vfio-user class and container
  vfio-user: connect vfio proxy to remote server
  vfio-user: implement message receive infrastructure
  vfio-user: implement message send infrastructure
  vfio-user: implement VFIO_USER_DEVICE_GET_INFO
  vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
  vfio-user: implement VFIO_USER_REGION_READ/WRITE
  vfio-user: set up PCI in vfio_user_pci_realize()
  vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
  vfio-user: forward MSI-X PBA BAR accesses to server
  vfio-user: set up container access to the proxy
  vfio-user: implement VFIO_USER_DEVICE_RESET
  vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
  vfio-user: implement VFIO_USER_DMA_READ/WRITE
  vfio-user: add 'x-msg-timeout' option
  vfio-user: support posted writes
  vfio-user: add coalesced posted writes
  docs: add vfio-user documentation

Steve Sistare (1):
  vfio: return mr from vfio_get_xlat_addr

Thanos Makatos (1):
  vfio-user: introduce vfio-user protocol specification

 MAINTAINERS                           |   10 +-
 docs/devel/index-internals.rst        |    1 +
 docs/devel/vfio-user.rst              | 1522 +++++++++++++++++++++++++
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/vfio-user.rst     |   24 +
 meson.build                           |    1 +
 hw/vfio-user/container.h              |   27 +
 hw/vfio-user/device.h                 |   27 +
 hw/vfio-user/protocol.h               |  245 ++++
 hw/vfio-user/proxy.h                  |  137 +++
 hw/vfio-user/trace.h                  |    1 +
 hw/vfio/pci.h                         |   16 +
 include/hw/vfio/vfio-container-base.h |    5 +-
 include/hw/vfio/vfio-device.h         |   15 +-
 include/hw/vfio/vfio-region.h         |    2 +
 include/system/memory.h               |   16 +-
 hw/vfio-user/container.c              |  348 ++++++
 hw/vfio-user/device.c                 |  389 +++++++
 hw/vfio-user/pci.c                    |  428 +++++++
 hw/vfio-user/proxy.c                  | 1314 +++++++++++++++++++++
 hw/vfio/container-base.c              |    4 +-
 hw/vfio/container.c                   |    3 +-
 hw/vfio/device.c                      |   57 +-
 hw/vfio/iommufd.c                     |    3 +-
 hw/vfio/listener.c                    |   35 +-
 hw/vfio/pci.c                         |  163 ++-
 hw/vfio/region.c                      |   10 +-
 hw/virtio/vhost-vdpa.c                |    8 +-
 system/memory.c                       |   25 +-
 hw/meson.build                        |    1 +
 hw/vfio-user/meson.build              |   11 +
 hw/vfio-user/trace-events             |   18 +
 meson_options.txt                     |    2 +
 scripts/meson-buildoptions.sh         |    4 +
 34 files changed, 4753 insertions(+), 120 deletions(-)
 create mode 100644 docs/devel/vfio-user.rst
 create mode 100644 docs/system/devices/vfio-user.rst
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/device.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/proxy.c
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/trace-events

-- 
2.43.0


