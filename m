Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07511CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f9J-0001qi-K1; Tue, 14 Oct 2025 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8f9G-0001pe-Fd
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:33:06 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8f9B-0000I2-5W
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:33:06 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59E6okER2865322; Tue, 14 Oct 2025 06:32:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/Ft//4W2QHIcojCkNS8aCNznKAob+qMuZQBi6Gzs5
 Fo=; b=QgwKJ3JBtPfbC90q+l/Z3GLBDEe/vhslmiAxkOIYimgJlDwJEN4PVqElA
 IQCdaqphFowF9jdWw04Autmf7MsRlSQhQtg/359gKIcJbynmqW29FEn2vmXEVyvI
 YbC0SUl5FHfmcPoDIhSKuV9o+32WtqPVEdsehvH1icrhWviBdTJ7Cg7bErIqh4Jt
 5VRz0AWC0cRzsYH/uduRFWf6/vzTsOaZZuJzU+5sjHkhwiaZMFfQPtKmgMHdqq3y
 ohooSmDEl1QLH3j9h3FMnZEYusBaT47o1Ck7ylBuSl0n9EDDiZazcpDNNeeQMUOB
 IcadsPAXX63ku/hKrM/dBai2henmw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022103.outbound.protection.outlook.com
 [40.93.195.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49s6b8t6gg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 06:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEhYc5uZGES71vjcb6L7YBQGf7RiTasJCzjNcXn43zyG9lzVlnPY4IgtIgBDS2jtro9A+hawpsDwCr7AfO8Je7uaoKX8HvRDnz66ytb0bjNPC12WDrEWoYl4L9yArQIxjp8Vi/lpeQGSHJM7ozRv12NLG5FJmI4yWEBHWflMzEeIKG7F8HTP3CbAzCn7T1Duvj+Hy2xflVw75vosaLRhLlhHAw0Aymf0m4p8SqjFa/SnjgaTs6K4I67jUxEH6ShZGFNXS4DxxOTk2ARCyhMsdrq7ztWCPLm45FDzSEJsm5bKw1aXnoIdsXQ8rjlOD6I46QdwUbtaWJH2jMs+lcNwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT1ovShQNhMnr6uFFngoXyIfeaHiun9QQwUMCNVznpE=;
 b=siedHI7kJ/Se6Dk5bLFWtlXqvMiACTRKD67tkRbT8y+aLNXZIXkCoUkfN6Nz/mJGLGH2B2KjAP2vNDZZsPqFiTikNSQ2O1OBVzYKgEdpOz5B9r9ArXwu69yFnr/dYnQGbyqTtu9XSr4ldBu98kPzRl10dmgSGsPgIywwKcrB9WaEI8G7EDwI2JMymSrEjwQD6LtSGcpI/BRKDlclp6G3pF1InI4KErdFUmDj5qHy1RabW8CXojx/iEDb6Kea+t09XRjmhWkSVmySWokTS55qk9hPipBcrPH5F1UfqMopjNVZy2pPCRiOh7DxnR71to3MBGWydUhi5jKjzzMNrjG4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT1ovShQNhMnr6uFFngoXyIfeaHiun9QQwUMCNVznpE=;
 b=QGCUlEZtpOxHt0c9Dt6nOAuBLsEJ6ob0ivIIs+46u4dxKOh3Hmvmr8ltiv4qmfgb797hks23C8ni5ZpT+vSn184eAg4Q37irvKpy5bj36W32mf52Ly0rvAQre4qvRIZORnE63pF5wIaVF73GHvi3bPoWnHR/r7KGUtgXfQZl5fC8R3SpkwYtoR60EQK87rlJ8ljsVG7b/e4vQ+zqTK/9d5/aBm8JbO/mqpqRWQISLjTS8ZQ3bS38OYyo+VsZZf7RtJlj/81x+c2K0Y23v+0z12hZkoSY3IaNW7Tg/NSaWhfaPgaXg2p/xCLlgwovHlvYKtORDdCS+IBtHZ+PalgeEA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7940.namprd02.prod.outlook.com (2603:10b6:208:357::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 13:32:52 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 13:32:52 +0000
Date: Tue, 14 Oct 2025 15:32:48 +0200
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 25/28] vfio: add region info cache
Message-ID: <aO5RAIX6WI0MerI-@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0345.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: a6360f98-0afa-49e2-27aa-08de0b262c9e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Apf+6tdOakgPQW6NyrdKBdi7ln5jUs2ov/g+ii+NH6EfJRqEKqoXo/VN88?=
 =?iso-8859-1?Q?9n6PJHJ9wW9oe8d1ziVmQNSpvZHvJACHZt0KqNvQiT2S5CMx34JS/k1PCx?=
 =?iso-8859-1?Q?XotkVYJpi5qpnQX46UMMiplD/TCWfmDx8cSJwcWs3YodUyksYKoeuj299W?=
 =?iso-8859-1?Q?wqR60coJSmFjuZCA6BHaCD3qvsNYZOeyUuSDhxHLzEEysZsOFW3axxkMOi?=
 =?iso-8859-1?Q?qCi262e8ilSMPi7dZ9nNDI0Tg3Pa/5hOCLy+xA48tqjhmrcsGF9MXs7VzW?=
 =?iso-8859-1?Q?1Qsw0Vgr8uFR3QLnNCYF6pPi1qCq34lyGZPDkxSzA4/mkS8YEZ2l9IMqjF?=
 =?iso-8859-1?Q?EByMKh9lyXuoV6/DVFiJ3/3etwXSdwg9P5OyKNLiRWbnF0Xkq9FScKCWCr?=
 =?iso-8859-1?Q?afsKxI2QEOBjOhZ89BDE1VSkPHrhJ5zbwA3iqGujA6oZdO99AXgT+Qfqf4?=
 =?iso-8859-1?Q?vGZF25s3jadiBZ1+KPZUAMFNRtCRPAP9ZWAChZvkJikxTs6SxqbzBDfcis?=
 =?iso-8859-1?Q?iVNwpJKzqEoZgvBh2KeUt1wGwHS/CYlf4F2dgSiqTZarVdCixjIFpv+z9y?=
 =?iso-8859-1?Q?3AodT3Dibpc2Kw0ocFyd/CaorQQ7lrXRbqJijqTSh6fWJGiPAfXSLsAc+G?=
 =?iso-8859-1?Q?ptdZKXvhLvIpwn336iLD8iWpN7a/zcluIeySTdEhxGTi2Ri5tMMHAIM1WA?=
 =?iso-8859-1?Q?x+Kspr7yOyN0xV6C9S6I7RtznDxWbLepkRJI4dUrR+sFzwJQrxduCOjvxc?=
 =?iso-8859-1?Q?/LDWQqF+zvTXHlA/DNyzo0Rsn7qkWf78FEqvwxSFVHvKLVhPJ74UZjHlcW?=
 =?iso-8859-1?Q?s4z7GoVHCY2VwvBSwNNVZ9/qxllNPj6Qgb3Uqh1BovyFM1fvEZ/Iav7YUS?=
 =?iso-8859-1?Q?KPZu1FQZrxWtXaKqhgy+q0Rj8tqXmJ8PqCO/mkQiUKfow9I0r0qr+6VwUy?=
 =?iso-8859-1?Q?3wfmDrmHGU+C9yoREjY46UqqevRwYJnYFF/02xfohX/qanIHuvBY6UI9S8?=
 =?iso-8859-1?Q?rxU4Fk4ZkPSy0t158PTNMl4of6KnjzD/7fw7mKGixL4U3yAjM0tSkOJgB6?=
 =?iso-8859-1?Q?MvtvFJdtqt9/TGEtZEqwltQAsbdYcRkUlm1K4hqMwGWplUKGuq0fVcP4Ue?=
 =?iso-8859-1?Q?3SnyUEDeNnxf+29+gUTgG9jBASwKW1WKQk9D1PyO6aBQ7bkX2/ApCasCnM?=
 =?iso-8859-1?Q?2mLXCI94t0yFRtw9yXgVoLQjhB9QhBCb9+CNYUqmrM+G4GYLbiujAu1Cj3?=
 =?iso-8859-1?Q?fszgW8+k27ONPhUyW7Sl4IN+tNfHaJ9odsDLUkdpVNy8RGu7E5wbek36oA?=
 =?iso-8859-1?Q?w2HV3DdQU50M+o6gZdDttwZ3PtosCc6KbW3u9gBgYeMxYj0V2ZtEvUmXjE?=
 =?iso-8859-1?Q?ZwJbk1bWhERKatMoD4FE5WRit07UqXivUEVgqlty3L8EQvCeqzHewVeuex?=
 =?iso-8859-1?Q?vD5Woin8VHHVZWRDk01Jn9CYkHYlGARguF5KPkSjMSmnBNEcucjb5ZLBcK?=
 =?iso-8859-1?Q?hImDp43bg9U7C0F9Ym5S/F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9NtObRxBvs1REg2OW+12/00MBI2FsHDiBqk0Kh7A3n3tXT+0aSXnPTRq5h?=
 =?iso-8859-1?Q?BhQLzhEFoKQSM46Hwn17IxoNsDQmfNgRhvyrQjpdCaIKyvaLNTlylNVsBF?=
 =?iso-8859-1?Q?MXyGDL2JW43hsNSByl5o8Y7bGyt9zw/dLwwAk4RF6pN/iH/LHmynx8Y0qc?=
 =?iso-8859-1?Q?Wn6OwoaThmMewqwWjay7NlXvq6sdPUKxOHyQvbHKym3T7YsGWaCN73dYR+?=
 =?iso-8859-1?Q?n1vuxUhOMekC4ieR6DtGo977u+mtsQrr+i4ofsBjoR6DUnoOzMK/NcE/7g?=
 =?iso-8859-1?Q?/QfsKg/xxUlKzx3aBmf/mSRdYoGLdiQCXFZqQbF+5R2fSU6ug7PPyfmnnv?=
 =?iso-8859-1?Q?Uj7Tk0pqhL66FCVo9hKkYMUpGyWPdQbAfKRzMkU8I5zZpMommi8uzMuoHb?=
 =?iso-8859-1?Q?ehelZ7xxiEnTKjI6xFxptK20BdnxLAUsdRd8ZyJgvl2zhHFK/AIHXulcbE?=
 =?iso-8859-1?Q?gmTQxGXei1baulVtE4Fwq9Jyx4XyMxG7UfLttGX4wKn8bbE7pwl9EdDT3K?=
 =?iso-8859-1?Q?AAcS/HiA0ENDlvg44hrdmH+qU5o7/oB0JbucJldvwTVx6E3eUTXMWJvHbY?=
 =?iso-8859-1?Q?i50PiwkW7LbKcChWkJBM2i7xaVWagVSpxUxLa8cE98ZXzpgve0dzrBssUz?=
 =?iso-8859-1?Q?15OIpDfXbFLyB9LEx8yNS4Gp+h3bXpLqdO0VWxJfZZfHXhW1zynnE5QCEQ?=
 =?iso-8859-1?Q?NuOyvb8+mG/u5680hSgeQQGfKpxQoonblagDwNKI/v4opuTsJr35+17cG6?=
 =?iso-8859-1?Q?+M9wT46bfj8IHBQCzb0DDJ5ZE3ZzbrqVyvt+Su9Ls+c9itduj84GbQaAiJ?=
 =?iso-8859-1?Q?D9vYqBr5r9mG5KiQ6QRfzUK2BWJzU7c5NHXhyDsmtuKe7d3DAEhL1N9LK7?=
 =?iso-8859-1?Q?KBf8fxIDXjH39TC9whkcIjdiOGrCKon6trvrKrnEwTBGYUfTVji5zXh2GT?=
 =?iso-8859-1?Q?p5sl0hDIkeJjlMt2luP5d7UOqnGdvBQ7MYnpYLY1gyKweuY9BJYoHjECom?=
 =?iso-8859-1?Q?HM6b6TgSuHuP8H7xyhn0aDstr6WwLzHI6ANu+zRsWuwHBaaTOVbCcK+YBh?=
 =?iso-8859-1?Q?WC4cd4eJiddikcwjIiudoRrwuoX27IxcJKUCsGue2IeDeOMMYT4M6hDNg7?=
 =?iso-8859-1?Q?uL8GGLWPkmZPXiPVxgOH3pYsrPdta8CAwWDx1SRX4o3atE/JtO1yuXcTFR?=
 =?iso-8859-1?Q?8KJatNzx54nuEVrGnptguY7aRWlSPzDoUmbrntCPjmeUudiukT1xzOTcPm?=
 =?iso-8859-1?Q?EXVGgi0GiDK1X1NOd6Fy18YteCb1HLacVZJGMuXSPOeZyV4XSGP21FoFne?=
 =?iso-8859-1?Q?KKho/5bILOdQfR7K1hMmbu8ZRgqRKKw+PFMCH2FBK/HrSqNKu8zkvFW3PP?=
 =?iso-8859-1?Q?Uuw+NdCXZxhaDYRckgW1ODCNAcUjixKGfkvvj1V58r2UaQhn8KgLVDkVi6?=
 =?iso-8859-1?Q?S/tdS4eT5ruTGXPcUf/UC3P99LxNwP9NXYauT8HJi0Ehkk9x9KhsoYtpmm?=
 =?iso-8859-1?Q?kTLcugNPftoDEP1EWj/wVs9cV5jTB/fEs27CNA9+fO7HMGfThdpxvPX09q?=
 =?iso-8859-1?Q?o3yq864rE+CD7f5W46mcOvRvYq4ISpyrSokBBnOqSXCxEitXad8FVQjQFK?=
 =?iso-8859-1?Q?jgo1S1z5HsMjyzAe9cPpt/8ZCULIvrAcfI?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6360f98-0afa-49e2-27aa-08de0b262c9e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:32:52.2822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8UgHEZfVqE7qJkBnQSlQYGaou77FZU+W3nTIOBXM3m7njE0RtunqvQRpEOj57rfTPyIWLfP9ds1zciq5jyTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7940
X-Proofpoint-ORIG-GUID: 5JBupy0vuOvAWCZJRZEBfY_QBKQoUIX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEwMyBTYWx0ZWRfX5egxnDD5P18b
 aLtitzuABi19xJEK6XlOUhTxbT+S47nO/LD/3tgivfPcD1axIzbExxVIYC7IK/Yn01cEPjXSzTB
 VKBS9QTN+mn+dgDvwu+WbdCZg5xH79E0QAD6i816G9JHeZjRPECNd3H8qwAeY9jyatTe333r8OM
 HLsovhzzsRjWX2qGSdJ4rugluTLlidyy3PtFBQuWLOwnhVvuIG3+wkXkPNmc9MiOBVLRR4yh9Qn
 sF2gKiO6WR4iwRHdZv5aK2yuNOEzJXEo7YafP16srW8p1WB2tlGY3fER3rTD4+XyEfSHslf4AJI
 HKftM1dXnBGgb3ozUTz7xSmQfHQXKMoaU67OYR5WRZODHsZoqZxHrnoVlySz0AA2qaO2vv0zaJS
 6SuFP0VY1BY7kerIzyGmn8m+2E4zBA==
X-Proofpoint-GUID: 5JBupy0vuOvAWCZJRZEBfY_QBKQoUIX2
X-Authority-Analysis: v=2.4 cv=IIUPywvG c=1 sm=1 tr=0 ts=68ee5106 cx=c_pps
 a=dTL/NSpv458ZJk1fBD1pSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=heK9hM8YoZV0GO3u6scA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 14, 2025 at 03:16:46PM +0200, Cédric Le Goater wrote:

> > +    /* check cache */
> 
> It would be good to add an assert to check the index value. More important
> we need to fix an ugly "index out-of-bounds" bug that can occur when booting
> a VM with a vGPU :
> 
>   -device vfio-pci-nohotplug,host=0000:27:00.4,display=on,ramfb=true ...
> 
> The interesting part is :
> 
>   Thread 1 (Thread 0x7ffff6891ec0 (LWP 11372) "qemu-kvm"):
>   #0  0x000055555581b83d in vfio_region_setup (obj=0x5555588c0b70, vbasedev=0x5555588c1630, region=0x555558a9c040, index=9, name=0x555555de94ba <str.68.llvm> "display") at ../hw/vfio/region.c:199
>   #1  0x00005555558208a4 in vfio_display_region_update (opaque=<optimized out>) at ../hw/vfio/display.c:449
>   #2  0x00005555556bdd6c in graphic_hw_update (con=0x555558acf830) at ../ui/console.c:143
>   #3  vnc_refresh (dcl=0x7fffec048050) at ../ui/vnc.c:3262
>   #4  0x00005555556a15cb in dpy_refresh (s=0x555558acf980) at ../ui/console.c:880
>   #5  gui_update (opaque=0x555558acf980) at ../ui/console.c:90
>   (gdb) p vbasedev->num_regions
>   $9 = 9
> 
> Index 9 is beyond the maximum valid index of the reginfo array :/
> 
> We didn't take into account the ioctl VFIO_DEVICE_QUERY_GFX_PLANE
> which can return region index 9 which is beyond the maximum valid
> index of the reginfo array :/

My apologies - we hit the exact same issue internally, but with a much older
codebase, so I did not realise this could be an upstream problem as well!

We put this down to a bug in the nvidia driver - surely it shouldn't be
reporting fewer regions than are actually in use. So we applied what we thought
to be a gross hack of boundary checking, and not using the region cache in case
it's beyond num_regions.

To put it another way, the header file says:

   217         __u32   num_regions;    /* Max region index + 1 */

If it's not actually the max region index + 1, what are the expected semantics
of this field, or of region indices more generally? We could not find any clear
documentation on the topic other than this comment.

regards
john

