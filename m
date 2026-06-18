Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98461CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGrf-0007Mh-3n; Thu, 18 Jun 2026 13:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.bommarito@gmail.com>)
 id 1waGre-0007MP-1T
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:49:18 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.bommarito@gmail.com>)
 id 1waGrc-0006NY-H1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:49:17 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7fd5346b5e2so21975407b3.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781804955; cv=none;
 d=google.com; s=arc-20240605;
 b=hhVUrowzzb+2m/f+3c83slxZlPwx7BlM7HkU5h30utRCBLe60Gtf1hqAIj3yZihxZf
 7mAuJms2EvYM2IoJIcCdUSekuEu25jdlcVhejTw7W6C35UGA/kmdVcyiMffMffIx28gg
 iSKA7D3O5hvNu3kGgcUOdeXSHcDjlWbz6fDcJAYD9QJiOd5YE8EOdjw1zuQEGd0l57hC
 Dj3WJMRnyjj7nZ9WVUy57IO0PymZOz/9I9/CxHv2XIgUHGvSglkxbjeshoeCSXvVH0cM
 v6Warl1zQoIqHqvdfmb6YY6CJjKLKmvEs1jmsGpMe1kAypm7T0xYkIEiKThca2p42USG
 NLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W3QFLVLX/LaY9CDtPpsHKUKBbekqzThkjUkLBZSOcsA=;
 fh=aIGRJeX88Guh3rQMlKWa8ulQxGF7zrcHMj1vvcRoZWo=;
 b=Ao5JnJZw1CGm0+5yc2BLQ9SpO45Ir52hEHTVRTJysL5B9Q8c3E/Mz7r4WvBgjtVy1g
 w3kAJKzywiCKwByMkTnWU3Yji8/djyRABAN131itr1iie3JWd8Ekq5JOl9Mw2N2cZdfC
 4CmUOMveifxHUQG8r4RbFHfX2QNrio4aaDecqKMNMF4/2bNx1WxtnqQTtv1lry+XBpdb
 IEkKD8MDMYmzAnIRD9KnU9m+ufH00ZhRmpFPbCZVdIKqsTTXW9Hkp7fu9ecx+KDMLG+s
 pS5/aXJyK+pKaPIz9QgmlLD1Z5Dpc3g0xjsm/VWObb8IgNQy3JexWlvJJYU6bddmwW8B
 LSWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781804955; x=1782409755; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3QFLVLX/LaY9CDtPpsHKUKBbekqzThkjUkLBZSOcsA=;
 b=EzqLbucaSybOicUkhn+KNzwpePxZTolU0+pauXLX3KWTBVpdko31P5gM8IlgffoPqa
 ZANvV9rPUIgaOLxDP9+XpOpUx3GC4Bs124Rlb3r9qaK82Mi1PGowf6wmMO3MZ5lzxmo5
 fVGzw0c6blSPwAq2z/f+/z+BCAPsqtw+sFj6h267XcSAqD7Oxe2P+kbEfRtP1DFN9Kxn
 E1uxIbH9kM06//0fJJd/owEpq3viq36DWyxQt3HzVYEycp6s0It6HjhMRWW3h61hbiwi
 7IBxfZDkiR+qWCP2i4LZIniEOtJcfZD3EbUL+wALHQGigD1Aa6YDlpvbyRdbYGQqMO/D
 5ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781804955; x=1782409755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W3QFLVLX/LaY9CDtPpsHKUKBbekqzThkjUkLBZSOcsA=;
 b=hzWoK6tgaGi6QrpjIZlOv2vv3y1oe+XSEurcJDKlYMAN4mC5fTQMwDccVVnQYSKUYR
 Q5VwOhlj+lHVbs4y+y7iYtUPCBfpXJZWsU/Z8QfMVPa6LLEv0RdsKgCSVruBSBVMZF3a
 ugwnpX60jhkXgEq3fmdnTFANqdwzhLIV7IVx/UKYMHS8y0de42YE8L4856NQlR/aK+aB
 lEEeU5/F3g1ZUEdJqcOxjNGxUutkiqPRNmZgvtDOWqN7GXqqwtv+vMkaEegt0qbpAgLH
 Zr0fi2+wqZMbitGQgCGaYJp27aGf1wym781KamZtyqz7K+bOhk7kVWz32IPuySqf7UXZ
 mmzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MWJGlD3YuNKo9gHGKHcJ1dNMPqp9huomVlHzoP5xDd3wndEJiO6T4s4mqBycZykyJ1YfxkL/7z8nn@nongnu.org
X-Gm-Message-State: AOJu0YyDtyX9NL+8xN3JyEcMQXEjxxMs+Ft5AsTBrRuNrVVNOcQDjKDC
 a2X2hfpaLngT1fmXsnnEiVV4okxwmm8jNDPE1yjQvzznBLlY7FHM/3qB1NewBeFGex3t76RlRoC
 3FCjzoqveBo7vYhKje9cBWnhUtr6RDso=
X-Gm-Gg: AfdE7cn3AMxkn6/m4geICSwaatyNaTOBGxUVax9ZjLqGk8OalDZidcrpaJ7rNh8gdLU
 gk9OHuJtWfmsKZRqzl5AeOGFS2HyCWBrF1u8MbabatfHMdpuHSmnSkcBDM5/iE7Msr0vYvR6JPI
 Rm0SeOphS24JDTm7PmNoWnv6ao0Syll5K8DwFiB3WeJeku+U8kiU7YDL/phk/YhATWnaVvkbqSP
 26K7ct8GKVxIgZCjZSxLbDQ8nvv+ZSJMfHTErOhHMHAwyW188EvnGuVR0PuVkFzXxLPIouWYs0q
 7i8m3I2pb/WyInOTdETS+ZwSsaiNq4VZMckM
X-Received: by 2002:a05:690c:39c:b0:7bd:73f3:7a58 with SMTP id
 00721157ae682-801216280e6mr387247b3.11.1781804954802; Thu, 18 Jun 2026
 10:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260617151739.4072252-1-michael.bommarito@gmail.com>
 <20260618152059.GF720244@fedora> <ajQbkHFIMcuA6r-Y@redhat.com>
In-Reply-To: <ajQbkHFIMcuA6r-Y@redhat.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 18 Jun 2026 13:49:03 -0400
X-Gm-Features: AVVi8CddqOTgUJb8jHmeIo3sh1SymAvFs9HSklnBGXtR7N2KKi-FWYaNu-FPGyk
Message-ID: <CAJJ9bXxokyYTkoToTs6D1Jud=gg0zyR7_5-15VucSAtTO8+EpA@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: store the zone-append sector as little-endian
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=michael.bommarito@gmail.com; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jun 18, 2026 at 12:23=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> If it did write the patch, we could make an exception on the
> basis that there is only a single way to write this trivial fix.
>
> None the less the Assisted-by advertizing hoarding should be
> removed before merging, as even our new proposed looser policy,
> rejects use of Assisted-by.

FWIW, the patch is pretty mechanical and basically consisted of sed on
a single function based on conversation with MST.  I told Claude to
make the change, and then it ran the rest of the testing and patch
setup.

Appreciate the policy is in flux and sorry for not flagging that before.

Thanks,
Mike

