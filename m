Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C4CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclvy-0005Mm-5t; Thu, 25 Jun 2026 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclvw-0005LX-D4
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:24:04 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclvt-0008BC-7l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:24:03 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6611669cd16so2788637d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 08:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782401040; cv=none;
 d=google.com; s=arc-20260327;
 b=XUT6quptwDTvuM06TAVjcC/tq6WoNT0m8uhBAzF4WSXkOm7glZItLXjtCpjrL2S3fD
 /U2RD4ndzgmf92I8juhoKO+JmmC6QybeBPOly3EH0AaTPtGIf4tsic9SxukHm42gfhJf
 3ABWksLf4Vzvp44mlhDvVVjKatCbHmLrG2/epBC/MXWhgfyDjTbz9jt1ahTD3KZVI7T3
 9lKdi4izwcxmNI3uTqezXsCwvQ5qnPW2kQLxv1/0COhHUq5+SHnKDa+TNvbN2WBaS9gq
 ja6xVTiIduxg+EOQ8Yh4zQCXHkkH6c00Qr9h6H7SQlo8EhGsAT/MGtuDgSDAIlX1kAQK
 gALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bqc5Wouj3/R29KoIGjvPJ9rd3M6o/N3gDiPFOQAvYeE=;
 fh=80K8lxDFWp1OiDpet2Wi000I+i/nnWvH4zSMND7Oguw=;
 b=KPyOoQ/xsZLF4tZmGuUMaEf65eATcT+1MZpPHr+RP3LsUKI7rZNnmtbBDmsYzRoj0h
 UpcYCvzOjf7+2AwrwGzZH8XVyndjyO1gP+DtFZUc7QBv4VOlKNPqnxuOWF5JZLqE3lAf
 2HxGKwISdH2j4FDHFB8rAntwt72jcQ2k93A0FIhjP9yBLvVvS5mIImshHDJfrpuNTaMP
 FFNxJSdc8TaETZhodbcs+oDIaG26GI1DQEtIz/6to+SrIsyq8DN87Bj0BusrrDKCxUF4
 zH9pjWI3Hsa97oghCQKKxMWHyFEd3AuKImWcghF35m0V4zQ0rUH4XWmgmA9xXjAqWFPE
 Dn8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782401040; x=1783005840; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqc5Wouj3/R29KoIGjvPJ9rd3M6o/N3gDiPFOQAvYeE=;
 b=HqmM7kjqf0fGpwOYLZn3lqFhWkKp8xhVhkPcVkmBcdyrWkbqycTInQYO+mLzUx9cS4
 N/GiuR7hqdXM5vlC+jXeIiQO0qzFSCDRUGL2avMTzxWVTPz6QqBawJ4RgnR0OOhTR8zq
 RP3QAL2ZqYSLz8H7iIFbr7rlaoOOyQ3vkkfSY1YCUvgRAqY6tnOYCTcA43fx/3iIxKzs
 fevwFFkxPYCedSMPDMDfmipnMoFKiR0nBX3Jx9SNRO4R9ilSCnnnMDkfp99M+5VE+5Ps
 rC3B4X5PY+R3q2f96ojPgonayryrBf91Hw/zI9AQbhfkzVn/t4XFRpDZSO43zNRPTlFg
 N6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782401040; x=1783005840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqc5Wouj3/R29KoIGjvPJ9rd3M6o/N3gDiPFOQAvYeE=;
 b=AlrGyuT/vKHjnwxjcmaeVDebL6RzrHmNO8rZo/Z62e3UFfUiwuo/HbYZojsdN500LA
 dnZ1r1u/sfPjPvAlXLQHM9IXgNkAk/heRmTRlbRPdiip3rIbx47n4qTbv1cboSwmv+1y
 TiaCQ6yi5CKMiWrbyHf1L4pr3i4fncJthYpaWDEQsc9uQeVbCnm4KEhNJYatE+WXEcIF
 4E1r+MjIJCEhfqQJVTfdDAhSo0yi3/6YYZDcgywYQjFvMYj1K7HUjgKh381ZrozLHvfu
 6W/C3tfbb4vxy26G04ByRwHg7H7a4WXMSj6JnFivj43bSQMVvKpsuwYXRihNecr6Vku1
 Yzrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvVk1NLl0KnelY95ui/Wl4PPD3E31GqKHbFDjyTPYfOzApZhum0Ujpdcbiz7ZwBAOnKfhfurwL/D5Y@nongnu.org
X-Gm-Message-State: AOJu0YxwStAcAMEoYoGEBn/Jdrg09l2AGpV/1/O/N9EXVmR0zGRz9oj0
 RGKcmuiJ5dqlSqZd95rtOhKv9NvAyYNuzY0novu4XoNPtSPrV3mlz0L4H+unsoLIAL10f8d0qxt
 DB6tYZx96WF31GG82RoVp/LBZyLUkuUzPBtE9mXf/5g==
X-Gm-Gg: AfdE7cnfuaITSGwappEeiIsnMC178KUBVOvuVJRpYX+62wkblp/wVqgLtotsaGWzjsq
 CM/HoRj6n3xXUmiBYIIYp5eY25D90gjVeC/GPhyVkGpvDnbdnF+UK8O0fSDvFQvWi/S5qnT5uOC
 krPJFnER13yfYOqOHdNZGYYkvyNUuClFexqD9NdPEvqJs1fryjwv8cRNzfsjwhLTkeR7r+VxC5Z
 SPRaqF4R77eVIEsZHOG4w32GgJVUPNH4itXs/mIiueLSSKKmDKkGQkGXAVI44+VxQQWL1ci07cL
 +MBUzkE1bayG2/74kp9HodNuSvt1p3ZptmWh4m386BBDHIx7867KRo0x
X-Received: by 2002:a05:690e:13c8:b0:656:30a1:70e2 with SMTP id
 956f58d0204a3-66487b36261mr2298408d50.6.1782401039812; Thu, 25 Jun 2026
 08:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260625101817-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 16:23:47 +0100
X-Gm-Features: AVVi8CcTfQ8bSXrsW_GWrobYdcAF931uZMAOr09cHRp0s4EaJ7pMxXFgpbvs2PQ
Message-ID: <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, alex@shazbot.org, richard.henderson@linaro.org, 
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com, 
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, 
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, 
 shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 25 Jun 2026 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
> offset 0x1 within a dword. This maps nicely to even classical PCI byte
> enable mechanism and so yes it works if your CPU can initiate these
> things, and it's atomic.
>
> I tried reading LEDCTL on e1000e:
>
>        byte  @ 0xe00: 0x64
>        byte  @ 0xe01: 0x2a
>        byte  @ 0xe02: 0x00
>        byte  @ 0xe03: 0x00
>        word  @ 0xe00: 0x2a64
>        word  @ 0xe01: 0x002a
>
> Works fine.

The e1000e datasheet actually documents what it does in this
case (slightly surprising, since hardware engineers love to
leave this kind of corner case undocumented):

# For registers that should be accessed as 32-bit double words,
# partial writes (less than a 32-bit double word) does not take
# effect (such as, the write is ignored). Partial reads
# return all 32 bits of data regardless of the byte enables.
#
# Note: Partial reads to clear-by-read registers (such as, ICR)
# can have unexpected results since all 32 bits are actually read
# regardless of the byte enables. Partial reads should not be done.

So for this specific device that access is out-of-spec.

I guess what I'm wondering is: can we just have code
that does an aligned exact-width access in the 1/2/4/8
byte aligned case, and the host's best approximation to
an unaligned exact-width access for the 2/4/8 byte
unaligned case? (so on sparc you get multiple smaller
accesses, and on most archs including x86 and arm you
get an unaligned load). That would mean the guest could
potentially provoke a fault on the load/store on an
access to a passthrough device, but if you give the
guest passthrough access it can very likely provoke
a fault anyway, depending on exactly what the device is.

I think the most likely reason for an unaligned access
in this codepath is "it's actually RAM, either really
host RAM or else something memory-like in a BAR", and
either way if the guest does a 4-byte unaligned access
then doing a 4-byte unaligned access seems better than
second-guessing it, even on non-x86.

-- PMM

