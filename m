Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F3DCA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFIbZ-0006t4-6C; Fri, 09 Oct 2026 17:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIbX-0006se-43
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:58:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFIbV-0006Mb-BQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 17:58:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhYne2021083
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 21:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w3U9PyYEr9+9aSK12mbVOUSWXuaU2zNrNvGKBhw+UFs=; b=dlkdGHkOK7UeiZHt
 WyO31sQBcNr6OpotxJDGsMdRfS81JwsCcgtN8JyQCRDPZY3OAEcSxxTB0N4itC7e
 g3C1SH4YkuZjsxTdBfbxudeAEeYqMOMkNK9SBlR3cctrBHoGUZUOS80kjMcY3byW
 yqIqVCwZ440eyj0QFHlwH0aJgGVV0kGt5VMB34WwQeoXcLU3PBF9G2QoKGF6EbU9
 RZ/T9tpsaVpuz80SMVfuZaFteV9nVCi3cTTsSjMFcJkZxNjB0kwGN+epdaGe2Jl1
 F6HmjIwroITcB/2GePTh12wvJY9PkrUuVJw0IdQfimDxJBaioBCTgCHBZWHxAIqp
 ZPdNJA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70v72-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 21:58:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-152d1363a29so650036c88.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 14:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791583090; x=1792187890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w3U9PyYEr9+9aSK12mbVOUSWXuaU2zNrNvGKBhw+UFs=;
 b=UyRIHDm1rpD3t5AEm9tmAYfCxE/K95i/VBLKLBbtxf99NWHmM0rOrwwoHL6o7m97Qb
 BWufO614xbfSLNQukjmH6lneWymUEBcv5MfhX/wspcgwe5oWu4ecaUw4iVR7F9em5X/M
 9uQ4VaplFjbWZHfqgUJeBAG1v5dY6YNzyo7moWTdei3XNLUHyIZU+YTMjVBd3n9WCltj
 epz8LWyg2C0pe9w8uXwnu1fioEieHTUOb6A9WuVjBi4XQKC/6EHS4ARqencm72bLiF50
 2vzjuZLHZkNND3davbVv8qsq32Eps04QcHZXhv1cL9PHS6Nn4nWGe122bvtQyTiDiF4D
 NoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583090; x=1792187890;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w3U9PyYEr9+9aSK12mbVOUSWXuaU2zNrNvGKBhw+UFs=;
 b=RW8njqglQGI4NfUnqFQgKOtKaHnWJZ1s4R2WYjqW9RlD1CD5ZuJzcELc0FX0s7ak9z
 UW96ueEtbhSBMVZBR8+fCFq87JiXYkG5LUIR4CHslISN/yD081NDbnBOA+Zg0hAyw9kT
 qBPJuSe5t5KUp3SYMhNeBvreX5ZJNM2efjR5D5pqpQXDB1uT5TQy1I7GERh4x8rPy7CM
 eZVRaJ0Fm+6A4BxN37FiUwoq/IIr1iOeclab0YBgwUemEwTwMC6kBUgSDn0arkV5nTHR
 WJOUK1LMwRuui46lGNx7VplitvE3wBMb8w97whAbpR8OJEFd1TnhYIrsEnZPV8PluNNa
 0LDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5dRCU3fr6I9SAh9gpyP2UcRAid/GqwhIpRqwnlFF8Vp+cKUQTmURuj/+wLMl8h7nygGVLgWUIxzwh@nongnu.org
X-Gm-Message-State: AFq9FYLLcKvarVYyZoetx6EQFJlFuP+/gn81aPmlssGo4fHhchVq6eb0
 i6qjaTG8xwCGgN1FlGl3IB06uygBUo74Kx5VrJOFcwcfViMjZT+cACMr4SGwiQtG1+/pr3q2hjn
 wd1dnpqmVRrWf8/q3J5iicKDb4P5AUEvrlkCM9vnLqeE81/vQmK3r+Pd21A==
X-Gm-Gg: AYBFou0vjwh9s+V/n2AYR34s3196z5o5t94Fu61eNM6uZsgBC65vwyxrSHbi/hdQrkM
 VDuS7WI+LgRgKVL+I5EZGoCDyz+sSR3kln2nH1q5SFh1f6wkuDHb10NtvDn9NScMItAtDyqaSah
 nFZN7mbipT1WjFFXFPVYpoknu4QRetJwK5mkTk0zgLLmkpLhU5Pe6dycLdi5jSEp+JMCpQaT952
 jlTwxorZjioBEV5Le9wkkcEHUnFF27qgHhIzfZJwYJvJVMKBuMp5U/6NetzDrkSGPqnC9WG/0jg
 mWBVQaJpfmJVh1d+Wo34cCVsFeFMU+ToJYjifNt+nrStOlqTmSt0Dkp78JAjJirvb/Ued7Rrc1s
 xYS9zA624hlxhHqrHb5dPLCyuIuUX0stdGoMO6f/4QXzhBUFhAXAvCFBogxzrWKb2tMegvA==
X-Received: by 2002:a05:701a:c90a:b0:147:9ad0:cf10 with SMTP id
 a92af1059eb24-16a610ca3d6mr3873824c88.47.1791583090447; 
 Fri, 09 Oct 2026 14:58:10 -0700 (PDT)
X-Received: by 2002:a05:701a:c90a:b0:147:9ad0:cf10 with SMTP id
 a92af1059eb24-16a610ca3d6mr3873796c88.47.1791583089957; 
 Fri, 09 Oct 2026 14:58:09 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm8231817c88.22.2026.10.09.14.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 14:58:09 -0700 (PDT)
Message-ID: <5ff9d90c-d4fb-4951-a5bf-3cafa92c502b@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 14:58:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/qtest: fix and gaurd PXE test build on MinGW
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20261008184119.142-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261008184119.142-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX9HOugy5vePQ5
 UJnkkaYj85houedW7izC8yltfF6oa0qluoWsUokvSNnmp0SOOeHc6sGaX4+Xc2ysLs9jy1YBgT5
 6imQgXbS5z17p4XP6OAcWykpgh/S3eYGyKXOsOoo+M0orY4ggcb1I4A11pR/MfTkSWXUM73Iila
 qPtUCOQZXNZUaL9WrpFo1sHELoW6pFxKaq3eeusYR4wyfzqxYEBqr1m8BhVhYv8uVpX3uOsh8AP
 6/uROxHFLCsgTPTOe9lC9RlHdKJgEpTl3ZalnNrXs+ltZt+AeXRVtsj3LgSLHRxccDi444XDIAO
 R9lyzVWtQKvBfX190odb37Idvzc29cDocvfeA0RRKbAUkkXc+6WpMrMLF9iNrhc7EKqscpqUXJe
 msoEfF1M+uGPT/HznbDwQtITiWLrGLSQuTWk8qoSILbyQUnegrpe5r6vq48knI1SuNQgo26dIOh
 yRJQhjXVl/x0P6CFnoQ==
X-Authority-Analysis: v=2.4 cv=Zt94uN7G c=1 sm=1 tr=0 ts=6ac96373 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=-bYXH39Ph-bsz2cvq0YA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4NyBTYWx0ZWRfX9O18l9Hn42zR
 J7OSFbg7YPfc276LtydXJrnNSQdZqJ+AWGdjhBWQ3QiTh2KcmxcK23umXRMduZMbU0jU+8Nc0BG
 wUj3uoBXQM7xWj6udXNMkbGYCGXiW3s=
X-Proofpoint-GUID: Ztr_OP3Sa8u4exWb0zsAgD9mIZfCXUac
X-Proofpoint-ORIG-GUID: Ztr_OP3Sa8u4exWb0zsAgD9mIZfCXUac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/8/2026 11:41 AM, Yonggang Luo wrote:
> Replace MinGW-incompatible memmem() with a bounded memcmp() search of the
> s390 BIOS image.
> 
> The Windows cross-build did not enable slirp, so it skipped building the PXE
> test. The series enables slirp for that build, ensuring the test is compiled
> and the MinGW portability issue is covered by CI.
> 
> Yonggang Luo (2):
>   tests/qtest: fix PXE test build on MinGW
>   gitlab-ci: enable slirp in the Windows cross-build
> 
>  .gitlab-ci.d/crossbuilds.yml |  2 +-
>  tests/qtest/pxe-test.c       | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 

This was merged into master (40ba85501c0b6ac2a7319d3804dab072edf67564).
Thank you for your contribution!

Regards,
Pierrick

