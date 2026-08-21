Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF274C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKvg-0004PG-Hb; Fri, 21 Aug 2026 04:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wxKve-0004Oh-Qn
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:48:46 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wxKvd-0001u6-6f
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:48:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so117915366b.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302123; x=1787906923; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YDUT0Dvp05ORIBmsZR8DplPeSIH9VmR8r20PYFfkxX4=;
 b=IOPqohyBtIkReKQnvowD52r62ei6RYkdK/4yND1p/UX5e6h3G40dNYopI8WAPXpom9
 LMLNvtn18JDnn3jLIABDM1fbXT6KbDSPJFDPIqtqe/VUR41uPC+nlWKKYvFzzmWtKiU4
 1acx4Z7qXMjMokldCmjbSK3EFjUhf7XQmTRXP4i2U4CdDA1PsZrZj0txm3QEXwCMnF4G
 5eoOs/7BYLCmoTrq0tyRmEB0viv/mk/NmfHU3QbCQL6G5tqT63eNFGNJCd08Z0Qgic5l
 6AlXVcGmnkZiOUkVSmBHQ5raVcNxT47vUhN0AU/9I81kOu8wDS+wt1NKrAswDKIsrejX
 f2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302123; x=1787906923;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YDUT0Dvp05ORIBmsZR8DplPeSIH9VmR8r20PYFfkxX4=;
 b=K4R7rmLyKj26NDZgzERbrQyyMcRylBDrBSfitmk5e6PPMHIpBn9T1jaxTAciM0fLKs
 2ChrAQRSd0KLPYJUylumYEJ2mQlCxOAS7GkPe6KfY2eZ8YtHN+Gekaw7h65voxLH6kta
 SLHs26dyFNzeKSIPaUqeY0bT0FCa9KIZaCRWg+QxAHRJZ0eXCXDcoN0hPYF1zEyCZ0Mp
 8LXPdLzJbdRG5pjGNK2S1YGw01g6Or/bd4qqlXDHfhqxttEqwrJbNsuFafixim78VUkc
 yBdpjNyfQz06vbafpIwe2twyFPvjY/961OvgIs7GEqaQg4rqQWvE6E5jccfZvJw43jex
 wNCg==
X-Gm-Message-State: AFuF++nBkwkiLBTpb8rZtCP+9tXAURk91DLvHd3Snqho2+qAuqnHYiJa
 GOJVfN/US5XyWHoNiu9yvaghdgIiNUk/W+7Xw6CyAJ22IXHQXvvlNEn2hYSRlqfQWqM=
X-Gm-Gg: AR+sD13NAZEdW1EB+qqPk6VVOvAGpXb3FKfyFKHVGKeAL6JGSalMA5+OzoGa5ZhyG77
 JDjXS5eemTy2AJ8D8f16cRsIcsOEISaqXD5PC7TyrZN1Qsnh2eWLswoUfilmGNwbWc93Jo8Iboe
 lgF5IUxf2Xv0XSlLGq8OCaJTTxT3MXQyqD1027ICjWWRwQsKzZJ95ElPy56sqfV6wGf8UyGf9v4
 EcI/Umi2xqH0ITEmIMc4gW92mtM/OQSg2xqrmlvBVYm7RUZKy3TX+1nvSMMto4u4mjT3AaXOERY
 ACmd17kD+H3H5p2BNXSGxzsIFxkyNvbk+3cw07UMLTeinbobhWF0aBxC7kUSiFjSXqwdG8oYQDt
 zWy8bG2bJAbvp70VljnKnXey8A0bc3JIIR0491NG1+3eRQevFD+btkrMvCgYkfRkapuPz4Oe0Nb
 wRAYVgtoI40/rcGAVWmPd33ujKKB5AfCaGOJ6/Pe2s9CfytrT6myjcj187ZkLc
X-Received: by 2002:a17:907:3cc2:b0:c24:680a:1c42 with SMTP id
 a640c23a62f3a-c246a4d3bb6mr494297066b.7.1787302123153; 
 Fri, 21 Aug 2026 01:48:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b094c4sm387156066b.22.2026.08.21.01.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:48:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40A7E5F809;
 Fri, 21 Aug 2026 09:48:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests
 if target Makefile is not present
In-Reply-To: <a5860c50-9839-4b46-8b36-0e4f4ea3c130@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 20 Aug 2026 12:18:30 -0700")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 <87y0e2p4hy.fsf@draig.linaro.org>
 <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com>
 <87ecfsppz4.fsf@draig.linaro.org>
 <a5860c50-9839-4b46-8b36-0e4f4ea3c130@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Fri, 21 Aug 2026 09:48:41 +0100
Message-ID: <8733w7q2om.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 8/20/2026 12:10 PM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 8/19/2026 7:30 AM, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> In the next commits, we'll port each architecture from Makefile to
>>>>> meson, and it's easier to review those changes if we remove Makefiles
>>>>> step by step.
>>>>>
>>>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>
>>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>
>>>
>>> It seems like you are the official maintainer for
>>> tests/tcg/Makefile.target, thus I'm not sure what is the Acked-by
>>> semantic for a component you "own".
>>=20
>> It means go ahead, I've acknowledged I've seen it although not looked
>> too closely. Generally when a maintainer acks something they trust the
>> poster taking it forward via their tree/pr.
>>
>
> That's why I'm confused. In this case, I expect you will be the one
> sending PR for current series, as you maintain tcg tests in general. It
> can't be me, the poster, as I don't have any authority on this
> subsystem.

I was under the impression with the rewrite you were going to be the
maintainer going forward anyway so I don't see an issue with you sending
the PR.

> This series will have to go at once, we can't delegate all architectures
> bits to sub maintainers.
>
>> Given its a temp patch for the migration I don't think you need worry
>> about having more review on it.
>>
>
> In my mind, it was expected (ideally) to have a reviewed-by on all
> patches before they can be taken to a PR.

I think we are almost there. I'm just looking at the prot-none
workarounds at the moment. Have all the architectures been acked or
reviewed by their various owners?

>
>>>
>>> Do you expect another change to be able to send a reviewed-by?
>>>
>>> Regards,
>>> Pierrick
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

