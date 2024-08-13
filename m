Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7FCC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 09:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnsz-0008Mf-KD; Tue, 13 Aug 2024 05:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdnsw-0008LS-IU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:32:10 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdnsu-0007VE-45
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 05:32:09 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62570fso6316563a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723541526; x=1724146326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPdSsMXVvwmkzToLvQO/aZq98uOCJ9cRuu25I0/T+ss=;
 b=I7ZYv5rJ8eJ5VOzQ+hjqQuiiTjASty3S65PvvwqQFCGV1qpB/EUzAQgCdUPNpDQLcb
 Jkx44lWYDgZ1qSmTn1dkrwuHEb8DTuhPSaGQH5iJlTvmk9Ywrn0v1JCpr1JDkDUrEVFC
 bBOawOHS+mPv+175G46cI7wR6YKwtD5/vcx43H3g+fe5pzxw3q2sdEAmq7RZmkpS1y6A
 gqMb/dOCkXQc75zppGHEZESFoR/HZ7/Ot1uptjT4em5ctLr1grShO31kEjIO7B8nOUVG
 bf1O6XRSl4qDPKx/gLb60MrCEzp0H94eWm3KCN4VA52nL46+C7Q11fEmyFqpaA7teide
 4QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723541526; x=1724146326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPdSsMXVvwmkzToLvQO/aZq98uOCJ9cRuu25I0/T+ss=;
 b=HHxLD7ajipt9JKEs9I3N3YRLHU9Pj+VixfMM+GIIoclQtuLyBAMT/zS1SIOE3xO7vu
 Jm+QxDMj2WBSShtW4A67ZSn5lA2F+GNcwamRrRRqZ2Y+Km0Wzjpq5zXvk8BZyLd54oo8
 Ce+ts6fwXLo1ERQwrw1duclaNd+CHZnQYgmPmAznPCH+u9LWVs85+2665us5rKZ8fDJc
 V4u0rCDOi1AyZeM3DVr10kZHncOxYdeZ4uTqXUhr68Cmh7eWn8PEk9yzv+Eq6yvRPLRT
 6nMQLOCEQAjyg3LQsX1aFxfVCJMmlNEvKb0fV2nX3GeJ+hS3T3fjWxDhKYVu7B1yAaGd
 oDDw==
X-Gm-Message-State: AOJu0Yz9n+jjecANnW9aOQQunHWdpsEv5FI1tTSOVIpSbE2r/6bxqXqn
 poYnr8R66KHSyyUlz1sRr6uXEYsXrM9Va6CrEys/KBSig3X3+R6uowZJz8ydzdAip4n5MWU3AfS
 HBdmXcnf9t9Y4c6qBpM+eD0qggjmPTlRDNzVz5w==
X-Google-Smtp-Source: AGHT+IEORpvqJDUUvIHlnux/hr5EOd+Cwywf2FHKSlLl2QWCJdKc6OVUuSgCrS+SQcY0WNIL+6AC4f36/4GxMIEpzrE=
X-Received: by 2002:a05:6402:5249:b0:5a1:24fc:9a47 with SMTP id
 4fb4d7f45d1cf-5bd44c69020mr1860580a12.27.1723541526083; Tue, 13 Aug 2024
 02:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240718230031.69641-1-danny_canter@apple.com>
 <CAFEAcA__WZ=uw0VLcP0fLbUTwmctsZ1y=FRf9bXMT9WJC2sRFA@mail.gmail.com>
 <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
In-Reply-To: <E03A8C36-4079-468F-9596-328D713C3611@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2024 10:31:54 +0100
Message-ID: <CAFEAcA9XXhsUeHNjsVkjhjO2_Njkk=L00BG+24xtXWWKgJayRw@mail.gmail.com>
Subject: Re: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS
 15+
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Cameron Esfahani <dirty@apple.com>, rbolshakov@ddn.com, agraf@csgraf.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 12 Aug 2024 at 23:18, Danny Canter <danny_canter@apple.com> wrote:
> On Aug 12, 2024, at 10:52=E2=80=AFAM, Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > This is unfortunately probably going to imply a bit of extra
> > plumbing to be implemented for hvf -- that MachineClass::kvm_type
> > method is (as the name suggests) KVM specific. (Multi-patch
> > patchset for that, where we add the plumbing in as its own
> > separate patch (and/or whatever other split of functionality
> > into coherent chunks makes sense), rather than one-big-patch, please.)
>
> That=E2=80=99s perfectly fine, I=E2=80=99ll try and see how the plumbing =
was done
> for KVM and try and emulate where it makes sense
> for HVF. Agree though, that=E2=80=99d definitely push this into multi-pat=
ch
> territory. Curious if you think what=E2=80=99s here today should
> be multiple patches or the current work seems fine in one?

I think it was fine as one patch. My personal preference
when I write code tends to go for more-smaller-patches
over fewer-larger-patches, so I might have for example
split out "Add hvf_arch_vm_create()" into its own
patch, but that's very borderline, and I wouldn't ask for
that change at code review time unless the patch as a whole
was too big and unwieldy and I was looking for places to
suggest a split into multiple patches.

-- PMM

