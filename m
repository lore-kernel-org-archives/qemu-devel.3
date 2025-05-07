Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCfIn-0000zQ-2W; Wed, 07 May 2025 09:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCfIk-0000tV-MV; Wed, 07 May 2025 09:59:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCfIi-0007Fl-Fi; Wed, 07 May 2025 09:59:10 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A7qdr026277;
 Wed, 7 May 2025 06:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ngj12ys2kxvgR1JSP22xqbaezTW1vKhUVUEbozPzJ
 go=; b=kaAcz2Jwit/w/lZ4XAgA40yJ+iIHBsvSWMzhpv7lcgtuRtjGpEEr/S/Vs
 UuPyfb1pV39FhFurjnY0soYTt1zAHtC3Cdj4G+oy1vdYY/egN8FMjmnb0QfVKdWY
 FGkax/gFRcPh//QHt2HkWTF66R/U1Nuv916WpJgx/D9txq2IlcIZiPwhNS/GUMSH
 8/O57CjKLAZRT/MjfUS/AWIR35c3OGOZ5sY4cCiZ3ZQz5zkiDV1aLMv1o75oy93M
 PDI0i/bIxeJzcPV/l1qnFNEkwwvfwTGW0HRXXUEHATpLLBUMfFG84SakFmG/oykF
 EThP/gG5aFECF8a8jcSIhTbDmwgPw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8j156g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 06:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKVpd8Z3G0Om4/gigxza2S8ThLCVy5eAmXJsjar8+kRnFUfRyil3dgsQbYXxcMkF2R7XYGnFb10IFsLxtmxydLhYroiYSSfzcgaMBIFkQmhC/l7Mdh2T7wvEfboY0jEc4B/ImXJOaTQw7+02QRnuZebmQk+c248Psg3geAt+q8o16Rq4/ZYkU5r2UNAuJbB/PRMRO+6KUR6uc8W8LSt+KU+fHGl3zv9bYUGGnIHUTdzmrtF49FKL0cnXo0vnF+yhSwgLnuhrcjRFQeIMQ4jmWhOR4WLx4ROzo/q6bnG7nYQebQVSyQ0CHWYqR59oE66pixXz9mip84MGI9jEauocGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhRApkIa4K9afzYbiHnAnK8fe8hnU9Vv2NWvoljea5Q=;
 b=NlOsmSgToIb/yLNrDiOSCjawNEcJ4ArGz51E82nC0DQk1tWTaRZc8dxtJNnEKu0hF2IO87/w2TfkAEL7iwdPcQmkslmne83wmaahrsTLKR6a4FZIX9Apt392qudxR5VObHwcoGzoXXaGrT6aYu7ZfSN41o7A4ihvTMJWkgGnpkMixpci93kW9+RCBLWDAG4xJDjFDwZm49+0qxPxAe2YEmr/f7FZqFdRDK6ivmelKOqbiaH2xwMwmzbIhlHbOcLtyDMdX5RYKKKv5n5mO5QE9lfHD1fLXG/7/nZMApQyI0Mc0kRyiNt5uzpKGuEU0reAPeB7rze/++P2CSuHEGswnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhRApkIa4K9afzYbiHnAnK8fe8hnU9Vv2NWvoljea5Q=;
 b=OKZa2sa0vZhhn2ovIbfxZPvaEfuPOBACoKmGFjzbypHsuw2UXkQNjqfn5r7yDqmPdZ1ASKDDYLpKroxwH3bv6uZ4C/3tAvBVqfyWN8OhBAlRXqEGteQmwp+08TJLei8RiZTyX22CTQVhp4mCvYlVNezmVqXDZd6n/65NlnMutQV6TiFvbwJaZUErM/R20q1Hy7NESy3g0ozY2AJj3139jvV4ep29luAHBs7ueQX92iWc0waOZR0JrAYRQMAeIUuVLpEds+dp7behQoPCxJuWewtd+F1FzIBoNBJJ3RF95PgyoIfM/VUiewfzmtgBbg9YsrEWHweEZCmbKPbKxUFAUg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6851.namprd02.prod.outlook.com (2603:10b6:a03:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 13:58:58 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 13:58:57 +0000
Date: Wed, 7 May 2025 14:58:48 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v2 15/15] vfio/container: pass MemoryRegion to DMA
 operations
Message-ID: <aBtnGKxF6ij1z9EW@lent>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-16-john.levon@nutanix.com>
 <94e51ea2-d598-4c41-8498-eabe32349788@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94e51ea2-d598-4c41-8498-eabe32349788@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:208:14::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: ea67335e-1f78-455b-9e65-08dd8d6f4dc1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?A5R0CaduuRb5FTCHp7GFGk9LgLPJ12hDNmqzRpYUGN1RlPBY2DxHfjyLgc?=
 =?iso-8859-1?Q?TodbgoEDFLiwYAXUrPlXZHDD3Bg/V9RE4eLENVY3acvVhfldXW9XONMM9Y?=
 =?iso-8859-1?Q?PXtUytpKXgoW/Yu4Sc9o0Gi4xUrMkQfyXDwc4G9zatr5KVHK4HV1PGrwqP?=
 =?iso-8859-1?Q?MWbqvBUbDpWwgqJoJUziney2uUrKF006DyDCyPFcpV+3EFXGKklGA1udj9?=
 =?iso-8859-1?Q?yjtgn9D+U68LXhZP2MB1/WY/tQ1WvUyBRjzHvxoLF9JUiEpkYEZr91zV7N?=
 =?iso-8859-1?Q?i6S4JbP5NJs2Weuc3bpr3cqkwysurYWeiufL/n6CCiaF2ciFWxCrqqvNJA?=
 =?iso-8859-1?Q?0mInodStlVcN3QwLNATX4wvEv7DQBGjT7qJH5WysMQcOwkk+szqRmjqanR?=
 =?iso-8859-1?Q?Z/00c/u1AoywWyxbAPVdqlu6Q+NBgPbIyIjXXueBHyFZJeQ+pR/TjqxK7/?=
 =?iso-8859-1?Q?X2OEErWC17sC7wcB0TAL4tX6GFANfPVNFUzszEWQJUd2fZ0dQQauSyrghh?=
 =?iso-8859-1?Q?qDp20W9Iqnj9LTcg4tiHOfDIJR4OQgiDPoIaZYhwH/fqK3WhKZ5+bV6OzN?=
 =?iso-8859-1?Q?dViiBbOvuaTPCSY383buy5snV9iAcnwFaF3OEX4ZXB9JOLR8n4+PIeCuvC?=
 =?iso-8859-1?Q?8gHFXnKD3kfnzgTLpRjLb1wl0oND0kTwjjBFAkPNBe+y29SnYrl7jZqQ5Q?=
 =?iso-8859-1?Q?muGZesLCenuf1trhyxft8Ez8UbmNxG1mQTFMQot1oc0y16K2r2aVzhcdfq?=
 =?iso-8859-1?Q?oRsPnWq6wdgD6HbFlrG86WJ24KFawpUUC9/Vm9JgOXpTnogJLcqRAr5s4Z?=
 =?iso-8859-1?Q?vyW8EJQp82kbn1splFvaXds4xORl/vP5yQ1QCdV1C61hpKeJoxvjLSSGYz?=
 =?iso-8859-1?Q?gmuxWAquDSiNN+OA/dnFuuTOKAdFKdVf8tp7S+97ry5fFKxUm8TEk3l49n?=
 =?iso-8859-1?Q?H8z/eWOXQO49K2WFPsHESyJnpiBWNVWMGlNTva9cbN2qYj7pPHAlrOucoj?=
 =?iso-8859-1?Q?8t9TehZtbS+KaaeORr2twb867o0NtEhKJhN/wYtP7ftGD9TD9GMypkQAQh?=
 =?iso-8859-1?Q?2mE7RGiZdd27Xl6JeedkvXN6oEdfPvnldS3evJEctrUT9vxMb5h/gTA/U/?=
 =?iso-8859-1?Q?BH8lT8A08oPxksYQzQ0D9qSZlj9dnn851LrUDrB/TjDoLcYdZQe+kO/+1K?=
 =?iso-8859-1?Q?SFzI1ShmAo2tq9kzgsuFxFt5p74q3qHc1tutJeG+nh7maImHhPuz+u9tru?=
 =?iso-8859-1?Q?IskKtrFOkXIn0y/ckvPbW4tCeBXParr0i2QzYQFeUL8JIpsrVf8YCvkWMN?=
 =?iso-8859-1?Q?2EkRs+Sz+IUZyhAsqodGU9UwHp6NaFtjG1aQIeC78qKih5GAb/eTt0adSe?=
 =?iso-8859-1?Q?T8RMCYyGx+YpoHRCO6X9fco5qXxePcSToZoYNALO3xd+9Bnn5p0Rda6NdG?=
 =?iso-8859-1?Q?g5RXWrGKV5h1lPXrHSh8vKDHlczTIIz/favJz1PuI0hCRA/v+wnCvFYt4d?=
 =?iso-8859-1?Q?A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?phKaLRNjUzCUEZZ6iTU6XxCQfCkiNkYlbnGtSx9TQ6Yb3AaeWvMVPoFRGB?=
 =?iso-8859-1?Q?iElA8M1b4YNdwru4p8t+TrlpSfmzewJY9YwiZEUno+yox+cUV41MLxut6+?=
 =?iso-8859-1?Q?MfU7exsLGPJW7X22zXDvHuIFMz2p3q4Jp1GE2bSfCwHC5ceQVJACqJzb+z?=
 =?iso-8859-1?Q?zz9p7VdSBF59zHUKfWbntKgbDgbgsw42nSdDEJWV3gZhM3/a4xwcwxB0Ik?=
 =?iso-8859-1?Q?LFg7VykNYcTuj2IoJLfhvwIZvLme1gtcIksSGPVa6Bm22pSkukx4EP0FgM?=
 =?iso-8859-1?Q?p260hHIykGytN8dujHfse3EOrF9O+CKoD9gS9T1dhzwWfP0JemlMoQum9i?=
 =?iso-8859-1?Q?N5X7KZN7mx1xnYL++NoW2teh+0lDHybGqOiKWDGg0lneCkUFk9O0EJeAdV?=
 =?iso-8859-1?Q?rXtPGt/6UY3XDQpXx2QeQlNTDQz0S3Nrm1n1NOfveC05A4ESMKH78xa07P?=
 =?iso-8859-1?Q?mIe5ka/BsjjU0UulYZ0q4NKgcLrzF1amtjPE9mG1R6lWrhIUTDxt5iCoVW?=
 =?iso-8859-1?Q?Y3hqWhYNlphXJumUJRRWzh+RrbnS0yLT4NUbktKbnUkthtZ+3jr/VAq2K1?=
 =?iso-8859-1?Q?UoY2R1VhscOOyPlJxRElzYjnwawEEWW8DE11IK1PNU7emDeorIadFS1xBd?=
 =?iso-8859-1?Q?PzhWYW5EjLENDZJI6sFCEaXoCYchuA9XGJ0E9QfxrV1+XYDWnvEImVhGue?=
 =?iso-8859-1?Q?Tr41lbdwh8oqu9yx5Y5ShZkLDIW304W5BQzUccOY3HUDyAOaoLtMYCJzo+?=
 =?iso-8859-1?Q?rztZm0Ce6pV8Jk+aODrLTpVEwy/Wi6MJlV0PkRtTrh4sHU9/MKloJ73HLb?=
 =?iso-8859-1?Q?DEREtGZgzU3iPdlp8SNk0zmGsSS+tpEQ6GqiQizCMYNtwyXiIQkrtxdKx1?=
 =?iso-8859-1?Q?U1i80lw2J2rQ54IvK4urknA95fgx75uKk8ZQeD2FetbMQljciTsMnDba+D?=
 =?iso-8859-1?Q?T7J3mlhmqmn5hZdVl+uTzIHet509FBq9A0pAPgvGI00qQ/howN2tnY/u94?=
 =?iso-8859-1?Q?tYDh6rF6emWB67UhG5VQbgjoxUyFEyh7mUqP04V+bvQlnIXlqBkMDipe9W?=
 =?iso-8859-1?Q?G4lB5ZI4g7Mdjrz/eyq7LodQFDUKC8kJKbjAoI3NV8wxaglJMYE9Zoqx/l?=
 =?iso-8859-1?Q?Mzc6gXLO7Vs3B2FjKNBzc7g28XG/yXBGe9RE4iNOP5/liSnReBHPTeLGUR?=
 =?iso-8859-1?Q?6NOZzXaZ2Y2zz4WpM/2RBnzYYA9f4LLhsBvg7MJBcJBaSH3h1Bn9/e992S?=
 =?iso-8859-1?Q?RqcptYA3sRTHo/KDvaDWu2U6YYk8/jobuE5GJSnKh/eWcMWpZxHstlvEOL?=
 =?iso-8859-1?Q?WyhB+2N6CHCRD/MCfqZ9Ny+DBKpjsdA7MsmwopZ6n3/WmSiCw8ccezutPc?=
 =?iso-8859-1?Q?Q4X2kykqx8N5QR5QwXRtRIC7UBfkraNY8zpxApiR/Xj+9g6oyk5lwS7GGK?=
 =?iso-8859-1?Q?i1tT+WqmPQNq5yYTXSjdMtn30RVCeMjMwoYsoON1beT+zqYs+m+j6uS/QK?=
 =?iso-8859-1?Q?sKl4f2Q2WVa55ijrn7Y890fDHzOJsqCK2Gqrir5LGtZWdECiGnezR4yz+2?=
 =?iso-8859-1?Q?8iGFxY9TFurbvVBJc2vp8PodtLAfgahFvo/DUTyrU32FugQ6u9rjhJP8nk?=
 =?iso-8859-1?Q?JkUMs6oQESlE3aPyO/lJNnJPJtG/oc3X7v?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea67335e-1f78-455b-9e65-08dd8d6f4dc1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:58:57.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W70mQqUCvoRvJIj2tV8mab0Qy5eg+hDkByCuRYQft9VUu0OUwhZb3bq4VHCDMkTTGHtfU4BNDnJGJs9nXoM46g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6851
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681b6728 cx=c_pps
 a=E16apIjzS4FSNrpGVxxkkw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=LPBmoP4vMa6TtmzCWCUA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: XNsM1Avf9ynU-Jr562Dr6XGbiVcQtR5C
X-Proofpoint-GUID: XNsM1Avf9ynU-Jr562Dr6XGbiVcQtR5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEzMSBTYWx0ZWRfX/l74hXFnLuCl
 RHZ8ABUL+D21ohdth801QFUVrJWI7A6tbMgbV76hqJiVNyNVb69C86UdlxTIKYna/cHqL3Z+JDA
 QKI9+5yN+IqeqxMy/uD4rYUnasqnKBb+lrVGZ0+dukyO6mfanKk9xYaFhJn3bl9gBaloBXTVQqW
 1Ou41OouVVyRAPOWmciYs4EOWIdCG9BlNcXPKk7ZjSlIldOmUq/N2nq6hKgt3gugv/ybQnwbPPB
 lPf4O9kprlaNmJnXd2dEGverVD+pSuXlvGM0+Tum03IL4ZogyL0J1G5KSl56eCtZUHpWd5UXyEQ
 CC1/uU7mbXo4OcoeJiyNFZ2mp6yO+SOrFn/DMhqYk6SST1V4wBnde5PHQCxQpi+rUoM1Id1yHAZ
 /rd8R9bUCrLYvlhyLKvSKVh46j0YlPQVrM4PBTG/0KpTGdfe19rBah4qZ1VcW3NbvSxYJ18y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 02:46:12PM +0200, Cédric Le Goater wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 4/30/25 21:40, John Levon wrote:
> > Pass through the MemoryRegion to DMA operation handlers of vfio
> > containers. The vfio-user container will need this later.
> > 
> > Originally-by: John Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> You should add the system/memory maintainers as Cc: entries in this
> patch.

Double-checked, and they are already:

$ ./scripts/get_maintainer.pl -f system/memory.c
Paolo Bonzini <pbonzini@redhat.com> (supporter:Memory API)
Peter Xu <peterx@redhat.com> (supporter:Memory API)
David Hildenbrand <david@redhat.com> (supporter:Memory API)
"Philippe Mathieu-Daudé" <philmd@linaro.org> (reviewer:Memory API)
qemu-devel@nongnu.org (open list:All patches CC here)

regards
john

