Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CF9CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kIg-0004QU-Ic; Fri, 17 Oct 2025 09:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kIb-0004LB-62
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:15:13 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kIR-0005dc-S9
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:15:11 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d71bcab6fso18092987b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706900; x=1761311700; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7KBvpUL1h3bSz5p6pHNnSy7lLlY15drjVxsXUrLr7D4=;
 b=BN/srSQmM/rLN6Wh+ih3e94kJSpkDuif8BaywA9o5+G/WXa3nByDtX97wp7oYJhr86
 ZyZMIh31gVAzRGzaKUOBWB6f4MhxRIA4s6sx+yWtUSaaS7kjxkQT1+sKOVkHb6RQNL0l
 7VKV7GTZSNYH9SFEhvRgRQ7v8gzjNf+5qheMGhlHBzT9YsjgsSOdwxPmJHCi7b9fbv7q
 wWQKLx9VtKN3RYFl6i0Kw+6vKYuMEcImpKEjC/s6zIJDLpk0GuIHp0+0ONVVN9+FZjxZ
 6wMa4P1hg3xuvIkc/iwadPtlfB8aJqUpHeXN6PnzwbAEdb19sXfBKCms+ZPQdUXSBZgX
 vaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706900; x=1761311700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7KBvpUL1h3bSz5p6pHNnSy7lLlY15drjVxsXUrLr7D4=;
 b=hur8ZXWVo50oJK6Dhf3qTnSjhWPRkpsaTq+0xUSPujafYScxkZisnN4wa+j+6Ju5Hk
 uUqNiWBu75VAfWSV4LF/8WoRt0o+tMrWjzR7sZy76pwqBGVyLqrxRCt4rrEwwEMvqdo9
 I5dJGV26mUPWwnamFkbnKcJ53OmezHmZ2oxKCKhFRPutHZOWJsDwZk1A5AJ+zNDY3JKK
 u/0umaXQcIEnRfN8F4xKJklJPoWMR2qfEWECBVd5aoBKE4NNiXk6Et7WuYcuI/b6TQEk
 2LdNAXSCDpUkj0ehkU4/VVZvOz3Aw/6Kb49QLXcCcJBeuFxH2B8MCxKVwKRRvgZ2gacr
 7abQ==
X-Gm-Message-State: AOJu0YxTgiX6mJuCx8KD4ShhZhaM94SodAmDT0iFxAgsVshkd2OJlbhz
 vcLbmf3nTW+wudZppsk9Ck206czogRk4uCOPW9rou6onE6WshbyaeXPdd7yPlwPQO9ddJ0U8T2t
 VZEKgL9AYYkiRVoqt0URIL04oCeimXuSPdQ0PxJ56cw==
X-Gm-Gg: ASbGnctfXrWMoDYNt1tSFDCoOxIh0jTB4zZiQkBGVYl8KF0ADE5/v1qN25qHcZ4zNFk
 HGJiduf7Dm5Copa0s4zQ9geAwOJuc+GPpvnNCUiqk4YoKt8E8YpGZSmG8LYEyRff126KrA3O5om
 5EWwP2EIWpKfor8ypplGgv3UuVDkYErXLWvB4PW0Zd/GijXypKf9nzm5DHrtSvx5omqSvD3Buiv
 uEyEjz7rAqyAO1iyRlW2k9xpfIilhsKufk7qv7i13xmbEjFX0o1rnJyIbhc1vpSH1t89r+w
X-Google-Smtp-Source: AGHT+IHJ5wcHMu2tTN7KcRdFZQq6SEIEPVpMtQY7tXYm4VtPs4ymux/OYrfiMuverZzdXuPtaibO7uQ2LGwDZKyZGJs=
X-Received: by 2002:a53:accc:0:10b0:63d:215c:e29f with SMTP id
 956f58d0204a3-63e16199e6emr2858404d50.23.1760706899801; Fri, 17 Oct 2025
 06:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-9-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:14:48 +0100
X-Gm-Features: AS18NWDVETvYNDKD0r02FzQxcODfIwB4zY3T6XrMTE3q-x0uQTCI7BlNhkqSesE
Message-ID: <CAFEAcA9nA=bsOX35bAPsBRRaZyp9pvMCU_uQ=TUmKpYHBJvRJg@mail.gmail.com>
Subject: Re: [PATCH v2 08/37] target/arm: Use cpreg_field_type in
 arm_gen_one_feature_sysreg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 at 21:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Deduce bitsize from cpreg_field_type.  With this, we can
> simplify arm_register_sysreg_for_feature.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

