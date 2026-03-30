Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADFA1061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7GoE-0007Vz-PX; Mon, 30 Mar 2026 13:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w7GnW-0007O2-1h
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:53:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1w7GnT-0008Ag-U7
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 13:53:09 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66a33f61d80so8036093a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 10:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774893184; cv=none;
 d=google.com; s=arc-20240605;
 b=lvoXF6bd6SSLZ4Ub/ZSEL+aYMk+FxbE7aXZyd+I7wJ2KeGAyHanYNYo57uyU0AO0bV
 A1sluGwZrdWfzsJzlFT74EfTXqUIFYPiw881fftxly2YG2jl3fE/Rn1goLF1oHrVZnwF
 rwa6rQfQtAhxggbjAvXHTAgCX/kz7jgWSCpQTtlWF41OnXWP+PoR0QjCPn3xhZTYAKxi
 DOhCIblSl6gA6XjooKFGjtESYh8BhxJ8x2k8poX7hfcb/P44REh79FSYSGNpkMMUjZKd
 6pGUvrRr5fmU68sBAUB4sz4OQ2MEwAYdhLjGwmKkxr368ju1yKq4ePBNXOB9SD746M5B
 doGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UxyUBpphD4KVRBHKIIgZVrwf1SbXCOZADhXVN1ZGF48=;
 fh=nuREzvHhaqzNEfw+XctgSg9ISKYlzmwDCgk6WKSfus8=;
 b=jHlw4oy192XY8Z7w0Unqgk3KxO5Og5eDV+Gb5+s1PzajzpG+uLcOmUPie0W1qwr2vF
 Da7zev4WNXGlmvOuivwlJksWXJts4MCcCRrQ6biGJLCRnQdSHazP3BwmzL/l3JvUKmxT
 fF6JXI767mwKrTuqNnDMCFY7+ELz3GLdEuCdNpBFLaRIi7H770k/HpgEEC9zVBCnoE/g
 ObM9ZisKS/fvOzPcOKeI4rMOY9vvyA3q0LDihPq7eYe9RpdyYhK74BWQoPeDKfvZCh2h
 n4+MLFn8sJhtZIVqx5AzKukaSl5hDms6/D4AR0JX1+tj3ijNFXwknYOY9r4IsyM84dL/
 /Uuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774893184; x=1775497984; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UxyUBpphD4KVRBHKIIgZVrwf1SbXCOZADhXVN1ZGF48=;
 b=VxeZHCMWI2HneErlM9N3tArkguKEWm3D+h3g+akUbG4SH9N96q46Wfp1OBc8ruH81V
 GH8on3necEmjBnFDev0NfoBAKZDEBUE0ChfW4GIVAebIO0tN2p0dyMM1MUDXgWNWBH53
 OboiYzlvOFF57DMjCbQ9rRCJcp6jlhv0V4ki1QnWSN1wDuX7JfaeTO9XnLCjQGuAycVx
 VPLaADaZPiEZ2wXLNaHfTBcpt0b8RzLZ3vPgoonFhXoGVsIjlWWpdQup9n1981LdTA7i
 mP+2VImXNXuuMttDhp38w3j09ssklCmfqdjdH59MM1HgAz3fHhCx5LqpvSTUtDcLT1qF
 6VlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774893184; x=1775497984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxyUBpphD4KVRBHKIIgZVrwf1SbXCOZADhXVN1ZGF48=;
 b=m0p+k1av/pzejj6Zv35ba3ToOPrj/edk24iF1ExHE7Y2vudJTb4GnFYW8guA+kKPb4
 uOqdaDMUuOsi9bVfA0Ku1qeOeytcq5nyFrM655Sl60QTb8jXSfqnTcSgS/lTOfUCU/FT
 iPh+7nk+Hm3BjwIKFTCFPaSbmYyzh7WdAjdZVC2H8B1Y7B/LMfg4fihNusO+TtgYIiAa
 lua5v+It1dfDUJGIbD+A8vnxkrkoUX/672JTu4Dt1QdM4c52SnAtiNA/TfjNlkesd/pQ
 of41QZVBbE2ROj4Lxlc0eph43vuDs1kMgm+pRAq8Sw/aea4N2EZ6CAfz+YfzQXWn8XmH
 06mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvrhF12VzOw94SpaTxyUTYEum5XzNtdekff0FiDOQFqsEWMihrpLoLwHIamt0kP9oMAkv/9pPkSGlX@nongnu.org
X-Gm-Message-State: AOJu0YwDa9vvwgqdtUulyz2UVFIZye76XJZIiqB3Inn5JZLB2J3gfPct
 0maGjp3lEe970NKSjkSPhuJFiH0gTBm1n5fzPwcLwl7YDmckjYBrNHGCnknhaCuT8gXAC5hFr+c
 m9Zc4t8RSP0FiPpGXBx4mZoJO2rViVpE=
X-Gm-Gg: ATEYQzwSPwO8c2m/KBrv3tJdRQ4rU9Y7gqGj7aQ/ANhuttnqSSBHKDXMbx4aePuzXq9
 sllnFw8cRQ1ap6hcTKS0gAWMpHC7xouFmlMZTfjaOLhpFR4PpQtQiP2ZKaAKc7J9xjRsvM0cxZI
 qnfTgyrI8pJ29/ztgjaTMpC7REJsi1sIez/Ures5UUXQsfOWQVsLTmRa4IghPN/iaJUNT22KP6I
 M/Cu+OIONbsRItMVyFSnjB0PZTbeZXhbMVBCLHMjtXPnviDJ6sWi73Pm1/QLBY7+drwRpzbSXE3
 ULD4tCcShJzbOTZq2rmrf7kNKzd4kwchr93GGQ==
X-Received: by 2002:a05:6402:234f:b0:66b:d31e:e821 with SMTP id
 4fb4d7f45d1cf-66bd31eebbdmr3508047a12.27.1774893183788; Mon, 30 Mar 2026
 10:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
 <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
 <875x6dzo50.fsf@pond.sub.org> <20260330133155.GA154632@fedora>
 <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
In-Reply-To: <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 30 Mar 2026 13:52:50 -0400
X-Gm-Features: AQROBzBPHjNCBTQhkaZL4EJgob0Zi9kF7LkaUrcv6gxzBmrFQ61pVTx2wqycvTw
Message-ID: <CAJSP0QXTEHphbgR_xxqBSvcvqNo=aGe6S1M7wksC=3BHEgKRAA@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Zhang Chen <zhangckid@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

Hi Chen,
It seems to be an email delivery issue. You can check the mailing list
archives if you are worried about missing emails:
https://lore.kernel.org/qemu-devel/20260305142459.52559-1-zhangckid@gmail.com/T/#t

Markus' reply arrived in my @redhat.com inbox but seems not to have
reached the mailing list yet. It could be due to slow mailing list
servers or temporary email delivery problems.

Stefan

