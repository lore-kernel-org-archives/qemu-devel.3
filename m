Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A341C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWT-00059j-EC; Fri, 11 Jul 2025 05:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWP-00052X-FC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWN-0004jo-C6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:25 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B70gmV032396;
 Fri, 11 Jul 2025 02:58:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=G5AcBUdwpVBOtalw+srHb5dm3ZvommTQPZxQRnEHE
 js=; b=UAlVvTaM8zz8f3tKmHpOhEyVfABgii5/vFfuAOwc0YSwyaYxqFnDUpH1e
 AD+dSYARmHxS5Ad4BO7X2IigQXsvkSTxS3sFyGNuS3J6fjXAbSxJNqPOaJ+HqcSZ
 OGIieCMtycR54dLMXO4Agk3OONTYZ4bLFEdDGToD9I6KgDYdNwnL9piC8+2ZzybG
 SgoM/lAR++M1q1RmHcAeen2Av8BK/iH80lBMHejI3WrALF9A/obg2a0iyiu2Rzn2
 Y6ovylqwjQNUkqN8mpTxi25cGLQJHCTumF//1wNn9kPQbS/pu/MUWO09OOE7TCee
 J5PQy2wSZM3drcce5KTtIZX9T0rPw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022087.outbound.protection.outlook.com
 [40.93.195.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzV5l4TG9Yu+XTgKIuWhGoSfnmcMT91trJfqRLkvctTnj9A0uFv/fHlJtGAedklhkhmTNQzK9Co8SPBkHB6xk8UqbhJ1L8VQDASynsvWBZG47Lx1KeFfaU9G9ewwsusIOwdVw1+kvfded77RFUhinLI0TZmJsto4lBBMQOzR+92hBJ+GSvMmv9jFeJZBIA9HUk7lhZ/9WO2ilFKk3FFxaf72qFD6yW3vHWBC+43lEyO/SzZ4XHSiMbF/Y9wGb4Yebne0x/Ui3Gon3u0m6RMMcQMZWfYK0EtbNzYXQ66ubLyXA7Gzg3pFbn+zRk2iHY4NR6jIg0gpzlL+Y27EXpkTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5AcBUdwpVBOtalw+srHb5dm3ZvommTQPZxQRnEHEjs=;
 b=LiLg+sI2FDGg+vqFd65xmeyKZSa0cgqr5Isz7pM42v3I/NJmSHOnGhJC1jM+gTHcvKi7Q4b9ujyLFnbF+/PkB+Z4Tjk0CVrKUvj7VdVNKaK65wRuh3n6yM/EWdJfdstblFr4VFDSEzp7+2FZSJS+8V89SHqCb89LbAxGqX+ya+EKScqlTGwz3rGrcgGyVIdM5uXDaRJAYkY9oVHNl8UIoPBm7j08wzjMcsDaf3ZZZqjkftTCiIR/R1hkQ92kW1EZ+ftIDzWaUASaoggFKrXykx+W9dzdpzKu5EFu+jEQWvbV1Uto5H2QtO3v5ad9TRClODycw4oWicVWBgh2pj7mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5AcBUdwpVBOtalw+srHb5dm3ZvommTQPZxQRnEHEjs=;
 b=PaM3J7etOR2zJAlSwq3EwXkb+O8q5ypNnV7NaS/7w/454e5n4v6GKmq3Br6Z8PG8By1qSxSMoskZzD5O6lU87Dc/jJgzRuO1vjMP9CWkpwgH71FXyxnVe3MuO6WIlljnmon5JcIBVZkM0ncKilOSgZnWuLycYgeFScg/07H8eS0b3kJau8sR8Bb9DcpdxIjqfCBsAy0WXerAwTJ93IdBK9ieeVb4iX53XflGGauWuGbSC83nE59prSHEujN9XUjMoJ18A+J9WW5/aUL7Rk7XRlhQOwDQlOnw1oiUn05pcGngDUUoXH3oo8tsR+/5vGgZNWBVZD1uz7Ys2Jqn7EOsRg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 01/19] hw/i386/pc_piix.c: restrict isapc machine to 32-bit
 CPUs
Date: Fri, 11 Jul 2025 10:57:03 +0100
Message-ID: <20250711095812.543857-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0061.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d570f2-29e9-40e3-5dc0-08ddc06176d5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hDU05wQzEzRUZ0ZDdhdko0N1lOTnFaaXRMeURpR1JTRkxyNmQwaTVXWk9h?=
 =?utf-8?B?VzdlZUtLTGtkaWVQOW0ya0dkSW5uVjRpc0w5a3NsRlg1TjQyaVIyekFEcDhL?=
 =?utf-8?B?dTFEOFpyc0VodmRqTG0rL3lnUkk1dytlZTJ0Q3hLQ0pYS0hLanB1SjdCSkZM?=
 =?utf-8?B?UUsrR1RXckdmSmU1Z3phMGVwaGw1NWJVZzRRVitmQkhoc3paN3BOMDdFbWVS?=
 =?utf-8?B?eUQrR05aZGtrcGt4cnI0NzkxOC9odGZ6R21lc1pWQ2RxR1hJV2JYY1hSeVdR?=
 =?utf-8?B?VVRsM2NyaldzcDlpdlE3VkEwNG9PRmZZblE0T3BWWDlPK21Da25EdHhTUFRD?=
 =?utf-8?B?c0V3VWtKQ0d3YjlzUUVXdysyMEZpZzBXQklCSktsVldPUlFoQUdPNklNdmVH?=
 =?utf-8?B?dFB5ZVBZQ2FVaTR2VzNKajdTM1p4LzRLSXBiZmpwTkJRSUhrbnBiL0tzQkU0?=
 =?utf-8?B?aVpyNG40R3pqeUNFc05nSzFuYnhkekovYzlGM2FSMVowZWpJMElaRU1mK1dn?=
 =?utf-8?B?dVRqc0NkZ0FCY0lKb1VCQWhhYXZrVzJMU05lb1FXQ0d1dStOQjF1VU5iTkxQ?=
 =?utf-8?B?Q3pjS3o2ajNYL3pGMnBUQWJJK1RZTFF3MVZ2OU9SMlZzUnpCamlLNmdOd1Qr?=
 =?utf-8?B?Y200cFRhRGxrNGYxdnF1TkUxbUVoK2lKdGsrUnNuNElYM2FxSjE0MHZHSndR?=
 =?utf-8?B?WUYyVDhlN21lL2FwVnI2Y3B3YWt3TmdzbndRNk8veTJoT3o4NEd5dkxGRjJJ?=
 =?utf-8?B?Z2FSZzQzZWFzTW1xOVBGUDlseWFjNHdHeUgzVzgwdWhIdlh2NTAvVytQV0Jj?=
 =?utf-8?B?ZUtIeklPWk5KVDdKVjJLMVo4OTNrSFBUSjNQVDFGdnJtUExYZE8vTzB4dWsx?=
 =?utf-8?B?aWNCUUt1S2tSN2tObG9Tc2RyNVYrUjlhQ05xN0hwSmJPenFxQUhiTTRYRWZp?=
 =?utf-8?B?RjFSTWdER2NJenR5QVEvd1FqVzE0UXJsaThqTWdCRnNlMGh3QXIydkd5Yys0?=
 =?utf-8?B?M0FtVmNTamkzbkxRWTYwQnJra1hiV1l2dHI0M2RvVlVOVHI4bStOOExiTjNi?=
 =?utf-8?B?bzNtVnh1NzFQaXFYZzNPMEg1aWhyUk80ZXl5clVTeWhtZXBNblVCVWZoRVpK?=
 =?utf-8?B?ZmU5ZjdxYmNOeDFzcnQ2N2FBRDdhRzAxRDJES1UrZkpJV09IMG9TWU1MZ1Q1?=
 =?utf-8?B?QUVyK1RLaklvUDhtQTRuelQ3Wi9UQ2tvajBqdzNDYS85ZHZtYU9FTGZCdk1J?=
 =?utf-8?B?Y0p3bWViZTJuc2xQa2VkaGdjSUZtVzNhTlVNaDJVbThPTnpUUkxCcDdodEo4?=
 =?utf-8?B?a0liYlJTQStlcUhFWmx6dlZOaXR6MnovQ3M1bmVSN1NlQXc5SlFvZE9QVjdT?=
 =?utf-8?B?STVEQkZQK1BVZitpcUtVNTN2WXZoWXQweUpPWWEyU01kRk80aXZsZ3YzNWIw?=
 =?utf-8?B?Ylp2YVhISXQ1YjZLOGJlUklHU2NnYWpJaGl1eE5sVUpUNFZqSlJYcFNUMGdJ?=
 =?utf-8?B?eDJwUmVmdUJDeDF6WDNLNWxyQlJWZ3hlRkdvZ3gvS1hiMVpEbVJUWEcvUEx5?=
 =?utf-8?B?YzJTNGJRclFQTTBsWjNFaVpEcE83ZkpzbktSbjllK201SkIzd05VbVhjWG9U?=
 =?utf-8?B?TUN4cm15Ui9ZcVlQWWdDK1B2NVZzT1RqYU9WdHZhMngyYzkxSDZjbDJ0dDNn?=
 =?utf-8?B?bUZpRDZHeVErdlJOS25TYUJ6V0lRVDI2YXZkdFdOc0k3RW9UZDZ5SGdWZzIv?=
 =?utf-8?B?MnJteHpNYkdIb08xbkwzd29MYVY0WEt1VngyOW9HT1YybjVOdFJDaTdVa2NB?=
 =?utf-8?B?RFN4em1JZDMzWXRrNDBvMjFBb04rZ1ltVDMrMmxIeTJIc0lKUzh0aUxYbE51?=
 =?utf-8?B?WUhRRE5rM3h4T0p2bVZnUE9tQUxHUnJFZ2xNV3daeUdwM3lPSDdtZ004NlVr?=
 =?utf-8?Q?LHsp3MD+OEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pNVTNXZ3l2a0RrTEMrOGJPdFZEbWptWUgvaHdmaUUxYTVhMVhkdnl3dlhK?=
 =?utf-8?B?SUxYTnpyTEE1Ri9hQnhteDhmZHlZdDM2YXZ4VGxCSmZYaW9Wck5OZlIwcEFv?=
 =?utf-8?B?MWpsYjh0Y3pMcm4rK2Fra0VldEFZeEIrRXRmeDlndVpPUmZWQzlXcGNuenFi?=
 =?utf-8?B?czZkb2xFRGs1TjFhYTlqMlF0dHMwbUtXbEZDYUJ3aWs2d0JCdENvdC9oNkUy?=
 =?utf-8?B?d282dERhRjZ1VnQzZ0pMeDl2aklTQjdJb0FzZVpDUU9FUXhkazY4dFc4ZzV0?=
 =?utf-8?B?NEQ3WGVpQ3d0K0pKcndySFlnbFpEV0lIQjhtTGVQRGg1eWh2K3ZRVlhhdmhu?=
 =?utf-8?B?OHl2WThsR0FMQVo3RVhIWlpYUGVvWlgxRFpLZ3gwNE42cmhLVnI3K1NzSE1B?=
 =?utf-8?B?WTZHTTUvKzQ4aEVKS0xtNUsxUnlOTFBjQ3htRnBHc3NMblZkV2JzcDZrUlZs?=
 =?utf-8?B?Y3ZrVDFyV1RNYUhybTVJMU5vV0dvNlo5NUFuMkdHZ003WkplSFpBeHBoNi8w?=
 =?utf-8?B?bkNOU09RdUdBN1B1OEhOckdlQlRGSWNGc2thcEduQ2JicDJTM21ySXVQVFZK?=
 =?utf-8?B?WDlLUzkzQ3hVTFd2azlZRGpXZWp2NWlnb3pYdFd5emlFTG9CdUNUaWhjQWd0?=
 =?utf-8?B?RVhmSkorbm9LVkRtR3c5ZXVRMHNLVGt5L3Jpb1lERSt5UzR6bis4ZmhYbzV5?=
 =?utf-8?B?SGN0VzF1enJNckhBU2hPcEY0dnFSZDNBZGU0TFAzd0dEbzFVM1VMVmlhaDlJ?=
 =?utf-8?B?V2NGdU9naW9lZVFob3hiMHA4dWkwMWFZZzZ3cENkbnh5QUwyYmUzRDFwSjND?=
 =?utf-8?B?MEJyZW14L0RDZzdWVHdRVXZLQ3ZtemQ2dGVZLzFoK0crd1RNbDJLT0xkcmN0?=
 =?utf-8?B?d2prUjFOb21mTDVYUmdDcldUbFk3NEtnK3lHTHZld1FxVTBzMHM2U2tLRkNw?=
 =?utf-8?B?Q2dRQkdpK3N5Q0VGdHhGa3RSbTBQREpibEFZT0xNZGdFNnFITXhTRUFWOEhs?=
 =?utf-8?B?bU1DQjVwRWxQdjUydXpNUS9KL0NIbXZSL0srSTNkZDdnMGtEbzRzSThHc2p6?=
 =?utf-8?B?dDhPOGtmSHM0QmZ3eStOTFl5MG03SEFva3h2SlZSUFhxZGZ6U1dDdHpuMmhh?=
 =?utf-8?B?aEZpN1pUaXNZNC93RzFNZndvYzVEdUxRdm5VRU5EZWljV01WVW02WHFoMktt?=
 =?utf-8?B?cmpNUmMzdkFOdm9JQ0p1TEh0TE5WZ3VET0ZhWmdWRjhxNnV6RGQ3clh4bFly?=
 =?utf-8?B?Sk03MjhxTGY0U2tFQVcvK1VmY0ViTFBOKzJlUThnZG1VM2pIVnNEc0JhMDdK?=
 =?utf-8?B?SVEyblVXUXNQdWx4SnZGOFkvZGNYbmJMRE9IcHVFeTJLbW5HTjZEY1JmQkFu?=
 =?utf-8?B?cDJSUFZnSnBnRVF3ZFZWRGpmNmxBdDFjdFBjMXE3RFdVNWppMTZaOTFyN3Mv?=
 =?utf-8?B?NEN6b2p1WFVTbVVlNHVVUFpubUU5SDEyT2lsSXJMMnFSSWdMaURNcEpSWmxo?=
 =?utf-8?B?RlgyMW03cFBoaTJsTkFuK1MyTzhJaDlFVE5FUXhmb05wQzFYQ3Z4dU1nbHR6?=
 =?utf-8?B?VzFaZDNzb3JmVjJTb0dXRHdlclRsWUVsdFNiWDI5c1ZyY3FIZUNkLy9jM3Vp?=
 =?utf-8?B?ekpBT2ZPYlpDZldocmJQM1NDKzByV21rUThqV0FpbklhbVZOVkM4Nm15WG52?=
 =?utf-8?B?NCswTDNIdHJHWWFSWUFETGxpcW5MZHEveVRBV0xjM2VKOFEyYUlONU1vZmJi?=
 =?utf-8?B?ZklDdmVLYng3b2xLT3ZvdTNkN3RBWWo0Y3BLTmdYSEtNY1NlcjRDVjdjaFJ5?=
 =?utf-8?B?aUNRT3M0ZG51dlZWWVBGcC9CRkEyMGMvWm9ya2FpVEZCWnQ3SG5FQStCTzVl?=
 =?utf-8?B?US9zZzJHK01jK29jTlRvcVdJazFMN1lqZmZpZkhqUkhnZGR5eWZBTjZ0THpX?=
 =?utf-8?B?L3pZNURwbEd2UFpXc1RLc1doTytkRWFkbW0wU3kzdG1UQ3lLNHlOOGNyRkwv?=
 =?utf-8?B?ME5XdzV0OUlveG45QXg3R3QwRWxCejkrUGR2WldnbUdvaHBwbkxhdHRSamdY?=
 =?utf-8?B?dDhScy9tQ2gxeEVNby96L0M0Mmg4Ulg2MW14dmg0MzlCaU1PY29CazJuM3Vh?=
 =?utf-8?B?WWtpdWFOb1E2YU9HNjRaWUtZUWNsbVAyaGxyelQ5VUZyb3MwM2hYdzhHZFd5?=
 =?utf-8?B?Y1pmdUMxL2FjcHk5UTBCQVpBQ0pNalNrS1Jlb0J1Y24wbzQ2VlNHS0FCTVRW?=
 =?utf-8?B?VWNyVGYxSWpVZ2JoeU03NGlCcEdnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d570f2-29e9-40e3-5dc0-08ddc06176d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:19.5236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99yRUgbK7Jg0NxyMalsTRpdrVi1XFqJsT5kPYgisoGaJGpjJ2rSHcVu6eNu/1j+XljeDjz9s0Jj1Ac6XLGt9e0xFqc3Uf/x2z0IrUDO34Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXyBP/Hi5TTqgH
 nSyDsuic1Le/5lxr3muMm3tQFaowUTCRlspC2xZZiLF1nHhpXdpv9megFTCIupYVe00Fqu6VVpo
 ilz+TihWgSUtWIZ1xy9obrZHXCZHevIOtYlBixY0MyEYkMNZ6h2mah9oM9o1bmlA3tcv1XPf2wc
 d338Us82KuYcip1voFx+bSEJFU44/t6kICYx2V+ihTFyMj0f9qpZqO5woc37ir9Czpb5GlKvgqJ
 hNPG2eoxPbLXfMcCmkPG5jt9LCBDJ4ixLUqzchlIWefy0sQ5gWxAbwRzYYpadlL8J/KW9bAZcN7
 OHnz7ROPNpyvfyZ36IMqNl9oTBloOEJIhHIAroiRofnDiNfArTvADHBIUvTjrPpTK+hlUEYs+Hp
 HueoRreDskhaNarGwMsutmIdHxwPwUoNnZOIchycZnD6pKocrjs7Z7/cmWM+hnF/ScPZ04NZ
X-Proofpoint-ORIG-GUID: AStmDS2Ae3L4ikkpYDQ19gYCQqXExKO-
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e03d cx=c_pps
 a=7r/ioy5s1gfMry3CYkvllQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=nuetpX4ixqIVgyrW5aIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AStmDS2Ae3L4ikkpYDQ19gYCQqXExKO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses -cpu max then the "best"
32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e783..34beea993e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -418,6 +418,19 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -786,7 +799,19 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -799,6 +824,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


