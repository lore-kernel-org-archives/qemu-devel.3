Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4860BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtqG-0001Qg-1X; Fri, 01 Aug 2025 13:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uhsKK-0000gN-2l; Fri, 01 Aug 2025 12:09:48 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uhsKH-0004NS-CP; Fri, 01 Aug 2025 12:09:47 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fa980d05a8so20791316d6.2; 
 Fri, 01 Aug 2025 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754064583; x=1754669383; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKt+cDY4YHGJL8Pm44gMQiotg8yYo2ggvPgwggOIOB4=;
 b=FA0peXFenrOG4S9p5nrjqIg/6+UETfOk4qomXyPWXw288xFMJGkTRkEuXMiqSwRc2W
 Fau2kmUPL1F0f2uCAvUF+D9BQZZS8vpbPVTIGlgXAQhOKrfIJ2gg291FJ484y/pth9+4
 dQZpTJOdhZNxnkgs3rV1hWT3dXwt1qeD5xMEqcKaHFwdGmtkHtqYwNGXs+Kuirl1p+4D
 +3MbdpWXBv3c35WuwgrBYy18KJIlH/HjhtcNp3CxGIVOUpqOhVUKu3ze+oU+uxYHHxx1
 tPeNlP89+ah/EAT0AbnI/uCqmMxsjfHnH26pYF1mMafdCDlHwrh3VubYpuoBdoCbC/CK
 osew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754064583; x=1754669383;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cKt+cDY4YHGJL8Pm44gMQiotg8yYo2ggvPgwggOIOB4=;
 b=D28jeAyBJZteXuTtKZqHGVsU5m9GSWKRd1ydLYeOuIhtT8qL9GP95Kxa4UBupAY0FL
 khgSrKyFWWfiPg1Mez/SexYY47lQUZ/IPLFnDmqY0U7H9bkcc4yNt1kurQgyNL8zFhu3
 BdhUve3ulKGpwXwt3Mnq+5IsCmLAznMspoMLhMajVlJOUe2rq9N9L6rEbH2ag35Q40TM
 0GjBYPUq/JS+sliYCw+sA5XMh0GV8IzsDdfUtHVpF3kcgfx+uYzlPyjYrJ8MlwD7YHbH
 117sBlcByw/Kvyv1UfXS2unMdHeYdssENa5T4jDDX3ag5A3NvYFVDOMkdfBuHhEiwRts
 wHaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/VbNKPHIhRIQK/H09xPpdbdxmqh0d9vjIZfX8p5sCJQ36gsaMc3MraCJCoj9uNcOjwhbZaS7xopVc@nongnu.org,
 AJvYcCWUHOHR4Hakwkg91/KFN34O+XwJVqDACaP9KmkrmUk1mbve3sQBiYTIiiwyMKqtCatsa20sCmdn8fvz+A==@nongnu.org
X-Gm-Message-State: AOJu0YxdUE0fcCrLUGK30UF3Bq3DncK33C8EZR8OU6Pzb9kksAZ2Po/k
 RK+4EcDS+T41fDdwISfyfr+5duZP2fODbe6CT4frnzWtwLkkhl/otNiH
X-Gm-Gg: ASbGncvPafL3I3x53TVqAykFnQQBFv3VX5w8ha1y3pMajpdTa9y1FlSlMJ6ubQ3jHXG
 mVo+iSIlhX/qfFCmyJyfWa0H/317cq522mLEsRH1LVdp4LiL5pYIC5Op8PSHGEQM5UYmskUn9YX
 rRBraobWvQ4PEuo+tLtqMf/9bZivo5LjMPFzXWjMw924myg5HynBLW/sYk/afl5cUnCQF85IHE0
 uofe1I4KV+YD0z92mSEBtHkeoasTDJ5gxqa6Iv5Burb8Lt/eRn19xQ7TAwrG9LXkxm5tm083sjG
 1F6kF2HSw22ZAfV1gasvs4hG9+vDEfzyHctVoFK9ea7YrcB1UZ7fEOOcLnmGXCPWBFDEI4TFWLb
 7r6SPCsS7wB/IDL0k2edLIdNFLQ==
X-Google-Smtp-Source: AGHT+IFbvo9COwtwjbT5VStbbpAubpsp7jH02yF+DdSBD9ujBZiMawZzDw8wPKJYn2OZdEX2RSHyWg==
X-Received: by 2002:ad4:5b8d:0:b0:707:16cd:8329 with SMTP id
 6a1803df08f44-7093631d6ebmr3049586d6.37.1754064582890; 
 Fri, 01 Aug 2025 09:09:42 -0700 (PDT)
Received: from [192.168.2.59] ([70.50.118.45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cea87b7sm23206436d6.87.2025.08.01.09.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 09:09:42 -0700 (PDT)
Message-ID: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
Date: Fri, 1 Aug 2025 12:09:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bschubert@ddn.com, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
From: Brian Song <hibriansong@gmail.com>
Subject: [QEMU/FUSE] Discussion on Proper Termination and Async Cancellation
 in fuse-over-io_uring
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf2c.google.com
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

Hi Bernd,

We are currently working on implementing termination support for 
fuse-over-io_uring in QEMU, and right now we are focusing on how to 
clean up in-flight SQEs properly. Our main question is about how well 
the kernel supports robust cancellation for these fuse-over-io_uring 
SQEs. Does it actually implement cancellation beyond destroying the 
io_uring queue?

In QEMU FUSE export, we need a way to quickly and cleanly detach from 
the event loop and cancel any pending SQEs when an export is no longer 
in use. Ideally, we want to avoid the more drastic measure of having to 
close the entire /dev/fuse fd just to gracefully terminate outstanding 
operations.

We are not sure if there's an existing code path that supports async 
cancel for these in-flight SQEs in the fuse-over-io_uring setup, or if 
additional callbacks might be needed to fully integrate with the 
kernel's async cancel mechanism. We also realized libfuse manages 
shutdowns differently, typically by signaling a thread via eventfd 
rather than relying on async cancel.

Would love to hear your thoughts or suggestions on this!

Thanks,
Brian

