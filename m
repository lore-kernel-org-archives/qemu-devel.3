Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29C2C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhCU-0005eT-CT; Fri, 03 Jul 2026 12:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhCR-0005du-Do; Fri, 03 Jul 2026 12:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhCP-0001vy-FK; Fri, 03 Jul 2026 12:57:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIkL53383279; Fri, 3 Jul 2026 16:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7VvkWn
 u2fx0s1eY8aakMYvspIGp+/Qg7OSUQSTHk1Tc=; b=fPSTjZrwcV9CbtOLvTwGGX
 kJTbbhoOzLTukuBV2c2OOHQFSqngh/McfgWeJA+M4ya2k8fmdIziABX/VuVeYQsk
 U3yGlDrsfVYgVrS0/4MlyXBoans0UI1rk+Wh6Hq6viZYbRGJT6ywB0r50+5lSIY6
 vO0kxgh0GgW68HsuEsXVIHmgSyDXdGHyknlnVK+fkEK0mB7beYc5x2Uw9vpsmwGd
 sGXhaCR9kAmKvdQsv0X/WexbBqXsC4ryki0f8W3h+MVQWUIg6b7niUnrFVQwQXV7
 B/3BYT1HiVNkWRgMQC1ncGLb89CySMabcGgBWJ9tRJvy7PtYRiNIyJxYoFAv5GRg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26peg9ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 16:57:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnZli031463;
 Fri, 3 Jul 2026 16:57:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhysftc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 16:57:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663Gv1BZ28181094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 16:57:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0B515804E;
 Fri,  3 Jul 2026 16:57:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFCC25803F;
 Fri,  3 Jul 2026 16:56:58 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 16:56:58 +0000 (GMT)
Message-ID: <5c7a7c60-c874-41e1-9e47-28de61b7cc98@linux.ibm.com>
Date: Fri, 3 Jul 2026 12:56:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/33] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-5-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703022933.1805010-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qyr0JuEVp0pKXOhZ0VmunDertPk7UV1p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX2HlRipmwgn1A
 /GTqG8vQ2KiJRPDw8+S971HgVTVKT6jbfiAtuFfUNaPkQZbKYWAGw5rkJdF4aq3F2d0Xuk+3kyV
 zH7L/4t0nuZDgPQiT5Tm4sDWLefxvp4=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a47e9df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=NoTqclVnJAl4llu3VHcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX/RAY+ajaOLoC
 6D59wfjlGlAU94OPOO352MeKVYS2mByucJxi7cSQwze5Q5kPS+A0Uj5t1ozTfyUA+aNX8UBytVu
 iRF8M/PLLMMe9b0SFN53uqcarBJyZCqTPrAEWmQpdFiHubfakJMLl6yOu/UX19mg084vjkIteS3
 dgISL9KZQZ+rX1EvppEVyH+CRNQf48PsGRBeDx8Fk9WC6o28m60OExb8TZA/7lvqoBwkNN+zfTV
 GNjyC6MAJKmsqBLjkfXJUFwHyL755zP8BhVgAKfjxWSVILH//JYgHLlddo5hvk0VZGkHQd2AuOZ
 y0j3FLBglB/sMbiDLus4iPkbvXjVNZTj6SIQPrG86BB6PWBgq4hq56RZFLYWy/eJwT2/ZEY3S7d
 a2bHFNoC+uC5zu1Wd5PyhnyAAKtzYqm2X3lPNUoxgB5uSK3Rz4uO0EZXEOMjJjqFWg1uOnnr6Ky
 hc8Vr0YPjEhG7QMq9gA==
X-Proofpoint-ORIG-GUID: qyr0JuEVp0pKXOhZ0VmunDertPk7UV1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/2/26 10:29 PM, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only.
> 
> The raw Base64 data is stored, as well as the certificate's size.  The
> binary (DER) size is stored as well, which may later be utilized for
> secure boot (signature verification).
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

With a few minor things below:
> +
> +s390 Certificate Store
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +A certificate store is implemented for s390-ccw guests to retain within
> +memory all certificates provided by the user via the command-line, which
> +are expected to be stored somewhere on the host's file system. The store
> +will keep track of the number of certificates, their respective size,
> +and a summation of the sizes.
> +
> +Each certificate is stroed in an S390IPLCertificate struct, which has a

stored

...

> +static int update_cert_store(S390IPLCertificateStore *cert_store,
> +                             S390IPLCertificate *cert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->largest_cert_size < data_buf_size) {
> +        cert_store->largest_cert_size = data_buf_size;
> +    }
> +
> +    if (cert_store->count >= MAX_CERTIFICATES) {
> +        error_report("Cert store is full");
> +        return -1;
> +    }

Seems we should check this first before updating largest_cert_size?

I think ultimately it will not matter because we will exit anyway, but
for debug may be useful to not have the largest_cert_size potentially
clobbered by a cert that was never added.



