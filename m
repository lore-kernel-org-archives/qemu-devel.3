Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC7CD26D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veHgr-00076q-Ga; Fri, 09 Jan 2026 13:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1veHgX-0006zE-P8; Fri, 09 Jan 2026 13:58:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1veHgV-0007bQ-OM; Fri, 09 Jan 2026 13:58:09 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 609AlP57014985;
 Fri, 9 Jan 2026 18:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GL9EpF
 qFaVX58LqkSnDxqTjdP5hz9ZJLmTQQDc27O8E=; b=ozRT23QInjBvOl11J4tsNp
 srWm+L4Z3VVAaaaEUowm4dTMynZCHS0os65eBE1DsNv6n+rrF+BvKbUM1CWR9s6W
 nsjFZVBagKEyVv/usijpfz2LxE0JWLd2dndSR7sR1f5bO6OmbZrsauEUKTyqkpuA
 VAPQLwMF5VtBoCG6s10IQ5bIeP+Evfe5Q7QgOohNyyzLl6q2uEcjg+Ll2dApyVT8
 zfa9CGg7rxouL8b16lVhQdOjXyN2zst4HlGoRiW+wJRFd4roxhIMWpe/8xYeAX0J
 hRsC/isNB2o8ctmEx2nghed/DgYghcrka3M9Fs24NpC7iw7eNWYTwGGMPRJ3F8iQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqn12t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 18:58:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 609HtwAE019337;
 Fri, 9 Jan 2026 18:58:02 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51pb1h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Jan 2026 18:58:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 609Iw0WT22938206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Jan 2026 18:58:01 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 954195803F;
 Fri,  9 Jan 2026 18:58:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33E4658060;
 Fri,  9 Jan 2026 18:57:59 +0000 (GMT)
Received: from [9.67.62.241] (unknown [9.67.62.241])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Jan 2026 18:57:59 +0000 (GMT)
Message-ID: <9f7fa1d5-3b70-489a-a743-80ba0bc28986@linux.ibm.com>
Date: Fri, 9 Jan 2026 13:57:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/29] hw/s390x/ipl: Create certificate store
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-5-zycai@linux.ibm.com>
 <e28e2492-5a29-4c04-b667-90d4f123acd0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <e28e2492-5a29-4c04-b667-90d4f123acd0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n0KXOa6PbofFVAA9HRpa-50-vf5enN8Y
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=69614fbb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oCK7kvAKtVny7xySQqgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n0KXOa6PbofFVAA9HRpa-50-vf5enN8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE0NSBTYWx0ZWRfX5iHEi35Un6zg
 3sL4DDk/rWcfB3MAU/WKI2ywCsNj2vVx2FYtAeYF1JjeTkRe5kUdimNkWKjsTi+bAu1rc63Xbyb
 5n5UYDHoQNsvV8wr6v40rYuyEDocA8ajClHzeAQgBbvYovwLK7wzUt1vV39Y9G/Gs9LA2QvNoxN
 GQ/lYV6nvKi0avvN3nPGfpN4z0nlXOHP6sPJXQVkxND4VEDI6B9328tXrbhJp9AzBpSq8oGsRFA
 kUvgC9oI7n9nKJtxASJAyW95pjm3XrrVkRmQhuG1zfDQcF/uX+GrKQwSflxARRZqpOPvic6lFxp
 Q9F50bh7g9Td3SJX4/cHrKB4XGMMn1aQgqsUz9Sv1fQ7CPUOMo3eNrKW/gx+C1qbPDm/CU+lzw3
 ljW2iwzxkzwXQoGyEoHCBtr+6hyzBBO2DOhXTXwnyKV0wD86H69n8YRgSK3qvi4WweNGzNTj4ki
 oliyqHpAPtZFXugWgnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601090145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Err, correction to my cut-off sentence below.  Sorry about that.

On 1/7/26 17:18, Collin Walling wrote:

[...]

>> +    for (list = path_list; list; list = list->next) {
>> +        cert_path = list->value->path;
>> +
>> +        if (g_strcmp0(cert_path, "") == 0) {
>> +            error_setg(errp, "Empty path in certificate path list is not allowed");
>> +            goto fail;
>> +        }
>> +
>> +        if (stat(cert_path, &st) != 0) {
>> +            error_setg(errp, "Failed to stat path '%s': %s",
>> +                       cert_path, g_strerror(errno));
>> +            goto fail;
>> +        }
>> +
>> +        if (S_ISREG(st.st_mode)) {
>> +            if (!g_str_has_suffix(cert_path, ".pem")) {
>> +                error_setg(errp, "Certificate file '%s' must have a .pem extension",
>> +                           cert_path);
>> +                goto fail;
>> +            }
>> +
>> +            g_ptr_array_add(cert_path_builder, g_strdup(cert_path));
>> +        } else if (S_ISDIR(st.st_mode)) {
>> +            dir = g_dir_open(cert_path, 0, &err);
>> +            if (dir == NULL) {
>> +                error_setg(errp, "Failed to open directory '%s': %s",
>> +                           cert_path, err->message);
>> +
>> +                goto fail;
>> +            }
>> +
>> +            while ((filename = g_dir_read_name(dir))) {
>> +                if (g_str_has_suffix(filename, ".pem")) {
>> +                    g_ptr_array_add(cert_path_builder,
>> +                                    g_build_filename(cert_path, filename, NULL));
>> +                }
>> +            }
>> +
>> +            g_dir_close(dir);

Does this mean that an empty directory or one that does not contain any
.pem files is allowed?  Should at least a warning message should be
printed?  Also, if a file found within the directory is not a .pem,
should that be reported as well?

Another approach is to first iterate through each directory and resolve
the path of *every file* and append them to the end of `list` ignoring
sub directories).  Throw a warn/err if empty dir.  Then continue to
iterate each file in `list`.

>> +        } else {
>> +            error_setg(errp, "Path '%s' is neither a file nor a directory", cert_path);
>> +            goto fail;
>> +        }
>> +    }
>> +
>> +    qapi_free_BootCertificatesList(path_list);
>> +    return g_steal_pointer(&cert_path_builder);
>> +
>> +fail:
>> +    qapi_free_BootCertificatesList(path_list);
>> +    return NULL;
>> +}


-- 
Regards,
  Collin

