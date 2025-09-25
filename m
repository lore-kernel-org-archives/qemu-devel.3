Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3268CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFc-0000hm-Eh; Thu, 25 Sep 2025 07:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE5-0006df-K2; Thu, 25 Sep 2025 07:33:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE0-0008QM-9U; Thu, 25 Sep 2025 07:33:29 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P85XQr109138; Thu, 25 Sep 2025 04:33:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+qg/WKqBpPks2V1GviS7ZaYmr3e/ZTf/XqireqAkZ
 1I=; b=YOX6VCvrnVy/gJ8unGOh+dpBmSJN2pM5TIP8o8Alyr8MR2N9umaFH0mSE
 nWTv4N7WezRnb59NcGR55V2GRPTWJG8MP7JxrpO42/EkmtVHae4jLPaa450susRe
 ok/QJD6X+mnSpSeAyUprZbqZfMwebgeNcCdLqytUE/l6U3GUSgro8+MDZLnH16X7
 dwaYWDVcEr2Uitc5luGFR0/MWAjmMO3JnfYTgNiawg783EPDdD/Go/JSdJHCqx6P
 xGOOS00XttCIeDo4KamFyreC9+gOJVRik6Ct75fwDQvIUD7o0SDvWzI2UbrAvOEa
 OC2o5Nf5tpvK+isDowWckKEAr0WqQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022099.outbound.protection.outlook.com [52.101.53.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1x08e0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbI/o2PmxDzEw9lry1JJJxsrUoNvYK5EhKMfF0a2AsJFBZaGcvytZqLRRfV7Uw5zvadcpV6pXED9forDU5KwNvQi1iujlQ1hZiosXFGkVjsLHASzgmqjtaVPZ+kzH4BlSsxywCWrFmNhhaH9tQEmeGAhxpAXKrpIJ8v3D008FY9bbCbfq5Aj/k1B04zBrbwH0Zfz6nInn/OoY/8makOYzOMYrRyk4jcLgSfInY7NZmt+ywfuCDmWKpU+CShSoETNWGpq46xg3MArVymAuyGTjnRLTpldVUdOoYc8H/goSRG5nXKaJm8ukhkkHcx0MQqcmfXO8aGj8bPiIiWyf6qCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qg/WKqBpPks2V1GviS7ZaYmr3e/ZTf/XqireqAkZ1I=;
 b=Hqvf8kO4xXQSuS1mmTI7Dcqao2DikGno/I4UnedCK0DopUu2+2NR9hzly0qHypvpi+GRN2sWU+RJTF+YtnUqeNuDUug9ENCM7RLAgYMJE8m1T66ZYy2CXaY1/2CHR/FvFcfdEyhopgeVolbgnUHB8mptdPQtEMxpoy4xAztDuhWpl//rIu+GeuTBPUHHCT30A2OoVSu2Hggi84T+F1HgAkNY/bd596Uic77rTwa8/Dv30uYUliQzBdBPwU13cYA/0vlgL4gVCG7bizyfnnqYBrGt3RRYzUfBcWT34IJ/rvI88JcwM9DtC3S8HOixDSS+41AVneRUuSXMyGDByA/1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qg/WKqBpPks2V1GviS7ZaYmr3e/ZTf/XqireqAkZ1I=;
 b=yPn/83oEJmpIjPf+zRLD9+a/2KS7bjvJHxwgevCXEBeQN6rfLd6/AWDTT6Rop5diI5MWWaaLPLK/T+N4dBISKjBuXbX5yZiqe5Er8TRXMeRDDhTD9p59Mv9Dt4OKB8oAadl9wsyuuGxXH12xFsu8FLasaQkwQrVeO3xlSpWqCOiwZOQe+wNNdGZ+AtAKmAY2aCh7GOGF9loj+V5+CYXcLiQwBdn40TCy+AQAscSD24UaH1J9T87hG1smc0BGm5cr/+7Tyer9FQxlOelx3rC/ty+3vpOcf7g1M51xAqM0BmsterTIaSI1WX0SYScqFZYDV5d/qs5wqX7NV0gugtIkqw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:33:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 20/28] vfio/pci.c: rename
 vfio_pci_dev_nohotplug_properties[] to vfio_pci_nohotplug_properties[]
Date: Thu, 25 Sep 2025 12:31:28 +0100
Message-ID: <20250925113159.1760317-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: fa48e10e-11a2-47d7-ae57-08ddfc274e8b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkhkSjB4ZmFDZ1BHblNMRm05QnorY2dPRWVZVnJGV3gxOUhzUmIyMFJBSEJi?=
 =?utf-8?B?ajROQXJsNVhxdTduaTFPQ0R2VVFBUGMxUjM5cFNPUmZBV0g1c1ZNYzFRTmtK?=
 =?utf-8?B?WTEyekhkTEF1bGZaemQwc3kxaE1hbFo2Z1pIanMreHJZbCtEbmlORUFXeWcz?=
 =?utf-8?B?TXYxS254OVZ2S09wMHVocG92Q2VDNXk2MUhRUXU5R2NiM05wNUhMRVpONW1t?=
 =?utf-8?B?cDBmbHEvNG1kNDZaMVlva2w0WlhqcnY4V3JLNDREKzkrNUlHaEEvMU5ZNk5V?=
 =?utf-8?B?SWdLSk9kczJyOXNaa3FYQlVsa0VKOW9vdi8yb2NXVUxiYU0ycGtzYk9jdGxw?=
 =?utf-8?B?bHNndFNoWXI0VzVMWkx6N1dIVkV6SmdwMDRXRkUrZzJLQi9vRXd5MkwyWVR0?=
 =?utf-8?B?dHhKWVBaeTZBc0J2d0VqQzQrTmsxR0NHVnJNajM3WFdkTFEydyt3MDQ5Y3JF?=
 =?utf-8?B?TVQ0cXhwN2pWMjJmaGVNSUlxOTExaTl0Tys2SUlmaUhkZW5pNktkRk4yb0Yz?=
 =?utf-8?B?a29XYTMwditSMC9DT3QxMnNVa3hYU2h6V0NOWWZPUDNTc3BTNmg5UWorcE8z?=
 =?utf-8?B?ZnJTNkVSK3hWU3FRaFhndmtCUDh2ODRkcUwvUlpBVUJCUDlzN21nNUpNME1K?=
 =?utf-8?B?N0xob1A4aStCcXhIVml3cnV4YmJsQjRRSWxOZkZ0RXJCQm41Rks4N0xYT01j?=
 =?utf-8?B?YWFKMFBLVXg4SjY0akNaWlV0UjNyVUFxa28yMURacENSVTdRK3VNWG1kMnBK?=
 =?utf-8?B?K05INVJGVUllY0V2YWF5WTlhc1lzR00xdE5HYVFHaStUOElEelB2ZkRhN1g0?=
 =?utf-8?B?dUZQT3hFZDBkMDd6NVpURUxEdmZkUHhYdkErOUU1WlJQVDdXTW4xQTFyWFZW?=
 =?utf-8?B?ZHNiai9UdmcwYlFrV0t0MGhkTUNSWWVaWmw3VmVhYVMwd09VSGNESjRkaktF?=
 =?utf-8?B?ZzAvNDJ4WnNSOWlQUDgzVk5ENVpxc2VOeXRzb1VscWUvUy9sOXN5dG9LTEtv?=
 =?utf-8?B?UWhKTGNta0hnanEvTThIMXNOanhjWDdxOExVVWlBQzVvUGU1RUtCY3ZIYUVp?=
 =?utf-8?B?YlBjSTQwWU50ZzNIUzlPN2FpZFMvVDJkbktCNmNoTUQvWmR0QW9ucHRxTU9G?=
 =?utf-8?B?aDdnaHFHeEJCM0poK3hTQlNLdEkrMHo0a3IrMFprYWJ0cW4yeGdrTHBlejl4?=
 =?utf-8?B?Slg3QzVqQ3hvSDNwMEM4TmRYblM2dTFlc2tyUnA5ajJSTk52dTB0cFJ0eklB?=
 =?utf-8?B?ZTI2Z2VZM0s4YkdTR1lVRW41MWIyTFNDTFBaWHhwaGR2ZWRaSUhFRjU3VkZ1?=
 =?utf-8?B?RkJSSG85RUk2cTVJU1lKQS9IZGdNNG80T1JOM0RXVFllb3c5L044VEhWYi9q?=
 =?utf-8?B?S0FJdSswSk1WYjZySWM3blI3WURRUEhoYVRjYWpBajVPc094QXU1Y2VOTTZL?=
 =?utf-8?B?SlZvL09Nb2kzRXE3ZmVFa0FCSFBZS1NwNklpRjdrM0FiTkdOVjRBNnlkclRE?=
 =?utf-8?B?eDlmY2ZFbEsyN1hVY1UzQjl1cnE3Q0lhWWVZbUJQUStWbFpDaW9KM1g4aHFu?=
 =?utf-8?B?RFl0WjhwNHdLSCtpNk15eFlyRkZmTGFUWGo1MU9Kb0RkYUxkNmlBYzMweVF0?=
 =?utf-8?B?bWlQY29SZHlJaTBVOFBQdXpoampHUzJuQnc2eUFTM3RaNXNSZEpiOTF2c2JO?=
 =?utf-8?B?V1N5Z1EzVkRYU2hIVXdKanNPWFBtVGcvUEZTb1ZpL1dLaEU0Z2tGOUVYVTha?=
 =?utf-8?B?VlNhQWN6c3FmcGYzVnAwWDFST1pGQWNnRFduNjVpbFIxYXBhNGx2STBxenRU?=
 =?utf-8?B?d0luV2NTcXJTdmI3OExLMVZVMVhhalFnc1ZKOGwwL1N6bEROMUQwUnB2cG1L?=
 =?utf-8?B?T2hybTlFcVRWaE9KVW84L0xBWVV3WUgzanJKZWF3NmZ1QVduNjVGOWRXY213?=
 =?utf-8?B?MXJWT3lWVktVQzRxWXQ5WEhJTE5oMGFBeFdQeU9pUUpIY1RBbC80VGx3Nkc5?=
 =?utf-8?Q?h3jneoa4K86HRbbUpOreUn3eOFsKi4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VGai94d3dVdXgxSldKN2hEU3ZubE1DRmp3dkVTZ0pTdHE1K3d1cTVHZTlh?=
 =?utf-8?B?RGRLdFMxTFp2SWtnUU5PU2VLWHFZYXA0T21hamt6VUkzY1VKd1FyYXY1UERY?=
 =?utf-8?B?OHpDQVUrcVQ5QWdJb2ZlTGYveHJ6UnU4cE1WSk8wWXVmRSttS1IzM1l3TzND?=
 =?utf-8?B?VEYwTDVyRFo0dWVMaEFFQ2ZyVlk4d2swOUlnZ0ZuZHNkb3ovamFPZjlwZDBr?=
 =?utf-8?B?STFoaGdNQzIwYklzV1ZuMmFKNjFpR3ZKYlNZYzYvaDBjem9NUVVxempocmgw?=
 =?utf-8?B?cjdaR2lqNDhpUXpYU05VZDhmUmw1Zi9kbmJSQlU3aHo3QS9vTjdUNXdvQXZu?=
 =?utf-8?B?THFxWlR3aEIxMWVIUWt5NDFUMHhJaG1FQTd5NTdBaUJEaEFTeWxkcnMvM1RE?=
 =?utf-8?B?N1ZZeXN6dXd2MXVQRGNMbnFjZkl5M0pIMU0rcWp6Y1lnWDEwbkE3QmJ5L1Zz?=
 =?utf-8?B?VEEvOVFkUElvVCtvNzhjaG4zSVNKOFQwVUp2ZXB2L1F5WWtxK1F0REpjSGpO?=
 =?utf-8?B?Y2VEb2tzc0ZzVTJadjY1aFl3dnBHNkUwMVBianQrM09vRjA5cWdhb1Q3eGp5?=
 =?utf-8?B?S1BxMnYwcWZPSXN0TGJ5MWRORGhBUnF6bFZuWU5PN3pFN2dOTlBiblBYUDdN?=
 =?utf-8?B?SjgyY0RCbnppT2ludTJ6MVBHLzkyNGExbm9kVzQ0a0dldHJHMjlodzBrRHkz?=
 =?utf-8?B?MjR4a3BiRFZsTFlSenM3KytZaUNrVjB2aFZTMFFBN1laWFBKcFhFNkcwc3Mz?=
 =?utf-8?B?SmZmc25FdC8xY3duY2F5YTBDR2kySnp5MGQrRFJxSXdUUXZsSGgzZ2Z1ZFBh?=
 =?utf-8?B?dDI3MURSRzFWQmdJUVNnMHVwTVU0MXE1MjVNN2FLU2dmOXkzTHhNZ09oT0ZX?=
 =?utf-8?B?WGxwelFZY1RCa0FkVEV1c3VDc2U4eU80VWJMSVUrSFpUS0tMVjRFZ3VBWEQ4?=
 =?utf-8?B?UHR0amM1eUVCVm5PK2pOVE04amlPbVRvcU5FZ2JlRDlxa05aRFdJbEVORE9V?=
 =?utf-8?B?WFhmWFJrSlprVXlyL3d4blhBUDlBOUFVMC9YQXhEQ0VUVml3SFh3N3p6RnVs?=
 =?utf-8?B?YW80WTNyYWs3R2luemZnemJmNjVvdGJzeTlUeFJiOThJYWlRWFFtK29ySDlp?=
 =?utf-8?B?SGdwWjN2eHBHYm9hV3duaXpZUVdqSXJwOVVQL1N5WU5TeFBnZEJBZ3FyUmVo?=
 =?utf-8?B?cGU2dkRRcHVER1JEUGJmNll4R04vdS84d1E4SzY2c1paUGdMdzNlSTEvbXpn?=
 =?utf-8?B?TThuRHQ4cC9pcXRnMWFiNUhUVFVSOU5WL2VTdGc3OTc0VCtuR3liVzI1M3pL?=
 =?utf-8?B?bjBFWEJZbXc4YytCMkVrRVQ5RTdxZlU4bStoblNDa2VLRDdoTzQ0NHBnbG5F?=
 =?utf-8?B?Rk9PRGtNaU8zL282V1IzcWpiYTJIUVNja2VOSDdIT083RHpHM3J2WThDM3FG?=
 =?utf-8?B?NmxPckpMeVhDSVNTVW9XcWtJbWl4WE5JNzIyYnZwdGhYQ3hwbkVuYW85TjNB?=
 =?utf-8?B?aHZUaElETmFPV0hJdXpGSHBUU1ExSnRrZ3diV2h6V0ptNEhIeGpLUVdvNnBX?=
 =?utf-8?B?VE1uaTlnc0lwM1VPZmVMNS9BcTJxN0tmdW9MNjRLSTBGUDJQd04zeUh3dGJp?=
 =?utf-8?B?ODJTcitib2NoVENaSDB5UURIcW5KVjAwcGNacmFEWnJFc3ZjODlCNmxVNXh4?=
 =?utf-8?B?NVFveEFnKzBmL1FveXZ6aFQzYVNlUFZnMFB6T00vSG1lUmZicStjL3ZHSzRV?=
 =?utf-8?B?eUNzMEFjc3pidmcxNW9IK2I2eXVKK1ZETy9EMCtTdXgrYjZRZTdyNHNnZnhw?=
 =?utf-8?B?NmxQdWJTTmNubEh1NFNEY3FFclZZNVpLeS9KM3dKemxncEpYQVliQkNuZHVW?=
 =?utf-8?B?VG5SdHQ5bHpYS0hKcVNqK2c3ajkxcWNmOGFyNS9qa3hzYmlNVnRCbjJTRzlC?=
 =?utf-8?B?Y2lFZ0ppNFNoak5nT2hpeUNIVnB5b1FQaXIwVXVEUEUwWWtxbnJ0REZ1cll3?=
 =?utf-8?B?UmtYckxiU0FhbWVHRm1nQUpCTVp1N1p2UEYrQ3RZWU44cjhOZjBkSXk3K3Zi?=
 =?utf-8?B?ZnQ1RmkrOEdyaVdWRUc4YUFOQzJuRUw4VkluVXBDODlRb29NK2hZNkFHcXQ5?=
 =?utf-8?B?T3FJUUFRYnNXNTZUWjhQb2c4ajcrb0dDbGZRQUZiZjRva2h1RmNlMTVjZWxt?=
 =?utf-8?B?OXFoNkVhUkNYLzJLdy9WY3dDZW5sRSt3NFdNS2ZIN25mOGszamE0T0tkSTFm?=
 =?utf-8?B?VzU5ODI3SFdPR0lEbUZHb09CTHBnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa48e10e-11a2-47d7-ae57-08ddfc274e8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:10.9097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DScHSwOslxMtbmdH1Q5j1hm7OlJsuTJdR7cYtKCU7yy4p7jbJ12KWxy5aaJyKN7/OVQc9rBVvnLyDORFrvUn4TW22olRFzbEP4Fm+tY/2GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX6zsxUCjmojGg
 JPBFtXqlTOllJ3gNSbIhyOmLKxw39SQHtFJHHJIA3JPU850YN6fOVBQu3TrWRsJLfV4x54tK3cH
 9LSZFlAFSkx0YmQ6ZqkELetvb2r90h2KXUHCYfLNLL2t72NktQWkQQZ6R6LERNjaPqU8iOvpWtU
 eXD5ff2lnQWYtCMB/7GyHQv/VHmSh1kAIw59q/9iKWbH3sBfSg4qiiiftmySR7INvLn2Z6G3A71
 r9Geqyv24APACxBZ540GK1A1kJXGhFDcyuHTO9YRS5AZ14U+5EiYnuOMsmbwN13wPbP+53YJilB
 ku8FRDJhCHKJcrRbmsoj2A8lc/Ds9OGwfi9VLJcEm/gXk7qZh4zLbY5yaAKMHE=
X-Proofpoint-GUID: KTQO-rSYjrMoCvUzTTE94IFb99JKeefy
X-Proofpoint-ORIG-GUID: KTQO-rSYjrMoCvUzTTE94IFb99JKeefy
X-Authority-Analysis: v=2.4 cv=XvH6OUF9 c=1 sm=1 tr=0 ts=68d52878 cx=c_pps
 a=qlJ2pVgRLkKXdQ82XtY8Hg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c3bb3725c..6b3c97c56c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3920,7 +3920,7 @@ static const TypeInfo vfio_pci_info = {
     .instance_finalize = vfio_pci_finalize,
 };
 
-static const Property vfio_pci_dev_nohotplug_properties[] = {
+static const Property vfio_pci_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
                      use_legacy_x86_rom, false),
@@ -3933,7 +3933,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
+    device_class_set_props(dc, vfio_pci_nohotplug_properties);
     dc->hotpluggable = false;
 
     object_class_property_set_description(klass, /* 3.1 */
-- 
2.43.0


