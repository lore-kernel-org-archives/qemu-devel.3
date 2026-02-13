Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D05EDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquDv-0003iq-Lz; Fri, 13 Feb 2026 09:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDj-0003gW-H9
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:35 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vquDg-0006bX-2x
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:32:35 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18c654458so392564a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770993151; x=1771597951;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqBOMzl28DKqqn/5ITt53IZh3OcJ6ZgKOh+W57xkrRk=;
 b=rb/06dDg0/hiXFvkdOelzBvz49TIY9xnimWOU2EtOwkML7YbqYyvrUWuVn/TAXnvuh
 WdiQep9Mpggf00OqULtW7G9rXGcpgb9U5PU4TDpZiTEKjiFXCn5VRq3vkYA/2temCkQ+
 PtGoDB+AplNsgbrtCF49sC8nXNeMDUDUbLjRjlMVnaHYI3PulOaRD/fjHH5sAj8BkZ5f
 4+HQ5Nb4e2ohNr17l9qBEPEu2DWCuqym24EGXF6/w6i7JOd1/Fd8nYfW4a88l06dKtsA
 RpxyqG1FRmfpadnJQmruJhCmpxlGwYHopZQhLWhKpe5QETydxJ786OPxlVZpAhFzhns6
 zo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770993151; x=1771597951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqBOMzl28DKqqn/5ITt53IZh3OcJ6ZgKOh+W57xkrRk=;
 b=BKRzbQ+aBvAPZGlTaEvzFqJdkLVBbj6H8peTuB4cKma/eZ0gaDtBN6ipUb6oE+d4Up
 Zz39n+CInM3uNb4AYk2dM7M7PmhFcbALZKIG96fj3bhtLHd/pah5yM0TPp0zaRviAtS2
 oyDmduHfbxY5vCSuP1Wn1PoTlrWsI3Jr/C2qa5lNwupppxoefzqa6R3stj2b0nM+wtoA
 Azk8QgWccQe5aSgYauHDKdkSiqnrnKEqdANEkG1DrVkMTVO1YGu5bV6D4NYdmtl4soQo
 IgHLEE34VwoApQ2J63WJMqrktLaodjfGbSt3P3mXwAyAQxY8/+KLVIynQYxEA2fFq6js
 DzeQ==
X-Gm-Message-State: AOJu0YzGL016uq6FFc1djJqnWy4LS03R7fsuroj73qf+ws/Jp6SUpMox
 gN88qLAn+nTOi9i+xMnoYrbWuHUBdY7FLWuKMXZWhpdehGQFCqrOAPlyBJD+aOo5vtk=
X-Gm-Gg: AZuq6aKzsNYvrSGM6eraHxBwCzMKDedT4jFr8Comr7+ZAK1gQgOLCiGiQ9aFfPJPHkp
 ocGcgUfc7ZFAEeUfnt9q98KPNkPwswaLVOP97UQYKrUD/jGBSAtC0MfkRO0vyBBROSK1QXOzeSL
 QHax5wg2so9YFHxIwfLrleTXG7FYYPNthtE+1Egbj+Le4Vc1uSr6ECVstxbpYuDx9ItfG9l1q7u
 lU+PImqImUMqTRsIdDaK3gk5hOEseIt2jlPfGowd5d6pXq30Ls2wyOkeH6S+5ICtNG7bKNc9O6z
 PUuw7qaSxxkIdQPtpU2knN4Fc1F0+EXaQTUV8PBrPgPxAkjNdbOa93OEiRITUjS2O4IgAla7KN0
 C6tTibM6NeYdgUQr5q6JNi1wMrTu5hN5NF6CM6Ei8JJEnVIkMpMtrrVd/bsLA6hNwHTNh4eU5WS
 PMb+fjxnOWNq00rQnpSI0xR79wf/WGlngTVUyvwN/aX8VI5AbrGVD7yPCtkIg5LMc+Hh7s
X-Received: by 2002:a05:6830:648a:b0:7c7:6d15:6ac2 with SMTP id
 46e09a7af769-7d4c4a0b773mr1094809a34.3.1770993150635; 
 Fri, 13 Feb 2026 06:32:30 -0800 (PST)
Received: from m2max ([198.8.77.157]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a733f033sm6564377a34.0.2026.02.13.06.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:32:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
Date: Fri, 13 Feb 2026 07:26:36 -0700
Message-ID: <20260213143225.161043-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213143225.161043-1-axboe@kernel.dk>
References: <20260213143225.161043-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=axboe@kernel.dk; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
block I/O coroutine inline on the vCPU thread because
qemu_get_current_aio_context() returns the main AioContext when BQL is
held. The coroutine calls luring_co_submit() which queues an SQE via
fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
in gsource_prepare() on the main loop thread.

Since the coroutine ran inline (not via aio_co_schedule()), no BH is
scheduled and aio_notify() is never called. The main loop remains asleep
in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted until
the next timer fires.

Fix this by calling aio_notify() after queuing the SQE. This wakes the
main loop via the eventfd so it can run gsource_prepare() and submit the
pending SQE promptly.

This is a generic fix that benefits all devices using aio=io_uring.
Without it, AHCI/SATA devices see MUCH worse I/O latency since they use
MMIO (not ioeventfd like virtio) and have no other mechanism to wake the
main loop after queuing block I/O.

This is usually a bit hard to detect, as it also relies on the ppoll
loop not waking up for other activity, and micro benchmarks tend not to
see it because they don't have any real processing time. With a
synthetic test case that has a few usleep() to simulate processing of
read data, it's very noticeable. The below example reads 128MB with
O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay before
each batch submit, and a 1ms delay after processing each completion.
Running it on /dev/sda yields:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in   25.76 secs      fish           external
   usr time    6.19 millis  783.00 micros    5.41 millis
   sys time   12.43 millis  642.00 micros   11.79 millis

while on a virtio-blk or NVMe device we get:

time sudo ./iotest /dev/vdb

________________________________________________________
Executed in    1.25 secs      fish           external
   usr time    1.40 millis    0.30 millis    1.10 millis
   sys time   17.61 millis    1.43 millis   16.18 millis

time sudo ./iotest /dev/nvme0n1

________________________________________________________
Executed in    1.26 secs      fish           external
   usr time    6.11 millis    0.52 millis    5.59 millis
   sys time   13.94 millis    1.50 millis   12.43 millis

where the latter are consistent. If we run the same test but keep the
socket for the ssh connection active by having activity there, then
the sda test looks as follows:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in    1.23 secs      fish           external
   usr time    2.70 millis   39.00 micros    2.66 millis
   sys time    4.97 millis  977.00 micros    3.99 millis

as now the ppoll loop is woken all the time anyway.

After this fix, on an idle system:

time sudo ./iotest /dev/sda

________________________________________________________
Executed in    1.30 secs      fish           external
   usr time    2.14 millis    0.14 millis    2.00 millis
   sys time   16.93 millis    1.16 millis   15.76 millis

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 util/fdmon-io_uring.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d0b56127c670..96392876b490 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -181,6 +181,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
 
     trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
                                  cqe_handler);
+
+    /*
+     * Wake the main loop if it is sleeping in ppoll().  When a vCPU thread
+     * runs a coroutine inline (holding BQL), it queues SQEs here but the
+     * actual io_uring_submit() only happens in gsource_prepare().  Without
+     * this notify, ppoll() can sleep up to 499ms before submitting.
+     */
+    aio_notify(ctx);
 }
 
 static void fdmon_special_cqe_handler(CqeHandler *cqe_handler)
-- 
2.51.0


