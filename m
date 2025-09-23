Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787BFCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UB-0006vL-5v; Tue, 23 Sep 2025 09:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TQ-0006LG-5s; Tue, 23 Sep 2025 09:54:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13TO-0003xX-8g; Tue, 23 Sep 2025 09:54:27 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58NA6pEP2985867; Tue, 23 Sep 2025 06:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=P/bmjFCDdSiYr/3USJatXXobPkx2LVIoMtbyHSd9d
 wg=; b=wpOulgsGwbpxBJQZrnUvkdHIDBH69S8K8B9C2CDOWzC46J6z0xYVDIm1d
 Z7HWKcbcaORmAXYT1QUXIutk/JaU7VXgTP8McI8+dylQKNkW1+1xlM0q00ABNXQV
 nQk2bpNzwIhVJUdn+LdFZ650HVy6TmLtkhoxCX6FaOjdmKrwFbv6FaIsXJxu2sum
 YSeNQMZV/oyZRvKQLUL9NFUY1uJZyhAhgOg0f0Qxsv3IMrT6XHUFL7kcuGcLoGuo
 3p1i68MXLyNg6WpNDMrZBArhtXyTjYzzh7bBunVvPLreUyLnJDkKasxzyHwPp5N4
 6OcFUheMUOis253RleqHZ1d69Q8iA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021088.outbound.protection.outlook.com [40.107.208.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju01c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlxqyFUqdkRmczlW5znJQAw1E2Ada6+zkRGZYH+6OrK76lqrwr/DZjwjYhdbgSMzA3ZUx6vE+fMVxu48O0SDEbFYfFPvqFaZLUOtKLmQEYDSVysW2cGjhS2lwaeQyfNDqDsGD58V8+RtAdMafH35Rig9flNfEcn2SZAsa0pFQaExUfHPi1TCXUseNoyylYFeuoYxYbYuxQC7fxnMe4bpY6CU5Y4RrXSXtVQuJHfdxXEodj5J9FGKFZpHaIijQlcCULN2wPy/88RLHmPBQ9tO+QoB2EeKR24FSe0awMy2BJv3KyfjqycewmYLJZvQjMnN4gOfYFbcGI/DYqbuLdHSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/bmjFCDdSiYr/3USJatXXobPkx2LVIoMtbyHSd9dwg=;
 b=Sn0hT+uHaxvLJx3YcKIPKwpoKK5FPwtzQDKvPykwwxz1kM78PCnCQDr5PmZhDr8t1gteicHbw2Ot20tu5jcJaFfH6SB+gVYOcCvbBH4oCsPKEhjRSwY40rvwFjGRArfPbyAuzodyin6/UPZlRt+bEXwSn80zh5Bcg1QddRFsexMwUDPc7FmUZD1BzSyTXbQ2hGdTBJ4hsLXzpZVDclnSm8esrLIaYl8DjUQrniBqrz44IT5roifmFgYylMBTfcCLjPrGfcjmvXF+JoOQgqLKsN8TeEAH5PUADepI/0jI6aHvjdY7lnhSLIQpFkLdrejaXIsicyKlLeRZX2yi0w9lTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/bmjFCDdSiYr/3USJatXXobPkx2LVIoMtbyHSd9dwg=;
 b=QUNV2K8HWj3DpROkKXSsN5/OmOGc0Utw8AnpIt1zrcn/51wq39y6zpaQoQX1uA6rMTHE4N4iCN7Fnk0kQp3AaJ7u+f5fDsGPz5FAmdmPcT95E08wpEi9OWp080dKqtEuG1CRE5JIGbee+tDYF7dzUzR+57fl1zVE5tvQOq6wDqiD2mtP4QnLPknbope9d07cIMwtH+WrkzI6r0oka2Xl2m+iG1Ga/lCryfwaM1OW3kS6NnesvgPMx+pO699OzzbGWh8YAKTOcINIQ7zrpsmc0867+ZRmCsIKSkOH4cMXjvN4uWDw6oE7aKl0tB7v1mCmneUcuZ2mJQbnCWhhO+GtIQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 13:54:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 06/27] hw/vfio/container-base.c: rename file to container.c
Date: Tue, 23 Sep 2025 14:53:12 +0100
Message-ID: <20250923135352.1157250-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 34147874-20ce-4d48-09fb-08ddfaa8b155
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJJ7/IHr1L66yt3i50WwevbWk1sCHHcoVEO3ckTMVn3vc7d/4JBEefGHicaN?=
 =?us-ascii?Q?mct7rbHrvu5yrJNNoLSDxuw/OI2VwzsbkCZa/A04d7JBYhZj2Oty5MuuZIX5?=
 =?us-ascii?Q?+tYAyzSddBNUvmGgzT5jh7LUKoA8K2XCtQhLe0ItRX7+fLFy8cN+Evoe7AGL?=
 =?us-ascii?Q?u++g7POtYZXSUcZ8I2UZfvXAtN+BPNxcZYLMPJ4m/5bf8vO50K9tHMYr0dni?=
 =?us-ascii?Q?ugdJNbf6GSp48OqggYDpkDqD48rwyKmIxLBzrOi+hUrcWb+up+JIovn/VX2x?=
 =?us-ascii?Q?+AIaNwA6Zv22o1YvAipdhy5qWluf78sVPUSKblsokj4nWh/L9dLyZ8aLkb1M?=
 =?us-ascii?Q?xOAo0WBMlK8doQ8eMJ7N/RB3uqaJHI9CCE8rigxcTmRhCzwcWVPZweng//Rj?=
 =?us-ascii?Q?R8ZJgQWD5V0eDWlVaYLqfEZj+XWP+H08meTyIn+0S7OFoqeH98xLbzhuVn5q?=
 =?us-ascii?Q?hX/25yx9B8VZ+5V6k0ZdjwFsMVYYJKPf1AFFQaCwHAIUk43Ss6FeAI+Nh9i7?=
 =?us-ascii?Q?McPT9XBU5WsE/mefB+1+IkZdq0sPnDdyf6pUYkxTJDZanR/T9J9wdZWNB5kL?=
 =?us-ascii?Q?+QIEVHx3fVs/dsK1KJMuRrxGjQFFdbp8oI7biRQ2Ka4Skm3t6kqSu/3DClrc?=
 =?us-ascii?Q?6wndySFX82eXtIUT/IzJXZd2TfKmy9WUwHN/WysliPbR84sxoZpkaPBDK1Ln?=
 =?us-ascii?Q?HHEcikhfP83xUTWggspFVFlVK+p4tiU8ovcgPTk1co+6PE/KXi3/HqTdNkdO?=
 =?us-ascii?Q?xCu748OOgNJ4Lq22cL3Hp3DwsECRweDKggyOtLLf+4JnK7CN6pe22pCJNoPn?=
 =?us-ascii?Q?RKgQDW/LZQK+cv75dSBWT/ylmGNG0dDO8rp+u6KxWQQUqqlCk9Eo4C1xRazg?=
 =?us-ascii?Q?SIJgabN6w4Pl6iDDm3W59LWtqMkRFzksYXpLnab4nfGSlMfH6iTC2OxHt94o?=
 =?us-ascii?Q?dk0a/IOOuFkT+xeTiEpAZ6lOn05h3cUT8j+Wph4fPV5r4vGt3oUeBXebcwhn?=
 =?us-ascii?Q?TCnUQ1PyoF+HI0nKzSTZkrjlTaoEuqU5qDa5YdF72rCd8qk/yE0duxXyKNSU?=
 =?us-ascii?Q?F7hgMEnfhyI5xgBQKNkBnRR7Qw+TqNiD0I3J9j680wNt5Pq/Ce364/nIoJkT?=
 =?us-ascii?Q?uPht/2ez7abCuO11vSwCXaXAglL+c2e4UY8j28obkNSAjHMAWdHfjFRkYhqm?=
 =?us-ascii?Q?YvTLmCtXFBRn1GsEEaJwyFDyCMKCqbxVDRvb+OBK730x/m6FnFP1gnis5CXn?=
 =?us-ascii?Q?m4jDDiRBM/Ye4ejDtDaZQO2FLMzc/e4bpHOo46xsQp8D/7Ce5v5YceIgi0hY?=
 =?us-ascii?Q?b8nMBpQqg/1oowh1dDilhtbcmYzYFQUv2OZC8MVNIKFbRcP1pQONX8ywgDEw?=
 =?us-ascii?Q?4JqVRZctkahHwc0QN6AWtWYgzVG+4NKFL1QhzYTuF3FyWii7TvcK9Jy2fRC0?=
 =?us-ascii?Q?39bTxf1MsDiup2cCm7Nj+9YQQ7bXF3W+Z75mkF3w3oxb2W01yfnoFA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/wU6IM38v+cRaN512g+TKm0tHN4N756F/CHop2IYo49H8EoiDWJVW4B6GH2M?=
 =?us-ascii?Q?ZTUzFYzGtkjahemdIQx7cgxRK+W5Nww54ATJB3k25kMXGLqCpXfH32B4oVHg?=
 =?us-ascii?Q?faemaxbQV1yEJYGeZTb3r+Evn+IieFEyIw/k8ON/YbWxWG+OtX8Vy0J1udHk?=
 =?us-ascii?Q?2MRid0uIq2ExwG74mJBFvKwqHw9JKP4rSC/7xl0HM6M92AyKMsrn2fCJxcwr?=
 =?us-ascii?Q?r0TptD0s3w3qCzksKgbt/kg7vdJsIMk8rCCuwg4zi9m1ceOl9uQjmkXKQq8d?=
 =?us-ascii?Q?0mpM8ho2z5Q/Sc3cFxwckTojjUNJaHKjBO8LF/n3FBaAP0pC2htzkmf0I9qP?=
 =?us-ascii?Q?8/H0umwSssvRIhuEXBCI4xJIH/IaR/KOVr8HbDxAsADWCiOddX3mhOow19Xm?=
 =?us-ascii?Q?0WIe1AhStKfIEHkQZke58NlglJzJudKrX8+ToQi2sew6kR3bqvQs3PKxpZR1?=
 =?us-ascii?Q?zDsxeYT1k7HDlMlw+wT5+WB/TVp3TXnavRSqiIOu7bDCg/t1+jY/fAxSyzHv?=
 =?us-ascii?Q?bZwbCsxAxTU3yWQMtarPxv96uvJr2R6ZhTZuoUCfoWpXn6drIDcWuT+NaE9Q?=
 =?us-ascii?Q?OQIwULCceBogJCPsaaV7FdiiYg8zaSEC9wAENbGj5pwQOq6tu41x2xqZgHkS?=
 =?us-ascii?Q?1v8oE5xfRr0ZO5HllvQmRVme5S7Fj8tjh7HhLjrIuSBizj8VKaPom/uSzZyB?=
 =?us-ascii?Q?uCvWI7tC7ez9tEYmbV7pKaY28jpuVrkW4Sz5GpcmAXVtki6hpG7w+LErNBDN?=
 =?us-ascii?Q?+ZTcxn8r3lWNpTRF5XlPrH3wpElwOBiFXG6kIadSOZsYXAfkJ4YHSuF3iDJv?=
 =?us-ascii?Q?ILolPcTnB17ir3amC0Nu1hDyBZwIqwrfHvxDbVujxZ7SaUkO4O931BcM5DMn?=
 =?us-ascii?Q?E3AB4x/eopa11kKWNeTABScWXyhIRVvX+xsvNwnRV/1J4wqUdomPxNgidrOA?=
 =?us-ascii?Q?ycSkhurUDwe2KlIYrEV8Abwu0KU1GItwL2MJrpm0F9oQghIvAwVNmq8WLnvs?=
 =?us-ascii?Q?XAb50C4AazKsVj2skBA7wyq+yvhdZdRdRe+jHihVudwMhIeHHXk0EcKw651v?=
 =?us-ascii?Q?+MHF/o2TymRJ/qZjRhiKJw79seOQQp2Jp2EsurAZ/P35i/Mobz7K9kpG2DAz?=
 =?us-ascii?Q?hABc0ZgwELHI+Kp5x/54KwpoYcV5vyxF9d0DqfZ5qrDZu5Ed9qTmPepJ0wR4?=
 =?us-ascii?Q?SlKCjyLz3ou/ZY6JtZGjKBb/5IbaP51zbMzohUxr/39i02GTRPHb/uywSRLp?=
 =?us-ascii?Q?ihZ7jq/6sLm9K1tnLaG49cW++vjWq4iKl5U2K4ZMOJPz/yoAcx9kvnjwL3/Y?=
 =?us-ascii?Q?klE3OiiRloNpeMTrygPQSdd3Ds0+wvn+jI4cs3S7R4uPlYdiqMiiyXZqXUHr?=
 =?us-ascii?Q?Tcg10K2LsmfzyHsd5jkAkOCOR45xeS97OTbxr591UM86loKRNct6zIuI5omm?=
 =?us-ascii?Q?TDMm2QTCA44fnJ8By6mHrYDJmTRemrnM2u+4Ri0dzc4WZY8BHyNTPCbaidrv?=
 =?us-ascii?Q?lCbLuEZ77Ahr0+Vsg21msYIDL/vPVnzB1ic5WYDt9r/0b6YpOk3DPHP0TJKN?=
 =?us-ascii?Q?A2bCWSZ2tp58skJ4nTQXvJ2LBewN877SREbX+4a3VkJTD8qeWoF3U2/wrhdX?=
 =?us-ascii?Q?H9UcrIgLDkporiakbDfbRVxrhWMHlCJ1231C1UcP9tYLMDAjtC5vC/WDggYz?=
 =?us-ascii?Q?EomDTg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34147874-20ce-4d48-09fb-08ddfaa8b155
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:19.4011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNc16waNvcDwkebDLPs5brVYkz+wpWuf6hFj+ea/2u6b7vHvlEsWwvEyEfbKfVrkF7LSBnr6PDqt8hr3pOPKMDY+KKsB8BP/ja7M0YW95Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
X-Proofpoint-ORIG-GUID: ZdZQtt9qUngdFr2YE2UYBTZo7S7BrZg4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX7N9OcTx6QrjE
 sGyS/A+hVqvlYRgUYYS4LgJ0deUVxB32Mpd6syDdCa8zZYRsPmErElZnd9WpgpYXkk/sNGYz4FC
 T+3wzDl7vC0DVvUKhqfcPsdkK5toYbQ6rEcpYffXOURx5tJeI4ceddTmzrNMqTyIvGMJFo79DXJ
 pWB8/rzjK8O5vkGHH35V82g+JROldek/1xF2hF8Srx1bs+SzeWWWrJz34spr/ujjuHI8U2e5umZ
 h7weWFw8Na/oUxHrUHlnOUb9EICY1PywacNXqOnJ7hL0/tible4zFYLo9Cje31nuJIklPp9ETU/
 XaZmAvhNxFxUqWjaEsUR11Qi0C8HH8daUahiMtivBN0gWrYeyw4Wba3byY/7ag=
X-Proofpoint-GUID: ZdZQtt9qUngdFr2YE2UYBTZo7S7BrZg4
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a68d cx=c_pps
 a=bSkFQXo9YJPfdG4GsN7qoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=LUkFdQWdq7mprEPiGlcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Rename the file to reflect the previous rename of VFIOContainerBase to
VFIOContainer.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/{container-base.c => container.c} | 0
 hw/vfio/meson.build                       | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{container-base.c => container.c} (100%)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container.c
similarity index 100%
rename from hw/vfio/container-base.c
rename to hw/vfio/container.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 62b7a7eaac..82f68698fb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -3,7 +3,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'listener.c',
-  'container-base.c',
+  'container.c',
   'container-legacy.c',
   'helpers.c',
 ))
-- 
2.43.0


