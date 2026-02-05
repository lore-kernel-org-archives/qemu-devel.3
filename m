Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25488ECD985
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2oc-00089r-Mq; Thu, 05 Feb 2026 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo2oa-00089a-CY
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:06:48 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vo2oU-0005BF-Qr
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:06:47 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79503150783so13035397b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770311199; cv=none;
 d=google.com; s=arc-20240605;
 b=AKmx6xiaVwYEt00T1biYYGhm/V2Z80AfMMSht0SIkqSWi8XIh/SFpqLeQhiqFyMGK9
 XioL1XrhWn88UGNhA0cQIo8XLCnE1mssou7aLIDu2WFf5W7B3sdVnqSNHirvOJ9v+wUT
 zD5LeBXNRya1lAewu8KtOd7MwAjomTMzweweG9oTUPuDH+uVFSnkVMtn2G4tnhV2fdzG
 rLG1PO6HnA7t3IGX/ipRiLPwbUwVnxMteWMek/8o9VIDwBD86OcQl2mxJi0eQKZ7GRG1
 r32wVYOvKirf/RUFxYTs1CCNJ+AuDIjWgLqXXeCIefG3TeOS8rUYZFseJey6pH3dCX65
 8cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KAEg4662UYW/bELI+4Ost1zMrJiH6kCl9x2ESCMbx90=;
 fh=4YEJy7HqdSVGjSO5H8UovSnFjcV1YLqgNCr0cr1lRd8=;
 b=dZxcn39TMzj1DVTYIMwdljZ/zdz5R7eULvhO0OoS9MT12iHAUKijnuQe9GK11N6ZbM
 7TeBq6tjAVw7zSPhHc8XIlh2lSnNxsmvm/jFatgsvSnR3b8zUd4LjWF9vfuS5tyewoNJ
 sLpXGDwRYag0Wiu1KCcT9MnNY9Up58klUJ/EsO/Oh+ijlH9lnkCEkaldO7t7m73/dsi/
 Ti+YWMb5bfE+aXjHRme7dQoE2loImHG0Ukcw0TzVkLNPyeKQNE+5fbz1BKtHSHtZV8ZL
 uMpuP1TbomEMdyTpCJ7ma1m4t1zyyFEGQf8hOPOV+krEWeBHHxlWxej0vEZUhLIrltvS
 1mpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770311199; x=1770915999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KAEg4662UYW/bELI+4Ost1zMrJiH6kCl9x2ESCMbx90=;
 b=escZuaEf55nNbgIHd+XlbTaUf/QE/HSSyZUVRZa7s6UjDI/10KbM0s/ZrLpZJZYEjR
 kFwX0qiskpc1XFPZgCc+NcjgUz9xqUoQ+HgMKlOu3BjSAKvQV+/74jZVnHlxnfJHhVcp
 3uU7kDG+EedBp02oPQXDB+NoHzSxBnayil7dzm5hbgr8Pck+oVlUFrTZEMhY+DTlDPgb
 U29Fk4ShRcAKvAnbUlmNnRn54chDbBukpLEU9RIvUPd9ARugod3EDEdl91PtWs9Q1a4a
 WRjCHYixTqhrEQ8HE9yVNU27PGchFNCYWLYqSrZAn3E1m5FiByfU+dCfX6MVuOKS74P1
 grZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770311199; x=1770915999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAEg4662UYW/bELI+4Ost1zMrJiH6kCl9x2ESCMbx90=;
 b=BlWGWNDlpt63DQjSTWyvL8ht6g0/f6s9A1LqHkeGzHol84vMA5h/g8tdrlwLqtoFlo
 xp0+1UG+fY7Vmq2umfTtQdNNNUK6r8y6mFeO3xgB8T8Led/jDHYijgQNHhdfV26r+2no
 P/Cyk3Nk5QaBNG0LkUQ6k2zxUNLYtdcwwLeH/jNhwCovV2d/NCwp0O0pAafelC38Rwiu
 3eWBHmlcqZWsJUpFB862y3XZSh4iTTqrss06U5mUYucaaZixkbBIC7ULIW4Uc7bxsDrg
 RI4gY9OxjFvcfpTwIwMbIms7UHA4mkTzjNSquhnR+Xl0YaA83+eTu9Kacz4fnxvTUiK9
 k6Ag==
X-Gm-Message-State: AOJu0YwxumnYPF6j+raYqlBuvxaYUyeAvb3kuqj1V34T/0DKTLGNPuKD
 P9puRKyNHNDZ9ClS4RZWMugQkxP4qBQ/rszM3sh6uSPppaHbqwEXis3sDCvf0CVikIW9cEqlqgr
 aUlzPzHDUX2kMriYByjWrDnPnETIa1aD7+StkX2F0JQ==
X-Gm-Gg: AZuq6aKZQ5lJMT/RTXc7cuy//C68fY+zCbv3oHNDC7CZ7lJ9OnAQBn2zq8kd8viL9v8
 TWZu+MiiKxlZitC18zVlx0SFY1mK37649f2QZOhOkQQDYAbWS/OTF9gdMQUzfzdd7msznJF7KFq
 ZOj2Bct0UG501mEqbRS5TZhsWec4RfedGgWK24U5OhKQsA85gcu4o2hC3AK4awgzt1/67rRPYuu
 ww4XW4L9DQfImF1rpEtigGjJPT70IRThp9DvpQWt9ltdwYH9ccZA4FLcGaUCJ2cWu4Cycqh3vUk
 m82C
X-Received: by 2002:a05:690c:3805:b0:794:f200:bbf7 with SMTP id
 00721157ae682-794fe698421mr66288007b3.27.1770311198795; Thu, 05 Feb 2026
 09:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 17:06:26 +0000
X-Gm-Features: AZwV_Qjr___9hV00IaP5rm_f0cEHd_y6FOBBu7-8oT8uePD32MdD3x0--hi3zxY
Message-ID: <CAFEAcA-zEZP0hF3gf3Aa4ec7AqAuX14JYwFdzinv+Mdz=OTRfA@mail.gmail.com>
Subject: Re: [PATCH v22 00/22] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 5 Feb 2026 at 15:24, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v21)
>
> Patches without a review: patches 3, 5, 6, 7
>
> Missing features:
> - VM save-restore: interrupt controller state notably
> - SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
> So SVE2 is currently masked for VMs when running this.
>
> Known bugs:
> - U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.
>
> Note:
>
> "target/arm/kvm: add constants for new PSCI versions" taken from the mailing list.
>
> "accel/system: Introduce hwaccel_enabled() helper" taken from the mailing list, added here
> as part of this series to make it compilable as a whole.
>
> And another note:
>
> Seems that unlike HVF there isn't direct correspondence between WHv registers and the actual register layout,
> so didn't do changes there to a sysreg.inc.
>
> Updates for v22:
> - Oops, add updated IORT now that the SMMU patches are merged
> The revision field in the IORT changed compared to the revision of the SMMU patches the artefact was built on.
> Ran a make test again in a clean tree to make sure...

Thanks; I've applied v22 to target-arm.next. (I took the patches from your
git repo this time as you mentioned on IRC that patches 21 and 22 didn't
make it to the list due to an email infra issue.)

> in side note: try to make certain that qemu-system-aarch64 is built as part of make test on macOS instead of
> the unsigned variant only as that might have been why I didn't observe this

That reminds me that I think somebody mentioned to me that for some
reason only the unsigned binaries were getting built for them.
Shouldn't we be building the signed binaries always, so that
execution in-tree works? (I had a quick glance at the meson.build
runes but they looked like they ought to be doing that, and I didn't
have inclination to investigate further.)

-- PMM

