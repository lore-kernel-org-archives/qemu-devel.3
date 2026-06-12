Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7781ECD4F2C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXxqF-0000zW-2a; Fri, 12 Jun 2026 05:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wXxqD-0000z9-G1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:06:17 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wXxqB-00020l-SF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:06:17 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C38aq31683126; Fri, 12 Jun 2026 02:06:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=nTWCzIO1K5lb3e/Dcnz9BZsyCqRmEy6DsmAZgRm5l
 0s=; b=TuvptFrTW+2P9hCfFFNiQXhqB0iRGkCvFUVmNVf9tVj2CZx7B6W47/7Hj
 xTt79VRWTrNMJnhISxW4qRoxpmDFtkOpIkN5HYyH+TdvDqfkP0jtx3w9JWhN0PaA
 fa/orGgGGMehORSJfS5bx/xrmKi2eh4IgcOc7NBXBof3YQ1cAz4Ed+kwtGFTt6p/
 KaQ4k9sAQSnSlpcwQK14+4S35rCYhAqOOOZGo5FmIXyIeIajSl0/5fXxzm2bvGls
 27rpOlDYEjTJ4ljGKZCdXKCmp8VChHhcIbjzCqYvXSSNs5vwxsIb+BVOsLuUQTMZ
 HocQ1EeU9k2meX/ulGNjpvD7ZYsHA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020084.outbound.protection.outlook.com [52.101.85.84])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4er8ud8sq2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 02:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr0FpmrbUMjxlH0ymJNG76PNtADAwPMlB93UswvYCqa2BfaRSmG+Lpllrxv1L0syuWADRPVtyxKBxrBHbBfS33YUuGIE2/evlIrd/ML2eO2kK2LJs08jOSXofWvFD8NDx5ydU7xbOLVeAhNKvq5xeE9c3EaXpDirfExTL7xqdJYO9eU4JZ6Vk9nU/Ljt8b8O3ATxsFJTNbF06ujEdb2WIA9Mmfw7fSqLHufzUc3LpvBg1Q1vFRmEn8L86Eicx/7uI4AHkOWq6mUgTIglvWchUkGYeafM9diOq0fMksGrWTAwYOiwWf6LCHnn1C0iBu0ZhQvRxU02lqmLDCkY7fFdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1REn+F3nn/xmRzGNDqn3JfIpd7VItfou4bdXhlruZVE=;
 b=G6tiXX6SIQ4EzwrKLHn+lrKSyMKIBj4wz8akNABU9UkTwP4prHSfFAWqXkrI/Ris18WUgFulGQYkpDNInXtC20rNNazh60woczj1i4tU6eDAg5Ehh/era5KjIG9/o48OXplBp32bVWhvjdQZM0Ardcbo5caBhmgkCzP8OoH58zQn8JSAGHf7ylL+UA06/zn7NYEedeYHy6aqgRg6gFs7xFQZn8HcxnIfFDQPBkU601OREU53LBi+oguUWcMrnIu92MlPjcGYVJ5dGoCkOdEiuYQ4IGC6GuHhpyPtcg09vcmkSQWYaqWgoRieUoFkdyZmlXwuJNj1XFy+ldSaYJNhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1REn+F3nn/xmRzGNDqn3JfIpd7VItfou4bdXhlruZVE=;
 b=nY+Ij58z2nRUYsADweSdJlN1TC4Z8R//IrehQMkGHNiGrOeJzocxw2IHv6Da5uzsPVqsIov/iPSxwPrYcuxv7rGrb8XyvsUzgC6HNAEryiCvI/r5tlP770d2HwPpeG/VtY4PTulZQep1+krquu+u3q0GyWmyD0acsegCeG/NlovPfCq0mohEfRzpVQ3MakDTXW6OmiD0a7U7izSuKJGpa09NKf9aYzuLEZ4/nEOrW44QryKEL1wIQO9RIzAcEqx++MjZ49gb+wAyl0aObHpauKgcpPnIVB67VZV9y/RdzV2oCIRreK7MHLc22U9SmiLiiBU5LvBklCvONA7fGqVi6w==
Received: from BY5PR02MB6753.namprd02.prod.outlook.com (2603:10b6:a03:209::17)
 by DM3PR02MB10232.namprd02.prod.outlook.com (2603:10b6:0:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 09:06:01 +0000
Received: from BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57]) by BY5PR02MB6753.namprd02.prod.outlook.com
 ([fe80::a343:65a8:bffc:5a57%7]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:06:01 +0000
Date: Fri, 12 Jun 2026 10:05:57 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: zhaoguohan@kylinos.cn, Thanos Makatos <thanos.makatos@nutanix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user: validate VERSION replies
Message-ID: <aivL9a2bpFXKmEN7@lent>
References: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
 <fbcf6e7f-c25e-4e37-a171-46a484a162d8@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbcf6e7f-c25e-4e37-a171-46a484a162d8@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To BY5PR02MB6753.namprd02.prod.outlook.com
 (2603:10b6:a03:209::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR02MB6753:EE_|DM3PR02MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e04330-8818-49bf-436b-08dec861d30a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ek++bxgy+TqZ8XQq04k+uD5v0J5t/2yq3dARtrmE08Rbd1QDcsa1FQMrD8Oj8+LLjQBjrQ9vAtiAPLe1hj/U3F7dhUgS/xDv3FIekZwPb7rql1NAFrK/wWI841vAxzQn1gpEFRhFgetXu3zQVd8+VhYbRXjCwpcjmfEtso3lZraqK/UIGhzISzJH+3Odb8whRJGRM+GOX20XstyFgWxj2AaS4APEl8QiimcxCBkutNEWIvuKW/NRyKizV+JRjGJVyk4rIKGUyP+h/00JlRlVMWL3uyCHEtdPz7HDmhoZFRtvtUaTLT7K2S/SxDrMAp70DDBwSJMEeWBvi9rxANVPmWvpjPVAzuDRk5ryvuaaopZKE7Gyw0N2fdnqBPk0TWclcODrKKGH4eb22qXBJLRCnmp5qKD2XdVAXoSbqDKcrgoHTfNN79pBNXyPFu4yFNlNPF4p10eLwvBgYN9yFnIpmMb2/787ia4ZUbL69XMzdK8L7yD9zh+hpJm/NGkDl8W0kJ8xsVHOFfGp1ZwVSxEhljVndA3Fw8WV6AKEL9Fo8XJh4l4US0k+EVSXCceRM5hXLOoCbsSn3y83h50BPXMrsCJOvSzscbI239NL11UvK5MuB2VnbfOKYBqsY7rURuYXF26jyYN5ytWKc/H/MB5BopoW35StJ/mShC61gTCvHl0vf5d0aX48Kweg4VfRZMdX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6753.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?sc+lODwJIpSmd3wECH6TkIzza0nD0benp2cbnAxo55a0JI6BbRSMxmIUF8?=
 =?iso-8859-1?Q?oC2pajbsaTQvgh3gQoZP2HlAEobD3iz3F1xN7bKnk+zTbD6rRcnQndk5ys?=
 =?iso-8859-1?Q?Emfv5P6WwcPzpsbsuWJY+uexZO0oMxohtDntIzsZ1WJ3uGVJTq9pMHc19P?=
 =?iso-8859-1?Q?ZbvrLiSchG5h4pHWdUkAD1cCZWC+X1j1GkCOjcGSquSU2OApjIF91Pajp8?=
 =?iso-8859-1?Q?ScEBavpqVth8aLke0MMP0xhKXCWEHWSSt5w+5iXFGaXLa2IVrkckcXNXok?=
 =?iso-8859-1?Q?T3l1xHomzAYmfJi6zbeo93jly6nEwrkDyOa5G0zJjA6sHMcUM5v0nNbUmI?=
 =?iso-8859-1?Q?tlXAkkvQCBcfb903NWMnIGW91gNWY4Shi9nbthVPkjB/lj3G8PhD/jzaPv?=
 =?iso-8859-1?Q?tWslgNYRdV3rCUqiQf+75Yn5t/ldmrBHRGYLdegUenGoyEpQKYRdpPoQM1?=
 =?iso-8859-1?Q?tqNL4/RjXGUU0L2kIbjnkBPv/JlsWybYSDrlTZs0KarzFP3vHrL2bEDchX?=
 =?iso-8859-1?Q?Aae4TcClJz1d59Q8TDq7bmuYpQCTSjhEslMXLSPvr0/xK1rIeVXYn4T7KN?=
 =?iso-8859-1?Q?55j9d2/X1TjQcKgqr4m/uR7dsPh9XkvDaPRjgelcCAtyAYMXbnH9Iahu1F?=
 =?iso-8859-1?Q?6NkUxz5vICOmi7TQMYCTg+t5qzK9XEu6QXIn62w5Yg6QK4M1wWkzGDAuHo?=
 =?iso-8859-1?Q?zHBiC3sgKXYSaM0IQOA8FXICwFr5EKW32eseefxl4MnhtDCtO9NcpyRQW5?=
 =?iso-8859-1?Q?tEaNFqqrxoYN3CILrEvLWHnqJq5d7ca+twgan5h7YEljUCJSlDKbQ6RvA/?=
 =?iso-8859-1?Q?WBXanO/0+prhulUQnJxUW2rH7DufOHVRWBhl+PhZ5o1ZXHIPAGyZGTRKcW?=
 =?iso-8859-1?Q?Mp71rNQFCeHZVc20k/xRPPKhd/lGN4IlmVZ4oT9KVbgK1zOL12k5x5TVlY?=
 =?iso-8859-1?Q?XFeEVbMupBc0t11pPYOwNKrKNDb+ZjiJte0YnQAPFbXxulbSzmZVD3GUyf?=
 =?iso-8859-1?Q?GNYbp8H40qstYe7KIUyoBKZj2lHRIva03Q/jy5JiVJS1/KooZc1/rrfq78?=
 =?iso-8859-1?Q?b6OrnVzx8H+PpJaauGsTi/80x2NIucJE4G9kULZRo6Zs0B4DB0NlXjpCyE?=
 =?iso-8859-1?Q?uBykHtwWuy1pcEtb8hILEqYBTHek4nddgjOXWhgc9QdFUGNp0HBh82Kn8t?=
 =?iso-8859-1?Q?BiOO8SUFPmTgJ45tM0SCUWm2+cPzrZEDpjWqLWcOrG9wYA+yM8hziijiva?=
 =?iso-8859-1?Q?ZzSHO9B0XDCqEUG/GBNcvGYVEL0w9Xbn+qnSrxMMWLPmlBv++xzV/vvttI?=
 =?iso-8859-1?Q?Ta7ZS4uIvfiJRpqbvr4HX2FK+1TaqYzrgNSxcfmj9X9WON5Wkm3sCRZeyd?=
 =?iso-8859-1?Q?7zE6cCyA69G3AmA95+Kec02ndCCMoBvCQfc81DcTCuXD3whwTStNAZG4R7?=
 =?iso-8859-1?Q?gl1Nz7pZ+zGMFPHja4mozVEWLySvUAiwy3b12hrgsY+Wi1GHk5bgrR80PD?=
 =?iso-8859-1?Q?9aYCEP0NkFEEG7UPU7poRhaGp+bjuSIcLnedk1fZHzEFZgwptKOHImYk8e?=
 =?iso-8859-1?Q?3eagEuzuRJIPewL4vkrAZ/530O6q5Q8MMVvgAf5qcHwLJCF1hlvkthzcNn?=
 =?iso-8859-1?Q?PHwZmz9YgJIp6Qt9BrRQwY1QO/3QBwvfJZdgn+0LzQFD3J1sbWrUXWX9uj?=
 =?iso-8859-1?Q?dMrYzZxxKEwwMPJKVOycsWiVozEmcMTVVmSgUCSk6syicTl6lfhI26UUZu?=
 =?iso-8859-1?Q?G1IIupLilY9RgSYCgujHXsRMRed1xrcejDHlB33WWrm3clYOvAAdQObnCt?=
 =?iso-8859-1?Q?4IlqqhZLOw=3D=3D?=
X-Exchange-RoutingPolicyChecked: E/i9RfyZXY6XHp8sU4hk7A4T+7lUSvvxh1fHCxdyuHo6jz7g1feW+FuYBCrr2l9mhslYqipq1hI78yPasEdV1pLgFtSv4yXLhtwACb6w9CvLCtcBlw0NIrypbWkGw6MJZOEHIK2RnGw1CT/VX1vF1At/cGxuauDYxWvZu931rnhHMoQmUReA0e3yo3zilal0BtVQyNH1+H5DvfkJlgonmPgImCkIihZD8rKyesgUfD4OCIJgFoLUMRSzODQuufpSoT/pF7a7tY6ZykKv66/oO46ndhtI/F7xHA1ytHwoRtm5WM6XTb4I1ES7r1vZyjxlq2IBt1sIh2dLN1hTekJ5pA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e04330-8818-49bf-436b-08dec861d30a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6753.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:06:01.3115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFx7Am+h1/wA4vwpXGlEoD/ubeR0+NgHO/EDtEHpb+FagautHBpgb75dhpg6muW2u56PH7runU4n/a35cx8KZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR02MB10232
X-Proofpoint-ORIG-GUID: SKBS3BmvQ8J0yxK1yqNUtt23Yt32_mwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfXwdRkMC+LfGgp
 AOlKCPMbfl60CD7gjU7dMuG2Cz8E8XYuTdBPxPq5YVUMF+TRCiwxWu9K64JLNIkyz9Bzuev6CEf
 LY96ldYT9mxA78Kg4bfrLpF1HdfFGFUmM322RWYJ+tuMu8cAXuDr07iPhnF5MaME9PoZ73uQOei
 3oFomGjdcsOpeIoeOBwHi7NxOOVFpwN2VvPe2P8MyL+IFV+ydCWmYZk1mWKc1TjViuYwuRwEUJB
 J9o8aYfgGWt6En+4drT+GTAaOVlgdlJfDwN7cqL2qbGjcaXEhQARpUPvWH6Ot2koWGswK/UY2Vc
 GLjWLJVgJzNvpEtVk3CByMoTjx3YpAKUeHp7G7+Krx+y/xfzeHHdOSqwYvtGYgy9XKLtNF15YQE
 6xMXEbJ+D0XmtvN7IyszQxocqNKZmByOmhPSh8tMiPYOQ9ZoNRdpfg3cJtmYaQaPn9RfDMzI0gK
 pBtiZn6umzNQj6Qg5BQ==
X-Authority-Analysis: v=2.4 cv=AfKB2XXG c=1 sm=1 tr=0 ts=6a2bcbfc cx=c_pps
 a=1XJinUMeHr/5msdtnNmmhA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=lMLPEW2cRtEjdLPvwssA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=QYH75iMubAgA:10
X-Proofpoint-GUID: SKBS3BmvQ8J0yxK1yqNUtt23Yt32_mwK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX38ZXGjI3vqxp
 6ar3BuZfmDBCfrt7NVbqhg42qOaX9tl52GTQ+U+TzunKkmG/uqkhNg5kk+dAciIjo5fnJCKPKnp
 znzsw4iWyfhxzguKHxxWdI3Fsj630s8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Fri, Jun 12, 2026 at 11:00:35AM +0200, Cédric Le Goater wrote:

> John, Thanos,
> 
> Does this change look good to you ?

Sorry for the delay, it's in my inbox and I'll try to get to it soon

regards
john

