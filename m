Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B163CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13VN-0000py-0G; Tue, 23 Sep 2025 09:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uq-00008F-NK; Tue, 23 Sep 2025 09:55:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ui-0004HH-7w; Tue, 23 Sep 2025 09:55:56 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N6QHLf4104495; Tue, 23 Sep 2025 06:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=e6SoJmA04fLGkZHxideb6RtyWErtdSkd5+99dmNDR
 k8=; b=IlJKAyF5pge74tACC2Z9257eSXV75ttdiUtFGhffbzTGjHH8jsNKvTilO
 QYhdrKy3s+LtjC6/o0Cm8Xb7Tf3ZTsar/Li+3xa4eLhVqefNIr+H1aaq7lIrZYxD
 5RfjbaM/57NK8MQqgiZRY1WRBtBrsDr/ADoMgB1nDodS9uC9klp6wsl80GO2KUoo
 M+z0zNS0T6VJOhFLFrMfh9xb9Mh6i0Cj2aDtPJ2WrkwPriFmF2CDMC9QjsNnV9TQ
 CI5pFu4czkJyLatwRbm9ypVkfn44xb3kvGyNYZohxSHV60mIGYennD7B3MOpeefH
 cTi9IUbECnrSFFtCVwYPP2VdzdrhA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020119.outbound.protection.outlook.com [52.101.201.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49bb1fa8af-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bly3CuVADBpv/dV/4xpZKq4cd2BjHJZNI56cxCPBe6g29f2ZLw3VCwh3CbjFrojyF3lq10lS/zzCCgFqMFkDmksOjviJlTjOZwxP8cW/jFNgacTTOi6qDGVGYES97329qYDtILh3lDgFzgG0j1taB6S2nrZmMJfQWJ3cblk3Yso2/GP7Dx6NnP/QLJ55Ipmm5U867PKzu2IhCPZjHLbVLTrWrOFIK7X81YxHhHoEIpyCs9N0pM8pDQz84sWqExKqC9d9O9SXD1VntOTbS0d7kh8qk+4hvAwAUO+dDsTlQ9Eu6yTWBPkg74ElrPn67mBlLPkU41FCu9wD5pFAkdQ7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6SoJmA04fLGkZHxideb6RtyWErtdSkd5+99dmNDRk8=;
 b=l73fPQ7bIiB22dt6Bj2sY1dKfffdEShJB/iJKyDW9bELrRLAW9KIBFnJUm1S0WbIauKeuqNhSMuUhhoYX8r7g12PG0DlL+U6rhkeuQjSxnyfqTJm1JcUXDHJvCpUWJsp26APXDsg2yZfO2WvQq+zluG7N+2XyVoe50QkXF51AmStiqY4jNJE4u6UWRDhaRTx+7Qtw8eeqjXdX2zXVSMA8RBXezOOP0xh8m6fw5MVh2DAn9PUJkykPv4j95OfAjD3IyVcbAM8Wj6mB82k74sKUnNrIzDhoEP1P+ueNy0pzq/w/tEN/57T+lKZNEG+dMvZVNoZ7zMMI4SlNlQBfEJarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6SoJmA04fLGkZHxideb6RtyWErtdSkd5+99dmNDRk8=;
 b=bCIho6JrfX4z60PBhj95xcdt7bgq4It+UGZ4DJmMNKqDpiEFaXlJ3EGOmyylpFomUcNJg+YTxzVxXwThsgN1iT5JnCKyLZYyRAD19yFtYjd2fvSAEsA9sddjPCvAUyPRHd4KYy3SihbDI/ZZ/gFu2IqPd6CQ6H/z1Q++5FKGQqRLi40QNlRQjUgbHO3o17ZTlQ4z9dnlwKS93ZznQ1ST+NtZieKrPhR9EvhTJ7UuSCPbzaC88S7gmz1d3nby2qPvT+hkch8zEA4tURuqbJBfebkaZQVhd3jJOXyMMgXMuZ26hObPJCR1drmfhrcS5a5g95tx1nEU/YnNKSBDX+Hy6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:10 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 20/27] vfio/pci.c: rename vfio_pci_dev_nohotplug_properties[]
 to vfio_pci_nohotplug_properties[]
Date: Tue, 23 Sep 2025 14:53:26 +0100
Message-ID: <20250923135352.1157250-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fa8d39-9720-4cdc-eb18-08ddfaa8cfa6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w9DS4TXQnHCQPSETzHPhGEX0dDJ9LarGLc8o+bPk8UuKL4qITF5xeLlFSjlb?=
 =?us-ascii?Q?GBOEDbetW5WERe/cJ9UWJqsXncd/AxITenVN4bHPt/h/ZcSIiMfrfv7xJrUB?=
 =?us-ascii?Q?VvypZeSfepvk7GbslvHQI+J5EI3stsHwcvfiliQf+pSxwooufo+pU+PfgPXW?=
 =?us-ascii?Q?/wHiLhnR4qxiEjUegA4Vq+GZtZd50q5maFo3MQWGVn7CWnicsnGNHF15RSrD?=
 =?us-ascii?Q?99aNX7vxzbC8EtRyo33TE9dooInjsQdBKFDYgPfjpC6H/ME3GX4B0ims12cO?=
 =?us-ascii?Q?IN57tOGLHImHeZPHtpc2Txlf+/RkmywH8PSkp9zirErmsyWj7dRFn1IBl/4q?=
 =?us-ascii?Q?KHvSq5L7r/tddXzF4a1VXNdVx5a083bnxT795s8BnsiV+mD2de6BY5sjaRkx?=
 =?us-ascii?Q?DXl6jko19+5OBWQgu86h6hjr/HZtxBWHQLM80E8gAjvu2rOhsgL2iEdHOvaH?=
 =?us-ascii?Q?j1Xfjp4yu5661fbSnIFpobRl/fHtUfz71siFnLDCR16pYnwiFTB6R5Y4d8Vv?=
 =?us-ascii?Q?GU2Mw/7Fg9NjzDDjt/f8gd6TCt/JvY48J5Vd4O9wzyo0QrEJZVkbrH1RctW+?=
 =?us-ascii?Q?uJGOpJTLgD/DVD4cXzBG9UTwRk6aOS0Hihz81hvlKZYz8TA0Cbsiw9ffNF3e?=
 =?us-ascii?Q?GqcFC3g0WHLQHzYrW6iouXFXdIL5lej+vXGBS/r9mbHU8y2YsyJs9GSBCZKg?=
 =?us-ascii?Q?LBZ4K40iHthChJgdI7xsulngcqLwATDekkGhc7ecMwx3msadTTnxhUt7Rrtb?=
 =?us-ascii?Q?UFHr39Vd4Yalo7Y+/16OG8O774rGcKBZ/QtF+feeGn4/gUCZMjibzm3EUP+Y?=
 =?us-ascii?Q?QOQ20qwJO/pS1Vta4JJ2ItLNVm92FUf4z8rjyPgYnjfiLE4DJIKqsYohSyMc?=
 =?us-ascii?Q?jJkEWjtsBkVJvAJYs+9NYDlVh7+iAB/arhUgEMG+JcRptcHtSKAoPv70MQGY?=
 =?us-ascii?Q?fOXGwl2QBr1dXoK0tYgavWV/For8/oEEB/074aLq7yaV9GA2LJfRNpP7VweP?=
 =?us-ascii?Q?yh/+ePbnRZfwQ40SPhH24y48O0DPkWl6CLWtXIwDfPYFu8QA8bXKcc2SJupz?=
 =?us-ascii?Q?11vzJWPIqyNVBp951u0ATCrnjEMhGYU+soFWv2lqIKa/Skx45ScMC9LuEPIx?=
 =?us-ascii?Q?jGisPqkRYxJhyLn4Y1sIOZgrpnVjRhA5fPzfr/AyoZZm+CYzsuM3BHtoAMIt?=
 =?us-ascii?Q?2HQpi2XOrI/G+YP38TtsETyJewdu5/tP7fI40ha+GGgrCH2+/JFYkAnwd60B?=
 =?us-ascii?Q?EdQcEUvbW387WRPLMSt0ppR2drxV51Wtv+IqeC0PutqvXL0tpsNaixS++lSs?=
 =?us-ascii?Q?T/vI5ZbVeT5eHzUknKxqBhTA8hgJfmdo2+0oZcb6prsZz9qvmOc69xK5uo53?=
 =?us-ascii?Q?7C/eh2pZ7lBDnVayp9M1zzC4D+99iXSzKU0JPXJu/M22iq3QWqrVsRX4bOOp?=
 =?us-ascii?Q?nfjzQFJ8emVSfJEX9IDsgEJQdN9cpEo5hTdmzxStPzBJGlyQs+9NCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhxbZeFx2TIqX3kdPS9wGrVVVHhHY+55gcRJbn6smENuisrln79c1+AWgSl+?=
 =?us-ascii?Q?J07CpCesaAnp7Pygr5P1IMxPxbC3w84vxJfM1n6JDS0Rkpp5h/dLZ7EXCa83?=
 =?us-ascii?Q?jLxdUsm+Nqb2EUUEQugBrQbwUoOdeSfpl9V6+DfIYGoUvJFIJ8eDPrpCxuAY?=
 =?us-ascii?Q?siBMHE2kAzAhWSXUuKeTIqOUmbWtVLgQxtTh5BMxmPlr8K1gkC1ZBpny3hWb?=
 =?us-ascii?Q?mftgVY/1e3jdPHU6EQyQxitjAmZx0GKoGJSdAWmqcFnKlshxlD9qv4BhP7Nl?=
 =?us-ascii?Q?LhDnwtE/7Dkz/HfKiFrnYQLesNzY3wLz2IA4T9N2xjHNFJ7WnLIkRdaIwtcO?=
 =?us-ascii?Q?/+3dlfZ1CxBV62mZwsRXxtgnVY+K8BdUTZOnbxVBInyCjhObaBh0kN1Pv+Ez?=
 =?us-ascii?Q?nuM4nkisKe7+0ZzFCWIggqWNdCsLvZottTDEYsnJQ+Ym2W8KlG6xFvggq7oJ?=
 =?us-ascii?Q?OZr6A+FIUGm3VHfOJbVnia6r3b0YPO8FW6SRp2bOE5Lwp88eN2dlfwgtSljW?=
 =?us-ascii?Q?FzP0j9C0jroyORpZRNpwm2dAXMgGZ8lP8NrrYya/qO5Cb0NIhOfIdVf1a/g8?=
 =?us-ascii?Q?fxWQm//sF1A1WtaJb8CZ9e/WdVzH5eTk2jcyVwTdjfShVaX6utBtfS7nzSRZ?=
 =?us-ascii?Q?HZrzUkW+20bhofHo9FJhTNWiU2cPRSPtSG5pxGw+xjG+YBYjndCunaCN/dMi?=
 =?us-ascii?Q?TK+GOKIpspnB7zhRR+RvmGkJfO9epeNFvCP8xtz+XqVynx9ZU/3RqrTiwufn?=
 =?us-ascii?Q?+Bp2bdBL7nyiVgI1bodMMfVLMtYIRDV9xqc3696nVXNogqn341/04/W6trNL?=
 =?us-ascii?Q?NK/m/R0qjpd+QBuvVLsQhbRp3MJP1WTaeARoMb9sV6NMuUyrtI1EwWpc0Yb6?=
 =?us-ascii?Q?2/4AUmJuoDFyu3fv1sQk2nl/M2b1PLC2Vh6Scg4w7X+L3iFL1upHHEu9mR+V?=
 =?us-ascii?Q?zNHADppVwakfDNPaJI7QRfiuIrghPVb+0KDVGe/cWKabNTUi7wCehfIYHvuc?=
 =?us-ascii?Q?CGaZGADVOAGXoKYTYTjrMf4GQxV/8rp8Ao5a5yS42/3dDy0qdoXra8AoZ+ML?=
 =?us-ascii?Q?RHuStotYZ0PsDvxUjBY1DMeIY2EEJ8eJKF7T5IvRvWP3JsT9cf/gZMk5UpW8?=
 =?us-ascii?Q?wtqvK/yg244Kc5WqVcVraha13j/iGLjXvYHXC+nkDD7tnZp041P/0qGbkENB?=
 =?us-ascii?Q?JUCxW0hK+Pu5ZyisZDjLxSQI1SyR2A3B4wlnPp3brFXkjAg97UT6wkH7ec0c?=
 =?us-ascii?Q?aXBike5dW0VL67WD5qB5l62tM1+tYIWpX+dds3G2c1M+EGjV7XPO+L4hficf?=
 =?us-ascii?Q?ivZzLiYu9AI+WsBYfYqywDDh8vAds4CduhX4EoWjFsNvdzLSn+W/9ItkcygC?=
 =?us-ascii?Q?6hI8eLOXmhk4YwJjw40wnaTfnGKlAU0NJUdbSlnHQBvuVTLldlJe5ANtwfXj?=
 =?us-ascii?Q?J2EeTxX+GHei9o96lSHxOruDalrc6Z6IJZwHdeN27k54BDQ9MOk+k1IcYSsD?=
 =?us-ascii?Q?gteUU1/YFz61JbKIKGU8jT4euXKBJ5SwQDd69DS6I/NXKr0/JI4tL7AkGbPp?=
 =?us-ascii?Q?HRPuxIlouMKiujpsUXbeQ7PFCBACzDpvqw0BfVE/SwQEboViZ+cPM9426fR+?=
 =?us-ascii?Q?gUseGo17Y1CUlcWMMLLcwHtVj9mjl0o7ei/dE0lqOJqfOw4djTq2yGrUwtUl?=
 =?us-ascii?Q?fvDs3A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fa8d39-9720-4cdc-eb18-08ddfaa8cfa6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:10.2706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8voUytp2nrxqp6a36PoXWm5Wn55pURvHvKzTSqRJ4w7+aO0+1s2hB3iHwop3NTnizXjo1bQPiW+gkNYExKWdyJZ4atxQw4RRC6SWVeeL+SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Authority-Analysis: v=2.4 cv=C5PpyRP+ c=1 sm=1 tr=0 ts=68d2a6bf cx=c_pps
 a=j7k210cWVAfXhyiYu0S74w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-an67RP_g-7o1LT8KO4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX5vHZuCxSymXP
 u0B7X01AjkYidwA3wY9MxoqRVyQkvAhF7dYHng/guPFs7t4Qn2EozWgtV5DQ8NyywsVsr4mkmiT
 ra35tE53ah/rIrxg3OXGa3luvmZ2HUb1TrNJyHZxy/GTvdTnvFJmLiUy3VRgk3g1b4xA0KIBAI1
 xido1iD4yk41weegELY+3g1KQB8Qr5/hVKSZSPTC1MLHZdKw+Kf+28OcvVCQaa7AwWMftIdw+iP
 VyMkcelB7cOcjTuSxOa6QF8lPrszEdztANF7GMX/CqZgcf4VGDwvKs/pJFcA4CWr6nTIwwhIjMH
 a6+NSdFZ+gJzPOjZJ4Zy+VVmi8NKBLw/TaOj2GdotceVIqzVUiOelt+p5pSawM=
X-Proofpoint-GUID: taoeSlyUAbCqPLBJs-0ipT0NwS-Ku6xC
X-Proofpoint-ORIG-GUID: taoeSlyUAbCqPLBJs-0ipT0NwS-Ku6xC
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 839b5af339..a32a507059 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3924,7 +3924,7 @@ static const TypeInfo vfio_pci_info = {
     .instance_finalize = vfio_pci_finalize,
 };
 
-static const Property vfio_pci_dev_nohotplug_properties[] = {
+static const Property vfio_pci_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
                      use_legacy_x86_rom, false),
@@ -3937,7 +3937,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
+    device_class_set_props(dc, vfio_pci_nohotplug_properties);
     dc->hotpluggable = false;
 
     object_class_property_set_description(klass, /* 3.1 */
-- 
2.43.0


