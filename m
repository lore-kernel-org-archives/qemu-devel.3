Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AF6FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5sF-0005Wg-Qd; Wed, 29 Apr 2026 10:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI5s8-0005WS-3y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:26:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI5s5-0003Pw-VX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:26:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TBe7Bu3687580; Wed, 29 Apr 2026 14:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3cm18s
 sFXL6ZOsd3CEhC3VWk352lIBOoYXV2K9KGCb4=; b=PTrFoxRGGyeyXF272tOFna
 EY3mH3mMl8hPDxp6fG1iy1b8qkniOrOdLMCFek4TwJmvGEY0WmNAq9B+RRxp0jSd
 QB95iEwB0vb5JJTmpnx2tKlJuabl6yv5c81Ge8uxiCjatHjyzQuEf35ukZZEnDdT
 7CzUF9/mOxc7PvK7BoeSPpiYsPPxOZpcCjrXuknrlpx6qNzqI9Ffst5f4S+Db95D
 8af2vAl9PcqDqgmxFfSj4pPgI760NkaABRxuHEFnR1J02JeKUnq4L6PBPXTzzCfO
 7nZro0BbyijN9csj74cxlIvu19HWoWcIwWzkp0uTK773m6xD6Y5YivOfs495z4hw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e1gx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 14:26:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TENojq008047;
 Wed, 29 Apr 2026 14:26:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk6n0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 14:26:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TEQQEw6095434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 14:26:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 383C158054;
 Wed, 29 Apr 2026 14:26:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D16A5804E;
 Wed, 29 Apr 2026 14:26:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 14:26:24 +0000 (GMT)
Message-ID: <a0ae9f3e-3124-42c4-937a-bbf23e7d6625@linux.ibm.com>
Date: Wed, 29 Apr 2026 10:26:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] test/qtest: Add test for tpm crb chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-6-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260422103018.123608-6-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: N3_EjlmBK9Qi_iuPeQ3yrMLTN7nv4TYe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0NSBTYWx0ZWRfX26LQPRxQNA4a
 WHsF99SsnUXuvhtO1Cs+X5ms1fLTT/l6pH3YaWEB58HbkwKgLqoId/gYfHhzH9wr2FY2SFZD/uc
 92rDli64RXW2obgoixaAH23WAHtXMFhe30tZCj7Jf98Zz0CXm/Lu3xFvt1UTRQFqDivV+Yy9GBi
 db+3wb/iKqOb3fsVZ87y6kNpyR9CPe4sv2ULh2vINVKxtAJ6gCDvTsSVgncfRjfmOu3yRg4gxL9
 TNTB8swTbNVTCSXbaubSc8LAt972OhJk3V85l/JhIL4lzDg2Iu6/nZQMmV14NE2USNm8TrBySAa
 Xg8zAe91KjWXpCSRXtBZLDugQiPOpXhwkdmEhuWgw3b/sbVq4P2hhrtDPyNe7mEzIP+gzZeHBNL
 ZaNBeWHXfnHfpk/11bHEiEr0eqH33qxp09bf8SqLpqstJKHeZcTQSAnMPzryC0YplG7gVc3Veyb
 ihETgJhvoazWD2vC3Cg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f21513 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=WVLlgutBtSRJ_CmmLvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2nZ1B1XOcuCGDKSZw2l77U-DLn_iBPS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 4/22/26 6:30 AM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> - New test case added to the swtpm test. Data is written and read from
>    the buffer in chunks.
> - The chunk size is dynamically calculated by reading the
>    CRB_CTRL_CMD_SIZE address. This can be changed manually to test.
> - Add a helper function tpm_wait_till_bit_clear()
> - Note that this commit does not yet exercise the chunked read/write
>    logic, as current transfer sizes remain small. Testing for large
>    transfers is introduced in a subsequent patch: 'tests: Use ML-DSA-87
>    operations to cause large TPM transfers with CRB'
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/tpm-crb-swtpm-test.c |  10 +++
>   tests/qtest/tpm-util.c           | 110 ++++++++++++++++++++++++++-----
>   tests/qtest/tpm-util.h           |   5 ++
>   3 files changed, 110 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qtest/tpm-crb-swtpm-test.c b/tests/qtest/tpm-crb-swtpm-test.c
> index ffeb1c396b..050c7b0c1f 100644
> --- a/tests/qtest/tpm-crb-swtpm-test.c
> +++ b/tests/qtest/tpm-crb-swtpm-test.c
> @@ -33,6 +33,14 @@ static void tpm_crb_swtpm_test(const void *data)
>                           "tpm-crb", NULL);
>   }
>   
> +static void tpm_crb_chunk_swtpm_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_chunk_transfer,
> +                        "tpm-crb", NULL);
> +}
> +
>   static void tpm_crb_swtpm_migration_test(const void *data)
>   {
>       const TestState *ts = data;
> @@ -54,6 +62,8 @@ int main(int argc, char **argv)
>       g_test_init(&argc, &argv, NULL);
>   
>       qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
> +    qtest_add_data_func("/tpm/crb-chunk-swtpm/test", &ts,
> +                        tpm_crb_chunk_swtpm_test);
>       qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
>                           tpm_crb_swtpm_migration_test);
>       ret = g_test_run();
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd4796..744592763f 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -14,16 +14,44 @@
>   
>   #include "qemu/osdep.h"
>   #include <glib/gstdio.h>
> +#include "qemu/bswap.h"
>   
>   #include "hw/acpi/tpm.h"
>   #include "libqtest.h"
>   #include "tpm-util.h"
>   #include "qobject/qdict.h"
>   
> +#define CRB_ADDR_START (TPM_CRB_ADDR_BASE + A_CRB_CTRL_START)
> +#define CRB_ADDR_CTRL_STS (TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS)
> +#define CRB_ADDR_CTRL_CMD_SIZE \
> +    (TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE)
> +
> +#define CRB_START_INVOKE  (1 << 0)
> +#define CRB_START_RSP_RETRY (1 << 1)
> +#define CRB_START_NEXT_CHUNK (1 << 2)
> +
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask)
> +{
> +    uint32_t sts;
> +    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> +
> +    while (true) {
> +        sts = qtest_readl(s, addr);
> +        if ((sts & mask) == 0) {
> +            break;
> +        }
> +        if (g_get_monotonic_time() >= end_time) {
> +            g_assert_cmphex(sts & mask, ==, 0);
> +            break;
> +        }
> +    }
> +}
> +
>   void tpm_util_crb_transfer(QTestState *s,
>                              const unsigned char *req, size_t req_size,
>                              unsigned char *rsp, size_t rsp_size)
>   {
> +    uint32_t tpm_sts;
>       uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
>       uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
>   
> @@ -31,24 +59,76 @@ void tpm_util_crb_transfer(QTestState *s,
>   
>       qtest_memwrite(s, caddr, req, req_size);
>   
> -    uint32_t sts, start = 1;
> -    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
> -    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
> -    while (true) {
> -        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -        if ((start & 1) == 0) {
> -            break;
> +    qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> +    tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
> +
> +    tpm_sts = qtest_readl(s, CRB_ADDR_CTRL_STS);
> +    g_assert_cmpint(tpm_sts & 1, ==, 0);
> +
> +    qtest_memread(s, raddr, rsp, rsp_size);
> +}
> +
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_size,
> +                                 unsigned char *rsp, size_t rsp_size)
> +{
> +    uint32_t tpm_sts;
> +    size_t chunk_size;
> +
> +    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
> +    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
> +    uint32_t crb_ctrl_cmd_size = qtest_readl(s, CRB_ADDR_CTRL_CMD_SIZE);
> +
> +    chunk_size = crb_ctrl_cmd_size;
> +
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
> +    for (size_t i = 0; i < req_size; i += chunk_size) {
> +        bool last_chunk = false;
> +        size_t current_chunk_size = chunk_size;
> +
> +        if (i + chunk_size > req_size) {
> +            last_chunk = true;
> +            current_chunk_size = req_size - i;
>           }
> -        if (g_get_monotonic_time() >= end_time) {
> -            break;
> +
> +        qtest_memwrite(s, caddr, req + i, current_chunk_size);
> +
> +        if (last_chunk) {
> +            qtest_writel(s, CRB_ADDR_START, CRB_START_INVOKE);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_INVOKE);
> +        } else {
> +            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
>           }
> -    };
> -    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
> -    g_assert_cmpint(start & 1, ==, 0);
> -    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
> -    g_assert_cmpint(sts & 1, ==, 0);
> +    }
> +    tpm_sts = qtest_readl(s, CRB_ADDR_CTRL_STS);
> +    g_assert_cmpint(tpm_sts & 1, ==, 0);
>   
> -    qtest_memread(s, raddr, rsp, rsp_size);
> +    /*
> +     * Read response in chunks
> +     */
> +
> +    unsigned char header[10];
> +    uint32_t actual_response_size = 0;
> +
> +    qtest_memread(s, raddr, header, sizeof(header));
> +    actual_response_size = ldl_be_p(&header[2]);
> +
> +    if (actual_response_size > rsp_size) {
> +        actual_response_size = rsp_size;
> +    }
> +
> +    for (size_t i = 0; i < actual_response_size; i += chunk_size) {
> +        size_t to_read = i + chunk_size > actual_response_size
> +                       ? actual_response_size - i
> +                       : chunk_size;
> +        if (i > 0) {
> +            qtest_writel(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
> +            tpm_wait_till_bit_clear(s, CRB_ADDR_START, CRB_START_NEXT_CHUNK);
> +        }
> +        qtest_memread(s, raddr, rsp + i, to_read);
> +    }
>   }
>   
>   void tpm_util_startup(QTestState *s, tx_func *tx)
> diff --git a/tests/qtest/tpm-util.h b/tests/qtest/tpm-util.h
> index 0cb28dd6e5..681544e7d8 100644
> --- a/tests/qtest/tpm-util.h
> +++ b/tests/qtest/tpm-util.h
> @@ -24,10 +24,15 @@ typedef void (tx_func)(QTestState *s,
>                          const unsigned char *req, size_t req_size,
>                          unsigned char *rsp, size_t rsp_size);
>   
> +void tpm_wait_till_bit_clear(QTestState *s, uint64_t addr, uint32_t mask);
>   void tpm_util_crb_transfer(QTestState *s,
>                              const unsigned char *req, size_t req_size,
>                              unsigned char *rsp, size_t rsp_size);
>   
> +void tpm_util_crb_chunk_transfer(QTestState *s,
> +                                 const unsigned char *req, size_t req_size,
> +                                 unsigned char *rsp, size_t rsp_size);
> +
>   void tpm_util_startup(QTestState *s, tx_func *tx);
>   void tpm_util_pcrextend(QTestState *s, tx_func *tx);
>   void tpm_util_pcrread(QTestState *s, tx_func *tx,


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


