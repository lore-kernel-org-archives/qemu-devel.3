Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C535CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 09:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v79qn-0006mm-H2; Fri, 10 Oct 2025 05:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v79ql-0006mR-Oq; Fri, 10 Oct 2025 05:55:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v79qg-0000Zb-LQ; Fri, 10 Oct 2025 05:55:47 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59A5V63k413679; Fri, 10 Oct 2025 02:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=+hXQSYIMMHM4nsE
 YOC+eRMpUYxCMqiCbFLe1EwgSXI8=; b=xhj+rHHaK/5kJ2lf9lMTYaohatvW7qO
 r1ZIecTlcXu+JEFrIgtyFR/P1FwzAs0BTqJEbhSCwG9e8EqM2PmK2iYxYKluH5xR
 p4frxT6kba6xKBE0lKpGO8P1uJLxUZUBkkj7E541/myAXsRn4YCqcW20ZG4TjILw
 1CKutSCm9x2G2wyUZ1scvQG6Kz5szZiZf4k1bMoyY3y/yb3ZVrAtYdfn3qdG2dwE
 VDKfFFCfqBAbQt8eP3uJQTbTJbXeYxxSdbch1WqqnTHq/cMHch8GduC1kMjdJKfA
 3IztkMwfh1Lxy2JZFgt+WkxG1ABqmSljUTIw6QW1saUReNORlSQs1Gg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023138.outbound.protection.outlook.com
 [40.93.201.138])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1qvhc6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 02:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUvoKXw7NmpXIgLBSfjq+bZsyYeF9vxPL0kuWHLxgyZOAJvwM+niQisAzE4lks59PjHN1jCQn/UGOYd/yyIrCWBk3G+D+pbmV/a+do7Le3PeAEZgCRJFtCzxlsn93ystQaT0wvJuFVEcM1VWMIwQeE2gYiuG6Ij1OSLp1MSv7fLR/3Gd1u0EQG0L45iR5xHHHoN3bTFyINF8rprQ6n9bAOcXe7l8yOJlZP45G/PD9CPOkzOAWmvI2aR4coZ1wPJqNv3nkpLbNkqYfZTkLLluSTMbm9w2sTIRjatOQq/zHhBXlAC9JWJX37671zZUy3obybIcomQf+MBzQ/aK/K7Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hXQSYIMMHM4nsEYOC+eRMpUYxCMqiCbFLe1EwgSXI8=;
 b=dya5qQTHHdlzKFtVkXiepRFJ/ksYy383MD3TqijO8gP4Rj+URfJIuwws9t1mMfKzhYC/ox84hiHsguEPJRRufekAUZ/g+f4ECFtpVf1La/4TpaJ0M2MbXoZAzfMPlvrGHsKq/vYoA2fFsWtMJ7kGhhUWY37dN46LSqA7BHtXsSOcbjfd/vnw+U0AJaG7xO2/JXqmgQBE8YnzNZyk14wZ3wYQrv4OVYyAmY4fv98ouIYizmZXmebf1z+oEnpRuMwLd17uXXw0mVizRw2NmH9Xq5wkLsWPNVrs0pQ5H1z+Yq/0xOyLH8qJtah71ftd06aE51wVh2sSKMfM6gJ2Z+e4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hXQSYIMMHM4nsEYOC+eRMpUYxCMqiCbFLe1EwgSXI8=;
 b=htRdipcFCBvEFQB1YVPHhHkLN7+FVqjhUcY7LAOhbUnGsMNlB+axraWSILCIgY0KgjAH71KU5HfNH3azW333arTvTgwgacKztgyhVhHONryEMJV8fvyUdKOaLL1YYOSy6X6kwVhmUygqPtffWjgdmhbgCxuZKYnNwTYu47CHN3K/oz2mLz98mTTSbgixtOvjIrySU9jfMJa4UDQHScSAPhmyiglKqMBBlMLFGWSkZ2o2FTHUBPPPQC8wzHdK6r23kntMPv3URcKLXMHby7msx0xdKeWsq4i4p78yiHZ3nlAUzk+EoK0xq0lq5mfomohcSAhLqDtxNcMTut+Xev4/Dw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA3PR02MB10973.namprd02.prod.outlook.com (2603:10b6:806:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:54:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 09:54:30 +0000
Date: Fri, 10 Oct 2025 11:54:22 +0200
From: John Levon <john.levon@nutanix.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH] vfio-user: Do not delete the subregion
Message-ID: <aOjXzi_trU39MstE@lent>
References: <20251010-vfio-v1-1-d7a6056539b7@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-vfio-v1-1-d7a6056539b7@rsg.ci.i.u-tokyo.ac.jp>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA3PR02MB10973:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9804c2-694b-4a3f-6a5b-08de07e3012a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?83mJqK2FCeF5v5w2NAS5cBkXaba6vtgGGi68eGbVRdFWNUzSISN7luPMPbJR?=
 =?us-ascii?Q?hu9z8WgrkSGr/YIO137zdHcVb0sHQsXrFCIGSQaRfwAS7/2OK6wXlH1jViC9?=
 =?us-ascii?Q?zE1ht6NzByfzZT/JdpIk9U1afOJ4diWFtEJZfRmn5+6mlrTbImDatFq4C3oO?=
 =?us-ascii?Q?Z2IIn0xbaRXddtVfbtR2WPOhLmXpo7V7tbLLC/hpM320EcqtSUdnNYI/uZag?=
 =?us-ascii?Q?ZsnA1ezlh/ncc8A1MAQsFBn9h/N5Pl5I8nVYFipbHkpoYC4kk8WxoNfWHarX?=
 =?us-ascii?Q?bH45FNeS7y53pQcYDZyhMSF+e/XtBN8Ep/pYDaOExDm78QWu0N4+NyeLNIhO?=
 =?us-ascii?Q?4iAI99OpeoozKb6nxr9tyJynnwJJzGDleN7ySdwGRY7MhGQOY0RvAJQeRCuI?=
 =?us-ascii?Q?WvFET6wSj2IUKJBlUKC8mMfpFbMyvLv0fY7jZp+nOBsLBFok9p4b+jp+fQeL?=
 =?us-ascii?Q?++kMiF1OkiLV40rd9Kl/HSZQYLUOgE++d+qrzrIC1PLzw0UBpJqeq7X6lIVD?=
 =?us-ascii?Q?Dz14BT+7jhTh9o8h/dMEeuHtRWkcZrumGYaU758AzjT5uj6EslsoWeVdtTZX?=
 =?us-ascii?Q?O9TKBUHD5Er0rHOd6vDUUeOwy1q8hw5ejk55huGPBaUxX8BkanZSU43STGkz?=
 =?us-ascii?Q?DEjix0/MerJuT3NPnVtEuphdVAE8d8JTUf24Us8fI/EATIHfvV3RfuhciJyO?=
 =?us-ascii?Q?2YVPyoUpyT1IDNWQ97QhVcNQwFEX4RgVja4SHHlf+B8cv7hoHobCfhIR2ccH?=
 =?us-ascii?Q?zITS3NRsYnQxuI93ufXAl1EtiIfykbgNuwX73OniS4opZx/eTTAoJ0HriZ67?=
 =?us-ascii?Q?FPtntL8J2T/1VRooIizGI+6p/apUoztVbJTzoZxunTINDfGECZFolFj8rB2r?=
 =?us-ascii?Q?EtwDZbeb8sskI5TrX73bux88A2nI/CiZFQu6oj+MSAWOQYzIWcIHi7cSEEMF?=
 =?us-ascii?Q?IlhVPE2r5amA8f91Bz84P1GY0jRVbiFqHgp1tlJuavBL9Si5Z2SjFZO/LVSF?=
 =?us-ascii?Q?xRK7iEhQIOfGX4j4aK7icBA/eRgbv4GCZlZFKlGWsPX4ENvfudk1cKsAeVgs?=
 =?us-ascii?Q?4JEupY54G0fjIGugcxYanB0cQpTUs5CE+Gy1DMlvoC2l16M8MiwYxSnlkdR3?=
 =?us-ascii?Q?x+agskawpn7wIMxLX0wdJUnCqvCj9RzdEuakmLUM3cDucWwLHfCZX8yQHN+M?=
 =?us-ascii?Q?D1aW2BeoqENWLKFFnILwsLJkyXeCw0oZ6VD9dwrXIY2p+T1DpmsqUioGN4Tx?=
 =?us-ascii?Q?+Pj8A35BljYZ+kwNRkt/QkALp2pJ/uCv/uN3cad8lsYn0hbetJYX+V52DSiK?=
 =?us-ascii?Q?0F8bv5SOemgOOMPQUMMRY00NzsP/aXNwfIXLaFtSCbgCjZY2dkKEhcjpgrjZ?=
 =?us-ascii?Q?tE33PGXKWgxsrbBOMiumZnFl7IdOXIiRMWdggImrY5SNv/Ajqqi96mbl1pzi?=
 =?us-ascii?Q?sdfmUeOt1KEsRasnOCzbtsUFYlg5LN8W?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnfLcV0Mw71GL1lDekOIeQNLG0gnlNV7j0N7X9Mw5e1Cw3pIbtPjo7kYHStQ?=
 =?us-ascii?Q?6nN38ZvhUKWFdB6iWdFY5oFzgy5bVUGXtrBO8tfSrWqAYKcNjB4TNNwYN1oH?=
 =?us-ascii?Q?lyxnbBa48I7AgKCU6DBMIVu9Tc3KR1CUsF+fB6giuXDjXUbile9R5tLwA49S?=
 =?us-ascii?Q?l2GUVpwKyV2mt9I9Nc8ZpD7dnfst9PBQuIMFyylWPODSCnblC+gRLx9Tiax7?=
 =?us-ascii?Q?s7OloCDkObWxyU7EpNTE2MJ8wCD5qTv8op2nfn5KNHT3OcYlnFpjDr/Fk7p6?=
 =?us-ascii?Q?zfHDhRftemPVjq8fhRXurgtDItqmcij4VdEmOz3j1alzBvHInPbsy9zC0jUn?=
 =?us-ascii?Q?iPVKDnkr8+6knGk6LcaNrKttNHPads3wtWISb/F1f7W9jW3PtubZUUyLduJa?=
 =?us-ascii?Q?D16zSygjcDRzsopsMVlKAVM74a8f1VWTeo8T7GIC4uBTmbE/BWIyBcyW91+o?=
 =?us-ascii?Q?LemtZUcH5H9Nf7zn2+Ya9PkJLEg43tPveQbZSppyRjMM2yf759Kf/a87TitC?=
 =?us-ascii?Q?D4kpHgDOBVCfqWVXrWBPmNidNGoleRJqzDRv7F9GNO/f0cR4/k0VjV15AC8K?=
 =?us-ascii?Q?f2d0qZpGVE1VNqNcmvV2yhR3reAzaCsoAhqIlox2AXGWpRs4H10E7Wc3DrtD?=
 =?us-ascii?Q?1/V8FIhsQpZr9YIjRLjAMCLnLjuwkIZ8yX5L+fvaI7izWlLaWlyyfbO4JUKQ?=
 =?us-ascii?Q?Jt61XCNTtugcmgjWg9RtkCKhfZHq2rY3+vXtbPMjyMtad96egWlt9u2knPmk?=
 =?us-ascii?Q?gp+8d8z5DnMR2ntBYZtmvxT9q4TRJ/pHSHyYP4Xmz/0nate50CVeym0KSc7S?=
 =?us-ascii?Q?fO23f6Ufm7Ev+XmMExBCvaRBqJNj/QDUQMp7jadBd8LO9J0BC5kQnOzJCPVi?=
 =?us-ascii?Q?V8sajGNzGxJKOquRLyv8au7EG9Yuo98TSAYiNa6zdzHr2N+Yn3VpzS0fsxXs?=
 =?us-ascii?Q?ER4NUPNFGZvuLLcFqy14+bPUgjygO2b9WfLne4+DeJCDac/lFQsDJGOCGrcy?=
 =?us-ascii?Q?MUqXc5l5LvsveyS5IevNm0iW5Jvrw0SkxVNHg/6LMHpMbsV+4Q4MMk0GHJtk?=
 =?us-ascii?Q?UK52TB7y9JmiQCHr0Cvp73GnIfYwItFKkAmSumkOTwgHfZfDfuk1+k/rQiDX?=
 =?us-ascii?Q?cWd4Bp9BDr7cH24IYUg2q+q5dQJ3TKKyeNwSxEb+LiOqbfoPAPJkvUwRIhjq?=
 =?us-ascii?Q?YmskV9e6W57kdQzYWhCpspdHkkxbUPg0B6lVvXP3xaZLFl2XUxxiUOJfzVKR?=
 =?us-ascii?Q?Ssi/UcmzHaazGffStAHHlqtdGWKuidEHhnRWB29/Qxf9tByQsP0QmuzDQF5y?=
 =?us-ascii?Q?+3VQkUGMgKIfVPbnKbM35wgelzWPufqbStHUcv45oufHx+TYsEcqnVGSLlir?=
 =?us-ascii?Q?4vJ2Th6hYkOuYIXO5B49q8E5XvjMV/BDkxNpMj+JhmJm4ZwqrQYTPvKtAO5V?=
 =?us-ascii?Q?kLn+QwTQ3bg9/Q2jY8OFaPV/UMJve2amq5gWg1CkqcpJytG9p1iOIUW0ELdA?=
 =?us-ascii?Q?6qll35tGdN8hYVA8xjMuQ9aaXd4Micy6MwQecTBRGrFkVMn43R3z+suzeJ4L?=
 =?us-ascii?Q?0R38P9e7ETDf6MgrCizJW+xTwUF8JLJzgiSE9l3v?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9804c2-694b-4a3f-6a5b-08de07e3012a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:54:29.9287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO2y1i7ShD/VVCw/u83c347eMfRI0k4Iq8PMF5wihTjurc2VgU/TcewS43RN/o8SSbaQijPQxNuG2pjr1vYROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10973
X-Proofpoint-GUID: RKhMC21OsXOTZUC6typs9LwveZeswR5V
X-Proofpoint-ORIG-GUID: RKhMC21OsXOTZUC6typs9LwveZeswR5V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA1NyBTYWx0ZWRfXzrlVyH4qCIwP
 avfd4a4c2CZiQnqt5juUZUx1S6KbcYGyPsZ0vblzuIBpd7yCU/5h5aMmk4r6jePDCT3sN84HU7k
 Cfvh2wzX42U930e64yoPLNjBwCkaUJ1KprOKEJfrFFPZFa2ZQ2x9jCUbhWRKiLwZuYllScIIb5W
 rIRH8f4BHlM5XPmYQsnZPOQ8JcZ1G0aKQ7AOlWUDUlWUnhG4dkQY/dDK2dFilS90x68i9ypq7A1
 1gf7XwCXoa02BhmOv5cooi330Bus/jbWb/mzGCsw7vxzKkH+/cSlGFf7TPL4HUgNkf/qEvZlM72
 u6f3A55w5LEzy0COjPumjpxXe/zMbkCyC0XBhiSeZl5Hi62/xoygNXUXxOKIjNPmfJzcJSpWWL/
 UbGpb2AnDZbEs99KWvGdP97sEDCmQw==
X-Authority-Analysis: v=2.4 cv=ecswvrEH c=1 sm=1 tr=0 ts=68e8d7d7 cx=c_pps
 a=S0nsQJN0x0NZxitFF6bqdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=T4CpwJqSomRDQprmotMA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 10, 2025 at 06:34:38PM +0900, Akihiko Odaki wrote:

> Removing the PBA memory region from its container in
> vfio_user_msix_teardown() is semantically incorrect as the reference to
> the region is already deleted when the function is called.

Can you clue me in?

378     if (vdev->msix != NULL) {
379         vfio_user_msix_teardown(vdev);
380     }
381
382     vfio_pci_put_device(vdev);

vfio_pci_put_device() -> vfio_bars_finalize() -> vfio_region_finalize()

Where is the "reference to the region is already deleted" code that runs prior
to line :379 that you're referring to?

What about vfio_pci_teardown_msi() - isn't that the same?

> The operation is unnecessary in the first place since the PCI code
> removes all BARs during unrealization

Might be worth mentioning vfio_pci_bars_exit() (which is what I presume you're
referring to).

regards
john


