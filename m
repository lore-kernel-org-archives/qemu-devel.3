Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D25DC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPYt-0000l2-D9; Thu, 18 Jul 2024 07:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sUPYr-0000ju-CD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:44:37 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sUPYo-0000SK-Ee
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:44:37 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I02a43023641
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 proofpoint20171006; bh=pUgEro/M8lIhffCsClTssBC1U/jdsTFH1hfcGbVkR
 cA=; b=i0/5uTevOHqydkgQ8FeuxFAcLz2As10MJ4EKPP0SxOpCT2bQgJAQLytnO
 Vkl4+FUpBsrZIUEuUte8rgRy1FY2x0inEUuQF1l2Gr81UqffZTsIWA0Fv2yzAzNP
 xqSRqEN7spTytd1GOvJ65ilwO9AeRNktpsVRIrKRFNMm26YndSl8snxV+VtYU+dq
 kTM+VEAbB/q3Wj8rj9ehrzZDKE6rcOyNiDKXfsDJVXyvBz3Z19JgL3ZqkjWJSZTt
 qUxSjvAyRN0rhQ9I6JELDQpSQpPGdqoAa02UfJSiMZB9BRup7BSC/4ipmyXZbXZa
 iTGpgOM7SHdOzreL7zlcQBY0zuNqw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17012055.outbound.protection.outlook.com
 [40.93.14.55])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40dwfjcn58-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxTx1K0ccZhPNGPZAXw7KuJJkdi8bQkaXRNL/ca5gsQeXWlFSE4V5WgqJ6I23iicg1mtpBO2ET7MwiZV82XziVlvjOIiLC+tExiAvXHLoARFl5Y4P91pmfvB4pzapyysULB3GQbMN/RF6yi9UHyE9VnzHbgbWtCGoemHTcW3j3zOefay68NsWLuE6/lFz06R/M+WE8Uhxbu3QMSnijZcO34+9H7UKl1tfNZlcy2KptI+Gt651VgyrEMg8adiriTjvUYH0UWXObPI11MJB3Lf0zmL4gmVH8YJ1nz3Ud9rPlZnfaNwKUD0sMQstGQhDGsMDDD1px9CGCfU7yUwhIRIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUgEro/M8lIhffCsClTssBC1U/jdsTFH1hfcGbVkRcA=;
 b=Rjm52tF1WTTEWWwx4pbtvbjjTQRegMteTQpU4rQwgTnNiRpbdWKAJe4ZZle35n9w6bubtqSqxG6VV8MlNDRHO9tK295I4MVW+poFgWYzBFYByPgrpI0fvJEn6u+t+/PrTCZTiXc3OpDEVPxprMRn+2W1zjtXyHdGrxEV4akhNHjKIheBP5VmLfmouegPpvWouxGVWaFvztSgBJQ9yYzh348iVudIHLLuyCmjpdGnLdllgHPSExKBJE7TRg7ik0dXFrX510aLsz8jjCPiV0adw96zSGymnInJXHbzLYri29qrL1uGBYSuscCbk3SnDCb7G9neajvrcGsJKjxoLCWfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUgEro/M8lIhffCsClTssBC1U/jdsTFH1hfcGbVkRcA=;
 b=aCWUswDib9AlwaGjMiYX3m+7AcFM7zNrulvxvfHCmt2U30pIr6wINH8GvCjMun4hrypr6E/fguW41TlH3Qnblu3GTOa/SwZ/zhkiqdVJJXbkJm9KCqNKLdjI669pr03AmORaUu1yim1EyKj/A3CxL5ZDh4u9112aE9XCIXtAj4g94PXSsFQ3YJ02m0nYqzxSwFaUcFdZiSvtQKIlmz414sYcmGmoBD/kMm68DC74ObdyPVxgMqrYJuR1in8HCfoDiJCW4192BV3E8D1h/2TKtKG40q6A9QqTomj/YZ+llE6lqsFsmpQfF6Rdx0eW14F79wND+e7ZT9J7wzDOE1Epiw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by PH7PR02MB10039.namprd02.prod.outlook.com (2603:10b6:510:2ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 11:44:29 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 11:44:28 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, Prerna Saxena
 <prerna.saxena@nutanix.com>, Bob Ball <bob.ball@nutanix.com>
Subject: Windows 10 and 11 VMs fails to boot with SapphireRapids CPU definition
Thread-Topic: Windows 10 and 11 VMs fails to boot with SapphireRapids CPU
 definition
Thread-Index: AQHa2QeI4d4KNvJYLUWuj2e+u3UDsQ==
Date: Thu, 18 Jul 2024 11:44:28 +0000
Message-ID: <PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7384:EE_|PH7PR02MB10039:EE_
x-ms-office365-filtering-correlation-id: ca85fbe7-6100-4594-15a5-08dca71efb46
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GTAq8FkX2A81rdYijQt9r+HXLdN1urVO4bXWdJUBJ7tteNtjemxkc23xcI0D?=
 =?us-ascii?Q?EdBAt3L/aA/HUw9hMFYA6D36mczpQI5ARTB7M60F7VSdUhZ4V9QTbqJ89cac?=
 =?us-ascii?Q?U2GdHPUF4NcbdQ9xl0TBCB3hky6s0MqdFJH1cbf4S1CkU7wMVGAl9fl/1VBF?=
 =?us-ascii?Q?PIoxJNmnlgWmJas+wukGBp3EYwU1NmU54lRHXiWHZi4bzOp6JJk+52lDo0rq?=
 =?us-ascii?Q?AdjdW9RuUkBZpT3RujKgKQFYZ5cs9xhl9LB3v10xf24j30uFYHMGid9aaxGD?=
 =?us-ascii?Q?0L/DQvjQ8pRekdTLKjjPvKOirnKr1ii8K8eshGdfflc1nAc69t08h75TXfRa?=
 =?us-ascii?Q?6MMiyeI4BSH2zlmiCxgwwAtD9GceoftBNFZT5A4thfs4sY1Qoh37lVIgYexk?=
 =?us-ascii?Q?3LkyTz4Q9o6sYyYA6+3Y8eDrio8n1Xp9hK82KPWj7VAVNIFSm3ORcxHsQYYV?=
 =?us-ascii?Q?wpsd9ufZ31w3MN/M78W/D8ChmI1sVvqYJ8m20UTTGIhIpXk0uKrA31Yy0Xaj?=
 =?us-ascii?Q?3IyRMDXNKqa/Z2eEVaHGj/bJx384sFBLipAj+TAv0rxKc07nPAxivAA+M7JU?=
 =?us-ascii?Q?LL1Y9UpdM+DBJBWct05NGhMyCfieMpZFx4KHjUmpfjShFOQYHSbaIEmkrgy3?=
 =?us-ascii?Q?1LlB+KISBoW4u8teC5aqjRIQ00Tk4M4GQIQa3Ky7fSL6FcgKTOa/4Drc1gh8?=
 =?us-ascii?Q?H7zjq9d63MqiO3alnHK7hW5tqBo3SI+ciFxl6T5hrBB/rrXmNECLK5hmHFh0?=
 =?us-ascii?Q?rQMNj1VjtjhjBvbM1nUS4SYMyqn0yWLY1dZElvP+vMydKY8YzhujY7GOK2bl?=
 =?us-ascii?Q?GXV3EfkZCpvX7wcTpW3fickdQBnLhRBHvS/mzQ3J0XYvzGPbm38irZIUiGcq?=
 =?us-ascii?Q?fQ9oreB8J7M2f8T4o5atwJAwsN5PZ4YDRAeaLEwQAXe4Fs1EZaSAFVFJYt6d?=
 =?us-ascii?Q?GgdRcxFzALNppkJ1sw1XljH2EdEsvBol+8Pee6Mx06xo3F5EypGJsUUekZIa?=
 =?us-ascii?Q?6GbfNTfTGC9yUrnixLGthaH4PdsUjmk4h6tNZdHL2lwrFhXVXedV1gyLD1QH?=
 =?us-ascii?Q?ccXXYGjGpZ6TFThtMBeSiDFL2DtfcDYKV0K2S0ppkpKwalAM+D2E4uXUAmiQ?=
 =?us-ascii?Q?4CeqJRLD5dyS7P4tUAl4VEz29dNbe0LZ03n2gmXxZ+3H7iN+TrQeHB2Ck97g?=
 =?us-ascii?Q?x0oQjaKMCRgQIKKvqWcu9u86eHpExn95SHLJsPGI2qMTCGvK+iYveAgmQrtQ?=
 =?us-ascii?Q?tyJbRl7wwi6L2NWj2H84PP+Viop6tK5AOg9Yrf/47URK/3IMufkQ8G/LKt28?=
 =?us-ascii?Q?7446bv/KQnEY5c8f9atwhqNhzhK0CFUA7xht2UVhVQTYujHd3XWlsMmT7hcx?=
 =?us-ascii?Q?JKQcOH4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/jee72Le7ntmRQyzxIA9pO35/1rKSJJYhGyEotMBJYBoya/mewzPSfg577N4?=
 =?us-ascii?Q?W+Au23Cy2SBG4g6W5RdC8ZUETE+YXsksRHRHNwCu8Fsd8hnfJfl0x2+ajWCP?=
 =?us-ascii?Q?EhACiQhruQgvdL+KECBJCmlD38xjyN9rE+vSsUd3Z96ctjWpjHEtPDx3eIsh?=
 =?us-ascii?Q?PYXzGH5KubiEIF1ZwVVmmCswRCWPCJPFOwItuhACrttJD0NiphEZdbshxbvX?=
 =?us-ascii?Q?2asyXk8xc2ZBeWSpQR3GegZSOSy3xqhEYk8rif7a9imtikMgL4ZszMR+ks09?=
 =?us-ascii?Q?bLYDi9VmPJBZbazO99pyqjMnu521SdZbTpGdKcz1eiPis8wqyk9jmMpYTmnu?=
 =?us-ascii?Q?8Vqmld+MsOBNZL6TcDY0nFcf2flDDzVQVMHVd3W5J+zhGfAgSydI2kwazhsn?=
 =?us-ascii?Q?pul9FpTEv1Q18pxdO4QKD5c7d0EQce1uqzwMn8MHH9DwbVINg8Ri8rrk1CR+?=
 =?us-ascii?Q?O+LGpUaUp0F64gGCc33Xt3Fpzx4zxcZ2xdZeFRyAjRqILE9U5VLe3wU6Bz2Z?=
 =?us-ascii?Q?JVZr8nOHFu9B2loCDuTf4Rps7D0iU0UbMPX5veOIkI9Zu39SoUMVSoKJXFKh?=
 =?us-ascii?Q?U4tAul03/D85GiZ/9Zjo9Wmig7F5VyXlRAkRPxz8jW/Ydu7bqNYx5oKNvGrF?=
 =?us-ascii?Q?CfCjMep8XYi9cOzaNrzq1r7tC3iip678l711jn4CmyEtyaXOw7MrZBBCvfxv?=
 =?us-ascii?Q?kZcLxmjYZXbTluRikV+cFYhLAWxUIH1q4a5SRQICHHsO7I1+gW/KiibsXk/R?=
 =?us-ascii?Q?fAym/U7J+cLta5/dGbT9TIlxvB1lLyZ0XpzdR+dJyRPEZaof3kCDvuz7jv46?=
 =?us-ascii?Q?cBoQKKKfoq6amIuzIUrqKvkm9vOJgs+Mw5LnwdL/CP9s3GBlmYSgyKF2kFDv?=
 =?us-ascii?Q?Cbh73dvN789VChP5ZhHDkG7pLhpAIgld7jAIwxEqeSGhRUSSMmsPWQCfk4hD?=
 =?us-ascii?Q?rjMaPE2MPq0/FvXp4moh9liWSpfzQjfpJfg4KuGvpLh7aZ+VPp2IyXt+oAIq?=
 =?us-ascii?Q?HtZ8PK7PGgVBFr32L7FwU1a3z8HRsDFi+nphur1HEXBdEBXypv6KoNZP9hzn?=
 =?us-ascii?Q?TNGFTvuTnasmyRG4eyB1D2Q0eLnsHSTTgX3jKwcyc5WtC1MxkLj7aC0VuLEI?=
 =?us-ascii?Q?u3xLhkNxt0u1iBu6W77T1QUhELm35pZBUHB+zSDYRim9VAZgRhup0YK3CTjA?=
 =?us-ascii?Q?grY/OHlReIUAJH8byFqvvpx+B1XI6NRpEKEQIuIzResXSvWexliDgc1jaZ6o?=
 =?us-ascii?Q?Ym7GmPj2O5PqdVU7GuXQQKyAztkr5KNCJT0KOITCG0SRzZSm669M3nmv/nTv?=
 =?us-ascii?Q?Aq9zO+U/Y01ywLEJcJ0H1BAiIay/T2qIbeblsub9ZvcEsAZ8x3YEDVgUNoh2?=
 =?us-ascii?Q?KtYn0Oq71C/4XQUW4fMAfs4sQBCvym1Ojo6a/cf/hVgItAgLY/GhXWKxXELH?=
 =?us-ascii?Q?XfWCpg+r6TFt43BuqIaZQPVRrpdgfMGEs/gG3F/Q/ppzoJJ9pyqVg+nly2+l?=
 =?us-ascii?Q?JeouSfZaK1EHFSCN1O1xECkFmgYjwuqdWdWepLx6T85+g2AvqPprOP43g1gM?=
 =?us-ascii?Q?1VtnXQr+Lw7f6rRdyZyaDYIwhnAYF/4qgNnQOPKv31phMhCpKYWrpyJjUmYw?=
 =?us-ascii?Q?evB3JbqkqPy05G666xltK1BQIu0n4s0UzgO19c0UqzTYRBqwgpR05UHBnb7q?=
 =?us-ascii?Q?HvMQsOLnCouYZU/Io2CHVtAmy5M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR02MB738410511BF51B12DB09BE6CF6AC2PH0PR02MB7384namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca85fbe7-6100-4594-15a5-08dca71efb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 11:44:28.5797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SHbMRTJvejIehJG76Viw7GzTwMScafXHl/PlPA0UDTHRsHHF/D5QU+l5ZpiSVUl6DnQYR3/T2yrhPwe6xfg7F0DLa9JuMq9g1mRmKEztIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10039
X-Proofpoint-GUID: 9BU37vMJsxfFtVlmFZilPuFHSNC4hUrG
X-Proofpoint-ORIG-GUID: 9BU37vMJsxfFtVlmFZilPuFHSNC4hUrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_07,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH0PR02MB738410511BF51B12DB09BE6CF6AC2PH0PR02MB7384namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

We are facing issues booting windows VMs with SapphireRapids CPU definition=
. This is happening in case we have multiple cores per vcpu set and the VM =
is a UEFI, secure boot and credential guard enabled. Till now we have obser=
ved this issue on windows 10 and 11.



We did some triaging around this. SapphireRapids CPU definition has raised =
cpuid_level to 0x20. This includes leaf V2 extended topology (0x1f). QEMU r=
eturns all zeros in case !x86_has_extended_topo()<https://github.com/qemu/q=
emu/blob/58ee924b97d1c0898555647a31820c5a20d55a73/target/i386/kvm/kvm.c#L18=
34>. As per expectation(also mentioned in https://cdrdv2-public.intel.com/7=
75917/intel-64-architecture-processor-topology-enumeration.pdf) if guests s=
ee this it should fallback to 0x1b. Somehow windows 10 and windows 11 does =
not work well with this assumption and panics on boot.



We checked on one of the SapphireRapids node with no multi-die topology; th=
is is how CPUID output looks like. 0x1f output is the same as 0xb.


# cpuid -l 0xb -s 0 -1

CPU:

   x2APIC features / processor topology (0xb):

      extended APIC ID                      =3D 37

      --- level 0 ---

      level number                          =3D 0x0 (0)

      level type                            =3D thread (1)

      bit width of level & previous levels  =3D 0x1 (1)

      number of logical processors at level =3D 0x2 (2)

# cpuid -l 0xb -s 1 -1

CPU:

      --- level 1 ---

      level number                          =3D 0x1 (1)

      level type                            =3D core (2)

      bit width of level & previous levels  =3D 0x7 (7)

      number of logical processors at level =3D 0x28 (40)

# cpuid -l 0xb -s 2 -1

CPU:

      --- level 2 ---

      level number                          =3D 0x2 (2)

      level type                            =3D invalid (0)

      bit width of level & previous levels  =3D 0x0 (0)

      number of logical processors at level =3D 0x0 (0)

# cpuid -l 0x1f -s 0 -1

CPU:

   V2 extended topology (0x1f):

      x2APIC ID of logical processor =3D 0x25 (37)

      --- level 0 ---

      level number                          =3D 0x0 (0)

      level type                            =3D thread (1)

      bit width of level & previous levels  =3D 0x1 (1)

      number of logical processors at level =3D 0x2 (2)

# cpuid -l 0x1f -s 1 -1

CPU:

      --- level 1 ---

      level number                          =3D 0x1 (1)

      level type                            =3D core (2)

      bit width of level & previous levels  =3D 0x7 (7)

      number of logical processors at level =3D 0x28 (40)

# cpuid -l 0x1f -s 2 -1

CPU:

      --- level 2 ---

      level number                          =3D 0x2 (2)

      level type                            =3D invalid (0)

      bit width of level & previous levels  =3D 0x0 (0)

      number of logical processors at level =3D 0x0 (0)



We tried a workaround having 0x1f output same as 0xb in case !x86_has_exten=
ded_topo(), instead of setting all zeros. This seems to work fine. Our unde=
rstanding is that current QEMU behaviour is not incorrect but still does th=
e above mentioned workaround makes sense? And if we look it is the same as =
bare-metal so it should not be unreasonable. If so will be happy to send a =
patch for same.


Thanks

Manish Mishra



--_000_PH0PR02MB738410511BF51B12DB09BE6CF6AC2PH0PR02MB7384namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Hi Everyone,</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">We are facing issues booting windows VMs =
with SapphireRapids CPU definition. This is happening in case we have multi=
ple cores per vcpu set and the VM is a UEFI, secure
 boot and credential guard enabled. Till now we have observed this issue on=
 windows 10 and 11.&nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0cm"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">We did some triaging around this. Sapphir=
eRapids CPU definition has raised cpuid_level to 0x20. This includes leaf V=
2 extended topology (0x1f). QEMU returns all zeros
 in case</span><a href=3D"https://github.com/qemu/qemu/blob/58ee924b97d1c08=
98555647a31820c5a20d55a73/target/i386/kvm/kvm.c#L1834"><span style=3D"font-=
size:8.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#1155CC"> !x86_ha=
s_extended_topo()</span></a><span style=3D"font-size:8.5pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:black">.
 As per expectation(also mentioned in https://cdrdv2-public.intel.com/77591=
7/intel-64-architecture-processor-topology-enumeration.pdf) if guests see t=
his it should fallback to 0x1b. Somehow windows 10 and windows 11 does not =
work well with this assumption and
 panics on boot.&nbsp;<o:p></o:p></span></p>
<p style=3D"margin:0cm"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">We checked on one of the SapphireRapids n=
ode with no multi-die topology; this is how CPUID output looks like. 0x1f o=
utput is the same as 0xb.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0xb -s 0 -1</span><o:p></o:p><=
/p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;x2APIC features / proce=
ssor topology (0xb):</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;exten=
ded APIC ID&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; =3D 37</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 0 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x0 (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D thread (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x1 (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x2 (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0xb -s 1 -1</span><o:p></o:p><=
/p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 1 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x1 (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D core (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x7 (7)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x28 (40)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0xb -s 2 -1</span><o:p></o:p><=
/p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 2 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x2 (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D invalid (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x0 (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x0 (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0x1f -s 0 -1</span><o:p></o:p>=
</p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;V2 extended topology (0=
x1f):</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;x2API=
C ID of logical processor =3D 0x25 (37)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 0 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x0 (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D thread (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x1 (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x2 (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0x1f -s 1 -1</span><o:p></o:p>=
</p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 1 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x1 (1)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D core (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x7 (7)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x28 (40)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"># cpuid -l 0x1f -s 2 -1</span><o:p></o:p>=
</p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">CPU:</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--- l=
evel 2 ---</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 number&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; =3D 0x2 (2)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;level=
 type&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; =3D invalid (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bit w=
idth of level &amp; previous levels&nbsp; =3D 0x0 (0)</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbe=
r of logical processors at level =3D 0x0 (0)<o:p></o:p></span></p>
<p style=3D"margin:0cm"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">We tried a workaround having 0x1f output =
same as 0xb in case !x86_has_extended_topo(), instead of setting all zeros.=
 This seems to work fine. Our understanding is
 that current QEMU behaviour is not incorrect but still does the above ment=
ioned workaround makes sense? And if we look it is the same as bare-metal s=
o it should not be unreasonable. If so will be happy to send a patch for sa=
me.</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Thanks</span><o:p></o:p></p>
<p style=3D"margin:0cm"><span style=3D"font-size:8.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Manish Mishra</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_PH0PR02MB738410511BF51B12DB09BE6CF6AC2PH0PR02MB7384namp_--

