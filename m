Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52720C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 22:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uME3t-0000AQ-0J; Mon, 02 Jun 2025 18:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3r-00008L-BM; Mon, 02 Jun 2025 18:55:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1uME3o-00070T-8o; Mon, 02 Jun 2025 18:55:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552LN2bV002631;
 Mon, 2 Jun 2025 22:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=n6DI2nu0l+05eLGL7DjTGysYzGsOb
 07T41N0mwGfjBs=; b=hfftSqCVXNcx6RxJsTrcDi2pPEcFrCECKJxXCeEhe7Z/S
 xsSYa7c2DiHqa43alrY9UAZRmxfBnBrf0mROJpC8DHnQ7oOVNcjCYEVwG0ngHD6x
 /OXWpmFJ4yBrPKRY9x/1dvh/rARD2M/J2yVIot7QpIcwMDl8QOeSWkmzO9QX3h2a
 E4g5beC2y265HcEGB3UZdjYDo1+3O9S3jhVnOp+TPM8sbXSct3EiQscc5wv2eVxF
 nOtGLs8xA5iCxgWId5pjyaak7CjeHTB0BLwzZvzRuAPQLR8otq30sEQTXO1tx+6C
 WOnbe3KURNKXKOOxxl68X+6Kx0l9eF/0WFm7m2a2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8j0my5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552KitLc030620; Mon, 2 Jun 2025 22:55:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr78jxur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 22:55:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552Mt3dM019747;
 Mon, 2 Jun 2025 22:55:03 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46yr78jxs2-1; Mon, 02 Jun 2025 22:55:03 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH 0/2] Add support for NVMe Namespace and Boundary Atomic
 Parameters
Date: Mon,  2 Jun 2025 16:04:56 -0700
Message-ID: <20250602230458.1073148-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_08,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020189
X-Proofpoint-GUID: M5ssovULj7KQWBIcCUWtQJ_044Oyp9hv
X-Proofpoint-ORIG-GUID: M5ssovULj7KQWBIcCUWtQJ_044Oyp9hv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE4OSBTYWx0ZWRfXyulyDYg9gWjO
 E4IVjHcnidWN0KCi5x1J+HjhnM7/Pmkrqu8MKQKae9qcVbL6qJ+yymmT8VwWbx5AjdMbjNtMz1o
 pwlnJCdyocN14q3VcSqdtLZBHCSF2YHvqrZIusnjLC92rBhu6sq+pw30BYLfEz5rrdCpxs1oDhn
 RGkcC+KSzuP1sMB7g4uyEbAKkqkv/h8l7wda4+rs3Kiz8tdx7unppAAvjD6CkSg3It7LIwX/oNk
 eG//oFPmZ3XSmo/EzQGOzLlXX3R3alx/p2OJFqbr/9zQqO5pWJeY02H+74hSimRqa+oxo3HB3xj
 yPOOadI8aDzgJ20Qt6kB5nTz2FZqNi+3lZ46CdtmPvCxx/UojSbN2gG8ArWivDB7uD/ddZT3hNn
 saZvILWqhBYlO/rkvVkiXWIhIRk4qNL+R/ruHRvZZye16QSZHg7C1lnznzJtSWRyOFOw447E
X-Authority-Analysis: v=2.4 cv=QI1oRhLL c=1 sm=1 tr=0 ts=683e2bc8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=IekB9Y5W0dOZfOWWcgwA:9 cc=ntf awl=host:14714
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch set is a follow on to commit ebd1568fc732 ("hw/nvme: add atomic
write support").  These patches introduces two updates to the NVMe subsystem in QEMU,
both aimed at enhancing atomic write support for namespaces.

hw/nvme: enable ns atomic writes
--------------------------------
This patch introduces support for namespace-specific atomic write parameters: NAWUN
and NAWUPF, as defined by the NVMe specification. The atomic parameters are
utilized to guarantee that writes conforming to these boundaries will be atomic,
improving data integrity for namespaces that require atomic operations.

The patch introduces new NVMe QEMU parameters:
	atomic.nawun (default: 0)
	atomic.nawupf (default: 0)
	atomic.nsfeat (default: off)

The addition of atomic.nsfeat sets the Namespace Supported Atomic Boundary &
Power (NSABP) bit in the Identify Namespace Data Structure, enabling namespace-specific
atomic write features. The patch also ensures that atomic write behavior adheres to the
NACWU and NAWUPF parameters.

hw/nvme: add atomic boundary support
------------------------------------
The second patch expands on the atomic write capabilities by adding support for atomic
boundary parameters: NABO, NABSN, and NABSPF. These parameters define the atomic
boundary size for writes and ensure that any writes crossing these boundaries are
treated atomically, based on the AWUN and AWUPF values.

The following parameters are added:
	atomic.nabo (default: 0)
	atomic.nabsn (default: 0)
	atomic.nabspf (default: 0)

If the atomic boundary is crossed, the writes are guaranteed to be atomic only if their
size does not exceed the values defined by AWUN and AWUPF. This ensures that larger
writes crossing atomic boundaries are not subject to partial updates, thereby improving
the robustness of atomic operations across boundaries.

See the NVMe Specification for more information.

Alan Adamson (2):
  hw/nvme: enable ns atomic writes
  hw/nvme: add atomic boundary support

 hw/nvme/ctrl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/nvme.h | 14 ++++++++++
 3 files changed, 164 insertions(+)

-- 
2.43.5


