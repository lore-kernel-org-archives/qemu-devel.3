Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11953CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 18:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Txf-0000sj-TH; Wed, 24 Sep 2025 14:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1v1Txd-0000rz-Te
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:11:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1v1TxW-0001mh-2t
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 14:11:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f32d99a97so133765b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758737472; x=1759342272; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oc8g9sEbIuJUY49r2NiT6W2ot/ONcAg0Dqf022GHF1E=;
 b=PeNff4jk/UZrqI2PMhEBbvPinj+GMbBz6idSZSsTjpjR2gPr+S9sMUprb8ndo3hPf3
 m78o+CYp9RhbJBbNgidiEsEaQ6OV4EGGlG7x0xRch/2JQenWbQ/lgo7bmn7PPjMbs43b
 A7rjxt4QK7YvZO4FWoc0TD+aHTcf9SLubqTgncf6YyQ/0sIqmxoMmrnwfasUPDsdQqNj
 xlYUJPvAaGXdsxci7AQykucwlKDJn//IC7DjmSP2eqYL9vA0zb2zeRmjcO/SBip9n9Th
 MRsVcaN9FvYsguW5lTs6WnXfJPhdBBCRHXa79LzJ19xeM6jKOWQ9y8U+mHi+HYNpba0B
 Dr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737472; x=1759342272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oc8g9sEbIuJUY49r2NiT6W2ot/ONcAg0Dqf022GHF1E=;
 b=Jp1xJyrDoalr1fQJrS1UyjY3rgmt5tC3/gpeLI2IF2gPYvGtu7tXGfLnw2B5JGX4F5
 hPXzp+iv7BiZWQFdAyjvJQL1s12zs2uNV/dFzjzHWWtKYGwO1sTAwNGyF/wg2PZwm8Xl
 lcsarpI23uOfPw4Rp3yu+ST65Ui3z2P1I3IFjjiLHayh4dH7JWSlWodfh6+DkdOeahml
 7/Iq2W85pvDVOlIqBftHsSPwEUQoHSRIXquEgo+PBr8wtKnaDfao0xeglPf0nOGQNHO0
 JRjYdzXwgLhozpfURETM5LcGVI7/0xG521fKoy3YJGSHv+Y+2pTexBUOvRDo9RCLvnIx
 6Fcg==
X-Gm-Message-State: AOJu0YwMVf6LEny9j3OuF8+dIeBLlHP+D8pyUUtG7Qv7NVL2/PMWjouT
 Uj329zUD2AU2EOQICugT5nuSSUXWs8tX6mGhpNY8i7+k/oDk9rAC8oZ42raGgVdxsSZ1vEHBph+
 0UBaaIVtM3ymBMq1VbEqgCIuypsX57i1PEA==
X-Gm-Gg: ASbGncu+7YxFpwtQ53vu3VvwDFDAQxQZGMZ9eCB4w28TNels/9PX5Ez88RYwPNOZBnU
 G3jpk25Q0uQelRTvJRRk2oT5JENjCeSI70/auFS5OJIxaZEu3RG/cyO5PnfgMQlQPqZXBYnOrfu
 GFn7x1vVjb7Gh2ZzZTlaR1IzQwLnZ3JL21oaMoQSnChbmIFCQwdLfJlAC9bXs/fX+HdXG8YnwcY
 Djpon1ef2UT4rK74iM6UYYhL7pzBtsT6RNEYoI=
X-Google-Smtp-Source: AGHT+IFdiNdWmFQQgZeD+GFyDilirfISXcGikX2OL5katfTaQFUS0R9dhj1d9EpUp8t5gqIdniSugs3phorneaV14GI=
X-Received: by 2002:a17:90b:1c04:b0:332:2773:e7bf with SMTP id
 98e67ed59e1d1-3342a2b9566mr576154a91.18.1758737471631; Wed, 24 Sep 2025
 11:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250924174045.54241-1-philmd@linaro.org>
In-Reply-To: <20250924174045.54241-1-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 24 Sep 2025 11:11:00 -0700
X-Gm-Features: AS18NWCijtoIxKye-jK2nK4ZJQ8tixwxNAOEwPkGPbhu-oIOQrG4Eil2fsL4C0A
Message-ID: <CAMo8BfLjU3w+Bkgb-Poa9+68i2u2BEJaQkVdBwTyF0JrJOBt4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/xtensa: Replace CPUXtensa:runstall by
 CPUState:start_powered_off
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 24, 2025 at 10:40=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> CPUXtensa::runstall and CPUState::start_powered_off are
> semantically equivalent. Replace the target specific field
> by the generic one.

xtensa runstall is not about powering on the CPU, it's about stalling
its pipeline. Also it can be applied at any time to a running CPU
to hold it, deasserting it will let the CPU continue running.

--=20
Thanks.
-- Max

