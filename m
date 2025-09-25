Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A3DCAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFX-0000ey-LJ; Thu, 25 Sep 2025 07:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEk-00078W-G3; Thu, 25 Sep 2025 07:34:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEZ-0008Ue-5y; Thu, 25 Sep 2025 07:34:08 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAtG8o1851329; Thu, 25 Sep 2025 04:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UKmTfL3CaBy8sn3RWrL/mUAe+UKIXxr8wA4satv7y
 3E=; b=UKd6Oh2F0EjZ42oXGSnNYT+ETzaJ3+6x/eBiueXE/FRVBgLW7QvCnYmsE
 dYrTROyS7na82fdTHlsHm9/flTi6Dd6Pr5ST8AgpRN5GUaFOiVdUyd1zzd0ig/6O
 nq2/JatnfEqyxUSylqcQyLvMEfRF+5gkHtwgkqT2fGt6vU362gP+o3TjIXys6vOQ
 oNEh6GjLX1YF38Js24tMi5wSOzi08iS3DtvNFUuZr7kXOh3BQewe8cT+CInBCRDj
 7zJDnssWwrK7wbeg/qphkQoOezKumLYz7ry/O6Wzd3TxmZPk/h0JRD4SEQaMzN96
 qn92lkSqQm93HKMLh36qAS6uyCs2A==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavg3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK+ogl/KGyYB7AqUn9cwzriWZtkMXuyU3Ep9CvBSG5jETFj8kJt8tPw9g7TA2OwiaZoIc67qQr5H7nDIYVLK9t1D9zAYBKMUZvCpEzxRr0XcR+ybQJBb7wDJVEACKnYqLcRTpyUdNBiaIFCIsEGuvFlcbH2O9Gs8sFkDcLLBWtyxuPR08ZBESho2N9ahP98x89maF2Vp531wHJA+/ZTBQ80oHvUGV8dG9pJAKJnVrkEO5qJGl8Dw2zinYbLN74iHtHVx7TN6nJExU4AOfB7hMeWjCtzY3qJbh1bkkCHevC2uXqTWUWk7a3NwZvDEb91W90jTXv2zjSfEgNt07qtntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKmTfL3CaBy8sn3RWrL/mUAe+UKIXxr8wA4satv7y3E=;
 b=ps56tWxFhSvKpqNuPHiwew8UuAw81VyzfOnd8PNsPpHgPt0IVhq4MORT/kzwugnnktNCV9VR70v+/mdUAfxMUVri12CKfH1w9y/lsohzdQCjEldDpmnTodqXCJOO0JpdV2rGM5Z8jRdLRFKkHeH1wNT1ZG5tHAtoDWbexxsSc72uEhwxFMYNy+OQDH/vphwxJdgYGo3rKxPT4VICcTglJQd/V9pAdmlySj0wyPsUKVsr+YoMqmF5IbLFxWSo4hK+5upw0ttPJ97PEo8QJusBt6VJAGqgDG5xYjLj9NBUqBx6szOSKy++/aqByIc9e4WhOdfm+G+b/plV+Jm8jklhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKmTfL3CaBy8sn3RWrL/mUAe+UKIXxr8wA4satv7y3E=;
 b=DufnKoJ6L0YnFVzJhzc3oHGo/gyr4p0Ia/nPPvIJcI7fhB8EmHuaMBwRj6hn7GXR23G7rXWrfojJ4YUkecgnhFZzJantIDzqF3l8smqHxyhiOZYYD1DwyshsyOTorNx7Pq37/i8pRhtS+4XaNnvz1UgZTsxOuJ30rWsVllJsm/22zDWZ4V8gufMYcdIUW2HYWldRTrFbYHRCbmj1EEqOS8auYc72SvpZwfPe3OpOUJdWDdbK9QxGy6vrSYH+JI5fWOvtNfpfud6k7nZz3njHCw3CtYmo8c+juJkpkwYy2TGbcbfsGCc8CPPMlxwDsM2gVhULa4mi8la/nahWR+Pe7Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 24/28] vfio-user/pci.c: rename
 vfio_user_pci_dev_properties[] to vfio_user_pci_properties[]
Date: Thu, 25 Sep 2025 12:31:32 +0100
Message-ID: <20250925113159.1760317-25-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0457.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::13) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf810fc-8cda-492d-6866-08ddfc2757dd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0NTOTdzQ0RWenMycnpEZ1VycU9zVyt5SGhPMStYdlZ4WldPbjZraUN3MlJ3?=
 =?utf-8?B?dzF1MDAvU0dmOGJhWVFqSWRCSFFzVG5iSzN2SW5pTHBNU1FlZzE4WFRacDJL?=
 =?utf-8?B?Qk1ZdDlyR3Vrc2ZMZW5GNXJOL0U2Z2dLQndCdFl5ZVlaRTFZNXpHemhhSGFz?=
 =?utf-8?B?OTduRk9jSzMwZ3EzMDhmM1h6RHRWZDBJSWtkQjNGSjJOMnIyWG0wRmlDc0E1?=
 =?utf-8?B?cUgwVzREZ29yQWUwdXNZaDZnVTlKQVl6a0lhU1lQemN6YWpvMXJrRlhaT2dy?=
 =?utf-8?B?WjlCRENQN01aOVNmT1NLQ2VNVWNjdWRhU2ljKzVNQzZwOHZINUZxQ3VJS1ZK?=
 =?utf-8?B?QzJqR1FwNDF5ampwb0o4ZFJkV0p0RDBpRC94OXdyWm1OTTJQYVRTcTlHVDNP?=
 =?utf-8?B?cW5ib25iR2VobmR0VEJkNWFFQjlTb0E3dGdJb21icHFvRDFLMnZHTExMMXRr?=
 =?utf-8?B?WFZiK3hWNkZnUWFtUzRKd2RadUYwMVk2WWx1Z243TGJEazN2OGVZRzNMQ3hF?=
 =?utf-8?B?NThPVzNrdm5NZUZyZ0ViTnpKYTJoSG96RHF0eHoySURWaXdoZkRIbU4wRlU3?=
 =?utf-8?B?NVBVSlJQMjFPRkhzVkJRbkZqMzNQN0k5eU9nNWZPUWtueXR2L2oyNmEyYTFP?=
 =?utf-8?B?cDYwL29zWFhLWWhaeEd3bWozTStlT0NtNytrZUI0WHVmMmdBTDlicWl2UWVO?=
 =?utf-8?B?a3ZiZjZsMXhJQ2l0d3RETkVpVHNiVTA1THVmb3BML3hpcDAyNmxCY095TDd2?=
 =?utf-8?B?Tlo2b1YyK2w0MXRqc0xBQVZkYThKRzh4TXRFZ21ndDdsMEFhM25sMlFyYkN6?=
 =?utf-8?B?MVZ0ZllRYkwwTityd3M2a09EdmQ5cGxYU0Jxa2ZQeEk0U2FzMlNxeGJnaE9v?=
 =?utf-8?B?aFpTM2hwT0RvU1orODR6ZnRPUU9acFNDUzZmcUR4SGczOWVWZTNPVzFPYkI4?=
 =?utf-8?B?eHAzY3VVb3FlNmpBWVVyd3ZZM2JnNlFXMW5xS0JHTUlvU0s3UGZuLytWY2JD?=
 =?utf-8?B?SDhFNEdQQ0kzVTUzZThtUUVtRkpkWHBaNUVGK1c4c3dSYThNRnVLTGJOTU5E?=
 =?utf-8?B?MG8xb01yZHBUOGJuajQ2aG54MjJXaUZ0S0luOWhtamQ1OHowMkNEUS9WYU5m?=
 =?utf-8?B?NHdIdjZMaEl5MzkvN2ZCbnRuNWFvZm1PaG9CRzRyaldIeVlrUW1xSVZqYTBa?=
 =?utf-8?B?Q0NTeGkrcFRrMlNxTktWTWtCUWZYd2piQUF6b3BrNGRzKzRuOHlkeVl4VExa?=
 =?utf-8?B?TDZBOGxFeFVyOTk3M0d0ckx5aGFaVHF3VE14dzMyVklTT1BzQlJVSk5IM1Rj?=
 =?utf-8?B?Y2FxK2Z1ZnpqVmpNT0loNzRzaUpOaVo5M3hkRXlnSVRIWUJaSUhxV3dqMXhq?=
 =?utf-8?B?cXl6QlU2ZlFxOUt5d3l4TG1LYWQ5ZktXVlg4UWI4VkRNc3IrZ0xCV2pzV1p2?=
 =?utf-8?B?a2l5WkdrMmhQSEdYcXFzZFB5Sm93Q1lmd2RhWnJ4aGZDcmJXeEFqb3dxVHJj?=
 =?utf-8?B?dTFReG15K2FKbVVaVmNtcCt3cnRCR0ljUHVLVm5KR2x2TkJXZE5ZSWVjVWxS?=
 =?utf-8?B?WERtSUg3T3N1VUxUWE5yUG4rcTMvRmhLaFZlN2FwZUJxUWJ1c1lhTktVUWkv?=
 =?utf-8?B?YnpESHVuR3FINE14M3JzOEt6Uks5MFgxdTNiVzQydWRicys3ak4wOTFSaVpu?=
 =?utf-8?B?eDNTVThvaWxZT1hvemEyN0MwOGlHUytNUk9qOFV4QnBKNUNqc2YzQWg5QW4y?=
 =?utf-8?B?Rkk1N2E2ZERXeWtldE94Zi9XYnNiUTZ4RTF1MlJqcXFtaW9HZXVaWHhyME1h?=
 =?utf-8?B?LzVNSVdzSUVzeXg1N1N0OFZwYnRkOGxlL0dva2ZuaWlSSmlrc3pnd0liQkxE?=
 =?utf-8?B?Rm5qRE42T1BtMGt2R2lWLyt5K3RRZ3Q3Q0sxc2hKUHgra0tYbEZGeDBxUWFU?=
 =?utf-8?B?YUtoTzVEaDQ5QTVLL2NCRm1vdzR4RFpFeFVIN3BqZzBxU2RaTmpCMEhQZEhz?=
 =?utf-8?B?ZTBHY0p2TVZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzU4ai9CZTFxaFcwd0N6NjRJRTZldVlMQTVDNXBVcUhLeTVIeVpzaklYUTU0?=
 =?utf-8?B?K0ZZbkhMTWVmU2FiVE15bm5uMVZlL0xERyt5U1FKOGtscXY2a1JHeVNHdHp5?=
 =?utf-8?B?OTQzc1Q0VVZPM01MT2FMWWQvZElGaTRTaWhMb2MzZlE4Q25ENkErR0I3dkQz?=
 =?utf-8?B?QUpBZy9LTG1KR3dkcmtYdUViV2N0UlZNVjJWZ012Nk1XUzkzNjhxSjFLR0hn?=
 =?utf-8?B?MXI5c3I4dlFTN3BPNDNlc2k2Z0pZeUs1ZXc1UE1zNTg5V0pwTlBqOVJkTDlj?=
 =?utf-8?B?MGk1MDYvSmk5Mk1EODJPc1NwZ0V3ZGVNY2dPRjV0bGpFSHBiU0duL01Yb2pp?=
 =?utf-8?B?eHJZNmgwWmMvTDdUOVF0QjZBdUlIazdGY3ZRVXpFQW5SWDVpaFdhYnN6b2ND?=
 =?utf-8?B?Yjlka3JrcHpPZFMxTzJCaE8wUDZFYXlVZUNGK25PQjNoTmhVcGh2ZlJ4cUhY?=
 =?utf-8?B?WjRzVmI4S1R6OWlsa2xmVW9zaUQwYjdLNG5TQ25xNUE4V2MvcmFIR1kvQjkv?=
 =?utf-8?B?MXZzeE0xN3RNdUwyQ01IRTJoR1pBd0RWZ2dwRjNsYTdhZjlFVnNxYVNlTkdF?=
 =?utf-8?B?QXk0b1l1T0czY3QvZ2IyRUJMUGc5dU03VUhBdTNvb3Z4dnVCYTUvUVlJVnhW?=
 =?utf-8?B?RGM4QTFMZGJXd2Z1cFhhNjAxTktjYjFDZ2VCVGZlN0FUYVZ0VjhVc2NmVzZZ?=
 =?utf-8?B?Mkh6QnRSNVQ1RXBMV1o3YkFobGhMN25qVkNpL05XTElNdUs5SFFBc2lwRGs5?=
 =?utf-8?B?OElyRFd3UFhBWFhsU2huOW5RS3dxa0FtL0lnTW1hc1hIMHdGNDZURzd2Wmw4?=
 =?utf-8?B?MUhjWGxaT0doS0VSYU8rQnhjb2FLRCt4cVBsUzZpNTNYV0JXNWdKWWRvRzZo?=
 =?utf-8?B?YnQ4bFZwSVY5d3ZGZjJiYVNjRHE5YlRQNGxFZzVSZWFoam1zVlZTWDM2U2Q1?=
 =?utf-8?B?b3VQZ1MzOXR0cEpYMEdlM1BpUVprYVV3UEt4MXRTbThuUTRSaC9lbUh4Z1BJ?=
 =?utf-8?B?VlYvNlJMWStIWlZqdmpvVDZlNkVoYzRid2Zna1EwSmg1NVJMSkZzRVNYNitS?=
 =?utf-8?B?ME85c1JCclFwUkpzM0NTSmJUM2VxbkkrbGlza0p3eFJDMWg0S21vdXZJcjNL?=
 =?utf-8?B?N2hiSW5FY1BpWTMzYUw4TW80eWdvdkkxc1BzUHV6NnFNK2xUYk5jTU9UQXp1?=
 =?utf-8?B?Q240dDZBQStVdFZsNFVTSHhsYUg3NktJcm9oRFNsK2FDZEtrcm5TNWhiMjNk?=
 =?utf-8?B?U1N4MHB5Q0ZVVjlHb2VoaVhpTFVJbUo5NEg1ZEFibzFzK2EwSVpjVHVQNDIz?=
 =?utf-8?B?NzdjUFhlb203d0gxaE5BMzJQYWdHWjRLU1hKSlVDeGlXWU4wVW9SdnkvR1V1?=
 =?utf-8?B?K0lFMEgwOGs1YjR0aHd0bkU1cnZvN2JBSm9WUXFtSmxqMkJlZTI3eXB5ZStW?=
 =?utf-8?B?dEpNbEVXQ2h1Rm50ZjhlZ3VWMmhHdXI2WWxNaFFoa0tnOWt6Wk5NK1V5Mk1s?=
 =?utf-8?B?dGlQbjM4dnllcHpIaWZDTDhKTHg0bmdBaEhPOERPdXdzMkNhZnNxT1dzUnVp?=
 =?utf-8?B?VzJXNWtNcUhZVG10MjZVVStVM0xsM3AzVkpvRnhjcVE5Vkt2bGVuT0t2dlFO?=
 =?utf-8?B?S3ViMWtuUjZhUzBCdi9GNStYYzg5WThiT3hlT1UvMzI3eGNpRE1uMzNxeFJl?=
 =?utf-8?B?WTZjb3RNb1RWU2N3YlhncTdxY3ZRVEN3OG1kY0Z0SVRxRkZZb0NFeHdxKzRx?=
 =?utf-8?B?T2dvV21BMHJqcTM1UUhMdzhrR08vcDc2dlJ4L2laK3FrWCsrWi9GS1cwQ05X?=
 =?utf-8?B?NnZwZ3ZodEVFT05DTnNjMkM1TUZGTDRpc3dGdkZyazg2c3dFNjhnRHdpOXVs?=
 =?utf-8?B?akIwbFdsMXZDVXlub1QwTmpKZkQ3clV3aElUMW9RSUoxYjRsQlg3U0twREd0?=
 =?utf-8?B?WnRuUFUvWWtPdW9TUjZnSXFSeWNlc1hPSFJUaWl6ZFlycDN0T3VHcUU1VXVq?=
 =?utf-8?B?RXF3TXFVNklaUCtaN2t4T1VvemN6UUJDZVRUNFdad2l1VDJlUTN5WWFHeE5U?=
 =?utf-8?B?eFl6RGxNRW1qd2szNkpCZk4vTmdJZlBpSkxWZUJBMU1lajNrVEg2THF0aGFK?=
 =?utf-8?B?eDRiSit5RXc4YU1nYW0vYktYb1ZvVmxSbVI4dTVZNCtsSmM4RlpJOURNanJC?=
 =?utf-8?B?aFNrUkF2UUl3VHBkdi9uZytqdVRMVFNwMXVRTUZWNHlRNHpjeDYxYWgvbHJ0?=
 =?utf-8?B?cGlBVU5rMW84Rzdtai9qNmI2QzR3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf810fc-8cda-492d-6866-08ddfc2757dd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:27.0187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX7pwfoRZFV2LOkmLB3Pygwp8FfUGyRFYQya8xwHut6l6BmBvtfAdIRxaHbIOLAxcnFMt2lnpVBrPcbBfGjCYiIE2feH8boVFU3pvvtnF50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX86e5l0TPWzxF
 Kw07T5XakT+DyD0TzTjeYGGJaCwzC8tlzpYQbaNBlv7fgGZIak5jEuo7jnRH4Bqy3bHJB6AgT3r
 00uhkhLM9nlG8s4/Jjp+HRw3niFnjDwOevK+k75nziUCriIHKhac8NmbYL18YnURTCeK374KjiR
 SMAlO47LsxuAUr8W5FUbFH+MsuCTgkHEJwUf0kSxyx5RIOnmRakFhkLSa2OFo5YK0YSep/d9eUz
 G4tet5HRG1Ay7EC26becsQ4p6tHYvs5aQrmnysdSm1AJqVWBiiDI9LhuIkZ/pwyqZog3+4qya70
 TyX3Eu0999xC43WLN2w48G8Rmj0l+Y3pLisjmzahaTwoD23aY1DlAL/XGEDRLA=
X-Proofpoint-ORIG-GUID: sbLAiK8zRIIyd5o7WWtN507p8UKidCOA
X-Proofpoint-GUID: sbLAiK8zRIIyd5o7WWtN507p8UKidCOA
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52896 cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=VO-VGI-_H-TUAJbT1awA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c5b5744c..30f485fdbb 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -400,7 +400,7 @@ static void vfio_user_pci_reset(DeviceState *dev)
     vfio_pci_post_reset(vdev);
 }
 
-static const Property vfio_user_pci_dev_properties[] = {
+static const Property vfio_user_pci_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
@@ -452,7 +452,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
-    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    device_class_set_props(dc, vfio_user_pci_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
                               vfio_user_pci_set_socket, NULL, NULL);
-- 
2.43.0


