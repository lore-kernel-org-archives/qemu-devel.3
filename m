Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75EFFD0060
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 11:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vweqh-0001d0-Mt; Sun, 01 Mar 2026 06:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vweqe-0001bw-OR
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:20:32 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vweqd-0006jn-B5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 06:20:32 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ae222d87dso3113488d50.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 03:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772364030; cv=none;
 d=google.com; s=arc-20240605;
 b=FLslQpqJ/mntMB3hDgLrJecxZK4ZDgeduglb2r4A6WS5srf0VyvROJiVMMKLlUTVff
 eY1oCI0W6OLqe1oXhIwXzSwaYZEfF4DmXw39ho7UbhPjtLfOUq8h7GIB71YD66o4J+un
 hqRxa7Kom5KvgqyxAo5keUZOIdItc7kAX4qEqAXW6uz2pcRr0DzIXMmkB5ImZt0fxwl+
 e6Jeh/eQLkYQut63wJ7dLtqsN7hhULQXxIiS4rn7nN4qL3DfgNrAZxHWdFleYWPP9Uof
 sYOg4Stf4WEcOC6iy0XVMwq/xPNw5dt3LFlf9SGcbY7cwc65LfRLJYkTELlT7zFOlsZt
 v/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u0OC50M/eU9NhHKmtF5wNw/gExCC+jUUoC4CwU1/3Mg=;
 fh=HTd5+v18H+4Ybt2dnPc/LrWNq6zDmxuvN8qpDKSH1eg=;
 b=XLHis/LhK4fZNluOE+g8Vwx/MccSmVmRTC0QMrB1KyHsw/i8appblh+PFmx3RV57+5
 rGqAu3swMgVaKejMxdDwHQBXpLkdv2FoLfaGho+wGsrZC8HkUVCe012X0j79GBADpkDY
 LpR2H/alDj0zKlyQmPcwQErnHyoyEH6KQWSNDG9ddLVEvxIoflh7cJNskUr1j+UNTowN
 7jQ+uBwyH7sb6MZSGQoxlwfLw3yhMV3+XZXmPp/hS6iuvrNGXSroxYOGo4SsLL2ro7KR
 MBqM1Adciwwni4A0+9Y1OU0RRujHsKPC8jr1FH/MKYEAAqZnH62uWpuhdMOU+MbIWf1J
 uxwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772364030; x=1772968830; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u0OC50M/eU9NhHKmtF5wNw/gExCC+jUUoC4CwU1/3Mg=;
 b=mUYzv5MA4MAXLotcY/4T4zkgcZ4f8Jqsj8muIvuOigeuTJ8XCBRPUP9oNMJYApicCJ
 zNGJUxZ5LFj6TDpL+2Qw1h9nm65MMd35OYUV2emBbxRjoLEIPupzkIvIrEGyMUZD4XOg
 tysK3vjBPAfZUKbB0BTsCO2K+bTQuWrGCOs+lErS4ug3u6OEj2VgXgdrh1v4tXd9kYrt
 rht2+aMjHR+AtNp7ZIcuObzDlN4p/sNXs4siuKV9xuVp4qMsGnFNhtl9g+ob8XWUT/LW
 xWxL+w+fhSQN5ys7SEkFqdB85qX1FwkyawHt6ANkTI2QxGH46fVmPdmnc1d8z/dP5pMt
 Wlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772364030; x=1772968830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0OC50M/eU9NhHKmtF5wNw/gExCC+jUUoC4CwU1/3Mg=;
 b=k9/+bpQ3chCTKUsdQNG9gDmk66tk/JSNGeoeoPmFPlV8RQh7OIbgqwgRttvjnU1Dmk
 83z4U67J/ov9+rJK3Nqp6dg912gG/HBJvYYGTXH7ST2vW+wLiPzdO3gRonj4OYo25SQd
 b6AKqKJHbHESE5Mg/628Gr8pfvPyk7lBskKRLIXXn0+SQj+4HBUC1Y+cuatWCzbzJ6Wj
 T6KvGgkp0XHfc5po62jnHv3JEdQrfuMd1Yf4fC9ViczgRk1G3Fok3tK6FaHZs2JzfSBN
 WlJSRYpke05WAlBYSefAw117V3WHYpFPaS1y/NCE5mRGgvQ76FmcRPnsZkkPKc+llD6K
 7ILA==
X-Gm-Message-State: AOJu0YyNqVFTuoQbaRVR9kDOMZll0Yg/8+bUk+b7cFvous62oUbjo5Nh
 Wo1dNc1VxLrCB9V3LE1WNNmK+l3GkxVJBL8ttQxvHump/Lr6GKbJQ1GuUr20u2595rEGriaNrnE
 0RUKaEkAUv0PytMk9UvmGFUz9HMA5o0rgsaAF51rreQ==
X-Gm-Gg: ATEYQzwvT37vL4Sg0n1xul1qa0b5Yeaoc7duoeC/JXGbPs2DhOCU8W7F/NDpmtuLrfW
 tNfh/58fiqw508rdXd4ljJxAdto5bnaRNa7e3XIdaIMXnZ/FYZdv2CrZ6lbrTVkv8HaaYmC1gDr
 0dcfj6PcfU800/zzdyYgSmWgDdETJD1m/XMVLIEUItwy9gKnKnoosSpmCqTA1jI2hn3Vn/8SNSi
 zLSZUBACwivEvvCBl+WmstdE5LmD9ZqqEj4G2EWbVI8HgQjdLQQRuoyG+3YptJ8HVASoRLiFVBP
 jw4Fu3S9DfZ3CBgjzqlS/ihVAZju4KP2iICOKrsO/m1t0bEpMUsZaMT9eSMN3JcAeMMs00sVAR1
 5Ag==
X-Received: by 2002:a53:e1d1:0:b0:64a:d80f:5cf with SMTP id
 956f58d0204a3-64cc20cbc7dmr5884295d50.25.1772364030191; Sun, 01 Mar 2026
 03:20:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1772285406.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1772285406.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Mar 2026 11:20:18 +0000
X-Gm-Features: AaiRm527JnNUp2NB6v1vWAZ_V1fhTqW-C37rz-rCvZJrjxJ-KDVEXVGokTZGHWI
Message-ID: <CAFEAcA8v3Fo8figVfbedzdJF8FSMGYEYMtUDNy3oYHPO3mF3wQ@mail.gmail.com>
Subject: Re: [PULL 0/2] 9p queue 2026-02-28
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Richie Buturla <richie@linux.ibm.com>, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Sat, 28 Feb 2026 at 13:33, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe3e:
>
>   Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into staging (2026-02-26 16:00:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260228
>
> for you to fetch changes up to b72d15f47cbd2fc93580f33fa86a7e23595a68dd:
>
>   hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver (2026-02-28 13:46:42 +0100)
>
> ----------------------------------------------------------------
> 9pfs changes:
>
> * Fix crash under unlink-heavy load in v9fs_mark_fids_unreclaim().
>
> * Fix crash with the synth fs driver.
>
> ----------------------------------------------------------------
> Christian Schoenebeck (1):
>       hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for fs synth driver
>
> Richie Buturla (1):
>       hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

