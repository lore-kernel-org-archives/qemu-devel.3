Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3B4C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjHBL-0001dk-Iq; Mon, 13 Jul 2026 09:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjHBJ-0001dY-8V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:58:49 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjHBH-0005jo-Hm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:58:48 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-667971437d6so5145229d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 06:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951126; cv=none;
 d=google.com; s=arc-20260327;
 b=IMVicQhzV/+r1Pbc4PaleGacC+TKcy0eZd+QmrcVfprXC2y8x0Jb/G3GqF4v33ffo2
 9gwGkSwATZhdGOaM/7aKFdrXptWa4h1ZeLqqBYSqjqmyaXNSfIIice2tkusEXHnF/T9t
 i5ZmchuefES48/aqdLSNh4kDXz8NxHYO4+t+EW7Yy1XFAcDq5ScYGz6bbsTJ/dOX/d3y
 2ntBg5aPpCtSNBSavSQmy1Ll8uIDjNI3mCHMu4id3sd7Oul69URMfUZjTpF+6zDd8NBw
 jBhlbMS0DwV4xHMG8u6yzKdq79ZFjMH/IOwEXLLB2VuH7kpZ9rxzNVBUtrKxD/0bWxEq
 7TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Km1QzDBNX52F6CG6DupUkf0a4mF2wNnjrwNaRsms6aU=;
 fh=WoKYLnaPVahO/vQJOSbKBeDgsKDuzfrb1tBWIwoH2D0=;
 b=rTQMU9gfnxp810JyYwYdwgeYKY/EdhNq3Z1Y4uoJJGJLdnxQa6pky2+A6pzk3KnXPX
 lztATMqn/UMJ7uza5qMNsa4n4kv/P7p4VyTLdc8z5WzCN8fYC8+xrsday1MKP6rzkosP
 fU0NvNWt+ODCQ2opRGhnvGnjr2oJOmi446SS665swN45eH35QfJ+ZZYcWrcygOhpjxWi
 DuNcfLJosbbLlfIBhwMeHbjfSZl6bDqA6Cz6zsrT/zMOhAvFCw2mk4DCPXwUXhCp976a
 5M3d50h0RiKRKoAZSL5TxkIGbbww6bnqyDk5DIjYELmd9l5gBGOg2ccfoN2Ussu9zz4l
 o+YA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783951126; x=1784555926; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Km1QzDBNX52F6CG6DupUkf0a4mF2wNnjrwNaRsms6aU=;
 b=jsNMp7P+08sCOru+neduqsNEVP4ihSo+JQ/AdRO25nFpf988eGzQf/k+/h6InEZTfA
 UsTTiJ983seYB9Asnotf/HSs9/CsFM2WUAw24nq6bPMeSiln6drTrckiJIskSsvCJQpC
 us/2to78QlsvcY6Y6qy6qaNy3TnAjXOJxmiOdTNd42IxSpCSi2+/gda0Vd6FEbLQ5Ais
 SH9iKteHKzPkl6AOs9/RReTBzxAvGK5w2I6wZDEhihU2VwnDdR4Tkdepz9dCIF9Tnqwj
 ubtf9vnU/tsvtYXHU38PEBTSIaRkjOSIa43RMfuP55RrYf6kCZ3LC55xVLoU9fhzLXX3
 DNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951126; x=1784555926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Km1QzDBNX52F6CG6DupUkf0a4mF2wNnjrwNaRsms6aU=;
 b=O8pKvkkUtWeJbRcGqTxL52k6Rx/kL6qCmsg0oLo7jjAx0p9RfOj8+TOC4erdm2+2pR
 B+x2QVmECRxAMWdO3IqFHjgsu2L0KVQUxoQP05ahFkCMMERI1VqC1QCsVEJNqXo+Cae9
 G1Ug21VEppnHPRHK0jRuUI8qbAL31UXWcK9KqdqGfNK0bJdbxbK2sWdADRsJofPDmrK0
 ofF74eLWSlBr7opFvyNjnQBM77/K/RLc21IuaXZthPZeC3e9ju9DVVx5xilscnvxzmUl
 M9Kzi/4j4FQqJ9mPpfeegmAMKXdybFO7RlEaiZHt8hnkd98JBbqWwxZn3hvhNR3pNUCK
 xY7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKmpwH4Wib+G+mduj6nurJGQSV9z16OYt9/fLYstnnSvxHgtCt3wbCLV4hxlgpB/YiSFnf3L9JF26j@nongnu.org
X-Gm-Message-State: AOJu0YxmsbSRsi7rcnf2uPvaLRTryYcvk3Mq6RFgxGrpPh0tpENNXl1U
 nVUqwXuo2mblPgRNKbKHgf5WddMSeVKkjP8wJUlZprliPGhnHYGj0MXnT3Q0eBbQGhhz5brD0zh
 zWLsmJD5RfhNkCpXt6SO18lyhc3zHoffDdMvgas4l0A==
X-Gm-Gg: AfdE7cmd+FB90xPUIvdcnJCFo0Qgpner1N10xfkIQ+850f6PqTuqTq952ZfGBsx0fWd
 osYno4gn1gI5GAgO7Roa/DU0/AowI7jzUaFVlvfkA7AcYrsrnoSp1BQUi8C1NJcwO2aOaxf5I1N
 UWWGcr4P4onEuQ5yQ5NBNjejGhfl6TTl+JjHpF4LrHDeMs/Y85oE5PLtC2keUgtlQ34NIOhq5y4
 7GsUU2vgUGApYSbs4ZzzVkN/Hsh3tH+A8IfWBgICweXy6C2IhqQuKjMxZ+y6tNsJhbNxzwLNDH5
 LVjLMUMr4Qyr8nwOyfCTQXQ6mvICESqDTtxQXLlZR2WStOTGU/jaFT92
X-Received: by 2002:a53:acd9:0:20b0:667:8b91:2445 with SMTP id
 956f58d0204a3-667d7eebf16mr5379893d50.92.1783951126085; Mon, 13 Jul 2026
 06:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
 <2c996e76-72a9-4e3f-b732-3cac1554be6b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_E=okeaQ=P4qW7_NE0dZPANYU7QXiC0N-kSqvwahwD1Q@mail.gmail.com>
 <874ii3gh5x.fsf@pond.sub.org>
In-Reply-To: <874ii3gh5x.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 14:58:34 +0100
X-Gm-Features: AVVi8Cf3T_pipmZcAkNSK0J4-VY9wkAFEqqzNMxQ0Ahif11KzOQIj4q_hXJUjQg
Message-ID: <CAFEAcA-rv3ZCBjUc3Z42NkQFV1wHWrxocCeCNAd1Eov7HUxrYg@mail.gmail.com>
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 13 Jul 2026 at 14:20, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > OK. We could make the text clearer then, I think. Maybe
> >
> > "#TypeInfo.instance_init may not fail. #DeviceClass.realize can
> > fail, returning error information to the caller. A device realize
> > method should handle being called again after it has failed once."
> >
> > ?
>
> In general, a function should either do its job, or fail cleanly,
> i.e. without side effects.
>
> For .realize() "without side effects" includes:
>
> * The failed call is invisible to the guest.
>
> * The device behaves as if the failed call never happened.  This means
>   you can try .realize() again.
>
> Does the comment need to spell this out?

If we want that, I think we should spell it out. I have generally
assumed when writing realize functions that the semantics are
"if this fails, the only thing the caller can usefully do with
the object is destroy it". Realize code very very rarely attempts
to cleanly unwind if it finds an error partway through. I would
expect the only cases where it works at all are the ones where
the only errors are "sanity check of property values etc" that
happens up front.

I would prefer it if we did not require this, because I think
it imposes extra burden on implementations in order to provide
something that is not of any benefit to anybody.

Analogy: for unix sockets, you need to first open() and then
connect(). The connect() manpage and the POSIX spec say that if
connect() fails the only thing you can validly do with the socket
is call close(): you're not allowed to keep it around and try
connect() or some other operation on it.

(We also undoubtedly have a lot of bugs where an error in realize
leaves bits of the device visible to the emulation, or doesn't
free things that were allocated, etc. But that's a separate and
uncontroversial kind of bug. We don't notice these because for
almost all devices the response to "realize failed" is that we're
going to exit QEMU, because the device is part of the machine.)

-- PMM

