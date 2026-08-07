Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00700C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKNB-00020H-Pa; Fri, 07 Aug 2026 09:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsKN5-0001zw-Mk
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:12:27 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wsKN3-0004YB-KX
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:12:22 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81e69a2db34so54374057b3.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 06:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786108340; cv=none;
 d=google.com; s=arc-20260327;
 b=lyy4WENHHzIbVww9EECQFXOXHUl/e0iMdYE6xXhEUDVvK6g9bSlUu4MhZwG50MQ1Yb
 wefCYPU5DbgdeVYgXP48vnwN7B+MGIXCGc3/XVUHPYD/vN1ZAl1T/RBawdhaVzl+rSER
 K7pQCmhUyb2OHnOH+qduhsN7YfXZJ79At4BJS0nmBZtGsRfpgK1sm3fWEv12PQjtfdPO
 JGFwP8PrqwP82G9hC2YHyVYCYkssVXEtFH+7KHJLwDwoa90+FD0cZJMY1Cdf4TiP30ui
 uTMKL5O7rHNLEFTbjeg0cpPa3mYYuVuJX5IZwIBhiYx02/s8YgxE7F8OpNPFDhhV5YSi
 vtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CK8iK/G1b2VqaxBAxYz3Xk1Z5WkHDabSP7CszsPk04s=;
 fh=luh2pz+jE30peEkvnCOTtp/S2/mwabsJyHcziE/qc94=;
 b=QXIy+/uOjBdoepnhZhUBlYYIPKXdb9rZHBIATNLj/ePPhysZSz8AhjE0P3ZbEuuQfZ
 8BDWRh8t4C7Jkq67nsQa2sshAH7fFP4zNCmldEvjjnYiMbzpm9FYy7Ath3M3Sn51WTy2
 xenshLm+UtMbgWZpdgSQ1hxnbeAvdLzDcDf69/clns2mSYKLQwQsBESLh8zrxQnC8Y2q
 z66fbH7krhOF9oDVX80ZP1mzMbD4l1VizGgPH21xpNXgrZiuIl2ckGMLbpJtdUi2RyyP
 xzNXyqowrw6sAlx8qM4xguYHeuhOdPLZ3P0OhbF1FwfCGS40MqryEo82stdneZUhv2Lj
 vyFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786108340; x=1786713140; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CK8iK/G1b2VqaxBAxYz3Xk1Z5WkHDabSP7CszsPk04s=;
 b=g7WPpvoHPzlJzZ0Mfh0saA2VnmEgtJox8vrryrLNYhiRzPZuB5O+0iSrXgCmKM+GN0
 h/jbBEZfpuNgycTlSl/sm+HR/bLB3/4MTInZyih44XCiQA7IjXiZ4gRkTmf/6uHEX7eG
 FijtkiIqyWLNHh24M/bDTkeO/id7kI3OOq6F3Til9CyRlr2ZYsp1p6edHLZztLohKbDW
 /nfyG9ePB7kJAgm3qW16LYuuT7pMC6HRatHyM9ag6K+yxEKnFWDz/TkK+ynsF6myAMVl
 abeZ72v1+iuhKah1/sIhbyp1S8R7F/bywD2MVu+C1+w2VXQfomW+Lx1aguJqUPtgsnHC
 3RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108340; x=1786713140;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CK8iK/G1b2VqaxBAxYz3Xk1Z5WkHDabSP7CszsPk04s=;
 b=WgiJ8OH1HfQ/a6GDrn+KLI29bUYwishCyyc+wew19CWqrGLXrVwg5Q715qS0OYfupd
 VQfZGSwy13TrR3Wi83sMQgGBd3wjPTyQGQgndpg7PIlK5TSo+Ek4pbGrTMuQ+EzxhLnC
 RzYG4iSj9AWhUdqeygfK2WsgXkpJT7UqiopPl9+36/uRg5yqog8zVC5jYbDZX0IRPj0Z
 EvkyL9T/gRM5CEyeeYo7bdyHMaes6MyY8NDJe2rbGWzapHi8ycUpNigxy4OgJeGBLjri
 jrxd8tsU8oeJrftjSbEhkqapyL17PnhiD8xqZRNrGVGPJErOvOS8bjCp0BWqVhK2tZFJ
 pZKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOIWrcn73pI+2+KQ+RmWZuq53MRSa9Wp3fnLXUvU2G6SDJuFcLyJoVhT4jITS0uaV5jR3d3+AYcTnP@nongnu.org
X-Gm-Message-State: AOJu0Yy2l8kgOiMzrantnBwoRtAteTiJB+R2Tfs+J4E2zl/0vRA/34sG
 ZiggJK/fe8V3zkjRFuR8cCrEQhjeLs2YT6EoF8k+0TJvdYTMhjtC/1v1ORdGCF9ymo1swNtT5v7
 egv7osEsCZgjqO9CTFEiTsGfg9hqhTQcfc+nGDpAtlQ==
X-Gm-Gg: AR+sD12DwhgwviyLaIh1UB4tO7cD/mF//I3TO1akFQOCZVkMTwXxnDtz8IqPrdlHHA5
 SVYW8YUEa1+BrfTZQs16OTnIBjlnWgd4AGFBI1cOlol61jjiqq7ypwlBU7Ao8Xec+ZNgdS2Cuvn
 iJQyayM0rkoYhipfQV64I9c4QWFeZhZV5OPuhpZx8LolZQ0e5eOB4z8FQG9uWRuSvRlkCuDXQAc
 x7iHjVscw++Pjg2mam0DKmxVrGD4soGdYzd/jDYnJS6gHm9IjkUtKGC4ujlQso6QtRfpaicf2im
 vPlI5ou/JRpXNbfhB4QXp/DS8TpHDFLUvmqEvA23rOYatrSghywfa6yweZf9t53YEJojVAaRI8u
 KQNimalX/in5uLe1tZWhG/Rz9J9gRbm4OhM8xEhQCwRMqoKyPoZA=
X-Received: by 2002:a05:690c:260f:b0:81f:64e8:d86a with SMTP id
 00721157ae682-825778aa65bmr1714987b3.30.1786108340011; Fri, 07 Aug 2026
 06:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
 <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
 <a8c13cdc-54c3-4913-bc6e-956cbfe082cb@gmx.de> <87ecgfkrg9.fsf@igel.home>
 <anEBr8nK-4nKmuXj@p100> <87y0emkhjo.fsf@igel.home>
 <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
In-Reply-To: <b1fbcbb6-2e04-42e4-80ad-f9b4907676ba@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2026 14:12:08 +0100
X-Gm-Features: AUfX_mxPE8VnG6zbTnpWRme0ljcDatf9OdJH0rtR1D2lv4tgALmm7k4KVdMF_G0
Message-ID: <CAFEAcA8Mof1EDHoF0hBRcu+to0W6ny-KvX7mUwch+SGVgRD3MA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Helge Deller <deller@gmx.de>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 4 Aug 2026 at 07:30, Helge Deller <deller@gmx.de> wrote:
>
> On 8/3/26 23:42, Andreas Schwab wrote:
> >  This "preferred" approach does not really make any sense at all.
>
> Right. IMHO this "preferred" (aka padding behind 32-bit time value even on big-endian)
> doesn't make any sense for big-endian. The lower 32-bit value then ends up in the upper
> 32-bits of a 64-bit time_t value and thus you have problems when mixing 32- and 64-bit
> time_t applications.
> I think m68k needs to follow the other 32-bit big-endian arches I mentioned above
> and provide an own uapi/asm/msgbuf.h:struct msqid64_ds file/struct.
> And this stupid "preferred" sentence in the kernel should be dropped.

If every 32-bit big-endian architecture is avoiding the asm-generic
msqid64_ds struct in order to provide its own, and they are all
exactly the same, could the asm-generic one be made to do what all the
32-bit BE archs actually want rather than something that nobody wants?

-- PMM

