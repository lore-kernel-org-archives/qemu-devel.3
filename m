Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B4C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcsS-0007pX-Fl; Thu, 29 Feb 2024 04:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcsR-0007pK-IJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:38:55 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcsE-00064q-2n
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:38:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56657bcd555so893027a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709199520; x=1709804320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vg0Dou+YTwwjbvHSqh0KnmZ9cWXyF7dqr7UQT/XlNlM=;
 b=L6xZCLecV7clOm3KU4H6Jxi/Z2ngede2ThYZej6xdcN4NwyXDzYUY32ZMCJcXflSBj
 K729Org5xgHXzYz41AJAlDGY4iM9ej0yeUcN8hf/AiISJ8OPm/AB3/Z9oO+57mHbfsvh
 TvsstDVrT8HUe4iCXs/ejEkdqDfGDifwPXC/z2w1GJachdX2BPe3rLSPMKx/nsCV7z0J
 CCAGDP5PhsP2FOWdzq8PSOFJk55SHN/Q5nfNXcqpw1UyerXtGY+/RcLKIrZnASzRFbkn
 JEABdpNQ8q2JXH78R9u25gQWD+mPfziZS5hBkginsymy4flrmyR991TxiyrYfAgElgCG
 b54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709199520; x=1709804320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vg0Dou+YTwwjbvHSqh0KnmZ9cWXyF7dqr7UQT/XlNlM=;
 b=Go350Bm+aE1cKKJwhVtg6bsBI8GW9GPDkFtdYJu00/d9MlWSfA6kbpfvMEp/KoN6de
 gqkEJvFzQh9oXCI2ehVx+hjAZr/mETp2cbzk/0BFVNzfRqdIYlqgM7FT4MXslx4/8Edo
 tQ7w3tzsS6Bgx4LznPPpIFTJozg5vltSQUwEjfeXbnPHFDCOf1uiwNvauAMBgSk7kxtO
 XXJJ4UbJxC+9WAYfZHmKPsBUE9Sx/NbbytTBMI65SBXfd1HxYXLJ0VPXRLHveRyLX3Oa
 CkTXCvCqTV/Neh7vn6Ssuq3d1vT/4LIGILg1YXse4nTc9LZVRyL+1EsBZPYx5Q7Gkg2E
 TvHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoM8x0djgMG+lKOfc0cha2jJl9dM9cqZHUQ0pHIDDqZ8glD2GeCeXt+ufYj0k7gik28iRir95kwu2LQHuoHkRITYHEcqg=
X-Gm-Message-State: AOJu0YwrVsWkjrjO6qQPjoJ7C096ocNCwEDhk1V2+9va0C2YhoaZCv8w
 eYW+pb0XrkbaghW481Zb46EtUsLLFQZ64lM9FC1lu3gnO6iIHmWNVeNZKHZYPTk1Yj/YimCnc0C
 kA/c6bn6CTQ4e5VDXzX7Em9nftpBpg7mA60v66w==
X-Google-Smtp-Source: AGHT+IGNDK6k3fgXjJ/A/fofew1DhSinQ7rr5xKNqvthLqZJxfLMWOR/mPmHZFn7RKwdKl9gsS/SvrrWvx7k9nDWGJ8=
X-Received: by 2002:a05:6402:2311:b0:565:cbba:b79a with SMTP id
 l17-20020a056402231100b00565cbbab79amr938637eda.13.1709199520508; Thu, 29 Feb
 2024 01:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
In-Reply-To: <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 09:38:29 +0000
Message-ID: <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 19:07, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 28.02.24 19:39, Peter Maydell wrote:
> > The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> > which was the first implementation of this function. I don't think
> > there's a particular reason for that value beyond that it was
> > probably a convenient value that was assumed to be likely "big enough".
> >
> > I think the idea with this bounce-buffer has always been that this
> > isn't really a code path we expected to end up in very often --
> > it's supposed to be for when devices are doing DMA, which they
> > will typically be doing to memory (backed by host RAM), not
> > devices (backed by MMIO and needing a bounce buffer). So the
> > whole mechanism is a bit "last fallback to stop things breaking
> > entirely".
> >
> > The address_space_map() API says that it's allowed to return
> > a subset of the range you ask for, so if the virtio code doesn't
> > cope with the minimum being set to TARGET_PAGE_SIZE then either
> > we need to fix that virtio code or we need to change the API
> > of this function. (But I think you will also get a reduced
> > range if you try to use it across a boundary between normal
> > host-memory-backed RAM and a device MemoryRegion.)
>
> If we allow a bounce buffer only to be used once (via the in_use flag),
> why do we allow only a single bounce buffer?
>
> Could address_space_map() allocate a new bounce buffer on every call and
> address_space_unmap() deallocate it?
>
> Isn't the design with a single bounce buffer bound to fail with a
> multi-threaded client as collision can be expected?

Yeah, I don't suppose multi-threaded was particularly expected.
Again, this is really a "handle the case where the guest does
something silly" setup, which is why only one bounce buffer.

Why is your guest ending up in the bounce-buffer path?

-- PMM

