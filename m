Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5BCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZWU-0008Qm-4N; Thu, 28 Aug 2025 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWH-0008K2-KV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:15 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1urZWF-0003V4-8J
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:06:13 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S8hNHF1759885; Thu, 28 Aug 2025 03:06:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Vsf95LggOO6zE
 aDF9anVdAl1MK77HJPKehlrpULrUtg=; b=vwB5S2N4gqutA5YiJRNAfO5btlTbP
 cPSykkFypDKPZ/tyZGeBNLNZQe0+HkCiSLfPEsJ4/NW6O9dMR2AJ5bSc+o1wvqV3
 3ayM3dhJ+sFXYWvHmeP1Lhwm08rlZQv2E6QOD6DBDPxjp/R9XVbSo9wq5GpmSZx4
 xuwlP96a2mFvVXKKqa3XOxcWJVFjSyscFqva2GpUPN4WZ/Iy+XxTkq6xOliqOB6A
 U4Uugab+0rCQ+rcq/l5DTtjBbubRlRIJym9EL1c+BBySzjnQ/ED5hUew7P6c+24E
 x7rlY+jiJq5vliAsxWwWUJYsjZjMKxZdgGWtTbeGZMlbFHm1Opcoirsnw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2108.outbound.protection.outlook.com [40.107.94.108])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t00vjt3q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 03:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYVY/9xLhUMaQxP8WLycum2kIxZ9hpRp8qbkV9ZkEDwq+eUpD57jLCn7M5830KxJ02PXaFc8WbcOrB8cFxboDco8xQ9jk5JuWUFx1YS8Jh2P4Whf2tCuu9NP6g4g8zwuUuPUYTXdgheAy9dOLNB0hGVlYoVkRc3sILcW1Z92jnUlXp/fapgybTZKrW7BBx+f8LGL+fl/6EL8vgQBxtUW/GvWj5bQLo792lsS1DWhU78HLXcHzi3xc+tKLazDdHtzYbKoAAQQ4+wQxmqajpE4xow4qqBRDdEPiNIU8usvYF4eSMdmFw3A0tpOeabTsPDaqZH7ySUc1GzStekJ4UOUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vsf95LggOO6zEaDF9anVdAl1MK77HJPKehlrpULrUtg=;
 b=hlXoN+Ue9tQUeZgA14zI9jTiLjs2kKtcpl6pIqn+8rWHoS+MtLLq4SdpmzHxISb+bkOnZt1A5z/D4zz5Yb1GBcvmo/FBJA+QcGWENppn4P5tRAuLHywOssxWDuWnQKRApNo7Q7+9+1FfzQhHGG8/XtFS2An+NTPipSVNS/xAFyIXQL54tEc8nXvWPaIaM1xEc/KiCai47KJetFptU2az6atUWJ2IXgFVjcWy4A5j71oFakXGR8WChu84rwHORqt61AeE60jiaQSpWeM2gizpras3VtxlU1HmJA0u2Ncop9upux58JaysknUhs5wVjnBURPJC8Lkq8FFfBKL5Rh1m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsf95LggOO6zEaDF9anVdAl1MK77HJPKehlrpULrUtg=;
 b=O0W9TJLggXvo0tEe52u0TnGZvSGgKcjsx7NOqBZ9Yodz5adv1aj+iiE8IECBGzk+XxE738rC4DZGiszyXT39r4L44bc8GfU6g7YJ4zg0lHuA3CGEFenX7Jb8evQK9sZO49Po8tFFIdEiCLCtdRcQ1ny1cfb+VPsEIF9fG2niOowlj3GMdQgsTFYGgP2Ks4VBvLeqz6D2HvWTKFKc0RsZX7XH3utRRbx6Tv80p/CVM+xwNdI4yL847vQFbAGcPf/QdsXimi5TJ+C/9ZK4Sx+taG0Fcm3w1vhSNAHZ5DP8WQpNPH/ej2tIHk9jCtz2CNnw6ROdeTGvJkqgcA61nfnguQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6628.namprd02.prod.outlook.com (2603:10b6:a03:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 28 Aug
 2025 10:05:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 10:05:59 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 0/3] vfio-user client functional test
Date: Thu, 28 Aug 2025 11:05:52 +0100
Message-ID: <20250828100555.1893504-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::12) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: aca59983-7d18-41f9-ccae-08dde61a7cb8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGUraDlPbFNDS3BRVVEySzA5NUROZ3E2d05OL1dwQ01SRE1yVDB4ZkFmc1JU?=
 =?utf-8?B?OStqakJJSDhwa3dXV3JoNWJ0RnMvUlc0SVJDVXRnLzE1eWRtZ3ZjTGpFYjU4?=
 =?utf-8?B?aURVS2V5TEYvU3VMdXlEdk02c2pST0t1TmoyVGRuNzZBUU0rdFY3TjlrMkxo?=
 =?utf-8?B?c0E1MlUvTDlDc1Fua0xFdHJkL0hrUEFJZnZ5Q1hzd1NqUjE1b2xDNGNBL1lG?=
 =?utf-8?B?a092R1VpdzJ4WC9XQzZkbWp3QVpUbTRQaUEva2hOVWNObGhnVUxFZjVUaE5a?=
 =?utf-8?B?ZlJjTXo5cmRIeXQ2akg1NUNBYXdBVVovcFpCeGtZdXVkeG5TQVlsMGV1QldZ?=
 =?utf-8?B?UnlndnRMeEFrdkNZRnpRd2I5Q0hFakF6VG9sZzY5MkJaN0UxRXovS3NXZnAy?=
 =?utf-8?B?ajJVbUF6L1pJRXhsQWRmS2xVSHM4VmVvMmtodTl5alB1M25LSElrOEhnVU9F?=
 =?utf-8?B?Q0ZMc2doR3BaTjBUZHNRTEFnS3RFOXdlK2o1Y2JVV2VubTRGSU9CcE1PSjRy?=
 =?utf-8?B?eStaUzNwQjB3L2k0ZlJQaUZja1BHYmRKSnloYzBkWWxzakxBbnBNalZxdzRU?=
 =?utf-8?B?amdVZkdNdi8ya2w5MUxwekdBVFg4RTk0VkFObWVEOENkelBjLzlNR1ZiTjlQ?=
 =?utf-8?B?aFdJcWdMNTVQU3ZhaFFBVlQrWDI3bks3TlFyNzQzaDJ3eTR6SFFVS3YvbDZ3?=
 =?utf-8?B?bC80WmJNTmtCNFAwSkJlb3UvMStGY3NKTnpUcU94bER4TVVOdzhhRmloSEhu?=
 =?utf-8?B?OHovSW5XbkVkYjNkaWFDTlN3czVnbjNCMHNUYXYzczhlemVlUThtL3ArZ1lE?=
 =?utf-8?B?ZkJIa0lVK3J3WVZUSFhuelJ6UUthQVRrMzFXcitKVTdBdUJzK0orU2ZEMk9S?=
 =?utf-8?B?UlVnTFpzdHlUL3JnV3d1WjJKMERlLzJLMDMrb2tBUlFjT1lxZEhQVXNZaVNu?=
 =?utf-8?B?L1pleTZpcmxQQWR5RERsRmN4L3h1cHRuUUFBOWV3aWNNRWxxRlpST2cweDk1?=
 =?utf-8?B?Qy9uTWFOVnkyNlhDRlBkeGxqazNwK0kyKzVobzZNUzJ3MkVUZHR3SysxdFVi?=
 =?utf-8?B?NEZvVEpkNjVwUW9MVWNVM0VjY3p1K1UxeFpETDFlR1NIdzdQeW96a1kwL1hl?=
 =?utf-8?B?SkY5bElDTzc4aUhHbGN6ZkwvdTBLbjVNSW4vbjFvNTcvbjBuTkJJcFgvT3Bx?=
 =?utf-8?B?MCt0VTdqWjJPcHNyZEQxYjdPaWI0eGJuTUJpT0VtY0JpbFhXSWFENU4yUjMv?=
 =?utf-8?B?TVFSd1Zxd1lmMGF2Yy9QMnVrcEo5TDJpT3BCbkdybFlMYXNQOHdOd1V4NXVx?=
 =?utf-8?B?cWN3MXlvTEVuMWpmdndYRWlYTnZ1dmoxNkVSUVd5MzlHc2Q5Z2taaUZoWDZt?=
 =?utf-8?B?RitZY0kvaTZ3d3EwdFVmWWMvQUNuaWpKaThxNFRHWFBlSkFSMjVuL0pYMHZr?=
 =?utf-8?B?bEgrOVpGVzE1VDVnSVZSMHZUUnhRMmUvU2pzeVVCVVpTTjZtd1lsc0ZsL2R1?=
 =?utf-8?B?VERLVHhqWHk5eDAzaFhSYVI2TktoK2dESEVXTXFVK05TZ05zUGd2a1lZQS93?=
 =?utf-8?B?MGR6R1pWUUZ0ZXRiWnRaSkZtTEpCMzhYOEh5L2ROSlZQMkF5TjdwaGpnTW5R?=
 =?utf-8?B?R0xkbTdtQVE2V1RNL24wdW5QZks4TzlHTnVMd3cvc1VNTlpiVnFqVkFJd01w?=
 =?utf-8?B?T0hvRzRVUVJpaW1KT2x1ODFnN0R0dFdHUTMrSkdVeFA4WSthUDB2VUp6Z3A4?=
 =?utf-8?B?LzkzR0RaYXpIRWppdmIxeDQzMVV5R2NVVmFZSVdVL3FrNWRGOTE1bmFMajJZ?=
 =?utf-8?B?cG9kaVpROHM2YlZGWWJlbWN6Vmh1TzZISlg3eVUvdHdEdk8vbThxaldCSzZh?=
 =?utf-8?B?SGZwd0RhK1drYzlLVWx2SG1Tem91QVhuUWF0R0I3V2Y5Tmdja2toRmNxVVlv?=
 =?utf-8?Q?TjF7G8ihcT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1Db1d6czlhRHZ0TzBxM2VVd1FBZCt1VXZPTzVVWDN0Y0VsMldKVENZZFJW?=
 =?utf-8?B?RWpISlM3SVZYcU1HRHcxNzZoSDNDcHgvcnlCbzlDczZDU1p3SFVHS1V1N1B1?=
 =?utf-8?B?OUhDbS9Bd2g5RW9lbk9CczZOdTlZZ0Q5UVUzRGxBU1E1VXNRZE95Z01QcDBo?=
 =?utf-8?B?WS9iMFZpZ3drdEs4WlZUeGhDL0RFNFBIVHZ4Q2owVUczL21IRDQwT2JrUC9F?=
 =?utf-8?B?YnFVaFdtcDlhOFJSNUJFUHhDZU9xQU5CYzMyb09zSGpSQnN4eTVMV1pUWjc4?=
 =?utf-8?B?WVArWU8wLzdYTG9rZFVKQkM1cEVxUTJJcWtrYkVZSlJYRXU4M0xsSDczMXdl?=
 =?utf-8?B?N05DbzFmS3FzK25wMnlzTzV1RXVyS2wzMEEvQlRWYUNXb1AwRU1NMk9WVHRJ?=
 =?utf-8?B?MHBVYmJmNEpEaWdnbWpxenRuYnNhaVdKYnpGK1FFbFdhTGFGRmtvY04rVFlZ?=
 =?utf-8?B?ZjJrdkNybFdWY0NScVUrM2Y5VVpBaWpZVUNwcG82eVhWWEFiTDJRVFlSWU8y?=
 =?utf-8?B?ZGswR204elhPVWh0OGdvRHprRVpYVGlkQkNrQktMSE1EeXpVU1ZiUlhxa0p6?=
 =?utf-8?B?SzFpc1pLaGZsL09kNnNkcGJaaVBxVnJSRDdhKzVwNnJEeGZqVkMreURHTENT?=
 =?utf-8?B?ZGhRWlpmTXhwQ2xpNGtONGcxNE1VZDBKajlNN3ZpK25wUFl1TmR3ajFCUW5U?=
 =?utf-8?B?TmRNYmVwaDRqWUl4RXE5MzZhSGs4TGNrT2Nuc3NsNWcweTc2amw3d3dSMUZr?=
 =?utf-8?B?eThwMW53UXlUWi8rSXFSN0NyanUrZVZDWXF3RmxZclAwc1hzcGpxYXRydlR5?=
 =?utf-8?B?bUJESGordzdzaHBPQlBIV3ZIWkRIQUI4bncyNktTaXZ3SGlNWGxNeXUxdG5k?=
 =?utf-8?B?U3ZNbHNFQUhCY2lRNWRGemlRMjRMNk0zSncyNlhXOVgraXB1UFVxbUhCQVMz?=
 =?utf-8?B?R3g5c2c0YUJaVHc3UEtaU3pTMTlFbTJqcTFMVy9hbHo1Y2tvb1cxejB5bTBl?=
 =?utf-8?B?dFhMMjRZOWtqQ1ZEc09UdHBnRlNwUXRkamVzK2IwWENtemc1SVJNQW5KR0ZP?=
 =?utf-8?B?RDJJa291QU5HbUFRSEc2aWlPMFNlNDJBVk9mNnYzZG03eGhOS3orRmxsaTI0?=
 =?utf-8?B?SUtvdkNkRW5pejl4NnFzRjlYYkZKR1FKTjFSN1FPVFBOV3JkR3ljRzBIdGZ1?=
 =?utf-8?B?MGlvOFFlVE9qejU2UkwrZ25tbllnOVF2S1JONDBveWMvY2Q2VGcvRkhzZWNY?=
 =?utf-8?B?NUdxd2FFQzVIQjJYTFRUMnVCVjczQ3dTbFVtZ3ExcmhOMzdzajFiWlNCemlm?=
 =?utf-8?B?TnRXOEd3akNPZFZrLzhTRGVjVFc4RTdkQmlyaGpTalFMN0V5WnFYOVdGa0tN?=
 =?utf-8?B?U3BmN0xGb1RuUWh4NEFtbDQ0UzNCVnhFK0dUYkxZanlWTGFMTWR2NTZHbUwv?=
 =?utf-8?B?djFOazNPQjd2c3ZqZXZ4aUJ5VkI3VmVxZTh0N3JYSURRaEtsNnpZcndPRUts?=
 =?utf-8?B?NDdpTFNQY0REWHRJN010WlkzZkZ5NGw4NHlSK2pnd0ZPMmkxNENmanlpWmE1?=
 =?utf-8?B?RGpialVkSzlwUHBiOWo1MFlndU1EZ1V6VGpveXVzNjJ2UnVGbzBSR1dnSmVo?=
 =?utf-8?B?MkNKTFYxYlAzb282c3MyMjlJeklVckhqbTBqQkZUWW8vN1dMelN0Zys1bndD?=
 =?utf-8?B?UjdMTWJiVUg3dHpGbExBRHpqVHFNSUNjTE1UNWxCZUNEM2Y4SVBUU0xkMzdo?=
 =?utf-8?B?Y2UzRGMxdlhEOFA3MmQxMFczbHh1QmNSQVZUeEduZTFHMnJJMVJlUjF1RXpz?=
 =?utf-8?B?TElxM1VjazFJKzRNc290VU0yY0RXME1TMXkvY1gxOCtsZFFDcGJpVmJIUFlL?=
 =?utf-8?B?eHJoUXZDazQ5Z01mMklwVE5YVENmb3hEVnRTSlU4dkZjV016UDNLL1JHV3Zr?=
 =?utf-8?B?WUNnZTJGQzFiNnE3UWNzZ0s2d1pKbS90RGxmNmVuV1Fpc2ZaMi9acnlsVWRn?=
 =?utf-8?B?eXFSakl2R3o1LzNKRGZnL2tLL2o1UGovQ0I5ekIwbzcrWXVaQzUyS24rTWJs?=
 =?utf-8?B?SFhLb01rUTJNb0k0VlJxWE8rdlRNWGlZK09jSy8zZWlwUDE4Y1lQVzIvQlhE?=
 =?utf-8?Q?S+FV4TTEszr4BawYYKUQN1/LB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca59983-7d18-41f9-ccae-08dde61a7cb8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:05:59.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6W32UalBnxnkaf8XJST+4Z7DIc+KMzBBQqEm28CA5KiqZprQpx2jonaHd4LA2heJli8O+m0kwrX10OjMEuAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6628
X-Proofpoint-ORIG-GUID: jrv1OceJlaUyaVjKF6yRrcE50J86sjpV
X-Proofpoint-GUID: jrv1OceJlaUyaVjKF6yRrcE50J86sjpV
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=68b02a0e cx=c_pps
 a=plS/p4Y5Qn2dKbtPC3UXQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=plkC6irEooDNg33354wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NCBTYWx0ZWRfX2WNibJa/RFz4
 chLdTSy2bUfOo/KDKLCJGQv5fgpZkAM5CaUz6FxGA2oXiljwIIIBs+W2vPh/gJLwBhSFzBY2iFJ
 ztuWh38EuWfTIZJYmM1vMmQSZYxdC2CiDF5avHAygOV3dUug3oK3LIRa6O3UisdWPxYlReFt42B
 uDzlZ7WFVDg93IpdvQ79pGHZ3BgF5kvLoCVmquyh9nAiw46N87QwRJV/PIFlqyFzwhP5e3FgMYW
 A5oBnHNN4Qbu+xZ4IgEZpSHcafb563Iq7sxQ7NsFmzS4hm4Ht5HhwE9IrW8c7N9gvD0MX4UoP2Q
 aHmmb5/0V3ROlUdXCQAXFjibFOHpBx+Q6cPPCJqO8HEPust5RqmwsecY5wbuQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add a basic functional test for the vfio-user client, along with a couple of
test framework extensions to support it.

John Levon (2):
  tests/functional: return output from cmd.py helpers
  tests/functional: add vm param to cmd.py helpers

Mark Cave-Ayland (1):
  tests/functional: add a vfio-user smoke test

 MAINTAINERS                                   |   1 +
 tests/functional/qemu_test/cmd.py             |  65 ++-
 tests/functional/x86_64/meson.build           |   1 +
 .../x86_64/test_vfio_user_client.py           | 407 ++++++++++++++++++
 4 files changed, 462 insertions(+), 12 deletions(-)
 create mode 100755 tests/functional/x86_64/test_vfio_user_client.py

-- 
2.43.0


