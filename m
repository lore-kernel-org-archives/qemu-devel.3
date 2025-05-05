Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD85C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBwQK-0005MT-7W; Mon, 05 May 2025 10:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uBwQG-0005Lq-7y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:03:56 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uBwQE-0007FW-BY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:03:55 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7082ce1e47cso33151857b3.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746453830; x=1747058630; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5wuwsTYtqRrlPsDGUnJVyd05PNGJPAPPX6VA0y9An5M=;
 b=jEzOg2W+IIH//vAbuC1ZeAhIIU2++CxlNvXEQKtx9omeMS1/y+OPVZwCdTUYxOl+kq
 Iy+6F5ia0Ax0ZgPNHfChTs/nniu2vkXtx+EFvCBWnpo/vQq5qeOI33IqGmXoyJYnIUva
 /Z4TbQJDWSDcFLSxYKzOV6irRb2FL/M5D/Cjv+yclBU8iCYihvjgJvLHUAmfUJ/tqs2z
 ueDFtTe4O1Z2CrFWFGelbEWE2a6oYUU1OY6Z/2HarR4TbmLQTCK6IbfmkpbEgwQj3C2O
 voKPdmShMZ3VJFtXzcJOPYH5cQu54ubdHJdWu/Yl6u1ttborCZEt2Rgy2EZQ4XVCPaMF
 TVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453830; x=1747058630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wuwsTYtqRrlPsDGUnJVyd05PNGJPAPPX6VA0y9An5M=;
 b=de1rY26Y9uTqj87YvZz3bLPv85Q9DjDv7LZQR/x5mq83ohWtECn7kgDF6nfuSnLmXq
 ZXooTzID4K17Dj1SFdU+rUxphqB8xDC/PWseSLu3SKHKuRnKHJrWE3X9ZruaasR4TYf1
 Uzfnl3SbvfDagveba3YEPvp1p4OVnugAPQIq2woUKms9/0VRRKasiUBw6QK+dWLJPLP3
 ys685bePjBI79v2Hv8OaPvrMFNEvaBR1DkIiZxEzD+xBzfpmy0ggYbHEaZ5DM35/03IS
 Z5ixWHXeE1HpYmN29VBZTqm2UI/8pGqbxI2thzNFQI1+RXg5gXqRayoK8Cvo/+Qzpqc3
 28UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVmtcuqPrMLc/Og/i+VVXk8Btfh94WNlJMya/CrujIQMJlMtHG90w6mzA07xAQdVz+A1HbfCxO9g87@nongnu.org
X-Gm-Message-State: AOJu0YwJIOE6v2fnLjRMWPTjJKgTeYC8XU+BF/XScfmHy/xz2IYWCes7
 YMqPCh6tGHTQ8iqsq+MSrakGUUqZxv+rQOOsDVMGaEDrdpnAc1q1cu9RPYPmXQCMg1yJfHOqoR/
 LNlceZA2jVwhkBCmDVGJEuO1j91zc4Ce8ukzwsw==
X-Gm-Gg: ASbGncvsJ9X9JMi9rXv8rXCFEgumoY6aTVvfpCv2GIc+N61EiXAnCCoCWTQv2ipdUd/
 zXphE2ixiLPZYLagn+wd3MprMlsRMBvG3pXxzgtuszZsvb+6w0uAKNdXFGhZxi1DxbjE4200JNP
 XIOpb8IHxk8YAi/frGXc9rJ2OF4UpsUIQ0Mw==
X-Google-Smtp-Source: AGHT+IEs8vQNYjEOn6o3Nu80xsr9wz8oIJg6uRDByS2u6VX+piT2mF5VcllJrt9P8jhkuRIBbpMQiCEIN55jfIt7ZZo=
X-Received: by 2002:a05:690c:690d:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-708eaecba5dmr97796817b3.1.1746453830462; Mon, 05 May 2025
 07:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <d3d1944e-2482-4aa7-b621-596246a08107@gnu.org>
 <CAAjaMXZhq_uv-w_9TT3++HAcO7r_OhriJA0RKWs8YqY_ryjK4w@mail.gmail.com>
 <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
In-Reply-To: <7101782c-f642-41e6-8f3a-7061ca722c99@gnu.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 May 2025 15:03:39 +0100
X-Gm-Features: ATxdqUEoT1i0n9WnsfYxFEEcgZBJkKBjfqXji91UxITs-cnq4NUyGOvrnkw5Pic
Message-ID: <CAFEAcA_UvYdKT9RH0H0kppwke7GW-DxCHA+Wzdo+4cG4SSTPFA@mail.gmail.com>
Subject: Re: Rust in QEMU update, April 2025
To: Paolo Bonzini <bonzini@gnu.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 qemu-rust@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Daniel Berrange <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 5 May 2025 at 14:45, Paolo Bonzini <bonzini@gnu.org> wrote:
>
> On 5/5/25 14:26, Manos Pitsidianakis wrote:
> >>     Something I do notice is that there's some inconsistency in
> >>     how we've structured things between the two devices, e.g.:
> >>
> >>     * the pl011 main source file is device.rs, but the hpet one
> >>       is hpet.rs


> >>     I think it would be good to figure out what we think is the
> >>     right, best style, for writing this kind of thing, and be
> >>     consistent. We have long standing problems in the C device
> >>     models where there are multiple different styles for how
> >>     we write them, and it would be good to try to aim for
> >>     more uniformity on the Rust side.
> >
> > The pl011 stuff was deliberate decisions:
> >
> > - device.rs vs pl011.rs: the device was written as a crate, so it's
> > essentially its own library, plus pl011/src/pl011.rs would be
> > redundant :)
>
> Right, I think Peter's comment was more about moving hpet.rs to
> device.rs, and merging PL011's device_class.rs into its device.rs.

Well, I don't actually have an opinion about which is better: I don't
know enough Rust to have a sense of what's more idiomatic or otherwise
preferable. My point is the more general one, that we should decide
(in all of these cases) which approach is going to work better for us
and apply that consistently, now that we have the benefit of having
written a couple of device models so we can see what each path looks like.

These initial devices are going to be the models that other people
(perhaps less familiar with Rust) are going to use as patterns when
they write other device models. Converging on a consistent structure
and way of writing devices now will help those future device authors
(including me!), I think.

-- PMM

