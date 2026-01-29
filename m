Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB95AD61017
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSHS-0008Of-Np; Thu, 29 Jan 2026 08:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSHE-0008Lk-T2
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:41:43 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlSHC-0005bC-Je
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:41:40 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79430ef54c3so9311737b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769694097; cv=none;
 d=google.com; s=arc-20240605;
 b=EtqO/EeDUaWxAkuQmE3Ry+KZAMUsIiUeJBPAuHxDDOB2v4o+si1a4iqvGPtFXiGsiM
 55BPNSmqR0sAENFEX500Xg5DgtTxftOzjfRqI/1IRsEFFQaDYjembFoq84mYISuIHE9z
 yVPl08UhseyrZjHlOkVK2vmPOVFdmWZu1HwY1ju0newnR0hgM30DwUZ7ggrUQaxD1CyU
 pUdcYEGQNueWUQ7Hdlp3lwkGRiCC4QBVFM1GW7BYwxI1SweNqcDJHYSOg3H/eHWGVb7e
 tlROGT02OYgRAD1Goab2jSrCX4naMH5JxW/SanSpiZSqXg1in7+1iiBYqLqY2/D3qk+E
 DL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cwyLYqO384PsM59QyIlQBNjYFKFwiiWXYOM1AFGJlzE=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=cAqDT+rzy2g1VjK1vZ53ndgqNSHrFLfAqiEEn77ToHUurwlEmiZx/Qq5hA1/+/uNH8
 OVbXC/u5JjBFl110dyBK+0j3VS3YmWPPWJYQi8buFmKf3dzUqDWMyak5iSXfYLAmcL5j
 P22mFvWCXVB5q9WEa6P5Hez+ZO0QwytHQFAUMMqZIk6KwVrtZQR2Ikq3aW1T5Qo/SrhI
 CjHrkyki0HmNmQ87eMBGSK4LnLcUeOdSIKGTbFpA3rlch6Xm7/DAx/2iVIcUP8yCnmxV
 5iRf/2XArAFNSNs+4gkH1qYTuvv0JnyBXC9e8PTbY/V0tqhkvQl71YDPU5Ja58YXyr9W
 TVBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769694097; x=1770298897; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cwyLYqO384PsM59QyIlQBNjYFKFwiiWXYOM1AFGJlzE=;
 b=pYSqQAyrL/RyEXWSh9GQvFk/V6ThoN5vUr34YYf7J37uLqOVsCODGfU99/LaQsGdXw
 pHj0BfENB+5svwqwg24Mz3GUETDWdTMGnxGCx7FDA8T+d6yFW3n0NUZRmOtcNhwqUAWy
 1QhhKLRsDF7y3IBwQrId7YXGIkCFi4jXvmvFuHWX5HFUxHF9VJnRd8O0V48IilM0bvcc
 Wf/45MPflG5ltW8CRk269Y2VW3/Fu7KqEYenu2N9NaJPlW07QPoQ/E0gwAa6YeL1jzTb
 5hxWuWlY5y++MEZfrkJwfCiFoLI947bccAhsw4W6vfhl4stHYve0Hf5BvIOG5H3Of0lu
 WLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694097; x=1770298897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwyLYqO384PsM59QyIlQBNjYFKFwiiWXYOM1AFGJlzE=;
 b=DfkKrn5D5y7nRTXghfBGj3EImIBniY17rm4z1HZ8SPKyq6nlWB+2/8SCu0NzomZNcK
 spx70xxyoDwMQt/dmpmgHplm3yG6u6O9DM0+FIJQ8tDhzj3sVfZv0MwQTGLgWCvTavg5
 viHsL9IinLZoQlT37On+MEjxaK1BCUZZ+ObVFXZhlHs3fAZcyhUMuiWKggmgBBJPxDC9
 DOdCxMAMQhqMLWIQPta1PZ7CHE9JTp/Iw6eul87bCQNiLbfnmnbm5pnnzp0VZOQdX0nq
 6rHKonP98PCxC6Zc29IKdrvl8GfZM5mdpyDjIfZntzxV0wv1+M/jYpV+oMCnftFvTIeU
 NJiA==
X-Gm-Message-State: AOJu0YycZWNVdWdmLU2E50VbqJcP6FuSw1VSVv4+ROD12nxKua2JBcnG
 oyhr00lQFNco/ZdOmlGIJ1mn9RloEwPO3kPDq8P6XPXQGxCOlhkKdIw2OA8a2/JXupoz9UHu6cG
 XVicAUSrhdBixjpt96y7L1NX6+QmYDaMQ4jDWnzGd3A==
X-Gm-Gg: AZuq6aJvrWmh8wjKf3Decw5CZH0Z4TbZ1NRX4uZNLW0h7QN8nv3mLN/8gmPV22qFXJV
 sEMH3fri1T2vA4SGT6bqQnWkIC8sStBa2M/+6/ylxnNv0TPvr9Z3+8hshV7t/K0m5+2chYB+V4a
 SzdIas879UcSTEcT3y+eD7pmWmB4qoNkXLbSerrKyY72mS1cXEU43WDz0coltUaVDDEyLMFeE9O
 orRyV8awKVvJI7oxVqvALmJUAlhJwOfpQ8dkpeUztHaoLlFUriiTDgsfr/WLCgahtpXqT3JIvsL
 A3of
X-Received: by 2002:a05:690c:2904:b0:794:9317:bad2 with SMTP id
 00721157ae682-7949317c25dmr13631087b3.56.1769694097379; Thu, 29 Jan 2026
 05:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-6-mohamed@unpredictable.fr>
 <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
In-Reply-To: <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 13:41:24 +0000
X-Gm-Features: AZwV_QjiaSc4bQvvEHjcRpY3vBoosppBqZv5nrEesKh4Q49SBnntHhtw_EfBkXE
Message-ID: <CAFEAcA-3akyfdwprPe8Fr_P-BOUAauxJqAETEj_+NN-XeBD3BQ@mail.gmail.com>
Subject: Re: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
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

On Thu, 29 Jan 2026 at 13:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >
> > After the previous commit introducing GICv3 + GICv2m configurations,
> > update the AArch64 ACPI tables for the GICv2 case.
> >
> > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> >  tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
> >  4 files changed, 3 deletions(-)
>
> The process documented in tests/qtest/bios-tables-test.c says
> that this commit is supposed to have the diff of the disassembled
> table data in the commit message, so that human reviewers can
> confirm that the changes are as expected. (If you git log
> tests/data/acpi you can see how this looks.)
>
> Can you provide the ASL diff, please? (If this is going to be the
> only fix needed to this version of the series, which I hope it
> will be, then I can update the commit message as I apply the
> series, so you don't need to respin, just reply with the updated
> commit message with the diff in it.)

...ah, it looks like unfortunately this is going to conflict
with the smmuv3 acceleration series I already have queued,
because that series also updates these ACPI blobs. So I think
the best thing is if I get that out in a target-arm pullreq
and then you can rebase on top of that.

thanks
-- PMM

