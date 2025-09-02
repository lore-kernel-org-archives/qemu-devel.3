Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F0CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNVG-0003ga-Qt; Tue, 02 Sep 2025 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utNVC-0003ds-78
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:40:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1utNV9-0001D0-Ir
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:40:33 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5828ccQs3048094; Tue, 2 Sep 2025 02:40:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W3rXh0pO3WTateKBNOu1uqRH0FYuxxcs9+OusVgj2
 pQ=; b=OzW+h+gGrg9kWcr0KISu5f+IjUNJ6Zm6A7KOzYAdgdNOiYAHkxAsFVNj2
 Oa1ohVbQYdqSx+sGgXIjkLptb4I7OfLG21cutmZBRgrnRsfQ/Ltr2UkGZadvNGic
 LJs5CEwM3Zt6j/NSIafPrKUxoR9VFAU7H9GshP7d/Tu8NvKmU9Evqr7XmlMxgbDw
 uZejcdlI54znvf/DkQHWlrJGUy6LQXFbJh7MlsMqKCv5mrMHqYZQboUuy8eAen5a
 O8G5BlQuqoKaA72oUCt+mY+dRqIPbvPEmoa1bXLk3Dniv2iZBfPXZvs2SxoNH1Fg
 e5ylv1skLD1ZDU9eO2j+2pTIF0jhw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022102.outbound.protection.outlook.com [52.101.53.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48ww8h848f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Sep 2025 02:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ7uk7HjRXbaFIK4eeuZQWsMVaJSPxxPdMXZIjVNOCdqooEKVvgqGYwPcM0sgeRJR2gGprQqRc+a6HpEZuNO1P5gK+yL2Z5RHascxQ4iK2tylJIsV2quRcole5asjx6mooaeBf8V6RpN6S7KeUQ7P4qTvlPBiSfIi4q8UTfF8tzhdJNLzD2Csj0d9LjAH9k3vmTXDemZ/cs/N7JJzlmgdemHo3PphXqFqd+u+cZxt4ebC3Vb8DWnktnQwcccUXmn+hBt32bc21B9RqHGBy4taq5dsRK87LMxiKkOwj2qsJal3KH8gKa4RlZbTgyoNHf2EXing5Im3KUVuCInJpieRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvFh83XRWsNGKlX4womTgqu+0RuHCjXdlMeYqQzZ33k=;
 b=RYWX7R4lucImp4UtoqXsF8bSJk16O+f494z8ye5pPcFZJbGnbT2j2Sp+qaXbVOFJZidSacu8hMy2R0DB15XHII+yLlU1Qi6SXCZ/mtQFIxEKhIgLNF/iLvZha0+z3AsZ5/cXrm1RRZzCAKV+fhPX8/XfH6A9PQ/jvqN/JjBiHgLJ4dfj6pbh1WKBSScTMZ0P31VJkmycCNwDv9CQ2gcXEALaOhVaWodl2vfb2bOpRwJnbgxMTan17UVXlFPZMtCyK7MqZ2HrDrCAraGBeIwDonkYzd51EHK/6jFlysvxnQdYE3GsIBLTgZIsc6h2TImRmDTOpHyB9trimOUkEfA05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvFh83XRWsNGKlX4womTgqu+0RuHCjXdlMeYqQzZ33k=;
 b=JRDdyuYXceKG1/2RaOh0v/Rw7SgSo0K5UolrE5UIdcaTqepkm7G9/7LbG4pQcTL1+ctbkrGtVw9KpHTDzvqZ7NxydCP1NpN8s2NTnUMe5Lm7C4lr7FmZOfLx2q67LQZMHzn+9SHcYO047fZyUJh91KtrdhrmXGMQuJO8g5snRclvO/skRflQfpEGFVtWUJAep8Ls/GgDs+gzY006CQQn851Ki4xSN20pEYfERec/jgAzSTQig/MkSqvIgUuMxoir9uAzWJNnwuNLOjpafAQt7ttz6XnKJLXxJ5pL7rXi2C7sYAYX/injmMytCB4cX8/7nCpvMKcLjZDQQij4mVItJA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DM6PR02MB6793.namprd02.prod.outlook.com (2603:10b6:5:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 09:40:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 09:40:23 +0000
Date: Tue, 2 Sep 2025 10:37:31 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v3 0/3] vfio-user client functional test
Message-ID: <aLa6297F4kdr2qYH@lent>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
 <0d030541-e533-489f-bc0c-82ee2c7fcd70@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d030541-e533-489f-bc0c-82ee2c7fcd70@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DM6PR02MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c4aa7d10-e1e4-4ccc-8b0e-08ddea04bd55
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?G2wsQjmJvPhiybmzMstgNVLoxjXz1xwQTkh6nGJx8Stm0zMgf0fNbZ4its?=
 =?iso-8859-1?Q?OiQjlH8gOYcxDKiU8udm6fS+uCuGxu6XkuFDghE5HoaeEb/PfZ4lkUFFq8?=
 =?iso-8859-1?Q?qhupKn710VKEq1ohVdiEbnSRIac1ju2FsgegsB2ITheBFDLjRX4XRwYQxg?=
 =?iso-8859-1?Q?VFtfP201kmEh+LbigMQCpagYcpIxzJO1815GE+W5Ghj0LQ/6eRkHMDigq9?=
 =?iso-8859-1?Q?GOFF5kq3b7M1jnKa78Qu1rreD73/M1m5HkBYh9Qh3S50zsVyHA7F2A1/VT?=
 =?iso-8859-1?Q?o46Uu+LEdVxbPNMuHmBE/fJz8Z14qOSxdeOvtL2jiNZfKTDMIQ2a5hwldk?=
 =?iso-8859-1?Q?svvS2lNpjv8IHAgzVR+6lgBBieyKuyNoa/6ZazeydTGaWIWqYYAlOs2/Wk?=
 =?iso-8859-1?Q?qafYTAIGRn6HSteqE0Nm/SGt8GmK1BZ8A9qhAJJC+efcbHz/3EMdZZIWkv?=
 =?iso-8859-1?Q?/8pbiQ4bAq1Prx9iEoPuv6gH0MWBtLghDGPmFpfnNsUu57WuilpVF3sAmo?=
 =?iso-8859-1?Q?eST20803xIxW8ymD6jAPq6o2+V8/wcFSHzcLm0kRGWxttt6lMWnqo+7fBH?=
 =?iso-8859-1?Q?8LvxPAj5mNV9uL4g9MvuVVARdQ5tRq0VcTge/Z6KJ2/WN9XhSr5M476vqb?=
 =?iso-8859-1?Q?uO6AC3hFX8oc+80Ah7xU9Px84I0knsbUTtOh5xnFC59cSNz+MFyLub96Fi?=
 =?iso-8859-1?Q?U/w+TD/LHofn58ZO93zwjGgYmsJkM7zKUzf8cB/3KXbcAmSg4EhnBy1ZLr?=
 =?iso-8859-1?Q?d/l79FtSYE7sJQlUDi01WR2nnJTmvWw9wWPufizAdkyeOv3JMLu2kKzZGE?=
 =?iso-8859-1?Q?abixWqchJwjjfuAUq/ILbpnniMmLSbdAN0fKBAvGMfsKogqI5W+X/mo8Ae?=
 =?iso-8859-1?Q?s6TKdalWHX3UE80WfDpbCMrPqw6zHq/ubwX39Fmv/F7VBNOnAtwZM/cW5O?=
 =?iso-8859-1?Q?N7HD8pa1EupDK35LKgsUtb7QfVP5caSIJbyJrfCJbjhwlkzKuNTwiqNM6k?=
 =?iso-8859-1?Q?8dOJMTTXiXwN7Xo3s4sCZca63KPq8z8kWpcUdlIenuYYVvWzhhAKVQlFVH?=
 =?iso-8859-1?Q?tvWc7wBDSPPsFWkCMv2JR7pcfcjK+lxXmzB03IOzIBL0bDwLMAtvLbNm03?=
 =?iso-8859-1?Q?RYf86wnwohESaqENiw0QZEFHvU54Q5nodf0CYcc4ecpeCBSt7wRG5YDs8S?=
 =?iso-8859-1?Q?eTl7a0HD9t1M+bwvzBlaLqc0x0JuumST45F7a6L0ws2a3/tIAznflwNjHe?=
 =?iso-8859-1?Q?kNsotceKsQFLl61XcoVuwOd4v4IveWUwbHm8C1In/ANH21TfcqOo9F8FdK?=
 =?iso-8859-1?Q?sUKyrfN2kfw/oQ4hIDu0rXWw1+ce/xr8kuBLmMFiVRDnM7jLXlm+xWmMH+?=
 =?iso-8859-1?Q?NSU8u8o/cG/hrxl1SQgxorD0Ax3HSzbEE0UYUp7skTAsk9LRxcW0OYgt2x?=
 =?iso-8859-1?Q?/tTzpCMiz6gTfP4iZY77Etl1/GI6Gr0D6Ps7ilaKsK/hvjrab/qtliaEDC?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?plmWqslAhOUMvMo4hwv+6kY4EIBd3AxfTkLEIk8ZMwvQx2U6dRU6euX3TN?=
 =?iso-8859-1?Q?/DQ2NLCiqdLc41vzHKDPxABw5gsYUfk87ZpZj/9ezBy4Z3/Yuusu7iBmc5?=
 =?iso-8859-1?Q?0kbX1OK032T0FY8vnXjkI4BtgcBrqEfPUd5jCMDupWjX2aBON3yqSsr9v7?=
 =?iso-8859-1?Q?0kxThF/Aji8i3ytB85Xhz/PFpBWbczupSsdHm3xhlupCdIKM7CZ2o6VUuE?=
 =?iso-8859-1?Q?JY3dh3KdiLYPCVproE0KlxMShL2gYaMbi8LpmWWfwocmu8VjtS/VVMWU+V?=
 =?iso-8859-1?Q?f1xUnDwW+gtSlgomMeRVTiM5hRN+33MXktmQ2OZT54DOFXsMd56oBNJ+Rj?=
 =?iso-8859-1?Q?20s4vV05yrviQH26nwy1EzBnOk42c0QEFIERTCeZjaaEa+jGkHzirE4col?=
 =?iso-8859-1?Q?XYtSH2UNcfLH1r1rfwnGnHtVRayERLOyRJabiMy4/0tbBBrK5BuyfJfI54?=
 =?iso-8859-1?Q?h4UScmKKlNzS7BRwgC8rRF3RNYRJqMWkW1fmXN001Y2qF93Ni3zo23/4w2?=
 =?iso-8859-1?Q?g3XXpAFW+Cv+rGfdKzYzuM/mf5SGBnRWb71w9v5LdorgpanRsAjuBPrhX2?=
 =?iso-8859-1?Q?1hDRmA09WS+c3/XVZnBFU+/ufAmi7A4aust4EqYrcSjyNEN4AvkzAqXsI7?=
 =?iso-8859-1?Q?jA5u9yNEeu8ucvfGxzZoucVcqJVfTpvrMNwUZrWuDJR6wBehdwfT0DsUmS?=
 =?iso-8859-1?Q?QyWd2kydxYLwEHJCwdKhvDgrFaLxMO57J3tqbwI45ou0Tc7MZ1LbYlqgY6?=
 =?iso-8859-1?Q?onVCgtTM5tM4QMM9szfaNkK52u7W1wJuyFVsQMh/YcMZmHurGVmvUnacAD?=
 =?iso-8859-1?Q?ljepwmJ8u+VUImjf9SZewHPd1QehFhD8lOOt5hDdkzNCLN/dO9i8LWFyT8?=
 =?iso-8859-1?Q?8maWopYD2Xq2F/A3jwZkJ+ymzOqTL2iz9tT3cgPC6uHrdAnxa8HTLiR/TI?=
 =?iso-8859-1?Q?gZcdsqXdWqbhETwgU2nqTv2pcleUeLlQ/kXRVL4adBxRGxP+Ht6QWdGhQF?=
 =?iso-8859-1?Q?uyjaAux3z657pK4w3UV5N+yks/OFOKQARPBiFXOXlum7NsxskgzS5IV2Xm?=
 =?iso-8859-1?Q?PWC/+HrJF+EObpvP3INLR/RVl+T6YUt6PEvna+CPAIv0JENKC7ewoRPLTr?=
 =?iso-8859-1?Q?cIw3MbHR9HK4TO/w8J0QsK7zPu+k2hyp2pBcpZfcdLIbfxJUeBbaHcs8cT?=
 =?iso-8859-1?Q?Ew0x84Fh0Kn401Loq4tYb1DVXb+lef13WFgp76QX2EVbPPyF/WCDA9WMQR?=
 =?iso-8859-1?Q?iJLRNJxW1dr+AaTeR/LcxdG0+NUc0A18owsihHrm2N+HVe8WAq/45idhDQ?=
 =?iso-8859-1?Q?IDGH3VtZ+KAGhu/JwFqW1N1oyLuOK36qVZ2X46hD7Z8XVnpp3ZAzrZdVJc?=
 =?iso-8859-1?Q?/+qcF5KS/0aXqefCXtkL0wTh9FALwASk+djZ8HFpmNWibLJBjXmA+qXp64?=
 =?iso-8859-1?Q?wnLCFL/epUroGRBMdj5/c2PYlcUzr8AeNoi6zc3di0oC7rLab1IFVev1NV?=
 =?iso-8859-1?Q?o+baPFmLQvwrLZB6NKFyPlhR6t8u6w6GyHjhkDPmhoyDcU+XpmqZcpdl/O?=
 =?iso-8859-1?Q?kPv8QGkx6tnYNMwhdrwLD4If8BbKlDnBmGJHJh5DXnx9tygeiMFD8CdDsG?=
 =?iso-8859-1?Q?VBWB+OlkEaBMESaUzZEQlilm+E805+2CZG?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4aa7d10-e1e4-4ccc-8b0e-08ddea04bd55
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 09:40:23.6865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p4UgDe1QP/i2VZHXs1o4H5Aq6EOkzqeo5g38EPHqL1JkLgPv8iRL41RpsY0Rg54jLLF3W9eMtnUheMqsdK0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6793
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA5NSBTYWx0ZWRfXwwzBJlGDmTs/
 +ZFxDQqHBzB0NY01t1ii9q19NiBhqVturoy1ZrpS8lyKyTu2qy9susfasFEhMovTAsB+ljNKIVO
 gK1NXM0cf7b0B6d76pwlvcoUcjiTXSB0Z7MwP/a+H7Jk9zyXC/1kEOwqdRAel25BindybqfT1Fl
 Hb/WVin7+NFD1g5AU+D96AS2BQG7fL7ThExHW1rX8WtFfJYuKcyeqdjyG8AcaO1ReDhyAh/DfMx
 u55JINi6Hf7AkvlGiWPFV/8fxnS8KyKI59DwzQlNtYJE0LRz42+zCVJNkCT48wo3mX0d1njfpys
 V5IUTayUYRlX/WGVMuQAeXR66uL9F8KccRQTPn7yqym9dHw16QNRJd98PL/Rs4=
X-Authority-Analysis: v=2.4 cv=TONFS0la c=1 sm=1 tr=0 ts=68b6bb89 cx=c_pps
 a=2Rjy4IR3uOVgXvcUMQBuHA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=OYgiqOW0Ep5drh3CiNAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: NeT914vZ39GCopyTpEZWvSV8JSIbgKTC
X-Proofpoint-GUID: NeT914vZ39GCopyTpEZWvSV8JSIbgKTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Tue, Sep 02, 2025 at 11:25:46AM +0200, Cédric Le Goater wrote:

> On 8/28/25 12:05, John Levon wrote:
> > Add a basic functional test for the vfio-user client, along with a couple of
> > test framework extensions to support it.
> > 
> > John Levon (2):
> >    tests/functional: return output from cmd.py helpers
> >    tests/functional: add vm param to cmd.py helpers
> > 
> > Mark Cave-Ayland (1):
> >    tests/functional: add a vfio-user smoke test
> > 
> >   MAINTAINERS                                   |   1 +
> >   tests/functional/qemu_test/cmd.py             |  65 ++-
> >   tests/functional/x86_64/meson.build           |   1 +
> >   .../x86_64/test_vfio_user_client.py           | 407 ++++++++++++++++++
> >   4 files changed, 462 insertions(+), 12 deletions(-)
> >   create mode 100755 tests/functional/x86_64/test_vfio_user_client.py
> > 
> 
> The test is failing :

What is the parent commit you tried this with?

I've had to fix this from a rebasing before, but it seems it's more sensitive
than I expected, and we'll have to be looser in terms of what we expect to
see...

regards
john

