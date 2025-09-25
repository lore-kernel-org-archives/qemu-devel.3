Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BE6CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kG1-0001IM-NT; Thu, 25 Sep 2025 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEk-00078V-Fl; Thu, 25 Sep 2025 07:34:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEZ-0008VK-Hk; Thu, 25 Sep 2025 07:34:08 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P7dBZb3781997; Thu, 25 Sep 2025 04:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=am+bx69vzDAf67f+JiwV8SXegBU6AiZv8RIh6ouFr
 mc=; b=Ry1Qoqv+dQQVve4bjq9fofTnMninH/Ki8YGBB67KkK4dkViRyEKBP2Byg
 xpttwGDVWCka7YSxIFlUbW5GGc/FkYOVSHx2z26HC9wtQcak9y94kAUOMbHIiwTr
 U9z1Jkgn4dKOi88hOfcpjnpI+kVPV75yD513ZlrTF7Ye4Rs7+DeQd+ww1TBrdhou
 bfej4QmlfILUAtI/6uLgLC1QpDf2tGREzB6x6cLQERLLTk449dDF8RuEEQe9X2zP
 joPV+Ed5GUbJDHyWAjH5i+k7OgTQ6xPLe84apd4kYsWZgURvQooRvnkFKH1V7uRz
 3FoGglyP295CoarzU2YxXECkhu+9g==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023128.outbound.protection.outlook.com
 [40.93.196.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1hn0fp0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+m6LWUcPa+fss9ylvOGFABPxzMRfYjszhxr0bA5vxNCA/rr69QTifeIr1mKePEv8dyM4X/XlWKZgQ+IszxGfIwQ7nw4JDxZyTDr5RH4MhdWKx2TKWmNASShUHerl1L/nu9XQGWvZqbkJyD76tHMBDhtua0HDXgRPhBguSIA9I1i99W5S6IBejdD2qNlG95NpmXS0pUaXnB67pz+54pZMk5gF6QBCe9Y/vrJAR4EwsBx2iZXV27gTrPjf+RB6GF3HkkEZGoCFRc3nAQKFXF2E1bYV7y67wo0AvEmz2fFqF+WqsXJ/ZnmO4sqfWC1GgPgM+aWd+LEkHPu1Rv0ZaJVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am+bx69vzDAf67f+JiwV8SXegBU6AiZv8RIh6ouFrmc=;
 b=WiX1w3sB0j+1wezwJ3t5pO4GU2ThA7pCbLj2K/21VWflbT7/so/eoR8APmw7OUhQWX3W5q1ayzGDhh5mk2zwo2oP4S9O9VxIlK8DG8ijHS29+DF+XWbaMUIHtdBZ2TuxTfcgvfiaBg0WNxaVPTCCSkiE2tp51tonh8yLB7lk7sACp9gk7pFtNpQWdV0GW0ou0fJZftiEuBb2n8+KTdTFC/3hIZkNw5iLnWFy+jFr/L98s8qaj2d1+hFILiTFalR16nGRtm2oufci3jE+hZQdsiQvLpKVTwTpHICd1O6hsKuzlGNIoMrdhf7+5NlkZxPqczGQriLMTqRz/whanomFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am+bx69vzDAf67f+JiwV8SXegBU6AiZv8RIh6ouFrmc=;
 b=yVr4c2QcnZnk1iZyVO/Apihk/6lMlE5EgBLCByMzd4xF9BxJ/CCUTRjBc57xRMsZ4Mw+TgIbJY4gQK/UKBCdHeK+J+BMeC3LSue6Yq59mpWVKVnaCxg92mCm1dJ0POYf9/+MgzTtD8z5rbnqJ+n2gf1Tt2FEcTCF+H/Da2WkM4YJ9Bo5/LLd4Lv/5wtkhsPMGc6RZlbHhKO8Q53dYil/jxf0u8BAOlOOdri1UGxT1mbOCa2+DcJc5AfNegnP3+L8Pc1UknOBlsS+24V65ddTTVcniQmgoDB7WNSKEuGXJYllTr7isM0+NmHIuGtAZJOMLZqwaajv7aMFvf3bppyYsw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 28/28] include/hw/vfio/vfio-device.h: fix include header
 guard name
Date: Thu, 25 Sep 2025 12:31:36 +0100
Message-ID: <20250925113159.1760317-29-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0291.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d7ec51-0a5a-4af3-d494-08ddfc27621c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4TqTut97Y/tR7AMxmZKae0Dt/u5rcd666oyDt7/C7NEMEXmjW9drJNV0iBnf?=
 =?us-ascii?Q?TwNCRJZsawgbSf83+lVOwwoEAlY1by9F3b8Lz3yctP8kokeKmS/csfc8+Vhv?=
 =?us-ascii?Q?7S61V2Gm6OjW/3mr5MT6whBEchy7343rhd/5curEYiCeKLQfgifUlm4P62Z8?=
 =?us-ascii?Q?dBTH/CbeevEt7bYQvNTV9eNNoky0ahNgtmEDpyBzPFRwQk7NElo1A/kOOPqA?=
 =?us-ascii?Q?32vbyHuOyg+wUYXVYa6zjSiPoz81f20iZuiVZGiAZRCInQyQh4gH6sMVMdza?=
 =?us-ascii?Q?dsMcvS0+4aMGOIse8k0J6Fu2yetyXNKCGLFjxR9sbTXnTD1qx855F1k9RKsH?=
 =?us-ascii?Q?7n+/Phzh/qIRzOCGzqncC7jeqOyAh3NILBzzT+bAGldCq1NX0BahhZSwHvL9?=
 =?us-ascii?Q?kQDY+Cxic2ZtnqlVurmBsP4ZCW2JzITb82hh4ZcENnz8KObKWg5Ld+pUgeG7?=
 =?us-ascii?Q?enEJomPDwgK9cJwYjLF4d0pD2kgA2FZbHmPdJczb6BJmsKo45ZK6dlUUhIlA?=
 =?us-ascii?Q?CraGyPV7R7FR7eIes6FYG68N1/b6DB1Exujuqn3+AlGd2qQab/OasuH2eMRL?=
 =?us-ascii?Q?w69oTJDN5y9QMNqjiIOmZP/l5MWrxiwzgpLbEEcUGyjn92Z6RHXbQG4+P1yZ?=
 =?us-ascii?Q?GsnfmPxpidkNsW2AM3LO6FkqyJLQyzKpJ6LjrXnfTbfqU6rOEkunnqdqZ/Zr?=
 =?us-ascii?Q?cA7W8HnPbXi+jwAqLvTnx7CHKNilMdopAmujOgLH9sr2xWzuZjhF9qElQ17A?=
 =?us-ascii?Q?foAzBevXPTYXNzs/vkJv4NqRLeOhxibWFXFfewH1tJAX8L+fQR065QI81ppP?=
 =?us-ascii?Q?XAWvCqHxHW17h2Pn9xMOKnwuNCQU3OpvMaBnT7dbu3fFLKgCGF0lIkg1pD/0?=
 =?us-ascii?Q?3bD8taZq6jg9olsrZpk0hoD8XrQjMIX488oUgTWGVXt4FDeWE3VBzsznp/oJ?=
 =?us-ascii?Q?WMMETxUj9jG/5ry2gMvs4KhF8wv9Z+6sPS1dRR3YCwmXwR2kLFkqZnUOiSpz?=
 =?us-ascii?Q?YJJPCXKOcxS0Nh3YW9zrwl4v64jxusg2cSzB5jN/rfwbWOY5wRs1SCcAjkiP?=
 =?us-ascii?Q?LB9PF+fpA0fMH7ooULqnlewLegUt3PIShFl/8FotMdut6KKrEd0XOntp54yn?=
 =?us-ascii?Q?jVNmHRoDVsTsYONP7mz13ijxu2Q7vF7cziAFVEI5rGSMU4ibn3L+GwbOS+6w?=
 =?us-ascii?Q?v+CUMOSyZxwhFwF/ribmE1A6zX0vAnQjsGNSAfuoA5x9Q4CZJncflrQM1obF?=
 =?us-ascii?Q?aVT08SPBziLtDAspCkTovmOksJeVz6y1NzSkLjNclVKgJWkR7AhdLjGVaCyu?=
 =?us-ascii?Q?KmQVTWvY4+RcqJ3/yTXyrau2Ac1CoLNq9YoEJfcsBOW4DAnUcXuaWmHjrBow?=
 =?us-ascii?Q?DOod4WlMycxggg2v0AI7JXtnD5r1fNbDZdqTmWVsHxjW0F7BYVCWapJIuFxW?=
 =?us-ascii?Q?9clu00icRyxMoT9DM9nxTSPyxmHnBOdSZa48XQItwoXG6mwNHpetgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9o1NwSYS8Wslyxz2LUST//v173UpADXd5BnwpLPn5F36Xz6/cIuL3zU4nUg/?=
 =?us-ascii?Q?5XqDAXvSJCQCECqpMujAHJndG5Zj3YtojoYAblFrUjJW/mHbfFaOYW0t9B4g?=
 =?us-ascii?Q?EqiSf1ITTFjiUGmbrbTNYmncc0zDr98b9HF5fWcu9DvuBWYo0C0fqBE5gX1K?=
 =?us-ascii?Q?IW+I2i9+h5cgWI3/o+HE2WC6s068+maeMp+JBCvwyfnHOvDCK/fOJtbe47Fa?=
 =?us-ascii?Q?JlXGo5ipymjiVDLCNIxfjsWpIcSaFmn7df9q0BZT2rrXmeJzlXI55GLnwUge?=
 =?us-ascii?Q?EkAOOnSHJg/u9a5fYL1bGPWqaQ4gwwIIRqrYzaPBmVFV1RwDoC6RFwrvBwe9?=
 =?us-ascii?Q?Y4wnotXcBNv9uvGSgVA12XEeI3BorIvhu3/kVBh9qUaKjvJL2Sk7t7ManI8s?=
 =?us-ascii?Q?1t0KYxYXCIiq2L/byLo3lg/zJElzotoNMTCgtzQtpd5ekx5RC4IgqlEgctyV?=
 =?us-ascii?Q?o29iOc6qgDr7RbnWR7hJaUW/ygLGt9kqQICbBxFK8DXAPDZPqTPUPzDMPOSW?=
 =?us-ascii?Q?XwEPaNVf9TylNqxhLWVYN4oz1SGH5x1Z6/O8KEv1d38OERT55eapX63Jrh22?=
 =?us-ascii?Q?qsMK8uebS1cXC6c4Iaa99LJ7E19mwFnw9m/eIkm/TnQ5WROY9LUVtW5G05yl?=
 =?us-ascii?Q?yOHQzWMI+iTXSDzl52Ln+z8+6pqmZMMSDza9ewBiVRPpx9gtMBFeSg61HT1z?=
 =?us-ascii?Q?u4YGA2wdpN1dPeD6B7witgFKAFjaZnlZEzpCF6LXL7CkLCUSVT2oPG/c1iAR?=
 =?us-ascii?Q?AF5jFWE+WvtUX9IH+oXqQMY93OSAeLtLOybV9PKJG3AkbNANui20JJimWZ0X?=
 =?us-ascii?Q?KLyCwRAemytDWBwMtkCXTeHiqJe+6shmtDcUiVd6Qjqfu3N+dk/dCCozZBjS?=
 =?us-ascii?Q?T1hYORmxzTcb0QtNY1JA3wathajlJ4RHydyWWhnbUSlcsFO3UD7RwJTbxGS8?=
 =?us-ascii?Q?uz9ts9MVaOrtliG/sgpwIRiLoSajLnBiga5XySQPRCpqAbqfXZ/+LwquBswo?=
 =?us-ascii?Q?DZsj88Wj/cxaeEnsL414mc7Nyn++hgwyeAz7ZtknuuFaQZi16f7fuGtpmAEA?=
 =?us-ascii?Q?5AbvKcctLGuZJdNTkC4mUcQAEU1Lal6VBOtuJ4qx7E880cdqMfEt1FYR5hv/?=
 =?us-ascii?Q?Ne4wakONk7HDkH61zaeWbvMnksDOyDY6fQx0N5SN1BZanXcBQgO6zi8YxTc3?=
 =?us-ascii?Q?MbHHk73h81m0yvokJj8kZNuVKdK6qMM2YBEoIlD5w0N2xltyWZoUnoeQYSIC?=
 =?us-ascii?Q?dwqffCTtOUwDZ41WIQwJqfs8nnBsfJWGjayCG6iDRahFo9m7vpCW0abu3vlh?=
 =?us-ascii?Q?L+BQTnBtk+9oZs9jyYGKRt17ZxcbUfuJMMoFVc1AGXugXfwC9WrsOgj6PZ5i?=
 =?us-ascii?Q?z6o1NzHuZwfKmFPP9qEknESz6J+jpctQchBcr1Gol5+Bcst37fViVgqix0js?=
 =?us-ascii?Q?xd4EpzWqywc2IJ95sP9P33gbtXX7srdtSprkXK+52AVOls1esQdmA0f0eNg4?=
 =?us-ascii?Q?oNR1jsRL46Ped+hYjNtLW+Yem52okW4pK/SycGBjYHZ9HwQISEqeF07PFVf4?=
 =?us-ascii?Q?YZP/B2Ns1ZsQgOMJMQzGCCpv8WmmNPKpzPvEM5jdRQE/w0CXedx2i9/ykug8?=
 =?us-ascii?Q?EtYONTWPmyJI3+BlNKX+YAhwou6yWCWRNvIbbX2zvXhtvyTb0+8q7MEvjyyb?=
 =?us-ascii?Q?fp6RrQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d7ec51-0a5a-4af3-d494-08ddfc27621c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:43.8084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46Bdi44XUTzuRsxmoBbLighC7uDnLzXgqO5Cg8oFgSBeTBNNRu74wMCXuKhBR6tyjWDKC7G9bT/9aOed19h+G1CMsLjqo8XR5VHoL8QKccQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Proofpoint-GUID: 9O5dNsBfH6e5Vw663Do08xSsGlgmPBon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX0Nnp6d6sgwEm
 atW9uzQ4oC1kX90R+hjD4dnWaQ8y9t2M1vpw4sVtNMQL7gjH41hvMP9hmym6Px+g3dwkSDZNRBs
 /PbXWWncgTzuHASHPnxWcvV+7dmk+G1Cc0wzncyI/0wmrrTWlDDKc2uzOgIN1aLtG02NqrFGY1Z
 +1noWoXiA3Wb0hmp15X5E9QSqioQuYg/3j2hAnHv16SQUTD1JVScRFLMg97/Y3wsRNGmyB8RBv8
 iHvqIKIVUM+nO8xxH51ajfLGtv1/xY7Y3MTRwEPZFsVy9mbl1M3hHNAi7cMflBo0SghkUZmfyFw
 o7qXXEcsXtyFtRR4zHcI/16oX3bTwxfWarmAfWYBHZMz63k3hiAo9j2C7qY6QI=
X-Proofpoint-ORIG-GUID: 9O5dNsBfH6e5Vw663Do08xSsGlgmPBon
X-Authority-Analysis: v=2.4 cv=D6FHKuRj c=1 sm=1 tr=0 ts=68d5289a cx=c_pps
 a=7mMRTYqth7La13Zyv/ERAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=VnNF1IyMAAAA:8 a=O3KG-0ovuMGEHiqPTjEA:9
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

The header guard was incorrectly called HW_VFIO_VFIO_COMMON_H instead of
HW_VFIO_VFIO_DEVICE_H.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index ed19e2e1e5..7e9aed6d3c 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -18,8 +18,8 @@
  *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
  */
 
-#ifndef HW_VFIO_VFIO_COMMON_H
-#define HW_VFIO_VFIO_COMMON_H
+#ifndef HW_VFIO_VFIO_DEVICE_H
+#define HW_VFIO_VFIO_DEVICE_H
 
 #include "system/memory.h"
 #include "qemu/queue.h"
@@ -288,4 +288,4 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
 int vfio_device_get_aw_bits(VFIODevice *vdev);
 
 void vfio_kvm_device_close(void);
-#endif /* HW_VFIO_VFIO_COMMON_H */
+#endif /* HW_VFIO_VFIO_DEVICE_H */
-- 
2.43.0


