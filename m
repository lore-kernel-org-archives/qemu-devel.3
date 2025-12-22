Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92B6E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 10:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY02D-0006BM-4N; Tue, 23 Dec 2025 05:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY02B-0006B9-Lr; Tue, 23 Dec 2025 05:54:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY029-0001iT-Qo; Tue, 23 Dec 2025 05:54:31 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM6b3P5032132;
 Mon, 22 Dec 2025 10:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=2kL16szr6TWeubh3LccRt1JDqrH8BU
 8G7WjkL+C+5F4=; b=hz+u0m/ZdotrwpQAmpw32JkoKvR368TKpPxDnnef/9y286
 JHuVFnIWGP2DG2yCSUs/M9CipUBPQ9q8/K68kmuOkskhHlUhEoXegMqJ4bRM9uRA
 AgHVjQvz7k3ZjQse0S6r9eZo1yHRZpe4i3OhcvMpZLuZw6VWsMWc7MI3/p0+9Ua0
 M9zScckhWEVL5H+LLgnR+Yyr45XRrAkVR47wO1DXO28d/+u2jz2MRBySvakf80L4
 WyMKkNCjCZdukp8JoHKsqiYzSFc2xybO0WAiixPqvhMKXHU9SqB4shtEX9jRqc49
 RGCMjM3sydcrLmW5JWvxtP7P5UY7Tp/B/wXCoxzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka37myw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMAl36Y028959;
 Mon, 22 Dec 2025 10:47:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5ka37myu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9e3fD005259;
 Mon, 22 Dec 2025 10:47:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b67mjwhqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:47:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMAkigD30016004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 10:46:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F61458058;
 Mon, 22 Dec 2025 10:47:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB80658057;
 Mon, 22 Dec 2025 10:46:57 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 10:46:57 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------eRfs98zP4W1ptWtzxzWtOw4w"
Message-ID: <28a3251c-52f7-468d-b2fa-a234acb47dd4@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:16:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251218200353.301866-2-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rTnqv4L8oSQHatnPqrRkjf--eeq3d4qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfX1n7cb5LxO/22
 twEa1h0blyuquVB/ze7dn7OWv3pU+4vluOAjXC7cu/c0X6vorihukyx9imaGi46J5F+Fqzjkhsa
 ZUr8u1sKRKoX2BvrFXSx2eJ53V/PvgrGYRj779wFyFO6jBgZiySVN8AYSEF2P2qq/k8KweL+IYD
 cNQLEPA1lC6HhwMLLflb2MafZXGuN3vZYSvmq83dHvTGmu3QYYTIPHMREw5jM/ouEdSdEbdU1TY
 0my0KVxMuM0MK73JQAC5RpBqCD0Mut6wUQ95RSHVEBl9u+0aOjVu4b2xNhBGtn5qGOLkobH29Hj
 eSum10+NEv49O41hxbhPmHaJut90LmtOlJ+2Euh4ix538Shp8Sv2qvDz5Z58C3t2bvh8SjHPcYl
 XTndnvyLQM0ynvuX1PUVV8Ue8+lkXyMr++59BSbDWsyuma2NIHkSr01LDmpIeTbH5gMNBLzqTFs
 2gF8nTj78EizpxFDjQg==
X-Proofpoint-ORIG-GUID: rgsHIbEMB2mzFJPYAz2iialOAz1_V00Z
X-Authority-Analysis: v=2.4 cv=dqHWylg4 c=1 sm=1 tr=0 ts=694921a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=uM3lmRkaaUgqgqTTx18A:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=fBMztYhIywFyU92DDHEA:9 a=_W_S_7VecoQA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1034 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------eRfs98zP4W1ptWtzxzWtOw4w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com> 
<mailto:milesg@linux.ibm.com>


On 19/12/25 1:33 am, Caleb Schlossin wrote:
> This commit suppresses the following informational messages
> regarding unimplemented pnv_chiptod registers:
>
> pnv_chiptod: unimplemented register: Ox0
> pnv_chiptod: unimplemented register: Ox1
> pnv_chiptod: unimplemented register: Ox2
> pnv_chiptod: unimplemented register: Ox3
> pnv_chiptod: unimplemented register: Ox4
> pnv_chiptod: unimplemented register: Ox5
> pnv_chiptod: unimplemented register: Ox13
>
> Signed-off-by: Glenn Miles<milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index f887a18cde..cd9b8ee348 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
>               val |= PPC_BIT(4);
>           }
>           break;
> +    case TOD_M_PATH_CTRL_REG:
> +    case TOD_PRI_PORT_0_CTRL_REG:
> +    case TOD_PRI_PORT_1_CTRL_REG:
> +    case TOD_SEC_PORT_0_CTRL_REG:
> +    case TOD_SEC_PORT_1_CTRL_REG:
> +    case TOD_S_PATH_CTRL_REG:
> +    case TOD_TX_TTYPE_2_REG:
> +        /* unimplemented, but suppressing logging for now */
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>                         HWADDR_PRIx "\n", addr >> 3);
> @@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>       case TOD_TX_TTYPE_5_REG:
>           pctc->broadcast_ttype(chiptod, offset);
>           break;
> +    case TOD_M_PATH_CTRL_REG:
> +    case TOD_PRI_PORT_0_CTRL_REG:
> +    case TOD_PRI_PORT_1_CTRL_REG:
> +    case TOD_SEC_PORT_0_CTRL_REG:
> +    case TOD_SEC_PORT_1_CTRL_REG:
> +    case TOD_S_PATH_CTRL_REG:
> +    case TOD_TX_TTYPE_2_REG:
> +        /* unimplemented, but suppressing logging for now */
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>                         HWADDR_PRIx "\n", addr >> 3);
--------------eRfs98zP4W1ptWtzxzWtOw4w
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Reviewed-by:
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <div class="moz-cite-prefix">On 19/12/25 1:33 am, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251218200353.301866-2-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">This commit suppresses the following informational messages
regarding unimplemented pnv_chiptod registers:

pnv_chiptod: unimplemented register: Ox0
pnv_chiptod: unimplemented register: Ox1
pnv_chiptod: unimplemented register: Ox2
pnv_chiptod: unimplemented register: Ox3
pnv_chiptod: unimplemented register: Ox4
pnv_chiptod: unimplemented register: Ox5
pnv_chiptod: unimplemented register: Ox13

Signed-off-by: Glenn Miles <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.ibm.com">&lt;milesg@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index f887a18cde..cd9b8ee348 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
             val |= PPC_BIT(4);
         }
         break;
+    case TOD_M_PATH_CTRL_REG:
+    case TOD_PRI_PORT_0_CTRL_REG:
+    case TOD_PRI_PORT_1_CTRL_REG:
+    case TOD_SEC_PORT_0_CTRL_REG:
+    case TOD_SEC_PORT_1_CTRL_REG:
+    case TOD_S_PATH_CTRL_REG:
+    case TOD_TX_TTYPE_2_REG:
+        /* unimplemented, but suppressing logging for now */
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr &gt;&gt; 3);
@@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
     case TOD_TX_TTYPE_5_REG:
         pctc-&gt;broadcast_ttype(chiptod, offset);
         break;
+    case TOD_M_PATH_CTRL_REG:
+    case TOD_PRI_PORT_0_CTRL_REG:
+    case TOD_PRI_PORT_1_CTRL_REG:
+    case TOD_SEC_PORT_0_CTRL_REG:
+    case TOD_SEC_PORT_1_CTRL_REG:
+    case TOD_S_PATH_CTRL_REG:
+    case TOD_TX_TTYPE_2_REG:
+        /* unimplemented, but suppressing logging for now */
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr &gt;&gt; 3);
</pre>
    </blockquote>
  </body>
</html>

--------------eRfs98zP4W1ptWtzxzWtOw4w--


