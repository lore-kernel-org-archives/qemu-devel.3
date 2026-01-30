Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB38D73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhW2-00089y-SI; Fri, 30 Jan 2026 00:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vlhVx-000845-ND
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:57:54 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vlhVw-00008e-96
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:57:53 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79088484065so15969367b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 21:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769752671; cv=none;
 d=google.com; s=arc-20240605;
 b=OT/pDOpfqo9TQ+no2jJkvDE9NEZnD74211bmiEd6ZR2zjchTsHw6sHgtKQLed8TzV0
 BRWJO/Zy1kobPTqJL3v/hXNWNu+JuReUTAFVVuovd6XmlKb1DjRu6im8Ke2NRMHRTlRh
 pDFoRhT5ZpcwTm1mEdXAVgOgOw5ZJbhIiZZ/G8c+smkEjmyb2asiHFvM8jdVznNkBJ+t
 kxJ47xZ1wNPYgrQLSReH5h6OMDDm3mJsVr6nUuk+K2ksTFQ7Fa1OoEM7rerhIm4BcAFn
 g7Jml0/Zv9kPX9QyzzqVkcfi7Wd7YTaqOPOAbWFaROUMWKmbK+k/MKw9cZQx4WclzCQU
 O4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cy8OpmMAlqouikF5v13/yxmPYiikxszf0wEYu+dAl3Q=;
 fh=Z/ChBmagr0Yunxz3rPKeskrqrJshrQ1YmuVp9/a/R7E=;
 b=YmGQtfxLPg+am7nbAoLbK7ITd5ZfevAE906dtUXVScEyfSRqUUhtQLgvT/r1/aKAvz
 kCcqsynWlqe2zlYjR2YpHOPNb9nvO+7Ka7FUoh66sk2GmR89OUL6UvuJs9e/yGzmm7Cn
 afDIO+J4EXTTou0aVCQsCeGpwl6Ji3+oJ44S+4krHYNRn/KYV4Be3Z9LGU2Wjr6UnhMG
 kzaDk5AHJ2RwacTbgi9veau6fFOqdAdcIKmWVhRPClNAkJ0FemkhlOgHtl/LtjtAG/oJ
 Y0GqzHeiSK5MixHqo7+sukCXQmMeNZl2v0Gow4mqK6p5yGsboNl9S6B3DVEmuFmDoqTh
 0dBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752671; x=1770357471; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cy8OpmMAlqouikF5v13/yxmPYiikxszf0wEYu+dAl3Q=;
 b=nFnMOyKj245rHMp5nAzxytvGljiU23MxPUASvSb64MSDOCQVGUHtLa1DmopgVJvqN5
 vK25VVbysUUfcdE0tcTYAVmD6BwIwdaCAaDPeevh8TmtSnHfwoqk2/0jUyphywGvSNai
 u40Y7pN6q97sbSZsWbglne0QTdEVfQHPJLcQevrq28myfw5qFExS7zrvDxPGdi/GBK7F
 7SoB+806k1/xzFND24XFi/rjwaOd36QMuWM3436wZr25eieGGInMY5NDBbK6xCX7DO2m
 9KfTq8b9o03OATYSojFFY9Ea2tzpHKGxGKV3JzFW668fS3bsvM7+4gbCk05G3zM6aeCp
 gtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752671; x=1770357471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cy8OpmMAlqouikF5v13/yxmPYiikxszf0wEYu+dAl3Q=;
 b=areQKaSRNRiSofr2J7ZQEWo7aKsbIa0NMNB06nPVBZKP6KdW9LJzrZqqrvlBB8Mdc8
 tnwy8VGnPQB1wB/EDout4u2B3vtItQBW8fHQ0Q5rLIDDlTjCCSkdgriEWMAEwH3cyzgq
 qhxnsCh8An5vScgo5qmMBr7dRSSCXWLs+OgaDpP8Api5jUE24E3Anc4BxAjDXgnlr5e3
 qJ5GOLu1wl1XTm/L5W2SVvPrHRORwy/ajeLstgwpA50b5VL7c44ct5W0tyFTOMNeCczy
 8o5OF7Ns1Plu5CK/AnRVyIRjVmcNNvefbzy0/k2UPPWp/0Y+j1Ats/AVQDaPMM/6wGZa
 aIrg==
X-Gm-Message-State: AOJu0YwrfYfXzFAxQkRUyt+iMsC2DJiC6i+7PMK7w0iJ62WG4yy2ahJe
 zOO04nDpr08NQ6ON/65sUB27ErCizQ883HTG4gu4yVydFjOTxfX01d88MUQdUiq1OTV1rgsX3Pr
 5Tn5CWAZjRNWEbKw/GItVVMNqoiL0RAO9/cQC6JSdjQ==
X-Gm-Gg: AZuq6aL3NGBvh5Kw2uOrjf9ZMF+EKYv8f20p/1twI5CHt2Gx1erg1WT8er9jAmXt6v+
 Vjio49SjxfhYXgv8F1vrss6gpgz8TT9roST1ai6STIicnplC0AxKDclbb/CnV7guPh2vrWcggev
 6ORjGPAqOWYRGnN4EWLsLWXRJe8CImhvtCcCVSZQ5+aDKQsxYRbfcWzjGzxDSlXlAp4W0GbDmNG
 A+JaeltF0UbImXjTNaVNdqUlknrH15Miu2IeXSbSgTw7zqhva59aT7UXKIYAsX9DoUQE1wC3S4=
X-Received: by 2002:a05:690c:1e:b0:794:8f4a:4027 with SMTP id
 00721157ae682-7949df246demr38647497b3.27.1769752670702; Thu, 29 Jan 2026
 21:57:50 -0800 (PST)
MIME-Version: 1.0
References: <CAOkKuiMh4A-7Jo2Zg98Js7cOpXCd7N_B1RUGUr7-=x-tU+=UYg@mail.gmail.com>
In-Reply-To: <CAOkKuiMh4A-7Jo2Zg98Js7cOpXCd7N_B1RUGUr7-=x-tU+=UYg@mail.gmail.com>
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Fri, 30 Jan 2026 13:57:39 +0800
X-Gm-Features: AZwV_QhKhggScIVzVn5pqyTgaNCNCXfSWFLJ28jYcDK5UhShzxDYtsplnxvlF9M
Message-ID: <CAOkKuiMD3t81fYr1OK_9RgkEB-myJydtj3K-A1L9Z4f6rEM+ig@mail.gmail.com>
Subject: Re: [Bite-Sized Task] Volunteer to Fix Issue #3193
To: qemu-devel@nongnu.org
Cc: "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Apologies, I had a typo in John's email address in the previous
thread. Adding the correct address now.

On Fri, Jan 30, 2026 at 1:52=E2=80=AFPM Choon Keong Teo <ckeong.teo17@gmail=
.com> wrote:
>
> My name is Choon Keong (please feel free to call me CK), and I am
> currently a university student. I have been following the Bite-Sized
> Tasks page and would like to volunteer to work on Issue #3193.
>
> I have reviewed the mailing list archives and didn=E2=80=99t find any rec=
ent
> patches addressing this issue. I found that the property in question
> was converted to a machine property in a previous refactor, but it was
> not assigned a description string in hw/i386/pc.c, as noted by Peter
> in the comments.
>
> I am currently preparing a patch to add the missing description using
> object_class_property_set_description. If possible, I would appreciate
> being assigned this issue on GitLab.
>
> Thank you for your time and guidance. I look forward to contributing!
>
> Best regards,
> Choon Keong.

