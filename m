Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E690CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoM7G-0003uT-51; Tue, 19 Aug 2025 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoM78-0003nn-31
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:11:00 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoM71-00072C-Ky
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:10:57 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e931cad1fd8so5364896276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755609050; x=1756213850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc7Rk+6COxnPyzGSwJO3j7uZvaYmy425hlkAZek3N0k=;
 b=OSti5Xq0F0tOl3/KlFbTY5AUT9HYJF1df71hJdXaKael4iaXlECCyinqzBNHiO/8nI
 2Kfi+x22iJQUipXr2OC5GUvp1mLQQW0BNRkSiEuKIS1RtM5G3hFzI+LjOSxTLCxc6bI6
 7JajBcwvN7xvtZoXfy4HAC1KCihArAeHn28ziEuyfXoGswwLWhTQJF76W65NnbOtbXcp
 1/I8tJM710UGl3ka3Cl9T6djZSoReBmhXopLgcciWy99DYYw2ODYQwAJjMbi6y2aEP47
 s49IzhLvxRUnTnfi7oqgeaZTr8gS2oGPnEftEDt10vICZioY4UlsFONXLA4EaRMwrAU5
 kMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609050; x=1756213850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oc7Rk+6COxnPyzGSwJO3j7uZvaYmy425hlkAZek3N0k=;
 b=FjtWPR4k5pZ051pC7tJ4pjvEGc15Z/jOKi/UyimqvdWRA0x8WmDlc7cXwNipwsTkby
 rGf04yYxlB9WDIVrh9R4qkMXWSLBbrKBBCf4Mm2ZhZ/yIoe4DfI6udWV1MRP4H4aTOJ4
 Y32VZWOhkDa8OqeCat0QHxwhw5VbO0G2bmmT9VLnntASeG8AWffysVdvTwiGbOiuPyNu
 CA7slzPWoU6Nn2X+pJG+A8T7cPM2Ul5CaLCzVTaIQqJhJ+pvyyepXJ+kpgG+GPGFwABA
 vWUYaQmDhk/3No3nW9tLP3gPUq1QZ5He+LGfLTN+SDd2b1pOTHU5NyFBlU+06m+IljUy
 dvmQ==
X-Gm-Message-State: AOJu0YzLmyecC9u/CqHraXw09gONTgLKeapGZSO8PBpjQBMIhFMKj83C
 wnloa5Pk9cQupUCJU7sS1Hegjg5/NIAXJRwQ+0rkidYQ4SjC31IZIZiJ1zVCK1XWEdIM+px2KaC
 pS0OSFwAkEZ1XQqr2WD29zXtcjNs+0lEDqQZXAIs/LyV07/3HMmqt
X-Gm-Gg: ASbGncu/sJz6qhG345r61hPti5j1wFatEIFJho6L+qvxnq6QSpn6Ne+rsT9tUYeX++k
 gXayKJn3zEHKua3WSDflAMglam+bTstqR/nH0IInW52i/fdfydjECdU7kyunsS8UfsnCza1CZjB
 IkDxJQy9Rp5WANisSLTeYgKUrcceNk1pmliD1yqOJTA76lzkGn9WnZW/7RtTZHI9oadzzKCCcFH
 nBZ4RL4
X-Google-Smtp-Source: AGHT+IFh4hROarJMzawZgKqmQF51gcjih5nUdlEy0mWkJ7f1HjqUmhuouFSmMYuqD5UfILXKATk17fPzSEGGmYzOYDE=
X-Received: by 2002:a05:6902:6d15:b0:e93:4556:8142 with SMTP id
 3f1490d57ef6-e94e62f3713mr2290424276.32.1755609049688; Tue, 19 Aug 2025
 06:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-3-mohamed@unpredictable.fr>
In-Reply-To: <20250808065419.47415-3-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 14:10:38 +0100
X-Gm-Features: Ac12FXwuWyV4BHVlk2_b6dQzYUAHOtsTqYeo9lw5QVYvBIEie6Jh3LYQWKzLhXc
Message-ID: <CAFEAcA-BfSremW3BETfi5yFowAeyLxyCk2OBM29bQs=BGbLdGQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, 
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 8 Aug 2025 at 07:54, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> On Hypervisor.framework for macOS and WHPX for Windows, the provided environment is a GICv3 without ITS.
>
> As such, support a GICv3 w/ GICv2m for that scenario.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

We should also update the docs in docs/system/arm/virt.rst.
These are already incorrect in that we never updated them
when we implemented the ITS:

- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
  that ITS is not modeled in TCG mode.

so we should update that bullet point to match current reality.
(If it is looking a bit big then we can have the bullet point
be just "An MSI controller (GICv2M or ITS)" and move the explanation
of when we go with GICv2M vs ITS to a paragraph below the
bullet list, in the same way we have for the explanation about
the second NS UART.

-- PMM

