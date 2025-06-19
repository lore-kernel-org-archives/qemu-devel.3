Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4F3C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNg-0004GJ-3i; Thu, 19 Jun 2025 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNe-0004FP-Cu
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNZ-0008EO-0K
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7OixG013270;
 Thu, 19 Jun 2025 06:32:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6RBYi8DRdfFPyblcpIU+rmlgrdPrUkTwUjNnhdmQB
 9Y=; b=ZEiLGuCCMfedubP/tRTLykdVZ4v4c4bFXS5yw5VFSX9S+z9JyNMLdHkAZ
 8huYaiPUPCPcs46tni8yXQb97zRFTjxaWZPGO0TMMfq+wsmpx2OiRrGlVXktDngi
 /sPzfMEm3eQjefYaAEhp/ED7vVwAMX4wrILihzXf9t9wYqgc1qblz5twh+EHaoTZ
 chsRxTbJNIW8hLAPGwW2UYL6FETraIIb8wT4bUiYDP6/k+WaLd/LZ+7lwbi9Npq2
 ASdbGHTl4789tQhi/0Moes4lCDx351YneaGx0cEBZ0+ZzuI5kyDEYDQt8BcjpVmX
 sFug9gKVzKQTh7BMuqNQ971abtKOA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020091.outbound.protection.outlook.com [52.101.85.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwpg-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAzCmyZyCeGG14/Si1jni9NNL6Xx62e4vPKjW6h5tjT8Z5BiRwa3mBsq1D5Aaz5FwIyLzHP8Ka7vZOxTebmdJH/T17ElQ5QKfCsbdz6Fm3AT9EgpOhNEsQl5745OxtUt9qNAUe/b9Fh2ONQ1OMR0Wj3IMsAlNz9yzgQi15tGbk+6K1K0wD/Bxa4i+bvMUeYjyF7vpVqg5uzD38trmsktCsLmmVP9B/tP2WvHM5oXID8nYs0f9cRbIZDBW5NSClaPMTO4X9J03z3fFyzRN6FZ9ov/Owmd9Id8XCj+w5AhUuX512Dh+xi6JsTQrdDnUIhT/YI/Vu97C1rYg+f6VMycjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RBYi8DRdfFPyblcpIU+rmlgrdPrUkTwUjNnhdmQB9Y=;
 b=tQp1hrPaexD0/nuvWy2E2s76nk8dgePAkR6k+pI9XvAl5bbRaCZkhVpWWbmP+jggwh8rSvl6zyw0wB4MSl3TC6Fey/C85MTCsteQKSLxoc4ltlz7ax8a3KnJDLD9wUofW1VOaqQyFMvKgT0yNSFlItIavWM0SKHsjalV3OvVu+LTXtWsg9pr/iBWkPPN0kxyjVVEgYyNKBd2F4sVdn9gQ+OBCYTIyCpa4Y2205+oc3xhw5me2gTUJgrpc8Q6WyxXYU2mBtVP/C1JWGeNmotRvPqKy2sAmDHGO0g45W0VnTxXHskeNBhxM9IHmKGNSt8KJ5IB+29ySPkNBnTTK3ECag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RBYi8DRdfFPyblcpIU+rmlgrdPrUkTwUjNnhdmQB9Y=;
 b=Dw6biigi6awCJt0/tw+hLrzZsLfyiTBg2vFF3wPc80b6EeX7FPmPZo7L5T8vVTWt6br6w/zUiJaWcLJhfVfa2ylQv+rpmC5m/7l3WmytJzqZtS7UCL7j7esdq/x06N7aO9Wznp1tPb9MpkD0Demnnm0ezgQR+IT9jiK1s5qUGmNc+xINced3H0TdY3VCjByfWDFQ0PeCHHBrxKBZ0PMOScrcrcgEP87X/0FQyWRsLGN5DazU6hQlJHsesAURBNUuHZ4qwmlZZo5K7slxFiT0Zxij6oCJcW0iKYMU9Ujz4dn/VsvUxad5+g2BmtYXbxUyFoRkzZCDi3GOPWNa9ctGZw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:12 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 05/19] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Thu, 19 Jun 2025 06:31:39 -0700
Message-ID: <20250619133154.264786-6-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3a0cb5-2bc2-45c9-f051-08ddaf35b20d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTUzKzJIbFp3clR6U2htVG56eW9SdHVSUzhxU2Y4QlA0SGFjRDVBMWVtZlNF?=
 =?utf-8?B?QWh0V202RytnUE92MkRMaGdxOUJ6aGxrRFpRcG1Wc0VOTnFUTTV4eG8xeE1k?=
 =?utf-8?B?MzZNOFB6d1FpQlZaK05hc2w0UEV4cnYrQkJTNWlzL1R4aDRYSGN0d3Fyamg5?=
 =?utf-8?B?K1FraWxNWmphOTMxb1pUdjU5a3h2V3ZvKzl2amxYSEFzMytEY3dyOHNvKzdC?=
 =?utf-8?B?ZW9Qb3dLWUdUdFhWSS9mdVpoeXFJRUEwdm91N1VJRlVKbDBJNzdoVUs2Sm43?=
 =?utf-8?B?d3paa2dhbDRNUllDN2QvS3B2NXpsY0dGc1NIOVprWE4wdGRpcWFBWldzTkNu?=
 =?utf-8?B?NTV4L0l6aVRValdsWGRxczJyenlOb09sMlUxeXFWbzZwcm1xMGxSb2ROUnJs?=
 =?utf-8?B?NkZUaUREZHN0SkxtanpVNk1Md09pbjRiQXkraitPQjY3eUxpSUs3RnhkOHdO?=
 =?utf-8?B?c2NuamlrRWJQWnBEby9XMDN0bGY1dS81Q0NwRDA3UFpQU3lnb2t6Ui9MYWd6?=
 =?utf-8?B?KzUwdERobUxmdjVLbTJKemtqQlZUMkg1ZmxCam00V1E0WExFdU1DQnIxblhh?=
 =?utf-8?B?cWZvMXNEbStkeURRMnVjeVZ6SzEreS9GNmFyZjA0bVc0bEF1VkhwTExDUitO?=
 =?utf-8?B?NlZ3bWZhekcwUHdpQlZ1ZlFIUWExZ0NPZ2ZNREl4eDBiOGZCdTNoVStJVnB6?=
 =?utf-8?B?YTd6MW5rZkxkTVVxOVY2THR6Umh6TWRPYXA1NGtteFFSelFIOVdRa01nRUh5?=
 =?utf-8?B?dlZyeHMwWWwva0hIOGc2RDllMEpBRzFLdjRhRTZ0Wm41UVU3c01TaU4zT2tV?=
 =?utf-8?B?QjVQdGFWS0FNZXFsakVrbUdSM2U1aEZlRGhsTHNhYkpESlZHM2JtWExEdVNs?=
 =?utf-8?B?TFhVd0szVyttaVB1QzVwNkx4TThjQXIyeUlqdmw5TWtsbDBuQjBaSU1TeGZO?=
 =?utf-8?B?cmdFNzhTaE5KZ1NrV1o3MFVqSHVvQU5ya3V5YmNhWUxmdFFDT083d2FTVWxC?=
 =?utf-8?B?eHVPcmRBbDVNRVkyY2N1UlZzYXFjemo1VnZrc3FDZWZ5RytIbDNYalhERTIw?=
 =?utf-8?B?YTkyWDA2NE5GSC9US1dmT0tKZE1WbEx5L2JwUWdZTllOdlhEVjJHZ1IremNp?=
 =?utf-8?B?Zi9TVzlFT3dMMEY1ZE01dDA2aDI5b0FoMXE1ckhVVmZnUW96SHJjc2ltNENK?=
 =?utf-8?B?NkZBTEgyRVFnVnlxVFZ3dUszNXFhOHZ0azQ3VHVpSldiaUZ6a2RyVVIyQUpx?=
 =?utf-8?B?aC9kMHcxWWFDZ3hrTHNrOGFiY0xTaEY4NVQwMVVoMVRmakt5d08wa2VvUEtU?=
 =?utf-8?B?ajNJcjhRdG5BWVBXUkxQZEcwRjhNYy85YS8vQ2RaVmNlWGw4TXk2cTdyN0lr?=
 =?utf-8?B?NEVLSmtCdThiak9tcWc4UFRlNmR2WmlEMGgyTUhnSU42RldwUlJmdVdPc253?=
 =?utf-8?B?bEh5VmxEbVovWDNSaUJHTjM5TmhQUmNneng1VXlYVHAxL204OXA1VnBUaHNt?=
 =?utf-8?B?OVhEejJhZEhLTnB0UjA5cXhqZFdhT1hjZ1duMjR0SmNZTzFzbUNRMERoenVX?=
 =?utf-8?B?elN6UUNCcXJuaVlGSkRCejhVS1kwdWxUalJOVW1tR2tMQU51TTZJM0R0Z2dI?=
 =?utf-8?B?OFMrcmxRemo4dlN4dHdrYkNPcU9SdzJoL3dVOXY2SWF1OGRCOU56dXVvOFE0?=
 =?utf-8?B?ZXhoWTN3Ui9IcGl6OXordkkvK0puTEFhQlJodm1tRWdhU3pHWmlwcnVCTTdT?=
 =?utf-8?B?NC8yejRnZXMrRXR5TXA2V3orK2V3Mnh2aUxGZmEzVUxJd0V1bVhuMjJPZVhz?=
 =?utf-8?B?WlJWT3VTRk1FNGpwcVYvdmVmZER0T2lXblZsZU1McEdqMlVJOXYwTUlqU3ZR?=
 =?utf-8?B?U2krU2R4akwrS0VzT2k5UnJ2bVhwNDhsdWg2anI2eThwMnNmcjVISnZaWEFp?=
 =?utf-8?Q?aDsQ66WTWIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlLTi80S0dHY0QzcVhWWHl5dGxzdE5ZSm5CY3A0b2pjUGpPQnJkbjNTaDBM?=
 =?utf-8?B?eEIwc05IdmJOQm5IdnJlUWdCN3NlVmVRNnZpV1RiNHF6UUVyREU5cloxU1la?=
 =?utf-8?B?ck8wdk0zei9pVG9vRHNZc2J4RlNyZFEvSExrYWlacWFSN1JwTW9FQXkyZzU1?=
 =?utf-8?B?b0EvMEpPaEoxQlJVbTE4akw4S0UrL0Q3eTVoYnA0SkVjWkQzemRXQW5TVWVR?=
 =?utf-8?B?N2dnTXlyWmlSL3VyOXI4eUNRRWczeHpHb21Mb2l4RXltejVKYitsOEdjM1Yw?=
 =?utf-8?B?b2g3dGV3dmM1ZmF4Yk0zaVlxOVc2ZzFrdWs3L2xTeFQrZEErUWh1M1hXSnc2?=
 =?utf-8?B?cXlTdGFacjNlQU1adkhqa2JGck5pYTRjV3YyZ2F3dk9neGVuSGVDTW9jWlFE?=
 =?utf-8?B?N2hOMlp6T2RsVnR2UW1ZaUhzQlRnQnpTbFIyVzlZZ0Vkd3Y2SDhuUnRyaWQx?=
 =?utf-8?B?YU1QVGxOWU9uYzJkcVBjdjN3OUovalhvcWJFMG9CS0ZPWi9ER2xKUGZ6MjlZ?=
 =?utf-8?B?UVpVckVPM1pJNi9sT0RNRURzWldFRGtLUndmWlhlK1d1NE5OQnZHU0REWEdl?=
 =?utf-8?B?Y0N3VzV3OHJxalhWOU55TGpSSXhGbmk3dkl2NGhMcVhSVHlPNEZCR28xRG50?=
 =?utf-8?B?MVZ4a3lpWmN4ek9tdW5TeEM1RUJBV25ybkhxcFdDUVc2cDlUbkxFNVE3MytD?=
 =?utf-8?B?SjRKcnlaS3ZhSjBmb2hpS2o0MTcyYk8vb1lVNnpFMnJmV0lPaDYyVngwMDVx?=
 =?utf-8?B?S3pUbUwxTk5NN0VLNzh3QmFkZGpOb1I0aDhJMTdxWEQ2bHBZcitGZ1QrS1JF?=
 =?utf-8?B?VmtiODhQcmJqQlVRN2p1d1FPMzR1SjhLczB4bytsRGsxdlJDZDNMZC8xaXlL?=
 =?utf-8?B?OXJMUjhIQ1BYMUNpRWJjcWY0NStiUDFjM3pORkFaMHNvc05JOGFmcnpoQk1a?=
 =?utf-8?B?SGVtdkVsRWtDbnRSUDk3MkVoNWVSTnpmNkk1elJ4YVlVKzZCaUIxQlRPSWg0?=
 =?utf-8?B?aUpIRGNjWlh1MmhQRXB0bVBqQlRmSVdxTDgwM1VZUFFJUndPU3hmT091REI3?=
 =?utf-8?B?RWFueW5PcUhlVEw5bGpMZHdXWlBEMjJpcmlveGVIN2VNUzJvOWxTQ2wzRDh6?=
 =?utf-8?B?L1lFdkl5aDMzOXptamFRWURxYkNteEN4eSsxRlY2cmlqRXZzYlZzbUVYT0dW?=
 =?utf-8?B?OEZBNnlHMlRXQm1vNko1OWxEa2pFbENJaFQ1VUdHUFQ4L2JoNGE1MmRXU1RD?=
 =?utf-8?B?NWZkaU1NdU5ValpxVzVNVkQzRTljeDN0ZGZPbUE0K29oR1Jucy93TTZ0cVJC?=
 =?utf-8?B?dzFMcFFzeENobGkwMm13eGpzN3BTdG9TRVNwR1htMW9mTDdnbHNYcGtrZHpY?=
 =?utf-8?B?d0w3bWJIdDRqbkRqRkorb2J0cmlvTWcwQU9KbXVYUEZJREpjaWxYMDF4K3Bq?=
 =?utf-8?B?NlUzd2tmSHhPL1l5c1JOeWsvZEJvUCtFQkNoV1FsVyt1QnR1ZVZ1bnB2Skww?=
 =?utf-8?B?cnp0RzVKTUVuU3M4a2FuWVh2bkFjTFRjZ09xczlNYkVuZU45MzJJSzVNY0pW?=
 =?utf-8?B?SzlIM1RnZ2wwajdNa3RUTmpheUJhbDZrVWVJeWw1c3RaWkxxSDRKQ1lTbTM1?=
 =?utf-8?B?TEdybmR2bm5MUmlnQ3BTMGJqcm5WSnBRUGdnSDBzcTFwZVVSQU9sZzY5OUls?=
 =?utf-8?B?c2R3MXM5cURMOUhGU1RCUTk3TDZzWmRINUEyTFhBUlFMUzIyNDZUOGlEYzgv?=
 =?utf-8?B?d1JPeVgyMnowOGFWZDRDRjIxdVh2d2ZUeUxya1RlK1JZZm5aQVJMZXJpSmN4?=
 =?utf-8?B?NlNiM0FhVlZDWCttaDZnVE1iaENQeEh0dDVpZHdkbURweEtmclpqSDBPZ2Vr?=
 =?utf-8?B?ZEhyQzc2dTZUQlV1ZVRVS2VoMldBVUd0Sk1HZStMYVV0SjRWUWI2Z3lud2Rm?=
 =?utf-8?B?TjZZd1BEK2Z3bXA2QURlZmtwRXJTTTFHYW9GNlZkV1liZWtoTTcrK1ViUXQr?=
 =?utf-8?B?QWxSR3R2emhxd200cUd1WUFZRGRwRGNwank4M2FqcGM2YUVYeG81TG4zWmU0?=
 =?utf-8?B?TEZrMXBDTjhJMEZPWGpJY0RLUm16TnFZMllBNUMwSkFVRG5WbVhiOHZlcFh6?=
 =?utf-8?Q?CRCMCOg/NVXsX65NidZKSJIhb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3a0cb5-2bc2-45c9-f051-08ddaf35b20d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:11.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv2w+GTEYaRWX/d3n7srOEo+IbhvtEaV6JXq2o96L2SqJxDoPlvk0gIrh//tACC5/l+BO++a/o0bbC3Xh3IXmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX6b8hiI0cFXYU
 i5ZnkOvYRgndrgafKO3fSxucFdUZp41l/cGD8AcB3E8LljGSUMIJO920wWZUaKDLf5X3TDLoWSA
 WX2pQSSbGBTiBQCz1E3u2YzauID7fNZHiffbHQ+1/1/gt9AW3q9YaQ3TbQq3ObgTBfIyGCXmJpy
 AoRFx03KGtVSRkm8hhEBZu+xwcPJAkHzK+ZskPk6o/LpQP1kwgUH4JCHTERAuxiVjQJa1zOLKiR
 bC7qeSTxEVh5i0g5hFpyA6I5/4cRgPed57lrCeARMN6Mlp4m0Zqu6f/Z1i3ycBah06nn64uqHIp
 1/DYiQA2RgNtfFXrf4WHZBT6dJ+5s6vKyHnFrFG0wis9fnYAodOPs9C+VTGYeGQzrBYt9TNDsMU
 fCRbrTJKsPKutC1BLfLSqZFVOxdtd8dOgyYXDh5l/pWkZ4HQX1VD+0ANoI701hmsJ/33Gw+J
X-Proofpoint-ORIG-GUID: UgS-FsQGVyl3Zh9ZlGZi66h60F5TE699
X-Proofpoint-GUID: UgS-FsQGVyl3Zh9ZlGZi66h60F5TE699
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116d cx=c_pps
 a=kkQK6hjpUACXm7ua2zl0Pg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=9e9T-0rTUHAn1w8HAtsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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
 hw/vfio-user/device.h     | 20 ++++++++++++++++
 hw/vfio-user/protocol.h   | 12 ++++++++++
 hw/vfio-user/proxy.h      |  7 ++++++
 hw/vfio-user/container.c  | 10 +++++++-
 hw/vfio-user/device.c     | 48 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c      | 12 ++++------
 hw/vfio-user/meson.build  |  1 +
 hw/vfio-user/trace-events |  1 +
 8 files changed, 102 insertions(+), 9 deletions(-)
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/device.c

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
new file mode 100644
index 0000000000..d6f2b56066
--- /dev/null
+++ b/hw/vfio-user/device.h
@@ -0,0 +1,20 @@
+#ifndef VFIO_USER_DEVICE_H
+#define VFIO_USER_DEVICE_H
+
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
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
index 2d52d0fb10..e0bba68739 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -112,4 +112,16 @@ typedef struct {
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
index 5bc890a0f5..bd5860e9b8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -12,7 +12,9 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 
+#include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/thread.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
@@ -96,4 +98,9 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags);
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize);
+
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 2367332177..664cdf044f 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
@@ -140,7 +141,14 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
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
index 0000000000..4998019b30
--- /dev/null
+++ b/hw/vfio-user/device.c
@@ -0,0 +1,48 @@
+/*
+ * vfio protocol over a UNIX socket device handling.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
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
index 0887d0aa1a..c6b6628505 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -39,10 +39,6 @@ static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize);
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -610,8 +606,8 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
-static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
-                                VFIOUserFDs *fds, int rsize)
+void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                         VFIOUserFDs *fds, int rsize)
 {
     VFIOUserMsg *msg;
     int ret;
@@ -782,8 +778,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy);
 }
 
-static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
-                                  uint32_t size, uint32_t flags)
+void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                           uint32_t size, uint32_t flags)
 {
     static uint16_t next_id;
 
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
index cb958d0aa3..54af0da585 100644
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


