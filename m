Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3216CEDDA5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 15:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLNG6-0002Wl-0C; Tue, 18 Nov 2025 10:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLNFb-0002Sm-0F
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:04:14 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vLNFZ-0003xY-0G
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 10:04:10 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AI8vo543466374; Tue, 18 Nov 2025 07:04:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=s9lxgwm+M9oKVbm21+4EAftENanqTekVF+Gl8gtIs
 wk=; b=VcuA07plDuxRpsABmpNTQgwXtcxcaWdTgIj8KFBv/SUf/KCF6xyMILcu3
 JZE4Xx43/gSNPELyg+knYLTyb8Iv88Fq3QCr45koS8vYE5/e/MMAGDnzvBwXtLe6
 1KrAutVqc8o9nuZ97YV2hui4A/C/Bnsihf2o/sF0uaZFoXrRiJhse/bSEXa2V8wD
 xkF8vDKoefQgzvmdSoj2IXIhjPhW2lbyj91zuBy06f0cXet39UTZFzg+fJMFpFc0
 u+pRScaK1vX/tJhZ0P4tHHw7FhCXjc1vGQVaEw2csgjd9Aid9QkJbtahx6Bg4CdC
 l4Er+M6Hspd5sUsGiBqHOUvMS7DXg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022082.outbound.protection.outlook.com [52.101.48.82])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4agb8m9yma-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 07:04:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq5wOEMhqxe87Z3Gs5QFKYAVVqHC7Qn3Mpuy5Hy8oPv8vtSCuuDpo9KJaNMz5lf0k9k1lOb9lzkXNehRdZiJWMW7RrrQtTxWozNzEvlKVk0PFfeOjknjx+REiqgvAMSe0F+6v8cCT6SO0z8tO3Bk0QlS0Fd0ezmEAuMHCuP+Tnq2GXr8SaolDc1v5ypGgm7WywJc0iepWslJw42zkJrSosWxTqUnomEuUTTS2gOveYpdJMHQVO4Kbc+j42WtpoQiFBqn7FVqY9OH0Ap/WqBsoI2MoaP3a8kEQT7d5IuMLU6QRCzMAYU3C6kTPWJbjqOTKt+Mv4YKnW8sXL43uVzGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWWZTi5YUgMlwR9MimFo6YoDJm09RMeLOXhrPuWv5AU=;
 b=vG9WgsV8aKWCl3PlsF7cknMo+x+exMtXHGcFHkwgGHdviwKGQJBnJw6AAR1zobQYbgiAajfypbt8q/kX1JudJnH4oprxUaahzcCRQ4Y6wDmSK7BN1R4XwH4ADyFCLrSDIIQkxQZMMLb/z0wJa4Vd/TlKGrAw+xjRuFmdLwrNmpx5Iuxm+M8GT6tpURyk2311IeexyaZTomhNA7yb0CrCsJWnOTS1sErBQyJja+JExjOM3cFrg+nPqL4xQNXLRdq8xe7kmhYK/MUXeSY07ZSQphHz/ys2rwzJ29OHX/9Zd1Rjps6aarfHxbTYGvUUOCHLvp0DxO2PsshHXLb9O6MliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWWZTi5YUgMlwR9MimFo6YoDJm09RMeLOXhrPuWv5AU=;
 b=AMXT2WTJkSQmI8IFeU8NhaxmrJM4ORTug9f2SW46ohe+91Lr8ru4VeIIdSmT7qUAwIOWBnx428A3V3HqsxEZkQlreMRDXd5a+oUYLIjoTQ5Z2UrVGGTOGvPdT1KnAagcB3qzGgs3ctI94GFyVkJDZU1cy2tdFylUdNQOuFqNyBRckNrp/fRzoxrPz/S+Nkz4qn8H4pvvX6AFmcovSAvL/udZbbaJVil8L8a5YJAhSPJNH+xLzKOD0pqjBM/4qisnb3EjUx5ywV5tytnBkS4eFunGJLNSw2+lsFTTyFc2iFOpqEG4vWN4lG8HP9w+IF+zTL1I+av/rwMaq7IXHTaP8Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BN0PR02MB8064.namprd02.prod.outlook.com (2603:10b6:408:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Tue, 18 Nov
 2025 15:04:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 15:04:00 +0000
Date: Tue, 18 Nov 2025 20:33:56 +0530
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
Message-ID: <aRyK3KUe0E-bng5f@lent>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
 <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4PR09CA0029.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BN0PR02MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: cd65aa50-6eb8-46c6-5b3d-08de26b3b49e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5Z8Vww76tE08hZl7GWZ29eXUC9Br3dJYbt/LTsqn0GbWTnVmlQThb8Poak?=
 =?iso-8859-1?Q?aLLH6o7WP69cSUjTdOhy7iAg3XACDBszHWR5p18YCosk9IDctaPNwFhaL1?=
 =?iso-8859-1?Q?UXUuRbDr84RPp8FqCLc/K/rqcFDHbkucAPCmRQXJhN7WW+PxYVxYMw6tDE?=
 =?iso-8859-1?Q?KzP+hEYj/BYM4fIGuMaYCZ9ciJwa4Rr2vz42ckIvfkKhvd6YdfSnbY5s/Z?=
 =?iso-8859-1?Q?WZrBE3xRQwCW/2vNXhhKJWUo9KpyiA+tO+Y72M1K49KBtOz04Q92cns3KG?=
 =?iso-8859-1?Q?McwU2T+fQEnyfK41URuVaAfjvVS+Gp8PyfomUBf4fR4ZLXDOOWnKM2wXl3?=
 =?iso-8859-1?Q?hnnDFzYs9jwXP5LOFclJpuntIa0cRje8MPVOyO0mh9pEENUHZ5j4mcgPSd?=
 =?iso-8859-1?Q?2X0a4jiFxUbzSsbE6SqTCVkP1KmWJZewMU2KPWo9I8h7BSF7rNwhRIXONX?=
 =?iso-8859-1?Q?DhauvX4iKcYb2Pi3O3xYIRee+FPtV2DiYv9VDo8cGL6zvXLJWR2Lf88ngw?=
 =?iso-8859-1?Q?qO+gC0vIdFPDkJWuhKYn9f0iRi+n5+rYpWsJZPUtB8E0hbnT23wjJGWzyi?=
 =?iso-8859-1?Q?4ltp5MGzTMm/dSw7lMxMc0kMS/GsuDe1kknLqVZKJ0kpKJyrR5EMDT6WxF?=
 =?iso-8859-1?Q?d7hcVxQSZO/u/fvPiqYS3M+TTc8aQaFvK53ClyXmi5owhYcMciafU+0YuA?=
 =?iso-8859-1?Q?iN5c2FPRotK3xvMxze5UYJfNxxbT5gzBGueWsp0ej1ctUG804OZnaTyOJJ?=
 =?iso-8859-1?Q?Adf5v5Cxkd/L08TDx/6DciZAV2tXMH86orI6KdT94lr7itegCWBdvd79HX?=
 =?iso-8859-1?Q?Iiol+Gb1oR08B2jZ08rGTEYJSN3yQpBJo/zz8K7I6Swl2WnX5qhzTQrabH?=
 =?iso-8859-1?Q?nd3VLqbwt0/7K66pcn2HmNySWeVZaAnTTCkfKF+L7G4sDw+3OQRk7/XPBn?=
 =?iso-8859-1?Q?D3cN/z0weM/X3w7Je6DfP9RnK6DTKRcAn1OAGiqifq3CDGnFhjX7fSP/iD?=
 =?iso-8859-1?Q?+MBPZI9NHQ+VMknkydsZ1SPiX3eaVJ6Fw2kt8Tp1uEO0CJuYCQqi5mttHX?=
 =?iso-8859-1?Q?ZrT8eq4jVS6aAfB+MH/QzRMkX9qGpKSwDBRG9H//gpL7orqIthBDmqOCaQ?=
 =?iso-8859-1?Q?oVAE2kXo+L6tBgGGxZTyUtBjNWSq7O9+5OHbFTvrFIpaFGIth7YMhiKXAd?=
 =?iso-8859-1?Q?VsGH6HzAsy8Mbq9TPEbgK9YuPT4IAdHyuSokNAsFtI1P5fYwc0fDlY5opg?=
 =?iso-8859-1?Q?Q2A5CeqkjgiNVnAq3XA6AL2PkRMZquikvDi55UVDP3a9QsgBtSApJZDmW3?=
 =?iso-8859-1?Q?Ezik6PhRnzsb8YQp0a+5Fe4YFg8ZFnQigx0bgEH6v+iaK+4WsMpr07NRnC?=
 =?iso-8859-1?Q?5l80PIDUmuWftD9h8dn7VkZ8farL//PdoO8+0QPIPNKxnzJCFQe6swbUTG?=
 =?iso-8859-1?Q?u5YAxii/Se9yUpYXDM7D9nrJCLqCpjPiZWECDiPNfMFvjiX+V+LzUZAoAp?=
 =?iso-8859-1?Q?hNnmlCVqok7YHxh8cAjbBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/0wSH1J27cD4rLyNN21bCCBmQl5AaVrOwfy+ncf2hG3l1+eM1B+C3u+GV1?=
 =?iso-8859-1?Q?RawydBzOHb4DXjQUGy4V1xJtOHs8v6lN5X+D1wCeoJhf5lLquRZiEBu8lN?=
 =?iso-8859-1?Q?7+icmsDJHhhsd3rNnKQDH4NAaEKpzix1U9XtZL7EU/l+U1FMlBNWwJhVO1?=
 =?iso-8859-1?Q?GxucoDib0G+OvnSaWT3G/CIPbW5m5iPtk3WUT5zNG3CCGUaZgZIo7hMGAT?=
 =?iso-8859-1?Q?XKVIRyib7kl+rynyydSRnMxgArf+1OdMhiSEm0w6jsXB+ygBmsXgMhi7Mf?=
 =?iso-8859-1?Q?LfPOtw4B8jsMdo/yoa6dLQI6gke7JiJvp18U8UD43mQW4+RHIyBWQDLIOp?=
 =?iso-8859-1?Q?v2MsiKXOWw3QOfYe1YoNnSeQiKXiqu00MHX/Yyiu/Xqei88KYocR/acMJL?=
 =?iso-8859-1?Q?IvKKlRwX+ocIBnBp82XfzItzN35IJ151LCPas9s111WgNHRLNAKhB5vYXL?=
 =?iso-8859-1?Q?Tkxmt7zqJvc+Laau7ZcUOVJgJLOemTyXOcd19ZwVxciIfuVuGbnJ+gwfma?=
 =?iso-8859-1?Q?/6bXPUbyn1tojgzKC7ZXcxLCmb8GKBjFUpiE+FDGC3zto5DlGBjvtBwO0a?=
 =?iso-8859-1?Q?Lu5XXxsmZuUPdmu1Ag//IkSBNiBSaJ5zwh9pFpjOdmOL3aKiR17HG+L/U5?=
 =?iso-8859-1?Q?2Hm/TGU8l+acdOReCo7ZhMupSk+DPaaNHhW9+Lua929pXeAhc+EbrpFb3m?=
 =?iso-8859-1?Q?pAd/yxnXq7g002y536gAKjCYZ6zZRfwSFAhQXbMgI1DV0OY3UbGWfG5Lj1?=
 =?iso-8859-1?Q?pb7cuTXY0O2wCDstbyhQjXvDbRrV29eFfNlkWM7g1JZw2eSVlRh+tBJt8h?=
 =?iso-8859-1?Q?B2qjM4YeYCNsFfq1XPrCSx3Tt8yZUxfSu8QPCcBC+CoTkRZczTne5hydG4?=
 =?iso-8859-1?Q?MiXc/aUqnfUCibsxCzJe1o0W0DqqkBKoEV67OxRYlSCTYvF22gfPO1l5zB?=
 =?iso-8859-1?Q?1CRZ+vPjisqfODDM+CaEUDi1tj/KBkOh86P/dNCVhczKmPEjSsis+v0rzl?=
 =?iso-8859-1?Q?gQTW1mfGFby/1QBzmK2h7TwdfwaSxJkbBKj1v1CTK4rmyhqiFKUZnMprHZ?=
 =?iso-8859-1?Q?pc59+ZaVDiCiyFWTO2WcNuOkcA/e4HcImTfBIIgZxkzclkRrFvt/zN326Z?=
 =?iso-8859-1?Q?qeSoVuMySWf3yFfNTp5bRsxdciMeeL2YGr70uDgYPqWJpMyYzR1H8w1Zxv?=
 =?iso-8859-1?Q?PS6zDL3clLAjNCNNS2SqViyiKynpjJOsDcd70qHTEFXA6PVGVEhEER/dL0?=
 =?iso-8859-1?Q?U/J5o/+0W7jNcXDKMfdbPfacIByk0AMln0jNCUpWemU1BLUi3X1yk5Ge8t?=
 =?iso-8859-1?Q?yZ8VaFOKfPg/AauXyblPE+zwVTlUCTR3Qrscub23Q4YddXDRnwBu9elfZ3?=
 =?iso-8859-1?Q?We4Ba5H8O4f/rGDr3ODOoIRQSsbv8yOgPXrrp+gr6eoCQg6oxSq7CKFTEp?=
 =?iso-8859-1?Q?gAHo8nO3Cx5IS6oMfYGCoRYu79uYoBVhv9Q4ykP/9HpkSGZ3k3gfiBQAjj?=
 =?iso-8859-1?Q?/VJncBYLfGukPkdLQxi/S1zqox/IMcw7A9muxWL91OVixjtWSXfqW4UwG3?=
 =?iso-8859-1?Q?Kc3AsUCdwZYmEVNWgyNHch0ZPlve1aShDj0W1wFbWhenLonw7lnmsHKcPg?=
 =?iso-8859-1?Q?jjakAkOA/RYpiwFzJLop2yz99AFPJQtm5R?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd65aa50-6eb8-46c6-5b3d-08de26b3b49e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 15:04:00.6211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogyyXliqzHO5SlaDqFPlQn0rrREejzzQunniW384HWt7oYERMc7pvfYZqwJYzjcvYLGrsivQxa1JlovI2GKnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEyMSBTYWx0ZWRfX3/ktzWopZpnO
 /ULgeYbzS74IYBmY9IbGkj4ihHz8AKMUDeRuLF3ER2SCActCUNuuLj68GD/Q7IbMbhSA0h3PPyt
 xg4GiUOBurAd4+n5T8G41i8YzyV5UnkG2XYioTEvWxFwz4jrUSsbGbMYiyzjk4JHEU0pxlss6ne
 PlHM16mPcYSS7wvGjV5gS0Gff67nLHfyZyVMsw/vsAslwEz6UBwLihFPeNWXS3I1wRqPB/vcmq5
 dsc7ja1VyxSRoRPy8N+H1PTrCy8jLVMUpiOVTo0vSSiPiWGzM2XZQ5cC6noF+fFLFFpKaY1C3Td
 d7TGNV+FH5KXJZshJZt4rIfxGut+5BnvuEpewfu6BXu6ZbzmIJ/E1hK0CPbUIbBb2ZwfDkLMIcq
 LyNwZsh/3yU+aqCifmihPdmh8f3hcQ==
X-Proofpoint-GUID: Vwd8yWbpmhB8S03mxYOSuA2iFyByGx1I
X-Proofpoint-ORIG-GUID: Vwd8yWbpmhB8S03mxYOSuA2iFyByGx1I
X-Authority-Analysis: v=2.4 cv=cdXfb3DM c=1 sm=1 tr=0 ts=691c8ae2 cx=c_pps
 a=n37zOek93uUOArlCZH3zig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9U4wm0hQmfE1ZL3QJPsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Nov 18, 2025 at 03:57:56PM +0100, Cédric Le Goater wrote:

> On 11/17/25 16:56, John Levon wrote:
> > This function was unnecessarily difficult to understand due to the
> > separate handling of request and reply messages. Use common code for
> > both where we can.
> 
> It's still difficult to read :) Could we have feedback from Thanos or Mark ?

It is surely better though?

regards
john

