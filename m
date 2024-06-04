Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3DBC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 16:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEX4z-00016k-Hi; Tue, 04 Jun 2024 12:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sEX4w-00010u-69; Tue, 04 Jun 2024 12:32:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sEX4t-0006M6-2R; Tue, 04 Jun 2024 12:32:05 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 454GPl9A020363; Tue, 4 Jun 2024 16:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=2UILuxlCh3W8dTgAuk3RkR8ps0I4r0Fr8UE+gz7M34Q=;
 b=jp6XNWzVUZC6gpueouFfMe71+UV2NGCxm2EPxqGYRWJn7jd0iBUzwxm08dtBRLOz2UFV
 9s1jvYmGTPQK0/2O2+mm0t+amA6YRVDHw6wN7arY/UAWa5wIWhD7hI+9dlJQHPiEUEhU
 2EA43E73v/BCPCcg6VUZtPb52SbrhbYgdsiTgvskUAFAGEDRMHbextI6oBVh7XJpYdKj
 MDdahYKXGWgcS2SyEwb7b8zqxmT9kest9FucbMdVPdVzT58d4k/fnEQCYsT6yC4cK3Qu
 faEUgjKMQyWL3KhvROkD3XX8mgtTjtAO+lI4KnxvBQK7rULOK2LLxCkkymzgh1YLCfqQ PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xj03f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jun 2024 16:31:59 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454GTurq027057;
 Tue, 4 Jun 2024 16:31:58 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj5xj03f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jun 2024 16:31:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 454EFRLJ022835; Tue, 4 Jun 2024 16:27:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ygg6m6r20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jun 2024 16:27:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 454GR3WN590490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jun 2024 16:27:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACC7958043;
 Tue,  4 Jun 2024 16:27:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B61558059;
 Tue,  4 Jun 2024 16:27:03 +0000 (GMT)
Received: from [9.67.137.138] (unknown [9.67.137.138])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  4 Jun 2024 16:27:02 +0000 (GMT)
Message-ID: <baf90d34-9894-4174-8888-4ad72c9a8cbc@linux.ibm.com>
Date: Tue, 4 Jun 2024 12:27:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] s390x: Add loadparm to CcwDevice
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-3-jrossi@linux.ibm.com>
 <8240e6c8-8de1-4529-9479-73e555c1b590@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <8240e6c8-8de1-4529-9479-73e555c1b590@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IXPeFbybn0-sRDMZ5SO4YtgT8d4auOTb
X-Proofpoint-ORIG-GUID: 01BcnPRFA4vq3pJKKK15vs0tsBuyyRuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=766 malwarescore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Hi Thomas,

Firstly, thanks for the reviews and I agree with your suggestions about 
function names, info messages, simplifications, etc...  I will make 
those changes.

As for the DIAG308_FLAGS_LP_VALID flag...

> [snip...]
>> @@ -438,40 +473,20 @@ static bool s390_gen_initial_iplb(S390IPLState 
>> *ipl)
>>               break;
>>           }
>>   -        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
>> -            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
>> +        /* If the device loadparm is empty use the global machine 
>> loadparm */
>> +        if (memcmp(lp, "\0\0\0\0\0\0\0\0", 8) == 0) {
>> +            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
>>           }
>>   +        s390_ipl_set_loadparm((char *)lp, ipl->iplb.loadparm);
>> +        ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID; 
>
> That means DIAG308_FLAGS_LP_VALID is now always set, even if no 
> loadparm has been specified? Shouldn't it be omitted if the user did 
> not specify the loadparm property?

No, I don't think it should be omitted if the loadparm hasn't been 
specified because it is optional and uses a default value if not set.  
My understanding is that the flag should, actually, always be set here.

As best as I can tell, the existing check is a redundant validation that 
cannot fail and therefore is not needed. Currently the only way 
s390_ipl_set_loadparm() can return non-zero is if 
object_property_get_str() itself returns NULL pointer when getting the 
loadparm; however, the loadparm is already validated at this point 
because the string is initialized when the loadparm property is set. If 
there were a problem with the loadparm string an error would have 
already been thrown during initialization.

Furthermore, object_property_get_str() is no longer used here.  As such, 
s390_ipl_set_loadparm() is changed to a void function and the check is 
removed.

Regards,

Jared Rossi


