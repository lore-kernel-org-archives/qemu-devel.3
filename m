Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05933C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 04:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj91J-0003Mk-Tr; Tue, 05 Aug 2025 00:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uj91C-0003EW-CH; Tue, 05 Aug 2025 00:11:18 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uj91A-0000S1-MY; Tue, 05 Aug 2025 00:11:18 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7e346ab52e9so605460985a.2; 
 Mon, 04 Aug 2025 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754367074; x=1754971874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KPkTAG8PRvh+jrhA0lHk3kPHmNbHKVIwTe48CJUZ05c=;
 b=AmF9ACu0jcj7l6jDe3Qer300FL4wBAQ//jxQgT5Dk30CbQdwHyCG2VwpusQJmUiF7W
 J+p0HZ5DDuQ3dFtQxaJS/mSWXDuvdBgMCVNW22IwyPpS/Bzsx8bgDeiSVRnU5hAqfjHO
 /I9FabRjrVzB/SwlJlTMINfKvkIv8B7f8nzxcXYVqU/jg9SKpiQwb+Z49MrwjIUv8Yr4
 POV4PXjuhuG6Cyl4kkfZi9JkVTH0C5q6KWW9bZ5uGyo1ZHxbppjJ9RyDcqVWPBCgR6Hj
 Fwl/LZiusXsWwoYqGRxfQHoWt8WYRiRZHoK17rZOK4XRyNSz8XY491mKPFEEwOStXM79
 Pv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754367074; x=1754971874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KPkTAG8PRvh+jrhA0lHk3kPHmNbHKVIwTe48CJUZ05c=;
 b=YAz+y7/Ik05pGhP/GZ8QwUEbeRFcf6BIrwh7xt//qodBFieaG6qKXrsOCydRiaFSJD
 GW/PsFd7p2gnZCsRN2t6vz8AyN/pppLYTuDyWx5zVHxr+hBNffLeprjY8PIVDikOK/r+
 Mus8IISa03u0JE3PXmylhRzo+UT+r5prj3HtkNTtOQOG0oncDxH0EphbYNmEU3DYRCpm
 YbM7EHlNO5LKbZeGH1zGDwzbPSTF7D2fjYruco3RKB5ZA+07PgoaJZU74tjO6lUCCJov
 t4ykOc60kCh+DgLkIBJYclKp8bpmx56zV1QErN/iSh+J/cQ2mQ5iiXqqHz/3X+8+0qrL
 p9Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo1hg5GiHHhlovXNr3k1MzfKE9/p4uI5De2vNGPKQfevsIKD1cJ4EKr40BkbEv7UZ9NtBRcnm1Kv1U@nongnu.org,
 AJvYcCX+O9H0Em8SdJQ//3rLG++ETfxIZehUfSZl7q6YQjSVh8TqC7K5LDIdQh/LwFw0gctm0JJ+i/AnjWCqGQ==@nongnu.org
X-Gm-Message-State: AOJu0YxpAofLFShwcpji9iBCSFyuOZPDMWKGoZLRetBzRsiZdKwa/H1f
 adi5+SeRgidMI3QTRRGiB0qOpce6ffomsfrLziefyYUomWWQx8n7Q5qf
X-Gm-Gg: ASbGnctLWn2LM46Cm8e/9YWY7xHj4TV0qagKKUW+CuUMCX/QSXHy/uXFbh2pOqf8vI9
 TfEAMqcV4Zk7ECFaIuLSe/ExTERvxNJV6Sdzm52bO76/vmBUmMruXyMHNeUnzd0B+mhWJjEfBX+
 Xia8wSguMo7Ddlpz7Eg4ZgAUEXZKx194UOnsfDShBKFkRDwe1zAdZZDPJ3TeCCe/xjumQpdYEGN
 V3U+crz7xJo2YKAKBtNtox7DAD4Rj35tSJl0t2d5sRanRKEBBXuMfNJqgCg1NPQVjmuor9WXIft
 hEDPCy3H9UIizAYie4HTf59m7nIjXdgNVOlLtMFxgDo7klwyBenf0nhbB35esDQBYYgcNu2Nl4G
 iY+bhyGrNxT8lJtWf+0R3gCs25pNuT+0xBtBY9BqI5U2GlXFxKQ28b+E4U6D3M/ckOkZC7MJ3VQ
 q9IGHcPDLmuUF1upzYj3r9ABY=
X-Google-Smtp-Source: AGHT+IEQJxesLlaczw/8Cc8FTlrLFRXDSKu5L3rnCllduqW3J+LPbdAnLS77piFiXZhodCj0dybvrw==
X-Received: by 2002:a05:620a:1a24:b0:7e8:922:f02b with SMTP id
 af79cd13be357-7e80922f11amr542118385a.25.1754367074536; 
 Mon, 04 Aug 2025 21:11:14 -0700 (PDT)
Received: from [192.168.2.61]
 (bras-base-ktnron0923w-grc-12-70-50-118-45.dsl.bell.ca. [70.50.118.45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f70397dsm628426785a.43.2025.08.04.21.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 21:11:14 -0700 (PDT)
Message-ID: <dbcfecfd-01ab-4ca4-b835-f3a3e6b3686e@gmail.com>
Date: Tue, 5 Aug 2025 00:11:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
To: Bernd Schubert <bschubert@ddn.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
 <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
 <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
Content-Language: en-CA
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x734.google.com
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



On 2025-08-04 7:33 a.m., Bernd Schubert wrote:
> Hi Brian,
> 
> sorry for my late reply, just back from vacation and fighting through
> my mails.
> 
> On 8/4/25 01:33, Brian Song wrote:
>>
>>
>> On 2025-08-01 12:09 p.m., Brian Song wrote:
>>> Hi Bernd,
>>>
>>> We are currently working on implementing termination support for fuse-
>>> over-io_uring in QEMU, and right now we are focusing on how to clean up
>>> in-flight SQEs properly. Our main question is about how well the kernel
>>> supports robust cancellation for these fuse-over-io_uring SQEs. Does it
>>> actually implement cancellation beyond destroying the io_uring queue?
>>> [...]
>>
> 
> I have to admit that I'm confused why you can't use umount, isn't that
> the most graceful way to shutdown a connection?
> 
> If you need another custom way for some reasons, we probably need
> to add it.
> 
> 
> Thanks,
> Bernd

Hi Bernd,

Thanks for your insights!

I think umount doesn't cancel any pending SQEs, right? From what I see, 
the only way to cancel all pending SQEs and transition all entries to 
the FRRS_USERSPACE state (unavailable for further fuse requests) in the 
kernel is by calling io_uring_files_cancel in do_exit, or 
io_uring_task_cancel in begin_new_exec.

 From my understanding, QEMU follows an event-driven model. So if we 
don't cancel the SQEs submitted by a connection when it ends, then 
before QEMU exits — after the connection is closed and the associated 
FUSE data structures have been freed — any CQE that comes back will 
trigger QEMU to invoke a previously deleted CQE handler, leading to a 
segfault.

So if the only way to make all pending entries unavailable in the kernel 
is calling do_exit or begin_new_exec, I think we should do some 
workarounds in QEMU.

Thanks,
Brian

