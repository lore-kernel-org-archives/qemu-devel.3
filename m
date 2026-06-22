Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55581CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgvI-0001H1-ND; Mon, 22 Jun 2026 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wbgv9-0001G6-10; Mon, 22 Jun 2026 11:50:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wbgv7-0000BJ-0J; Mon, 22 Jun 2026 11:50:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFmEoY3591590; Mon, 22 Jun 2026 15:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hJ80Cb
 sv1XchP4Aktb6kOpovSj4iolLUCpDFnHMibnI=; b=S2v3oU/wc4TGzE98Y6Wyik
 9rOf6DbuyAKL738XhC4dcP4jRhFoCaIHEmCKRCfb8iQ/k5PXsm4+fZlbtf00Qo5b
 COvsDMwELNYWwvcg5kWEMojhcDyL6adhGnzucbAGkPCZstiy8tZxIiNjAxJoLx4r
 q5WC8UMFnlm/udZZHMzlBGkp8guUkVuHoO1PHQ0sVMfFZGm6JPb09lNjIOVOPImQ
 UztfEcEzopgsObwOq1KG9S2bnzzPmPAGSFWOOpwpyQvtMJsjbZng/Yt0c36hV2oc
 nhVMm3GmOXPIbguUr75zxG4dBI05wWkF1wf43aQ5bZbG8ed0Q1Vwd2Nq5lxMU5Gg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqj1j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 15:50:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MFnlVk025320;
 Mon, 22 Jun 2026 15:50:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyem47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 15:50:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MFob2E24969790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 15:50:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164E95805F;
 Mon, 22 Jun 2026 15:50:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B5C05805C;
 Mon, 22 Jun 2026 15:50:36 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 15:50:36 +0000 (GMT)
Message-ID: <0e3faa9f95c042f1a614b056a6b82bd94abf83ca.camel@linux.ibm.com>
Subject: Re: [PATCH] s390x/kvm: clamp stsi 3.2.2 size
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-devel
 <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
Date: Mon, 22 Jun 2026 11:50:36 -0400
In-Reply-To: <20260622092035.400959-1-borntraeger@linux.ibm.com>
References: <20260622092035.400959-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3959cf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=p45afdTvkiPx-vbwLScA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX42Kg5+igMRd2
 tCq5cmQfSEbub9fC3wJC3ezAJgQYdT0XNPdb/HogU7LqDPs4CII+Sj7m+t6u21sXSXuSHFZXXbx
 qSGehRyC4DjVRhVM4PKMZ6Z5wjI9AjRE0SWdr7NJP6ra6ZXC8C56N9NEPicNgbM/ZsQU8CZ4aC/
 RP+Szvynp9FXv6nPDt1ByG3Ttj2nCEmLMTGprH7YhHEMqXmTYH3DZdv94T0pf42QJdxZ4EqKcI3
 kLbwkyHB7Bo6AUVxOmQn+xjFe+TGBrcHy+qKjEMqB7DnTy3Vere/WKB0kdpwvmBXdfWfTHg3cj9
 cDsDKIF++UxCjhjh9LdvxZmBAPrd8f28WZW6HGZa/oyB+7b3Ng/eTVoh83YgEUGHusPnXtZ/eS3
 K08U8KHJhMH0ICDJGRvMbPTb0yedn2KDa6Ukq+nVPIlnYLQa2GnPTQo4aNwfvD0ireeDsb9wKwC
 ZyKqBxhq0U50sGrq2bQ==
X-Proofpoint-GUID: RcIQ5dsgDHwEvJQrJL5L1nzQbUDeKAui
X-Proofpoint-ORIG-GUID: RcIQ5dsgDHwEvJQrJL5L1nzQbUDeKAui
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX8P7amHE5Ku6r
 Xj2KjfpRv15BqaBFxVdo3L03NxMSq7OEmPSveoCvTCc3cOuGELb1tq6OBro/HI5vex63IAxZBUE
 +mZbGNemP6sBrZrG+GTDLfJNGoOo4OE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2026-06-22 at 11:20 +0200, Christian Borntraeger wrote:
> The stsi 3.2.2 page is being prepared by the kvm module and the size is
> clamped by the kernel. As the memory is mapped in the guest, another
> guest VCPU could race and overwrite the count and messing up the move
> operation. For any out of bound count, fall back to the kernel buffer.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  target/s390x/kvm/kvm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Looks right to me.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index ed8cd6b410..a3835573bb 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1791,6 +1791,15 @@ static void insert_stsi_3_2_2(S390CPU *cpu, __u64 =
addr, uint8_t ar)
>      } else if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysi=
b))) {
>          return;
>      }
> +
> +    /*
> +     * The memory was filled by the kernel but mapped into the guest.
> +     * If something is fishy, do not touch the buffer.
> +     */
> +    if (sysib.count =3D=3D 0 || sysib.count > ARRAY_SIZE(sysib.ext_names=
)) {
> +        return;
> +    }
> +
>      /* Shift the stack of Extended Names to prepare for our own data */
>      memmove(&sysib.ext_names[1], &sysib.ext_names[0],
>              sizeof(sysib.ext_names[0]) * (sysib.count - 1));

