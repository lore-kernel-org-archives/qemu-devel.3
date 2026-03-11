Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26EC1125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MOB-00027K-T0; Wed, 11 Mar 2026 12:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO9-00025o-Tc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:25 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1w0MO7-0004EU-4j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:26:25 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BFh1Yu1315708; Wed, 11 Mar 2026 09:26:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W8+ltoBFOZsTWm2QrCXjhrEa9sb1XXib/KMTjtQ/Z
 YY=; b=pTIpJSyGxEeuHLvmXzLA6dj20Nx5CexhqmNMAz/2hf0pi0KIfP9uNDOpE
 dKO097HmueyEMhoSpIGvs6UfXdFMoi/0SWgoyc9yPD0/gRuLQCyFi3D3VpRCnOZD
 vGSeTiA3AdIcuubeuRbdrCcxWaRgLnUwOczcgXD30sD2Y/FNGcrtVorRyA0bqycJ
 VY3B6GwEH72H98L7z0SkLk3OXsTQGPr5hWwCzIA1QsFVKv97lwcBCSlqAwTdTU/e
 w5PapsqRPBubukzzbeCmZ/eXJYOKtAuKhXyr8lOLS/Z2BSv6Cufw8JlObfuTHncn
 75hn9Pm46woezYuenvHR3u08X2W9w==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022124.outbound.protection.outlook.com
 [40.107.200.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ctu562dte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 09:26:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2TKeTO0L62R+d/cD4lqZnBm46dE5ANBVcOEw1Zf6pxOQTUkqIpVtlKQLQ9fNQdrzyAcxVSedP+qjefPQYAm+K89kMn62h8+BYqjTSasA40DyokOXDq465rPnoIbDzLAf8MzdL3550b5XGJe3Iai/j4AofYElDb74U+rmVB5P4swbK6Xr+n1H1D+4uLrqxTvCt5OLRfBFahluYFsxI/if41e7dzYZIpZRVEYlRLetFv4oDsqAjwSSF2lud+2Y2ybrZBltYaJinJC9DVkei8dFbb7n5Nld+sVFiEIxMAcYJRjwoE6e27WP4qHgFpr4yIro2r9cDi5jNAv1VMgpltR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8+ltoBFOZsTWm2QrCXjhrEa9sb1XXib/KMTjtQ/ZYY=;
 b=qIVN1nlasHiz6zg8Z+4K14KLWp/Qa36fQ3fvKR9ZYLX+VyPr12fGSaoV52iY6x7DTqLYswcFrKgiWxKov87IYBN/Y7M8ymkIyukZYLv5lVQ0OAR9uSUVIv+hkOZEnZ/TcDVBd2jGd7EClpXEwAqK1yg+tnVEfCb9DeRw2EVLfVcDAxtMhXbgDlKshaFm/7TRtoIEXZmB51LbwJgd5rVNflS1NHHO+rZDEkZB0c3bqfTyDrzB6YTsE/J+p81g7teW5VA6DU7UowgIPLMZLi7gNnKSo8qLGWB6QfhqYwrYNiWTcZFwrq+73eZ1q/ZDDr9DgrFcnJ/7xxDTpc3UvRcKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8+ltoBFOZsTWm2QrCXjhrEa9sb1XXib/KMTjtQ/ZYY=;
 b=WNuRe1aeEeg6FxRf3aLU21Lk8l6yWRRRwyWxHPVg4aQIf/X1io0iXlBsL6xqBdXLBJHpmRqtt5wnTJakCW0Lrh3BsqpFIYcCmQwO+QJB6tsFtz3tA8WScxDhAF0jz1d2w0bZIRlovKO2UVJnSFjoNLBmmps57TTCLBUOeVnVAVw6U5frpwqPEpRQCEjg48laYqGTi2fbp+FQG8dtc8yKi4LEqybO8d62RIPL/htT933TNJ69x4uYEuTueFB+evmI2EFD+rCi6VovL8OKVTn6rGOJRlpXNhMOVXdmC9Of4Auon+KLbmThDr2F5mInhjbnYguTeVmgLrIrx0Nu/svJig==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:26:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:26:17 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/char/serial-isa.c: declare IRQ as shared in ACPI
 IRQ descriptor
Date: Wed, 11 Mar 2026 16:24:28 +0000
Message-ID: <20260311162605.2976339-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:610:b2::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV0PR02MB11111:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ccdb36-ae69-41a5-d32d-08de7f8aec3c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 9FrFa7H+zkIFiKVVw89k3KamGF+LJ9YJhw8TRgaep0XmMxG/7cdB4uzZSMrcGU5mDnY/Y+onfHsebtwwhLqzv9KAy0QLWhtEbhjBlRGJmumQgdo1IjN9cK5lbZJR3/3DBpqZVSxYMvGNzMdn47hVjQjzx8DRe5V9gz+qsJIe8V161hOl6fHxJ1/BT9suQe74+uHi/O8cU4ic2ScwKyT846s4IhtCsfWCwey9F0mt5s6yK8/pLtdVAYf+5gMebxTOXcuAa0+3kArOjWBrVSuze+FJ/hzIQC/zHk2Q4hvQF3lZ6xGASgm3m7jleoTWvOKGlZZWzigFrzFVmKBuMuk+wmO6Trx9mkFUmXWhM//u4UnHNAmKgVVoT6DGUEl1Zp69StKsNngBGRmGRbCZEyJjMzlZx5lxDkE88Dkcf6DH4V/HMmb47XiA5rkU4R4pKh4LnmbePUx9NLwdZFkUT56+UPZlHegr9mx3ywyGnKYmAetgnNjh8nv9duZeH9Q029dTcdlpBqo+zSDilFMJiCa31hDJ5lmJSUbEsDYcl6XtmLAXrKnPCyWD5QioeA5FrE85sadwijnkfkEzgH8/3SS2lvO742nrLafqcDMuIsvDRM0/ZN6K0ubx9rpJrWuBHw+ogo0t2yBV53aCxZ5yNol7ID3+xLkkWrpi3lbIWTmf322pDk0EFvxAdR8ZduyPR9ZBTVQJsMcKOCbXxriDOmCYQQyud8qQEYvxiph474Nzuys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxihnvkqxuagYhD3EX6nkFrg8SNwSJkfjFLSUVbv3y1Yfgpmk+0eRA3Nz2yT?=
 =?us-ascii?Q?7CIB1Mf77hJz9fG0U3Du0JhajQM78gks5Oge3OAiLRXa3Qj1IAkfW2tgBbGx?=
 =?us-ascii?Q?v8nkUb5uBeky7udfgan7AXE9BHoqzzJnU+hUVr4A9tvnjNO//O/3aLLdf+wR?=
 =?us-ascii?Q?dH7majJ0Ebl0O4SDicbSQTwDy2nVw7E+NE0jRpO8yMZo5jlJcy4BCYKvidsQ?=
 =?us-ascii?Q?23LvuNPqPk9ROz38bfm5a60AdHFzMMOlz5Hrj5jPPzh5ZLw9b6rRLT6ni/gp?=
 =?us-ascii?Q?bEJzZN57F71LRasPbzwUDdyE+GrtrhzyHszSi4O1iHimgI2wbzK7Totq03x0?=
 =?us-ascii?Q?M7q7lUp5Hs8wHeF2E/EZyArGmDa8/9FptPBr6iHJUafgO5zsSPQo1CtdKrf4?=
 =?us-ascii?Q?CXL+JSCeJEHnlvnziflZBUlqnahx8s92HwiicTfaF5CF9Sxxb3OozuqS5ut2?=
 =?us-ascii?Q?n+RFmvE3N86i1xaJG3O0cUReEDNhV6N8J2UAs8GTOeuPxUc7EXAnZt62xEd9?=
 =?us-ascii?Q?h4XnDCeYtFWzGQDOliRIGKZzczwBpzM9ows1Hh2WSbeyzPISnSzulWRCzeDw?=
 =?us-ascii?Q?oPHs3XsSS0UOhkNVMYID6S/gEqEAOsBa6W6drK+mdTiCxmtz5t7du7YhGAul?=
 =?us-ascii?Q?Y8hUNQpzU6wd5Vwi6RxLKke3t1YcKTBmq0/3ckDZ4mN98u0NrBr10Lqq65jv?=
 =?us-ascii?Q?jF+R7gA0Lz2MuyibUbPzXRl///RTkldgNG3Dfsyw5o2iwl+TJBWspHjKQ8l4?=
 =?us-ascii?Q?Tgu1CWj4Rwf+KH2V47iODcQGBEhHtczpX8M/Wo3V83x401a3a3ILbjywQCul?=
 =?us-ascii?Q?qocEfurZho6Z4muKTWSbQ07a+mdhre60STT/okv/hQ1nDiZAkNgmoOdtKNUO?=
 =?us-ascii?Q?8McnMxa7mb2F88PNqRSAXrQcqmgkpYU7UsNyJjUkyTWoJJ7w59l/06OsC3gp?=
 =?us-ascii?Q?KrBo8gV+P2M4zsrtst628O9ZBWVqbduDS+qik0OPuwyzq8gvChJ6IVkZQqK1?=
 =?us-ascii?Q?q1lyOHz7rJM5mRdx9Z28CNiOsOwNq91WdzP8KYS5Xd2jAcZIJwHKwH69tann?=
 =?us-ascii?Q?YkXbJpWvhv+Yb9tITk75rCsHCQCCWWSgbfLlczKDjMEeFIyibD1XqT7nUMzw?=
 =?us-ascii?Q?JHQF6aLQKLehZhq4QvNo8i4+dh8SQPkjdbcMJ6KsYUzB/1ONac5brqK+oES/?=
 =?us-ascii?Q?IE+E1pz6sUwOf4zlZ5OIqkbs3Mo77euPzJG1X9klIxsvJw3xWmqXYDtbsB9m?=
 =?us-ascii?Q?zxEhzOG2d9nBlXWKc1GPIqsfbx0kIaQQTjs/2PQ+ujviz3jPmzvl9OP5GXWC?=
 =?us-ascii?Q?SIozmp20zFiVSF+Bl0b0l4VF2ms/OhlcyMDOHoSZKG3azgV731dX0V1wvnC+?=
 =?us-ascii?Q?8yNLpEO712B3rKMk6ZKveBGGBx8pv8P/e78PKY+Bylamx1fWRPTMtx3VrSrn?=
 =?us-ascii?Q?0uovkXU4xrAP5dJcdkz3iQ39ldNgyQXtRTOIzsPqrTtTaTytgdQk1gklN66M?=
 =?us-ascii?Q?YQqadeIbSoxiW+I7pc/0jM4rYerVXTThK4smFB9ZxDRWKe2hMdfc+1xsF44X?=
 =?us-ascii?Q?b4G6YOfqZlfY23YBFJRP/lJqCpYITbhjRUuIdoX4uQqwQ+aKUy2GNUaTBTj3?=
 =?us-ascii?Q?RnFeGWJxDqTSBhnEn84Pkg4uCj4L3lJztEWConPW+HY1uQAQDue/w0c4BOga?=
 =?us-ascii?Q?xmoEHuiMkIm1Lk6D7BH5ql8xBtty8PZ6ZyJBmfDbhgVY0DWBrLqyGZnM0456?=
 =?us-ascii?Q?qecbHFHcZ8shyDY1y2qYlXpGYnHp+mU=3D?=
X-Exchange-RoutingPolicyChecked: XSirqLnGNqC25cmDu/v6iFJ89v2nyrP31SGuoZWWYI/7kUMYlUc55MVbnShCitNBqFXqgyDYP87WB0e88E5NzOufbGNkj35oQ6VEDg/12h0ckgnQ7t6j86wxOSzO4yxVx3NAOwLs+cPJneb4mlCChQGjZRNSD+eJMS7kCQE7Ojh80XMvRlZNJvvoUbyLwvAZ8QGW16IBY0eRGk3UHA5bYSPMnjnXIO/PE03SnAAyUCdHrmGvWV+nfFQ6fMdpEXBtMxcgOiSdOWjYNf4zLHrYe+CcfDsCDVteHOCcHpwwzbqscR6hG+aclJLNQPDSEecOn38EOUMRxHI10zfxczctIA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ccdb36-ae69-41a5-d32d-08de7f8aec3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:26:17.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqPJBxzwFgVctulJ+2hevzNj1S97qjVRPNmIAdVziKZeZoAcFhRDVFVLTvVac/aKTzaTOiPZqnfVgUO7LPkWPeb7RPv+vjeBTPpGsx4hpFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzOSBTYWx0ZWRfX0DfXDLrTjAQU
 bKSP5g2JmFcesmiV1yHcv5/t7T44MgTijJ9XhFA7wI/tM6iVt/x8RmhFCUg3wcNbHWCidYyrUC0
 dq0vnVCO/WoTgny0UoLrOTCEeAUBCKUY3mvYa5PYn6LMuFL/okjqhv0+BIgxi4qwW4FDq11Z13l
 wrqSvoWV1MXnA28/qpLb9tH9q3kKesZRRyw3qAz92JkbV3FZbsZ4q/6l0M4lqn0LIb2JeTLLWhN
 a6gMvQj9uw1wBDxl2gKU6MX+2zL3r13p1An6ltbiNJZ0dtrFBA8PgD1V13G3b3K0gnLR+LeJsSX
 y48rxw/sT4uhI/hRymQTjf3HIssj2CphQe0Qff7LYGdES2nh697ys3OGHyNtI6xKY2x1W0j9P7C
 DoVd8weKEZ7LJny25Lyc3AKkUYw6xHHuFC4QSoe2xdCDixTTLOV7YmxMRSG/oxtyx7EAUKsggMI
 /BmyjC0tTQQMV9ITirw==
X-Proofpoint-GUID: 96sqOniPM-J1b2-dj6BxBKiibYVvV6C3
X-Proofpoint-ORIG-GUID: 96sqOniPM-J1b2-dj6BxBKiibYVvV6C3
X-Authority-Analysis: v=2.4 cv=OLkqHCaB c=1 sm=1 tr=0 ts=69b197ab cx=c_pps
 a=6kjKZ7CY8GAURWpkwvnN0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=VScZQXf2u9VvzekDok0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
Descriptor is used then the interrupt is considered to be high true, edge
sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
an IRQ then if more than 2 serial ports are added, Windows indicates a
conflict in Device Manager and these combinations cannot be used together.

Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
Descriptor indicating that the ISA serial IRQ is low true, edge sensitive and
shareable. This enables all 4 legacy serial ports to be used in Windows without
conflict.

Note that it was agreed during the list discussion that this change does not
require a compatibility property since it is not part of the default machine
configuration and was already broken.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/char/serial-isa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index a4be0492c5..686336f34f 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(isa->isairq));
+    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
+                            AML_SHARED));
 
     dev = aml_device("COM%d", isa->index + 1);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-- 
2.43.0


