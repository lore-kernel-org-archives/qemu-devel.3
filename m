Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDC7CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApKv-0000Rs-Sv; Mon, 20 Oct 2025 08:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApKt-0000Pz-C9
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:50:03 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApKr-0002g0-00
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:50:02 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63e1c0fd7ddso2721736d50.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760964598; x=1761569398; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9RI2a0AxP44LRS2KvKcsjcPCgyEQFJH0Z/EL1OX64+8=;
 b=dceMx7kjp48hY0tro8TdJXr2Y1zhfU51OgJtkihcEn4ff5exCQv/U7S9giZHcXurBw
 Chwu0fgeQ7hbv67ufpnXLZONYPkOFo7E/q07JaRInhzrRBgvOqRw/348ZjnACh0KgzS3
 Q7wNmyltXaiLgs+naidSOxOAqRcolN0o2Ot92YYnh/CTPxH88XWZ9RMZOdc0PLFQMTsY
 XDqeI7CsL1v9QUN6/L5c/2S6SJzLpEzrYDxf9QZD1vhBIKjues4clHP3mAQPhd0m4vIU
 mJwQ0lj52gWEe6H9bM1ZxfaRcGKFM0Dno+yq5sboV32mja9Qcsgm6mILyfcSdmWAhzy3
 FsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760964598; x=1761569398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9RI2a0AxP44LRS2KvKcsjcPCgyEQFJH0Z/EL1OX64+8=;
 b=knWMVR+1ckBinPHafW414fuG5EfzMTaa6stedZxzgz8mKvJDA5QSwybELpEM8HqSmV
 o7hbaH0j3zCIkGcuyAaXQ/vDv7YPQLyu/5GfvlZK5RKPB9YO2R1tDKRhJdPgSR2OLduA
 8nzUGkdVNpprFcV6Bb9jpv6jRS4FHMzJDqzmL/g5ulmHPogUwFgJ7C9rSSQntWfy+0a5
 ydzHDYm7MOiL+JZGArdHCYPtgdTyWMG3ZxW7iMkTZysIWGClNinrVxNErdHW5VqDcicC
 8913NXOYU5HQMwKkSynoiMUaGYIittHWKgMEvudQTXnMAGgwJ3QhOj+kBNnimze4w/ef
 Fo9A==
X-Gm-Message-State: AOJu0YxlI0QZZ7RaD0PoM99gP3dC+SBhL8EgBzaCEga4RjessRUTmiS1
 L7eFGR8FSiTHcqGgrwmDyX5NbL5PZySTNvlvUcAFjhVwUF1Cvuq0/lxz6+6XjCF1Ungg/gWaUvD
 SZysjD6il0nyt4odrssfzXZZogc3jBLK0t273RpFELg==
X-Gm-Gg: ASbGncsaLdSkVXgRVEaYTbZ5co8Ugmke8PXmMACtMzQPpKqbGazaeUkUiKrpUQHMtKu
 zOLR8mR6W4tWoslK6RfFRDMCyMqIqiIDR059xaBxMKiiRUoCzd6nUEgdHlt9GXYiJDKdP0NnphC
 sV72WXmc4FsdkMXI0ODMMSCuQ9nwDW1KXs6q0Hc/idSBSKaMF/IkCF2BmVhnhUvl1bMSoyIKXVk
 pzet8QQ+EO3k3MdTuSmxwr+fhlpR886iycbPB0PWsOsgMnfUilUIFnZQJw1mU6zVLaiIh9A
X-Google-Smtp-Source: AGHT+IFU9aNVQW1cdITXw+5n518p5advk2NgXy6ws7Yrj5qe/lmx8crF/i+EoYY3QIZt4WhXwB78JKjhDAPkgaJWtr0=
X-Received: by 2002:a05:690e:2505:10b0:63c:efd6:c607 with SMTP id
 956f58d0204a3-63e160d904emr9338169d50.3.1760964598530; Mon, 20 Oct 2025
 05:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-19-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 13:49:47 +0100
X-Gm-Features: AS18NWBIGjSlEzsOPZ-V626SA8ryHRuMStJUJqylpaZFh9lMguHjtOLYWE4seFc
Message-ID: <CAFEAcA9ThkDVXygLisbHYvfNEe_vQLDfBCyjnffdz1MoX71R5g@mail.gmail.com>
Subject: Re: [PATCH v2 18/37] target/arm: Introduce helper_{get, set}_cp_reg128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 14 Oct 2025 at 21:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Helper functions to invoke the write128fn and read128fn
> methods of ARMCPRegInfo.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

