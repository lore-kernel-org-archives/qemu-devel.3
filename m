Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE691F0181A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRok-0002KR-Ft; Fri, 06 Mar 2026 04:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRoj-0002Jw-22
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:49:57 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRoh-0004wa-FD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:49:56 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad8435f46so8652726d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772790594; cv=none;
 d=google.com; s=arc-20240605;
 b=QfAmxDyjOLZeO/rfbCNkV6N/Kk+bjvO5E30Xe+0otTNXDZuGgwHObiZ55eAJ8LFucb
 YemnZzEaTI34ye/TJ1PX186u0xlR6UKvSrwfeL9/FAIjk2XJfBfR4miBC6rSTDNn53S5
 AR6N9TJvtv3q1kqRLhn/va9PTM4Uzpi38YTlQBuYMELf0OrCMG7FHeDDKDZSaQCCMLpg
 ZTwkLFKnmKS+79lz3IjiHWM1IAgQ/Exg3AO2WyM5IeOjN3aBEuDEFsbuMnwoykKVc21s
 /ToK6Z+4OP+pMqfI+X3uuZmZEzDn7EkJBRRfpq5XqqddnqJCGb1hCC+/K39tLa6xehUQ
 +LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gUn1nqn3wclmJWxblTsaUHjjS0ijVhXE2LYsDu60P1U=;
 fh=W7z8qFQGxc5I6dbU3N9yuhnG8qdLHZ6a8lYYZC5H0QE=;
 b=QRlix4syhNTMid6YYUlUfDwzvT6aiLwI8BwevH8wElVo9dYsEwhyOJ0FSnaO+BhlFV
 +H0ExjiG3h4lpyTkYRoznyqUI+GqxMyZlbU/sfG1WFveNP26RQTYuyuuflJoVeX0hlHp
 GitjwIdXo8l/YgbOalFQwB3Dcd5p5mX3nrxF3DPW8U0PJhxInbmYjEbsxkC8mjzHPdAz
 UNLn0JCqJ9YWS3HzuRc8P06AOHhYWBFGPttA1cYHg909NFhnbANToj/xukBSh5ZXt/wW
 5eQXm6g78Z/X02jtq6qaE6umWEQaFBDVpW3U4WaufYRCGMDFjP6mkMCbiMU052smmmCN
 p5sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772790594; x=1773395394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUn1nqn3wclmJWxblTsaUHjjS0ijVhXE2LYsDu60P1U=;
 b=ngzeTCmh2768q+IH2+2o/3ksmYqkbwJJpO6EMg5pCdvHCF1I3ucmbfcT+XD4i7MWIO
 a1s9jQ3TLgxmnJdrmFtlKHIyJlDjC62ix16brLhyIwA6MnF/D4THW0gLfMwrn0Ay5U5B
 kDtwje/W8tCwQqyokbDyhJpxJpOPyNi1lnEwvtfLdGD4sNkzkuqm5a/MbTn9t1YnjP/J
 aKZfEHCG6rUrd/cDiyDcHiF8BXe08XdpRvNzPBmCQ+ckDoK7ZfGbjmi9GnFREQ6GM8qx
 0gEOkRwbqa/H4ScOzW43M48aTTnXDdlLxq6LXhuxLZ0T9T9GQNsR7uw+4q+2JYCxFQ6k
 IJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772790594; x=1773395394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gUn1nqn3wclmJWxblTsaUHjjS0ijVhXE2LYsDu60P1U=;
 b=lPeTkVr4iQKuihS815I1o6q7sr/M/6lhHTPM3wb9uOcw9tagX8wF0InfX3L9Uh8fb/
 ASAGgCSFT8vlFCu5Qtc7KFp7dqosrBHKq8Tjk4F0OQ7IC4fwvVjiScJSWofppu+fNAxA
 ntCTlEqJZyQwhqshwesZuhOOzLH30GLbYEo67sHWuAZISCXmfeEukjRbvtSAn61QDSGR
 rX4BE42Z6T+yISCD16NzBWHoisHlyjimVQgVItczMdMJ8aAHh5qtSdAdQ1vqj7XQSYWi
 n4j+sYhrcYRfk7uM62JtUIe1hszT4rh9IdGywnrd+YH0Uynqck6hn7JOPu8lAGIPc0jl
 C0WQ==
X-Gm-Message-State: AOJu0YxXP7Ohn4bPFDh0g+BBCUiUdrCeJGl3SzfK4i3jkzCnzNJSxlXF
 qt9tRfQM7k63gWeoJ0/NYMJu/GgVvZPwQg7PRWHWzc/RltVV8dpIYFMFXwfpQvnBZ8tOIXZzAED
 ducYmXChCUc8jkrbtk+EilOIuKNLA0SDke0a7TUciKg==
X-Gm-Gg: ATEYQzyl57pbBNS45xcyFp11MfNmDduVtnxE3HWPwF7ahMP11n90PocYQG4PSG/aJAr
 NEl5AaTc8m05HulJDbtrkoFXV1emIAcOYZXrWG9wx18NNKItb4hI9SZHCxbeFeswf791QaFZAdA
 YKUqtCQo+tS49S5PyEciDLLzRcOP3+i2j1GULGeOE0dqlTT9s/6vJRKhsVQ2/AXrdowrUkRFXmW
 d26zj5c2EwKZXSIqFw44luibdcvond8JuWEPPRZRATL1lSvkjj+cjiGoBqisQ+U3n81b1+9EVh+
 KZzxFABub5s2s/F3FAUbz5mLouRy2izVgsfJ3wyXNr+/OtNvwvJGvXx91TY3asBzbB8=
X-Received: by 2002:a53:ee57:0:b0:64c:f4fa:4030 with SMTP id
 956f58d0204a3-64d14147f3emr1183053d50.25.1772790593989; Fri, 06 Mar 2026
 01:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20260305174743.3084606-1-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:49:41 +0000
X-Gm-Features: AaiRm53944RP3nbQCH4yDEJiFWk2oBVqmQ4IdLDYRUArj--z9TMadt_OR9s97v4
Message-ID: <CAFEAcA8yfT_BtdF-oOtW4BJ8h2FSDwgRMdMt_HJc1g6XUjaC3g@mail.gmail.com>
Subject: Re: [PULL v2 00/27] Misc patches queue
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 devel@lists.libvirt.org, qemu-rust@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 5 Mar 2026 at 17:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046=
e9:
>
>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu in=
to staging (2026-03-02 14:01:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/next-pr-pull-request
>
> for you to fetch changes up to ca61f91ef9b0d10333881fd0070303ea33cbc72e:
>
>   util/oslib-posix: increase memprealloc thread count to 32 (2026-03-05 1=
7:40:24 +0000)
>
> ----------------------------------------------------------------
> * Increase pre-alloc max thread count to 32
> * Fix checkpatch warning for new/removed files with --terse
> * Detect more GPL boilerplate in checkpatch
> * Fix lean of data in TLS/websock GSource cancellation
> * Tweak CPU docs for DiamondRapids
> * Unconditionally enable thread naming
> * Fix race setting thread naming on Win32
> * Add API docs for logging APIs
> * Fix interleaved error/trace output
> * Fix missing error prefixes with warn_report
> * Add detailed error reporting for VNC passworrd changes
> * Refactoring of error_vprintf & related funcs
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

