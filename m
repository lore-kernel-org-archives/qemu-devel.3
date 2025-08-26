Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610DBCA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqp5r-0003KI-R3; Tue, 26 Aug 2025 04:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5S-0003GK-KY
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5J-0007Vi-EE
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:25 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57Q5jMWT1785161; Tue, 26 Aug 2025 01:31:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=p1Wv2Dd2E2xfw
 CEIfuK3HjpE4Z7QnLzSoEp590dFBdc=; b=1sV/djid/HqhQl0szsEIdhlQNfGAl
 rPz3+pTq4FZU1kThkS8mJux8GmWJfR5ktHDVamS3Q+LnE8LCbmuVpe8wR1G1NSKX
 N7+/F85jz5RvwQl162RoCbFNYFAabWe/gCK0JazCLOb7E35tuxqkzDm5nYAA/wC9
 5/fXO+zxpURDg8vbFUHII7FYal7tmu2BtHAo8ElFnUOUKv6wnRfzCgIpITXpiRjy
 KZcewasVMis3GXV2Yhi7jD8ClZnagFh3YxVwL0HDRxs5xtGR/gkpi+40Om88nncx
 H01Ls5M8hLScupD95DAFiYobfuRzf+29V9PMNR3sbHFjaKWACAIX+yDfw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48s7280bc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 01:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yACu3NHZA8959YpnddrqjhhaCz3xG3zPZR1jLJAJrI50cqtKUb79IO8fCk1R6EiiLeyCimGRAX38do+9IK1G5RxrCuHnTSWl44vDFSpCWm5SdeSgUGqsmUExng+Y1pvf44BMYIz2+E7pKSpSBfAuStzwhUoJ5l7nhNMNpJ3YhyT+d8e7Bc2X74rOFl3WsmErjwiq8qPrAmA3w7D57t06zuJc1pQKWatIqu7W1KdpBaXFHyxWT0rETqwyBUKiz+fONppMXIknTsIQDhqulTnYNa2iCnke5hS+k2pb1FTlkiOvLhEgtJwaH9Lnl1UqElbpRjR4tDXj4UTU33jb2uXrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1Wv2Dd2E2xfwCEIfuK3HjpE4Z7QnLzSoEp590dFBdc=;
 b=PwgP+t0vq2sB/CygIxnxc3GI6qlgk0j2JSrQw/8W6yyprtLltT7cM0azmlKLs9HNycjauA836LT5OGwC5B0D+/vesSq1t4+gFg69LW+tWrscjijBAjhqCCyZX+C2a2HQtaSJMH7Ia7L6WW9VXOttIibAIcXpSqzCyYRvgoStrdyCGU1conkwVL3auegSZaMpoyAQF4fs9AU/v0SKi3stWdN92ApOHIkNd67QtElkXZjS6aPNxgifdTRWMcNNc4faf4FdThWHk5H3eBppZ0kf+8+bWCXLdkPOtO4VZNKPDtdDNgT+RMiyMhCBNt/+5MrjpBTJSkEMmpW5LJcGDglClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1Wv2Dd2E2xfwCEIfuK3HjpE4Z7QnLzSoEp590dFBdc=;
 b=kXAViLPK/D/78wXs8PUACH3mffNyepJtEPdYbFbQsyDI8J8P6+MF1siImeO/Pdfv4uow5XlnVYNZULDlWRAKek1lJneU7gGm68FLXzcwhiOlqr0RPhO+P2/rtyygCwjo/APsJRWAEcw3+jfPjXn4ZHO95O3rG35wGR0S/FPwmoMUpXDpBWTZxiICRPcqZm7EfCqVM9lkTxRvjFl1jXK4srlN0fElvpGD6IMGHHty0WPgaAdwLx1BDonN2GbufDYhwz//JlB65qdQCbQvDo0f1UCxIXLAONoa9pjhPqNB1+TczZ6IW5zEAu08pedWC73Yvo+4lAnCIhU1OXLz2Cu8tg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7404.namprd02.prod.outlook.com (2603:10b6:806:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:31:04 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 08:31:04 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/3] vfio-user client functional test
Date: Tue, 26 Aug 2025 09:30:57 +0100
Message-ID: <20250826083100.1058305-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: d36ca821-15fd-4b0e-e5fc-08dde47ae52d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUg2SDdNMFNZM0U5Ui8yQ0NHMTQrb1lJdU9xaHFTT1M0NmR2SUJ4UWlmTXNF?=
 =?utf-8?B?YUNJejBiUVFGQVJmQm9ySnZBTFN2d1gyNlhhdlFpZ1RQSloxbzZrbU9mYzlx?=
 =?utf-8?B?S0F4cEhHbE9wZmM3YXpnSUF5TG9kalBMTWw2Z011dzdHeVRRR0JENWxTYjZI?=
 =?utf-8?B?N0NHSTRnNFo3NXJMby9wMEE4RHNnRlMyUXkyOUJZL09DSlNHNjJKUnpFWThC?=
 =?utf-8?B?Nk5xQTIzSFJBMDQvaFNLajcvZVlpUitKTkRhaDB1OWVUcUtOb2dnMWVlUnhq?=
 =?utf-8?B?UjBDOVIrZnNLUzdRMVRXY3A1dFUvMUtpQTZ1bTRac0MzZlVPb0MrYm9pSU5J?=
 =?utf-8?B?d2ZjSk9iZ0w2Vm9FK0svY0hLUEd0ZHhaMjJlM2lZQmtVV1hucG8wVGFBdndq?=
 =?utf-8?B?YVJmZHorQjVsdS9vM1Viemx6dklUdjE1a1JHL1lWYTY0S2REb2syaDU0M2Zo?=
 =?utf-8?B?ZVJ1ODBibXp6U1daV1AyblJuaHkrVTRydTBhM2IvZmQzWXZIalNtTDBDY2tz?=
 =?utf-8?B?TG1iSllMeWUxMkV2UmRLc0MwRlBNM1pteG1JUGxkaTNKeVhvazRpbHpMb0Y2?=
 =?utf-8?B?cFNwcHBxUEl6cGNFRUdJUTRteG9KNGoxK0FKSE40Z2tTeHZhM0pJM2k2VXk1?=
 =?utf-8?B?SjRiWC9oUFVTZFhlTlFueDcrM2loYjd5Nlo2cHJFaTJxOFJZMkU1THgweGtN?=
 =?utf-8?B?WGd4cndaeCtZKzVVUnpkMFNqRmIzQlNLWEJqaW1MTWZrTDF1V0JIUzByUlB3?=
 =?utf-8?B?SU1SRTFUOGlDcjhsTFBCSjlTZzI0RDRUejR0OXZRZ0xXd3VwWEF3aG8yWE1G?=
 =?utf-8?B?alcrYWFLVWlGK29HeTJsMGhobkZxYUpDd29ZK3MwNlRmYnlwSGI4di9kaVhX?=
 =?utf-8?B?Q3krSndYSmZHNHVKR3dlekFWUk84SG1YN0E3ODJWNHBxMTQ3WmxkL0N1KzVw?=
 =?utf-8?B?VVFOQjJ3aEJ0SGxBM3ZYampzRzdYMVoxSFZqQmtEeXRSc0thRldZbXpuaTNE?=
 =?utf-8?B?ZWZIZ1VIK25XNVJ6dDFqaFAxUlcraWovWmxSN28wWnRxTTVRYTBZMmJIL3I0?=
 =?utf-8?B?Z1RSVmNuN0FsamdWM1drYkQ2Z2h2ZEdwb2ZvSXUrSi81MmZPVDlnT0NqK1J3?=
 =?utf-8?B?NlZ4Z3hDSi92ZS9OTExFOVdxRDlpQlBNK2JUSWJNaVpnMHBLTVNlZ3BONGZD?=
 =?utf-8?B?Vnh3N1pvbHZyR2ZtYVZ0VXdiMVRIV08wcXBlQ1JRTkhwcDE2UDlKRi9oeUVr?=
 =?utf-8?B?TFJNNXpJVEE0UmVRM0lRZ3A1Sk1qU3JSZzRVUEFSVitJMHRRQmg4MFRxclJh?=
 =?utf-8?B?TFZ5ZEc4RzhVSmtGaGwvcytpekdrd2MwYksvUTFEb3pscDhYc21xOWZ3OG9s?=
 =?utf-8?B?SFNpYW9VWXJlRjI0cjBPN0FUZ1Z1bWlZS2dTMkxmNFNxcjZXOUxxbE5wVkx4?=
 =?utf-8?B?ZU40dEZPS1UxbUNDUjhIdmRTeWFTRG9wVm5uMXkvVHFsQ0oyMEJhbVFNcnow?=
 =?utf-8?B?dkMzN05xRGFGZFNhRzRkSjJLMG9RWGVPM000dXI4WUkydGpkVk93dVU3cE9S?=
 =?utf-8?B?MDljMXRzUEhIc2w0Q0UxRG1GOWdtYzlYOWVFN0Q3d2FqSVI0Y0ZVUDBnYVlO?=
 =?utf-8?B?Wjk2N0xCZitOeldIWktFNlFlVDVHdWJ1ZFI5RGE2T01ML0NKQlp1R3o2WmZ6?=
 =?utf-8?B?WC9hOUNWSk9SV0xqMndZaUYxQnE4eEY1M2V3NHhZZXVuS2x1ZVpYeGJkd3lJ?=
 =?utf-8?B?bTNKYUZ4djVVTzlMdGpnRUxtWEUzMDlveW5FalQySkV0TDBaY1FZajRidFV3?=
 =?utf-8?B?TmF6NHBFbmxOekN5TUxmeEQwS1dnVmtLTGdRY1RCRG5kRzNPd1VBb05IbUQ0?=
 =?utf-8?B?TVJoSjJQYVFjaW1HeWJkT20rTkVMOUVpb2w5MHd3TnMwNXdnNHZLMG56Tzdm?=
 =?utf-8?Q?v9ZJGbBVC90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQ3eEpvbEFkMENlZ21PWGNRZ0EvWnB5R2NMeXV5aEJoMnBxUUJjQzFOTUlE?=
 =?utf-8?B?WWdVTHppWE1LS2xwNTQwbGJqOGFNMk1qTXkvNGNzOVVlSitkMFlhdzhEazNS?=
 =?utf-8?B?MnNPRFA1V2NrcFp3Z2I1U2RxejlpUURscUpqVFZMd0FwY2Uyc251NDhKaFMw?=
 =?utf-8?B?eGtGV0ZXOEZCaHRFL3FRWU9VSzEyTUZOczVNZXNYVVBDQ1pENXNzbmtZQ2JU?=
 =?utf-8?B?ZTNtUms5OEVuTjl1NWZSMmFyYTQ2eDViZGxKdTFzRDJFalp0U09wOU5ETTU5?=
 =?utf-8?B?S01wYUZSQjlWSytBbFdZejhqVUo0RXdtMHJWZ2FqY3FuZGpYWjUxSkVEZzY4?=
 =?utf-8?B?eE1iMWxiY1Mra0JVN1Q2ZmF3VFN1Y3Vmb1gxVHNXMGQvcFZpMk5pbFlQRGhK?=
 =?utf-8?B?Z0E1SFhqaUNYalJwTldiRE5PTkVlV2J1cDZjRXMwODUvU25YbVpRaGMvYmt4?=
 =?utf-8?B?N1U5SnFLTUpMZWlSMUtvQ1BMa1d1WHZ6bnd1bnVEekU5dTRvaUZKbzRrOEJU?=
 =?utf-8?B?bEx1SEU0b2U2eGg3enAwZU53elJWZlBieU8wWUdzelF5MUdnZmdmNjY5bE9W?=
 =?utf-8?B?L1oyY0VLMXdpQXFmM3ROa09hVW9hSFV5N0xaYU9Ub1d1a2YwMFJ1ZUh6YVhy?=
 =?utf-8?B?aXRYYUVuUlcwVUIrNUVzd0l0RG8zTTI2NDZmTHRKbW5ENGxod1UybDFoNk5C?=
 =?utf-8?B?YzB6RE9wQ0w1MzZYOGxaVHN0dmludUtTSGZrV3k5OTVPK0FBaXZpQ055MzZ6?=
 =?utf-8?B?bzZUbWY4N3hDZ096a0ZKU2lNclozNm1ZbldDNkxSVUhPSGg5dGVNY0JaZG1R?=
 =?utf-8?B?bzNHZnBiWEpNdTVXM0pqK2pXRXBWOVF4S2dab2dkRjlZcmlxZnRXQVkwQVkz?=
 =?utf-8?B?T3F1d2drVlNiL1ZIQ0tPQ0trWHFpTzY0SWNLNkpFbGdwRUJrQWdhRUVTbG9Z?=
 =?utf-8?B?bzdNV3BpRjFJYjJaWURzTncySkllTG1DZG1CUUtSYzRqa3RoK3lQZ01meHFM?=
 =?utf-8?B?U0hncGdrUFRFcHdaRkhNbWoxR3FIc0dlWnhPc2V0amNuTkJkdjNmTGhiOC92?=
 =?utf-8?B?MFJYYlorNGh2UkpURkx3VFY2L3ZiVFNkeXljTDVpSi9PUmxLK0FiODgzRE43?=
 =?utf-8?B?eVZ4bXdlOTNhNkRQeDlXcGJ5Nit4QVNoQkxFL0x5QS9ZZXh5R2twdWFtTFpt?=
 =?utf-8?B?d3RkMVVUOGI4VGxyckJjYXBGQ05iMjNLcXRPR3JCU2RacWN1Wm9MalRPYXBK?=
 =?utf-8?B?Z1BWQkhvWjJ4VlI4bFNlU1k1bXZGRHhvTUNRUW51d253RVdtbnVPTUhaTFZC?=
 =?utf-8?B?bG5zeERKRktUMUJUWUsyUnRoN0dKYU83Y21UNlJJYkdaNVlzemxTZmVyVlhE?=
 =?utf-8?B?dENIaW9vc0J5SmllVjFvY3NUSklIQlF1RzRoWE5SLzlJWVJGQUxqT0RMWDBs?=
 =?utf-8?B?UDJPTXNlbmdrOS9SM2N0QzJiRzRWdFdqZjREajhqQTNpRmpjMUpNSTlsOUJs?=
 =?utf-8?B?Uk90M2dFdzRWSjI2a2dLWmVCZisrWkpLdmVEMWxueVpuN1F6TjhSdnkrNHVH?=
 =?utf-8?B?blladHA5ZmZ0OGJqUmtPQjUrTU1wVXdZNTUrT1g5dC9mV01UeGxpd3NnbGhE?=
 =?utf-8?B?alhoNkRDck8zSmVPNGFhdnBZUFFkVnVEQ2RldFdMV0ltc2JMa1pCMzltRkJx?=
 =?utf-8?B?RTdBaW43cTF1cExwTFZoM0VsOG5DSWpZbGgrRDdzWXZsck9ONnhoSlkxWkEw?=
 =?utf-8?B?NXZxVmUvY2x0cnhtQWk4Y1ovbUZMSVJEeEg4eWRUcnVqMW1TaHRENzR1OTgz?=
 =?utf-8?B?UWVhQUlqVDZ0Y1E3bWZWREhoZ3BMWm15RVRvWFdiL09jWExRR1hWUjl2Ukhv?=
 =?utf-8?B?endxY2JwaVU3WWkrRFBUMUZvTGpHZU50Q2ZhMTRiS29EV2NyNHNWSURlRTR5?=
 =?utf-8?B?ZDYrNHUvRStQNCtXWWdYNE4vM1ZwZWY2aHZCa0w5cFdmOTJIbVdta2FMR3BL?=
 =?utf-8?B?TUlLdmE4bVBOeXU1ZEQ5N2dDaWlmZTRETDhBN3dONjRRVTVoQkVMUkd2MGZa?=
 =?utf-8?B?bUtMQ2p2WisxVlh3THdBdU1lakF6c2NDT3lhRmNIMUdEajJhdFd0NDBidTFj?=
 =?utf-8?Q?HDVr6dym3Yt9fL4Ny+X/qZ/eN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ca821-15fd-4b0e-e5fc-08dde47ae52d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:31:04.2619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYlgsXOgXlGWXHzmUfE63Q0Fo1YK+8vvB3h6KXBFDRpIC3y81BLCMNNhoDXidDnff9sPPpSKEqBq/PNk4fLuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7404
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA3NSBTYWx0ZWRfX6aS9C4t12wte
 LQKWf+kzL8JkvUb2I9a5d77Jll/pO0WPj51PxCpdb1l6c7graIkdN6EoYxwDxdKLgJlH8mBn9rc
 uPlhofLnEH4iC/hWWgyyRBjC3TPjixyEAYcDVkp/DjanTbSS5puXDxJMaEGOzY2929SSQgfAAPM
 1tBgDCSSUQtfouLuE/RaZ9jE0nU0Yj8F+2yCxcl25Vhae13iimSwdC4BRCkkesyoIhEzBnGMX+q
 CoXODnGQ0H/kO8uPXoMpqm9pGKmbAkMhCcB8tw8bag1SN434kfLTfZmIqRdqdioYzi+4tWvRGtH
 q70BuFyw9POohVpvTETKvQ0pXx4Sli3balA7qzuEDI06VuhbHkMYmx1Jm5W8zw=
X-Proofpoint-ORIG-GUID: T182QMdji36JySklstez6c0xpwsjBY5_
X-Proofpoint-GUID: T182QMdji36JySklstez6c0xpwsjBY5_
X-Authority-Analysis: v=2.4 cv=Ae+xH2XG c=1 sm=1 tr=0 ts=68ad70ca cx=c_pps
 a=2CGiMo3D+WyQmyd9lmq5eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=GkJwjvidrGdLuGONZSQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add a basic functional test for the vfio-user client, along with a couple of
test framework extensions to support it.

John Levon (2):
  tests/functional: return output from cmd.py helpers
  tests/functional: add vm param to cmd.py helpers

Mark Cave-Ayland (1):
  tests/functional: add a vfio-user smoke test

 MAINTAINERS                               |   1 +
 tests/functional/meson.build              |   1 +
 tests/functional/qemu_test/cmd.py         |  65 +++-
 tests/functional/test_vfio_user_client.py | 407 ++++++++++++++++++++++
 4 files changed, 462 insertions(+), 12 deletions(-)
 create mode 100755 tests/functional/test_vfio_user_client.py

-- 
2.43.0


