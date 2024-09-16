Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF4DC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqBeN-0003qY-O1; Mon, 16 Sep 2024 09:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqBeL-0003os-TL; Mon, 16 Sep 2024 09:20:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1sqBeJ-0007eY-Bl; Mon, 16 Sep 2024 09:20:17 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCavLc011609;
 Mon, 16 Sep 2024 13:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 bjyIOf8xvwvkNXX8tjCjxNsH2cQAi3fRTzRXG2q9eIw=; b=l8yI2iPt2zfOoxv/
 KouADbotXuCHBh5eRYDxc8zanio9IDzSv/Iy/gsM/GXMc3PopeND7TOHXbD2Dzwz
 Q7VFa+sWSsc25YFmlMEch/4QlvHQ/meeThO0ZpSrxmmGI1uMPgKgil94uqMp7rhf
 T+s764M+/MfkB7TWxApEalHCHv9zqMWAlksE62UylLP1Uldsg6JO1nUMfBYgVMm4
 Q2Wj4K2s5apMd+ro47pCXmrtN/R3RhzP7loNnIjpPRlAUP2TZFbsLRClQnl+pcWH
 NgxcQ0UgH5UMZupo2tIH4zLAC383l/+W/KxkXPBT8XaxlwK7tmp+0VQAv09U8g/f
 6Tk+cw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht89bt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 13:20:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GDKAs3025672;
 Mon, 16 Sep 2024 13:20:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht89bst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 13:20:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48GBfoeW030631;
 Mon, 16 Sep 2024 13:20:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npamyfsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 13:20:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48GDK5P154264230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2024 13:20:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5333820040;
 Mon, 16 Sep 2024 13:20:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B09020043;
 Mon, 16 Sep 2024 13:20:04 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.9.12]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2024 13:20:04 +0000 (GMT)
Message-ID: <a2cb5304c1bf326455030f7d370155ecba3cd7d2.camel@linux.ibm.com>
Subject: Re: [PATCH v1 06/14] s390x: introduce s390_get_memory_limit()
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia
 Huck <cohuck@redhat.com>
Date: Mon, 16 Sep 2024 15:20:04 +0200
In-Reply-To: <20240910175809.2135596-7-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-7-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KnMCiQoMi7sR3zoU6O7CXqSNF0xvHOmF
X-Proofpoint-ORIG-GUID: XQkVqObg8oE3PuGYST2AxzGXLp-tiMlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=953 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
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

On Tue, 2024-09-10 at 19:58 +0200, David Hildenbrand wrote:
> Let's add s390_get_memory_limit(), to query what has been successfully
> set via s390_set_memory_limit(). Allow setting the limit only once.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Comment below.
> ---
>  target/s390x/cpu-sysemu.c | 19 +++++++++++++++++--
>  target/s390x/cpu.h        |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
> index 1cd30c1d84..1915567b3a 100644
> --- a/target/s390x/cpu-sysemu.c
> +++ b/target/s390x/cpu-sysemu.c
> @@ -255,12 +255,27 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, =
S390CPU *cpu)
>      return s390_count_running_cpus();
>  }
> =20
> +static uint64_t memory_limit;
> +
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
>  {
> +    int ret =3D 0;
> +
> +    if (memory_limit) {
> +        return -EBUSY;
> +    }
>      if (kvm_enabled()) {
> -        return kvm_s390_set_mem_limit(new_limit, hw_limit);
> +        ret =3D kvm_s390_set_mem_limit(new_limit, hw_limit);
> +    }
> +    if (!ret) {
> +        memory_limit =3D new_limit;
>      }
> -    return 0;
> +    return ret;
> +}
> +
> +uint64_t s390_get_memory_limit(void)
> +{

Might be nice to guard/warn against s390_set_memory_limit not having been c=
alled before.

> +    return memory_limit;
>  }
> =20
>  void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index d6b75ad0e0..7a51b606ed 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -895,6 +895,7 @@ static inline void s390_do_cpu_load_normal(CPUState *=
cs, run_on_cpu_data arg)
>  /* cpu.c */
>  void s390_crypto_reset(void);
>  int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
> +uint64_t s390_get_memory_limit(void);
>  void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
>  void s390_cmma_reset(void);
>  void s390_enable_css_support(S390CPU *cpu);


