Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BD9CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUuG-0004f6-Gf; Mon, 11 May 2026 13:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMUuD-0004et-7h
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:59:01 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMUuB-0003pC-8T
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:59:00 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so4871913d50.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522337; cv=none;
 d=google.com; s=arc-20240605;
 b=Zv1xccvAzogWF3QhkqdcjslIP/3DrfpAbWEvS7wl4JQbAn2OW8m+S9GIJFsx8p+kCF
 PJIJntHeLMLBNwPv8tmhJynlXf2xi03srzLfRapHeV+erTz5gwPWTRcMI2SkFY1Cbr7Z
 RIU/IYFUBfI2qOhvHURu3Y3Q53INykDeg4aEwQgImSQqDnS3Ux7pEz9JBaz3DiRy7xIY
 tQXJuVlYhVMFMeEL3p0EE6DQxx4bFcvh///6ivmk2ZZ/ZkMEVPzg1lmCKocxdYAOcsPo
 DDchvMs+R0e9mjmb+c6sVTeH000NIpFmd3L3774LcXmPh6wyBG++UAtBhboz6mxYn/uk
 s9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RJk9iFoQl/oKeevISKQlPn9xZuD+vq8OLHjG3fRk/P4=;
 fh=C0d6MoelyxnyEnZgqQ38cA+Tdf2UUaAoHDpAxiJFa0o=;
 b=N6z62V73B8DxdLyAnLqzns/1URl5JKxLgwRJJbhAMVjSQzwEdInHegQpfWAnqRYX7J
 VVnfSimW6+JtOwgAQabHmR6H7rwrVwTgK7OehZWxztp2FpN5iyHcggLJQEBdKPnjzeCO
 zwS7PlCo1FjLD/oeoqaLymQQRtOW1trdxyhMlI9kH+uoNVHoV0WuH2s75CRP3fpuYNs/
 q9RNEfg4B4clX2EZufPJJ9kByTJN4m6MZo39ooJy4BPmVzByIzl75OWN+p2S3i4ANjFV
 zSCWmag52EKqz5l/ErpTmnxEBNf+mxfvgJvfpy8mnafnCtigqqmL13M4qpfjsMSGoHCU
 XRVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778522337; x=1779127137; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJk9iFoQl/oKeevISKQlPn9xZuD+vq8OLHjG3fRk/P4=;
 b=Dju+1C4r/+r6kmZKxi3ioLnt419oboD42nDcaSrQfr0pP0iCDkEEb4SSpLvSWo7lDO
 72m8Hb55NFllmqQRWi4vb3Ox8QHVZ1lls/+X58ttdlMlzk0slMpuEWetQSY6kYrVSc0K
 U0274tf6qUoKQ+bP/paLlmMU37IFutgx0lOjXCqpvT8sz1AwAX2hqm6h7+NDLgv3m9fi
 imkrKrvhKm/142aTIzqdZ3v+F16CUk18aLbUzzDoETXD5Sp6grI7MwzySJuGFb7cbR7d
 6VZ057HxTY4u6Y4WIq7fe5iXpPVHKJrAufxmgRnXrraLJMatJ11zbC5zo3yNKK1bzwx4
 6vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522337; x=1779127137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJk9iFoQl/oKeevISKQlPn9xZuD+vq8OLHjG3fRk/P4=;
 b=rWYZ5gIVBS4fepK4kXAL8Mi5nZ+IiWvLLwXxLPXPdgpFCNzbOYE0CfnlM8Nmxcn/G4
 YroiRlGG1j+1k+3LYePx/xwxVDtcJEaIGTBVTJjvFlUR44rzIfFu3O9yMuZZt2BU71f4
 +vjSuQpL7KfMxzvGXFtJwh71h6NiSaGx5xt5RzWwn/LOYHwKLqzBtuJDSARExCAUVkyQ
 oh2lpukTlXSSFro8ysGjv+y2n+IZUlQSHOBPgfiBD9Azc/AozxSJtpcZoyxS4Ij666sx
 Whu3/YcC9D1HB0qfpUXW+rntfVsVVOzsmY6sDE/9GcNO+bLMnmxImiHu5kBSrWexRwc7
 bQDw==
X-Gm-Message-State: AOJu0Yy0larABrgTIs12+igXNlKlE6QrtKh5zfKWtFFzw3CkBM1bAWwR
 2tKlpV7BKyJZ/wryq+syeVUO4mNWuay+6HYcqGBEIjcUNKp2GZFZq0x2Qict6uyfPZ+sOL6lpdI
 XtbqMLVhM1EUyOcEWF4QQSThhbvsOk0q5AppTsym0kA==
X-Gm-Gg: Acq92OGSZiY5AhO8C3Vja7Uvu5WicoSrwiMB1pyghyoUP+na6qCszA6n5EmsgJeRCKl
 Fo5bJ7Enwxsn9tZfI6EjZYukpdMJUQOTzwsgznFS865MFZfPxp4SNDtDlUSOWURQ5KOTPtO5rpL
 c7TA77dm3Z9Mr8px04/OEuhPlz1kd/r/sSFLlTyTSJulxpco36587p9Ls2Z2PwtOHUPu7zRaW04
 60qc9vWuOI4IOg+PT3gRtAE7QeHmoQpDaMpbGmD/z708qmdt2ulWa0CtsaXK0MApQ6ZrMmPkI+M
 jdW1pUfhGFYqH1yyx/x7wVf/0hbLKGbxjeEdKPnrFAdNL1cjntnNxLWoX8E0xfmyGyE=
X-Received: by 2002:a05:690e:1aa0:b0:651:9286:57a0 with SMTP id
 956f58d0204a3-65c796e60d4mr20137594d50.0.1778522337209; Mon, 11 May 2026
 10:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
In-Reply-To: <20260511170500.124211-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 18:58:43 +0100
X-Gm-Features: AVHnY4IGcl9qn2AqhsYOKEkUOQ2buz_exoxdiZusmj2vQCfknTERvuvPalz2QJE
Message-ID: <CAFEAcA_tTR0dXKGp2y3YanS3wASrMSgcNQAiET3ff-c7HfBLBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 11 May 2026 at 18:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This was written initially written by ECA based on its understanding of t=
he
> code base. I then expanded it with links to the various documents and
> the general coding style.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +## Security Policy
> +You MUST NOT report potential security vulnerabilities in public tracker=
s
> +(like GitLab issues). Refer to `docs/system/security.rst` for the projec=
t's
> +security stance. In brief:
> +- **Virtualization Use Case**: (with KVM/HVF and specific machine types)=
 is
> +  the focus of security support.
> +- **Non-virtualization Use Case**: (TCG) does not currently provide gues=
t
> +  isolation guarantees.
> +- **Reporting**: Report vulnerabilities privately to `qemu-security@nong=
nu.org`.

I feel like the important thing we want to point out to agents is
that not all "this crashes / asserts / overruns a buffer" bugs
are security issues. As it stands I feel like this text is
going to steer them pretty strongly towards throwing anything
and everything at qemu-security@, including bugs which we
don't consider security issues. What we want ideally is to
give instructions that will make the LLM itself do the
initial "is this covered by the security policy" triage.

thanks
-- PMM

