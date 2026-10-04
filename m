Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF1CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOxM-0005cc-Ba; Sun, 04 Oct 2026 12:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOxK-0005Yk-S8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:20:54 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOxJ-0001iw-4O
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:20:54 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so590314d50.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130852; cv=none;
 d=google.com; s=arc-20260327;
 b=dXwiRFsxJ+kqG21cZjWKK2kh7o8p5JtE5KajljuPALAZla8sXGdEu3ilIOBOYgfdLj
 smT9rPRPyCE0c923mgieBtK9yLt5BXTiqWNLP69nymv9ugNeX9fH99tuY60WZjoy3nNr
 nWZuqCPx78mzwFBiFZDa7zXUfnpaZ+RWy2P/hx7Gtx1Un4y4DA4sPUldeEjexegQr57S
 rofubxoGyr8rxUkssCy9W6T+osE0zwRLAumu86bXqW9M1iZ+iDPD26bmRqLk8xtLPNtK
 9imhzA1i7PgBH6JCaLap668V6/GCizSQrM7CljfXmpLExAYRiGHYSB8tDgFJTRzPTZC3
 GpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/hywT0BiVvvITDVjhSXn8IT5PfMHYkwYkfwHJeQppMA=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=pWabEQ7GHee3A00WeOXFlSqj3J0M8xG3G5nirWCTFG6/3JNklWMeSvO4syOqGFOR5V
 C7KPbm4ysPc980mtNsqYfQyI7RumvMd4fbK+WAOA6nENeTESEDXiO+hWK7M3V5/lLUch
 cTQbVKVZ4ZVVoJsxfJhKslXd6S1ar2+LrRZwh7fEMuDjncWA1EIGnzww5mN7t3dbZ0pe
 DWF/ZOObFTkVB+gD+C97QZN7FRN36RQk93GAaVJLq3mrr/Qq7vpMz0fkS0l6K5d+tAHl
 07krCgva/Cw8kK4OpFarymiCDRrE0Z6yV/tYOAhWo8cQ1Bupfh3jMi2WAjLWeBHf+C92
 nebg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130852; x=1791735652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/hywT0BiVvvITDVjhSXn8IT5PfMHYkwYkfwHJeQppMA=;
 b=rKIciZ/eyHVdvX+M+2QFDX7TNv1YBNaV9wWbR1awNVE6oGi0QL1EAr5nRW/Q+wdfDH
 cclyPUcHcgG0hXSyMEW6PUda1tO33zVPHXPwkTfxoWsZ8LY/v1OkKwv0/2tnC2bXpalw
 eH8iHmYHgnUH8oIHQT2eM65I9Ohv7bEyKEED24C837YD5ulOyLtVs4nn2tY5pLD0cxdX
 qztieBolzgE+xNtn7S2dXm67gG308AB2wyz3m8FdeMmruh2iBOtzRHjJo16xVR4FXtO3
 qqj19OBXOH7anBKRTjXnNOiaJE83jhYVW2Gmex3SVaMklIbXMS7ABxGZnBC8qxvzqhQY
 mmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130852; x=1791735652;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/hywT0BiVvvITDVjhSXn8IT5PfMHYkwYkfwHJeQppMA=;
 b=erzzXRmfyUdPsJzL05vZJfSEYwuXJTTUuBFtNnc/s/MvwL6IM/90ZSmMIyei/Bga2h
 t5vyz8ukImoJF4gKUaPeX/vpswYWOE6sh+061dCYpDNhIz7F7PFeMJE34LrxU11AwTyz
 ZrUdkOrKe4bMRBX43/14EnuYcpBWWPQSbhcmdv56YK8cG/LM9qH0CQRPty2+FOzlq+UQ
 N+aYbYkVanN13BzwMBD+cyh9OG9hsHo2fJjkQp+q1hzJnMDJxlKAVD7EF6SRYWFIk7y1
 Bh0RslkT5Z+KI3JGZdhzUx5pbEeYqIJA6ZQ4YcpYBxPBnU9SC3oHqL+1dkdP+aeu2Tp1
 zcRQ==
X-Gm-Message-State: AFq9FYKA9741yFiSsTe/wVDw6xeymrqw70SdZt0CMfr9U7jjlOOPs5gr
 sP8WjIaqokKJHSJdQFIyKbnB8ZafL1/yUtU7CWebQmI1wp6th8yHm8qBOU0GEtMxYv/4mVwdDmY
 KTqSt/qgQSffx3It7bWkuuXnwEwlTuns=
X-Gm-Gg: AYBFou2ZBrpDz9cPz8/LEraxzF5KQDzmv9c11wmPVv8O7P+boFG23N5RdaxYmEU0A49
 QgWBMvoJ3dmesKRGuU5r9NxvkPAI2JrbnE3wdy/MO20TA+Yk1HCKCpkoflOxP9Ew8L2AO89v3Kb
 v3RWZOgfL7+qTKu+tvg6/X3lXxgFm80fUm6saawKEmbvT2pCJo91IeCaegmaiMjpgivi85mUqdk
 6sMt3ZRcwAa8WBT9i2PFlzZGInXYBwSflQISUl/RmYCB+q0J9tFA7j65v/IDBdz2hc14A4O/Ncm
 7qAWpA35Ta3oBo6zAbV3VCOVM8H6JnYQd37epNDWJDU8nM9V19PvAIERl+hvBmGa7zdrWepBipf
 A9Aa2fsUyvcrvL2I=
X-Received: by 2002:a05:690c:e3ee:b0:8ac:b1d9:460b with SMTP id
 00721157ae682-8ae38db4b81mr33151567b3.23.1791130851967; Sun, 04 Oct 2026
 09:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-21-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-21-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:20:40 +0800
X-Gm-Features: AclHuK8Fg-jdr0GBspjwbfUnw03ApYhZvRskuw_kQAHyucyrMzMF2sG3IFuYgjU
Message-ID: <CAEUhbmWpRxohFygDnv_ng0U0MP=--S4+zQoRr7JA_aNaFJxefw@mail.gmail.com>
Subject: Re: [PATCH v2 20/30] Kconfig: Extract config FSL_IMX7_GPR from config
 IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:37=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config FSL_IMX7_GPR to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 1 +
>  hw/misc/Kconfig     | 3 +++
>  hw/misc/meson.build | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

