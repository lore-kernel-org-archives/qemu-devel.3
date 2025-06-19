Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAB3C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNf-0004Fv-CE; Thu, 19 Jun 2025 09:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNc-0004EN-JD
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNY-0008EA-Ds
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:36 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8A060013187;
 Thu, 19 Jun 2025 06:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4AQW+C846BaFh6JO8Nd5ChXiGKBzGo/8yVp2/T7vq
 Zo=; b=qaxMPtX5yIwKdTVdMlsQaVhFK86IAryt6wHa27oJomp8dEGNN/5j2HDG6
 UcbYANZwO0bTeY8ekhw/+bZgA2QmxZEAfEaO9JYNg43W1uqoUtZ8PmdxGsx+n4Pg
 1esrkfus9p1lC0iMAJTCMPI4DYnIZosCM05bdHs9ie7aq/RdysS5mxPtL2gKocwU
 inb1HaB4tmBp5IFPaF/YYyqWiQl+thCCP5+uMwDxF3arvm6fPy/rdHz0EgxyW9tj
 7Vzde/os4iOjAp9vtSuNqjSZ3nBIbC/Ffe01gAMkooVkmAcQ2tf3tooWQVZlBbrt
 fVxDxZDSGq2QEejDsulxRrX/X/Njg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020121.outbound.protection.outlook.com [52.101.85.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mykwq7-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOQrjuS/DYEmJrZ6OYd6W9tzwb4WKahg0FAS1tuQNJs0u6t1NJPftsBL/YVvATmZu/6CH3Yd52fE4PyODJydg0dEfkoLUovUYsWEw7zBTxjud4sDjHlrutQNF/RtP+zLddDB1dZqwaMhgQZaHrgD2RlkBmuTAiO3IFoe9fSvOTU1jNTvl1+pRYA9ApGXMNt0rENIRu+Egqnlqf4TSBz3tfLQoyqI/Zkj0S9UJuo0MdckwLlm3KxoG/wPv2aR/flo5v/aRUJ3S6lldU1qhamZiUXdSmxa55pCXM5jU17mReX23F+cOxvPD9tTFWt+JuK1S7mkvrg8HoVhvz7SSsSu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AQW+C846BaFh6JO8Nd5ChXiGKBzGo/8yVp2/T7vqZo=;
 b=XOGOdHUnNWA+J/9P0lkaiwTkVx8mfSI2P4AxRrqhQsXofItpTEEkmdxAcc4fNgUSqCIbdV3Rc+HqiTE3MR7yjgyitucTmc7FnFLL1haWcqLjeh26RXygpJt+G+hh6vOTit70uO3YuAwrGh7XYvQR8HN/x/GGQKXplzJT8KWEsWt49wyF7RW4D5XWHCROP077Iey5f+5LI7pz0MaYbsT477YHtMoEsr0cmwGpo9mx3XjJyMRnIGDWOGR2J2Qi20b5boBxnqVVZHQFLmMOpdQYjegE/sq2g3dzMGAAUwywQJUX42vnqOCXpvJZIK9wfXLLd4gtz1n58GVLBcOLG1Gyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AQW+C846BaFh6JO8Nd5ChXiGKBzGo/8yVp2/T7vqZo=;
 b=xRJ2qbQMOKsDfCB2jtewnTwtaItUGj7Lym4O1UM2Fn6hXGPkyB3ENqW4pJHtQx/TMgV85CZ6R/EadexsDbE9q6Vya6Ga6YjUVVHORfJK/5SMUN4IHjWgZ9YXvTd1kigLFzhSFtsOdBBEvH29baED7/pS0lwI4EhQCWpDEKctxHr+3uGrEhafHvLyASgzlkCiQIydfqQaUF7LkC9lpb5zbE8gO1Ha4B5+4ipup47MdLHkHnrnmnmsfFxqtNkIFEbS5ewe2d1Z4RvY4BkyF2RHgMy2XzcRlpc5bJUE1OETTYIaLIdM3l5EbbNlk9dhDRKmAFRxphzpwrMCxxEbWQKZ/g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:21 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:21 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 09/19] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Thu, 19 Jun 2025 06:31:43 -0700
Message-ID: <20250619133154.264786-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edbee53-830f-4785-2f61-08ddaf35b819
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+J0iMblJs7+wjYuqBIRFTPs9lMZtl8gbrG7iisqgk27s4AwVVASkysIzCqLe?=
 =?us-ascii?Q?mjHFyA1RhhQ/pqGG+PXjhzNQOsuIFMZtPnnBqfo/w7u3cHaNFgEd+tfj+YIp?=
 =?us-ascii?Q?o17ilyLZhiNC48r+dNvf38iviTICHefSlSGY+HIhui6y9kbQehtPtZ7rF6qi?=
 =?us-ascii?Q?7T2oYhFj4h/mTQ+YG8Cnc37DQAhDdC1GU48AF4IamSnczcK7r7T/dexqewBy?=
 =?us-ascii?Q?1rIwY+Ea37w8b65ScOmuhdejoZxaZi7xurwO8tj+dH1waj/BSiLjt6w7Eg1m?=
 =?us-ascii?Q?1mRw1m9eIyzHhFEDQ73IwwuKeqlrNtLBeVifDKkL2ajEzNy9Ti4zu6XdLiVb?=
 =?us-ascii?Q?cwHhp3ZjiSfjdPNk1iO5ylB0LA71vGO2/H380gGigkyX0bvSi+enhsNKSu1z?=
 =?us-ascii?Q?/ZuYQvRlPq32tf3Vh4xIHeW0gvi33ejP3r3D+tXfPl4bf3mxcKevGcSntqwg?=
 =?us-ascii?Q?9X7UofMeUcj8dowM9HaK1HaZgYgd35xb5EWRR6PPFKjubSksfor2b2WfBUPi?=
 =?us-ascii?Q?A0RMUnrdc1NYxTv1R0IL1zjf9s7YWQHOUO5NDOAknqYNgSmLpNYO8Lcr/kB2?=
 =?us-ascii?Q?ZpjKAkfuWXoXwDl7RzzekIJkTH63uraK4zQ8WDAfkfqsUHpSaruddggjR+XJ?=
 =?us-ascii?Q?CQDUQfNT8WfdChrDSjR13t8DBzQh3C8A1d/4KPacIh5N6SCLs/VtvMTRx/hv?=
 =?us-ascii?Q?GglgaBeHHejLJ7DqciTgoneKhmRoENPhdN+R3a2XFeO/t18rs7B4NZppS77q?=
 =?us-ascii?Q?pko+kyEHQvUkw8rnMvCpNITCW4qXiWo8Yb8EAmm9tVD/DvEqwlSWYj3vLuem?=
 =?us-ascii?Q?xesK2FhOcniWPL4nKsIqITS/oedsBBjmYusppKeiMo1FQpkC5QgR6+Z8lQOf?=
 =?us-ascii?Q?ykYswxxe1WEnl3H6TybOgRCpFPQG3zau6vRbUi21vUld5a9pUUla88+t4gHi?=
 =?us-ascii?Q?846nw8lYVo+xnJaeEr+8k/pokqSWrkxVxZd7FOsKR5bk5iIq8MHtdZ3SW/YI?=
 =?us-ascii?Q?PFcPIUo+O+Y9E5n6GUgf/59dHryCrEzCWqkxbz+s9rz+e7g3uz49h5AjDeOe?=
 =?us-ascii?Q?iVFBAoPT1J6JlBbCzTRDgV/R3TpBO9CgYVMfPkZihKYHeIHx1csQDj39cABH?=
 =?us-ascii?Q?C3rRXibPgIaNKdB/ZKniVhJ4B6jnypIjyimr7+bWtI+CjRiZc4RiVWvhndYf?=
 =?us-ascii?Q?VaiIMLDmbOlj0TRTdTUpKCOZu5yd0pSRUe/kTr2hYufnnmJtoEcMFmGdargA?=
 =?us-ascii?Q?oeSbBuBiaJT6n1bIOuSHzdWu2SurmLN7SWdQwmKcKjuaBfq/Vo5HDDjSncuO?=
 =?us-ascii?Q?qC9qw0uC0bqbF5kcvvd5uyEjZVppr/xuODtZEH3fYtynHVOTNIQAFs5Ir5ub?=
 =?us-ascii?Q?97LqFsEDfa9Bdiw2P2z84EJ/ePVkzm5uv17LjBIuyPozFFXzMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZjTWx1vVQY/sJucakdQipQi4lTxBUM4e7Wu6s6OfeTGpiaeRJEX0pQl3nNQ?=
 =?us-ascii?Q?3VnLeLit8JtJf8RiPTb/MBtL9wxqJNIwDMm9jM1UeDAmy9gemku5IFSzfilz?=
 =?us-ascii?Q?/cZ2Zt6N1R1IrClZV4Ljq/q6HWC8z19vm4luhOCJMRowikdVIASbk3MDYS/d?=
 =?us-ascii?Q?RRrf8Jl+DlgzWYdoJuMr9HB0zxolBjTmjzurN3kFD07ssKSWpFiQJ2PXIuYK?=
 =?us-ascii?Q?cp9ydKrPkrbVR70sD8fMyc/SfVSn3Q+z2ATqslNfwTPVQ7W3k2X0hOVa4+Y6?=
 =?us-ascii?Q?DFWigvfhMPIArVJj0epn5yvIXezgRj7JUgWTeJ/sTz+30uM/k45pbmpDWT/+?=
 =?us-ascii?Q?21bw+AYC1Timcl48q1bbNaGeBb4ncwbTfIxNkFhshzWkjawYtenuSuJwM4vO?=
 =?us-ascii?Q?jjhdhPXWvC9htZqPb91mvH2t+w6m68c4tVbg5DhhdiLR6GHkZozSz2B43cAd?=
 =?us-ascii?Q?dtpeo6dyxwYTqmayhGI5JFZPsMfbllDlvYFLSGklsuL+QqmHcezOiO9OL1y2?=
 =?us-ascii?Q?3DzCgUEylq7/veecnX49wuxiMr2aJ6Al5NMMHR5ttWlxPDH3y7WZVightCkW?=
 =?us-ascii?Q?P/h7nSmDvSXYtc2OcsqbL70Nd/uy9k2l2e6WGmdkYYg+21E6ItvMzQHFwQ/F?=
 =?us-ascii?Q?L1K0Q7anti6CAwnJPfCwrN1qZP/2EQZJF3Y7r0qNhZ/YR9YRTtthfDFvo0O1?=
 =?us-ascii?Q?bl0kHC93K2nyoh/W3AH9pGvz3MZzIbDONl+nfE6Cu2iZF6ruIM+zC6+qieOc?=
 =?us-ascii?Q?5z1AK1fkTMwFaziScz56YMFdUmzfM2OjefRrn+gdzJF/WELLmnML6ZkitDWc?=
 =?us-ascii?Q?7o5UGtEKJokvLl7yaA2gJyvKpAtlw0QTjf3/Y5GoJx/xIO4XPv7jU9bAJUiV?=
 =?us-ascii?Q?pi60uADnwBugAObMlcxcCVwGdQxiMRE/DdxxS3+5nTZwnRbD6u2iiNvyyzM8?=
 =?us-ascii?Q?eKBL68KotN1fkKdQEVHtz4YGuBxD9MPlaRx8qhO49IOc+pgc2t99+v53OjSB?=
 =?us-ascii?Q?F9wld0w75pT//0uuwrojKND1JS6t4KNeVPhfe+c+tD0dPpKc83EfWAfAEOSG?=
 =?us-ascii?Q?Wnl72PjBfrVZX8nazDBkPQQJ7yp7A//61tzJCLLJPhBE3zKTpWQnIp8SLlwg?=
 =?us-ascii?Q?fddckyW+H1mSdpIoB2vqqB0P5S4kRosyQ0oWTcEr3I6oifpF3qjEAEwgfd5j?=
 =?us-ascii?Q?vNrjjakSPZx6zlbPJSJwS4OA0aCcVCikcx4ulDWO4QAYBbHTCaCd5xrvql4A?=
 =?us-ascii?Q?1qIb9DoJk3+MCJ0cO1C909XctNs0hLFFpNbtew+EQR/BrZDvL6zCqJXuQ1NE?=
 =?us-ascii?Q?PDgl/iu6P/t3NwmzzNeCnSO1j/jCmFRGBmINCdeZhidfmELW7UWJ0mBGh53i?=
 =?us-ascii?Q?dIHKPrzbrtgctdHftxveh8Cpko14+pBI09wDUVQviWVPaTxBukT3w+vaEtfc?=
 =?us-ascii?Q?Lp9e9E3QI/I08b7Tn/kouYAkNqCX+xKa9YnzkuN/hXcmlwdj8kbTl868AVXf?=
 =?us-ascii?Q?7R0sE+WpuvTZ/h2layzsfo3quAkb0NFdZy0qY602lkAQOa/gWC2xR5z/Z5QX?=
 =?us-ascii?Q?8TuUxYNynZYFAQcJqI3qrRaGW3ZZNGgU1zJsGvlO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edbee53-830f-4785-2f61-08ddaf35b819
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:21.6574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygSVBqnAP+jUXht74H9RoKqo+ODoXMfJQn65hQpJ9w5VA4Yp9EWHw9CFGWhSZCkK1k/mWM5g3h47QBWiT+wZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMiBTYWx0ZWRfX9DzDdi5g2EYl
 b33tdWc4USNGSFU9UmIkl3cX+uUh1XFDcR1t6H0qjPYibAoXBTU4Zea/o+Gg/NMMsgLGFl/hWxW
 2HJJozIBH1d8pdWLu6UvQmr0djUm0fd79b3ClL6gwuDRyEyXm/TgnhrR/GT/8XgR/9vt554Zbky
 9Li1x7kb+sEoj8ryo78rtONsEmAFsQJJsTqrVsWNwfLps1CeKgerhkLXIEPUBuikbGCHUzAtCbB
 u3aqpjcaXbvo+Z/0p1ucg+NRBx9tCa5w+wS7DcLUDNc1MO471iXqwuQ11z+k9PtBZo3DdEeH3Yv
 BApEa7kEAH6SRq+sExN0/YWv8/luJTLDLc6oUKr1bzxL1VdTKL+hOn9mDGR8zMCwGE9ARGmHUM7
 kGxdAjB1xqWmU5HBL+8YqwtHqXjGfklfRJW3iNkVcNGc0OV/ZF+VwJk15yli5FKYCSSJHw2S
X-Proofpoint-ORIG-GUID: eMalymKn7My15u6YCjJx2GErlUOH88N5
X-Proofpoint-GUID: eMalymKn7My15u6YCjJx2GErlUOH88N5
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6854116d cx=c_pps
 a=Yi5XoY1Pvk1/bV4Hj+lk7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=03k_OfxykpieI8sgW_IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  25 ++++++++
 hw/vfio-user/device.c     | 121 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 148 insertions(+)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 0cd32ad71a..48144b2c33 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -138,6 +138,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 8ec5aba632..0d7ed9c5ba 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -108,6 +108,125 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_device_io_get_irq_info(VFIODevice *vbasedev,
+                                            struct vfio_irq_info *info)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_device_io_set_irqs(VFIODevice *vbasedev,
+                                        struct vfio_irq_set *irq)
+{
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                            off_t off, uint32_t count,
                                            void *data)
@@ -177,6 +296,8 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
     .get_region_info = vfio_user_device_io_get_region_info,
+    .get_irq_info = vfio_user_device_io_get_irq_info,
+    .set_irqs = vfio_user_device_io_set_irqs,
     .region_read = vfio_user_device_io_region_read,
     .region_write = vfio_user_device_io_region_write,
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 3f5aebe7ac..053f5932eb 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.43.0


