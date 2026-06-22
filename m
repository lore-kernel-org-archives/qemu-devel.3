Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5710DCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfU0-00085B-43; Mon, 22 Jun 2026 10:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wbfTk-00084b-64
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:18:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wbfTh-00064R-7C
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:18:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDLQCQ2829122; Mon, 22 Jun 2026 14:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=s643cT
 pBUfokeBMywl8d/ai40b1ise5JohMQVrJNxL4=; b=DPxJJ+k40W4AXaT6LYRneY
 FtK/o8lMRyYzs9VSXGXc7mMsM2KRyzCsHIG3+NipedGodpj3/1B12lWMVTkDZrs0
 3mBFz2+t9MSRmeWVM9KJxJkJhMC6h2BmsNUGL4rUHGejlbqmNiwaCDeC/044gzQD
 XPGxQUBhSK3F6ptSoZdsEGjFS4gRJDRuOJbhOgvQatJXcFU2KizRTkyK9vrh4KDc
 JVhpJeYbX+Ww0lyxTY2nsocypL0fn0IcFJbAl0VXp5rLieNmxouo/ENnaCu9EnIl
 P0QN6hRY+E82ju/IFBZyBhsp+pY8A/WEFrvsTciFYrDKGz5EgeGHHWvah73ra1rw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hhx8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:18:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ME4cYk016591;
 Mon, 22 Jun 2026 14:18:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dfxc70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:18:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MEIDeW24576508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 14:18:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3132005A;
 Mon, 22 Jun 2026 14:18:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22A342004B;
 Mon, 22 Jun 2026 14:18:11 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.18.229]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jun 2026 14:18:10 +0000 (GMT)
Date: Mon, 22 Jun 2026 19:47:46 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
Message-ID: <ajlDm6VHX-Gd0Bh4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JVKzZz-TjiXQ71BSSwcJAMP-87bARm0k
X-Proofpoint-GUID: JVKzZz-TjiXQ71BSSwcJAMP-87bARm0k
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a394429 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=KCHLMIyAhemotzaD9pgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX0Y3YUdqcDtYx
 /I6z/TDf9aXczb85MkzZA2qGjrXePf21Ob+oMh9TLumwZP3dRsdxFwXWDJt8x/lHwfy0yB2vQP4
 g+h2mcZyMmSEbYuV+xcGgNGjoKyp5RGByImpcwdnB2s4gcWSD0GO2s18VWGYZzKhSDKaK4PEoFJ
 AQFCOkLoPY+IGGMDz0U5ZBT9YDbkDYwhYGSrhvbEJHBa+Vy1MJSTHXYkZclCFZ64yPDhXAuJX84
 StYbUJ48JIib6qVTDjPPF1TiILg3+FogaGgVwKgYEPxptIxo6IIJ6NVmKJiisKsg3/J/8GspCUJ
 l/NwVaBMK6aFs+nN1KQUSykRqLhrKnMQGCq6kFg+wvgbkBaN8LyJTcank+XCkBCG8fJkdqnbcKQ
 VxI2LVVCQIb+PDXQguvKpWpz09pmS6p/TaxYTlWN5FJUKrMNMTlAspSMlTeDwbr2Z6l+ziPrWqZ
 8H0yk+6HMOk5jwJzxEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfXwKiSvurpz+QF
 s1Tw0qJhlGBU8zQrTNp1GichL3jxAtZgv+9IKswqNJ18YPYDbUPi1HTT0NusyDlUAk8MmcvmwcB
 rH3FfhnSiensBLJsjXyXHEPjzF9kNTQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 26/06/22 12:31PM, Daniel P. Berrangé wrote:
> <...snip...>
>
> Much more significantly, there are the following people present
> in MAINTAINERS, whom are not members of the GitLab project:
> 
>     Aditya Gupta <adityag-#-linux-#-ibm-#-com>

My gitlab account is at: gitlab.com/adi-g15-ibm

Thanks !
- Aditya G

> -- 
> 2.54.0
> 
> 

