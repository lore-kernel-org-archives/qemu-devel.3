Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9CECA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 05:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy201-00011p-Mz; Mon, 15 Sep 2025 01:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uy1zp-0000zC-8J
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 01:43:27 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uy1zi-0006D8-Fj
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 01:43:22 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-31d6e39817fso5820321fac.3
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 22:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757914993; x=1758519793; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVzP2AR/wuRPmR296FjuNtuRHrpKr4/naBzA5rmYYO8=;
 b=Jc7Pg4Jd2AYeGY2ckG38m1Tas5l/jMD1XCL6RiHpCdLaTIEBjnKL0iko95ZB9MSSyF
 Zh6wLavJxsjfiB+N/gRwghEpkK/E94iMo9V2Hv05mSejNH2hF8ddLLcv6JXNZyMGyIyF
 QLZzl/b7Eg9M002zazmrGS/Z3KpmTe7XSV6DkAo4WAFLjhDZQEFxYHqG6R8Kj2TCuC8R
 CA16urSRP6XsKSCtZRpVmX3Q3uCJCBQs1C+V5JyH7DtBQHqpkpNMYHPuIX2GyYD9wqjR
 vb5QpRqahR1HB24zvbcigKsCPj4DGS6a9hp7Sb09GJJTX3CtN4eDR0YgxBbZv5T5Xx8P
 /y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757914993; x=1758519793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVzP2AR/wuRPmR296FjuNtuRHrpKr4/naBzA5rmYYO8=;
 b=VeM210kWXN/Rtx0pPuHkSSPG3eYFzaDOIGb4UnoeA4Y8dreHeMpwv4LmrHl0lm8UN9
 QQAC72W60BB2ip1+oZwZasig39T6HPozEJ5U9bILCS6U/uXPrwWLnlwvvYk3QzoJgnk+
 Djv1bKxsbJ1gUomkNnBmy2XGmxpCRsmTLkF0e1TZXBsKUp8BdZ89z5rFLesZTYl+S0Sm
 905kDSINL9jP2Eg+4hqz1TR1gs53w/cPALSjmVEkWElxq2MRMg/nT0/F2ugrGA1tJywD
 53wfWev+h66c8BbjL5uRtHOT/9jCbAJbgpbLzpc1QFtoTytU/uBgUFhSYr4PECV5TJjR
 64dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuYtNBQn2H5kbsrlAzxzm0pYnAhlTHhDFUIo8JQvKLRkr6ZFnKeWWE0+3xDUnnw+5RmNe+Vz4h7ua7@nongnu.org
X-Gm-Message-State: AOJu0YyKjRokC9tAhakmw+arVJknU/a/hx0LEPFCyyZB/xI83TIaacvL
 MzYbV1vlo82xdGR/7X4me2XPzcqAIHt3UnLI5vTwU6eqJWk63N9A2eEsGiyThXvPYmgF2ySZh85
 oD8oTLbwN2aL2Ry8t7Y2cdCW/Kd7fOrY=
X-Gm-Gg: ASbGncv85t2FnqID0G8yq2mQ/uqM3q0PrOAeW4O2JlQDswA7FA84IQASLhQtGmlIpj+
 +UNl5RobFoK6v8krtcz2n4M8gat5yFntRx3e20ncoE02Pt2Yu90TK3Kw6S1jRZwvwSa3IKiuOC1
 U6QLaZ7D7z+MNTIK9+gbHlrCC0d1lJA4lpjw0JrjjqHRypNprCnKehUoYXXoTBGFO5ouX4Z5lAK
 NlfhA==
X-Google-Smtp-Source: AGHT+IEO/r905gqdf1XASeNM4AHPYHqhi4m+tUkJNJul3t02rWlguj6XRTYUxWTwX5PVfBA2ZIb+RXeNLMSjnEdSRAw=
X-Received: by 2002:a05:6870:818c:b0:332:8147:25b3 with SMTP id
 586e51a60fabf-3328147369dmr1078921fac.47.1757914993416; Sun, 14 Sep 2025
 22:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-4-hibriansong@gmail.com>
 <20250909193358.GE218449@fedora>
In-Reply-To: <20250909193358.GE218449@fedora>
From: Brian Song <hibriansong@gmail.com>
Date: Mon, 15 Sep 2025 01:43:00 -0400
X-Gm-Features: Ac12FXwgttSMeBlBqERMYETINL7__2ictmvHhUlnoIiW6mgkcvZi6BO9AHv4KHc
Message-ID: <CAKWCU7VFbJius06j1pXvP_5aSpmhmaJq6Z41H4efWFmeMjr4OQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=hibriansong@gmail.com; helo=mail-oa1-x32.google.com
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

Hi Hanna,

Stefan raised the above issue and proposed a preliminary solution: keep
closing the file descriptor in the delete section, but perform
umount separately for FUSE uring and traditional FUSE in the shutdown
and delete sections respectively. This approach avoids the race
condition on the file descriptor.

In the case of FUSE uring, umount must be performed in the shutdown
section. The reason is that the kernel currently lacks an interface to
explicitly cancel submitted SQEs. Performing umount forces the kernel to
flush all pending SQEs and return their CQEs. Without this step, CQEs
may arrive after the export has already been deleted, and invoking the
CQE handler at that point would dereference freed memory and trigger a
segmentation fault.

I=E2=80=99m curious about traditional FUSE: is it strictly necessary to per=
form
umount in the delete section, or could it also be done in shutdown?
Additionally, what is the correct ordering between close(fd) and
umount, does one need to precede the other?

Thanks,
Brian

On 9/9/25 3:33 PM, Stefan Hajnoczi wrote:
 > On Fri, Aug 29, 2025 at 10:50:24PM -0400, Brian Song wrote:
 >> @@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport
*blk_exp)
 >>            */
 >>           g_hash_table_remove(exports, exp->mountpoint);
 >>       }
 >> -}
 >> -
 >> -static void fuse_export_delete(BlockExport *blk_exp)
 >> -{
 >> -    FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
 >>
 >> -    for (int i =3D 0; i < exp->num_queues; i++) {
 >> +    for (size_t i =3D 0; i < exp->num_queues; i++) {
 >>           FuseQueue *q =3D &exp->queues[i];
 >>
 >>           /* Queue 0's FD belongs to the FUSE session */
 >>           if (i > 0 && q->fuse_fd >=3D 0) {
 >>               close(q->fuse_fd);
 >
 > This changes the behavior of the non-io_uring code. Now all fuse fds and
 > fuse_session are closed while requests are potentially still being
 > processed.
 >
 > There is a race condition: if an IOThread is processing a request here
 > then it may invoke a system call on q->fuse_fd just after it has been
 > closed but not set to -1. If another thread has also opened a new file
 > then the fd could be reused, resulting in an accidental write(2) to the
 > new file. I'm not sure whether there is a way to trigger this in
 > practice, but it looks like a problem waiting to happen.
 >
 > Simply setting q->fuse_fd to -1 here doesn't fix the race. It would be
 > necessary to stop processing fuse_fd in the thread before closing it
 > here or to schedule a BH in each thread so that fuse_fd can be closed
 > in the thread that uses the fd.

