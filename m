Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C44C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6be-0008B2-N6; Fri, 26 Jun 2026 09:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6bc-0008AV-Tg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:28:28 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6bb-0004d3-KP
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:28:28 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664a09bc459so685508d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480506; cv=none;
 d=google.com; s=arc-20260327;
 b=SXKtqozthsMe0iAtm2OKThO14EW2OBoNiYLtrULQQW1wgpNHZEYJFebkzFbEQbRCKP
 wyDYSfiN+3TCqYAR85nmIumLmLI02RklKZHId3OgPc4QN/uENujRdrKC2791hXnEooAZ
 bSZu87pTA5/w4dLp82Nnl+bIEIfm4gkg//52cG7HaePDIQtROqdXuqbhgk9rhHhH/tdY
 4yioWoe6mTcN//WUam6y9vsPVvoyjJ/b8r3b6MljoH6byV47WARLIVuscn4r6uwC2iPf
 MLDoZ22wbviXlm52EH6QW9I52xV2yAUglG+hBHRZ1S3NKqnGp7riWYXvKd3o+MWPPLW0
 Dqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WJzzHpyJQa/qACYS74nVmXM1iRZOkgmQnkh1QkvEV2K7RNyA487vdSIRNOclhBH0mh
 l/HQPEExwmKZeblugidaJtQOnsWrKYwuj463w0zyz2GPRTdBE5UXtARUnE+iM93YoYlW
 9JBBXgUHlaLVdNEI4yM+HeIIQf7vUbq9laTlp1Tg9S/d/Fl3PEaZCgUtuTbsp+W4+z3a
 PHEHfufhFJVfwEtcQMcUpIj1aIojk0XWGMwAdwZtNDFLxQBV7TJ+LK35UTQnfHi8S1VX
 enfFH5QVbSrmnh2m0TEy2LqMeJqP7OYHbbbNieS8NQmResozPCvQwB4B6n927od0NjdS
 vcDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480506; x=1783085306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 b=JbkDLhax4uBUaKyUczwngVg/zvUH1h1OA0rszq75G1OuLBC6X108qYwGGuVAYJtpWF
 OEOKpJn7/gfe991EoD9f4wzF8bWQPVa6YSyen8mikmF6rMr0iaxv9YJCZuBX6hecUir2
 pIQYkAEFiEoRufFK/yKkHS50o76CJZr+i6BPZ1SJDSH6WsSFVAssqkjQ7VYsZaotzRaS
 xs6yCRXlPZVXwyirjkrJ0WzDzVve2Op0EUjeTdprcVpjByEaJ9qCfNG3glsNF9xUUpeW
 A7XSpvLh3kAX2zfMRZu9+7fPbsTzRBnTPKisvAyP3+RlWgfLIFYL8/yJtTeQKzDWqPjb
 EwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480506; x=1783085306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16rcxC9eKTWRh45+UkrBUmawBkQjl/XSO1guN6LYfy8=;
 b=rt95KPq005OkPeDc7A2DJ8ACnIga65X6B6G03rykvRnNHIDd80hHXiN8Z2GJAp9s36
 gjZQsdHoa8ZZURPQX8Mo+jy6lZKM43Qb1cE96gw0ekWMFgjm3F951uRc1OF1twZYiLIb
 Sw3J9lHuuEJayWVRGlqOLc/aVDAmyQn5hLbf2sE3mdEzoG2NUQuBLnMAwFoH/j9kn+n8
 RrwAMNROo1YCtuf0sJYX/kleSAuNvaOr3o3ZoT30lFfirGEXcpirmzbo7Q3eHOxvv2Ou
 Wfb6SkE6XZEBP2vxIlr5q3nGW5hhC6XjtmZqwpGTBtHMNWUHUgkCDh4PVTlg02I0KuBF
 XDqg==
X-Gm-Message-State: AOJu0YzvHRqvuD6X4+CThXPmTZGuu5cXSUEX+YHhUU+7kqMS+cSl82PL
 mEYh9TNHChkhYCs85fkLpon4h0dORiG9NEbr2W5e3dlVBbWxYTbhoPaYWqesD+XhOf/woN5gy4A
 /zyycZk/j/VaiNI7WtQPtlZqzLgrLf70CXayyflBBKg==
X-Gm-Gg: AfdE7clBb/HsF3fop1Mqck+YP84zcw1U0UR9vhOIpnvDlYGAw5Sv401z8K18WOecQM+
 T2j+m4dFtcinthOo/Iwi+qh411WAAePWQdaV359eTXxGlnltb+x1ZyT8DLTDOHOrM/h1xcL/nVf
 HwyG7BuUWgeT42t5ZgcR7i5lxCS9e5Blxi0r32pR+SnKhcF2pryBp8DrgtlnZPs6SDgMnhEWj54
 2NYZoaWNJ7TEIj0BZzPdeOVqkogIVLo6HwxQzqnM91XkmwRu5oXnJCapZBcLAEaeLv9RXSNpVF1
 WtEbOZDXfsr66g+DPyC9AqXF+gxJq/poasyvOdzXb9Df3JDCROozRbAA
X-Received: by 2002:a05:690e:b88:b0:660:82bb:e9db with SMTP id
 956f58d0204a3-66487e54b9bmr5440123d50.40.1782480506440; Fri, 26 Jun 2026
 06:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-10-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:28:13 +0100
X-Gm-Features: AVVi8CdC-TjmP4fBX7xeOhvey82_GKMkiuKFjALM0NJ7U5PQifT1gakByool_tY
Message-ID: <CAFEAcA8i+eu6XxpEDxKVgF=OkBF9FXTQJBgJ78AVx+_6CWJS6A@mail.gmail.com>
Subject: Re: [PATCH 09/15] target/arm: Implement SMOP4[AS] (2-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 25 Jun 2026 at 23:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

