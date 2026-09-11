Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA6CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x526r-0006zx-Rj; Fri, 11 Sep 2026 10:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526Q-0006j5-SN; Fri, 11 Sep 2026 10:19:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hugo.komatsu@nutanix.com>)
 id 1x526K-00049T-UT; Fri, 11 Sep 2026 10:19:40 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BCh7K3004863; Fri, 11 Sep 2026 07:19:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=q0tUiR64yb+PdsdqEKqJzXHCMI4d475Ef6q33yg12
 eU=; b=DKI65zY4b3BdnhEhAfv2aJLnmUiYHA+N544gKEf1PYj+0T0CollxSFuD8
 ldGNrzq2me3a5ISyK0AVZSqmGPvAvYzjp9zmkKEISV67aDyXtOeasfP/JGtx00UA
 ycO4a/h1XXQEYAAR+rhcc+a8/UCK4DpT2sU02QxTLCILuCQOsfNMddBmNpb/DXYZ
 YeVUPvOwHG4GckhK3KM/v6tsBsUeQJNEQ+cf9qdDpOYKra4+OqSBVg/33zLCcXxa
 gxpj86yysPaHCyFsGMk1nEkVcl/KibiuNn/qK4swVgLWvm8lzDOSnopD6aGhtWFv
 ykIARzSwubKv/2gQThfORzbAa5glA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020087.outbound.protection.outlook.com
 [52.101.193.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gkd0157rs-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 07:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTVrNxHOWZRSXL/IyPuIPg4IW9dxTI3ZrJRcHqh8LCJZP2y9yOZ2eJ1cAGr/Q6wUVxuFhAebcgFtW4Fy3s3UMEfesyIHftt6RqfQvdNZb8ZoRTmgHuUtke+op27OG/t6HiqjqjVSdBr7+F0s4WEobfrVirGr6mXpo+/SYOcKn6U/08gV5iNJnB8OHtOLdkG3RtuGyom3GCwuo7YoCYWlaWFyAGFeB0fEoe5UfL0+ed79YhpSAFjT+nY8/lNWwbE9J2qcBT1zRoK2Xg72bgDFiktuIf2nexijboM2+3yd4VP/2cKmp6UqPHmrW+9sDhTXk8xBkQ1CrIMzs8TcOvL1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0tUiR64yb+PdsdqEKqJzXHCMI4d475Ef6q33yg12eU=;
 b=VhqRoiFVHCLILBZRlj/B22WZUPhbC8hxFe8EeJVOz3HdobYQXQnPl23iyhy+w1gP3cduj6tpUzcMYX1ABskb8KwCzbZD/07wVsew/hG3Rx1hWyilZFJ+o9K8Rpfgc677e33EoWlUmoAegnCvU3+bIh7g8rsh3l6oSNuyJT3P9vqkJk6yK4VaG0RlrThyplXJWQ+VBee3SkIG/IDjXheKXzP2V8qGcdYiCEEhLuk+auddeCNebaHKk7/GgU7DuapwDD1k6LV2I7Yo8IgEuWTXsNR5qmK7Qm8dzDXHKkAeQXhRNFY8tNeX6dCVvW9xCRRyOgrfC3l80+04rgY03Un5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0tUiR64yb+PdsdqEKqJzXHCMI4d475Ef6q33yg12eU=;
 b=rVyrDSlOwfhhA7C0Qq9ReemT1eNnoPbiGM7s8c7iNKdzBzL4xF5mE0ZfD8nJNBCxA9jXXrNP1HouwZjv1EGhXpmRIiZBOLphO4/hxEPuuHJ9o+GiVpwH1vRWDrHmMGh8fqSPbxJi6HKzTiqPyfafEvllh2cap8K3tQPK7KCvYericOzaubNHDVJC7lYyXTpAsx8hbjBRPle12apX1sO0T7hrEy1Ks7yLyD9AQMNLuClFMstI5Yg8uY0yNT2NN+X+LTbLdKNgKVP9txL5Usx6yyRPJvg+Amh/sJBuhaC9T56PvVvxfrRRMzIYVnwqnCIcAZu7d1+VDNaavOOqcXAj4A==
Received: from DM6PR02MB6172.namprd02.prod.outlook.com (2603:10b6:5:1fe::18)
 by SJ0PR02MB11781.namprd02.prod.outlook.com (2603:10b6:a03:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 14:19:25 +0000
Received: from DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd]) by DM6PR02MB6172.namprd02.prod.outlook.com
 ([fe80::39c3:beef:21c:b4bd%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:19:25 +0000
From: Hugo Komatsu <hugo.komatsu@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Alex Williamson
 <alex@shazbot.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 2/8] docs/vfio-user: clarify data_fd and DMA logging
 behaviors
Thread-Topic: [PATCH v2 2/8] docs/vfio-user: clarify data_fd and DMA logging
 behaviors
Thread-Index: AQHdQfiMSazTrWDqLUSrCRnfi8hw5w==
Date: Fri, 11 Sep 2026 14:19:25 +0000
Message-ID: <20260911140710.2348139-3-hugo.komatsu@nutanix.com>
References: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
In-Reply-To: <20260911140710.2348139-1-hugo.komatsu@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB6172:EE_|SJ0PR02MB11781:EE_
x-ms-office365-filtering-correlation-id: 7f5d85e1-7c6d-470c-5eb7-08df100faf21
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|3023799007|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Y8I8MabsyOmfIjZcHqqOPhmqUnWIHbVJAyAKZg/oWlQ1sylpZvASEd6WKpgyF+PzYJNMvzr9DWnh89l1ic+Lg1zhKgiOOFjfBuOrBU0XBCvjN7ulHXUiexo3WOWIcPuJWHeNasVonD9EH1Ms5o0okLDwpUFt9HaiZHs4Iq3skl3cWj8BuHMMNdMAxPzhl8VwRXdsnW9maV6osWTavH8BkuTsoU0er93QhkKQ7ibaNIpdFz9tnJp1vzlxsXjt8XWDnAujqlXPgBtpi8GIgfcRTs66UKzXdbZZ/2UsX2yL9mkJldX0a3hzSZpTZONy52bnWoy+eNkvCUIp5BIgBcGKU1HTAbugmlnRK9spihV1VuvbwTCoxUmSadPVKBpk8t3+0CTfp74VRSfVjXbPVnov/p2Xxu4wYbXv7eIr+O1fNLqBSDzJzWjFWrH2DtutffyUHxOW1ie4b86XWgu9RH4Kt/hH9h2VFD/c4msAXmRovIpmyW4LzvnVIPYC5cvXsWlIWLUdpMACDJtWs/Bam1j26cd1n8ws86K6tn3i7HMUMYdD9Wu7yauG1x9DCcZnymAV4BBjGnSskRK6Ek3woWXuWb3f7i9DIXuagq0uKP3q7LwruIJL48+Uyr3fT1WLQBTs8XWIsY8LEp1+4WoM9Zaezafl5tbZ7nJ21Mh9bkwXzyOXwmY5VIznoXlOg5Tt1b7AqBlt5hl/CFTdcLIi5CK1dVzgMos9GzzMjdPmZ2kunNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB6172.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AHqQXFvQ9enyhOf2GS7LuejwVZp8IfJN78hDoGA9leNEQ2QdrAtte4mECn?=
 =?iso-8859-1?Q?gh7z05rqgmpGHN0u96fxETSOMS+tEAkCwY8L/u4S+h9Mq6R8R+zTIRooSq?=
 =?iso-8859-1?Q?XI2CSPgESO68oX1bLnK5aMKeIJUP5CtN/v+sv1p7xwdH/MJZsOzB0FDZVq?=
 =?iso-8859-1?Q?j15sE2IkJMtPV8ayPnHQfTv7c1afxuphvkRLu79E/YL/6JEsuOCbU9hR2N?=
 =?iso-8859-1?Q?GQ3qZdQZx6DfEeWWvoSPayn2K6sAXWeIFeXu5aRlEYo/CzIQe0cQq6/dCA?=
 =?iso-8859-1?Q?ZZiIlxJ1VSg/j6d0Mcuz17l9HDyAlnipFk4vB9tsAkOWdE1XGYboi31Gaf?=
 =?iso-8859-1?Q?FZMhCrU7D+6G3YYtruk/2njstoLw4aqRl4zhfTWQeHScHfKv7MQDquOpT1?=
 =?iso-8859-1?Q?BuVKT0yEEGCBbs1889fK45pTgHaDaGDPYYPPcZnnXQUPrhC9d7iTHNrXu0?=
 =?iso-8859-1?Q?NVoOA6LxalhsBHQ7onSHFfCI/hL7DWVQJqVU1BZ+Jn2BgsIg55S+LUXf1h?=
 =?iso-8859-1?Q?6/AXMH59dDJldls4vrgocZ37uQHvNXXeWazgZR4lTo8xcrJNBC7Z9v9QQ7?=
 =?iso-8859-1?Q?EIKIMParRvu2BQmX7V88Pjf1Yi6LVPMZvyROcoSfOicc3+/z9D1joA1xD1?=
 =?iso-8859-1?Q?WWtiBiLNjgMtNgATQPHwkbIWgM0Wj9WkkI1dB+asUfWV09ZoyIB8v7dqLR?=
 =?iso-8859-1?Q?4gK9EgHPd/q5SMo04bM1DZidfzHX0YgNjkwBKoNPGN36bJ+QGEzgbr/LtW?=
 =?iso-8859-1?Q?Zk9vdN4b3JnyY6brJ+B2wrlarAnf20H4EJpbnpxJgw/xhNvwotYgSaTe91?=
 =?iso-8859-1?Q?yxgeiH9U+io5aWXfa9I/JB/4DYl/s2tNxnGRgB0LhcFfIfGp4TuFkuJq9R?=
 =?iso-8859-1?Q?GSaT+DW0/TbUpR/RvGZPf5yQ03BnMzqPOlkDPqKG+YyJR+RjZKShGIXtS1?=
 =?iso-8859-1?Q?Ns28OH/AD8wCei9PlK59+mBXRHDA99WUmJ3LlYb42Nv2viV2G/K1BMesEQ?=
 =?iso-8859-1?Q?WBGCLfwSRmnia3ABzUDq0T440ZWlLetIJuaYAZFnUJPH6X0uMMMcXP0Cwj?=
 =?iso-8859-1?Q?s/fiuCcbAAVNOKPqsvtujg7wFvOeK6fAt1810S9lFMTPJHfO0ucnzVGZvY?=
 =?iso-8859-1?Q?PumL7uka5nPDpI2NSvIRgpL5oQJGTXqSvOsyUthzAAH2jG1z3GZwCdVoL8?=
 =?iso-8859-1?Q?Xoy1XvuOkpnmb9cDzLgy8NQbr45e6sBRalr2BOIhcATEFg7Pqb8I065/2n?=
 =?iso-8859-1?Q?SsVhQ5+rS1rsWlTsRZXWKN/7NaHqGx/P0bcsV+8+LCDKb9zq0CL6asaO1h?=
 =?iso-8859-1?Q?w7SKhRree3K8YhhDgSIqlBRGyf+8STx4PTfS3k0qtlMqfwSVCdHuivkApN?=
 =?iso-8859-1?Q?iGDd9/0yhMBDaRzev9LnOfX4hydPuw8zfyQN3oUOGTw7Z8ocmp6lIu19AW?=
 =?iso-8859-1?Q?6WAqPnjEmE+NXXE31BsoHkEv5DzbtRoYENEQlReVcyPH66v71456FY1wXn?=
 =?iso-8859-1?Q?7ZKvFZw5EvGl3a6hU3aH3yszMtXhyzzWCdFGKyKcKrrJMCvQMXOiKVcy5K?=
 =?iso-8859-1?Q?SoXkI1cuNQvX6p+C0Bgexjmg8UR4mq6ML59L8rPCqlIhU4rofSkCUnTC4q?=
 =?iso-8859-1?Q?jkFcFYxw9OsjXSBRhLBZLiu72g0L32RzWNa8tuE6rk1kKhWUEDLed+L0/j?=
 =?iso-8859-1?Q?oQPw6s/P5wiMF2wlyY7iqdJNo96cXCFHc42Z4JlpN29wcc/Naejr3YyPN9?=
 =?iso-8859-1?Q?gcvaz+4hFKdkyh2iu22LyVVtrjHpBk1ZLZ78gW5uQc+8cIQglg9RB2zIqU?=
 =?iso-8859-1?Q?HstKWDORdi7b5YAjExuk+FIBgRp7xHc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hx8lN5GcUoy+TlnkdEVJlqCl9kjS0rHeG0ivhOvMlNj5mU79JFmOo1fQ5SzpgnTToJty01LysZpZJNhT3ybD1D4/X5PvbSeVv1TfMulp1Cl2PsN8QLc/k2M3L0s2tVqNFKzsRs+Bf1+cT0wz8lrifGglPld2Myb7rtnUY9tSPLffppDFvjm1DN8VRmslmJNaX6TV5orPrVGtToUjEeZNBhwSu79A4mb/dgMvyRO6Jrv9cP4RoYoYMtCSbXPOKhoJ+aZSbPPnfdp0pNIi9T9emmhJa9GTuVkAd5F8aW1L04fXbhL4IEqivsNM96hTdqnkMzN2+JFAANDVZTbWnvCpBQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6172.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5d85e1-7c6d-470c-5eb7-08df100faf21
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 14:19:25.8229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4z9OnT8g8150+osAQCUSHJ382+DYkW+pbdWatug4OvSQYKbhu+YzxwoQat7dQ19W1J4G8yI4FKkNo5/rocuA2i84DRG1/fZ5+Auy6qlTvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB11781
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfXwRanCdMtxaXp
 SAOMINIAY8cjJZQa3JTwmRE830RTf7yZ6z7rkZmenKJvv4IZ8bM+w6zjDJdjaDg6mwNkVj3X8gW
 IRD5YHfBO3i4qwimxbnkBq9KeK2JkdEU44wMCByVcizNDP6gZ/ZfbgAX8FdB0XGImNpyvOk5Wdw
 fMFJHTV1asQvUx5qBRrWf3O7Xfuk9sLcKotWHpixoCb+D24kh+TEFrE+AfBo+7UM5U7+prHFx0B
 YcrwOPestnRSsd1Dqod4a9R1ef7WZV1EmNp2jVMWwBX19m8jmf5UJei5TqSDt1WdASXpo4E92o+
 dOo00sSRcLjAnFmu1AqlG04P/L+Vh39mDyCqqxB0cbQyS8wdCyBOeIy7B7Q3/d7hDFcOd+ixB+G
 C8yBDfv2HgfqV6lpAPhM6/6U+J99RQiKm1Lw8DhTOvWZO6u9uGzVl3E5/xtsMPhS8JgXp0oz0Yu
 Dt0dZm0LvCLLeGu9dKw==
X-Authority-Analysis: v=2.4 cv=H5hOUOYi c=1 sm=1 tr=0 ts=6aa40df1 cx=c_pps
 a=kBs6TrnBGiNV6zZMgQ8KSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=64Cc0HZtAAAA:8
 a=4vskkdsKVMauzmvqB8UA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: nYI1rQJ8Yb1GWg8T4iTWtwYT9CicjQC-
X-Proofpoint-GUID: nYI1rQJ8Yb1GWg8T4iTWtwYT9CicjQC-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIwMCBTYWx0ZWRfXzWywih4rDg04
 Sf4TZWmpfzphVGnt4xEhFSOEZo/P/mveiGyc04QKCCNd5Ore2nMqLNpGDYxh0sgabElOZiE3mEy
 zw9qqu1R1WT0qf+wycyqOcbOUq4V+Lg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=hugo.komatsu@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Specify that the data_fd field must be explicitly set to -1 by the=0A=
server, rather than relying on client-side fixups.=0A=
=0A=
Clarify that the server must return an empty bitmap rather than=0A=
an error when reporting dirty pages for unmapped or message-based=0A=
DMA regions, as the client tracks these natively.=0A=
=0A=
Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>=0A=
Reviewed-by: John Levon <john.levon@nutanix.com>=0A=
---=0A=
 docs/interop/vfio-user.rst | 12 +++++++++---=0A=
 1 file changed, 9 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst=0A=
index 73282cd2dd..17c0f82355 100644=0A=
--- a/docs/interop/vfio-user.rst=0A=
+++ b/docs/interop/vfio-user.rst=0A=
@@ -1712,9 +1712,10 @@ structured as follows:=0A=
 | VFIO_DEVICE_STATE_PRE_COPY_P2P | 7     | (not used in vfio-user)        =
                                     |=0A=
 +--------------------------------+-------+--------------------------------=
-------------------------------------+=0A=
 =0A=
-* *data_fd* is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and=
=0A=
-  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration dat=
a=0A=
-  transport.=0A=
+* *data_fd* must be set to -1 in both the request and the response. It=0A=
+  is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and=0A=
+  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration=0A=
+  data transport.=0A=
 =0A=
 Direct State Transitions=0A=
 """"""""""""""""""""""""=0A=
@@ -1846,6 +1847,11 @@ The bitmap is an array of u64s that holds the output=
 bitmap, with 1 bit=0A=
 reporting a *page_size* unit of IOVA. The bits outside of the requested ra=
nge=0A=
 must be zero.=0A=
 =0A=
+If the server cannot translate the requested IOVA range (e.g. because it=
=0A=
+is unmapped, or accessed via message-based DMA), the server must return=0A=
+an empty (zeroed) bitmap rather than returning an error. The client=0A=
+natively tracks dirty pages for message-based DMA operations.=0A=
+=0A=
 The mapping of IOVA to bits is given by:=0A=
 ``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``=0A=
 =0A=
-- =0A=
2.39.3=0A=
=0A=

