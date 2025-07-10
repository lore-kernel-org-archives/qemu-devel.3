Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A962C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2Q-0007tA-9f; Thu, 10 Jul 2025 04:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2D-0007hX-Ho
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2B-0003X3-HG
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:41 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569MbfPc010556;
 Thu, 10 Jul 2025 01:53:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3b9iGl2PYyETgh+gSdyOOg1jkiqiB+FSsCf8TZ4Ca
 yQ=; b=FRjtt1P4ZQVdcFlK6O9yf+efVPIgqMFRffiGXHuSIVkouamuv7QK66loe
 pPbf6yZIRRPfOEirS+XRmavpXECq+7yyNTYtoi13GJBN97dsCf40KJpGcxxPqaAx
 FiaVzOItLqO9Y/eeSJieQg1K0T5/oEA6VeCxpaoiNt9AhSKCysIa+6mzB431lohY
 BBVWuhZwq64nQjYsP7oHY0xzBESqqDvNkA8icK7429OrGTmK4nRGDnAqRVV3zBXy
 QDY6uOgPoKafhhjPx32bsDGoat3YBb7qtjwrGGbZOBLR1EfLxjVkYlWT3e+q32OM
 h0w0+8PfhFWfChM41+RGXb2Y+DrlA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2091.outbound.protection.outlook.com [40.107.236.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkcn12hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhY59eeB+GsI0h3X3DcKcVjTy0C6mtPyBL/d1gdoBGAENAtaavaszZ7H4O6VRbvf0xWbWlL7nMeE7cGu7tx2+goO8dFqabhHebAB+WhqdpRQQdak1hhq8uHoGOX6jUqyHzptggMuVQIG2IPX1vpjbojaThYkdjjDoFnLZdrfI/NcsST5oIg4eUV6UR/LZqPmTeC0brZ9Piu7N9lCW7rREunt9hpy4L8Q6elq8rkftoxNf++tTtN6qCpaShASx62/Ej64bS1SZyr3fOo9DQtVPO+SPDGP9oRRSSTv+ygr6dJeWwunL/L2bLn/Phs8GXcFBDxN0oyK3mCQhzq4Hkt3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b9iGl2PYyETgh+gSdyOOg1jkiqiB+FSsCf8TZ4CayQ=;
 b=erIGYuHzinH2kD96xgNMLLvD6pGI79kgLLmp1aGupNJNebS90bNhOEJBmLfAI7bgBJN9LxLJFioUTTqgalg1YVqpmVgTtXpPyGuAn+wKSYfkLQGoaI5egtYeihvYb+WuaQCjBCjqviYXzsphzS+nntIgJ79xegGzf3TnG5Fq2ZXzFoGZbaThKzJu0Lko373MipMe2kKIWmzNlf6jK3v2dJ93+HXcCL0v1bb7sq4IY/SkiRTf7zP99PSoIy98Xx/iXxVs0o/wTTnmU4Yq6zY4Vi17NdX9FjI0vA6ATxYAaLJRy/tvMONrwRez2iHKAw9vGwgHuhTy3Zz0uvutrRMVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b9iGl2PYyETgh+gSdyOOg1jkiqiB+FSsCf8TZ4CayQ=;
 b=W60FGF53mWth8eFMmSbs+uJcQDutq4tg7x77VOiRk0+FhEfyWlQVh1awjbYs3Pj2N/fz+iTCH9C7vRfLykpH/ap42PmvUqsM8HhplQu8lujLzjUS2QeR0+PNrNAvCiPIUJQiGutsPtknvTzYjMnJ9MhR1AiNmecZU/UjeNuat8+Vav+EuO+5qf5PHq3/bSw8HHcIN7lTuZzw0PWD6kdc2r6hq6oFryZkfk46A+ldcT2topDMm3lmwOku1Ztr4wHIPiyvefgnTdUgsjkw4oBW9vLf0Oey3exFAn7++da+HaPzfwZO0U1vrR9GsZHAcrNIFQX/+AEnB92PAYX9eXt3jg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 05/18] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:20 +0100
Message-ID: <20250710085308.420774-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 03276762-e47c-4fb5-41b4-08ddbf8f3ed8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDlQSkcyaWYwUGQrbGZnU0VNU3NQWVJaNFdidE13Z0FSdmV6cjdzZ2JEeTUz?=
 =?utf-8?B?cm1ud1Y2RDM1QnIxczRObDNSR0YxSU5oZ3Y0Rys3eW9tcXRhaEZMeHdmbE1G?=
 =?utf-8?B?L0g0NThIUnZhUjBCN2tOZkthRHFUQkdQY2VpcExYbHljMlVHRTZQV0NrRHd1?=
 =?utf-8?B?ODBaM2pvZjNpVHBYNkl6OThLSE13aXNwakhySy9WVk0wYTN5TXVNbTA3aVR0?=
 =?utf-8?B?ZVI1ZVNmRWxNa3c5RmY0d1NDUzhlTzNBdU0weWJ3U0NyT01nK3JDU1g5bFZu?=
 =?utf-8?B?M0NJb0twWUpGZ1ljMnltcExMLzhRT0t4K0RtbS94YlJoMnAxbjRlTkVuOWxF?=
 =?utf-8?B?b3dOZ0wrMVBGYmxxZEUwU0xldjVnSytZTUo2clJpbnN4OUFOdGRkV2x5Sm56?=
 =?utf-8?B?cTd4LzNIWGkxemp6cmE0eUdya2IrTXlyUTBEQmg3dDhyV3kyaHBlZ0dtajhh?=
 =?utf-8?B?blJGL1BkR1MvNlhralJlNzhGNktxSmFqTXZtNHZoZ3RBb2hlMldDWUdLYW92?=
 =?utf-8?B?ZWU0WUs2UlZVc3VjbUk3K1R5MWNoL0pwVjZSUG02M0VFdXNhYmZTcUp5THNO?=
 =?utf-8?B?bnJVV1lQam5FSUpoOWlpUjV2NUZDU2FQcnJJOW5RcEsvbjN6MGoybjlOVG93?=
 =?utf-8?B?Z1IvQWxBNGJwSzF1cTNBZTN3amh2Vk1DUkkybEF5b3R1VWVrWTZBaVluNHNt?=
 =?utf-8?B?UkNxNGlMWm5ybDVjZllhM3J2OTFkamhPWjdQRWFZTmpFV3JUTU5wSzVzQ0t4?=
 =?utf-8?B?MlJIOFlFdnZtWk0wMnV2V0RaVlh3cVdwcHFqNFdlVDFMTS8yQVgxM0lBU3h3?=
 =?utf-8?B?OFVLakh5eW9KSlpKWFlWd0s1NHB6dVBXUW5OZy9WY3l0eUFRMmU3M2JKNmFh?=
 =?utf-8?B?TG1GRkUvV3Iwa2lleDM0QjdDcVkxalY2a0o0QmhUR1RUUCtrUTUzWXZTekNP?=
 =?utf-8?B?WGcrUGJkbzJzcWt0REZqenJRdURGZDBNcHZwZ2lKZGxlRXpTMlNLNGQxSlVT?=
 =?utf-8?B?NXdWTUg5WmUwaUxvQVRzNHNOa3hRRTNhQXF4NVJpTEpObzZLVTAzWnNhWUZu?=
 =?utf-8?B?TUZTTGRiMDVlWFcwNWNkVmRTcS9WaHZVY24vSDQ1ZkFRUnVwWlpwZWZHUlFE?=
 =?utf-8?B?WHcvUGt5R0tOODlIYS9ENC9BWTdqdGp5Z0lubzRtcmRVMGkveittSWc1b2pn?=
 =?utf-8?B?SXJQQlY1ODJmckJRR1hJYWJEN1ptMUdRM2NzY2FsS1daMUhPNStmbDZtR0tI?=
 =?utf-8?B?bkhqVGJ2cWpUSk9zTU1IRmpadndFL0NYY05NUVVWb1h4bnVCL1E1Snp4L0Rt?=
 =?utf-8?B?V3BVMGtvd3NtNk1iU0tlNEMrQzJiYzFWektkUVZNbDZhTzBSZ1RybEpLd3l2?=
 =?utf-8?B?MmkzK3BoaklYMytLUE1xbmhJV0hJOEcrYVJCbFlDSTZKYXAzMXMxNnZkZFpv?=
 =?utf-8?B?eTkrZjk4ZEhLanJqcSsrdGNFdThMSisvMVduanhVYzVIb3lCVG5lMklkSWVs?=
 =?utf-8?B?RGdYRUdwMCtGQXZTRXVjWGNMVzhZSjJhMmJFd0FDUFlIcDBTcjYyd1NQRzZm?=
 =?utf-8?B?aVFqNXAvQmRIblFoUFgza09ZaFhHelJBMXlhVkxkYVhpRDB1V2RVS2tDQWZu?=
 =?utf-8?B?RVBMTkQ1YUdraGxyVSszbWI3VmpKOW5UNFNTK1hvNVZlRjBNNDU4dlcyWlVo?=
 =?utf-8?B?b043bXFDWFhlOEdiaVNCTVZVVzVIdkNPckxMSDZmQnhBMDhqb2ptTVJkZXhO?=
 =?utf-8?B?cVFrTGM2NTh6cVpwMTNQdmNFM21kYzZQY2JJQSt6bUJVT0JpOWFaVVQ3Y1BQ?=
 =?utf-8?B?eURFbi84a1ZSQmlEQVZkaWx0b0NTd0laZU5Va0xBQUk4ak01dWp4QUVjVXNF?=
 =?utf-8?B?N3hVODl5V0RKWlZCT1BOK1hhc21xSkE5dnZncDVVYkNLTDFaV1pVS3YxWnho?=
 =?utf-8?Q?UNFooMm28nY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZQYThxYWdWVXBvRXlGc2Y3bFhNZkpDdFJBV3NKUDVQZmo0bXFqaHM1dk1y?=
 =?utf-8?B?NEk4ZzZ1eG5rUWd5eG50cXhKSDlxTEs1WWJVWllFamRMUmtTVEZqdXlxdDRG?=
 =?utf-8?B?L3ZRTDFDZDFBang0SUF0UEt5UlVyZEYrM0M4WUQwZDVBVSthVmN1Sko1Y1Jm?=
 =?utf-8?B?Umo5V0U0Y3FBSkpheUEwVDFtZUFodFRwK2N1QlVCYVF1OGxmR2pYRjU2V0NU?=
 =?utf-8?B?Ni9IQkh1TGNFOHlGUUZZS1JpbWNvK2Z5c25ZR290M09zZ3Jmb0xGRXVqR010?=
 =?utf-8?B?Rm8vSU5FazJ4c0xsWEY3YWp1WEJOSFV1NnpnOFc1ZVZxc0kvaWEwb1R0TGtt?=
 =?utf-8?B?Rk1oN1MyUTNweGxHKzc4QzR5MHdqV2R2cVQ1eFJqOWtaNWM2bWdKZHlhcjQw?=
 =?utf-8?B?YlpFOEFkSGN1Z2pBVldFNXNnMEJvNGIwcmk1OE9STzNOcGx2RjF5Ynh3enZo?=
 =?utf-8?B?eEI3SDB6TmdkY1VFeldtQjFkSDRDU3JVbGJmdy9kL2wxZU9TYVAyUmtBV2dn?=
 =?utf-8?B?cExvN2Z2Nkc2azRwK1U1dEV3WG1FbmlDTjhacEZDZ25EUWxOUVo0UVZ0a3Mw?=
 =?utf-8?B?WGRaVFlpbENNaFVRTlFKVng0Z1p0SlBHQXBDOTVQZU1IQmtyd0NZNEtUYW1S?=
 =?utf-8?B?MTQ0d3VjZUtROFhCY2Y0MFYraS9ZYjlsRlUyRTFxdmlLcG9OZHdrZXdqUUU4?=
 =?utf-8?B?S2Q0UkVUM0FuR3dRMFVVVnd0bFY2VzZQNi9XL2VkNmpiYlhyVEc2a2t3WlFP?=
 =?utf-8?B?bjdFZEZUZ01yU2llaWdIMzYrUFdHZ01sUDJmN3RCbGpLSEdqeTI4aEorRlg2?=
 =?utf-8?B?UVMvSExtZEE0cEZQNGlHU0J1NG5RRVZZUDdwWlppM2NKQ2Q4a3Jxby9nMFp1?=
 =?utf-8?B?UFFLb0p2UzRVVVo3QXlxYW5KbDltdFhHZ0xEaGordFgrUEhzV3pnbHU3ajhZ?=
 =?utf-8?B?OG1IVmJ6c3RjQzNuRmt2a0p1TlNobHA2NFRtSlBBN3d1YWk5Y081NXVoWVFs?=
 =?utf-8?B?QWJNS1Q5dnc0dUE3bmRxSVY1VXJSenRDT28rY0FTK0JRNmhUYXVsMDBzRGNj?=
 =?utf-8?B?b3BFY0U1Qm5RVUQvQ2prM3hwWUZ2aFc4Rm1mejdSUWg2NVJVOWVWT3F6V01D?=
 =?utf-8?B?MGMrSTFkOERHMjBneXBGa3c2cDYwZ3Fja3FMTFhrRThCUWE2T0hoYTFpMHhK?=
 =?utf-8?B?N3B3enR2SVQwMDhLbGNEZnJQUkVMc0JyM2k3T3RQYzQ2UDNVaG5uWkVKTG5L?=
 =?utf-8?B?SUJLR2ZXTXFTWXRtVDJFK2Examg0aTZVbzAzZVpINTZyU1VRSmkwVWZXaHQr?=
 =?utf-8?B?eU94WlFsc1loeUdyaDlIY0pyMmZxOTN2MmdaQmhjdGVTVkdsRHNLekZPTTJ0?=
 =?utf-8?B?TmJuUUp0U0lFelltUW5yRDlSdFh6dHMrOEJObFV5Ny9vemY4QWQwU2ZoNW92?=
 =?utf-8?B?ZEJiRXhZdE5FMUsvc0RGWDZGbVdXVFlvVlJ5OWtZYzJvd1RJQ1A0YzhBbk93?=
 =?utf-8?B?KysrQ3FQa0dVTEMxSnptQ3RyM0YyN3NyMXVrallOaDB4QVlqVjhnaWthQmkv?=
 =?utf-8?B?ZHZ4SnBBSzRCT2VIeHd3RUxBbE1iTDRESXI4UzI4VmlTblRqOTYySnpISlU1?=
 =?utf-8?B?aXNFcG5LUjhydDA0azBCUnBnckVwN0VmY2FldkI5SHRZNjBkaklaQ21ZQ0hy?=
 =?utf-8?B?d0gyVTFldmVXelJpYTNobFNseFJaT01kMkRVUHU3RU9YTW9vcXFROUFLLzRG?=
 =?utf-8?B?NWxabTR4ckh0NUY2OGtQQ254Q2oyMDdIcXRWdmlac0xaQ2toNHNzVnU2eTgv?=
 =?utf-8?B?NTVERk5zWS9ib2s2clR1VGw1bTZBWW50cE01T3lMUEpZSGFWRXVXZVRLR1dh?=
 =?utf-8?B?eWFrN2tLcDZLVGJQY0FRNkRicGFnTHhPU3ZuMTQrSm1YSHBYdjh5Z3dwVnZN?=
 =?utf-8?B?dHBSN2RwVHdFbmpic1pXcTJiVC8xcERmU2RJa1hlOHhJcVhKLzEyTmJJUzdw?=
 =?utf-8?B?SURqTHgzaEMvNGhhSGNGT0xjNUFJUHRPbkFhM2RIaml0WXQwaWtacitJWnc3?=
 =?utf-8?B?eWZHYmJCK1VBa0dPSGx1Z0R3V254VHBIQWpHWGZqaFBKTXZkc2hCUkFIaGV0?=
 =?utf-8?B?dTluTy8wOGdmU3g1dTJESXlPSVVnOFBpa3pEdTFvOUxSRXFTT1NqaVlVZWhE?=
 =?utf-8?B?SmxwOFhyb0YwOSt2ME5IRzhKOEtxb1dkR0p4aDNjNHFZS2wyMHRueG1GdjZR?=
 =?utf-8?B?K1Qxc0J0WVBoMEMyRnpRcFBFbGR3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03276762-e47c-4fb5-41b4-08ddbf8f3ed8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:31.2786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmdTb8SePRkpqZGmYDl6nShA0T9mlUb1Cg1iRFUi4g1kfcdinJUGLxYyvB2zWOvorBTx8kfwa+DnD7ZDcCGJtdpyf8xn456frlpf2yV1CO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Proofpoint-ORIG-GUID: HsDdIiakmLmxeaDLSiYWLTLP5hY12NAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX2XJowiC9gm19
 zGCla8W1tRNirtCtmfP8+DgRVOFSFaLd0gmRv77jEh6trCJTYheaeVr2Iej5OdQ3y2d/sKteS5R
 P6sz+5FO1+I+QnQIti6z6zpTre3UnefJlt6vbNrAYUmHUsHBitYcupB6t8yVM1dIrFtmQ2z7Qxa
 T/FXf+f2CWu9+gEyanoKPd86JXi5ghpiI1UDL7PFRO6vmHfpUyzqNOOUsIK/9Pcq+2DPc4JmQvC
 tj3Hd6HH73E6L9JFHVj0jQOvkvZCw59V7rAmUURx6DafVjynwKmfRuOnMcE1rOdK3vATIBs5cvQ
 IARz40e0tzwz7Pn+x3uIUng+eYR2eV9qDXqWbrVFkLKKWhPNEXJE7t9YSf/w3H7IyPlyOWOvsRP
 awyK2H+nJQEGKwbFV38JXHOncXzg9BY26o6ZWFnQYpsM+oZHHkB99xBkdk7/PfmOs7gDNQPl
X-Authority-Analysis: v=2.4 cv=KKZaDEFo c=1 sm=1 tr=0 ts=686f7f8d cx=c_pps
 a=vI7cwuzHBtkooc9oao+6fQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=F9lpminiuFHZMRiaUDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HsDdIiakmLmxeaDLSiYWLTLP5hY12NAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 548e81cf1b..cf451d1cb5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -423,8 +423,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
@@ -578,23 +576,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


