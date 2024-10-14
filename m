Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AE4D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0L6O-0005l9-HM; Mon, 14 Oct 2024 09:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0L6L-0005kQ-Ml
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:27:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0L6J-0001S5-L6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:27:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ECrksQ001635
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 13:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 eMwWRtMHDR2tMp7lIQxe/jW0KC4bLVYXULrF29R2+yg=; b=oYnvgp4YtzFA/xM0
 dhiJpbYfjGeyI3i/S93Yob/Av67Ddcc5gxxAJUKAppCJ5kwqQznn/5xnK3DmtTPg
 OKwUzMJ1uM4blepEC6ndpGhljphkY4Xk8ZrM3z8gif609e8Qgt1+8rLzGlNIbdmx
 IZCrXNNLltOA4qXI5GqvtGUQUFdxQFE7kaRZv/6ggxx/o7WfDXRUdlzZjdFLbZXf
 yJXqLj/En2lInR+lPaNVDKJ2Xvn9bxAQ17cENQMdpc1ZmZZ+/EAUGe3MMQx342xJ
 FdZlN7Er1ufkCVmcsEr9siOO145f73isLORzM90dQNXVigw22LRPeC2h04FjfJzX
 SqIFBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4293q2g67d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 13:27:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49EDR5nM017697;
 Mon, 14 Oct 2024 13:27:05 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4293q2g67b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 13:27:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EAQ4M2006714;
 Mon, 14 Oct 2024 13:27:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283erpxqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 13:27:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49EDR32V46530938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 13:27:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D92FE58060;
 Mon, 14 Oct 2024 13:27:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA4A35805A;
 Mon, 14 Oct 2024 13:27:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 13:27:03 +0000 (GMT)
Message-ID: <f88c3517-5405-448e-8bfe-c77416ea7cb8@linux.ibm.com>
Date: Mon, 14 Oct 2024 09:27:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tpm_emulator: Read control channel response in 2
 passes
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com
References: <20241011223556.2953808-1-stefanb@linux.ibm.com>
 <20241011223556.2953808-3-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241011223556.2953808-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E2YhI2yzUtcDcBKqu0WxNEi4zSh1H4L0
X-Proofpoint-GUID: nHpJVW39WP0YGFp5cGMZKE8DdshmZDzk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=736 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/11/24 6:35 PM, Stefan Berger wrote:
> Error responses from swtpm are always only 4 bytes long. Therefore, read
> the entire response in 2 passes and stop if the first 4 bytes indicate an
> error response with no subsequent bytes readable. Read the rest in a 2nd
> pass, if needed. This avoids getting stuck while waiting for too many bytes
> if only 4 bytes were sent due to an error message. The 'getting stuck'
> condition has not been observed in practice so far, though.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2615
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_emulator.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index b0e2fb3fc7..1b2e890668 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -129,6 +129,9 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
>       uint32_t cmd_no = cpu_to_be32(cmd);
>       ssize_t n = sizeof(uint32_t) + msg_len_in;
>       uint8_t *buf = NULL;
> +    ptm_res res;
> +    off_t o = 0;
> +    int to_read;
>   
>       WITH_QEMU_LOCK_GUARD(&tpm->mutex) {
>           buf = g_alloca(n);
> @@ -140,11 +143,29 @@ static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, void *msg,
>               return -1;
>           }
>   
> -        if (msg_len_out != 0) {
> -            n = qemu_chr_fe_read_all(dev, msg, msg_len_out);
> +        /*
> +         * Any response will be at least 4 bytes long. Error responses are only
> +         * 4 bytes (=sizeof(ptm_res)), though. Therefore, read response in 2
> +         * passes, returning when an error response is encountered.
> +         */

v2: We need one exception here and that's CMD_GET_STATEBLOB since it has 
been sending a longer header since basically 'forever'.

> +        to_read = sizeof(res);
> +        while (msg_len_out > 0) {
> +            n = qemu_chr_fe_read_all(dev, (uint8_t *)msg + o, to_read);
>               if (n <= 0) {
>                   return -1;
>               }
> +            msg_len_out -= to_read;
> +            if (msg_len_out == 0) {
> +                return 0;
> +            }
> +
> +            memcpy(&res, msg, sizeof(res));
> +            if (res) {
> +                return 0;
> +            }
> +
> +            o = to_read;
> +            to_read = msg_len_out;
>           }
>       }
>   

