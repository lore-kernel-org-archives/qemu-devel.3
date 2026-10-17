Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85724CCA490
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 00:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHsGW-0006RN-Fj; Fri, 16 Oct 2026 20:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHsGU-0006RC-Ia
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:27:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHsGS-00078F-L5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:27:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GNFCl03627013
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 00:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e9Z0K7CGYOCrcs3PyEvVIML7SDv24AU2AZPp5yKvCZ4=; b=C35I6sIILuu8xFfE
 xqTP2OjmxDz27LfvujdQJUn02gCHDaE9nVAA+fIzo46vY/OKgQjlwCHMv1Pzcvi4
 Bi2mHnoH5+E7nqHGMNaHYyXzk9u1WXvdBB5/j+tmqJ3HR4sPo7yGm/ZmzvtadDu0
 iljG+L7d/R8ZmUk/Yr1Rlr+iM5XQYtYnzjHNvGIjbMYV/Z2rtpgS+OJi8PAO+Hfm
 JfU7vYSFTzTkaTHbl3syMrvy8lNjCTNlc/2Ht0i9Y9fmRu1NAwzC7IrP4joJ9N1L
 R3fA9Gk/dmhDvDr6Vc5SeyUJ6e1k9Jf4Ldjim2J4AW5dpORVh95VG9ggIZ+1xq9q
 SLJUXQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yubg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 00:27:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5358515b4easo8097281cf.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792196824; x=1792801624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e9Z0K7CGYOCrcs3PyEvVIML7SDv24AU2AZPp5yKvCZ4=;
 b=Bd2meKPlsCkrKzSBf97aCiiOuSJa94j8F2zDbeZbo5C4VI4zh3AZI2icgzg6IVQ3P6
 VpcOJngHkJ2Xu19u41mJ+egnkAvxxu5cBec8TKmGQmKPXWb60G2n1oJjyGEXMBGknri6
 AqapdPyLE34RGdQNpjwAYTbtonngrD3zdNfWNDO5zYZH2us5ftFc7k9XRFl2+LNTucHU
 T84eDeZdNOqSFJK2y0uU/dqjzsvK8sYxD1XkmNi5Ome1q9yuH5QzQssy+Uo5mnKckdRN
 gV52s6Bi3nIgRj+uRfngAZniepP5bdvb8DM1XvgmON26B+gHGTRKqIq4YpmFExO/ritO
 Lh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792196824; x=1792801624;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9Z0K7CGYOCrcs3PyEvVIML7SDv24AU2AZPp5yKvCZ4=;
 b=JfD/NHnor11AeopabOJFyzn6YYydGuw1vhO5MEGB2YCq2z8VLsqZ8C1hVNlNXhyg+r
 9tGnVc9mvBDSoTe+HCB2ta8XrRz3KX/HxVaX2LeSQZSEj7VzCnihxFaRc0ZhkMdtqXiC
 xJEuX+kNT3g8Q+16JRmCVdfYwXm68feg9t3RymJOZeJfWkPaJkUIGq6yCJHDY96m801C
 o1HiauMDT47lY+3awJRO7Gq2lV7LI1SD+Raa8GvEiDAPZFKzUt9i4PC5RrE7mW72DsDM
 voYVsGKmM8Y+OH2AlZhkKMiJ7ZME3CwEOZJ7A1UatioiZ0hTmNLCQc9yhwQkOX6rtped
 CLrw==
X-Gm-Message-State: AFq9FYIApVQjzfUDN1LXMNju6JmX4Vfw8Whlyl5V0CMcU/jZS5/R4jdT
 ZTtn1Y6wJEy+rwoUEvxJI1KPROvPKcRrsjTBefgYE47r1NSwWfS634YvAUdUzp9ytPz6n6W7olc
 oWG3zwqny5V+EzV8ehiuqjPkUC2u7MCUBHtrDns4p7chGQesgQljo30t2jA==
X-Gm-Gg: AYBFou00rsSo3sU/w8gn7jhzFpQlpFz+qeVaJdh3HDYHcDzNoGFQZIeD4hMFgAjYBQw
 cnW4DqVzODrLPTLYYz+oa5m2wrquHt0/PCHfwmo6M5zthF6eodS1iw9E1NewebiR60hYrfNrYKF
 5/gKLVVHj9rzPle9bN5d75+AYpM8i1DEOKJd2YDge/1gNdAu+hSobPn+g4leCg1piVFICNhNChU
 LQsGv90O0SwHmVEAodGOzAV8XclR2AI/VBuWCQKS5QqwBbfNsRrraUKvlTp0go2o1omis3C9HWx
 VMKwvqRsjvvd0TT3hfGm0gdFg8GPrURXvBQFLx3/lxJ2POX03L9ERyJvLkVcBy6Ae3jT1qeWyDa
 WwoBnqUOCMoIr8zMaS0qMA5A5w5AaS41h/fGgaHN0EKQc2aGAFx2QWjXI99TBBOr+bMuUu3tU52
 141Mk=
X-Received: by 2002:a05:622a:1b1b:b0:532:9eb6:8498 with SMTP id
 d75a77b69052e-53645e6774bmr16556971cf.22.1792196823798; 
 Fri, 16 Oct 2026 17:27:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1b:b0:532:9eb6:8498 with SMTP id
 d75a77b69052e-53645e6774bmr16556631cf.22.1792196823287; 
 Fri, 16 Oct 2026 17:27:03 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5364de4d690sm1335941cf.3.2026.10.16.17.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 17:27:02 -0700 (PDT)
Message-ID: <e52712da-c1a1-409a-914e-c2457b1a4902@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 19:26:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
 <CAJ+KCYP4L_JamaaVJVu1jJzuTzW2xea5tzNMbXXRgc+xci9S5w@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYP4L_JamaaVJVu1jJzuTzW2xea5tzNMbXXRgc+xci9S5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e9Rs4KoqJiu_ZOGR2pql-5tqTfrPudV6
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad2c0d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Hwn68EZ1T_3vY1XmufYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwMSBTYWx0ZWRfXzBhdpB6dzGNu
 e4T6BHzYeZCxUsPn2e5vi2gJht6AZQhsbQoyMvn6a/N2BCide6xMEmm68En8uodPv3I2+EdL9qR
 F4ggqk1CaOZs+2nzUt/NPLDimDGyRqI=
X-Proofpoint-GUID: e9Rs4KoqJiu_ZOGR2pql-5tqTfrPudV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwMSBTYWx0ZWRfXy1JVqWA6dg7f
 YuedJtj4RWA7qU5XBexcyDYMv1ommA4u0K9Xj8IrDlpmemko47H7iQx2Um2Gl5ek0/8fkQoqV2S
 sBrQUFdvDXIacWWZGnB5wUC70cc4R1JnXoMd7q10A56KIoMXVknbroixu3LxXXeVzAklrlE5jt8
 ud80CnyDyrECiSBalIVCFGVRBGkBsyIBbPajpkqq4UyTR1Rs411+DEcUXEHvZ4hG1FHuCp+eW63
 FcVnQuKPmleD0yolf2g+bHrG+9Ba3Kyv44MoD4yJf9nmTHXnxwA75IoWxeOAFJqlae6VBeBoM9F
 FtmK/pac2ndCzXAeFkBg/z4OwRA11Nz30OufnCMAsfHiq1Lyy67XML4WXl6LRBQPdZUc1EUqRr0
 BRTXVQNThUs2/9NpOrr0j4ZBg+pm2c+qMW485+HPGPnehNkfXyIVQcHolAjW/f7PkILuVLffx9N
 9287DIhxBYSQg8kjPQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/16/2026 1:52 PM, Marco Liebel wrote:
> On Wed, Oct 14, 2026 at 2:52 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Bit 7 of L4_loadw_phys is valid through v81 but reserved starting
>> with v83. Decode it as a legacy don't-care bit, then reject it for v83
>> and later.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/decode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>> index 89e961331ff..9e8ff5d608c 100644
>> --- a/target/hexagon/decode.c
>> +++ b/target/hexagon/decode.c
>> @@ -721,6 +721,11 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
>>               /* Invalid instruction encoding */
>>               return 0;
>>           }
>> +        /* Bit 7 of L4_loadw_phys became reserved in v83. */
>> +        if (ctx->hex_def->hex_version >= HEX_VER_V83 &&
> The check should include hex_version != HEX_VER_ANY, otherwise it breaks
> -d in_asm for any version below 83

I'm not sure that solution is ideal either - the encoding changes for >= 
v83.  But if it's not shown correctly in in_asm then that's probably a 
hint that this special case here wasn't the best way to do it or we need 
a special case in more than one place.


>> +            insn->opcode == L4_loadw_phys && (encoding32 & 0x80)) {
>> +            return 0;
>> +        }
>>           /*
>>            * If we saw an extender, mark next word extended so immediate
>>            * decode works
>> --
>> 2.34.1
>>

