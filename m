Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3AECCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhjb-0006Ex-4D; Tue, 28 Oct 2025 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhjW-0006DE-Ph
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:19:24 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhjM-0002Tk-MA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:19:18 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63e3a7a67a4so6270914d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650349; x=1762255149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpHM8U3lLFKgz4Lw76Bxs+M3n57MYbLJAUJ43ylwpug=;
 b=szoG7CcfTEFkH2NPrT4XP2eP6aJXRM3vkQzTxZMjFgjrcXFPPwbSHqJ18fZwy2U2j4
 GP6lrDgcdJUTH2e37dZTLWUC69CQiFoi7ZXUU0vJ7qaDc3NCW2P4D6YQ6hx38VE5SybA
 JZw4kX6KKN6I2wt0cb0rSnmORv0kXfpbvieAet2jrIQSDHBMFQQKsbxa2hoBieDWQfP2
 HUW1ISp0aZmi2PL0rshzVXteK0XCOSr+ppnI9J771VwY/BSsnH6Basz51Vo3uT1VY1mO
 QUdCnv2vKvt/3gEkJ3RQ+3gMW6BEnyNyDlC0cAGvsI4KEAb7OFPJKITFnNpWji/cuPKu
 2+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650349; x=1762255149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpHM8U3lLFKgz4Lw76Bxs+M3n57MYbLJAUJ43ylwpug=;
 b=SerhoVJDpBfjcFVYUUo03rYoty6I2wSefisXQxB6YcNaTYhlaxltXbrNGA6lsM0IS2
 eD0tGqgSShX2Hn5itDexA1hYGrrGdZlS8XgMRMu/8ZlohLTaKxl2ZIN9O2b4fsMzFK7s
 MwyZ7uebpgIwlvDxFQKY2HIv80K+47Ms93t9jXRt2ybGbDGrTPPfuJpNeUYA9wG2ZQhd
 bHkCm/lroD8vcKvdnC6pIFwrv5ZZ4j5ZIiBAYmE30I9p7AcA5sHyNbmxRH5EAfvwI8+E
 diVxGVfwMVFrRZcHrfJDnq/7c1mvMEcKRy+r0Zb86ik7BCK0qXvY1pEfpG64WooQMIoQ
 sHWQ==
X-Gm-Message-State: AOJu0Yw0a9euidDri4SAlRleTMWoVkEKNNa/V0GKLjAFfp8nvMwLnqZe
 AFKzAkZV0rW8n4VZ3cI2lyW7vDh7oQvtjOuCEpupZMurg+MxXcbMQE664AdvOUVXdWoFCx9nF8I
 7hrabA5KxU2jWYZgYCuJjlckVBM8ImzmMc1BNC/55BQ==
X-Gm-Gg: ASbGnct6vrIUwMsYzgPGDPtg6IiC2QJ5QkRmflbnpieacHf4agBHF6atK0ABphn8+6b
 3syLMPRESzP8wpBExq3nrLSnrpxGhaUfkAAPWIUQ7GjKb2T4z1r60QElHN94fwEvp5Hhj8dMFMS
 kb0tDa3Q6r99fNqkqo92y9fyZ3ZI+IM6QsiVBrfOFTNZt838PeLOpZdtsEvDu68P7GzWjF3vGz4
 VsBEWGtZmyc/3Vk5KahPPsLaEaQ5IixWkh01vhDmf+PCBV7PBQBTYlbviD8Gg==
X-Google-Smtp-Source: AGHT+IG2cQaWEZTSs0Y5epSzvWv+WKv2OKrWOcpuoYCSKtmeSv8VIghkBK1xbgr5cwszsR58avyIAqzOir9cSlQugMk=
X-Received: by 2002:a05:690e:4184:b0:62f:c634:4b3f with SMTP id
 956f58d0204a3-63f6b9d3132mr2616840d50.7.1761650349242; Tue, 28 Oct 2025
 04:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-19-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-19-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:18:57 +0000
X-Gm-Features: AWmQ_bn82SuPYVoiy2QwkORg7Xyc1nUDhibjfSmAdY2bG0OnlWp3ry_DXztbzmM
Message-ID: <CAFEAcA9FH86ja0GX_GM1p=2NSMV01WSefpNCgEZ1ap=xHju+DA@mail.gmail.com>
Subject: Re: [PATCH v3 18/59] target/i386/hvf: Factor hvf_handle_vmexit() out
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 28 Oct 2025 at 05:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Factor hvf_handle_vmexit() out of hvf_arch_vcpu_exec().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/hvf/hvf.c | 478 +++++++++++++++++++++---------------------
>  1 file changed, 244 insertions(+), 234 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

