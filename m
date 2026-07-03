Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3350C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeyK-0002Us-AM; Fri, 03 Jul 2026 10:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeyJ-0002Ue-7j; Fri, 03 Jul 2026 10:34:27 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeyH-0000XR-Gf; Fri, 03 Jul 2026 10:34:27 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635trV71992316; Fri, 3 Jul 2026 07:34:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=PV28wNh+3aFR1
 OzTzhz681ix1HBgam+BzyfwbNcxAjU=; b=wSBRrjOwyhCwGzZSJngYAf3yxKXkF
 13ShfuO7BJpAggOlCleZ4nIEiPZgQg0heaI/mYy/kqpFbEURI87RQmepwc8pnlPG
 u8cAf1CfqOOyYQnKN/yCUA250lwMNykp8UDpJGJBUCaegszQpFGhBDb3Oa/43coF
 Sv+5f3h6Ril+S5zHWVwaJbRxLfuW3H6oRfQeINhWNAxGrIwfdMiPQuZfowaScZn8
 xHy9SMMjpR94oKbRyS/Gt0PS2c4ojSuh1LLnE6PCXEDGD5Pley1iA4FjrGYy3Zhq
 m84JM0apli0gStMgBLsQ23WC+JsEzXLXmBxQCpDXqmb07VtZKJdNBW4Pw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021112.outbound.protection.outlook.com
 [40.93.194.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hcptu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 07:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIZbqmmDzPbwPYYavpABVhAwYsIvixhAdojAMPuBoxcbiYjCNwT0/W+6V5YQtt6oNGpnnVmcjYqV6rj7TDxq3QUkqEim6erK1WPAiSO8/dnSSr1lKbrT13h4XDfxuyrdHa8gvNsxENBKEE0OcchMJaWVJxzmIJp03VEKTQXTc7UVvJpSz5GYQumA8TDAItw4CxznFVT6kRNcHU9yEiqgC7lA8mB6bFCAuTnoyBCIDs+YOXL53nT+jBYaCSjVGch6mZTPf8MDyhyRq0Oj1IkeAKv/+xjmw22JFkQW1YrNRYpiznZ9Nd7Kp6PVH7CzOXyAwLU3OkaBp69/vuqPahAHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV28wNh+3aFR1OzTzhz681ix1HBgam+BzyfwbNcxAjU=;
 b=EnB4KxrFxMjTTIgUXA29DtAh+u5LvdHQXKiCUY2hilxvdwWE5zzhsh58I61eKSSbO+41ryLUxIFT2/WhboRLq0RKtvWy9iKwVm0gXNXGxhPmiL6gwjTAfz28noeQSKQaAQU4QaMTIqO5YipTkrUssb6rOebFRczNYbWtBrC7CqH5slys+2iaR2M9tBp+fOC6V4luiTwKiCk25ItVwqBq6208irrZyVLn5+VrczED2uPDgrliMydr83A+rEGz7o0gLuAG/ZmK1pzGiWmu6S+MbAAWY3LILLjq+XwnD4uqbJ/rs6I4UbUcT1/i8jkdMduBZazVj8c8L/k/hwFeRVu0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV28wNh+3aFR1OzTzhz681ix1HBgam+BzyfwbNcxAjU=;
 b=uUQYXQWepgY6x12hkOEx16hwCmEWEtrEWbKLelzZg5GsY1CY622zvhtEXOBI1lPkeiOrHqUrcskr5G/Ezd6v438rkDDLIeD+0CO35ypNIl1vRLnHGC/fDSog66GT95i1+wnsGxIQKJ6vkBgJ/UUcX53VRiKF1bRyXvJHT15yJtQKuZ6unlEbTOylB4LLLPPYSEqOSeUZA/NXVRvBGm9gVNVPe0r85Oguseiijx/HiuaVSVJ6DZ9Ka/8ttZsrtIbLUmoKDtM2utGWXrAEkbi2tEBJmxArOcCLJf7+X9Hssyxm3GRFK54dtpNg8vitsLNI6gIgQulXZ0mVYneOFOVPPg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7540.namprd02.prod.outlook.com (2603:10b6:303:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 14:34:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 14:34:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] hw/adc: convert object props to class props
Date: Fri,  3 Jul 2026 15:32:16 +0100
Message-ID: <20260703143408.3235231-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: d5be6c90-98f0-4631-520c-08ded91025d3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|18002099003; 
X-Microsoft-Antispam-Message-Info: LtgD4UYGgo8kMZC/gKz2G+RxLlaG4fE/MwTuwZKYVdEvMIpf/y3jrNbZnldP8/DiNjVfj3+tm59VxHnP7HJflRbuQ2/ar42x7+K0nL0wPfbS2efm5NdT0XuZ6h2eq1fZFChRh/qTl+8rSTI7yUEVDfg0X4uarRRb7i56zZbiFNI9ZvX4NWHzS/yk4O9qAncwCYzF2emHcvoZnhBq25slxhroxH1PUt00VD9UFaIGIftyFlLKR1VBNLWwUkBU/rah6toTl/synqTqd7+1a359LWzTt7T0NccJgpL4BOb9HBklU51Tos4VREgYqWmukKXeJfrE9aqa3P3EoAKEcjWv1Q75yFVvZ8+mizXiq+ojY/NX4IsRaLT8a3bwlXy8sJgcD/OrCQzwn5gKQ/ZpKojTk3uLpc6PeylNGlxCb5eE9ruspQo30lcncDJGg+wRQ3YTuo4gDNmXtaBE5mxrJDve6ORP713c8ZRH/K46/qanX8jVEmd4jYOYA2zo2dazfum5vaxD+qgSrzrKoURlhjEnYjAPK3c94OB0+Y9x3Ihh053EiANSVfSwoNtTyTH2Mc/BVbJVA4PLS1P6wotv6JysHZl1Ebm4bpKddvyR9KmPOZgiRawDYvh2gM/xDEF9BNPy9AW3DkDL0h1mI8Tnw2QoJ6JyKJZFvv55HQZyCFMzsu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LB5cZ61WVMTOA4xIR4LoGua1xA3mk5ZWspM3n5P/Az/Z+THrnhF/0UlzmOfI?=
 =?us-ascii?Q?WwqLtS/9Ti1rB83HhoIFk6z7Lch+caDkbBSUwihQRIzhSBGDIYQovJMqd7DI?=
 =?us-ascii?Q?wc81eUQnFs7VPnx+r01Hn/Dz4zQ2YmUBlvQGTPR4IluIhGQMv0wwgBqWS8/Z?=
 =?us-ascii?Q?lGjW5dIHh8bRUJRfzpJVsTTAydYdZifLH1Uu4qhkU2sPSV3eywYslCUsn7O6?=
 =?us-ascii?Q?eXIfRok6bEvpWJFQio1H9hlyZtruLBts4EtnK2lSKhh+aPFm8h7Y/1P98Cmf?=
 =?us-ascii?Q?oyKeMBVVgay+WAYcVCnNDeWhAp5Lr5/ZcPOs0MB85o1Zh8EsJzCaCW+3TYHS?=
 =?us-ascii?Q?NaRA8/uNEFfeLQM3mI+hkFKnfK1Bsi19qGW3kbI5ur/LnOVRmdZT2iMmPDXK?=
 =?us-ascii?Q?fj/iKyw8U87Rr1d7ybe9jMZkV4Ary0gn6uVr2Bp4kEOMCDY1n4prj7SD/9dm?=
 =?us-ascii?Q?uIF3WvAn2F4LLPmaf+PtnvBU/eKjxEOoFV6IRAIbJNXJDEiv8XSJt7HOU3g2?=
 =?us-ascii?Q?35DXx6azvrpICilnsYlXlgUqI9AXxhA9bxzlk4EyZad4D52BRy8AHNbB1c1r?=
 =?us-ascii?Q?Gz7rKtxENvu0LgxTc37zcHbwgTzkeTPbmPdiof5ZaR8isqob2buwZVZgiV8M?=
 =?us-ascii?Q?v0WnBTn+bIKAB8FiTCmhfojVyCaWD/j5xYsycd32TtC/NN1JZRRf42+x1rYm?=
 =?us-ascii?Q?7RfludLr5k/iK6Xfohrv/X15x+O7R6DSTttegVjjkr9ik3h+U1K8E+xwpQdP?=
 =?us-ascii?Q?FrKp4wcHd7EFp2I/N51JQagU5qUKX4Bh5AAkUyWGjtmt/QVBx6SVcktKa3TC?=
 =?us-ascii?Q?aFHDjL2TIPStXQfetz0pJ/uJnx2xcseEHUyH+YqKt1D1uEVJH+P1Emn4A/mm?=
 =?us-ascii?Q?m5k3YOB5qXJ/Ak8yNi6Cxq/0l38aWHcYrvaNc9xpLSl2yNTTUIPWLbh/cj+h?=
 =?us-ascii?Q?thEC+Zv8HePuFpzFZue/tKRe1u5gPjmaTtEovFcEP0SbBddR8zVJEF+P+3At?=
 =?us-ascii?Q?WwQwlR4+28CZn/mEcMuNHtAjD/a67fQyCspKEWe0sC9QIfkUFSVi/zcWCV5y?=
 =?us-ascii?Q?AKpJMjTsncJSzzxnToKpUdXDILZExLFXnU/6xTXO66GINKZZ93HsNkkAtYt0?=
 =?us-ascii?Q?Kuo+wQpwhjcTof5WyDxXAgCHLWSNji5MEalvT04mlvbO8NgbcigyUiuuDDfd?=
 =?us-ascii?Q?1Sxtg1QlZyLKJjhqBFRxMkQ0VkZV3QHpwIFuRsFiE5uIf5svlyduliaxb7ui?=
 =?us-ascii?Q?IVFNB9YNykBY95b8RUJ5Nv2ddhN96gOLNSJsqIOQ5gE8CzvcV+IfANecJQBq?=
 =?us-ascii?Q?NmGyxVtAse4eortXUtHe6Svh0sMDo/TdKUYI2v14gyQyNG6G6KlJcCfMX5NG?=
 =?us-ascii?Q?G5sbNdRgps9QdeJkbkoDaptVM0yAses6A4R0N8jqMNJcBnHfCwQUrBiTQHbz?=
 =?us-ascii?Q?IkBVfwPlpe8mGg78HPVNc/hW1OxH8wmjIS1XElnlyDgVOXdnkWwBjinTq39S?=
 =?us-ascii?Q?FtLu2ZOKgF3c8fpM0vNSFltGvCCqB7e75YyY7Xa0KewfdVRBtaMxzAIN76Pl?=
 =?us-ascii?Q?shCUCJRmn560+SiOIb+qw4PPvA911tMYt73q5Rh5DDylTwGTrPWbPOTsplXj?=
 =?us-ascii?Q?Jd7ir1RuFPB9swTk7XJH36k5PgMKMz+B7DsmNqcNephrzmB5hArOn4Mycw71?=
 =?us-ascii?Q?Q7PMXzrn17sUHM0udJazIJgImo0gx6Xoe+A3NiI0hVqIEoedaJYrR25S2co/?=
 =?us-ascii?Q?gUg6fC0vKXFrcHiKvUT3l0VD7gtVHOc=3D?=
X-Exchange-RoutingPolicyChecked: TNPmGnk5zM+Icvy1cJgtEOLUPf6pMEN7YU47Xdph8JyP2cGr3/+LTZC/C4WSAaqTo5fXfDveQyiCS3F9xNXc31az+BuWIsDoWUFJGgRd8KfiKzK9oQqN2ikgtycOvCrM2TNuEdAFHBT8367Dt6AAsCEBRNXfm9IttcoqvIwDG6ZHs91z7NJscJsgX3zoyFOVJKEgNfYf11R3SNOZpe2Ru1CRV8BDbMKsM2o+z5m94PLLGjzFwtOs2DGKVsg5fADSgv6bB8fYIKJuinlp8bY0wgWXp8xnzXDLXJcIpVSgRFRBy3IJglejn3NdbrRWQBQdGpBI7MJcpcAdBYaTHylVAA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5be6c90-98f0-4631-520c-08ded91025d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:34:11.4287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3u4h/GDZGbcie3g1+oskF6cGPBmScszZvQ//XPWOlRKOv82esm5KQBXEOX9feFKEb3ADh7azdUFuIc8e4aaO1vM7JjSZ9OqgYJt6C6eMMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7540
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfX3TntMY8Utarr
 nMXty1iD7eFz5nMEaVFr2do/zPOasOmTfN5QZxP6BumGYmUPPYvNAoRCn7WdJ7oAk6AUYGDYlNI
 tENMYwsTy55Mmoybs6jR4wAUGxwsZfYyPbOGmh91+SdLfddOWM25t4uh5KWacoUNEQYfk07yG6L
 TUyJhQvvJ2FnV/nnfBSjWWU+WwMxZokE2HLFlmT0hWWv7ojJzQ0ZKk/3m8NNzXh8bJzTQCZNKJ4
 iwiLtRsNTCkSKOBndPtTEV0H7ifyb+DlOcL2jx/ljy3gaVaxNXMlV0ZIxY933KckSEjc9/fOMQ8
 4uGVJ1M/6mgdGTYKDbTHGo7EAO99ZmYVekGrNdlgWfZd8RS7RD7dlwM39ASb1MdkbmDCeAmsArS
 agMTkzhR+B35+4cf29JSWRfXuQ2tLXFWLFta/kVRZ1faSOJ6/Oczap8ZmHdHBLr0fDD8VbGfFhX
 jZGeHNL3W3zy1UEd3uA==
X-Proofpoint-ORIG-GUID: Y_AJXUqs8RfW_oNQuNWE_my1tc8o_03z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0NCBTYWx0ZWRfXzO8ZX8dl0O9A
 ZhDxxpaj/1hDPgud72mUtUYn7PzPOuxQ333ofRdLb/G7upuPN9Cx7GpxEzTCV2xKPTJqhVLxUuY
 m4MzD7tm9DO5bRG9Mqt+m0QywvObIYs=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a47c865 cx=c_pps
 a=c++aTPG+XoUugkGw6UtskQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=Oov7GBWg82k6lRvLM3MA:9
X-Proofpoint-GUID: Y_AJXUqs8RfW_oNQuNWE_my1tc8o_03z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/adc to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Based-on: 20260703135512.3213964-1-mark.caveayland@nutanix.com ("hw/acpi: convert object props to class props")

v3:
- Rebase onto 20260703135512.3213964-1-mark.caveayland@nutanix.com ("hw/acpi: convert object props to class props")
  to use new object_class_property_add_uint32_ptr() function

v2:
- Drop support for "foo[*]" notation, and generate the array property name
  directly as suggested by Daniel


Mark Cave-Ayland (1):
  hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props to class props

 hw/adc/npcm7xx_adc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

-- 
2.43.0


