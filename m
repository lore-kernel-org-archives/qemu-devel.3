Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBnm-0002IC-1T; Fri, 24 Oct 2025 03:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCBni-0002Hs-G8; Fri, 24 Oct 2025 03:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCBne-0007Ie-AA; Fri, 24 Oct 2025 03:01:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O2Cp83001436;
 Fri, 24 Oct 2025 07:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aGL96QkdmxV/93o3u77NLA1xCKDU8F
 GsOUJ6EMPnSyA=; b=djs9Tn8aQIzr8mlr8A4BanWhd6cB/JPzpBpI7fRkfTfZV7
 vCJU6mYaLfZrJDGCbgYEpJ52GCooaCwR7HtcI6C0ik9oSk2bVLXnN5KogQ05OZBs
 eM9NImBmxM6OYfrwrgdn0RMGsHdZhk6pyW92s6+LxaqjOASwLgyRxOP9M8tbuOEK
 tkGlckOmqw6enpt402MjwADBH6DJFga7EB7UOW+H88RLWfn/zs/c/2BR4hf42pt9
 UwCxq2sod2+4u94grNdjjLRUs4mUxWa/MjUjLMZrM506RzE3Qo7TJ/oOudfMFIRW
 xwfso34I9JZf1i+2RG/tivfO5rTkPhQhIPgc5D8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31se1hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 07:01:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O70lZt004782;
 Fri, 24 Oct 2025 07:01:09 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31se1ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 07:01:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O4JBxR014848;
 Fri, 24 Oct 2025 07:01:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sj3p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 07:01:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O714Ix38076802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 07:01:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B404020040;
 Fri, 24 Oct 2025 07:01:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8869120043;
 Fri, 24 Oct 2025 07:01:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.24.113]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Oct 2025 07:01:01 +0000 (GMT)
Date: Fri, 24 Oct 2025 12:30:59 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 hpoussin@reactos.org
Subject: Re: [Patch v8 5/5] ppc: Pass error_fatal to load_image_targphys()
Message-ID: <b77zlk6bmog2l42zsqerhceeuenfwjvhhqmrwzycilzqet4lcr@uhrhof54phgj>
References: <20251024052707.1852358-1-vishalc@linux.ibm.com>
 <20251024052707.1852358-6-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024052707.1852358-6-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b-lT96tYvPpSq3BqA6JEWKL33W0RQMKh
X-Proofpoint-GUID: KiKSeLIIpvgryvLoVDRjTHaYzTv3WAiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5fVsarr088/a
 WXd5zJv9DpsEPnmefpl3KtIDsXQqgeZFsX7YCK2PdLvmX9yav+mScK1GS1MMmmomzW+JnEnSMF4
 lbTvAZHy18u8wkohCi/UeNC2qeaNc9x52VoLqGyGbrMveS6f4NecXJjWomLWxoP5yF9tUsaIaSr
 qdga1GxBPFvBvGbDoAhIIl3S3w9rjS8oLUOs2VUYElh7FIbon6akxG+wiJjc3cTNWGcrGHcPf+n
 qeyUFnMO8D+emRlIRPRmlLcWzTlrbmaP2PO1nk4p+Cq5iMgSrDm9Ht+GImkBHor9UtWamNK/ME8
 5kfD82TRuMevfI5v2Lm89Cv+oUv+MCrAoz8Z5sRdryPyQYjYgPqvSXuQCQ2IR2+7TpdYIp5/K61
 oUVsQbXSmsXPDNJx43t80vb/A/08qA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb2435 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=_EigNRFGLW7WWO1u94oA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 25/10/24 10:57AM, Vishal Chourasia wrote:
> Pass error_fatal to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
> 
> Passing error_fatal automatically reports detailed error messages and
> exits immediately on failure. Eliminating redundant exit(1) calls, as
> error_fatal handles termination
> 
> The behavior remains functionally identical, but error messages now
> come directly from the loader function with more context about the
> failure cause.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

Thanks, the errors are much clearer now:

	$ ./build/qemu-system-ppc64 -M powernv -kernel ./vmlinux                                                     
	qemu-system-ppc64: <...>/vmlinux exceeds maximum image size (128 MiB)
	
	$ ./build/qemu-system-ppc64 -M powernv -kernel ./vmlinux
	qemu-system-ppc64: Could not open '<...>/vmlinux': Permission denied
	
	$ ./build/qemu-system-ppc64 -M powernv -kernel ./vmlinux
	qemu-system-ppc64: Could not open '<...>/vmlinux': No such file or directory

Have few observations below, but the patch looks good to me.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

>
> > <...snip...>
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 004efc6b97..951de4bae4 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -189,7 +189,7 @@ static void ppc_core99_init(MachineState *machine)
>          if (bios_size <= 0) {
>              /* or load binary ROM image */
>              bios_size = load_image_targphys(filename, PROM_BASE, PROM_SIZE,
> -                                            NULL);
> +                                            &error_fatal);

Nit: This and few similar diffs below change the behaviour.
Previously qemu wouldn't have exited here, but now it will.

This looks okay to me, as considering the code, it must successfully
load these images.

Thanks,
- Aditya G


