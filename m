Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA72CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH0jv-0003mz-FA; Wed, 14 Oct 2026 11:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matej.genci@gmail.com>)
 id 1xH0d7-0002Wa-5K
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:10:57 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matej.genci@gmail.com>)
 id 1xH0d5-0006aB-7R
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:10:56 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3a5a26c8412so39925421fa.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 08:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791990653; cv=none;
 d=google.com; s=arc-20260327;
 b=KgLF1qOEcKYxzT2w7EJdOrd5jWrCQvronb+QalDe3dsrZze1EeScTyCy4vZhi9O1i4
 Nf3zsHbLvMyZS9CQEOvqrUqhO0thFyUWc/wlLzE8oT1zvaMyx0Y9lf+LRlUj8W8plK1S
 HRMHlQfPXjARE4C5jYLCSkhVVjPuCw3BXCfl0osBbF4eU1iH3caKIJGyHdxK7MIYriEq
 6OIcqoeAxfhc5ZhJjnHbwProKLP3QiKG9HC+MEKw6TnvaVqFr63+eH2jOw4p1Yd0TVSy
 zwo3E8H7Hqa2yxesPxNX1nS2V/w7VhDaD0wxRbzrt1cauCbwScV4imGnSUu/+5kiLX2A
 RIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=XO2GwWz5g5PCsuiv/WqF8qQONuWgwCJfieoS6H4oHrc=;
 fh=5oOe06I5PBcEDFBOnmyXLf1PWJVlcLmo85VfdsH7Qcw=;
 b=d2I0uUd9n9rrVHg2Y3QBwVHXmNqrBdrqDtduTTy4mdtPdoOuvvjceyLVJHi2Jnb/n1
 NohoIuvEj7FALeXYkp4RwtFXG0ZdByWbpCI05gO+I7jpCl8UH4o0txNZx5YVb9RFYlR3
 8LU32BQ90hng8Lu3Mb+C3FSTFZEUAVojShVmnt4GF4F3m5VlBN57wVLYMZ6DBhNvVFeh
 pjgDc6QaUwYSZl1G0IBmzR2EcIxK4D2cec1QqnqbDlkKKSfexsJw0t0f4uP65tPu0DaB
 3ebHk9BY9iU2zJ6RyWuQyqAI4Pv7uyO3L6CfBvdhUzO7fKxeA2saO7RmHZJ63bJp4gKP
 lyqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791990653; x=1792595453; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XO2GwWz5g5PCsuiv/WqF8qQONuWgwCJfieoS6H4oHrc=;
 b=g2mrY2Y/MLOLoSAVtA145CehzbM36+UzTAZ5j5d+U+d+LL8LS7/0Gu0kVyex86/Ik4
 DCZTBaVklW8dzV3TtdWj840BrmAsb+tgfm3xldnxx7aiQceWMvkR1IYSldaTswXJ0uw0
 27Z0YrkFx0XwDGbtLQ1lQsg8SJ2W1ZOxMfqr4TEiQOUDj4OXN3ta6tlLR2/QIlThyJjr
 YHG7YkBsDsSv2tVr26ALcOUX1xzH92EZENBbq+87sMk24pXeqCB4SEM9/IZ1T7p1Fclw
 +OSz4cR/s5vCMpGYrpPtEspjLYq6+1oigKk62vMDQFMPTiEpYPcRI2ftMIayNPEzS5B9
 f1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791990653; x=1792595453;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XO2GwWz5g5PCsuiv/WqF8qQONuWgwCJfieoS6H4oHrc=;
 b=v4LH7jVXQBezGlfPXb63cnk9LfmTP9zo4bBshDCNCHfahZjyUU8ZlyhW/ZHAFC13hs
 qsY81vZHx14gGlMgCjAnnammyLN5fNSZrGW99oCB8rZSS1DSiWtICr6878SxrVe9kN9e
 /J8RMiXJcSjZ8yF/6Xyqk9iprf5jFuVMH7UOuxTBRfNXqwFzidFEmFWAaHUt+1IxMLGF
 1KKQsMfQXOSXLXbOk2u1L0pdxiD0yyA/tkeEgzKF/eyZmsxp8FTBy7BV4y+NlIR+1yO4
 VT/cTf+MHDOmW7Ai38phQ8Bp/1fyeIvfQooU1eYychpDYNMWAYbmPaDtZ3Ugdiu4/SXb
 isHw==
X-Gm-Message-State: AFq9FYJNQKrbaDrDOmE4rGY6R3IhP10sgTQgdzmE7q0SNHdDmGkns68h
 Lr9xx+0Cfh4iow42hPaQC5y4C9SvXTFdc4Y0NdFdhMKSIgRvBdER1rbd3OMjzEfisiqvxaT0aWc
 I/aOgT2B30ShzkgRi/6XzK9deRZUOVcjubwWFt/s=
X-Gm-Gg: AYBFou2RA8ZPGXTwlCaFB9Jtpee7pA3HVX+ESzRudFzUYMDZEEODoqS6ZdmSALaHFhl
 6upN/oMWLAqVbKzF4gZjefI1swLPb1h67Q00xQX7DGlUaGiXWps/NNoIP4e6pbwF0+VoVx9iVLb
 g2vxBeico8c6x0Apd4IB6YUlDG/QR8jsskrILpixOyOdNW0/9/N4RVu642FuGPXkr2zH8DFMPBh
 zInlMTjDQR2vNHxkFaLx6eD7/DeQUDk20DbNafLUDwUTl91zB58YehHquVmhIX+VrCqbf+njpDr
 7NRnHjuonQqZSnST8EnIDsULd1xTOKY1ENfdIh7dPs+IYxyIcUUdUVY=
X-Received: by 2002:a2e:be03:0:b0:3a9:c416:8142 with SMTP id
 38308e7fff4ca-3a9c55dafebmr42717771fa.4.1791990652513; Wed, 14 Oct 2026
 08:10:52 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWF0ZWogR2VuxI1p?= <matej.genci@gmail.com>
Date: Wed, 14 Oct 2026 16:10:40 +0100
X-Gm-Features: AclHuK9uff8FPzlVogXO0zIx2_JkGpod2ME5HU2kwTIBy3VUN9Fyleo0GTXHJCA
Message-ID: <CAHPkGVdzQzqnW0MS9G-7xDuakHfjqYZCRR9HATDsBy0ZyTXLmw@mail.gmail.com>
Subject: Establishing an order between messages on the primary and twin sockets
To: qemu-devel@nongnu.org, john.levon@nutanix.com, thanos.makatos@nutanix.com, 
 clg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=matej.genci@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 11:17:58 -0400
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

I'm writing a TCP transport for vfio-user. When I was looking into
bringing back the interrupt message, I realised that currently we have
no mechanism to establish the order of transactions across the primary
and the twin socket. With a slow connection, operations can happen in
this order:

1. twin: Server sends an interrupt message
2. prim: Client does a REGION_WRITE to disable (or reconfigure) interrupts
3. prim: Client does a REGION_READ to ensure the write was processed
4. prim: Server completes the read
5. twin: Interrupt message arrives, client raises an interrupt

My understanding is that PCI protocol guarantees that 4 and 5 can
never happen in that order - the read acts as a barrier and the
interrupt will be sent before the device responds to the read.
This shouldn't be an issue if we use a single socket. All multi stream
transports (UNIX twin sockets, even interrupts via eventfd) can hit
this race, but TCP seems particularly susceptible.

To address this, I propose adding a sequence number to every message
on the twin socket (explicit in the message payload or a separate
counter in the client and server, I think either will work).
Replies on the primary socket will contain a `twin_seq` field with the
sequence number of the last message sent on the twin socket. Before
acting on that reply, the client must have received every message from
the twin socket with sequence number <= twin_seq in the reply. Posted
writes must be delivered to memory or interrupt controller, for
non-posted requests the client should receive them without waiting for
completion.

The `twin_seq` field should probably be a negotiated feature, which
would require additional changes to the wire format. Alternatively, if
we don't mind a backwards incompatible twin socket spec, we could
enforce this for all twin socket connections.


I want to get your opinion before I propose some spec changes or
publish QEMU patches.
Fwiw I opened a discussion on this topic on
https://github.com/nutanix/libvfio-user/discussions/883 as well before
Thanos pointed me here.


Matej

