Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D6EA4E08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3qO-0003be-IW; Mon, 02 Mar 2026 09:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx3pj-0003NW-2m
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:01:20 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vx3pf-0003bG-92
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:01:13 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so3622288d50.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460069; cv=none;
 d=google.com; s=arc-20240605;
 b=bsl96N+6R/max/t7l2LGRe8La/L9YbL5xfmd0XuqaW90Qk3Wb9516xsxL1vDjxoA0c
 p/6p14y5/OxyELmmCCNfidiCy1GrrCyKPY8+JdB5ZBOxlnDgp7J/2EX8FCWXBZ9kLWTt
 RM40x9Q+l5hOsL1vUBOmJWa6Lfr9dH9WWPd5dQ6XjZG5If4nlLF2lgxbZnl9HzP7x4id
 y9bhS8oHUZAoqvnNtazBHAjgdhoSZoapJA/I1Tf5jQJarslAJHR2eDR9oKoHD5C+icRI
 wR4XlfTmy4HdqygeXRZyF0GN6qAHlrDGyHY3CJzZGPvygmyaYw9oH/XPYJdT9ASVZCVG
 E8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FxKtkjBadrPD4oYWeNGR/uVqEgtggZyjfALvcexN1i8=;
 fh=imp3a1zOamCT2wVB4mhTeFcsaqSUAsHzgGZj1DD4DCA=;
 b=kETDh6wKryM1JvMkespoCCsROgx8p3qT50VR6ronOXxfqly/MTs+zNr4Bl6cdKJM8h
 JPw+dOOYlsRQ69gi1NAa5lQT6cDYbuhXjNYYKNLgpS5wcFblO3ZV6HYmYvGFizle6w8I
 OIL7isIDIrSGc3NgjyJ3jRa/JAnkSL37pQTs42uSu0n5hrUc1h7mQwKDzSR2ayCn5Gaa
 jDVWh0PLuCh042UPf9eV5w+8Al6zCrjNwM7Z3N/imlBO4206B2D2ttvGqNIQx9KMAOWU
 6wKXkJoDIzQMSpz0VMV9pExmUPJnpGibnNJ/Y0an19MCZoSuzRS7Y1PoTFQV3ZrUzjgI
 w8tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772460069; x=1773064869; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FxKtkjBadrPD4oYWeNGR/uVqEgtggZyjfALvcexN1i8=;
 b=nvSQ2GvvGl2CHzM9sXG4MM5wnVIcYa1TtKdLepvgGFnuqAcOC3NrgIsRnlVvzCKDeX
 qUiXT8erUQymxnaXIxYE2miQGuEFaBe94fMVGC3GWDlBafgtwvIYhfeAdJvWuYBXB9QD
 4vJcV2ExErgeYg4IpWRYTtJyIB9TU/lyV/LtXYNGvOL+qF2tgM8sL3BHWQheBz0LAwK4
 /1dV5Jg8YrXL1v6pWODtzIinAJ28AIBqwHsRA3ZnucAMlYhXA240YWbItOiaFgESMpoL
 oow0q9HmN+NGSHIgRpAzwgClBuJxGTR7KOWx4LGjpDUba6KO2cVL0r2YD/RzSFFKXtvP
 g/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772460069; x=1773064869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxKtkjBadrPD4oYWeNGR/uVqEgtggZyjfALvcexN1i8=;
 b=rAI+++/I7cm1BSDmYuqVinFLO+okhIX4A62akYTH9/h2oHD/xuz1EWmK9aljWjIqsb
 0dX045PulnikAPCLejRHWWRazeVdaQxLG+TTlDXcZaWkTwYtMmL7uhFr+NrYLW2JL9h4
 7/s7Z28hoYtU9mbcLDcxPVdB9//qI0+U+ACy8JAQYVcyRcrMhgO7Hy1NUWv1efBBTk47
 MpeUvlyTIf921oG2bGMLLoEvrl3+zBobLxZPOfLHnacjRtxrZ7LDx92AjB7PsuEzYanI
 RBSn/NTbnjdcrX5kQ9YF7J0x1qV+pvcJsVB62aj5W6oQLKh2ze94fWwNAyjBffiwXgxU
 kOGg==
X-Gm-Message-State: AOJu0YzfHJEi0NsKGZg+VyN4qk8ZFTqBVRQEX+be/vJFyt/72SD4Rn5B
 1RtCPNA6TUb90J+xfEb8sUaHnVkplEcr46vnZ9ZYxlzJSEdIcSMTgG3JCy2i8wBwUwYypAjO6DA
 B26l1IJ3ck437KL5v3E2tHtVqx2eO8W/LLN+9JP+szw==
X-Gm-Gg: ATEYQzz/gcxDL9u8fH7qO7be4HkJW2blINoewRF+MFAhxhGYzD8hErl3u4HB8uK2Kri
 7QAUDsbHVjHBmQOTAQEe6q+1gfP8R1fuqILT+c5eVSwqRBcIfddVXaR7h2HE0tkyylPk9eslInL
 ULhsKelBt3EDovnW9vnmAfs5SHATNV2r1njSCwhkmzKbe5/CinPS4NFmFsY/LX4D1Xzo1xZsM/2
 BZQde2WPQwPYLCbQwKeRYgggJ/xsRMEHFBzOcWk0T/XyJmapBaEidqDk7XVfS64iR8q804FXyXA
 GQ0QAzhqgB9MrS5qePG9jIWRGBoptVksE+l+T2jQrLhag8lkh74R3oOS6njsRR3TIvc=
X-Received: by 2002:a53:b5c5:0:b0:64c:b130:f5 with SMTP id
 956f58d0204a3-64cc20d4228mr6486763d50.31.1772460067729; 
 Mon, 02 Mar 2026 06:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20260302065230.56220-1-harshpb@linux.ibm.com>
In-Reply-To: <20260302065230.56220-1-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2026 14:00:56 +0000
X-Gm-Features: AaiRm53eeTqcTw-iW-iYNfoBcveZMZwciN77yJS9HJ_5dZvmOY7eXnr8Aj5vdj8
Message-ID: <CAFEAcA8dUmCaGOwyJZCu3=65DSYeK=fnhhwJjqaF-Ru=EuyfcA@mail.gmail.com>
Subject: Re: [PULL 0/4] ppc-for-11.0 queue
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 2 Mar 2026 at 06:53, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:
>
>   Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-20260302
>
> for you to fetch changes up to 8dec25e04e016e02c19cca68deb7ac6afff26cbe:
>
>   MAINTAINERS: Add self as reviewer for PowerPC TCG (2026-03-02 11:17:34 +0530)
>
> ----------------------------------------------------------------
> ppc queue for 11.0
>
> - Fix TCG debug assert translating CLRBWIBC
> - Misc Power10 PowerVM bringup fixes
> - MAINTAINERS: Add Glenn as PPC TCG Reviewer.



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

