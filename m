Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823C8D3C530
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 20:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1XGM-0002d2-NR; Thu, 17 Oct 2024 16:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1t1XGK-0002cX-0p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 16:38:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1t1XGI-0007fl-1K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 16:38:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJSCcN008212;
 Thu, 17 Oct 2024 20:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ds5l6O
 wbtWIFz3OGFp7VL9J/dX2jNFIYrPcNxhTEy/4=; b=c5Nk9ij4Pew6BeFC9rTTjB
 qaSOdVf8T8/WvQg4gaXo7vtdnnzYRrpARGl+zApcxj415Jp54XU01bmuONnhQu4n
 g1hcrVPb9O53g1fYOe58A5jwRZKKSshVabAAIVNozO13AXwbYmYYAvmuQJxELwKM
 XNDaXuDVjQCGTHTbh2bMY+wkJqErD9TwYcUtAD9b3SPL4mkiv1m4y8g2IS7ZfCQY
 Pw8T2+8Oe6G43NmSjfii87RE8viMv+Gzi2tW8CpM3KEvs8XRdtr7M/8YFlQT+34t
 BcbvkPZndpHy93tmcWs52hMnVoUqyVJIgJU349ouALzUhwJSloUZfuctBiob74AA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42as8a4wk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 20:38:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49HIhxA4027480;
 Thu, 17 Oct 2024 20:38:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283ty12tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2024 20:38:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49HKc6hS22675836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 20:38:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EF522004B;
 Thu, 17 Oct 2024 20:38:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18DE220043;
 Thu, 17 Oct 2024 20:38:06 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.21.94])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 17 Oct 2024 20:38:05 +0000 (GMT)
Date: Thu, 17 Oct 2024 22:38:04 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 09/31] hw: adapt to new import path for qobject data
 type headers
Message-ID: <20241017223804.30afbf87.pasic@linux.ibm.com>
In-Reply-To: <20241017113344.883424-10-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-10-berrange@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rZW7phDRuKN7msIAkyMgngh6W6hC98LA
X-Proofpoint-ORIG-GUID: rZW7phDRuKN7msIAkyMgngh6W6hC98LA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170137
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 17 Oct 2024 12:33:21 +0100
Daniel P. Berrangé <berrange@redhat.com> wrote:

> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index bf22d6863e..1b89092fe7 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -16,7 +16,7 @@
>  #include "hw/s390x/storage-keys.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc-target.h"
> -#include "qapi/qmp/qdict.h"
> +#include "qobject/qdict.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/memory_mapping.h"
>  #include "exec/address-spaces.h"
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c4259b5327..b9116cd5f5 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -18,7 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "exec/ram_addr.h"
>  #include "qapi/error.h"
> -#include "qapi/qmp/qdict.h"
> +#include "qobject/qdict.h"
>  #include "cpu.h"

Acked-by: Halil Pasic <pasic@linux.ibm.com> #s390x

