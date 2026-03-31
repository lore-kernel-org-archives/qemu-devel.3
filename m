Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30661FF60FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7WSz-0002zz-BA; Tue, 31 Mar 2026 06:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WSw-0002zC-PJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:36:59 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7WSt-0005wt-UK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 06:36:58 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-650221149e2so3091578d50.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 03:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774953414; cv=none;
 d=google.com; s=arc-20240605;
 b=cAcXIeWQkKElg+YoshAXeXXVL4qKoi5DwULG9+hNzpwf5WDEaev4Ss07btIQ+UBkZ9
 eVvCifD+fXx54iu9AtaumA4iSqlclMiPMytFMqhtKszQNhyqjxMv4lLy9CCeX0uC/jeY
 OoxZGVcHQwGvUKn2EZ2jZhhWitizYsu8jeu/Wq0lC+jEaq3Ke+Wo1IGo3wu+nbyo82PL
 /lNsB/TIiiJsCeNtUHRmKCy1pxc4wmCtJNkQahjpMXZGSjI4bkR2tbqi+LEnWtZpHCcP
 XU/ZdgGn8TPAQm6BQg0VZiP16BA6HPmHr7EPjc6vC0Ikmu1mMO/PuG2CnAMSO+rSgWht
 BgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yru7KmdrOQ13HJ3Y5DYNlYlKEYc79tfskCkI1743rwg=;
 fh=vuagoQAEf32ezVAIxmfYZt5TUgrieby/HKjOkkFWnkQ=;
 b=RQry+c4KH8CBPYUAe2XMdlhruabAA9cdSbmIogW/HlWZ/ewb08cclntmTkADopylS2
 uDdeqrRahtcVkDm1KCVXXauuPR4T3vE/8oPsoNu3e0Adun9/X3cPtgSezrY5T7Iri/PI
 pmp4/6KDVsapO1189V0zyxWNnDNc0wYLgXnbR9FIT5BwXb1Z9J3ulCHO58w08MrkHFGJ
 9ZWsNO+t4y5hCFbV3S84RS6Adf/y+z7vuPBAXKYtE1XKdlb2YS/1mRpfjdsvWsUuZKj2
 xEDsUIex1F70EWEvc5UIs7zZQaIIkNUINa4z96tsHd/Aa6CI2U0KuKQaRzjz2+rEUCBF
 mZeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774953414; x=1775558214; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yru7KmdrOQ13HJ3Y5DYNlYlKEYc79tfskCkI1743rwg=;
 b=F0YMZrbxSfnP+JkxsgtWLRK4s7OqXE7c1PK9zaH9yXksMJd7MbiWBzF1HH/Sm9SjKr
 m3B0pgmE36az3SxanrJTu34fsxjFUTLAV7a1I5WTD5nAIOMhl5Q/i1m67FGSzo++t/Gl
 dIK8b9V362A1jOqxJUuTJDe6K3ZWTt3fRhG8wJUPQ5ZItt7nximNfL7Z1aui89+qzj0N
 b601Yi5W6xtOwpVb408xzVGyH2xl8YIHuUo2EuD+HR11IVbzWx2Mhm6UtRLbAT/Lewea
 7qJfqyK/esBv3LQVU7SooiN+1d6e3+GuD23pvU8oZ3EHDNMpSecsjxL3ghh687n0nnkW
 mpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774953414; x=1775558214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yru7KmdrOQ13HJ3Y5DYNlYlKEYc79tfskCkI1743rwg=;
 b=AYkjwn4PzOXeuSOYeTNRMCCwsKLIYyHthjHnXEPdtWPutbRMTufd1wkaAzZ1Mm3R4c
 KkYNmwPPfJ/oKnCJZ5JysAyZeEkwZQs4igIEKWrCw/tL8XoCvvsX8Dfzfqs+LRFLFJG5
 eVlkDm2dTfyPfXt9l0uKniBmtzY75aurUTxzyWjXuYLxKQg6MmvhxSLPVKXxMP4eC5ck
 aiu//AVw8HprLcBabs3NUVh5wVL93bYqkmlf/a5Bt56ul4dVrFkPgdJduy96BLAeYXvq
 Zqdku7OMCbGnT69l6rpNzzhuU+dQHSib0Ejo99vW0U6Rm8DD3g9IjN1slf9bP+bh12kP
 0EOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+F1JSRmiKk+zylVPH/DwgTFn4DI31BXMHyaDiibsfWy3zPftnfQdWYO6vqrxWr1iKj0ipA3mnHIIJ@nongnu.org
X-Gm-Message-State: AOJu0YwwzlaUZmFccujw2bB30eaNjdl499/fsj3Bk9caed6hbAVw2Y/L
 jIijfbD2X+Uup1g/DzSSbGWtJxHIXhtG3uiLO/ezxGK1Tzw9WoJnrGlYYrslCpLasCR8mNbmfhM
 EPGXSkvbzaRJpSd9hpJnVm/O7hySGTvBj+1UoS8Ci0Q==
X-Gm-Gg: ATEYQzzMMImfXD+HM+mSYuMFSnbiYuy/jf4u5sFTUUK4iW4yC4AJMuc0rcbtBfMc6d1
 zA9atqN/JbLUfQQba188Xzp7fk0h7l1gFuvzquWbe5AEOXADgi6HxleM2EtQ8S0EuroPtbTAx+9
 x5mRnYjAiTaCsv1T10LdmtDUX/rhh82s0PEgETjcssAWfvFjjQuvNp2hvnqGnlC2ck/nHhGdG3Y
 c09nMjGy07vkWW1t/+Wx5plAgaK2OMzAHGSTUIx1Ji2cOPWoBnIJssbiABb5m/0Kz8kSQ7ptBUe
 FKXKJCgdVUKT2gCndKtiQ0IE9/5iNMa2ccXCpUfX7CSP3zyDKxbkOTcv9DheNVFGSXE=
X-Received: by 2002:a05:690e:169e:b0:64e:e896:a86 with SMTP id
 956f58d0204a3-64ff723edbfmr15161764d50.36.1774953414493; Tue, 31 Mar 2026
 03:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-4-tangtao1634@phytium.com.cn>
In-Reply-To: <20260331040659.401397-4-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 11:36:41 +0100
X-Gm-Features: AQROBzCzeP_9qd9pSjRuHsYGlRcY9oF-urqiLkE3HJVJjcFgugZNpJse8bfUBMg
Message-ID: <CAFEAcA_h+eK3TZSipQCKEFEEqZA1dFPFxYT-V2MK5h57wPDQwA@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests/qtest: Add qtest-attrs-test for memory access
 attrs
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>
> Add qtest-attrs-test to exercise qtest memory access commands with attrs
> on both aarch64 and x86.
>
> The test covers:
> - Arm virt,secure=on: scalar and bulk accesses across non-secure,
>   secure, and root spaces, plus negative coverage for realm and for
>   non-secure accesses into secure-only RAM
> - x86 q35: normal accesses
> - libqtest-single *_attrs shortcut wrappers
>
> For negative cases, use qtest_raw_cmd() to check that accesses which
> miss the intended AddressSpace fail with ERR responses emitted via
> qtest_send_memtx_error().
>
> On Arm, the test targets the virt machine's secure-only RAM window so
> that the requested attrs must select the correct address space.
>
> Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
> builds.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>


> +static void G_GNUC_PRINTF(3, 4) assert_qtest_response(QTestState *qts,
> +                                                      const char *expected,
> +                                                      const char *fmt, ...)
> +{
> +    va_list ap;
> +    g_autofree gchar *cmd = NULL;
> +    g_autofree gchar *line = NULL;
> +    g_auto(GStrv) response = NULL;
> +
> +    va_start(ap, fmt);
> +    cmd = g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    response = qtest_raw_cmd(qts, "%s", cmd);
> +    line = g_strjoinv(" ", response);
> +    g_assert_cmpstr(line, ==, expected);
> +}
> +
> +static void G_GNUC_PRINTF(2, 3) assert_qtest_error_prefix(QTestState *qts,
> +                                                          const char *fmt, ...)
> +{
> +    va_list ap;
> +    g_autofree gchar *cmd = NULL;
> +    g_auto(GStrv) response = NULL;
> +
> +    va_start(ap, fmt);
> +    cmd = g_strdup_vprintf(fmt, ap);
> +    va_end(ap);
> +
> +    response = qtest_raw_cmd(qts, "%s", cmd);
> +    g_assert_cmpstr(response[0], ==, "ERR");
> +}

These seem more generally useful and not specific to this test.
If this is the API we want for "send a qtest command we expect
might fail and check what it told us the error was", then we
should define these in libqtest.

More generally, if a test case is having to use qtest_raw_cmd()
to directly send a qtest command and parse the response for
something, that suggests that we don't have the API for
the "non-raw" qtest functions right.

-- PMM

