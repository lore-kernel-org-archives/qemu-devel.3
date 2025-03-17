Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC3CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuEMe-0001IB-Ne; Mon, 17 Mar 2025 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tuEMd-0001GK-3J; Mon, 17 Mar 2025 13:34:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tuEMb-0003Cc-4L; Mon, 17 Mar 2025 13:34:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HDaBpO022408;
 Mon, 17 Mar 2025 17:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qMSZsj
 M8PDii/CB/cT00mA7mQkpn7N+TSizIPBy+79I=; b=c6i1dbqdtgdTN/GCei61TX
 UDkI9LrVUY76HGyUbbXd7rVsW0ydaae4u43HMQVZx0mOsJ2wfuNlJCsfPZP4+AZ5
 s6JHxNEmA4eVok8cQ3Fc1opTnjzpeEYHq5nRDoEahGAlpifjsPtJIzMBBk5bfs2Y
 CtOPUslU0O6rcwM5kQ0EN9qT8NheXqyiRLxfmDI4RRdAX0zWBt5sT3EMzHnWk1AJ
 08AJw58dcm6a7D0d0oCOnxGbcEuETbiCvgAOZc1GgLucH80rwsXQb/cTWciH6w9o
 UZfHSqV6UP+MvvVHflVh2A/yAlwApTJr3YaAAPEMIQ0JjQopZoA3kB1Q/QSziFBg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks99ncf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 17:34:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HHGXZc017663;
 Mon, 17 Mar 2025 17:34:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks99ncb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 17:34:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HHCufQ005738;
 Mon, 17 Mar 2025 17:34:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk274y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 17:34:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52HHYmj656885624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 17:34:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0D2E2004B;
 Mon, 17 Mar 2025 17:34:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC39D20040;
 Mon, 17 Mar 2025 17:34:45 +0000 (GMT)
Received: from [9.124.210.193] (unknown [9.124.210.193])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Mar 2025 17:34:45 +0000 (GMT)
Message-ID: <739b2170-ab00-4ee3-9d58-c3049d3cad5c@linux.ibm.com>
Date: Mon, 17 Mar 2025 23:04:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/functional: Add test for fadump in PSeries
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
 <20250315064636.611714-9-adityag@linux.ibm.com>
 <8dad5654-6d0a-4045-abb1-2dee489f3102@redhat.com>
 <9eaf6719-ce8f-4d38-8ae3-b23506d69fe2@linux.ibm.com>
 <8c5b08fb-de96-410d-9490-3e971f914c43@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <8c5b08fb-de96-410d-9490-3e971f914c43@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qaBbyhjGc0thGgIzuNPA6-gsbvCobPA5
X-Proofpoint-ORIG-GUID: et-Mkd8hu8lIW0Kn0gtfC2jDHsZzBMD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/03/25 12:30, Thomas Huth wrote:

> On 17/03/2025 07.51, Aditya Gupta wrote:
>> Hi Thomas,
>>
>> <...snip...>
>>>> +    def test_fadump_pseries_kvm(self):
>>>> +        """
>>>> +        Test Fadump in PSeries with KVM accel
>>>> +        """
>>>> +        self.do_test_fadump(is_kvm=True, is_powernv=False)
>>>> +
>>>> +if __name__ == '__main__':
>>>> +    if os.getenv("DEBUG"):
>>>> +        logging.basicConfig(level=logging.DEBUG)
>>>
>>> The setUp function in QemuSystemTest already sets the log level to 
>>> DEBUG, so this should not be necessary?
>>>
>> I did that to see the QEMU VM booting logs. I see in QemuSystemTest, 
>> it sets the log level of some loggers to DEBUG, don't know if it's 
>> the same, as I didn't see the boot logs during testing (also, in 
>> QemuSystemTest, we are setting specific loggers to DEBUG, while I did 
>> .basicConfig to DEBUG which I think is like a global debug level 
>> setting)
>>
>> How do I get the system booting logs in `make check` ? I didn't find 
>> it in the docs.
>
> The log files should get written to 
> tests/functional/ppc64/test_ppc64_fadump.* - main log file is 
> base.log, and the console output should go into console.log. Can you 
> spot there the information you were looking for?
Yes, found them, thanks !

For me, the full path was 
'<QEMU_SRC>/build/test_ppc64_fadump.QEMUFadump.test_fadump_pseries/console.log'


>
> Anyway, that information is missing in the docs indeed ... I'll try to 
> come up with a patch when I got some spare time for it.
>

Thanks, also while you make change can you also add the 'build/' folder 
at start of the path you mentioned. That might be good, I was searching 
for the files in <QEMU_SRC>/tests/functional directory.


Thanks,

- Aditya G

>  Thomas
>

