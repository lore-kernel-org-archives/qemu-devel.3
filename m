Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E90CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnUT-0002N4-LI; Tue, 13 Oct 2026 21:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnUS-0002Mc-1B
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:09:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnUQ-0005Y8-9N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:09:07 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DK6rgi806684
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ipqHFctUUnJba3gkprYkEQLsowt56vuRbcAD+CEIEPs=; b=hm16JoTDmajGTPNE
 mDV51YJhC62e3bmqiWrMjBuCiEffYGWzoy7UUz3/c/beX/HuoP3x6i58q3WOE5dB
 gqDnqc3ne9s4IywZbe7NWwWjFhjVXuro7QjK3s9gtHQvVIg3bVzQ1joYpbEOCTA0
 ldNkQiL34NfRi6Or6ucNeJWby32/ZQEt6Nk3I3CoTewC7QchWA22Z9Bks8WCkETs
 keAPwDVh3nbrQExJ11X/dFcUxb6XNfksFJY38hrq8S7sKoEe8J4/CSsw+yq1H+Ii
 Y+6biROpn3RghMBkfOeTtskks7l2RAQuoh+nHdY3NGw5w6DtBUgdJRI7/P+JrNlX
 1LqPFA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud68xg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:09:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so717832eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791940143; x=1792544943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ipqHFctUUnJba3gkprYkEQLsowt56vuRbcAD+CEIEPs=;
 b=LgJb3gFzPKGz9LEjsPLybpn1dYvBXUwFed54JJgv9twvwbiN3urTRxfw893P8HyaqW
 SLdpRZKY9hsUoXzjR8kBpws/qi8Tq3VWYCHiejdSLRdWYN9qlb3IvVEV+EJij35HzIPN
 MN445zd9g7xflVv/R9F7fYiBipeGLPGLA2qDjbe6zw+YUg3XYVLW/VWRfdAXeL7LkAnG
 gZod9r0Mn7XolD835UYfQH2WYV4eryEeTbknIKCOGtaN+qnw8n1sUHEQsx8ykJ8HWZWl
 AsvinkrZgu61gt2YPsXj0lmkY+FKjfLbPVVZf3CokcwWCqldSgf2WB8Yrc6kSMXl/syw
 KIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791940143; x=1792544943;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ipqHFctUUnJba3gkprYkEQLsowt56vuRbcAD+CEIEPs=;
 b=X+hZgzrsOKNBzS6RAi4H6qZ1FunokWucYYONyVGDFNR8xBHNnlE7rAQ2ON6Fw6C6sz
 TaZlmiE15/nZ0wria9QoYPGvxiqLRWgwA520byzdlWpo7X107x8VW8mBCsQyW/yO1/8p
 Vnd5A1eSIxrd36nyEeorO8zB06sR1jOejspnF+QPZwOVdI1IO85vV4ndxWszmsmuLKgz
 fzSzh/jLd/jjifgO+bZSk8BXpUMNP0yEWaPTWZIhkECG1xkT6fvAvIrGjIY0L+PBJuMU
 xTXySLC7Y4Le7E2bJ3Ffmk1uQZc/j+ltlRIkcc3fRrwkT7Py1RzqVUu3df1x2sAAvlAu
 F6CA==
X-Gm-Message-State: AFq9FYJoyTjVLq7B7pySD0FYFRc7qhRVQ7322u0I3ctA0+idL4+ACUYj
 zCLRUPe/y2WjuShwuBsVC32voGowltrIz4PC8AeVFum+jShJ8hjqb5GiRaj6lV6S/fQp9CFRUk5
 /iV9mK63tTzqCKyrljv8jwf6vz7anK8boAWuea7EWzj8WrlFAEMgyGhgXlQ==
X-Gm-Gg: AYBFou3ibjvwW6tULdzsRWfq/KaCpddpZLnMSok5B7ZSQnOXYP8itCx2DCDW3mmEaEb
 I/LLJuVBpcRF6VUIKD5tqS4Q08h5h46iYlaep0G2rE005BMZzb5QRx1YLMhvHRdDnVww4g0ahyY
 ZoKI3UywrQUBZCBCPsn1I9su2AjQBEmKr83dgWZm8xBSi3/Y02tJLD7Pd/HKBWlRFf0zKNCU8hF
 tgXbRTF4wSHJIeNx4AZYUJ75eU1+4LFLq1Zf0hIZ1uBQKPIG9/4SG4ZO6fu997Hagr+oPyBaqv3
 619LPB4qlPL6Bf7kFa7urVSIbY5t5qeJP59mUBQ5emhFBMmuHluCosESmUnjfSJiTMGtNt+LSt/
 Ob+ssvAP3/foTUmWaJnpMqs1ENoiK8P2N3+nIWaAvpN7snvik+6havIYYjFVyxck7v3IJ8w==
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id
 a92af1059eb24-16a63b2edc7mr27704136c88.47.1791940142600; 
 Tue, 13 Oct 2026 18:09:02 -0700 (PDT)
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id
 a92af1059eb24-16a63b2edc7mr27704006c88.47.1791940140958; 
 Tue, 13 Oct 2026 18:09:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16997c21ff3sm41743259c88.2.2026.10.13.18.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 18:09:00 -0700 (PDT)
Message-ID: <65f84e82-ccb9-453c-bbe3-beafc8a1f49e@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 18:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] releases: build and run any QEMU release easily!
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, mjt@tls.msk.ru
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
 <as6d-7bwBOyz88hq@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <217d7743-f441-444c-9ea3-7de07bdd3b21@oss.qualcomm.com>
 <as68xiVXLzHVdpvV@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <as68xiVXLzHVdpvV@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4g4T1HZEQzd-xqyYNmSQ62LPkdzHPwvB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwNCBTYWx0ZWRfXzj64K1Iydoui
 GTG2V9Yo9P9T0qD2Jbawj8+ETb6vpL1DPszka+uhbQIIFP0+enzpdX3Wny2aPuRGnUZ2TcbTVkd
 phSMPbhxgXzCqmHdMfwqZj17UvYkqpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwNCBTYWx0ZWRfX1+XCC2swxX/P
 ZVC+kTt/KqU7BGj+H/CicFR5ObZruHNcrlqgQcnyxtKgdQX9HcYdFoWah72ujgIcLAAgZvGYVMk
 0sy7M+yftqrbmf06+XoUq1BEiDCGiCBvwITpmb1l2VZ5yBICrJXoh+vua8C/cwz4+opkoYsHTjh
 RHpS/clMXp5FBmdK+Hn0QgfYJ7O1cOJx04caN6duYxQQJJfi2OGEwRKw9mtnphL/H84sf/ScakW
 cKhEYrVq47MiHG1vy1/XRHBCcVnuxXtkHsB5bmDVMKR9vLRwCd3gtN/e/DwESELI9rh4fEhCstI
 +HYKU3+8wsFwm3/p7LDMNSQJadtZe4ppxh7ezXR2CuW9iHMb4jApwtsWnpTLeFqkHrXqmasqDu+
 uwG6w8GCRyPQt3MpCRb220YBuV+Qeghdi85rF2FHCRcY8CNA/DOdHks6bu8vs4Em0P9xq42TOi7
 pJv/23ye5W6uNmanmFA==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6aced62f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=3XRGYvhMMELV_IQppK8A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 4g4T1HZEQzd-xqyYNmSQ62LPkdzHPwvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140004
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

On 10/13/2026 4:20 PM, Peter Xu wrote:
> On Tue, Oct 13, 2026 at 02:16:47PM -0700, Pierrick Bouvier wrote:
>> Is there something specific you would need for migration purpose that is not
>> covered yet?
>>
>> If we go in this direction, and decide to host official images somewhere, we
>> could even add the wrappers by default for all builds, so everyone could
>> have ./build/releases/vX.Y/qemu-* scripts generated by default when typing
>> make or ninja.
> 
> To me, the build container would already simplify things auto-select the
> base image, making the build smooth; I don't have personal use yet for
> official images.
> 
> I think Fabiano's testing env is better than mine using this similar
> approach, it's just that I hardly hit a bug, especially, QEMU bug in the
> past, that breaks migration ABI in a way that A<=>B works, B<=>C works, but
> A<=>C fails.
> 
> Here, if we make A=master, B=release-N-1, C=release-N-2, then the migration
> compat test in CI (on whatever migration-test covers... obviously not full
> device coverage yet) guarantees A<=>B, and then B<=>C too in previous dev
> cycle, and so on.  I expect A<=>C works.
> 
> I am assuming the ABI compatibility chains like that until very old qemus
> when Fabiano introduced the compat test.  Then I hoped we had good coverage
> even without a large matrix of qemu versions to test.
>

Thanks for the insight. I don't expect we need to do anything with qemu
1.X, but it was free to go until there, so why not.

> I only need to do a custom build in extremely rare cases.  There, patch 2
> should be very helpful already.
>

Which kind of extra builds do you need to do?

If you find it useful, we can add a container build-arg for qemu
configure options (empty by default), so you can build with debug, or
any other option that might be useful to you.

So it would be something like:
./scripts/build_release_container.sh v11.1.0 --any --option --you --like

> So I'll leave that to you all to decide how far we go, or whether we need
> to host official images.
>

We can see what other people think.
I think it's a nice convenience, and I had to build all revisions to
test the thing anyway.
In case using prebuilt images is an issue, I would be ok to modify
wrappers to a build & run action, instead of a pull.

> Thanks,
> 

Regards,
Pierrick

