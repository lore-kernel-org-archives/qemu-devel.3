Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFEBC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvlz-0003na-AW; Wed, 15 Jan 2025 00:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXvly-0003nJ-0r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:16:58 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXvlv-0006ma-UB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:16:57 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so7957436a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736918214; x=1737523014;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wj9UC/3w5jkYxtsOFWAaIl08xWB1xKkZadIrahiiC2I=;
 b=sg5IF0GgdrM2wA3XTmmS7Tsq57I8LsXvMpz4WmJpevZzqAElOPUhH1CdEYEBeU14IX
 pAqec4XKrmCstBd2Oc8N7RT4foyoZU2ak0gUrO+/5R50WfavgCOJE+p7rkuiXbjziDI4
 aNrSYVCwC7ieWac9TpPVcHzf2k9ZuTRR6QS5MFj/jow0Tim7HcJT4E6G665X9NdQXMOt
 BaDE0j/dmLVU2UqxN6jspYoIxkUKJixY7i6XcIN6yfg/SOOXEekSUyqNijrg1s3hK5oz
 R+u2vls0mFlyNa6yh2ANyhfji1Tpw0BQvT+F98ReedrrkL3HnR0k5ax9qPkCJFDxlu2G
 PvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736918214; x=1737523014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wj9UC/3w5jkYxtsOFWAaIl08xWB1xKkZadIrahiiC2I=;
 b=GU1260HmT9MrJL1vh7L3BtMHjfSWpt2+6jXc6hGWuKAYt1Cpc+15TcOiSlkfLd3Pfp
 34LfEHKvzPL4IxzDtbrJLO/gm3Npec9qFC6rc6IGt9uChJkZACZ8FzjQN0ZSrz/SUKMr
 +w1H6muQTiZZimEwt7tAYlTu3HWZLeITXJx3sKxSZVb2pBOKqk6nvI6DX4SOHprKkgjU
 H9E/JoGG4hlo3081hymKFj7lXl0gVHQ5/eKQevqlI8VGcP8ujZWKVdrNNg4Crb3KqXGI
 oXa99nXF3Xh0QUGDoSb4ntDByhfpRYVO4tQbgqIdMu7x54eLdH78JLOiDgHmgN2SFa2P
 v5EA==
X-Gm-Message-State: AOJu0YwE/dlQTl/0MY0t+fXSp5gxAqRvFSfKQa1qqW7PkI9uOHW/cFuf
 BxCxxY2mTF76icClyhnxstR8hzFGe1pWPJNjNe/C3zEBm7Y0uId+w7Zz4kyF1xo=
X-Gm-Gg: ASbGncsS2VZnZ0B2qpweI5j1HJm5vWNZsrwOayghlnUr3NpFL0SiB0On0j1U7lX98/4
 SFveDxXN0YLOq6jiWm0GcX1+RUKQBPESerL9T0PvVSUh9yu0Mc8YGltERSESSZBWJCAhQIo+3wY
 ubOjUfvM8QveYF2rJ6v1qs97TAG9djgytIrDeumJfLPi26605kUL92jOZJKLiU3xQMEewhNCYGz
 qAxnhZoO3vA0hUONsjsUwP/YukH7LVfGZhH21Sc/MW8Qe1XtcFV4LegXGQu5tjuypg=
X-Google-Smtp-Source: AGHT+IHHEXTmE9xGc+4triinS25Ry1LTH46I2j5eKfbPvUvBEdlGCsZfD/1PGhZe2s6r1QGm4Bv1wA==
X-Received: by 2002:a17:90b:4a44:b0:2f4:f7f8:fc8a with SMTP id
 98e67ed59e1d1-2f548f7649amr42778503a91.33.1736918214437; 
 Tue, 14 Jan 2025 21:16:54 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c20cbe8sm507348a91.37.2025.01.14.21.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:16:54 -0800 (PST)
Message-ID: <db4deda5-2869-45d2-8d56-9ba390324cd6@daynix.com>
Date: Wed, 15 Jan 2025 14:16:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
 <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
 <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu6sFRm+xVxEp6X+N_qRH+qcbi_W3onXxX3uRPjS0hiFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
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

On 2025/01/13 11:59, Jason Wang wrote:
> On Sat, Jan 11, 2025 at 1:43 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Hi Jason,
>>
>> Can you check this patch again?
> 
> I would like to have this if
> 
> 1) it would be used by libvirt.
> 
> or
> 
> 2) there's no other way to do this

I need this to make QEMU work with macvtap on mkosi, and this patch is 
an effective way to accomplish the goal.

Requiring to pass a file descriptor is simply less convenient. Most (if 
not all) aspects of QEMU can be configured without file descriptors; I 
don't think there is a reason to make tap exceptional.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>> On 2024/10/22 13:59, Akihiko Odaki wrote:
>>> On 2024/10/18 17:10, Jason Wang wrote:
>>>> On Sat, Oct 12, 2024 at 5:05 PM Akihiko Odaki
>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>
>>>>> On 2024/10/09 16:41, Jason Wang wrote:
>>>>>> On Tue, Oct 8, 2024 at 2:52 PM Akihiko Odaki
>>>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>>>
>>>>>>> ipvtap and macvtap create a file for each interface unlike tuntap,
>>>>>>> which
>>>>>>> creates one file shared by all interfaces. Try to open a file
>>>>>>> dedicated
>>>>>>> to the interface first for ipvtap and macvtap.
>>>>>>>
>>>>>>
>>>>>> Management layers usually pass these fds via SCM_RIGHTS. Is this for
>>>>>> testing purposes? (Note that we can use something like -netdev
>>>>>> tap,fd=10 10<>/dev/tap0).
>>>>>
>>>>> I used this for testing.
>>>>
>>>> Anything that prevents you from using fd redirection? If not
>>>> management interest and we had already had a way for testing, I tend
>>>> to not introduce new code as it may bring bugs.
>>>
>>> I don't know what ifindex the macvtap device has so it's easier to use
>>> if QEMU can automatically figure out the it.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>>>> ---
>>>>>>>     net/tap-linux.c | 17 ++++++++++++++---
>>>>>>>     1 file changed, 14 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>>>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
>>>>>>> --- a/net/tap-linux.c
>>>>>>> +++ b/net/tap-linux.c
>>>>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int
>>>>>>> *vnet_hdr,
>>>>>>>         int len = sizeof(struct virtio_net_hdr);
>>>>>>>         unsigned int features;
>>>>>>>
>>>>>>> -    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>>>> +
>>>>>>> +    ret = if_nametoindex(ifname);
>>>>>>> +    if (ret) {
>>>>>>> +        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
>>>>>>> +        fd = open(file, O_RDWR);
>>>>>>> +    } else {
>>>>>>> +        fd = -1;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         if (fd < 0) {
>>>>>>> -        error_setg_errno(errp, errno, "could not open %s",
>>>>>>> PATH_NET_TUN);
>>>>>>> -        return -1;
>>>>>>> +        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>>>
>>>>>> Any reason tuntap were tried after the macvtap/ipvtap?
>>>>>
>>>>> If we try tuntap first, we will know that it is not tuntap when calling
>>>>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again
>>>>> in such a case because they precede TUNSETIFF. Calling them twice is
>>>>> troublesome.
>>>>
>>>> I may miss something, we are only at the phase of open() not TUNSETIFF?
>>>
>>> We can tell if it is macvtap/ipvtap just by trying opening the device
>>> file. That is not possible with tuntap because tuntap uses /dev/net/tun,
>>> a device file common for all tuntap interfaces and its presence does not
>>> tell if the interface is tuntap.
>>>
>>>>
>>>>>
>>>>> This is also consistent with libvirt. libvirt first checks if
>>>>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap
>>>>> otherwise.
>>>>
>>>> This is not what I understand from how layered products work. Libvirt
>>>> should align with Qemu for low level things like TAP, not the reverse.
>>>
>>> This change is intended for the use case where libvirt is not in use. In
>>> particular, I use mkosi, which is not a full fledged layering mechanism.
>>>
>>> Regards,
>>> Akihiko Odaki
>>
> 


