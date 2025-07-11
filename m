Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A2CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXb-0006mK-6G; Fri, 11 Jul 2025 05:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXD-0006W1-SC
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXA-0004uy-2H
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:14 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B86Fmk032629;
 Fri, 11 Jul 2025 02:59:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QiuB1IQfLQsR7Ew4F/luinvFpG6kD8CgLkb+jvrok
 AQ=; b=pzcU5xLywRbmUntbS3s1YXU6nJLnxcYJxcG/393H/TXaq8YFZU2D+SvvG
 ks0lq5XNY7aw4l1EIlCu/Kg+ottI/cBt4Q2XeTr8n4aozpjJ6mKF2F7Dj0beOGJ8
 Rw0GehXNr3Xr0d/Te1YR/tF5Lk+34jjrePhRK2rOuLc6Cr8bA+R6eHLdcl76bxYQ
 rT/dWzwa16nUDthLiPxb0nfKFEgerhfyVYYKwNvWjliemx97cXhD79kI9ly0Zwcw
 Y+zTeNAHuYMSrsIicZciuUk+h7fVPktvW3mTkrQxrLmOi7PmwUTjjY1x5Za/obUB
 ffShS1V5WaLCj1JOnu2EENy3n4uZQ==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2123.outbound.protection.outlook.com [40.107.102.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k38m43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9yH3QE6sdhXjA+RODK1fDey9/5Nxzx/h+9tfxvyRWCSx+vE+mJxhCasGEiVdEjJ6J6neFZNWrO8NbA0BeLu46x+AHF1iaaldRjVueX0WmHj3IJbIYvo0hWTG0kk5hDke0wl2hNsrk8o+r3mRACGa8N6rw8Q5va5+Esmepv5G6gFrvWD1gATgngAfw8ZDk0Zo4YZzKcQnwu+yKGhjxfpWM/a6HW7xn0IYqHoAd3LU+RP5fBMErnZ2XIEW2Gc1eGrQ3OAgCeyg3tURZ/1oFIXkAqHGdJ4vUdDDggg8VQkIiIgjrj4ahFNX11nBJ1LN2eEcFrkRtBAto3vLI+AhTD15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiuB1IQfLQsR7Ew4F/luinvFpG6kD8CgLkb+jvrokAQ=;
 b=lbpVeiEQF+CUohr3bGD5aNT+E98OtL4fTr0PgNTxCGuLqT/M7uyi/gWVwvjb5DZFUepGBrs2LoJaRY+2kbv1YQnyGfSM+HBJawFR5NFjyjrHeyVW8oJP3gnWSYYJh4KfooHejlGwWxPaCNDtmHsOz76N+uUQQ/2FhY0+48SEcRrWdM2cB/kJ5Uo1sStA30NfWW//ob3UR/19MQhvYpWJbq5MsY61XUvqgz13qYY9uEO8lNFsJ8xAeBRq9fV/B908pi397LnJ48rbjt7UoSJ9Vsu3uGwS8bioWZ3drz5KJFfIOzf8IrFlQEMJgR66JbSBwVp/rLn9h7BEg4HeHLvuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiuB1IQfLQsR7Ew4F/luinvFpG6kD8CgLkb+jvrokAQ=;
 b=nz0RnRP+QcWiWBTjdi6APbBCRnm6mfuqCYHX4HSgbagwYVQME7Ladeu8/OZP6a3TNOk4xjaCjMb64o+ElfS1hBdrxz0kQWks08HEqrFq7vH92n7oWRGLvw0WLZz0cs62B2//IqV7B5DZPLb39AaPe8qyLsbCSFDPKmL1A070df2Lzc12EYLC/gUjY5CGSp7JluhJjpcuv8fkOafblNIcy5bjrXjeSVpnf5o0tBs+Re4YLgZGsnse9mGP65I45O7BMNaFXPJT6Yp23g6QOQUXf0kPv+m9bJp3RSJTvNhI82S/Y5hRbAb8A/6zhGLkYbB/7TceLhJTGb8pX6+rWqcC6A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 15/19] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always true in pc_init1()
Date: Fri, 11 Jul 2025 10:57:17 +0100
Message-ID: <20250711095812.543857-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 04710141-c42a-40a0-9c95-08ddc06193f8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFFnUmN5Z1BDeFMzUzhFNzNqYjFYczFXb1BBTXpkUk4xWW9NdTFaWGNTcEYv?=
 =?utf-8?B?OW5GNldxbXlmK3BaL2V0MTNzQTBVSzlxczRDOHZUeEZHVkNrWVlGdzVaTUhB?=
 =?utf-8?B?eU9BMktXdkQzdDBoWjVtMkNWdnY5eTlYQUVMd3FqcExEQllYcE1RVlYrT1Bp?=
 =?utf-8?B?d0dPR1ozYlRoTlNTclBEdFlzNUdjQkduQ1kvSjBPQmRUZ21HNHJUUFdnekw0?=
 =?utf-8?B?SDJJUUxlbWFOeUtnUUIxdFFlamVpemJ5WnZvWEpLTFFmbTIzSXpjdDF5cWU5?=
 =?utf-8?B?NWdkWGtJdHlxakg4Y240ZmdOQ0t6RThkeE9WeUl0OEhRVVo2Mk85UWhCeDkv?=
 =?utf-8?B?RU9ncnowSEl2RnZKb011L2xqc0xmSnJUUktuajcwZUtWOCthS0x4T0p2UVNV?=
 =?utf-8?B?WVMyRzY2K05QRWM4Wm5mUC9vZ3FDbng5eVF4di9xUVVaczNOeVJ3WTZJZEVS?=
 =?utf-8?B?eU5BUnROYm5MUE54b1d6YVAxQkRXcSt0UjkraWZUVmZSUWxWZnYrTmpYM1BC?=
 =?utf-8?B?ODRkcTBFM091clFIQ2ZycFR6eDhiaGxTamo0Y2JwY29YbCtHdE5GanJLZUVl?=
 =?utf-8?B?SnVBcXJsVnlSTCswZU1udFd6RlhWTDl3b0RkcmdsZ012VU1lSlR3UkZEK1ND?=
 =?utf-8?B?cElQQk00RWNxVkZZSEFhQWNQZmtwYUlrbEMzZTRTSTJLYjNZUUt5aXJYRVhv?=
 =?utf-8?B?MlB5WTVqUHFPV2Ztd01EUjRid09Uak9pVDZoZ2xrMEtrbU5wdU8xWDQxYUk4?=
 =?utf-8?B?YUk1YlVFSElwcnRsQVlSUGJxYVQ3Mm9hSmlHTTgrRTNkRGRCakFlS0JURksw?=
 =?utf-8?B?VVoyU3JzOEZiNkNQdEEwam1IaTFqRFhDV1RaNGVld05TcHlGdGsySmVBTHVy?=
 =?utf-8?B?QVJsQXU0WWs0RXl3NkprKzdyVWRZUnFyMFd2d1lHRGhxbktVeWdWWGZSRVdh?=
 =?utf-8?B?cHhQWVVpK28wVWo5MUM0VmQ4NWRQV3RkM3A1RjlOMFVBNEltL081TEU4QlVp?=
 =?utf-8?B?eStyczZtQkRpVlRSaUgwWUJtREFRK3dNTDdxYzVnTjBDN1RrMU1vZExnNnpY?=
 =?utf-8?B?ME56UEpjVU9jOERORHZ6SktzTmR5ckE0VU9vUXpCTFhYd0xHcGZtUEJOUnlB?=
 =?utf-8?B?dUhyUllZcll6MzdxT3Rzem1rb00zaWlQWmRPZFBYWFhtdXhWMFdiZXA5QTZj?=
 =?utf-8?B?MWJXTmFxcjE1QnpONFZmSHpBbVFGZ3prc1NVbi96L1BOa2Z0Tm1UbmNkNGlC?=
 =?utf-8?B?RHp4cytNek5CbkN1dXczYWwzdDh2VDBSNzZZZnJKM0F5WUtOVTgzaThrWm50?=
 =?utf-8?B?V3lQZlNmWUpXQWUrV2REWTFlOGdxNCsxQTFzL0Nrem1kMXdVOEJDR1ZsRWZs?=
 =?utf-8?B?K3kyVGViSHhPRVBEVnAycFA1bWswM1IxUjlNUjc5U3dNSkVnRGZXZGN3TVVo?=
 =?utf-8?B?OXZHWW40aHBhNldEK05RaEpZZ0E5Y3lhVm9jdzQvVTQyRVhDc3ozOG52ejU0?=
 =?utf-8?B?blgzYVFweGFiQjBCY0h6NmtDek0rVk5HQk1DQ1lkbEFGcmFRN1QxZSs0L1Fi?=
 =?utf-8?B?NjB3WjlwUmJjWHYxTGtKaGlIUm5HRTdvZWpyWDRnTlJyZFVKVVZEYVBwMnJi?=
 =?utf-8?B?QXhPYnpQbDZURmVQTk9IQjJYbzA2NkJVSVNxdk9NTXJHNEZhL2dCaEdmRnNv?=
 =?utf-8?B?OVc4TE9rMXVDZ2k1NXBDUU1zWnBYYWpJVkszOU4xNzU0L01JUE1YNGMzUjBV?=
 =?utf-8?B?bWt0cWFLNERuZmo1OXU3QzREQnZXdVZRYmdYNXFRazBUeCtDUkZhcVAwRStx?=
 =?utf-8?B?cmhiUnRhSkpUL1B5UG5tT3JseW13R2hmSFQxdU56Ny9qdU1ZYm5YRklQSzlP?=
 =?utf-8?B?enVTU3I2YUU5V2FSSm9hdU8zQzBnckoxMWYxMFVYa28rVmJsOVJ3NGFlOURp?=
 =?utf-8?Q?G7MVepJ/xQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VXak8wekNtaXRMeGRuQTVvODlkalBUeTJSUW9PMmxaeFQzM0ZQb0dlQ0sy?=
 =?utf-8?B?aEY0RVV2ZVpaTmc2akNvbWNHUjhWV09XdXhBQmlEUG00dG5pOVdKcWppQzFV?=
 =?utf-8?B?ZWpoRWZXK0pHeE9RV0pUbjlJdzd3ZG9lelhucUpTNVNocGZIWWtyYVJNUHhC?=
 =?utf-8?B?VWl5aGpNYlZvUWlXOGV5dXVvek5MbHo1akZwcWhGZ2huMlZ3enVDeS8yUzdC?=
 =?utf-8?B?ak5sYmFzbDZYS0pBSUh2TERYOXp0ZHloZHc1VmRTcmc1T29JWUY1aWRYeVJW?=
 =?utf-8?B?MXVldGRldWlNZHpGVHFqZEY0MUx0TkZJMnduMVQrakJkS1g1cEMwMkJwRU4x?=
 =?utf-8?B?TjhuaHVwdkRSdll5dlp6UUdveVpvcGNnaGY5bTBEeWQvWnl3N0Y0ck5zL0Nk?=
 =?utf-8?B?eGZLbGVtNzlvQldOczVpbVhrRmZZb2ZZN1pNNDBSbXRzSmV2dFhMSzBKc29h?=
 =?utf-8?B?bHhTZWFHTFRXM0tiV001UHlVUGlxZHY0blYxeTdBemYwT0ZYbWVIVkpKMDI1?=
 =?utf-8?B?VjJxMUhLNFNCVVJRWGg5VHkwNDRCUW1TU1l3Z0J3NVVoS1ZETFNiMmw1Wm9a?=
 =?utf-8?B?Mm8rSzAyaUJERkhFVG0rN0tDalY3dFN0ZGhObTByemVoSlZlcGc0MmlwRXRC?=
 =?utf-8?B?WEduNVdFSlZNWjRTYWZzcXdHeXloczNNRTREekJrdnBKTEhrU3dEOG0vWUgw?=
 =?utf-8?B?QUVLcjJuOHJ0UkZBa2d3eEwrT2JlVDNkczRLU2NSb2grdDdPb2JrVDBXZFdU?=
 =?utf-8?B?ZFJxS0xLcjMyM2VwV25wbWFrbktXWDBmYTEzOE02YVVCL2JwMFdCOXJJemg2?=
 =?utf-8?B?VnBRNHZxZkVqMXpWQjRJOXIyOTBGc1hjVHJWN1I4bVRrZzROTEhYeWhWZ2ZI?=
 =?utf-8?B?VkNWWnRPZWdqZElkZVcydFVJQzNZMWk0RUwzaVlSYS83c3Q0d0R0dnJUek5a?=
 =?utf-8?B?Vmk1Uit5QkZ0N1ErK1h6andIN0VvTGZ0QmhlcytjQmlDK2FuVWpEZGtQRXZY?=
 =?utf-8?B?Rk9OK05LaTJDT3hTMmlTT2xtRnFVT2cyYTdGdkFDQ1BJVW92S2llRWR0YUJB?=
 =?utf-8?B?Uk1RczFQUzlGRHdSYXBLb2tmcDc3V1M0THlGM2hzYXRTTWR2eEtwWk1ZOUUv?=
 =?utf-8?B?Tmc2QkVjWm53clNyMXRneTlaNjgrTUhMUm5kbG5mUU5hc3hEY0t4WVNwSkNL?=
 =?utf-8?B?eFJ0TktWY21RTEtqbHlBbFRWWlVkdnRtTndqWUwvYjJvQmV3M3padWNXY2t0?=
 =?utf-8?B?RHZBNENYbHRBODF2Z0lUTkZRanRwK2xZSHZxd0NvYVZ1V1h0c1dxSWR6NDdC?=
 =?utf-8?B?WHFMWmFMd2pPZ2s2ZFg5NThaSndhZzNoTjVHcExTQ2ZWV1lNdVVpd1loS3U5?=
 =?utf-8?B?ZVpWck05TVFraHhQdG0vRjQ3YzMzVnlHOElhNGhXMkVEMlUvam5WSitLWDht?=
 =?utf-8?B?VHN3ZkViK00xM2FWUDVIMldQcmc3dUdoOGFmUVNpbTRVVUZYYWhpaHkvcHoz?=
 =?utf-8?B?anhrWVoraUpRU1kxVkhCWHFiYW1HZmVuYWduSFdtUVJlVnBSaml2b0xNMW1B?=
 =?utf-8?B?ZlgxY3lIa3BlbWRCcm1nSzd0akI4ZS9wNjU3cWZmVStETEN5L1JqbFFwZ09a?=
 =?utf-8?B?TjE2T3dOeVM2NXFzOEp4VmpuVDlLVTJSdzc1Z0piMHZPTnQ3WERHSmM4STVU?=
 =?utf-8?B?TTlycmxsdURnVUpYV3FNcndWOGRrUzQwSGRvVWxldkNZMkl1bHVLV2IvdUo2?=
 =?utf-8?B?R252c2Uzd2RnYjBXVitmVHZTMEY5VzI1Rmw4bW1ZZVpTTWRlcHB0aVgralBw?=
 =?utf-8?B?VFlwZmg2REtvUzJ6aVk3SGZqam51SGxrZlpzbHptOUkzVlFFcUFLRmNkT29F?=
 =?utf-8?B?dGJzV3J0UHZLM1VadFNCSGdROHEvZkFQcnpZVlRmcEZ4RFFicDVWSEx4aEN4?=
 =?utf-8?B?amZJYWF1SHc0Z1ZxVnpVRDJIaWc3NjIyUm9ONlJETHkzN1VOdy9CSkxURi8w?=
 =?utf-8?B?SFNkOGVwVHk4WG5SeWdETkNFaEx3VVRBQnJPNCtYaXFKaUhQQ0twT0N5M2wz?=
 =?utf-8?B?NlZtVGpwQ3JzeUY2UnAzbkhaclNwZlFUeVp4NkxsQm9vbVJmNG5WdmNLNC90?=
 =?utf-8?B?MExOMVcvODZQRVpSSU9oeE5nMTY3UXJRMFFTazNnQTZxdWVwMWdaYzdNbWZS?=
 =?utf-8?B?OWtPYlBpRWxoc2U4UE9UM2dwZXlxeWJrTlVyMlovZUxrQmtDTTNvTzlCZ3pC?=
 =?utf-8?B?aWxXM3RiRjY0WEVteWZLejIwTHJ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04710141-c42a-40a0-9c95-08ddc06193f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:08.5445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOtnuxKDyo7HzOIUfFvLacqZvqt0/GLcSYvleMolALJ+HczHglDJzHX0OOF/INlBTf37abA1rSgEFo21OEuwUU+GPSNsZftkso2wcmWMh/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=6870e06e cx=c_pps
 a=YN2C2ub5wNuFRx14BhrpTQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ZtfbtUD1nkWWkvgxnEIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: F88_zdI2hQCQGzbF0ZKfQcZGL5p8BsgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX4DmNsH18C2Ic
 MRm/fghIxX4tgeA6KM8fOYbgFhqhbIhNBrzZ8NntEcET6P+jiOUs6taQhBQJg6ze37fMsiVOrPJ
 SffTzw9mNnbd5J9pdm7Cnfm3UBcQhAyFdsWlSamMBixuTgbEdq2yGQ/4OorVDR/6+05bd4W4EAF
 IX7yXG++80XiUPz6XwoydwQzuey/S4juPjev5M8OexlTbg6giNYAt65wYbfR7X0IbDVxctS4KWd
 Q9TSKeGUJPzquAwbEEcWjCsWQm664ouWSTDcOvduuPhVUmFyGIJ12c33uPFPBkA7zSaXCn/KhdZ
 XAknh9vV6J2MsTx+fLHP0tVVh/We5uqk3Vij9a2ehWg2sx735PqZNLhR859ptNwsBWCI4UNHmxM
 LP5UyUO5oG6vnCc0972TaGAykaxTDEGt6Cr10UOxR9BluJs1GidUJ0XZXT4/ZY1HFhM/Ic3u
X-Proofpoint-GUID: F88_zdI2hQCQGzbF0ZKfQcZGL5p8BsgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
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

PCI is always enabled on the pc-i440fx machine so hardcode the relevant logic
in pc_init1().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 194 ++++++++++++++++++----------------------------
 1 file changed, 76 insertions(+), 118 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f6cd1e728d..fa63659113 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -70,7 +70,7 @@
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
 
-#ifdef CONFIG_IDE_ISA
+#ifdef CONFIG_ISAPC
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
 static const int ide_irq[MAX_IDE_BUS] = { 14, 15 };
@@ -117,6 +117,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
+    PCIDevice *pci_dev;
+    DeviceState *dev;
+    size_t i;
 
     /*
      * Calculate ram split, for memory below and above 4G.  It's a bit
@@ -187,38 +190,36 @@ static void pc_init1(MachineState *machine, const char *pci_type)
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
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+    rom_memory = pci_memory;
+
+    phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
+    object_property_add_child(OBJECT(machine), "i440fx", phb);
+    object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
+                                OBJECT(ram_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_PCI_MEM,
+                                OBJECT(pci_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_SYSTEM_MEM,
+                                OBJECT(system_memory), &error_fatal);
+    object_property_set_link(phb, PCI_HOST_PROP_IO_MEM,
+                                OBJECT(system_io), &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_BELOW_4G_MEM_SIZE,
+                                x86ms->below_4g_mem_size, &error_fatal);
+    object_property_set_uint(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
+                                x86ms->above_4g_mem_size, &error_fatal);
+    object_property_set_str(phb, I440FX_HOST_PROP_PCI_TYPE, pci_type,
+                            &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
+
+    pcms->pcibus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pci.0"));
+    pci_bus_map_irqs(pcms->pcibus,
+                        xen_enabled() ? xen_pci_slot_get_pirq
+                                    : pc_pci_slot_get_pirq);
+
+    hole64_size = object_property_get_uint(phb,
+                                            PCI_HOST_PROP_PCI_HOLE64_SIZE,
+                                            &error_abort);
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
@@ -234,72 +235,51 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
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
+    gsi_state = pc_gsi_create(&x86ms->gsi, true);
+
+    pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+    object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                machine_usb(machine), &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                x86_machine_is_acpi_enabled(x86ms),
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
+                                &error_abort);
+    object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                &error_abort);
+    qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+    object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                x86_machine_is_smm_enabled(x86ms),
+                                &error_abort);
+    dev = DEVICE(pci_dev);
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+    }
+    pci_realize_and_unref(pci_dev, pcms->pcibus, &error_fatal);
 
-        isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
-        x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
-                                                              "rtc"));
-        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
-        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
-        pci_ide_create_devs(PCI_DEVICE(dev));
-        pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
-        pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
-    } else {
-        uint32_t irq;
+    if (xen_enabled()) {
+        pci_device_set_intx_routing_notifier(
+                    pci_dev, piix_intx_routing_notifier_xen);
 
-        isa_bus = isa_bus_new(NULL, system_memory, system_io,
-                              &error_abort);
-        isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
+        /*
+         * Xen supports additional interrupt routes from the PCI devices to
+         * the IOAPIC: the four pins of each PCI device on the bus are also
+         * connected to the IOAPIC directly.
+         * These additional routes can be discovered through ACPI.
+         */
+        pci_bus_irqs(pcms->pcibus, xen_intx_set_irq, pci_dev,
+                        XEN_IOAPIC_NUM_PIRQS);
+    }
 
-        x86ms->rtc = isa_new(TYPE_MC146818_RTC);
-        qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
-        isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
-        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
-                                       &error_fatal);
-        isa_connect_gpio_out(ISA_DEVICE(x86ms->rtc), 0, irq);
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                            "rtc"));
+    piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
+    dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+    pci_ide_create_devs(PCI_DEVICE(dev));
+    pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
+    pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
 
-        i8257_dma_init(OBJECT(machine), isa_bus, 0);
-        pcms->hpet_enabled = false;
-    }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
@@ -313,7 +293,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, pcms->pcibus);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
@@ -321,28 +301,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
-    }
-#endif
-
     if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
 
-- 
2.43.0


