Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1B3D2D8F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkgx6-0002DQ-SI; Tue, 27 Jan 2026 06:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgwx-0002Bm-4S
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:09:35 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkgwv-0006in-5r
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:09:34 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79427f739b0so56567377b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769512172; cv=none;
 d=google.com; s=arc-20240605;
 b=US1oAiW44R27oMZcl6duaGSPshsrO+po7NEPvkhdRMM2k7JDkkXGM+P82FcqHJf2Q5
 jOcBHz4Evz4X/3pwlEUvWA9arvht/pqshgDWlAFsLcDXjX0kGthQBJ77HF11fo3ZZcMt
 Rl6+w21VzQfm3hbJJhi5pHJBDAgWxTi9BS87I4f8VJ/Dc4XoWT94+RxyXh5V13VYfk3e
 rb4mMVoCSFZG3eyItGsw+LYcckecW8ZRiGxV5P5/o7jalPg3gkeXcG2ES0Vhm/933Y6d
 +UPO0y32Wz0bfWLlHrUj1yRqxZqPb2VioTJarVK7ya4DLLNQCAEzI9QJYtPqlAJ/RP4C
 KGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mQEb84e7JtMOm0oSuQqUamX2gk5Z99Avs5hmajUOejU=;
 fh=dXHoilmhhxY5vg21Ss6PZGFufhldebBfEzqm3qMG63M=;
 b=ZadVXttRz0tEeTV86XD3JqUtAP+zfXEp3fYJwHXHGAiav6yc16+8CF8Gn8ZL0B3gOJ
 Lmxil+Cz0mbeKTaAYz/DJlnsKuVpzRVlqCAwo96d/2wpK9DQLWTswGYURD7SnhkLZ45f
 stYK7RHVJSmm+xxungemkC9C+kFr69kI2gUwZknpi/o+ib0VjM8uIaLBu49vv1eh9E0m
 zHuG7acgG9usQQMSyU41Ii2J9r5G9kDIjIYApI3YPDGw0eMKpWB+1y8Fp7fQuOzXMDqD
 AOJz1QjQPrplVnfUjY7+0ahTR6n6J3MQzROniBTm/LD1klkCuxsBe6hF7vLXUQaocTLL
 Bz9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769512172; x=1770116972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mQEb84e7JtMOm0oSuQqUamX2gk5Z99Avs5hmajUOejU=;
 b=LpWzcQy+mAuSj2ZczgeouVO+L6pNLdH3UC3bYzgbhfcXY4VdVWUSWxKYCH9d9JbD7J
 LMHT1LFjp8mazUceTIZB107A8oC12eDvAzasZta2OWL95ZCsWRsdmSbFGkMj8rqtvG4U
 aTmljYiqdMpwu967eZttv0m3BxGiHp3Ohe58SKvN04iCHyDvGv2wRzHNh1pTLliSu/8F
 Soafey5+eGCWvTUSXf8v10d4iIi0h+dNTcM3ZeXtY9FMvz2EXfcK96F4tcdHjurDMA9L
 Nh1TrrnHqbViahW9F8CtcVijFUGsqSX1bJPEAx87NkPZB+T9Xh0fpto+VEBX/M/wLECa
 6t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769512172; x=1770116972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQEb84e7JtMOm0oSuQqUamX2gk5Z99Avs5hmajUOejU=;
 b=nkVIGH1axCPLRQBjNJQIwrdlSgYOZv02RQJM+W8tRZZQ+5dPjFZJt4EaglVTgGy+yj
 Tz/YFEnYOrB4s2Z9Ho7JVJBDWh08ocYVfKrcfEtttMG5aIhAx9cxwRQ0TN7BYLZGOxbR
 sVnvfbxETZP7fNjBrpRPmaeM6Hz0IyGNsdh7D6XD7ig6WHRdATFmXyrdpUbl4xZaq29V
 z/d0P3W7H90u4EjeHhuxTDnhXx/MKVrpHhKcuaCMMYZEdeGXTUOnMUjGKTNCbLA7L+cf
 3c7GmdvyX18LVnL5RJJFUSWvZ21vK2eFeS9Eglox6P2j10JEoiYCBHxeE4IruHGLoxCC
 AxBQ==
X-Gm-Message-State: AOJu0Ywvvhtyb3gyV10V03W2KkQ4cjiceXPi+mH3AyZAD83nRKi0nQBZ
 H1LkUcv/CvEN3/HMipIQE6Uj2M1/rQZokn3okhvu5QddHLK6jrZRfUOyiaGowleFR7vXyR3HVBk
 jbJQlp7JQr8p7h7YbCw9uJR397NuFO7PN4xziDeW+gw==
X-Gm-Gg: AZuq6aIts+/7SGIY00Gny0d9aw1L0yf5vowEMch24aemn8jlOboPJwBH7eLj0FXK0US
 cIRnCMUrHzKlY15WSTyTMNNJp71iZUlRAIZ0S3h6CZWhw5iRBbR32PA/8oeW5dFev9J7P0TOtDT
 2uii81EUROVX8P/odrWD1WLs6qZRHlEwPyg0AMCSDlN83CVkolNiBXUUoPcC9OP1fMQ1dMmlJp9
 r9cVd6LZP+3klBtOKPAJxVyDlkUXN9zjA+ujr3W3oGXrrSIqeghp2NCjXo4fbVEughiPA==
X-Received: by 2002:a05:690c:10d:b0:794:795d:4728 with SMTP id
 00721157ae682-7947aa04204mr8209797b3.23.1769512172088; Tue, 27 Jan 2026
 03:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 11:09:20 +0000
X-Gm-Features: AZwV_Qixd0EgnbcgMdIeEVoGMfqvDJPGAc-SR0Geb1PsZtMeX-KI7VhJfc9gmVs
Message-ID: <CAFEAcA9qQB6Cthd5FrFTQRCVuiwAz7J+xBuuE=-vq7ThUpS8Lw@mail.gmail.com>
Subject: Re: [PATCH v17 00/21] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 21 Jan 2026 at 13:41, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v18)
>
> Missing features:
> - VM save-restore: interrupt controller state notably
> - SVE register sync: I didn't have the time to test this on pre-release hardware with SVE2 support yet.
> So SVE2 is currently masked for VMs when running this.
>
> Known bugs:
> - U-Boot still doesn't work (hangs when trying to parse firmware) but EDK2 does.

Hi; I left a couple of review comments, but overall I think this is
very close to being ready to go in.

thanks
-- PMM

