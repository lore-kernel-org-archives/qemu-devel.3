Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A8C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4FvL-0005TK-KA; Mon, 14 Apr 2025 05:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u4FvJ-0005So-1P; Mon, 14 Apr 2025 05:16:13 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raman.dzehtsiar@gmail.com>)
 id 1u4FvD-00018h-UJ; Mon, 14 Apr 2025 05:16:12 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5262475372eso1730850e0c.2; 
 Mon, 14 Apr 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744622166; x=1745226966; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T+xDIeBKdKGtaSBa2J+4Yo6+ws0SrTNp4I4rgaqYoi0=;
 b=WcFmRwFU5V+GYp4F0OMKYMXE54VMhRYhI3zqka3Tu7ge2GFiyor4H8rD4Ju8ThgxmZ
 lLV2zg8CuerhIVGUpMM5rIQcX2vPZBagG/CIKJABeHNrlKXH8VkodV4+Nx0aKzzbX6Xx
 5b5lKZNLoUtTs9G0e6Alx0RbZLW3DK8tSXsamaA1eUyJxOnjTy3PEBLaOLdDGighbOZu
 p35uXym9OJwgZLZkzSQCC01FkPC3GM3v+A9AOCF91gAYR9pWxFnIuzLClHOcFnJJmjnv
 zwNyT/QNeC9XL0+hukR+z+9RFcbA8ASJ557eof53gloChM1jH71N+rLOsVNkPmZ7QJBx
 8Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744622166; x=1745226966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T+xDIeBKdKGtaSBa2J+4Yo6+ws0SrTNp4I4rgaqYoi0=;
 b=Nw1nQJ+lNekWx2hI2CqjshSAcq4wBnqqf/fWENou8PMZOFOAFEJvqNRALq0bf/Fo1H
 8iNHfMHUkZ+KhKdUFnZMsry+sw/OdA3c3RAfFVIDHRCw6gI8VSvwZOEheslphwHOVm3q
 Yk6B4KpILcKJ2MTdLDrL1hINOojYt8pNMcKreoofYTu1XabXni8EIKaIhy/cbvJEAGww
 e2xsfYqAgO5oMCTtU3q5RxUg1k4+m+Hm/q0p0/+jbbHI5seOptK0hm5m1U4jW4pVB4I0
 P2b3fzmPOWlviA64rc1/pOI22j7FGbPQnA20/vgRuy6H/l3XNSh0xdKxPYJOu6bWRcAx
 l8uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLhN5xqdTuKFUbRKKd6jsd5W6iq9Lr5cJRbfbD9pHR/OYgDJ479QSyNnXcUch1AZN62R4gKjrUPvuJ@nongnu.org
X-Gm-Message-State: AOJu0YyJtZaoixPpPVzYlWafrG874WMCc79uuzPSaDzd33cYXNo+xIqy
 KxwfPyeOLiIlWRHltBmT2lyjPHEmaxT31fbBlPP6xsEucNgs9WaopxwUg4juHDgWFIcvy4mjFtS
 WN5YWcWck82ohLDGK/LrlzAF8Vxw=
X-Gm-Gg: ASbGncu2pUJdV95XGwsvJJanGsyChazozR6k9xre+w4KZ0N9Cf7Pi6Uv2Usei1xlR/u
 xgMe3Tl6gpDckMDYmkpaXYvzWmL6d0TXLqtdYwZMj4tKEodzTOsBkpIFBQaC5/i+r+wdiuvA19m
 HTLtnlORhX07nUAZcmnd/s+Gm/Z/ZsQAZL
X-Google-Smtp-Source: AGHT+IF1a8L+5386RekavNVcjDFeMxdzRgy5LMDChaW2zUpge9mBsqb4QnOotb8UFPzdb+dE/nF1EZ9syGcKJYCPETI=
X-Received: by 2002:a05:6102:5799:b0:4bb:b589:9d95 with SMTP id
 ada2fe7eead31-4c9e4ec1211mr7372480137.4.1744622166216; Mon, 14 Apr 2025
 02:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250414011817.671328-1-Raman.Dzehtsiar@gmail.com>
 <87r01v1gcz.fsf@pond.sub.org>
In-Reply-To: <87r01v1gcz.fsf@pond.sub.org>
From: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Date: Mon, 14 Apr 2025 11:15:56 +0200
X-Gm-Features: ATxdqUEaHn9SeKu-0RPJEWV1jFaQzAYQ-_B1YldHd81jPACJiaJzF79KJnixLnk
Message-ID: <CA+uc5a2V0-3RXevBKdwjVj2Q3feoTY3Exv_GAMgMJAHM2aVMYA@mail.gmail.com>
Subject: Re: [PATCH v3] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=raman.dzehtsiar@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Markus,

Thanks for taking the time to review this patch.

[...]
> > +# @on-cbw-error: optional policy defining behavior on I/O errors in
> > +#     copy-before-write jobs; defaults to break-guest-write.  (Since 10.0)
[...]
> Scratch "optional", please.

Good point. I've removed "optional" from the description.

[...]
> Also, make it 10.1, and keep the member documentation ordered like ...
>
> >  # @x-perf: Performance options.  (Since 6.0)
> >  #
> >  # Features:
> > @@ -1641,6 +1644,7 @@
> >              '*compress': 'bool',
> >              '*on-source-error': 'BlockdevOnError',
> >              '*on-target-error': 'BlockdevOnError',
> > +            '*on-cbw-error': 'OnCbwError',
> >              '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
> >              '*filter-node-name': 'str',
> >              '*discard-source': 'bool',
>
> ... the actual members.
[...]

The documentation entries have been reordered to match the member
list, and the version tag has been updated to 10.1.

Both issues have been addressed in v4 of the patch.

Thanks again, and kind regards,
Raman Dzehtsiar

