Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08C1C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHFT-0007cI-RZ; Thu, 03 Jul 2025 06:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHFR-0007bQ-Sk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:57 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHFP-0008H4-St
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:32:57 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710fd2d0372so6755257b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538774; x=1752143574; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JFhMaeEwwADu3C6VXIiYJoBN4oIakfDgczE9dKM5mA=;
 b=qoEIDIGg7OtlhHpydyogF6uZmxgasPO0GkFU/8qTR6KNDTNStKpknO0cG+QwBSRfL+
 tnFh//zUZXX6B5LyA156y6GxvA/FIrQhKis0lWksMfJxtLK+IDu9rqllKoO2YvInJHGi
 3cy24aywk5ZSUZCiI8F7q9hexQ/kg4q0ahPWbladGUKCmOGHQVO6ic1CWyZpGjFzN9bf
 tR0kzWubZNyqDKfeX9d2NZWHxSpdP7uqVCDquIPYHicTHGojPoIfWxbBvaVCSFW1/e90
 0W8I0L+3fo4/ohRBEbh4bEg0VRaf52htlsB5cFmbGP4mIf+B2GqGE1KS4cjpFJEEdiI7
 kf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538774; x=1752143574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JFhMaeEwwADu3C6VXIiYJoBN4oIakfDgczE9dKM5mA=;
 b=Z/+5W2vxt0DqlP1CODnG6a9/QEWkDg5/ZC4+l49U+hrENu60Cn3RDVPg6QxDq6bVN5
 PTfxm9kr9br25uEuqo7eOzQDOj9i1tG8ov6G3mlQ0dfPiJnLmxzMajICZv+oT3hYTf7z
 J+3vmyvsgGmwrkpk1MWDFxxlxT/Xhj4MKBgamUCLJdKoPWBNwRNIkJD60cLMgedDXQ3Y
 GDcN5hJr4vh0vyMcEhwOBIl9uf49gs5B3TAY9Pz+iYYjT3x8T2LUi9YaZCjb7mU8zmJa
 HAUKPjH3WshyVOD70pE4MCDk5LQsb4ddBr8R/0noa7pjhUbx2LH4SAwNDB9UN34uinL3
 e7KQ==
X-Gm-Message-State: AOJu0YxNvreV7+yDHxOnQTsoEPCfLDB4hzSiNBX+nBeSZNOCZGKSiUMa
 qW95rapzloxMY0KePTvo2OZNMw/30iRdMuVloM9j7mQyPnQbzgqwakepHFqRtIyhJt9aStoic8Y
 /IrLzCyjclxLIfPZpaRDM74sLI1+V7Y2cVgGeKyNV4w==
X-Gm-Gg: ASbGncvHFxTNVANGMo1vyiom1F77pkECYEQ2CWJrCIjv327MqwvpEcNOVQ6NUUF3sTa
 UBkdec28jXuwlDJEkt0VdRNNQXHsgq8VdMNL65VP0I2gFzQ6hh6aunPBwAs34JTCKgLRWF/Vry1
 drCIjBsqFYsZNX8FVVAlcYjqfgYDKDNIrcIgQamjiu2wrnWGgV70IpAbc=
X-Google-Smtp-Source: AGHT+IFlCkxUMEtVjvCjkmTevhlE7cT7fpOUj1ITBrtJEyvH08vmJvsJPLTXniW+wz4A/Jzq9EvrwPOHSl3kzH5nnt4=
X-Received: by 2002:a05:690c:1d:b0:70e:404f:6714 with SMTP id
 00721157ae682-7165cb464b8mr20715487b3.19.1751538774260; Thu, 03 Jul 2025
 03:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-59-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-59-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:32:43 +0100
X-Gm-Features: Ac12FXyjpsIxNaUm7tI5jH_cl4fv0YMu46W-I69aQJA9D2iKQ7LP2iWMhUoiRQY
Message-ID: <CAFEAcA_-Z3SX6Pw8vsEE6MDq-WZVccOP1bS2Kn4-VNG-ub=REQ@mail.gmail.com>
Subject: Re: [PATCH v3 58/97] target/arm: Implement FCLAMP for SME2, SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the single vector version within SVE decode space.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

