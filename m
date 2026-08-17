Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68597C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzlE-00076i-L7; Mon, 17 Aug 2026 12:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzl3-00074e-BR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:00:23 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvzl1-00065T-5v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:00:16 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-836c4474028so34925827b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786982413; cv=none;
 d=google.com; s=arc-20260327;
 b=aQ2/WsILpYUVqFiHNR170ZXisCp1mvu+qWRSSW37xZlw3uTk11OfroTbLyral9pUNT
 54mUsrb4q7umN2hrYXat11c+gOroTj5E/eABZKinH5JvqWUNt8q5DFZDM0C1JySTMQBC
 NmFThk+vMraUrn9rVTFSQcxPYesJxS8L8/hB0bfGQPX5bWxI3mQWRJMSOSKEBP+AyWV+
 2RumVCPdkV6ahwjk/FIDelSv8W+MfBiLZmsCAoibN/cAX7MW91p98U6zqzpD5Beom+kp
 9MO6/Z0FllPunnFGg4XEKB3YQi1yTiPASbJrPnasvDloPMJ7yibihNDkw2ZR5TOB+7Te
 +1yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
 fh=VKhT/ROQfPaxqvsqCO+NJenwE/mNmOPRDLNy9Z8TYvw=;
 b=VKimqEJohjvIZr6LNvsUSH5RSYudkh4ryOoH95d+eh55XXQFv3aIjK6A6E2+iT4Sax
 CdLQOqaS0igcuNQy4DcWKXutAc5PVyYAqWaPZtQYqk/pJROvNaAgM059rmCK/XBHcOkc
 P83kl0MMfA96chuGFkrnhRp8kSHe4nLhlD1srq1eovt1VUSpKMFSd1YxIDX0JUp3NW54
 +aKAJ9oREMNkL6q/2hD9XP/k+rlLX/IXOS5/6TOl6AOH6k/5tNaIssrxycgy7SE5I6DU
 J8VeZoCkc1rDoyVfnnpHhtlvbIuebB8rq6wrfx8lDrHqXnoTRMohpoT5SjyZPlN+35EO
 OvhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786982413; x=1787587213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
 b=TcOVyzQx/A4fKoxi2qiQmKdqpiqqJ0jt5yoivbPIis5mhs3vBRGJAF9nQjJVQ+LlXH
 N0/MmiCeRQT/uC66ghiJGCpFNKBQukXlI5uq/nRZGf2rIdbAvTU5gb5TMAGGUHmGnr4Q
 InFyePsAMsEktTAuaL40BQYWXGDt5n8H4JdoF1ntwPkDP8hDVWHzeoHBqrzTTLM42VDM
 DlEeoUrdYS0T70Befcioyj9vuYV7J9NS4cudlcZh9E1XrUtJCC/GHSIkg4+rD9eXXtEf
 gqX3pMv6Wizaj19/9q5su5Qjite/GaH1mWWD5rtP3NqGlsCSg1Ct09ugScfqSesu1coa
 u4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786982413; x=1787587213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0v20WHATN4inOkpw4dTSEM5J6s+dmnOJCNOR4bt+A0=;
 b=dabB3K88AixqTQiiSNP+edf3psf+eDiLHQFZ5r8QChF+PsLpNHvm59y6d90kmBnp5e
 guwkMf/3HzLl5ZWmDgXHfmnqYwCpaalcqP3RS+I6toLqOVM4EuO0xvSF26C5DS+WrCXf
 kyRpPrNHl0ES4l/BV8dowA/MRVdhj9ZBu8dqT94191F9yXA9HNv8xMb2GDaWm0PpeABB
 SJxeaPqImEBn8Jz6zT6Cu8ngI/TdUstetLYt70kYAtSCbYDdxvIqmpFh7wH+tDXrscNi
 BWmNl4ELfw2CCo+IBkA7Pw7fcRQlHcRxcNnPwT4qYXNtLjIVdXmRg8ZqdBXfzx0rX5RC
 FSRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAyWC4I43v8EQWHLmG/Sc26RxgBjfuB6pxNazvJNO/SfgkQgEalrRd8K+5zhj7p3YtuQybWG/XNZJB@nongnu.org
X-Gm-Message-State: AOJu0YyCQ8gu0CpcSAR/Q1wmtp4ecp9wLKK9Dhawkrsj2V2h2dK2JXX+
 f3LTxcgQ+o80Wvro+Ysv/WChTYBJH/7he0MJw7qDINxhcaHCGJ8Y+FdGxfkw4J1dKeNVIbL7XHx
 W/8WUlaIzngxMm+wCLsiX/QHn4cyLJxq7LeEjscdkpw==
X-Gm-Gg: AR+sD12nIdUHR0327v/Fe9wHQJ3yx9+IpPinhtnaLYJn1LzmfzS2qQhGDa/ZKY9aMXN
 ClWeNndEsW8xVcq6RCxVjFDNXwVC5vnICe+UIRC64stn3SCQE0HymM/0aVcu2pJdMU+ppKmcxEo
 9jAU5VXT6nzoBBFnbrhEtWxqkbA8V3GYywewFRjCGswCDo3ehGQcL/vnGVnPsYYARRAgaNyWfdu
 F0IYYyDjrMLrtsvh9CraAHcne7BY8hWUhCYr/I4OWSaqma63xoo8blsmTwQ5Pk7tDMdgAuedz43
 WyNgJYTIAKFaFfQnN7jymLYEcHdeRRFIA0oOksQWX0YgRMd+tYiRqZGdhFlrM2hARl2hFRGgpAV
 AqsPsUuln0VmODE7ahkRR4CHryNAd
X-Received: by 2002:a05:690c:a4c8:b0:81d:a1e5:a4d7 with SMTP id
 00721157ae682-8370c93d31amr76988627b3.5.1786982413325; Mon, 17 Aug 2026
 09:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-9-philmd@oss.qualcomm.com>
 <0143f26e-eb64-4924-8e76-3b6ce66fe6db@redhat.com>
In-Reply-To: <0143f26e-eb64-4924-8e76-3b6ce66fe6db@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:00:01 +0100
X-Gm-Features: AcwNN1WKg9kcvA4JNKRjNxIc1m-gB0o4nyQG1KVRXlHPNyw8dOI79_GwpnDCC_k
Message-ID: <CAFEAcA9CzSeOKHiPdwUcowYhiSs2tcT0OR_j6mnyvykgMoaZLw@mail.gmail.com>
Subject: Re: [PATCH 08/16] cpus: Slightly improve *run_on_cpu() docstrings
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf <agraf@csgraf.de>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, kvm@vger.kernel.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 17 Aug 2026 at 16:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 8/13/26 20:16, Philippe Mathieu-Daud=C3=A9 wrote:
> > Be a bit more precise mentioning BQL use and blocking calls.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >   include/hw/core/cpu.h | 36 ++++++++++++++++++++----------------
> >   1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 183ef9f4ef2..d610f87abd3 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -908,36 +908,40 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func=
 func, run_on_cpu_data data,
> >                      QemuMutex *mutex);
> >
> >   /**
> > - * run_on_cpu:
> > + * run_on_cpu - Execute a function on a vCPU and wait for completion
> >    * @cpu: The vCPU to run on.
> >    * @func: The function to be executed.
> >    * @data: Data to pass to the function.
> >    *
> > - * Schedules the function @func for execution on the vCPU @cpu.
> > + * Schedules the function @func for execution on the vCPU @cpu and
> > + * block until it completes.
> > + *
> > + * Note: The caller must hold the BQL.
> >    */
> >   void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data =
data);



> > +/**
> > + * async_safe_run_on_cpu - Queue a function to run with other vCPUs pa=
used
> > + * @cpu: The vCPU to run on.
> > + * @func: The function to be executed.
> > + * @data: Data to pass to the function.
> > + *
> > + * Schedules the function @func for execution on the vCPU @cpu asynchr=
onously.
> > + * Unlike async_run_on_cpu(), all other vCPUs are paused while @func e=
xecutes,
> > + * ensuring @cpu has exclusive access to shared state.
>
> Might as well mention that @func is run without the BQL taken and in
> fact must not take it (see comment in process_queued_cpu_work()).

We should also mention the massive bear-trap in the run_on_cpu()
function, which is that (a) you must call it with the BQL and
(b) it will *drop the BQL* during the course of execution, so the
caller must be prepared for other threads etc to be able to
reenter it, update state, etc between when it calls run_on_cpu()
and when it returns.

(cf https://gitlab.com/qemu-project/qemu/-/work_items/1109 where
we can segfault in the raspi display device, because
memory_region_snapshot_and_clear_dirty() drops the BQL and allows
the device code to be re-entered, much to its surprise.)

thanks
-- PMM

