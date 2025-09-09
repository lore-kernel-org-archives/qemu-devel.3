Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E2CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 20:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5JT-0002c1-HG; Tue, 09 Sep 2025 16:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw5JP-0002bO-6r; Tue, 09 Sep 2025 16:51:35 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uw5JE-000167-Uk; Tue, 09 Sep 2025 16:51:32 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-70ddadde2e9so46462416d6.0; 
 Tue, 09 Sep 2025 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757451074; x=1758055874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9as5JFbY5LWi+h75lj7lrirVwAZOLwbP4aBR3nCVTk=;
 b=ibmD7QSYeuhu5kYqpePrYB4roC6eYZ/dbiwtVxHcPAPcVKLuSu2TcbmcpxBeFPyEEO
 g5FlMY8P8ZVt6ruWWLCFTXGtTs6mZYq5PIkhvybJA2/WyeguIsi3e7HvNRWVFVc7mzCA
 3gxHMT22RZhPjPd5Y8AjBzlkpmz5uLtSV39jcBIkfCHAN9+1Ub8ysOTK06VcJXc2bX5k
 FYgBIu7xtFW7dPPVIEXFP0dDgl15LWQDE9SaexN+REulTNWRmRA0ZqXbGJaF7CzM/AG5
 AQM0JYfxk2FSHEXkDHBJYhKr+a9glPOsWpVDowUpify4RzT1xgU4bNXQ+IjlLdsZq7aC
 xF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757451074; x=1758055874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j9as5JFbY5LWi+h75lj7lrirVwAZOLwbP4aBR3nCVTk=;
 b=eM6m3oDciIm1wvyyPCX3Yfe8/c8+q82v6CoF3YgPuH6TBgdhRpYFa3Y05slPwmSj3m
 snvhoEhwv4GVAMThd9EfuvOpsVf52IAXHSaznEXMgLz49g9JLzH0tZKYsW+edkY7OZnT
 gmjkd73gE0UZcoLCFNokKLmmiuMwimtoL5ACyC7QNtZNxmVBnxDoZ5j0+Ygc0bQxEAvq
 w3OgerI3pLb8WGM2REvvVm1tp4Ejo+dWfaptsHCb4CzFiRWG9gzWzWebeg319zwka4jd
 Mj41SUzudXKylB61RVQPlCpr5B7/pRMWo39QJJZVv1xjqYI8jtjWpx9302Vxp4/gIugR
 4eMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW10ULRus3Wh1zW/swENQafCM+Vk8fYzT7bqPtZlEe4QQX0XLHcRGNOatGnmc4sgY/S9emjG031EB7/@nongnu.org
X-Gm-Message-State: AOJu0YwmtdKxluRR3qZyHA7c+jA+ZknVwyWlTZN+b38G75BfNCz4ornq
 zK4KDZqxqaYSgms/ypZlByTuIbBnMZVHQGHjaz0LtZD1RuHMI0x3acXV
X-Gm-Gg: ASbGncvI3FKW0mjv8zhsMBGA+QQQpVzZ7sY8fVcLYU9v6H2ABHZqGkmDCkZYxcLAO0B
 jo0TS4R64l/V7x2wEG1w+vwr6eFEoHYMDTlINCJTn1fXXI+TdR/KGP5Vx3WINXDPZMnt5Axlm9x
 xZsLxjAmzNOZ7Od2KZPTKIpBDWcXhprgjXiUjxkIhbkz/nb9X23z0W/qs9YIHNhUZXhW63+XD8j
 /cgiRKMPi79i/R7ZL+Tpi1CI9oOL7nE5XqdDXLn3uKFPtWQrXwYnxbTpSoMG5TQr2cDB/GTjiXW
 QXCpxt4B7z2uQQP5ZTzDAjVFWXEfoC4n9OdyzbCOohs24DVLTizYV8MOBwj7Gop7Em2Yv53irkI
 Ep8jZtOme5Po/lkU21/X4RdjvYvgy/AI7JK+w2sg9k2jIuD8eT8+mrzULqFRNO5Ho9YB51obTZC
 s8DuUQczUJGxc=
X-Google-Smtp-Source: AGHT+IHZ4DhGZMq9Nm5sp3ICo6qnXdCCm/8Afm1lLfysGW9gBJE0nUmUNWM17ar+5g86BkRkEZBiVw==
X-Received: by 2002:a05:6214:20a1:b0:71f:55eb:d517 with SMTP id
 6a1803df08f44-7391bf48d2fmr154043286d6.4.1757451074189; 
 Tue, 09 Sep 2025 13:51:14 -0700 (PDT)
Received: from [10.36.130.207]
 (wn-campus-nat-129-97-124-207.dynamic.uwaterloo.ca. [129.97.124.207])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720ac16de30sm148621486d6.7.2025.09.09.13.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 13:51:13 -0700 (PDT)
Message-ID: <c280787c-0db5-4a63-8e22-ce50726e7ebe@gmail.com>
Date: Tue, 9 Sep 2025 16:51:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-5-hibriansong@gmail.com>
 <20250909193830.GF218449@fedora>
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250909193830.GF218449@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 9/9/25 3:38 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 29, 2025 at 10:50:25PM -0400, Brian Song wrote:
>> To test FUSE-over-io_uring, set the environment variable
>> FUSE_OVER_IO_URING=1. This applies only when using the
>> 'fuse' protocol.
>>
>> $ FUSE_OVER_IO_URING=1 ./check -fuse
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>> ---
>>   tests/qemu-iotests/check     |  2 ++
>>   tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++---------
>>   2 files changed, 36 insertions(+), 11 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 545f9ec7bd..c6fa0f9e3d 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
>>           mg.add_argument('-' + fmt, dest='imgfmt', action='store_const',
>>                           const=fmt, help=f'test {fmt}')
>>   
>> +    # To test FUSE-over-io_uring, set the environment variable
>> +    # FUSE_OVER_IO_URING=1. This applies only when using the 'fuse' protocol
>>       protocol_list = ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
>>       g_prt = p.add_argument_group(
>>           '  image protocol options',
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index e977cb4eb6..f8b79c3810 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -539,17 +539,38 @@ _make_test_img()
>>           touch "$export_mp"
>>           rm -f "$SOCK_DIR/fuse-output"
>>   
>> -        # Usually, users would export formatted nodes.  But we present fuse as a
>> -        # protocol-level driver here, so we have to leave the format to the
>> -        # client.
>> -        # Switch off allow-other, because in general we do not need it for
>> -        # iotests.  The default allow-other=auto has the downside of printing a
>> -        # fusermount error on its first attempt if allow_other is not
>> -        # permissible, which we would need to filter.
> 
> This comment applies to both branches of the if statement. I think
> keeping it here is slightly better.
> 
>> -        QSD_NEED_PID=y $QSD \
>> -              --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>> -              --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
>> -              &
>> +        if [ -n "$FUSE_OVER_IO_URING" ]; then
>> +            nr_cpu=$(nproc 2>/dev/null || echo 1)
>> +            nr_iothreads=$((nr_cpu / 2))
>> +            if [ $nr_iothreads -lt 1 ]; then
>> +                nr_iothreads=1
>> +            fi
> 
> Please add a comment explaining that the purpose of this configuration
> based on the number of CPUs is to test multiple IOThreads when the host
> allows it, since that is a more interesting case then just 1 IOThread.
> Many other configurations are possible as well, but not all of them can
> be tested because the test matrix would be large.
> 
>> +
>> +            iothread_args=""
>> +            iothread_export_args=""
>> +            for ((i=0; i<$nr_iothreads; i++)); do
>> +                iothread_args="$iothread_args --object iothread,id=iothread$i"
>> +                iothread_export_args="$iothread_export_args,iothread.$i=iothread$i"
>> +            done
>> +
>> +            QSD_NEED_PID=y $QSD \
>> +                    $iothread_args \
>> +                    --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>> +                    --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off,io-uring=on$iothread_export_args \
>> +                &
>> +        else
>> +            # Usually, users would export formatted nodes.  But we present fuse as a
>> +            # protocol-level driver here, so we have to leave the format to the
>> +            # client.
>> +            # Switch off allow-other, because in general we do not need it for
>> +            # iotests.  The default allow-other=auto has the downside of printing a
>> +            # fusermount error on its first attempt if allow_other is not
>> +            # permissible, which we would need to filter.
>> +            QSD_NEED_PID=y $QSD \
>> +                --blockdev file,node-name=export-node,filename=$img_name,discard=unmap \
>> +                --export fuse,id=fuse-export,node-name=export-node,mountpoint="$export_mp",writable=on,growable=on,allow-other=off \
>> +                &
>> +        fi
>>   
>>           pidfile="$QEMU_TEST_DIR/qemu-storage-daemon.pid"
>>   
>> @@ -592,6 +613,8 @@ _rm_test_img()
>>   
>>           kill "${FUSE_PIDS[index]}"
>>   
>> +        sleep 1
>> +
> 
> What is the purpose of this sleep command?
> 

I don’t exactly remember why. It might get stuck if there’s no sleep 
here. I remember we discussed this problem in earlier emails.

>>           # Wait until the mount is gone
>>           timeout=10 # *0.5 s
>>           while true; do
>> -- 
>> 2.45.2
>>


