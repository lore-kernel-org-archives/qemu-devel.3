Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F259C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wkX-0006ex-2j; Tue, 08 Sep 2026 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wkV-0006eh-O4
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:24:35 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wkU-0001hB-9a
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:24:35 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-871c8a36fe3so48611997b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877473; cv=none;
 d=google.com; s=arc-20260327;
 b=OJIIkjRXLxCwFf3HZw88lR6IQ8MVNycjk3QIzGEIjrCexYMHYBwAbF2sETCsu2pToH
 gOoNrkJQE7t39r1P0r4W7+yfQqiRT2/s0NMxPDI87Bs8KR5dv9kN4IqH5V485pA4MM/h
 rlNVVeDUorwlUgzvsToFE4D0dk/+te08D3wjquSJuO14zgDHVb5YHRjPX68RXCvPqQo6
 XyQgMC0/S1r/HI4QlZd4lC4Fvnv9tFQBJenO8epH7b7vxpTzYYBTaoOQqwSa9KVDItti
 WTnC8nsfyY0WqFvBebpDRbET6XqVVxnhFL7Q5uyolvJl/87A3DesK8yXCnhLpCS+aJ+0
 K50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wZMZJdORXYR9pyRXqrShK+qhViOMSShLK0xQJ8YeWHI=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=he4N2/ofrhqhbK4oQqxB30MCfl7F4s+gjFqaoLjxBINzL9NZ0KwFGELGS5Ex58MGEb
 nYjxdsnd3V+iWBfvL7NuJK1SylhxfiKdio8BcxVZN5JGoITssKj1vj9pRu5hYxRhSQUG
 CH51YYezlugNRtUhS+mGgE0EuWoI8j82YajYqsLbFD2gBvS2SbcyDi8RKoh8ciBSNF1W
 6YdStN3CdsuZg6uDzAuJl2b0efCPUBkIJc4xgcUA/xtGUYKq+f2ZAtRAGnRwrvOxVMNw
 usaikwhnLIytp1Xdyaj4DTZspLWBP7X4CXnrpLGUFazEmc7g2QY127xaXRuKkaBR7QA/
 DnoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788877473; x=1789482273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZMZJdORXYR9pyRXqrShK+qhViOMSShLK0xQJ8YeWHI=;
 b=sTfwLcdiAyNrd387H/rPWJxfR3JY/EngMnDzV7S8lFJmqUOXpCw6fLpy8rGJH73fIz
 HuGOcbr3FH54kODMORxhYCk9RVny40ZVjBA89pHM8/ENpR75l26NbeL3mpSLoqEyKBL6
 s5/GZJVVRj55YmJ3uZmb2uzwtSbKA4HxZQPN537TNhGF1WghY5gMgkjs30+lZWuHFlxs
 sxAG0fEZCnrNF+FXghm5RZ34hEVFOR0K4Xdat0/dkOy+B2UTVHMO2uMJ+eYIu4x0xCJA
 l6b83kUcbbk5dIcfqi2GYS2+O4KAQtsgbz1QgQV6T8KJijebJn2lMkCR17LGGvXaADzI
 VlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877473; x=1789482273;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wZMZJdORXYR9pyRXqrShK+qhViOMSShLK0xQJ8YeWHI=;
 b=qpc4f4+GswBQi9xK9AQfnIWTyRlPgJjHeecGiAc8i7piesTgF4W/Vb20nLYV580j6v
 XoABpz9pwLmDXQIo7QAmUKidrpHBrp3cosq6Oom837rEv+bKLJDVVZQvW8OPYT0WV1EL
 5RVDZHGrISdkTzUqgexpo2n1BnX9yF8EghaVSrOPONUdNPaKYXrC0J7pjGXk+iAVlWha
 TZbs0+t885ZpLn9243KgAsHy5L4xXHJU/327BAXrrPWAifXz4xoqBphbQzdB7P4V2/uw
 nsjpUizbcl3ZB1nEqsCmJtTqKKt6sSBu2EOoP5u5lgnzfmP8iK/WsD5HKuK7qo57447V
 VQ3A==
X-Gm-Message-State: AFuF++nFNVb8ufjWIuMfZOO+WNC2Xk2JKRKYHlUiiL4UffQEnAonnk7w
 sbZasWPVRK8PPtlu2uHJpyb4O9rUy6Z0G/4iRELtpJKVIFNA2dYidgzy35HXJJ1abQDRP2fgrYk
 Fv4i0Ayu3b8IjIYJB79DFkhyFrIbRO0E5NmDWvSYZlC/UmDJ3PZ4aw2Q=
X-Gm-Gg: AYBFou17xBP3pV6aFIDVAhCkRLKisXzQeRL7bTGNdsj7MkA5iqVVV5N4CUoIj0CMWLH
 pt5jaTKMdp0mopRWQdx/7qrMhXW+868BLldppWIPlFDe/eYUO8/F94xqQBNMxwemtS3ZzAMB7e+
 /1byNeiyPRFDG/kmiHcLIYM1zrG/PSlJ3njAAdTvTkxr7kxJPGkpXTTed+hH8lkz4gOTxFpj4Rv
 Xerwu52h6ujMMNKiKJ2cDH4bACHRR7xIRLYmOlO60ZloQ610wDl/cNLd2ZEDM4AYdugj+QTauXJ
 un8V6G1nkxDlFXfsDuudrxRtQZPvKodrqb1KB6guaKfkzJXmA0W9e5zBePsz9ARUJlHVCgG5Foq
 ijHtwBfIZn3NOyeZUNzi7uEsCPWIh
X-Received: by 2002:a05:690c:c50d:b0:873:ea3b:6c08 with SMTP id
 00721157ae682-873ea3b77c9mr67893657b3.1.1788877472955; Tue, 08 Sep 2026
 07:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:24:21 +0100
X-Gm-Features: AcwNN1UjqN2WmC0HvWbVnXrz4w_H8he7FYKWeUyodupanMu51m3HtHx6MIFQnUI
Message-ID: <CAFEAcA9wOaqX8=Fs5omoiRpeX-FS3Wekdthxcpxi1dMU0tdc0A@mail.gmail.com>
Subject: Re: [GIT PULL 00/10] Make HMP optional - follow-up
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 8 Sept 2026 at 10:52, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 35500e5c41aec76cde59befe750600dac7a9e3=
7a:
>
>   Merge tag 'pull-aspeed-20260906' of https://github.com/legoater/qemu in=
to staging (2026-09-07 13:33:12 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v1
>
> for you to fetch changes up to 7e72db1dd160628f2b806d5a3fe25125f5aee823:
>
>   tests: fix qemu:func-hexagon-linters (2026-09-08 13:51:37 +0400)
>
> ----------------------------------------------------------------
> Make HMP optional - follow-up
>
> Fix left-overs tests failing when --disable-hmp



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

