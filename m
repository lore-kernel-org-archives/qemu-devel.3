Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C271CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZv07-0004Eg-JI; Wed, 17 Jun 2026 14:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZv05-0004EG-GM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:28:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZv03-0000st-9r
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:28:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHdE1q2895757
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUULp31KWAwWIyR/1TL8+81Pl/j8v60Bq7ZXvrRVS40=; b=HUeUJx6XKDwy9XU7
 ggzfFGw9mHP7VWwe66XM5q/Z1mAFXzS/akeHjIf0Sbuk9ehNfudd4Xkvqx/7cdwC
 pBVCOfejZpPzGr7ZxyAxhVo9H2PKwdla4bYG63naF4SZpjbBXjA/Hj05Ndcs0GY9
 gdY6UdXZPCM7gRrhHl/HPUOy7puzHwD3X8vv/bVuVaf0S18WjcOdqgJ2Ks/jNnGC
 OQi5J5MffnTso04o+r6uIPEZwFlPlJKfkxgDVzlzaPW75IO/UAUAS0K2a/XMpcP/
 kbIF9GG4oNxSsJRwN+KOKrhcN8IOGtoVFjT4c3n5e3d3GBkwhikf1i40MdkYRexx
 Ii7BnQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer4uh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 18:28:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f1820babso131950eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 11:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781720906; x=1782325706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUULp31KWAwWIyR/1TL8+81Pl/j8v60Bq7ZXvrRVS40=;
 b=RprWpp2P9KxpxTCisDLcidCS0os7UxNdygnoLTDTS4ZTVp6TJwd3B7O+CaaqXk+AnZ
 rAzSDfE7JcgUyHnPhoVVKlnCQFv72WyQb4agL92U/96ZeLXNMetfo/kmoiQVWsf94IBX
 DFIjtTMJ9O/YCVxq4meBCb0eW+viF4o6PvRNoSZzWgGGx91LRrlwbZHQbt8M0U4ZLLZ3
 d5mJrByUuc/X90lfgIoy6irGK6qN293dezxX9kTAXeVppZ07j0sxVljBCtY3AqnI6iQX
 0GNk9HmD5nILKoi8OlwUjaVl2t4HcEKg/3ydO855g4+z6XoTtQjiZ5MnSvnLsCpdj1vc
 +wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781720906; x=1782325706;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fUULp31KWAwWIyR/1TL8+81Pl/j8v60Bq7ZXvrRVS40=;
 b=SNazGEo668cUxZSNYQRWwd31R5a94ErwQtJKXOcYy8GRsIQsAl+1zvgbNqOQaYsBHe
 Qg4FqOGNlP/epse8TpnInBSpwBk7ssIW2ZIzmBAzFIixFpuF2fiUPzaR/PimLO2caPG0
 dZ32NKXEL+wrvJtLPQKt6Gv69Oinmu0Yhffn+dSWNNCOcFpjqNipX0ztDuYhStQdpQdn
 7/YiF3pfBuXfoJUckhtJ/p5yJskq3GsN0Lda34LuWf1NE5kbIbpcky+g86QVIswWnzNm
 AilJCwEZbYovomjqpGwAJjF65mClYbPm+Lo+2dLgozUsPyFXKpoQAyIygYrSmV98UVCe
 AOYw==
X-Gm-Message-State: AOJu0YzUwcPPV4TLhFPc8ROiehQ9rKd4RlFHCLYXtaA1vb1Cl1lQ7Mj+
 3KHNj0oLe9yIMJKadnxByLh4l3TrfEcS1FnurjQfhWYd5BLCAqbzOX8f0ezeIWeTuvkdiJxiEGw
 +/5o/52wJIydMbgzrCD46wn1q3TDz0xxwXdzlGrLOKLunilcz9xis+9xY3Q==
X-Gm-Gg: AfdE7clEGeJCzTM2nCdLEw1ZWCwmhzzxFTd4/XV2tX2lP8F0xSFyfTZfro9TGhnjJwx
 8vDyS+HjJ7USlqo8ptm4sW4whfn0P+BdLLoyG7rsAG53FYUBNKAgBIf6NBzxL02A4cOG7+usxF2
 Kh7UR/N/qKtvpscqZXZIkO1qsMxfa+98uc0laI6+5X3RdbM1FXCaHrj53SwMyPxbOlEXj7wOnvy
 q6dADjkd9n5fViEfJK8Oh/ZqO9X4eUjGCr7jM+LRzPPwJ8NHvZv9aXYKAQBi8boMfHjhkxZIONa
 WjmxxAnd8CFg30k6hYLTAmX5nWof2uAgP1ux+F9GfRRszt0lz66S1S6ix3nYXiGCtryBQfjhWGG
 WSWJEhEjyAvm/tB5PZ8176qEAVRC5wHl0f+53MbiIxE1mKKSQryAe2QaIVvR3lnH8HwQ61CW4oX
 0pH74=
X-Received: by 2002:a05:7300:e61a:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-30bc9aa7477mr2720912eec.6.1781720906172; 
 Wed, 17 Jun 2026 11:28:26 -0700 (PDT)
X-Received: by 2002:a05:7300:e61a:b0:2f7:d419:dee0 with SMTP id
 5a478bee46e88-30bc9aa7477mr2720886eec.6.1781720905594; 
 Wed, 17 Jun 2026 11:28:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea447b4sm21678684eec.23.2026.06.17.11.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 11:28:24 -0700 (PDT)
Message-ID: <2efd2091-73bf-4ec2-9946-a49470e1dcfd@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:28:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: fix entry for 'Python scripts'
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-2-pierrick.bouvier@oss.qualcomm.com>
 <87tsr1pvj9.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87tsr1pvj9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QQxjfqbIYj_YJjtsI_DD7sGJgBGcLBXk
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a32e74a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=6R7veym_AAAA:8 a=kGYYx_ejPgIqDN17WxMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-GUID: QQxjfqbIYj_YJjtsI_DD7sGJgBGcLBXk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3OCBTYWx0ZWRfX9Gza5gF9Y4zT
 BQ3hCNoQ+0EGe18dqT9E2qb3WwmxO0pfE4q44Y7vTMjlioslN0BNIjYtrAcZR0urnbcBBrl8NbH
 V4jptrvKHDGsU/Ff4pvFFxJWgRNXsjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3OCBTYWx0ZWRfX/ulzGw2nEI4d
 FAhyoOp9eSux5nJ2YBwrGsCWu3RutG7f4XKfJnCTUaT7Un9FoarTpSMuSEZTmsOrZsYjJZcFLEy
 X7Ls6YaNOf8rl2SnGzh1JZ2KgHOfeHwE8gguZ9O8xeaoIlXve5wIQeZaTxM4ZRSdXjTpaLl2WmR
 unDPdu9dBUZTof4ItLvPYZH+WTEt3CYMKmmGX3BcH+IWvHGAhPW8e592ErySea0mzi+/15MDFPo
 DyS/w972GzS9wXf/oO66QAxo9ZpIT7Zb+z++zSzL8bcMvhVmNsa8t5uMjFUFWB/9Jo73iGjPz8S
 wdEbKw444uEirI2dnykWbud42SfogdzZN7UQXM3r/EsfLPvvhllqSfHqH+rMKsqbsw4ZzIYYvla
 785nNbvZ70wrATr+lWVg8DUiwem5OzCdsX6TpIISbMHOc42mkB5iQAHHheeFVLvaWuJRVLVWp3L
 npcz4uCXL6em4reFzHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170178
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

On 6/16/2026 10:48 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Existing entry tests/*.py does not match any file at the moment, the
>> semantic is "any py file under tests".
>> Kernel MAINTAINERS file supports 'K: regexp' entries to match entries,
>> but we don't support it, and I'm not sure it's the right solution here.
> 
> I think you mean N:.  K: matches file contents.  From the kernel's
> MAINTAINERS file:
>

Oops, you're right indeed.
Sorry for being confused with N: and K:. Surprising given how those
single letter names are obvious :).

> 	N: Files and directories *Regex* patterns.
> 	   N:	[^a-z]tegra	all files whose path contains tegra
> 	                        (not including files like integrator)
> 	   One pattern per line.  Multiple N: lines acceptable.
> 	   scripts/get_maintainer.pl has different behavior for files that
> 	   match F: pattern and matches of N: patterns.  By default,
> 	   get_maintainer will not look at git log history when an F: pattern
> 	   match occurs.  When an N: match occurs, git log history is used
> 	   to also notify the people that have git commit signatures.
> 	K: *Content regex* (perl extended) pattern match in a patch or file.
> 	   For instance:
> 	   K: of_get_profile
> 	      matches patches or files that contain "of_get_profile"
> 	   K: \b(printk|pr_(info|err))\b
> 	      matches patches or files that contain one or more of the words
> 	      printk, pr_info or pr_err
> 	   One regex pattern per line.  Multiple K: lines acceptable.
> 
>> Instead of adding "yet another generic solution" to this problem, just
>> add manual entries matching existing sublevels. The Python scripts
>> section is the only one requiring this, and we can always reconsider the
>> K: approach later if another use case emerge.
> 
> "Only one" is not correct, because ...
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  MAINTAINERS | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2b5b581e173..61af956ed82 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3472,7 +3472,9 @@ M: John Snow <jsnow@redhat.com>
>>  M: Cleber Rosa <crosa@redhat.com>
>>  S: Odd Fixes
>>  F: scripts/*.py
>> -F: tests/*.py
>> +F: tests/*/*.py
>> +F: tests/*/*/*.py
>> +F: tests/*/*/*/*.py
> 
> ... F: scripts/*.py matches only about a third of the .py under scripts.
> 
> I'm not demanding you port over N:, I'm just giving you information :)
> 
> The "one F: per directory level" solution is pleasantly stupid, but also
> somewhat brittle.
>

It is, but we need that in a single place, so I'm happy to have to have
a stupid *and* simple/explicit solution. Complex+implicit, like in "I
need to read the full QEMU doc to find what it does" is where things end
up being really stupid IMHO.

>>  
>>  Benchmark util
>>  M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 


