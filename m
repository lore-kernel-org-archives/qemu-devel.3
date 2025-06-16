Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA7DC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 16:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRCzg-000334-6P; Mon, 16 Jun 2025 12:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRCzQ-0002zs-7T; Mon, 16 Jun 2025 12:47:23 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRCzG-0004ww-78; Mon, 16 Jun 2025 12:47:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6088d856c6eso8291871a12.0; 
 Mon, 16 Jun 2025 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750092425; x=1750697225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NlGJYX88Jt0iA1lZrMOkU/zbEj0+MjfVGYXd0wcFU4k=;
 b=Ksg15kIZef+/5Xzu9hYqvo0v0nnvBpseRpySLhAHPZpGstui9zB4RLv0hIYV+QXHkA
 GpEf6CM5c38MNyu5xty8gDd4cbx4EUkHa7noraQ38K1u8U9SUygql9VzM4hgmh15tvrJ
 g63xiWk6464iI6UJiWem32JHQMncg2Q7IccQzEB27Zedyd6Ck9PQMamQP7aiOppnw8U7
 ggynk0wOJVvJ3xmxcdm3gsy+VBG4TqXPzKZfMACYF/s8LqEMxNr6aVKQT9mm6g3mEMiX
 Hqg+mC01bPQqmiCKGRfOXMUuUymV/CWCUplCmkh4p8NvClpnMa7S12dZe72qYyxAbozs
 30/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750092425; x=1750697225;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlGJYX88Jt0iA1lZrMOkU/zbEj0+MjfVGYXd0wcFU4k=;
 b=nsE6ZKSb3yF7RJByznKNOGhqmvz+hXWvLNhb/XpQKdOIYQ395kQCBEjrfXNz0t1cGY
 hAv81l/XAA7Zy5eW4NrzQG546o6bB2ePp7ELFfEDjSBYiPc/JnBc3PbL25WNl02+Y+Ox
 dIQZxTVy89BNws05MVpqCjowjNhVUvyMfYV4UBgIvZkTnKNzCekFbFaZCWMpQ8COiDlt
 Z/bZXVJ4y/AV8kR0Sd+8VsdDw5PeCVFHfSGicqwD6RWhgniGkJiru2XhmoO34rDvE6b4
 ej9Z830/8ueSDvSjwdu5USFGqi582FjvbiMsaK/FvGbHXALrHqp8JoG4gxdgDGAwXA4c
 QF7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVmWunzzJ2A2eq50C72gELwfRvE64V7cN+9m6JL6C2cdDp1wdlWDXbb0geetBuvRg5AL34gbWttX0=@nongnu.org
X-Gm-Message-State: AOJu0Yxcfs6YPHoYEV+/BwaYv5axWEJitAO3x3XRmzLi9bspMN6TLr+9
 IUax+ojotGPp+Pyfgcpf3tztk6CNxmmjC4N+6FUW/63uimD0V/9IzI399tPaiWlGB4DteabJsmQ
 gbH2Rh4g+jUeEPmRQafqJCzsuCCKy6Gc=
X-Gm-Gg: ASbGncvcZEipMF3BpeyiP3gZkJxi7vhoh40vHAHAlxU9IHtHlyXTpSQI2/uL2kd2wQt
 crdltqNtveNxRbev4HLI7IXuaCwkkbqpwNZPs5OaOdurNXhyhPrP1cyutS9OCiUWOLKN+Ngx25o
 iNpMvPSvmYEWiTLXKzLQdHW6KuTAMQJ2bWi8aNL4dWeg==
X-Google-Smtp-Source: AGHT+IEEmPbH7SnJzNQiJsMegruRYnPMODq6uw/DrT6vK+fI3ES2T4SilLkQVwrhBtjEQe3lHBenfUgfmSiUaXACxSM=
X-Received: by 2002:a05:6402:2686:b0:607:35d8:4cf4 with SMTP id
 4fb4d7f45d1cf-608d097966cmr9252854a12.25.1750092424908; Mon, 16 Jun 2025
 09:47:04 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Jun 2025 12:46:53 -0400
X-Gm-Features: AX0GCFvNS8F0hDQWQHWxUJxeCSwVTA5dcVepKhj3KpyKHQY-zk1jCdjP58Y_Cns
Message-ID: <CAJSP0QW-3ibYSCL0jYyvm1eADp7fKvLgorGWEk8WXW4SMGfaJw@mail.gmail.com>
Subject: New CI error due to mismatched lifetime in hpet device
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Paolo,
The CI is hitting the following new issue in rust/hw/hpet/device.rs:

error: lifetime flowing from input to output with different syntax can
be confusing
--> ../rust/hw/timer/hpet/src/device.rs:770:15
|
770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
| ^^^^^ -------------- the lifetime gets resolved as `'_`
| |
| this lifetime flows to the output
|
= note: `-D mismatched-lifetime-syntaxes` implied by `-D warnings`
= help: to override `-D warnings` add `#[allow(mismatched_lifetime_syntaxes)]`
help: one option is to remove the lifetime for references and use the
anonymous lifetime for paths
|
770 | fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
| ++++
error: aborting due to 1 previous error

https://gitlab.com/qemu-project/qemu/-/jobs/10338038013#L5165

Stefan

