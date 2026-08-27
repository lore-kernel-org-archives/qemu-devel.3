Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D407DC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wze7s-0006Tn-7r; Thu, 27 Aug 2026 13:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wze7r-0006TO-0Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:42:55 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wze7p-0002rw-Cr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:42:54 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-857ff9fef54so1204457b3.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:42:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787852572; cv=none;
 d=google.com; s=arc-20260327;
 b=gQkFLhELBY+cRTsE102dtje1ABpAClw3JxaBkQeCiw8OKfyJYeN1zCwt5GHpJYuS79
 pRWHUanJLApYAsUzxEexVPbJ/2dDVg92vLmZuNkb50uvOKFePVvzk05KU08C8+pGm1Ry
 kz1pnKL+6UKWD5AzN3b6dIrBLsAo9n+qz739yVzNBrXt6+irZQ0o0PGpidoZSNH+/dJ1
 bosLU+3xoM008XWCbhTJqEbT+Y9gyYJQPHjyjoPIo0MZnsjQb1Szj2k1ImG3LjCt+f42
 x6odayPUTNDZ0ErcfRDhOA43GOArrE1n/unDB+FZDWLDEdmWfvzye9V2TpeWHz5oe2RZ
 7qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mHfCUFStXRQs4Vxp/BYAOOICbf0Ocg/AAwvAD3GsPxg=;
 fh=zEdtnl1BadywD4Mti+tSJF/WIon03KmN+k5aXWuofHA=;
 b=A439KoWrJykberUvjjY8H7phQZCWdrGOKOhggXSRL11gSFOCwlNEM0eiyn+XomhiJS
 661zdUVHW3Q2I85qb8LdhqR9dcP8IhE7vEiwBmTpgnMdnl7VTw+HEWNksCDk0029gyV+
 3A1ZeZ44DZgwAPlk9gOyclJ1jonTUKWlHhNdbcPQjulYHt7ueUVj4km8TkZlS0AaLDDh
 DL4sS0W6UdWWVhgMg5r5lyCVL5lSoN9adOZ9lQ4Qw6fMhR2EVI9DLAF2x5+lbqLo7m92
 WR5dHDDNs6JAJPfwPgIJKsmgWesCenyZ+9TsyboWGTu7bE8DOAxH1G2hdXDgYHnLEttC
 AkRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787852572; x=1788457372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mHfCUFStXRQs4Vxp/BYAOOICbf0Ocg/AAwvAD3GsPxg=;
 b=itz+9WjFZKtkaER7vkidlHRZw2QXtUl/GcB1vunzswuqQL6VzL2zC8+Xrz98P51xmY
 dLaNnMzpVduHvZbu6z/XutfBRZ6KHSIJ3m1zxYGBIJo01tKmjiOTD3r9glZQPRCYsmxh
 kq29yQ2xjPFMPUGjZnMKEcxc57WpFvkyFeU1FC0i/G/4FFLNW8ihcG2QHDHJNKXNvjEp
 yRQqV02UsEAioY15YjHyAHRfSrl8H+KJAaG9Y6bv0o7n3jJYGx38DUvv/oDefQqymR3Q
 QG4QXG84N6+ev50vmQ1MY9SSGrXeWvEjeLO8P0V8xn/hGMjAMZhL8AZ1guXPIY7/YBYp
 i60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852572; x=1788457372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mHfCUFStXRQs4Vxp/BYAOOICbf0Ocg/AAwvAD3GsPxg=;
 b=Yy/u/vd1FGzcrLIN8n6m+mZHnWOf451IiFPvcTbYrCXUkVnAJPy1K1fQWWc5esUsaN
 3y3KZAzYXWPw0gahEa7PTuFD9znXN0HZZINr9miHXf0YO6GX6obocw5Hx3oGCmW4vCJl
 sRhaIpEi3/x4k7tU7sQRD7h9y1JI0e5OAi3f0p/S2csX6fdroCPe48IX/MXmIWWQ4m6l
 hbEYYs8GCrp5NTnO+xZqUgVWeG/iuMluwuwJb9t2Gtt3KdEvcD0hPjvrdlTI/SwDrMin
 ZD02BWEhc/PN1b25zZgyJdBjUQiDxcfVIKWdHNbRwWavSLjA5aXR2HoKxJyrlzkUt6Gc
 7JwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYcldh9OWBXHgPZgrfxAaVmbd+zM6nJEd7C3xhKzuwITcs/w4A3kjQLrhCMAOvh4qaN/x6+a7cIndl@nongnu.org
X-Gm-Message-State: AFuF++mL0es1wzV9OJe0XGFx+uVgzyuP+GAqzoIC5p8kUQ6I41CUyGyM
 5qij+Y7+7xf6pGoxFZVxgkVXfbNvIs+uiubgwShn9iZ8ed308EeJGNKfeW6waIpbX9AkJ0exjOL
 FXwYp9bRau/4cVDnU2CgwT75WMQcZAqbEns1Iz3oBEw==
X-Gm-Gg: AR+sD11fVkzggVhFaEEAZCT+v3zSx+tIuoc7WvZP47DFDpA8J1sAZ53nQUj/L/sVfuZ
 8wCVxKikAYBXa05TY1oaU9H2qIxKAOUKcVW+XBBtvdQmoY4Z60OLrhzSJrXObNE9wzUQsW6Ppua
 +MmYCci4l0O7Qfym3qGVDRKfyLlYX09JGKguFhv4qJ9zyE7eGkK5sQad7RR7wwPzu6llfbmY0CX
 /tDtJlcDVgkmTf5phbo/C3op/SlRNwMj/rJj0lBnFkMnB024FXueyiz15Nk2Zpsv6WDpHI3oF1H
 Z/f5nI1Z2ZTmKGocjXsoDgMH7QlCPaavwKoumUqQ06OnkYKu8lTyDA3DRos/9PVqfapBA/pbiFj
 vWhnDq2atLT/28UTcokDj3WOAMB8VxPM2/jJHPxc=
X-Received: by 2002:a05:690c:f15:b0:857:ba53:5f7 with SMTP id
 00721157ae682-85d69f00dfamr5665747b3.14.1787852571904; Thu, 27 Aug 2026
 10:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
 <apAG8JQTnQxRkfip@redhat.com>
 <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
In-Reply-To: <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 18:42:40 +0100
X-Gm-Features: AcwNN1XjP2okfaqDrZv7av6Q836_ff-1z6FvUw2VnaDSVYtGGUC4HG1j_CVuyjI
Message-ID: <CAFEAcA9cmsMG9w32zLAuYNA37J7T6t=gK_4w_pZUVr-FXZna1A@mail.gmail.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Chao Liu <chao.liu@processmission.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 27 Aug 2026 at 17:32, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 8/27/2026 2:44 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 26, 2026 at 11:35:11AM -0700, Pierrick Bouvier wrote:
> >> Seems like the Genius.Artist. in the bottle just need to escape, and y=
ou
> >> can send us a nice series doing all this. Meanwhile, I'll try to find =
a
> >> carpet, a monkey, a princess and a suit to be the next Aladdin.
> >
> > This kind of comment is not productive and disrepectful to the time
> > reviewers in invest in looking at the proposed patches. Please stop
> > this.
> >
>
> The only person wasting everyone's time here is YOU.
> There is not a single person who came on any thread to say "I agree with
> you Daniel", while several posted or commented they were ok with the
> approach here.
>
> Project is QEMU, not Daniel's EMU.
>
> Whether or not you like my joke above does not matter, just focus on the
> first sentence of it. Send a series implementing your view instead of
> long emails "I said so" on other people series. And go back to the lamp
> until it's ready.

Pierrick: please calm down and take a less confrontational attitude
in your mailing list posts. Daniel is reviewing the code, which is part
of the project's process. He hasn't done anything here that merits
the sniping you've been doing in this thread.

This is entirely separate from any technical issues about what the
best approach here is.

-- PMM

