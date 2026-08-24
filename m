Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A566C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyXxi-0007lT-HW; Mon, 24 Aug 2026 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxe-0007l4-O9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyXxS-0002v8-0R
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 12:55:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmohU2857065
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3oi9opcB+NQorDK1/Fg0jTpB4knoX9qc7+ko26uhZdM=; b=WhBaSn1/Z67fVVbQ
 pBP1XyxFQTdrksLsOeuLaMbaSsA4IvsO2g0ZkJk3k0Yv7dvWRJOtbmwojsINBg5D
 Xt1pnUunapmvS6qsgfWEKcCNkkQTpnwBBiWeCu3xz6/GD+hYK6ifaZchmacrjdem
 tBGfPBRAnB+UPSQCl/T+T90VX739wuRqwrpe6bHbg2xiFK56PUkeTPa8h42zH0k0
 jcPOnlb36o6Dhw/7I+SmTh0NT6SW+++ww1Y5x/O8q8hC2iuJI6q8D9KBaMzBpSx9
 on3orPjeqSn4Ou1DJKRM+VfKWhoFfx8A9v0VAoY8qJLhjlM9ZVwtKmdZhIC3GIw4
 0mW0kQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdshvha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 16:55:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so7260888a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787590534; x=1788195334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3oi9opcB+NQorDK1/Fg0jTpB4knoX9qc7+ko26uhZdM=;
 b=iN/eJ0kgcd7wtONRV0pC/o5xCSY6BA5K1YF0Fl26EQGZboQBf+tIBoVGZPozPR5cj2
 D/tjQkL1uQdRDLRebf8fZHyQe3X0oZPEQrfddqxRARZzEfsCHqqWqRTfu/7/rI50F3GI
 88SBLQ7spiSBCnNMp2x/VMLEIyPIHLSMmmR5A3jYsv16yMnyGMNXFSshi0WGOanCCK5r
 vMth0RQ8jNJfFSDD1PoEa4GwEMWRbqBy8Ez8EizzqXTmTGR1GMPuIKu5E2C6VpKAq5xQ
 TcbAklh5RzeG0k8lNKtsZJkgpzEej8cHUiTAqpKQbdZ3+AdH1M07fRtIAVQc1Oh4h34Y
 gVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590534; x=1788195334;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oi9opcB+NQorDK1/Fg0jTpB4knoX9qc7+ko26uhZdM=;
 b=mPjneO70Daf/osOxf7AcRnpc8W7MbCIn+8RWjhAQ5A1wpNJS6qR+sbbnI1haWFAYPt
 S8KJuGAEkd7YrifIKg+VmBfODpYNsyJ7fSu5ygQRhkUBQHYvEVUJA0BBsNHcKl3bShPh
 W9surLyRYfSJvVmP9QFAF1e1ITJ3e6DlRn+3y8QOo2E0BqaWlO7l73E/L3QrfC5q5iNu
 yeA/DoU7NbaE49eKYKCoQiBLVJMuw840a9y+/zw+HWVYgnIfGdqfaElgYbZR0tCAFGmM
 dIxoALk6nTA4lb5xqQdfmXiOpP5V6rn5hCPHa/iX8sGQ7zhXeaBfGtWpdQxlTwatW57t
 ZBZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVCetsuo54vrjfKiF+amBXgCWCVIYIkAcJtFbhbLchzdRGppcQMjv5MHiq9iyhE7ZKsfs5mBW0QGSr@nongnu.org
X-Gm-Message-State: AFuF++mEXddmjmn+CyOWKWPOuKM2gyPW5vXI/ibr9NlcfSEgS+9UDZ9I
 TQt/mHshLjNcomcSOUhw9JZl9ydMaiayQx9JZeSiOJgKy70ivelElnoMJ3cvik65SZ8ToD6slnK
 dcqswQZXnQHd3mPdfpu55e2HLDA8CVrZ+ZXMcubOMivBp6A1erdUOaVagmInTHHWWzw==
X-Gm-Gg: AR+sD12HJTr926cUBn8T/aCVFct36GlMXd6/Pk8xQltsU+QYThJ4VsBw4CKuctHyj1J
 Wh7VE6gY/Z99K0/sc/RGeEwqmkw8mYbUWbRAJ/vXiXp1mIvAX9yHWfKy0OkvrelRRqt1V4/chEi
 i4lnMfO523lTKvrEf3G4y2PWahKIxiKmefju+tUcMQkT3gLaBqyNOFO8ST9qObVtnw5nuGXZmNr
 qpsRM4CdI7gf5A1IYm9i1DEYNuYjoj6xmBsQmpUh18Jp5YgVkOBapW9fCaZLC1pqNkrMfwX/mCC
 oFW58FTmFqB2N9N0BHb5rEa9CiiQrgB1xbUFBlrDv2yqIHXKj94Gf1rnNPipyoPmpqhSeI90OXv
 8ys0IwRwDW+qX71hPtWOXFV15/PBVrov4bQSjK8Cd843UbhGIYpxJjLMlpOK5yvrqN7sx
X-Received: by 2002:a17:90b:33c4:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-395c3552287mr48919037a91.13.1787590533765; 
 Mon, 24 Aug 2026 09:55:33 -0700 (PDT)
X-Received: by 2002:a17:90b:33c4:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-395c3552287mr48918954a91.13.1787590533214; 
 Mon, 24 Aug 2026 09:55:33 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b39efdsm222881a91.5.2026.08.24.09.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:55:32 -0700 (PDT)
Message-ID: <73397703-16c8-4119-8f46-8e0a4589c63b@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:55:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/40] bsd-user: Remove mmap defines
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
 <20260818-misc-2026q2-v4-7-09bf5647c98e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818-misc-2026q2-v4-7-09bf5647c98e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfX7oXX4u4uV28I
 O0uhbvnH2RWsosXHut1ihThLi5pfMc8DinDP69ASpPxKqHX7OrZ+AL8I0y23oKx3QlW/+gGrr2O
 O19R3Wpa2oAZDfT026uLvFrs9swmkr4=
X-Proofpoint-ORIG-GUID: ETUTt4-ZynKmwUoK1bmjm9B_dgI0kWB3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0MiBTYWx0ZWRfX5JGyDvYZO464
 UqKGYuGlyOU3KZdHvQFjkVcQs+7sQbSbzE2s++NCBHuTJMWfR+T0UpZi/W3JA7oB9LAL2wwlk4N
 b2daChUK3GzwaN2NopQ2i/hLj9fhwq7RuyOulOqU4l8/e7Kqj7EK7BMtbBTjlKD7eilxlBg8Oio
 Vh8RNXvVyE1+fWVwDbtEA9NiRZds5T+U869jNlwvKFSrj2sATjD8nROKgbJsORlujtQPaSiNfQO
 wmQo85fx4RHrdXrsXGdvWwKuqnKfN7w0Gi8xX40xM+RA8Qdq1oEvgnvoCUFMrhdNWi08IAiIZcM
 jJhImU9eYUY9cDgUFlzu45tiDHCNDiAuu77IXMOfZX8lOmVhgRWosoEdTmYoX2Im+9bmgmzgQ3t
 EoMLXpswG6qD9eMdrEMFQMkaeM0O8z3j/9dJFuCG5rKf4JxbqTF1c4rcbxrqmZsrjUkq8piPPCr
 ocviEg871CQbqSp0vvA==
X-Proofpoint-GUID: ETUTt4-ZynKmwUoK1bmjm9B_dgI0kWB3
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8c7786 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=cDWiFgNlYuxbV_YjrucA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240142
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

On 8/18/2026 4:56 PM, Warner Losh wrote:
> These defines are not used, remove them. They aren't in blitz anymore.
> A future commit will cleanup several mmap issues, not least the obvious
> mismatch in the flags here.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/syscall_defs.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

