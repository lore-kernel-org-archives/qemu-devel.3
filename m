Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D391CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIYk-00074V-Gf; Fri, 08 May 2026 06:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLIYi-00073J-KL
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:35:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wLIYg-00026j-EG
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:35:52 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6487eTDj3185307; Fri, 8 May 2026 03:35:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=fhN2lcJvTMZVdlR
 aH1Nd63eyjnT/i2hyM9fMhMCzLuI=; b=t8Lw5zVsO+SoK0Bawl/BPC7YL7pbkn7
 9977mVWZIyLAk0h6tknSw6hjCQ3htHHNhlNAtk+8y/gIa1/4D2wLV5RQ7RMCw/lO
 iuJnEV2dP3YoRmPr4guCVLBza01CGaXBM2TwTegb/GEPzphDf1tevRXlaEKjStc8
 Ef2VEwE2xb0GrP8vNEfbZj1G+hUC7KCLYuhwR1Jm2f1GDiqq7CsPDVA0eo/cl4QG
 OWBUObNV9CqzcIM74N8PITJnr6hcbQJttzMig0+u5SZJKf8ptg92ntq5oYb32ZXg
 9UmTEbRuS/ZqtHeErOPM3c1wx1/xOqlXj7bWla5URZsdRXMrBnglJaA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020113.outbound.protection.outlook.com [52.101.56.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e0yxr1ua2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 03:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuoHPBUYEJv6frXlS6pBt4NfMQZ0RpP/4KsZh1o8QB1MbQlIi6Vgj8BwoU1nh9qPjy/GlM2Q6T2FpXvod4V5ACGeaunQhFw0QkjmOZoFMhfUMaAt/eqIXihWVc1E2x94nHqmrXjjCTqsSG+4AQKZtiU3GXrFjml/pmRj5/ezg+actegb6lnLwTpMhcOEGpEsd+0iTNAiSjdc/KJtIppLSjHZLj20HE1c0ChiljpOSPDzrEVcUwp/F4blPtCNiLyFDaweMpdbN4xktgxGspRkrH1p9bXwRKjCoH65zBOhpO6NLXpMkbXVA3preiN1ju27q4lHloH17UZswR+GX7YbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhN2lcJvTMZVdlRaH1Nd63eyjnT/i2hyM9fMhMCzLuI=;
 b=iZ2KIYeG4JUcw+Ie1zX3Xjza2mASyq5x3BLeZN2fSeCSGnpb1JzMBmBIc3rU0XpgiAtvcf81nwgSwyZyoaPfRy86Kv6nww/5ggfog4X5QAM+1lrDg6izgZUEJGWHimX6pT9unicEnvopoXxooUonH+2wtPEJOnJcLjagDAcl2GUUTQcCWSTWTDJasL9OY14rcudd7Q6Oop+Q9iaxLInPySRWGYQNhpKjqNgiggRDH8sl5p8gNAdPrbwmkU3jB/3k9Ype1b5pboR5I10tZ90i+s8ZxvdarLeAL82P9HG1Tu/P+Bx8JJ+f7B3lqEeMkgNi5dMdZSn9078lCqVUAc7fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhN2lcJvTMZVdlRaH1Nd63eyjnT/i2hyM9fMhMCzLuI=;
 b=bVGiRkrvHPaBe66amJVeYu3RrcXwXP9fou2RODfsYLCe+zAag2eqauKG6Lcr2Eg8L0MEprrs1oh0iUZLN/f1pEXavSPB5K+toChGYCP++KuyAWHRngZkUulktVo3VFr+OyCDEqzkXdVy9BpbPf7sgNHclh2MuNvgP3CyeMv4UIvh1SdVX1mqyB2CpVUb9kNG4aUkOFSmA7gKTk0pMNGLBdDziZ3INw/0l3lC2ufKhFMtXEnaE2lraLqn5NuSPLaNgRFMW6oTII13OH0F2/+g+qJm7whlXXD1B3Q8U9TSRBcZWhIp0lrFNhw/XaCM3RsI3RT9EPilgwwsXMrCjhyIGQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by IA0PR02MB9780.namprd02.prod.outlook.com (2603:10b6:208:482::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 10:35:46 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 10:35:46 +0000
Date: Fri, 8 May 2026 11:35:39 +0100
From: John Levon <john.levon@nutanix.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 clg@redhat.com
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
Message-ID: <af28e_ZXCJt4BSwu@lent>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <CAFEAcA_Q-ad3r6kV_7tUJA0maTntWELOMDYgL4aDh1AQ_p2_fw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Q-ad3r6kV_7tUJA0maTntWELOMDYgL4aDh1AQ_p2_fw@mail.gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|IA0PR02MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: bd02ee1b-a01a-434a-4b24-08deaced9036
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: kPQi7ylYn3teGBq/gAC9FzqKg8qHJz/zmbtaFiHynN9JdK1StskDhZOEYoHVmJdFMMiT7dkizkUFfTfZb4+sOz3gw6DV6sd+Xc4TujDVog37Yd/kB3HS9ANaEQblFeud3jXQ23A03CzjD29xLT8g81UuV7MedrgmVtEQ7GlAuS2rtYmlIumqJnBEmHoVOoXddwHnvPzGPd8kk95n/EkML6jFXYrQY9zHaaYAn+Qj+XWd/qGcYBiLz/ZraXyV5pJkyvy5JkkPlcxXMivi8jUTsYIg+qpmoYgRu3F20pIbpSfeWtVgOyjmtrCV5jQoznlIXPXHrwr9Z58vQ6yfYsdF94zWWUYmgDGNiPFJdVaR4h3Cx0aXxzNm3tFC8Nv8ilm6+OSBxWhegebW8+hhLJ0IAjxRIpEOXBM5SKd25pC6nBznATt2s0GMC+y+r/ri541duYrugpM7qbXr2scFO/T7D0/2QCX+Re4+mjNom1eUDCYxg4klWgtmKLxdeOfADkst6IIMtdC/MGuh1uoRwukyTb5KOqskk4EQytihHQz4N0dRtU9HhuOZV6lWAB3SXBcCHXUV3H4mggPN0tKxa1K/d3VaMTYd9esFiHQku0wSPOnLsrWl9tmx7PBBuuOveEt5gIcaOC+s9gOs8YorvCWHV2k/b5Wvr3TJwc3zYNTiWgTcxXlviFGZloT/qwTL+fOn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s9MZAlrfyn3p43QWtg449+S+Yph4d1ss6X2Q0gdbVGri6gPmpzOExESnPjoa?=
 =?us-ascii?Q?bETixrj/6wmNnSZUY/nFwaJz8MGuomd+Eb2Auq3v9j4hk92dBWAohkq//DaG?=
 =?us-ascii?Q?PXyLg+cg4IKkqOU5a9hVGkO6XBDMEnNII9J+DtjdUH0MgJU70Hyl0oa8fLRq?=
 =?us-ascii?Q?na8WdobrKSjyz+LwEipoMj49AKZ6m31MDiDr5Kt3W2J7UPovDEzdcoOxIVpd?=
 =?us-ascii?Q?DGIdB0UWVyO4+UPUOw8bu7OzTaeFLBqY+qVJpmL3muOyfEZF1OqgMT5f2NcP?=
 =?us-ascii?Q?QwpbcEJSfgjl1LT/soZbVoKjWOVx7y9k8+g1A8oQmVqGWuqVCwq2YCXI0qFW?=
 =?us-ascii?Q?EId0/d2jyhgxrSmEEwb3d6CN9DlXIeNSvIq43s8mubKTdnw8pAbrNjZdkEXy?=
 =?us-ascii?Q?58eBGLKiM1I2WOBJgpaPIgWGxjr46JsbnNYMplBE+1lPBea9ufhLkjSR61XC?=
 =?us-ascii?Q?/T43INlRj5FlyC7o3436C4DrspL0JScADMA58P8w0zjo5aJh7srdPRyqy4ky?=
 =?us-ascii?Q?ztHTdTQAbcrWJR67zwh9Upw6BidejHEnQtf1r9oFXzcOedZIOJPKErsAxRNL?=
 =?us-ascii?Q?V1pYiPvZVcIIqeEMNoKtcgzkU3Pk93GeY92GwaDO6V5TPjjPP8Av1mLaF2Fa?=
 =?us-ascii?Q?LV5sJxRXt/ANQQzei+pIMWemyzsHYKMLCfwhIz1N20zPUtLrH8D1wLLzR1gC?=
 =?us-ascii?Q?HIn9JigmnAuS6VgLJtIC/zMyekci+Y+lHZ6VuBadsVmSYZorVVHAHtbEKGI6?=
 =?us-ascii?Q?F4GG25slqFW9HYpRh+k63P/rK/jFxIzraSk5RNX1UPGTH2G/nQLyHKfOV7fO?=
 =?us-ascii?Q?80sSSUbPkLlwe8scBtYU15dvBPVzNFYKHa8Q3WwhJ8+xMunNJ9kJmG7OgKte?=
 =?us-ascii?Q?z1ncduJaZZUJS4Moi+QzywYcqZ0cBCqMKrpxTb4FE2r+tXU/lf17XlFXxWky?=
 =?us-ascii?Q?AkWpD6/r4XOc0pWQw1Raaj1g/zcgk22U6Lo82XfBvUnzQObWG9ZwIP3EuZGP?=
 =?us-ascii?Q?KW7li0dyx2POItzMR6A/nAEeyQWPAB/PoRB6fHOPG/tj9edgZ1EpiHvyzMRc?=
 =?us-ascii?Q?Gfj573BJyjutfBSqWCaZG92cnAHjnPeii1u0BZGErorhNnrNcWWPhNDNlfr9?=
 =?us-ascii?Q?FHmd9jDXjeMWBSua+7iwxnZ14quZdqzvBK98GBFKUdalg8Nu25oH+ncX8Sk4?=
 =?us-ascii?Q?OYUSq5Aox2OiRNeB+ONSILYm0uvbIlQ9y19bePG2KcHhRl+tpK6dZcNd/9FO?=
 =?us-ascii?Q?VkTG0ZnGOpFmei1vtAqoQ/1SpRwNv1LXBfLh4KrAeDeghyHRws5PRZ2gQ1+x?=
 =?us-ascii?Q?zgTB5VifrRCihYSpKdVig5g2IPwylL8nlKnZf7Csvdecpfjjq9Reg6tHdjR2?=
 =?us-ascii?Q?bv80TMVPBeJwgkMjQpxB4RKbcpEFE4I3q5sGsok1NPYIOt5FIJqvrbumCGi5?=
 =?us-ascii?Q?aPtQYJJtP/objHLMVdLMheZXkP8JPA97Noap1tx9wYS/HM8CQ2du6w30wETy?=
 =?us-ascii?Q?kdDmJtmuenRm/bYYbu77FbioXcGvdxYIsLxMbmP8oJKH/dqmZ+FiVvaNJfRi?=
 =?us-ascii?Q?sHdRZBX5w/QlgDiNlU7R+w0vh33Hm9FhdOpeNBjyqKjmVlxeQnFtHZq2OvmP?=
 =?us-ascii?Q?Oc1RwIdtB2xasEqp9n6zdh4/UQptlkbF84n7wNj1dJtipg9Upi600LVBChN3?=
 =?us-ascii?Q?0bbo7kc5L2TrPWWwMDByxoipgJaQJS8/d6p/JMIy6T2fkVhoMYnxu0cbvlwj?=
 =?us-ascii?Q?IA4Yw00Rjg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hS0qj6DIUi6fgWLg8jHoXh2p1oVVRNUDzn6uge9/YKNw0CwupObhlZ1FPj/t+8rVscp82hrkgy/eBeM57FIH0qE1WBikLnFD3l+rZMBap+ycZU8Fvv8hXcfmHKIWE4aisveme/ktRfY7AlfMkKdaG5b5CJSRrsPGJjO2kzrIYPNxtrdSxoL6NaiceHjIgNL/AlrEXvrOt0nTcfgW46awDdGiOr+5wbfutyQ1Rc7Ir1EUO+Tue2pbmozLN9PNRIMSHvDe3EGOXUViKIxSq0yBsnNzBKLgA7Ozkc/7T6Fc0vd1GPSvhLAuXm03IyK0ee5A9aVjYhAAcQD7iqgdQqZNfQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd02ee1b-a01a-434a-4b24-08deaced9036
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 10:35:46.0873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ftmw9avR7fG+sEnFfExVK0VlH/AiJDrSh4a75/uy9D/ZHi+r3vTmEnc4rhDF1oxoBKIMi+b3oGs+fLbD2Vh61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9780
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwOSBTYWx0ZWRfX/X4pmiW4zJpt
 CScNL4jSJprOoBGlit+znnG2qjl5jGWeEnHZcMYHTtbxqAq5r45bjJ0w+TUTzfCu/5HDjKxORw8
 SUHAe7NRr9GttKQot++AWUeEJ1iILBwjY+/vyEMqa7t7an8lrt7aWOu0E9zS/2hMzT1lbEDHOom
 KDf7dbe+/NczFEYAtYtvkjlbpCTz0GhCcNkzJ0srS17W81uOxaoPzm2hFHVi719yWpqVEKOwpjl
 vCrg2fTuKoBRHClI3l3bDlT2B3l6UIqnduHVLQIAZtmggOxj7qy8ubG1+C8rZuFSZ/abBAThjuu
 iiB/FgK1L99gLDmfUU6yMDc4OMMbeuNJ96PFW4KU5xZ1SV2U2Zsp5vYPU1V1uC0NducrTrFFy8m
 zdWlWIFi+Crt10R9a6AYF9vCcb5yEMSBIL8rixQp6Fhnm/FT9jgq9jwjHLEUIT3JMG6ZCj+vYAA
 ZrQqzVtUC9BFbAlkisQ==
X-Proofpoint-GUID: TViB8DhQ91NFcVwwbj6NPEgM19kr9H2u
X-Proofpoint-ORIG-GUID: TViB8DhQ91NFcVwwbj6NPEgM19kr9H2u
X-Authority-Analysis: v=2.4 cv=Cv2PtH4D c=1 sm=1 tr=0 ts=69fdbc83 cx=c_pps
 a=gm+t6+/57aVGIJ5RQ2SxIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=87dXumU1015gOhQ7AUUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On Fri, May 08, 2026 at 11:31:13AM +0100, Peter Maydell wrote:

> On Fri, 8 May 2026 at 11:27, John Levon <john.levon@nutanix.com> wrote:
> >
> > This subsystem is no longer seeing any development, and the primary
> > contact listed as maintainer has confirmed they're dropping support of
> > it altogether.
> >
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> If there's no longer interest in it, can/should we list it as deprecated
> in docs/about/deprecated.rst, so that we can remove it once the
> deprecation period has passed ?

Can you suggest what section this should go under? A new one maybe?

regards
john

