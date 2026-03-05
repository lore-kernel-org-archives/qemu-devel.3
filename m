Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF56F30920
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4xt-00035r-IT; Thu, 05 Mar 2026 04:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy4xr-00035Z-UV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:25:51 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy4xq-0002FH-Fs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:25:51 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso6753017d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 01:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772702749; cv=none;
 d=google.com; s=arc-20240605;
 b=S+Z4BzJtc7fhPTVWVdg24t1jblBTAdsAe4fsRmIdZcwTayugw+7EMwxealNvi41Lj4
 tqJ3pBiYJdHDTtlq6n4NIpoW/YhL29LINZPZ328txEPDhrx6ID3b6Nv8DYxT5OvNWpO3
 8EIs+ZigB8LaFmlDG7HCNkOgIHq8I1lbX5Q9iGTpTR4SvpyJO4d0vMUE8QyRYGaYaTKE
 zJZdIyji+bQwZSZUVBanfiNpD5ChWc4IQM5Ol4+CaxXkMJk8u5tCU/CUJFRz2dxkStII
 FDM/WSv0de9sYuKn/9vIMH6+l6iYQ0VDKpJEHLTWE1ZqGJvOX08ypblfar/H99ZEUe4+
 gojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zwa9DTugguEpzWLeMIHXbG6QY+oogAZV3B57SvCGfV0=;
 fh=NIHYoW8kbnpHbwO0XuMPul02eH92tONrrLBR6XRAneg=;
 b=FYkDnnN3CCa7HOl5tjYKXD/e5111h+jKpOg9/jlp/M4f/ZrPoUXe6M8kzj4pjf0CBK
 Ln6y+aiyxudtCosCRhQkShizlqMR2Jg6w+94bP4I8ko1bKs2QDAQIyH9/X+/uFOrbi1w
 21/ypKjYWCiE71QJkoh3JLiN5ZeQymTxqX1deK5MU6uWKFizDMU9q8lrBmCC+VHpSfUd
 cwXfTmYs8jFWHiq/XvC+mazoujlzaVaViO/bnEPsyfFERrJXj+/iWl3B5KXcvbBPfLxm
 n5bCc6f3C7nkoi/OrBACcxiqz+8Ks1eVU+c+UZ02G0fuMXY1lhA1bnSI6FZyefDp/rXN
 WPVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772702749; x=1773307549; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zwa9DTugguEpzWLeMIHXbG6QY+oogAZV3B57SvCGfV0=;
 b=v10PfJ1KddtoYzoDSryMFV2Vl6tdSiwpYqy2oP/U46MjJoTJe4ArlW1F1ZgZK/PKyB
 CqwOPQ7CXgjOvhYMVFaKxKQ+D9wCatWvQZSTyXKomDLYF0+CbcNeaJnG+B5b43szX+bc
 bY2Eeg5vJ3zls/5E+wNEemOk6DOa8hetGxYlLbSGw9AuAGP0c/j0MQvnXkXhXUtRW4D6
 NA4t7ivxJxISrLCTTE87n++lude+gmuPhxEgucT1ijWtxkz6NDLcdwdO5B1D03a3YYLj
 VPJeGTyzQcgL9B7CO3ewlLBG1R7nkwoBTyM7v5/Op2F7DGInGKm5fk8CxG9oRgO0TNWG
 5aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772702749; x=1773307549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwa9DTugguEpzWLeMIHXbG6QY+oogAZV3B57SvCGfV0=;
 b=Xd5h9SdoHr7f4hSBRUte68P4a+qPTlMJGWdU4Badj4NcyqrbY8wK5EmgVpyv1e7kOM
 f8LDXNKB6+9N0sNlVoPENqe3Ml5uXRlyYP1aICUCZM8ARXNYfu0qynk56SgrMkKxd5Qx
 G2jnY9j1AwEiw2+0EowowcUpwldwlipiniRAO9ks1mWxJjbbaY9fKT74N8zkV85rdMd4
 BVza+rpUuKLT4oWXjci4NUXr5had5ETWyxjxL9ZH6ygj7lcPx1KxhykYDjH+/0nwmvlC
 gBNTU8DLfWpHHvRmG+rJNGl1DyCHpQbgFjT78fY2l8GzKvWHpb1bs4mbgIMIK0Sla+PO
 VM0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdqDwHuOcmKMa0EqUZYnnguYpikRCM6OGgXzCNFj7/BRQrrLWxVg3Rv+Aqgme+iWgFqF8uNI2vWzrS@nongnu.org
X-Gm-Message-State: AOJu0YyxjZcalt1+FqSp1asYHuqX9GMe9umMZ1slG5y5RDo1QtckMzJu
 APw7ePmMjPsJay07cAJgfMFc7C15Q7jWa0Ljj/SWcDmDUq5oevJuwzLNRa3PPzvB82+mSWgz2ey
 l6EAn8ixNtcTXxAYWEB2G4YAhj3Hcyssnq6RMzJGj/A==
X-Gm-Gg: ATEYQzyXGh7Gtt4Cr++fdy5F22Wx32x193hFo17+wIiTzKoBo2rbxU8fS0Pz1SpzMDN
 DRtkdfoHAQllTTqHdZPsSgNczrzybcktXZMJq4l6F+p6pT9dNv2bb7MCQqdRk7FxRfGrSCk2s4M
 A4/Jfu0aI3MGnttc8H87HLUqmPdPHR/GMeHunddv9jx3qZpsR3nEZ7Ri9dKl8D0H7N1zJhM163+
 LK/cNmP56RHm7BbeCXFGcGfbSgYvj9dW57sAsqb4cF+VQdtnOf2jqYiYOSne8FFh3Jnl09gaIKt
 cY7d8T6l9c9jUgStkh3Ymq9pG+eigJfv6BTJ+ixpaXnUqnH1czVj17biFiXZiKaMqG0=
X-Received: by 2002:a05:690e:1209:b0:64c:a41a:3a64 with SMTP id
 956f58d0204a3-64cf9b6f9a2mr3923070d50.34.1772702749059; Thu, 05 Mar 2026
 01:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20250501230129.2596-1-philmd@linaro.org>
 <20250501230129.2596-11-philmd@linaro.org>
 <f27ebed4-b926-4c74-a61d-575eade934a0@redhat.com>
In-Reply-To: <f27ebed4-b926-4c74-a61d-575eade934a0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 09:25:37 +0000
X-Gm-Features: AaiRm51zVA7MAG97luoQwb8vy-oKIBsYlJq8iV-hXBHO3qC6Jg1AzOXlEZqQRQA
Message-ID: <CAFEAcA-s661UdPYhMkyZY0z-9iP1v77wC3b3pTHZn7mhetTP=Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] hw/display/vga-pci: Do not expose the
 'global-vmstate' property
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 5 Mar 2026 at 09:17, Thomas Huth <thuth@redhat.com> wrote:
>
> ... and we can't remove the remaining global_vmstate stuff since it's still
> used by vga-isa.c and vga-mmio.c ...

Unfortunate in hindsight that we didn't tie this to versioning
for all uses.

TYPE_VGA_MMIO is used only be the MIPS Jazz board, which is not
versioned, so we can break migration compat there and switch it
to not-global.

But TYPE_ISA_VGA and TYPE_CIRRUS_ISA_VGA are both pluggable
ISA devices -- since you can plug those into a versioned PC
machine, I assume we can't break migration compat there ?

thanks
-- PMM

