Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C96EE20A8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMuo-0005OB-4M; Fri, 06 Feb 2026 09:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMum-0005Mj-CG
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:34:32 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voMuk-0004IJ-OI
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:34:32 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-794e95357cfso21196017b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770388469; cv=none;
 d=google.com; s=arc-20240605;
 b=K/2BQg6qkJSbw1M4JPEnMDttue0v8Rf5pCQAx6Q8SXW8O5JsadFeCvhp0GTMd3Oli6
 aqPfa7IIvMFoRl83fQnWLuXlt7WSOPFp3MdSIhtdqm3tZSWj+GqpF/GCQQukzLdMLScs
 Ww8+K4ugdwxBsYzfTgoQHs4EkVythuGJV0LxqUPs003AUneDf8VYHoNyyBYYq5umklhl
 yqPSykBasKPFSAk2mLo/v3qA2RW4vFl6sYJNXpbCEVNvEM/OINghylkwBENapQVEZFcl
 jVz7g+SrzFUQpVcCmccSv/e4P9GkL3uIFlIQrZopdMDl3SEknk4475XvpwY5WSdD5QZm
 AgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1QF+DrOZ92/2UckmnvCyXlTNYdwhzVhQX7vJx1YPgPU=;
 fh=uQAE53GSVJksk+ZgHjxzEVv9HqBJ9wUEGrW2HX0x06k=;
 b=lW/bh2O6/fo1gsPSAyG3DqYSGWWbHJyIRrzNVOXEbnN6AwVyo5HEIhHt9DxqQJ8XhE
 DQeQhecdRP+vplqpCgkiwHOOtcRMFQjEe6jQFmNGJrNnao9hlJG05Kfwv0zb3swg0e70
 tvJWaYP7wr66lGDrnXQGnrMBxjNMwmqj4twyHDzCopnf4ayX74n3QP3ygxx3ZRnIFcwZ
 O+xXlyM1BqKiuzZ5snvDETDZYv8s73itqc2t32DUFbsKsFogbk1iLcI96JleZLqYPUgX
 jUDx9ievI0aTr18LPqWogXh5WtjfkgEBDGK7Oq57ubzcCCUrM4lEIUo5KD5F9RL3YozX
 swQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770388469; x=1770993269; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1QF+DrOZ92/2UckmnvCyXlTNYdwhzVhQX7vJx1YPgPU=;
 b=nkHpzEEkrweLnFL/Hll6Y417lrc4gA6iSnUUhULeh5Cv6Mfyo4pKiCBQvR8eW6iNUI
 tADaE+ZvxNyb6blxUo5dWCUPbU3nUxVT4LE27Pcm7bv+i535aWgJKwwGcXqB8n/lxaTU
 eHbwW7Q2BnStQMsOxP1qfqaB9WLbNmheVIPH3Xw8XKYVNsj0SGhnSQPdLKJ1FYcCMTEI
 oesONM5M64uXHvVCwgnnkhUVM/pAT57d/NVz3kVygUUnbAr5slQDwiUj33S/uvWWa6z5
 qqec2RLWq7VlZnPhxL48yzrt+ggbCwGrAJ8s6rZt6q8chfgsCiX57aC/+klR0oRkd3b0
 vOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770388469; x=1770993269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QF+DrOZ92/2UckmnvCyXlTNYdwhzVhQX7vJx1YPgPU=;
 b=RGHboA1TlkPcQZZCfZX5geHPea4J6Z+lBy7pqJtifc9GNFio4DLnR2GRTblVxbxfUC
 cz7R4gnwR0Nx/83kpFASUJBhIpyi4RLyKgWQ+1MIsuQjp5r/BTIecfCyNqcbtEOCtkJV
 alyjJmrLtQ5EgjdOCFHxJ2FDmOku+IZCG/HMGtktq574pa8jl5MhPLX8liVB+LN8vfmS
 b/Uc2go8J/hJFv/XJe2+1DKqiFCEJlF4LzMIAJFhJQFWxQM0tDFG1sA2rj8bJnoObY9g
 HsAS9NL1ZdWKPgncaxHaQgDn3unII5JY3wamTHZRLU0rz5J4Hig2jXsnP6Qh+GDAOsTk
 sK+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS50Hv1lPSGQwQGqXGvH1+WhdxZSQOm+/hqx/dhpsUa5LJVotFBYAuzFN2/6PBOdgmG+MZwih7Jw2q@nongnu.org
X-Gm-Message-State: AOJu0Yzji+YmCU120TX/vNx4dtjXu0gk9DMUoj4zZjn8R729DPvLuvVt
 5GYFe5kOJaeK18juTGzn6BE8pBiA2SxPwGaATUY8j2xenuUbdTSdJ5KobB85EroljUWLyNlpPta
 27ifpJdx3iN9lRHMU3GgOVKw0gm8CwbhJqM3ZBi/Vhg==
X-Gm-Gg: AZuq6aIwgo2fZbc+BlA4x3yJNLlOF/gvkVupLN1+n8O9oLosZlMZlDI43JGUOPcCNi9
 BwI1S4fiAhGrxiGuHImfkbBAMLbPulMetoYCDs/bMHGmqrE3Ak66Ni1pZi3UBfZKS8Lds140DnF
 HUIUDiD55FJtykYkMdZwh8f3zp9hMXazCHuHaFfBEcFPEv+V8zenW/kxumjTD+8+4UeI3IgH2bj
 50DhqQMJZkz9uQ1mLuX3Hf8NIATmQ7UjGCdEcRpZy5fUeRpnMGhxX1u34mUjhYBfomVgKkd0cZY
 WR0sY1W8guoyxQ/qLDJ/nKan1HpRyljDGYaoKVUE/2GSJKW3MEfc4g/wigIj5OD4xw==
X-Received: by 2002:a05:690c:f95:b0:794:3068:255a with SMTP id
 00721157ae682-7952ab3f631mr27280127b3.40.1770388469281; Fri, 06 Feb 2026
 06:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-2-eric.auger@redhat.com>
In-Reply-To: <20260126165445.3033335-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 14:34:17 +0000
X-Gm-Features: AZwV_QgonnCeAULfz2vI0ip10Vy7G8wO8jNB96Hhllk6OH5AuvA-LjMjnL_SzG8
Message-ID: <CAFEAcA-AtNZWhcRh=p63krT3RemqtSq=MbWjwQvhqk5a6GK_pw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] hw/arm/virt: Rename arm_virt_compat into
 arm_virt_compat_defaults
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 gshan@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 26 Jan 2026 at 16:55, Eric Auger <eric.auger@redhat.com> wrote:
>
> Renaming arm_virt_compat into arm_virt_compat_defaults
> makes more obvious that those compats apply to all machine
> types by default, if not overriden for specific ones. This also
> matches the terminology used for pc-q35.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Having our function name match the pc version seems sensible,
and this patch isn't strongly related to the rest of the
series, so I've applied this one to target-arm.next.

thanks
-- PMM

