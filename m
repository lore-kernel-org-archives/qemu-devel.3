Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C617C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlde-000231-N9; Tue, 30 Jan 2024 05:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUldc-00021y-JQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:46:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUldQ-0003v9-7R
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:46:44 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UAjLTP028705; Tue, 30 Jan 2024 10:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DlDJwqGdKKL8th6A6LyRVfg8xSeL1QEw5/70yG8hijM=;
 b=I2e1SvoBHDxsd4hYlRPUWpNJ5MnG+XnDE9rMM4qpIUhnCZPg2RREbbwknrsTWcY5uY9S
 AL/HRnZUqWScucT8XmYeYagFJ3pBbI13u6/pjG2uxe4MXikriG/576QpmDBeZf446G5I
 g/cqaZgeGhpQK/FbrMVekTGLgIXdSSNuFHUtPeA5G0A7LU2OXlswNywDn5CdEusPL+Kd
 qgGmLsHhh4DwujREAV4DUCq4cyRtJ7ZnjYQ2apGE41cYBqF440bnIyZcd0Qvn6udVPYg
 CRiAn8cPvL6iEh6rnmadlj7IEq/b+vai+KCRgVwHAW+RwTs6teVC5Vof9aDRZB3DPfoN Tw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxyg28900-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 10:46:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40U8ZCVm007179; Tue, 30 Jan 2024 10:46:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev25rhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 10:46:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UAkSc623790138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 10:46:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C77420043;
 Tue, 30 Jan 2024 10:46:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9F4920040;
 Tue, 30 Jan 2024 10:46:27 +0000 (GMT)
Received: from heavy (unknown [9.171.1.43])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 10:46:27 +0000 (GMT)
Date: Tue, 30 Jan 2024 11:46:26 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 24/33] tests/tcg: Remove run-test-mmap-*
Message-ID: <qbjgj5l5tgjwqo2lgbopu7j6gydcsxedxjggo3ypffpnr7gufx@kjsidkkjofxq>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-25-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-25-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IuoaecGehoR4fGFb8Cr51DTqPR6bGHZX
X-Proofpoint-ORIG-GUID: IuoaecGehoR4fGFb8Cr51DTqPR6bGHZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=668 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 12:57:59PM +1100, Richard Henderson wrote:
> These tests are confused, because -p does not change
> the guest page size, but the host page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/alpha/Makefile.target     |  3 ---
>  tests/tcg/arm/Makefile.target       |  3 ---
>  tests/tcg/hppa/Makefile.target      |  3 ---
>  tests/tcg/i386/Makefile.target      |  3 ---
>  tests/tcg/m68k/Makefile.target      |  3 ---
>  tests/tcg/multiarch/Makefile.target |  9 ---------
>  tests/tcg/ppc/Makefile.target       | 12 ------------
>  tests/tcg/sh4/Makefile.target       |  3 ---
>  tests/tcg/sparc64/Makefile.target   |  6 ------
>  9 files changed, 45 deletions(-)
>  delete mode 100644 tests/tcg/ppc/Makefile.target
>  delete mode 100644 tests/tcg/sparc64/Makefile.target

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

