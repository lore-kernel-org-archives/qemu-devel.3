Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B848BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMk7-0001bW-4L; Wed, 07 Oct 2026 04:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGde-0005az-VS
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:40:24 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGdO-0000et-DL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:39:59 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6dd7070699eso2664908eaf.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791337014; cv=none;
 d=google.com; s=arc-20260327;
 b=CmCKP8EilVDVPy7F9Pj4msZR/g+3WC3ef0NMCLBqR+N9k6dSt/Y74VBJzjAtEkll+7
 0SzsQf/TSGSk6vm95VcNBzAQrPjELCCSHWk8cwLqs4sE5G/rXqi39dpqwgAQoMsofZxH
 8yXcClU+fL/Luw+Xxj4ARqO40IuWyElNdqtCNJsLoI+uKo4B/rXQe8ZToqnKJge2o1+2
 PCIpyCXjYMtJH3h3YrFMH2KS/LY2qqCZwAF55AzibKb61XC/xUp6rkA2btj7CPO5qsNP
 WbURdzS8SQ6d4v4ROZRxhRZpt7YWRdfpTRtcuILY23V1ZrcsG//3Mro6c38mcgeJvt6d
 5W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=leiS/eFLLhtGTpDsq+zm5fIE5F8QGWtKOAaevU6AOz4=;
 fh=ub/zH6y+WPJijJytJEhlCd5PKbYleOIQ1GJXfRlIPlM=;
 b=NnwouCFlZLLArAnNMn7BUCWmUTgxev0PWi8FOvx9uSeZeO4LcFJp0UXajELO02i/22
 g05oGofUhIqhDJ+uVVVB0rpvo9QiekdXIh/Zl8tSlN6vVtqGopSzG0cojM8jYAxZgBJ/
 H3yZ/Tk+xcy4ay8kJQY5IgL78wkLkTwDmbbEfmA+162RQjyvkmbIEe6LlFVTwfttMWpQ
 BFrENRLNWk9/RKL90JUPZ9ZRzn6R7VvNXj7Tfx589/hDW0ue3rU8m62nFvqTeruMRUTC
 tHRAH39EDPAdoQyo+cQ4/UstWjJbTBWcEwPQeR0IJvqVZLNIGEd6/fa/uIOtdGyIaQ8L
 FsdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791337014; x=1791941814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=leiS/eFLLhtGTpDsq+zm5fIE5F8QGWtKOAaevU6AOz4=;
 b=h7XeS/HAkT3dWIPYw5tBm6Gtx5v8QuVP3p8IExf9NxIVwOGDS8weqVCixKuG86LE36
 JltIb5ZkT51yQ50ZamEGT9ZsGMfooRUzelgapBOZFjxz8J3xjD1/8MIICzzrgNi87BE4
 g0VppYIF8jAICK/JsPQC5qLNAaPa1NQia0Y/l8DOwQcNh6lxcZFXmQja3T6tbCQnRnOn
 +XorhuS2ZJTRB3uCT796tRYF7GFrZLb7Sk9zFFlevw6jjVcH+PJxyZNPlyj6qA1x8hea
 WCF85umb7TgArNILYmRi3r7N0J0KzO1ZDKN6J6cv8jGDm5FNBiR7h6FJ6EolOu12GosX
 kSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337014; x=1791941814;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=leiS/eFLLhtGTpDsq+zm5fIE5F8QGWtKOAaevU6AOz4=;
 b=OdJxAVP0jsZ04JI1HOaDdaN0vXE4kUwOgFy+QncL1TWh80xZiEcRG5RNdrWKZcTRFU
 +eO9NIYek8/PfQbZ5B3EOQbvZEPu538EQAhl3bSLpKvcRX79exZup0n2nbidWfKlaKVe
 XUsrFY1Xw3UUOPD/4JyITBCtOeC5Ac3NnD8fFiNrpQ1FMo/4iV/zW/xI3mnCllC5KyLH
 ydnnfBTy6EYJRSX6Kmtcr1Cf37nYbQOni5YYkNkH5cSZGt1fI2FYp9RTAg8sOSqUxE3b
 g4jVKbVp6cCz7Qb13erclBj/MeKMarS22MqK9lmhGZX+xpGJy1ZeNEb4yAPvAj60Gnyu
 VZcQ==
X-Gm-Message-State: AFuF++mAm4rURfxGEFNieoDYexDogtYkrnt+rWV9rY6/0qudJSuk8G0z
 9tU7R5jXGbsBRrEbQLPrA5SzD8+9CDwrZoCGiJyMMeyCpxAvhCBtrTbV/6Ws3kFH+JH5CUlxqU6
 E+X+bjfiBOLWTXVONrTuMvbG93GtHqv5f4miJZ8TTZcB5oOGGvgF86lU=
X-Gm-Gg: AYBFou0zbMMs+TaUOaRmp+6tmamV4fDo9+36XlFA2DUI029HJG4CrUp8v0cg2PECYH+
 B9qm/eghdg04/oK59zSakcKtr8ITCjabsSEABx2QwCazPvfM82YMGDE/16wQTC8mYL2GJ1sQ1Wr
 KqoPdJUENLsvS2B3KZV/ceTG8UBHIuBuuiUkdyPunIXueossKBFXUK1uCvDjHfnrUCnbqv1WXqY
 v5Y1/2JdRTp+cezd2q1AUVzBlcYr14Yjsu8yXoGhLG6UWk5z6ZJfdVnHgObGVqwE60UIYJUso+/
 mRKg5hH5gihNcu7EZtoJERYU8nTcQoHY6Bbt/YULMgvNd86gXk03urwgm109DnIL0T0SydvFsiT
 d+rcPEzWHGSoIup/I4nYgPBr4xOVgG7l/+61sC/JGuICqmw1rAQ==
X-Received: by 2002:a05:690c:e681:10b0:8ac:927:f7d1 with SMTP id
 00721157ae682-8ae94cb53d1mr32268947b3.22.1791284703490; Tue, 06 Oct 2026
 04:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260930150257.408020-1-alex.bennee@linaro.org>
In-Reply-To: <20260930150257.408020-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 12:04:51 +0100
X-Gm-Features: AclHuK9PS3ogLaWJEfdvADGi697oGIeItZrf8AY-CpwfGEO9GeBlJg0L2UVhKfw
Message-ID: <CAFEAcA_3rtOLXvr-pFp2SHdbQK+v2oZOCDLxBvYBRWMCGs2SKw@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: fix user-mode emulation of ID_AA64MMFR0_EL1
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 30 Sept 2026 at 16:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Since kernel commit b130a8f70cbbf9 (KVM: arm64: Check advertised
> Stage-2 page size capability) the relevant Stage 2 have been pegged at
> 1 f(4KB granule not supported at stage 2) by the kernel. As a result
> the behaviour of the test differs when run on real HW:
>
>   id_aa64mmfr0_el1    : 0x00000111ff000000
>     !!extra bits!!    : 0x0000011100000000
>
> compared to under emulation (neoverse-n1):
>
>   id_aa64mmfr0_el1    : 0x00000000ff000000
>
> Update the test with a new helper to explicitly test for fixed bits
> and update v8_user_idregs to match real systems.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4566
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>



Applied to target-arm.next, thanks.

-- PMM

