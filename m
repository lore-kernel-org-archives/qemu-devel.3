Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B52BFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00H5-00036J-Oa; Tue, 10 Mar 2026 12:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00H1-00035x-71
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:49:35 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00Gz-0001JJ-D2
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:49:34 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9704cd6951so212534266b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773161371; cv=none;
 d=google.com; s=arc-20240605;
 b=GQXD6f3PwOXVVmkNrbTdxnxG5Suv8IlS6TWQ5aUXqMwQp+iLq1NtggNlbapJND7dSC
 7lxT3k49/oB7wJ7d44Wn7P98SUeXxukMKcKW3Kd3eOzyKQ3VcWr5HZSKX1eDS5UK9UtW
 YcTrLWwaYM19yd/ESADGKPCBdiODakkl5pXywh/eBSyxfPFWO5QOI9DeulavYcoT0lb0
 7wkCulHtRfPfqYgx4vnfHw5q5bbXsza0aO6x7zebTBFc3f7SJlWWL+F8I7hHxfm/ADyU
 UbbzdNldNTeWNQyPrAWCLPvTLwyAHIHXPWDFvoUcQiueu8eV+Mi/oVV7TVUlfPhNhw56
 Cv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AlnjlecALTJd7vBc5aBxXqL+r8ZoPyjuvgpoB4UbyoY=;
 fh=L0TlHOEEnsG8fZKcAojSy8uMGFRKUmRdvFPDkVDeddQ=;
 b=cUfEuIigeH6lEfJZV67opo381bUc6rNdR1CwYJ5/NA02vGf9vGmb7q8F6MoyGqNTpa
 NsrIaOSGw+oadAfIFRWbmTaiCovP3VZL9+w+cfomlbKt9WBCU9BmZwLh+J3CvPs4QJXR
 etbgGzcZs0tGFbY6HjALw7Pjin5vBRP8SIQwaf+ca20nxhIpLP26kxkG1YsCJGHNIxol
 quQ78uYYkH8rXPtTf/eaIurpcKENrmzJqqCQfMaN+W4EaAyMjuloBtnWPwhbagp/4xmn
 Ab6zavdNl5gEzCOdUhAnQ2Vvb/iqPMQnYs84p/sf/ZEDf8Z06ET5dmgnnAK7+UMU7mIw
 8PwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773161371; x=1773766171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AlnjlecALTJd7vBc5aBxXqL+r8ZoPyjuvgpoB4UbyoY=;
 b=UZhEFnMBuwUy0+exXoTPXiTnoanQFgVlI5G1zf/FT2SZCwcoxRr+MOhcnvByl27wPs
 iDSP4fU3Ua09zJX13nixH6JlHIJN1PxLw1ue3DZva+3Lz4P3bMtq9SFT9CNkAR8tBfeW
 +3d01rd8zU7WN0AIHNOBtlf0ydbuZfB3fuz+4Q/dKmfpOLTUcRMG3GIAgcVRjyvZweml
 lNVe8j2nf6ztH67ghQnjFx7eMlnauPk9OOaqmH9+2Y/xAyJrNKQY+WtAmLeVXxUm9ZDy
 3c/us6dNLJxTp7pIOi+Ks8h9GFv+S5s6M03xVuuG1+I5wmmUcNYkA0xTkCXo676I3lzs
 C/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773161371; x=1773766171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlnjlecALTJd7vBc5aBxXqL+r8ZoPyjuvgpoB4UbyoY=;
 b=jIXFfGFWz/uQpzHYkLgP3joMGhWlq3LI92lPMXyIRcp6hyHTdPaVYNl3EUokLwPZn/
 vFC+jx9auHVW7KsAjFyaLTHvqifqaEd3Rry0S6goJSJfM2ZprWSX4T0m4aEtD1Sj1qz8
 He4KPifC+4Yy61aSCJz1NOF0bvwPJIb4z1VWYsPbe7cfqeKnG2RAP7DeEEubOtEDQmz7
 qTlV2ps3pvUeGoD+Q37wPFDOgXzZfhIn2usXTCHwLeDXx16qTHqh61zT9n6zBpwcWynK
 fIohGg/Nfxv9IeQ62Dp0w/7+OW9EyPsmTLKeOQEf1dotjrGFCekv+qjlBEt7IJh188DM
 7etQ==
X-Gm-Message-State: AOJu0YzQJZpFyUQtO5RRwd57PxZvra2rfcGR7DVN8d5Sy1yv6KGuRx36
 p0cV0yjLPSW5YJ5x+RjXUhUqyO80tAizVbYAY84dDIWqdXJu9njLf8Z9pD3zzpOK54QBKoKgSls
 IHsaIgs1QSEoL4YZUlWOjGeh1Y6xf7RSnLMVdVdy1pSjKkc1KrCDDt30=
X-Gm-Gg: ATEYQzwKcWMXHaIviOMptA3q0ONGxh8/MISXIBgLf2MC6Q+OnUlFrbC1Y6StqQ99XTg
 2INhRFuUrFN4ENRXWG8B78pNzkudvijRnVs9jJZ764enSL5T5ptm7p+4+CupNd9gepi6lRxOQjX
 UlWwZWjd0mwgtZ5b4MTLJmhCiBhSOQKd876k3b4ZYp/IqMKMf1xBa3R/P1xp7Zs9en64oj5qBXv
 ftjJLGfpf5UZL0wcBebL1SSefP38lMAZVU20pZdGt6HP3YTXHwxqCTCi6mYAdpnFyJP+Csgp/PP
 PToUlTvgL5RQvrP4BP5jfOjxp0VnB6SMeLC+yqOHJE/JP5sKdZtjJJi3bEiqCcDOyqU=
X-Received: by 2002:a17:906:6a0d:b0:b93:9407:ea62 with SMTP id
 a640c23a62f3a-b942e1584c4mr903383966b.54.1773161371201; Tue, 10 Mar 2026
 09:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260302084338.473368-1-pbonzini@redhat.com>
 <20260302084749.474955-7-pbonzini@redhat.com>
In-Reply-To: <20260302084749.474955-7-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 16:49:16 +0000
X-Gm-Features: AaiRm51XRctMJ-OS1UTh7VAoj0lBCMBjkSCvuj5xj_QkJAx7w2AHkDtUzrt1504
Message-ID: <CAFEAcA8YWkoG67A7pVqauPTj+jUxBT5jv2=ZJrqZyvwrDK6GfA@mail.gmail.com>
Subject: Re: [PULL 073/102] hw/machine: introduce machine specific option
 'x-change-vmfd-on-reset'
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Mon, 2 Mar 2026 at 08:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Ani Sinha <anisinha@redhat.com>
>
> A new machine specific option 'x-change-vmfd-on-reset' is introduced for
> debugging and testing only (hence the 'x-' prefix). This option when enabled
> will force KVM VM file descriptor to be changed upon guest reset like
> in the case of confidential guests. This can be used to exercise the code
> changes that are specific for confidential guests on non-confidential
> guests as well (except changes that require hardware support for
> confidential guests).
> A new functional test has been added in the next patch that uses this new
> parameter to test the VM file descriptor changes.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Link: https://lore.kernel.org/r/20260225035000.385950-33-anisinha@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity points out an issue in this commit (CID 1644565):

> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -526,9 +526,9 @@ void qemu_system_reset(ShutdownCause reason)
>          type = RESET_TYPE_COLD;
>      }
>
> -    if (!cpus_are_resettable() &&
> -        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
> -         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
> +    if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
> +         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
> +        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {

This change adds a dereference of current_machine, but earlier
in the file we have

    mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;

which assumes that current_machine can be NULL.

Presumably here we should be handling the current_machine == NULL
possibility?

>          if (ac->rebuild_guest) {
>              ret = ac->rebuild_guest(current_machine);
>              if (ret < 0) {
> --
> 2.53.0

thanks
-- PMM

