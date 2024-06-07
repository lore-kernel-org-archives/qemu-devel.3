Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A93C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:17:16 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbJU-0003EW-G3; Fri, 07 Jun 2024 11:15:32 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1sFbJO-0003EF-FU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:15:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1sFbJM-0002Z6-2s
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:15:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 457F7mAX015194; Fri, 7 Jun 2024 15:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=C6CWfTENGYRCmV/k7AytlZY0P1torzrbKUmdqKzOl3A=;
 b=BTkHdLrav6lJvSBh2+Qv0ArYYlMTCkWa9vDdIQp2hFN1CF39lv+lyjiWnU/+TzAk1hd1
 IquB54grmSFBeEcT5VdaOUsbbrAxH4JqLiBJFPLbyTKdQ3wthf26WKBlua8Lh/13JVfB
 JsqkSU4P/zNQVhJEseIP2aQ+yXdEc4ZrD2QB8jgmK/Yf0OVozSuadiLyF6O2Moif6g4S
 FfoJW/EKEGzRjqKVM1JbuvilTkHhdmfe5NM6sERKFdHTbfaz6DCyPPZPtGjKErytYDuK
 BZE1NRQ0V43ByC7mOnZyEYOFwDsQgbV3HFfi3tOFrWwfrA9wWPpKkjXQB1pIsDcGpfHS GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym4jp00nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 15:15:20 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 457FFJgs026065;
 Fri, 7 Jun 2024 15:15:19 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ym4jp00na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 15:15:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 457EuO3N000803; Fri, 7 Jun 2024 15:15:18 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygdyuhm71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Jun 2024 15:15:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 457FFGKT17498542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Jun 2024 15:15:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 773355807A;
 Fri,  7 Jun 2024 15:15:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47F758058;
 Fri,  7 Jun 2024 15:15:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Jun 2024 15:15:13 +0000 (GMT)
Message-ID: <b0fb7bf7-b936-4801-a637-42907a59d680@linux.ibm.com>
Date: Fri, 7 Jun 2024 11:15:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] backends/tpm: Remove newline character in trace event
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20240606103943.79116-1-philmd@linaro.org>
 <20240606103943.79116-2-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240606103943.79116-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FtWTxSRjct4Tg8-hPRZaJYzoFf5K2-dV
X-Proofpoint-ORIG-GUID: oSSSb8dCQ8I2LQ7dLWX5fdRFxIFjf94d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/6/24 06:39, Philippe Mathieu-Daudé wrote:
> Split the 'tpm_util_show_buffer' event in two to avoid
> using a newline character.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/tpm/tpm_util.c   | 5 +++--
>   backends/tpm/trace-events | 3 ++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index 1856589c3b..cf138551df 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -339,10 +339,11 @@ void tpm_util_show_buffer(const unsigned char *buffer,
>       size_t len, i;
>       char *line_buffer, *p;
> 
> -    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
> +    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER_CONTENT)) {
>           return;
>       }
>       len = MIN(tpm_cmd_get_size(buffer), buffer_size);
> +    trace_tpm_util_show_buffer_header(string, len);
> 
>       /*
>        * allocate enough room for 3 chars per buffer entry plus a
> @@ -356,7 +357,7 @@ void tpm_util_show_buffer(const unsigned char *buffer,
>           }
>           p += sprintf(p, "%.2X ", buffer[i]);
>       }
> -    trace_tpm_util_show_buffer(string, len, line_buffer);
> +    trace_tpm_util_show_buffer_content(line_buffer);
> 
>       g_free(line_buffer);
>   }
> diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
> index 1ecef42a07..cb5cfa6510 100644
> --- a/backends/tpm/trace-events
> +++ b/backends/tpm/trace-events
> @@ -10,7 +10,8 @@ tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->len = %u,
>   tpm_util_get_buffer_size_hdr_len2(uint32_t len, size_t expected) "tpm2_resp->hdr.len = %u, expected = %zu"
>   tpm_util_get_buffer_size_len2(uint32_t len, size_t expected) "tpm2_resp->len = %u, expected = %zu"
>   tpm_util_get_buffer_size(size_t len) "buffersize of device: %zu"
> -tpm_util_show_buffer(const char *direction, size_t len, const char *buf) "direction: %s len: %zu\n%s"
> +tpm_util_show_buffer_header(const char *direction, size_t len) "direction: %s len: %zu"
> +tpm_util_show_buffer_content(const char *buf) "%s"
> 
>   # tpm_emulator.c
>   tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

