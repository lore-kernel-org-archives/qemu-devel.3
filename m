Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0783ACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWfS-0001yz-G4; Fri, 22 May 2026 16:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=96028f17cb=quan.sun@windriver.com>)
 id 1wQWKw-0003hQ-BF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:19:14 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=96028f17cb=quan.sun@windriver.com>)
 id 1wQWKr-0003ji-7K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 16:19:14 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MIqkcV3696829; Fri, 22 May 2026 20:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=cO/Gue5SJ
 ZrL9Jo3LhMjViTdcgiJOe9NXZor0Dk7iz0=; b=ncETYxuYRkonSv+J8zJMVaIYo
 JH4RbVN91Hu06SjJ/jD6F54w2c9YzEGnVuHRi0QjNSesoeJcOeQ+6Rd/jRHXVKf5
 wcdtbP1Cpx/V3dhf6c26/jimhUPaS+TCljdxS4EfJza3p19adNjdnY5RNA8oskN+
 uR0cd+sfyf3HvZ2xlsywHqrYxlxMSLDIn6a8F4+KsdXjj3NDQLXVns/+8VPfm53s
 6r60r10tZTWEgs1NaUK34zlDHqh5pmjA4XlI3b6RFOm+AzBIxGm0XZaw1te7wX1h
 ZyFcDr+LH6gKeQeJ+NZ2hjl8Tg2n3ydHwbfNxqFwSpcRSngdJFgLcBE2kmvpQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e9rdjbm29-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:19:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YW7QlwZy3PStINWohfjNfmWIfG5h8aH+agg89IY54UnNnP9a3sdGWRVwqDnG+A6HOkwWX9osiIwaE5mftgS9IGxm2gxWUOBk+CMDmUSyhE/KNyKxW0LrHff79HBNX/DhDCkMtffle+t0bDmTfK26Dkv8jB9t1fnk8FngKHXgnLD+RYwnfncabB9kIctKZDxtJdOvgygFIpEuMqhzjnWW404Mz3x2jdINzAiXZo6DvASolcPAcYTRTV4ucrb7MfnlLxH4HclRqKDYLftf5jdbiSUOrQqz0Uv5PAbuG8S58g6OaeMsEdcYtf0gkQTwyOPskKSe1lnS/vyBclEfQjPohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO/Gue5SJZrL9Jo3LhMjViTdcgiJOe9NXZor0Dk7iz0=;
 b=T38iUM25w2Ao5R8gf8Ecu9Bki1g8mbQPmVMqTQCKjPi4YGzm+h2OUUeTA+ZsicapJF6B9HoCHeN38+Mt6tqF5tqd+SPDc3F4jvD5AWg+vC5nh/sbCjBTMZEyjvxo+0bydgsM0//dA4GRrLd3RKBti8qViv/iNx8o9XO2Qk/iRhs3nxGYLwPQnaHzFChT2V3SILdIFJrbkr+idEw4T54EeIap+9pcqy+maU1DUCm4e+qs+CXot/oje9Daq5ZV1oori0qcCcmk0EJqKQPsktcqOGhaZnO0yLC1QimhmY8sy4nzNzvelwO2ZHw3J9UQvhVnz1CLArhBFFLPvr035fvMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:19:03 +0000
Received: from IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8]) by IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8%5]) with mapi id 15.21.0025.023; Fri, 22 May 2026
 20:19:02 +0000
From: Quan.Sun@windriver.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH] meson: fix close_range detection on older glibc
Date: Fri, 22 May 2026 13:18:50 -0700
Message-ID: <20260522201850.1342167-1-Quan.Sun@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To IA0PR11MB7283.namprd11.prod.outlook.com
 (2603:10b6:208:439::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7283:EE_|SJ0PR11MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: cff4e942-a9d9-42d4-bb05-08deb83f5d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: +uRhj6GA9YBzbGhkKkTztzanRTSnfiqnQSvO7+seAHUSsDy3ru+ZvGEw7OWU8nfnGlOEeWgb6O2ttL5RI/7R4HjcfeA9aSmnvRjiv3uaV4MdSN0b5ZjT79UYtfWmvsJ0a/xsJJFMY5aNzCeuXm5ik25kQ7bDHBc5DcAwVE0hCsZLyTsIav68s7stf6Q4oRnpUB31YuC7n8AQYbUHQKMPCri7bKkk+zCEYfvZXSrzIDYFHZESAlmQhf+fXFxcrqilsrg5yd9Ag2XQvm32jwapOceqVSFZUxChbh0RO7GxAr0dtr6RB+zV5uaK7LOB1Y2TluVKiCQRFjGyn77U6qNWa/VzJKwhXq2UtEhd7DAAintYMzH/v28lnZdf/wzMy1S9Wme/YuGkCp0CXBL89ULi0b6GRgbnkWRQJvraaSEUDoNFknsN3/8MFdHgXdpsUOEX1D22VX4RKAyC3o5b5t5sF9D2Wmo1mxFlN79T/xUzdetLU6Kta0qxT/qHkChzTDqSO0jPrRygGjCm0bxsPYWC60dBgshe6iy8n2Iswsr3rbKp3128KUaZi8wGidxmfw8yTZ/iAjvbsbqdywoMq21rjVZlhbU1A/nDOvpzBKKmuids2n5jK7H3foV4P7FH+n9vOnozlFOOJPUcu1YJ5Z2tCJvv0zPQZqlz7L3ctW4Nrax5CcoB0wFP9eKbmSm+wejb3cFlJLnn0OukXpyeIdIBC5JwXV4Y0RkmMk1G7Ep9GB1lSKn8ai5avhHluPNPQ3ur
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdekpFRWjSyFQCs3ZlseFXwW26dSerYi5er2F1va0SW5rDv8EsDm97jXecWC?=
 =?us-ascii?Q?u+edJGTiUDJ6EiLppntsIuPH8Nm25oOZ9OuqrlcRDIq+IAoffKaM0Ds9iWeu?=
 =?us-ascii?Q?tZCLtJbxJTbKsanFaRMGsnVaoafxJVLwl3OUuWmWk79+TzdiOmJTGdHWxlDm?=
 =?us-ascii?Q?6knFzuEnveMhdn1QTJ4HQKDq9oO0NBY/N6joaKtvhiA9i3aCNTrNfkIxk20j?=
 =?us-ascii?Q?pLrFbnepzn6sO2u0vxLT5FgjlOtweT03Vq54M5t5fVvtvX/caVm9bRnKzgGO?=
 =?us-ascii?Q?5dWEMsssEBBSwheITs+UnHhA0l0WmwzP129QrrNX3qrmwH+qR764v84n7ewX?=
 =?us-ascii?Q?PVBUQS6tuiTh6UIq+EIQc/dqgoa/mpTpzi1L6hEylOhgBKHlMjJ1fGTHsN6b?=
 =?us-ascii?Q?J1aEjzwhMqiAzNmtMFo7YanW8BTnihBe0dZMYn2Wx1vsi6l9IWvm6NcUe7vm?=
 =?us-ascii?Q?nIM7rhwWKGylEU5WBH5vr+lntw6N6xkJ5GP1TfI3/rjwd4bWR0iXbMdDAZPX?=
 =?us-ascii?Q?IHjVkYHTy1SWlhsWjWD00k1PNfUBVlF99d/bNBUo1njf/NY15ZzYLEo0tLUl?=
 =?us-ascii?Q?TjwntwV01nx8gle/Cg9cTpMwNLS2HMCQfsYSxy8tq83IxDwGcX7+BGuYl+3V?=
 =?us-ascii?Q?FvUcLq3spOAktg9tAPlSFQ0HWNKZnlLdRox85EBgyqYBqhQ1z1dbKuCTRjFH?=
 =?us-ascii?Q?ylDg62MBJC4UYJdSigzz9UgIF4zkZr6wbCtTG3T31c/UfoKrw9J5kg7hof79?=
 =?us-ascii?Q?mwB+cLPJRT//sYfG/oMm2Kt/Icil/3XOUYJ+C+3h4TPQrj3U+umKQb3BtQOa?=
 =?us-ascii?Q?S89pFuPF63x6k6hTQx2H3mBbXPZpmfZA64pLtxW3hs77zyK9GxMWqzQA5k6R?=
 =?us-ascii?Q?MF1ZnFjov/3gMU2WmOQ4DxU4g8hbw0G/lrHWG2qrwOsy1H0+ldb5ElBeASSm?=
 =?us-ascii?Q?DOmzjyu9MRSQwlgxG9bW3JWqiNhTNq0QRsaWl+kIsZuekFmayIIae0Ubh2Nh?=
 =?us-ascii?Q?cQq9pRZjwqrLpw8PbFtzaFaS1Yt8AlK73hWruexsLxlkmf4cz/IlRZ+8tso3?=
 =?us-ascii?Q?euz0M3SSc2RintRU38kHw5EgPmtj2PcYPGIMU4uSLyaISQqH6nLQ+5l4+8/y?=
 =?us-ascii?Q?zuusIezDqsxuVefKzG+mZHHLVKPZ2AT9Y8wzw37eFgL+ByBthiAaSK1baNmI?=
 =?us-ascii?Q?00N/yz1AYsdh++VJDlo1fi369Uiw59KhrwnWFiQDii78R4ED2T6q9mGrVcb6?=
 =?us-ascii?Q?tY3rihtyu71bqdmY98of7aCSPa4j+xfxR9gqmB9YlVg3hAGXsZFEq41ozBNU?=
 =?us-ascii?Q?AGuB/bkJniHjyHKWTMRAisS5esW0fJutQ/5X74zaefJ1jHj0IbsfTp20LtzV?=
 =?us-ascii?Q?+loYBeeDSLlCgsSplYdDI96pm6vRFjEIn0YI5jUHZ4Kiba84r6DkjnJAcy1I?=
 =?us-ascii?Q?dspWU8L5d4eWj5dRDfU6KIhS7LlDF2HHptT4dh7l9KbiBCgsIyaqhcZvE+5K?=
 =?us-ascii?Q?l1PVpT3z/xh0yEw25MB97VGTE205o1jYfiG+x/RB1wKpevquOkc5miYqBAfz?=
 =?us-ascii?Q?VreRFHdktrtTMTujsuKihJoqPoNMKuRNuFg4vEJsIyxO5RB2Ur0jsrfYVsOS?=
 =?us-ascii?Q?urUZ3SUfrcp/MIyINJgVCdCaygUUhiH+SqEUkCiIrV34oTajaSJ+SIV/K4ZZ?=
 =?us-ascii?Q?e5ExkJWW9N2+9osZeOiiwkukyglTzRuI2uKd4scEkS5elW2R1grfYafxZIcc?=
 =?us-ascii?Q?W5gPAuTh4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: OkfbDfc6vu6aRLfBrshpWmbrgvNL7dAmNeO+KNhipoMkTOyO6rsdglH0o9dUDC+3Bl+lXiv7796gx1JAHYzOO1bOdh3k6NkinTok5QPTy2iEww3mvxRJQjpnTqDymFr9l8cBQMAMW4U+2tvwzrXE3ODVqiJBeqjbKJ0xOkjq3QMr1Usq1OvJqTLA58L2dD5A4WmXw++pRHQxwkS7KT4K8UaNJcyD/EhU5UmDxk4KcCMLYAgWvnWA0OOWWEz8qhD2keV8z5ceFuhFbsd9DIKthmTO59UNR10DC3agXozOoHIXM4A4V34ef1xJDR0sROt/m1pWxbk2Xw0vfVfe+zBvBw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff4e942-a9d9-42d4-bb05-08deb83f5d9d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:19:02.9059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbL1XnxGwwknyJoXi2cUYEEYIPaTExVHl5gqirgWYs0xpFdJRHfjf7YHrItZk8AucEe+YM5ciiw+AcUOg+khhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-Proofpoint-GUID: nZgJqiiXkvn-Bi8tp0S136ItF0e_HN96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMSBTYWx0ZWRfXyhGbKPlEy9Hi
 2+O/zMfn42v9QcJO5+vmoqMNm0LlauV4DPlVG+9kNGzMzB6Ygw2OIxjEnyhJjm+X8I6/f33bsfo
 h6E2h0NOOmF1ssT5mlxIW5okKYZzBkHPflC5PAIqCFoteQtybOKfVVY9U7XDV3tFE6pVtEE+YyM
 bm+KSJJueJpWvkcU2W2hGT9JYkOclmxRWm6c91xCr+JgGb2bjgMo5JfCfCD+DbuHnCVZSVLl3vY
 bPsLIzdimNBiXtFwv+k4oJGPEL55uUnKmzRKfMfVzRnU2HM+uHGqx4xAljd8ZGf5PjN552SmOYA
 eHnqiZ5EDoVMDFUvjXfEOz8jNg+eaC5LvKg3xI/AWY5XkcD1K5Hqn78tp74bjc7jmbQJuCVlcv2
 4fMSi4uuJBZ9TY32ttG0ME+/hxDNcdozPgI8E1HzfPruY+j/HyhWVAvSPzjW8MlvOsk04Mh0xLR
 1EEM7pe1TqbdXfrm4Zg==
X-Authority-Analysis: v=2.4 cv=ervvCIpX c=1 sm=1 tr=0 ts=6a10ba39 cx=c_pps
 a=gkvpKNK0ht0eUS52gBn1PA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=doW0eduCIYI3hH3KIaQA:9 a=O8hF6Hzn-FEA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: nZgJqiiXkvn-Bi8tp0S136ItF0e_HN96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220201
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=96028f17cb=quan.sun@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 May 2026 16:40:20 -0400
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

From: Quan Sun <Quan.Sun@windriver.com>

The has_function('close_range') check succeeds at link time on hosts
with kernel >= 5.9 even when glibc does not declare the function
(glibc < 2.34, e.g. AlmaLinux 8 / CentOS 8 with glibc 2.28). This
causes CONFIG_CLOSE_RANGE to be set, but compilation then fails with:

  error: implicit declaration of function 'close_range'

Fix by adding a prefix that includes <unistd.h>, so the meson check
only succeeds when the C library actually declares close_range() in
its headers.

Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index eb07491819..e396394f4c 100644
--- a/meson.build
+++ b/meson.build
@@ -2596,7 +2596,7 @@ if host_os == 'windows'
 endif
 
 # has_function
-config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range'))
+config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range', prefix: '#include <unistd.h>'))
 config_host_data.set('CONFIG_ACCEPT4', cc.has_function('accept4'))
 config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
-- 
2.43.0


