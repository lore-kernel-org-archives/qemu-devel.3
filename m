Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F9ECA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGZ4-00043V-Vd; Thu, 18 Sep 2025 11:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uzGYs-0003ul-10
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:28:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uzGYj-0003Tb-H0
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:28:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAHjUe018471;
 Thu, 18 Sep 2025 15:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0MeYOe
 rMHFYbKZfJ8EkG1RQNkzgw/qLIW3GFK9uDXwo=; b=Gt+zRxd8+vpd1NQrJPYx/C
 uwsEjU5dn07tR8d277Rf8zYaNQB7OeSCsISr/vRz5oJTH+06Ed771DaF8awMyptD
 Ztcuzni0oQRGR+AVKHiAImkYagWnqSR733M1Y6qoMF7k8UQA6yFiu4qZw5tOUTqC
 8UNsLhdMEmrQMoYe09X8Jve0yzKXCIpat+C5tGTuhhczb1h48d4WmT6RLb6bJFKO
 q2wDkKnnub+QvrTLakMxAnqgM7s3xOvWqckrK6m+mYlt0q4hJ/fsjqpUbNXlZdZS
 00t5t1ho6siz/6wFoFOvOh11ulqIAnkJeefnhw34A4ncvJfLnlsF1BCYiMCMCw3A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pb7wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 15:28:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IFEJ4V012353;
 Thu, 18 Sep 2025 15:28:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pb7wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 15:28:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDJBho022300;
 Thu, 18 Sep 2025 15:28:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpyb1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 15:28:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IFSKRB36503810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 15:28:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95CFA20040;
 Thu, 18 Sep 2025 15:28:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9713D20049;
 Thu, 18 Sep 2025 15:28:17 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.53.186])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 18 Sep 2025 15:28:17 +0000 (GMT)
Date: Thu, 18 Sep 2025 20:58:07 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Fabian Vogt <fvogt@suse.de>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 1/4] hw/intc/xics: Add missing call to register
 vmstate_icp_server
Message-ID: <aMwlB72gmJl0ILZt@Gautams-MacBook-Pro.local>
References: <20250819223905.2247-1-farosas@suse.de>
 <20250819223905.2247-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819223905.2247-2-farosas@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2k0ky1GF2WzM
 0QpDqQahsmt+2o+w8fSbbq2I9RVJGjpDtkhgAMY1MdR3WVkY0qYDOSKKHiurfuSj+qk4zqTHIaW
 5YvJTrZxXwWy48oTmSmcmQe5upUPBn6FbMP/9mjBgxG3w0kLCkhESm3T8kkdy61lwn0VAjFNulM
 kSjuHM66Zc1Ae42K67mfoQUs/pW/3TVA6cDUEC7x+8FkRvFpQI/+1Ik1K3eBQNVPpz6lZer4CkU
 qpr+vQcltmNPubDQ1lxq72pUYmxCBhbt3x8rUSV7Cpd+SIrq/Y7caUTs53m2LCkxJeBTFy8QkIy
 XZe4SGzKTfl+Q8lYktu3DSjmFz2En3yioo2r71VWGukM4Xewmk3tiyd2pchNIkN49OVVD4RXCpm
 5dn4hMLP
X-Proofpoint-ORIG-GUID: 38C-8FmafV4jJClMJBf1pblBv47ZxvrY
X-Proofpoint-GUID: F5tsoFa_QEZkNowFQDfDsvF7pMELBFjT
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc2518 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=GCogdzMTRew3jUDZFjwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 19, 2025 at 07:39:02PM -0300, Fabiano Rosas wrote:
> From: Fabian Vogt <fvogt@suse.de>
> 
> An obsolete wrapper function with a workaround was removed entirely,
> without restoring the call it wrapped.
> 
> Without this, the guest is stuck after savevm/loadvm.
> 
> Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
> Signed-off-by: Fabian Vogt <fvogt@suse.de>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/6187781.lOV4Wx5bFT@fvogt-thinkpad
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  hw/intc/xics.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index d9a199e883..200710eb6c 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      }
> +
> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
>  
>  static void icp_unrealize(DeviceState *dev)
> -- 
> 2.35.3
> 
> 


I did some testing with QEMU-9.2.0 and 10.1.0 and my observations are:
1. QEMU-9.2.0
With XICS, both snapshots and migrations were broken and they work
fine with this patch

2. QEMU-10.1.0
With XICS, snapshot and migration both are broken - lockups are observed
(with and without this patch)

The 10.1.0 can be fixed in a follow up patch.

For now since 9.2 works fine, please feel free to add
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>


Thanks,
Gautam

