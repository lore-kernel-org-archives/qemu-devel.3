Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C09C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 19:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5roq-0008Nr-Hm; Fri, 18 Apr 2025 15:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5roL-0008DH-07
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:55:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u5roC-00024R-5k
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 15:55:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so15453525e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745006130; x=1745610930; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58Fr5Jc3+gbOo6HFHWawNhIv6PlRPPR0lUnnIxKjYwM=;
 b=EOPeUe7e4Kds68myed2rHRXDmP9xa5seCfZQAF4rMn0ixeOD8Yd6Ezpxv8n1FJwL+Y
 BkftAxCN9WaJtFXZNMUPitww02/cgAueOxZvn6WyHCDjR54hVNV+7rX7NbWzpCF/Vmy3
 RwBRxi+CYP0AU58eB6C9MefCqabonBia9pHIKP7Z7TeR+XaAQd8FdEyBehzQdsWlKYsK
 kyoc8p6/UNFscte7H/GeMfNFjhHibt+I4CnbDtcEWNudeqzYDi4Bfaeoy5H0bmdEHLal
 WNg49Dw1FNZKxMP/JTvmLKaCNeeZkx7OahUMkmNR1NOevChueNcNVoAjYezx0dEC+Bqc
 OM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745006130; x=1745610930;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58Fr5Jc3+gbOo6HFHWawNhIv6PlRPPR0lUnnIxKjYwM=;
 b=Ks5K/4KqMcBv4xnZK0Gm4ilYPR8LfRF9C6E3iQsaNEbANg5tpM8zZUH7TqmXaNZoHR
 u+47ahTpxhVgPBizBndbLiVMORs94HJlXvuTfg6tmSmXrZzK/T4YWmrv1mlgkd0hwlZA
 i5Dg85+pJV7Rd6byORIkQUXnLEdMfX33sP+h80Qaqd2bc0pEAX4mDpIWOThYYS9hKVKA
 /in/LwaOz0GxXtxLE2QzgqTK2/ije2bUthfTV49Vvp3OqPY1Af3W3217IxNk2QE6e2h5
 G0239BV0EJ+y8UE8YNNzAYmaKp270FxvXeRWJHLYNmxZQcdp8MvshBF/Kiaja6ON7QQ/
 pMrw==
X-Gm-Message-State: AOJu0YzPslBZKZS/e2H3dVzJw6J00sLsq3855zy+gd6unsJmFdLpQeHt
 r8f2S82YXaXtKJ4hiO9DZuY1E4zdwSPnt6BcjddHXf/vd2/Spy5z
X-Gm-Gg: ASbGncsZOKwVBrjTtb/shvNqKpr6dF7MUr9v3pEzU5HyeDvHi35A+X0waVnxQdMq/Hw
 AzIdIOYtnthsWYws6xPZwM7i92HxWWuP46t1gkQLxDXYKtAZrQGU+DHt74tcWh3AUqd3TlJ1g+6
 gh+1Gb0gH/ZgSDfqRpDwDtts4KJC0oDzR13wAL0jZdpvlIZ96zFKHDl5AJwXsalavBFOGwr6FmO
 66k+zZHOjl60wQnDI6tDAeBc/vLWYjx2nnQheH0MHOcR+Zckg2hI6t2T88l2kEBxUDMq/QFXStc
 M+HVtj688IGuiSS4UFJmVmu0cdJ8ALrgb+mxg4bviedpiiaJOTPB4e0I8You+CFgx0Z7RnJrJqD
 Nn2VTOFaKFASDnz3U
X-Google-Smtp-Source: AGHT+IHq6BzOUSKrYfpye5WSeHUXZJxneC2cRI5F2lZrznTFsItGGs+qXKqTo23PjZ9gDgaw4oPSOw==
X-Received: by 2002:a05:600c:4706:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-4406ab96b35mr33947095e9.14.1745006130171; 
 Fri, 18 Apr 2025 12:55:30 -0700 (PDT)
Received: from smtpclient.apple (89-138-169-5.bb.netvision.net.il.
 [89.138.169.5]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4931acsm3635663f8f.72.2025.04.18.12.55.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Apr 2025 12:55:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] io: Set unix socket buffers on macOS
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <918f450d-a5fe-4e3d-9320-950485352b86@linaro.org>
Date: Fri, 18 Apr 2025 22:55:17 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>, Richard Jones <rjones@redhat.com>,
 Eric Blake <eblake@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <933A8AC8-FE70-4F44-9E05-7B814FEF352F@gmail.com>
References: <20250418142436.6121-1-nirsof@gmail.com>
 <918f450d-a5fe-4e3d-9320-950485352b86@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x334.google.com
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



> On 18 Apr 2025, at 17:50, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Nir,
>=20
> On 18/4/25 16:24, Nir Soffer wrote:
>> Testing with qemu-nbd shows that computing a hash of an image via
>> qemu-nbd is 5-7 times faster with this change.
>> Tested with 2 qemu-nbd processes:
>>     $ ./qemu-nbd-after -r -t -e 0 -f raw -k /tmp/after.sock =
/var/tmp/bench/data-10g.img &
>>     $ ./qemu-nbd-before -r -t -e 0 -f raw -k /tmp/before.sock =
/var/tmp/bench/data-10g.img &
>> With nbdcopy, using 4 NBD connections:
>>     $ hyperfine -w 3 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:"
>>                      "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/after.sock' null:"
>>     Benchmark 1: ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:
>>       Time (mean =C2=B1 =CF=83):      8.670 s =C2=B1  0.025 s    =
[User: 5.670 s, System: 7.113 s]
>>       Range (min =E2=80=A6 max):    8.620 s =E2=80=A6  8.703 s    10 =
runs
>>     Benchmark 2: ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/after.sock' null:
>>       Time (mean =C2=B1 =CF=83):      1.839 s =C2=B1  0.008 s    =
[User: 4.651 s, System: 1.882 s]
>>       Range (min =E2=80=A6 max):    1.830 s =E2=80=A6  1.853 s    10 =
runs
>>     Summary
>>       ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/after.sock' =
null: ran
>>         4.72 =C2=B1 0.02 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/before.sock' null:
>> With blksum, using one NBD connection:
>>     $ hyperfine -w 3 "blksum 'nbd+unix:///?socket=3D/tmp/before.sock'" =
\
>>                      "blksum 'nbd+unix:///?socket=3D/tmp/after.sock'"
>>     Benchmark 1: blksum 'nbd+unix:///?socket=3D/tmp/before.sock'
>>       Time (mean =C2=B1 =CF=83):     13.606 s =C2=B1  0.081 s    =
[User: 5.799 s, System: 6.231 s]
>>       Range (min =E2=80=A6 max):   13.516 s =E2=80=A6 13.785 s    10 =
runs
>>     Benchmark 2: blksum 'nbd+unix:///?socket=3D/tmp/after.sock'
>>       Time (mean =C2=B1 =CF=83):      1.946 s =C2=B1  0.017 s    =
[User: 4.541 s, System: 1.481 s]
>>       Range (min =E2=80=A6 max):    1.912 s =E2=80=A6  1.979 s    10 =
runs
>>     Summary
>>       blksum 'nbd+unix:///?socket=3D/tmp/after.sock' ran
>>         6.99 =C2=B1 0.07 times faster than blksum =
'nbd+unix:///?socket=3D/tmp/before.sock'
>> This will improve other usage of unix domain sockets on macOS, I =
tested
>> only qemu-nbd.
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>>  io/channel-socket.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..b858659764 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -410,6 +410,19 @@ qio_channel_socket_accept(QIOChannelSocket *ioc,
>>      }
>>  #endif /* WIN32 */
>>  +#if __APPLE__
>> +    /* On macOS we need to tune unix domain socket buffer for best =
performance.
>> +     * Apple recommends sizing the receive buffer at 4 times the =
size of the
>> +     * send buffer.
>> +     */
>> +    if (cioc->localAddr.ss_family =3D=3D AF_UNIX) {
>> +        const int sndbuf_size =3D 1024 * 1024;
>=20
> Please add a definition instead of magic value, i.e.:
>=20
>  #define SOCKET_SEND_BUFSIZE  (1 * MiB)

Using 1 * MiB is nicer.

Not sure about the =E2=80=9Cmagic=E2=80=9D value; Do you mean:

    #define SOCKET_SEND_BUFSIZE  (1 * MiB)

In the top of the file or near the definition?

    const int sndbuf_size =3D 1 * MiB;

If we want it at the top of the file the name may be confusing since =
this is used only for macOS and for unix socket.

We can have:

    #define MACOS_UNIX_SOCKET_SEND_BUFSIZE (1 * MiB)

Or maybe:

    #if __APPLE__
    #define UNIX_SOCKET_SEND_BUFSIZE (1 * MiB)
    #endif

But we use this in one function so I=E2=80=99m not sure it helps.

In vmnet-helper I=E2=80=99m using this in 2 places so it moved to =
config.h.
https://github.com/nirs/vmnet-helper/blob/main/config.h.in

>=20
> BTW in test_io_channel_set_socket_bufs() we use 64 KiB, why 1 MiB?

This test use small buffer size so we can see the effect of partial =
reads/writes. I=E2=80=99m trying to improve throughput when reading =
image data with qemu-nbd. This will likely improve also =
qemu-storage-daemon and qemu builtin nbd server but I did not test them.

I did some benchmarks with send buffer size 64k - 2m, and it shows that =
1m gives the best performance.

Running one qemu-nbd process with each configuration:

% ps
...
18850 ttys013    2:01.78 ./qemu-nbd-64k -r -t -e 0 -f raw -k =
/tmp/64k.sock /Users/nir/bench/data-10g.img
18871 ttys013    1:53.49 ./qemu-nbd-128k -r -t -e 0 -f raw -k =
/tmp/128k.sock /Users/nir/bench/data-10g.img
18877 ttys013    1:47.95 ./qemu-nbd-256k -r -t -e 0 -f raw -k =
/tmp/256k.sock /Users/nir/bench/data-10g.img
18885 ttys013    1:52.06 ./qemu-nbd-512k -r -t -e 0 -f raw -k =
/tmp/512k.sock /Users/nir/bench/data-10g.img
18894 ttys013    2:02.34 ./qemu-nbd-1m -r -t -e 0 -f raw -k /tmp/1m.sock =
/Users/nir/bench/data-10g.img
22918 ttys013    0:00.02 ./qemu-nbd-2m -r -t -e 0 -f raw -k /tmp/2m.sock =
/Users/nir/bench/data-10g.img

% hyperfine -w 3 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/64k.sock' null:=E2=80=9D \
                 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/128k.sock' null:=E2=80=9D \
                 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/256k.sock' null:=E2=80=9D \
                 "./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/512k.sock' null:=E2=80=9D \
                 "./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/1m.sock'=
 null:=E2=80=9D \
                 "./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/2m.sock'=
 null:"
Benchmark 1: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/64k.sock' =
null:
  Time (mean =C2=B1 =CF=83):      2.760 s =C2=B1  0.014 s    [User: =
4.871 s, System: 2.576 s]
  Range (min =E2=80=A6 max):    2.736 s =E2=80=A6  2.788 s    10 runs
  Benchmark 2: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/128k.sock' =
null:
  Time (mean =C2=B1 =CF=83):      2.284 s =C2=B1  0.006 s    [User: =
4.774 s, System: 2.044 s]
  Range (min =E2=80=A6 max):    2.275 s =E2=80=A6  2.294 s    10 runs
  Benchmark 3: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/256k.sock' =
null:
  Time (mean =C2=B1 =CF=83):      2.036 s =C2=B1  0.010 s    [User: =
4.734 s, System: 1.822 s]
  Range (min =E2=80=A6 max):    2.021 s =E2=80=A6  2.052 s    10 runs
  Benchmark 4: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/512k.sock' =
null:
  Time (mean =C2=B1 =CF=83):      1.763 s =C2=B1  0.005 s    [User: =
4.637 s, System: 1.801 s]
  Range (min =E2=80=A6 max):    1.755 s =E2=80=A6  1.771 s    10 runs
  Benchmark 5: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/1m.sock' =
null:
  Time (mean =C2=B1 =CF=83):      1.653 s =C2=B1  0.012 s    [User: =
4.568 s, System: 1.818 s]
  Range (min =E2=80=A6 max):    1.636 s =E2=80=A6  1.683 s    10 runs
  Benchmark 6: ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/2m.sock' =
null:
  Time (mean =C2=B1 =CF=83):      1.802 s =C2=B1  0.052 s    [User: =
4.573 s, System: 1.918 s]
  Range (min =E2=80=A6 max):    1.736 s =E2=80=A6  1.896 s    10 runs
  Summary
  ./nbdcopy --blkhash 'nbd+unix:///?socket=3D/tmp/1m.sock' null: ran
    1.07 =C2=B1 0.01 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/512k.sock' null:
    1.09 =C2=B1 0.03 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/2m.sock' null:
    1.23 =C2=B1 0.01 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/256k.sock' null:
    1.38 =C2=B1 0.01 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/128k.sock' null:
    1.67 =C2=B1 0.02 times faster than ./nbdcopy --blkhash =
'nbd+unix:///?socket=3D/tmp/64k.sock' null:

I can add a combat table showing the results in a comment, or add the =
test output to the commit message for reference.

>=20
>> +        const int rcvbuf_size =3D 4 * sndbuf_size;
>> +        setsockopt(cioc->fd, SOL_SOCKET, SO_SNDBUF, &sndbuf_size, =
sizeof(sndbuf_size));
>> +        setsockopt(cioc->fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf_size, =
sizeof(rcvbuf_size));
>> +    }
>> +#endif /* __APPLE__ */
>=20
> Thanks,
>=20
> Phil.



