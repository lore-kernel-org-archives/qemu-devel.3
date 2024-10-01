Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC9CEACCE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sve04-0006w0-61; Tue, 01 Oct 2024 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svdyg-00061v-3S; Tue, 01 Oct 2024 10:36:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1svdyZ-0001m1-V2; Tue, 01 Oct 2024 10:35:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491AqeV2001220;
 Tue, 1 Oct 2024 14:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
 rQQUchNIJld8bhmehnFEP4gVjCBS71EgQW5AELT2BE=; b=k/ntstqN7uX+SMKZ3
 Y3CZwnU2nh/k827//jXGH487lnUYtFZxr0KI2JtGkujytqe2z1le8CcPPDd4BetH
 pHe6tekf5zdvbPmm+ddCKasQm4B7vFQ30vHjn4B0mBRWqDJ4lxoheXmXRRJre0vi
 /5hRkvQn+hYJ3Rk0r796PGFrIF7T9313H26oVGmJTwu8QVau81qvNz9vXgHUDyy6
 Um0Xgr6ti5JvDqzNv5ytmJqAaqQy+xToy6aXWxbRJEMiUKFRYLbCNNrOmXtQmuIp
 rJvHFt1935OJtWMm6oJ3ZFsulwbsjdk0AyuE4f/1+Bu54OZ2wjijfZOBjFJB9NnA
 XsQ2Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s816-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:35:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491EZefc002920;
 Tue, 1 Oct 2024 14:35:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420fq4s811-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:35:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CVF78013975;
 Tue, 1 Oct 2024 14:35:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk4ujq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2024 14:35:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 491EZa5K54722956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2024 14:35:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AF3820049;
 Tue,  1 Oct 2024 14:35:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB98320040;
 Tue,  1 Oct 2024 14:35:35 +0000 (GMT)
Received: from [9.171.29.251] (unknown [9.171.29.251])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2024 14:35:35 +0000 (GMT)
Message-ID: <e8dc19e7-7e46-4b10-aad4-4430c10c7b12@linux.ibm.com>
Date: Tue, 1 Oct 2024 16:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] s390x/s390-hypercall: introduce DIAG500
 STORAGE_LIMIT
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-8-david@redhat.com>
 <6636c963-228f-4bea-87c5-bd4f75521c75@redhat.com>
 <20240927200525.5a90f172.pasic@linux.ibm.com>
 <10165d22-c3e8-4db1-9874-8b63ca59afe9@linux.ibm.com>
 <20240930145712.526a1c79.pasic@linux.ibm.com>
 <972044f1-62e4-4ac0-8b24-e0bb78770309@linux.ibm.com>
 <20241001153132.08b0dca9.pasic@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20241001153132.08b0dca9.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EIXRmopc9ZPMyRg_fScy4q7eHVtBRLR_
X-Proofpoint-GUID: y7fzWI23JOzBkEUWfEY_QZEMjy5bjMit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=753 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010092
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 01.10.24 um 15:31 schrieb Halil Pasic:
> On Tue, 1 Oct 2024 11:15:02 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> [..]
>>>> So 500+4 should probably not cause any harm apart from branch prediction
>>>> going wrong the first 2 or 3 notifies.
>>>>
>>>> 502 will make kvm_s390_handle_diag larger.
>>>
>>> What do you mean by this last paragraph?
> [..]
> 
>> gcc has logic for switch statements that decide about branch table or
>> a chained compare+jump. I think due to spectre gcc now avoids indirect
>> branches as much as possible but still a larger switch statement might
>> kick the decision from inline compare/jump to a branch table.
>>
>> I am not worried in this particular case this was more or less a
>> "what could go wrong".
> 
> Hm, you did state that "502 will make kvm_s390_handle_diag larger". I
> suppose now we agree that 502 would not make kvm_s390_handle_diag larger.
> Right?
> 
> I understood that you prefer 500+4 over 502 because the latter would
> make kvm_s390_handle_diag larger. Now that we have, I hope clarified,
> that 502 would not make the switch larger, do you still prefer 500+4?
> 
> BTW your insights are very appreciated!

OK you mean that diag502 is not handled in the kernel but instead via default.
Yes you are right. So it should not matter I guess.

