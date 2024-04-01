Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC2CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMIy-0003ZA-Kt; Mon, 01 Apr 2024 14:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daleyoung4242@gmail.com>)
 id 1rrMIw-0003Yt-DP
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:22:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <daleyoung4242@gmail.com>)
 id 1rrMIt-0001qf-TX
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:22:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-6e704078860so3664220b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711995762; x=1712600562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRuomK486jWOfc7CoAmClPNpZEdWkNYhtNlurldJV64=;
 b=TbiYr7y/jT0vav1oKesdd1dKCKeoGNRkgx/vDi67zL3h4xBBOFbb3BFD6eHHCYN1hv
 IQR4fvlP9Ucru+2Lk34uhXIzDXFT14dwXQx76igWnocAO27x/O0Y6icPos0rKaSkksEd
 rSCfnXMOEySlI9y39yJkGfAw396w8sWwFG7ATV/kE6KqoP2e0A+LuSrZCrGAH2VAQA53
 2OWZTIYUVHvg8QqJ/CDdE4lXN/Ae89bOgB3ohIzYvY4o/hTFzBMMuV+HZeHWLyjHMZSq
 T7eRXasEsXxThWPohD7aQSuquysT7LTyabgzSE9bc3dzxmJcciEJhlLS0hBuo4XEJWVR
 LRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711995762; x=1712600562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRuomK486jWOfc7CoAmClPNpZEdWkNYhtNlurldJV64=;
 b=ThPlZG3yYSGK77WbJVBfKhLNc+52ghRZibBTwCE2zM04TomTQk6IcSdsjNBeA3af6q
 WahxXmBvqne6KY/lJNo4ysj8nz56zFAtECaYa2P/U/R3WijuyoM+URUgrM/Wjc3Qq8nb
 2zRX7iPXhNaupa65/PYaxbbCgics+DtdC0K31ApC7x9ki3uOxnytZ6wnF7EsF+TPsbDN
 vaS2NoExYet+N8tIfChEx84YuPaN9p5Sh/djjrKi0HACp6Nn7+MJ/ARE9InsrssrLYVB
 33d9kdykoKGc7Leumz+6ZRKkqziFtA/fJt2uxKKimYmdo5kKFbJMffRwwiTE5zTP4Yq4
 6z+A==
X-Gm-Message-State: AOJu0YyWopEO8AboA1Z1qJWQuDvKBKZeNwejExE4LKB1sBBDQ8qhgJSd
 GJ5a8ITAxYf2SL6IlLBWHt03r8+4zyybQSeOW7dMbMLyqMvsSWdGF5aYYylMPxI=
X-Google-Smtp-Source: AGHT+IGIvNAAcVXf1iSGJkyYwRV0U78/Q6lB7wxI8PJ1z3yYcjCmNoBaqLOFbr0cD3uVybB6Vlv+IA==
X-Received: by 2002:a05:6a20:2144:b0:1a3:72d2:c430 with SMTP id
 z4-20020a056a20214400b001a372d2c430mr6743819pzz.51.1711995761801; 
 Mon, 01 Apr 2024 11:22:41 -0700 (PDT)
Received: from arch.localnet ([142.171.174.14])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a639512000000b005dc49afed53sm8117791pgd.55.2024.04.01.11.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:22:41 -0700 (PDT)
From: daleyoung4242@gmail.com
To: qemu-level <qemu-devel@nongnu.org>, Sahil <icegambit91@gmail.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Tue, 02 Apr 2024 02:23:11 +0800
Message-ID: <10693205.CDJkKcVGEf@arch>
In-Reply-To: <8390729.NyiUUSuA9g@valdaarhun>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAJaqyWdhsXUXdP+3GN81hw9tqccy6+3=WVvigxu2yU-8F=x04A@mail.gmail.com>
 <8390729.NyiUUSuA9g@valdaarhun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=daleyoung4242@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On Monday, March 25, 2024 21:20:32 CST Sahil wrote:
> Q1.
> Section 2.7.4 of the virtio spec [3] states that in an available descriptor,
> the "Element Length" stores the length of the buffer element. In the next
> few lines, it also states that the "Element Length" is reserved for used
> descriptors and is ignored by drivers. This sounds a little contradictory
> given that drivers write available desciptors in the descriptor ring.

When VIRTQ_DESC_F_WRITE is set, the device will use "Element Length" to 
specify the length it writes. When VIRTQ_DESC_F_WRITE is not set, which means 
the buffer is read-only for the device, "Element Length" will not be changed by 
the device, so drivers just ignore it.

> Q2.
> In the Red Hat article, just below the first listing ("Memory layout of a
> packed virtqueue descriptor"), there's the following line referring to the
> buffer id in
> "virtq_desc":
> > This time, the id field is not an index for the device to look for the
> > buffer: it is an opaque value for it, only has meaning for the driver.
> 
> But the device returns the buffer id when it writes the used descriptor to
> the descriptor ring. The "only has meaning for the driver" part has got me
> a little confused. Which buffer id is this that the device returns? Is it
> related to the buffer id in the available descriptor?

In my understanding, buffer id is the element that avail descriptor marks to 
identify when adding descriptors to table. Device will returns the buffer id in 
the processed descriptor or the last descriptor in a chain, and write it to 
the descriptor that used idx refers to (first one in the chain). Then used idx 
increments.

The Packed Virtqueue blog [1] is helpful, but some details in the examples are 
making me confused. 

Q1.
In the last step of the two-entries descriptor table example, it says both 
buffers #0 and #1 are available for the device. I understand descriptor[0] is 
available and descriptor[1] is not, but there is no ID #0 now. So does the 
device got buffer #0 by notification beforehand? If so, does it mean buffer #0 
will be lost when notifications are disabled?

Q2.
If I'm right, the buffer id of the first descriptor in chain will be overwritten 
with the last id. But in Figure: Using another descriptor chain in the last 
step of the chain example, the buffer id of the first descriptor (4th in the 
table) in second chain doesn't change to 1. Is this a typo or I'm wrong?

Thanks,
Dale Young

[1] https://www.redhat.com/en/blog/packed-virtqueue-how-reduce-overhead-virtio




