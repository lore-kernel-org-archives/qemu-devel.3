Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CDCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwgXp-0003pP-RO; Thu, 11 Sep 2025 08:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwgXh-0003my-4V
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:36:49 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwgXW-0003KT-Cp
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:36:48 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d605c6501so4478967b3.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757594192; x=1758198992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj35KbzD5dcIylU7LLa/BJrzN/sHGuI44yROHJ2mTvY=;
 b=sQ6lMTKdL19E9v87BZG1gQGOFkHjOF61CrLvQ5jxgIuIdnAdvk5N5sMeb836jSWNF0
 BuKpiFmY2xHwqFdUGpLNVTFdt+I7cwJOZsEJ1DspDvdMzigjH9K8NHma6KHxj8qMNNsn
 VxZ82gs3xR6J/ZZMKGmelUWTSp5c8iU2j1qQNoX3k4v77Vt+HsOyCk+PvRTCZGq6/11y
 gUf4M5AeIVt2/UbcO9NOH7q9sdHGc8iyEs0kGicFQgW5Em20S2a4BOQvIkz9W7ChwKNN
 eJE98/EL0YWakMb8OSHMfpXiV2hPIv1U+IMZjg/AhltlFqW9uoxgfxXouNHR7uvuGwNw
 k6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757594192; x=1758198992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oj35KbzD5dcIylU7LLa/BJrzN/sHGuI44yROHJ2mTvY=;
 b=e2vEgd11iV5QUs1mqc3Q0LjnNQyipmTp8vG4fLgNsUvPd7y5BJptuaqGTF4Aj0b+uI
 jmT0q7Zdh6BcKmX2XxWn8GB4tQg5Ii3cpMcJXrdlda3ldqXf9w36zcbS3iViUf5DRYik
 rugkOj3VTUytPhr6BY09dmWrtmasnYmrOAjOrjLSXFbHeG5WSmvikOGtIQjhxISWiPS5
 QQ/QXPpZpDmSk55GAoCiss86EQCK7p5GfaTIhrbipn1ym0qso8QfQSRSSBjFIxCIQMsz
 tMctDJ/oXb1TkYaMI4ZslZ/8MpnZUAtvyeeoQjvXL0iNQKBE41skd+z6FN0P9Of1MrM1
 IXsw==
X-Gm-Message-State: AOJu0YxSvtsmUvwnrCod6bZanYmkzX2erRkF5nJwxOX20sQCVwmAL48N
 DN46aLqZBCs32V3LM9he1tgs+v4bqkOPOka4tPPRg5R+Kes9VMGSdmkCTrpzXnVlrJ1K2XLjqei
 IUgOnqvTbUP3Z+30Wp/FCLvNz2uggElzAS4d388NjmA==
X-Gm-Gg: ASbGncuUSGLfKjQVcDeOQq61oODmJuWG3G5AJjasPxDKTeVdweaKyAFc+VPYYylDWGy
 d7r8VEFpERSn3rz/7m0kiuKwkpLfxHe5FM0tkcFDX+ksK4fqT6CRJmpy4xPtYdr6Tfj/SmqzxQm
 N+wokHKl7SWpMNcglcSsOmSog324N8Yol6n5n/qC+/N1VK76lO5t5UCuHVliRTF2BRPnOeMr5So
 7qcHKbQQ77NhWe5JFw=
X-Google-Smtp-Source: AGHT+IFXPGc+NODvmUp7swucbfGlu7ZHhCWJdjrcTHXl6qlXBkBMvhNP2mxBU4AoJ+zdVOmzcuamdiqNjkb5p7yJrXw=
X-Received: by 2002:a05:690c:4c13:b0:71a:3849:f88e with SMTP id
 00721157ae682-727f30afeecmr171155597b3.17.1757594192064; Thu, 11 Sep 2025
 05:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <87bjnhgpg8.fsf@pond.sub.org>
In-Reply-To: <87bjnhgpg8.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 13:36:20 +0100
X-Gm-Features: Ac12FXwIP_k3WcsdAILMxTY5cXwIBYk3XFQldbn_9ZXBEOtgwJRNAYgqCrVNSxE
Message-ID: <CAFEAcA-1zbzURECvUDmx=j0KO5UBmHnwznbKG+JP8CRF9qTuaw@mail.gmail.com>
Subject: Re: The different ways QEMU logs stuff
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 11 Sept 2025 at 13:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> - Control: off by default, enabled with -trace per trace point (and
>    also -d trace: --- I find that duplication bizarre)

If you're a primarily-logging user it makes perfect sense:
I want to be able to control everything I log in one
place ("-d in_asm,exec,trace:gicv3*").

> * In my view, util/log.c consists of three layers.  Form bottom to top:
>
>   * Logging messages: qemu_log()
>
>   * Control of what to log ("log items"): qemu_log_mask()
>
>   * Address filtering: qemu_log_in_addr_range()
>
>   The bottom layer is also used by trace backend "log".
>
> * Tracing vs. "log items"
>
>   Tracing and "log items" both provide opt-in logging.
>
>   Why do we have two?  Feels like an accident to me.

Partly this is because tracing is newer but it doesn't do the things
the 'log' facility does. In particular, with logging you enable
the category of things you want to see (e.g. "tell me about
anything where the guest does something we didn't implement")
whereas trace events have no such categorization.

Log messages don't have the weird restrictions that trace
events have that some of the backends impose (e.g. "no
floating point values").

Logging is easier to read and write because the format string is
right there in the source file, rather than having to be
separated out into the trace-events file.

-d also always works and does the same thing regardless
of what tracing backend QEMU was configured with.

>   When to use which?  I guess people pick whatever they're familiar
>   with.

I use logging for "I want to get logs of what TCG is doing",
and for the "show me everything in this category" logging.
I use trace events for "I want to see what this device emulation
is doing".

>   Would we be better off with just one?  I wish...
>
>   Which one?  Clearly tracing, because tracing backends provide plenty
>   of useful functionality "log items" lack.

But the reverse is also true, which is why we still have both.

-- PMM

