Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E679C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxWG-0003cF-12; Mon, 05 Aug 2024 09:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxWD-0003SP-Hv
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:12:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1saxWB-0001UT-SP
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:12:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36844375001so4911035f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722863574; x=1723468374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h4XlR8VxMHSS8WKD7RwHKI7LSPcnYgbQZ85JulSk/Js=;
 b=feA/vRwryJn2LM7qK3+GvQquqZTX4w1+dEZphUygmx+nsjXwerZy/Utd74E6gTUSt/
 aCbM845Nd5Q4JgLQhf4OfHNb2NNCxFfSo/eqpXUqj+ahKFYzewXBtD2C7UoovinnQAtB
 ZoJQRxUaRtiGaG0y0sKdIxi23lP+sTmax9EtlmMF62AFxvUXuS/tKSug6QjdxLDaSf2C
 KsXPgLAZEimQFeK+9qGupWSTg0tWgNGMm6NHsK2/KGCTmRcXeEinZ0S8kswNZzSRccFA
 k1qYz76E6P7i7FG5dGQCeqearikBk1JgFwv2nXBNFaa6tmYTTn9sDkAcuQLKLkBTpU5h
 SvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722863574; x=1723468374;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h4XlR8VxMHSS8WKD7RwHKI7LSPcnYgbQZ85JulSk/Js=;
 b=hUDuBxfrvo7l8Mqv91Mig/kHg4LwnsIrfZqwd9LfW0TQzPOsR+nEDp5hV2tAsVrC1a
 IHWHY3bfChNcyALbOk1VBJQXD11VxCP6nQ6N2oo+jwEy11+TRtmYhTGXDTOjTEdtluwg
 wpQ6mVXxpHHsKmnsgTXTWYNEWu51Z3CYWFcZTjw/4IsYAycnWsuLb+q/Ml8vkKtcU7az
 3imytzY9DIDyN5c7y8CDpaVoazewRd9tCq3JWR+3dFLEvAmy/F8xZcjRLMXiLlfeP806
 GlH1kdS1rLlnfrwF+heFWyRh1ghBft1Yoj9kY9DzDMSEUhMLal0YPgg0RwXMvwplYNmD
 A7bQ==
X-Gm-Message-State: AOJu0YxQelahuZUbD+Qwy+8W4vMI9VDzDCrosMslXoF+kqRw07gdnY9N
 M9eYVFgj43cpv8tqXJDZEptmgNd/5JegP0BczY5vfl2WV0PuIoXaqBIj2+myCLY=
X-Google-Smtp-Source: AGHT+IHo4dGUydOHq+JMhqPWUAcqeV5B7flg59t3T2BI535tacSKjjMbUoFd6s5FW7dfjZa+5drWJA==
X-Received: by 2002:a5d:5f43:0:b0:367:4dce:1ff5 with SMTP id
 ffacd0b85a97d-36bbc0e7593mr9208117f8f.32.1722863573620; 
 Mon, 05 Aug 2024 06:12:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd059885sm9866063f8f.84.2024.08.05.06.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 06:12:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 605B25F882;
 Mon,  5 Aug 2024 14:12:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org
Subject: Re: [PATCH 0/3] configure: Bump GDB detection version for GDB_HAS_MTE
In-Reply-To: <20240804161850.2646299-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Sun, 4 Aug 2024 16:18:47 +0000")
References: <20240804161850.2646299-1-gustavo.romero@linaro.org>
Date: Mon, 05 Aug 2024 14:12:52 +0100
Message-ID: <874j7zru3v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> The main goal of this tiny series is to bump from 15.0. to 15.1 the GDB
> version used for setting GDB_HAS_MTE=3Dy to correctly detect GDB versions
> that support all the packets necessary to run the QEMU gdbstub MTE tests
> in user mode, resolving issue 2447 [0].
>
> I took the chance to fix a bug in configure also regarding GDB_HAS_MTE,
> which was being set even if the GDB available in the build env. does not
> support the Aarch64 arch.

Queued to for-9.1/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

