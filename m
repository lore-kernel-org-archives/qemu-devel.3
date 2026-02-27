Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A1CFEFB4F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvy12-0006OO-NH; Fri, 27 Feb 2026 08:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvy11-0006Ns-1G
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:36:23 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvy0w-0002Th-Sz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:36:21 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ae222d978so1825053d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772199375; cv=none;
 d=google.com; s=arc-20240605;
 b=Fc8sjqHdwDO/XKvDA28mJjVBaxI9C3GE0mc2psv45ReRpovvBUPMSZjA6Zd/wGIchW
 ZeJBIhdeAxggn2CO5ij1wrDldL59CTRmEVQQQaj068A+D5IL6rMwiFS5dCyqNQIT6iL8
 CmGgWm8YXu8xc+x0eNenogz/efFf8F9slqqZ1vzDK0Mp6ImiRo42BSDEJYlySKKMaggf
 WfYlI4z1r8+wLgIm7LpRH+K9+ecqtXQVTgZH5w1FJlOR57xbbswxbXucy8ztnbmLbwKd
 BtMca9gHX+JLoUzlv76kCFNGicDPZEMLUQ0uCvZGD5LET+5GWPBNR5MjHFYxtCg0vcGt
 4Dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S4irztnqbbgQlCoC34C43pIRxRtPZhHtjrI1JhWV6sc=;
 fh=R4ICwLqqLoRGx9KpJH2L+RpE8XRID83H1PerdS4nzwo=;
 b=JkwxU04eUmzMSujzefzFMTK9VuB5AXnjMiyHeCMQm4/sRCLuFIMZhPC1hzCSGwjGIm
 ybxFqOAgNkadNwMS4fV5GJl4US/4Y5YemGBalxn9H2OAbA/xxkTLtGiBTM/T1IFwZD2x
 l3R45h+L+2FTxI1e/tWHpTRKpWaeiQ+wDN07Th56hTDl7dgFBo3E+KATcqDBQumZu+Cf
 8HEXMBYH671sCMGeuITKskPNuwR1i0EflLCg+8vr77kPr1p2hldUrPoRGKJV16hHXjMi
 Ge/+GPuXcIdSQawEDV0mD/NzVcVrJnbT8B4sKb3T/L/aUvW+hRbx4W+9n9CGAMKJBgIY
 Eg/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772199375; x=1772804175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4irztnqbbgQlCoC34C43pIRxRtPZhHtjrI1JhWV6sc=;
 b=dfa42zi1qB7WAW/CxCFJzWQbAPa6/wA4W9FXK0mktL3w6S7gvw520IcH/wcyZIbbUS
 APx26mST6rc5kf4rz8D0jibuPuhmLghLmcwP346XhZyO0UWDjcD17VM7tZQt/Heo4eH8
 mUXjxqmxhctpfIT6tYrSF+QkwSYel9pXx82dk+YWMXvdks3fq/Xgd4hO3V0SdkEdjZTg
 KTOpD3LOqW9jokNTssN8TM/wbplMBMX7tltQwL2NyQGgjcjLdDnMOqQUYBE9Ryu/StEU
 KKi6WrKIlilGmp4QB0AcbLUAfkdmrbqUHsIMPKNm0dC5EQzmZB9C5Qw3twIXiVOy6vc/
 LM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772199375; x=1772804175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S4irztnqbbgQlCoC34C43pIRxRtPZhHtjrI1JhWV6sc=;
 b=UF00rSvyQMDhWVpM69WtYc5pOWnul8aoY7+QfWJxDbSeaDFWhY74xfLX9thGcfYjci
 ZBxcJ//V9FcwuZjnEMnkeB3dCQXVuAxdSrVyRjJhkRBG5lQz1mRH9DBlPsSzAIhY/yGi
 St/9+enMqPZXrCkxZBXp2MeMMh4hGavUXNTvMiWE4MsyXoFyBBrpf9wxkVj4p5EVtJOe
 XIEXyp2IA1lJYaXG8rA1yeIEWKnIo1xhB+TNWSXZhzeK4uQF9EsENB/7cqWb+P2s56Fl
 0iBdsBKggaJYbWF61h6KBgSP5QtpdCBe4617buNAibG3an+EQX6SzoXvNx37gFdg3nFD
 LBEQ==
X-Gm-Message-State: AOJu0YydhJ4zWTj24v7+T5B24rsFrVl8II0HDbHYqs8Ja3/C7suoGPYU
 0rM9ayKtYt368FeV4Gn6tmD2qIqd5u7cWCvCtevgCaFgNfTkQIEOODJZepCj+erM2tnhAjCKBBJ
 qG4HdtACrwTDTd8fSIWeCalzjGvY3p5BhbFYUwTMu8A==
X-Gm-Gg: ATEYQzx/SLZ0xjxFU+CtItQq+3ZoAgyiq5DJNwLi9Xrvx70UqpYljg+WHv1Z90zy2YO
 i2cIzKSW6/0EjXUiU0cyQMhgWtXRd5b33LrhUfk478ntSYCbv3p3aCLzW1Fanw3Ud38EabwAk5Z
 FLkxcF9H1A9rqYD2jL3L9lWUcyA5sH1ZGo6CfhNixvBh7P29rgxN4cMmyq5PGzN/8EKWvuVE4i0
 cfhQN0eGDCBGooCrUEuqCv8O9Yt+XdcytlayxISE3s1ZOdLv6TRSKOJR1totKf/mc6cjxK0Y74r
 AfT6MEFnuZIHsxqGBZXyZjDHo4kLmawZYt7icrQAQlyAEx4CB0MP5tLyqJRtPCbn/R8=
X-Received: by 2002:a53:ac9c:0:b0:649:b851:4eb with SMTP id
 956f58d0204a3-64cc22100bdmr2606703d50.53.1772199374837; Fri, 27 Feb 2026
 05:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20260225034451.41338-1-philmd@linaro.org>
In-Reply-To: <20260225034451.41338-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 13:36:03 +0000
X-Gm-Features: AaiRm51VAa1zifQcOFsoVOEXynBvuazfWCEr_Te26Q1eijg12ZVJYwSm0I3Ahmo
Message-ID: <CAFEAcA-U5FdcNC-RQL1rkdPsVBWuk8-4B_JFtPMWS0eZid8L4g@mail.gmail.com>
Subject: Re: [PATCH] hw/cpu: Build a15mpcore.c once as common object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 25 Feb 2026 at 03:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> a15mpcore.c doesn't need to include the target-specific 'kvm_arm.h'
> header, it only lacks the qemu_get_cpu() declaration which comes
> from 'hw/core/cpu.h'. Include the latter and build as common object.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks (and now in master, looks like
I forgot to hit 'send' on this mail...).

-- PMM

