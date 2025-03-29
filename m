Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE485C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 17:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyaMw-0007ys-4Z; Sat, 29 Mar 2025 13:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyaMr-0007vT-6M; Sat, 29 Mar 2025 13:53:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyaMm-0001ux-JX; Sat, 29 Mar 2025 13:53:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52TCT2Gd032186;
 Sat, 29 Mar 2025 17:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xprOJ3
 OaZsvSOLiVznwrZ2+IY1nVTBardxwXdTU2Gx4=; b=EoFY7av8HMX5DnkpGEJwDw
 VM9OCDC24wBq5BT7w6UvJvC+G4rVvg6yncQTW3lycKzDqmgdFsyKGGS7y/nn62s6
 itffvBFEHQikYpVJ1VPk3s9LX9QOZBByMJY0n6rvg1zz0BFSOnh1ZGekAIUME6tn
 W5L0QdUDvo4MqmqZN8diPvqcTRbfaLl69NRhBBA5cTV4k/k0LKTPq9xtv27PSRgx
 L7bYSnWaZ/SJN1WIGc0jaBKlqZWxRdaKhMiSF/8BHAnFO14NOj1MJsllNo6IZLFc
 mIl4NN/Qyl2oRCk4223aF6vKyAQGd9jkBhEb17106ande2wvfQ/sgZlpWEcgL8wQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45pgw1gway-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 17:52:57 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52THqvgt017086;
 Sat, 29 Mar 2025 17:52:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45pgw1gwau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 17:52:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52TD9tEp020105;
 Sat, 29 Mar 2025 17:52:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hpgf72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 17:52:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52THqqcP32899650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 17:52:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FD5E20043;
 Sat, 29 Mar 2025 17:52:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9206220040;
 Sat, 29 Mar 2025 17:52:49 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.16.183]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 29 Mar 2025 17:52:49 +0000 (GMT)
Date: Sat, 29 Mar 2025 23:22:46 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] target/ppc: Deprecate Power8E and Power8NVL
Message-ID: <5vt3zgzmpbb3smwwxvwdx5r57mm5i4qypznzamdwah4czwawij@ei74grckoqdp>
References: <20250329142641.2502003-1-adityag@linux.ibm.com>
 <050f086b-be7c-4ec3-a67d-f2b183750ef8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <050f086b-be7c-4ec3-a67d-f2b183750ef8@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MjuXK_UHXkmrvQpbdRVC4NmtFRcJCeVC
X-Proofpoint-ORIG-GUID: Acdilg-RIlF9RVV3NtuZJg6hJKM7uUsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=616 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503290126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/03/29 06:42PM, Philippe Mathieu-Daudé wrote:
> Hi Aditya,
> 
> On 29/3/25 15:26, Aditya Gupta wrote:
> > <...snip...>
> >
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -32,17 +32,22 @@
> >   /* PowerPC CPU definitions                                                 */
> >   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
> >       glue(glue(glue(glue(pvr, _), svr), _), type)
> > -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> > +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _is_deprecated) \
> >       static void                                                             \
> >       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
> >       (ObjectClass *oc, void *data)                                           \
> >       {                                                                       \
> >           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> > +        CPUClass *cc    = CPU_CLASS(oc);                                    \
> >           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
> >                                                                               \
> >           pcc->pvr          = _pvr;                                           \
> >           pcc->svr          = _svr;                                           \
> >           dc->desc          = _desc;                                          \
> > +                                                                            \
> > +        if (_is_deprecated) {                                               \
> > +            cc->deprecation_note = "CPU is unmaintained.";                  \
> 
> The CPUs deprecated in this patch are indeed unmaintained, but maybe
> future deprecated ones will have a different reason.
> 
> Maybe use s/_is_deprecated/_deprecation_note/, so passing a NULL
> deprecation note is OK?
> 
>           cc->deprecation_note = _deprecation_note; \

Makes sense. Thanks, will pass a string then as deprecation message.

> 
> > +        }                                                                   \
> >       }                                                                       \
> >                                                                               \
> >       static const TypeInfo                                                   \
> > @@ -63,6 +68,12 @@
> >       type_init(                                                              \
> >           glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
> > +#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> > +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, false)
> 
>        POWERPC_DEF_SVR_DEPR(..., NULL)

Got it.

> 
> > +#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc)                   \
> > +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type, true)
> > +
> >   #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
> >       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
> > @@ -722,11 +733,11 @@
> >                   "POWER7 v2.3")
> >       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
> >                   "POWER7+ v2.1")
> > -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
> > +    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
> >                   "POWER8E v2.1")
> 
>        POWERPC_DEF_SVR_DEPR("power8e_v2.1", CPU_POWERPC_POWER8E_v21,
>                             POWER8, "POWER8E v2.1",
>                             "CPU is unmaintained")

Got it.

> 
> >       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
> >                   "POWER8 v2.0")
> > -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
> > +    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
> >                   "POWER8NVL v1.0")
> 
>        POWERPC_DEF_SVR_DEPR("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,
>                             POWER8, "POWER8NVL v1.0",
>                             "CPU is unmaintained")

Sure.

Thanks for the reviews, Philippe.
- Aditya G


