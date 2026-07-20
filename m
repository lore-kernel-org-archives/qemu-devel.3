Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF4AC4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloYu-0006LC-Qi; Mon, 20 Jul 2026 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW6-0004n1-98
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW3-0006ZC-6p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:45 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqFpq588123; Mon, 20 Jul 2026 06:58:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lqOQwCiojI+rrhu8R6jMCsZ1ayQF/rTfMn+IWYJDW
 BA=; b=BK4335OENUisBeYwqumXHTzkP/uhetz2a5Ut2HWzs3n2ptEYXlnJUxSu2
 ov1pHgygaM6X4adJvJhduDgpGoHA6TIXZscZu20oUs6cObv/Zm2G0X2TiKoeyafh
 kUQMn+tPHZGXD+5y6iAhOfl6JzT/emaic9nGxfEbUQn79hrDljuBnAn96qsmiYrr
 mLZX5r/gFZG2Rfj+2DnkPkcdMX2tuucO+EmpRWapmbLjAza/kZx3dpTd0mcUk4tS
 A3exKJoD7jbBfl6KAmPnkHlkvyCILLMq7PN6XqMHidU5ua5dJ8eXJBcJWMXiCVXa
 u+ATqirZBdRqiX/abEIvvmoc1HALg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020100.outbound.protection.outlook.com [52.101.201.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8tbkdrm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJqu3M1GBMRySdqVSu7ZYrWAiDas2zxB6nVugMT0TJ05UNouTONDWhlLTdsLcu/YDBUTp5ty611yTa9QO9yfmv5vLTl6/aifMJJUznpvAEeflNOWuVpiiQV1kNZCyG2ZI+eijEth23BuqQvETmnSVoDtUgeNOVp5rf9uUekL+wsvxTMXyVpA4eisT2yyzog7HVMBHhoXagU26eDWBvbAZaeL/3NWn06gTgweCfVf46Dkmkmde9kOpDNAAJghzhkUgG3eyC8AJtFfv/heE6Xd8W3btCvmeWufkJoU8ibjYf7sizpL5fVixb4atLafzwTgchDNT9BRZFhZF/Ef0sgQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqOQwCiojI+rrhu8R6jMCsZ1ayQF/rTfMn+IWYJDWBA=;
 b=w9PzI/UDYyu4uhGdfP6c/qFMr2KEjoNHywOh65PiZB/GklnMgmM6XxhaAL6JLzlRXDdmfr1Tpx23meYQ6YC2ILctC1BwdWjCnUankbniRYnNMsnD4uGD1r3TBoBBwDV9s/jU0L3nGUSwwfY2qtZhKgXB82Fq4W9wbgnLajt7zolBL9Qg/AuDa7jMtG6xMycNfwxJE7A/h/HC49+4Sml8d+5QCgghVBTzXgvt01w/i5Y5IfRYj08x+gLtxb7M9xo3v1w4K73oRrOC71Awt+TGbuk+CqJBDb7nL7hfR+NmDlAIbiMSMxTr6VOthB80qaloOBO6dTGHULkToqFolrMBXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqOQwCiojI+rrhu8R6jMCsZ1ayQF/rTfMn+IWYJDWBA=;
 b=nGyrJsmB95oiXVHW49glgcRd+yKZpouA9rerJuC2NRmF+OFVbQlanmoLpKxUutoN6tImA/qioPX5uOZvtRAqBfnA2Qp7liFaGniiCzTy3LlslVgMB41fiNCHbBxmUINlZhCNI29wFMsQXIwFQdo4ob5J9IfuhPvOOC7uBIKi4ZbyrM/MPMGz2eLOYCZHwsYaWb3Ox5t1uJ840bxKE/d5LPqEeQKo3iICfqFBIIlgqBeGkIG3viC8UDO8Y9HAlMwOZxsIvBMhZY6aQbrasAF9meOkt564QEPN/vDTfzAeChYHS0193b2UyYA5nBspbR7DB8yGm9H4SNVWojTlStxYpA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:40 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:39 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 2/6] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Topic: [PATCH v2 2/6] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Thread-Index: AQHdGE/eLr8FDIqv80WqsFBTA7io7Q==
Date: Mon, 20 Jul 2026 13:58:39 +0000
Message-ID: <20260720135823.21070-3-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: 4990d684-bda5-479f-fad5-08dee6670096
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: +KB+UMrERadqr1OC/wq+00bwB6c2Nh3HnOSKd/Xe1bKQO9D253/I6GFYgECSYHfJn+PxJ7NNi0JcE38VDJEjw8gqaPIVHTnaqQTpYv4c9VcFQo4GKM9CbBLz0RDP76pGIoq/4csmrvNSjv5QJXZJ+X1cRwRwx1YQp9o1VWui4mZtSzjcwa2DRqCHBbSc5Ee6cMX4uMKcW7GcB8yGUdV5eRP5TIAnt/Yzot7VdTgvdcil+URj5RXU7fskFk0q0SHED89oQc053jl4rmI32apkf9iHuKIwwSelAqS4HuJfP+gvGoVlAlQyMld8N5UtBt9iBndb7qRfiuqd5LLXSScBDNSH/OJvl18ScUgYmU+r1Ums9gHzUdqjnegbAx99ywj/R+HFhahE34SUkNu+yL2RSyBz+kwciQYXklRcl2WVXC4t8zdVklWt+PoNB0Tj8BEgTUXKltQXPlAz/5drwje+uenwo17bRVkuj7EvwvqdsrQaQPg3czU4imk0wHtZ89HA78GF2gzQB1le0gd0Xs2apNVEILSYht1QObcy4XaxD6GtxXJNkzHmKhC2qkEy03cRHS+Pi4/+uDZ0MO5//wrA5CzhxxGSkGbMgVi4FM/ZEWIv3sbRpn03RvpdNQZ//6KvQxw1RDGHJ4aEvQzAmn9hO/I0/z3n4Lo1cWuEk3aZYsbtDjJ83LRSS3j6TYEJr7csvQZMlSUkDshAhhbCfdsVwEThUkkDeHuc246gbqhZXe8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YxfgbohLsT901wUNH3PL0ZWVdfyVCTaVXbO2+WsVdFHZzOgeNpna6/atWF?=
 =?iso-8859-1?Q?f5/gvKUvFKMwiQHzbgjLsxrsa0Zh+oLdO/OCB2LpoEVY4EzhHc8uihO/re?=
 =?iso-8859-1?Q?g0K9iKbZQ8Q0p59RMv2xUrrcGriZlHYFxw6R8YMujq4v4dmOd6x0MSK6He?=
 =?iso-8859-1?Q?b2D973WwM81cS2spioWg0S+Bff74tNN9fkR5AznZ9/W5x7LImNbGQqHXHf?=
 =?iso-8859-1?Q?mpLdi+t2IBar4DQwgRQZGNsuT507WXx+cXceVuzLfz/+REPf71Nd8dRKaE?=
 =?iso-8859-1?Q?G78zPmgqLMTboAXRRMCWO7xeK3WTuGPrFc9J9XceErjx8axC2ghj+j5j+t?=
 =?iso-8859-1?Q?LG2Pn6iQ/hIsosR3o8ntXl+yXxM+e70k7TQHWRsYAwzm6rcbI3+Fn7rs9k?=
 =?iso-8859-1?Q?wIC0IvrfnAoQOtqauvOn3ox9a82jJHCTJK47xG+8Psw4OW1PnE0Q+6BFMc?=
 =?iso-8859-1?Q?57DyWiPuIQiMo9kTew0euPkaz9bXygZaRO1l6qt+JcJ3SCZlvzvnZCbs0q?=
 =?iso-8859-1?Q?6xpjJNIosgL2FPvVlC4aWYFtmQ9M1FVY3gN3d+k63dCvUI6h2wEwmiHDEZ?=
 =?iso-8859-1?Q?uAWKuAoaTmDWrjejsjBiktlkQROjVhCgr6mW8SEvafg6WkMqCrtYtRV9Hd?=
 =?iso-8859-1?Q?y1RpUaNX5ap/KKSKMeVIi/zJsGWkNwiZqH2exCg9Yagj+Psw6/l9BkhEaJ?=
 =?iso-8859-1?Q?2TN/chAuHVQK2el6Hne1kXTYC3558rZ9yPC3nw6Ew5HPhatFQkccr1a2ZG?=
 =?iso-8859-1?Q?12UoVBtVBhmpD7/dXEmhhoUN4fVsjGGju9mA50x9nw/UVdOmDrVxKKPw2O?=
 =?iso-8859-1?Q?mWw11i86bh2dA9OR/LiznuAtpzJTmFivu1qeeI5qF6XmmW2BhhmOUFmYf4?=
 =?iso-8859-1?Q?M3LZsxt9lEHU7FW0xs3r7xewwDvTlRi2GNNOimCrfCMQqf9sdTesrrKFtV?=
 =?iso-8859-1?Q?VI9xYFYEX9oVx1BWFepI+Hc3Vq1rg4/q3Oh6Kxe1ZOuGA5a2ITodA6kI+2?=
 =?iso-8859-1?Q?vbdb4bosGhQVGd/Ek1hglImqG6h2rQ91MFbPJm08L0XsTeWtd++86axo4i?=
 =?iso-8859-1?Q?RhSl9Q6oSnwil+ThlsOdz5jOVUdkGQetooDGcVA6T9KVkLdlhPv3hIdXd8?=
 =?iso-8859-1?Q?gTX3s+AG8cpo6qvFQmgpmFwC+eT+iVEferBo++3SloZoUBCe/TfdD4YpzZ?=
 =?iso-8859-1?Q?RTgjiSDMn1UflP1uLa5pFEohhu7S2MEYBryN1v4QaQwOgRlAUWKHptDjiQ?=
 =?iso-8859-1?Q?PYS8lG6Pbyj4dkKnUSP61tNkqQ0FEcugCpNUD6nGWzEeJVvxcgqAOyeZwE?=
 =?iso-8859-1?Q?f99xVq7oNT9JPTXOGdTiFExZWcqTaBCGzAQuHH5WnBFqCE4raHsFyTZ3+E?=
 =?iso-8859-1?Q?0NK+ZTrtAOoDX9nntMX10d+ppCJPd5jv0x+w4c9+tz2leilu2TNzh5hk2V?=
 =?iso-8859-1?Q?UqyXRdTsbikkUOArTa2hVtlx3zMUX/NXyy74Ew7N3mRTk9eXxMJo11yJQx?=
 =?iso-8859-1?Q?4jzeO2cMER91Fo+13D2L3SVPtokFPlkUNxeqvg9fLNb4SUC9qzLMVzAelr?=
 =?iso-8859-1?Q?ixMyjZcNTEhjFwF4TOH7DW5uFpgmdMxb0qmdOLSPq+44E61HK+dPHVJ8Ln?=
 =?iso-8859-1?Q?UzYkY9a5lVWedKRxw54KMx/8Q25MkdL2+py5jXaHXdX9TcUBAo8DBEnVBf?=
 =?iso-8859-1?Q?F5EFxqVVxmfA4QA6OO2QKCyvPIy9XxWVgINy1xqJUuootPicdRHqY6lpgH?=
 =?iso-8859-1?Q?E+48faikzFMwXXebGVvo3gewgizngvAZHOwbIJJEePYz0knMTdWV3OVrcE?=
 =?iso-8859-1?Q?jpLlrh8Bb+ADEjbTRKP4v+xe5lvrAGA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D2b3KBDtNzuln7lw0UJOCEU5hJxfLhi9tub/zBSc2PDSpM5AJtFGP/h44IQmSNTxdLNa2zU/tkmbjShSVVsBrIX8r++pTJnuhlzVzyKjmkrTtQ0DQoQLNMScnbrKjf7Kwgw6Qi0K1gbf+bVyFKqZ7VMHcE2nZQVzJt0eqffyPzlJ7uksMOzVnVMCFNYklxOBshrVvVvF7rJF2cVXPRPUJwD9VkS9O6Yhy9R/1hJVHF1rZoSsVvtAvVQAVBcWnMoD5ANrJw9y5kfHWNj0lhFNlJGOSzJqHP9/tpU22FiNvHs7OyiJybyeK9+l4+7YaDjI5kH0w6w5hLOImsVrYetX3g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4990d684-bda5-479f-fad5-08dee6670096
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:39.9041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEFLf/3J/m20HUrFzKKbFb8PxoR3ot/QVuaCCXVaxAl6iGoCGuqwk/di+yI8JnQO957PdXtHVxJPSw2H9xk7eW4YNVMgMYKUP9lEBXgpqr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfXykcpgzrMS230
 NrxomqjlN7C06q8uLSKeD2YzUZHNubggpdGP1RdheVguk58QnFEX0nWQkvAMz928L2pLEhpPBt8
 KqDeiwqLVqqkjgZ/S42oAJvymRCcXAv46nmm05n7F2WZk5423nmC0Md01IH8Pp4IjMimRzEd0P1
 l41y99Z72079Se35A+HcwDooas5LHVqRJh/r/7YZ2/4ADYCUy8Y+Yr0zYGUqj9FMNvblSFPhxef
 GjB2FoosO5Oiiulx1nHR8IrbGSTBORtQMdfckrKRHEkmh/CE4/+p/Tkid2l+4N86XC7ZTCMwTMK
 ULUe201/px2/Nwark4BNAIy7iyNNdXTqyK1KUZjQwm2w+KpTUdkTcxUhyhhS1nyti0+IK5uzjqQ
 YjR940R4V19lEEERlkK7okdtB1gO7vQ/r/Bj4chRiwishB5QE9/URnPm5jRavpYiK3iv9jZtwdT
 E0bunKPoIG5/R8cFIhA==
X-Proofpoint-ORIG-GUID: dN8mYpaw_iyj-7B7s6LZ8cEfMV9aBWOV
X-Proofpoint-GUID: dN8mYpaw_iyj-7B7s6LZ8cEfMV9aBWOV
X-Authority-Analysis: v=2.4 cv=ZJ3nX37b c=1 sm=1 tr=0 ts=6a5e2991 cx=c_pps
 a=jBnIPXBCpefHP6rz4AJLnw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=64Cc0HZtAAAA:8
 a=H0gwBzo8t0bp_Z0icpIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX1S+QjeEzcu2/
 tR3i2Lqhodywpy/eLbcuU4nBPa/ia2oVkTfRPverQPKAqzbEkgZtwGzed876BS+M94NEQs5j7cK
 gOm45/fRjq3FM3C8Tp/YW0GkH5I3r58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index e58167a818..8350bb2c01 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -137,6 +137,10 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         error_printf("vfio_user_get_region_info argsz too large\n");=0A=
         return -E2BIG;=0A=
     }=0A=
+    if (size > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_get_region_info argsz too large\n");=0A=
+        return -E2BIG;=0A=
+    }=0A=
 =0A=
     if (fds !=3D NULL && fds->send_fds !=3D 0) {=0A=
         error_printf("vfio_user_get_region_info can't send FDs\n");=0A=
-- =0A=
2.34.1=0A=
=0A=

