Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4709DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBvS-0003vc-DM; Fri, 10 Jan 2025 05:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tWBvQ-0003vA-0S
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:07:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1tWBvN-0004pV-IT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:07:31 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509KTwbV008670;
 Fri, 10 Jan 2025 02:07:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=f6A83TDlG/ILv
 MCHyisua7K1JC3wuitF0H6dPvgDoRc=; b=cSh1aTgQo0erMUDadnK/pjF8M5N/8
 gar7jbdr6Jp4C1ekGFs/7cD3HRjbFfVIQnZORguovGafjftbFe7+n6Ji/h7hP0Xs
 Q+1QYsQ+y4qu9MfkFNmr3RQSyMm8pmXn9FS/tJwTfy1mlTcxCDx+FRsRM59VHai/
 2G/230hxBbIaDEgL81BI1FX6f6F45VkvNvUQYIER/JdhoGIudvxIXMiH9lIZb1re
 Yg0gCTfXf4s4gg8zaXVAJ6qDddvarcsY8uTIY0FxZaGnG8ugveNk6xM+jbck7SVP
 MIb2rUWP6GwURb0YAIR2j7ABiJcCS8ZWkUe8CIyxz7Ssd5Sg9G9UB8P/g==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y1sccevg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 02:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPw7hDWSH5FF2nJkUpwdSBCO1KU+B+JGrYEQ5oEn2Y4SnZR/kHmCAvLRN3Q/lcwH83nydVt1Dt/FzTlSvHRdGbOrDOJPcLnDQ1eqnaZpLxgCEYG40oJvVikPIMGONay95ptsD8OvaDOeRmU10wKL+PGX+YpsrRTPecV5tNUPBZoNN6p+Hvtk+x8GQgZnX5Ly2DGGE+cE7zM2Zt3HKBYHhWG41r4U3+es8S8yQInw5sbcaf/3NSNP/vI+qe4bATjaYYr9kNCYfkJFpC02c2ontZivYvFtiUTQqoKSGVbPxHhd5i4AueLPFuJsG1obs7QU0leNfQm+wuXnYqT2gffw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6A83TDlG/ILvMCHyisua7K1JC3wuitF0H6dPvgDoRc=;
 b=c4ZYFomID54g/Zq1yCLjtlFYLgRwBpjbJzZrRmPkj9zpIQqYFuaVCiJs+iPfp2XGueexIT/akaFKsrWNIvuGb8ZFM2AhdDMMp+4ItYIthD4KaJNdI4du4pDDnO2ecTkXqkOYX1d76tdoNzvZjVWX6dawEdrHBK86Q0NrN3DFKYQO7RhUuSR0B8zB8KpU3QJJqlo7+F1iwtF2lBlAPv21CcrBaO88Nq7MLqTE6NcYnloTlGNUxywCB8sJBOYfGZGGhWaLLg0htvp4M121RXh6MfwHcUUSjbnLCLWu/UwjOqTp8uUa1xaH4NoMlh636DwY6n0d5FFtNDDIFbvrVD+O6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6A83TDlG/ILvMCHyisua7K1JC3wuitF0H6dPvgDoRc=;
 b=ELANWNDCCLxum6347aYSl44FNYSkgNr3XGvibpS0/QdRWlq9NxtkMrEyDV0TeE3z1ACwJYGP7NFs6u0B+M2rUbqsN6T6FGNDQhBkfBihgqikE53VIKncZqlqkUTNJWXPEiv5ee6lBtgp5K5OBTiy45gi+Ra5Q6un6T8aRr99WXspjLqe0yrhHRIsp/EniI0c3OE99FVOYK89BcVrF7ZigYUEToRf0GJV7Zqhu/FRLiafmXqM7ZrdMa+aYpjStxpUeI7Rxt5PgajKvXcEdY8Y5OWTvZCn3LEqSq1kbaLblHVi5iFIp4Wug+DcuBp2XdLHRQVizs1KYOLYhy1EdZzvvQ==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by BL3PR02MB8017.namprd02.prod.outlook.com (2603:10b6:208:358::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 10:07:23 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9%2]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 10:07:23 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Shivam Kumar <shivam.kumar1@nutanix.com>
Subject: [RFC PATCH] Fix race in live migration failure path
Date: Fri, 10 Jan 2025 10:07:07 +0000
Message-Id: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To CO6PR02MB7555.namprd02.prod.outlook.com
 (2603:10b6:303:b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR02MB7555:EE_|BL3PR02MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8d0c9a-52cc-48ec-f739-08dd315e93d8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7oXkujuvjtgzCm+5cCcTaxfTNdKNmwCL0Gf1g9G+5Yd9OPhriw4X9vTI9OTw?=
 =?us-ascii?Q?1Ly8Ef0YGw/hQwkUe0wkBMvB18D18+W59xtj36HJaNr4r/YhUidD4D3DnrAG?=
 =?us-ascii?Q?STfE8f93fhKWFKD+a/DRNZHSsWJ5fvOCXAzzPrpmsvJaP+vuKK+b8QOWqiYw?=
 =?us-ascii?Q?kcrbTL+gcUcZX+DRXM20h3L6WKD2nYbr7d00woBvN6xbk3uLp+/5zXjY7wYJ?=
 =?us-ascii?Q?eDhZ4IPSnUZcfDCo1kGs2sW9YDvaaoBm5NexaZb3CDFtcHAsXgGWDMWb5KIz?=
 =?us-ascii?Q?fqh6LxHiXI7atYcGhiT0+1FCs4T4RFDkElrvea4Vgk5K+YXBd/HaSeBwXS5w?=
 =?us-ascii?Q?p8W2RKF1pnrUi6LETGPJE5MQM1tyGyLLMYwwSsFCT6G6vBbRHSplzB9h6OQ8?=
 =?us-ascii?Q?Ks+WkW9HIGObPH7v47Ksm0Xh3GzJpTd8LKitKBlfel3NhWHkY3ofyjZGBM1U?=
 =?us-ascii?Q?AhXKPlfrmRA7nQ/+W2fjravfA9wvlgiYbUJTndia73eJxbnwF5Fm1kQVmprW?=
 =?us-ascii?Q?UFoDoUviQ0LWzhJJ8Ah9f8qzYmpK94aYk6jtfyq1tNlWu5Wm4y+Y2le2MDof?=
 =?us-ascii?Q?NH7rulhFtcrU1F8ettRNRRBG4fSl6xHXXoDcVN5tsh6iSHstXw2Y8LzpTDlo?=
 =?us-ascii?Q?kJbwQwyUZORItF4ZpWZNu6244NTVksNQV/xxxkPXhyOLPUL3rSS7aP4B7xXL?=
 =?us-ascii?Q?jUm3a2h0Rk/8Nk/2aDCyVx8JJdVkx1Y8Qz7mUbliAtHREmsYwcLXPbFmBcJ5?=
 =?us-ascii?Q?aVSlIT6D6s6lwHMV/dbC2ZoiqshP2rD6lAd+AXrNRQBJfSy5V8cJKMjyobDy?=
 =?us-ascii?Q?xVmuiuiF52xjZs2U7xOnJ9PVt1NKc3px9UKNmABwMLLu/Zw2YgmVBrct2eSo?=
 =?us-ascii?Q?p+0ZFqvFaUE7EUc3I2B7JmKKaCn4shYFJVNR1dGo0vP2HY0i0HiXQpGHiS5g?=
 =?us-ascii?Q?h92Wh534Xf62tfraIW4mwcmBtRzj1ceElbXRSAhW4djiGopog032gKytVVzr?=
 =?us-ascii?Q?5+Ddo9rW7TjX7pjI3bSp50RjsmJrLO8ri+KTDmqsHW1aJIfSzbjhVtxezgX6?=
 =?us-ascii?Q?hW4GMJijhIXk89cLOpeO4NXwW8hAgJEysGxDUcAHaHI18NBWgHMOqD/Tj4t4?=
 =?us-ascii?Q?XEz+mlY7BXofZMqAKKR1dUF15xJU/7yragAYV561GeSv36tgtKkbj47+MOOJ?=
 =?us-ascii?Q?24aOXXFqdWtJbD4kMKrhbkGNk4hxELyLRi6kNqodYcZ/fwGpYWmXzFSqc241?=
 =?us-ascii?Q?QPDx7QNtoLVhvBp0VcNJcZBexgKggJ79QkG4mvpv9rUQpWxchH/SDieMuMir?=
 =?us-ascii?Q?GCCEuCJE4BChQULYctb77w9tfrWMSd0e95KmIc+ycbaR7YEpAdNd7tbt45v1?=
 =?us-ascii?Q?6yO/BNMvz1IybWbXioenpI355XiRuXMHwzexoNdXAAZhleo08XDK4oOvide/?=
 =?us-ascii?Q?6tsv8eCjk4VIsk9JFMShl6e7aMVHqfaK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWNcrUye9Dx0hE1kJt9u2eK+8N2etHaZoQVS/9CEVigzXyRDS0FWQjoEMRuN?=
 =?us-ascii?Q?ZLTPrLSVT+J1RxImG6jQn0TpF6Fyazdlwyv0I4iWIbjJlPcAGGiOV1JCzHQW?=
 =?us-ascii?Q?Vui6guJfNx2/nGsCG2VZdUCq3elBVcV/4qUPyLpeO4+SNlu7pSA5GKGVDsBs?=
 =?us-ascii?Q?4MEw9O2EQ/Cj/x5+j1MbjqA3uh/Y9l+5LStQHF7fBw6SvlFTYx8Db3pmJuqe?=
 =?us-ascii?Q?DBc/xMam/20FBWRPKeabma6JrhaeqgvAzXJN/BgTOczNaeVQVylWoYv28NcK?=
 =?us-ascii?Q?f1F8+6/lZ7cilFWx4HokTMgb1Vcd4AkP3r/AgBS0/pRZw7/B+0MzE6uj6Fip?=
 =?us-ascii?Q?C4TA0gHHyLkI5sDHl0vAZc1AHhEUF0SOtkSZ6gM43IpWC3m0upag/K2rkDJk?=
 =?us-ascii?Q?+koh37GF/z3zfkXNp51xJEwx8qgEcpzlksApi7NTvq3xIYq5enFioCZUjUXw?=
 =?us-ascii?Q?gpa/oQA54qly+fs+z7FtBoCTr5a8xc6VeB/TLMjRhlm56onKb7jmlq2dG81j?=
 =?us-ascii?Q?2OgWRJbQ0cAXawXTbfE7IKcw+l1aQFdruLr3ZqzhLmB+vOyOxPW6qhv2FSSI?=
 =?us-ascii?Q?Y7QWP69br/VxmX/1ApMO146lrU1KGhb/V7gIQpOavpMWl9XmrT4YuMinnfXX?=
 =?us-ascii?Q?9z/2R5ghR96rj9CYLPXekqNHgNQUP2j7mCBkWqBgK9NoymAsLf9tjSc34mai?=
 =?us-ascii?Q?iz/21nr95upbSjocRFiWWbKcGsQPURQWjbDgO/r9Buxph9gE9aoaFzeJvaE9?=
 =?us-ascii?Q?QuZrFNOIfeUA5ie2Eylv/feigfC23Ggmv6wMykR2uvkhYocll3PHA/pPzZwT?=
 =?us-ascii?Q?o/rlDbnH8j3/AHUZ+GqQcWrGOyEE58RoJLk6V6jPNHm4nhBq/SKgFm3VXRw1?=
 =?us-ascii?Q?rQISWNDpRK7b9OT3A2c6A5bjaYkWyLi39cfy5f26mc6KUTGQKeR0PqoRU6un?=
 =?us-ascii?Q?pqUfxt5beXNULgcLkKp0jQKTsZcCl+gMixdTdpNZ/toK1dShHVOrrIAnBXo2?=
 =?us-ascii?Q?bkyscyi7TjCOjiVHpuvC/JIHsxdiSkqGCOi4mkWVNmhDAMBoj8r+g/vnhGaZ?=
 =?us-ascii?Q?xq618n+GAvYSrV9x+d1qWgj5MwzvpfisRbpYbL2ZvlwPw2kO2lmgEqtRRdqi?=
 =?us-ascii?Q?ZGgJvC6ZvXU2fTG1z60na0S3sOgAntV/9RRPAOBS0aTeO/GE6B07mqNYVh/z?=
 =?us-ascii?Q?RPq30JidJ1YaNHK5vKs9zQT7Fu5QK4qi1I86ItR3ys6PGHIsMcGhs/4b8NTN?=
 =?us-ascii?Q?KcTTeNrTpZkbDomGyEq4HfzWUSpE3rnM1lkAUxkaEULa6nN+8WXbbfHLXKXt?=
 =?us-ascii?Q?2qmKzYEtCi48ktLXseolx/cXoEZbt93GkZhLZN9Q5chJkUiGQv6fmW2c6Wl5?=
 =?us-ascii?Q?6eRlbUFJ1X5wq6SDPng0KIyeV34AjL4QLG3R75lORVv8irwe9MhBPFBlE3kY?=
 =?us-ascii?Q?lwh2CXlNE+BNTaDDSO+ceF4gnL5IFV/VpwnBXgAC6lEG75sTThSiRgkDFaB1?=
 =?us-ascii?Q?GUJf9zSaqmYwwbAgK2sPnVbQEoGi+sMKMWMzKOooL0v4kzYFA03nPzx798Fw?=
 =?us-ascii?Q?gUf0g0OWpNR0Kga65ycFLCy8lfLWzQAOnSMdwtfLD8U+MlEbkqLINesEI+zA?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d0c9a-52cc-48ec-f739-08dd315e93d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 10:07:23.4656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5S0Nx5TlTaRZpZAauqLhKbJYau8+0xMxZZ8RBGK0Ube9AE5jv52LwsqXgaRQKIv08Qo7gAfTRbYoX1Sb+n4KoehQSFIS+fRO6CuHj/wSQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8017
X-Authority-Analysis: v=2.4 cv=TrYchCXh c=1 sm=1 tr=0 ts=6780f15d cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=R_4ZNaxQZkJKwDbYerYA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: FEl_Dz1S8Gd86hfd78t8qEizjMloo6yH
X-Proofpoint-ORIG-GUID: FEl_Dz1S8Gd86hfd78t8qEizjMloo6yH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_04,2025-01-10_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Even if a live migration fails due to some reason, migration status
should not be set to MIGRATION_STATUS_FAILED until migrate fd cleanup
is done, else the client can trigger another instance of migration
before the cleanup is complete (as it would assume no migration is
active) or reset migration capabilities affecting old migration's
cleanup. Hence, set the status to 'failing' when a migration failure
happens and once the cleanup is complete, set the migration status to
MIGRATION_STATUS_FAILED.

Signed-off-by: Shivam Kumar <shivam.kumar1@nutanix.com>
---
 migration/migration.c | 49 +++++++++++++++++++++----------------------
 migration/migration.h |  9 ++++++++
 migration/multifd.c   |  6 ++----
 migration/savevm.c    |  7 +++----
 4 files changed, 38 insertions(+), 33 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index df61ca4e93..f084f54f6b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1143,8 +1143,9 @@ static bool migration_is_active(void)
 {
     MigrationState *s = current_migration;
 
-    return (s->state == MIGRATION_STATUS_ACTIVE ||
-            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    return ((s->state == MIGRATION_STATUS_ACTIVE ||
+            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) &&
+            !qatomic_read(&s->failing));
 }
 
 static bool migrate_show_downtime(MigrationState *s)
@@ -1439,6 +1440,11 @@ static void migrate_fd_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
+    if (qatomic_xchg(&s->failing, 0)) {
+        migrate_set_state(&s->state, s->state,
+                          MIGRATION_STATUS_FAILED);
+    }
+
     if (s->error) {
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
@@ -1484,17 +1490,16 @@ static void migrate_error_free(MigrationState *s)
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
     MigrationStatus current = s->state;
-    MigrationStatus next;
 
     assert(s->to_dst_file == NULL);
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
-        next = MIGRATION_STATUS_FAILED;
+        qatomic_set(&s->failing, 1);
         break;
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
-        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        migrate_set_state(&s->state, current, MIGRATION_STATUS_POSTCOPY_PAUSED);
         break;
     default:
         /*
@@ -1506,7 +1511,6 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
         return;
     }
 
-    migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
 }
 
@@ -2101,8 +2105,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     } else {
         error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
-        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                          MIGRATION_STATUS_FAILED);
+        qatomic_set(&s->failing, 1);
     }
 
     if (local_err) {
@@ -2498,7 +2501,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            qatomic_set(&ms->failing, 1);
             error_setg(errp, "%s: Failed to establish preempt channel",
                        __func__);
             return -1;
@@ -2648,8 +2651,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+    qatomic_set(&ms->failing, 1);
     if (restart_block) {
         /* A failure happened early enough that we know the destination hasn't
          * accessed block devices, so we're safe to recover.
@@ -2782,8 +2784,7 @@ static void migration_completion_failed(MigrationState *s,
         bql_unlock();
     }
 
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    qatomic_set(&s->failing, 1);
 }
 
 /**
@@ -2850,8 +2851,6 @@ fail:
  */
 static void bg_migration_completion(MigrationState *s)
 {
-    int current_active_state = s->state;
-
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         /*
          * By this moment we have RAM content saved into the migration stream.
@@ -2874,8 +2873,7 @@ static void bg_migration_completion(MigrationState *s)
     return;
 
 fail:
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    qatomic_set(&s->failing, 1);
 }
 
 typedef enum MigThrError {
@@ -3047,6 +3045,10 @@ static MigThrError migration_detect_error(MigrationState *s)
         return MIG_THR_ERR_FATAL;
     }
 
+    if (qatomic_read(&s->failing)) {
+        return MIG_THR_ERR_FATAL;
+    }
+
     /*
      * Try to detect any file errors.  Note that postcopy_qemufile_src will
      * be NULL when postcopy preempt is not enabled.
@@ -3077,7 +3079,7 @@ static MigThrError migration_detect_error(MigrationState *s)
          * For precopy (or postcopy with error outside IO), we fail
          * with no time.
          */
-        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
+        qatomic_set(&s->failing, 1);
         trace_migration_thread_file_err();
 
         /* Time to stop the migration, now. */
@@ -3492,8 +3494,7 @@ static void *migration_thread(void *opaque)
     if (ret) {
         migrate_set_error(s, local_err);
         error_free(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+        qatomic_set(&s->failing, 1);
         goto out;
     }
 
@@ -3617,8 +3618,7 @@ static void *bg_migration_thread(void *opaque)
     if (ret) {
         migrate_set_error(s, local_err);
         error_free(local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+        qatomic_set(&s->failing, 1);
         goto fail_setup;
     }
 
@@ -3685,8 +3685,7 @@ static void *bg_migration_thread(void *opaque)
 
 fail:
     if (early_fail) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                MIGRATION_STATUS_FAILED);
+        qatomic_set(&s->failing, 1);
         bql_unlock();
     }
 
@@ -3805,7 +3804,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
 fail:
     migrate_set_error(s, local_err);
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    qatomic_set(&s->failing, 1);
     error_report_err(local_err);
     migrate_fd_cleanup(s);
 }
diff --git a/migration/migration.h b/migration/migration.h
index 7b6e718690..3b808d971f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -471,6 +471,15 @@ struct MigrationState {
     bool switchover_acked;
     /* Is this a rdma migration */
     bool rdma_migration;
+    /*
+     * Is migration failing? Migration status should not be set to
+     * MIGRATION_STATUS_FAILED until migrate fd cleanup is done, else
+     * the client can trigger another instance of migration before
+     * the cleanup is complete. Hence, set the status to 'failing'
+     * when a migration failure happens and once the cleanup is done,
+     * set it to MIGRATION_STATUS_FAILED.
+     */
+    int failing;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/multifd.c b/migration/multifd.c
index 4f973d70e0..48ece2162c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -878,8 +878,7 @@ bool multifd_send_setup(void)
     return true;
 
 err:
-    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+    qatomic_set(&s->failing, 1);
     return false;
 }
 
@@ -949,8 +948,7 @@ static void multifd_recv_terminate_threads(Error *err)
         migrate_set_error(s, err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_ACTIVE) {
-            migrate_set_state(&s->state, s->state,
-                              MIGRATION_STATUS_FAILED);
+            qatomic_set(&s->failing, 1);
         }
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 927b1146c0..4f0ef34f23 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1686,7 +1686,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 {
     int ret;
     MigrationState *ms = migrate_get_current();
-    MigrationStatus status;
 
     if (migration_is_running()) {
         error_setg(errp, "There's a migration process in progress");
@@ -1723,11 +1722,11 @@ cleanup:
     qemu_savevm_state_cleanup();
 
     if (ret != 0) {
-        status = MIGRATION_STATUS_FAILED;
+        qatomic_set(&ms->failing, 1);
     } else {
-        status = MIGRATION_STATUS_COMPLETED;
+        migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
+                          MIGRATION_STATUS_COMPLETED);
     }
-    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
 
     /* f is outer parameter, it should not stay in global migration state after
      * this function finished */
-- 
2.22.3


