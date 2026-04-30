Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9ABFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGQ-00043J-FX; Thu, 30 Apr 2026 10:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRKZ-0001ug-Md
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:21:27 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRKW-0007lL-P8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:21:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2aae146b604so6013545ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555282; cv=none;
 d=google.com; s=arc-20240605;
 b=RtBJxGBacPWyDMlGQ9llXsmPUWWfEcJe54VgUHxjtMhmVOM4+Tn5D8HBKrXFCAi9Fn
 5L3HddCP2rp3tUbAVkPWVpTtIJJ/weJwOClO0YcghCmRt4OfDoX8+e6R1LBiXC82XUGq
 6+TvX9quMe5hS6ed/aD9KicZovVhFvpF41UJvWJjf56SMJ+p4sZZsecAC4FtZZM9cd08
 VGttc+a9F0/Ga2K16i/vM1QuhqNphRaMFz46PlGY9VI5aadXPeC6un71DO0KrfOFX3l3
 41fBFgZl6+OL/oBsYsElFkiMR5aUH7vCDJPnoo1LAPFI5DfulF6w5pyUSBwJc6snBj44
 NX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
 fh=qsSgpkl+6XmdYWhRLMAbTUE72QWsJeCxh+IYdLSlTrk=;
 b=QPDj6ihlGL/RcnaT+pxnCvYxJFse+OViOqfQi9FzvsyRT4ikLuaRZxsXV8toofhhG4
 vtwEviroYgV4RzfEldspr+QgQz/cQTIW115dQNKrNM9+NV/9BSsyA/hs+bnl2FCabdA9
 PcJKG/XGMykJkGUqRup9aYnuw/l8ieoWTkiD8VthIzn6NMtrZ7Y2rkcV1G9yXPIoLh6q
 Pv7tghrBuP2bTWyq+gOOngVhd7YgBkTGlF7fJSTRez80DCyiZQlMAjSkZc7wgdIZIGz/
 7AB0J7FRO1Pj1nYrPCLd2369yn3EUcffSbrI9SHiwjH+pK/SnQ90EOz4SUNS1OTT4wg0
 4L/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777555282; x=1778160082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
 b=Z1A7o3lgG+AnI0xpVGC6Mw3hSTLg7HsBNA5QGhI+KO+4P2V3Pdz+O6dyxF9A6Wygk1
 g5czHD86Qc+zuTWU6WmCTsUxOmz2WFMvWsfyz4V9kHEBfJtGF1X1sf3I1tTkNY7Ww6R0
 rTPkvVn+NGPm9+dcro759bfQUPH34ZA8j7F+XAesYmwhuiQoN/hsNvRDKktzLQQyEUWa
 TSJpHcibMqWr8h20qIjsC63qWATwp3R31+uq1AnfPI838BNRCVR2+/jtc4rzB0fYg5Eu
 iOwOELj1jFQ4e7HQ/YnVfLEEmwUQEMOEl59lHnuelYTWiDrg2g7a3clKGNso2MNlyGXR
 c/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555282; x=1778160082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxbWF8KbXOGlfQKsgorPOT1msBKMLNNbj2kYslbT5dc=;
 b=piYQxC45N8OUAgYuuVvYEngQ7DE5nrR36f/qDPGOLqMqy+suCiZJAz2tRna6UmP4qJ
 RdcOfy8+i1+B4EuPlhQZntlDjEjtRWGA6zaRwo5idxrOM6H2VbFNSrxlvA7g92EXNt6l
 KzG9tu/THT2kjfF7a55onweYDsdMIKxXlw6NAC6eCw46bEkQmfTRV9r/IOQhdaY0zmp3
 JXPtXHHwDSeOqIqbyUtpZtZ42RglYOTxXzBiho0h639+XLvS2acjYGXo4B+vDqHuL5Ah
 qin4n8I0ccrvDgmWZNQIYxQWSWzoJamcXXU8yy+djqtI92KX1UuOD/W6ixEK+257PD36
 SL3w==
X-Gm-Message-State: AOJu0Yw+wVqVIOqr9yglfSN09rhhwxs8FNxM0a0lMUkRoryPUGazO5/5
 V/lSh6nTC7/DA5SSXjHfNnieI8CZMWMxBQwA6QNVJhD0qFt5PAwM3YZj1WSyCE9cP10sUO3g5Bz
 ylhtyOZ4xsC0/0fNLELOyzpukzuLJlHa1TPW2J28iPWekYaYllzeE
X-Gm-Gg: AeBDievrOic452oAnwq4TbhNWCWH8g9vWQ6pRz2pIUd2aU21kPfzClbdh5tymN0rPKR
 MVmXOyUNAoNRmS26R5sJJy8m2MZ9jQD+nqh0/S84L22qit7XrqA1+fW318/vg6KqyUzegG1P35/
 03iI+Ppbt6aj8O0A3G2q5HTc7t9z0mxkMVtc2KJgqzr7YL5TK+uDauFeb1iw+3iLCm72vLhe47l
 tIKNDC25c0TQx5paLOuuVamyysTz0VRakHyQVrkWplYz1C3aFS97XOPPv4PmgMwpsMC+lLLxRPg
 dyZ5wjACeo0GuMzNLsKyvM2D5BYdX7IZ1E5a9N2ifWi3pr8PumvtA6m1dULzaQEwVT1xwKlzZIW
 6+w==
X-Received: by 2002:a05:690e:2451:b0:649:ed08:1a01 with SMTP id
 956f58d0204a3-65c18de27b4mr1561059d50.35.1777554591429; Thu, 30 Apr 2026
 06:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260428-features-v1-1-1841b39da7e6@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:09:40 +0100
X-Gm-Features: AVHnY4ISyJss64q1Mf2DvH6h2BtrzOWFl1ukcMtkQZ4nxtYAaw3YZoAhJwZVxFM
Message-ID: <CAFEAcA9_Sc=+Cn7JiPOo9GjOZFU4KCc7nFVqU=9=QAsNBG6AsQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: Cache host CPU probe failure
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-pl1-x630.google.com
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

On Tue, 28 Apr 2026 at 09:07, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> kvm_arm_set_cpu_features_from_host() does not properly handle host CPU
> probe failure with caching. The current algorithm can be summarized as
> follows:
>
>     If dtb_compatible is not cached:
>         If kvm_arm_create_scratch_host_vcpu() fails:
>             Report failure
>
>         Cache dtb_compatible
>
>         If getting register values fails:
>             Report failure
>
>     Report success
>
> This algorithm has the following problems:
>
> - If kvm_arm_create_scratch_host_vcpu() fails, probing may be repeated.
> - If getting register values fails, later invocations incorrectly report
>   success.
>
> Make two changes to fix them:
>
> - Cache dtb_compatible whenever a probe is attempted.
> - Record probe failure by assigning QEMU_KVM_ARM_TARGET_NONE to
>   arm_host_cpu_features.target.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Supersedes: <20260422-arm-v1-1-106a9a9e22dd@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

