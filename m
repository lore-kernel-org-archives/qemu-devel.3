Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3716C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hda-0008PL-9L; Fri, 25 Apr 2025 07:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdY-0008Od-3A
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8HdV-0000PP-KZ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:31 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P29EKi008884;
 Fri, 25 Apr 2025 04:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FQSW0lJUE9LgixBAJNeDS159zjhevv8syPCFaMuKJ
 Ic=; b=0LROL38HCjxI9qo/1rDwGn57WIZsJxWw8sVlbJOVMuW9zXQLu2wlcF9/2
 CcV+vvywYEg02iQis0Uf0kpv2XPpJb33rv47EGMIlGZIXPVeRcb2AHOcMXog0xMS
 9sqncClaNC4Ernrf36jqHVk9RMLjxGBfRO0MYx7zdFEYtNR+FeVMt+mFRJJL2uR6
 ufvya5tJzkqu+apAxO/j+17S6+/JGC189DQS7ytUXHIOujoq3y7lUZni9BvsZuFE
 54vubWfN4evCfKjwUzR61ZuR5VrOgCZn+PEYJQZFF5PpkXjp4GqIXWKjB+8L893Z
 8qP+u1VFUS9swPTcRTCnQMlWXQWxw==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww49b1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3wtJ2hGL97CumsLxLhw1omZfLrG9eWeuFNODcPh49oentxhJ564+G4+ZNyhNb9a5yiN05aCwJkvpGOQPr/1Uscr9cNmtL96t4Bb1yIqg2DQtw+RbeJ2SrFKWQolMeVVdIz6hqMZO0nGFunWEHmpfAKt6Xk7OkmIWU+R4ywelbdieWTUzXY5sqn9fswZQ2Fcq/EL9KMZxyhei8adiYP4EiBJgYyPL4Oi4QB7VZNiw6oEoTN8ZZaGGYyqMInq4g2pC7w1zYKXahkvqh16D/HRtuKKCGMk5quUEEUknmYLVfJLYRJMK536eGcS/d5/5ZBB226g7Z3ZMzzl6LKKoSHJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQSW0lJUE9LgixBAJNeDS159zjhevv8syPCFaMuKJIc=;
 b=gWgjvsk4cMEnRiSAZ/SR6JBE3rfyz1DHpteBoTrnX3Gfd2mewuI1Zc8k1Asa3pIBwa9u09U5QAOimMyshfZCU04Wegij3bZlNR/1dawnjSRmrqg+bE41KWaV0mjTZHjtT2LsjIrr7Vh6QOfmb8epcWxwZ4Nt0bd9KClRQlZiW2Os+hoi4yvAnGuuqTCnmR9VyYb3Q7HnsnVODNIXOmatkPQKUOwdCoe4jNDgAry+9I/c/Ld/SxhWrehm83QR9jkJKs76377bcHAG9zAkTtnuJzgYeF4GcCoEVtnWZeakiK9Es3Eea2aHDrfKO7mFWJvxlvVoeWC8XT2b6ySA+QKtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQSW0lJUE9LgixBAJNeDS159zjhevv8syPCFaMuKJIc=;
 b=ZQwUt9RztfIQQ50MoBUumLhr9+/xA0aL8qYsoC4CwwOAUQvgm+jAD7iTzPl9Uf7lu4CM3xDqrzMsVxYwkiiib8Uk88jn9b94ifbI4kLU+dTg1CxyHQZkOv+9C4VW/Vy749KpljgQbrVTvh7LfAqQR8BB+NjzGhwsxHfKU9aYBdghOr1eYpubPhldD29bGmfSR329AHjZ35/ro+4FY6rPqsvpAlaPnxeF6aoX2xXDfduehKyU5Y+QN+DmVF71NFG57AivGhi73U8N7vT/er4L0R+9iheY9//qXloid3mjzrLryp3l4bWGcfE5p7h63ymjskTaRl7KZpPho/FbfslbBg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:25 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 07/12] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:54 +0100
Message-ID: <20250425115401.59417-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::44) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 8507dc69-772a-4a75-6325-08dd83efed0d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+hEZ3+7pf+8A1S9YFumfPhH+zxwtm4GhfdXkAe6xE92BbA6b741yImRZbEAB?=
 =?us-ascii?Q?e0PoCkqRShQKyKt9RDpoSiPlwvuGAIa19Mm4i/LN3CgTdDgKfbnBh45EyGKn?=
 =?us-ascii?Q?2+7Ynd9BEf0tZQeVeqBTu7GSuSA6Cw7ESjpzhUOdpG9qscCxVtBICXqY3v9I?=
 =?us-ascii?Q?w7b9yy/7cPvL1kRIi1BsFN6PNCAkeM8OPyB/HRn+7U2FkOmesjtU8cIo2yMG?=
 =?us-ascii?Q?c4EvNokVDLtvuUwnMmpT/STJCZcTyodK3CSz0j/bbNIkM812Fg9XLDh2XqJt?=
 =?us-ascii?Q?uJOii5RfFoMJBoVswUhL62hUTef+2DfLsbQIZ4e6QJtEgvWzjZqHmVZwq4A1?=
 =?us-ascii?Q?N4X9piPtSvfPdKOse5SwywN4Opxt3HWaiushdk0wJxgH2Zx0A/44n8xWHy1K?=
 =?us-ascii?Q?NjoTOKrEGCdaEtH2LDV6nPmGQh+CStZCuiGNMc4xNJihlHs3seSoJ/jWFaV9?=
 =?us-ascii?Q?GgsvUIf9Nza1pBIkH6H4N2cvK/oDhX/KwJdMxAU3sWdayew49LzhjrGMwMTS?=
 =?us-ascii?Q?TWSlwNKHUJzHDWhlEPC3yjIodzNxwGvdaev6v4l3U5TvLYE15jayRZ7mVcBg?=
 =?us-ascii?Q?qfWvKSM35rCHyn6jL03uTjCFGlsUfAw3xct1L8zOk15hitUif4K+glS2oZvk?=
 =?us-ascii?Q?1dBhyMLIU4pNUiaiV9sPY3+Kq51UpH3lFUfiLez1tLt4wDsY8ogXQtRvWXky?=
 =?us-ascii?Q?g4KUys/MoZvpI2eAQvCXKf2jKBex7CzNk6L46qVejhzCEonZkRM7uwm3XdXK?=
 =?us-ascii?Q?xlnLzs8/+8FKXzEZ3F9v4amZuRZ0/b2D10uayu+8p8PznW0aXpaC4XIPN7PR?=
 =?us-ascii?Q?dwO23TYXHuuZUGBvtM1reiKPL+Aw/nMVQ8MR9AZt435QEN5K+xueiH35Wvqo?=
 =?us-ascii?Q?yBY/y+ytW6j/1tRINLRLq2q/K1uwGH6ZbvzqDpdZSnRSECaeLW6c7T8ZCdzE?=
 =?us-ascii?Q?NZRSzJqrhPvXcvlEP2ba0uimg+qOVVl9YfEDS0Z0mjAYtj5+NvIenbW3RhjC?=
 =?us-ascii?Q?qznTCU0rojPGWS7fgy64DRV5RWyPfT0upTjxne6FbS0NxJxHUl7WVO8MkF17?=
 =?us-ascii?Q?Aw48iESyTO+SB6popACt5uM0kWHgEeiy+soaXDX20O6QqJgxHbCXJCr0PjN5?=
 =?us-ascii?Q?KCX4eNzUUje3/rni+p1JuNfjX0kVsgh5LjxCjD1+v5pMS9xC/UNl1+/7Gaki?=
 =?us-ascii?Q?oSj2WKo96IK37TakEFOiF6J6PvlZy5+p/MXIf9OBpl71z8a0rr/0wm160n1p?=
 =?us-ascii?Q?61x8UXD36L8VI1Q5BuAEZ+chZzRG40J9JlvHyZDQnn7Kv12QS53gBYpYbTcV?=
 =?us-ascii?Q?1UpHd96xpbyJoxaDAuajrUnDIqS2qGTqVBQbAaXL94nPEhQmrvDnrxuevkEC?=
 =?us-ascii?Q?vM8r6Upk0sfT53RwThNT6oXUyL/zJhVmIFZw/Br3usbj/Xr70w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G03LNhSdq5nyikCciaAf5y2DhknkO7ER6oliHDv0Gy3IkotpilUpRrSxn4HB?=
 =?us-ascii?Q?lCxCCUUnawoaWWItlI9rkswqN0k3Vp8okws1o/KMbU5/7S879f1jHEsggFOV?=
 =?us-ascii?Q?12DMZ+4NuHUwG+mOXJ1nAtS4AElkfpnlWwXvjYfGfNqexOy1ZCZUdzC6roH+?=
 =?us-ascii?Q?yOwknBZNng2fIUD8bvSdHnVemTCMv4kA9yi/69YNnZRsVRhJ8eqC6Qi69ZJt?=
 =?us-ascii?Q?xwQH2FB3v5eTb4+eaNUtMGQsTYOXk/50Pln/KaGyymn9mdSrXLvtNI+R5s5i?=
 =?us-ascii?Q?glZ8tEJPF8Nl/vNgYCZsedJHwgBDjBNuBhDXfGO7mym0rqd8blP/O29/Kclm?=
 =?us-ascii?Q?vVrbZgxWG4VT5qoicRMWuNKVwGa867fTaSLkSJ55CQux7VP01WHEsdDpMo6z?=
 =?us-ascii?Q?8XTG9GEI9ybFBbTbY1ElRfbME1Jn1wegk1ZiTLLfxf2jdMMstKQp/u5WV7G5?=
 =?us-ascii?Q?aV20+jB69i0+HM8Brc/yZ/CvPvKdZfuOP9Y6pv6clTwMTu+oJgTdKxyqwp8D?=
 =?us-ascii?Q?1mRrcFgHuyeMUWf2ErhtzvG2djLJVWBypn24Tmxkb+Q3jbv3/QXNj+pJMQlH?=
 =?us-ascii?Q?PtvLSNxN+sAr6CjgQnDkfsgyqqk1poU7GSDiGLHXt7D+9eR6r3Hi/+6Uc1Ky?=
 =?us-ascii?Q?ja7xAnOzmDqsdeq4XfF7ItKy8HhzDu2pYnFWERehmZW8Lqyggxz/17jE+GU8?=
 =?us-ascii?Q?EWgShAz1/JyELeRqEufWK4LOzr/eEqmb4FSBPamW5SDQ/JuxLEz/2zZHfWq3?=
 =?us-ascii?Q?Lcwm7S8aXBRUwJCpLun5NfQ7/Y/JexR35wXiUrSA55ETsdmyqoiYw5jsHpld?=
 =?us-ascii?Q?/dc5rUPW9zEXUbMQR6keBC+f9cpZBeBla/TnEhFn8U3J9sXZHVjlJ1o8QLkK?=
 =?us-ascii?Q?8YTqtM6FSUavR8AEDESkwNw6dFEfH/NPI/fNB0bH5awPR0QryqtptONkIpZ9?=
 =?us-ascii?Q?1h5RYkD8FTMLjuLgP2qE0VMURerPaCBYcFcx4S0OWEIhOzEupvVdpHzLlLbS?=
 =?us-ascii?Q?6QfaDQKCkGpIKNvrtVOLYE9XJlS6KQy/6W5AbibrqxD7ctk60c6nnwB+lXlG?=
 =?us-ascii?Q?TXKUxP9wsGR25xT32zxY7eXd2OBDMs84NQxYOlZVfKLvgPm39oNHi9vWujAM?=
 =?us-ascii?Q?8bOcGvIVqnjDm9XhDa3/OMz18bKXY4vdw6/ENFST25RAxSiD601mXc2/YMuR?=
 =?us-ascii?Q?vI1VcyBaeDKzUZijkEkAT3nA24gz2DpLIkGLLc/94sev9tEDSmp6rwOGpqJp?=
 =?us-ascii?Q?Hrtr8jyP88z2tvV7SXPcc2+TXcoK1rH8cGOuR+OEeYs6GbVyg5I5yTnWgfRG?=
 =?us-ascii?Q?mgpa1DS0zmSru0TsoZp9tTEsb8naPGOsRSFl0NslqlNJi+tjVuCd8UEjgjFl?=
 =?us-ascii?Q?68TxsA7SnHZouWt46gHEK9cL/8dR+hbHvRuRxu5502Ad7SqEsMTRDF6oUWKa?=
 =?us-ascii?Q?1c3yk8BhWCfh9aa0cOebUNmYw2qIc9M0xWz+MHT0gt1VR8N/iK8tyFyk12BL?=
 =?us-ascii?Q?88b6JRVW+aqnptyA1hhscHWChyhpNWym59rXFMWD+UtMLb/zSfDCEhoqAthO?=
 =?us-ascii?Q?pHEit0h5/h6Xy+3CPYHtIV+fsuvP/2m3zZX1eQHaAk1Xt0yvxsDyETytWX9w?=
 =?us-ascii?Q?lm3lZu06cWVxU5q7CEufLwPVOkWy40J9etznmgOqPmKlfOBP7KyTbVbooevs?=
 =?us-ascii?Q?3k3fUA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8507dc69-772a-4a75-6325-08dd83efed0d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:25.4969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fFBt4irzUjVoWRg+zipFsQKGH8mpunpY34jpSG+MNENeDNDI20yxlyx3D/hvHr4p/JFJR2GtUR4a1OiOgzTLWLoLWNDWG7aWm8gDVVJFtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Proofpoint-GUID: DUteSMtIgUK89bGZA_UN54QwqykBFk-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX1KF2v/a4eOdY
 0/owglsmJoUxeL38r8v37jCiQkc29c+bTB16NSd88Yf0oLP6V4or5A2noIOXUk5Rx2UU8Ill8LA
 0yjqp2kHxEJF8A1j040jJMot2w1p5TC/pZk+TXE0oNhcFkZ09Y4095O4ie/nH6yZ51BTEkEXj5W
 /81bC3KL1fAjTcfJVFAz7ElBuVapCzqaxohmtmpFidMePb+TbHiHO88WowsJnj9Ufe2oQbwMKPr
 JkNhwVicqrWNkjtNPq9KzL2y9vL+fTT9meXHcMaU2ueGqmJKhc+5h7MOeFKyInYnmJxVj2Y6XI/
 Eeaz8tUBxu5knEiQAbLEZ6QW4v+pWEQF0M8qDhoMTvdddVZFj2rKbZLAz7wqnxW8401TMbY0B7I
 rZpFBDUXxSr+nI9GsdlOpsubPXUhrHLsYvZNG87XbD/tnT2sVmVWQp2fhNJMFkYjIwllVKbx
X-Proofpoint-ORIG-GUID: DUteSMtIgUK89bGZA_UN54QwqykBFk-8
X-Authority-Analysis: v=2.4 cv=C7npyRP+ c=1 sm=1 tr=0 ts=680b77f3 cx=c_pps
 a=MGIL9jhmtb3Hqg0nl2vIzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=cJTHVYagl2foYDAtDiYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 61097c1e15..9c78f485dd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -422,7 +422,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -445,7 +444,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


