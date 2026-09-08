Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B462C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tPx-00066F-FT; Tue, 08 Sep 2026 06:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tPw-000663-EZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:51:08 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tPu-0007jC-RF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:51:08 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66e63c2c9e1so4451537d50.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788864665; cv=none;
 d=google.com; s=arc-20260327;
 b=PsHf6NdI/tydTpklcId4lFXDtKgLeeL8lG6aGzd/5DPi28cuqJfoNA5424zBUqDveo
 nR+5gNcjd9E+Xjg8WnwIg3LAodpzKKXPyWJq3uEubznr6KbcTTnC1YRNFKDNZvov+5ie
 Eqn0Oul4Tz8yH57h26lG3zKhVdpOXeN3GIn7lk+TKb3NaHiY1uooEP2rpwqMQUxCng3f
 lFAO6uAcsaNIJ9/AOJz9TVrt4OqVe9vA6cLg766DUk+dwdG8p81/hIGkpSwIhxbTeE/c
 T33WJJSlQd+Uc/1xnVs3TElU9IQ4Q/uqAYqGlN9h0jibvITVfVNuD/v1DAkXU00K9kNY
 8GKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3tlL7UDbBVLbZbYvR/gN09CGMdqr25TIqGpFSGVMNQE=;
 fh=AJJQC8UsL25NRH65SN4WtPGIwBnn2JuaVopGicM+qcg=;
 b=bToPyMuF4c5C7j/9uLx3kbMmpSijoJWURkpaWlVzNq9sZKq5/sJitUhcusR9iz7hB7
 46miYFHnvcQQk4BV9bO4Zyc+5CypQRDNRC3+FVSmqnzWv2dYxJm8IWj4QYsUSePn/SGF
 2lSwZRZk0UFK4orVZ+fKWYFwAWvDULTTOQyKMfWTjnCK2ZwThH98cNs41+knKPOIIMJw
 mIAtWnx6z5eIUlGiK5QSbbg7Yk30ZEFd+v4NZTOpxe+/kkOG6f0q0d7TtQwV5bpGrUsb
 R9XFHklj0LNhxJJ4rZ2T68au24eqHUkzFvweckQSoRMSOcuV6XpMqxQy87yiys61NE4l
 vVVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788864665; x=1789469465; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3tlL7UDbBVLbZbYvR/gN09CGMdqr25TIqGpFSGVMNQE=;
 b=meOcOTaguRV8dWQZt7uRn/kMjcuoXv51rYM71CerMcoXLW0bLUm4k8XOiOSfrO0nC1
 TH+8+alYOU9FHHEOAZLFUZk9uQIWLQTY2GvMmprb467CjkWRcc0xUbTX9TbCVFNYABsi
 lQbGAd/3slUK4esUbgV8KvMEhj+ZJfcp07s4GampkHxASeVe41K5WrmelYnS92xMZiXC
 Bjdx9bOCCHYAkN9kCQ/6YvfuumHFe9LYiq/J1Z2f9zeVdUoBWdvdYSwsw/HqvY7kscjS
 CK8teIthjMnkI1rNlrDqaRGH1N29WY8g63qfyv2cidZAbPZq1ffh7WnwaaVZ84Jyfpak
 MxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864665; x=1789469465;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3tlL7UDbBVLbZbYvR/gN09CGMdqr25TIqGpFSGVMNQE=;
 b=G0sn8pasycguSBZsu/pifzN9H3w0D0A2X6XSPjQlHbD85j4gTykM4FY7W8FkXfp89f
 3ZjkeUR/1uBUcuB6mAXRKWV2iSkDdVKbBNzX3xLjYz0DwLpRbJBfcKAvGpkUI+O/E60T
 M90qJ72xTzA68AqsrEPue65v5YTpMrPCtxffvlr9Yh5zlaWp3D+0i9bvjweaQ8rtTF/T
 AqlFvAaxk88eKRXgDMSCVFry7cY75FBCyhNq4723ztBFvnxdg+5wFOwEaoJPlLPIMSTd
 N8sNHZpNAcGtPe07dw2MWKtfvWoC6X4WJBk1VdCnA+oTtXxbUKp0WxZSlPIRzy9qnnhh
 8sBA==
X-Gm-Message-State: AFuF++kAA58pkIxEPQAxFPd/Lh5pCx6hKl0l9bP3f6RTFK/Uh2k0kPKV
 XLBnIxCuI2LPV909ib+SmHgqyP7fJ1JN1W5r/8/FidpPQozWQWPPqV+XtRzdCFKnjNhr3I4mw++
 RPjYhtGAtnWKlj3EwAVZoRqDpHuA7pH0s1J5dkXSVwQ==
X-Gm-Gg: AYBFou07mpzaUhts5e7O9SGbfAfKWQGayC1XZ1Em2uTMi211A/Oi0/cTn6kyWwy72OX
 +hcGjZ1dBaoCIoUKjl+wcuZFHtzBbwcGYwSHMWJ1WBbvcOgOhrqpTXswzGvA0bEVuYS1nBDlbrj
 nItEKAmv0oWpAZfDRieofmwbyujzN9X7XygbSPtmqaTqt8+ou4/x1V6z77uDXX5LolMWIf8AxLW
 1vS5w8ml5DPOroNND7r+poqIYFz5915uduzP5XwYpKTkNIYoW+E9oYR9X9fbgTiq3L8Qkt0lsq2
 Y2LA4tk5xPiLfDccSjIKhE2Hv13AD3R0vrEbwmPQUdWrFBwotXRjMR9xuktLdEyeGFYY5Mp3Eq7
 OwbzJkJ3t0WMTW5eGmMv9w26rNUGs
X-Received: by 2002:a05:690e:1596:10b0:66e:5bd7:7dec with SMTP id
 956f58d0204a3-66fae6679a5mr6125896d50.3.1788864665181; Tue, 08 Sep 2026
 03:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <LVXPR21MB7009892597B7773332B656EFADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
In-Reply-To: <LVXPR21MB7009892597B7773332B656EFADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 11:50:53 +0100
X-Gm-Features: AcwNN1V0ro6i0CuHrVArDnE-pC-pJE7LdtS3fdJwCY13xTnEMLAP87yOLLdqt9I
Message-ID: <CAFEAcA-Nn+zFDf7iYU852JE2mfNy+eD7eJhUEZRc8oM0PAn2LQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] target/arm/whpx: fix whpx-arm reset hang
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Pedro d'Aquino Filocre F S Barbuda" <pbarbuda@microsoft.com>, 
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 20 Aug 2026 at 01:35, Doug Cook (WINDOWS) <dcook@microsoft.com> wrote:
>
> Under whpx, arm reset results in hangs and crashes.
>
> - Arguments out of order in ENCODE_AA64_CP_REG, so get_arm_cp_reginfo()
>   fails, whpx_set_registers does nothing for reset, and SCTLR_EL1 retains
>   guest state with MMU enabled after reset, resulting in fault and hang.
>   Fix via wrapper macro to retain existing ordering convention.
> - Fixing the ENCODE_AA64_CP_REG issue results in assertions while trying
>   to write to ARM_CP_CONST registers. Skip them.
> - Correct four entries in the breakpoint/watchpoint index 1 block that
>   named index 0 registers.
> - CPUs that are idle at time of reset remain in suspend after reset.
> - CPUs are not in the correct StartupSuspend state after reset.
>
> After this change, I am able to repeatedly reset an arm64 guest, using
> shutdown-reset, external reset, and watchdog reset.

Thanks; I've applied this series to target-arm.next.

I noticed that your emails for this don't seem to have been
correctly threaded -- in a patch series, each individual
patch should appear as a reply to the cover letter (i.e with
the usual standard In-Reply-To/References headers). The
patch tooling relies on this to be able to operate on the
patchseries as a unit. In this case since there were only
three patches I was able to manually go and find the emails
and apply them individually, but it gets more awkward the more
patches are involved. If you could have a look at how your
emails are getting sent so that you get the threading right
for future patchsets that would be helpful.

thanks
-- PMM

