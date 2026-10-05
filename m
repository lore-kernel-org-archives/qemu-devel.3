Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD34CCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:01:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkBs-0008Dv-GU; Mon, 05 Oct 2026 11:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBn-0008DS-Gt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:15 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBl-00056Z-79
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X03Oc6QLFgdI5VA0Z7kWF09IW0KTyhXHENxCUZSJlODCHDEvkvxOiSvwHL42gDy5xfrGKeVZuRc+v9xLtEOzR+hXAGYXVQ3DmTCjTK8J78sp7VOl1th+VoqBNFNlwDTOavV0Ndwf3GNZvh0ZsMogCa7SohPcm/RGXl0eDha2gu420zKuGDHsJ6FrnEE1DKX4Hl4Js7f7F2g9MsNKwoI3yO4vTcxcZjg9v8c97qsmbRFi7qMkTSxhm+UgI2F90QHviSB4jmNiAL++HsnDzLuUvdu7v3Cq/c5bZ/vMangPV9NtltUPm96kDihKHbaTrFzgMSU369MZW9GYMWOI0hKZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1OeoU7KJPhmiAsFFQR9it2yQBrEP2b7yxy35fHSLDA=;
 b=ZbZ2Gn84ZHc1YUGa8nnF3e4RDzOXu0Vib13zhQzjnFsmJ4ZOedRxIRzFDCrXNLuVQ/2z6lHCLGpLs7ptuwraXmlAm0RR5UPoaqPBeeqEe276UAebCvJ8oTn/UflfK/jn1AetzzpmI/8gOwVKwJOQ5VnF1rrz0VYCh/14uFtDwx3+RQ7EQaWTxNAeYnohtR/YofkBTQaChhhuGzg+HC5vPk14fS8+uLPP3jn9iORdBzIPwUzHtTOFvihEvkXXcN+Z0AnjRSw7279K5wD0cGkzhTGY50G54UU3cL7tDcWnI2IWvlBnaukSeeWGs35+zApWpMhqMSWejHp3lvcwAriBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1OeoU7KJPhmiAsFFQR9it2yQBrEP2b7yxy35fHSLDA=;
 b=ShYTGEqal5B4g8zEzpk8iOCCOBKtkVWQSBCjYPDf5XNE1DCk2SArhx2ooTcJBfN6hd6W75GjbOlTXZEyTcYqpiusYTYZw5m+IX8Bvng8ZNZ3Yxz/SXx9jnWtisbDnPctChx/U8E8pnxPNul1v63Nzdz+OZxGIJprrTK2kSxyfKwSGNzdS1ZIQnMh6hMZ2a7ar+c7LOr46553VTqNE+zLHvakA7xcDtTN+4kKo/tYSBU3PvQD5hD3SEi53p6/84+Mrwg/haPaBnVIdRsZiCM+htrPARKfSbHPj8Xj9Alr2r8XmNs7UTuBA6syFw4FaEEJ39hjFxc/3EbSZdcbMe3BYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:07 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v12 00/21] migration/cpr: support vhost-vsock devices
Date: Mon, 05 Oct 2026 18:00:39 +0300
Message-Id: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJi7w2oC/23QwW7DIAwA0F+pOI/JBgK4p/3HtENCYGXTShUSt
 LXKv4900xRpSL7Ysp9l31j2U/SZHQ83NvkSc0znmqB4ODB36s+vnsexFpgAoYHA8uXCS07unZd
 TyjMvHXfG4iApoMOe1bnL5EP8vKPPLz95XoY37+YN2jpOMc9p+rpvLd3W9+ujavg1gI9olJCdp
 aDsU4nTvKTrNT269MG2HUXvla6l6KqoUeIgRqf7MLYUs1datxZTFe0D+QBSOtm1FLtTBLUUWxU
 Ug6s/g8GqvqXQTpHQUqgqnoB00IKMgZaC8McgALYYhOpYB6Sskp7s0HRw74img9tVNvRAoxVG/
 vvwuq7f3xudznECAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ca1a61-83f4-49d0-6815-08df22f17c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|38350700014|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: J/qIwb1AxWGsXMrOBhOYT78L3eEhuTAFY+78x0kpHsKM/GzOvPrDfYUdvTuij/kkfer1nOpcuLlP8qR+QOkHK3KbV6m0tbbNLgb6bk1NGrYqBh3b2ytKC2oVb/V7o0jKv2eYLwBlY7EHJzyYOKMPhUtDKmfepEENCl8R1UWNi7pdAj6SujrCYkvAWY5fw3MFqBJBLvzj5IjE2xobhMfhMTuy2w6r5fIhHa8z1IzVuu+/7Nbrobrn9LHJXSM27jGhS8m6zKjigQqEM+TFE/68yN6uPoDbhNYdfoU0DV43eEDVtP1GVD8SqXIlsdrfiRiDRLPE+9GiBIHjW18p7yGIfq4noi41FLOZvDw9rskDtwth4/2ItVXh+0BwYBk7styhNg4y/jeoBNcsgPt1kwoAEvIrWBmK52vFZ4JILxLCDm4CO0063nl6GXfR41KgMqxhauWSP7A1qDRJNnpSTOTs38L9OTU9e5a5OT+eCRjbNsNHk/cFM5otm17NB+CtCNt7qU+HCf7rYmtyZKnvSJjnX9tudhroo9MN6H2hoy9U5K3C3BOt4W9PloZtJPx+JELeygIUqg1xC3dFOK1UZlnAvL11i7qFQAf4aZtjRjWQt+uFHXaT6SMS/mkB3i7WdBK8C+Nv6FKHoDpZlRLHojfQknrxcqPKD8naySTcf+3iFMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(38350700014)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1hjUEE4Z04zd0ZCUnBpdWdvUWlwOXljMVNxdzlEb2haVlZmWUVtZHUzQ2Q3?=
 =?utf-8?B?dzRtWk1PSXpzOGJoSFA1Q0puWTZOUXRYZnVVWCtIS1V2c2RtM0ZsZmZPZXhu?=
 =?utf-8?B?T1MvSksvY3hoSUk5ODJSbGliUUg3TU5mcVAzR043cytydUFVREZ4SEdwTzJO?=
 =?utf-8?B?eVpiNzRiOWlKcFd0NEZSVW92Y2lValNpZStqcDUzb0p6WElJYjN1SVhuRWpW?=
 =?utf-8?B?eUpraGFSZFhIeUFibHZFQ3RTVXhXQ0tvbHNCMnRRbDR6K3pwUnljWFJzUGVi?=
 =?utf-8?B?cjBFZkNWVHNtL3V4L0tVV3h3MTdSN00wd2Q2OElKS093eHlTSW1TSHlVVE40?=
 =?utf-8?B?d05OK21jZGdsRlZOSG9aWjcvMFV0YkNYOWVzYkltbTdYZlB4WGRydlhiWURH?=
 =?utf-8?B?c0NuaUZML0tZTXIzQXJ2TG15Zk1oQzNUaThkb0s2eEczTVZpSDBDYnlsQnBF?=
 =?utf-8?B?OG13Y2N5alhIT0wycXY5WVNsclRPNkhkaW1YVEtsNGFPQmlvakw5a2o4TWxD?=
 =?utf-8?B?UGtURmtiSk1PY29uMUQ0a1BibDlRbFBBQkhlb3lXSzQ4YlZ6MWVPY29maTlO?=
 =?utf-8?B?dVFTVUdYeGVTVXk4ZFQ5R3p2Q3U2ak5hclYyamYzYncyNDF4dlBDdTIzQ1Yy?=
 =?utf-8?B?Vmx6NXYwYVVPWndZTUNHK0o4M3RiNS9hblpieDJJRDBBNU5MRkRLUU5vMDFF?=
 =?utf-8?B?Z0E4eUNGTWF0VEZxUUVVelpHanBRbi9PN21OZDhoV0MyTVE5eEtkVm43ekE1?=
 =?utf-8?B?eFlUaVFoejV3Wmd3cEtxaC9nbW9SUnJyd3lPZEorR3lLY1phdW5JV0tQU000?=
 =?utf-8?B?ZUFLMjJZcXNUeUZRdHBsSjNOdWlEbVZxQWZzWUdQMUpSWE9GbENKTDhwOVEv?=
 =?utf-8?B?cnBDb0hGVm5FK0U2SEpXdDF1bjZ4NjB0VWRCYWxnbVkra1FJYUZkc3BGalFG?=
 =?utf-8?B?dXpiUG9lSUxrbDgwMG9mOWY2alpqRVRWYU5NcVJaOGl0UEtpb01uK04wdktj?=
 =?utf-8?B?cHBPTFFxNEd4VmdqT3RlTjFJbEtXbjFYMW52aHVGNndYQnptalY2b3VqOHgx?=
 =?utf-8?B?bkpCb3Rqc0tqQjRDUmtzbmNhWEhwVFViUUJCODZTQnd2UUs1WUxLQ1RQWmpY?=
 =?utf-8?B?Zmxzc3VnWGxYOXZLcDlDS1V5TlFsRjJTUEY4bjc3WVU3aTBKZFkwcTRmWnlF?=
 =?utf-8?B?RTN1cFlDa0hSMXprOEVIK2VCM0VlWmh1dmdrNno0SzIxL3Q3aUdVd1BEWmUw?=
 =?utf-8?B?L1JWSGtTQXJOV2piY0d1YW9LbXkyQ0JjMUE2YmM4ZFJ5OFdLRmJBZFRNWVNN?=
 =?utf-8?B?NkQyMlRvVkxkUHR5ZjR5akNHME45SlVTQjdwWmlqSFNhZ3cyRnRWaXdFeUd0?=
 =?utf-8?B?QkZvdmdISUNXM1E1VTdUV1lHQXZtc0ZUWUpRb01YNi9KTk1IL1JFRHJ3Zk84?=
 =?utf-8?B?UXNUd2xyd0NNVmZpaGN0NWJrQjdNczFteFRvVkFPZ2dhYzJ1VmRCZGR2VUsz?=
 =?utf-8?B?VG42RGdNOU1mNWtqZ3NxeTZCUEhmckNqN3YxdUFXalROenZWbWZxaC9vaGRl?=
 =?utf-8?B?UFpkVml2K2V5Vk5EVmVBdnMvQjU2ZWYyZHFtK0ZJYm9IeldpODdEQW9kSmFr?=
 =?utf-8?B?NS9PVmdyQ3lPeHpDcHk4T0VTZlp5R2tyZ2ZZbVo5cktFK0pSRFlva3V6Z0Ro?=
 =?utf-8?B?MXkyK0lmcFMzbTNyZWxWL2JtTnFGMUZ2aE4wM3doTUFNRCswcjk5S0dIMUgy?=
 =?utf-8?B?SFo2WkNzbnZsUnZDUTJ1ZjhqdEsvZ3NjZVpOcE9DZXhBZ1BvREVTNzFsK3Zu?=
 =?utf-8?B?S2UxVVAxTE5TUFdRTkYwVk1nZFQ2L3p0cVU1QUw3V1dWMVVLUENYQkVlZm1L?=
 =?utf-8?B?ZS9OUUlZTmJQQ2o3TzlyV0ZtK0ZiUEVWYVNjUUYyU2laZFJHOGUvdHZTcHlk?=
 =?utf-8?B?SjZsN0FMVDdSL3VyR1MwWVJybS9kRGZJMG9vZ3YyeWRHSEZkQUtDT1ZmRFAw?=
 =?utf-8?B?bk9CWU1TNkxGRU1CMVY5T0tWY1piMFBINWFURWlLVklWL0U5RmJMNmYxcHg5?=
 =?utf-8?B?MDFEckdwRXJFM2YvOFRYM3p6R3ZzYUlMbkQrSG8vWjE5WVByM2w4bEtqajV4?=
 =?utf-8?B?TkVVOHlocTcxVHZGdU9EUWpldlFVWlpXT2Z3OEJIcE1vb1NUV0R2eG8vRi9H?=
 =?utf-8?B?OU1lUjlRdDhpTXRta2VWYmk3SFljOWdIcWRjN0hsSUhaTlkvWlRqOC80eFRM?=
 =?utf-8?B?WU5EbWc5K3F6emlMdzZ0bGd2dmRCZW01Wi9Db3g1S1JZcmZLOUVqVjRNTnov?=
 =?utf-8?B?bkVNZlpncE1NRnZMN3FtMi9id1hRL0ZZcFZIc0ltQng0N3RxMUR6c3dEUE1m?=
 =?utf-8?Q?8pbOHOXaPN0vwue8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ca1a61-83f4-49d0-6815-08df22f17c13
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:07.5567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWjQVxQ2E3vt8xY/gzBhOa22npTGY53jRnsgeCihSV0jkHcJZzd9r+rzj5x9GI0Cuky9Wk8qb4GjKoHwdipX8CJz73iGPhoEjASQWhhCS6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

v11 -> v12:

  * Patch 17 (NEW):
    - add incoming migration failure notifiers;

  * Patch 16->17:
        ("vhost: release ownership on exit") -> 
        ("vhost: release ownership when the incoming migration fails")
    - release ownership in migration target, whenever we fail somewhere
      after post_load() (i.e. after the ownership was aquired);

  * Patch 21 (NEW):
    - functional test cases for a cpr-transfer target which fails after
      post_load(), both exiting and staying alive.

v11: https://lore.kernel.org/qemu-devel/20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (21):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost: release ownership in vhost_dev_cleanup()
      migration: add incoming migration failure notifiers
      vhost: release ownership when the incoming migration fails
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest
      tests/functional: cover a failing cpr-transfer target with vhost-vsock

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 ++-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 +++++++++++++--
 hw/virtio/vhost.c                               | 100 +++++++-
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  72 ++++++
 include/migration/cpr.h                         |   2 +-
 include/migration/misc.h                        |   7 +
 migration/cpr.c                                 |  64 +++--
 migration/migration.c                           |  23 ++
 migration/options.c                             |  13 +
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 311 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 +++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++
 25 files changed, 1020 insertions(+), 81 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


