Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F16BC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 19:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4PW9-0005or-46; Mon, 14 Apr 2025 15:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1u4Owp-00027Z-R5
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:54:23 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1u4Own-0006mc-7H
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:54:22 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8f6970326so45918066d6.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744656858; x=1745261658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgqqsODAgD3pRTGB/PJZ9SHxqElfGdh8WYhsgBJhLPg=;
 b=fz2FeBA2TDEzNfm7Iq44vjO44GsPghmtEh1H+hT5sQ4ze3HtigmdB/gEzHMol8jzhG
 LyEM8gOF7iNVahRJ8diUaUGZJRkwlajReBx0a99u2VF7KvH8gNgY1DQgZK4Bf+GVEtpJ
 MOYR1744yip7oCrknMQlGX6LXcaC0a/wYN3wUUbRzwlVgU7uTjLFnmQlCVvtm/mAOY5K
 swazwa1LoQg6G5v/cqJBR7LtTPKOuk8a4ziEivgKivqZdRrjYleDKiXtX5owcDuXxHcC
 iLtKeR5uqVscxr7UGAygwwEmH1boi1020JmbjcXt4HvdTepaUHfuT+KP6qjFViIdbwq8
 JgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744656858; x=1745261658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgqqsODAgD3pRTGB/PJZ9SHxqElfGdh8WYhsgBJhLPg=;
 b=Fw5G6QMA6YBHWgcPcM+vjZHonAlDT8zG/SuECetj/eQ9LYsARVmBOrf6E2dUZlGQz4
 /c0UKdJnZd0WAhqXPTa7uP40UHQPYs/oGNEaymFiaeVdlF0ut+WQTlsAKr7IZQFtQki5
 GordG12/MzqMqXlmkVmHffJItJAHVEwyFQ2ROwsX/z4XMVhHdhm1ewWjDn8uhN3iPTqN
 OMvhSoVdWDo92nW+ObVAOgByZjSnX4fMLPlaETAhvFYLNZsM/sJ2/qmXKmWLoKwxyOdH
 5m5K+qzzSdN3QIeNTMdhDDJqXXl3NfdMZNvOZQYTl7qwRmAxvJquOqJCbre5ISELoNUT
 nxOg==
X-Gm-Message-State: AOJu0Yzzzc3XaVIaQQ3yhJbt5eTcpKMdl/OOzYxfTKEufpx4CF6FFmHm
 ojexkBOwRLyEqE8+KI6M4ol2bddhpAnl+lzklAaUhEyMP9gBv8Dcubgz6g==
X-Gm-Gg: ASbGncunlTScLYo2kYVwm6ub6y1oy17XTDK4UI46aDy9RQhUM1IjRZhikrdfOAJicxy
 GFsPtdQbXbPV06NMYlt3/jEHFqp4vyS5lQ/XKLUp946dwx7i4+GBS2N4TK1lRB9kZZDhR5OQEmG
 9wRtS3KKMCbzdr+MhuLxRswrw2lTcV7jkQGmIpSKHoWcuWPsY31DKO93kWf/TA2tavUYPIZuKhz
 Wt25JyyHhfOKFOJNfrBNYRSd4n/Glk3FxD3WLXWWwgXHeg1Np/SoVQvuJXVmUD3MhdAIwCVyCQR
 ZH1x4nXff+tyRhuWZjHqE80AdhsWEt/+XJjT1h5cWN2CL62Pm2WJ1tV7oSU6ORi2wdZ3M1Ezkrl
 UzLYjaEg+SLhzwLaCEC99L1zTwJPUzohR9BZEt5U=
X-Google-Smtp-Source: AGHT+IHBrerrMP6XMxFNsZXC5XUFgRuPp+3AVmMsUfZNGBHbQVQKVQMlZGSeVC2g/oseLbdgv9uGww==
X-Received: by 2002:a05:6214:410d:b0:6e8:fb44:5be2 with SMTP id
 6a1803df08f44-6f230d73ea1mr205518256d6.23.1744656857631; 
 Mon, 14 Apr 2025 11:54:17 -0700 (PDT)
Received: from paper101.paper-domain.cs.uwaterloo.ca
 (paper-base.cs.uwaterloo.ca. [129.97.152.163])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f0dea101aasm86688676d6.96.2025.04.14.11.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 11:54:17 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, Brian Song <hibriansong@gmail.com>
Subject: [RFC PATCH 0/1] add fixed file table support
Date: Mon, 14 Apr 2025 18:54:11 +0000
Message-ID: <20250414185414.2922845-1-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Apr 2025 15:30:31 -0400
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

Hi everyone,

I am a GSoC QEMU community applicant this year, and I have just
completed this contribution task suggested by the project mentors
Kevin and Stefan. This task requires registering the file descriptor
of a block file that currently uses io_uring as the AIO method to an
io_uring instance, so that when the kernel processes I/O requests, it
can directly use the index to find the file information and avoid
frequent file lookups (fdget()) in the kernel. This is expected to
improve I/O performance.

Note that since this is currently just a proof-of-concept that enables
benchmarking, handling scenarios like block file removal is not yet
implemented. Testing was conducted using fio for random read operations,
and based on the results, there doesn’t seem to be a significant I/O
performance improvement.

Please feel free to share any thoughts!

Thanks,
Brian

The specific testing method and results are as follows:

guest $ sudo fio --filename=/dev/vda \
                 --runtime=120 \
                 --ioengine=io_uring \
                 --direct=1 \
                 --ramp_time=5 \
                 --name=randread \
                 --readwrite=randread \
                 --iodepth=64 \
                 --numjobs=1 \
                 --blocksize=4k \
                 --runtime=30 \
                 --time_based=1

** Guest with fixed file table support: **

**vda (guest.img)**

randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.39
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=502MiB/s][r=128k IOPS][eta 00m:00s]
randread: (groupid=0, jobs=1): err= 0: pid=1208: Fri Apr 11 23:18:26 2025
  read: IOPS=127k, BW=496MiB/s (520MB/s)(14.5GiB/30001msec)
    slat (usec): min=2, max=3541, avg= 5.89, stdev= 3.71
    clat (usec): min=8, max=24149, avg=496.40, stdev=149.85
     lat (usec): min=11, max=24161, avg=502.29, stdev=149.89
    clat percentiles (usec):
     |  1.00th=[  375],  5.00th=[  433], 10.00th=[  449], 20.00th=[  461],
     | 30.00th=[  469], 40.00th=[  474], 50.00th=[  482], 60.00th=[  486],
     | 70.00th=[  494], 80.00th=[  502], 90.00th=[  515], 95.00th=[  537],
     | 99.00th=[ 1287], 99.50th=[ 1516], 99.90th=[ 1827], 99.95th=[ 1958],
     | 99.99th=[ 2573]
   bw (  KiB/s): min=484856, max=530928, per=100.00%, avg=508499.90, stdev=8880.33, samples=60
   iops        : min=121214, max=132732, avg=127124.98, stdev=2220.10, samples=60
  lat (usec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.05%
  lat (usec)   : 500=79.75%, 750=18.05%, 1000=0.44%
  lat (msec)   : 2=1.66%, 4=0.04%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=44.52%, sys=55.43%, ctx=199, majf=0, minf=36
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=3810630,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=496MiB/s (520MB/s), 496MiB/s-496MiB/s (520MB/s-520MB/s), io=14.5GiB (15.6GB), run=30001-30001msec

Disk stats (read/write):
  vda: ios=4422643/234, sectors=35381152/14793, merge=0/20, ticks=120202/328, in_queue=120535, util=95.02%



** Guest without fixed file table support**

** vda **
randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.39
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=459MiB/s][r=118k IOPS][eta 00m:00s]
randread: (groupid=0, jobs=1): err= 0: pid=1217: Fri Apr 11 23:16:24 2025
  read: IOPS=127k, BW=498MiB/s (522MB/s)(14.6GiB/30001msec)
    slat (usec): min=2, max=246, avg= 5.91, stdev= 3.19
    clat (usec): min=10, max=21817, avg=494.55, stdev=149.50
     lat (usec): min=17, max=21827, avg=500.46, stdev=149.59
    clat percentiles (usec):
     |  1.00th=[  318],  5.00th=[  392], 10.00th=[  433], 20.00th=[  457],
     | 30.00th=[  469], 40.00th=[  478], 50.00th=[  482], 60.00th=[  490],
     | 70.00th=[  494], 80.00th=[  502], 90.00th=[  529], 95.00th=[  562],
     | 99.00th=[ 1270], 99.50th=[ 1516], 99.90th=[ 1827], 99.95th=[ 1958],
     | 99.99th=[ 2376]
   bw (  KiB/s): min=441768, max=568144, per=100.00%, avg=510363.83, stdev=23076.31, samples=60
   iops        : min=110442, max=142036, avg=127590.88, stdev=5769.07, samples=60
  lat (usec)   : 20=0.01%, 50=0.01%, 100=0.02%, 250=0.10%, 500=76.37%
  lat (usec)   : 750=21.30%, 1000=0.52%
  lat (msec)   : 2=1.65%, 4=0.04%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=43.71%, sys=56.26%, ctx=133, majf=0, minf=36
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=3824929,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=498MiB/s (522MB/s), 498MiB/s-498MiB/s (522MB/s-522MB/s), io=14.6GiB (15.7GB), run=30001-30001msec

Disk stats (read/write):
  vda: ios=4468557/140, sectors=35748456/8817, merge=0/18, ticks=129894/244, in_queue=130143, util=95.00%


Brian Song (1):
  This work adds support for registering block file descriptors to the
    io_uring instance and uses IOSQE_FIXED_FILE in I/O requests (SQEs)
    to avoid the cost of fdget() in the kernel. It is a basic
    implementation for testing, and does not yet handle cases where
    block devices are removed.

 block/io_uring.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

-- 
2.43.0


