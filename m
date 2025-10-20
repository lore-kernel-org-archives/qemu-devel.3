Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C9CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApG3-0006BZ-7m; Mon, 20 Oct 2025 08:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApG0-0006Af-NF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:45:00 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApFs-0001gt-3u
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:44:54 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-781421f5be6so53017437b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964290; x=1761569090; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iSpbpgNOFWWoIJJQjSCiK0KHug92+QV6KC/HXyuAMAo=;
 b=tmIenhgUpNc+zZURs7o75FN2rk2w3lvnGkqMaIZqjWb4JMuySO7di8oIl/7ZXkPlVa
 iL2rr/iPVDY2UXJAPfOgaemLJOPXxAa71MylR0X6GkAqPlrlEP+pYS8D+UaGSxwzJl4O
 aQt4p+8oz+jeWMt1aPt+MRIFSDKGW2UqQtl6i1bYDWz+5XEeVCw+aGMENdATmVUDksNV
 6GHGq7YX9HPabjT0z1rSZVjXammvlqOsOG9P5LMvBVJW4YlHAaVgtcmhKNIRvP3l09fH
 /gFb9CjZc7TghPWhZOd9d61J1x3dMvLj1Yu0tK/nTIj6WA38p4H7lDFSG9wknF0vVnZD
 mZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964290; x=1761569090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSpbpgNOFWWoIJJQjSCiK0KHug92+QV6KC/HXyuAMAo=;
 b=jY0Z+Cqvx7wF4e1sryh0/pP7kM7ma31SJz0uQHYdsE2+BbRDAOruh/vjY/Fr16fjZT
 DEAHI9AW8WOnDusdXrFgfFQlYBKWoal/0Ud+8D5hjBmkvs+6u3SjtsGHZ3N0ce7ZhZZq
 njZ7bqAwANgOlNSwdGitCKxD+rtKQpf1PfULOl/Woe9iAhON3Oj2lvLzgY7fD9+z585H
 /WMpgkpgf+vnt8QgYXCkdo86hWY2R70qZBJZBcxxDnTpS1d1ndWwZxmWty3jrjmt5/Ei
 gQcA0yQ022Jb+WMCTGNQtLTF4USV0Oh4IlivaJNwfdQau9U9HekmVJ7/PA9GwW+dDIP6
 Wkyw==
X-Gm-Message-State: AOJu0Ywfu17+sHXN7dZyeWGvBo4drcyqlUDkKGD+vh6uQPPFMhQp4CO/
 VLB4UoVvJZ8FkIBXpLyOwmDiyA9HYa5UVL5yhCJBojVXz4FzYeAIHyx0eP7jM/YdlG2gxV9aLsX
 4REmLETSROKtBINlSC4073H///n7QHoQmatqwRXRb2w==
X-Gm-Gg: ASbGncuDgIgC0xOkztMgOx3igHlVKKnfL+0anbP9AKISJzXYUD35oK8dcRVSSbmGa+J
 tDdOy9fKuEec3o8ai3Z9VemxwwHBzEUqFpd/Zg7JyOfha3Qugk1qO0O5jsxQoa+zM8Cu/82bEOm
 LAIVjOOcPAR+7B9EVTsb7GtY/YWSA1fbBhj6BIMYtYFcSiM/DTN05p4leM13ihgQUECe/9LQ2Ze
 HrRYDYwW+U9lZHHQiRaNUTLgm7+BFcsN7ouou1wDMruoA8dbd6EJb+KaaFRH6E7NYswl5p1
X-Google-Smtp-Source: AGHT+IFAiZN3tBZkV8XtDqE7pis/2vL3J+VRpbvYKGKibuY1RaLrjb4xBMy09ArzxSkF1l82CIbIbDY2Zx3gMBEy3HQ=
X-Received: by 2002:a53:cf4e:0:b0:63e:1395:1951 with SMTP id
 956f58d0204a3-63e161d76bamr7540001d50.54.1760964290075; Mon, 20 Oct 2025
 05:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-17-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:44:38 +0100
X-Gm-Features: AS18NWDluKTESkKAfN1fgdxH-oc2Sgeg7IlcLE7nf5-9P70Z681moHgFDis5TtQ
Message-ID: <CAFEAcA88cSO17mqfTzQ5O5q7UncAWfd6s=Nu=SFz03hEzLDi6w@mail.gmail.com>
Subject: Re: [PATCH v2 16/37] target/arm: Migrate cpreg128 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 14 Oct 2025 at 21:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/machine.c | 50 ++++++++++++++++++++++++++++++++++++++++++++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

