Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D970C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBhD-0000WA-O0; Tue, 22 Jul 2025 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBh9-0000RA-Cx; Tue, 22 Jul 2025 08:02:07 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1ueBh6-0001Ll-5j; Tue, 22 Jul 2025 08:02:06 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-615a4b504b2so1226484eaf.1; 
 Tue, 22 Jul 2025 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753185721; x=1753790521; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OAk5oJIRGeHnc9dUKgFBjmqSc2DM+INaoUXU4oCRw68=;
 b=RjEKhLdiMvKRD+QslIxn3yHEYOQEhglQE8tX5P8TwmsVJ00wnMr/nfaTCp1gEZwj1T
 ye5sQc4X1Xtd8vHkEHKW703YB85G/Ql/jYsaegQh2Wz+/Y2RIgA0H6kY9jScJzU+mPAh
 vr4Q7nQaSfzPtzwrQt96J4r64r4tD+rJMEO9/4bVSzUP3hTMod5bjEnsxNGEOsvSYdpK
 MSn9UKpo0/beFWHsz6yTGwgP4OgrgzbsGXVA/eJz17c91Zekb9R6t8bs1ZReeaRj4Np3
 AQdtm0/b4p3ehM14ZaHs19hphQ3cf2/ViZ7h300v5i4HomYZVI3YqoYVES7gFFZxnIlL
 LvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185721; x=1753790521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAk5oJIRGeHnc9dUKgFBjmqSc2DM+INaoUXU4oCRw68=;
 b=dTJowvrXvt8r8dlciTbC+CP8ryvukOYJ8uVek/l9tk4KHMPYA+S+U9kUqpaNsR898v
 3rDTkJpEzFRVpzVYei/x2QNIZEnqb/qkkNTeYSCt2eN7xM41I/RRCZdwKKAC1cmDre6T
 cSBScttJ/YMdjAe1wGoqUUaHdJ1e+Cw6P+mZ6POJfZ0YJZ3a6lXyscVWOlQAP7h1gLAQ
 gq0TsO7Y2uKpykjwxymK9otyHlPHCeaJUT01M+ZDow0G5EXQ69rxneHOhqcizIR2swKJ
 aSX4gTJaHw0J0cmcCfYgy6iks132rndjl1rAaNEKbNMoJ28sJc5SR6Z4fmx6m3hHdppj
 +USw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIS9d5nFqN4QLQsN7r1PosKgBk9LZB0t1mlRYUuX5IuiqyPqG5XPpP9tiIYlYlOCjoWne1l838ujT+@nongnu.org
X-Gm-Message-State: AOJu0Yxxjc6xkktk0XTWKJkzCgBolXIUP1SmmDhTrR/iXUFXRSXKgqBY
 zfBb+6gIzvA9sw9xDWm7oEI/uVFgaITkyFpUJkCIRXzKsTnhnHJf2ltXOTxH3oUxAnvds1WBcIM
 rc80Z+PatLI3afQ0qkVM5DM5RmKRS9xWaDg==
X-Gm-Gg: ASbGncu20QI3cnW5L1En79xwcXDWdTZJ1DDBcvDdr0lBbEqONq2uAIrPY0LSjVJylfM
 cC8GuXlk1vAuHBI5mqZLfJFAFpswIQvJO1SRQ7aEwlVG1p4O/X+GjpIzoJT0VXVFm2iCy5x3mbJ
 0mYDdnOnPuf+wWKKEhEjhFbbCLoxgAaw09j2Kk9ELlpm9A7UDui7e6qRFGKI6jvrjs/q8LQbTs2
 uYXVg==
X-Google-Smtp-Source: AGHT+IGkkWAbO5Ti0jWvh6ORG2kjDG+INolM7kWLj6ncfxGwEmpu9MKkqvfRE2vjXRKTWZecuF4Tld/jwbjkQYbyAZM=
X-Received: by 2002:a05:6808:3c4b:b0:40c:5b59:6b8d with SMTP id
 5614622812f47-41d04d8e87cmr22024315b6e.26.1753185720535; Tue, 22 Jul 2025
 05:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250720161351.GA32887@fedora>
In-Reply-To: <20250720161351.GA32887@fedora>
From: Brian Song <hibriansong@gmail.com>
Date: Tue, 22 Jul 2025 08:00:00 -0400
X-Gm-Features: Ac12FXz4rIGotoXUgnLrRXthsoL4efyH8QkpMn2HItSmHUHmqjAaEQHPk216V_c
Message-ID: <CAKWCU7XqQc=cyn36MR9C7R_0S2ZKEPBdt6eUOZ-LxtRZuegsbw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 bschubert@ddn.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=hibriansong@gmail.com; helo=mail-oo1-xc2e.google.com
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

On 7/20/25 12:13 PM, Stefan Hajnoczi wrote:
> On Wed, Jul 16, 2025 at 02:38:23PM -0400, Brian Song wrote:
>> This RFC patch represents an initial implementation of the FUSE-over-
>> io_uring Exports idea proposed for Google Summer of Code (2025) under
>> the QEMU community:
>> https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports
>>
>> The implementation approach is primarily borrowed from how libfuse
>> interacts with the kernel.
>>
>> FUSE-over-io_uring (https://docs.kernel.org/next/filesystems/fuse-io-
>> uring.html) has been officially merged into the Linux kernel. The idea
>> is to replace the traditional /dev/fuse based communication with a more
>> efficient io_uring-based approach. In this model, userspace registers
>> io_uring SQEs via the FUSE_IO_URING_CMD_REGISTER opcode, and then waits
>> for the kernel to forward FUSE requests as CQEs. These are processed by
>> the FUSE exports implementation in userspace and then committed back to
>> the kernel using FUSE_IO_URING_CMD_COMMIT_AND_FETCH.
>>
>> To enable this feature in qemu-export-daemon, simply add the uring=on
>> option to the export configuration.
>
> For consistency with the --blockdev file,aio=io_uring option, please
> name it "io_uring=on" instead of "uring=on".
>

It seems we are not allowed to use '_' here.

In file included from ../storage-daemon/qapi/qapi-schema.json:57:

../storage-daemon/qapi/../../qapi/block-export.json: In struct
'BlockExportOptionsFuse':

../storage-daemon/qapi/../../qapi/block-export.json:191: name of 'data'
member '*io_uring' must not use uppercase or '_'


>>
>> As this patch is still in the RFC stage, it currently supports **only
>> single thread**. Due to protocol requirements in FUSE-over-io_uring,
>> the number of FUSE threads must match the number of CPUs. Therefore,
>> this initial version only works on single-core VMs (i.e., QEMU started
>> with -smp 1) or single core machine.
>>
>> Brian Song (1):
>>    block/export: FUSE-over-io_uring Support for QEMU FUSE Exports
>>
>>   block/export/fuse.c                  | 423 +++++++++++++++++++++++++--
>>   docs/tools/qemu-storage-daemon.rst   |  10 +-
>>   qapi/block-export.json               |   6 +-
>>   storage-daemon/qemu-storage-daemon.c |   1 +
>>   util/fdmon-io_uring.c                |   5 +-
>>   5 files changed, 420 insertions(+), 25 deletions(-)
>>
>> --
>> 2.50.1
>>

