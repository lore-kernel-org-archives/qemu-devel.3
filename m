Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A438CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoDj-0000zz-8l; Tue, 12 May 2026 10:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1wMoCm-0000od-Ny; Tue, 12 May 2026 10:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1wMoCk-0000nS-VP; Tue, 12 May 2026 10:35:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CBNtCZ2607277; Tue, 12 May 2026 14:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=T09pv40A+807iJLFXd7FnOc
 1c0nZ46Et8eqk2KpOAG8=; b=bG1OQYNeKEqSj9cqeOIZ+7sN+JM/jf2icMkG65S
 5XMw0hRNl3KTUaaipn2APozooB2FWR/LAmQswLZ3lU+NgyKhxT5ZHGYxOOIideEx
 H8YRbBN7+rT89y6xHerKTfLeNEFY1i0XWVNJysnKKNQIyOekscjukuW+PiJLrDtH
 fQB9G4XeQ9JeOeyZTZ+lqKgu4plE0AiW8TSDrbweUHfpvGEml1TCU1hGLn2Hg+67
 QhCRIvROjEK8CRa/nelOa4IQl+9502raBJk19gbOrCT2pwEPoTLz4nvCzBafcWpC
 MaoB5zwteJamWJha4cvs2Q+P1v8k6qX4IlhNVrjq5pPUAvA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv53h6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 14:35:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CEOXAc008270;
 Tue, 12 May 2026 14:35:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgkg71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 14:35:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CEZAdW34275584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 14:35:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DE2A2004B;
 Tue, 12 May 2026 14:35:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A40D20043;
 Tue, 12 May 2026 14:35:10 +0000 (GMT)
Received: from vela (unknown [9.52.206.27])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2026 14:35:10 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
 (envelope-from <brueckner@linux.ibm.com>) id 1wMoCU-00000000ZIN-0TI5;
 Tue, 12 May 2026 16:35:10 +0200
Date: Tue, 12 May 2026 16:35:10 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
Message-ID: <agM6nlfVdt3xAbe-@linux.ibm.com>
References: <20260511134909.43802-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511134909.43802-1-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE0OCBTYWx0ZWRfX9Cts7uwFBLRn
 TH8uAeMx9DXepR48wl8fvOJqXa6rd9uu949gDsDmWBF7FX4VQcHloi6bohB2iwMSqk/aK50E0Qk
 wb6T+1xY8f/wkH7PzOE8iFq9WzvFb0i+yFyCAiJjUFK4YwxKNXCheWZljbZBSb+6nv2CihdzzAN
 cyC6vLB4wEbI2XyaxW5KQlagx0YK1QLwigQu2hQj5woYnWHmfekzHa2DaMFfUmr/QUOBrj2OttU
 w/iu9Q6nFjsTHxVBjHM2Or+FWhRhCC2SFgrHQ/R4lmrdxFWDU/piqzeRRE6TmQCVU0cKomkmw5M
 G/J9CFnYtvgU+HDP3Rq6I5bAq1MIEWu4hZJvy+2pu3lKhlgzWQgt57uOkXtdHI0xzNOqsdgVlla
 8RxFnevy5SCKv41/Ru1nD2e5zDgxp4Ghs9kXkh2NH91qV5SbBEXui+nryCAwAUqDkaA7CK6yz6f
 pnQhb2or0ZUPUy5mFhw==
X-Proofpoint-ORIG-GUID: y0XlwJJ0orJiJIJXOWRFqJ8VjxzRdOyA
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a033aa4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hgKO5acy12MQRdbuvIgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: y0XlwJJ0orJiJIJXOWRFqJ8VjxzRdOyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120148
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 03:49:09PM +0200, Alexandra Winter wrote:
> The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
> unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
> by starting the container ids at 1 for the lowest numbered container.
> 
> The qemu misbehaviour without this patch becomes obvious due to a recently
> proposed kernel fix. Older linux kernels pass the container ids from stsi
> fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
> in off-by-one values when compared to the values from HMC. A Linux kernel
> fix is being proposed to correct the sysfs topology ids by -1, so they
> start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
> fixed kernel runs on a host with a qemu without this fix, this can result
> in container ids erroneously being shown as 255.
> Example (Fixed guest on unfixed qemu):
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>   0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
>   1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
> After this fix:
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>   0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>   1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1
> 
> Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>

