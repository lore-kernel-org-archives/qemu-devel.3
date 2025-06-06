Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528F3C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYeE-0004A9-1w; Fri, 06 Jun 2025 11:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNYe7-00049G-9B
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:06:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNYdz-00066M-Hl
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:06:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556E0fHY032426;
 Fri, 6 Jun 2025 15:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IHGQzE
 aNz/ouWt8OdkorbVEx5QEVjrGPOKq/DMtfkjk=; b=h2//RPeY40rdKuZXuALmAg
 M4mqA0kyAVTdKIFuPl9ZlfHBUP2/jJx3jv0VoG6qv8c7xeMVasPE6TxWRCyirlZZ
 adhTf8DMgd8pvhPHO9Cv1uwH8OiMHVstZRObKY8jA7/Vng298UbzT4prvRTGMwaj
 IUN+IZOcsjnsNa89vg+nbyDSKE7lie5ErPK6XihighaR/M0Hc2VThjsEtiROh+Cd
 xaMvYE4nPY1Zu5awAv1Ko01WxovVIB6H/GwAl5xsR2av7lyWDVVdTQDVkYzxVPAt
 G8Vn+p9fDLGx9HLOs+3ye62iEBkZaD6Rrl4uibdIk371nY0IiFQOQS8Vm3517p6w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y49jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 15:06:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556BpPe1022569;
 Fri, 6 Jun 2025 15:06:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tt5m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 15:06:04 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556F63AF28508680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 15:06:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7F3B58055;
 Fri,  6 Jun 2025 15:06:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E8A85804B;
 Fri,  6 Jun 2025 15:06:03 +0000 (GMT)
Received: from [9.61.255.24] (unknown [9.61.255.24])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 15:06:03 +0000 (GMT)
Message-ID: <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
Date: Fri, 6 Jun 2025 10:06:02 -0500
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
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Nezm13D4 c=1 sm=1 tr=0 ts=684303dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Ln4hQe_N6IWAe5r7zdsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sM1-MSgYyRRCzfDZzv9rD-9DyQdbxoJF
X-Proofpoint-ORIG-GUID: sM1-MSgYyRRCzfDZzv9rD-9DyQdbxoJF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEzMiBTYWx0ZWRfXyX9ub6i/nebK
 /Kl1bIGmNkrU1Q1wC5Hx2UrZ620PMeiwkdANZvzM+HMWCu1LhIBO39JY75wSW575eslCMZyeutY
 ku7HcMzZrTUutQvUjr3fGhe9Ta9gh0SEX8eaBxdGaiIIhMFIhko77M0QdkVHy4pdUy3VT7ixuM9
 ZWEQ9CMbcWGEq9vykncJ6tubhHHPM7GEKVrqJIeOYO/YIF96c1kUNNNFo9jSAiPLUGuIQJ5RT4z
 nEDYmNo1UwREbJ8gW6ESWmGG8NecyAwcf2YmsBKMF7iq+gillAe/8ylRjO9l6UaXt+XfXUZYwB+
 mVL/EPDW4ZHU69sKZXW2E/Nv2xUW4KWVanFcIvCG5kYjKmkRCicSfY/R9OjZLcEq/E4yWrc94xF
 kLJvobbR3O8RVXizpRnn8ar0zf2dfEEdbuosiqDyZWTrvThZ2fBuyBmi0N9/EOWfUtmmH4z/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 6/6/2025 9:14 AM, Steven Sistare wrote:
> On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
>> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>>> When the source VM attempts to connect to the destination VM's Unix
>>> domain socket(cpr.sock) during CPR transfer, the socket file might not
>>> yet be exist if the destination side hasn't completed the bind
>>> operation. This can lead to connection failures when running tests with
>>> the qtest framework.
>>
>> This sounds like a flawed test impl to me - whatever is initiating
>> the cpr operation on the source has done so prematurely - it should
>> ensure the dest is ready before starting the operation.
>>
>>> To address this, add cpr_validate_socket_path(), which wait for the
>>> socket file to appear. This avoids intermittent qtest failures 
>>> caused by
>>> early connection attempts.
>>
>> IMHO it is dubious to special case cpr in this way.
>
> I agree with Daniel, and unfortunately it is not just a test issue;
> every management framework that supports cpr-transfer must add logic to
> wait for the cpr socket to appear in the target before proceeding.
>
> This is analogous to waiting for the monitor socket to appear before
> connecting to it.
>
> - Steve

Thank you very much for your valuable review and feedback.

Just to clarify, the added cpr_validate_socket_path() function is not 
limited to the test framework.
It is part of the actual CPR implementation and is intended to ensure 
correct behavior in all cases, including outside of tests.

I mentioned the qtest failure simply as an example where this issue 
became apparent.

-Jaehoon Kim
>>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> ---
>>>   include/migration/cpr.h  |  1 +
>>>   migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
>>>   2 files changed, 36 insertions(+)
>>>
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index 7561fc75ad..cc9384b4f9 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
>>>   void cpr_set_incoming_mode(MigMode mode);
>>>   bool cpr_is_incoming(void);
>>>   +bool cpr_validate_socket_path(const char *path, Error **errp);
>>>   int cpr_state_save(MigrationChannel *channel, Error **errp);
>>>   int cpr_state_load(MigrationChannel *channel, Error **errp);
>>>   void cpr_state_close(void);
>>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>>> index e1f140359c..3088ed323f 100644
>>> --- a/migration/cpr-transfer.c
>>> +++ b/migration/cpr-transfer.c
>>> @@ -17,6 +17,33 @@
>>>   #include "migration/vmstate.h"
>>>   #include "trace.h"
>>>   +#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
>>> +#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
>>> +
>>> +bool cpr_validate_socket_path(const char *path, Error **errp)
>>> +{
>>> +    struct stat st;
>>> +    int retries = CPR_MAX_RETRIES;
>>> +
>>> +    do {
>>> +        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
>>> +            return true;
>>> +        }
>>> +
>>> +        if (errno == ENOENT) {
>>> +            usleep(CPR_RETRY_DELAY_US);
>>> +        } else {
>>> +            error_setg_errno(errp, errno,
>>> +                "Unable to check status of socket path '%s'", path);
>>> +            return false;
>>> +        }
>>> +    } while (--retries > 0);
>>> +
>>> +    error_setg(errp, "Socket path '%s' not found after %d retries",
>>> +                                            path, CPR_MAX_RETRIES);
>>> +    return false;
>>> +}
>>> +
>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error 
>>> **errp)
>>>   {
>>>       MigrationAddress *addr = channel->addr;
>>> @@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel 
>>> *channel, Error **errp)
>>>           QIOChannel *ioc = QIO_CHANNEL(sioc);
>>>           SocketAddress *saddr = &addr->u.socket;
>>>   +        /*
>>> +         * Verify that the cpr.sock Unix domain socket file exists 
>>> and is ready
>>> +         * before proceeding with the connection.
>>> +         */
>>> +        if (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, 
>>> errp)) {
>>> +            return NULL;
>>> +        }
>>> +
>>>           if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
>>>               return NULL;
>>>           }
>>> -- 
>>> 2.49.0
>>>
>>>
>>
>> With regards,
>> Daniel
>
>

