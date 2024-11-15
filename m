Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AD0D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBz3P-0002UZ-Lt; Fri, 15 Nov 2024 11:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBz3O-0002TF-Cz
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:20:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBz3G-0006he-Jj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:20:13 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cefa22e9d5so2236472a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731687603; x=1732292403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hi3IYa1oiebpItviUFMRjKe37lDdfcXpu3Iq6daonLs=;
 b=j4PQFTmY/NaIyFlcD239nrF6EiSrJBVzmeJsUsM0oM3yslW7UqLRtNARqJX6cdCzzN
 wHOCODg5d08VqPbpUwIW0axaBPnlihYbrOFm5EXGfgmDC15TxNp154mK7P9xYXfMvfT9
 ooyKsjG3pU8CiHrXJlQrrjpgmUkabsTs4BDVP7OQb9y7v8hXQoCwnWl7f9GsCrCYQUei
 /Fc4RdsrRjcLTdaxikZYJNDwcz1b4n6QdNGFDZUAYBTX2nCjZsunyhUrLGlKmtpD+p5F
 Zcv688XS5SQ+gSDkCP0DteqW/ctSGTvMGAk1s7GSTLDa672zsWM2NwczeqiwsyaXG3A3
 G+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731687603; x=1732292403;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hi3IYa1oiebpItviUFMRjKe37lDdfcXpu3Iq6daonLs=;
 b=ZV80+PkfDs9QeJeg6YKDVN7GOKZtQQp7XLa134NdyzYW8yFkHzVqB7Yw6aazO6HDDL
 C31ezvHqJrwwqLVtOvDDCHXr5m0WT/guRy8wx1ZDJBu2XAkhX3wIwzZUWVOHuGytH8l0
 LatM+cZEODXyKCl+MSu+ODJjzJJ3eeqrqhOJSXyMyHiKJrVlTr1hbkcul6+S8vlrH1oT
 LTD63jSGlqFRCEoDIpKPXCg1Rvp5jxdxU5nzhhBwe/P0I5kXtuSLwpIv/PKO9cNXiaAW
 y2NAtnpyG2Jb7F8YEFytcx+Vl6AQHK7lysFuofeEafj4Qut6OH6fqt5KfxbA2jLisVKl
 WBEQ==
X-Gm-Message-State: AOJu0YzIahx3ORum+zls3BKKzq3+X+ENOfzm8RQF3u+Q2QX4FdPn5MxP
 1g1r/gIc6F/yXXAh115kQ0exJUSPNtf0LpfEEt4NyiIw5AQLIE14+YtXYjPYHYddYTrn6lCArlu
 y
X-Google-Smtp-Source: AGHT+IFr/imrEzVAd48SzRZ2iZRFWKpMvRL2CwlMOpIn2vrZ4zzGLNKdWeAXHNKQJuwrSLZTVe+DVA==
X-Received: by 2002:a17:907:7ba3:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-aa4834263aemr308562166b.18.1731687603240; 
 Fri, 15 Nov 2024 08:20:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df571a1sm192364866b.80.2024.11.15.08.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:20:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A5A515F75D;
 Fri, 15 Nov 2024 16:20:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs: explicitly permit a "commonly known identity"
 with SoB
In-Reply-To: <20241021190939.1482466-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 21 Oct 2024 20:09:39
 +0100")
References: <20241021190939.1482466-1-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 15 Nov 2024 16:20:01 +0000
Message-ID: <87iksoqxji.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The docs for submitting a patch describe using your "Real Name" with
> the Signed-off-by line. Although somewhat ambiguous, this has often
> been interpreted to mean someone's legal name.
>
<snip>
>
> [1] Raised in many contexts at many times, but a decent overall summary
>     can be read at https://drewdevault.com/2023/10/31/On-real-names.html
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
> [3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> [4] Excluding the rare GPG key signing parties for regular maintainers

Seem reasonable to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

