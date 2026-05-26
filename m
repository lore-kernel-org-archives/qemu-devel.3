Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29CCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnRv-0002YU-KM; Tue, 26 May 2026 04:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnRt-0002Xb-EP
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:47:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wRnRr-0007UZ-2y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:47:40 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q8XQiY3083673; Tue, 26 May 2026 01:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=30IMBcWgwPonuVsTYFftrcfRNedF9kok5rZnWS5JB
 uY=; b=2f/uoBHK9t8gLCH6VKe4jny5AI6joYxKcHqQaoHUUs8im5LQkGV7Z8ThF
 T/sAWaW2EOPkRXqP4BqfdvxRPf6Uat8S2TQg80li7UAF3o/wjRLlau/aIsvb6ekr
 Gc0CGYLxy7v31LZmegwH1ivbbBuSEVCg++CvwWi3MPG9+Icj8P2Yzc140v4sYgUL
 vme9YUeaEODSYFEqLtKOSY3d4B8GHHlpBUzk0j4YAu4HEVqai3wXwKL4LrIqIgXT
 GT9I0D/AkJ/oA7K5ubjlm7cpXPezdHHz3otvJuN3YdNToyLxH+JL86yWvnm6Q1Xh
 pWng6iKQsYuDqIgoZJoMQxLa3DCJw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020109.outbound.protection.outlook.com [52.101.56.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ebbs0e4t3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 May 2026 01:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htoDjqFHy9oiFJ8Dmm/+S4kNL/DhP3+t0yZe2tu5JC6bQFBHgWdKx62QVvdqAi7V8rks+NPPGYhxMlMC+CyYTcVQLjzX9smfdmnQ3x3Wz8hivPK9ZnW+WoxQ9t/ZEb/N1DanmghyHQdVaB7D0hld8RjTPCqgTGO8wMh9K0CTb/zQZW+kDf8FbFxd3gHW6ghRVriucW+WqkKaWNNiA6nMVyAx32yOhj98jSunJWYiUKC4lJK48m8yczo99i+6MmmIMSb4tvHcBdfcep8Q+QbGrH+1nfOePl3Wak3dRaddHqXHtCbaCjzqDbowD2tyKmthEjQN53nUh87kw0NC9dH/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKgG0jWEFR8EpyuQuXZPXRe40XBQdfjH23/3dbN8FLA=;
 b=Pgon4AzVx3CdHbZG5E7RqpCVka7q5K4guQqLgSauZa82nJ4bbZ6XlOX4BjTxH9/xMPvGAzelAui+JRxWeUA0Y/rs6gAx1RDiMNJhLCHypnbd2vpi1vL3zwoASQGGC2eykY8RaZSx98EakYdcQz8lKiT7Yj6BkrDwWC8Y1YyO6G9w+Qn4EkyMHcxdQxtjd1ZfjYmVqMRnloHrngjmEbKATO+CL6Ye9zB7H0HWzCTUXxrqSmt4yRI1DL+j/INqrBMykLjVzR1VHDykVPk7thDn+E12BZ8s0+5W7wOWVWI1OpDdnDPSmp+zgQMnI/6lD5KLYnGd7IWqZXnHs9rdsLp1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKgG0jWEFR8EpyuQuXZPXRe40XBQdfjH23/3dbN8FLA=;
 b=pAcnZxPuKMZnho3wF72wo4vJKOET7ySV1txnLXN4H/QySYAjj0wBbWe6RE+nA8H0+cFSjrhKuwQiAQpdDdjsFB2859A5PnhHhAS4hX/kmIC0Z9Jb7ob6PFHMgNwaiENggdPJ8TcLBH6Lvf3oNsQxZ5xJFJr7QLht37z1EzYLUdlOoxVs2z/5GSsWzZZ/+IvXq7KpmDlcAGL2p0w3t3SmHsmBKBv2KvFC2t9qllmPrSjRbdHgqqt16k+1QjFeCYaZG6vgRmryfI9ulzsPiV8VbHKp52MoaFPhtxaC0V1/7tpNxNervNfs64PBsccb8QtXp0Uv2ZlE+SkQI9WvgQtrRw==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by SA2PR02MB7659.namprd02.prod.outlook.com (2603:10b6:806:141::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:47:32 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 08:47:32 +0000
Date: Tue, 26 May 2026 09:47:28 +0100
From: John Levon <john.levon@nutanix.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] hw/vfio-user: use a valid object ID for iothread
Message-ID: <ahVeIJvRjTnRZ2vr@lent>
References: <20260520082459.1132051-2-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520082459.1132051-2-berrange@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO6P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::11) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|SA2PR02MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 7156f14b-5323-4c20-5764-08debb036d25
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: z2AWfasljk9+NZiTJy34XgPd2Xa/wAbLAnkNhCJ5ijlBn61PuH6yYWgkiKi6e0VXz/g/Wq7QUAz9N3TFH1IWaGG8Pzhnl+1AJPjHGiqy1d1/ybgIXDD2NzGFDp5fuUAfHhLygeLuJ9n9vihzJnQBHcEjWDWsbhI6Eiw9zsyLJekoepf/ryhOVWnPJuUuqduGtg2r6YmbczhLgpI0oyMU8DwRkaSivGfL6tau+3Bj3MikKl+X4qE2Kz00xxWytS5mxQ5Z8+Ea2yuKgpoqaER3Uy6xxvTHMSkfm+SEtPEEmO+8pAMTsUNfW3J5iWmeYmgu1u/efj+P7n+ZOR9VXKawZCpAQ1eMKCLEKob/qjuf8NPvCpojAtfttURJJUDMYifofhlBahgmeBJv5AAuIAeRJvYLJJRvUxpWIRHrp7nqGsw2IrMfp4/rKfmyj1I4awaGXMG5g7fOHyKaia32/W14+UnoFitp3ba8w9s6e7OJ++7rJeUutuErcOzAZ4Hpwy8Al+9oJFuvFnUpMGkVAK9mM5qILcIKlsuItX48ALA4eStqpvpbXi6Vy1+giZqhs4KFuI8CZLKZVexaLhEGA/jy+II0gzzYXGJGv71KqgMP1saSHRgJsj1+GxvP/Scz506571euToWwvPnsJ0YqQiaod0RQMiDR3Sm5TkHmGBWF1GlLFdHFzolst975cq/IbCag
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Hh1UHax5qoOvCoMxoah4MRPd627/8enK2TDRb6sBM5BVZBcPdBoPCZyG3w?=
 =?iso-8859-1?Q?n3jmlQj0mcuy4ZnV98ykeoxZ4EnyYXaJGCYthyD4KNyfP+q7okOAamSa9w?=
 =?iso-8859-1?Q?CL7I5QPP47yVynWEjXXqdw2MlALXwt0ag7FLYqv/iOpHlyfcmUbx7aVQ6r?=
 =?iso-8859-1?Q?rfayY4i/RqVz/tJ8ZfUn2hq90C2ooiaFayeXbaddXqPgyVu2igfOphwqNI?=
 =?iso-8859-1?Q?5pd6X1L9IzjQ+gPDRpFiFj+6VWAAMivRQMyUpHwXjeupj5LwanZ50WSepX?=
 =?iso-8859-1?Q?mPzIisF7ZJBF3w13PT9udM47RQLoQPSVxSB4FpP4rWiw+3wEqrUPMjrvs2?=
 =?iso-8859-1?Q?WbrI1aBZZkl8OXwmG9ylBu5/XZaVH/ZiZXsQaMZomCI7ZHG0Q95kpnme/q?=
 =?iso-8859-1?Q?LbPCFmlbxos86DEtcGub3GcNBlmyP4vHGvGfrv4sNkkMJW3/Z4febnun0b?=
 =?iso-8859-1?Q?Mm/iRtbY26+WASGArrSqxSMvUHXperoPHFsJk/qnYKEaZu/4sy2PsiP1SD?=
 =?iso-8859-1?Q?QQ6Pj+Fu6dfS1wTGco41a1bBdLgezDPf3gqMofPMbTdWsLSmgmjVRdK06v?=
 =?iso-8859-1?Q?7gS+PcDajnGUysLKamgoIwOr8mrYduKlmdJduUPmEouz7wFgt0QeA065cF?=
 =?iso-8859-1?Q?WSalHeBuwNRdpi9Qr/V7bBcjk0hdu4GJpawsUvahJRJa4O+GpY1t2H4bb6?=
 =?iso-8859-1?Q?HSP1788+c/OP4/SEmImi0hx4OcI/DN7VUFBP6PZlYoF+PWp7G7MUkK8DOR?=
 =?iso-8859-1?Q?9zMtekYm/3AmMuBC6kcyg1csXeaBYrDZtsASjMUROaWVTBnpOKBz0cUlHv?=
 =?iso-8859-1?Q?f36eIfI5MoqK56N4O0upXFDaWikQeqXyudDwSNHy5VIRnqgc9C0+pZzvB9?=
 =?iso-8859-1?Q?lO0n7QiZpqbFuh1pAX49jHTIbz3A5rBwbAwARyLU+wevDUWLxGHgAig29Z?=
 =?iso-8859-1?Q?buTda/1ZY7nraWoUnuH23sxI+GgG/qJNH6e6se82jpuv7/hMsZEeyGrHmi?=
 =?iso-8859-1?Q?Na/cPft9ymH0w0DTNaA0dHIcXzJje3miKlSGHygjgaVecCwpj6SGebpZbm?=
 =?iso-8859-1?Q?0eriCru1sg+jJRkDsfSRIlbC7ricKM6S5QF50hRG6JNRmKty11LKdHNM4d?=
 =?iso-8859-1?Q?0smap4DFc+YYdO//MvRxZOBAdVqRX+TW58v2zjEHRkNPh9wvBHjr5BgISJ?=
 =?iso-8859-1?Q?gn5AEVYOv62Ke0HsXEplyJj6OO5uVN9azX3ODZJF/aImsb+EyuNfI6T7xj?=
 =?iso-8859-1?Q?ZYn5PqGI/wy8D9fmS6neVYtGppTkaOsPrmOlvGNIrzNxEHNgN9rlsMYtHs?=
 =?iso-8859-1?Q?WcFr7+pwePUhPrcCpbW6q2uT/Nrv9BfQXtcBp2B+z61hc4yNF9RWw2CH30?=
 =?iso-8859-1?Q?MFDhW1t2rs4xqEFW0jOz1jBJmBRhucZlNZpIGTquQ2Tv04qlk8GZhUgi5w?=
 =?iso-8859-1?Q?0F4m5HXBkbK2S9VNjxj44nTm5+5sqd8jYOVnsg+O2hcQOqXDaAFSVq34Ea?=
 =?iso-8859-1?Q?SP9qBp8ojpNzs4OnMCFcx6AmJVYVfsSItXL2Zp7s8+SmZ+6k03/hfNK+kY?=
 =?iso-8859-1?Q?SJrvr6uDa7u7db8CF86TLADTUG2yJ3njDKgqfvJ0z6WQ8/zV6McgRbxhAB?=
 =?iso-8859-1?Q?er8z6c3JNlVL2OU262xzVz/L3WTFkmL2NkiT3pT16Tm+nGUPOcO8qprO3f?=
 =?iso-8859-1?Q?EsugaFXw9d+etahpPoozB/rlYT01tzAFLBLrjnyU5TtxiMIf/XfKUUJkdo?=
 =?iso-8859-1?Q?ADJUjAzxm7J9VBnFYIjhnH1b/ZFYgs3bRfgzkDucOx5cLXz1y/j3vZBvmM?=
 =?iso-8859-1?Q?W5NH6kP2+w=3D=3D?=
X-Exchange-RoutingPolicyChecked: MinVoWjWLFKEkKZyMWnHVKi4gKkyMM7pZIzyHmu0L8q/WL52hqowWoHReZDHZXcYG+RRSO9e/CARadV59BwWZRpXklkQT4sR6P9DFh98IaKxq+Usw46Ih7rlgd7uFooU7Br8lXrOmZaTldRmoRQP08gLmiI7+euhp7PE77jh4DzTUkLNfcxvvGLf4zReiM5DI/EgWpOQy2HFBvqb0rfWsDBo4qV1fYuqySPs6i4Cn67NTpX1+iZX3fW1G1SXAZii0dOmicpXF3GscSJ5kPuz+HQPknapXvrbc2TcUu5tlXDvG6zDWOT9ow47JLiW0iK6UB5NIugqAzXDnCM2g7qrKQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7156f14b-5323-4c20-5764-08debb036d25
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:47:32.5060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dhxb7kR0/KRQcDmrY+tkvec6SGmo+xXftgI7Av1IbW341xs2PwWJl16eTv98R8LA0SXEogEqw7LIhX6JYUHcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7659
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA3NiBTYWx0ZWRfX8YWExcp6Z4EW
 i51DETTuhN3fRC+6qWLuySvX4P7iBWUizn6EbcwWWYq+RYR4gatT+/1Y6VGDmTkC1qPu53Qqi2h
 h7OzorSg96wLzU+5fwo2msG9rJs7Nf7hdbiQB20xYbrNQpwnH5u5ULpz756Ak35pTg+zSwr95cJ
 bIrn9iRKymdcKKeLZ8/Wp4ok7KcT5tRb6iBYueGL2XeC/33zZts6oYqBRuuwoZ8Ajo+EoG3KtIb
 Q39Qlxr9/ooVEziWZxdqtJ7o69sy1Y34hciEVU3udl0Ym8fLu7f1WkZneRR03YBKhKPewwIcLdY
 qr+BstEukGWD2nGd5HPFCuuCR2RnmUtQXUI2XhB6fK8xzKblmv1vN1K0b+AofjGGkA/82mXg5yR
 CT4oM5Pe5N38dtrSsUQQwBnuNrbzrepKTxAk2nOmyrYKB2/yfQxRUuxBVG18zIjvNqpOyWsZ9Vf
 pLvnl7fYp1KofHg0hug==
X-Proofpoint-GUID: I6H1secdaJ0bz5oXgbX0zibg44oBS0p6
X-Proofpoint-ORIG-GUID: I6H1secdaJ0bz5oXgbX0zibg44oBS0p6
X-Authority-Analysis: v=2.4 cv=dOaWXuZb c=1 sm=1 tr=0 ts=6a155e26 cx=c_pps
 a=hjBpXxoQfMlz7yq7ll+NbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=KTpRurGQpwpl3fXeA6gA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, May 20, 2026 at 09:25:00AM +0100, Daniel P. Berrangé wrote:

> The objectg_new_with_propv/props methods failed to validate that the
> QOM "id" was well formed. This allowed the vfio-user code to use an
> invalid ID of "VFIO user" (space is not permitted) in its internal
> code.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/vfio-user/proxy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 314dfd23d8..3d0d72e8b7 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -933,7 +933,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
>      qemu_cond_init(&proxy->close_cv);
>  
>      if (vfio_user_iothread == NULL) {
> -        vfio_user_iothread = iothread_create("VFIO user", errp);
> +        vfio_user_iothread = iothread_create("vfio-user", errp);
>      }
>  
>      proxy->ctx = iothread_get_aio_context(vfio_user_iothread);

Reviewed-by: John Levon <john.levon@nutanix.com>

