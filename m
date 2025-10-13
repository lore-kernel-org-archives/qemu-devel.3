Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFED8CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 09:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ekq-0002Z0-6Y; Mon, 13 Oct 2025 05:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Ekm-0002TD-Is
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1v8Eke-0004RU-Fo
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 05:22:02 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59D1F8JE772949
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 02:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=vcGv4XNjgBnxV
 ytDzSq3rsROU5+sg56WsJ0KTPSrtaY=; b=YnXhguYVAvUE71rdHwSUsHvg+y9ra
 d/6ZBWA2JeRpXM/V3LTPfjATie6V2mKIh4K+y4bPtRiYlrk3Orivmr4Z1XCK45+G
 FgOVb1JcqKGyQWHopzc5VBYd5RM+JjW+2xWshugmBCF7qmLEbWO6ofX4oEcHM9tL
 /bsDBaseJAtd7Dn1i7owKTkgRJhU/ULi8P4ZLms3Y0CfsgRPTmH32THD6s+ChSIW
 A08C5sfv74fuohvsvDTsHt4xikNQRAMf2o/2DFER7sr2twqdw0ex/7ijrLYKLrhc
 HO0CorHL3ThlJLJzvgvaOAtbnrIBO4K+1imkP2m7SLvznGELdPGiY1S0A==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022121.outbound.protection.outlook.com [52.101.43.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49qpad2the-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 02:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oisk10PcERN8E9+VC1ihWFZYx/HYQ1kUXCZ/b4vB8bL/g/56pZKfHBufPVkvKGTs1O56NK5RfOhWwh9x2ASjyG3/6js70rQyttXjyze0sSZGY4ssOLhj+gGji11SHdf5GKMm3R9b+cNRV7enJmzV4qPRXEM8u45zG3JKWc2ywFALAOd6HxYA0WlwzrY3L/CkxN9/wlvRByewImOvQXztVyS3HpjSLBB3rrkYCM4A9ZqPrlCqH3TX6kl7VKD+mRZtr0WRNUX6KmyGGwsCagtdwvPHA03vHCNv6zHOI2ougBO9dSADnxsUyRc4ZTMyjI4St/YIjK1A8TZpAs7m65hRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcGv4XNjgBnxVytDzSq3rsROU5+sg56WsJ0KTPSrtaY=;
 b=jtI80T1N3/KEmY1ACTTr00RAIUGYtI8YnnxOYqx0X39cXEzn74Rqr/K0kcVIjPOHAw3Krkd80FAw5dN/KgSdle2zyheWNcLRWCbdpscQ4Z5M5CMZIpLHrv7lKi2LljuhLAVb6TXExjBZVSVWuATqhmUZjG607/HcRyF68Xl+neAOAGt7RXC3PDvdsY93uS7WnGUR6XmYCSc5DrqriA1z/DOqRVAEUoRDMsjTzDVmF8XJzGDdSwuPYnYSAACCn1V95HnheKf2jNk/7IrZ9ZYP7rCXo+QgH2BQf/Z9YKvroeAg9gIIO28geeN0YGmVQ+3eJasq29ljj8SNiDqWmRnjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcGv4XNjgBnxVytDzSq3rsROU5+sg56WsJ0KTPSrtaY=;
 b=yuoMA+31rUv6BLEI0sU/TwIWTPsuOqy6cNKc5q20KfOBL9PjH/Lct8Vx1v1KQqVLtSv3IKxEGkTRbgLc4EA7N1qNxs4NJRmerl3WIZ2ErKPAT72JDfRKhUBx897ne3lBuoBaQK8gw7OC2BHHPN2C1psDqoeLF2Vjts0TyC+Hdl7NOvPYjnPzuo+C5dl5xCaMeRC5Mv7/1gNA0fAVu5MB6pPQ4ynEB7irTxlqb9do4ljecCNQyYGmGT1ioGFI21PyECZOX9TWzAiYnIaZQlFC09t3v6wf3/2NLL1unhNlNOcEuUa/MiINnI6JWjv4SBTZRRtM82/uVmtAwbp8OO8OaQ==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by PH7PR02MB8955.namprd02.prod.outlook.com (2603:10b6:510:1f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 09:21:49 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 09:21:49 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v6 0/2] Add zerocopy partial flush support for live migrations
Date: Mon, 13 Oct 2025 09:21:20 +0000
Message-ID: <20251013092126.3480671-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::19) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|PH7PR02MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0e4857-766a-4418-63db-08de0a39efe2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siughS4BJYB/aKISpmM0ve/CEJ5xYmZVlQFHZA2V8ejqVQdIh941GeLaL09h?=
 =?us-ascii?Q?d67BhZE5peFOItI430jACM/FUg9x1wh3i1evH9mYODinehJnbIxH/bnkrq7J?=
 =?us-ascii?Q?oWmJB6Xiev8gZZLGZha2+p8w5dgvwk22Epx6u7doz5aSvZZD+FGRFa6Fl0fb?=
 =?us-ascii?Q?NAh+XuCOyoQHMUGN6YBJzOIOXj8KHV9bmBaApO+IuV+vPexV6tuXecJ7ovnn?=
 =?us-ascii?Q?B13q4mvEhHTc+Pn/qlpRUWlWo0Yg/pyU8KnJa21OhGKujIWwUScYKQPxhQby?=
 =?us-ascii?Q?4C1lSce33DwihTCaBz/Q05PIoG7+0l7nun6t9ZdhG+PeRwFwIUcA9SX0QqrZ?=
 =?us-ascii?Q?+Mmpp6StPwyBCfJKfgIJPRZWeMvtrqaD69JzxJ4LouQiXs5Iq1RtTxqTbsZM?=
 =?us-ascii?Q?35y+MrnHVSWs+FiWchDItBzEmes2Mpeq3Oj3/2TitelFRP5UtPvKdCL9s8lg?=
 =?us-ascii?Q?ubTOvchF7WyMNOAvI8SZcDlh4WKEYbE/9tZQ4VNo9hRShKufk/hMI0f9geqV?=
 =?us-ascii?Q?cCnVXDBS+zNR8YkJ/56mFhrSGdGFr8QtJjX579sslaGyC38F7iiIWcUoZ+bv?=
 =?us-ascii?Q?tLMH7tD/1uD9/Q1sbk89NAWLV5/nPnZtQE5dKsQScjZccdnBu9yCVM2494rQ?=
 =?us-ascii?Q?d6p09Bjp2BVFpY/pTOh8N9RNy+GvRIT5a0g+occpvFBFNwn0xsKezSOyWACn?=
 =?us-ascii?Q?0MzwI9OWd9AgAhUXLOcvAwgCGcfKOUat3K/w2hR9flsDY1aK2ImOUah4fowX?=
 =?us-ascii?Q?lB0R/gddY8QDkkiPKU4M78tkVI+9tZM9+oaAbOukX1GoNB279QEIM8t3DKct?=
 =?us-ascii?Q?GJk8SZV0tu19Lgy07bhrnr1sqw9bFcy5bF5o1tUatngU85Y2fenCva4Ntxzq?=
 =?us-ascii?Q?CRakbxtl1XMdWncP9MUgF3Mr59YS3PVcVyAg8ut3QfY/oISSnZpzPW3HdotC?=
 =?us-ascii?Q?LfUoKDjTSUD8sQ1lj7DErLkn30AckTbCTwzMXRFosv3g2fv9Hrc0cXIRGFKV?=
 =?us-ascii?Q?nXGMm32qmIusGkiLTape5Mn17C9S/rq1LX3+L9e0stud80sR1U07zi62uzcl?=
 =?us-ascii?Q?wLZUlrJNVS6Z9Y+Mvq/P87ljTE1CD1XTn/El2FS6FEhCEDIo4aF+k/pPfddj?=
 =?us-ascii?Q?MKYcsDCtw11d4E2vosBa/m5WCRa1lMDPYCdXyLQCNyzQCK+nH2cUsi7e/iGq?=
 =?us-ascii?Q?82b8xNkKBAV1qJts/88xuM4eM+HP9qMJnudBdBn7KP8l4M9amh6vxO/jyPpB?=
 =?us-ascii?Q?Tgy/i8l597+fsDq52NZtHPe4kTd6/JD9+AcFpi+Pbcv1uXdCHb0Y2P1ie9mc?=
 =?us-ascii?Q?G4RUpr4pSeoJC1M4O4+6EVYyMUfTrN258YsIOjfRsdqj4ziSgdRnFaez+0+S?=
 =?us-ascii?Q?YLTe01E+9uWMEPh1aYCE1hdswlWBtYoe4p2+L3SxD6HuHpwfq6pi4fCkU24N?=
 =?us-ascii?Q?qBL1shptGhSkmC1G2p0nJRq7DRGQIW9WV3YsH59mGH/+xikl1SAVMBuuyCWV?=
 =?us-ascii?Q?qDlZePl9xQa6K3UgtqVqypc7xfVtTj8O8qwn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+U63GAprfNEGLtjFMDH0YGHHxv9vhQck5cLVBPFoBKmE//i/dH0nTnHQ2UGO?=
 =?us-ascii?Q?ESftXS1S93TIooKJ4RA/on8NJzgUVDoemLTc66bbTvWTbEfeYOzhNEX7aQ5o?=
 =?us-ascii?Q?3EZYZcVKnp4t8Qw88LazvJvtPvt3F5UIuGQkX9whHCFzEEArTV7H8taeT2q4?=
 =?us-ascii?Q?zUoky3NWgxzRxJdfIes+Iyr1Dr9br88AQvdJ4PR12HoitV9DsJ4rAiGswd22?=
 =?us-ascii?Q?HB9vEUJswgNYo9bKdI7XZQFMSjjBO5I0M4JuQsd1eaNRee/BllKf47iDQmCe?=
 =?us-ascii?Q?PnzldM3mYqm+gfWMaxKCRqZR/Ap/VUleZiyDzNd9GnGOWoPkGEyVVGpT/qJ+?=
 =?us-ascii?Q?By45wIdCkOhOdSvex5Zd5/t6kxzXGLNF8A9u3JYdc0SDsP549p0Y3Y5HvOKU?=
 =?us-ascii?Q?wRwqXTzhME+wbjwLaXbAG/Hno9Mmv+HzJ35qv3O0ixKye1ELo65i3js83IgN?=
 =?us-ascii?Q?JDhtWe1oM3+PlBb0DI1kZNzVCFXbsQlGzy/n6l4/lff3Nv+VYYdY5BHkFP9q?=
 =?us-ascii?Q?fv0Pqv3vZOUTD1cVwznLI8jLLy5iUCzC69iugUajExI6UO58t7OGTsKEm9lJ?=
 =?us-ascii?Q?6Uf1+PoC4gOG8M6yMc8yQdfwXFsKvJY/cZUG86p0PPI72oMNERAdFjv5Nft/?=
 =?us-ascii?Q?3va0CvvpE3hLL0OGloDSyis3jeCUowbf/Pf6XajFcbW/fWSOI+ebnERptMtm?=
 =?us-ascii?Q?PhDEpD77zkefwhigzBdt/UhuYMp7iZx629YGezV4LMF55KTKTzQil7Mpne7D?=
 =?us-ascii?Q?YOCSZqHAuUV+06WrBTaFGCvJRqGpYo/fEwgiELcrB3V2yKM6Pz0ep76bsDvS?=
 =?us-ascii?Q?w44Sz9/M8/WupqDNocvdPiPwPztPIUMC7YTSjjW48wIOd95TRWnhq8mkTYA4?=
 =?us-ascii?Q?jCpMuos8yHaKpqpR3PiZhxKg7t86oZJV2dk4MvnIA9rA0cM8/84cdEuwKQ/7?=
 =?us-ascii?Q?wc3T/kTDlDzVbi4U8Vbfn7hcgnOg8igO315KL/WrN8dDH6yyporWNi8/eLA0?=
 =?us-ascii?Q?KwAKefg/WgpuqUiwebn81cOqUyXBaH9M8Ok2vGMoU2lNrw/2MbWS2yZmzOQu?=
 =?us-ascii?Q?z6MTd24dw1D3gOH3zpohtBnUUq5cXDI9XJUmlgJpIzWZyBw2aL9mgpwpCr9r?=
 =?us-ascii?Q?z7bvYeHs+wJh/dNmVLWytjN5qYuggUC0qBRypybFRU7q6NWdJ1Iy/AkXa9yP?=
 =?us-ascii?Q?PtPawJkp/MX7ZNzrMI/bf5RkjJAHrkhty5RQFL2S2RsGt0gvaKlIkOT2SP+r?=
 =?us-ascii?Q?HrbJPPV75jmbXw6HIb+RM0ZWJC181QPin2t/avPjIDuPBAUvwmbg0ekn44Pk?=
 =?us-ascii?Q?m+TLt3QrZGCIwCzNvy5ZbUONdIRSvPKnfiP5qlFYLbX3PbJHY94HewnGKHoh?=
 =?us-ascii?Q?gcuJMSItcBl5j6wNLZQX8/JnlSdKqhqZszDfkvQ7nRltHkei395G3eK6uSwu?=
 =?us-ascii?Q?fT3R1bNdo3VUfSZXIW1h6O5X3aPINz7aumZohiFNwR+5TnclC20+dtPfJhfk?=
 =?us-ascii?Q?KvYTG9iaVX5LkdOvDc8LaAzIYdTa7T3aQVtLmPNEdnNqXOY9LJoviydA6EdZ?=
 =?us-ascii?Q?6vFI+r553DJsqgz6zRqkU+k18lIcl3ptDzlBbeNP?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0e4857-766a-4418-63db-08de0a39efe2
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 09:21:48.9532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfC/Vq0RK9xJ4Pgzk3o6dxYc1cqhxdxzZGDUywwoEsQiOJjYPBF5rMYGcLnICtXo4bLbBjEiWTRFbZfoqzZ34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA0NSBTYWx0ZWRfX3GkRG3ZtJ8W7
 2rafcgydOx404ejr7lEa4WHlR65Sf7MI5IR/sopoOPYHXl0g9lw2VPRzdUkxBZh+Wvj2nu6hBRU
 gFS91xluQYW2Rup/B2kGYr/nsLl6zo3zA9hPixJnPPK6bEGsTsfO/Y60JZy7Ff7GyHmchlk3tph
 Ng2DzWYR57yqNXvkZ9g9/sKfyoxwxe8WXrDHBrrPs2z0uRbZa6Ba7Opb5ulRTK/LQPboB3E9c5Z
 yHd01Y1CNdzUXO9Yc8YtiD3cohYHYqGSU5brcBjzmAkl4mAWWKcjkQju4lBcQjjGB8FU1bp27Ls
 mcnP9rvrKHDC1GaoXsV+FbiRcJ9YRPY+ZeRxtdxz3dPQOwLkTgYM8XIUSrr4RW8AKT8tMG5ltO9
 oPN1xRq09Jyj21F9Hht45v3X3UOXmQ==
X-Proofpoint-GUID: nEFdEztHsRYNOq0csoGsScSari6XLaPc
X-Proofpoint-ORIG-GUID: nEFdEztHsRYNOq0csoGsScSari6XLaPc
X-Authority-Analysis: v=2.4 cv=NYLrFmD4 c=1 sm=1 tr=0 ts=68ecc4ae cx=c_pps
 a=ojCuy1h7BbwMffJHuf2NLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=pB3Rj0LEYSIxIFKjaFAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Hi all,

This series introduces support for partial flushing of the socket error
queue during a zerocopy enabled live migration. This will help reduce
live migration errors due to ENOBUFS in scenarios where a lot of
out-of-order processing may happen.

V6:
   1. Dropped QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE, since it's
      redundant.

V5:
    1. Introduced a new write flag
       QIO_CHANNEL_WRITE_FLAG_ZERO_COPY_FLUSH_ONCE, which will let callers
       decide if they want to do a partial flush on an ENOBUFS.
    2. Added a "blocking" field to QIOChannelSocket, which indicates if
       the socket is in blocking mode or not.

V4:
    1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.

V3:
    1. Add the dirty_sync_missed_zero_copy migration stat again.

V2:
    1. Removed the dirty_sync_missed_zero_copy migration stat.
    2. Made the call to qio_channel_socket_flush_internal() from
       qio_channel_socket_writev() non-blocking

regards,
tejus


Manish Mishra (1):
  QIOChannelSocket: flush zerocopy socket error queue on sendmsg failure
    due to ENOBUF

Tejus GK (1):
  QIOChannelSocket: add a "blocking" field to QIOChannelSocket

 include/io/channel-socket.h |  6 +++
 io/channel-socket.c         | 77 ++++++++++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 14 deletions(-)

-- 
2.43.7


