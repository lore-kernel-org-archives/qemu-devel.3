Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C804ECC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH223-0005Yh-4W; Wed, 14 Oct 2026 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xH221-0005YX-NW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:40:45 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xH220-0007WH-5c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:40:45 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b05bf699easo34957367b3.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996042; cv=none;
 d=google.com; s=arc-20260327;
 b=FBnUPmfuvFbQqlj+7f+7GjcPlZev7Z6AAwfCUQBRjCg3vop9Z9u/lRBnJT1jzoCxRP
 WDrJbhmBY4AqqSE1tIeh/k0ZHTab1ogZ+hWsfb68UbautVqWDP3IYwWKurpXgbJM1oUR
 EBFrbf5TEo7zhjj4451/l8JWK+yLR7g9APOT13BE6FcQnP5zgurRjDOWV5qM3/MeabD8
 vtYQM4aNuKuEEjSjRwic1D1ndNZxi8GEQBgJU17rhAMoIg5XNA5yXI3MN1uBMUQv3wmW
 9cAPkUxq648P6uxlKSHdicB1ihHnw6Z/g2LOd5eCMTbAvay5NkcUGCTHHDvRw9Qj6QEO
 C2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HsE4A9PIDoSy53wyR5EU6kLVeX4AGREiYkgrJG6uiU8=;
 fh=w7Bu1wSGyEWRhvKtbbR+K0kl0+7ycObiJaq3bQjBX30=;
 b=sWZSKvfzF+uMK7tMts7uwEYFn3u+DbC3ePB5M6WnhnETdOTW/kvPfr2cOM/4PN0Zui
 mBNssth3Royr+q59900FbDK4EOwUUtWrdvrv2qRFjtebcCVhEiOQiewkx/tJ8WLOL5fH
 THiJQEi7N/p7iVqExEzvRx0o57XkJAnmPHglmOqkq9kVtyIYH5AZOeJSUup5C3BIWi31
 p7kl9ZO2Z9j1iZvwJhnR4K+s3WHW/FPqpk0nf/d2LCH6KuPSnF/7O6u+FCPrwDTbPPV/
 TO7rHBam6FQbTYAZCpznKrHYzhWofqsWDU8+kWltOGfaz6707yc3Fc6NHYefsyJHZH5R
 WZng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791996042; x=1792600842; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HsE4A9PIDoSy53wyR5EU6kLVeX4AGREiYkgrJG6uiU8=;
 b=qyuXcPPrt4mS8GATW3Ngbu7Q2mUa4YXol3NlzPLQHDZUjHx4g1RAXi4t4BoZSxwxAA
 kk8im8Ny4uMfuitC+OfRBQH0ygW7bJtjJ/it44j0Uj3ojf7MvCnb5JR5taZhlunRHYSU
 wKywiSwEGx6n4F7dmLbnHU0an1mpPow73ZZ2TyTOzpvHDcfL6upTlNorNWNn7gOe3adb
 UdNPHQHccp8VgoY1dEtPQh+T1OiV4sEqK0MOt7YIloD0EDQT6VHhkZLsl2uD4EF6dNPn
 2KwFA2LBITs01lL3FV6wQzsux5twRFS3QjZHpdw3Pl/R/gdHDJnmzqir6XuIcOQpTXRC
 4lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996042; x=1792600842;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HsE4A9PIDoSy53wyR5EU6kLVeX4AGREiYkgrJG6uiU8=;
 b=J2JTr4GxWxxibTJIRVidV7Jn/U+bkSYmFqDLqrOF3u0m8oimZkICcpwrSKhUbH2o/V
 uctQeyrdIqfEyyIr9qXokblZIg1XfdK5JWOUyCHeo1bhyrlvDW9tvvh7R+6rrGwq1Pro
 wvKzseQl2xUanK5Kfix89+alC4Rz1naPVEe3fmviTxcLHRy2u2XT6prVgllLqqDBNQSA
 1ylIeBXFjkHIPhguhqzVz7cGYMcc9XoJ/C/RcDycmXgsAnspbWbTH7GlJwyt0un3fAf0
 v5iJD2RkNMS7aYQiRB14CWlekH/j/28lhFl8VfBh+2FXbB9zHUNKIx2jwGIcGRM1Gz3y
 +4zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvvvDvjUrWiTUPWltknmZehyfFXYeuSkg/OLpGLVpYbSUiVeuOWPIhWFvh6UUFyMD3XUXLoCyVOh8u@nongnu.org
X-Gm-Message-State: AFq9FYJtNfR9bcEjSmSfHWmGGE3u/s9G3bpSzx+q6F99c3V1hVWHu6f6
 VHaN4mQqvhzQnRDHadtN3OHGwx54eT0XH+u7vo/l5Nz9m0b+ePSkrV20WDyCz1eLm9o947c7lCl
 OoOr1UP3XE8s4Wz+/logABk6/0kgT8K12hv2PiKI51Q==
X-Gm-Gg: AYBFou3FgT/zQd7dQM51DYOdU7ZfsGuLdG92SDqtGsjc1HGBkUVW7hibgfkklHzEY/5
 iv7PFf5I9Z/NGBqnEfB/wGHSJa+rTGYbbJhLay4Kn5SQ8yN2VNWhz+dy0NOVUrZynh/llsKva9/
 HryanE9DITwMXLgofTcOzDRWhMEp6C9i4G11yNetOddADZb7p7PVmAsgcFevAIc7RjUCqz+WT7K
 eOK0+RABkOjxDEP1rBB9Kn/f7WG1pMFr7yLOr2Y0t42XdtxBY6gPRzyeMMPqT2P3pWG6fvwPC/m
 tNlbbszgK8C6KcbXXlbRkEeCL2MQwqbvwVi77UpeBQbbK+NOoW9lQlS2boVwR5S2LPgC5OGNYab
 PnT/gSGLGRErIEC9nF7XXJrUJXlNgbE+OUFh21R/up04rXEBBWQ==
X-Received: by 2002:a05:690c:ed6:b0:8b0:ac08:d706 with SMTP id
 00721157ae682-8b0ac08e3aemr29323927b3.12.1791996041754; Wed, 14 Oct 2026
 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-6-mark.caveayland@nutanix.com>
 <CAFEAcA9eucRyzG=PR2tpx8ObHkdK6xUmOjQ+-nNbJ2dVHaptOA@mail.gmail.com>
 <876b66cd-0ea6-4943-9a0e-c0abf2ad6e26@nutanix.com>
 <ca07d55b-3a6b-455c-b456-8944459f051f@nutanix.com>
In-Reply-To: <ca07d55b-3a6b-455c-b456-8944459f051f@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2026 17:40:30 +0100
X-Gm-Features: AclHuK9GKZpuJodSpbaJGGjpNEJHf1hmwnQWIYQLstVzf56ZJooPw1UCua58JCI
Message-ID: <CAFEAcA80Rb_TY81bFAu1q33uFL2COfdiH22iw5tkN9aG_gCN_Q@mail.gmail.com>
Subject: Re: [PATCH 05/22] i8259.c: move parent_realize from PICClass to
 I8259CommonClass
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 14 Oct 2026 at 14:58, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 14/10/2026 12:00, Mark Cave-Ayland wrote:
>
> > On 13/10/2026 16:54, Peter Maydell wrote:
> >
> >> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> >> <mark.caveayland@nutanix.com> wrote:
> >>>
> >>> Both the emulated and KVM i8259 implementations store a reference to the
> >>> parent_realize function in their respective classes. Start by moving
> >>> parent_realize from PICClass to I8259CommonClass and removing
> >>> PICClass since
> >>> it is no longer required.
> >>>
> >>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >>
> >> This is one of those things where I think we're not 100% consistent
> >> about whether we think the parent_realize field should go in the
> >> child class struct or the parent class struct. The name "parent_realize"
> >> implies it ought to be in the child struct, though, and I think we
> >> do that more often than we put it in the parent class. This also
> >> makes some kind of separation-of-concerns sense too: it's the child
> >> that knows (a) that it exists at all and that (b) it wants to have a
> >> realize method that will mean it needs to chain back to the parent.
> >>
> >> The docs for device_class_set_parent_realize() claim the parent
> >> realize ptr is stored "usually in the instance structure" which
> >> I think is just completely wrong.
> >>
> >> I could be persuaded otherwise. As usual with QOM/qdev, I'm
> >> mostly interested in (a) consistency and (b) documenting what the
> >> "right thing" is. Realize, reset and unrealize are the three
> >> methods where QOM's lack of convenient support for "child
> >> implementation of method will need to chain to parent impl"
> >> is most awkward.
> > Yeah it's a tricky one. This patch was really just refactoring what was
> > already there, but I'm open to moving it into the instance if you think
> > that is better. I agree with your point about the child instance being
> > the one that knows it needs to chain back to the parent.
> >
> > I'll have an experiment and if it looks good, I'll move it to the
> > instance in v2.
> I did a search over the codebase and checked all references to
> DeviceRealize, and they are all stored in QOM classes and make use of
> device_class_set_parent_realize(). So for now I think we can say it is
> the documentation for device_class_set_parent_realize() that is wrong,
> and I will leave it this way in v2 of the series.

Yes, the *instance* part is definitely wrong. But there's still
"parent class struct" vs "child class struct". This patch puts
it in the parent class struct, and as I say above I kind of
prefer child class struct and think we do that the most often.

-- PMM

