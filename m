Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D9D2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ovE-0006fd-5n; Fri, 18 Oct 2024 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1ovC-0006f4-9X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:29:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1ovA-0007tM-PF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:29:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so3060247a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729265383; x=1729870183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35TxFoBwE/Ru8ZV4fXJd7kbiQXfCKpRq6FMpSUnsZJg=;
 b=poPPF3l2r5YaXoX7pNADdTUE0znjvyfH1SIxwVly6yTXJLrjMA9T9mxPOcXzZtew8p
 xQCy85G0hRiijNVukqqpszLv1O9vVHUoQM7go5Ud1RPHZwAu0n4mVIMHGC4BKxEH+Pvm
 IeREgyXlM5T0KWBvbM0G+68CUV5rlhbatlBc7x9cO/4FDyg7e/LfsbnYLjmlrWDApkVg
 nR9GZJO8GmZEhc+i1xp7vrXra3f3an37K8W5XEa7ZkAzxzfXcVIkKzxge4SfJJHuxdjF
 dvTDi8AIlObblzEbgO5iHst+sCmfyEiUjfKL6mgC3vcs64cv+zRUGhhtyoSEqDFtPwUb
 RyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729265383; x=1729870183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35TxFoBwE/Ru8ZV4fXJd7kbiQXfCKpRq6FMpSUnsZJg=;
 b=Xdk0gYhwr5OHSBeWUbqr5onpcZMYfIh5tXRfLP9NzY0rmaxx4lulp+BiA3AIurRi2b
 /jqL+3nGciq3cki1wKqeS8/2bDr+EfH11f0FdqDH5nfFzz+xNIygiU/4aPFyk6rFO98p
 RsFBd60orLk+N5UOCna+h1OnIE/prFEGU5sYDbl2mBsOc0RkDa55Y6Z0/UfYhq4o1uFu
 iaMDX0jjtTiH7gO/VEC0wHON77EH1wt8aYsoh39H0euqP8sD+++DVWOHHBYYzNcyeWX9
 NqV2q8QE8u4CciCgalEUA+ykXr7oL2PnbXhTyXz5M2TYha9TS0o5/o02NJkVyf1JXIH+
 s8Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUba9ga/B6yL6eZlRGN/YQFe/SKhZ2i/nmrJbEQ+LzDI5xuLg/VaL+IZq06tSgBreTtHCBF/h9S8r+c@nongnu.org
X-Gm-Message-State: AOJu0Yw6jpk0QvK4oYns5Sm99Yl4uaD83Wyx6crSe9XXjQ1tSvoohfeY
 giyuQRwFmjLSbM8ShnvDA0bpIzq/gFjCVXzm/aegY5/Oa2is6F7fWDcdrGREA7ouWENz1P8DNmv
 JY9MVKXHtNgjb96PxWeIEPSJ326H4r+sW1YIYnw==
X-Google-Smtp-Source: AGHT+IG2C1pcmNQERXK6oOc622D1AEjdZx696HcoljlYKND9OBPgEa6D6VS3+3TOsW+8HTGqTr7naSc2QtRU+b/1yfw=
X-Received: by 2002:a05:6402:268e:b0:5c4:1437:4159 with SMTP id
 4fb4d7f45d1cf-5ca0ae8055fmr2170619a12.28.1729265383049; Fri, 18 Oct 2024
 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241008114302.4855-1-gankulkarni@os.amperecomputing.com>
In-Reply-To: <20241008114302.4855-1-gankulkarni@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:29:32 +0100
Message-ID: <CAFEAcA8pErj84CTzBJ-Vd94B4radu2Ta=oDyKV_xYMBNcotQmA@mail.gmail.com>
Subject: Re: [PATCH v4] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 gustavo.romero@linaro.org, alex.bennee@linaro.org, cohuck@redhat.com, 
 darren@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 8 Oct 2024 at 12:43, Ganapatrao Kulkarni
<gankulkarni@os.amperecomputing.com> wrote:
>
> From: Cornelia Huck <cohuck@redhat.com>
>
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> [gankulkarni: This patch is rework of commit b320e21c48
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.]
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>



Applied to target-arm.next, thanks.

-- PMM

