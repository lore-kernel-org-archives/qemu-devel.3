Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAAFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjTe-0002JI-5H; Tue, 28 Oct 2025 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjTU-0002Hr-OV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:10:58 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDjTP-0001Qk-0Z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:10:56 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-63b710f276fso5925364d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761657047; x=1762261847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2O3ru6bTDJHgdmYgqB4W8Hotz207mC+7l7vbnYfbmNQ=;
 b=EiZlXOicts7pflPmN7DWc3K3iJCFyzX9+/vuapU833OUCtC3i6QqO21kWUf0c4/aRt
 lePyFzxXrSrRQyd8BUQh+HodA2XQYKBl4C7CyEUMtoc/K2MusouyFzZmGjiXgk2kzemJ
 Rno/Odgv7c/79NgRrHoFjXFcdNPMauwwcbEtJ5ZYdGQA7WuhLPLHx7O0q1gmzTM16kQY
 U63EYp8H9Beu2s9H1ifErBYORSQzw2N/yHACyPSlp3mLbzXve7ScZ+od+XIcCuZmPHZJ
 hu5hx5SSTYFjyFSouhzrSRVM0ZLSE5x+yZoX+gRXtcYTfAtBdquBozm3GKYQKGfF7uRU
 iCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761657047; x=1762261847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O3ru6bTDJHgdmYgqB4W8Hotz207mC+7l7vbnYfbmNQ=;
 b=aPOUfHUxcgg+uR0v29SgEcVIiENWUxJoQWr6mrdfK2Jz7Gw3/gpBNavtpZDeEkWUmD
 QmzM6YNrjyoFkoFPQh1jJ/HOV4kDcbqRTCOMxLfnR7htnoxX34A0DUTs3XvTM8zXGaG0
 9Tu01yjKvhyALLyaRx9Cqt/eYpBxoK9viiRTxlsx84DCUzqadch1UJE/jG4QPTj+4/Yk
 EzXyloYRvbkwzBJCKPr+q9BPSQ95YRsGc/YwA0nTn4ant1zVeBCM9EtvZ8epH5HPTCrd
 ex4IlpqJQgobRus6DEXHwIkjFlr0LdUSDJ2RnQmqqE2bU3KawWvpsGboAgmqZXB3ZWeX
 fJbg==
X-Gm-Message-State: AOJu0YygEulrP9ZhEapgyOQmM4D08xCmyXqNaMxob8GbgB9Pya7osVu6
 +O5miA6k4g2MBqRV4WdIQHFUgpbWeKC23YCzzRx5Yatv8chbllvGK7R54eOiH1FmLxrkcIlhf3c
 zvXErz6rVL4LZfH3p4TW5ScPdQ3S02iB2LhFEn6UFlA==
X-Gm-Gg: ASbGnctamc9laNFckO0ePUsFRWOE9NB2E8y4XrhTNRB6Vd2AempHcGkE/tEG0xV/ZHu
 +NomsYz9BgjyrugQ013LaV/puxM7AUoK9aYxCMwaRSb++uH0gXY+67yvbr7wTg15UWoFORtQZLX
 RFdxgzB9oCJUHm0UyCHF1kRR+J6Wh/OFzLDVcM347ttCkJzAhcKh+OfAi6lIaItSdQ0bkm0huyn
 jZ4K7Rt3ZNMixDJvm0aBMlFeJ0EaIa+JkoP/UvFIqTK96oBlQKOPEJ7h4yoYQ==
X-Google-Smtp-Source: AGHT+IGlHI9mLlBVkrO9VxmOtOe30pOmwlqni7AolhwbAyGX+QB02Qe1S2Xw+CDM724HOI8Ab6mLEN69LebUyKf/U3U=
X-Received: by 2002:a05:690e:1517:b0:63e:e5e:6b75 with SMTP id
 956f58d0204a3-63f6b94bc0emr3137514d50.19.1761657047361; Tue, 28 Oct 2025
 06:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 13:10:36 +0000
X-Gm-Features: AWmQ_bmI0UZUWFDDf5w0nAKk2QHOEmBqLLbhoAo-8KUaIShwBk8o89lZIsfU9ts
Message-ID: <CAFEAcA-3SzHPmLc-huMnyNbZBnEwi5+fbPNuvCYJcvY7gYboEA@mail.gmail.com>
Subject: Re: [PATCH v3 00/59] target/arm/hvf: Consolidate
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 28 Oct 2025 at 05:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Missing review: 15, 18, 26, 32, 33, 38 (up to #41 could be merged)
>                 42, 43 (up to #49 could be merged)
>                 50+
>
> Since v2:
> - Improve host page size/mask uses (rth)
> - Remove cpu_test_interrupt in hvf_wfi (rth)

Richard found an issue with patch 32, so I'm going to
take patches 1-30 into target-arm.next (patch 31 is
reviewed, but conceptually part of the next few patches
in the set which use the new functions it defines).

thanks
-- PMM

