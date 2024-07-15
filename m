Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C637C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIYb-0007ep-2l; Mon, 15 Jul 2024 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTIYY-0007WU-RC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:03:42 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTIYT-0001Sa-5m
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:03:42 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c1658c68so450345966b.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721037815; x=1721642615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wJMyMUb2GJDpZ4jTaypVaqOfXXHMdeFa01idvOE1Qu8=;
 b=p+K/+XT0UG1Q2B6iGz16C5WNCSwOYmU8pVy3mXrqB6TFlE093bOzL7d8fqswqKIFMQ
 sOsqsq2qO1PaNoZr9Bn2shufMCBYDhgM/Ot+hCQh0+fkfBcwegGnnoSBtozsh7gJ73Ke
 jL8s3+4bBdxDZR1erOw+Wmmnq882r1Wmnwwrem8ElRsVCPr1Pp/KVSm+yeNeebHKPxbh
 zI3UB5nki9rNMQhopzIPLtQfjZt2gpdqLEXEebCZOOECPUwvTxvBHdEzECGCYhw6AV7D
 cIw/Fqf6Ea29RdZHFf2rmo4T72svIBjFocGoJ0ytlC8L1xdRrddt4ygCltyw3/XFiBWL
 DZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721037815; x=1721642615;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJMyMUb2GJDpZ4jTaypVaqOfXXHMdeFa01idvOE1Qu8=;
 b=k938m/Sa0RS10NQODWfDX/tElvD98hx9Bi5sDUIfgzaFGw9dDbHtXeoJQnNyOmI95k
 l8K26gLdEXnbn/G/8fTThs8omxb3/6JGQQAnHz3v4gpGcfHkU8+sxpNaIO2/QrDejzSA
 QVks8q2X69PXF1gvtEKpFdMyxBEkFh8wsaYKuK9wC1ENOTJZXo1xICl2hMAsLkYM3PGC
 MAb7v8aNhdnS7T8kuccoeIgtf5kLa3sgtldq6txDJjrUV81BuddRKG5rnDoCSDHA47x3
 Nr2+8FDB5ejDO66mxkXKLvScFSwsujiDOT+d3FqE9ykX3oE90SWT4EqqFgC3csnh9aAq
 Kotw==
X-Gm-Message-State: AOJu0YzQcEf1qYccHKr8kZEQ/fKV3UfybnAP8udH06uLB3PPX9pzqx52
 irEDotmFBawhZDKIO7wKnpxttTCVM2MZxQYmMpwaXm+0H8mz1rrXwiYLGqtCh2Q=
X-Google-Smtp-Source: AGHT+IElNC8w9udhGB/uILC9jLCpV5Yvn29vwyPM5nKj6ISbi61SKaqVG5rNBsltMj4oQoU78ZbOZw==
X-Received: by 2002:a17:906:3c04:b0:a6f:2206:99ae with SMTP id
 a640c23a62f3a-a780b705382mr1082820866b.41.1721037815071; 
 Mon, 15 Jul 2024 03:03:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7e79sm195185766b.88.2024.07.15.03.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:03:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86FBB5F8CC;
 Mon, 15 Jul 2024 11:03:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  danikhan632@git.sr.ht,  qemu-arm@nongnu.org,
 qemu-stable@nongnu.org,  Daniyal Khan <danikhan632@gmail.com>
Subject: Re: [PATCH 2/3] target/arm: Use FPST_F16 for SME FMOPA (widening)
In-Reply-To: <20240715055820.319035-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Jul 2024 15:58:19 +1000")
References: <20240715055820.319035-1-richard.henderson@linaro.org>
 <20240715055820.319035-3-richard.henderson@linaro.org>
Date: Mon, 15 Jul 2024 11:03:33 +0100
Message-ID: <87sewbhszu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> This operation has float16 inputs and thus must use
> the FZ16 control not the FZ control.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Daniyal Khan <danikhan632@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2374
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

