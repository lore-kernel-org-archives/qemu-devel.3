Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631EFC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZ8T-00054K-9O; Fri, 06 Jun 2025 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNZ8R-000547-4R
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:37:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNZ8P-0001R9-8E
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:37:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556EDaAH011152;
 Fri, 6 Jun 2025 15:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WZi9OY
 XSD/cZHqJbinupZ3/HwwqyX74Y7sJxMQt0ldw=; b=WOKez6aTQZP0skLkZQwMtS
 39DBlOvTF2F6OxvL7quXn4keIL01EOJ0CqEQQsyZsdLDbl+hvBFXHEK6TZpvy+Nj
 A0KNqCArCEn0+TSiXMaDrfhENQCypTQXmFTmAB0vJS7LNW0uUhH0/FDEU+R42+r0
 3NEvzb2Wn1BR+Dr+nIX3ZRA0DS8DzrL1V2ezcrSNatc7Uka7GVIWqOJQ4Wrq0uUJ
 7d+1Gf12CCm/k6RgJYJ/cT8escsS+/SUYYIQaIhhWZXTgnogD1DB4ND/7/ThHAKm
 K2ZvGMuGKjAdGxdf0a5t6V0Q8vthY4v5/Ad+jtnewEwmJ4uc4JR+0b+H6xWFSfgA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf07102-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 15:37:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556FEeUg022550;
 Fri, 6 Jun 2025 15:37:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tt95d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 15:37:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556FbPY148890204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 15:37:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D646F58063;
 Fri,  6 Jun 2025 15:37:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ADB058055;
 Fri,  6 Jun 2025 15:37:29 +0000 (GMT)
Received: from [9.61.255.24] (unknown [9.61.255.24])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 15:37:29 +0000 (GMT)
Message-ID: <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
Date: Fri, 6 Jun 2025 10:37:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: Steven Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0E3XCpJ4GLiYTnxPIFYMN2iET_wpvRhu
X-Proofpoint-ORIG-GUID: 0E3XCpJ4GLiYTnxPIFYMN2iET_wpvRhu
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=68430b3b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=ZRWfNBs9nIcWNDPEzxEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzNyBTYWx0ZWRfXyuYtOHkMMu/M
 9eimDncrengXMwT63HXmf7tWjm2MQ5WXlLOiZeAYxNMCpQihz+Lb9Mbt3KZgMmoIrwTIM8/pI0X
 UH/7qLjwk3WUIK4QX0oeqvHaOIXdPcnsmrmDHss6OkWQXXG+l8RiBMZ7uLgGaRRnYlGt35mdSMh
 Upz8Cix9u51bJ/berkMU3nF97iJKuxKQgCTUPRRmjfHLvb/F06IG3Fe2LPk/tRJdRcTWlZfta57
 yYymha0QZXzr1LDFHioHlhxuS8bfKGylY0ZrMxH6BSiHPlwz5uD4h7+CMgD6qfQJiT4mQzuV7BG
 t19tFeN4IYNH3QJ2MvFUkfQGqjNLLaTfXgDcoyPgk1OIWoTTOd7u9sYPL865P35XIlwrxUR58hW
 477FZ7j4k681xuzFjwHCb19IjSWW4veeEx5AQsKvXr+6NzfHMh/LIDC7Ty1fzW9+V/THb5D3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060137
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 6/6/2025 10:12 AM, Steven Sistare wrote:
> On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
>> On 6/6/2025 9:14 AM, Steven Sistare wrote:
>>> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>>>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>>>> When the source VM attempts to connect to the destination VM's Unix
>>>>> domain socket(cpr.sock) during CPR transfer, the socket file might 
>>>>> not
>>>>> yet be exist if the destination side hasn't completed the bind
>>>>> operation. This can lead to connection failures when running tests 
>>>>> with
>>>>> the qtest framework.
>>>>
>>>> This sounds like a flawed test impl to me - whatever is initiating
>>>> the cpr operation on the source has done so prematurely - it should
>>>> ensure the dest is ready before starting the operation.
>>>>
>>>>> To address this, add cpr_validate_socket_path(), which wait for the
>>>>> socket file to appear. This avoids intermittent qtest failures 
>>>>> caused by
>>>>> early connection attempts.
>>>>
>>>> IMHO it is dubious to special case cpr in this way.
>>>
>>> I agree with Daniel, and unfortunately it is not just a test issue;
>>> every management framework that supports cpr-transfer must add logic to
>>> wait for the cpr socket to appear in the target before proceeding.
>>>
>>> This is analogous to waiting for the monitor socket to appear before
>>> connecting to it.
>>>
>>> - Steve
>>
>> Thank you very much for your valuable review and feedback.
>>
>> Just to clarify, the added cpr_validate_socket_path() function is not 
>> limited to the test framework.
>> It is part of the actual CPR implementation and is intended to ensure 
>> correct behavior in all cases, including outside of tests.
>>
>> I mentioned the qtest failure simply as an example where this issue 
>> became apparent.
>
> Yes, I understand that you understand :)
> Are you willing to move your fix to the qtest?
>
> - Steve

Thank you for your question and feedback.

I agree that the issue could be addressed within the qtest framework to 
improve stability.

However, this socket readiness check is a fundamental part of CPR 
transfer process,
and I believe that incorporating cpr_validate_socket_path() directly 
into the CPR implementation helps ensure more reliable behavior
across all environments - not only during testing.

Just from my perspective, adding this logic to the CPR code does not 
introduce significant overhead or side effects.
I would appreciate if you could share more details about your concerns, 
so I can better address them.

- Jaehoon Kim

>
>>>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>>>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>>> ---
>>>>>   include/migration/cpr.h  |  1 +
>>>>>   migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>>> index 7561fc75ad..cc9384b4f9 100644
>>>>> --- a/include/migration/cpr.h
>>>>> +++ b/include/migration/cpr.h
>>>>> @@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
>>>>>   void cpr_set_incoming_mode(MigMode mode);
>>>>>   bool cpr_is_incoming(void);
>>>>>   +bool cpr_validate_socket_path(const char *path, Error **errp);
>>>>>   int cpr_state_save(MigrationChannel *channel, Error **errp);
>>>>>   int cpr_state_load(MigrationChannel *channel, Error **errp);
>>>>>   void cpr_state_close(void);
>>>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>>>> index e1f140359c..3088ed323f 100644
>>>>> --- a/migration/cpr-transfer.c
>>>>> +++ b/migration/cpr-transfer.c
>>>>> @@ -17,6 +17,33 @@
>>>>>   #include "migration/vmstate.h"
>>>>>   #include "trace.h"
>>>>>   +#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
>>>>> +#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
>>>>> +
>>>>> +bool cpr_validate_socket_path(const char *path, Error **errp)
>>>>> +{
>>>>> +    struct stat st;
>>>>> +    int retries = CPR_MAX_RETRIES;
>>>>> +
>>>>> +    do {
>>>>> +        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
>>>>> +            return true;
>>>>> +        }
>>>>> +
>>>>> +        if (errno == ENOENT) {
>>>>> +            usleep(CPR_RETRY_DELAY_US);
>>>>> +        } else {
>>>>> +            error_setg_errno(errp, errno,
>>>>> +                "Unable to check status of socket path '%s'", path);
>>>>> +            return false;
>>>>> +        }
>>>>> +    } while (--retries > 0);
>>>>> +
>>>>> +    error_setg(errp, "Socket path '%s' not found after %d retries",
>>>>> +                                            path, CPR_MAX_RETRIES);
>>>>> +    return false;
>>>>> +}
>>>>> +
>>>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error 
>>>>> **errp)
>>>>>   {
>>>>>       MigrationAddress *addr = channel->addr;
>>>>> @@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel 
>>>>> *channel, Error **errp)
>>>>>           QIOChannel *ioc = QIO_CHANNEL(sioc);
>>>>>           SocketAddress *saddr = &addr->u.socket;
>>>>>   +        /*
>>>>> +         * Verify that the cpr.sock Unix domain socket file 
>>>>> exists and is ready
>>>>> +         * before proceeding with the connection.
>>>>> +         */
>>>>> +        if 
>>>>> (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, errp)) {
>>>>> +            return NULL;
>>>>> +        }
>>>>> +
>>>>>           if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 
>>>>> 0) {
>>>>>               return NULL;
>>>>>           }
>>>>> -- 
>>>>> 2.49.0
>>>>>
>>>>>
>>>>
>>>> With regards,
>>>> Daniel
>>>
>>>
>

