Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DEBD3E78C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 04:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTYTK-0001eU-J5; Wed, 10 Dec 2025 23:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vTYTI-0001cn-VD
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 23:40:08 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1vTYTH-000351-03
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 23:40:08 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-8b2d6df99c5so175751985a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 20:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765428005; x=1766032805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMzhI+vFeG7m4UpMIAPv2t90PiAp/LRKOBf6KKbwx5k=;
 b=Dzn3zUSSaaqzYH0QsCLc2MOVge9TPkYH5gkRMmfdCFXAxxQe1WfKp44e/JDiZ9lNiP
 rF7N18PlYUe0vknscSUO0uElP8zpeDtnVgpuQvW6xzOXI3exnk6fVp2H42z/h9uBmjTb
 rEVEB/VKA7oVsfHR3G6nLSmo+4s0v15EndY/fv6wrM8p9i8vZ9gRMX3dGzT1xRDDTjZS
 MNe1ZcQ0/uyA0OzzxHpAW0c+1Sx1WYYhOO55gE92ra9+JWzVLeKbXQfcgbgpSV9ZTmbt
 nDdviAf4BU6zN//KfM7iqVHsd+nv/ZvwolvImm3k34+IiDi43JoZyU3eLqtZgrJ2uVoG
 6ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765428005; x=1766032805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMzhI+vFeG7m4UpMIAPv2t90PiAp/LRKOBf6KKbwx5k=;
 b=JGR/yUfLgd4o8XiLgoMVyaxUfhRnCPbJMyS5ycE96JHmIu1g+RTZK2jb8U5AGhur0S
 o0qJtigYK3UiVroPjqdSHT3pp9P+G45PuGOF2b5tK54NrZ2VZV1hIeBaPr3ZFM4+1DtP
 jLmQ7tDWESZhQUbCMEpNu1/ZjycahVWTExVtGaTsZcvWCaMb/ReGss429bgKaXwjkvHa
 blXU6FLObHAMiRftq1cnRv7zHBTMcjF3PsjOpyO4DleyHn7u/12MGKN3/dlZ4/WRanct
 zpudGOVPl9MFSG51pvrlGnI0+HSboJuK37Xfhn7Zps6xerQYon6ezq0nhF9DDa6EOvh6
 vZfg==
X-Gm-Message-State: AOJu0YzN8ZFmPbXQskmwR5ImJZbb/jRH17Me0OnVCEbTvGX8SUZLr0wx
 yHIkeosqoaybMbVIqdRd0FQNaXkwlIX04iXdhlBMuNtkohumsJhZeUKu
X-Gm-Gg: AY/fxX44Pc0LDByMW2DU4JUIKyLZdp0qcCbTLjTxTffiDpdiiiPCCt4BSy4KxrPSRsS
 2h+1/MsDgJRHbjTcL1r5HTO76AS/ZnCMlJOJP5BdIMlNJmzngcmIhbNi/Mh1i3MqdD3g1qKHcWy
 xPPuvJN/A6CwKc+/6O+pb2CVYIiUfVzSnaREsnsCKVXPPYKoTRRhfxtJ4oQkQzgyXSk97DnxKxJ
 LyBzsI9ojPx6beDVe1AQA9aXB874vjw9nNyg1l6woXqHzhcFwGJac4xmC8iWrAGmLKS2K3SPjKK
 vrs/H4zOi6ZxhAGUkLXF9VI2RIN1UuQwWeTLey9/dpThIhsLOo22YDcBKj71Te9u7stWHT5aFd5
 895vLlDl+N2/0LcV0QztAzDpcoY778mneNjTvYgWUKWyVH7rkmH/i7wbsMoO0Mhw/VoJMwevTXK
 cP3wEnxjAKs/pQgjM=
X-Google-Smtp-Source: AGHT+IFgfFlgMlhVgC0Msj1zfBxVg8uCpCDrv16YziRm1r4rjA2KTfSrSgTw25YpuZce7psrem2kSw==
X-Received: by 2002:a05:620a:4408:b0:89d:b1e7:29e5 with SMTP id
 af79cd13be357-8bad3f910d8mr109783385a.5.1765428005494; 
 Wed, 10 Dec 2025 20:40:05 -0800 (PST)
Received: from [192.168.0.156] ([45.62.219.80])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5665ff3sm125914885a.15.2025.12.10.20.40.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 20:40:05 -0800 (PST)
Message-ID: <e8803d1e-6c76-4bb2-82d8-b3b0c35aad8f@gmail.com>
Date: Wed, 10 Dec 2025 23:40:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for QEMU
 FUSE Exports
To: Bernd Schubert <bschubert@ddn.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <6ef9f104-3a04-4065-8e57-40dc3ace98cd@ddn.com>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <6ef9f104-3a04-4065-8e57-40dc3ace98cd@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x730.google.com
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



On 12/10/25 5:10 PM, Bernd Schubert wrote:
> Hi Brian et al,
> 
>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>> +{
>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>> +    FuseQueue *q = ent->q;
>> +    Coroutine *co;
>> +    FuseExport *exp = ent->q->exp;
>> +
>> +    int err = cqe_handler->cqe.res;
>> +    if (err != 0) {
>> +        /* TODO end_conn support */
>> +
>> +        /* -ENOTCONN is ok on umount  */
>> +        if (err != -EINTR && err != -EOPNOTSUPP &&
>> +            err != -EAGAIN && err != -ENOTCONN) {
>> +            fuse_export_halt(exp);
> 
> 
> what actually happened to these patches? I don't see it merged in the
> qemu repo? There is an issue here. I know we had discussed -EAGAIN and
> -EINTR. Actually this needs to be specially handled, at least
> FUSE_IO_URING_CMD_REGISTER, because it can arrive before FUSE_INIT
> is processed and then kernel will return -EAGAIN.
> 
> https://github.com/libfuse/libfuse/pull/1387/commits/34f3dec97cce508642679cb1b874e99ed36d8158
> 
> I need to split this up it also includes some other refactoring.
> 
> 
> Thanks,
> Bernd

Thanks for reaching out. I'm graduating at the end of the year, so after 
GSoC I got really busy with finishing school and job hunting. I've got 
some time these couple of days, so I'll go through the feedback on patch 
v3 from the mailing list and wrap up the remaining work

Thanks,
Brian

