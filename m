Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96693EE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCkf-00039l-2h; Tue, 10 Sep 2024 22:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1soCkc-00038h-Sa
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:06:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1soCka-0000gO-P3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:06:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEhwu9023785;
 Wed, 11 Sep 2024 02:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gOyZAa7mqyOulDwtgkSvzl8RqxVpG52gJgOqat7KzU0=; b=G38gmK7LXAvbCZhj
 CRmNxgKwQcDLv/xehmf9QcMaVOTnaA4M2xC6/RNigay9Y59oTT4HWPUmykJCduCX
 mXPzBP0PPBlAGzdy92qjYPCH8npoKdc4lFxH934FGuxt+RYd2jEO/k9AX1c9fa/J
 XDVw+IzCz8qIUMnXMoktJjFtFwhZRD/SlCaGgGvVl8Fnqnh8nN9osv9Z7HCRv9Js
 D5xeRdjqzWGeYr2eg3Gp3EhQobUig23vNrw3w5x/avfNf4tjRaEhlkA/30cKvVXz
 V71cDAzjgq6lbyqUJUD2vQeWwYjcjQIl70Ws1IXmpg/eS0ptA61wAOq+14vHdQ2p
 kZQW7A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6p7xux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 02:06:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B26LLU026474
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2024 02:06:21 GMT
Received: from [10.110.112.8] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Sep
 2024 19:06:20 -0700
Message-ID: <ce4daa98-0b3c-426d-95e0-59320eb29be8@quicinc.com>
Date: Tue, 10 Sep 2024 21:06:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/qemu_test: Use Python hashlib instead of
 external programs
To: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20240910201742.239559-1-thuth@redhat.com>
 <1823ff97-b305-453b-b3a6-b24cc1987002@comstyle.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <1823ff97-b305-453b-b3a6-b24cc1987002@comstyle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: zs7TwOxrxOrByV9-Ic0H0K2wqtI7s-HF
X-Proofpoint-GUID: zs7TwOxrxOrByV9-Ic0H0K2wqtI7s-HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=810 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110015
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 9/10/2024 5:26 PM, Brad Smith wrote:
> On 2024-09-10 4:17 p.m., Thomas Huth wrote:
>> Some systems (like OpenBSD) do not have the sha256sum or sha512sum 
>> programs
>> installed by default. Use the Python hashlib instead so we don't have to
>> rely on the external programs.
>
> On OpenBSD they're named sha256 and sha512.
>
Rather than port the test to each OS's particular program names, we 
should use the portable solution that's included w/Python.

>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---


Reviewed-by: Brian Cain <bcain@quicinc.com>

>>   tests/functional/qemu_test/asset.py | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/functional/qemu_test/asset.py 
>> b/tests/functional/qemu_test/asset.py
>> index d3be2aff82..3ec429217e 100644
>> --- a/tests/functional/qemu_test/asset.py
>> +++ b/tests/functional/qemu_test/asset.py
>> @@ -43,15 +43,21 @@ def _check(self, cache_file):
>>           if self.hash is None:
>>               return True
>>           if len(self.hash) == 64:
>> -            sum_prog = 'sha256sum'
>> +            hl = hashlib.sha256()
>>           elif len(self.hash) == 128:
>> -            sum_prog = 'sha512sum'
>> +            hl = hashlib.sha512()
>>           else:
>>               raise Exception("unknown hash type")
>>   -        checksum = subprocess.check_output(
>> -            [sum_prog, str(cache_file)]).split()[0]
>> -        return self.hash == checksum.decode("utf-8")
>> +        # Calculate the hash of the file:
>> +        with open(cache_file, 'rb') as file:
>> +            while True:
>> +                chunk = file.read(1 << 20)
>> +                if not chunk:
>> +                    break
>> +                hl.update(chunk)
>> +
>> +        return  hl.hexdigest()
>>         def valid(self):
>>           return self.cache_file.exists() and 
>> self._check(self.cache_file)
>

