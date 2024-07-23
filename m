Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6395C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCgR-0006SL-8P; Tue, 23 Jul 2024 06:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCgP-0006RF-EH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:23:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCgN-0002Wy-9x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:23:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368712acb8dso2547175f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721730225; x=1722335025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tuuK+ryP31133oSbBAqOaBIHpGXexOtkpqc+JniZM5o=;
 b=Csq2bRlpg3Vppv3KAwqe5L5e74rAI588G016e5S62DOTX38KRRRbmAzTexqiQGDDhd
 WWu+S0sECqj+rVm1Sk0UPfa3ZWvC922BL3nxgicUnSIIxrOWioHy5kM9qHzFyVm9H6ud
 uT1Kiitq5iA18pNAGWFiaiDExlVJVb0U/hiW1DjqttCzjNU6Zn2fF23/rFqXSyBIjbRf
 If741LQOfTDE0yk9zdIWQLzf9cWYXZTRjwlsQvOtPgaC/XoUkiaj/polXKgg/sj1EEkj
 cb1nJ6S6vIMW6PLV3lThbi/LbrUzgR+flyyqrt8wVbdkbYJVJ4rdEYN+vQC2yH/npnT0
 Lb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721730225; x=1722335025;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tuuK+ryP31133oSbBAqOaBIHpGXexOtkpqc+JniZM5o=;
 b=NVz+l5Y7AE6vXeY19gAQ5cW8TCGZRJ08xgS98U/qL7hhgo1tPFFoqwEOKTWHIFemEv
 Ari1+kiw+L/nzX5jq6bHCV1vFw5V1WcWB5VfbZWOnOgpK6OclpmwTLpMQTCqz0rKs1F6
 2c3hXp4dGII2ytpD6MBYCMw0iXI+523zq4Km+pQ0coyat9K1u71d+tdnuDlx48lEcYch
 qx4B4WO3/HSsLpnKRu/cnPZUx+iMFUXQeccC6Wr9cFKPyqUp0VEyUGIb6KU9CTv6NiSF
 4THTx9FN+6rs7ZQIG9ORUUgKXX0+5gcwPbtNEYwkBmUDx5p0bjoSkG2GWXvuZ5uxmoct
 axNw==
X-Gm-Message-State: AOJu0YwQR9QBjge0ubvKejzyldV2DGfzn8b9hmXAE7YhgO2aFF5a2lDW
 lUGyuwab575SaYhSWuUpjPu0moSAvUCxxkNtc9NKw7NAP8EqVmaMGsg+5wEwe44=
X-Google-Smtp-Source: AGHT+IHMmuSbX3zXj7dJYXkfFZnimEXiGYl7HHoD+oj9/iK40e3Axcte/j52b5OXJadA7xN/P0G9yg==
X-Received: by 2002:adf:a3d2:0:b0:367:91d6:e12e with SMTP id
 ffacd0b85a97d-369dee43ec5mr1686544f8f.44.1721730225413; 
 Tue, 23 Jul 2024 03:23:45 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eceb0sm11164298f8f.99.2024.07.23.03.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:23:45 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:19:07 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 8/8] rust/pl011: vendor dependencies
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <43d9c3f65224f28f78f28d15e67b999d84a3b66f.1721648163.git.manos.pitsidianakis@linaro.org>
 <Zp9r59I4Uy655+4L@intel.com>
In-Reply-To: <Zp9r59I4Uy655+4L@intel.com>
Message-ID: <h2njj.c64x848hvert@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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

On Tue, 23 Jul 2024 11:37, Zhao Liu <zhao1.liu@intel.com> wrote:
>Hi Manos,
>
>(This patch contains too many codes so that mail list rejects to display
>it at https://lore.kernel.org/qemu-devel)
>
>Please correct me if I'm wrong...
>
>Is the reason for not using git submodules here because v5 abandoned
>compilation through Cargo, so it’s necessary to add meson.build to the
>code repository of each dependency, and consequently, all code must be
>loaded into QEMU?
>
>It looks like will be difficult to synchronize the dependency changes
>in the future.

Yes, ideally we want meson wrap files (git submodules were removed in 
2019cabfee). Meson support for that is a bit buggy and might require 
bleeding edge versions, so for the time being I vendored the 
dependencies. Otherwise I'd keep getting delayed posting a new patch 
series and I wanted to have feedback coming in the mean time :)

Manos

>
>Best Regards,
>Zhao
>

