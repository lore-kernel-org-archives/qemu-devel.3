Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA54C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuVQ-0000og-1b; Mon, 22 Apr 2024 10:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryuVP-0000oM-6S
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:18:51 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryuVN-0006qI-8I
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:18:50 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a55b10bfd30so91678766b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713795527; x=1714400327; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xWcMe1r1xfrYk7035Y+Y06ENIVgnk/UML/pGeVuWqME=;
 b=uzkXmmpTfBtKZwcnZpXzmavU9oaQ9v46n/7HK0HIIVx1iMqeOS4ka3rD72f9YpbuDp
 mfkFz2RrQxZDxnWLbz95xbct3YO7EfAi5F/Wp5FMUiBHzYTIrOBXobsxwIRN6oZnd8wP
 CS4+fW4d6qU8YWH0O+bWSjy31SQLLwNxKWL7frgEjNJQ2zCGRnRHA5+qNABPAHVB/Xmy
 FsEeWGLx+k1XZVobrSU+ZvmWcJEQxkF7Qz0C+aJgY+SZavqq18oDX6M6arLkM8O/+OVH
 IHCC0G5OH5AaRJtfJ71tRwZJ96GEEwjeRaEzPEIq9fryoUvv71GBRzUZ6i3GWOeib1G1
 xD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713795527; x=1714400327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xWcMe1r1xfrYk7035Y+Y06ENIVgnk/UML/pGeVuWqME=;
 b=fGG3JJPPlKLGeGCMskDpYNgcPdYc50KQwxLyy0Wiuz9WwG4rnbT/vUZRVpZF1ugRD2
 ILi+Km8yQI2Us8CJpLsIXD48BoA/JIPCegbJMjWwckRdGRWTln52ad1EFS8fGhh4/ANV
 Kxa5Uaf6K9adcXrUnt/urCnvHTaul7CQVL4sp/GXc/eBz2cPCV9qw8ovOFxnZU6aIOct
 tmUigdBn0EyGApq1TCV6MArntlI3uBAnCZ1o94+FOwcFdtEsFnUEswf+dFCmzvubq/+h
 NYyOJjmhIGxVBv2nt4Wy9icPUjRkzu+z6amP4glW9RjsA0BbQMv2a+AxtnjlWLxMgX+b
 X75Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUclmv6N1VRUch1E0A6KtBig6jtfprZxkWgpZTrEm6x8tuMP5e3s3Rxa5qj1VZQQuUDfAwrlv1xYtODcVwPzVkTGcFdK+E=
X-Gm-Message-State: AOJu0Yy35/Pbeg3NeSruyr65DeEqL4JDE2IFmN5HIuO7lELChyyt/JrN
 VDKmxIgfhFaN807yEN4H0kiu0TSNWGUDPOIRU1Nq70z2V3JNOlx0NyYpJvVv92FC6q6nkF6CVA4
 B+zP7e6aqMrjlyXw/JItcyDspmlsyIqChhUZMdw==
X-Google-Smtp-Source: AGHT+IG+oiZYigBpRUgLze0h2VtG7j2k5UWSCshkjqTLb9tK9oLYS+xTqPJVL/B3pCnEk06t12qNTnhAP0Ya5pDC3uA=
X-Received: by 2002:a50:cdc1:0:b0:568:d7fe:a768 with SMTP id
 h1-20020a50cdc1000000b00568d7fea768mr8176946edj.25.1713795527342; Mon, 22 Apr
 2024 07:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <CAFEAcA91ZULEjEgTotevp-epgH_azcwrSi9PVnnOSk8gq5j22g@mail.gmail.com>
 <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
In-Reply-To: <c84bfac7-5fb5-4fca-90a3-93adb40bcf3c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 15:18:35 +0100
Message-ID: <CAFEAcA_PWyu=ca-S=qwePDdGqjX95k3oQ+BJUZc541YEyV7i2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Make the counter frequency default 1GHz
 for new CPUs, machines
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Mon, 22 Apr 2024 at 14:38, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 22.04.2024 o 14:56, Peter Maydell pisze:
> > On Fri, 19 Apr 2024 at 19:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> >> The upshot is that the only CPU type that changes is 'max'; but any
> >> new type we add in future (whether v8.6 or not) will also get the new
> >> 1GHz default (assuming we spot in code review any attempts to set
> >> the ARM_FEATURE_BACKCOMPAT_CNTFRQ flag on new CPU types as a result
> >> of cut-n-paste from an older CPU initfn ;-)).
> >>
> >> It remains the case that the machine model can override the default
> >> value via the 'cntfrq' QOM property (regardless of the CPU type).
> >
> > This patchset turns out to break the sbsa-ref board: the
> > Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
> > avocado test both (a) takes rather longer to boot and (b) when
> > running thinks that time is advancing very fast.
> >
> > I suspect this may be because the firmware hard-codes the
> > generic timer clock frequency it is expecting. I've cc'd the
> > sbsa-ref maintainers: is that correct?
> >
> > If so, we can deal with it by making the sbsa-ref board set the
> > cntfrq QOM property on its CPUs to force them to the old
> > frequency. However this will produce a technically-out-of-spec
> > CPU when used with a v8.6-compliant CPU type, so probably we
> > should do something to be able to tell the firmware the clock
> > frequency (if it doesn't want to just read CNTFRQ_EL0 itself).
>
>  From what I see in EDK2 code we read CNTFREQ_EL0:
>
> GetPlatformTimerFreq() checks for PcdArmArchTimerFreqInHz variable which
> sbsa-ref has set to 0. So it calls ArmGenericTimerGetTimerFreq() ->
> ArmReadCntFrq() -> "mrs x0, cntfrq_el0"

Yeah, it looks like it's TF-A that hardcodes the frequency:
https://github.com/ARM-software/arm-trusted-firmware/blob/c8be7c08c3b3a2330d54b58651faa9438ff34f6e/plat/qemu/qemu_sbsa/include/platform_def.h#L269

I imagine that value gets written into CNTFRQ by TF-A somewhere
along the line (and then read by EDK2 later), though I haven't
quite found where. Plus I notice that the TF-A sbsa-watchdog-timer
assumes that the generic-timer frequency and the watchdog
timer frequency are the same, which is a bit dubious IMHO.

It also seems to be hardcoded in TF-A's support for the virt
board too, annoyingly.

thanks
-- PMM

