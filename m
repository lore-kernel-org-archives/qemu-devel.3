Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545ABC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNP-0004Aa-LG; Thu, 19 Jun 2025 09:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNL-0004AO-JS
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNI-0008Ad-Cl
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:18 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J6d410015883;
 Thu, 19 Jun 2025 06:32:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=7e5rbRo0Z6BTr
 z276eFpu+bDjlfXhe6w3C3SCf89Qig=; b=O0TGH5r9SKfKzq1wtSa3fJNElTwcB
 e4JvvBIt5d0C70dFjY5pc2HF15DYLbki5vkiNuJRjPJ1UZiCbbl2rmiP2U0vd0dj
 MFB/ifzXl3r6g7Jkh0LmL68rZjCU2xgn8g1o9NbOQMRjodHXlke3ltB2RLqh4PbF
 40dLM/po/Qn+AwZ6qfV8YE0HIauMh94H20uwSEUUI0k5+IQ/187VkJw6y1MUoWsI
 9wAqrw3ecZLKyu6+y8cq+BPZyJJZOXdIUy/bNokS/lukSDDtL7H7aEzIuQerHzVb
 0Detkjq5uO6ze+XQhmkUhzz4QJhMwI5osz9kGRUL7b0nM2IU2mzvZiUZg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020142.outbound.protection.outlook.com [52.101.85.142])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47b63weacd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPBEjxPSAX5JIod+NQDJoJQwQI01MTPI3srBxPD78FBbICKWNIHbBhjV4yhDnqgm5eNnzz23tLkkndRh5kcQWe5fCs+PtqJsB4N4u720jJtJsdse3JEejIo55827FIXqdHdeg4kEflYRRkFBbGKdsO1qXC6kNZ8I7Lsel6pLpPGyiyKZOQp5aElrSr6J454OoCFm6r09si+W0qLRJBvhGRt+gzs/WhLauu8u9l7iPVlWorC66YEk2L1ahN+15zZnbz93sXD1dwCWeQv2jPrkzeM/fTHDCcdgpunMNMhBvX/KZaNgrIPnZmJxX0hM8FCUEMdcG036eM5+iRBH1w7KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e5rbRo0Z6BTrz276eFpu+bDjlfXhe6w3C3SCf89Qig=;
 b=lSQiApQwd9uKyA0FD7i4OiZ6/Hfy1Z6E+P3AfN5mU8YZudmxvx5iA05HJQ8CtkMmrxuqqs5CCUcD9KajJmtfXdKKFoNdKAhxH2VLhoMOoBwa9CcvAqZDstjbzY/mekHZzfFYLGX3PmScJWpCcQXT4UTFrR5JzhvbdgQpBhhHTfB0A0Bg8U95E94ZSVG3O4pK2CjW+mFdPNTXujt2U/c5iFBjQrtJ3W474NpNBACSmjaqHYBKcQZyCSPTbJmwDt5mJjhRa+PstDd7ZZtobluyMDwWjCkFE7t83jBObmFX0Cr1hp0DiQeKZhR4FuBwJdw2xJl2kQ1jPluYa+z3RJWP1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e5rbRo0Z6BTrz276eFpu+bDjlfXhe6w3C3SCf89Qig=;
 b=wyJLhFIpvqlwITrd4s7FsRFZJVKh6bkMVOqWFR/lsMprHG/SZBQp+0Jc8j/UYhvE3YTNLUsurGvwGW4npl44KYTIoEU2HVZLEvgtxgaWV3DStgyKEXsjg64x7iOaiD9wH6ng4g0GQNHqBid7Pym3zYOwOhq+/4YbePI94FWypvh4kDEp3FSiQyGE/7/TAwL2YR50RuKTldCa9XAR6Nc6yywM9y+8i3pZV4L6nCO+gSkOJWyRBhAdD/9y+Gt6amzz2h+eSlCEfgxQwGaO90kT6OvG0HSKEBjZVcjiHA7I8g0ChMJORsrs5tsHroh1+IuAYB6C08GMTWVwJT2gWaQZSQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:31:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:31:58 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 00/19] vfio-user client
Date: Thu, 19 Jun 2025 06:31:34 -0700
Message-ID: <20250619133154.264786-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: d07f8f8e-389b-42bd-111f-08ddaf35aa75
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2F1VUVpUUUrckJ4WTdtZTZuanVEU0pEb2hBRmg5RTZWTXJRSEEwdmpqS2V0?=
 =?utf-8?B?ZHdWTXlzSHJuTnQ4QTV1ODFDcU1CaFFzbmtONFpFNWdQaUlubVJpLytMUlNE?=
 =?utf-8?B?NHN6SkJCVTdmUlQ5TWJuSGFlQll3anBkY0hHK01mY3ZmMDJBanJOamxMUXNV?=
 =?utf-8?B?aklrQ1JXZk9BWlJHMW1lQitxbjVNU0Y5YXpzYTJoZ1RHeVlpRkRLWm9kU2lX?=
 =?utf-8?B?QVZSR1poeTNqV3E5cXRHUzR3dUgrWkJTVGp4b1FPcnlKa2t1RkMzTzVkV2Nw?=
 =?utf-8?B?bFRPQTk1WXVvTm1zSFN2eFVRbEp3dllRbEI0Q3R3KzEydWFjSkNUcndEeWl5?=
 =?utf-8?B?bjFzT1EzRVFlY3MxbTNSMjhrSmc5bWR4WWJkZjRLTUtEbXdVWjQxaXZtUmVB?=
 =?utf-8?B?VGptOExDU3NJUUhsb0s2T0lzR1d1RTQzdmlvMGhEUXBGMzFXVW1nSlg2UUVk?=
 =?utf-8?B?Vk9iQk5lajNieGNoejE4SkdlOXlNSkFMQUpSaGxoTUdobjVwVVlqcVFPMTBa?=
 =?utf-8?B?STFzM3FKZGUvbERqdWVKU0o4REdWTm85OVcrN0tjdVhoTWJzYlB1QXZvcnZO?=
 =?utf-8?B?RWhmZG94TkRjUldTUTZOd0JLVXVEOW5RVEljMGlTNHZqeVViSTRrVzk3NGlJ?=
 =?utf-8?B?UDJ4eEI2ckZka05uMitheXpDc3FuNHNrMDZ2cjlJRHJMNituR054Yit6eDVZ?=
 =?utf-8?B?SkRpaEpQMXJ2T29wYm9Wd0pPalB2eEF4MVZWN3R0elpNTk16YVdwUlNrejd4?=
 =?utf-8?B?MXE3amFMYUxnK0UyTVAvWk5FMkIzQmlqMi8vYmhtajhpRm9ZTHZBRTJtSFpx?=
 =?utf-8?B?L2JEYVFWS2NyMldKc1RtNUNmSWtwZXBmQzJBbkVwSlhVYzVvN0ZmN0R2QlJq?=
 =?utf-8?B?Sml5SzZ6Z2JyZ0F1cXZyOFBiSXFIbFJWTVFnQ2t2NzVPWGhsSHNQVlJVczlu?=
 =?utf-8?B?UmFKYjE3d3RiODVjVDQzRkl3alpQWDVCcENOeUhhV2VobXM3SXowQkM1MnFw?=
 =?utf-8?B?bU1MbDNFTms2SDhIMS9Mb21PZ2g2aU9JOCtXb2tkNVltcldvUVR6WVd4dVFu?=
 =?utf-8?B?WGpRUWM0WEZacDZnakZYREp3OHp6T3N4K2tuanRxN1hMcUZjTGREWFdBaXJu?=
 =?utf-8?B?SFpaTWpSdmx6ZmhBbDk5UnFNTXp6SWlrUTJrWGZXVE42NnowZlZCdVRnVyt5?=
 =?utf-8?B?R280WlEvR1lVblJ2L2hmVlZleDJDc3p3d2ZQYkMzL2J0VjRwSERkZEplMTVO?=
 =?utf-8?B?OFdKNXZCcDF0TXB2VGMrNmUxOU45SHl6dUpFZzQ0bzNRNVBRY0Rzak92QTg2?=
 =?utf-8?B?OFpvK3VIc08rS1JxNHJ3NTZvK3hRNVA5OU5wNGNZWFZPMnNrNk5OaVFGTnBF?=
 =?utf-8?B?UTdXY0ZiTVlobmNMakMzRkVZNkFsemVCeVo0blFJZS91MVZRRzdDaW9aeFNG?=
 =?utf-8?B?eHhOaVZEUEFvZ2JIRFZCZTlOR1ZZRXV5MFRkT1NORkxoR3U1NDdmejRxSjZB?=
 =?utf-8?B?ZmErRjJqTkF1UWxpbno0aXptUVdhc0YvRnRoM0tNWUhxOTRZbHFEMldwVUZx?=
 =?utf-8?B?eXlPcm1QQUJPU2pacVZGRlJPNjBhVTFVVE9ndExhcCtoWXh6VzQyeFgrbzVp?=
 =?utf-8?B?aHl0S2g1bjZKOXJCZlNuSzluamlzc2p4OVFWclBQYzN2czBjU2ZldlU4K1VQ?=
 =?utf-8?B?cld6RmRQVXdGK1RIRHZRWi9HcHJqRkJvaDZYVy80Sk5KSWltWmFob29EeFd5?=
 =?utf-8?B?OHJkRk9Vd3orWTJrUTFQQzY0Y21lQ2x2cGNyb3BUNzQyZFVEeFY4RktwM1FT?=
 =?utf-8?B?ZnhwSkRHL2Z3NGNIMVJkc1BSb0R6NHJsN2xqVUc3eVZHQ3NWdmdCTzZidFA1?=
 =?utf-8?B?dHZNbDVaR2ZsNElRb01kTmVQTktvblFDOUpubng3THB5TWdsL0YvZTk0ZXdu?=
 =?utf-8?Q?CLyABB+sHJA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjZsbmtLS1I1L0hjNFgreFhxdUtsTjdDdXJ5b2VnWS9EbzZlcDh4Y2tsTzN1?=
 =?utf-8?B?cmszZDBHS3dPNHlwbi8vQnJhNG01MENDNFFhdWl0SzhoSGpoUmF3bVMzdDVs?=
 =?utf-8?B?bzJ5bDlhTlpTc3h5NnlLZE1KMnlveXhMQm5hY2Z2SEpzUXRwNVVpT3dZeFVZ?=
 =?utf-8?B?WmJHaEdDa29HOHcwK2dVbnp2b2JtUWg4bnJuOUZzK0o1VTUrbXZhUS9JRUdt?=
 =?utf-8?B?clMrdktMV3BhTzZkMC9KZHA3OXRGRHo1QlN1S1RxTlJBMXRrT3YrWFRwNlRS?=
 =?utf-8?B?MmVqWDRudUUzaStwdXAzTzk1U1dLYVF3QWZJQUE3bGdnRkRyd1R0QnIxNUh0?=
 =?utf-8?B?VWc0NTRHNXQxY3RvQis4YU12UUFORmFWejZqUFJxWGY0cWNBRWkrSnU5Ykpm?=
 =?utf-8?B?d3JsNWcwVXREVTFVMmhadEc3UXhJeDBuQzdKd29naHhCSUJ2VnBrNGtna04w?=
 =?utf-8?B?aTFlUEh3czJKa044QUVCMDIyRWVPR2E1N0VwaFEyUW5KSmlheEJjdW8zUURB?=
 =?utf-8?B?Si9KOEpLM0hqM2luN2dzVkExTlg5RjY2Y1JXdkRkRmxXeVlTQWdtRlByeW43?=
 =?utf-8?B?cUhoZ2lDRzA2NHNNYUZSOC9iWDRIa2NQREFCR2ZLRGJ0ektCZnM0SEp3NkpY?=
 =?utf-8?B?UHVQd09jZWtRQ0pHQmZZNzVKd1lBK1hEblJBWHNWWmN2KzBobCtqY2tqZEhT?=
 =?utf-8?B?UUJkQ1JDYkhZNTBnNXJnSGp5WDZ1di9iRkxURlZYcFhLQkYrNUxCSEhzeXB2?=
 =?utf-8?B?M1NMTWhUa044Wk9pQzQ3YU5GOVhxWnJrM0lWbHJocGlxYVVLRU14ZnoxYTAy?=
 =?utf-8?B?TXJWSUVDTStIZ2Z3YTVrUTBuOWp1SkNYTHVrdkxiUkU4MlY4YWlCZmQyOU5p?=
 =?utf-8?B?UExyY09VS0EzbGRkWUpVZnk2UUEyb3lvL1dsZTVkdXFaVVNicFVnK2JLUzNE?=
 =?utf-8?B?b3k2Slh3U2xsd2JKcU8rZDAvdWdlOGtxYmdwc1RRb1dEMGg5YVFIdGpxQjlv?=
 =?utf-8?B?YnR3azljWWpsc3Y5SlBoekIzRFZJdDFZVHdoaEdoZndiQVliM3J0M0JESGZ0?=
 =?utf-8?B?ZnNUUXE1cTExTnZpeDZESnhLcnJEK0QraHp1R1o0VFU2cXRMcGI1aklxR0Mv?=
 =?utf-8?B?ZHZwNjNEOEQwa1p1RVp1NmQ1YkJ3Q0FhdFdrUVJnZWZseXJoSG84SXh3Mjl1?=
 =?utf-8?B?WDNNQnIyVHMzRUpPdDN1Q1JxR0o0c2kwQkpmeFBQRmZ6L0ZET1ZxNGRrdEFR?=
 =?utf-8?B?NEQ5dC8xeXMyK3pvVGhoeW9oNDJkaEh3OUxSd2lWcHdCK0xqVVRudjllUkZ6?=
 =?utf-8?B?QzJUVENMbGRJb08vRitQV2RaQTRLU2ZDYkdnUDJEd2hIM0M4bHBQVVFQZU5j?=
 =?utf-8?B?ZGRpVllSYVNBdStGUXJrdEF0K2dVWTNxTHZ1RTJKMWxEckp4RmFEOTZXQThn?=
 =?utf-8?B?eXc1b2RBdkxPRWFjeVFZbmJ4NGJKZkVhOFhtSDlVbVNONkJOWnc5T2xJR2RK?=
 =?utf-8?B?YVRFRUFNYm12YXBSaGsrV0prNy9hSkFvS1h3NzlRNkZsVE1ySzh5NXFWMERn?=
 =?utf-8?B?QlBLRjA5MEVZZEN2Vit0Sys0VFpGTGc3L0sxMzdsNGppdGo3Rjl6RjBFMFM0?=
 =?utf-8?B?UjJ5a2xzMlV5MkM3Ry9pRUo3R1JEelNtZlFqZkorelFFNlJkTjlGc0R1NmpM?=
 =?utf-8?B?SlVCL0h0YTRKSVpjQ2phUCtFOUltVjNjVlpYY3lpREMwMnI0UmN0V0lyR0xh?=
 =?utf-8?B?ZXJGaUVaZmF5OEFYaldtMzAydFdCcEdUUTRiSnJrYlZiYm93NmtWdzdVKzZJ?=
 =?utf-8?B?YXVJaGRENzNPbHUrLy81Y1BKSkNXWFpjTTI5YUJKVUduSzVnc2cwZCtQWEJY?=
 =?utf-8?B?UWl4UG9mdW96NkVoemxacU9ETCtBSHlIWnV4am1Mb3Fkc2FlTXhqWmEwekRI?=
 =?utf-8?B?WmN6V1NmT3JiUTVQUU4ybUtPdFZtclNDSUlEaXBPd3ZXNVF6bHlVdWdvdEJF?=
 =?utf-8?B?WEJudE5qbi9TcVdDODVIV2g0NlhUTUNPdWpZRm1vRVF1MDY0NTg0U2hCMnRo?=
 =?utf-8?B?TmVOMHp1SDRoVUNuWlpDdHo2TjF2U3E5VE4yZ1RNK2kzM1J3NUYrNERHSGNZ?=
 =?utf-8?Q?WYDfTvWApE/KK040o0T1j+0ts?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f8f8e-389b-42bd-111f-08ddaf35aa75
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:31:58.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eqsxgbOqn9nK/FFT9ILMVjeSaGh61/fLXCDEL81CxGSMFYo3FgcvOVmav0FBRoVKcaYG4oZWbv0fZZnrNkEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMSBTYWx0ZWRfX9JClQBkR9bMY
 qX4Fq61LBgy+3G+/fvxn7wB0QO3P61b065TF0pgpo+8Fo8uem5dVoazpqgJKe9L1jEEHljhk+bW
 hNay43gtwp+iaRYbTDCq2GjVWDdUD+exBKIzBYqn+wTDyw9y1Z6gzwRgYiQtNoEJF9RlX55DTHC
 qe/D6ENnL69zVCWsM4NLKEgCgDY/95VaXWA+sMj6Wz/3OmGHitGuSnVn7JSbAptunrhDE3g+083
 3JsnBwdzk2b9o6ZEIsbkqjdUGDM3zBphMACbAljtL2oa+PEUKsIJiP/0PQPOdKFsFSZO+hzJ30/
 GjnCuEr9ZM69B27boSBzLJ4D46v5kMfpblIr3mcFZwWFOT1MXyvwqbwcmcQIyejNSZmS09tM22a
 kRSWXiRCEPEGhFTjOalsQ7YcZhQ08qYOvgB5E08UdTVmt5Yguo0I6yVrTPF5UHJaz5h9BFSA
X-Authority-Analysis: v=2.4 cv=EurSrTcA c=1 sm=1 tr=0 ts=68541151 cx=c_pps
 a=1I5b7dHNXDVHQsjYcRiYGw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=-Z5CLq4igGlHnYpvNrMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: v9WLWC7GAwopSaX3OS1k7xYzuxXiHPBy
X-Proofpoint-ORIG-GUID: v9WLWC7GAwopSaX3OS1k7xYzuxXiHPBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
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
A functional test is still pending.

A previous version of this series can be found at
https://lore.kernel.org/qemu-devel/20250607001056.335310-1-john.levon@nutanix.com/

Changes since last series:

 - the vfio-user client is now enabled by default, the configure option has been
   removed
 - the documentation has been relocated next to vhost-user's
 - SocketAddress is now used for the command line parameter
 - small bits of code review feedback

John Levon (18):
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

 MAINTAINERS                           |   11 +-
 docs/interop/index.rst                |    1 +
 docs/interop/vfio-user.rst            | 1518 +++++++++++++++++++++++++
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/vfio-user.rst     |   24 +
 meson.build                           |    1 +
 hw/vfio-user/container.h              |   23 +
 hw/vfio-user/device.h                 |   24 +
 hw/vfio-user/protocol.h               |  242 ++++
 hw/vfio-user/proxy.h                  |  134 +++
 hw/vfio-user/trace.h                  |    1 +
 hw/vfio/pci.h                         |    1 +
 include/hw/vfio/vfio-container-base.h |    1 +
 include/hw/vfio/vfio-device.h         |    2 +
 hw/vfio-user/container.c              |  345 ++++++
 hw/vfio-user/device.c                 |  387 +++++++
 hw/vfio-user/pci.c                    |  475 ++++++++
 hw/vfio-user/proxy.c                  | 1311 +++++++++++++++++++++
 hw/Kconfig                            |    1 +
 hw/meson.build                        |    1 +
 hw/vfio-user/Kconfig                  |    5 +
 hw/vfio-user/meson.build              |    9 +
 hw/vfio-user/trace-events             |   18 +
 23 files changed, 4535 insertions(+), 1 deletion(-)
 create mode 100644 docs/interop/vfio-user.rst
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
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/trace-events

-- 
2.43.0


