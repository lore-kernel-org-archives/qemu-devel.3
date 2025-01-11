Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313FBE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 05:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWUH4-0002Df-Sh; Sat, 11 Jan 2025 00:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUH2-0002DV-Ro
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:43:05 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWUH1-0007SD-78
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 00:43:04 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so3698961a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 21:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736574181; x=1737178981;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nKm5OiS1njPEZZLYX6s7XzfgG5hCAAevmqprhpDK6XY=;
 b=ikbaOY2f/2NqLebWRPThSFAEGhlC9i9+kYMmWNFe3XxVf6Zoz6huq+tyUEFJl/sTxj
 SRtpeaFAdhZnYRZns0xqQ+Ho9NuajDKNYphRhhnCkAwBevdTAEFb3/Jj8VCknlSrqdk2
 f72BURPGajuW7EGf4h7/uHI03NmjgcAUBZCH5l0UdAaD2+FFShMPUGNUhMJCL6bCWkjX
 H35AXbtzcjmP1t35CrqPyXj6rZ46izU3TGCwuQQWq5ohB6TFtDhFSQNOSHKOLWcPPUEY
 wu+U0mXtIpt4bpDhSewpsq122ks+ZSe6l8KfOiMGvaQTmHJNvbURvc1DA1b8pdl+hlKK
 x5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736574181; x=1737178981;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKm5OiS1njPEZZLYX6s7XzfgG5hCAAevmqprhpDK6XY=;
 b=OyLVi/wjbdFHqRczoRVYbLrp2R2vFo2sx/GB0CFbe4PrVC+Z7rhxR3hk90CA3U2bRS
 oCPbjsEta5KQ+ny/TIxfkpE0zrMBfWpjK+szfMoXsST5wb7wa2qquEce9TXttl7BLALj
 m7eKB+kCp7+bul1zKqcXqb+iLFBMWzF21Ld0/aFDIzP3kIlKWZBIPtKoIMUhxnMTqkjp
 s40oa5+wn9wG1wbGeBTcj8wOhE5HAFd9PGYxTLk9qSVyuh7IXgZ39O0FvyXlxFCBeUKJ
 VwLGUwmbrTtMFqq7/74RE0shQcbSKcDnXyt7DKlvwffUXt2Oi/pQkkWhVwV7wsGGdvIa
 VdNw==
X-Gm-Message-State: AOJu0Yzn9xouRhBfPRSy2sCT1/7i/sv9lyMJ5nuQAR38FWIaS0bpH0X6
 CkjaGWcMrt+6LJE7i3LQ2fQu5nofrgPBJCE6vUukzmpBFnwQkiWfKz1z+ckfazo=
X-Gm-Gg: ASbGncvqfPTYabiQ3FNNWxtdjYAiVal1KabFYrGY1c8PtCo6WjpmTT0HaKILxZVLtT5
 yjbwCL7wJJB/FwSpinOejnpfhde+KjTiHLxjg4YOwoKey+KXU8ZB6Ng/f1PLBoKd53RlW8OkJMo
 +cFaMzgaDl8ogkGAmBzFiBS1ZSrJfLHogK/r0uReCOSZXdJvQZm0/GZtuPieRleT9pQp8BwGwa9
 oc2F3+x+H+1EWtdn8Fni8ChGoX75sK64WF8z2G5To9Q05m4jFP6XTVTC1KmEfab3TM=
X-Google-Smtp-Source: AGHT+IG3bgFMJRC9rBIflCLzfJXQz2A00z47fr34sCswe5SeaPaOUsq45gvsWJbFxpR5C3kZ7G9VDg==
X-Received: by 2002:a17:90b:4d0c:b0:2ee:8619:210b with SMTP id
 98e67ed59e1d1-2f5490bd21dmr19577465a91.29.1736574181528; 
 Fri, 10 Jan 2025 21:43:01 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f55f76e5a0sm3450405a91.26.2025.01.10.21.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 21:43:00 -0800 (PST)
Message-ID: <50e784b2-850d-4d1b-9fc8-7fb6076f101e@daynix.com>
Date: Sat, 11 Jan 2025 14:42:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tap-linux: Open ipvtap and macvtap
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20241008-macvtap-v1-1-2032caa25b6d@daynix.com>
 <CACGkMEvmEsFdLRgF9CLQCEo0jt3dX8wAPLjRC2pNb4ofD8dLNQ@mail.gmail.com>
 <469f9995-9182-43c2-93d7-ab8dbefb9eb9@daynix.com>
 <CACGkMEs2hkX7S3QJK1yLbJjSxW=obiSOYwKA4w2xiJwuOooq4g@mail.gmail.com>
 <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
Content-Language: en-US
In-Reply-To: <74d218be-2119-4977-8d2e-40a51cccde9d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

Hi Jason,

Can you check this patch again?

Regards,
Akihiko Odaki

On 2024/10/22 13:59, Akihiko Odaki wrote:
> On 2024/10/18 17:10, Jason Wang wrote:
>> On Sat, Oct 12, 2024 at 5:05 PM Akihiko Odaki 
>> <akihiko.odaki@daynix.com> wrote:
>>>
>>> On 2024/10/09 16:41, Jason Wang wrote:
>>>> On Tue, Oct 8, 2024 at 2:52 PM Akihiko Odaki 
>>>> <akihiko.odaki@daynix.com> wrote:
>>>>>
>>>>> ipvtap and macvtap create a file for each interface unlike tuntap, 
>>>>> which
>>>>> creates one file shared by all interfaces. Try to open a file 
>>>>> dedicated
>>>>> to the interface first for ipvtap and macvtap.
>>>>>
>>>>
>>>> Management layers usually pass these fds via SCM_RIGHTS. Is this for
>>>> testing purposes? (Note that we can use something like -netdev
>>>> tap,fd=10 10<>/dev/tap0).
>>>
>>> I used this for testing.
>>
>> Anything that prevents you from using fd redirection? If not
>> management interest and we had already had a way for testing, I tend
>> to not introduce new code as it may bring bugs.
> 
> I don't know what ifindex the macvtap device has so it's easier to use 
> if QEMU can automatically figure out the it.
> 
>>
>>>
>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> ---
>>>>>    net/tap-linux.c | 17 ++++++++++++++---
>>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>>>> index 1226d5fda2d9..22ec2f45d2b7 100644
>>>>> --- a/net/tap-linux.c
>>>>> +++ b/net/tap-linux.c
>>>>> @@ -45,10 +45,21 @@ int tap_open(char *ifname, int ifname_size, int 
>>>>> *vnet_hdr,
>>>>>        int len = sizeof(struct virtio_net_hdr);
>>>>>        unsigned int features;
>>>>>
>>>>> -    fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>> +
>>>>> +    ret = if_nametoindex(ifname);
>>>>> +    if (ret) {
>>>>> +        g_autofree char *file = g_strdup_printf("/dev/tap%d", ret);
>>>>> +        fd = open(file, O_RDWR);
>>>>> +    } else {
>>>>> +        fd = -1;
>>>>> +    }
>>>>> +
>>>>>        if (fd < 0) {
>>>>> -        error_setg_errno(errp, errno, "could not open %s", 
>>>>> PATH_NET_TUN);
>>>>> -        return -1;
>>>>> +        fd = RETRY_ON_EINTR(open(PATH_NET_TUN, O_RDWR));
>>>>
>>>> Any reason tuntap were tried after the macvtap/ipvtap?
>>>
>>> If we try tuntap first, we will know that it is not tuntap when calling
>>> TUNSETIFF. We will need to call TUNGETFEATURES and TUNSETVNETHDRSZ again
>>> in such a case because they precede TUNSETIFF. Calling them twice is
>>> troublesome.
>>
>> I may miss something, we are only at the phase of open() not TUNSETIFF?
> 
> We can tell if it is macvtap/ipvtap just by trying opening the device 
> file. That is not possible with tuntap because tuntap uses /dev/net/tun, 
> a device file common for all tuntap interfaces and its presence does not 
> tell if the interface is tuntap.
> 
>>
>>>
>>> This is also consistent with libvirt. libvirt first checks if
>>> g_strdup_printf("/dev/tap%d", ifindex) exists, and falls back to tuntap
>>> otherwise.
>>
>> This is not what I understand from how layered products work. Libvirt
>> should align with Qemu for low level things like TAP, not the reverse.
> 
> This change is intended for the use case where libvirt is not in use. In 
> particular, I use mkosi, which is not a full fledged layering mechanism.
> 
> Regards,
> Akihiko Odaki


