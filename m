Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97849C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXh8a-00014y-LY; Fri, 04 Jul 2025 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh80-0000rM-1y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:11:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uXh7w-0004kp-OW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:10:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564BwILL008977;
 Fri, 4 Jul 2025 07:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4G9wT8zaI41zA7GIDM+pTIJYQLQ8dhW88Poi9NawK
 0Y=; b=pzg3/7c1gQN8xfy038fL3LqwpMemsWg/4tAgbfxRB1eeX2iShrIqbn38c
 0aVv6zLiaYpvZwvDQ8rf37k8H4zIzR34bb5TVix+kVfuQNPMPMWUWq/dZsVqIuY7
 RGofWWx2A6lAxmKYK0z8v5ZvZ0TI1B2ZxCJW4qQSCSeLSIpa6IOezzinud/vrAiV
 AN/gv1kCJjrrUfcKT4hbUCEJRAdYVW7bUwcbfW99Oi/Rq8h4JKfXmcW/ROsr4z5S
 Gams48EJGq0vgxv7fo3j1CWHGwS1FOwxxTv8Get+h+mPXeFJ68HAdVTbP+U576I3
 U49VpMVnCCdkdBRZlYHwNdZ2wh/XA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023121.outbound.protection.outlook.com
 [40.107.201.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47mhw30fu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Jul 2025 07:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7bhN/Y6b7Bcyjloarg2Z5iTanySwPcJVD9969GjZfAO9ylo4c6o8uvbsHMvTcn+6fYFSLEtrFOHzexfFowZCJCa09FXN8LzqbMiFBglp1c+kpS2stE4MD65cJQf6RWRH9a7hFogKAdNCTMB7nZLy14orY0qiEQbfKnA0MtTSa381M8cRHUZpLQcLuJLebWOdsEB3x4a3rYL/T6fCuOP35gz4EbUwYStBrJiS3yHVIubZpiYTmuIKmZFKyentG0Dv+NdyCwI4VO2LtaMaWPgx/Lc7h+d7lzzK1Rplv4ZspgGRyJNvGq53J3CY86iJAux4oRMQ27TNavLDWEUW5tFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G9wT8zaI41zA7GIDM+pTIJYQLQ8dhW88Poi9NawK0Y=;
 b=MaYNULHFdlQa32gqH1Bb14u3nf76lxv3DE8KYJ8D4XtZPK4J0+0eKX29N/RudrH2ia3AwBuMT+Eqm9GKm5+OBp/P/F9xJx2OIPKFC+OjCG60jiUM0WSgJMEbWl52I7KZq4slRuEzmqQHwwz6ihCNmGF+ed/kgH8hsXFRBhTXs8nFN/HP4Ch/UIJXt8qEN5wzRMaq5CtB6cUWx3PfV6uOEXiHLsKx4InC2OMj2TCaZrYzQf/6TsRwF6bEBobMfnxGj7JEt/N5dBWL3yaACmFkPUlXHU0Qj/0zPu7Th/KWeXM1iQkt/N9l1hxfPzybuyONG2SpdzNMqth/yfSXLfr0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9wT8zaI41zA7GIDM+pTIJYQLQ8dhW88Poi9NawK0Y=;
 b=kLL+dBBG9VCyKSnSI9sVjar/L4/lvtNeOp+NPYxdMp1UU4IXHYxgLxlfga8xq/4HMhwolSKttcuhKYCPHZ1szOPSebv59wJO/pfZdsV1FZL5yOI/gEuFDG8mKykmOoE0wHmPBDSv6pLl1H08DTU6Wuf7YqL6Q6eU/vj/4tvbzvtvDdsnidA0ZHUYmMTaEqcS9oW3ZbSKF9dfww9ar10ZcGV//rF7uMKYPNauuKG1WW1bds1yGrBJdqCmoQ1cDmdmKj+Z3pD17ihvsi0zTyC0JTMNptc+ipTSW0aWyj3+DxnlnWRFXOsVQDk7F7e5q6EwXQ2igkoJfYPmu8gW9YA68g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9087.namprd02.prod.outlook.com (2603:10b6:208:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 14:10:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 14:10:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 08/14] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Fri,  4 Jul 2025 15:09:35 +0100
Message-ID: <20250704141018.674268-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704141018.674268-1-mark.caveayland@nutanix.com>
References: <20250704141018.674268-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa8e809-fbf3-4291-0c5b-08ddbb04950c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGk1MzZXVkhHUTlzaXN3U1lKcnAxQ0w2SFdlN1crUWtGMmZvZ1Z6Y09rdGxP?=
 =?utf-8?B?ZGk0RDltNmJWOGZEOW1CcEFUR0FoRVVER2JOdHRFaUVzWVY5ZXdXTnU4S0Fa?=
 =?utf-8?B?ZHFpczg3TlE1TmsrUVowNlM5SFhPV1llRm9HYzR0UXlxSnFMdVVRWlcxRzNj?=
 =?utf-8?B?SkN4TTBkbzBnZ2FYRjRSZ1JScmhteXN2d0UxQWp1cFBaRVRra25nZWovTFR0?=
 =?utf-8?B?ZE5SNUlKUitrL1I1L1VhUzZieEZOaWk5R0VVQUszLzIvbTJnUVRMU2JrWHNn?=
 =?utf-8?B?cExXQWhIT1J6ZE9FNDM1ZHVJd1JtNlJyM1QyaFNod2s2KzY5YmlWeUJMYVQz?=
 =?utf-8?B?S3ZmTkFyYklYemhWbGN4UHVNNkZBVUpQY2c5S3YvYmRsbCtXT25lZlIvdU8z?=
 =?utf-8?B?RFdFM1FNeEZyRFE2aGIvenFwTGZtbmZDbVYrVjZNenJWUzR5dzhla0Y2WlRl?=
 =?utf-8?B?Vm85V2U0bmYwOUVTdWt2VVUrVWRwVWV2VXhtOU1HMm8wdXhjQzRuMnU0TDdr?=
 =?utf-8?B?bERLT3ZMVk9Db2ZXRVJNMmlHaHVheWQvbmVJWUc4UGJ4T1NrV1hsczk0NHFO?=
 =?utf-8?B?cy9IUmpQMHdCNEw0UDFEeldNQm0zUHpqVXFzRE9BMHFhOVdmaCtCQ21oL0lH?=
 =?utf-8?B?WGxVNjB3NjlLLzBTZVNkbWJTZmRBMThnT0lWVm5oYjhjSzBtWWFJQitETDd3?=
 =?utf-8?B?UTVOWUNlY1FOcmNSZkdQSzN2VUl0V0Z3YnFxMm9CMG1RbmYxZmVwbnM0M3Rr?=
 =?utf-8?B?bG84NFRVc1hXT1orc1ZHejk4ekRDZW04MmZDSEdTYUFyUUVsOXBrdU1PUGdk?=
 =?utf-8?B?bDN0R1I2VW8zTC9MaTF3N3lseGw5V0RZS3VqWDdCdSt0Rm9ZT3BOUzliZmQ5?=
 =?utf-8?B?UUowSDllM2lOYzlWbm1ZY0lrVGpVVFlJcllHNWVtUnZtazUyRStFaUVTQTNx?=
 =?utf-8?B?Vmw3SEJTUmMvN09EcFhoVTM2MlQzNzB6ZnA1OUVid2RnYmFDb2NwYkV4am9M?=
 =?utf-8?B?Y3hKaGtxUHZRYWZ0MlMvTmx2RE5tRFMva3dIMnY4Y0ZlZWNZbTFRZkZISk1M?=
 =?utf-8?B?OG9KNFlUdHFha3QzQ0JoMUU1TXRHNzF2dGVMY0ZNcVdUdUlWL2orQ3NJa3N2?=
 =?utf-8?B?REhjQjdhaGgybUZYTGVRK1czQUNBUFFCUkg5WGxhOGhBc1U4NkRHWlFLVzJk?=
 =?utf-8?B?Q0VDM2lUUXJTaUVNSU1TcWtkbFBiYmxQelhxVEk2MkxPbC9KbTluYk16d0NT?=
 =?utf-8?B?WjlPeTJ0YVo3TVA0dTBRUVFPdEZKdFZIODMrbkxSSGo5SEhmcUNQRENJaUND?=
 =?utf-8?B?eUtxclA3anhjQXdCMjJNVzFhdmdXcGs4cUhESG82aUN6UVhyd3V2MHZUd28z?=
 =?utf-8?B?OFM5WVZXWWRrNXE2bjFRLzJEZkNCQmxFN05OS2pGZmxjODZRK2ZGMTllVVNx?=
 =?utf-8?B?V28reEJxRTdoVC96clhYaVkrVkFTdXhDSEo1RzNLNkg3OTVncklGZS9MRzJm?=
 =?utf-8?B?aTRzWFgzTm4vWlJSMnNsWjV3enErbGdIN1gwd09ad2hvemJnbzFJUWluOVNp?=
 =?utf-8?B?ZWdBaXJ3K0hKVGRiREMvOXVXTTN0SWJuUTloWXk4cTRGY3BBMWVhbDljSURB?=
 =?utf-8?B?V3BVcEwyblQ4dHlZRzkvcTE4R2hwbU9nRUc2dDhUZExFSndCZ2pBNGdRM25Q?=
 =?utf-8?B?ZnhDaGlwS0FJSUpPcEVQT2ZySzJ5NVVPc09mRmVsRkhsL1RSZEhpd0pXdmxB?=
 =?utf-8?B?WUg0SzZnU2tHNVl1bi9vMHMzb002Mk5ka2s4aUMvZm9RUnZtL3oxL0dNK3Mv?=
 =?utf-8?B?bXZ3Q25BaEtycmt6WmxQUkY2Smoyd2JESjlBOUtUdXYxWDBUcHNValZWU1lZ?=
 =?utf-8?B?NnVpM0pvUDdEZnNJNWRaVWtoU1dXMGtSVFUxNXptb21Hamc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStxT0RrNzZRd3hKTlBSbHhKemQweHVYVnR6cUh1bW5xbHcyOWs0UXQxMkNJ?=
 =?utf-8?B?ekEyMTRNODFmOVN1WDk5RldlN1lzMzYxVW5FWVRSUG84VkYwc0hYUHpkVUNJ?=
 =?utf-8?B?M0lITDhLZUlPVHJyb0cvMHhjZm5iZWNyNWtsb1hGaS9YSXpFVWZoVkxwMGts?=
 =?utf-8?B?eHZZdk9GdzM4Y05YbWxlOFNyUWlCYXZINlY2U2F0cklGa3RZYjVXTytlUHla?=
 =?utf-8?B?T2RJQ0taUmpDa2srV0c5NEkwZ0VvTHplcnlhLzNvRjVDMFcwMlFLWUpPK3c3?=
 =?utf-8?B?SkMvS2J0Sk9ncE1LWE5nOGZiQXgxT2V0aFRwTWxuN0ZPZ1hCRkV2V1RpVldv?=
 =?utf-8?B?KytFMEY4bHZnMVpHVzdZRldCRkxKMjF4emhJN3FNc0pjV1RkRjVxMStiWkZO?=
 =?utf-8?B?bUF6NVg2b0NoRlNYeTFmUGhtOTRrQkx4TFdEY3FlejIvTW0yenVWb1AvOG1i?=
 =?utf-8?B?cDlsRWl6dXE5d3dqU1ZoRWpRSFF6N0FDSW9VNDRHL0JLYUljdUViZHI0NDA2?=
 =?utf-8?B?eFg3czlTd0tDSHdlWllMTlpublZjdHluNWNTVkozc0FYNjg4T0orZkdBS3Vu?=
 =?utf-8?B?eEFackM5WHFwaDU3THIxKzZIbFhBMmdVODczTTJMQnBnMW1Yc2FQbVh0cGU4?=
 =?utf-8?B?ME9YOXNycUFVRW5rOC9YN3RyOUJyTDVsY1dGN0RBN21YazYxRWN5TTFQZkxx?=
 =?utf-8?B?U1hyRTlmUndldHlBejY2b0FiYWxkb3VwR1ZBcjQyU0J6Zk5HbUphaEF6TDE5?=
 =?utf-8?B?enpYcGx2Vm1SbWptOEpyTnpodCtQNTEvaDZ5T2ZhbFRpRDlrSEZIOEhjSmVP?=
 =?utf-8?B?TUZCcEYzVGhWK2VmM3dFSVAyamF0b1cwSUQ5dzhUK1hTQ1NQMWpPY0k1R0dh?=
 =?utf-8?B?V3UzdUxrZnppQUZZT1EzeDZOc0ZhTE9tVGJRRFQrdUI3c2hwTjlRYnJHSXJT?=
 =?utf-8?B?NTZucitnVC9ZKzR6RlVscGNwM1FKRWxydlhkVUxlaHl1UC9BVVN3NXBoRDZh?=
 =?utf-8?B?QnVCNnJnUjQ3cXJPRGhkVUJXYS9BK2VnRkJObWlvRFc5c2VYbDdWOGw0cDlZ?=
 =?utf-8?B?aDVnUDA3aFZOc0R4bnJ5OGJXdVNIcU10dnBZeGx1YnU2TWREWFl3SkRxSzIw?=
 =?utf-8?B?TUJad25kYVRocTVjS0JObWZpZUtrRXNSS3RBOFZzQW5rb25NbTRPblBRblNW?=
 =?utf-8?B?TDBrbmZaK29GNUszcU5KUzBsRGpTRTJGekpXUGdUS1NReE5oQ2hiTFdTL2VC?=
 =?utf-8?B?RCtNekF4anllckZWUFQxbmdqKzVreis5Y1JHT1hJSisrMXdaVWdyRlBTc05z?=
 =?utf-8?B?RldFZWxQQm5JSU9ISExrZ3NpOTlyblV5OFBQckxrNGlpZTk2Z2RaK0tCUHo4?=
 =?utf-8?B?OHZFc3ZWN2lzSk9kSHh1dTljMEZjeHQ5YXRZYUhiSEMrdUtlMlFYSEdOZmpK?=
 =?utf-8?B?d3hTeC8xZTBLOFBmeDdZWmphV2V5NGwvS3o2OFphWVRneWJEOWRZT0l3MlRU?=
 =?utf-8?B?MVBpUmc4U2ZOME5DcHgwazJjYUtHNVhnV3RhQWc2SllkQkIxUUU4QUdNYmtN?=
 =?utf-8?B?S1pVajRWeTE3TXpjd25yUWZLVkc2ZVFDQldFMDJXUmI2Q05yZCtnOHROdVVa?=
 =?utf-8?B?a2QrUlYwTk9BQ2FoK1RjSk5GY0p6VGFjRGR2ZlRMTkd3d3EzVnkrVG1lY0U4?=
 =?utf-8?B?bUNLanhGMWMycHdZWE0xdnRmWFdFMjNuTmZzOENhbmRsaDZueGtZNnd1TnZ0?=
 =?utf-8?B?NlJPZ0hUeUY5V2h5cG1JMGZWVldHcHhQU1l1azNmNHNIblZ5VEYrMTlVUFYr?=
 =?utf-8?B?RExyNHVOaFVKaGlDV1hMdTNycmloYUJPY3BFd3crdmRZMEdIZ1I2SzNDOGR1?=
 =?utf-8?B?N2F2L2cwU01KdnZaQ0pLcjFUMXNCQlVrNTk0clR5L01id2FiUnVuVXJpaERB?=
 =?utf-8?B?bUZNSlVXdURPQ3JVcjB2c1pLK2pPTUFHWnVkdnliblpnTUdUMHY5QlNFbjlI?=
 =?utf-8?B?aWV1Z09QQkU4RGRxMlZJRVJhSDdlSE9YYnd4M3RzTytHSnpnN2JpSUxTdzd2?=
 =?utf-8?B?YW1TRHhFM1VnODZVSWJGMTRsSjdBVHJLY0h3dUFTZjlCZVB6aHNpVjBtM3Fz?=
 =?utf-8?B?SHN2ZmdqcmxwZ0hucTdwQThhTlEwSk95N0laaVhBOGQwVGVCNVZuQldMakxW?=
 =?utf-8?B?TUhoeW1Udmg5OXdmY2ZGeEZoWGRkc0JsZ1o4bHlxZGtVTE0yT3FBdFdKbUZp?=
 =?utf-8?B?aWkwUTMxc0RreGZ5R2h4dGFVdElBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8e809-fbf3-4291-0c5b-08ddbb04950c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 14:10:51.2070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpagbbYSH6tUbEXDff2W2PndcTNzYo8OZp8Ac9XdeAUNszabYBgQnmm7XcaWAEIkAU/bdZYL0dV8Y8S+rCCUpBHv7PSmOtI5AqCsW/kKgbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9087
X-Authority-Analysis: v=2.4 cv=ctGbk04i c=1 sm=1 tr=0 ts=6867e0ed cx=c_pps
 a=PUAjdIoGeqohqgimoigyeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=aqeCdxMHYQgX1PSeTiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: z5X-VdKwf9xUDYra3c-kNGwfX-6r2NZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNyBTYWx0ZWRfXwHz0iGGtM3ca
 kktOSn7yT1FunpmxjXrpDsx+Jd3HSPzmK6fzPPq/ueHKQl3+cDWGqXLUumZxwexCB9WpWkqn53F
 DSnCWDP14RB/7oWNoJL0bSNKaCmXaQIvlGzUHApuXKkoWAtSZ58ZDEJ9zZfAQ8HUn87DpJjP6Ps
 NhtpBodrq0XKHA4MEB0Rlxrxv4ohUnoP4neAuO8VhSIJXTDtfrZqZYWkGjUaA8aL1ciOxIkSuCP
 kuKyaQPnbJAmBLX6gjWuno2Ra7y24bb8Q3S066TBCLs+bKv8rGQNPuW5ACHdx4JUcETiGrhe0/O
 KimVF7U6a7+1z5CxoGgB5i47X8D2M4amzWGiOUwKMOMDsH43bda8ArH/UsDh7S0meJhJEiyGgN6
 HnSOYIqzea6JZjX4msb5Xx6ZqfCur7M7KiPQLodnm167b9aK2g9LL0jsDdsxtQ4YY0iD27HE
X-Proofpoint-GUID: z5X-VdKwf9xUDYra3c-kNGwfX-6r2NZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 838ab9e15e..f07ae6da26 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -427,7 +427,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -462,7 +461,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


