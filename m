Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00468C47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUo05-0002tZ-MI; Tue, 30 Jan 2024 08:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUo03-0002qf-LI
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:18:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUo01-0002pj-TV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:18:03 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UDCE5C018052; Tue, 30 Jan 2024 13:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=iZhJi31stDN4nhiqWyYobNpYGOvJ2f3cxpkKlgRWlXk=;
 b=toAXjnutgfPnuuJVppkFXLopFEBhf07ApeIwbeGzuMYNfL7BtkwjRU0BsVicvce9CXx2
 AFjaITnGv7K2mTfDxTOFwahB18u5gwaFlIdiAJhZMbynNLBX3eWfjCMAc+aIhY/q8r1l
 iKF9AXTVL9xdiejxIvsj/fJVAqVzVf8/PQnfBMju3gJPtPIqfzO5zxtFmZ9V8dXrxr6R
 wY/heBISIh18LRMCF1oSDLFMWiNAf2Hpa6jb0TPLcToRJieiwQnyYLvZXgcb5UMP2YXn
 f9NfjfIupz7Z+khmVTeel7vq/DTnN1ZfCt9/WA6ObwFv+trAC9eSRG0CHOCABmkK2gkL kw== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy1sng66m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:17:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UB0AAC008086; Tue, 30 Jan 2024 13:17:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkxsf8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:17:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UDHkJp18612918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 13:17:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1EDF20040;
 Tue, 30 Jan 2024 13:17:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6313A2004B;
 Tue, 30 Jan 2024 13:17:45 +0000 (GMT)
Received: from black (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 13:17:45 +0000 (GMT)
Date: Tue, 30 Jan 2024 14:17:44 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 27/33] cpu: Remove page_size_init
Message-ID: <byayfjg4jlz6nym6fljf4owq4eo6yijb3ujrf4b4cz5c5shn7b@5qyezle5hkx5>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-28-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-28-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tvbrNWjAETlg32ado45eWYwaIRr-7yE3
X-Proofpoint-GUID: tvbrNWjAETlg32ado45eWYwaIRr-7yE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=702 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, Jan 02, 2024 at 12:58:02PM +1100, Richard Henderson wrote:
> Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
> It should be removed from bsd-user as well, but defer that cleanup.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/qemu.h           |  7 +++++++
>  include/exec/cpu-common.h |  7 -------
>  include/hw/core/cpu.h     |  2 --
>  accel/tcg/translate-all.c |  1 -
>  bsd-user/main.c           | 12 ++++++++++++
>  cpu-target.c              | 13 -------------
>  system/vl.c               |  1 -
>  7 files changed, 19 insertions(+), 24 deletions(-)

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

