Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C412C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevlZ-0002n2-Hx; Thu, 24 Jul 2025 09:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1ueqxt-0003Ia-J4; Thu, 24 Jul 2025 04:06:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1ueqxo-0006eh-3z; Thu, 24 Jul 2025 04:06:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O1S5dN013529;
 Thu, 24 Jul 2025 08:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5iPe+5YUhEnzP0H8r09wliujHf8hje
 W4fMVAR+G3I6Q=; b=YkL54+vRvinffY8FgcMXKarFNnVW431sFqhV38Gh3NqnoV
 /rzoLigYNSm9PtfBKL0QjnO/NLpRLnoEW+Bm/C/EwEec4QzL6TOJpMo+5lu2I98c
 XjWxWVoMxdPr8baSq9UY7q5xPd0KAVuwzUTc/T/QIvUM6dC/UQw3TTrlyVhjcBE9
 2892BY3l46yO79duf+/3vCww70vuUcw0j26ZQ4acewIqQF0hrM7xFicLtSFxFIiX
 kYOUYzPpS7Zb8Ool1wnzVM5Ig9pakhY/tQnYl+8LYWoOLeYJXTp7AhSxLpDF5Wbz
 wPm1nW1IwljbJXrYgw843Nu8ZEP84QfJpotvvhww==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqhdc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 08:05:57 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O843HI027324;
 Thu, 24 Jul 2025 08:05:56 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqhdc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 08:05:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6W2JT025138;
 Thu, 24 Jul 2025 08:05:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480npturym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 08:05:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O85sT060162400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 08:05:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE84C2004E;
 Thu, 24 Jul 2025 08:05:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B6D220040;
 Thu, 24 Jul 2025 08:05:53 +0000 (GMT)
Received: from [9.111.1.127] (unknown [9.111.1.127])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 08:05:53 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------qXqF10ZfAJix5GK9EuNF4A69"
Message-ID: <d28741e9-1e47-4a83-a37e-20e516ec7deb@linux.ibm.com>
Date: Thu, 24 Jul 2025 10:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IFJlbW92ZSBGcsOpZMOpcmlj?=
 =?UTF-8?Q?_as_reviewer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250724075916.1593420-1-clg@redhat.com>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20250724075916.1593420-1-clg@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1NCBTYWx0ZWRfX1rta/tTgt6a7
 ar0wbWtvA6HQPvcg9K1a7XYR+rTbQ6RFVAlXqV2ag5PfnzgZJuxRb7jy8vjluERUxkq3IWnfGaA
 P7Q5DMz86lHNGAMZLPceb72H1RJ0mhIhIFbe9MBsGLwvgUZmNw6g0EWey/J9Yse4EQI/f3gaLla
 hb2reKjwq4DQx8OihEqoEcDpe6IVYaCKI2pvWvwzY2hakqqZRpiAp7j/5kM3bNnXe2IohgQDNl3
 d8io98BpMHjvCX//8ZmtwHCWumtlOifBEQ75UcVjXsZAOA6dL3uhF+qL+BOxXEI7qUsF/uyiJz0
 BUoqYWamg2Ad13A6bm+tupuOgPS+AqzCbIxQUsP9RBK4hY7YLOoE5cMcfptfBXkknOenuqj0LB1
 75IOIIlYce9kegk3XRShefieXKcsCP0j3jnmWs4sf+OcTgLnOBVrBTcr40PDiX2GKgGtv6As
X-Proofpoint-ORIG-GUID: dnug_KiPDGEPK1JpT1FLo9GE4jskn746
X-Proofpoint-GUID: 2lEGWjqxrybtiJSJ6QpHobqZKwl-bw_l
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=6881e965 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=5KLPUuaC_9wA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=W0xYomIou_QkumTA3RgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=j0mKdv-hwMJldExiu3wA:9 a=uTmpICtGGvg1W_Ke:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Jul 2025 09:13:42 -0400
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

This is a multi-part message in MIME format.
--------------qXqF10ZfAJix5GK9EuNF4A69
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 24/07/2025 à 09:59, Cédric Le Goater a écrit :
> Frédéric has moved to other tasks within IBM and no longer does QEMU
> development.
>
> Cc: Frédéric Barrat<fbarrat@linux.ibm.com>
> Signed-off-by: Cédric Le Goater<clg@redhat.com>
> ---


Acked-by: Frédéric Barrat<fbarrat@linux.ibm.com>

>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3f981f90deb..9481a21c8018 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1578,7 +1578,6 @@ F: tests/functional/test_ppc64_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin<npiggin@gmail.com>
> -R: Frédéric Barrat<fbarrat@linux.ibm.com>
>   R: Aditya Gupta<adityag@linux.ibm.com>
>   L:qemu-ppc@nongnu.org
>   S: Odd Fixes
> @@ -2780,7 +2779,6 @@ F: tests/qtest/fw_cfg-test.c
>   T: githttps://github.com/philmd/qemu.git fw_cfg-next
>   
>   XIVE
> -R: Frédéric Barrat<fbarrat@linux.ibm.com>
>   R: Gautam Menghani<gautam@linux.ibm.com>
>   L:qemu-ppc@nongnu.org
>   S: Odd Fixes
--------------qXqF10ZfAJix5GK9EuNF4A69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Le 24/07/2025 à 09:59, Cédric Le Goater
      a écrit :<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250724075916.1593420-1-clg@redhat.com">
      <pre wrap="" class="moz-quote-pre">Frédéric has moved to other tasks within IBM and no longer does QEMU
development.

Cc: Frédéric Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
Signed-off-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@redhat.com">&lt;clg@redhat.com&gt;</a>
---</pre>
    </blockquote>
    <p><br>
    </p>
    <pre wrap="" class="moz-quote-pre">Acked-by: Frédéric Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
</pre>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
      cite="mid:20250724075916.1593420-1-clg@redhat.com">
      <pre wrap="" class="moz-quote-pre"> MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3f981f90deb..9481a21c8018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,7 +1578,6 @@ F: tests/functional/test_ppc64_tuxrun.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <a class="moz-txt-link-rfc2396E" href="mailto:npiggin@gmail.com">&lt;npiggin@gmail.com&gt;</a>
-R: Frédéric Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
 R: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
 L: <a class="moz-txt-link-abbreviated" href="mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a>
 S: Odd Fixes
@@ -2780,7 +2779,6 @@ F: tests/qtest/fw_cfg-test.c
 T: git <a class="moz-txt-link-freetext" href="https://github.com/philmd/qemu.git">https://github.com/philmd/qemu.git</a> fw_cfg-next
 
 XIVE
-R: Frédéric Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
 R: Gautam Menghani <a class="moz-txt-link-rfc2396E" href="mailto:gautam@linux.ibm.com">&lt;gautam@linux.ibm.com&gt;</a>
 L: <a class="moz-txt-link-abbreviated" href="mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a>
 S: Odd Fixes
</pre>
    </blockquote>
  </body>
</html>

--------------qXqF10ZfAJix5GK9EuNF4A69--


