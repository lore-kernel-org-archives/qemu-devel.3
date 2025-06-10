Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8325C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxb9-0002Kr-3a; Tue, 10 Jun 2025 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOxb6-0002Kb-B8
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:56:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uOxb0-0002m2-Kp
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 07:56:55 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A2kAM0021564;
 Tue, 10 Jun 2025 04:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=517iY4iD0wGw0SAJN2TrUxY1lqf1UJsLXgUVb8j1x
 /E=; b=GzCR7VClsDNxz9FFMfL9L1VldTQgU+Wcoq7ON68ZAMNe7Toz+lev8EDFn
 0S8tK0IYsCUwyHBXtsEDlbfyehb5AFy7+xWWym9YvvrxyLwS0U1w537vaZMdRIho
 qInKkjHR/jmbcU1D05i+q27EKPXuvGY1MiRRMtQvqKWeB9sAOVHnKyVyLisQmWBR
 GWpr9hbGIDoqi6EI9YdXBYg5Wjrnb21eWoF0ro7cQNbhEiPIZZC6VwrRBu34wUb8
 Aa98Gg4NN1fee4U5w3hmh/MqWhd/gEWRs47dLLKrzUXSPhLigSW9v+o66tD3VtFB
 a3pK0NkRTrqj1p0R0J8zNDNHLG4Lw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474jy9x3h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 04:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+0nCdFIJU3/hg45GNk7QzV9FSVaxaCdWdG3ahIuxqiQMmblImzzYtwcamZT9g29kjzEIFZBOQXOqLCuqFMqzyHDt1B93DWbEFuAgLjSKo6Aek1LSA3RH4y50781FC71ZqlwZlU3GCRY335SkLt9T+CuIQNIeyZB/b7tGC4VTFeO7roxPif42u0N9doLAhJxSbc0Zz59TAUTJbZalhNZGxTMcmnZPY5c8k+8mhqgGYQRoaPvbrGpWQMbLAXEfJC/Y/kc6gWIVVX5u8TGvfd/9f45T0l57Vt2zjArJEnkc18hVBcPHnGaq9Xv1iX6c8q3R63trvtUNigpMBDicYEFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Req1cnEBiXWp2gKtumF549o3N1DnvqwcYgkIq+UyVGw=;
 b=MZ4JS+BoVbwulzAHxWI8Vbq3Tz4l9WpuJl6FPRa3BsbJY2mmAGxU3RXKaPl45WlSohxt9loAsIbVNTy8V8XEsqDeqzI9NIHTlyZfl35vpgYF0ks/Y2m/Jw6iMeFy9hk9aGLZPjx6GS35NVOd+jLOjNj2Tpme8uLiNCWx2l1EPFuEPrpVRhZTvLuBbrgmXDaBfA4Pz3fO4LDP1bP4iKeq/BLL4lVTL9l1bP2o2pb+TYS2ob1yIJxFy40RkGgr8ktsOmUPPnBseU6U6w/qPX+soRfHZyjg0xvIrwmeED0ZapK/U+t8oAJGop4HWBQwMYbfZati4/IcxVN24oTEhXKNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Req1cnEBiXWp2gKtumF549o3N1DnvqwcYgkIq+UyVGw=;
 b=XiOQqf4ysZCeNcMSOKIQkwDNWOxYETyj/bQytwqD7iCAk6kOHF8mbtK3dJrXlVsVM2LCzKh8Hvg/X8qCErkUPMonMyozLMg5oNIEG8aJSNrrV1RPSbR5fUFvQph5bp7AarC/ip5hXD2/fcOXcMartCDfdGzXsbi9AOra6vYj+F1mCy32zizdpJH53lDaOeNDoxVcmaKrHdRElJ4XGmwgvWCQtYPPpcN0ffCP1i+PvbZwSIfLsQCQ4xWcQ44hn/WxrMJXo7lPvkmDvBvuyIUA5OHcbBRcCV49pPqOQPb8jWFjkbHHfAP4W7OqrTMwHHmlQFejeE7aQFhBbmOmnQcdHg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CY8PR02MB9226.namprd02.prod.outlook.com (2603:10b6:930:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 11:56:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 11:56:38 +0000
Date: Tue, 10 Jun 2025 04:56:33 -0700
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
Message-ID: <aEgdcfh-OBklhGFg@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
 <f1a03beb-3667-485e-aca3-5a8f4990f67a@nutanix.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1a03beb-3667-485e-aca3-5a8f4990f67a@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:208:be::25) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CY8PR02MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc7aa15-664f-47d4-63d6-08dda815db07
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LMLwKEQ3rNEF5GRRuuKdSxtBoPvCkl+x1It/KXJWNOqUiMBXB6qyP3lvUB?=
 =?iso-8859-1?Q?ny8oBpn32FiWrpelQCUnM7ifabf1639ygn/zHhe3UktBcC7VY7L/Z/YLjI?=
 =?iso-8859-1?Q?ywIxsMgma5dEDWcqkwKQkGzHsL/lBnIuYN3g0cN0rMI+YhwX/JfKXgZEdv?=
 =?iso-8859-1?Q?DMRvJWov6gRzXDQkubCQMePY8mbujJd0sNONgT+IQDIcP9ndIQt/Uz2A1f?=
 =?iso-8859-1?Q?NffbWIPyhPzQooL2K6hJMU/Ho61nmgr/T5cUjVCWQnDcow4ij4a7ymSoQo?=
 =?iso-8859-1?Q?DtZ+WZmjpool0UQCdqEQKfWlauxdPVJJzidRz+hP34XljBSPoUU0jfY+3b?=
 =?iso-8859-1?Q?peQjv0FlWxbFPGNwqzWtryTkXKeZ/Rm3m7N4l50/nenhRUdSYpnTX1DiQn?=
 =?iso-8859-1?Q?1dyXEOKtwN/QIekEHAtxDDKh+yRTV04JDT5ogrqtA9TtEQ/QpxyrdLOjj0?=
 =?iso-8859-1?Q?EaxyF+e864P5JDTFOr2eA0PfVZFUa3+kfj0X8p5ngHqSIGG+9inowNmpHZ?=
 =?iso-8859-1?Q?zS+72c939/649Y+Ca8Xnxj/75APqAtW5pN1uYoFfWZj5gbDqSZUcjRPmKC?=
 =?iso-8859-1?Q?DUFHT05ZqKxWqw0a6K+fV/o5bsRuYBohik8Nfl853vC7448jBSovbBWNvT?=
 =?iso-8859-1?Q?VAm5nqJy7mHWUYd/2GRsziIvght12113AWro9IqHH4sCUSIFz5YzgL4jWl?=
 =?iso-8859-1?Q?6cVcOREZGVuk9UBnZLcJdCExN2/eLq6DSpqn3twTzyx9m4y/HQldUNLLVx?=
 =?iso-8859-1?Q?pzshHn0WbDNiGIdRQNVj+MEAC208sKXiDn3F7ve8X7buxQbVppHtY7dfE9?=
 =?iso-8859-1?Q?GXru7yHbLkUSGKWT5mLGMB3qRtIt61xZaruUFlzrDoXV3Lu4lUwa0Lr05d?=
 =?iso-8859-1?Q?yELRoTtsjIXAgmEsxoub5olSHxCQ09z2r4UAWaYzVy9SXHF1g1jFYfmhZ9?=
 =?iso-8859-1?Q?yHOIIPEniRvS0OQta4HUWgjalb47R4o2WHw1Ch5PmVr75xyUq7748jKGyD?=
 =?iso-8859-1?Q?hljy3Wis8SGg/Fs0hEU69t52VTiqcjVzeM4JN6SgtRg3aw7XU2zXP+re0u?=
 =?iso-8859-1?Q?VqMrn4WpDb7lSR6YzjarKh23p0t92AAUSguipY/Tcu/zjMSpDdc0AZ/xA7?=
 =?iso-8859-1?Q?0rq33ZGsN6Vz9lZJYvSQ0p2kfRua2CAGFj+lUxsBoXzLZCt6jstEIz+g0V?=
 =?iso-8859-1?Q?aG0zq8SYDBgsnEZmsPlvTfBOUQ0d1RUpS97OHV3sNikadUd0plXFL7B4Gn?=
 =?iso-8859-1?Q?S8dNI3cKd5/9tjR+ikGozrmRE51F6yIPhBZ/KMOsUP/vVUcCP9VmfWnkLk?=
 =?iso-8859-1?Q?DXB1S2R9aRCNUHfFLvL28aCTSfNOhLhFGPPbFCgmdGvqTQgOyMRnyz3P5i?=
 =?iso-8859-1?Q?PvgfD+mrM2TD0BQAjHCd8VaaoqCs4gyqyUaCi4b3qs6S6dzIWDWzk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?82juorXgZCcDwSiU7pTko/KvFgUxg8ADZvV3CC7+htBk3+gDQeV9WMh7BS?=
 =?iso-8859-1?Q?HD3QMaRifsBknIuMkcfy8Wil2FYf0gNjdYKyKTsZHi/LxbwiB2CJEZL+c1?=
 =?iso-8859-1?Q?/nVecpmhstXLAPd4l0AXziQdyPhVICf6FDMo4vx8O9YEX/h6GObfIi/Who?=
 =?iso-8859-1?Q?/MdtEYXd8Mh40aV5TupP7C12VyO3B2WexSVe+t7PBSHqdjCTD6D5AlPdFd?=
 =?iso-8859-1?Q?i60SNCD35iTPUNanZGnJfJQP4AogJQ0HbA4z4vY+CeoTiRzTpXqL/oObN4?=
 =?iso-8859-1?Q?EakttD4wnYtUom6JV+wG2em/aiU3RYdEVnyCrzxGvlkFsvDXJOCodXZtFy?=
 =?iso-8859-1?Q?J3ZfW0kNi59r1kzA933AqxSpRb1BNogVuiWGqxleikrWWe/AM7PGwTgGfY?=
 =?iso-8859-1?Q?gj9o+0Q3MakTLQu59JU2Aw69u1yjvA7hj/cc/UvCZlYvSbgoALhctUbgp3?=
 =?iso-8859-1?Q?w1TTYUIcQ3FRqixJPFFCUY79Fy5gOip/rul1o5mMfYx1yNlbbYsUAPC5LM?=
 =?iso-8859-1?Q?p1xEyq3lzaBYlXsi1V9DodGWEAC1khhnHn0TWkATzvtK8Y82a9y5WMdjEJ?=
 =?iso-8859-1?Q?RxYnwfJHJ0iGh76IPVtewogq7GSeOmNO/ZHMD0BPLrrmiFuuvFPWsl3zXE?=
 =?iso-8859-1?Q?FT/P2oXcU2NPqzQZYubZRI/1Rj4QF3P4U7fcV8sBsQ1evNFJ7UNcA2Mhwq?=
 =?iso-8859-1?Q?FNZ8Oy5BwltPte/gUfhsybRzxuWuO+LAqRzW+EwoPlDFeMbzuMZKSddcB3?=
 =?iso-8859-1?Q?OHiKu9MKZkdoVz4/k/KtWdjHPQdePbzsoVi9h4jsErVDkZ9D7mrLxHTmuh?=
 =?iso-8859-1?Q?8gx+YcGoyUWzgYhDge4PJe6tEsbQSVyxQ/QH50clP1de88m1YLWTfw2Dlr?=
 =?iso-8859-1?Q?7pOs2C1zABKBhOxzOKWMVUUhvwMG55NIcwr7Jlqijd9khNVNOid444Qucs?=
 =?iso-8859-1?Q?vmO1JVlWX/9giChWcBf+doWsLEIfHs0BdeI3vp5aM990BPKXIiZJ/KC4Cp?=
 =?iso-8859-1?Q?uNydFE4bQvQpvbwnJExlWjB6pBYe7Ynpl67DeVrWwIfh2ovHrCXwsec3Hq?=
 =?iso-8859-1?Q?llPYUboBmRgRzVp2nyRZQIdhBahH71pg6n6sxA0fEJHZ7Fv3Yo+WjEMfFl?=
 =?iso-8859-1?Q?kry0wt1mZstXJvb/YMmVNuXGdDOagDYvGa+/PZvEq1qpmLHsZxRxLo3zm5?=
 =?iso-8859-1?Q?Vhxy4RH23HyRbzYUSi05Aevqzrh6f4GhJuqvmxRhtJooNbEzJNzHkO7yxB?=
 =?iso-8859-1?Q?dfNZh0YzSEcMvB/OhhvntfWghFc2lvBOvmYRIifXR2c4UBhW8T5NvOKMwi?=
 =?iso-8859-1?Q?grBssX04uCX0JWvSfCaPqjQjnb5saZzdiPJY6kIv1SDtsaGG5BT/g7xwib?=
 =?iso-8859-1?Q?USWpcAhydbKjiMBDfQnxas0vDkyz/zSgyTbBhzSL4E8SQlP+f39P7kkqmH?=
 =?iso-8859-1?Q?AatYiAkod9/o7EH+uP1jf56RXQK6hmmSZTsckNxFAaH+nR4gpYzNjurBhY?=
 =?iso-8859-1?Q?9uHf3nJXrLE0YHPavt5VqT8vG+zXszw63klEEIZjrZAe5T/0CCoQVeunaS?=
 =?iso-8859-1?Q?VnkG/3mQHRMdCAS4K1hAT2hkfI6AUaOZKQjyqL5Mmk65u8YyUk5ykQnxIS?=
 =?iso-8859-1?Q?4gn+NMQoR8aVcPZLcoSyqY3k+egRxV59O8?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc7aa15-664f-47d4-63d6-08dda815db07
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 11:56:38.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVziHgqfDBpuhEILbmEtZdd8VUDq/B+lOWTgLiiERJUiEQIHtsWTNwS5CRscZjqEqO35se025C+45Q9Kj/4YJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9226
X-Authority-Analysis: v=2.4 cv=X9pSKHTe c=1 sm=1 tr=0 ts=68481d7a cx=c_pps
 a=W6PkFPwA6vbAdK70y+XIRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=NLiCwHATAAAA:8 a=7D77f_kO9xQwjX2SazIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=XHjirhgxjc0A:10 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-ORIG-GUID: eR3TN3HQRB1r_7HsIStj2-FjrAzPIB0I
X-Proofpoint-GUID: eR3TN3HQRB1r_7HsIStj2-FjrAzPIB0I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA5MyBTYWx0ZWRfX25tAKJfp+mG9
 oM6FNZkoWJ+bLCxRkJEOY7CugqCNuiqc65X8pkdC6ELx+rDbSxNF8MEgmtgfOaBx8xrMMnHEXW6
 lKqCVkqpK/3xmpYTHeqRWXOn9KD7gLUu5EWvufAzYIbws3ap9ty6eIbb+AoppoKDiYE9oxBEHa5
 piO1bKXdNE2e0EDETukzs8z9wG3I41tyew9EP7nmoGVMW5kQjnFlsF69qNzONUt0b5c0Pu/Q1PH
 fKNJ/jHCufYtF/V783iVze9d+OJ5aQvRKfKcNml1+c/EVJu3b6QWDa+6y7+GPszEI7i/31Htt1t
 n2sxNlIlDOFVCXymg93aCXAXnfA6AkgeRtJb1zuoyf0vGx7UFGv0y8MTXq8V7XOUr+2hj2HVj4S
 8i4EgqAEFDiH2xIV3QhkZ85hFtsyduNUhtokZnb8CzrsUvCdYnot3/bCYCeS1zuYTEwZjC3e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 12:42:35PM +0100, Mark Cave-Ayland wrote:

> Question: how do you see the division between hw/vfio and hw/vfio-user? My
> initial feeling is that there is substantial sharing between the two, in
> which case I'd expect the files to be in hw/vfio as e.g.
> hw/vfio/container-user.c etc. instead of its own directory.

That was also in the earlier patchsets! Cédric asked for hw/vfio-user - and I
think I actually prefer it myself. The amount we export from hw/vfio is actually
fairly minimal (now).

> > +#include "hw/vfio/vfio-container-base.h"
> > +
> > +/* MMU container sub-class for vfio-user. */
> > +typedef struct VFIOUserContainer {
> > +    VFIOContainerBase bcontainer;
> > +} VFIOUserContainer;
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
> 
> As per the documentation at https://qemu-project.gitlab.io/qemu/devel/style.html#qemu-object-model-declarations
> the parent object should always be named parent_obj and struct shouldn't
> have a typedef i.e.
> 
> /* MMU container sub-class for vfio-user. */
> struct VFIOUserContainer {
>     VFIOContainerBase parent_obj;
> };
> 
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);

I don't think I want to diverge from VFIOContainer here, though, right?

> > +static VFIOUserContainer *
> > +vfio_user_container_connect(AddressSpace *as, Error **errp)
> > +{
> > +    VFIOContainerBase *bcontainer;
> > +    VFIOUserContainer *container;
> > +    VFIOAddressSpace *space;
> > +    VFIOIOMMUClass *vioc;
> > +
> > +    space = vfio_address_space_get(as);
> > +
> > +    container = vfio_user_create_container(errp);
> > +    if (!container) {
> > +        goto put_space_exit;
> > +    }
> > +
> > +    bcontainer = &container->bcontainer;
> 
> References to the object hierarchy should always be done with the
> automatically generated QOM cast macros since they are easier to read, and
> also ensure type safety e.g.:
> 
>        bcontainer = VFIO_IOMMU(container);

Ditto. Sounds like a fine future cleanup that should be applied to all the code,
but for now, and for review reasons, I'd prefer to be "the same" as hw/vfio/

> > +struct VFIOUserPCIDevice {
> > +    VFIOPCIDevice device;
> > +    char *sock_name;
> > +};
> 
> Again as per the documentation link above, device should be called
> parent_obj plus there should be a empty line between parent_obj and the
> other members i.e.
> 
> struct VFIOUserPCIDevice {
>     VFIOPCIDevice parent_obj;
> 
>     char *sock_name;
> }
> 
> Note that by using QOM casts the name of the parent object member is not
> exposed to the remainder of the code.

I can make this change, though, as there's no vfio equivalent, if Cédric thinks
I should too.

> > +static void register_vfio_user_dev_type(void)
> > +{
> > +    type_register_static(&vfio_user_pci_dev_info);
> > +}
> > +
> > + type_init(register_vfio_user_dev_type)
> 
> Use DEFINE_TYPES as you've already done above instead of type_init() here.

Again, same as hw/vfio/pci.c

regards
john

