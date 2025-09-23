Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4647CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Um-0008TL-SQ; Tue, 23 Sep 2025 09:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ua-0008Hb-6u; Tue, 23 Sep 2025 09:55:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13UX-0004Ja-SS; Tue, 23 Sep 2025 09:55:39 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58NAWaVQ2049627; Tue, 23 Sep 2025 06:55:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=k0WjvoZ7Z1LsAs5lgKysnJ8/PREJINOcEnJefjpRJ
 Fk=; b=VkZyCb2Ty11UuUxnL4LH+OP3oyBOy4ATYm1eggH1DrVmmMVORRVRKccKy
 UPgWTygIWMEMsjU9zRu2+6KGi3CMQXYF4+9uklUrZHBAjNq/1w9EF3wo/x5QC2kp
 Zo7XRnEFYXdnIEFjzjCUz9szDs8zNANlpRoDeyFBnK/NBAJ294yCALwWBHrGTerT
 pSgZ6Z9HX07BqYDWAxIo9aB13W8Xpb1DaEhIuRnj5B2KXZMvgfPeO40gvk/Sx1Dr
 65eQ7pWe/V7jL3cyObySf1NxkW7+QFovSsPwEqiQLHtfM+np+aWEzpExDJOeV+2R
 B2UbLkNTFkEXYPdcRjJVELYsYN83Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023086.outbound.protection.outlook.com
 [40.93.196.86])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49bsw08dky-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx3CqFipBaNFugJD/px3m8TtM7yVTxceCaGZxxeKzwVy+R8YJvR4h1N2lg1RWLRo1ZUQ6niQbbRltT4LJUxWDkSx+r6og8qxxYJz1wiZsq7CHUucScD7j7sBYgHCNZ26Wg4mB1wvpCcLFip5SZXjhcUrcqdsjChJDsKp3+qbI3C5caxGVknVX8cVsxPk+oghNK+l9m6N7Hu6ifrnsl7e3UYYwaGlMAhLNh6dgn3wYONtT/6S8h+4HPus//1/vvZ4T+f/KaPU5oG2AsQYb4V1d+CZhFznujY9Q7XeY65Zh0Y2ORbZEZAx0aDQUqrJZ2u3wceQ1urTOMji2jhGbyyx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0WjvoZ7Z1LsAs5lgKysnJ8/PREJINOcEnJefjpRJFk=;
 b=p7e25m0PL+Ze7W7Z3iYlO6N9O9ZiHuaatUw7npttYa9rT75ZBKE7dNN5etwgtQ+GBGRC9uOzbisKRpAjVpxHu+Iyjzdsq2TdDsRgbwh0V6UmJ88sRss2yAqUKUt8EatRlBBXhcWRBBRjtn4AW/zsKSuOaEbJ3cfR1kW9aUstsMb9Uwx+9YO44Q7/vwnHnnjSfTBciLHlrrHdKM4xOAL324MErNKcrWBjpbcxeufdJ/9ijUM8vTtr53hyja+4OgwCiMz3EfqkiCSg86xzcJMCS/afM8Em+TvAdCWuOkZD95NjJYhtWs7udPZEQ0k+0ULwvlVcrl7oroLGXGEvvGFqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0WjvoZ7Z1LsAs5lgKysnJ8/PREJINOcEnJefjpRJFk=;
 b=iw1BKPx9hQQpAVU6lL/sIcCodHOdP7n0e8BE0PtQp0bLGEtdYDnpCGEsY5Z2Hq8lUMbVCVO43f469I6hXcsAodlzzhuAZFv3kq20fgrj7WlRriIuYZbNGioIHJP8Qg6KO9xnO2Q/EBMTI02S9xRqxBs4zIGE7o6HReGGNom/sMZNjSe1g+7x77aMMeRU0SHqnLfueXTdRG9/kxtyOagVJoRDOSVfSHE7dzdaz0NIp5M93aINQP6TbWi8PI7KGJdlCJO0UXK9vbrkub6QxnEDigK/Dn2Z3fXPSP1ZDDmzCy6YVvGVTZMPXcUWJTsJCHunGdaLHg76XRnNH54fssJeOg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 24/27] vfio-user/pci.c: rename vfio_user_pci_dev_properties[]
 to vfio_user_pci_properties[]
Date: Tue, 23 Sep 2025 14:53:30 +0100
Message-ID: <20250923135352.1157250-25-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0002.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: e67ee0f8-7158-432e-4e0d-08ddfaa8dc00
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E9+6jDN8f3GrB5BqKnqD4EWCOMZKo5vo186PUKWuX/VExqiHECpga7A10Kuj?=
 =?us-ascii?Q?3ffrYZ+NKsTg5h1vIUTJXlP9y8TkJZP2hVVHskS2RDUJCh+N7bIviT7W5Zjq?=
 =?us-ascii?Q?rVCEmDjCbYTpfww7u+daOAdmeydH7F4CODPM49s3peqEuUa39WJObcavMn1z?=
 =?us-ascii?Q?ba0DBAUUlrwwaHy0z+F4DiVj5zcakCigtPN95+HeSHz3ONNiKEhtfZg2qDIO?=
 =?us-ascii?Q?7KY64V90tsxOkzwUY8gmGqg3iuxZEvbo+vaoBnBAIOEq+RbjPM2wdBgtHGDM?=
 =?us-ascii?Q?xtNwEHWGlZ10sHC35dWWTlOt1QAPpSZ6WKwxuEmL13QXJFWXNT4geLIiUO0L?=
 =?us-ascii?Q?GqBuvWjMF64GzegYHkTjnI52mlgcDSW5PQfeteYMEW9HR6/2XUm9Q9SEiUan?=
 =?us-ascii?Q?oYm7zOIaYxipju3odR6HbzXwFE6w7TZOAyjYa3+tVRjgrw61tCn22GENVRfI?=
 =?us-ascii?Q?R7kdtlJ3d0X6W8xGFQaea8IOv7RvkMrKEdQc2LRg4gcE/wM95napfowJPdgD?=
 =?us-ascii?Q?9VVGqil1wsxnIwAk/8YNzCLit/mq91olfIt5y9CxHsj3e9XX7Rg7cJPkrLHa?=
 =?us-ascii?Q?TGWZ+43j3GUqo/M9bNhrocPZPMQHY6a9WunQpMp7r82u+NHYE0McjOnERsHs?=
 =?us-ascii?Q?rKMb1RAiJok1MRizX6BE8yN6nDe8KsjLkpOOOuNFdX78/Wrqg7Elv0B/jYaP?=
 =?us-ascii?Q?cRB4EqcCrLaaQFHEPBJsQfyvUglVZ8nyC1JtPq5L8jlgWh12D35f/aj7SwMI?=
 =?us-ascii?Q?fVA6V+PnzPLmkBY8twrY9vZwpG22v3gpe8TJmbdmSkPgymPTb2v6XRPZMD7n?=
 =?us-ascii?Q?EshRRKqNTx4+iG7b0qY/Q0s2aBtfAw0U9IOAgJsxuFrcIiDndVKudOLbDJen?=
 =?us-ascii?Q?XCWI8pAhQSxFSoIu4MucrDFj0EafirCf3cej/LJKrqzCfvzXMGkR9gWbetkK?=
 =?us-ascii?Q?bs1WjwyOxtRE+4WAFYg4KOChzOp/t1GdbvxT7teORHPrbM8pJ4DFEmvi8zMs?=
 =?us-ascii?Q?v2uqL+T/sWEvqYXbn2FNB3yDAZooW0Z75Mjxu9f4rTcIa99WPxCiZWEc//JS?=
 =?us-ascii?Q?u7kebEv2jWo5DHeNtfDvzcdpk8q3smsER6xUn2ZwdRYVSF33cLpuCyFwmaI4?=
 =?us-ascii?Q?iZm3wmeuhrWf7kfumfudD/qErt2siHs5muOJAzYFIPXD4SI3upQO7mLwzSsn?=
 =?us-ascii?Q?Eoj86DrB1/iYptF7Cw0ybCcvqAqdCbdDOPA2BoUF5dxLTRe+5ZE5n3Z6cWwR?=
 =?us-ascii?Q?Mgr2Rr+1kri/Lb3wldBFNtQMOwELOMgL6LLmsi9Pb32fVEDur/VqWAdR6FtC?=
 =?us-ascii?Q?kmZIcT+qWVyhi5gOkqt0TEgdV1LMHLaoAp1bU9Jj+5XPpE9DYIxTNnaDhYi3?=
 =?us-ascii?Q?jGZDsknhnEouIHC3xUkIlsP6HWv4xxa8zq7N0+o0a+dcA3cHvE3LcsWcwZoq?=
 =?us-ascii?Q?uh/Zs1ql3XZcRYgln4ZRbOhsX5cW+b1NfxV+MF/gI/kyyD/YmI/UYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vu6vIEvIsEyxE5OKijfnELEbun06VIckh0BPYsXEvY6Q263ZcaYHdGPYApKW?=
 =?us-ascii?Q?n9iTckR7+RTfDr6BW7CY71360GJuJMuFSvchFweOQQxZdxXKdrYzAt0hNtOj?=
 =?us-ascii?Q?KVVBXo5Fd3M4K9Au/NWfPkRBA5TTQZLHtdaRQzMG/SHF1jW7P/2j0pOLVhq7?=
 =?us-ascii?Q?DtNKkL28yy2WCH4+qIT4530WCN4NOXfUbD+XWcmSZCtOb+8ucrvCFlQh1gXI?=
 =?us-ascii?Q?e1J07oWok0fGXVGrepUQll+qfTQxuGNj4W5f5Gv9ApZO1ukLK/psOl7b4hr0?=
 =?us-ascii?Q?6OB8QUDsSfiGbQ9pghTgU5peICd8a5E2jXfevwQzrpfNQlyJgn0Y51U1YbT1?=
 =?us-ascii?Q?N65Ksvrx/Bt3qLA28LU/a77jDeA6pK+GrT5NKFv0IsL1HXRa3EP1bQpIDqIB?=
 =?us-ascii?Q?nvwYwgWY8DB8amJSQTQlAlFgKhqXz7qDfZ77HjZDjmMzh+D4rj82htfxaPNq?=
 =?us-ascii?Q?lLLmVOCvBkDFHQ2DLwq3GNNStmXcXR2rfM/yDje+rvKJNcoquG8Tq83R6CfL?=
 =?us-ascii?Q?yDtlq6NjKq3BHDyH4JahOalnV/sfJILaFCP4DMjMUw/ln2cBGeV35Y4P9QDQ?=
 =?us-ascii?Q?t/bxGLP5busm4yZyej9YMc9VfUB49YRonjOBxbC0E1UhScXEhonpczAgI1D4?=
 =?us-ascii?Q?6Z4MsBDiAvi3JPygfy2nur72SivHdg6pxlNO/mnX1pb5ZeuUKQO8GtUvoADy?=
 =?us-ascii?Q?/j+WNyGHRRKuGr3IsJcvHwCne9ua4aeMZODT0We8fE45utV67mT0yJreAxlO?=
 =?us-ascii?Q?ga84mggUmtOHg1AgWteuXNEoY9wRCkOIcTMebdEN5tckgttGyP7zeYHnO95N?=
 =?us-ascii?Q?rV1BmWhxH4sjJ/n7B8A+s1VFQHJZhemi0bxNqH5LQwOaKSV0F7aYVYyYThX+?=
 =?us-ascii?Q?TQ9h15pHhiC3e02M/AOn1EC68uVhUxmzpYzfuTJ17UbHovdk61t5kRY/4QMK?=
 =?us-ascii?Q?p+U8JeEs8jxieycwAL+uES5qRnu4s0lqCNv/IAGytc6EjJMteF4wWTVXwOex?=
 =?us-ascii?Q?cvLjEVUwsVhA2YEre6j4MTifOXx9ivDE96U8KoFcJXBTjemIJO4hxRJ+yg1k?=
 =?us-ascii?Q?enuB/xiqv+e0tXjNZ5oSqREQroHTS3BsMIjkU+l9/5kOkOLcKkLBUeDzpp+7?=
 =?us-ascii?Q?gdilHMuSknVvuDiquiY3i2e8SqeY0GcMbnvHVZ4ZNi5b/G0PFdsqkH1NwEde?=
 =?us-ascii?Q?smRQuy7dbUNOuc2y+VsalEQd29OgGMiSqvuS8adYR7o+OlkFIDjuEHyD52FK?=
 =?us-ascii?Q?CHxfiKcsCCpXQsDrlVklEtgtN//zU0kKu0rNAkzFzdPg/uzE57OZSxEW1d3W?=
 =?us-ascii?Q?K807wxyu+tjbjIcTOag8WpzKMNlH/LngH7/9dgvRo0YG3EMg7FnzzQooCSRo?=
 =?us-ascii?Q?B6/60jI4Xgk/uUECK/LCXfxcCHFHdZej4F2M5WLtZP1ROyNZ8FPqe+FjA7HL?=
 =?us-ascii?Q?jkf1SCDgdQkkDxDLgoCzBV6Ex8rAodoq2Wkm88fHFGbl0U0H/mGCuaGk3/02?=
 =?us-ascii?Q?sYY3lvEIrZ31E7/2lcH4uttL+QtVlrzGDVqh4TUMLxS4OQ2WJfwJmL7CxMWb?=
 =?us-ascii?Q?hYJut64al/rhfGVm/RWVzZyhq1BZp/ngC5sRYofbM0bpOIWmvYqFAxwHTi40?=
 =?us-ascii?Q?4iWMhkJYW+8qeD3noGYwmX4gOMokAFMVNx+sIO8fsqfK7/uJnXe5Pkm2tQZ4?=
 =?us-ascii?Q?BHSc5g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67ee0f8-7158-432e-4e0d-08ddfaa8dc00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:30.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTJienvFPRGoNuvQ9R6h+7aXl6gWDLKreq69i3dnJ3vFqamXcYxU1o9FveFMWWoUF+4Iwrw0IH90lkF0QciKOn8xmrFltn3Art69IoYsJvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-GUID: aLCouggmKoVf9gw3r7aVD9WaYORtTdz1
X-Authority-Analysis: v=2.4 cv=QPRoRhLL c=1 sm=1 tr=0 ts=68d2a6d4 cx=c_pps
 a=0ygdBYYpfQySzMJeDTx3GQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=VO-VGI-_H-TUAJbT1awA:9
X-Proofpoint-ORIG-GUID: aLCouggmKoVf9gw3r7aVD9WaYORtTdz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX6Ib1JfhC+UiT
 QSo0ZOQKe0a03uVHihVPbCHzgVwk22+OYYCN2VtQJ4xA+D7SidJTyCEjlPflxjf7n7Yd4achHMx
 zWnekQKgdt/6KXQ9piD06DTrwPXfq4Nf86PTC8lpzdIIVR6UzFPf8OTQr+oNrWvd2sGuwNw9GVu
 wPXHh+ZZ0f7jSL7UQrHuGnvE/i4+gWRqItamNHsYXvhrb+BsLYU291naIzK5aqXOQJ2+lH3jlLA
 CwhpYoZh3pDdqINDMpuZAfsV1SnK7I61aYR0qq+R8/OR53Gjg8jlnHZu26ur7DSE2b9OSjHGrAm
 kdzq3QS7cChjE0+T/0gsTESp3RmrTUrCUHnwX157/Lkc41v1GxdKYNjhZTF4TI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c5b5744c..30f485fdbb 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -400,7 +400,7 @@ static void vfio_user_pci_reset(DeviceState *dev)
     vfio_pci_post_reset(vdev);
 }
 
-static const Property vfio_user_pci_dev_properties[] = {
+static const Property vfio_user_pci_properties[] = {
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
                        vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
@@ -452,7 +452,7 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
-    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    device_class_set_props(dc, vfio_user_pci_properties);
 
     object_class_property_add(klass, "socket", "SocketAddress", NULL,
                               vfio_user_pci_set_socket, NULL, NULL);
-- 
2.43.0


