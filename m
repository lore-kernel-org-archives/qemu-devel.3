Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C587CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhh5-0005KO-Hx; Tue, 28 Oct 2025 07:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhh0-0005Ju-5l
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:16:46 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDhgv-0002Fx-Nv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:16:45 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7861978aca2so12974177b3.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761650197; x=1762254997; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qq19yoNokeRIKV6QsVUrrWcYPH3C20bsjt6gVhyqZd4=;
 b=of3VAYevfrcQ+pD9Fl/zrjZX1q432Yb8DnMxJbaIvUR8XBjZIiUAlopjIyOMFcq9vO
 zuIe5S+mKtGXXexVz8T+XC79QDap8N8mWqe74euygUW/3g5g6o7Yh+O4aEmzOlbgVrg0
 RnON/ZJpfEPtEYJ+//AlANp6h56aOoWqvAzegDBmjnVXPc47irAM2oqM5MOQt40BSmUu
 3E+0DSJCyZ8X4b50iW9C0w377HNmouICxgv7SstHDNhuyMFSercbqNx3ykLrzS8hHMly
 NiJRW6kB0HsvrO1j7OTSuh/D5KG2pfFCpZieESBD7bZNDv0wVMjxTYPvrynKR6Ee4WPP
 kbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761650197; x=1762254997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qq19yoNokeRIKV6QsVUrrWcYPH3C20bsjt6gVhyqZd4=;
 b=HitqIpDZCdjTTYVkAOHE61C3Zryu5OEdDD+CrglfFehJISR8/nDKkiJi+cN8kz0mcD
 rwAZWynYU5FD+lMIxvYdmD/4kYE+oewuxVvkXvjUQZ9i8BdcQ+1Rb3B+WPqRA0h9JmzJ
 VJ1gO/1+Yl3MPqi2zxpu0iEendlwU4usVjTqab1Ffj4RtbbFZ0pSnQBIrx1jOv5yuAg7
 a1Lbe6XD+7DN9A673bvMPuzTtV7qrH4/0gD8ClWXpOoOmSrpkVwiuHJ0T2xw8/CGah40
 pA7UvY9nRTL3aMAry5dxdr5q8Hk3PEp2mB68jeXKhfbrlcZ5Ju4zhpe9nCaJynbW+Etv
 xxyQ==
X-Gm-Message-State: AOJu0YzpSvo5Vg86oWka8Q820cA+CNw9UR9pLyioxLnM692wp9ECBGR8
 hMROACE++ydE51RneKkcrRryyshNrI2wHOibgnW9xzDseLdRdm2SrGvFsyrelOG2qn+0I41NIfj
 zXxN32xu4nzJMJSdpH579Eg0xrK9HobZgAIMY9Q8OjjIr4SgftO1O
X-Gm-Gg: ASbGncs5+su0Gg4f9ARirTEWXp5q/+k0QjHrma4ZpzEMxDCUrLjHL9Q2WMTjeq5RvJZ
 Y+psCimiv+sNexGs25DLlv4E45P/FErjZU8hfOhpuLSAknU27bFxuljRdnqHMZ9Bet2nJKIulcJ
 VsuYF17Dm6Ng3qAAN5cymHV3pvzkNahUUIkM/atZuwI2A6MEoC6+QC8Ja9ETBMYDLa4/FZkgBZj
 T1Yp7Vxlr/OfB/up9udzVZWbLxfdQm6onGhvDBvjZGyxNYGaZ+VTbI52XqClQ==
X-Google-Smtp-Source: AGHT+IEGi7F3q6pF1+zy6W59GTZtx+d3+8rlBr38Jem1dg6LCa08F1GP3RrekLa6nf+9gdiLLCgBLS4Q3hoxSR9teOY=
X-Received: by 2002:a05:690c:92:b0:780:f3f3:b56c with SMTP id
 00721157ae682-786190062fbmr24081327b3.9.1761650197646; Tue, 28 Oct 2025
 04:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-16-philmd@linaro.org>
In-Reply-To: <20251028054238.14949-16-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 11:16:26 +0000
X-Gm-Features: AWmQ_bk6ZxSNt6FtSF_vfFnFHQfrQUny8bk3kq42fEzvXoDzNsArGBKJh9YxbYE
Message-ID: <CAFEAcA_uxT5CAZ4bdXjgV2hUe6o626Fg4X6hTDufo3ffSsn=sQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/59] target/arm/hvf: Simplify
 hvf_arm_get_host_cpu_features()
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 28 Oct 2025 at 05:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Use index in the structure, dereference &host_isar.idregs[] once.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

