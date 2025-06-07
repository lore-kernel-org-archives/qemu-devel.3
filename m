Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD5AC61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9W-0002vC-F3; Fri, 06 Jun 2025 20:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9V-0002un-HS
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9P-0006N9-74
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:13 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556K9XAc027707;
 Fri, 6 Jun 2025 17:11:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=4aUUpaEmGPTxd
 H9nTjS1MKoOxnsenAgf5MBDOEguEHE=; b=CzyCzeHVgEOUs41QrA5rJYMQB7WxF
 fQR+zX+HaaEv5mFJTmHaDSLLHLKyyQp//mmMoedtV+NnfLR9hkJH8wRy6iGtGw8V
 lZYSAJ4Q76khzNA+8BhrrTHOW7DFvqI6wJxlUPe2oDoLS4QU4YTb7xacOf/2FsP5
 c9pOSs5wADaiWl3tzQRnP9yL83MK2rRRuoWUdZReLqup2zmxM9i/XME0zihS0+RH
 /YkaFuiym5z3m2i9FRMBu47AmrHXcGFQouDrVYdY3i/hIUBRe9eupDGCgZFfvYrJ
 v/qMh111uK//7l7cq7iUNAYbSSIs4w9K1QNej/wWFkl3ZTdKmu+iDSHCw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 471g813xsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtNEPJyfvV6fndyQipQ/aP/3LvRU3Y1cakky4eGoaBdnGrIO0KDDJoQaQ5Wgx00D6xa06q8SkBAzC8Fvl0+DBKpMElPft5m7iJFUKvrfqbWTjMr2QRDwyj8xJqaMLSn2fEXmgl8fECkWdc05D0pUIum547CZuh9xZe0SR4lfa1yPCrE5GQtc7ayivgmf9vV0AzhZdEEOqhDYk4jpDITz5iD/ofwMLb/3aWPB10Jub0Cy3PoXfVGqf1k81cZcXkLNrUq7dMZ3TNJitt/wJg65NWRMPU2vheBthGT+X6MMWDi3ipVhN/oqQRJDWbtgGdgxZakxhXrVkgsnnXsJg13IOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aUUpaEmGPTxdH9nTjS1MKoOxnsenAgf5MBDOEguEHE=;
 b=QeFK3Cp6wTPUN/EgXI4SJNXoG+3dk4flk+jQYGmkiT76O8swco74KgPz/STa1fgQNOKEfisTO7Y57gSIUTnRpRAavonvefkd1VNzeZ5zHs4kymSqj8bbOYgfY/pMdDNcqpawZi755K6U1+fjgELl4PIvUZJW8Bi1yd+W7nXI7zzRMbw9+ZdTRcbd9x4llNZ2b9BsVj8G1lvoojAj+RqWh3/swk1QeBBjnE9TQ8LlTaLjoZm/6iaUt8JeH+FeH9NlzxwgKFzRWC69WjRpT8YTh94cKzLRIW7y6qiqyF+Cs49//xBsbSK1p4IloVEKNj7uIzWm9HeiIBS95v2B84b8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aUUpaEmGPTxdH9nTjS1MKoOxnsenAgf5MBDOEguEHE=;
 b=rZNDflWTi5zrUBKGzVddwpGEr5ww9DFvXgbzXdS+C5eAtrVlPVUHqA1GToHNtYGC5DDBYl+6SXhAhzLzpyYkfE4VJJCPFMDFcyNb3LN5FqZ1MSt+7XBMZ7IKc8maaKBkygqaF+eFjscfy4URtGqA0jAaImc3GeJKZbs3pbkEPtQ0zaSsftzZknMaNWpeaCKokNCmp0j57zx/nl4+9ljF4Q+FikaX2Uoq667bMhkHSeDOUDzjw/u6qTOVu+VHmMcBXTbjlSGqAozaRMGK+nVhx5xuGE6Ul03YqR4GsayHeB7ogBzkTkmOdFcxh7RXte+mUc3/q+5rYKLNPMfdsdLlHg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:10:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:10:59 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 00/23] vfio-user client
Date: Fri,  6 Jun 2025 17:10:32 -0700
Message-ID: <20250607001056.335310-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c6d142-8c82-4a9f-9b45-08dda557c7e3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1VUK3pFVFRFVUVKQ3FDdjROc0gyK2NrSFREOHBRRjVLbkhOdldEeGhJaHZ0?=
 =?utf-8?B?THl1TW1zQTZpa2lHaGtwUkFRMGM3K0RtSlBnSitzSEk4WWR4ZytSVHVSdWxo?=
 =?utf-8?B?Q3pxb1A4ZUNvUFZtLzBSTXBQWEFKRXNiQVYvUzJyNU9jSzNMUE54UFpSdVlx?=
 =?utf-8?B?djA1WHFCcmRHWE9YK1ZqeWdtVWdST1kxd0ZRdEEvNEhMUWVvMG9ybmxkTUpD?=
 =?utf-8?B?YU9zckREaFdndEJkWFByWnNZOFlsVFVYWktGcWk2RGRqK3lIekp1U2hFdDZv?=
 =?utf-8?B?YmgzUDVPK0daK1A3ZUdjank5UlNFamN5T3lOMVlkR1BTNXQ2S254TWM2YUhI?=
 =?utf-8?B?NHdLTGtLR3RpeXEycFlDbm4vZktpT1Yzc0I3dW1aVVVWY3RJRnZSRlhjOGxp?=
 =?utf-8?B?TE1JSldwekNZR1NSWkZCT1N0MWwvUEt6UXh4R1BTUUEwWGROOUlmSkpkK0NJ?=
 =?utf-8?B?WW1kWmV5Z2xuOUtWMm8vNHdwbDR1YXA3T0k5SEp0and6T0VzNlZoZlI0eTNJ?=
 =?utf-8?B?R0VvdkxpMFBCNjV5TXRJR0lqVmRsMDZhRGZyMW9FaFcwMnJtSVlmNVdYUUtN?=
 =?utf-8?B?cEs5alV6UnpnRTU1ZUFwR1I5bnF6Z2hDR2gyN2pmODJId0dwYXpYN0xpUUJH?=
 =?utf-8?B?eVBWTkpnK0lWN2J3eWZRMWNKY2JXS1RieGFtUVdrcmJQaHE5MWMvUUF1cngr?=
 =?utf-8?B?WkZBUElCT1V2djBQbHozV1pOUStmQjZISVpEYVp3QWJxeEFiQUo3RHJkbHFj?=
 =?utf-8?B?dVg1VVMxbUw3Q1huOUpudWxhVERIK0NwVWlRaWhrbUVUbTQvYXlSMjZPWmE5?=
 =?utf-8?B?YW55YkVWbDgwK0JGZmpQTFNYVkFSZ3FjTWU0WVh3MGR1bkdLQWc4cERxTEtt?=
 =?utf-8?B?ZmpXcU9Kb1h0c0ZURUZpOEk5aVBUZFRMTFI5QmtFeVpYZnV2bmRmQW81NmFq?=
 =?utf-8?B?SHNZaG11ZmJCS0dKc0pKcUlOaU9nY2p3V2VwTkMxNmdlUjc2ampJZ1cxbzU0?=
 =?utf-8?B?VTRjTWZmYmsxbTU3NEpPazZHYkF4K1dRYm1vckg2M0o3TGhMZFdnc1JsM2ll?=
 =?utf-8?B?a3pqYnpTMHZFMUVJbkxIK1pGTk00RFcxSy9kdTFGRjd1R0RoVFJGMGRuVFlR?=
 =?utf-8?B?RWY2MGRDTmZyTkdUMXAxMEl5QVhUY2FGUTFJM0hPeDdEVm9UQnVvZ25JYUZq?=
 =?utf-8?B?R3VUNkJ4ZEs1d1o3UkhCcG80SXFyMzVtb3BQdi82YkRKUVdYYWxKU0pXZU5V?=
 =?utf-8?B?cFA1SDJaRFRoT1l3dW1tWW12MzhUb2VMV2Z6WWhtZFN3Z3Y3a2xCN3ZoZ2Zn?=
 =?utf-8?B?N2dLSnNROXgvVGEvZ1kvSDNCNkZaeHhBL3JaaEFUeXJwVU40Q2l2NnJoT1hX?=
 =?utf-8?B?UDhXUy93WWpHTVlaNzB1dWJvUlBkeE5yK2lDdE5TL1RDc3I3UlRoNkpVOTZh?=
 =?utf-8?B?TFZ3bjZLZWtrZjI1WGdvQW1QLzRBZVdIczZqQjNoSW84WWhBcU96U2U5d0Na?=
 =?utf-8?B?YzFwN3JlOHJzK0IyWDNuamZBdGh4MTRqZFFqYmRxUG9haW1kUnNpY2VnQXd1?=
 =?utf-8?B?OFFld0hPYS9KSkdkN01PVTgxUkt6NWlyL2tRR0FmVk9scFRrU0pHYWMrZUIz?=
 =?utf-8?B?b3NqZ1dZZFhmTkUzMFVsR2FTelQwY05IeXZxY2RFVEZnSStYa0NPZzhpS3dE?=
 =?utf-8?B?UlBUR2VwOU5lQjJtOFc0L0NJeHRwOTJ0UjhzUkhNUWRWcSs5aCs0WFpQck5z?=
 =?utf-8?B?SHFNYWg3bitZSGRkREI5aWVoVGZDK0xJSDhXNG1BdHlWYTJwL2tvZnVGaGJD?=
 =?utf-8?B?bnR1a0VMczZaSTdocWc0OFVyd1ZGV08xbktnaFN6UUNWejRRS3k0MmFLRStW?=
 =?utf-8?B?V0hOdXo4RDhDUWJYNmJOWEp3ZGpaMm5PZWROZUpsK2dHNlI3RHRUL1M0MlpG?=
 =?utf-8?Q?bvDSO1HtPGc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2FGa2ZKSk01NGpNeHhkOTFCaHJBVjZyQ2JVUFdwSUZYVmlQUXNydkxoYmxF?=
 =?utf-8?B?RC94aDFOOHFydnFDdHQzZHJrYmNTL2x0NlBEby9aN1JIZDNBWUhDTXVRUmk1?=
 =?utf-8?B?dWxHNGFhd0t5STIrSm03RHFLbE1jbkxlVUdHNnUyZ21xVHRheUVJaGZqbVhl?=
 =?utf-8?B?VE1sbkQ1b2dVcG42d2VFVDNxcktCMEFsNDFUQzR4T2JXaHUvZWp2THBCdzNP?=
 =?utf-8?B?WjJ4SjRMdmtNdC8zZzZXSWY2ZGMvVVpTc2hpWUYyb21sTzJzYmJoa3V1QnpZ?=
 =?utf-8?B?YUJvUjNia2dVZWtnL1c0ZCsyaFlHaWxjc2ZFc1M3VktxQnNXcklqQVZuT1Z3?=
 =?utf-8?B?Y1JCTUk5M3dlVUxuOG9GUnIxUmJoRjc0djRyaFIzWTJLWnpTZWJBNU94UjUx?=
 =?utf-8?B?VGh1azhhcjh6ZzNyVlR5d2ZncGNzWDFnRCtYcWJqTkVlREkxQ0Jjay92dmNs?=
 =?utf-8?B?eVEzMGFmbTMyYUFsU1ZLSUhqcHd3Y1NqQzg2cFpraUZrLzZCcW9UaFdaNmdz?=
 =?utf-8?B?clFld01UYkRMNldMRWtkRnFjQWwrRGlKOUlmM0ZwZG5qNGIzTU9UZU9nejlB?=
 =?utf-8?B?ZEFSR0NXM251ZlZzYmJPMFNLMlJVVlRDTkl2RXlXN2ZSYVZxVXFmZEtOdWlD?=
 =?utf-8?B?WEdVQjN4alE5MHo1Q3kvYUlNUERwdmRoMklCR3RTUk9IRGhYYytFZHRoMm9k?=
 =?utf-8?B?RG9xbmwrV04renEzanpDSXdPeW5zYmxxOTUzK3JyZU91NGpkVXRnbFdoRWl2?=
 =?utf-8?B?WUtqQnR1TGJpeXNySkxyOTZhRGNoTlFnWnk0SldaeFpJdWxJZzk2Wk5FaFE4?=
 =?utf-8?B?RXRDY0VudFpIQThQQll5RzVZL3BCVEhLN2UvYnZwRjlDOGZianE1NW10Y1lI?=
 =?utf-8?B?T25vcjZSOUxpQ1hDaXRVNy9xbS85MGFKYWdQb3YybktHWEZFeUdMK1BMVnli?=
 =?utf-8?B?Z1lTeXRYeFlKT2c0RDhtaUM2SFpkSkc0NWczdE4xLzY1ZU5zM2JwazlVSHBy?=
 =?utf-8?B?bmZnaVJjUUtRd0RlV28rTzB0MG4rQUord1FVNWZGdXNiUVVqRlRrOHVFbCtB?=
 =?utf-8?B?alRyL2YxYlpNLzFTaXhJVHZESGROUnoxb0FjL0dnN1QyVkluYlV0Y1h5elkv?=
 =?utf-8?B?d1pmYmpMSTJlT2tLcHVPajZRTEUveGlBU1hiRW9KeU1XaUwxOE05YWZ1VU1C?=
 =?utf-8?B?bFlOQmRZbjg2eDBCMDR6dlVZaXY5ZDZsblNmMTdVOWdSYSticFk1T1BaUWtY?=
 =?utf-8?B?MzhjQjdUa3NTWHZSRE5aVFFSelJudUd0MkQrNE5xWUZidUlyWUJJMng0REFE?=
 =?utf-8?B?czhqWEs1NFdNeVFwVTJTaUNIVjJnY3ZvdlNBSjFXTmIxSFQ0d2RheHkvd3g4?=
 =?utf-8?B?WmVCRm1BNkJuQk1TRzdHUmVHQ3VCVjM4NHdEVXNLWGd5SEpLTjJXUHM0b09G?=
 =?utf-8?B?cUg2YlZZUjJycXczdERoYUtlQlptbW14ZVZkcW84NXloTzdmSHBoVXRDYWdn?=
 =?utf-8?B?SWsxTG9ZMGRoQlpCMERHdml0NmVwd1FiVjlEdHB1TTdOSTgvRWx4eGZUMXBq?=
 =?utf-8?B?blhudlN3ek1xVEhQWWtmeFh3VGg3OTdCbnNZMWo5UmRSMi9UUXFEL1BhbERw?=
 =?utf-8?B?U3ZqM3U2QmNUTVVsTXhscHpGaGE1TXRVSkhuSUoraEZ3clZQV1ZsckFEbGVI?=
 =?utf-8?B?clp2T3c1MUh3anFiRTVaV2FXM0JsRFN1MEVvOE1oRHMvT3dIaTg1UFNGVEtp?=
 =?utf-8?B?Q3BNTE9WQVI0MGpxa3lJT2JVeHJHZVM0dnJUTUlvT2gzZWFlb1A5L3BLaXM2?=
 =?utf-8?B?bDluSHFYcE5laVdiQ1ZZMVIzcWlGOEluRUdjdmVrK05Cdi9kcjN5RU93SnJa?=
 =?utf-8?B?ZWx2M0lPK1gvcDhmYStkaFBZZjB4ZGJ2VElvM2d1QWpTbVBlcWlkMFZ2ajla?=
 =?utf-8?B?YlVxUXVKdkFvcUtISTdBSEFtWStsYVJHTXlKN29XLzl5R0FnRFFsYW54RW5n?=
 =?utf-8?B?dDUyVWFuNi9PUFVVN2xNWjhTNEQvNWpJZnhJUHBHWU82STQzSUFmSnFUNHVw?=
 =?utf-8?B?eFlNSzZud2U1eWovQldUZkVRRXNJVkZnWHZna3JSbmswMFZuZmljMk9ZQlkv?=
 =?utf-8?Q?kjm51SMCgObzNq9a3jvjPUOP0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c6d142-8c82-4a9f-9b45-08dda557c7e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:10:59.2424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3vH8BtkSPms+4/H37xqhAUk/9gStXdbdaXHw6hWsu87cefbvYyZPAhUjX+PQ3s4/xwGAoCzd3L8maZktX3Nqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX43iduJnxbh5h
 rMFFZ6WsmWsyUyFvqvVdTg7Kct6zaq/ARdiAKD6Ne6CX30pp5hQrEPcTgqokyb54vZQtNXru7N0
 LFkK8CkCrdAhDqEyJPbS4nz/lt2Gg75ncnUJsqzZtppp6z/SeuQHbLxfxK1zTyUSrhps4s5XLVx
 Fb04pH3WD1TwD2xu81sdATR0659eFTX+jMWlys8/ldWIIp/gL5rMj6MigdKvhuobkx8w9JCEH5Z
 6kLFJpy3W31KotIDaQ2ma58jnzU7q9eJeZwHXPw3e9SDXelIHBz8tBu2SVHZScalFeY7El3YGJ1
 1cd7zQ8xR0B2DlXXFRdAdZKstrYyU21EPJmLXcncaHmlyECY/gfynFc9Ezxx3mEC6DxmQmEkaiy
 2dIZ8LJdU9614mgxhZbx7X1RmHG0pp/PalGyV2jVtCO1rbUEtQb9pEnI9t6Xv6Xx5dmMVnU9
X-Authority-Analysis: v=2.4 cv=SY33duRu c=1 sm=1 tr=0 ts=68438396 cx=c_pps
 a=PuycMPbAwArgayjkkQxHog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=WC9NrebBiJSwSucxmncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5k0oVY68xP-9NxEFc-XK801xO57DHs9F
X-Proofpoint-GUID: 5k0oVY68xP-9NxEFc-XK801xO57DHs9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
https://lore.kernel.org/qemu-devel/20250520150419.2172078-1-john.levon@nutanix.com/

Changes since v2:

 - rebase to current master
 - code review feedback for region fd change

thanks
john

John Levon (22):
  vfio: export PCI helpers needed for vfio-user
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
 hw/vfio/pci.h                         |   13 +
 include/hw/vfio/vfio-container-base.h |    1 +
 include/hw/vfio/vfio-device.h         |   15 +-
 include/hw/vfio/vfio-region.h         |    1 +
 hw/vfio-user/container.c              |  348 ++++++
 hw/vfio-user/device.c                 |  389 +++++++
 hw/vfio-user/pci.c                    |  438 +++++++
 hw/vfio-user/proxy.c                  | 1314 +++++++++++++++++++++
 hw/vfio/device.c                      |   58 +-
 hw/vfio/pci.c                         |   99 +-
 hw/vfio/region.c                      |   12 +-
 hw/meson.build                        |    1 +
 hw/vfio-user/meson.build              |   11 +
 hw/vfio-user/trace-events             |   18 +
 hw/vfio/trace-events                  |    6 +-
 meson_options.txt                     |    2 +
 scripts/meson-buildoptions.sh         |    4 +
 28 files changed, 4679 insertions(+), 47 deletions(-)
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


