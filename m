Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E38CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBqK-0003Cw-HP; Tue, 21 Oct 2025 08:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vBBqI-0003B0-0h; Tue, 21 Oct 2025 08:51:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vBBqC-0007tU-Pl; Tue, 21 Oct 2025 08:51:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8HWuJ003883;
 Tue, 21 Oct 2025 12:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=b+vWZdSuLVEjsi//TA2ccCR
 gl6r1Li7/byQ7fuhWL90=; b=HhYhHYHrrtzT5UlYkWCO7Mt43L0oWDtzaLxNB/j
 tv9ufqNZMbCDN7xqg6Ys2coFD8PX5iVcRgfZy1yoOu0DHYApynNycKwsEf0PRl0I
 jAZopdb1GypdQcOB7AKq/3dchuszhXqFCxezbX1iCvSpZrpOTGz/xpPQOYJTMjzR
 8s9t5oOUjcO9mYKVOX7gEIPg7A2xJeq+p4Y1qtobqRN4Fs8SEJ+yPclMLftctN2L
 Pl+d79bAQJpEOF8hmG4F679dS51Nb3rSUDBsbU/HwtKJekLM96Aty2NiIL8ueI/8
 HFArTSuF312hrKDDP8o61kCuVCDzdHfukRVkW3iasp/Ldzg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326q0tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 12:51:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LC3nIL032142;
 Tue, 21 Oct 2025 12:51:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mtqjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 12:51:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LCpZ7Z53543368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 12:51:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8B532004B;
 Tue, 21 Oct 2025 12:51:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B694620049;
 Tue, 21 Oct 2025 12:51:35 +0000 (GMT)
Received: from vela (unknown [9.155.211.212])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 12:51:35 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.98.2)
 (envelope-from <brueckner@linux.ibm.com>) id 1vBBpv-00000000DnL-1E0y;
 Tue, 21 Oct 2025 14:51:35 +0200
Date: Tue, 21 Oct 2025 14:51:35 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
Message-ID: <aPeB188DtsMaq95U@linux.ibm.com>
References: <20251016121708.334133-1-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016121708.334133-1-shalini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f781dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=RKBmHt94fYA7jx5VqUUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyOqZEUOVLADh
 dv5ddcPJsYvfg9OnqblU/j3yMLebtWI2o5zsYFgZ+KZ0/nIQVN6bBssTxUvaM0Qd1d+ix22LivM
 w1+r83gHL4cOgHUpQJNpm7A536u99rlczirZD6EdUTxtZxS5G0ILDdFHopgDt7rAOmlxy7MKXWY
 GV3Ft/ELozMGrCSu5v9V9tTtltUkyNJpKBkYlhsYJfniXygvsveqkAVTSSPUFlY1E7jGRoNLcCa
 vMW5pAqJm7/RM8pmONgcVyY9u/g/YlleZYaOEX95etJpItdq8gvFHpi6gSRFChHc790bDD4enaQ
 Ece9NgAigTZh4M4rWJFJ41fppipVOSGRjRn+fDyY2Vkwt1Rnd3396pWvxR+Vk80g4MEmXmX/MtM
 fzroqdWMCIeccqimwVrpceQmI+p2iQ==
X-Proofpoint-GUID: YawUYoWQjCkJRhXRTsDgLrf99OK8ncCx
X-Proofpoint-ORIG-GUID: YawUYoWQjCkJRhXRTsDgLrf99OK8ncCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 02:17:07PM +0200, Shalini Chellathurai Saroja wrote:
> Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
> of Control-Program Identification data in QOM.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/sclpcpi.c      |  4 ++++
>  qapi/machine-s390x.json | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 7aa039d510..68fc1b809b 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -54,6 +54,7 @@
>  #include "hw/s390x/event-facility.h"
>  #include "hw/s390x/ebcdic.h"
>  #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-events-machine-s390x.h"
>  #include "migration/vmstate.h"
>  
>  typedef struct Data {
> @@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
>      e->timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
>  
>      cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
> +
> +    qapi_event_send_sclp_cpi_info_available();
> +
>      return SCLP_RC_NORMAL_COMPLETION;
>  }
>  
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index 966dbd61d2..8412668b67 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -119,3 +119,24 @@
>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @SCLP_CPI_INFO_AVAILABLE:
> +#
> +# Emitted when the Control-Program Identification data is available
> +# in the QOM tree.
> +#
> +# Features:
> +#
> +# @unstable: This event is experimental.
> +#
> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
> +#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
> +##
> +{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
> +  'features': [ 'unstable' ]
> +}

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

