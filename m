Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA04C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfA9-0002zk-Uj; Thu, 30 May 2024 08:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfA8-0002yf-Cy
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:45:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfA6-0001pk-Jn
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:45:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1e980a65so605055a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717073140; x=1717677940; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9j40sM4WIx6v0SEVl9/BXh1TEkvNO4gXYvwS+2NaKg=;
 b=C+Z3a/e1j1grdEB1x7mJ02vJPbaSk7QMcMf6CSdrmSl10d9e6TBieon34+obgPUsSd
 VXe4vBHZAEkRmkY+MlRSIQI91b4ANhZapQWXwnmW7ut6BA6CCIRAzw1OJW/NFqwbtRvn
 4+82hX/nUTxUJuCysKMWy8c2NU9SYYFFHO9nL/6KAewmNmBqupTI3v8p15gIXn5DZnC7
 pedceQxiiBk+kZgHuZUkfAJXqRXoZ4b3n6t2HIeDtLlFCxg0Rx2psQGygcM1uRPRZ0Fa
 2NgnSSV7V9erogkdzZAZT0+HQw2+uKsLRtvJRB91vUTq56uGfPsJj5BCGwAk/NN5Dre1
 SalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073140; x=1717677940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9j40sM4WIx6v0SEVl9/BXh1TEkvNO4gXYvwS+2NaKg=;
 b=W9iNG5B+M3CLIv6rsmMaSPJI0aYZpHAccnQ4lQh0Chfv2o0xJsCtsu9RVYPi+cssGD
 DJZ98QpQwEd6PTWy4SDQ+uwDNpZFcM4LnfWA6xvVIB3k/8BZLiQ53PmMMKeTptoeT6bu
 Smz9/7PKGoWHCs48rZecwQO+3i1zChC+8d91xmdarY8VY7llVxqZZ1m8Td9TMV9RbdiH
 BYxT+m8D/qpc5rhCC1MTPk5qbgv5W4xDlD1EpJGpQKvq/bNfaW9/7aRZh7zSuSZ6M1up
 PCCtNzxjtJKjh9WdZc1EEU6/nArgfIagBOd827aiiNFgrBti31EiEwh45NE6IBgKS1ew
 l7zQ==
X-Gm-Message-State: AOJu0YymEdT0zleZab2kakyHU7EwzgBERfU+K8o8GcUB5/dhrX/7YKVn
 6S6Qcg+z28QNFIikcISElIRSY6Xz0I9CvnbkidoiBsdhjZttn5gaI5t5McRn7jetdRP4TN0mE5M
 uCqOHuf0LizjdZfe+MaqXj2F5Ru47KAb75Fqj5A==
X-Google-Smtp-Source: AGHT+IGQxJOcfDYTsPypPkzxdvmQDBatgy+CGgocrOCKGjMo1pgKd7nSaNzDnICU9hM9Zbl3d+Rxnon1pVdiJv3T4B4=
X-Received: by 2002:a50:d70c:0:b0:579:c015:5377 with SMTP id
 4fb4d7f45d1cf-57a17795272mr1323667a12.8.1717073140680; Thu, 30 May 2024
 05:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-2-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:45:28 +0100
Message-ID: <CAFEAcA_pnwrSEBgQcoVjXiHA_EKSOLoGKhDmn+TBNS9X5bA6vg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 01/13] risu: Allow use of ELF test files
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 26 May 2024 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> By using elf files, we make it easier to disassemble
> the test file, to match comparison failures to code.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 52 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

