Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1F0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDo1U-0003nC-RK; Tue, 28 Oct 2025 14:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo1G-0003ib-G8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1vDo10-0000NI-Db
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:02:05 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SFVX053264077; Tue, 28 Oct 2025 11:01:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Ze2uqv5aQp9M54pnUAdS5ZNu1eeYzFZoY9rEmLzSd
 +4=; b=T0KXUAdfGkXKSPukX1X8v/lkq0RuLHIAG2hje83R/CJOZ5Z3+ddmOUGBU
 yv35fkXgkWeoHobtcBgoUFTis+9bLPGpHFTEC0TD7XU2q6FJ8q0jKShIxthlB3ZG
 eD1gF52drVhBjRe+3ToE03SZCEPK88QbUDRaZJ3XD4B9GpqlPNXfkXG8K9Q4r6Wo
 fn9m5Awu2Rat8BxYvyhUw9EmkjTBSdAYMTZ16hwN/5/f0MUyB02PCxWACIRz2hQP
 6bmeX4dhibK6LFk0iWfLl4VwVm4nDGKNHPR0fRB3CNKslPD1ySmUe3FTGxsr7eLX
 NckcceqFQp+m3OPJA+tcJ0eIN8idA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021109.outbound.protection.outlook.com [52.101.52.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4a30j4gcqt-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 11:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/IfHf4v16sQ47uBYyZh6oPm1XRDbb6xue6Evyj4Nmcf5ImJQPeO7kbnJpdV5tmqimcrdlqYn3wybBtsPDawAxNiduppzaeRkfrQ2rD/HuV8NSl5zZ0s3PBGpdqavN5ITXtfj/XvLroU+hVCrT+XqaO8E1vh24Nt49uJ3eYhmi5gpWIWK5B5nLkpJ8GFxLQuPnwvNDkyhxfhUIhcPTCHzw4LTfqFWu4wsKZrNT9WrBNRC38NJC+5ZG6PwcTcGASrvfE6snXaQumf8Fw8Vw4uWLg1Q3yAuETuHOPk7QBKMtpyQ5ktGoPzIY699EWtvtZF/2TfsDp8OEDqQ5McSF5eow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze2uqv5aQp9M54pnUAdS5ZNu1eeYzFZoY9rEmLzSd+4=;
 b=Xp0xt2YXu5FEx6EdN1hWAMJHbG13xQc50f+B+q9OjQ9k8NxvPe7N1r0meDqHh/eI3MBmgnJcsIRjKmdRGt6kgbwST4w/Ntw7K5fBRSLi3uzcCWZql57SiZKunEBPKmc+mZTpGr3R635sCL3ijP81yqXgnkYfn4YnsaV6fP6azN2ygQO919L6Mq33VH2vTfTjzjFDR3y4ETmYPPyblsuYzbNHRz0uXXW3MJzGfr8JIgG4LiOZ6A3GnXgh+b3IsGJwHof58HfuK/9gE7IRwneubhVnOfhMIhm8TsvykGwPuFXLApmkWKenjtFDjBJGr0ExqnKaWKmG/QTlCjLrg6RAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze2uqv5aQp9M54pnUAdS5ZNu1eeYzFZoY9rEmLzSd+4=;
 b=hDPVP7iCMXeKPP1CCK7F7wM3S8VgHp7yNJ2Fto0X7HUCupzLGirA/+d27uwpSE/Q5Lc4nc8lFf94xQXMEJHD4VXU3fmCDgbx2P2huwUh1XEjPXlo1j2t4lxBNdP4L55pXEme34QJ/vv9/q1upn9copSQLIzmgd2gci489btOg4w6kOiUB0IGyj038WoE+3boNZzoC/SsocPI4LmrY3QYu8hJj0Yy5y1w97uExCc1GEZOpfdYAv5hheMZQi80Iulz8ZGXimH4GkziGHIqDFUn/FGiSUV7Wqp+WS57kluB/A95YLAKywWZpxuJ6ImDhwJ/K9bh+Nrm3Sp2s9/GwsmbKg==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by MWHPR02MB10548.namprd02.prod.outlook.com (2603:10b6:303:281::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:01:20 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:01:20 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "minyard@acm.org" <minyard@acm.org>
CC: "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, "corey@minyard.net" <corey@minyard.net>,
 Jonathan Davies <jond@nutanix.com>, "cornelia.huck@de.ibm.com"
 <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN channel
 config
Thread-Topic: [PATCH 1/2] hw/ipmi/ipmi_bmc_sim: Support getting fake LAN
 channel config
Thread-Index: AQHcSDTcH1pDlX4+/0KsuzktMTd+ng==
Date: Tue, 28 Oct 2025 18:01:19 +0000
Message-ID: <20251028180115.1098433-2-yunpeng.yang@nutanix.com>
References: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
In-Reply-To: <20251028180115.1098433-1-yunpeng.yang@nutanix.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|MWHPR02MB10548:EE_
x-ms-office365-filtering-correlation-id: 0aff7217-2a2a-47dc-c803-08de164c001f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gVY5Q5egMYTLykpoXY20nsrAMUfPrXTJF+Qp2EbTqtQI7F70HjZqvp/FLN?=
 =?iso-8859-1?Q?d8vaOXfOJeOJtJ0WfQy1/GCQaLPtz6hQTgH0RcmHsEC+LN8JEQ3sOlDuQ/?=
 =?iso-8859-1?Q?xiAj1EVJ/fkSzhZp/XH/0OijEy2mSF3plYc4hKgn4Tq1npHSK3UF8nn5p0?=
 =?iso-8859-1?Q?JN6EKBmgx7xM37fUNfMngN1RLmTvdUNi+0mBtDjbF3TsAY7BXDvDb2tk2j?=
 =?iso-8859-1?Q?DqyMMxJVKX+rKEDKjdtW7aHoE9/+9q9w0B64pcUixA4bJdoYnt4Py6rVZB?=
 =?iso-8859-1?Q?4lNCz1kdL0OS94crxj27r9L1l3+Ha5Cf51B2+M5ZoLdBDbwpLVL2yIyAKy?=
 =?iso-8859-1?Q?baa0DEmMGDGD5TWJGuufWmXTQhUU979zZuBa96TODPBbavnaDVqk+GrFb8?=
 =?iso-8859-1?Q?EWFLNVqi35ozR3lysgRki+4ux9YL+saoOA+b0yT6VfAAbbAJbs9wZnrWRr?=
 =?iso-8859-1?Q?1FVA9zsAIYsZ0RnTYd/PGPZclVwrJvEnTHOY3/tLyC7IrGlyC6k5O1Jj/1?=
 =?iso-8859-1?Q?V3xwM9nZuji+7kWyS1j7gFKRGWxuHr++7kdw6mtUIdq2bzhydzeIr2NxAZ?=
 =?iso-8859-1?Q?x+fRqelCa/6HYIvvRsnOkL+Ilt1+8lGaugnRW9hxJiPLFdmlrn7xpsoGzC?=
 =?iso-8859-1?Q?/Q+nRZXu2ZgfbpKSFwykA/UdQpP8QE8IMXjpaXaZV40H7F5gDJXL1P9JZ8?=
 =?iso-8859-1?Q?bnUx1WPP7L6xF5zp9LUb08Fx54WsmyQZa10LaYaNiwjZwSqQmdhiIjCjQW?=
 =?iso-8859-1?Q?oRIKkh31/7dhUoCRMcRtYw1a93C4wtqB+Y3TNk/9TLClPvW5GJu7sHUKMk?=
 =?iso-8859-1?Q?7CcYqtj+2tStlD3XRL1QzfdsK3ZtyMYuuaA8NA5jPTSIujvKkqKNdoANwQ?=
 =?iso-8859-1?Q?//p2ceA9mlud2yBlroyjQB3KDvc1IYvGQScdqL4RlMRY/mr7X3AsazMkjx?=
 =?iso-8859-1?Q?dlNKDoB33Edf9fGzN4TQcxPF/v7H7kdvswp7CGfntWjQSry2R+5nekPtA1?=
 =?iso-8859-1?Q?UxPVVDeTZ5qBaSq9aOjDDjG8DT/q+1Mc3uteQdP4yDRuD74SgURiWVCTHe?=
 =?iso-8859-1?Q?e786Q2OCYBXrYw7blBZESSVn0EOJhKPRteXEjQ9x8Aqgu0Z1yR6YPAfuYF?=
 =?iso-8859-1?Q?Yfy/M4alrEq3+dwW2Qjld7HMRGvC7Bf+c6c6YoP/UIwaAR5omIW8qPDMKl?=
 =?iso-8859-1?Q?RlKnSFh/+Hjx/QpylKwzUr1DmqVh6YeFgODW3HqEoKRw64isQzau5NJU1a?=
 =?iso-8859-1?Q?ohm97nNYbqmjkMjp+rDvPV7Os2F5VkSPwZbKsBqpYkV9DaiE1666AdA0zE?=
 =?iso-8859-1?Q?HRWTJpQLcOGLa/oO4i/woeV8RQu/EM9RrtpjBlBQjbPCI9TOBIc7DlAu7I?=
 =?iso-8859-1?Q?jLkwfLBqh86JPlfouqBent/306A+u0d3NpvflHsOhQm9gE6NMDjMimaNeV?=
 =?iso-8859-1?Q?wId5/jQHvhLl1q0nlUwcC14GPkwlDvOpruG4uJIUlSjx/eTeqyyYmylhXa?=
 =?iso-8859-1?Q?JFch8kmE9MCRYKfq+QITI8/m/vghenjfGpBYa8q3LU9HwoazXgLu/gzOyg?=
 =?iso-8859-1?Q?6Na+QPpB7GNbBt2J4hqfcBlYuZjy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AnRFz7oJWI6smkU1nskr+LGAAucUpfkEj3R8G29mKr3oS/6fOWLdzlRdmf?=
 =?iso-8859-1?Q?Sw8fpqF9ifZnp/GFik8mMcv+P81Sy7lWMdwmj54EnNUbcvDs2Zmpa59J8v?=
 =?iso-8859-1?Q?H3CVUPwkQz7Tc3Lgsv36hddm6T6iF1mrkZ5BFjdUtfe6AgroMre6unF3On?=
 =?iso-8859-1?Q?WJBnlMHMvd59gW7cDBzzjw+rElJHX1lQleDJFxncaTTGEIosE3fcVZ+B05?=
 =?iso-8859-1?Q?YQUcanuhQAozeZNU42+0MoAOD5+I+/vSWs6MQ7xmTWW2qHt5wUt4nRMO++?=
 =?iso-8859-1?Q?TQaGk38e4XnY8qrtpL8FuOdHI0BN5dXXhWkCN0J8lJxLXd+F17WW0QFjB4?=
 =?iso-8859-1?Q?Dm++c9lBXxiHhGqxCNIlzVZKZsb3JlAb52mF4cZNVUV7s5xqvxGnUITB/h?=
 =?iso-8859-1?Q?t8YMY4Yt8Jdg74CjQUxsw3S/p5yGhmT1D/vQtj86X+M9epIIhmbOZpShyj?=
 =?iso-8859-1?Q?7COLP++QXBK+DOtXurib1Ma6Ce0CK7j8iTduZPYyWXPDX9XeC18g14MT6G?=
 =?iso-8859-1?Q?qHD7rtpBEUGLZ5/JC+zwgc4ZNI1vIchrWF8FtvINCfdkF100EIdKbcgGJi?=
 =?iso-8859-1?Q?MSQ/Vr+MxiTroN2GKjUi0be9wXB8f+AVEMWtrhuI5s1/Py5nYZqgNJIx1z?=
 =?iso-8859-1?Q?wVCU4O+v5eEWUG2G5jx2fhPpcmiKN7X7qekVGNsVXy4apNRULnFW2d3f2s?=
 =?iso-8859-1?Q?pXqurUThyzXi0xVIW2Uw7iJlR2gqAkuhPA3Ncssp6akJvu+Dt7n3ICP6Yw?=
 =?iso-8859-1?Q?xcVKDEfaaILIjH0Xeqt85vMC1E4AP/TVLM/zhAZ5X6sBOyYi1p1jNLHqXo?=
 =?iso-8859-1?Q?x6VrUGlrJ68hrxhShX1j4dB26MRm2RtBD4dclgnqE02pAw3UZDkbuLADkP?=
 =?iso-8859-1?Q?02lX9TkLWDYAPp1JtLuOQBG7lilvSRSxcL6rPl8F9wZr9wnqygg85LMtQj?=
 =?iso-8859-1?Q?vKPIZHFhC3GpnLrW06Q8wp33RhYido12X2Gj4LtXKVljLeXwRYnQqImEDi?=
 =?iso-8859-1?Q?8r4DgpvIWPdRISFkBUw152oMXYwHZi6sbMjVi+YxsXWUz4fFgH7tz37s6q?=
 =?iso-8859-1?Q?qlG9XnmcKxpAZYnjMlDa/QBcuAYPYfSIKWdTskp4L1OCGULV6fG1YGAlX9?=
 =?iso-8859-1?Q?570jCMiOzdTkm3w3WXUr6U644dc6x2r0l2NaPkYaEKSV4JAEc+S6Lhvj6U?=
 =?iso-8859-1?Q?OcxuIyUsQSKHPbtP2ytWrC8K0Xinkc83M6q2tHu8LjNGKkl5VoiLtRrcHO?=
 =?iso-8859-1?Q?+m3FZmMDbCOLYfH5KFl1eH/hA7HuuTfaJZIDCJ0JB2nktjzu0sfMWVzAWM?=
 =?iso-8859-1?Q?nvSP9Nh2PkGjDgp5mRncDcHO8RW+10ARh5EIKfZnT52jT0xKIIi2py8tU/?=
 =?iso-8859-1?Q?X0AfyQbyto42cxHQ8vTjKKPuzmwpncneJ0tFTtcOz2yoJAxcRlGWbV7wLA?=
 =?iso-8859-1?Q?8Z4OvQa9c64hLQ/CXojeetOqQlwk5LROcUbhSZlMDVUBogYbr0gEUikv43?=
 =?iso-8859-1?Q?F0yq/0Pz/DHU8NafNYCBJzAJLf6m6YcOu18ckE4Zcw/zcZJLfDnp9U+QzS?=
 =?iso-8859-1?Q?svBvpbtF/rpBQwC5PcMuvwWYcyiXCAnDhVLIps9Q3UuA0b/2Ec6jtnzzkW?=
 =?iso-8859-1?Q?liyw6H1PdjdM40p+obzYeKj7oGU+NE5jrPlYiA71rz0wXzbBVBvArt9g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff7217-2a2a-47dc-c803-08de164c001f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 18:01:19.7464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwiXjyyf7pLl5tYK/vVz3lHbr6zf8mYdACthGyqndf/8d2NtP7HiL+ZCZIaCV60HGWciOOXtvde2Wj2vnKPYXXjRGv4UcyfmUToRbmEj1yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10548
X-Proofpoint-GUID: VceG0pb_Vm7kB2AinTOLR96EUlkFQosc
X-Authority-Analysis: v=2.4 cv=FJYWBuos c=1 sm=1 tr=0 ts=690104f3 cx=c_pps
 a=eErdSk/Sa828lcK029XJ5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=pTf6PJ8vMGm95pvt50EA:9 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MiBTYWx0ZWRfXxCubsFN8nbRU
 1RFgehQThioBAx9LqeA6+YMVZulprCRn8IOdXRkps+BI0ERcl4ExooPeIldK8L2dr+erx87+LZ3
 +5tSF9tcr8OCXechC++o1oBDR6nBR8c/s8Wkio3mZip27A92GAW7n8SsptRwYPO2HnZNDhXgt06
 IFRYGL7J0VqVpWoIO4cyZBcPJqRo7MtF1duf0KSey46kTAQ5Tsyyw3MZZ+AoYbliyEcPdrWZt7/
 MRTHisNC6oRBq03Oazfj+z903yb69Xyn4/I9VwB5Uy9OUYA8YBM5JgmJD9P8Fcc69rhAwlKPbk8
 UWXDcFu++QuH1KN6/UzEPpCoAyXCp8bzOV8n2cmD/FKZL0BtnLKrU6CqokfKGoV3oiJBIVv+WlQ
 NxdOvcdCJBqcx/RDJxcDScEHiTPuDA==
X-Proofpoint-ORIG-GUID: VceG0pb_Vm7kB2AinTOLR96EUlkFQosc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001 autolearn=ham autolearn_force=no
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

The following IPMI commands are added or modified to support getting=0A=
fake LAN channel configurations from the `ipmi_bmc_sim` device:=0A=
* Get Channel Access;=0A=
* Get Channel Info Command;=0A=
* Get LAN Configuration Parameters.=0A=
=0A=
The fake LAN channel configurations can be specified from QEMU=0A=
commandline options for device `ipmi_bmc_sim`. Inside the guest OS, the=0A=
configurations can be retrieved from the device using some IPMI tools,=0A=
e.g., `ipmitool lan print`.=0A=
Note, there is not a real LAN channel. The fake LAN channel is suitable=0A=
for testing purposes.=0A=
=0A=
Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>=0A=
---=0A=
 hw/ipmi/ipmi_bmc_sim.c      | 297 ++++++++++++++++++++++++++++++++++--=0A=
 include/hw/ipmi/ipmi.h      |   1 +=0A=
 qemu-options.hx             |  26 ++++=0A=
 tests/qtest/ipmi-kcs-test.c |  60 ++++++++=0A=
 4 files changed, 374 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c=0A=
index 04e1dcd0e7..2ead46ee55 100644=0A=
--- a/hw/ipmi/ipmi_bmc_sim.c=0A=
+++ b/hw/ipmi/ipmi_bmc_sim.c=0A=
@@ -27,11 +27,13 @@=0A=
 #include "qemu/timer.h"=0A=
 #include "hw/ipmi/ipmi.h"=0A=
 #include "qemu/error-report.h"=0A=
+#include "qapi/error.h"=0A=
 #include "qemu/module.h"=0A=
 #include "hw/loader.h"=0A=
 #include "hw/qdev-properties.h"=0A=
 #include "hw/qdev-properties-system.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "net/net.h"=0A=
 =0A=
 #define IPMI_NETFN_CHASSIS            0x00=0A=
 =0A=
@@ -70,6 +72,7 @@=0A=
 #define IPMI_CMD_GET_MSG                  0x33=0A=
 #define IPMI_CMD_SEND_MSG                 0x34=0A=
 #define IPMI_CMD_READ_EVT_MSG_BUF         0x35=0A=
+#define IPMI_CMD_GET_CHANNEL_ACCESS       0x41=0A=
 #define IPMI_CMD_GET_CHANNEL_INFO         0x42=0A=
 =0A=
 #define IPMI_NETFN_STORAGE            0x0a=0A=
@@ -101,6 +104,10 @@=0A=
 #define IPMI_CMD_GET_SEL_TIME             0x48=0A=
 #define IPMI_CMD_SET_SEL_TIME             0x49=0A=
 =0A=
+#define IPMI_NETFN_TRANSPORT          0x0c=0A=
+=0A=
+#define IPMI_CMD_GET_LAN_CONFIG           0x02=0A=
+=0A=
 =0A=
 /* Same as a timespec struct. */=0A=
 struct ipmi_time {=0A=
@@ -170,6 +177,23 @@ typedef struct IPMISensor {=0A=
 #define MAX_SENSORS 20=0A=
 #define IPMI_WATCHDOG_SENSOR 0=0A=
 =0A=
+#define NBYTES_IP  4=0A=
+#define NBYTES_MAC 6=0A=
+=0A=
+typedef struct IPMILan {=0A=
+    uint8_t channel;=0A=
+    uint8_t ipaddr[NBYTES_IP];=0A=
+    uint8_t ipsrc;=0A=
+    MACAddr macaddr;=0A=
+    uint8_t netmask[NBYTES_IP];=0A=
+    uint8_t defgw_ipaddr[NBYTES_IP];=0A=
+    MACAddr defgw_macaddr;=0A=
+=0A=
+    char *arg_ipaddr;=0A=
+    char *arg_netmask;=0A=
+    char *arg_defgw_ipaddr;=0A=
+} IPMILan;=0A=
+=0A=
 #define MAX_NETFNS 64=0A=
 =0A=
 typedef struct IPMIRcvBufEntry {=0A=
@@ -215,6 +239,7 @@ struct IPMIBmcSim {=0A=
     IPMIFru fru;=0A=
     IPMISensor sensors[MAX_SENSORS];=0A=
     char *sdr_filename;=0A=
+    IPMILan lan;=0A=
 =0A=
     /* Odd netfns are for responses, so we only need the even ones. */=0A=
     const IPMINetfn *netfns[MAX_NETFNS / 2];=0A=
@@ -265,6 +290,36 @@ struct IPMIBmcSim {=0A=
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2=0A=
 #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3=0A=
 =0A=
+#define IPMI_CHANNEL_IMPLEMENTATION_MIN    0x1=0A=
+#define IPMI_CHANNEL_IMPLEMENTATION_MAX    0xb=0A=
+#define IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(c) \=0A=
+    (IPMI_CHANNEL_IMPLEMENTATION_MIN <=3D (c) && \=0A=
+     (c) <=3D IPMI_CHANNEL_IMPLEMENTATION_MAX)=0A=
+=0A=
+#define IPMI_BMC_CHANNEL_IS_LAN(ibs, c) \=0A=
+    ((ibs)->lan.channel !=3D 0 && (ibs)->lan.channel =3D=3D (c))=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES      0x02=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR                0x03=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE         0x04=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR               0x05=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK            0x06=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS        0x07=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR     0x0c=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR    0x0d=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR         0x0e=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR     0x0f=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING       0x10=0A=
+#define IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS       0x11=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_PARAMETER_REVISION    0x11=0A=
+=0A=
+#define IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(v)    (0x0 <=3D (v) && (v) <=
=3D 0x4)=0A=
+=0A=
 #define RSP_BUFFER_INITIALIZER { }=0A=
 =0A=
 static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,=0A=
@@ -1231,6 +1286,25 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,=0A=
     }=0A=
 }=0A=
 =0A=
+static void get_channel_access(IPMIBmcSim *ibs,=0A=
+                               uint8_t *cmd, unsigned int cmd_len,=0A=
+                               RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel =3D cmd[2] & 0xf;=0A=
+=0A=
+    if (channel =3D=3D IPMI_CHANNEL_IPMB || channel =3D=3D IPMI_CHANNEL_SY=
STEM ||=0A=
+        IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        /* alerting disabled */=0A=
+        /* per message authentication disabled */=0A=
+        /* user level authentication disabled */=0A=
+        /* channel always available */=0A=
+        rsp_buffer_push(rsp, 0x20 | 0x10 | 0x08 | 0x02);=0A=
+        rsp_buffer_push(rsp, 0x04);  /* privilege limit: ADMINISTRATOR */=
=0A=
+    } else {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void get_channel_info(IPMIBmcSim *ibs,=0A=
                              uint8_t *cmd, unsigned int cmd_len,=0A=
                              RspBuffer *rsp)=0A=
@@ -1240,29 +1314,29 @@ static void get_channel_info(IPMIBmcSim *ibs,=0A=
     IPMIFwInfo info =3D {};=0A=
     uint8_t ch =3D cmd[2] & 0x0f;=0A=
 =0A=
-    /* Only define channel 0h (IPMB) and Fh (system interface) */=0A=
-=0A=
     if (ch =3D=3D 0x0e) { /* "This channel" */=0A=
         ch =3D IPMI_CHANNEL_SYSTEM;=0A=
     }=0A=
     rsp_buffer_push(rsp, ch);=0A=
 =0A=
-    if (ch !=3D IPMI_CHANNEL_IPMB && ch !=3D IPMI_CHANNEL_SYSTEM) {=0A=
-        /* Not a supported channel */=0A=
-        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
-        return;=0A=
-    }=0A=
-=0A=
     if (k->get_fwinfo) {=0A=
         k->get_fwinfo(s, &info);=0A=
     }=0A=
 =0A=
+    /* Only define channel 0h (IPMB), LAN, and Fh (system interface) */=0A=
     if (ch =3D=3D IPMI_CHANNEL_IPMB) {=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_IPMB);=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);=0A=
-    } else { /* IPMI_CHANNEL_SYSTEM */=0A=
+    } else if (IPMI_BMC_CHANNEL_IS_LAN(ibs, ch)) {=0A=
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_802_3_LAN);=0A=
+        rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);=0A=
+    } else if (ch =3D=3D IPMI_CHANNEL_SYSTEM) {=0A=
         rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_SYSTEM);=0A=
         rsp_buffer_push(rsp, info.ipmi_channel_protocol);=0A=
+    } else {=0A=
+        /* Not a supported channel */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
     }=0A=
 =0A=
     rsp_buffer_push(rsp, 0x00); /* Session-less */=0A=
@@ -2045,6 +2119,140 @@ static void set_sensor_reading(IPMIBmcSim *ibs,=0A=
     }=0A=
 }=0A=
 =0A=
+static inline bool is_valid_netmask(const uint8_t *netmask)=0A=
+{=0A=
+    uint32_t mask =3D netmask[3];=0A=
+    uint32_t inverted;=0A=
+=0A=
+    mask |=3D (uint32_t) netmask[2] << 8;=0A=
+    mask |=3D (uint32_t) netmask[1] << 16;=0A=
+    mask |=3D (uint32_t) netmask[0] << 24;=0A=
+    inverted =3D ~mask;=0A=
+    return mask !=3D 0 && (inverted & (inverted + 1)) =3D=3D 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Request data (from cmd[2] to cmd[5] inclusive):=0A=
+ * bytes   meaning=0A=
+ *    1    [bit 7] revision only flag, [bits 3:0] channel number=0A=
+ *    2    parameter selector=0A=
+ *    3    set selector=0A=
+ *    4    block selector=0A=
+ */=0A=
+static void get_lan_config(IPMIBmcSim *ibs,=0A=
+                           uint8_t *cmd, unsigned int cmd_len,=0A=
+                           RspBuffer *rsp)=0A=
+{=0A=
+    uint8_t channel;=0A=
+=0A=
+    if (ibs->lan.channel =3D=3D 0) {=0A=
+        /* LAN channel disabled. Fail as if this command were not defined.=
 */=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd_len < 6) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);=0A=
+        return;=0A=
+    }=0A=
+    channel =3D cmd[2] & 0xf;=0A=
+=0A=
+    rsp_buffer_push(rsp, IPMI_BMC_LAN_CFG_PARAMETER_REVISION);=0A=
+    if (cmd[2] & 0x80) {=0A=
+        /* The requester only requests parameter revision, not the paramet=
er */=0A=
+        return;=0A=
+    }=0A=
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {=0A=
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (cmd[3]) {=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:=0A=
+        rsp_buffer_push(rsp, 0x0);  /* set complete */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:=0A=
+        rsp_buffer_push(rsp, 0x01); /* Authentication type "none" supporte=
d */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:=0A=
+        /* Only authentication type "none" enabled */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Callback" */=
=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "User" */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Operator" */=
=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "Administrator"=
 */=0A=
+        rsp_buffer_push(rsp, 0x01); /* for privilege level "OEM" */=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.ipaddr, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:=0A=
+        rsp_buffer_push(rsp, ibs->lan.ipsrc);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.macaddr.a, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.netmask, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:=0A=
+        /* TTL 0x40 */=0A=
+        rsp_buffer_push(rsp, 0x40);=0A=
+        /* don't fragment */=0A=
+        rsp_buffer_push(rsp, 0x40);=0A=
+        /* precedence 0x0, minimize delay */=0A=
+        rsp_buffer_push(rsp, 0x10);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_ipaddr, NBYTES_IP);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:=0A=
+        rsp_buffer_pushmore(rsp, ibs->lan.defgw_macaddr.a, NBYTES_MAC);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:=0A=
+        /* 0.0.0.0 */=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:=0A=
+        /* 00:00:00:00:00:00 */=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        rsp_buffer_push(rsp, 0x00);=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:=0A=
+        {=0A=
+            static uint8_t community_str[18] =3D "public";=0A=
+=0A=
+            rsp_buffer_pushmore(rsp, community_str, sizeof(community_str))=
;=0A=
+        }=0A=
+        break;=0A=
+=0A=
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:=0A=
+        rsp_buffer_push(rsp, 0x00); /* LAN Alerting not supported */=0A=
+        break;=0A=
+=0A=
+    default:=0A=
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED)=
;=0A=
+        return;=0A=
+    };=0A=
+}=0A=
+=0A=
 static const IPMICmdHandler chassis_cmds[] =3D {=0A=
     [IPMI_CMD_GET_CHASSIS_CAPABILITIES] =3D { chassis_capabilities },=0A=
     [IPMI_CMD_GET_CHASSIS_STATUS] =3D { chassis_status },=0A=
@@ -2089,6 +2297,7 @@ static const IPMICmdHandler app_cmds[] =3D {=0A=
     [IPMI_CMD_RESET_WATCHDOG_TIMER] =3D { reset_watchdog_timer },=0A=
     [IPMI_CMD_SET_WATCHDOG_TIMER] =3D { set_watchdog_timer, 8 },=0A=
     [IPMI_CMD_GET_WATCHDOG_TIMER] =3D { get_watchdog_timer },=0A=
+    [IPMI_CMD_GET_CHANNEL_ACCESS] =3D { get_channel_access, 4 },=0A=
     [IPMI_CMD_GET_CHANNEL_INFO] =3D { get_channel_info, 3 },=0A=
 };=0A=
 static const IPMINetfn app_netfn =3D {=0A=
@@ -2119,12 +2328,22 @@ static const IPMINetfn storage_netfn =3D {=0A=
     .cmd_handlers =3D storage_cmds=0A=
 };=0A=
 =0A=
+static const IPMICmdHandler transport_cmds[] =3D {=0A=
+    [IPMI_CMD_GET_LAN_CONFIG] =3D { get_lan_config },=0A=
+};=0A=
+static const IPMINetfn transport_netfn =3D {=0A=
+    .cmd_nums =3D ARRAY_SIZE(transport_cmds),=0A=
+    .cmd_handlers =3D transport_cmds=0A=
+};=0A=
+=0A=
+=0A=
 static void register_cmds(IPMIBmcSim *s)=0A=
 {=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_CHASSIS, &chassis_netfn);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_SENSOR_EVENT, &sensor_event_netf=
n);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_APP, &app_netfn);=0A=
     ipmi_sim_register_netfn(s, IPMI_NETFN_STORAGE, &storage_netfn);=0A=
+    ipmi_sim_register_netfn(s, IPMI_NETFN_TRANSPORT, &transport_netfn);=0A=
 }=0A=
 =0A=
 static uint8_t init_sdrs[] =3D {=0A=
@@ -2176,7 +2395,7 @@ static void ipmi_sdr_init(IPMIBmcSim *ibs)=0A=
 =0A=
 static const VMStateDescription vmstate_ipmi_sim =3D {=0A=
     .name =3D TYPE_IPMI_BMC_SIMULATOR,=0A=
-    .version_id =3D 1,=0A=
+    .version_id =3D 2,=0A=
     .minimum_version_id =3D 1,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT8(bmc_global_enables, IPMIBmcSim),=0A=
@@ -2198,6 +2417,13 @@ static const VMStateDescription vmstate_ipmi_sim =3D=
 {=0A=
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].deassert_states,=0A=
                        IPMIBmcSim),=0A=
         VMSTATE_UINT16(sensors[IPMI_WATCHDOG_SENSOR].assert_enable, IPMIBm=
cSim),=0A=
+        VMSTATE_UINT8_V(lan.channel, IPMIBmcSim, 2),=0A=
+        VMSTATE_UINT8_ARRAY_V(lan.ipaddr, IPMIBmcSim, NBYTES_IP, 2),=0A=
+        VMSTATE_UINT8_V(lan.ipsrc, IPMIBmcSim, 2),=0A=
+        VMSTATE_UINT8_ARRAY_V(lan.macaddr.a, IPMIBmcSim, NBYTES_MAC, 2),=
=0A=
+        VMSTATE_UINT8_ARRAY_V(lan.netmask, IPMIBmcSim, NBYTES_IP, 2),=0A=
+        VMSTATE_UINT8_ARRAY_V(lan.defgw_ipaddr, IPMIBmcSim, NBYTES_IP, 2),=
=0A=
+        VMSTATE_UINT8_ARRAY_V(lan.defgw_macaddr.a, IPMIBmcSim, NBYTES_MAC,=
 2),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
@@ -2232,6 +2458,47 @@ out:=0A=
     fru->nentries =3D size / fru->areasize;=0A=
 }=0A=
 =0A=
+static void ipmi_lan_init(IPMILan *lan, Error **errp)=0A=
+{=0A=
+    struct in_addr ip;=0A=
+=0A=
+    /*=0A=
+     * `lan->channel` can be either 0 (meaning LAN channel disabled) or=0A=
+     * a valid IPMI implementation-specific channel.=0A=
+     */=0A=
+    if (lan->channel !=3D 0 &&=0A=
+        !IPMI_CHANNEL_IS_IMPLEMENTATION_SPECIFIC(lan->channel)) {=0A=
+        error_setg(errp, "invalid LAN channel %d", lan->channel);=0A=
+        return;=0A=
+    }=0A=
+    if (lan->arg_ipaddr) {=0A=
+        if (inet_pton(AF_INET, lan->arg_ipaddr, &ip) !=3D 1) {=0A=
+            error_setg(errp, "invalid ip address '%s'", lan->arg_ipaddr);=
=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->ipaddr, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+    if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(lan->ipsrc)) {=0A=
+        error_setg(errp, "invalid ip source %d", lan->ipsrc);=0A=
+        return;=0A=
+    }=0A=
+    if (lan->arg_netmask) {=0A=
+        if (inet_pton(AF_INET, lan->arg_netmask, &ip) !=3D 1 ||=0A=
+            !is_valid_netmask((const uint8_t *) &ip.s_addr)) {=0A=
+            error_setg(errp, "invalid subnet mask '%s'", lan->arg_netmask)=
;=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->netmask, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+    if (lan->arg_defgw_ipaddr) {=0A=
+        if (inet_pton(AF_INET, lan->arg_defgw_ipaddr, &ip) !=3D 1) {=0A=
+            error_setg(errp, "invalid ip address '%s'", lan->arg_defgw_ipa=
ddr);=0A=
+            return;=0A=
+        }=0A=
+        memcpy(lan->defgw_ipaddr, &ip.s_addr, NBYTES_IP);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void ipmi_sim_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     IPMIBmc *b =3D IPMI_BMC(dev);=0A=
@@ -2259,6 +2526,9 @@ static void ipmi_sim_realize(DeviceState *dev, Error =
**errp)=0A=
     ibs->acpi_power_state[1] =3D 0;=0A=
 =0A=
     ipmi_init_sensors_from_sdrs(ibs);=0A=
+=0A=
+    ipmi_lan_init(&ibs->lan, errp);=0A=
+=0A=
     register_cmds(ibs);=0A=
 =0A=
     ibs->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);=0A=
@@ -2276,6 +2546,13 @@ static const Property ipmi_sim_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),=0A=
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),=0A=
     DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),=0A=
+    DEFINE_PROP_UINT8("lan.channel", IPMIBmcSim, lan.channel, 0),=0A=
+    DEFINE_PROP_STRING("lan.ipaddr", IPMIBmcSim, lan.arg_ipaddr),=0A=
+    DEFINE_PROP_UINT8("lan.ipsrc", IPMIBmcSim, lan.ipsrc, 0),=0A=
+    DEFINE_PROP_MACADDR("lan.macaddr", IPMIBmcSim, lan.macaddr),=0A=
+    DEFINE_PROP_STRING("lan.netmask", IPMIBmcSim, lan.arg_netmask),=0A=
+    DEFINE_PROP_STRING("lan.defgw_ipaddr", IPMIBmcSim, lan.arg_defgw_ipadd=
r),=0A=
+    DEFINE_PROP_MACADDR("lan.defgw_macaddr", IPMIBmcSim, lan.defgw_macaddr=
),=0A=
 };=0A=
 =0A=
 static void ipmi_sim_class_init(ObjectClass *oc, const void *data)=0A=
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h=0A=
index cd581aa134..3435d84178 100644=0A=
--- a/include/hw/ipmi/ipmi.h=0A=
+++ b/include/hw/ipmi/ipmi.h=0A=
@@ -45,6 +45,7 @@ enum ipmi_op {=0A=
 #define IPMI_CHANNEL_IPMB                0x00=0A=
 #define IPMI_CHANNEL_SYSTEM              0x0f=0A=
 #define IPMI_CHANNEL_MEDIUM_IPMB         0x01=0A=
+#define IPMI_CHANNEL_MEDIUM_802_3_LAN    0x04=0A=
 #define IPMI_CHANNEL_MEDIUM_SYSTEM       0x0c=0A=
 #define IPMI_CHANNEL_PROTOCOL_IPMB       0x01=0A=
 #define IPMI_CHANNEL_PROTOCOL_KCS        0x05=0A=
diff --git a/qemu-options.hx b/qemu-options.hx=0A=
index 0223ceffeb..100226d84b 100644=0A=
--- a/qemu-options.hx=0A=
+++ b/qemu-options.hx=0A=
@@ -1142,6 +1142,32 @@ SRST=0A=
         is set, get "Get GUID" command to the BMC will return it.=0A=
         Otherwise "Get GUID" will return an error.=0A=
 =0A=
+    ``lan.channel=3Dval``=0A=
+        channel number of the fake LAN channel. It can be 0 or any=0A=
+        integer from 0x1 to 0xb inclusive. If set to 0, the LAN channel=0A=
+        is disabled, otherwise the LAN channel is enabled at the=0A=
+        specified channel number. The default is 0.=0A=
+=0A=
+    ``lan.ipaddr=3Daddr``=0A=
+        the ipv4 address of the BMC LAN channel.=0A=
+=0A=
+    ``lan.ipsrc=3Dval``=0A=
+        the ipv4 address source of the BMC LAN channel. It can be 0=0A=
+        (unspecified source), 1 (static address), 2 (DHCP), 3 (BIOS or=0A=
+        system software), or 4 (other source). The default is 0.=0A=
+=0A=
+    ``lan.macaddr=3Dmac``=0A=
+        the mac address of the BMC LAN channel.=0A=
+=0A=
+    ``lan.netmask=3Dmask``=0A=
+        the ipv4 subnet mask for the BMC LAN channel.=0A=
+=0A=
+    ``lan.defgw_ipaddr=3Daddr``=0A=
+        the default gateway ipv4 address for the BMC LAN channel.=0A=
+=0A=
+    ``lan.defgw_macaddr=3Dmac``=0A=
+        the default gateway mac address for the BMC LAN channel.=0A=
+=0A=
 ``-device ipmi-bmc-extern,id=3Did,chardev=3Did[,slave_addr=3Dval]``=0A=
     Add a connection to an external IPMI BMC simulator. Instead of=0A=
     locally emulating the BMC like the above item, instead connect to an=
=0A=
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c=0A=
index 3186c6ad64..d0a207477e 100644=0A=
--- a/tests/qtest/ipmi-kcs-test.c=0A=
+++ b/tests/qtest/ipmi-kcs-test.c=0A=
@@ -262,6 +262,62 @@ static void test_enable_irq(void)=0A=
     kcs_ints_enabled =3D 1;=0A=
 }=0A=
 =0A=
+=0A=
+static uint8_t get_channel_access_cmd[] =3D { 0x18, 0x41, 0x01, 0x40 };=0A=
+static uint8_t get_channel_access_rsp[] =3D { 0x1c, 0x41, 0x00, 0x3a, 0x04=
 };=0A=
+=0A=
+/*=0A=
+ * Get channel access=0A=
+ */=0A=
+static void test_kcs_channel_access(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_channel_access_cmd, sizeof(get_channel_access_cmd),=0A=
+            rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_channel_access_rsp));=0A=
+    g_assert(memcmp(get_channel_access_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
+static uint8_t get_channel_info_cmd[] =3D { 0x18, 0x42, 0x01 };=0A=
+static uint8_t get_channel_info_rsp[] =3D { 0x1c, 0x42, 0x00, 0x01, 0x04, =
0x01,=0A=
+                                          0x00, 0xf2, 0x1b, 0x00, 0x00, 0x=
00 };=0A=
+=0A=
+/*=0A=
+ * Get channel info=0A=
+ */=0A=
+static void test_kcs_channel_info(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_channel_info_cmd, sizeof(get_channel_info_cmd), rsp, &rspl=
en);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_channel_info_rsp));=0A=
+    g_assert(memcmp(get_channel_info_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
+/* get ip address (specified in cmdline): 10.0.0.2 */=0A=
+static uint8_t get_ipaddr_cmd[] =3D { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 }=
;=0A=
+static uint8_t get_ipaddr_rsp[] =3D { 0x34, 0x02, 0x00, 0x11,=0A=
+                                    0x0a, 0x00, 0x00, 0x02 };=0A=
+=0A=
+/*=0A=
+ * Get LAN configurations=0A=
+ */=0A=
+static void test_kcs_lan_get(void)=0A=
+{=0A=
+    uint8_t rsp[20];=0A=
+    unsigned int rsplen =3D sizeof(rsp);=0A=
+=0A=
+    kcs_cmd(get_ipaddr_cmd, sizeof(get_ipaddr_cmd), rsp, &rsplen);=0A=
+    g_assert(rsplen =3D=3D sizeof(get_ipaddr_rsp));=0A=
+    g_assert(memcmp(get_ipaddr_rsp, rsp, rsplen) =3D=3D 0);=0A=
+}=0A=
+=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     char *cmdline;=0A=
@@ -271,6 +327,7 @@ int main(int argc, char **argv)=0A=
     g_test_init(&argc, &argv, NULL);=0A=
 =0A=
     cmdline =3D g_strdup_printf("-device ipmi-bmc-sim,id=3Dbmc0"=0A=
+                                       ",lan.channel=3D1,lan.ipaddr=3D10.0=
.0.2"=0A=
                               " -device isa-ipmi-kcs,bmc=3Dbmc0");=0A=
     qtest_start(cmdline);=0A=
     g_free(cmdline);=0A=
@@ -280,6 +337,9 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);=0A=
     qtest_add_func("/ipmi/local/kcs_base_irq", test_kcs_base);=0A=
     qtest_add_func("/ipmi/local/kcs_abort_irq", test_kcs_abort);=0A=
+    qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_acce=
ss);=0A=
+    qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);=
=0A=
+    qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);=0A=
     ret =3D g_test_run();=0A=
     qtest_quit(global_qtest);=0A=
 =0A=
-- =0A=
2.43.7=0A=
=0A=

