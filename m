Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F104AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOX8-0003j0-DE; Tue, 20 May 2025 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX5-0003bz-IS
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOX2-0002kf-Fp
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:30 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCUIcA006673;
 Tue, 20 May 2025 08:05:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOy
 n4=; b=mZKftc2xhtgWsw0Y4KY/aFYU6p5z8govRbwFVcKavTY2occ1/Pi68dUqo
 /+ujAASLr7v7W00wpzur2zABBUpwJ+WazNaEI3YQfbKblIgaq1aNovm3X4L8UO0y
 X+ccRTAV3hs7z0OB3V4mryS144SSgLyLTM7RE31iU+yJZbOnPZPOlkTjvzOtD+IE
 RzU+zavli14VOgWB8VQOS3W4C6FnvAa030cniQ9BOCkKrCWvz5ZeHOMN/5VZglRg
 nSZJ15fqITZirzmD/ZJgYwYMUN1r+mBpMwKQjS94eoFec0aTY4tzTd1ZZiJdJRM/
 2NIwxWN2zRHBI81zayaO5vF5Y595w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46ppsuehk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ/6SvI60ABQWQ2po71vwgzfu7gLP9yhBNoV6+DoEuYOWbmeskD5EMbjE0ZJisuUtung6+7T9JdToXPF/6vIXltVl09p2pO4k3+9kl7cr3xbWf7+sH7fSoPyBdhFofbMMzItfm2F3Y7Vy52oKcBt5CK5skHxJZGa4/N9+4It5eIH2YddIq/DN4tmjYsxo3U4CimF2zS8GdoVwO3dRi11Sr5Z0oTfYKr2SqYwG9geg2rVsZlZvh2vrvOtW7gD6+wB03ZdD4uaOBCZC2cMvRWoZK9gRKkyB+jxdWf9qEtUVICKewMHddAZQtDPv9bqbcJRNqAoaEVPwGUL05bIOMxg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=Q2A4bQ9rj2Q6vS/FnjYs9use9L0D4fLvcnEURlPSEeonVvOaaCyWaCLE+4J8sCzczRj0TrhamOuGRMnNAZX0hD6g3Yq84y6vSYeshzZ3k4ENwKFK48oIgJw3yjEteGpsWzb741C0vP0Najw89ippXAlhN69q+VhUxsx7VwPEiOu7Tn3N3pZQMWJV2gt3qpcA8gRwrSwWELPK6qe7rZ2sM4HO8UbBaxHmwbs600olE5IJBd30YNICTwHIyUn9ITp0c91Eery5keLTMr+NkaBUO//DUcI5trXDzSvg0ULIjRn1HUdLhIYpwCL1clEZyGxMs5vXPSix1dlnjyu3Rq2Uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le0NKHZtXWjCySeTO7S61i/syVWzvme3vUpWwRiOyn4=;
 b=nYl3pKWp7RBB92N8Mx15EKHxB/GFU5g+d2GkEwmLsx3XsYlS3ZlstLGviisWS9r9yqalyEoZo47y+3lhbEmDu9McWEUjP6S25o5Hu5/MheItdNActAG53N7Vi8bufQgVLcTI2vyIQeYgzbU+JBhxuojQ/+UNLbesEDj7JdrTuz8Szg9+VGgpF8PsU1NKkOOvfozWE/GS6/Hau31956nV1c84K7bOHSHurszbqAmnOn7x/fWNlVvohkhULzfJORj9YibaLPGJ5wSFkEmUboNoBA53FfjfqCFPdzxLXoieNZLNGbZp8T/T7bR5Z+EHEFS0STGCUx5ZW1AvnJ49x35uCA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8582.namprd02.prod.outlook.com (2603:10b6:510:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 22/29] vfio-user: set up container access to the proxy
Date: Tue, 20 May 2025 16:04:11 +0100
Message-ID: <20250520150419.2172078-23-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: b62c074e-4e02-4ea3-069f-08dd97afbd03
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y1BaM9sf2D1PtsQRdYBtlb04ab8OFmMVBKtHK8iqgZeUMa3d7nEcTZL+WDlZ?=
 =?us-ascii?Q?44JNNorrAPsZzPHuTlFDAGNdgY+PrBG0ecBKSsg/CejiU5muZpil2Ceb/SKr?=
 =?us-ascii?Q?bKf7kXbBmVFNmYEHzZCltDMTt0vcl3IMUCAwR4mVUs6Yjjmo+kzMnBvKZ1+a?=
 =?us-ascii?Q?WdaWEnneSKPUbfrJnWk5QKGLhjsaAIGNaV8Gk/UcTHzUli6sZnUn5xT01WaG?=
 =?us-ascii?Q?yzee/OmZZKdjbd6NZoWpTlvx6OUIGfh7BEjZFDlk4Cvf5YIGZrOmtqjG23+X?=
 =?us-ascii?Q?t6QpfSoADOtbwIFhcyx00Lwvtuq0SXRI8uBvy0bmyKgXHDDPcFPXHuJWGYQs?=
 =?us-ascii?Q?pxXvjaTM5jfbMERuQC/neBSNurxnSas9b1ouP7Iv3VVljC2HLuIiH6fjp2Bb?=
 =?us-ascii?Q?lmwGd6DuvP0dAXF19B7rdgUv9ozgpcXvAwY2MUA7OjqyNsR9ly7b2ZqIzyPH?=
 =?us-ascii?Q?FalZNzmhToBxYOySpA5sY4vTMnUrCC+pRkZGgs8HLABX1cmPzyZDCVF2Kgzy?=
 =?us-ascii?Q?AHoK9jzllRziSdSmQAHL72X0DFyApYoUAMb5f2fT4eODOV9URwMGiOsCK0VU?=
 =?us-ascii?Q?coWum3KMa+R7iDAhAN8wONmGlynEMYSp2H+oMOwpTbdCIihnav9N4J1Uhuyx?=
 =?us-ascii?Q?uZR0slrfcF2eancLz2sEZNXSYLU/3CsOz/dWFoKSxw8Qt8ehWufxgFmJ46Y+?=
 =?us-ascii?Q?rcPcgCx74QBmEUZWTF0UrDtj/ERzK5fRGv1wyb3kt782Ck0VPcnwxe1chZ8s?=
 =?us-ascii?Q?gCBWPVtIUyxQADltJDyqxT4bELLj4+Z2KZNH55+pNW8omnN9ajpgDGNsVevO?=
 =?us-ascii?Q?3GZ4vpb+kyMNcvKutjAc1/2OAUF+PwZ5YLLf1+LzP5qZJUfbKbZuocrUsO0g?=
 =?us-ascii?Q?Bia21iLq850aupQ3Tk6mFb9tKuOoMt0dgpS1KYgDugu846tSZmAYuZhQEuut?=
 =?us-ascii?Q?UpWICiJ8yjQbic2vz8kVyfvL49M4oQ+WlHzFAOkOHKuxUPhMhmCSzVgkRDG/?=
 =?us-ascii?Q?NViIgWU5fhcB0kQKKV1D89UAxz5vdcwuP/ljgCMJ4vYGvm4Ed7UMQtfYbEYa?=
 =?us-ascii?Q?QXQuRLUc+5mOIdSRaLJLrYFMyepO2NLdgtoJDPVcVw6tnBgcNqSA7lovk6OX?=
 =?us-ascii?Q?jpoQiJ9V3+51sTVC4F1TedWuS5o9H2DLzMjiEyFNc18b/suL7ltuuZEAF+eD?=
 =?us-ascii?Q?p4kqw/6rTuLyeUX4y1MBckr7gehY94SSfzoXZKC+9cGQIlzSJ7kJMd9wTqoL?=
 =?us-ascii?Q?i3jR9JVSkrhKLYjycuOduDgrULLKUeeVzVRyRdKBmgq0x8BkMx04eS+JwCB5?=
 =?us-ascii?Q?5SM6JJB1kDISVBkXTyhNRO4lUG9r1cQs9V9dGs7hnyV+I9kbMZ8+G+O3ffuh?=
 =?us-ascii?Q?xXDr98lCeeimkQHREd4JHVSyqHo3Xeq67Nf8pg+Mspw7/OtH32O0lG3bOpnU?=
 =?us-ascii?Q?T7OpaQ1CRyE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLdplS3LNxpiBYpDmdMoAUrDEKyHZXbTSO8HITdLP/JhvYayHdG1SZJ35+xf?=
 =?us-ascii?Q?E/rg5UQCFzQ5Iirwrn+q0D9ZoWJiO20IqefYFbDz/7Yi/hupHc3folVT3NxD?=
 =?us-ascii?Q?9v1PWVF5eIp+3aY4tcgwSv4QnfLTalfGbszKzzgW26DNJ7IJGnaQcXrypWFU?=
 =?us-ascii?Q?SvEGhGGddDLky04+ga7nsJ2Ax7i6+ga++Q+4EaVA7gbVvtJPuqxkwff2c4DZ?=
 =?us-ascii?Q?LPWKTOMnG2LT5JPwq0pqOBiqvdXy9MCkhpLbs2M0mSnXfgzukBd7zKs9Slm9?=
 =?us-ascii?Q?uVVFhZ+Ec49MDsFXjIdH/pqFd5GJyIQbkcZHDE2VtXtjlvv3kcIzh0f63UFk?=
 =?us-ascii?Q?Q7Tt7qHdxhoHdne6B5P/p27nwB2KRQZzhudupFDdnb6ZFskJ6kcGaEQWMYER?=
 =?us-ascii?Q?ImzGURaIlWM4tZCgBMe66x94ut5fO/O8DHZy0cVroZtAncS7Or4ho3PhZNKi?=
 =?us-ascii?Q?mefz9KMynVf6TYNeh5n5mBHhnR7dKMQRCxoq1WdoDe0Sg+S/L2l3pFH/FRLw?=
 =?us-ascii?Q?fz+XKdavCi8KJSRJelRSJwaNOcEkhdCPd5X3hdAgy1QKa3AUoMtHX/6vbRvt?=
 =?us-ascii?Q?2djq9WOA9Y7kY6/4exVDg3nWGgZJXwrogSc/hvmDslzOvdKTFrwl9NNijYWV?=
 =?us-ascii?Q?7MM8H1zW0F+UGqtXReBLMNPxjf6PMbPweQeEelgDv63TL1nz/0KGu6m2w9tb?=
 =?us-ascii?Q?musXSbnfdhYPwH6IzaBUrMNvrsdW9jBrqQAdcgx+DI5CuusvWvpu0kXZ1R2p?=
 =?us-ascii?Q?k7l0lF5Puukt8VyJhYi9EwFcX+MWmooASeRkAg/8WLKYpSxU58VWCL9RTSVz?=
 =?us-ascii?Q?2RWOoQvfZ09DiYaoBzXBRLPUh2j3jehuj/xQiRKCtAPV/cE3pqzWJuhIuJC6?=
 =?us-ascii?Q?mDusQPe97gC5CWRAoTsHmw1Gb1EahpwBtrXOyzWgBE0lN8ZIGVRl8wpUyfwH?=
 =?us-ascii?Q?dnE2kOmjx8RMyH33dU9dioU1gNTlhcsqhbBB9q+g1LDoz9c2qgRoGaTrwG32?=
 =?us-ascii?Q?H2YgrIJGUfwYMk9c5ie/kiEJzpeFF7ONUo5QT65GCmVBO/EielVhCgASA498?=
 =?us-ascii?Q?V+0fvqa3C8gHBj/a1+73Sf2f30Dj1yGtEpPlb0++q5333lfM7yBMj2bIXVdb?=
 =?us-ascii?Q?akdo3Ygx0micswrkmTPG64JEgr7yilFDrYE7ddxNn+JEqqbbZIh50S1ILXwf?=
 =?us-ascii?Q?kPzaMo2+a0gUMcUEYS1RVsB7BCDsPYt4C0P4W7D52+ODrNw2SDYMM+MtXeq8?=
 =?us-ascii?Q?6gf0ENABvu5YSMrQBcSCC4aP3Mg0AmROL1CXcmhUBe8JI1nO4YUV1eD60dNY?=
 =?us-ascii?Q?JbB0LS/ZKIpz2KO5uYxdNN5azX6T41JMTn4Dt1KHfpZwWb5CSnujoAWY89R+?=
 =?us-ascii?Q?uYdCx6rdyI+fHr5PYT2mXYU3eCuuGETRc+S9MLYvoBpqV8TcS+j2fQSjLgMS?=
 =?us-ascii?Q?8M9Kr1iT+TgAo+kiSngRMn8iR30mWdF5T5HoOMWqqWqxklaatfkMexaGhRxc?=
 =?us-ascii?Q?TsclaLhETrumO02OsC+ZVtSkdr8XD8RmCdXdnF6/XTDrO2DhZsSX+vh1Vn56?=
 =?us-ascii?Q?2GKyCxt7V8cH1OLSed8PZlGjJuC8gU7nCrV09lkj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c074e-4e02-4ea3-069f-08dd97afbd03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:20.4278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Q+MYh36U/IZD3uBvYvHcHa+yygGqJxch/qwJ8oJg+9GYrcTvzQZQP8g+m9r5yvBsClcYK7abeqCUgg3nyyTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8582
X-Proofpoint-ORIG-GUID: ifS9hkD7UuY2xhehSrXTAd4xL40d6CLh
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=682c9a36 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=eNiANMbe5KInMaSQXcgA:9
X-Proofpoint-GUID: ifS9hkD7UuY2xhehSrXTAd4xL40d6CLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX/fr3GIHsAbXl
 mfBdqXoboA25gHQNQtw+V9cC8a+zJzegj630cXRLHa6NLhB8oKv6kseyYCkiKIeh2KZgwmKlFHQ
 mPxa5p5Q6Yb0dOCSm6Xjcaw7xhHXn6mVsWRYyychM7Sc1SxBRJi2M4ZAmiyTo7muLYsF+VEl/8O
 XhPPHWVXFwkYby8oDYuAt2JlfeMpgf0HWCvoDzaBl/APSWCvfvvI7virRYzONvtYJYJ3t/5015G
 q5kem4OHD5KvqFScgO/tYN6abZfm4uV9iwGR52h4ZuhPcPKWeKPffnl+d4mirG6sSI6EJwk3laF
 +dqcjSEFRrf8QPKwZruic6woBKk7CIxCQbhpceOJs62Feaqar4LZHDhNlIeyKY5ZMXwlHYJXruc
 L1fpIsnTd1keIKTxq/TNVe1CrBLHXa+lEueucuh6a56GTLJQpjBUNmvrUf3pDkPqvU2sVsw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

The user container will shortly need access to the underlying vfio-user
proxy; set this up.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/container.h |  2 ++
 hw/vfio-user/container.c | 43 +++++++++++++++++++++++++++++++---------
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index 3cd3303e68..59e14cf5b3 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -14,10 +14,12 @@
 #include <stdbool.h>
 
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio-user/proxy.h"
 
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 6f0eb86a75..38e9cf8d8a 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -53,15 +53,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_user_create_container(Error **errp)
+static VFIOUserContainer *vfio_user_create_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -69,16 +82,18 @@ static VFIOUserContainer *vfio_user_create_container(Error **errp)
  * Try to mirror vfio_container_connect() as much as possible.
  */
 static VFIOUserContainer *
-vfio_user_container_connect(AddressSpace *as, Error **errp)
+vfio_user_container_connect(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_address_space_get(as);
 
-    container = vfio_user_create_container(errp);
+    container = vfio_user_create_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -89,11 +104,17 @@ vfio_user_container_connect(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -112,6 +133,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -128,14 +152,15 @@ static void vfio_user_container_disconnect(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     vfio_listener_unregister(bcontainer);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -169,7 +194,7 @@ static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_user_container_connect(as, errp);
+    container = vfio_user_container_connect(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
-- 
2.43.0


