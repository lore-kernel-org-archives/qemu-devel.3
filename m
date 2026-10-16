Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12977CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 21:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHpKQ-0003Pk-2Z; Fri, 16 Oct 2026 17:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHpKI-0003PF-Bi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 17:18:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHpKF-0005vY-3u
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 17:18:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJep6s3179137
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 21:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MXtrz+g5Hj0ZqJRpeal53ijWk7NUeWrwh3cRADuKo5k=; b=U67BA/17b2YaaF8C
 ZkM+cLU4mJBOtmh0+rgnlPuffEX73jk6YXvGsukRTO2a1Dw7YynHjlpAXnItOPT7
 pi+KiRd4tOSUho6U7jz/4HZme+R/i4fcnn8HwRO22L+8tszv/PpMnvbgmJlJI7tf
 PKxCUkUcZBxWyNIAhXiT7UJ2SVqDGDqd/PyY/pNwOFPfbk3bt6WJEvP5wRqjcURM
 QKizJJs5Ea6Yg4zcclGGXVbLVoVBR8WggMfGqvRFh24dCDYJoflB2pLWBBvgCNDw
 841dQ6qCoHEHMLVvNCf9QQlFIz5DUjwaV/O/xcKCRZSAwEDjZ1FPZE7DSrcVcfuK
 6vVxkw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5ytvqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 21:18:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso63083585a.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792185528; x=1792790328; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MXtrz+g5Hj0ZqJRpeal53ijWk7NUeWrwh3cRADuKo5k=;
 b=KsJdKTmpNieGk5zbtAtL1sz3i9lFMip9Lld8K7Hf2k2PfDbmHTMdW981VxEUHuzcwH
 p8w3TzpF1gghXcfBy1Ub9+cfWC9GJCSEEx3mh5uhkeOX765euovtiDXVpbBk7016uUFQ
 /rgpca06kHvq5k6/YDDZBU0jbg7ocD6mJ4juDIMd9rn2gRPu374KOZ2FNdtbtAzVpGPQ
 Pu5i66+JiBe9mhd4L0+hMtE9U3rkdTMOQ+mrAFzIpck/R7MzcKeuXmfdlalWMbs9lIJb
 tgSg2yMDJrpqFia9S/zg1xU54sxNz0r6Lp2UxIIPt/eBXLiNP80uj4n3Y0gfLMbEqXsG
 iV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792185528; x=1792790328;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MXtrz+g5Hj0ZqJRpeal53ijWk7NUeWrwh3cRADuKo5k=;
 b=tM1ZBJ5E8n/MsjCaoJEyfTs6McnPnJ1Z70gtL9WDypSBcCVkFakH0kVJKi5JJ5WEBO
 Vg27jrCP2xRWI6+T9qARRwSHEYs8Ks8ivg+iJL87IkHTekmIs1j7v6EGQp4+a4htB3c9
 uW/sS7/SB0OLTiE+vam9o3vFIS/1Nz3UvtPDzAmL2JaZt3aTyEcixnzORrKHNHcm6fl1
 76ewGYT8TvDTLUVgtzAVzrKmrO8vtZd4wlDm4OY/85ljDfvh+Riz7+/SSAO2PrsOnHsH
 Mvu5wtUE4ei4YC2I9dU8FzVkDT5j+FmXJt8joSHUdX/PYF/ynHBh/tr4dbQnzbw01Ome
 0D6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhkajgwqWDAFB801fuysQuuiwOFbniPtWkanhh4lVUD2+/2GMMViwz2gP/HKlFMd893uT6LnajeB1v@nongnu.org
X-Gm-Message-State: AFq9FYJCj4VPG7ekVdwiIkOQMDq4Oo8dSmttGyVJnHuZLZBshVwcww6Y
 5gtjW9J90u4x+n15OO1ogcQa4049ALGohQXpYsV9fYGBDO7kpszxtnCz3CliuYW0H8ZCe2kEXF+
 lN2+YJMEDy9QkfBDy4oXYo/xXS29W2MkokCuuEHQHSGsAfU6J2DtqEiiBpA==
X-Gm-Gg: AYBFou0i2QusDq9n6YJSevAK4XhNn2ff4Z8VMyG9Q5iJjCf+wkDs2W0K3np9dzlgr1o
 mgLGC7BuVxniCcezotmVkDggY/1vg01MeNj8TmgrFp8ChNPU81FNBAwEZjJH17+RRB/ljvoEqyu
 fQ4jyM0XuC+r1nBtE43gf5LQIWFhJpNRmLutWaG25gOhDsgK2nt+Ac0fanfZsjLLZa7BShwUnGK
 nx0I4bU5JxFongJBUPo2Z41M6eNFz+dBpVOz1Bu9aDkVAZ8sEPUaMh9Y6g8CmojGX3FUWpjhB+R
 ujTMuOh998Eg7ePDFGzz1alzWLkkXpKoobVdtlaURr3NflYlcU0kuNNXh3j4hOvFeS4+3vStrJd
 RYOIKa64vBBqF6ECuxfx8itI7YNP+/pGJYAE=
X-Received: by 2002:a05:620a:294e:b0:93f:24e6:403e with SMTP id
 af79cd13be357-93f29d6fcfdmr194936985a.54.1792185528140; 
 Fri, 16 Oct 2026 14:18:48 -0700 (PDT)
X-Received: by 2002:a05:620a:294e:b0:93f:24e6:403e with SMTP id
 af79cd13be357-93f29d6fcfdmr194934185a.54.1792185527652; 
 Fri, 16 Oct 2026 14:18:47 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm64723485a.23.2026.10.16.14.18.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 14:18:46 -0700 (PDT)
Message-ID: <44461a91-015e-47cd-a84d-611526a9740f@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:18:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260930085433.830743-1-pbonzini@redhat.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3hYseYBxknBBokcbq_smodQE4rZe1qBC
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad294b9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=bO4EEU5oiNorYid8Rq4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4NCBTYWx0ZWRfX6anDRW48sl0m
 dUL6xIgxJ1rc71dOS2oT38xHeM9LC5sVNhzRvAuTwOdNFy+OX94Q/TDUmxoQR2kifw0qEQA8YDI
 5YYvF5hypD8iqid/hDpbc2uD2PjtiiI=
X-Proofpoint-GUID: 3hYseYBxknBBokcbq_smodQE4rZe1qBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4NCBTYWx0ZWRfXwhLvHPGxMd8t
 uG/21dO5ZCmTcxIPqBgehxuaGjfGwO6CdQOPiFwcbH+BPTyWzi0A/psn0zOVsrMZyTqrCuEwDkW
 wKbKm72r82sCPwsnnHB3wK6fJokjkUxP39Eh3UV6EkD0BMAsKFHIGDdqqNVCwMSOZimde2xlyN6
 c6esictLB0TECf8xiR/j0eMynvRvP+Z7cuBuO7EjQvbVf/rwyhjeNknN61QX8hkZSj3Hel1ITtt
 fJN+pr7Q0kzvFtkREoHwI574GjcQHuFy44mlMGNshrKfG2W/1wfBdNaIXSYep0gHj+UkIlnAfCU
 F+dK5LIR6rF65wnJX/EYhWmfuRvhrBbCC7UEKcnezuDo9dUT2HfvefuOxKMGrgJMwZ2y4v00MVX
 jhU3ERgG4XoscIOs7Z36mTJXKTa78xOFFz+8PfuOTSDkPE0cGMonzcvK6c8hfyNmZTE5WDNzA71
 i/1vY/QwJWhOhjVS8zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi,

Not sure if this belongs to the changes made in these patches but can we establish
some "rules of engagement" in the mailing list discussions w.r.t AI usage in
replies?  I know that patch 3 touches on it a little bit but I'm talking mostly
about mailing list email.

I've seen several cases now where we have an apparent non-English speaking trying
to engage in review/discussions in the ML, and some the discussions are a bit off.
I assume it has to do with human reply in English -> AI -> translated reply in
language X, the developer reads it in X, writes a reply in X, then uses AI again
to generate an English response for the ML.

This works ... sometimes.  And other times we have cases where the developer keeps
sending the same stuff over and over again, and we're now wondering whether someone
is being cheeky and ignoring feedback or if the developer didn't fully understand
the feedback, and I bet it's the latter.

I'll assume that we don't want to forbid AI usage in ML replies (might as well just
forbid AI altogether in that case), but can we ask people to let everyone know in
advance "this is a reply generated by Claude"?  Maybe a tag in the reply or something?
If I know I'm replying to a bot I'll refrain from write things like "dwell in your turf",
or whatever lingo I came up with when replying, because I know the bots won't be able
to deal with figures of speech or pop culture references and etc.  If I know I'm talking
to a bot we can make an effort to use plain, boring and direct English as possible.
It'll also align our expectations w.r.t the interaction overall.


Thanks,
Daniel



On 9/30/2026 5:54 AM, Paolo Bonzini wrote:
> Based on the previous discussions, I am finally attempting a non-RFC
> version of the new AI policy.  Discussion on v3 introduced interesting
> points on attestation and I think a consensus is forming.
> 
> Why review the policy?  The blanket ban no longer reflects reality, since
> contributors have been posting AI-generated patches or even larger series.
> This was done most likely in good faith, as these submissions predated
> the introduction of an AGENTS.md file, and it shows that AI can be used
> for useful and creative work on QEMU.
> 
> Rather than expecting maintainers to police these contributors, the new
> policy seeks to ensure that AI usage helps us produce better code rather
> than simply move faster and flood us with dubious work.  In the words
> of Warner Losh, we want to avoid "free as in puppy" contributions[1]
> that increase the load of present and future maintainers by adding
> technical debt.
> 
> This is not a free-for-all.  To avoid maintainer burnout, AI
> contributions must be grounded in respect for maintainers and in the
> existing contribution process.  Large, heavily AI-assisted contributions
> require pre-arrangement with the relevant subsystem maintainers, and
> will be held to a higher standard.
> 
> One of the reasons for the old policy was the issue of code provenance
> and the impossibility to certify the originality of code created by
> AI/LLM tools.  The new policy tries to adopt a "Swiss cheese"
> approach to mitigating the risks implicit in accepting AI-generated code
> in three ways:
> 
> 1) by requiring pre-arrangement for larger contributions, and making
> maintainers free to apply their own considerations (see [2] for a good
> list).  Maintainers' preferences bring experience and creative thought
> into the process, and contributors must take them into account.
> 
> 2) by introducing agent instructions that help the contributor drive
> the design and understand the code produced by the LLM;
> 
> 3) by introducing an "AI-used-for" trailer that scopes areas where
> Signed-off-by cannot guarantee full control of provenance.
> 
> This series reflects feedback from earlier requests for comments, and
> even earlier discussions with members of the QEMU community.  Thanks to
> everyone who provided feedback on earlier drafts.
> 
> Paolo
> 
> v3->v4:
> - rework opening text [Daniel]
> - exempt "official project agents" from not being able to post to
>    GitLab [Alex]
> - explicitly forbid clean room reimplementation [Kevin/Daniel]
> - remove "The DCO still certifies that the contributor has the legal
>    right to submit code in general" paragraph, replace with a note
>    that "AI-used-for" attests respecting the policies and is considered
>    enough for DCO [Daniel, Kevin]
> - make the requirement to "understand and explain your changes"
>    more prominent
> - small edits for grammar and clarity
> 
> v2->v3:
> - remove parser example, replace with "adaptations of existing code"
> - when LLMs are used for boilerplate, "highly recommend" disclosure
>    for "non-trivial, functional code".  The idea here is to avoid
>    having to disclose using AI to apply e.g. changes related to
>    automatic code review, and leaving people some leeway.
> - clarify split between DCO (legal right to submit code in general)
>    and AI-used-for acknowledging that the submitter cannot audit LLM
>    output against e.g. the training data.
> - clarify the defense-in-depth/swiss-cheese approach to limit the
>    risk of copyright violations from LLM output
> - mention that pre-arrangement is not an entirely new concept
> - mention that maintainers can demand larger changes than for human-written code
> - do not mention inclusion of the prompt
> - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> - rebase AGENTS.md on top of existing file, split
> - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
> 
> [1] https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com/
> [2] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/
> 
> Paolo Bonzini (4):
>    docs/devel: relax policy on AI-generated contributions
>    AGENTS.md: add final instructions
>    AGENTS.md: let agents know what the participation rules are
>    AGENTS.md: make the human part of the design process
> 
>   docs/devel/code-provenance.rst |  71 +----------
>   docs/devel/index-process.rst   |   1 +
>   docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>   AGENTS.md                      | 137 +++++++++++++++++++--
>   scripts/checkpatch.pl          |   5 +-
>   5 files changed, 347 insertions(+), 80 deletions(-)
>   create mode 100644 docs/devel/llm-usage.rst
> 


