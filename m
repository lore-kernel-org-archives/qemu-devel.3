Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A19FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGS-00045A-Cf; Thu, 30 Apr 2026 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRLB-00028T-1D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:22:05 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRL9-0007pa-Eg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:22:04 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so564797d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555322; cv=none;
 d=google.com; s=arc-20240605;
 b=V/slw+SiKr1KW+Gk7b9nA0xwdGha6cmD/3zGgXXCVjcRLzx/+H4PzbdvGLg6Dawagy
 Q46qtkWbQ7fu3Ia5D8IhglJ5Jg0nAmCnqUMRTPNpRQGeF/XyOjwNtSSaVVgfCeczcn3M
 isKjLtya42nlpMQHZgAtB9nUU57DxG5XRsgQS9ul/EqC5nePilUIE781M0rH0kGnpl6B
 6UCGMUD51k8lVTSv9sBDLGdkywv28g9jwwo444KVS1EOtwpfyF7M3whSp9GKM0q9P5Ga
 YZqov2qdn5CxoHkyTaf6gmXkCVSB88hxKJhiiLk6jQqyu7nrNZoSQ6itTR7BevXd0t7O
 lvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Con/S2xvj2vkGXHzb7AtuLVeslL/DNtpsbMPk7m16TY=;
 fh=fw7MzBdzdQuxuCIiZCxkmpkzledHmjVp0wjlwFO4u1g=;
 b=QNMYlF+RsMuqmMRLkbs1qIlp+ZscxvEiV60dWqtFOLfZD0A0ZUWLwcApimyUfJAJlt
 aD3jEbiNPHGQ58SMZ+QEUQk0jSbWP6Q66J6IPeFUfqAHB2rpa6mgHv7xkZoX58uKhBGD
 eLycKX6AleN1h1bgAjY03O8iMOAaO3jzs4PQthNWlnfqogqaSyQ1IULXWLoCf890tZZ9
 M1sk9cwPK0u/OZ/RS/njG01AL9svhIzeyjzuvDpp8Zw6llKyJaQepB0adRSe24BRLtfI
 RKgUxrt85kbGstz39dSy8uMQzfJNGi8K/sk/JWov2OelJUxfg+iuBOmZN1JyjqV1MJWb
 +kFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777555322; x=1778160122; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Con/S2xvj2vkGXHzb7AtuLVeslL/DNtpsbMPk7m16TY=;
 b=vGSf4xtkr6Om8upNevpXulSvvpIXGzgDs3KMAFy8McFV7iy8VBvJ4zYtemkh+36nW0
 jkkVbdFPTGXe5chhP92e8CsY0vsFffZOYHqEDeZ3woR1wVnJJ1l7pgISd4gbylbC1HD+
 OITb7z/COU9NX53JNpoqiyXuztyuiDwnD36lsDhvalpzxVXSB9FK9QK3R9Zs2molId1Y
 liKbyOiWasjx2StrnXTUKijUGooxhJw8oryslnYs/mHUmW1P8YiOO5coWL5Uxw46kpZJ
 vWpo2QYk2hHvQTx5RFusQ9AXccmfDT3hlLCHD8hBWwL+KStD1Vh+olroaedYZF4Mib8o
 avww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555322; x=1778160122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Con/S2xvj2vkGXHzb7AtuLVeslL/DNtpsbMPk7m16TY=;
 b=GNlH3wxhXWaS6Ng8C3ehLr2aoTf/4MeccAq0bcZJGxYVNBdq+zpcMRLFloL6GsXNTI
 8gz9ck9ve9ehvdEtHplYEHxz2GAbCN/0EENa0NsDkImnacnn3WZQdVwt7eHMsleIPvSo
 uLuM5uHgm4UFdWxjQnuzL2NXkB4vvE9XRY1KEThkWHDQhx1Ookx5hmLSf4/N/MeD6kWx
 aH26XLqRFzw5vUVJm6F8tNDtoWPpG8uOpW/8KcsK2hBY+a/hWcthCRPFfdiHaFzeWb5Y
 Zmz3h9pfR1twHDGUDfkuYcnY/gOFalB8Xh4Ji/C+6MeMDAV4IarJlOoaWEURHCo4Cuti
 HvzA==
X-Gm-Message-State: AOJu0Yyg59W78/V+kcogJWVkXaGjrCPEtBvYF0QyFl1GmWV+d7/u73CX
 GEdbRbyL7rBO6pv6NuWPzJPf55jqVQQ9Ytlx11SWNm68qmcyAhV5OmodWxEg8XsHEbwDmo9rSrG
 aJZF2DLdrxhu4XVCU4lSoL4N49bLNiAMLGvBIuMbBPA==
X-Gm-Gg: AeBDietWvmSrUhxewRuLnhFhOpNqtpiTwgDWDSX22vApsWihOM8D2N8f+XpHLpOlVPv
 kZegdRBHHcTuOoda5uoDUMDDWXlyCVrEwQn1MyXafWJFUwo85affjstTOUC8H9FKkfEGKBh2Cm+
 R4y1YLXOIHmgH2x8F1xcJzUe+FVk63x8NDf2hI4b0OqICC6JGq0QRq0I06LOKtRpiiUC8k41VxJ
 tSqEa3+G/Mw5jwMfSSA0pIrlBfaBFvnm6TdPQoS0dsMrnP24LEOKyekbq19xfkTOU/91OWOQ/rc
 lwRRgaRd8GRo0P3l2F3G99gLoQwad+DkbxyvrrjiKqNY/TX+j0ZQNjRZjAuUDO0FqDIjVpXDQtb
 BOA==
X-Received: by 2002:a53:d8c6:0:b0:651:c321:9d0 with SMTP id
 956f58d0204a3-65c18de37abmr1910095d50.32.1777555322125; Thu, 30 Apr 2026
 06:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-4-farosas@suse.de>
In-Reply-To: <20260429003130.15164-4-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:21:50 +0100
X-Gm-Features: AVHnY4IZ6eTAeH5XlXkkCvW1ovq_W4lnBm14l26zCerrTKp3EOnlOzINkTOeWrg
Message-ID: <CAFEAcA_bpXeKpjKU30=DFRCuoi4ubqhNxq9RO8mfUwmwwChGVQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] docs/devel/qtest: Mention environment variables
 usage
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 29 Apr 2026 at 01:31, Fabiano Rosas <farosas@suse.de> wrote:
>
> Document the QTEST_ environment variables. Only include the ones used
> by QTest itself, don't document test-specific variables as they are
> more prone to change.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  docs/devel/testing/qtest.rst | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
> index 73ef7702b7..0aac0f0aaf 100644
> --- a/docs/devel/testing/qtest.rst
> +++ b/docs/devel/testing/qtest.rst
> @@ -91,3 +91,36 @@ libqtest API reference
>  ----------------------
>
>  .. kernel-doc:: tests/qtest/libqtest.h
> +
> +
> +QTest valid environment variables
> +---------------------------------
> +
> +A few environment variables are used to point QTest at artifacts to be
> +used in the tests, mostly QEMU binaries or to control the behavior of
> +the tests. Environment variables are set automatically by the build
> +system, but it can be useful to alter them when running tests
> +manually. The following are the environment variables recognized by
> +QTest, not including test-specific ones:
> +
> +QTEST_QEMU_BINARY - The QEMU binary itself
> +
> +QTEST_QEMU_ARGS - Extra arguments for the QEMU command line
> +
> +QTEST_QEMU_IMG - The qemu-img binary
> +
> +QTEST_QEMU_STORAGE_DAEMON_BINARY - The qemu-storage-daemon binary
> +
> +QTEST_STOP - Instruct QTest to stop the QEMU process with SIGSTOP before continuing execution.
> +
> +QTEST_LOG - Comma-separated list of log domains to allow verbose logging. Basic log domains include:
> +
> +           qmp - controls verbose output of QMP command invocations.
> +
> +           qtest - controls verbose ouput of qtest operations.

"output"

> +
> +           test - controls verbose output of tests.
> +
> +           A dash '-' used in front of a log domain has the effect of
> +           enabling verbose logging for all other domains while
> +           keeping it disabled for the specified domain.

We could write this using rST definition-lists, which I think
makes the generated HTML look a little nicer. Here's a version
which is basically the same text but with a little more rST
markup sprinkled over it:

===begin===
+
+
+QTest valid environment variables
+---------------------------------
+
+A few environment variables are used to point QTest at artifacts to be
+used in the tests, mostly QEMU binaries or to control the behavior of
+the tests. Environment variables are set automatically by the build
+system, but it can be useful to alter them when running tests
+manually. The following are the environment variables recognized by
+QTest, not including test-specific ones:
+
+``QTEST_QEMU_BINARY``
+    The QEMU binary itself (generally a ``qemu-system-<arch>`` binary).
+
+``QTEST_QEMU_ARGS``
+    Extra arguments for the QEMU command line.
+
+``QTEST_QEMU_IMG``
+    The ``qemu-img`` binary.
+
+``QTEST_QEMU_STORAGE_DAEMON_BINARY``
+    The ``qemu-storage-daemon`` binary.
+
+``QTEST_STOP``
+    Instruct QTest to stop the QEMU process with SIGSTOP before continuing
+    execution.
+
+``QTEST_LOG``
+    Comma-separated list of log domains to allow verbose logging.
+    The currently-defined log domains are:
+
+    ``qmp``
+        controls verbose output of QMP command invocations.
+
+    ``qtest``
+        controls verbose output of QTest operations.
+
+    ``test``
+        controls verbose output of tests.
+
+    A dash ``-`` used in front of a log domain name has the effect
+    of enabling verbose logging for all other domains while
+    keeping it disabled for the specified domain.
===endit===

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

