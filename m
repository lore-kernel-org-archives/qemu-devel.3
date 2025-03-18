Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D4C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuaRD-0003Ip-An; Tue, 18 Mar 2025 13:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaRB-0003IQ-8y
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:09:09 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuaR9-0007KV-3F
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:09:08 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so4628729276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742317744; x=1742922544; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Stp0SP8qqdwqcMVSJ8RaJ6vrUHJ8NLGoTMWj29ihkYQ=;
 b=o8UMwHla8CqSi0OxkBo80nlVuV+JntYhU3HSjyHq4pduZbjOt4O9TErvJZqzF1ouAx
 kO4tIJeaMimIh41rzGMC+i6b331+KSxxL7PdfaMDUp08wLFFxOfUStQatuP07ohDhSjy
 mElGQaW1VwI8nTrvnL9yNFXgjuctaEkLcM9aAsRkB4w7Alg9Eds4QbJawpFsBfREdnYi
 yTGmf90Wurq/6VVvtiOzaaYIjGkG1ix7e4tXO5Y2zS1EolJDH1Yg0DQGKTwhQjCSFc15
 S5HQlet61vUiS3pwOQNxG+KpwLetN6tMrregeWru75g00+2KBYLIYdqs7dB8QkyiBzEr
 xCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317744; x=1742922544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Stp0SP8qqdwqcMVSJ8RaJ6vrUHJ8NLGoTMWj29ihkYQ=;
 b=k7g1kBEQwKI16OhqjbP4RUpsX/4m5lkn+n+f1SHxC1vGaLHPDEv/fc3oiQKgMRZL8t
 iRCfII9v9grGFpu9YRU4laVI/G6JR+6pqNp6p4qnoJmZKLKnsqyRZxy/20XLkYcH8R61
 bi3to2tGhgiXnMyH4eiSfnISv4v4X9WNo8oGOwepf7pQV8Q9Yfx2leAP+AXbrNQ2zhYn
 6X2mtGT7LV0y2d8QJ4QeC0HURyqJVbO41iZ1Z7a/pEL5wjc+rqyh5zkd6l/V5vZAGypS
 2FPummMz4wjVw24idoQ/cAM1hOtd4m+xDl2vA5BNvb7wprqJXuegJQYdzI5aSh4AxFPz
 s8eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjmPJ4VkuQotTl0gEP6QhYemoSAOrC4h3FnPSWQirLmKwLVI/lv+qlcFom4/3El2MwfPkfR/RySwdA@nongnu.org
X-Gm-Message-State: AOJu0YxwRZYOzq+TnVOvHhdM8c9yR3tnymEXgwI2ektLq7LFpvhR5gJc
 7vjlvdYrg9xnsSJKAZdePJQc2wwslI8N2GeH8OLUMvQprD6ZjbxWnU5PPLm0OUfBrwFQUjF2Nlz
 8+iZ52fQ5BVHZpgxOnToIX/G8mFTxUnukSDiYDA==
X-Gm-Gg: ASbGnctlQwy7xGkTmEBHQjfsPyOqyhe58ps69i2h+gpvgEt+TbD+EyXF8K1OFR+W3aK
 uc49yA9Aul3hgtWIfIaCKF+k+HwFNIKq8yFLwrxqnKd8TGGtFu5QekzIFFFV//cONauIe1lPGt+
 3Hv/JMggEVWfcQvmMkuYF6PwPoq4Q=
X-Google-Smtp-Source: AGHT+IFnlv7Sonr77yT8aQnADCMuMhS/jEvrQ6u+ivGwgE2U/f+jaKxDVQZi6SuKxeiQhXFPB5SVsGgrEa4TryCC1Ws=
X-Received: by 2002:a05:6902:e03:b0:e5d:bdbd:acc9 with SMTP id
 3f1490d57ef6-e63f64d9b64mr22483355276.6.1742317744612; Tue, 18 Mar 2025
 10:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
 <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 17:08:52 +0000
X-Gm-Features: AQ5f1JoWs-0mPfZymPIgrZZ-xF8VpMvMBDR1xBq36KP2S63FzdGVVbFsYnZOOSQ
Message-ID: <CAFEAcA-=FaNSQOSG3iFua30baATRvjBQPd5TfG6fBqJrFBFuYA@mail.gmail.com>
Subject: Re: Generic way to detect qemu linux-user emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 18 Mar 2025 at 15:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> More generally, AIUI glibc expects that it has control over what's
> happening with threads, so it can set up its own data structures
> for the new thread (e.g. for TLS variables). This email from the
> glibc mailing list is admittedly now two decades old
> https://public-inbox.org/libc-alpha/200408042007.i74K7ZOr025380@magilla.sf.frob.com/
> but it says:
>
> # Basically, if you want to call libc functions you should do it from a
> # thread that was set up by libc or libpthread.  i.e., if you make your own
> # threads with clone, only call libc functions from the initial thread.

I spoke to some glibc devs on IRC and they confirmed that this
remains true for modern glibc: because glibc needs to set up
things like TLS on new threads, you can't mix your own direct
calls to clone() with calls to glibc functions.

-- PMM

