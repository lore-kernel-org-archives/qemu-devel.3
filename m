Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCAACFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpvJ-0004YN-V7; Mon, 07 Oct 2024 11:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1sxpvI-0004YA-Qk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivam.kumar1@nutanix.com>)
 id 1sxpvH-0002UB-2X
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:45:24 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497EYQKj029510;
 Mon, 7 Oct 2024 08:45:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=CmgMHKAwvc/l4
 YV5ujzTYr6mkpX8LNsiGw7VapY6YG0=; b=VxFqsWVVXVlb6JyHjl5OmAYZ5rd+F
 4N08hy5+JQkyKGFxl1vzkYOZSej2bHZdb16lcN1Qh2u7OhlbNAGC9p0DXYIindmc
 w2B0ABMOfe5OFDc1Mv3WY2lksnQsXWpSPHh9KlRJ8r8VPsGmKaTJdjeqz47gTYw9
 emC+4zh0NVoMCFzYsshFdAUM5CdKCk7KDAFr0Q38srjl65g+04vm77tX1PS1sk6P
 n4NDlwBhp2uruv5cFgY5vSPtcajzXECAGVP8Rp/q1v++E2dxpL4adSLgFALayxDF
 76TYUC/Xq3G/QNXseNlo1nmtIGLwd9EcTb4yPDw5vvFyyiRxnG6lDErKQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4234seurnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 08:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xERzikTxtRdsjWiNpyGFV9ZFkQXh/SZbGQ3KDtCjsfPsIaTYxuavCAHMSmit0A35Srjax2NYaolV4LfZGYIHwjgIX3U+rtttXcYKK4y3n9Z/mY4E7DGvHcevtyl+powSkWkyQcw2WZ4YoWHe0hR4+zsEfuj+p0D5ACgLfFpHg5LnWKXGx6EHuCnJF7BJevmnYGI+d9oaixPmtwivW0kwMGYgpr+aSkzcqDg8z45EHJG2NaS3TFajI3XlpNZG9SqgM6cq1T4OD81hsl0F8j4yDRt8HFkn1f31gqtHtatgNpDv0nM8zsMtkvHGZ7HFm2lXherpcUL7oF0QjYDuUN9MHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmgMHKAwvc/l4YV5ujzTYr6mkpX8LNsiGw7VapY6YG0=;
 b=neB2+Qf2UDFG2M3SBP9EW9leIA3+dsT6sEI9DrmfDfgFoZa3/51A4JmWSSbroT2E+Fz/rEhofMO2/vVJer86D+nc4X2aRhXq+Ap9Ele7y1lZf9hW/H/jQGwoc+Wl5kuRL+ykZSTcs1dqWDcRAF5JUjbcvLuJ5wF/Ilao6HZz601ASJVphOXbwTo971Hi4PP1TA7tMFVAHVw4B7USoSJJ8nD0y5Rci5NgabIuONel/SCNfMMO8b3YlwZHMy6TwZYzEVCbIDrhpd5agS1zGzxY/myRBLOXC+Z+RR1o8d7of5pSk29bEx7o5t+TndaRbP6x1j86M2HGuvJ2mBhiyMANbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmgMHKAwvc/l4YV5ujzTYr6mkpX8LNsiGw7VapY6YG0=;
 b=C+/lmLPZTaAjwHdxqKUbePp8gohwn/zh8YSAzO70vF5AHhn00y88upj5nDhqj8xkOn5S2kClu2C76HSCs4rb5xQGzdkkkn7WqBm/2ofe6Il/ibbgMwh6CIDjD7DlmE8kBnIpqlHaxjDZl9QIHnLIT/kGqL4hCn8cweiqiWZobfc9q0h9dMayULjMG40JOtrGrxMspZXxUp/M2Yq1Bu2x5wkRejbfP7sF+ZMoxxHfXmWTwASMPnjhMXM/5AnaXuG1kKVNv2tTsiB1XZFSBuvhl9JpAy5+VbYiydXwb1F6niF5ONtLKonpYm1aBDWly0uDUaZ/cL3zJPFrrABNGjDapg==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by LV3PR02MB10209.namprd02.prod.outlook.com (2603:10b6:408:21e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 15:45:09 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::cab5:29a2:97ac:ef9%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:45:09 +0000
From: Shivam Kumar <shivam.kumar1@nutanix.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Shivam Kumar <shivam.kumar1@nutanix.com>
Subject: [PATCH] Use multifd state to determine if multifd cleanup is needed
Date: Mon,  7 Oct 2024 15:44:51 +0000
Message-Id: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::18) To CO6PR02MB7555.namprd02.prod.outlook.com
 (2603:10b6:303:b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR02MB7555:EE_|LV3PR02MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb2f308-bd3a-45ac-ea69-08dce6e70611
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MFd6BtWBNTOTum99O+9+h16ha++OsnRtHu96x4FTb51Q2wNB3MiVkJ3onOxM?=
 =?us-ascii?Q?+g4tuxFVcotfAx2dUl1qqtEH7it6npIUUmKxaperlG/+HA8MO/RNoyyPiwIS?=
 =?us-ascii?Q?lJeugBN+nFu+B1G8CKdlfhp+mJzkxsIbNZkxYMs760UY+FtWE23am09xpp0z?=
 =?us-ascii?Q?8ziK/DDAexCH/vSU/pZ0mbuHlwvxgZOE0XQBail0NuGPQbxMjjE55FcfC28H?=
 =?us-ascii?Q?3mzLwXhYUAsnM23KeH6mM7Rovu2bOSBmUawR5XBNL/3gIq60jFAw+81RSKEr?=
 =?us-ascii?Q?nRBvD1uyp0XkbdCmvTGwgE1NRH3yAHHggDPM0uHPvAqmWXlK7TYy+YqFJuiP?=
 =?us-ascii?Q?Z35N3W5+3Xgp4u5hmm1qoZa3xpoZpsPKVS1IEzC2uln+4in9j3BMA4uQEwV2?=
 =?us-ascii?Q?uijQbWG7ODHQpLWfX+uC0Hjd3pVpwukVR2urrS4Fa2B0ttsUMzSbUg5tMskE?=
 =?us-ascii?Q?LO2uRcW0cS9zveWf3qyfHQf45RVvMF8crQUx4oX6zUQniee5SOm3yvBqiYXT?=
 =?us-ascii?Q?OyY+s5raQKyOp/ScqzN1YeCwmjKI/jKqN7esl0gqSYbl5ajyPANFTHFn6Cd9?=
 =?us-ascii?Q?Uv/t46sn8vomjbO5rx0wTA+agE+IqIjANVkyeqQe2NeAI5G6NeTKAiDU94xd?=
 =?us-ascii?Q?zsJyZlsMFo15vaQsjUEVo8pSHBFjA1y+qr4ezoywt3UvCDweXqAxrGv44dLq?=
 =?us-ascii?Q?Skee9uH5gF2SurINOrV7R4cAl/Ov6jfk6K4N6nimcjPISidnGDNLagxL82PR?=
 =?us-ascii?Q?w2upp2NlFV4Urw+V9TDohFk3+AcfgxrsWrdhnTwmjHml0TVMqUVxvKMLBvTl?=
 =?us-ascii?Q?WKtBJLts9zAWicCbHWAgFxNjYvF/vVJ7g/WM4RE7qEahYzjlLDXaKJeMnjXA?=
 =?us-ascii?Q?G5+3BmlPEr2oTLAHOW84ntZEbeOpife6jdBpAQz1W3t+ohZP7MvuvnPP6JhA?=
 =?us-ascii?Q?UL2XVuvX1trAyT+TLApPOEVPFNCdf2rJphi9amRCg7Ahdr7ORmUoQmt6o7Uk?=
 =?us-ascii?Q?rq4C2JOuLwyc8+308GdObmAgQzTHwCDaj6l9Ll1TYHIiOwyhvC9my0ilHxqU?=
 =?us-ascii?Q?UL5nj94+dJsnvnPslFIZum7FNg5M4OU6y6QS/6yUE7Ykfk0xbwe+B346QsIH?=
 =?us-ascii?Q?w3DXH/SPSzg/8tsPCVdtvG5tw0ypdHkwrIr/CA6OrZGZWJhvhExreo284EjZ?=
 =?us-ascii?Q?ABdBJZp6QNl8GhbE1G38TeTMeBNaTMch/hzTO+8GS5VC5tbRNca1WQusjVRT?=
 =?us-ascii?Q?o5UCzjeQDS6+w7DxoYVqnoLDTaWaAzHKjYWHTOmgmkiR8YE5mi+tldPPilqq?=
 =?us-ascii?Q?E3jyBFyGjSZUUW9sNG6hGgA5Gv/eM7ZuTaE9fZMj6sb/PA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR02MB7555.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpN83nHHHtebffexxD0RcHyv+F8h9Xfw4khGzDgIrY6yTZOO/OuekDqqOe0y?=
 =?us-ascii?Q?enHSciob/gsXTMY1KSsMg4GsQ9WkqxKiBcX2jHngCsoMhRUaL3cfw+ctBIgS?=
 =?us-ascii?Q?rjG1AwiaFbR1CJXpfIpWFsXlvJMAv9Exqn7G3+QXkjTE2Pj79CtaUOAQppaa?=
 =?us-ascii?Q?wcrlboq7t+1EXjXlcvXrUC1TTRDwSMvsrWCF5ElxjO7Ak14tRDTeLwcxs4nn?=
 =?us-ascii?Q?i2w7PIWDt5nPKsHg7eeI+6fN8bfou7qfWc/g1N8ZYWilC9lAY1LiunTaDH3o?=
 =?us-ascii?Q?pmuyz3NDs8/dlPoVop5Bv7ed3rbOT53Xa9uJcJuOW0vUr0hRvVQKxWLoGpIi?=
 =?us-ascii?Q?wXBbiU+XjYRcBhBm8eKPdmkBp4RkP3jstS/OW9fUTNn4sYFSYxuRm8Mw2e/U?=
 =?us-ascii?Q?P19uET2RjhaA52oGpYpVXsTe6bcK9imTokr/ze+0m7IdUTxi5jNfUGrgoyXW?=
 =?us-ascii?Q?fv50YD+02GY4xBBZrOLsi3c+4KLp/oXkXNcE/TAtgyCCTYzXwqtJF2RATaAv?=
 =?us-ascii?Q?Za9GrRbTwtHRXlBP8PIl+w/BeJLkpWBVDhLmzpXs3OQzu+j93E6pl35+PZJL?=
 =?us-ascii?Q?MWtQsQ8tQtvF9ague2IKKDcrQwXvRE5ELGktC7HnWw/k0t4BKGnycGRvhC9r?=
 =?us-ascii?Q?WswJMpbuEA3K66JLZJd7MCTlOSDjuewfEWY+68QJRSqXBJIqBeKSJx3PovTv?=
 =?us-ascii?Q?d1F+0LgSfDGBLK26CO2Y7egDxVW52VOcW3lkbBki8t3IN3rPoWxrtUoozMKx?=
 =?us-ascii?Q?Q1GoIZ7ZFXSNEh8savZpKIEH7HwSO7vtz0EkpJg6YNRe6Q0xKqdY+X3+Zsjw?=
 =?us-ascii?Q?0VjgGmNOEr+R9Yvg/4W2EVI4FCRwE4H3qPctVO6d88uahm/KnJwphdY7Wyfw?=
 =?us-ascii?Q?tpZNlZ8Y8Ai6pjZX+DD5+iThny/Z9xalDLedNGK0QV6CmFMOcozysd7Wgoni?=
 =?us-ascii?Q?hJE/mG/iJIF5PcrItVfhG7wei2RlV9286bI/rnhiHP8lqeJxi5N5kbdcWAVZ?=
 =?us-ascii?Q?XxSiMQ7Q+/k+BhTaOL4alO4VbrcXILq4A/tPYdoWQFaEPVEI7Em/v3cJNE8F?=
 =?us-ascii?Q?35b3yOQKnKsjjx80/ETRmd1d8KbRdjZMQlSITjFvEBcQkmfdMYvEtV6CFeoP?=
 =?us-ascii?Q?Le50CWmdj87lCUHTx3xF/h/pDmUT97Bh/GgbKl1PuepOCcI9CcrvBVCkGaBc?=
 =?us-ascii?Q?zsRZdprZ2IQmQsq3zhoBoRqSLC7V634Cv1xTLyvumf2m5osNrfb6imyEqVtm?=
 =?us-ascii?Q?dTga7McPEaXiA5rTK5Ip6umcHWfsfbf8EEIgZOeBWGP5dSxQK82dffjNq/Bi?=
 =?us-ascii?Q?9ptc0Xls+RlWkOETWGlXatBD7LHeb6JHXrEjrHzud2xqNNwAGccuT5Oq+Fqi?=
 =?us-ascii?Q?9vZTeeGKfFCQjtGDSUejgTZwXBCWsvMXuyz33tJ9wh1+ogts9VNhkiBrzAWW?=
 =?us-ascii?Q?6yCIxdNKWxwVdNhLPbf7JOafq5VH5w/LifP9ET1ZAifXnZBkiBHXtL66o867?=
 =?us-ascii?Q?MNskYy6eSVYt1rpHkC+3w5qXfRld2ek0sz4doc40tdKmL2dZ+jOxzIN+cd2F?=
 =?us-ascii?Q?y0Ucb8XWHaD0CiS76EY65najqavZamOzssScRCCZ1FkL9ElJ0RHWnOOSxOeo?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb2f308-bd3a-45ac-ea69-08dce6e70611
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:45:09.5421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSeVX16DHBE/bWtO4TZuuc4Ku9/mjYGm7j4VGOYd+0Rbj6wPidoz+Hpu/sywV4E4fzsif3NHcH93b/BsPngi5d0ZUnIS6ITHxZPwrdrYKYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10209
X-Proofpoint-ORIG-GUID: eq0r-cm-Lww2_i260LGjjHC15KVGpd4P
X-Proofpoint-GUID: eq0r-cm-Lww2_i260LGjjHC15KVGpd4P
X-Authority-Analysis: v=2.4 cv=bLlEI++Z c=1 sm=1 tr=0 ts=6704020e cx=c_pps
 a=8NhCg2oU0sQOR5chO7ltBw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=RQtsqoFJyvxh28ou:21 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=uUDbgATewITTajkZ3NQA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=shivam.kumar1@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

If the client calls the QMP command to reset the migration
capabilities after the migration status is set to failed or cancelled
but before multifd cleanup starts, multifd cleanup can be skipped as
it will falsely assume that multifd was not used for migration. This
will eventually lead to source QEMU crashing due to the following
assertion failure:

yank_unregister_instance: Assertion `QLIST_EMPTY(&entry->yankfns)`
failed

Check multifd state to determine whether multifd was used or not for
the migration rather than checking the state of multifd migration
capability.

Signed-off-by: Shivam Kumar <shivam.kumar1@nutanix.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 9b200f4ad9..427c9a7956 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -487,7 +487,7 @@ void multifd_send_shutdown(void)
 {
     int i;
 
-    if (!migrate_multifd()) {
+    if (!multifd_send_state) {
         return;
     }
 
-- 
2.22.3


