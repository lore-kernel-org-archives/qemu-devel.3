Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1466C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9b-0002yr-OH; Fri, 06 Jun 2025 20:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9a-0002xX-U1
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9Y-0006PH-R8
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:18 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kw9UM017955;
 Fri, 6 Jun 2025 17:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLN
 GY=; b=0u55zSDIokWCwoS+LyOLpI/ieo13hQyUeKoIZjwcJpRF6LnL3+/A/YY1G
 WLKmja4IlnirIRYih8w13vNYrKiNjb18MSS7vvuYuHv8f3vJNflz5/w4BORQ1yq2
 R1rwOhEdsmIKovy4mNUeD06X1t4wXMCFw85v1T9uAQdVfj8eJxHQrvTkqWLTjXyn
 Kyt91PtyvTNcK0WB32MSRIG0b3LXVdVo4UQLDx2bmKKRO89aPYOO6fRAbP3qZhwY
 /Pvzf1ZkOK5LNhnOqc8okBdzXo2o9yly0WNmuTbb8du/BJFCjyMQAptpaC0BmbAO
 lm/rGTbxS39xWJPA0Uw1hYDuQVJow==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OformQ9m759/wjPfyY/jia/KJxBr+Yb0NByc4j/ZWPiA8IhuBD6mPFGU0ep9guuso7ay017HhqHMGkevjSB+lFAq9z55dSt0Jnh2onU+jg8g123RiqHz9RIOSN5m73oopS5/ajBItbbdDvv677bUg8UAhewd1YrgYgkAFpcMHLu3t8++YhreBtZ0Bmjvs46xKa0v+JglFTC4bCOC+A1X8MKT7Ccoj+tp4LIU5oFvOKHIeCICNscvbF2RYxixB8S2LXFeBfLC0QxDrvJWoOwhWdkycTVakLnYHdk0KcGkRimm2SERXGMW6N3k/o95O+sglQ5s1SQ86o1fec5N0NUXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=CFM40aVJAJXz2Q4ufHJrCiKjguMc8yaScJQQkCNwce55lj7sGyw3qu4WPrANlVkGXk25Zl6V/QWNufbiYTovhO4DNoSQ1Rvzy/ftWWaSsQ/fr8Jan0qb1NLMrW0ik9yaFsn5yTE2nfvhVP4X80m+b/5x5DqMDSVr2IX8SMzDzI8Hn/zfd524lPqyRx/JK8FheiSt8rCnnOk57hhGnffyqWk2AR62Ym4uu2NA7r3hYbr9XuxQLyYdYVnQE2/6IjKG6ZjLc9q8ySNqSu0UlBwDIdmwIRks6aTktHK0N8evz7wfClyYyPQK/DBeCPOm+DtmPTaobU8wo9glXyZ/s3yoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH6f2tmI7ATg3KzwM9TyWxj1523guBD6/z5O7cFLNGY=;
 b=n/Q5aAw1WscJBEM6HnyaB03emGIfmt1YKa7roXfz3munimJvu8tW2O7K8ryHxuE+txtq2nxtb8Vl5EEGMRIKkSWNyWVXhaSKzBfFYM1fopjR/Rls/7cogB8wN/g+FO2wRzxJwGjjwr4y/sRwiNyZmrnRB14QbDqy3ahHScDgObSbJVFVwV89sqt7fVU7PjGvXMvTZ0aK4QwWP0xSBbPk7m48kDHNXXXwzUZRRWPBPr3ZuET0Rc/KyFIlJxRCtvfkykG9usEtmafdJVunxlk4pkTg3rYEG31MR+HNxMLo/lhZYwAp3u0uTuLhLBfa/zKxUsamsaPNbPeIZW62E7MxbA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:13 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:13 +0000
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
Subject: [PATCH v3 10/23] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Fri,  6 Jun 2025 17:10:42 -0700
Message-ID: <20250607001056.335310-11-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: d847f374-0dfa-486f-dbc9-08dda557d04e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1M0ZzF3QVlLZXUzU1pIZ0Rad252clFqbEJmSkU2REdMOHpjU1RZT2c2cTNr?=
 =?utf-8?B?WENUMTkySmllWHRaRVF2d0ZlT3NzcnlEREh4dXd4TnNCZnUybitRbG5nb1p1?=
 =?utf-8?B?ZlZNbGNvQVpXeEVJYnAwSHJxZDhGVkRyTG0yQUNVaXgrZFNzWWJ5TXZTM2NT?=
 =?utf-8?B?RVNRMkhIaGt5dmdOY1owYUNNKzZxb2xKL000a0pWMjVManJQUUx6b2hWM0g2?=
 =?utf-8?B?TVhLK0NiY3NkY2gxY3ltRzZBdC9rVWxHaHlkM0JRR0hjVUZBNlRURnp3Z0c4?=
 =?utf-8?B?LzNaN1pKdXMwclIxWXRMQkJ0M3ZBWlBnbDRzSDZjR0V4dDlQSWRiRHc0T3Rj?=
 =?utf-8?B?Y2Rzd3VURVhpUDN0bk1YNlM3cTZRczg2WGFoS1RySnIyUCtid2VJSHRVRW9K?=
 =?utf-8?B?Z1l0akdESkVkRDdVVzZCbEtDQUFmaCtwMno1UjgweS9taVBMN0xtMENOVmti?=
 =?utf-8?B?MnBoNTcwRmRDUUw5dU5ZM2hTMGpSMW5scFlNbU1vT2Qxd1l2Zy8xVkpybExt?=
 =?utf-8?B?TEhwUU1wcDhSdlhDSno2TW5UdlNVOGJYVXMrZmRZZTBjemRVVlVNbEltSTM2?=
 =?utf-8?B?dUpoYm85MkVoU1NvcWJXcGlNd09KM2ZxOUd3TlZPUzl4WmdSZWZCSG5xM2NQ?=
 =?utf-8?B?UkZrbGowNGF0NkRjekNwaHNLeDlGYW5CV0UxQWRZUmRFaDZiU0dkT2JFT1h4?=
 =?utf-8?B?dWN5T1QzR0pyWXp2SWYxakVycXh1K29DQnJBWC9rMVVCTExLVmdJeDRkNmcr?=
 =?utf-8?B?WGlVRFpqMVUyRnlBZkVYdVFNeFBQcWQ0dkhMUzNUVWJUK2RlWG1yd0l0eldZ?=
 =?utf-8?B?Z25TL1ZUYWJabnFOMmt1SUdsR2s1VFo5S2dZczZRKzFsZGpvRWxpWDVHSk9Y?=
 =?utf-8?B?bUlHeDZGNXE3Y3RZd1ZtUXRDVE01bWswZFJMRFg5RVBJR29CdXpMMUVKUUNi?=
 =?utf-8?B?RXlxVkVEWDRvSmhER0lPNHVkT3JUS1JuRG1DMlJzNG5FaXRRTzNOdUYvZkN0?=
 =?utf-8?B?bVkrbDNITVBGMnFwK3NBOU1wU21NaWRDazlwMTVLREpvN3E4TDBmV2Zqem5l?=
 =?utf-8?B?c2NjZCtFcGtod2FZak9ITEFBci9WSEhDSWNzSW56ZzhPeW5NUjBCenVTRStM?=
 =?utf-8?B?YzFtZmNmeHlINnFycm9OMm9TUVJyL0NGV3R2cEZVc0RSd2RIZEtMQ21hVDY0?=
 =?utf-8?B?djFKQXlvS3RGSFNxZjNOdkZnUFp1OE9oQ3NQYkpxY0lrbHlkWUpyNmM3dGFv?=
 =?utf-8?B?Q29yVlZucW9ROVFTMGlKYUxEd3dxcFA2ZmJ4TE5kRjNQNnhJMFRKWXpqVGF3?=
 =?utf-8?B?RVEvVzFNZ2xFU3IxaXRQWTdadzl2K3lVTEVuaFh4NjN0dUdzUWlrRWlUeldu?=
 =?utf-8?B?OXpNakJwSHpiZ0NCM2NyZ3lmQzdjOVVGVUMzTGUvd0xZWlYvbGZ0bHFZUEJ4?=
 =?utf-8?B?VXZ2UUNHbElIWHE3R1ZickJpaFo5YWpUeVJnRVp3N3F4cndjRGJ6QmpUL1l0?=
 =?utf-8?B?TS9MSTZxZWtMVUEyajlmM2drbGFOODZCWWM0Zy9RU28rQTlDalZWWEhGUENG?=
 =?utf-8?B?MWFJc3FGdDNsd3U3eWgzQk04OTIxSVBnNDZGMjNlYVdyOW1FVnZKdWpSaWhl?=
 =?utf-8?B?SllIYW1lM3hESUkwcDRVcEhOanhCcWpldjF2a1ZPNG16MzM1V1BOWWR4MnMw?=
 =?utf-8?B?UU1yYWNNanhLQUR0TWJZeTdPbUpKb1JXMWFIaVZwUlRMYjV2L0tUQWN1bEl3?=
 =?utf-8?B?OVBRU1Mzei9ENlViNHdDQ1BmNjNiY2NNR0FpdkhTRlpSc0t0R0NvTWh1WUFm?=
 =?utf-8?B?MHRrcUM2RGRyNkpVaGVZRXNza3BwTDhLSVQvZDhUR2psNzZodkZJQ2t5dktk?=
 =?utf-8?B?dVhnUExaTWk3c21FUjk4ak9sdlorOU84MmlWWXZiRHlINjJHRHo4bmlTQ2tu?=
 =?utf-8?Q?m+9DRQSNxt8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEpvS2ZYSkt0eG93bldiQkhLUllGNDArZFUyenVZbDQzaFN5NkZyNmthWVhJ?=
 =?utf-8?B?dnN6WlZOeUFtWmVzQWZ4OThpTmFiZWpjdFI5VkNxUG1GYjAyUlV0dGNqWmFj?=
 =?utf-8?B?UFB2Ujk2UXdCdE1YM3NYNjJGUFhBN1dnUCszSW84MDBOb1NJVkc1WGZpMzlt?=
 =?utf-8?B?aU9lYW95WnBRWGNzbGllWVNIZ0lNczBFWXRXTDVZdDRvVWNOSEJLMEtBQ1hw?=
 =?utf-8?B?WnhZQzkraTJJV3hKMGx6OWFSUEVNN2M1MnVWOXFiMHE2WHRGcFlVaTVPSEU5?=
 =?utf-8?B?Q21CdW02TDYrU2paTVhEeEd0VmE0NEZEOWtubkpRMXMrbVVrbG54TW9sR0Y3?=
 =?utf-8?B?YXpZVWFwdllZejBmTWR5VWFOYzFwaHluakQ3SlRJSmNERFV6WFpUSnNGbVpj?=
 =?utf-8?B?anl2SDNRZG41Mmd2RTFzRnZVb3Y5TC9XTm9PZnIzOTMvcE5XSTNlOGV4aXpm?=
 =?utf-8?B?ZkFKRzBVcEJ4b285cHZRMlB5OEpLb0p0ZEQvc3pnb011azdxTXcxaXlLZ0tJ?=
 =?utf-8?B?VWxWS1NQYkZQejJiaGhYaW1ybVlVejJvMVZWcTYzUUd6QjhGMktVY3VMcm9Q?=
 =?utf-8?B?S2VpUG9Uei9xb25xeVdPS3RNdGhRc2pYYmNtcmJEYjdJeGtYV2hsZW5jUVVj?=
 =?utf-8?B?RStHc2Y2L29vR0dVS2E1UjBqTTRTcFNndTNwYVlxelVVN09qTFZoZnljNml1?=
 =?utf-8?B?a0xLQ2JtVnduditSMy9lSWZubjFyTTM2aFRQZnREeWxHM1BPTkRjNUk3aTAy?=
 =?utf-8?B?ZWs1eWJ3clZJbUZ2cGY5YnYzcjA3WFdqNXlhY1RuMW1IQ1BvTDJKempYNkJL?=
 =?utf-8?B?c0czbUhhVVp4a3J2QndpVitPU1NjS1NNS0F3elVOcFdxcUpHNjdaYm9zd1NF?=
 =?utf-8?B?RnRENnZiaFF5TWdkV1c4b1dkbHNsK0w4OXlzK2JXN1lTNkFHa1YyMmNyU1FI?=
 =?utf-8?B?emY0cURuY29HNC9MNTJQQmRWcnNOQ1k0NjZUMGk1TGZCOGJodEQ1dHE5RTlV?=
 =?utf-8?B?WTZEMFR2UEQ4eWRvUlA2T2FtZnJSSFBCM25jMWZTa215WHJCQncrR0lGZENM?=
 =?utf-8?B?aS9OcGZRUlFkZHp1aHduMVJLS3ZJVCs1eWlJb2lxODhCd1pVaHdlL05wUnU5?=
 =?utf-8?B?R2NFd3VkN2VUZForcGI5UU5LM0hSNnhXOTlpSkh4SlpseDFtWlVabXJRVnl3?=
 =?utf-8?B?WG1jeGxaMThVNkJPa0ptZit0UWVuK2NkZHZmcExYNTBXbkJxazEveXFJNm5N?=
 =?utf-8?B?eExmTWFDOHpHS0Q0dEc2ZklWRGpCUzVaQzY4RXAvQnhSVjhBY0NHUStYRitV?=
 =?utf-8?B?M3AxOXhPZ0t0b2VLY3JHSngrMlhKMjJGZ2NIQXIxeHRBYnVldU1BUm83RmEv?=
 =?utf-8?B?Y0k0cW5aZk5tZEdzeGR2V2F3alNSOEh6WER0UmRjVWRnamJ2dnNncFg2eEs4?=
 =?utf-8?B?VEw3SmY2eVppNDBIWU9taXNQTVkwRVZEZFdJckcwV0NBUG5jNW5WVXZNS3U0?=
 =?utf-8?B?RG4zS1QzMmFoT2FWRWZ2M0hqcnBQMEdOeG5CdzNuek9YdUlTNElIM2d0amxF?=
 =?utf-8?B?R2N6T2tBMnVaNGthaGpmbEFhMzdZM1ZTT0hwNDd0K01DaVAyVnV3My80OWxR?=
 =?utf-8?B?WXN1VGdpSGc4VmhZQW5BWVIrYmxwa1k2N05ETGpCVGNpclBMNll4dDFMUXBP?=
 =?utf-8?B?bEl0Z0I4UTk4WXJCOGsyNmxZNFdySll2b2l5ZklhL1FVRUZUdy9OczMzYlFD?=
 =?utf-8?B?TzBqZC9YN2ZzNUZRRlVGWld2RGdCd2VTd2pjdXJrcTFSeWNTckJOSkQzb0wr?=
 =?utf-8?B?eUZ2eXdzOEk3VkVXYVh3WlBEWS84NHpkMFFrRklBalZXd0RkK3d1R05NakxH?=
 =?utf-8?B?SHlsNnFrNTIrdUFNT09UTkNycTN2ZTJoTlAyc0VSNVVqVitLc0pTVHJmeFVY?=
 =?utf-8?B?cmpPcXA1cnhGVEt2MVlZTk16aGtWMTlEenVyMVI5ODFwTnBISDdqQ2JEQTdU?=
 =?utf-8?B?bng5MUJ4U0ErUDVyUDFJWHJrSVlqOWk1ZDlLZGRObGU0aGxRaVpEQzVlcVJD?=
 =?utf-8?B?bm9lZXQ3V1hDUUlhclk1YzczWDBPUVJoRVpoYVAyMnk4c0pwVmJwaDM1b3Vr?=
 =?utf-8?Q?0V1CTUhWak/t+QVrzRF+aoVVa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d847f374-0dfa-486f-dbc9-08dda557d04e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:13.3411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gbcWBx0lQ/4ly+88mnj/maIwpwvRV7AIjoUWuobvzAx8iqKZEQmCjwwtF3cD9m5fNRpQklXiw1Wtm0KlgFV6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=684383a3 cx=c_pps
 a=Cb1kLmlYO8D/Z2wQFUco/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=9e9T-0rTUHAn1w8HAtsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wgSlH6HZY1mVlena1nczi9nohm0kaytw
X-Proofpoint-GUID: wgSlH6HZY1mVlena1nczi9nohm0kaytw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX/AcMiDzHkpaf
 qjdl21q9i8Fvp8mkE9np3hzqnLvAS+iGO2BCRnkS4Z8kOCZ50Di620aj3NESfrsQTks7xUAQmtC
 safxNepruNZC+9lrL/YWOpZAQNhUT9ZU9Eqo4j4YaOQRdaqHD/XkT4N+l3jfdDUJBIe/BxkGQ6Q
 3m1tsCYzn1cCz3EIh64CDSGT3ThNlMXTmUoFht1g8lslxDydtWISEUH0IWZjBJWcWKpyEy2721T
 6MdPTHvhqKxClJkXSwnqHKMadfd0hy6q7Ij2fsMSQdjiVuwVd/vpYhmgr48bWDx6cs0NFVaQovx
 QwgVfcmv7A0c2JdhtPD3fQ9C4bGh2WzYhr6hoGF7x+rG1dQ2l/Mu1UJbGTg/dFpE7NdJJ6y5cZ/
 6CJeu+sQ9gfwJZC7X6CHYPgd2hI4UhjSmTZqZp7tiqvMDtwXOBOc2hgorTsmjzqgP+QA7z/j
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

Add support for getting basic device information.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     | 23 ++++++++++++++++++
 hw/vfio-user/protocol.h   | 12 ++++++++++
 hw/vfio-user/proxy.h      |  7 ++++++
 hw/vfio-user/container.c  | 10 +++++++-
 hw/vfio-user/device.c     | 50 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c      | 12 ++++------
 hw/vfio-user/meson.build  |  1 +
 hw/vfio-user/trace-events |  1 +
 8 files changed, 107 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/device.c

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
new file mode 100644
index 0000000000..f27f26b479
--- /dev/null
+++ b/hw/vfio-user/device.h
@@ -0,0 +1,23 @@
+#ifndef VFIO_USER_DEVICE_H
+#define VFIO_USER_DEVICE_H
+
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "linux/vfio.h"
+
+#include "hw/vfio-user/proxy.h"
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info);
+
+#endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 74ea2a94e6..648badff46 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,4 +115,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 33e8a4d83b..9c6b2cdf35 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,7 +15,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
@@ -99,4 +101,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 2892845b4f..6f0eb86a75 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
@@ -144,7 +145,14 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 static bool vfio_user_device_get(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+    int ret;
+
+    ret = vfio_user_get_device_info(vbasedev->proxy, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "get info failure");
+        return ret;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
new file mode 100644
index 0000000000..e081033ff1
--- /dev/null
+++ b/hw/vfio-user/device.c
@@ -0,0 +1,50 @@
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/device.h"
+#include "hw/vfio-user/trace.h"
+
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
+int vfio_user_get_device_info(VFIOUserProxy *proxy,
+                              struct vfio_device_info *info)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_printf("%s: invalid reply\n", __func__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0bc12da865..34df9bba7b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -42,10 +42,6 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -613,8 +609,8 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -785,8 +781,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index 695b341547..19bdee688c 100644
--- a/hw/vfio-user/meson.build
+++ b/hw/vfio-user/meson.build
@@ -1,6 +1,7 @@
 vfio_user_ss = ss.source_set()
 vfio_user_ss.add(files(
   'container.c',
+  'device.c',
   'pci.c',
   'proxy.c',
 ))
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7a3645024f..6b06a3ed82 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-- 
2.43.0


