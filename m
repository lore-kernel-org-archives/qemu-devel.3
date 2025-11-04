Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AF6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCHd-0000Ba-AD; Tue, 04 Nov 2025 03:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGCHZ-0000Ab-8Q
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vGCHC-0006Sb-Vu
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762244424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RpqdAlQH+1jtuGUAWA2p6JR97+Pl955HMmQrBkYG6dQ=;
 b=PW7k69NQSyjaYs9OVtBQ75dzwkNEFe/w+cOKWQ8dCZ9vAmj0VcTgNjIeQBhmUZAL89avD9
 UVKr9SeFjEo3yEaqldV1XyWoAYagDVCBEjjl7SllJ7Uls6+Ax7B/T++AU/zeMZpHq+3Bcw
 eIF1wuNB8Wy1s9v5VzZ0EzKxv24QvWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-jGnzyArUOwaVB2cZGqI8RA-1; Tue, 04 Nov 2025 02:41:21 -0500
X-MC-Unique: jGnzyArUOwaVB2cZGqI8RA-1
X-Mimecast-MFC-AGG-ID: jGnzyArUOwaVB2cZGqI8RA_1762242080
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429cd08586cso1150535f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 23:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762242080; x=1762846880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RpqdAlQH+1jtuGUAWA2p6JR97+Pl955HMmQrBkYG6dQ=;
 b=BRmvi3eIqwSuHtAIlrVGrx6CNTiLgI6bA/8Qspphn41b0TIUYzUgGl5MdhXzKu8Q+C
 oQ4l7yZ1YMGKQH2AVpRrx1iUKmmGT+mFANan1dkC5YZ6bwpi5ToGQUxyvm4K6Bk4/0SB
 kqDeEmzR3q11Dz4+DIoPwTp4o+aDdzP+uAozjS4S9FWUUECCFioqWwdEgWcpErPw0lW2
 mTsJhx7GINt6WRCSpwHbh3EONTV4JLKBvEv5JItzmnoscmD9ZqkfhqTnsWRHQWxKYxGZ
 KWMQ70rn9CpK3T4PAf7/IYp7KfjBWwKV79Wzpaipl1AqHgMrUb6YADqxjh8tUxSIEZW7
 c9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762242080; x=1762846880;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RpqdAlQH+1jtuGUAWA2p6JR97+Pl955HMmQrBkYG6dQ=;
 b=ZTiVbFAm0lcy2yj6vo6i0fY0QOzF3E+4Sl7BQTONUL1AzxJdLDn5bpU8pQQSAObae/
 0FwnF7buDRLKhmGIzUMdDXKWx3ttaLo5+O8iayaM0S1SuJydBH+F4QVKJawMr9XtZe+T
 gH1leRCLWK/R+T7t+ifWyvTEpMYjWvVaSIkWwrc8VEQUg+a3Nx2pK9nKJOuOakC+EbYo
 Bkiu1MuXDAaN1AoSpsZ+df4hEd41WmKYK0REKIx5D1YDOAZxzjSzrDjzkhAnzg1wNlvw
 ijVvjl5e5QGdtV0+6G13Y3B1Rl8h6F9GNp/bjWZpEnawSf79MPfgFSGnB5voByguw0r4
 T1vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhXRN51Vhmn9pvueM96aIH3RQwqf8oBIYCrxrlfJ0TM1kOR76vlZ8kdDSEOzvUGJeG6UZqP5jvPJAS@nongnu.org
X-Gm-Message-State: AOJu0YzX/pUlDv3NYU2Q5JQBNkYKEjQlsYMbt1h9QXG+Y4HbV3SGOpjf
 ul1Y8+dehp9L0Cxu6rdN3Y3P7sPoCRT9JyNrRIz9uopjNNPg4bygzzMGAI9zMts2cH4qjOn1XKG
 YRmdD2uiga/UHJQqiZfbrUk+qOWMU5Wg3zJtxkGoFLIlTE21ADtEhcZd9
X-Gm-Gg: ASbGncv5UgzBCLGQ8dNTFPU6Zk9ae3SnugjsAtSLa9Fea3i+wmMEO1iGTQebEHrZxzV
 hfdjgI9ycSIWMotmENpvUKe13wjpBAlOTNgUePy0BUqtXiccw/8MUu4eVpixa9xalD4gaaMWmuQ
 XhpdXdQ9SUQX8cgAS5aEi74o6R3FXAVD0v7BtDGUErs2kEgaGU+MC4LkbyfAMmrbAHwzI+eKcXA
 AF2PcLiwnKFYxz/IBgMfvbOsoGMandIfd8Wzfw2M5QFcpaYbvUg06/gkimIalUMkANbRhR1OQwP
 CxHgvl6kiFmTVZUSxrgIJCtH4na+owC+uqnhxkxPSmH3iGMujVDw1mLRLoo+MRKP+oCsx0Qz
X-Received: by 2002:a05:6000:26c1:b0:429:8b01:c093 with SMTP id
 ffacd0b85a97d-429bd680c85mr12362474f8f.15.1762242079718; 
 Mon, 03 Nov 2025 23:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEBduTRObamzJWM6WVJLhbFF2quqadBk3SSMj1hkVuKXqPq/WqHIThWeUczPeR6DlQE/vE1A==
X-Received: by 2002:a05:6000:26c1:b0:429:8b01:c093 with SMTP id
 ffacd0b85a97d-429bd680c85mr12362433f8f.15.1762242079174; 
 Mon, 03 Nov 2025 23:41:19 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773d81cb03sm189975675e9.13.2025.11.03.23.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 23:41:18 -0800 (PST)
Message-ID: <30a9e854-e37b-4494-b372-f76ce6bdce25@redhat.com>
Date: Tue, 4 Nov 2025 08:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
 <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/11/2025 02.45, Akihiko Odaki wrote:
> On 2025/11/03 22:59, Thomas Huth wrote:
>> On 28/10/2025 18.34, Paolo Bonzini wrote:
>>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>> Borrow the concept of force quiescent state from Linux to ensure readers
>>> remain fast during normal operation and to avoid stalls.
>>
>>   Hi Akihiko,
>>
>> looks like this commit has introduced a regression with the "replay" 
>> functional test on the alpha target.
>> When I run something like:
>>
>>   pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough \
>>    --num-processes 1 --repeat 10 func-alpha-replay
>>
>> in the build folder, approx. half of the test runs are failing for me now.
>>
>> I bisected the issue to this patch here - when I rebuild qemu-system- 
>> alpha with the commit right before this change here, the above test runs 
>> work fine, so I'm pretty sure that the problem has been introduced by this 
>> commit here.
>>
>> Could you please have a look?
> 
> I cannot reproduce it with commit 55d98e3edeeb ("rcu: Unify force quiescent 
> state").
> 
> Can you provide meson-logs/testlog-thorough.txt so that I can look into the 
> failure you are facing? If you think you have something useful for 
> debugging, please share it to me too.

There's not much in that testlog-thorough.txt that could be helpful here,
it's basically just the information that the test has been killed due to
the timeout:

==================================== 1/1 ===================================
test:         qemu:func-thorough+func-alpha-thorough+thorough / func-alpha-replay
start time:   07:25:26
duration:     90.01s
result:       killed by signal 15 SIGTERM
command:      RUST_BACKTRACE=1 QEMU_TEST_QEMU_IMG=/tmp/qemu-rcu/qemu-img QEMU_TEST_GDB=/usr/bin/gdb MALLOC_PERTURB_=255 MESON_TEST_ITERATION=1 PYTHONPATH=/home/thuth/devel/qemu/python:/home/thuth/devel/qemu/tests/functional G_TEST_SLOW=1 SPEED=thorough QEMU_TEST_QEMU_BINARY=/tmp/qemu-rcu/qemu-system-alpha ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 LD_LIBRARY_PATH=/tmp/qemu-rcu/tests/tcg/plugins:/tmp/qemu-rcu/contrib/plugins UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QEMU_BUILD_ROOT=/tmp/qemu-rcu /tmp/qemu-rcu/pyvenv/bin/python3 /home/thuth/devel/qemu/tests/functional/alpha/test_replay.py
=============================================================================

Summary of Failures:

1/1 qemu:func-thorough+func-alpha-thorough+thorough / func-alpha-replay TIMEOUT        90.01s   killed by signal 15 SIGTERM


There is also not that much helpful information in
tests/functional/alpha/test_replay.AlphaReplay.test_clipper, apart from
the console.log file. For a good run, the console log looks like this:

2025-11-04 08:16:46,148: PCI: 00:01:0 class 0101 id 1095:0646
2025-11-04 08:16:46,149: PCI:   region 0: 0000c000
2025-11-04 08:16:46,149: PCI:   region 1: 0000c008
2025-11-04 08:16:46,149: PCI:   region 2: 0000c010
2025-11-04 08:16:46,149: PCI:   region 3: 0000c018
2025-11-04 08:16:46,149: PCI:   region 4: 0000c020
2025-11-04 08:16:46,149: PCI: 00:07:0 class 0601 id 8086:0484
2025-11-04 08:16:48,149: [    0.000000] Initializing cgroup subsys cpu
2025-11-04 08:16:48,149: [    0.000000] Linux version 2.6.26-2-alpha-generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
2025-11-04 08:16:48,150: [    0.000000] Booting GENERIC on Tsunami variation Clipper using machine vector Clipper from SRM
2025-11-04 08:16:48,150: [    0.000000] Major Options: MAGIC_SYSRQ
2025-11-04 08:16:48,150: [    0.000000] Command line: printk.time=0 console=ttyS0
2025-11-04 08:16:48,150: [    0.000000] memcluster 0, usage 1, start        0, end       15
2025-11-04 08:16:48,150: [    0.000000] memcluster 1, usage 0, start       15, end    16384
2025-11-04 08:16:48,150: [    0.000000] freeing pages 15:2048
2025-11-04 08:16:48,150: [    0.000000] freeing pages 2987:16384
2025-11-04 08:16:48,151: [    0.000000] reserving pages 2987:2988
2025-11-04 08:16:48,151: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16272
2025-11-04 08:16:48,151: [    0.000000] Kernel command line: printk.time=0 console=ttyS0
2025-11-04 08:16:57,358: PCI: 00:01:0 class 0101 id 1095:0646
2025-11-04 08:16:57,358: PCI:   region 0: 0000c000
2025-11-04 08:16:57,358: PCI:   region 1: 0000c008
2025-11-04 08:16:57,359: PCI:   region 2: 0000c010
2025-11-04 08:16:57,359: PCI:   region 3: 0000c018
2025-11-04 08:16:57,359: PCI:   region 4: 0000c020
2025-11-04 08:16:57,360: PCI: 00:07:0 class 0601 id 8086:0484
2025-11-04 08:17:08,468: [    0.000000] Initializing cgroup subsys cpu
2025-11-04 08:17:08,470: [    0.000000] Linux version 2.6.26-2-alpha-generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
2025-11-04 08:17:08,471: [    0.000000] Booting GENERIC on Tsunami variation Clipper using machine vector Clipper from SRM
2025-11-04 08:17:08,471: [    0.000000] Major Options: MAGIC_SYSRQ
2025-11-04 08:17:08,472: [    0.000000] Command line: printk.time=0 console=ttyS0
2025-11-04 08:17:08,472: [    0.000000] memcluster 0, usage 1, start        0, end       15
2025-11-04 08:17:08,473: [    0.000000] memcluster 1, usage 0, start       15, end    16384
2025-11-04 08:17:08,473: [    0.000000] freeing pages 15:2048
2025-11-04 08:17:08,474: [    0.000000] freeing pages 2987:16384
2025-11-04 08:17:08,474: [    0.000000] reserving pages 2987:2988
2025-11-04 08:17:08,475: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16272
2025-11-04 08:17:08,476: [    0.000000] Kernel command line: printk.time=0 console=ttyS0

I.e. the replay worked as expected. When it fails, console.log only contains:

2025-11-04 08:25:26,601: PCI: 00:01:0 class 0101 id 1095:0646
2025-11-04 08:25:26,601: PCI:   region 0: 0000c000
2025-11-04 08:25:26,601: PCI:   region 1: 0000c008
2025-11-04 08:25:26,601: PCI:   region 2: 0000c010
2025-11-04 08:25:26,601: PCI:   region 3: 0000c018
2025-11-04 08:25:26,601: PCI:   region 4: 0000c020
2025-11-04 08:25:26,602: PCI: 00:07:0 class 0601 id 8086:0484
2025-11-04 08:25:28,601: [    0.000000] Initializing cgroup subsys cpu
2025-11-04 08:25:28,602: [    0.000000] Linux version 2.6.26-2-alpha-generic (Debian 2.6.26-29) (dannf@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1 Sun Mar 4 21:08:03 UTC 2012
2025-11-04 08:25:28,602: [    0.000000] Booting GENERIC on Tsunami variation Clipper using machine vector Clipper from SRM
2025-11-04 08:25:28,602: [    0.000000] Major Options: MAGIC_SYSRQ
2025-11-04 08:25:28,602: [    0.000000] Command line: printk.time=0 console=ttyS0
2025-11-04 08:25:28,602: [    0.000000] memcluster 0, usage 1, start        0, end       15
2025-11-04 08:25:28,602: [    0.000000] memcluster 1, usage 0, start       15, end    16384
2025-11-04 08:25:28,602: [    0.000000] freeing pages 15:2048
2025-11-04 08:25:28,603: [    0.000000] freeing pages 2987:16384
2025-11-04 08:25:28,603: [    0.000000] reserving pages 2987:2988
2025-11-04 08:25:28,603: [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16272
2025-11-04 08:25:28,603: [    0.000000] Kernel command line: printk.time=0 console=ttyS0

I.e. the replay did not work.

Could this RCU stuff somehow influence the replay mechanism in QEMU?

  Thomas


