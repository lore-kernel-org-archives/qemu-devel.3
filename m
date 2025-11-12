Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E526CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgn-0003sf-Ft; Wed, 12 Nov 2025 09:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akash.kulhalli@oracle.com>)
 id 1vJ9TR-0007vw-0k
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:57:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akash.kulhalli@oracle.com>)
 id 1vJ9TP-0000IR-8m
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:57:16 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACBgNeU012845
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 11:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=n6rLww8tFkkLaKSjsCjF2vx+clhjw
 AXRmoGuIHVLVVY=; b=KECpLg4s/6aYitOOIGSgKaDr/+xT6TwBC0wFUCdfW8u6d
 HT17+n8WVEQU3Z3eJ3OmuDVXKxT5HA7NXSV4WXTRazOfGkot/1HocNYRNJQ0AyxW
 d9oczgHFtFOVW2/limkzN+9z8wiVaG/lr4EYWqunBds3fSTdLzcR87F+nBa0Mv14
 lS7ndG/w9TBKQLUdh59hfldVNCYAdkICuMrQn6fGKPcfjdjmgHDITcbnPJwPPj/2
 dKXGuMPs94aJAMcMRv0LWIgd2n5+jifqWjj4ZrDGSBMjT8HPqf/ERbnL9GGMSOYu
 l17WtQprsv783EbHaytLuiZggZEuiipjJ7ikrlwDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acrrug3bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 11:57:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5ACAYmw3010115
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 11:57:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a9vamccsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 11:57:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ACBvAIh019817
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 11:57:10 GMT
Received: from akulhall-vm1-ol9.osdevelopmeniad.oraclevcn.com
 (akulhall-vm1-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.191])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4a9vamccsf-1; Wed, 12 Nov 2025 11:57:10 +0000
From: Akash Kulhalli <akash.kulhalli@oracle.com>
To: qemu-devel@nongnu.org
Cc: akash.kulhalli@oracle.com
Subject: [RFC] Why is IO_BUF_SIZE still 2MB in qemu-img operations?
Date: Wed, 12 Nov 2025 17:25:34 +0530
Message-ID: <20251112115534.853892-1-akash.kulhalli@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX92h7O+3Li2oP
 +9wP+RJXbwDdkPa8dmRvJo8F5Mw28QfmxTpICpyud5kPz99Y4/LUlVx58/WSRYlquUlEEJb6rO9
 FC1DIdrxKs3QQzQF3b9HdY4kdPgNxGBaYuaybDk707us8pB8sVrTBulcYni5fohpU+06gTzvVlk
 fCuozgYjwrYPW2qe/S+T4bJOxLLrYYsLanKaqiwyBtqBOfMuh3Uyc+BUohaFSk9564YBfZpve97
 AiVWq6dAqQcLeMKly4zlIofgWgZ2DCZ3fy6zl6VSGEMabauhcT3O2qehtFcxx97hlLR+uoqwnkJ
 kMkh7Cal2JB201enM2QqW6AJa8n0lhKTejVTwm6jHgKqbh39RGZzcUUk3nVdMg3mLEZ2DfJHEH2
 fx8bREHuhiiNT1V1oiSy8QlXAyMk0GAFsNRaZl5wlVsvM8OGrS0=
X-Proofpoint-GUID: 42giQes2zHdxB7SCgLlYLPjcG7julFaU
X-Proofpoint-ORIG-GUID: 42giQes2zHdxB7SCgLlYLPjcG7julFaU
X-Authority-Analysis: v=2.4 cv=N9Ek1m9B c=1 sm=1 tr=0 ts=69147617 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4wxDOdoqRUtZD-WHigcA:9 cc=ntf
 awl=host:12100
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=akash.kulhalli@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:07 -0500
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

Hi,

I'd like to understand the reasoning behind the buffer size used in the
`qemu-img convert` command. Currently, `IO_BUF_SIZE` is defined as 2MB in
`qemu-img.c`. Based on performance observations, I would like to propose
a patch that increases this to the current upper limit of 16MB, with the
behavior being configurable once I understand the reasoning behind the
existing values.

The motivation stems from analysing perf reports during image conversions
with different negotiated sizes with a nbdkit daemon, when investigating
performance slowdowns with virt-v2v; it revealed smaller, inefficient network
data patterns. This buffer size is what qemu-img negotiates with nbdkit, as
validated through some debug logging. Increasing the buffer size drastically
improved performance, especially for network accesses when the source image
is accessed over the internet.

A quick observation of bandwidth utilisation with the larger buffer sizes show
a significant improvement. Using nload as an example, on an otherwise-idle
system shows a very low bandwidth utilisation when using a a buffer size of 2M-

Using 2MB buffer sizes
======================
Incoming:                                               Outgoing:
Curr: 33.44 MBit/s                                      Curr: 1.02 MBit/s
Avg: 35.19 MBit/s                                       Avg: 1.09 MBit/s
Min: 1.13 MBit/s                                        Min: 34.52 kBit/s
Max: 50.19 MBit/s                                       Max: 3.39 MBit/s
Ttl: 473.11 GByte                                       Ttl: 9.26 GByte


On the same setup, using a larger buffer size of 16M yields much better
results, hitting peaks of ~267Mb/s, as opposed to 50Mb/s with a 2MB buffer
size. This is a pretty significant improvement and therefore warranted some
closer analysis.

Using 16MB buffer sizes
=======================
Incoming:                                               Outgoing:
Curr: 267.08 MBit/s                                     Curr: 7.89 MBit/s
Avg: 117.76 MBit/s                                      Avg: 3.18 MBit/s
Min: 4.20 kBit/s                                        Min: 47.87 kBit/s
Max: 267.30 MBit/s                                      Max: 9.40 MBit/s
Ttl: 369.93 GByte                                       Ttl: 9.34 GByte

It is also important to note here that this problem is visible for a specific
combination of using qemu-img alongside virt-v2v (virt-v2v 1.42, as is the case
on Oracle Linux 8). While the internals of this utility are out of scope for
this discussion forum, what's relevant here is that qemu-img uses this buffer
size when negotiating receive window sizes with nbdkit during initialisation,
which bottlenecks its own performance.

Can anybody explain the reasoning behind keeping `IO_BUF_SIZE` at
2MB? Are there specific constraints (e.g., memory usage, compatibility, or
other platform-specific limitations) that prevent increasing it to 16MB
(or higher)?

Appreciate any insights/reasoning behind this value. A patch can be provided if
the discussion deems it relevant.

Regards,
Akash Kulhalli

