Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DCFC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWK-00033d-7u; Tue, 20 May 2025 11:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWG-0002z2-7d
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWC-0002Kz-Pb
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBfwAN026470;
 Tue, 20 May 2025 08:04:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QqjzyRIu0Q/79dyxB26Wi1evx4jj+/CdPWsp1vaia
 S0=; b=EzTNr2vXI9DM1N44J3cQnVYhsKPa35zfkRzAMT70HKYhZV9xpSJdKm54D
 rquvE83q2vUPyh5TTjgRfm/LfnM4c9ESxoD1kW/IoWURPLLqtg7TErr6y0vUEN+F
 C/IwNJuSEhdezubd86xy7sRBMTs5ynhWdMkVLsUzGWB6wKOjohgtgLYuBYJ68NBO
 Cey52x/2ge8t4btQeWFWhH9l8fqgytukxbatBP/w6uxQtsLECPt8jetVNHOpxmFU
 mMFzIPQ0EKTK9kONSBz+QReG9yLZYKVtaUbkwmVp37P84oWmtL0HdHc44twXJk5M
 PESJzE9cl7y5RO+A9DtJkfg0xPrJg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheabe-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLAp+jsNkksxOJ6ffjMB+0MkvKFHZ01Rd0pawrBFnjY2i64OAwwc54vlZ8MMmgdrud8fFU2Qc2bVi78s6AgRtVQ0DwGZhp6kDrHoBsEE8ksYr1TcCnUiDDQMx8uKCTGjZ43hEKFJkKWqO2181gcqzW9TWBDbaydM3ummlaxt1qCcpRbrT2o9Ms7pDBZmmQogv90gc1EFEm4Cb+7Lp26wglHCMUgAmUxHPWGbLCSNx9LIXVwOJXs7GQ9MuzkUCcbmfB7sdOkC7En45ppIfBIT/z0lQdlrGvbF0SbZyXdZ8QvDU2BGqbBj3Z11uvkuDxvZTuwWQOTkDHoDpolSPytFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqjzyRIu0Q/79dyxB26Wi1evx4jj+/CdPWsp1vaiaS0=;
 b=ZveuiPYasN6Hoau+f9T6Su4WAhUX0chlQSAuu3omB/gCG7VuWPZFRr6mxarYPmCjTJTmxUhfqM01VqsxToS7SWs0coTMqs06cHaRbRGdh4kGEDhkP+OLrzB86Z+9SyEdarxQ6Rm81XRyp5WW6cVmFLKgvZpmnA9WMpkYvEiv2+nmDxW8IIM1j0KJB8ABD0LeQUUz/4gDRss1uOekDEuhw+lY1VJ/GW3STtq3HgFYAtBac+aivvhfbwkRt/nVIMqawI5KL6gvrvVUO3or/lJHttq6TuvCDcPT8tdtdN6I1+xAeXocvjxxfIloP8cWNRqVbv+YCvVtoJuOhXkM2YUnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqjzyRIu0Q/79dyxB26Wi1evx4jj+/CdPWsp1vaiaS0=;
 b=CvZHgzPho1HglMPfjzMXRHq1OfdjI5JsTYNOhG4O33zpnSEvIb1JjR4rBAsmkakLKvZ9i/kbNW1MOs810H4ihP3iZgolz0FDa+uWKgrTERNj9/U/+x6uCR1i8RUJGHAiz0yOo5JYpgPTMS30J/XYudFU7NqMR11+PoYGG2O5uZY7H4oBjsyN6ETr53N3RIDLSGDMaWE6A0CePXsTF3wVMv7VMset5KWH/uvHekzZLxhNwoy9Et34jSCRYaS8/2fpk6KhYCF8eslQQw0yPw5WUV3IgMivtcLYxtoVebw5UTmctiQbdGfd9dxNvnpjgxy6snVT7r4Pgp1R3CzU3gUWoQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10612.namprd02.prod.outlook.com (2603:10b6:610:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 15:04:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 02/29] vfio: move more cleanup into vfio_pci_put_device()
Date: Tue, 20 May 2025 16:03:51 +0100
Message-ID: <20250520150419.2172078-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10612:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f0b72e-1ff4-4006-918c-08dd97af9f5a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEo0cEZJcURzdkpLLzRhVHRoL1pKZXU1R3F0aXhCUExxMzNob0ZMK1FiaXVo?=
 =?utf-8?B?TmYzQ1BaN2VsN0s2cElrdjEweGxpTUUveGR4L3VpaVVySDBZS3hhdEdpRUpL?=
 =?utf-8?B?UnhYMlVOdVNQM202R2l4clQ5UmxYVjRqemtOUWNMZS9xQzJiMDhvaFdWZ0NK?=
 =?utf-8?B?eEhOQlEwY0k1eWdzdWVzTi9QOXdHSDdEV0Y5eGczWE40TmxaaFVKVHNEQ1FO?=
 =?utf-8?B?aWhLUVQzeFZlTkFaKytGVExMSnJicGhxSGlndFBZaUZVc0tPVTZjZTI0MmJX?=
 =?utf-8?B?VkFQZEM3NnpFN28wTFFzdm44MGY2T0xCN3RLSFViT2V3ZTBnTlhxOTM4NzdV?=
 =?utf-8?B?MzNjenlYVmhWelZUSURBN2MvYWpKZTlMYnV3MGdmeDU4dnJURldMZ1ROaThi?=
 =?utf-8?B?TEVPZEtrWVM3ckdmN0FuTjJhblp3cXBwMFAySHZrVkdoZDBjdUpOUlgvZDVl?=
 =?utf-8?B?eVhhZVh1dHRCbDhjaDJaS0h3RjVYQ1ZKVVM5QVlqa2I5cjlWK1V2RURqZWpa?=
 =?utf-8?B?K3d3MUlpcjFSQW96QklYTTBwR0E0M1E4c2cwTS91NEZIaUNCazdsNlNzeExx?=
 =?utf-8?B?TXNmaVRCd3BGaUxtYUhJenNkVWQxWGlEZUhQNGFGZnJOV00xOU9lcFhrU1pY?=
 =?utf-8?B?RGQxZmFsL3lmZ1VaNEVNWkRCbExmQ3FzL1RVMnRDMW4wbnJMcTlYcWpGbVdz?=
 =?utf-8?B?Mmpiemt5dzNrU29wMitGVlhkYWFsWHhBUWdIYy9wS3FYNkNGWlBjM3BHeEww?=
 =?utf-8?B?eWV2cXdrbVg5MzJDNHp4T2hjMGltSE0xKzFZQXFDeDZvMC9PbHpDVitIZzhk?=
 =?utf-8?B?dldleDZJZ3c2cmI2Vnh3S290ZmZVWkRzMFY2TGsyR08xZUR2dUVRdnUzMytP?=
 =?utf-8?B?OExKelpsN3JoQklUWVlwOCtuQi9CUzJIVW9XSk16MnU4aytEVm9ZL2Rwd3Zn?=
 =?utf-8?B?bGNRYlpOMmtSeTNMNVpBL1A5WVI0NEN5Y0U1MnlCN21iWlBTODZ5eml5QWds?=
 =?utf-8?B?TGhIZW1BeU1nWGZsbWRZWUJrVldrbXY1VUxGZzI5SisvdWEyUEtKYUdvbDlG?=
 =?utf-8?B?c0tFTkY0QktlOWxlMW9rZzM3VzZLYkhWVnYxT3dTWmMrc0NsZnU5dktuSWwy?=
 =?utf-8?B?VU1wNVJ0anAwUzFZREFHQ0ZPVnBCaUUxaE92blYyRk1DV0xBdWU3L3IvWlBK?=
 =?utf-8?B?RDQ1dzE4bXA1TzdWR3hQRGhpZ1VCUElCcitJVVpFc0Z5MXBQL3N0bkl3TGJR?=
 =?utf-8?B?LzIyT0ZPVDZPckFoQnFZSDkyVnBsR09qT0hFVXdFemV0VFhGbUR1UDkrTVds?=
 =?utf-8?B?bUlOYXM5TXZSakVPSkZEZ0g5MXdxY2x5UGtXVFI3OTRaZjdDWnZGZzcwWDFJ?=
 =?utf-8?B?bDQvSDJ2NW9YZTRFUnc4VEx0MmFnOWw4aW4vWSt6a2hDYWRBMXlxWGtwS21P?=
 =?utf-8?B?eWM2Y3FyWld6aWVMc3RnUmxVZWltY05DNWZZVTB6N0ZVSlNqS0VHM2s5QS9L?=
 =?utf-8?B?NjZvQXYxMmtoMnlGN3hCcGJ2ODRFRklLbDF0SXBtek14dWFaK0E0TTFsYktM?=
 =?utf-8?B?TE13dzAwRjlCcmhvc3kwWmdidDR4R1VWZkk2ZE9QdkZXdVgzRmRHTkxNbGRU?=
 =?utf-8?B?aFp6UjFZT282SGdWVGhDUE1KVFQ1RWM2OHNSUmpzck4yUSthWTdudVRyay9L?=
 =?utf-8?B?VU1Uak1rczhLQURTQjNXaE5reTcxN0pVTFlhaEtPc0hmbjNtNGFjSGFWOU42?=
 =?utf-8?B?V2hqZVd0ZU5uNkFKbEZmSFV4WnR1azVOWGtGSjFweTUzd2JpZFNnRUUwZ1dF?=
 =?utf-8?B?bW1rT2djMnB3QTdzYktwUTl4Q29WOTg3YkVxaWpEZnRlV2RvL0hiU1ZtYk00?=
 =?utf-8?B?R2hBbFJCYW9QZzNrRFN2RmREUmgzM2VCY2wyOXcyNW94bmhSNVloUEFuNWcy?=
 =?utf-8?Q?zblKJrCwoR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBiNU5yRkFXcmgrZkp0MldFRjhnRW5NK1hFOWdVUmU1WmxuSWRyMGFrOS8v?=
 =?utf-8?B?N3EvMVdXU0FxU0JXbTgyNGdtRlZmaXkrc213RUVxaDF6bkFBZVhxQTR6VzlV?=
 =?utf-8?B?T3p6bkJXZjZmdjRSaWE3S1JkR3BsdFlTdjV4MGtnYldHQXdjS0lQWkwxWUVK?=
 =?utf-8?B?SER3UHA0YWxSQ3NvL3RyVjg0TDNacWtZTTBndzNlUng4S2p4N0RmME56UHhn?=
 =?utf-8?B?NndqTkhGSFcwUDdqdU9FQk1YWEkrRFYyV1BnbnBXQnIrbjdBdW9iQkFOb3Mz?=
 =?utf-8?B?c1JKT3ROTGdzR21IdjlXWnRhd3hQK2J1akxTRHgyQWZkWDlIMjRqaHNXK3lt?=
 =?utf-8?B?Y2dGSi92VTdXTkNvNXp1cmthMEJUeENvZmRmL0FmLzMwczBzdCtORVlTcHZC?=
 =?utf-8?B?NXBvc29BVjlCWVVxWmJMbDd3NEd3N0o0SEZwRWZlOEJIcFV4Y3JudTVXWEZu?=
 =?utf-8?B?eWdZaTgzcVdMeVJ1d0huUXU1UFN2c1lML29hS1JIR0JrYjVPbm4vaU05Ym40?=
 =?utf-8?B?Q3R5UFdUZDZBZS9SWWFTUzcrV2ZRK2JMNFZqNHk1QStybndDb090UUdXazN4?=
 =?utf-8?B?WXArUStnTXVNVWlhSVpsTUtoalBHOUxlTXozNjE5bnVhY09DbU5ZZGZzb1FS?=
 =?utf-8?B?Y2RMM0UxT3hOM0hlY2NpQTMzVE96L3NyRGVhNTRpR2RnVHZGV1AvREpsUGNt?=
 =?utf-8?B?YVJ3OEZpa1VuZ2hxOE9yOXlvYTVCN29KdHR2eVJFblpiU1RkOWJ3THlmSVJR?=
 =?utf-8?B?YkdMd0dWZ2VQVk1ZUDY0bldmTEhjOU9pMmltRVZWUVMwekdGNE9KaTNraTZS?=
 =?utf-8?B?TUpJb0sydG5KaFMwY21RVVdjR29vK0ZmZk9jcDBUcG1IREx1UUh0RW1PK0Rl?=
 =?utf-8?B?TGRSMnZneUJVaHEwYU01UUxKSmMwYStjT29tZERsSUtmY1NoRUpsZlMxZGVO?=
 =?utf-8?B?aDZPNXZBbWtTL0ZkK0FuVHJnNWVxV0pGUnQ2TmtidDZlcWpyM1VTZUU1QUFT?=
 =?utf-8?B?TVNXMUp4eXplaGUzaFljNmNhZk1Ra3Z5d0hJTlFKRitOQWRyUjdoNnBEYzl0?=
 =?utf-8?B?M2lXazhKV0lpajI2c3ZMNUxzWFNQeDh4TU9mOVNWSW9qUEx2cG5pYU9Idk9y?=
 =?utf-8?B?c0UwbkJwbFYya2RKZWYvTFBsS2dTTEVsUUFsTUNJaFZVdWdFSHBCNjFHTUVa?=
 =?utf-8?B?K1NXQU94akpTZmY4V3lSYjFJbDkyMHJpZ2dDRkF0Z1IxbENHeGNEcnJWemhm?=
 =?utf-8?B?WVcvbmEwdy9hNTVkbXlpTldMNSswUjVBM3FrYmRLVUJYTTZxRy9SVktPSFV5?=
 =?utf-8?B?K09jdEVxd3J6REZWd1EyVGxtVzRKUThkbXRBOERpN05CQ1ZzWkR3V3lWem56?=
 =?utf-8?B?ZGx2dGdtTXA0aXIxL2lsa3lQaVBRd2hhUFUzMHFkNEJ1eFl4aklUNHZsaXY3?=
 =?utf-8?B?VytYcmttRHBHSzBYbHhoaHlVMzlIUmFmVEd3SE5XMFpDVklQZGJCYVM5QUpV?=
 =?utf-8?B?L0FWQXJ0dEVUZVRscFZRUDRxT3hma3BqSmVWSlBpbGFVVEQ5T1dVSk9qVHN0?=
 =?utf-8?B?MndBUXZDYkFDWDhmR3liMSs4ai9IZUlqZko5b2JOZ1JRZnVwQWhCUkg3bWQ4?=
 =?utf-8?B?T0EwWG5VMHNMc1E4YURvNC93TDBsa2dhdU1MaC9jNmhRUlIzU1kvNUNyYytY?=
 =?utf-8?B?bmMwWG96TlQ5ZlQ3VkFuWTg0dGxldUVPL1gvcXBMbllUYmNHbFJJblpDQUNp?=
 =?utf-8?B?U1ArRGVraEdvSm9UVWxrNEhPcEJrRzJNcDZ6OHJ4UkV1V1pxS05DVzBjalh2?=
 =?utf-8?B?b0U5N1E5Z2RZcEc1Rnh4TTN1MTZvMU9wM3FqbVYzZWMxb09Gb2tudGYvamZy?=
 =?utf-8?B?TXRMSnZaWWNkTTVOQ3RIRzNnSEpVTEZYZGxhRzJkVmdSTzlOZWJLcElsUEZ4?=
 =?utf-8?B?MHRLRzBpNWJaUnJmbEZ2eWE4SCtMdjNTZHJiaXV6aU5WaGxsZnU3RC9KSWJ0?=
 =?utf-8?B?enFUZDJYY01UVEpET1IwTjI0bDdiWVNqVzN6MWRKSExjdWdUcHE0SFdxSHFj?=
 =?utf-8?B?Q3pndUxzbHo1aWRaaTlNK0VxU0F5QUFsNFdEZUN2OWM4U0lzM1hPRXR4KzBP?=
 =?utf-8?Q?Cqp/R8SZ8ZcdB+8ydHKD1RMxe?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f0b72e-1ff4-4006-918c-08dd97af9f5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:30.6438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf0Ov13RFyDb77L8DewVwHlU/WwZ+M6ryqnzUpyodMCpZCZSKD9o0ul5eV/53vloQuzEwleRPmOVZOeeSFYl3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10612
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX+WOmh7/Fg3Pi
 R5hL01Axr7KD5BM6amu2V/bM2+F+zgMRlSBIufrvw/YD/OXMIDuz34W6U/Blr/2x0yCT23waYSU
 Ntci9E7ymogu3pgaAIO3u7UfF80VyXquLB1n6+OycQcuD2M26evQABThwujDVg/wAEbmeFBVWZF
 hv1Y/V4ETQAfZYBBZ3a9RhlLXHVyVAeZlgUbWE7mI7VNFUaWu2/nCXvoF9j0lTDN6GwWCYStj9d
 L9JyacqP2469brasxjY6bn16M0eyGDihqG//WsLsyzeOjIGk0yXpRvYboteyHDbI332nvp2sWHW
 ZaUrR4maZuCuHDlGd8rGUMyL6kB42hJTAIRBMUqXvQIDrBuw7qJ052T2Nj1tIJhUZhDT0mTxJdh
 IO37RRJxDje+/pPihL7/hV8GGZdl58nbNl1jNSQOyVObZDvrK920uGk7oJmLtLO/j4h9cT8a
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a00 cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=_mo5Ov_VicZQ5TNRUswA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3lk5PqEfqbahGAw4JRqVcKBeeX_-6Mg5
X-Proofpoint-ORIG-GUID: 3lk5PqEfqbahGAw4JRqVcKBeeX_-6Mg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

All of the cleanup can be done in the same place, and vfio-user will
want to do the same.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe375..d96b55f80c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2854,6 +2854,18 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
+    vfio_display_finalize(vdev);
+    vfio_bars_finalize(vdev);
+    g_free(vdev->emulated_config_bits);
+    g_free(vdev->rom);
+    /*
+     * XXX Leaking igd_opregion is not an oversight, we can't remove the
+     * fw_cfg entry therefore leaking this allocation seems like the safest
+     * option.
+     *
+     * g_free(vdev->igd_opregion);
+     */
+
     vfio_device_detach(&vdev->vbasedev);
 
     g_free(vdev->vbasedev.name);
@@ -3302,17 +3314,6 @@ static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
-    vfio_display_finalize(vdev);
-    vfio_bars_finalize(vdev);
-    g_free(vdev->emulated_config_bits);
-    g_free(vdev->rom);
-    /*
-     * XXX Leaking igd_opregion is not an oversight, we can't remove the
-     * fw_cfg entry therefore leaking this allocation seems like the safest
-     * option.
-     *
-     * g_free(vdev->igd_opregion);
-     */
     vfio_pci_put_device(vdev);
 }
 
-- 
2.43.0


