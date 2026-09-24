Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0743DC98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9exx-00042e-1o; Thu, 24 Sep 2026 04:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9exs-00042P-7R; Thu, 24 Sep 2026 04:38:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9exq-0006OE-AM; Thu, 24 Sep 2026 04:37:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5bVG41334123; Thu, 24 Sep 2026 08:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XAeqei
 youwuIoJ7lNgDaiA4ge9nypKGghjXU6+IEc14=; b=iioPB0/ps97mSKNBdfl4Xo
 p2Vn6WyXRIhVaWRQGykqaD/QjSsPvlsxcXD4jXcFCwtgu4+AqcV+y0Az4DepENps
 SfaQXT6Kic0iNM5wQntknelUIs1/hFm9CMMuHARxJIDDQ6p7jmCTrYSZ8XOgUs1R
 jzKwpOU3RyntgUo3rR6CEpUfxTd2IjGpWgxvzBmgnYgf5BkFXMYPW4hMVKUPfni/
 Xe+57bjQCTZMyzcZHyqocvWnZo+9liAvdTZjTkpdwg9CGuuJEcnONnm2jWtI0sqZ
 X0WSb1ZUYVCZH55+CZxMXSABNgqbUJ5Rrf6dpvoQIdffrZ89cEtHZ0Y6Jw76VqZw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsfv66-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 08:37:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5laX01555050; Thu, 24 Sep 2026 08:37:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jvv83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 08:37:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O8bnQZ46596548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 08:37:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52AFC20043;
 Thu, 24 Sep 2026 08:37:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFE7120040;
 Thu, 24 Sep 2026 08:37:48 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 08:37:48 +0000 (GMT)
Message-ID: <717d2abd-921c-4fbe-bfdd-b14a45d629bd@de.ibm.com>
Date: Thu, 24 Sep 2026 10:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Expose pv attribute in QOM
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, david@kernel.org, iii@linux.ibm.com,
 richard.henderson@linaro.org
References: <20260923083406.64128-1-frankja@linux.ibm.com>
 <17016443-d6e4-4b64-9f6e-52f1413bc099@de.ibm.com>
 <a871af1d-4f1f-426a-b7f8-5d7217edf36d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <a871af1d-4f1f-426a-b7f8-5d7217edf36d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4e162 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=kG_BEEY7b0qlitFUft8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tsnHrHfgb5OgHmJSd8KuD5EGrWTDAXRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfXw4NIRSrj8f6L
 zL3Vj8HGHUQpkiE6fAWkMXVaw6/vMXbCk2jwpkZSyQSC/Ge+EafryIU4bFRmacjzrdwYRfUDHC6
 vc6otGEr4HM3bd/4hTZiOgVcDlGeTgKucNOJfvH8DhvS+xKz5XLQpdLOCzrz/9jvjl1K60ZJbT8
 4L581SWt/h4MeKnVwh0Xg4Bf3pfRiQna/AQvmZZxu5OmQhrvjF+s9r4ONXEHY797Zy5lP/K/39K
 qLMWgJAiMRIIP6JNA60BwmTpNBnvoEOX049aYKyYnrbFVXu6azQs7ANxGiO5/l6ldSWNic5sJSk
 9JrvPq95lYLbZ9d5ld4WSFftZQMNeTQSMCeOVSGFj1YPjIoT5y00ItrFskiCEA4l4EDr2Bnpx4M
 NjL03rQkfNgE8X/1l/w9jjU1YGaAoLTSXFhH9r6M1f50ttTONsB2rxxXQtXJGy2CjxEzJ0xg0QA
 WpoXzxg4Gw3PdPndGjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX74MI/217MqN7
 P3LZT6ILlIzBGVhl/nqOQSIBk7E8cFMcQm6MRbYZbYnzJ2+4Co6hG9jBsSIAZlDLaY1/EEkaOfj
 8xnF3Zqdc36makBIVWP2PbjVRrAFooQ=
X-Proofpoint-GUID: tsnHrHfgb5OgHmJSd8KuD5EGrWTDAXRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@de.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 24.09.26 um 10:35 schrieb Janosch Frank:
> On 9/24/26 9:19 AM, Christian Borntraeger wrote:
>>
>>
>> Am 23.09.26 um 10:33 schrieb Janosch Frank:
>>> People doing VM management requested a way to query if a VM is in PV
>>> or not. This of course does never replace attestation, it's merely
>>> QEMU's view of the situation.
>>
>>
>> Maybe make it more obvious that this is really about the runtime property
>> (has the guest switched into secure and yet yet switched back via reboot).
>>
>> Same for set_description, maybe something like "true while the guest runs
>> in protected virtualization mode (read-only)", plus one line in
>> docs/system/s390x/protvirt.rst. The docs line matters because read-only
>> properties don't appear in -M s390-ccw-virtio,help
>>
>>
>> In any case
>> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>>
> 
> Something like this for the docs?
> 
> PV property
> -----------
> 
> The s390x-ccw machine exposes the read-only runtime "pv"
> property. This property is true if a guest successfully made the
> transition into PV mode as reported by KVM and hasn't yet exited PV
> mode via a reboot. This does not replace PV attestation which is the
> only authoritative way to get a definitive answer if a guest is truly
> protected.
> 

looks good.

