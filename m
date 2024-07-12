Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982BC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCZA-0002j2-Vs; Fri, 12 Jul 2024 05:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sSCZ3-0002Hy-Vi; Fri, 12 Jul 2024 05:27:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergey.dyasli@nutanix.com>)
 id 1sSCZ1-0006dP-9l; Fri, 12 Jul 2024 05:27:41 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C21OMN001604;
 Fri, 12 Jul 2024 02:27:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1ldzFAD3rQFmy
 nNedMAbJLbKdY+vClkfqVdtl0TSFRA=; b=0A9nWmjkkJEAwuU8A5sO9wXBu/Ahr
 48VnyZyp+MkcGBS6N4R/vWYG6y+plQ3hr4mDs77haINoekeQwFbfJmbVKerZYXcb
 95bDLBdmpNDUVwYOoPeGrKS8Xw+NhJ0F5vCoLJg5RVavIMhBQ0dwdJkNQj+6RQiK
 si3cQXY2/IH7GEJheg0cGKMgeNtyRQmB8RwWx7LUn5sXkIOEnnFik4tGyBpyCSf3
 vHTUfI892Bo7pt8In+ET56n54/DzhnXPzPwoEkNWAMsZ0chIiItGdTR86n2Ky+1Q
 FEgI9YZAB38YikjJs7ZB3DZJYfApCjjeGtweYWmNIDr+mLKW6tJe1r4vw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40741fe6rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jul 2024 02:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4mYhSvUQo2yQqe7gvQ9CPCCpjb1imCGGodKHNOIF4SEy7g72twluSgDLLXNEG2CKzDcNbb0kfD1IDVwVwAo8S4Kkz5BW922rbM9UC347iz4EcuPkHqODMMc/gyqJEfWxONApBe6n4D/EHET/puu94jxLGAafbF4ybBoesBH3aUK5oS/4KsKUhLXvDyDLo85oHd/HfYRDCnQxXJKy0AfW76LUbYaOdYQ6NwKldxdjbs5aMsUyo6KxCUdWsCScKVqikAeSI6C5Wt7vlkFtNgotX3Mrx4UmMSBMFrGjf7DRkK90pJA7VAFzcnkrHSvX0Da1qtVbDQZCKmpWDFmtuoJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ldzFAD3rQFmynNedMAbJLbKdY+vClkfqVdtl0TSFRA=;
 b=R0tC8bM2lOeOpIzbmfIAfHG9/PScWsHJzlARdsdqAKknt6qAa2neQM5qI2APnIn+PlnasO+Py7GKsgVPoI6csfZRbSEyrQ+ZGBsAK/AxDOFEJ1B3mIW5k5Y8a7saqar3h+/YXZcy44S2a+P0zFisi5SG+nP19Gy2yMyzHOWxirwxbyga8+tVpKCsirwrI2PpzcSiUFFP/pURpBHvoQTyj1V1D9X87Z2qnyiWxC/ka3b9btxaJ5a7xp8XdmYqvklH7pKpCNRYDZREElYdIKa5+t3g6UFLZXTV326zw8oSKQm+T7jrkWShoy2VDkwEceAzc/6yrvz3IP3EKfRDC0tE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ldzFAD3rQFmynNedMAbJLbKdY+vClkfqVdtl0TSFRA=;
 b=QgzWPmcfTeDSPgWyhkmFw6gThZbD6/olhUM99lUdv60V0rO5INCVYXLBcDAGlVztOmgSaKAFK+90Vy5g9vYWE33tiY/XJf6Ca6ekUdTJ+JDx+X5vDwxQuugRwZeMPnCjjoST49LPIUSZZVXNnojmlQhhkXVuaj4ivia/hBS92FwIuJk0/WgX1iaGKPk0T8XG3WoNaZOuBa7rH6H3Ptkk//TiWc6oniABITLHKmkOH++NpA4ZP7wT2Iiom5okF8PBgBJmNyKxi2mBHCY1WSGhF/vvN70fDfQphFHQYTmPXje+KuwxnJajVldyIdUJbOn17l2ZdMzhdgmorr5dJD9Xbw==
Received: from DS0PR02MB9101.namprd02.prod.outlook.com (2603:10b6:8:137::22)
 by BN0PR02MB8304.namprd02.prod.outlook.com (2603:10b6:408:15b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:27:33 +0000
Received: from DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3]) by DS0PR02MB9101.namprd02.prod.outlook.com
 ([fe80::ca92:757d:a9c6:6ca3%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:27:33 +0000
From: Sergey Dyasli <sergey.dyasli@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Sergey Dyasli <sergey.dyasli@nutanix.com>
Subject: [PATCH] Revert "qemu-char: do not operate on sources from finalize
 callbacks"
Date: Fri, 12 Jul 2024 09:26:59 +0000
Message-Id: <20240712092659.216206-1-sergey.dyasli@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::15) To DS0PR02MB9101.namprd02.prod.outlook.com
 (2603:10b6:8:137::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR02MB9101:EE_|BN0PR02MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 3634cde0-160c-4dc2-33b0-08dca254dbd2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wCLHQYNMmm0ZnauTrO0C4AU9FNpIGlt0Xb25dN7D7gQTlaPAzBgnI9UW9Gs2?=
 =?us-ascii?Q?khibwQ1gTtNuDLKQ+YDUItxshEeWLDka25ixAuCJDe14kwlGai0nXUVe1iRs?=
 =?us-ascii?Q?imPV2zBwD+R8s69A/N3d3f81ubPp/GKaL2SKajCuOAputxwPJRROT2wjJe3a?=
 =?us-ascii?Q?o4tiQpclEFBMR+ROuEeJvLfRuSXtpwoFQwkFEzfDekadHikKVz/Osx+0E2t0?=
 =?us-ascii?Q?FOyvtKnn7AAc00HRyoW/xNYHgun6ZpLvB9fgLcIEINikdn08vNezr7xKUGJN?=
 =?us-ascii?Q?OpMLwffJKQj9vTW9UOCgkN2kcW1cqUNxdRjO6RwHjz74fbVCGxDJzXdMqasy?=
 =?us-ascii?Q?TVR5EDaj407qEszc98XAq27wenJgkLDxaJfex27kaWjc7uAhzHVLO0MdNjat?=
 =?us-ascii?Q?ZU/pT6MpdJJL54KneM4pDfuucNy0rJLLrRJRDUw6lrg7wb2oxn4VpCuY4QBC?=
 =?us-ascii?Q?Ir1o+T8eA5s4FUqzCO90DZeWTqbRKDPeM4ejhqX91n9fxzd2u7iNkMd0Umoa?=
 =?us-ascii?Q?6jD78OQ8kGgUFATo/fnOSgXZon7nVVMsjVgudVe74q7VLM+V9Xq6z/LeBeKs?=
 =?us-ascii?Q?XaevbSomiPSD4JuhtpZxZ9GSnO5kxLRIN8q4GhXR8JtpecTzSmVcr/l8iKuG?=
 =?us-ascii?Q?yxShFeyyp1Qjy57emGNo6qQlStEMwM6FISmgI7KYn9FVJfUzcMjSfEnELh+H?=
 =?us-ascii?Q?R3n6BlSmHrN5KtIuwIOcSeZv2r4rWdDi/5Cz5XZ/mwJArt7UVXFf8UD2BkHe?=
 =?us-ascii?Q?xLOmlKKxSZuEUoE024N7rwg86S2OdKBcUdxSFlywCPYAf5C+d2id+3WUOdhU?=
 =?us-ascii?Q?DydAboO2KyZjd60ZDxB24VUrsus/HCFL9zlz7/mnDvTJiDmXP/BPIPVL1Lrw?=
 =?us-ascii?Q?jzCeOMQXkyLtTszTShMxzw7c7zpVbnSlHgJEC1Z9mDIp+j/Nyq6bIwVeOvPm?=
 =?us-ascii?Q?wKtB9Gqzn4d6yJQcLZkugzsyuNjLU9ljAKotcPSZ+uLaYp2Bue16LyWHO1gL?=
 =?us-ascii?Q?seXpt0kmXFroySACSh45PFB6W+y5b0X6kTuTtX+0zDsZXzrtQNV2TIhPgYzK?=
 =?us-ascii?Q?//c9NyI1N/uz79JKW/9FEEOcI5bXbs3BBFr//YjtyM9dBjjUqu8F5fDhovth?=
 =?us-ascii?Q?D7sfVDTaZogF4JjLVGAKMixVOfJjP8aTNhVMBPBLwVAmQTIdL3IWZkQJZkNg?=
 =?us-ascii?Q?Mg3ERpmbGCmFvK5Mcso7k03IDXnMEH/l6pmREIgMKMu2zPmmMfOmNbUdDkrW?=
 =?us-ascii?Q?pa6cxZHxDrzXxSvpHcw1Dho0a9fOEM9PNxcpW9Fj/2tyIQ9EuhdB4bvwxEbd?=
 =?us-ascii?Q?TccNrcrWg7kq6dgU34djKzEjR9BELNM97Z3K6ikZNoTaluWLofkxDT+kb0j+?=
 =?us-ascii?Q?6fsDDX+5kNG96gYZXXctOCpePiT/PL7GGuYqhMC3Yxz4nfmqjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR02MB9101.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMR6D3fRaCCNsAmJLq2WCGOLEQ63oLPpve3PwXJKYGG7pIwoQJ6dO9L8Xmc4?=
 =?us-ascii?Q?ZYp4sk3SC7XdQWKexuWgmsEf8t8cD1hLN10oCY2ybqNc594gHlgPJHeCfk1I?=
 =?us-ascii?Q?5nYiQj36vLgVy/GEBkvCVlbxbS3dJQWOhALTU76xEHD6c2AcmSkdqXJ70OdM?=
 =?us-ascii?Q?weJs8IoP3+wuqNOojPSkIqT3Hj+vsAAjTPbg5Ghp7ebSdXfK1TXo7R1wr+La?=
 =?us-ascii?Q?RT0QgylPi0yPoBgZIuJhjYUz0csm3ohZTChiAE3q+UcN6DgQzvaaG/C5l/dw?=
 =?us-ascii?Q?RWiwBhxHk8cjGC1r4Dk+Y1N7huQbuTMvQNAiRRxlTbISbnWJ+/Qe5yvS8BT7?=
 =?us-ascii?Q?al3xxU1B+m0Ni6tUwQgbzbClKLMxdWATEJMLIQ998r1uV9ZaLzRoj2xLtMmw?=
 =?us-ascii?Q?p3kQ1UcuDDfS6z+o3i5BORHLfnmzfgniQ/0OWSTFyo1fPjUeIzQFFdLbfJPm?=
 =?us-ascii?Q?J1MQ+VOb9/Uu1O93k/azi4xBEV3LmNYROY1vIkL2+I7zse+O5PPOhUYfhdhW?=
 =?us-ascii?Q?NVur/WF3wjl2e69zA5ctJfc49+YiIGB/Kn2oXN7QMESU3EeWAUx1C72vVue9?=
 =?us-ascii?Q?VjstTTu+SanHqyBhlRM9RmAup68dN+wV4HQpsUrnmXYC3Gf6BOeBBn81NYYb?=
 =?us-ascii?Q?S+WmJq2iB2Cga5C6OmQ7187f62JGdIXTafhbvB1DegN5VB+Of2HPCOiqkPuz?=
 =?us-ascii?Q?dSwMoqNuUsH8vIOK8QTYjDxwIxbbmFTTY5DGws0muT0SdC/5S4f6DGFAPo7+?=
 =?us-ascii?Q?WYvF1ou6Mb/owPmK9p+1HWw+OihCv22TUe+WHIhO0TKC39zvXjd3UnZoT49c?=
 =?us-ascii?Q?OU1YetQnI6nWFBGLkg3BTagi//ukeBLeKGYC6H4pVJTFrTYQdoRPmTzdnCWq?=
 =?us-ascii?Q?Vlenmkan5fCZ+VQR/gpdGH2G4rb3FD3Cb+DcFdgecJgP+cv6GnrbEZkRd2s1?=
 =?us-ascii?Q?Hxcwa0rS5pFmDGqBpl15nJ0qQuIfnN2R74nri1QuurcezSE+QL7n6wLtm3XO?=
 =?us-ascii?Q?9hLM1No7w1I+vbmaetmirQ9a4RMckJoiuzohEpFKb3F+CJHaZf260ABWlIBv?=
 =?us-ascii?Q?i4PZptmDNOK9Vir3KsGL5UL76DnDPLFUxkglJnTrBarqfk4cQL7zSTYIvZ2R?=
 =?us-ascii?Q?WWXKFZj9veqhCJa2n0obMj0FtdK8VGSuSFOEYGKwqkIcabwAB7bGwXPZOTP/?=
 =?us-ascii?Q?oGEAdVUj+DsWbueG5rFWjN2eWy6AK/aa+DZPVqy2FwQ8SwDYYpbbsCtvnA3n?=
 =?us-ascii?Q?TtzHiJPsIDn7q+9BXSTaJxub4JtnStlnapoHxyz8dSwr+50VPVwI7/I0JVJn?=
 =?us-ascii?Q?Yo5KRwQZ9Bk336ZNp+bODJeRturQw0W0eCpiQlmB5+X94hFhIOJPCY1GmgRv?=
 =?us-ascii?Q?Mze5MGhg3yTlxD5FdYfSSLFWAZ6OvI3RrYDhdXg5128otUoQGNTFO9orMOlV?=
 =?us-ascii?Q?wG+XLPQoMq9chHHLUF8uMma1FKNgErbtEuqB6BpVtRt8Vp1oKFIelnnCobkL?=
 =?us-ascii?Q?Hl+Vi89Q+DrbLLGqdENO9u0TetOP3FganXpAC4UHqb4tmaBhmNUPCYa3Gh8K?=
 =?us-ascii?Q?vxB3ub19tj8DpaDgWiXA+gZ/hRuAbRM/c0+qYxnFaM/naDfC2BG+aJ+WCo7p?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634cde0-160c-4dc2-33b0-08dca254dbd2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9101.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:27:33.0084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNxkMJbCRUCy6di/0FJ3Br766ZWqoJvhK4Jze51nZdSam7hrJS6n09rq/AJiiwynVEH/wIwM4h6AbK+L1aVqPSiZEghHRCtUqkojfAkMLi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8304
X-Proofpoint-GUID: KDTCMHk1z1LKG2YFZ1-YXQ62Uh--ndd2
X-Proofpoint-ORIG-GUID: KDTCMHk1z1LKG2YFZ1-YXQ62Uh--ndd2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sergey.dyasli@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This reverts commit 2b316774f60291f57ca9ecb6a9f0712c532cae34.

After 038b4217884c ("Revert "chardev: use a child source for qio input
source"") we've been observing the "iwp->src == NULL" assertion
triggering periodically during the initial capabilities querying by
libvirtd. One of possible backtraces:

Thread 1 (Thread 0x7f16cd4f0700 (LWP 43858)):
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
1  0x00007f16c6c21e65 in __GI_abort () at abort.c:79
2  0x00007f16c6c21d39 in __assert_fail_base  at assert.c:92
3  0x00007f16c6c46e86 in __GI___assert_fail (assertion=assertion@entry=0x562e9bcdaadd "iwp->src == NULL", file=file@entry=0x562e9bcdaac8 "../chardev/char-io.c", line=line@entry=99, function=function@entry=0x562e9bcdab10 <__PRETTY_FUNCTION__.20549> "io_watch_poll_finalize") at assert.c:101
4  0x0000562e9ba20c2c in io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:99
5  io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:88
6  0x00007f16c904aae0 in g_source_unref_internal () from /lib64/libglib-2.0.so.0
7  0x00007f16c904baf9 in g_source_destroy_internal () from /lib64/libglib-2.0.so.0
8  0x0000562e9ba20db0 in io_remove_watch_poll (source=0x562e9d6720b0) at ../chardev/char-io.c:147
9  remove_fd_in_watch (chr=chr@entry=0x562e9d5f3800) at ../chardev/char-io.c:153
10 0x0000562e9ba23ffb in update_ioc_handlers (s=0x562e9d5f3800) at ../chardev/char-socket.c:592
11 0x0000562e9ba2072f in qemu_chr_fe_set_handlers_full at ../chardev/char-fe.c:279
12 0x0000562e9ba207a9 in qemu_chr_fe_set_handlers at ../chardev/char-fe.c:304
13 0x0000562e9ba2ca75 in monitor_qmp_setup_handlers_bh (opaque=0x562e9d4c2c60) at ../monitor/qmp.c:509
14 0x0000562e9bb6222e in aio_bh_poll (ctx=ctx@entry=0x562e9d4c2f20) at ../util/async.c:216
15 0x0000562e9bb4de0a in aio_poll (ctx=0x562e9d4c2f20, blocking=blocking@entry=true) at ../util/aio-posix.c:722
16 0x0000562e9b99dfaa in iothread_run (opaque=0x562e9d4c26f0) at ../iothread.c:63
17 0x0000562e9bb505a4 in qemu_thread_start (args=0x562e9d4c7ea0) at ../util/qemu-thread-posix.c:543
18 0x00007f16c70081ca in start_thread (arg=<optimized out>) at pthread_create.c:479
19 0x00007f16c6c398d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

io_remove_watch_poll(), which makes sure that iwp->src is NULL, calls
g_source_destroy() which finds that iwp->src is not NULL in the finalize
callback. This can only happen if another thread has managed to trigger
io_watch_poll_prepare() callback in the meantime.

Move iwp->src destruction back to the finalize callback to prevent the
described race, and also remove the stale comment. The deadlock glib bug
was fixed back in 2010 by b35820285668 ("gmain: move finalization of
GSource outside of context lock").

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@nutanix.com>
---
 chardev/char-io.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index dab77b112e35..3be17b51ca5e 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -87,16 +87,12 @@ static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
 
 static void io_watch_poll_finalize(GSource *source)
 {
-    /*
-     * Due to a glib bug, removing the last reference to a source
-     * inside a finalize callback causes recursive locking (and a
-     * deadlock).  This is not a problem inside other callbacks,
-     * including dispatch callbacks, so we call io_remove_watch_poll
-     * to remove this source.  At this point, iwp->src must
-     * be NULL, or we would leak it.
-     */
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
-    assert(iwp->src == NULL);
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src = NULL;
+    }
 }
 
 static GSourceFuncs io_watch_poll_funcs = {
@@ -139,11 +135,6 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
 
     iwp = io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src = NULL;
-    }
     g_source_destroy(&iwp->parent);
 }
 
-- 
2.22.3


