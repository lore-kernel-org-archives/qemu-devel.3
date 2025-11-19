Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F2CF3957
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 16:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLl4R-0005hJ-73; Wed, 19 Nov 2025 11:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vLl4N-0005gM-U8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 11:30:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vLl4M-0001I7-4Q
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 11:30:11 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ7X532026915;
 Wed, 19 Nov 2025 16:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=rO/d/WodAriRne5bEPTICDY+dG1nLthqpPRVpLshr44=; b=MAoJUEreK0MY
 SxXfYtjjjMKsMkphRXBF2sFiR6qYj8hRIPXU4knOGsJzh2FftCC+C9OocpBubOwm
 Jj8tXXnJT8+C3P+HqSTGftkU0J/n1paszMxlspv4nkltiS/1t1CcCkZaq9huC1y1
 i7dt2LhvxOK69ZjYgF+zf8kk0NsHY/5AMGllJG9VvOLT5mjt0/144c31tnOzvlWo
 e+L1WEidbG9y6aXudGkJLAJDV83azNgKSxSqGbf5qPSgvEBlCuDXAig/FG85/s+D
 ZpWmTd1jg0URRyYYeBSkDMdoD749BXYwPBMFstucvNKIgvUJ0538yzjCFEXtE7PT
 OjHsNz8eDQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw9n19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 16:29:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AJGRXq1022649;
 Wed, 19 Nov 2025 16:29:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw9n15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 16:29:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJF065a022370;
 Wed, 19 Nov 2025 16:29:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un1qfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 16:29:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AJGTjkE60490070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Nov 2025 16:29:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F84B58056;
 Wed, 19 Nov 2025 16:29:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF6FE58052;
 Wed, 19 Nov 2025 16:29:43 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Nov 2025 16:29:43 +0000 (GMT)
Message-ID: <f1344276076ef1a8ca05073951168640e956b01a.camel@linux.ibm.com>
Subject: Re: [PATCH for-11.0 10/15] tests/functional/ppc/test_ppe42: Fix
 style issues reported by pylint
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>, Peter
 Maydell <peter.maydell@linaro.org>, Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Aurelien
 Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>, Nicholas
 Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Date: Wed, 19 Nov 2025 10:29:43 -0600
In-Reply-To: <20251119082636.43286-11-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-11-thuth@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691df07c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8 a=afbpXOviwP4MOHP9KbIA:9
 a=QEXdDO2ut3YA:10 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+f+nQKr/jCNW
 eF/sgMJfg0Emp1aLZEqOXbfJ96I5JL3p61zahqWTlQVgybF4wA3TxeR8Eqx5InwxCgX5T6eEjxM
 97vwaYqN41aML1nrhAPFmVBO95uQkjK7UYJ+QbO9sUN4BOT7OFmY1Kov4ieAtv5qDdbXC0+yVGD
 +46iVbgXUN+JVO0SZpB88p1SjBQMNiKJhuiecjjkmh9hFlHUFma4j3VRJ5LOtU/1t4R3JtadoD8
 WK8V717Y0RUdwy9Ho9xPY+Wgz/SpxWE3HEEa2yThXml6BdfujQ2KeAyo/YMmkcc4u2+JCH1lbuU
 xDkeImJbMOJoasB1LWnRc6E2bGccZ3LvxBd8/6laKPMFNg34XBJz0tir/Py95roYgkK/d3FBfKm
 +CpzLqmvg60dMmJS1wPFPCx2RHu46w==
X-Proofpoint-GUID: ogfjaXeXhCzexT68T8r7eIhgsNYekhKh
X-Proofpoint-ORIG-GUID: HEBaK2EYFMzqpJOD1OYTrnUhdxXUeY5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Wed, 2025-11-19 at 09:26 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint suggests to write some parts of the code in a slightly different
> way ... thus rework the code to make the linter happy.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/ppc/test_ppe42.py | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/ppc/test_ppe42.py b/tests/functional/ppc/test_ppe42.py
> index 26bbe11b2d3..7b360a40a54 100644
> --- a/tests/functional/ppc/test_ppe42.py
> +++ b/tests/functional/ppc/test_ppe42.py
> @@ -6,8 +6,9 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> -from qemu_test import QemuSystemTest, Asset
>  import asyncio
> +from qemu_test import QemuSystemTest, Asset
> +
>  
>  class Ppe42Machine(QemuSystemTest):
>  
> @@ -30,13 +31,13 @@ def _test_completed(self):
>              raise
>  
>          self.log.info(output)
> -        if "NIP fff80200" in output:
> -            self.log.info("<test completed>")
> -            return True
> -        else:
> +        if "NIP fff80200" not in output:
>              self.log.info("<test not completed>")
>              return False
>  
> +        self.log.info("<test completed>")
> +        return True
> +
>      def _wait_pass_fail(self, timeout):
>          while not self._test_completed():
>              if timeout >= self.poll_period:
> @@ -49,14 +50,13 @@ def _wait_pass_fail(self, timeout):
>  
>                  except asyncio.TimeoutError:
>                      self.log.info("Poll period ended.")
> -                    pass
>  
>                  except Exception as err:
>                      self.log.debug(f"event_wait() failed due to {err=},"
>                                      " {type(err)=}")
>                      raise
>  
> -                if e != None:
> +                if e is not None:
>                      self.log.debug(f"Execution stopped: {e}")
>                      self.log.debug("Exiting due to test failure")
>                      self.fail("Failure detected!")


