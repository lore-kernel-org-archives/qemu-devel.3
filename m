Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA159C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2U1Z-0003mn-Lr; Fri, 04 Sep 2026 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U1Y-0003jo-Mi
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:32:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2U1X-0001lO-0k
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:32:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIr1j3566360
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JFoc4gk/A9MgQwuNTvhE8Ju0+wbQT6MuAykNj+ZXqJM=; b=H2i0lkCivhQ0Q9Fx
 jduogeI2CfYPdz4+uHudQ2xrGws3nZTkxIggrWw9dM48g46r2m6UyLKYFnfYYDHR
 vYGGf3wUmw1Jh0le0q6RKJIIAEhvz1uMNsUc3DuXRF3e4Xeh1vxX9lT1eiVH9M5f
 EVRwQFRpM1xuTYWZtu5UMZQXg3v8Epog2oMuSdGNuxeepSjyZvRgeLyzQM1KgHvg
 lFIEs22XInsgxoD7ocd4Et0U55dwEDIwdurIajD6qQ6hpKWzLHZjF7XiXctp7cXr
 KgnOFM+FY8sgya9pb317PWBg5bc5p9QlphnUVaLtqpd8siVQKQ9/FKPOdKHHeOVb
 Yflg2w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp0r1yn5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:32:05 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9909eeeaso85583241.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788528725; x=1789133525; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFoc4gk/A9MgQwuNTvhE8Ju0+wbQT6MuAykNj+ZXqJM=;
 b=aCaOhKlR8WdKZMlQS448SPHjwv6q0SoYofvNBp0JCq1tUMxmnTBs5yuTfXKdHQUfR+
 hrLHU2mVOaS8w0p+wKnAGJnl0k4yI5iXuF29JPYnLjPGEgukWkXUuXT67SJPtXKe16xD
 NOr0wrqzGSLj+sZol5mzeIPpBE9NExI3sPAEBcerl1tHqCF8+ARwkfSfgqJMej2Ui6DG
 10C9zez2xDmD7//EWwkUXu1BRB1zTs7HcOY8t1G5pRZ4EfdwsVHGyJUPqlIduRWRxNIk
 CReTXVj/g8m/goP6QUGsPu3WZyacrB6mDW/LCnXug5V91cIwMRei8fW471DsRDAocE9m
 pK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528725; x=1789133525;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFoc4gk/A9MgQwuNTvhE8Ju0+wbQT6MuAykNj+ZXqJM=;
 b=Q1jJGr5T9jHYSn1JhesIMs1f4oj12jY2EYBdt30ZfsxuRaw4kSNpIAgI2FVAC3ymtG
 UJ+Es5D2mNxPg6iRjaSusXLiPvQUShvRz4aNiaOqJBkGrk4F9Zs6ubTQofi4iACmZSuJ
 4uRBR04bqLL/+uNF0podrtO8pUTadeFLD6TyjH88WH22BvF68q0nLcQy9NhZ0PNcxxGI
 nNxTlHu1W9+Y2x0VCCiHrXQ/NfEAt5E34NMGjcPh2qMMUp/O1BjqRlAUMQyA6W26k7nr
 GiEfM7d2yKoSi3adt+d/jes9h+9xUg80rzn843OQ6T5CFTn/SlOBM3VbndonYDvSIb37
 NOsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZwbaPTYcdEEyk27pi4AsND2gBv5cFDzKdwtJSXp4LQO3jWbkr4lkw66R4yyk5ox5ZHPmUY2mbVoLw@nongnu.org
X-Gm-Message-State: AFuF++nftZXYFFn067XysHsCrecEXQuyugnz8ypkQn0mr7otL11u8dXa
 ryVO8eIvW3Ou2AXGJNj5dYEg256YlsMcfFkFQaIS/EgLlF+CmIxi7VOieOu0xPtfVcw3H92GbnP
 Ml/tjLTNky3XhbsNCHBVA2oj6r9wcE3rW9oJ6cNVWeRSDydbZg2a+c9FJtQ==
X-Gm-Gg: AYBFou2D9OH1FW+wsPb/ucZ+EoaFYBmS27B3SY8FmjNkr5wvVuerQoa09HIDhbzcmyr
 XpgZRoI8hZMzoqoNbhndq9CKTc0Vob6UyalyZardAc/QSJnrbJJ0qZdzlHzAIiPZsvYSAXmbxWy
 AVxlMg0b/1dhpLC+K/Ygc53rhCENMEcCNjbYmsjCPjo/4B4YWGunhV0hh3c8HGr2ZEeFnhkfNID
 y9vLJV9EKIOftNPBWXBYoJYvgsQ9BCKh2jOi03ZYWO58kq4UMprFBKGqwqnT2CLSMo6Mg+nKNW0
 KKn/M+FSMfeBbJyT3KNYUAUc5ebEQzyHrB9CUtorb2Hvtou7lUS82rQ4gDfZWQlg9sJhRs0goi0
 h3hVYEpqKF7aQk146mMTYc9xO7KqdMHfICw==
X-Received: by 2002:a05:6122:551:b0:5bf:a179:b2be with SMTP id
 71dfb90a1353d-5c7ed4087bemr2110813e0c.7.1788528725280; 
 Fri, 04 Sep 2026 06:32:05 -0700 (PDT)
X-Received: by 2002:a05:6122:551:b0:5bf:a179:b2be with SMTP id
 71dfb90a1353d-5c7ed4087bemr2110764e0c.7.1788528724862; 
 Fri, 04 Sep 2026 06:32:04 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm154291325e9.2.2026.09.04.06.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:32:03 -0700 (PDT)
Message-ID: <ad937267-9796-4ef4-83e6-cf1087f61d09@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/hexagon: assert guest register pair alignment
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903185622.3234171-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xU2S6ETS_pk8OEMfIlbA_X55oeqdyoGc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEyMyBTYWx0ZWRfX5CAiTe5uNBWM
 GO+WB4Lp7XXSYFLr/Ce7IfIXJZJaObP6FpyPf9wQ2Vjf603cj0f1plVpxm+icc+ZKQvgi+oBn46
 doHJH39Kp4byvZaWlPBh2vHqKxsF9qE=
X-Proofpoint-ORIG-GUID: xU2S6ETS_pk8OEMfIlbA_X55oeqdyoGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEyMyBTYWx0ZWRfX79FUYXiYg2aW
 p14BEKWqGqqqmaVGTi2+sXMQRltHOTYuWkylhFr3XHdcru0QT/dttYhRXjjFrtEb8lfXcyVPKHC
 lhLnD09gUOCZHKbGCckb3ctJKlUTaqCD7ek8DvJlA80Yxa2a0nJifiC4Ld7Tn46vVxrUxJD9sv3
 M6muXHsncp+CMr8NaYHCsOYih6Q0ZSYOjKmzl3eWkIysQN0ndLeGuOUdy8dfsm+kbzIZzEb1TNZ
 0fZH43Dp5qsFvuIjTKrk611LLyRSWqsLM5SQEnxYwJxHNMk67jEOXmG8L2TP8UyLMLpTkskRNVD
 KKAJQ+AFfeI2lc7NlhTw0wauBhiBENMf0oypEdnmB9zxMYyk1MiOUhHa2w6G/FwvVkk2m8WP4Xk
 8g1cB9rBNJuz6mGhcWngbVXyjT/Upw==
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a9ac856 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gHPne6YqgEI5AgDLG5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609040123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 3/9/26 20:56, Brian Cain wrote:
> Link: https://lore.kernel.org/qemu-devel/f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com/
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/op_helper.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

