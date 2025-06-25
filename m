Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D80C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpF-0007ys-OM; Wed, 25 Jun 2025 15:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpE-0007yP-9E
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpB-0003GI-5t
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:27 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PDQbP3009293;
 Wed, 25 Jun 2025 12:30:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+JW0z2M0XDMLfwMf2cvg4TTzvrHungvz7UY+9GcaC
 1k=; b=LIvigfV4aGnmFl6sEtnnNIhEh+GoR0OiiyYC3hyxE5DUilXLYCy1Dp2dF
 7yooQzrHjIhV6vKdqVciFrWw+BN5BEB5XSwf+XMHlYN1rbUR43m69XBqvJGI1yZ5
 pULVW1PQl2exGjWZU1/md9piggCWfBF+ZmBpUuuEB6yd8fa0p2aZjrPV4OmNPcmZ
 TpgJXbKBYa6VfZTKYX1S2Sp47bbmTEtOKMW+nO6yomI+9bvp56LONmJ2swkMOEMq
 7XfLMZn8ONlkOS1BtRnY7Kl8OidiRs4k7l7NBDgDREo7SANbesAMQBbmSv/pvYVj
 D15SsQvxxUWApXuVKIu1BxnCzRKrQ==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2099.outbound.protection.outlook.com [40.107.101.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dt9carm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWobJ/tcpmU7ItsHvpf/lSdNY4mM701aS0IwnJoiH62WoeCxqivi1FnGx8hFTzFTgjgDZV2G50XLh24y27JkrdZz9uc/AHIjnPWvxOEX1odhue6lZGnPY2fH5+RdZL9rV9sPtqU1tgU4El6ECwyTrVbwYgMPDvn9kOyWP0wijv7hm6pkww1ZSAiC/unbq1xiygGMXAmp3sz3SkuPrhcjMgG0vrExxMPqc0rJyIZFySRVjoU3EWFPCUHC+4o3NOotiVrg8UsAig+fahMI8HNJyQEORwA9SYTfZTxIW+IRayFRpY2D2IZ+iGfJi4NkyKtbrpaR+8a0Ainfl5ovXoHMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JW0z2M0XDMLfwMf2cvg4TTzvrHungvz7UY+9GcaC1k=;
 b=cW7mc8/+qKd4gY3Zx00fPPay57Wmh88SjT7WAYg6mbqUlx0m2oWW0eSiXhwYA6WJskcA55s3A6lEcBc1croIaEENJNabdNfNI/iDc9KJZY0XyubbdD1DUrOUCCXmz9xVHufM1gykMe1g82l7I83Zrfy6EjhJLimKJdACX5O0MaBs/JbOfZCsq7+4P6bGMieQYuL6wZL3U12BH/d5mICe2d850AZMk6JoOOZKBdZWwPare9AYS68QR3JlqhR/eLUAVme8zOyQwZph5MDsT1HTbBVUm8993kBo8yAg9o6xWGLvDdXR4oZ4HTkhdB+XsxGwxZcPYVuS+1NDFYvx76yejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JW0z2M0XDMLfwMf2cvg4TTzvrHungvz7UY+9GcaC1k=;
 b=wab729luCQqkB9H3zXXdlbyVf92YWEUPJBCg7MX+CmtDyc2EPuI29jx5yL7D2zaLRgHJQ/Wk/tcVAQSx8TQSV2lPbQRjTl6cU9UvTFH/8ZiM30doEGxQSJ832cWLfK8gET4cZgfMw5aHXKgwj2Vm/lnG+idi9FrUtbrCs1I80kZaQbNGGyf89f8moauPPce3cY9wbBg8NM/aF57fPrfm2AUGL5SvEQkqCvalHfHlC+Fd0nf70UB332JVp7JgAaIFRmkUx9HfBDy9qUIEzQFEJ/iMG5GVimNTzlsN6FEf0coc4ge36fFWQcQaaB2UEzNCjnA5O7icZ8DEht63/Z+zww==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 01/19] vfio-user: add vfio-user class and container
Date: Wed, 25 Jun 2025 20:29:53 +0100
Message-ID: <20250625193012.2316242-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5086dc76-b947-4dcd-a08d-08ddb41eb89c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFBjVzE0N1hrbUFhdlpXMkhLWDgrSHBNQXdxR0xRdEFLTWIvaFJoSWVEUUxW?=
 =?utf-8?B?NDQvSW9EN2trUGJiTVdIRENYMGFlVnJSZnJ4WnhYUVZWODJBcFF5LzFxd2tQ?=
 =?utf-8?B?OFdtRkE1SEdLUGVMWC9oZnovaExEUWQwOVg5Y2lwL0liVFo5YmMxZnQ2eE9L?=
 =?utf-8?B?cXgyYkRJRFFDZ1gvWk1DN1ZxNk9WaUcrSzFsNVI0TURDc1RWRlVMM2VzeEcy?=
 =?utf-8?B?anlGbElQVFJicUFTQUlhNzgxM1RLVWc2a3pES05WbFcvY0RkZkVtUk1yR0pK?=
 =?utf-8?B?N044QVlBek0yYXIxa0swT2gzajAwRGdCVkNkaUdVSWpXT0NvRzczZGRyWW5w?=
 =?utf-8?B?OTI3a0Z0UFdDTWZQOVd0c1ZwTzJZVVordkNLVHVGb0tkaVpzNEJ5a3Rndm1V?=
 =?utf-8?B?YUZMa29Ram41blNHOWpFMTNyRmpQODllRjg4MEZKVk45SlYrNlk4SDdsYTFV?=
 =?utf-8?B?OHkwZVVQZHJHdFd4Qks4SjBrYTNYS3VaWCszaGdtTnJFZTFQTHUxOVRWQzNJ?=
 =?utf-8?B?bzNwa1pUSkJKOENWQXdJRFlGRnpMSVZCRjc0N0RaYzJSQ3FFdi84QzBSQ0c5?=
 =?utf-8?B?a0IxUDY1MzdNUmViV3cwa3BCbTBFeGVQQ1Y5N3c0RzZxYVhqaXBmZFhWRTRr?=
 =?utf-8?B?aXZ0d2ZDUWltNG9tOWtZR3A5SFBSaGZxSjVBL050WjZHZFpTM0tFTWgxYlBV?=
 =?utf-8?B?WkxTM2RidTgyZlZBZm4wMFArbkIxSFI0bE1uN29YbDdvN3I4ZTdJNmxBeVp0?=
 =?utf-8?B?enZDU1FMb0ZXTlFjSGFmd3BDbnV1cnRLbXQzWUY3R1RtY3p2V3hMSnNRcnJ6?=
 =?utf-8?B?cWFBanhQaDdDbksvMmZNZDIxWFl1VWVIcTJCNkZjbGlaeWhsbHAwWWV2clNv?=
 =?utf-8?B?VGtKcXFnMTh0d2FhUkFqR0hMbnpkRmFXYlc3RkRhQVdRNzE0VW1SZ3h4NVQ4?=
 =?utf-8?B?c3BCMUxpalFzNGxWWWx2bktHaDd3WTdEZDJqeHNYQ1FnMjlqcFNybTZQUndp?=
 =?utf-8?B?SVkwTlJFNHB1aEpVOENyc1d3VDRIcjNWZitxTUdaS0FETTV4b2VHdklTRm4x?=
 =?utf-8?B?cEkxRFRIcllkVFZYcFA2bU9laklVRU42dktGZkFaaUxVS2dsK3p2a09Sd3Fu?=
 =?utf-8?B?UWV1MlRuWXNNZkIzTHZVREhwUXR0WC9MWXVpZjJNbnFLZ3F1VkEvVHBQRC9D?=
 =?utf-8?B?VERaYTFDSEVDeWNjNXNEWUpEVWpYc0FKcERPUXBDZFJXREdzTDhPaGZhdlZT?=
 =?utf-8?B?VDJxWG8xcXJ3TVoxN3EwekxDRDFvQzVHaEJJV3lhOVdyQWhDWVozYnhWKzhk?=
 =?utf-8?B?a0h6ekU0bmFiK1IzNHhyODE1Tnl5YkRTQmxZUnBkei9ldDgyTnUzUXJIMEVJ?=
 =?utf-8?B?M29mQjB4ZkxhQ0ExNm5kUlJhQ3dLUFU5VnNEV05KOFhkV2lqdDJ2NHNXdVhJ?=
 =?utf-8?B?cHViWWQ0RnpGYkxHenVRRmhNaStlZ3pobHhTL2pkczhSYTZkM3VzYTFuY3RO?=
 =?utf-8?B?eUt4S0VnSUtKNCttTEtBa2VoaHNUQjlmZlhrd2Rsa3FMZVVNM1dYOE5oYnZP?=
 =?utf-8?B?VCt4QUxBMSs0akNsKzdxeklURndYbnpkUzJoTmxJSGdRQ0RQU3Uza2FwZFVF?=
 =?utf-8?B?dkt5TWRUaUlVZUdRajFvSFBPVy9uQ25YMDhQci9qN2h0d2JZcEFRRGlmUUdh?=
 =?utf-8?B?RUE5ajc4dDZ6ZUtZOUhudTFpeHhYN1kwdkp1K0szLzRPaWZia0ZId1FGRFpE?=
 =?utf-8?B?eDVWcllmbmsxcFUrUkZ6eGxOek00aHNvKzdUNDlGMEdVWFlYRmxnNDVDUnhh?=
 =?utf-8?B?K3RGZDBUVFN0V25QRFAxUXNOSllidmg3cUs1Y0VieFNybDRjN1REZ29URVo0?=
 =?utf-8?B?ZEpzUkFiSGJWNjR5SGI4N1NDVUtoRU9ueXFiWVljWG9EdFRGM25VWXdFcGQ2?=
 =?utf-8?Q?nZjDPYFMAv8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtiSXhZSFFpL0toMzZrb2MvZFVpOE05aGtHZzByZUtzSzNENDVQbUVrMHJn?=
 =?utf-8?B?MzFVYVF3K2tMSk0xSkhhZ09xVXQ4a0Z0WnVwdVVhRVZjKy84bWtYcWVrZjNS?=
 =?utf-8?B?cjNPMldnUk1wd1pMWmc1d0FFMG01Zm9Nekxtc2JyNit3d0kveFlGdkZuRmZE?=
 =?utf-8?B?dUs3dk9JS2cvU2Z4eHNidlVFVndqWmVXb09GWi9FbjhCczV1VmJiSEEwQ0xq?=
 =?utf-8?B?T3k3WVAzcmh1WXRaLy9OaWRYSnZxMEEzQTNaM1ZNTGFRZkQ1UkhHb0dKYUEr?=
 =?utf-8?B?anJId1J6b3RZR2UyZlc5Nk0zQm1kQXg1dlZ5YmREVTBuQisrU1JvSjBkcGFK?=
 =?utf-8?B?M09NV2pvY2lzbVhSUllLdGt5Z09IL3ZQMVpPdTJBVWdZQWJ6RHZVcmpQWUZ3?=
 =?utf-8?B?R0hhQUc3eUhWZU1rclhKeVJzQXgyZEIyVjFWT0lSYU5KNjRxeU1sQmhXc3J3?=
 =?utf-8?B?emV4azk1b2J4TVFiTXZjWVZZOFZxNU8vQzFLOXc1M1BnalpmOCtHSVFmMVhO?=
 =?utf-8?B?WmFvcUZSZTY1RUpRN1RyRTFvVWN3dFM5NGhwVGpjVDBraGN5T3VhY3R6SnV5?=
 =?utf-8?B?VWVJVDBLeFp0Y29hajRNR0VYdzFUMU1wMmJkUjNEb1V2QiswTkdZN0ZNSmpO?=
 =?utf-8?B?S3hFSWRsMGZENTRtaEdUTExLVmpYb1lLSXFqclBXVXR5TjBacVNCYzRGT0VW?=
 =?utf-8?B?djdtMXlRK2tmSm9QR3EvaXZDUTBCZEx2QlA2SWtOYlgvWHFlQlFlbGhVQnB5?=
 =?utf-8?B?Ry90ZENSV3hFWTkyTmRmSEFndzNnQ00rZEZZcnpyUDFrd1E3YjdKKzk0eGls?=
 =?utf-8?B?UUZET2hYTDRndTUyWTY2SjZXSlR5eVFzU1d4Y0JNOHRtYStzSmx2dVJOdmVr?=
 =?utf-8?B?ZzdTamZ0aitWOTB3UVFUbGdTYmM3ZFpZQ1RQR0tZOEpwQUdGQSt3NklKSEt6?=
 =?utf-8?B?SE5Zd0x1QXZJZWgyWFBlVnJWdlZjeEsycFNMbmdlNXczcGhpWE5lbkp2Z3R3?=
 =?utf-8?B?d3dPcTVXMFlZYXhTZlU5OVRkSjduKzYwNWJTS2p1UTJocWtQWWhaTFJZMEZv?=
 =?utf-8?B?dzdnYmhWbVlMWVNaVFozM0ZTUVVKeHpJc1RhL1VpOFdKNU9QcDREdWxOOUVV?=
 =?utf-8?B?T29xWk81RFJRMWUrT0UzenRKeG1JMmRBT3d6UDdlVUJLbUpaVUcrdEs1UHZ1?=
 =?utf-8?B?NDJoeHFuaXpEekRNMDNFd3VZR216S1VpS0hvOUMzVnJ6TnlJMGt2Sy9ORk9S?=
 =?utf-8?B?YWg3V24zZEdKVEl5UGo2LzFxU3N6VHh3emlRYktyUWZycWpucm9aOGNmVkJ5?=
 =?utf-8?B?UDhlY0lTV1JHRXFrQlRlVThsdkFwcjZ1dDc5dEdJT2c2em1CQkNWYWFqQzVM?=
 =?utf-8?B?cnNhV1ZHU2ExT2t6SGRLSFNreTNYOFo0b1FpOERHOW50VStDSzBNM3RTOUdx?=
 =?utf-8?B?RnNyMHJDZWVtZGVxMTZETkFONElrUkpCaWJ3U05iWFhFNkl2Y2crS0ZucUdW?=
 =?utf-8?B?cXZ5cUJuQ0hZQjlvTEQxUXFMN2lKM2pBMzJpdmJrRFkvRFcwY1JaTkFGTDh4?=
 =?utf-8?B?QUJkRGtxN01SbGlBVXpaK2J4K3ZSTnBzdDFoQU5raGpabmVwNzJDWjBmVzhu?=
 =?utf-8?B?d3Uxak5EYk82a3B4bFZVMGlsY2JnWmZObnRHK1dhemhRNVh0ZGxkTUxoSTAy?=
 =?utf-8?B?T3g0anJkTTFVd2ljS2VieVJMUEVZa2p0NnpjUk9yRWQ5TzFWU1RseFExcy9H?=
 =?utf-8?B?MVozb2hUU0czbDg5Q21yNnJXbUN5cC9GN1lpeXcvekJDN2pTbmRJbUgxa2Jz?=
 =?utf-8?B?dW0vSTZLVXpScWllKzY5UGF2d0QvbHFrTWxFeStGeFNNcHlGY0VQR0pwUDdl?=
 =?utf-8?B?ZnNhU3RjNElnNi91bEt5SGxEN1JZZHQrY3haVzliNzk0dUNZTzNuNFZQdGZj?=
 =?utf-8?B?MVpqcnpzN2Y2a0EwNUxJaXlqSytFZUVmRDJIYTVQYU1PZHlyS3FrSGFTZlln?=
 =?utf-8?B?dHR6dVd3OWR5ZjFkNDc4R0I4RE94NldGUW40WS84dERqbUxNOXRRdXhWOTdN?=
 =?utf-8?B?aXVBTmMrVkZCY2YvZW9jUEt6aDdUREp0MVROcFNZZDN4cXlvRE1JU3RMV2Jn?=
 =?utf-8?Q?3O0fM9p7vxTIHbakgorHP2PzF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5086dc76-b947-4dcd-a08d-08ddb41eb89c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:20.0059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyVvgKh7btCBwYlDzphvLDMMwSjZRsMxzO9lEsPsb6p0ENQ5csi5lHkjV9gIWGpBZDk+QvsyLM4Ais28jGJTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX+9OdsSPj8fYb
 TUuZNh/peuFFb13JfgGnAUA//7VeuujWt7UJiy7noGKy9aL0OLb2ntpckIqE0RLREA8bcvalagV
 iETXvW0KPTgVwlQarMtc6OYrt2HFTSX2B9NKCg4SCUVJzil5EtAdyeITJe0SctoBCZFetZZY7HR
 ZoMMqnBF7fRCH0A/pJvi7C+f6YEjZ7UGk3YK6rPRRedXi5gowZUDHFQ00qxQq9O9TrwpMPRf1Mf
 Rpl0mggz0lfC6DFY1b7aPNc2DCFSxmyAQJ7kMXoOKv9qOJ8ED1gEVORKTfkjl4tkbPQj6Cm4w1P
 JH2eBgSeiRX2Ui8clF+fSDOFwaQ9PTlNIBvIwTDqNHnS//WtDPhKXiz6ViCoI7TMjdKjg1uEulH
 AW3i5VbsYuUS3LNoHAOBvKj2OFUQHRossDZALll3fWMlonx2V4A3n7Q7I0QxwkaoEYdd/a4H
X-Proofpoint-ORIG-GUID: d_0A21v9OHk8nKCAGaV1aiY8OD1gsFzC
X-Authority-Analysis: v=2.4 cv=MeVsu4/f c=1 sm=1 tr=0 ts=685c4e4e cx=c_pps
 a=BDhOPDsQvggip5BazaeBNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=u7rQ6wk7R_5OE3_9H9YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-GUID: d_0A21v9OHk8nKCAGaV1aiY8OD1gsFzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Introduce basic plumbing for vfio-user with CONFIG_VFIO_USER.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   8 +
 hw/vfio-user/container.h              |  21 +++
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 208 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 185 +++++++++++++++++++++++
 hw/Kconfig                            |   1 +
 hw/meson.build                        |   1 +
 hw/vfio-user/Kconfig                  |   7 +
 hw/vfio-user/meson.build              |   9 ++
 9 files changed, 441 insertions(+)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 27f4fe3f25..2369391004 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4253,6 +4253,14 @@ F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
 F: tests/functional/test_multiprocess.py
 
+VFIO-USER:
+M: John Levon <john.levon@nutanix.com>
+M: Thanos Makatos <thanos.makatos@nutanix.com>
+S: Supported
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
+F: subprojects/libvfio-user
+
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
 R: Andrew Melnychenko <andrew@daynix.com>
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..e4a46d2c1b
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,21 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f0232654ee..3cd86ec59e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..2367332177
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,208 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..86d7055747
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,185 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qapi-visit-sockets.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    SocketAddress *socket;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
+                                           device.vbasedev);
+
+    return OBJECT(vdev);
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_pci_intx_eoi,
+    .vfio_get_object = vfio_user_pci_get_object,
+    /* No live migration support yet. */
+    .vfio_save_config = NULL,
+    .vfio_load_config = NULL,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    const char *sock_name;
+    AddressSpace *as;
+
+    if (!udev->socket) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "e.g. -device '{"
+            "\"driver\":\"vfio-user-pci\", "
+            "\"socket\": {\"path\": \"/tmp/vfio-user.sock\", "
+            "\"type\": \"unix\"}'"
+            "}'\n");
+        return;
+    }
+
+    sock_name = udev->socket->u.q_unix.path;
+
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+};
+
+static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
+    bool success;
+
+    qapi_free_SocketAddress(udev->socket);
+
+    udev->socket = NULL;
+
+    success = visit_type_SocketAddress(v, name, &udev->socket, errp);
+
+    if (!success) {
+        return;
+    }
+
+    if (udev->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "Unsupported socket type %s",
+                   SocketAddressType_str(udev->socket->type));
+        qapi_free_SocketAddress(udev->socket);
+        udev->socket = NULL;
+        return;
+    }
+}
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+
+    object_class_property_add(klass, "socket", "SocketAddress", NULL,
+                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_set_description(klass, "socket",
+                                          "SocketAddress (UNIX sockets only)");
+
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/Kconfig b/hw/Kconfig
index 9a86a6a28a..9e6c789ae7 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -42,6 +42,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vfio-user/Kconfig
 source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..791ce21ab4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/Kconfig b/hw/vfio-user/Kconfig
new file mode 100644
index 0000000000..24bdf7af90
--- /dev/null
+++ b/hw/vfio-user/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config VFIO_USER
+    bool
+    default y
+    depends on VFIO_PCI
+
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..b82c558252
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)
-- 
2.43.0


