Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F5ACAC587
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtQq-0008I9-RW; Thu, 11 Sep 2025 22:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uwtQp-0008Hf-23
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:22:35 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uwtQl-0006Fw-3T
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 22:22:34 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7e8704e9687so152291185a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 19:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757643746; x=1758248546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XNGfVOHwOxsuG1+IlKfopeHk0m8RMByLbQO+DlJvGeE=;
 b=GTR+X+Y0R1+gVI4EPj2Z5Un4MfAdNRprorIlhr0x55d6bGiVa3dHZ4YojtcebV71sP
 9rPFrZLBeXAJy693aMQluYf65Xn/Fs38RMug6t4URBobqpLeKOtkn4/Mbs3ISAunNVDK
 vtTqW2CLJW/J3r3ZdaNJZ5rwxRVWZiXkO8VM+Bxyzo8guOcBTe9FKDL6DigdpRj0lTrF
 b3u6fAH64vPUMWC7tSi0n/eX85K7eTXPwOQzRntSWVPjC6BZ7w0HBhldyuH92dU/oOSB
 KhCX+Nd3UZJL0Jxnp9RIPSFKp9iNC0EvBJc17Mulr2eak9CB+bwGVWn3SLbEf1BOjgvS
 pURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757643746; x=1758248546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XNGfVOHwOxsuG1+IlKfopeHk0m8RMByLbQO+DlJvGeE=;
 b=Swkv0/KbCiNKOPF7N4EeaNTyhuTeA75/QGlx2IPE/k8/sLTljhuzp55fIhLobemKeW
 J3gi/aLDWEP+CT7fFmO8PxjMl6oIFt5AoBevaIX/IjtcIE+kLShBFWPtT0bqJ36Esqoo
 RYzYAZymgzpGBsnSODjpAzDdQ4NVjxMUUgleaFccGlhWi3k1R3GC4nYSx4UUWjdbPUe8
 fSNJFPgDkQFm4Ru/BglvA5aYoAwxtrhhvvyGKVMlAFkSRhB1zum02ic0HrKfyWRYprJD
 w2eD17xMd9S9ys6Gq/LMRTQeevcZ97G5tav2vKp9OK0W2MOzxQay8Z6a0U+HVyLR9cvM
 qPmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMukObLsaM52jchY/j4ybPkjM+p/YprewMHDMjTbkMPpm7/40fxr5E7ED0LcspIoXB6zvtQFBgtcTF@nongnu.org
X-Gm-Message-State: AOJu0YzikiVRMT+WvFY1e2csV0Gq2QckqKUSLEU6nx4xcmrhbpdltlXa
 YtJ64VjhgGsV01UOGN10/VyHoxHAfoUhhn1g7CUw+xPhdQVPXLkZNAqO
X-Gm-Gg: ASbGnctFVddOwa6xRILsbq/sRdYSy9ub9T1IwATIDt4E6BYVAtEIqxmEdIBrHxjBaIV
 iMs9pLNrvfrJTPnjb6y/NwE7IvFTeD78PEDvFPla8xQV0a+FCCb0jDZljRuAESW2BPKKQGE7OCk
 LBw9Qts7D0shlU4diYOU4dw4Hp8kFdQ6guTUJOeaFcKIVe/3qijsOh7SQLYtD66s16iPkY88TmA
 xz7zP1zrWJ8hpIsGjg6tPD+q44IQmONjVGu2kMVvXIdSOkG5tkeSTBOldllFonnshtsn/8jfED4
 x9MP7YEXNnEwowO386tXFsmCE1MeobrvLpXewXUJr3jvgJl6OUBwZ1PfGuQMM0/eyCU2/qbUwdT
 5MXJIZYPxdirBIuvOIIbq9dik91Y=
X-Google-Smtp-Source: AGHT+IHVtuXca5QjEjQnbkgmShQiDWfazm7ar4GqJJt+/syQKvEDHfvC9HdyRTWiCeIVGI95zwOMtg==
X-Received: by 2002:a05:620a:8a82:b0:81d:398d:fda8 with SMTP id
 af79cd13be357-823fc1d4a80mr152939785a.22.1757643745788; 
 Thu, 11 Sep 2025 19:22:25 -0700 (PDT)
Received: from [192.168.0.156] ([45.62.219.80])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c8ac45a3sm198911985a.5.2025.09.11.19.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 19:22:25 -0700 (PDT)
Message-ID: <f97b89e6-1faa-4f66-9630-99b7d387e90c@gmail.com>
Date: Thu, 11 Sep 2025 22:22:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-5-hibriansong@gmail.com>
 <20250909193830.GF218449@fedora>
 <c280787c-0db5-4a63-8e22-ce50726e7ebe@gmail.com>
 <20250910131418.GA246746@fedora>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250910131418.GA246746@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/10/25 9:14 AM, Stefan Hajnoczi wrote:
> On Tue, Sep 09, 2025 at 04:51:12PM -0400, Brian Song wrote:
>>
>>
>> On 9/9/25 3:38 PM, Stefan Hajnoczi wrote:
>>> On Fri, Aug 29, 2025 at 10:50:25PM -0400, Brian Song wrote:
>>>> To test FUSE-over-io_uring, set the environment variable
>>>> FUSE_OVER_IO_URING=1. This applies only when using the
>>>> 'fuse' protocol.
>>>>
>>>> $ FUSE_OVER_IO_URING=1 ./check -fuse
>>>>
>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>> ---
>>>>    tests/qemu-iotests/check     |  2 ++
>>>>    tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++---------
>>>>    2 files changed, 36 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>>>> index 545f9ec7bd..c6fa0f9e3d 100755
>>>> --- a/tests/qemu-iotests/check
>>>> +++ b/tests/qemu-iotests/check
>>>> @@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
>>>>            mg.add_argument('-' + fmt, dest='imgfmt', action='store_const',
>>>>                            const=fmt, help=f'test {fmt}')
>>>> +    # To test FUSE-over-io_uring, set the environment variable
>>>> +    # FUSE_OVER_IO_URING=1. This applies only when using the 'fuse' protocol
>>>>        protocol_list = ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
>>>>        g_prt = p.add_argument_group(
>>>>            '  image protocol options',
>>>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>>>> index e977cb4eb6..f8b79c3810 100644
>>>> --- a/tests/qemu-iotests/common.rc
>>>> +++ b/tests/qemu-iotests/common.rc
>>>> @@ -539,17 +539,38 @@ _make_test_img()
>>>>            touch "$export_mp"
>>>>            rm -f "$SOCK_DIR/fuse-output"
>>>> -        # Usually, users would export formatted nodes.  But we present fuse as a
>>>> -        # protocol-level driver here, so we have to leave the format to the
>>>> -        # client.
>>>> -        # Switch off allow-other, because in general we do not need it for
>>>> -        # iotests.  The default allow-other=auto has the downside of printing a
>>>> -        # fusermount error on its first attempt if allow_other is not
>>>> -        # permissible, which we would need to filter.
>>>
>>> This comment applies to both branches of the if statement. I think
>>> keeping it here is slightly better.
>>>
>>>> -        QSD_NEED_PID=y $QSD \
>>>> -              --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>>>> -              --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
>>>> -              &
>>>> +        if [ -n "$FUSE_OVER_IO_URING" ]; then
>>>> +            nr_cpu=$(nproc 2>/dev/null || echo 1)
>>>> +            nr_iothreads=$((nr_cpu / 2))
>>>> +            if [ $nr_iothreads -lt 1 ]; then
>>>> +                nr_iothreads=1
>>>> +            fi
>>>
>>> Please add a comment explaining that the purpose of this configuration
>>> based on the number of CPUs is to test multiple IOThreads when the host
>>> allows it, since that is a more interesting case then just 1 IOThread.
>>> Many other configurations are possible as well, but not all of them can
>>> be tested because the test matrix would be large.
>>>
>>>> +
>>>> +            iothread_args=""
>>>> +            iothread_export_args=""
>>>> +            for ((i=0; i<$nr_iothreads; i++)); do
>>>> +                iothread_args="$iothread_args --object iothread,id=iothread$i"
>>>> +                iothread_export_args="$iothread_export_args,iothread.$i=iothread$i"
>>>> +            done
>>>> +
>>>> +            QSD_NEED_PID=y $QSD \
>>>> +                    $iothread_args \
>>>> +                    --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>>>> +                    --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off,io-uring=on$iothread_export_args \
>>>> +                &
>>>> +        else
>>>> +            # Usually, users would export formatted nodes.  But we present fuse as a
>>>> +            # protocol-level driver here, so we have to leave the format to the
>>>> +            # client.
>>>> +            # Switch off allow-other, because in general we do not need it for
>>>> +            # iotests.  The default allow-other=auto has the downside of printing a
>>>> +            # fusermount error on its first attempt if allow_other is not
>>>> +            # permissible, which we would need to filter.
>>>> +            QSD_NEED_PID=y $QSD \
>>>> +                --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>>>> +                --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
>>>> +                &
>>>> +        fi
>>>>            pidfile="$QEMU_TEST_DIR/qemu-storage-daemon.pid"
>>>> @@ -592,6 +613,8 @@ _rm_test_img()
>>>>            kill "${FUSE_PIDS[index]}"
>>>> +        sleep 1
>>>> +
>>>
>>> What is the purpose of this sleep command?
>>>
>>
>> I don’t exactly remember why. It might get stuck if there’s no sleep here. I
>> remember we discussed this problem in earlier emails.
> 
> The purpose needs to be understood. Otherwise there is a good chance
> that the test will fail randomly in a continuous integration environment
> where things sometimes take a long time due to CPU contention.
> 
> Stefan

I think the issue lies in our current approach of using df to check 
whether the FUSE mount has been unmounted.

When we traced df with strace, we found that its logic for checking the 
mount point is:
=> Call mount to read the system's mount information
=> Use statfs() to get the filesystem statistics

But our current test code exits with the following sequence:
=> Kill the FUSE process
=> The kernel starts cleaning up the FUSE mount point
=> df calls statfs(), which requires communication with the FUSE process 
But the FUSE process might still be cleaning up, causing the 
communication to fail
=> df then returns an error or stale information
=> Our detection logic misinterprets this and immediately deletes the 
mounted image

Since we only need to check the system's mount information, we can just 
call mount and grep "$img" to verify whether the image has been 
successfully unmounted.

Does it make sense?

Brian

