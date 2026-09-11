Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D425AC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52hK-0001MV-U9; Fri, 11 Sep 2026 10:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x52gK-0001C3-6p
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:56:55 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x52g8-0004ph-OZ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:56:41 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab19127so962239d50.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789138594; cv=none;
 d=google.com; s=arc-20260327;
 b=QGeHyKgtWPSg2ySgzm6Hu7SwA3UcPbGJzQfKplv5Gxc+5hZy1ZDENjdnRMA26pFNSN
 Hgzl8gJmK5hO+o90PqwRaXExYvusVrLwB8uLUZB1maLqlo4Dvv8UrdodSf8CnA0Vf8xd
 RiR0DWFdzqRPv16zIkBhyrBIiUpx5rBa/PMlKmhrGv2r8C/kWcgAMBnl0INfBa+CdvCT
 2WzsJLrN25EeFjE2TizU2oiF1kr1jeDBZlVIVectRm8oKciGoBAUH+gF1hpxdXlixGKp
 XeanzyegEgOnItyzQ+u2EQaDaUcl+446a62Lsu5m87VNTzZY699XZYzTUPXZg9HQQmdj
 iMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5t14kjtkJw6ulLvN85ahqL+1Cufqnue3EYxXJNtvEUE=;
 fh=HidnfpVwaz4PUPht7rmf3MlxCIPg9y56uyjQMwGFtuE=;
 b=f7BPmTs+la4kFhF6yW67A3Lx1m82QmniPh6A+OZ5liUEPojS7NPigsqfOopFO/hPBK
 D5Yt1rQ0oqxV3cfgr3rxdwY83nrtVWTvZdb/WF3V7k5WwsuDnVwHqSwQf+yzqVCPcZvT
 yIX41V+5zxcHTWwcR+TFwjAaFpKXkIjJmuWFI9lzo2uiiSkIpaX81Qrk0gLLFdU9P6C0
 ungKzgyYna93bruvnwgvRbQEm6FaAtDYMdiyL9+IlAkU8Ng3jgRcqR2nF20CYjcyChPV
 IbrfU9WVhwMu1WRV6I3PZsyN7rfhciQOvLyC414IRw/tZdVczIqhfljUEYMFSmSUJR3g
 5OEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789138594; x=1789743394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5t14kjtkJw6ulLvN85ahqL+1Cufqnue3EYxXJNtvEUE=;
 b=GZl6/3+/gveZnVOGWwSK2wfiTF/7ye2ln/+Z92lJbOKFP3kdsBM+Aa6140yqx4gboU
 wriPTMqV1s5i4hEmX2H8VkBrBi6MqB+2nf2A1Pv/eIuthpBxNDyd+tvJD6i4eDfnvRbh
 ISbK+NffQ7AaTua6jeh86ceJATu0VbwGMuPvTV8QRSf3sUc2yMc11ZjgesQVl+zDQyoz
 kZNgBSYtKg5F7fhuXNsF6Z2XFUDvmBAPAEeCTsNaMGeH4G7GkyqPJwfT8218wSuHLpCT
 FoUSrupVMR1vwCEfhn5vNC8xJSrnqoQloRwHNLHhyLR5HFmh3Mjh41yF5vQSd85exR7/
 4KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138594; x=1789743394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5t14kjtkJw6ulLvN85ahqL+1Cufqnue3EYxXJNtvEUE=;
 b=cwKucK9yvko30umCbGWEucVcaSeEoQK3NPRG/7o3hzNnsKqU7SvYK/Jn2eDwAAuXtG
 bJt9sfWaknai3YGRjspWOHswp+45Sm+UA58+U6LrrVZ3+j+ymRdoTLBwPVot0nKnhu4/
 ZCkzN7SXR+A1Xa5LN9908ZCwR2F3Pe4lkOyPP2QMKykH9ezFWFHEuzHg7XXZN6/RNGl7
 FBtaFa9qjL9Q4fxodnaEoWhW35WTev0cCUaw7aEC5kvmdJdPchhMSUi23uHHvMW/TmxT
 CZp8TqLq4l2Q5NQhK2EyOSfB/TyKgbQxGQmz3/LY8vzwg48qaPfCrWvnzGoU4168KjFS
 SwOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBygkOh/QD5lfp4U8dFnqLJLfa9I1erWDsLr1R+GuSaN7vXO8XLb6+ohc9flOmvnRE8jCvICNIXSMX/a@nongnu.org
X-Gm-Message-State: AFuF++n+u/g5bGwm/y4++CkfoQh4kklY+HAcTRNoxl+CF04pMBMovCvI
 lY4ppl10KsvR67f121Pv96nQNxDQ1LefywqsKXrFO/5t/hGlaQulKQNihA7MYMPhe15Yhh5lWcI
 idEdZXU/3bOY2b8h3G3+sPupm/gJzhlQQDIFtp3AM5g==
X-Gm-Gg: AYBFou1i0yLqvfnIINI1B/OqCNFTaZjPtVVISPwOvhnpmBXW9uk1NHTj2EWxnvDp7tI
 Wy6YEEqVNYLukxCZnfD6Zhxu8B8l17m4oAwEjMJs1rzjX0z/WjkU89WcOaumoEodTFYU9HaZfEo
 l4L6Xks+ZOIBn6AFwIFBx6KFK9tsrpkLB4FKCcwqYmpA7R2/rNDKaTAiJUFelRHrN3B5qjzSvat
 67ELtK8qauruIq/yK+whGGRN1gbPWQ4TASUkzfoGj/ay0GgPxRp8H5hASszqbD2QcdibVYFwszD
 yUN3NSl5I9My144bE5BYo3NXT86JKkOo1/db4PjJRwKuR6qlKa6/8Xn1DTOh1xe88s16eIKt5Cp
 BzGPKhUtb+ch+4cWMmdIaKnaXfS7cTfdWwCrGrYU=
X-Received: by 2002:a05:690e:16a0:b0:66d:2cd9:91d with SMTP id
 956f58d0204a3-67124752923mr1952365d50.50.1789138593729; Fri, 11 Sep 2026
 07:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <30ec634b6072ac23c38a6a05bf3f90de4b383632.camel@infradead.org>
 <c9a719c9a67c9a32ad566a0255d24722e760a622.camel@infradead.org>
In-Reply-To: <c9a719c9a67c9a32ad566a0255d24722e760a622.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2026 15:56:22 +0100
X-Gm-Features: AcwNN1WWJyP_KhXTQufc5rB9sU8U7M0jxAg592d46t3fVacxoF6HjMSZN-YPQQQ
Message-ID: <CAFEAcA9WAARKjyim9HkYWQA9L45L27NNhxvCVw6CkH5d9pgiYw@mail.gmail.com>
Subject: Re: [BUG] hw/xen: features published after InitWait since 240cc11369fc
To: David Woodhouse <dwmw2@infradead.org>
Cc: mark.syms@citrix.com, qemu-devel@nongnu.org, 
 xen-devel@lists.xenproject.org, sstabellini@kernel.org, 
 anthony@xenproject.org, paul@xen.org, edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Fri, 11 Sept 2026 at 15:39, David Woodhouse <dwmw2@infradead.org> wrote:
> I wasn't *actually* setting out to comment on the AI policy today  =E2=80=
=94 in
> fact I didn't really have a strong opinion on it. I spend enough of my
> life tilting at windmills *intentionally*; this wasn't meant to be one
> of them.
>
> Letting the tool reply in its own voice and pretending I was held
> hostage was mostly meant as a joke, as *well* as being the only way I
> was going to look at that bug today (it would have taken me a *long*
> time to do all that testing of old and new failure modes, finding the
> net device path that *does* reproduce it locally, fixing the other
> problem with that, and finally confirming that it all works).

Even our current strict AI policy is fine with using them as tools
to help in debugging, testing, and so on. What I am complaining
about is not that you did that, but that you posted an enormous
long apparently unedited pile of output from the LLM, rather than
using it to do the work and then posting your conclusions. That
is asking readers of the thread to do a lot of work for you
(i.e. wading through the huge email to figure out whether the LLM
output is right, wrong or irrelevant).

> But our policies should be based on actual data and the holistic
> outcomes they achieve, and this is just data which we can take into
> account on one side of the balance, even if the other side remains more
> compelling.

Yes. I view that email as pretty strong data for 'even a policy
shift which says "we're OK with accepting some kinds of AI
generated code" should still be pretty strong on "text intended
for humans to read (docs, commit messages, mailing list posts, etc)
should be written by humans"'. I think that review commentary on
Paolo's RFC about a less strict policy tended to be in that direction,
so I don't think I'm completely out on a limb here.

thanks
-- PMM

