Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F24CC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWfLX-0006K3-4T; Wed, 24 Jul 2024 13:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sWfLT-0006F6-5t
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:00:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sWfLO-0003Pi-Jc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:00:06 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXnt0030312;
 Wed, 24 Jul 2024 16:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=qLSA8bnfW8mNJcz92lvAHgn/xOdwi47l/tqW7ewVzXQ=; b=
 LJuuJwZQO7alvwtK4hrvWaoPD7GsRb528sLX6OUQBCZVR3E/0g84YjMzc/rHbBKb
 KM921WHoS5e+MfDmwdr6aTvhDf5paI5gHobgnGyWs1wxtVrgcetv9t4p5sRdP7k0
 xce9ZLRAElj/YpQaruVfK2Fg8hxq2stI84SxEA4wmlAdCo6ntADAjtVGjWsoGFKB
 fNE26in9pemwtItjcVkz80gT9VXTDeKbjTv5NdIrzjKpXvVUqPeZzlhmqq5jUZRt
 MErwC7YRaSzEXSULiLmwNRc6RKNsxmuTcfEhq6QNM7U2ssduo/lFCNsZ3S0y3AZp
 5d+dBGk8NxQE1eT2la15nw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfe7hkdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 16:59:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46OFnbTe024953; Wed, 24 Jul 2024 16:59:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2a35fdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 16:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzTTeW5vpb0YTaxfG2gHoTJg4znexMi2jRlF6B0UUuonnN4cUYhtkoYfTaQJcuy0AzqbizSGTdtFW1qJGGh2AopZp4hOokqHa/34qhmuStGyT+g40Cq1BaXhsDsn/RZqJiopwABacaG0i8/xsH8Zp9J7PIcnsJ4qNemvJoMyg8SRzy4hX2rZdhnYctEeO/TpivLLNr4Vvjzh7hNea/2w3EUNeYfvVILEGRWwVpteolALl8fkZGLr63kRTQ1TycJY7sm7pvWXxI50YG5TVCWSJlZNz8pAU9hgokTRs7MTPRiza66BtMhxnnB8ImXS32Gbo5fGLFLv/x5QEsmGmbC9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLSA8bnfW8mNJcz92lvAHgn/xOdwi47l/tqW7ewVzXQ=;
 b=CXzyc/hgtTNTT/l7Hm/p+tLnS8SHob18iU8TmLv8d2JK+UnhbTwibsoVuEJQzB4JNV3r9MxTD/P+V9weyGIw/OSHVJLSCxn4Dq8TocYI8gTBU9UFMsmocaqM+KHs2CAKgoFlOr7z4Nm6nm0wviSWWWmmG1OHoLLO7Ry8hp+MUFd4QMIOfjQHrODO08KfP55Ri/6mGsI97JZCYn/XMfczqL838tZLrqquUk9KJD07b4bpPf7GcKIuDd6qq4CL+J6u9odtJWJBRSAcCJCWacsFzX/GFd/9ZMSKNarAc4ZQW3albeNdHQtzJtK2iBeJAMyyP+TBlhTqWwWYEeUj8algTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLSA8bnfW8mNJcz92lvAHgn/xOdwi47l/tqW7ewVzXQ=;
 b=w1SBp+eIKxiuo5ykaibyxZEqbt94tTgRx5RiH9xYvlNCOsSUU8WrQf5EDlHpJ4q+AS6G+bARqa+XlzCEkgVtaQNXoh8Rxg/j57dYLdZgAw21IHDQf3YTU3/446fN00I47Xxw5gAWKc5Uph0vCH5AjZ+9jF9NiKKCl0FQryeAzY0=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 16:59:54 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 16:59:54 +0000
Message-ID: <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
Date: Wed, 24 Jul 2024 12:59:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b25559-fc55-4eca-c0d3-08dcac020a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q21WZnhES3pNZllRSWN0Yzl5THlubnczY1BoRVhqUkxzVmIxbVg1alZ2RUQ0?=
 =?utf-8?B?bEpIQ204RTB1eHlzY2tqWkg0bkxGZlhTMy9sc3dUbXNxeGNwTUVWSVhqT1ZQ?=
 =?utf-8?B?SHlOOTBKWnpZSTN0WjdlMGxqRFg5MlppV3RzeG9ka1pzc25CSFliWVZFSnlZ?=
 =?utf-8?B?cnNjRnNMekN4ZGVDSlFzY0FqdGRoK0x0ZzJMdWZGK29OZEJWLzk0eFVud0Jt?=
 =?utf-8?B?bERIdEVMOWd2c0R6Z3VoZVVTTHE1bHhVQzlzYWVCYityS1BzYXVZNThRTzNs?=
 =?utf-8?B?a3F6RVlESlY5U1NmUS9OdEtGY0ozQ29FM0YrSC96N0VSWEhOVUFrd2F2OE92?=
 =?utf-8?B?UU9qOTkzQkJYL0dqOHFOUkhtYy9nc21YeTF5blExQ04xUWNZWnltSkpyNTNk?=
 =?utf-8?B?OXhmV1dTRkdnTWsyeklpcEUrNG8xMXl5UXZzaW9ScW5kOFZxcTVUOTIzRFZJ?=
 =?utf-8?B?ZmxHN1JSU0FvQnNQaHdOQTBsS1J0K0VjMEVVV1ZpNjdlNURzdnlTYlRMM1lG?=
 =?utf-8?B?Ykg2UUhQWTJzUVM5SVpPb2RCMVBld05rcXovV1hoRFd3ZWhvbzdIYXlDS3dN?=
 =?utf-8?B?c2JyRXU0Y3cvUlEwNkVxV3VlWWNtMHBtRFhqcEZUa0ZiWUNZWlVFbGhGYVc4?=
 =?utf-8?B?bHNNR0RZdlQvQXpYQmtyeWJyMWkrRzlidEpFYnhYNmZOcTJyTmk0MEh3Uzcw?=
 =?utf-8?B?V0ZnSXQxMVV4R01UcCtmN2xwUjlmT2MvZDY1L2ZVaTM2cmVrRmVBNHFCbWVl?=
 =?utf-8?B?MDVJSXlyNExkZDVSSTFMc3ZvRTZhNUNNQ3pWbUFTSmZnd3RXV0FtZzdFU0pu?=
 =?utf-8?B?SnBOdlFXbFRVQ3pyWXhCZVdlaHh1RmkxRUVZSTg0d3JpMVZvZjdjL2RLa1Np?=
 =?utf-8?B?SERLNVdycDd5bzFFU2lGRFU2Ly90TGlLdERMVUh3aFdKK0FLYXI0SXJHYlRv?=
 =?utf-8?B?Z1NrUXlEa29GNkRDYUxsMUE3SmJWQWFzLzUzQjJSN2trRDZJZVZrejJUT0V0?=
 =?utf-8?B?TFNXUEp3L3VVTXVET05FZEdMelhUbHZMVEN5WkVJblk0YVJHZGs0WExuTXE1?=
 =?utf-8?B?MzFUd0kxc1lvMXp4UWdTeDJIdTRUczFLTmlUQ3cwNGMvVnh5d3VuMlZhamRh?=
 =?utf-8?B?SDZRcXVWb3FQWHMyUDFZMkRtR1kvMUxmbEFYSmdnTWpqbm5EMmczQUtHOFlE?=
 =?utf-8?B?bDBTTjd0bkxtZktDMkJxWnJrYUJPSzFKazE1V0xGTHk2eDU2bUpBSFhoNENQ?=
 =?utf-8?B?dEpXaEIzZWVDZU1FRDgwd0srL1lXUEU2dFUzZC9zckd6Y3hJRXBicVU5RVA0?=
 =?utf-8?B?Z0FMNWZ0NTlMdkNlbVpxSHNHakl4YmxQTytiTkdGeUh0bUdNYUNpd3AzdFd5?=
 =?utf-8?B?QmtKNC90ZnNRdkpvalVyUVJZakNzRHk4eVJHVXJXZVdTdjZrcTF1cXFyWXM3?=
 =?utf-8?B?U1dqUXBXTDRPTHFmLzlBbGg3S2FaZ25NMEhpYy94UVNMU3pheXVWclR4NDVY?=
 =?utf-8?B?d1VTczBYQzdCVW9wcWZSTU9hUWU4WWZ1eExCR3NGaDVhdHJ1S2hBeGhqS1NQ?=
 =?utf-8?B?YnRaRjl3Q0tObTdraHRrQWoxeXFXRW8vNGg4VStvSFdDZ3JVL1d4b2twYmhE?=
 =?utf-8?B?dUxuMms3eXFOekh3dmVwbmM1QVF5b2F4Mm9UL0oyaXBsekcrVG44ZW5vNTVs?=
 =?utf-8?B?MnBXd2tUVTEva3pyMEd1Ui9PRWtzRnYzdmZXTFFEWTFBZ3FoWkRHVldwSUI2?=
 =?utf-8?Q?GJ+gHzwHO1wt/4Ty4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXA5THBtZ1grNDBVY1VoYmhzb2lPUXhRYlRHbnh1R1RWMElWejFJNk9IR3d6?=
 =?utf-8?B?bDlRVmt4KzI1WVUycU9zck9JNnBnTDZTVG9CajRBeHExMlpvSU1zZlZuTFFR?=
 =?utf-8?B?REh0YWhJOGFIYU1kYmszZjZ4eFNjd0hYVU5vWUZiOS8yTUwreXBNTmlrTTY1?=
 =?utf-8?B?NnZpUWhyejhmdFFoRFdhN1pJcW83RTRZNFhBc2xpRlZzb0RHTFEwQklIYkJm?=
 =?utf-8?B?WFFvUGt3SE9ObEhQZFR1Q1R4QjNxa3lmZ2dsNkNzdGNWWU5ZMjlSUnV2bDBh?=
 =?utf-8?B?dkZibk50blFlVTVpakN4eWpGcm5yZmJYaFRNQ0pIQm5LQjdzVGRjTVJGa3Q4?=
 =?utf-8?B?SUU3YTBBVVJkZ1ArbFdiOVgvYStoZWRnTUI0djV5WVliS2hDZ1NlNjZVRzAy?=
 =?utf-8?B?MmNGU1lmSjlkQzhBR2V3NzFtWjNGeHJPaDRRSWlNZnRQL1lkWUV6R1FKbHFn?=
 =?utf-8?B?TjM3TkxwdDFMRmNSMGM4MmROTFZJTDFiaGVRSTVRd01GelRRRVJua2pobEc5?=
 =?utf-8?B?T1J3Tm1wTC9RNmYzTnVLRFlhRXU3REtkK29XeG9wMDlTcjZzcFUwTG11TXZC?=
 =?utf-8?B?YlNSN3plMG9GN0VvbWhBMlBYVE13cVhhVzMxVms5VTN1OUZ5NHl2YVU5b2Iv?=
 =?utf-8?B?eUhhSEMxRFpOVjNGSVVjTFZoMkxESXF1Q0FOa1lMR0FxVVJkN1kvZHpDcG1p?=
 =?utf-8?B?T1l4U2MyY05HQlNoZUJGbEVTeHVCMHNFSG1PWTNaQVBVTjRTV2VWVWkyKy8w?=
 =?utf-8?B?V0p3ZzhNZksyYWN1ZGJ5cm81S2tYd1RPOHFqTVNzd3c0R1poYlovdmthNmpy?=
 =?utf-8?B?cjVYNXp6dS9BRDcrTkdCQiszcHVLYm9FNlRDNlNWNm44RkQ2dDRldXJkUUV0?=
 =?utf-8?B?N2poL3ZYUXgrU1B5dU1VcHZqTEZ6aHl0QXZtMDF3RkRNQk9sT0xVUUd3aFVQ?=
 =?utf-8?B?dlBQVzBINkN6Q1RlYktmUGpaa2NtREpxQ1dGUVVTZ2lvNDNRYnhtMUM4SHZo?=
 =?utf-8?B?LzdzSE5KSFh2K2pXcnU0MUhmbkptWWJrUjN6SzVzYzVCU2x2U2NjemRiR0VN?=
 =?utf-8?B?YmFqOHRySFpFeitCTTZIQURkditUazBrZ3JIUzh1N3hjUFVEUUswMzRGQ3c3?=
 =?utf-8?B?amFkd0NQbUpVekVidEx6dm9ld2JFVTlWYWVvU3hmZE1LT1J4QThQS0R3K2ZL?=
 =?utf-8?B?UmtabGRGK0xkdERBYjZpakQ4dTNYdE9wRExlWDc5NHRWTkUzZTg5aSs2NElu?=
 =?utf-8?B?VW5oWGNQVVlydVFVc012UmhLQkxBaUY0bjNBRlZHb0RBSFBMMEFFKzRVdnEx?=
 =?utf-8?B?Tm5QaGxzZ2lpL3kzOExmZERvWTFISVlYWFVxeVVDZWZYUnQ3NU13KzFjdnU2?=
 =?utf-8?B?aVdJY1F1ZjBSWlhkSGRBRGthN1Jqa052R0k2S241eC9QeWdUVjZyVFRKVFRa?=
 =?utf-8?B?bnJzQnliZGN1NTgrWGpkSlBXUGNNbVFRYW9WWjJVQVpHM2hPWThRc3FVWDh3?=
 =?utf-8?B?eHNSNzFiL1J5UTVDYTZmdEsxSHJiVVRpZmc0a3NRWDZnKzZMTWJmSjdQMlpR?=
 =?utf-8?B?WkRKT0NxcXROMlQrUFRWSUd5Mm9Sc0hLRlU1N285Skw2RzdSUkZiV1VteXlW?=
 =?utf-8?B?bmxPVkhJV096MjF4OENIV0pKYnZPSVpsYjZlUkRjS0gwdXVNNXJUcVd5enZm?=
 =?utf-8?B?NFd5VmJPNjFtNUJERXpRSElnZzRyVTBDUVRHb1lvZlJ4S2ova1grdUQ3TUtR?=
 =?utf-8?B?QWZFZ2NZYlhLeTdwMWJ2ZVNDZ2FwVkIvYkdVWGI5dURoUlBibUE1YkNpMDZG?=
 =?utf-8?B?TnJiQzJGNFF2em1CMkRiUkVQZW9lYndDL2haMGE3U1Q5QlZJQU15Z3FXL0Rj?=
 =?utf-8?B?YmpCQmpPdEgreDVBZTBKKzlTdmFUUG9CWHlCazJyV2ZLdk1pdGxSWlJFbCsw?=
 =?utf-8?B?MGFOZDlwVUZSbUFvRmxWMjBBWWpzWXVGVUdWbmNwenFKZWxKY3JHeHNKV2RC?=
 =?utf-8?B?WFR5QTBnNHZ6RGVuVSsvRnlnWU9hR2NGVE9XcW0wWlZuL25PT2pnQWpZVURD?=
 =?utf-8?B?Tm9IV3VyaUQ3YmhoQnZtRURaM1o1RHFBRmdQbXNkUVBZaUM0V2tsOFkxbStk?=
 =?utf-8?B?OTFPSk1JSHNWMHJZU1gxUFM2TkNYaW9GQlNIL2o3anJxSlQzTTJSZEp6RXhi?=
 =?utf-8?Q?YydfoVP+rzv0CCpYjduxodk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ONEnqj0+l9FGap1lwU+udA15iGm4ng1CAWjrulXh3CVLMU2Hc3HLO4WWLUeVzutJimrZhfPkIZXLttWSPE/LlDZ7n1UQII56DLHs38nygZsUJA3/8TuE/RRO5piF69T++Hk7uSP/jqiUdhVqxGtbUk2VNF+pQyxSnmW/dH02ybAqYQsDrXQIXWypEcln5nPrx1nPjGZYBGfH9WGBJKgKs5ubvfXRz0ebb5BOxMKTpioq1b2t1BTPdwIZs5t7NEj7fd3fPPFfJpLVD9i6hRfStXS932TIHdpNfgvI1b6rAd+uPEH1e8wBnj6DaK3YOkGjle3uCdmit0fNwjKTWkCx1nZSzoSSkc/ykkR70Gmn+YkEQgcPMGJH+tj4Ad0Vvg6qNDTsOgIGXheOZ+Sr/3R/2oNwD4tIkY3vXm0dsL4uN9beeKqfXJeODesW1w/IPcI3n4OcW/oT8/SWWKo/Iv095c0SqFilVkkjcerB3bvy0n4odncQ37+CBX3aQ11SRw/lFiXOjIWwIvYDeX18DH3ELAUhnMhkxohad2eMpisk2jI5hfoWXcO5e/y2Vuti9MFhFteaP3DSsHVhmns1uWYNC7rqK0trrVIGrxS+vo5rw44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b25559-fc55-4eca-c0d3-08dcac020a22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 16:59:54.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7CSNbdd2o2JcVziPkDsWcfiPvitUTptNWYfgYJA8ThRcFOUvHTO91rFyk9s5tuaCER3VniTAKp2xQlXnB1shA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_17,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240122
X-Proofpoint-GUID: s1pC9YuWB0g8v_zKrZIskvFrQPq2F8wc
X-Proofpoint-ORIG-GUID: s1pC9YuWB0g8v_zKrZIskvFrQPq2F8wc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/13/24 11:56 PM, Jason Wang wrote:
> On Mon, May 13, 2024 at 5:58 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
>>
>> On Mon, May 13, 2024 at 10:28 AM Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> On Mon, May 13, 2024 at 2:28 PM Eugenio Perez Martin
>>> <eperezma@redhat.com> wrote:
>>>>
>>>> On Sat, May 11, 2024 at 6:07 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> On Fri, May 10, 2024 at 3:16 PM Eugenio Perez Martin
>>>>> <eperezma@redhat.com> wrote:
>>>>>>
>>>>>> On Fri, May 10, 2024 at 6:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Thu, May 9, 2024 at 3:10 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Thu, May 9, 2024 at 8:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Thu, May 9, 2024 at 1:16 AM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, May 8, 2024 at 4:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Tue, May 7, 2024 at 6:57 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56 PM Eugenio Perez Martin
>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where different GPA leads
>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlapped regions
>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the tree, as looking
>>>>>>>>>>>>>>>> them by HVA will return them twice.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I think I don't understand if there's any side effect for shadow virtqueue?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where this comes from.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences of maps /
>>>>>>>>>>>>>> unmaps happens [1]:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> HVA                    GPA                IOVA
>>>>>>>>>>>>>> -------------------------------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>> Map
>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Unmap
>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>>>>>>>>>>>> 0x20000) ???
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The third HVA range is contained in the first one, but exposed under a
>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
>>>>>>>>>>>>>> not overlap, only HVA.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds the first chunk,
>>>>>>>>>>>>>> not the second one. This series is the way to tell the difference at
>>>>>>>>>>>>>> unmap time.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY$
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
>>>>>>>>>>>>> the iova tree to solve this issue completely. Then there won't be
>>>>>>>>>>>>> aliasing issues.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I'm ok to explore that route but this has another problem. Both SVQ
>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
>>>>>>>>>>>> and they do not have GPA.
>>>>>>>>>>>>
>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle this
>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can we store
>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ buffers).
>>>>>>>>>>>
>>>>>>>>>>> This seems to be tricky.
>>>>>>>>>>>
>>>>>>>>>>> As discussed, it could be another iova tree.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me expand & recap.
>>>>>>>>>>
>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use is easy at
>>>>>>>>>> adding or removing, like in the memory listener, but how to know at
>>>>>>>>>> vhost_svq_translate_addr?
>>>>>>>>>
>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ version of
>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The problem is not virtqueue_pop, that's out of the
>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
>>>>>>>> conditionals / complexity in all the callers of
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The easiest way for me is to rely on memory_region_from_host(). When
>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. When it is
>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use case, it
>>>>>>>>>> just worked in my tests so far.
>>>>>>>>>>
>>>>>>>>>> Now we have the second problem: The GPA values of the regions of the
>>>>>>>>>> two IOVA tree must be unique. We need to be able to find unallocated
>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATree, so
>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is very
>>>>>>>>>> complicated with two trees.
>>>>>>>>>
>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For example, we
>>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges. It is
>>>>>>>>> shared by both
>>>>>>>>>
>>>>>>>>> 1) Guest memory (GPA)
>>>>>>>>> 2) SVQ virtqueue and buffers
>>>>>>>>>
>>>>>>>>> And another gtree to track the GPA to IOVA.
>>>>>>>>>
>>>>>>>>> The SVQ code could use either
>>>>>>>>>
>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and buffers
>>>>>>>>>
>>>>>>>>> or
>>>>>>>>>
>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
>>>>>>>>>
>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
>>>>>>>>>
>>>>>>>>
>>>>>>>> That's possible, but that scatters the IOVA handling code instead of
>>>>>>>> keeping it self-contained in VhostIOVATree.
>>>>>>>
>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>>>>>>>
>>>>>>> An example is the iova allocator in the kernel.
>>>>>>>
>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME passthrough
>>>>>>> code, not sure it is useful here though (haven't had a deep look at
>>>>>>> that).
>>>>>>>
>>>>>>
>>>>>> I don't know enough about them to have an opinion. I keep seeing the
>>>>>> drawback of needing to synchronize both allocation & adding in all the
>>>>>> places we want to modify the IOVATree. At this moment, these are the
>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, and
>>>>>> net CVQ buffers. But it may be more in the future.
>>>>>>
>>>>>> What are the advantages of keeping these separated that justifies
>>>>>> needing to synchronize in all these places, compared with keeping them
>>>>>> synchronized in VhostIOVATree?
>>>>>
>>>>> It doesn't need to be synchronized.
>>>>>
>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
>>>>> which part of the range has been used.
>>>>>
>>>>
>>>> Not sure if I follow, that is what I mean with "synchronized".
>>>
>>> Oh right.
>>>
>>>>
>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
>>>>> IOVA mappings separately.
>>>>>
>>>>
>>>> Sorry, I still cannot see the whole picture :).
>>>>
>>>> Let's assume we have all the GPA mapped to specific IOVA regions, so
>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
>>>> because of the migration. How can we know where we can place SVQ
>>>> vrings without having them synchronized?
>>>
>>> Just allocating a new IOVA range for SVQ?
>>>
>>>>
>>>> At this moment we're using a tree. The tree nature of the current SVQ
>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to look
>>>> for holes.
>>>
>>> Yes, iova allocate could still be implemented via a tree.
>>>
>>>>
>>>> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
>>>> over all of them, order them, of the two trees, and then look for
>>>> holes there?
>>>
>>> Let me clarify, correct me if I was wrong:
>>>
>>> 1) IOVA allocator is still implemented via a tree, we just don't need
>>> to store how the IOVA is used
>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
>>> the datapath SVQ translation
>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>
>>
>> Ok, so the part I was missing is that now we have 3 whole trees, with
>> somehow redundant information :).
> 
> Somehow, it decouples the IOVA usage out of the IOVA allocator. This
> might be simple as guests and SVQ may try to share a single IOVA
> address space.
> 

I'm working on implementing your three suggestions above but I'm a bit 
confused with some of the wording and I was hoping you could clarify 
some of it for me when you get the chance.

---
For your first suggestion (1) you mention decoupling the IOVA allocator 
and "don't need to store how the IOVA is used."

By this, do you mean to not save the IOVA->HVA mapping and instead only 
save the allocated IOVA ranges? In other words, are you suggesting to 
create a dedicated "IOVA->IOVA" tree like:

struct VhostIOVATree {
     uint64_t iova_first;
     uint64_t iova_last;
     IOVATree *iova_map;
};

Where the mapping might look something like (where translated_addr is 
given some kind of 0 value):

iova_region = (DMAMap) {
     .iova = iova_first,
     .translated_addr = 0,
     .size = region_size - 1,
     .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
};

Also, if this is what you mean by decoupling the IOVA allocator, what 
happens to the IOVA->HVA tree? Are we no longer saving these mappings in 
a tree?

---
In your second suggestion (2) with a dedicated GPA->IOVA tree, were you 
thinking something like this? Just adding on to VhostIOVATree here:

struct VhostIOVATree {
     uint64_t iova_first;
     uint64_t iova_last;
     IOVATree *iova_map;
     IOVATree *gpa_map;
};

Where the mapping might look something like:

gpa_region = (DMAMap) {
     .iova = iova_first,
     .translated_addr = gpa_first,
     .size = region_size - 1,
     .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
};

Also, when you say "used in the datapath SVQ translation", we still need 
to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is 
called, right?

---
Lastly, in your third suggestion (3) you mention implementing a 
SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for 
just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.

struct VhostIOVATree {
     uint64_t iova_first;
     uint64_t iova_last;
     IOVATree *iova_map;
     IOVATree *gpa_map;
     IOVATree *svq_map;
};

---

Let me know if I'm understanding this correctly. If I am, this would 
require a pretty good amount of refactoring on the IOVA allocation, 
searching, destroying, etc. code to account for these new trees.

Thanks Jason!

>>
>> In some sense this is simpler than trying to get all the information
>> from only two trees. On the bad side, all SVQ calls that allocate some
>> region need to remember to add to one of the two other threes. That is
>> what I mean by synchronized. But sure, we can go that way.
> 
> Just a suggestion, if it turns out to complicate the issue, I'm fine
> to go the other way.
> 
> Thanks
> 
>>
>>> Thanks
>>>
>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>
>>>>
>>>
>>
>>
> 

