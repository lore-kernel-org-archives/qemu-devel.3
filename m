Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A81CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxz2M-0001t6-BF; Mon, 07 Oct 2024 21:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sxz2L-0001sw-Gr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:29:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sxz2J-0001RD-MQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:29:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42f6995dab8so125725e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350953; x=1728955753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+5O1d5QD8SiqkSDnIJpF32o7IWvaXTr5T4PAuQq1/8=;
 b=y3ndyfleTbfIZvjjm/1LXJ5RkAGHjdljXvvdu4drprjVVkao+93jEzXh1VVO6R/ZRo
 /K3Gt0CrRkZeKTCD8uT0xxyE3XEBxVfYuFiUh4NCKVGgDHD5yqktqgIcn0zUZxyPhpVs
 BzKsOtbgyiLjCLbGXp7k2rS5b+axNon3Qjy32vAYEPRKOCZGRhbEp03aiVWfOXCbv5Kk
 jO5VMq9eJ9J38CrYXKBPcmfmU5dYlGj0JFgusbNyaD/KpUIb6mL3DF0nrQ6YC4fqosmx
 +WHppI6FcyFd8GHzG1M2aYjbt4H0Od2WGXsrUtkogjjlUnZEYMi5oBAZIpkIqRQQNfft
 eMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350953; x=1728955753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+5O1d5QD8SiqkSDnIJpF32o7IWvaXTr5T4PAuQq1/8=;
 b=FpgbMbTOw9wNLlTOGzqgs7KRp8RnPL65MeRrG656xVO0EmeH515hzaYJRSuJCHdaIc
 YptcHxh5tWmTWhG0Muk3XJ3BBF+4/9Syjm4CB+aZjGSgSmV8awxeYPYu39VTENGPAMIa
 I/BMnZM6ytihfxgSrChLYea7Mxq3oi7bEOWoa9CKkFLXVEh7Pq5WqcGI4aIw8I2CGQWL
 Ljk8wpBn8PWAHG6mt1CUMPfJc++qMsZ8lxfsjtE3FLspjLa2tkPuiogxBrVY5am1tZwC
 ZbZUZvRaLASOvUksu6WqNvidu2BNN4ZyGHQdvGy0R0wcFhP4VJLUIH/5ssM4p9g8bYYw
 nhZg==
X-Gm-Message-State: AOJu0Yx/YZmuITW6Mysp2+y9k9++Khi3vUSHhtzvjZbNsGuO5XqYLSox
 oSlAIQb8y5BmmotpLIyyhNWhnz9eLQTT6wxfeS9xeSJy86/pe5Zp6Mdlnmu+iH55K2S/6lA3jEB
 MxeIyV+7AfTgofKZpnp0sKbjL5klkG4H4k81d
X-Google-Smtp-Source: AGHT+IFwSDOkZGHl6BoEMiBL0H5Gt6QjKeSQcfdzGOoFBZvGlnz4IrBU4N5Dua/3URvtYccWoCVoCkq7DRrhrTQoPNg=
X-Received: by 2002:a05:600c:5010:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-42fcdcddf49mr2430475e9.4.1728350952901; Mon, 07 Oct 2024
 18:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240806010735.2450555-1-tavip@google.com>
 <CAJ+F1CLhDSMzT31TCiCuoXegyhAeSNr4Ly3Jm4Aqp9SFYW+kAg@mail.gmail.com>
In-Reply-To: <CAJ+F1CLhDSMzT31TCiCuoXegyhAeSNr4Ly3Jm4Aqp9SFYW+kAg@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Mon, 7 Oct 2024 18:29:01 -0700
Message-ID: <CAGWr4cRM6o2tJJi1vVw4SPagUqiJPrmtNYUhn4rSuGpwHeSnDA@mail.gmail.com>
Subject: Re: [PATCH v4] chardev: add path option for pty backend
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 armbru@redhat.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@linaro.org, 
 berrange@redhat.com, Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=tavip@google.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, Sep 3, 2024 at 12:14=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
>
>
> On Tue, Aug 6, 2024 at 5:09=E2=80=AFAM Octavian Purdila <tavip@google.com=
> wrote:
>>
>> Add path option to the pty char backend which will create a symbolic
>> link to the given path that points to the allocated PTY.
>>
>> This avoids having to make QMP or HMP monitor queries to find out what
>> the new PTY device path is.
>>
>> Based on patch from Paulo Neves:
>>
>> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmai=
l.com/
>>
>> Tested with the following invocations that the link is created and
>> removed when qemu stops:
>>
>>   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
>>   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
>>
>>   qemu-system-x86_64 -nodefaults -monitor pty:test
>>
>>   # check QMP invocation with path set
>>   qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,wai=
t=3Doff
>>   nc localhost 4444
>>   > {"execute": "qmp_capabilities"}
>>   > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
>>       "type": "pty", "data": {"path": "test" }}}}
>>
>>   # check QMP invocation with path not set
>>   qemu-system-x86_64 -nodefaults -qmp tcp:localhost:4444,server=3Don,wai=
t=3Doff
>>   nc localhost 4444
>>   > {"execute": "qmp_capabilities"}
>>   > {"execute": "chardev-add", "arguments": {"id": "bar", "backend": {
>>       "type": "pty", "data": {}}}}
>>
>> Also tested that when a link path is not passed invocations still work, =
e.g.:
>>
>>   qemu-system-x86_64 -monitor pty
>>
>> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> [OP: rebase and address original patch review comments]
>> Signed-off-by: Octavian Purdila <tavip@google.com>
>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Ping, it looks like this got lost.

https://patchew.org/QEMU/20240605185050.1678102-1-tavip@google.com/

