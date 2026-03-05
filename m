Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296A3EEF317
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGLN-0001PL-NS; Thu, 05 Mar 2026 16:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vyGLK-0001IP-SJ; Thu, 05 Mar 2026 16:34:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vyGLI-0004wg-Qr; Thu, 05 Mar 2026 16:34:50 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625DR9T91457437; Thu, 5 Mar 2026 21:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H+v6V5
 aPRp6n6jmozsRAJ581EuSBEx2cwCZqsP9gex4=; b=eEloK309dvNPDlbd9hm5kB
 SgVNmM9/WhhdVGuzQ32H4AA4c9+axhVufWNME5TzH7YJLnFxLGhEel5qbdTBxuqK
 4Sp9zTgkcOyO6B9yOa+Sb0xywTt5SvWj4kqkV5fMx7IvIZH014Kcpe/32uo3GmhB
 02o1DNhHKDErcfBjNXw3Q3SUqYU1nPDGeC2VsarIL4axhblT7gHPei5ro7c9aVBp
 qc7uAqun1ntwoD2jyAgG6qdwlSuWR6+C3J5Wxa9QbzswN4hA/o25fZjlmNztrI//
 X90BfWCEI4dp1v8tjDfikAY5U6jEUjH0nd2EGT758psWtLyNhPBq+fUyTEhzYH3Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjdtu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 21:34:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625Ht13S003275;
 Thu, 5 Mar 2026 21:34:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ydajh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 21:34:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625LYdk428312156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 21:34:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E824D580F2;
 Thu,  5 Mar 2026 21:34:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 170CF580F1;
 Thu,  5 Mar 2026 21:34:38 +0000 (GMT)
Received: from [9.61.243.85] (unknown [9.61.243.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 21:34:37 +0000 (GMT)
Message-ID: <6d403596-571a-4452-8284-3233ee457f4f@linux.ibm.com>
Date: Thu, 5 Mar 2026 13:34:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/30] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260212204352.1044699-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a9f6f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=uIToqUvhtT_G6tQXqXoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE3OSBTYWx0ZWRfX7iNp3nnRo218
 uS1LrDuZCelsIzvmlAzVKqQZ3NxgETZiA2zbuUjEm/76oAPa+tfr+XOyvEq+3Amo5tvF6MrAMMf
 CfBi0RdgWmc0sJA/kAPYhtZIzEG0qnEVfCHTC+DQveL4U/95EeEXDeGHJuSeIz+sYVKcoXPtaac
 2DGWtmwFXzvnWJAPPyT7BgvUTY30MJlpYhy0wSUBmay1X+JlXJS8SscJm+nBGt/+Miayv3N2V1s
 wtoBPbG6dhA+UeC7r6VqHnje+Ej5n8z/e2rktqejTngsT4AoiXVlbb+Jvfvf4X4oQ8u2T1rUTuw
 HTChTxok38Q9TBa7HtKyzjah7FRoISnHhIuk78jtoLv6YPic+Th08LyTPh/15hHfHiDEOQk5mcg
 c4UrfX08j31tmT237iaXxK/3AlhIMC2sEELI6fYu5S8tTm/ZtO9egNQsd1DufZduF4VD4/izMTs
 zAk1jVHHatx3hPN1nAw==
X-Proofpoint-GUID: aO6dNaMkLuOQpp7-zHDQ5IN9Nm7ZFDJW
X-Proofpoint-ORIG-GUID: aO6dNaMkLuOQpp7-zHDQ5IN9Nm7ZFDJW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

<..snip..>

On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
> void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
> +{
> +    GPtrArray *cert_path_builder;
> +    Error *err = NULL;
> +
> +    /* If cert store is already populated, then no work to do */
> +    if (cert_store->count) {
> +        return;
> +    }
> +
> +    cert_path_builder = get_cert_paths(&err);
> +    if (cert_path_builder == NULL) {
> +        error_report_err(err);
> +        exit(1);
> +    }
> +
> +    if (cert_path_builder->len == 0) {
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        return;
> +    }
> +
> +    if (cert_path_builder->len > MAX_CERTIFICATES - 1) {

I think we are off by 1 here and it should be cert_path_builder->len > 
MAX_CERTIFICATES. With this fixed

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


> +        error_report("Cert store exceeds maximum of %d certificates", MAX_CERTIFICATES);
> +        g_ptr_array_free(cert_path_builder, TRUE);
> +        exit(1);
> +    }
> +
> +    cert_store->largest_cert_size = 0;
> +    cert_store->total_bytes = 0;
> +
> +    for (int i = 0; i < cert_path_builder->len; i++) {
> +        g_autofree S390IPLCertificate *cert = init_cert(
> +                                              (char *) cert_path_builder->pdata[i],
> +                                              &err);
> +        if (!cert) {
> +            error_report_err(err);
> +            g_ptr_array_free(cert_path_builder, TRUE);
> +            exit(1);
> +        }
> +
> +        update_cert_store(cert_store, cert);
> +    }
> +
> +    g_ptr_array_free(cert_path_builder, TRUE);
> +}

