Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE11C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2F-0007iy-Hq; Thu, 10 Jul 2025 04:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn25-0007eX-Re
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn23-0003Wi-QU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:33 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569LnSQW032547;
 Thu, 10 Jul 2025 01:53:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rf28l9VxXD8WH3voqalu+GHAJZPEicVxp3NdxI9vF
 xI=; b=konfmpQJH8mESR+7LGRmnlMZvwgqXtzTINMQJsjo9BB24U0Yo9mwCfKyP
 gIJ7ZEM0tWLH9YunqFxi3LWrnnoeGQzlJfYY3E49JEuLsOg8NyKUtFzA2X8xYYXG
 cBKVPmS3S+fXF78vbkHCxHDKZ4VmUglR7jd6gaYibgVdFy2y+WkCiO2F30ByH0cA
 Bid8B4O9CeQA6+S6CmHmVo27aNRm1SOKLfrVe3edIQkU44B8wqPhXr7N5EklHBmR
 bNfSiqoyfTue8Q0vIvjvBapWgmJlG45D3k1RDWyJgVZvMuMLY4gObyTEMcyvW9Gv
 QnWjq4uELHNEE0GgxzqpgoIyxTvWw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2102.outbound.protection.outlook.com [40.107.223.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1kank1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+dn2jZnMAy3LzjJ8wIRy53iLCm140XnpSNZZaEfvNMxsRNUh2oerhk4Dm8Jx/P815cSWJss0BCRiBNeyTn+IPt9zsSLC2Sl9+baEDBD0jSd91NfLAHFUwTqsSZgIL9ug1uUEhUUw30BO/u5Hdnu/jUlE4bOgFZd0SxYfYNV0PzfZJVcjMnLGq9SYo19AP0acjMH+4VzfG38zrwE24sCbJgf00wICO/9ebV/3xqfjJUTWyOw94ONR9WSKVAbN8WvXye5zkpdnWaenQ19bGERPnCgJtnZLKKfsavi0Ml/QNrh6jfDkm/1Odtxus+4RZLZG6i2VZvw0QDASKlQ3U/rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf28l9VxXD8WH3voqalu+GHAJZPEicVxp3NdxI9vFxI=;
 b=NeYjKZw87KszkppFqL7cUusS8g0NNMkQIrU4jjXKxdhamuuTaSedhjRSV3GP1Yvu/hQempWsXQs4kjYrK4W3h94tCl53Ogb5+gtR8iGXA4wkhs7y58cWiDGYZPnc5qptjjMd2XKGwUqj+xcEx1SAChfEFf0TLU8SOmHAyDuG5qfCmcg0qoK13uubRFo6J5bNeRtHq4UiaozdOBzZn6fRd8YFbO6JpgeGh7fqjHh97LpiJ0fGz9682rpsJgz8wr9nCj55ezDhCxdCQaQ/5ys5ptCryGux/QXkleobP7xcx1Lph37uJWjxbWOAaaV6y0xhyDJL7MJwgyG4Egr7ctOSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf28l9VxXD8WH3voqalu+GHAJZPEicVxp3NdxI9vFxI=;
 b=Wzi8aKx3aBqk+ASzp8zGssYc+UMtQRVBkIK+RBg6RvVh7DvWUYEgYwsu2d5AfQpjnbEiOPHHuo5vrki0yIk5KTpv+a6A+TlvYxaYc/x6sfIWu4qa++rOWI3H4eUNuP8lFVMbW9qmPt2pbtYbNQTfdVE9sMHnBaYPHTcqMKEl3XIHHkX1+mXJ99M48Myo6wcfFPFokqwrGqsVD+xe5FOo+TYR+kzkld49ekw15aisK7GtgDzhRvmHn/7YDC8mF6/iRUxiZiu0a541IjflkjhwaRYYP7oH70jqyBzOUuhgNu+OhQhJcG/4SXR6dhPa1ZZyrxVXs8L/f1WYoFH6b3HxZQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 04/18] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:19 +0100
Message-ID: <20250710085308.420774-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5b7c55-9ef0-4c00-46d5-08ddbf8f3ce5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdUWFlvakZsSGdCdk1VTjVtSFlMTEVtbnczUmwvM0FHV1Z2TzFDZllFbEtV?=
 =?utf-8?B?NlZGV3lTZlZKeWR3N1dvbkdRblpmWnhOT1N5ZFQ0M3lORy9VQ1JNOFZ3U2c1?=
 =?utf-8?B?d29NUlFlWjQrOWhpQzZjclBRNGZIb3RobFJIWk0zZGhDcnlXUU9IcEpzYXJp?=
 =?utf-8?B?cWc5Rkd3bFR3NFZ3MlA4T2NtOVp0WnB6OTlWcFd0STFVdHhxNGF4TVpuTlJW?=
 =?utf-8?B?SXFVVG5td0Nqak1YdXVwcW9DRXhIRDZCUUdLSHpnM1hGcU5veTJXalFCbEVJ?=
 =?utf-8?B?WC9jWkZUcmRLcTh0ZjZ6a2l1WU56MVZNTzVGZTMzYzJmeHYxb1pMa0orTGpZ?=
 =?utf-8?B?cXB2bm5Oa0xBaHBmcEhibXFqQ0NMTW1GaTdZR3lzcXVoSm1LSSt2c2dsYy9j?=
 =?utf-8?B?SUpZci9hRTB4OFBnTmlIWTE0LzE0RWFJWUtNeFY5VG9qenNLZFdSeGY4N2hq?=
 =?utf-8?B?RWhKUDZ4OVFGcVNaVVkwRllzZ05pbmpjRGdmRDhPMTdhNURtQ1Bob01jbDJ1?=
 =?utf-8?B?eG5XVXZrK0JFRHZHUUtlMnlOcGZHYXFSc1RMVGxUT09xUDhiYmk4bnR3Y0ZY?=
 =?utf-8?B?NG9DRXR5Mk1OMjl6cy9sanN2Q203d0huanpsbExkSGxEemZmWFUwaEpTNTVh?=
 =?utf-8?B?cnlMbm1EOHppWHR4V1FDT0V4Rm0vQkVvd2pQNEdraXZEV3RsSURYbnhRU3JB?=
 =?utf-8?B?b2E3bFcwd2F5TGY1Qi83TUVjOVNweGtjL1I2RWtBdFZqeElhYTk5RGd2a09k?=
 =?utf-8?B?ZDZwbWp2QjNoQUdrdkpwMUV0YUNkWkFTZkRpZ0NaUGx3blhIZzVkd2o5RlVB?=
 =?utf-8?B?ZTlyZkZHVklpSDhESVNTc3RvWnUxdkhpaDhiQktmU0p0ODRZbmkvTzBKWFV0?=
 =?utf-8?B?RkdLVTFMa0N2SlVOQ0NCa3pMemQrdWNGeXZJTTlGK1VhRTJjdm5WWTZ5NFNh?=
 =?utf-8?B?MkxmN1Q2eHkrWitnQlNVN1hhclROQmpyV0FmUjRtWHdBS01BaE9qZDdkMzBB?=
 =?utf-8?B?SWhmRXVCeVpOR1VkYWlCdmNPZCtqKytQTmd0L3cwS0puQ3BiT0FRNGUxYXI5?=
 =?utf-8?B?bE9GUGZOZVRJRXlRUWZDRVVUQk1sSEs3S1hISlNoVldyalUwU2VQLzlmZkND?=
 =?utf-8?B?MkluRlZKMW9wVUw1MXNmeE9CQTZlUzAzenVtWE5MK0FaYnBhUU1rZWd0RU5U?=
 =?utf-8?B?ZjkxVHNPSENPdkNZM2FROVBSU3ZRNERiRm9HdXdrd29FS1c2TWVrbXpFaGxB?=
 =?utf-8?B?SDRpN2w5cnlRcGJkTVgxVHIvU2dhK2dwamc2VStEWk51ZTdWK0l6emhST2pj?=
 =?utf-8?B?SG1wUEZNRlpndFQvQWxDaWVHUjNNR0JXMCtTN1QvMWgzL2lUd3dNRURlOHJR?=
 =?utf-8?B?aGNBWklBOHRtWlBibWdGMkF4anZVYU5BNWRNUzhUaGdGVmNpZ1JYbXZUNm44?=
 =?utf-8?B?bWkycytvZkNLdmF6aTVHSU1RM1FHMk9POGViTDhOUmg0SnNVbWY1RVBCNis0?=
 =?utf-8?B?dm12K2I4UzRZS2FqSGc0c0pMcDJGM201dWdJTnpTa2Vxc3FTYWsrSTVJL0lM?=
 =?utf-8?B?RkNqNlYvU1NvcUh5dDAxZ0JvNGphbnZhNDQrT0twdHp4bnhnaklId3ZLRlRY?=
 =?utf-8?B?YitvWUxvVmVPalVNNWx2bVEycUN0KzVLTnNVOUZuUG44elhYSW9rc1JQYlhD?=
 =?utf-8?B?K3ovSHRKaWxYb1RRTlZvNVJtMjduSVR2dXdVaEoyM2hNOVRybUVZdUpmb2lY?=
 =?utf-8?B?Y00wQTBsNjQzN2d1S3hRMTk4bTR6MXNSRnBmQkNwSFFUNGl0R0dvdmdET0Jw?=
 =?utf-8?B?WDhrOEdVS2FRaVd4eVYzMlNpRjlsKzJyNVg2bE9QcW1Ld1RyWkloSnlQVjYy?=
 =?utf-8?B?L2Myai8xYkFvM0FMdlJKaFZmM1BjNGF5d0poOVhjZzVlNHJ2d0JFamhzWHdU?=
 =?utf-8?Q?dUCfDaAaG2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlhrWTZGU3VlaVBNcTRiNEtSakE2WDBTZ0NpVWxyUGtVam9kQUYzcXQ1NmRU?=
 =?utf-8?B?enZNSGdHVjNocVM2RDh0WUxNZG9lTi9XaU54dmhCWDlnd1NvSFBQaUJFRHRa?=
 =?utf-8?B?VlFabHJudnBLbmdGM0JmSnVXTkdONXdtWFNpdHZTQURFQ0d4U3BzbitiaEp2?=
 =?utf-8?B?Mnh4OFllbFNVWFlJRm5ZdmZVU0orMnJzamJhS2R3akNZNzEyMGNXZVhidEdv?=
 =?utf-8?B?SHVuV2UweTY4Zit0VzlDVCsweEMyYnZtZXg0WEhIVGo3TTR0YU9OaUZsclUr?=
 =?utf-8?B?cmhZRTQvOEdrUUJ1L1hORmJXWmo5YjlsZXd6L2tpZEdjNVJoN2hBK0hVUlEr?=
 =?utf-8?B?Wk1nNlI4VU5PSVhJMWRtM1B1Ym9BTE9oUDF5NEo3eGlFb0thc2c1MHQwaWRG?=
 =?utf-8?B?MG1yR0NDbmd0UjJuNTg5WnVib2xJSGFxWmFJWE11d1I3N2NOY1NIRmVUOFBJ?=
 =?utf-8?B?QVNqQi9XbWhReFpaTlpVbUNPYVZRdFpLS2c2TXZxMzdoTXhkRlBacTN0YWh6?=
 =?utf-8?B?d3QwQThxdDd3a0NyL0RjdDYxRlh2V1VSbnpDU2UyQVZqNlhwZ2Z0SWM1LytM?=
 =?utf-8?B?RFdVQWx1VnhaSE82bTNVWEp4SXNEbGM1cjVyb3hQVDdIdk9SUko5TUcrZjAr?=
 =?utf-8?B?cElvd3ZkS2VrWm5wUHVZKzVJOURxTy9FYTR0MWNxS1ZSRDVGbU95Qm5LN0RQ?=
 =?utf-8?B?eVV0SHdSb1cvaEJrM0p6ZGNMTHYweGdKR1JnRzZuY0RHMlN0M1BkT2c1d1E1?=
 =?utf-8?B?VW1ST0ZFN2hFeEpzV1FzcmdPTXMzYnFvTDBzVDl5OVQ4U2tyNjZRaWJESFpF?=
 =?utf-8?B?N3lqRUVaRDdsL2NoUkp5QVI4ek41V2xtM0hIZWUydVF5S21rRFpMWTF5cXFT?=
 =?utf-8?B?YW9EN2ZEaWZEY3dIQ2RUK1IrNEh3akZzRFVEYWE0QUVBWFlTVHM3YThKcjdI?=
 =?utf-8?B?THRCNzNjNjF4Y25rVVE5ekNwRGFpU1lrd3JPcEx6RHpEbDZJclVyWU8xY1g2?=
 =?utf-8?B?dDFyeFVMNkc2bnB0L0d2SStqcjVnNnNNK213SldKOVg0WTRwMmMvVmRVM0Fm?=
 =?utf-8?B?VnJiN0NlZXd5ZklUbEdoVW1vWFo2MzVGUjFHSEcxMlZvMldWeUhuUmhEa3ls?=
 =?utf-8?B?ODlWNk9BamptaEF3WVhsSUw3REhaVVY1UExkTEdndHB3a2x3REFJYWF2VmFR?=
 =?utf-8?B?a0lUV1NJbE4wbjBXampFdWxQOVBBMHM5OFc3NWF1VW5zaHpYcWNKQ3VlNjdy?=
 =?utf-8?B?Nml2OEZodE4rSHZCRlJzdE9pcDRnWmVIeURQRk93RlRkaHpxZnN0amZtZysx?=
 =?utf-8?B?MjJFYUZYMmJwYXpVanRiRThRMmZFU0ZlU0hKUGtQVitkUUlaZFAxNElhd0RM?=
 =?utf-8?B?K3hpc0FvSkNPSlJhdWp2bmpWYmxod09DMjd5ZnFxOFZncGJVRFBvOEprT3pv?=
 =?utf-8?B?VFBDQjBUUHFESG9EUXpxaXJGTHRCQ2RHZ1JlS1VqTFZRMTBLZTJaMllFMVRp?=
 =?utf-8?B?Kzd6K3Y2VDhTU3E0bGZkT3dOdFd1MDVFZWtjZHYrZEY4Z2dxMTAvaEtTRGUy?=
 =?utf-8?B?bGxiZzNvNUVPK2ptVE1ZbVRNRWN1N3FTSngra0RPUXJETEJ1OFNvb3p5RWVG?=
 =?utf-8?B?WHN1QkNFMEIxNmkxV1FIUzdOb2dsNlI3VU5BM3hmRkdweVJzR1o3U01BUjFB?=
 =?utf-8?B?NU81bWV1Tk9BdmJpYmR6eUZucS8va3c0WmJYTy9VWG41aHJ6VDlaMkxCVVZD?=
 =?utf-8?B?dkxzd3p1T3liVUwzRW8walo3aCtySnNWbHBLN1lZUm1SbGNyVzJpYkpGejEz?=
 =?utf-8?B?RzExWityVUw2OU1aTTcxU09oMXBIV083cDIxRXBjZ2JHVkZ3SVNxTHpBYmo5?=
 =?utf-8?B?WVRGTnVkNHFwN2Vmc0hCd3lvSHN1ajY2a0Y0LzNySkdSSlJuV1ZteG1vZjB6?=
 =?utf-8?B?eHJXUzRnZ1hSTXBOeStQblo0V2ZFNWZJUXNoQ2M0bytMSVBYdHRXK004Y2ZR?=
 =?utf-8?B?eUNrK3Z5N0o4RXVnTzhEeXBWaUNlN2hYaE9wd0NIbzNnNUo2QnI5bUtNdnlK?=
 =?utf-8?B?QkZsYXlLZ0ZweDNyWFB2MlZ2WlZvVHpvakVXS1FBT20vUWZFRmJXa0duK1J0?=
 =?utf-8?B?OGozOGdUdXJ4d0hXcXJEdmFmS3YyejN4U0NTT3NaMVk3UmhQaUxTU0hlZHBo?=
 =?utf-8?B?NzhnSzR3QnhpV2tMbnFEbmQ3QnpXenhWMUQvZmh3UTNyY1B3ajZFMFByRElR?=
 =?utf-8?B?dXpSb3Y5Z2krREFlalpRSXB0YjZRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5b7c55-9ef0-4c00-46d5-08ddbf8f3ce5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:28.1458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6XoptXCi8SIWq7Ti07H+UbXHJpFnah7P4W3CwlvyrqrAlS5zAQZqY5tqG19e2djrxJ6VjCBzTLXRjn1ZyatLVikLxwZ0XK40xIGWOxAVGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX/Z7AY8aEiYoD
 VXkFGCP6AX1yMz05Z9cnNz/CbnSfOAcixwDPtkcKaVNBHdDa4Xduu3tVksNkAsfDBPmzFC3DQf1
 YhaCHW46u6KElENeJDvscKIsa2OACqM/Y6GFNk7N6+CdyzrgeXlvp5Rpw/tvAenQkHcMO4xlO0R
 T+DI0BkVK9+UsF3+wXAdOL5/xUnJtqJRx7b4OROzzlXg9S+pNpKYtBRMqy/Q9rEUzrC5QTkd+0O
 vYQJZfCj2VNr9nvIK7coOt+LAVVaB6FNeBHz2doU35vRZ+zlNnpSBKvGcXkf3orf1+Wbwb4rawL
 JwF6Kov4RznHYSQ9Io8fkp8wqf1Kio5boBLj1WxEp2PMP0MG8gzXufiPQrlwhUl1nzR/prLv6jq
 GiNa8OhvPsvm9bwOLTcaj6ztHT1QjUHhjQmnd/4WUXD+PLzbLVHJrWKp+rMkd7+o361wZIWy
X-Proofpoint-ORIG-GUID: aAr8mV7X2qyrEXyvEDl8NQFIytz79YTo
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=686f7f89 cx=c_pps
 a=mEzR6i2+MZAQiuWfcobVjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pDVciPHeplB8fhom_mUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aAr8mV7X2qyrEXyvEDl8NQFIytz79YTo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
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

PCI code will never be used for an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 105 ++++------------------------------------------
 1 file changed, 8 insertions(+), 97 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0928b905d5..548e81cf1b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -417,19 +417,16 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    const char *pci_type = NULL;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *pci_memory = NULL;
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
@@ -516,39 +513,6 @@ static void pc_init_isa(MachineState *machine)
         kvmclock_create(pcmc->kvmclock_create_always);
     }
 
-    if (pcmc->pci_enabled) {
-        pci_memory = g_new(MemoryRegion, 1);
-        memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-        rom_memory = pci_memory;
-
-        phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
-        object_property_add_child(OBJECT(machine), "i440fx", phb);
-        object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-                                 OBJECT(ram_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
-                                 OBJECT(pci_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
-                                 OBJECT(system_memory), &error_fatal);
-        object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
-                                 OBJECT(system_io), &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
-                                 x86ms->below_4g_mem_size, &error_fatal);
-        object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
-                                 x86ms->above_4g_mem_size, &error_fatal);
-        object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
-                                &error_fatal);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
-
-        pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
-        pci_bus_map_irqs(pcms->pcibus,
-                         xen_enabled() ? xen_pci_slot_get_pirq
-                                       : pc_pci_slot_get_pirq);
-
-        hole64_size = object_property_get_uint(phb,
-                                               PCI_HOST_PROP_PCI_HOLE64_SIZE,
-                                               &error_abort);
-    }
-
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
@@ -565,74 +529,21 @@ static void pc_init_isa(MachineState *machine)
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
 
-    if (pcmc->pci_enabled) {
-        PCIDevice *pci_dev;
-        DeviceState *dev;
-        size_t i;
-
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
-        object_property_set_bool(OBJECT(pci_dev), "has-usb",
-                                 machine_usb(machine), &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
-                                 x86_machine_is_acpi_enabled(x86ms),
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
-                                 &error_abort);
-        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
-                                 &error_abort);
-        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
-        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
-                                 x86_machine_is_smm_enabled(x86ms),
-                                 &error_abort);
-        dev = DEVICE(pci_dev);
-        for (i = 0; i < ISA_NUM_IRQS; i++) {
-            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
-        }
-        pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
-
-        if (xen_enabled()) {
-            pci_device_set_intx_routing_notifier(
-                        pci_dev, piix_intx_routing_notifier_xen);
-
-            /*
-             * Xen supports additional interrupt routes from the PCI devices to
-             * the IOAPIC: the four pins of each PCI device on the bus are also
-             * connected to the IOAPIC directly.
-             * These additional routes can be discovered through ACPI.
-             */
-            pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
-                         XEN_IOAPIC_NUM_PIRQS);
-        }
-
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+    isa_bus = isa_bus_new(NULL, system_memory, system_io,
+                            &error_abort);
+    isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
+    x86ms->rtc = isa_new(TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
+    isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
+    i8257_dma_init(OBJECT(machine), isa_bus, 0);
+    pcms->hpet_enabled = false;
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
-
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
-- 
2.43.0


