Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB841CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHino-0001wt-Rb; Fri, 16 Oct 2026 10:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHini-0001wb-0D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHine-0006ZW-SQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:49 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5Db03215898; Fri, 16 Oct 2026 07:20:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1pCF8b60VVnDX
 4UsfNMHUrQaLNz4cgQKXgiVFlnlh6c=; b=ioOLe4HZO0qzSmY4lZ++DUzeKX9ij
 hAb7cpn/5o8Oksyd0EvSyMwiM0AkcYTx8CV5diL6PdGWmuXA7YHa4Pdt0nWFShZK
 w2Z1oVBN+cjCj2mvh+WdmthF3j3kS2ImH99Tjv5Zz6GGj3SLfaoFVTyRNA1D7y03
 QSxB9+WsFwZkKryCdRrvlMfuaY12JVq9DWx+JdqRtxDN2F4sKQQ5X+nc/TYmyp6h
 jOcxjHuhTDOteVfEl65hn3kgTiN5RGbG7ss5CNPkOmUBQggdr9gsX+hAkuDkggU5
 gkhGNI71TpxcwtNcs2WoYJVRLThjlbLkjrOmBOtz2GGhq++MNHLAeiBxQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020096.outbound.protection.outlook.com [52.101.85.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045k1j9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCpvnW9rJNhZuOv30/7cJrGI0GuS8SohcuJAwsuDzFeObkN+xgfMXFS7ao6JWBrJ9DLOFx7XLVufXktcNQ7ja75jdZ6GTgw8LcmvdHMtkr+nKToMQKvVvLZ/OEEpyDibO/bLAqhP06mWxOdTJiMhLsroROOM+uxHVf/kPPgde/uwJcl8gW4JPF/5NV2xEgAjem6EMPTUbCahqp8eTeZX53vCgPYWd3CISLVh7ouoexAzwfNSQo3zWNLppBR4VN90w3zrwTRMbMXAhHuL8SQz21knmHk4OWADEu4550mLO2RB39G/hKODko5gd/PxpGxJ23Up3faK2bx5NSagWqJmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pCF8b60VVnDX4UsfNMHUrQaLNz4cgQKXgiVFlnlh6c=;
 b=drmYt43kC2pqlPepvJxSdkSnOxAUBIswyoSc5OD3BOa13g10oT5MLRoYHhH6OMFYDF23NuTke3bxEM9HqlNDKAgR3GWJ0HpTQItDdAY68FS61T2Chv3vbbUMzdyfhsx8uzEccuMfEOomMYixa/TxWNOcihefCKY8P+zlrcQy96v38lpTIN8rzkYfKfQIiiauLGPaivaD6+5nxo+BrVB02Nx/hm7RkdDAiKhepuamsShQvDcrX00ClQ4vvghzM1jf+rHUmHUgnGkr3GOQLLGzF+lo4NRMoHl/7s59qg0kyVWMWBa3SQcjjJ7B2O/v7D60vmzSysQ/6//OWTsuC7jd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pCF8b60VVnDX4UsfNMHUrQaLNz4cgQKXgiVFlnlh6c=;
 b=XLG/okVCsgIX/asgSU5gQcl+vu3hq5LRxnQPa9CluZV5rP0rVow1gn2q9hVwfCWwEy/+6fV0gESXyS9wKxbuKY+vWYf1iN/0Wip2ndWRvEYA4bpwBuakp2+DwRJj15TiL0x/R8TVSz8CHqzHyvBWLRc/uE9lZxLmGqQRYCh6mGCfavHjuMvWjWv/y/axLxLQjTbRpbMFSk7cfrpJSpoIkApNhih973xjdRtO5HMtp2IkGNjUodAQwoR3fA224I/ieCHboKUdYcmFYpKOFHCjFtKnmljUWuldCfkNhk5jt6R+lVv6UodaG5xrlf+FjZZW4UFiS37q9DDBT8xe4Mg5fA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:20:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:20:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 00/27] i8259: improve qdev PIC modelling (and misc fixes)
Date: Fri, 16 Oct 2026 15:19:06 +0100
Message-ID: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd89d2b-81c4-4105-0914-08df2b90a51b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|3023799007|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Gwt/yyR9Xn1Q6F39Rcwsq7FBonFdvI9/5+DTf53S+UzHBMnhxKDPJOhcGpZ50jbrcVYvau/h28rPkGFUmTvjop+3VHfx9fkIchNNIEeI79/KyniGUHrRpeNREIyaaN1m3PrApZg+74sMWMgATafrO+9UGicgUTW6HiS9qpKDYk2YcxcpUK3hvaXuC2UECpak1D6EQ6UImS8K0DI85Q1URcAhMRFmV2Hs1cyXgke/+4GKcb8Qy2Im9H51hUEuqwtsAwetI2smxivT+Y3SuQAqeQmji2Uwovfh2GezgOBabFoX/shLhU6MKNGNv2XG8k6O0TBnnfi4mya+NSj4EKlZ3DR52Bzvf7+8OJMijUEKsaardq3leCV9C6xauKX9cfRrPUvSJkndhrfl9jHV0KHdiZe2CLSIcet/2WAl4vaU72NpmiooSF09Mr+dXBE00SKN4QMnD5WtN1spNTR6q9SXtTl5HGcGj/fRAP2Melz/HdZ/+reYOCokOPzxiscYnlCbectN9w+IJsBx0P/Stluixs1e7nEiFzMSlKagSKfcm0CDqV+bDIT5G4C1gEJHz/TgkYKiokCYWbgWr+/vLS7yrbuRwKb0kMzDvYqahWR/+EtgczMKVpSJv46ffQYIR4jvvB5duIzOvRt/Qjl4h5UbDIhiSuYbJSwnu3juVg3sJzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(3023799007)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMgbf31ucWeHhb1IcOQlsT4MLPIU17IYW0zOlmIqKLdCrTo8LSrb/b3xERxK?=
 =?us-ascii?Q?1y4FMSUll+n5PlD/P1XnNRSTcI1HqDVVNAK+wQ6IUCJpsb4yqPZRkhirPoDI?=
 =?us-ascii?Q?IKIRNU1JgsjzOWPHUDdIR/vlzxqNADMtM6vw7FZYE8dBS/f3J4Be8ryWglI5?=
 =?us-ascii?Q?e27NsYn0vESxw7H8vcl2odwOjKak85027NgWyor/ES8+L4Tu+jlN1H3yLQSm?=
 =?us-ascii?Q?OncMsV+0nDqj4JHID9791NcL1NoeNkRnCKa4LBK/wIkA7dhwJ6Wsaxfu4oDa?=
 =?us-ascii?Q?rgvSgetGA1sRGaTwVxRoGD5qv19CfM0woVM66YoF3v2HeUZlDA3Eb3yRAucy?=
 =?us-ascii?Q?Ao6HmC4+tRqqs8HoJixy+EZ+l+FyAEhRfzFcQ2Z/D0bp8y5gYKEa7RuGqVfp?=
 =?us-ascii?Q?QKfNP4irlc6PGGK833btX8MrcGpcSOS3puKfnUtEOxl6OZG6QjlfVAzOqhK7?=
 =?us-ascii?Q?RoCl87R3WdGbsGQehj2uldLDDOKeAsflvmLSkVSASp3JtiOweANi3ECfiNGl?=
 =?us-ascii?Q?DFCguAXT0TgsIuvqZxQPh280RmxxaW54qyuh3DopM9rMWVKr8T6GFGZ4YCYg?=
 =?us-ascii?Q?lKJW557W68a7G0iDQtv83ZVpEOJPVJlkLZf8uajRJo35o2ffodswrSt2poqI?=
 =?us-ascii?Q?KGBnmZwXGzxXIjiGu0xU+Ub2YDMs+jyzh4xxgRgezzQ1joOlW18DjrrY7QIA?=
 =?us-ascii?Q?VyisteF7ldGWo8UxyKUsNV7Fjk5Fu6R/Z16K76fVdjqtjFuwefKgzJy6AgY3?=
 =?us-ascii?Q?u+geh6Ov+WH3tKIoUHtw0XPtz29ArAREIoU6i8j58yxuUJo3IGJ+ea22vsVX?=
 =?us-ascii?Q?9aHbQPE6jHuaRHJ25UQxEHLOM7tVLqXzwGtaEF5dB6Lvj2uuFMQLWpHW+WOV?=
 =?us-ascii?Q?Pc+Wn5g42zjbqKi5yEK/q/QnKJ58HDjun8aJr4EufTe0qbIn3Nw2z+U/GI2U?=
 =?us-ascii?Q?U6QBFAW9l+mlFUjjT+sEk+5CKFyNpWiGXeel0oS1VtoJJN7u7rcfnbPcGNje?=
 =?us-ascii?Q?NOBHiQEszGkR0LD4Cy2QErpf7yV7gakqe36hpLHu3HrprkYUsseIP38KI7H4?=
 =?us-ascii?Q?DiAMwIVgcXfE8WbReAz5MI4OdjqxK/OBKqY7ssDG3VqCoBBdmIEV6zVzuXYY?=
 =?us-ascii?Q?39HBfL/4sJ0SIS+ZlTcuE2+6ueeIiCEUAe1ZzeS45ZOyQPvAcxCFFBaK5r4D?=
 =?us-ascii?Q?avd/3q+ZVCb/btARSXZAQhXV0CXeVPvJSiu1EwR0Qaa2VO0OcREaJWgIJjlN?=
 =?us-ascii?Q?xQT6CLi7o8HeQh9i1S05RCNmTqhsyexH99BM3cRnAS7TLDAqdgo8wirUEMGU?=
 =?us-ascii?Q?xRY3zIc6aF+y0QCpHF7eY9xraB7NC2Is6z2pcmMe1oCyGMCEdC5NJGjO2dvK?=
 =?us-ascii?Q?WFlrHYPsAYqbOcO7Q2HyZIFJkYF4Rvf0Tjj2KTgHxFl7YJrFaAc57ef15I/7?=
 =?us-ascii?Q?kifDpOpY34ZRP19wyD7KhjrZrkdquvyVSCMbgIdz3/2w5UEpEkGP0MbR5Hi8?=
 =?us-ascii?Q?wv+C5z5Nj5L8nu/QqBZhcj7rah4fSAwyKfh2kAVhiMP1dYcEon9Uo/2SoK5z?=
 =?us-ascii?Q?awJHY2Jc22e4BNw9g5pKQlEemdiVoF7iCcD6552Osr9LqraHjWxloTIQjEn0?=
 =?us-ascii?Q?lnQRq/eK1SUMRGtKC4I94b8EUovjmgnxi0l7PEVHFa1s+Ner/Zfnxx6znIP5?=
 =?us-ascii?Q?g3dsd53mjQZshzSMElzj7fcw/dPiLWsG5gYYsKfOAZbu9imwDjHvajbM2fi7?=
 =?us-ascii?Q?xdWX8hQYcx/g04F/ARLuZaLrI8y5REA=3D?=
X-Exchange-RoutingPolicyChecked: uFu9rYW/SmGlAhjWE93KKrG9Ud1aiw5Qn46Q83Pjf1c4Xt6jhk5GH9BYQ0SiHsISTzdmMo1VJqLg5YXZw8HrzNlwgzX6sqEjjVFb7aOcus4+8JEzyfZeusJCV2ZAfqh92N/kpEARH2jB0sPi8sWlsz06h0ToFdZpRER0DpbFi981iCzmG0hbiwQKWiMXea+tVKqggTdX86H/8yulyGZNfA/uUpQHF2R8EndhlFcUjTPmDN9CHilijCl8Jo0nCd/pMesrg/LMkIOYSZACluOZQ0BT55ursQ4bYl8uJIDiWN0A2C17YJxWFOpD1nzcPtSBLviaJdhqKDHhRMIcV2fDjA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd89d2b-81c4-4105-0914-08df2b90a51b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:20:35.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIsWrrH2XUfHWRdFXxGVVAx3HB1oyJY4jW6J2Dykerxyn6myovJYiaVaLanLP+7WH4b+C2a7Wu7QCrUVo1zPRTucKPnAuJoCKzv6H55oOTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-ORIG-GUID: cMrVKQqQ-adKoEyDWMT6HSLwpb5uuUeA
X-Proofpoint-GUID: cMrVKQqQ-adKoEyDWMT6HSLwpb5uuUeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX0NyUuSsAqr5I
 wt8mQHSbc04d4uIRDd3Ch+F9A6GZH0NhOKP1EeoTwdWl7Z/M05ZU1+L+tjdEjg5znAvFA9o6D/u
 zaEajYsOMyX6UGozw6oIsHJIxsW5dxmUT5g60M/Gcis1STwdzPS2ZzprL45LW5hGG/qeY2S3oj1
 c2cBC6LM2ENf+g0wxNL1nmO6SNzZHpgbmZPtTZuAVhhPCxeF6ro5/hAfdRaCIb1Qc39Ym42QacA
 Gd8cY+JtxXMlW74hAubg0uePobT1ofFJ+hBLzwBSRGOK7JVGJ1ebHDzZ1ee+c2KVnkYXuD4VGWb
 bfEAaZKokTszsvOdxJBrUC8iFAyGjdNqZZc/73dcUC2fEnIEwQ5bBavmpKC9MAUDFNQpOl7Dxjr
 ej/k/iz0e/5i3eWHFywZNWnUY+Z3zUZ1e5H1BhP/m8Q1rzQBwShJI0roJcXb92j0OionVbe6lJb
 ow5JwpMF4CTi8drRquw==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad232b5 cx=c_pps
 a=wyQZsu7YS+H2q1uHh87QeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=8Gc_limY6Ox-UrGOeuAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXwz2ET+XHUGZX
 pjAkwu9QLU4So6dMOwEnpjyPDQJGbJriTEbFbKaCA5+HYsCar4ZZIqCP9vqNAraY1DHCYdL2elM
 F4oTNGYY0q9Q/lHCEqQCrF9jSI/FVdk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series attempts to improve the modelling of legacy x86 PICs within
QEMU. The initial aim was to have a qdev device with one output gpio, and
16 input gpios representing the legacy IRQ lines, however as I went about
trying to model this, I found a number of other inconsistencies/bugs: in
particular there seemed to be some fuzziness around the functionality that
belongs to an individual i8259 chip, and a cascaded i8259 configuration.

For the purposes of this patch an i8259 device is considered to be a single
i8259 chip whilst a PIC device is considered to be either a cascaded i8259
configuration (emulated/KVM) or standalone device (Xen) representing the set
of 16 legacy IRQs and a single output IRQ.

Due to the updated device names, there is currently one visible change in
the HMP monitor output for "info irq" where the isa-i8259 device now appears
as isa-i8259-pic and the kvm-i8259 device appears as kvm-i8259-pic (see
patch 19).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[Patches still requiring review: 5-11, 18-20, 22, 26]


v2:
- Rebase onto master

- Add R-B tags from Peter

- Remove FIXME from commit message and rename trace event in patch 13

- Introduce a separate I8259State for TYPE_I8259 and KVMI8259State for
  TYPE_KVM_I8259 as suggested by Peter

- Keep but rename the associated classes for TYPE_I8259 and TYPE_KVM_I8259
  and move the DeviceRealize function into each one, instead of keeping it
  in the parent class

- Add patches to make variable names consistent when accessing
  I8259CommonState from child objects

- Update the comment on patch 19 to reflect that implementing the
  cascaded secondary is actually a bugfix


Mark Cave-Ayland (27):
  i8259_internal.h: rename PIC_COMMON to I8259_COMMON
  i8259_internal.h: rename TYPE_I8259_COMMON to i8259-common
  i8259_internal.h: rename PICCommonState to I8259CommonState
  i8259_internal.h: rename PICCommonClass to I8259CommonClass
  i8259.c: rename PICClass to I8259Class
  i8259.c: introduce TYPE_I8259 device
  i8259.c: always use cs for I8259CommonState variables
  kvm/i8259.c: rename KVMPICClass to KVMI8259Class
  kvm/i8259.c: introduce TYPE_KVM_I8259 device
  kvm/i8259.c: always use cs for I8259CommonState variables
  i8259_common.c: always use cs for I8259CommonState variables
  i8259_common.c: use i8259/i8259_common prefix for functions
  i8259.c: use i8259 prefix for functions
  kvm/i8259.c: use kvm_i8259 prefix for functions
  i8259_common.c: convert to use DEFINE_TYPES() macro
  i8259.c: convert to use DEFINE_TYPES() macro
  kvm/i8259.c: convert to use DEFINE_TYPES() macro
  i8259.c: introduce TYPE_I8259_PIC device
  i8259.c: properly cascade secondary i8259 from primary i8259
  kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
  xen-hvm.c: rename xen_interrupt_controller_init() to xen_i8259_init()
  xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC device
  i8259_common.c: remove unused i8259_init_chip() function
  i8259: move InterruptStatsProviderClass get_statistics() from i8259 to
    PIC
  i8259.c: switch isa_pic from I8259State to I8259PICState
  i8259_common.c: remove static irq_count and irq_level variables
  i8259_common.c: add missing 0x prefixes to "info pic" output

 include/hw/intc/i8259.h         |  11 +-
 include/hw/isa/i8259_internal.h |  19 +-
 include/hw/xen/xen.h            |   2 +-
 hw/i386/kvm/i8259.c             | 250 ++++++++++++-----
 hw/i386/pc.c                    |   2 +-
 hw/i386/xen/xen-hvm.c           |  40 ++-
 hw/intc/i8259.c                 | 465 ++++++++++++++++++++------------
 hw/intc/i8259_common.c          | 225 +++++++---------
 stubs/xen-hw-stub.c             |   2 +-
 hw/intc/trace-events            |   8 +-
 10 files changed, 637 insertions(+), 387 deletions(-)

-- 
2.43.0


