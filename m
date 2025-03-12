Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0DCC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMuJ-00068F-7t; Wed, 12 Mar 2025 10:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMuD-00066K-4B
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:17:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsMuA-00025S-Vu
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:17:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913fdd0120so2353354f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741789073; x=1742393873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYJ3ECqWjuXnPyqp7AVfnFFrkkGeAXD7mOJOi6p3muo=;
 b=eTbjZ/MBrgHFRAkswBoBJ+VqgrHE+/jW2XsyIwDw741Lv1i2SLPe/8RdqfNQxrfRxT
 csmAZk2qPEl1bPvUeaXsTKFWYw3Ls8g7fxoanlfLan1Gv67KjurvvktMJjci2bHUOgCl
 plQhThER5Y65pxRxB8ijMCwRapabDz9BRcDVC67gTwk3SSHjgM3SCNLDwZYr7bWe8lDc
 b062F7tB9uRIbwRfhRisSJjpjPGO9gGfwFOrNcw6RFMj878w7+oIO6YmqIGI84caF+2m
 tEHLuW4GKrYbnnkdLN1QTQ3Qy3IDAKbbq7Mei/vukJjkMicF6eXTTubaRJWbZLFVwdLd
 22pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789073; x=1742393873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYJ3ECqWjuXnPyqp7AVfnFFrkkGeAXD7mOJOi6p3muo=;
 b=fs9CkX8uTf2CdTPkKchtSygLQE3yYVoOs6GrrHYj1YEdgi4czd2Zt2x1B+9crccLvl
 4LKag4grjgP5g3NkIX0mcs2dsicKWxF5/1hDyfo5iOcovdJcpQf1HLWovodk0F+qjsdc
 AiiyZjRd95Z8JJNfVjnudpXCgN/cNCUB2MZnmClM4VaWY+/M/eBQYuQjxtmTlw4HT4Hs
 oGP1UX1/RJNLDfAmLqIBs2KnqYD/bpVXSNGNaLYz1p0dfln9ip8GVVdI4i+PAOG39DAw
 EKWyUHB/igiuo5xBNpZAIxWDkA6rsrHPMvBvOFWA0VKfW3tMZ8crdcbemh2ZshxfaEe7
 IRBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm0yz/q1s0xQhxmixtvmeqaI5Ys3ixRfV4gJ+iOM9uAlMb+EvXCOUuslA/LEEP9M/BHPT9XQ37HppI@nongnu.org
X-Gm-Message-State: AOJu0Yy4nrNMbdH9eC1zHHnLTyu5KeryfVBbBHHcLlEVHECNCWX0vA/Q
 oS4tl10GhPv+24JfkHGH2KNY9wYVkotxJRNHWPIf1sj+Pr/jI9i1tqyJuiZU1FU=
X-Gm-Gg: ASbGncv8XMvc//9alwoYNwuuf07yugIeUlVtlGcn33ytIRVcuv700itsy9tfaTnRiKc
 /RaSg247RPOyuYfqjd9i6cMtWohMwSdoh8mqXoQwN22W5XUNNeLkrZhQmoFINZy8wQet8CWyFf/
 NMCLy8jwIQ3RjJmlK/T5v4U7PJzMC6RekfKCVnzhclCMuuzPojm9vjRkuqnqfOUtS4Kw6qAo6rW
 smrDnaxfO8xWATlXSw1yQVdQ8XCrzulL6pEx/LOGpry4WgU1RT2dsNpeY0egL8eqdDMeFsWoDZt
 P8i8VWP+5JY7Y9Q4ffmsfmEH+UcyLk7+ki+uw+V5vezTHCdcEG2hcN1tteN8XuHPJ0P+2UPVkrC
 DB1B+bhr6
X-Google-Smtp-Source: AGHT+IEzVPO7mTyf+a7fbMlxyxCSfnn+HG2imntXGgKZ7u0/M621sr79OlQk8nIrbYMPz+XL2f+psw==
X-Received: by 2002:a5d:6d04:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-39132d05f78mr17489567f8f.10.1741789072553; 
 Wed, 12 Mar 2025 07:17:52 -0700 (PDT)
Received: from [10.223.46.213] (216.165.185.81.rev.sfr.net. [81.185.165.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a75aae2sm22652365e9.20.2025.03.12.07.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 07:17:51 -0700 (PDT)
Message-ID: <9f2e1dbd-a9c7-4516-8944-753906f5e7b3@linaro.org>
Date: Wed, 12 Mar 2025 15:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
To: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <b9550966-3c60-48dd-b0f3-a6833bd59cd9@linaro.org>
 <741d932c-95c0-4a6a-b91e-6d07e7767675@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <741d932c-95c0-4a6a-b91e-6d07e7767675@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/3/25 13:29, Thomas Huth wrote:
> On 12/03/2025 13.18, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> (patch merged as commit 4f7689f0817)
>>
>> On 16/8/23 23:07, Thomas Huth wrote:
>>> When starting a guest via libvirt with "virsh start --console ...",
>>> the first second of the console output is missing. This is especially
>>> annoying on s390x that only has a text console by default and no 
>>> graphical
>>> output - if the bios fails to boot here, the information about what went
>>> wrong is completely lost.
>>>
>>> One part of the problem (there is also some things to be done on the
>>> libvirt side) is that QEMU only checks with a 1 second timer whether
>>> the other side of the pty is already connected, so the first second of
>>> the console output is always lost.
>>>
>>> This likely used to work better in the past, since the code once checked
>>> for a re-connection during write, but this has been removed in commit
>>> f8278c7d74 ("char-pty: remove the check for connection on write") to 
>>> avoid
>>> some locking.
>>>
>>> To ease the situation here at least a little bit, let's check with 
>>> g_poll()
>>> whether we could send out the data anyway, even if the connection has 
>>> not
>>> been marked as "connected" yet. The file descriptor is marked as non- 
>>> blocking
>>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this 
>>> should
>>> not cause any trouble if the other side is not ready for receiving yet.
>>>
>>> With this patch applied, I can now successfully see the bios output of
>>> a s390x guest when running it with "virsh start --console" (with a 
>>> patched
>>> version of virsh that fixes the remaining issues there, too).
>>>
>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   chardev/char-pty.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>>> index 4e5deac18a..fad12dfef3 100644
>>> --- a/chardev/char-pty.c
>>> +++ b/chardev/char-pty.c
>>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev 
>>> *chr)
>>>   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int 
>>> len)
>>>   {
>>>       PtyChardev *s = PTY_CHARDEV(chr);
>>> +    GPollFD pfd;
>>> +    int rc;
>>> -    if (!s->connected) {
>>> -        return len;
> 
> Old code discarded the bytes here if it was not able to send them ...
> 
>>> +    if (s->connected) {
>>> +        return io_channel_send(s->ioc, buf, len);
>>>       }
>>> -    return io_channel_send(s->ioc, buf, len);
>>> +
>>> +    /*
>>> +     * The other side might already be re-connected, but the timer 
>>> might
>>> +     * not have fired yet. So let's check here whether we can write 
>>> again:
>>> +     */
>>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>>> +    pfd.events = G_IO_OUT;
>>> +    pfd.revents = 0;
>>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>>> +    g_assert(rc >= 0);
>>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>>> +        io_channel_send(s->ioc, buf, len);
>>
>> Could io_channel_send() return -1 in this case, and if so is it OK to 
>> ignore it?
> 
> ... so now you get the same behavior here in case they could still not 
> be sent.
> 
> Why do you ask, did you run into any problems with this new code here?

Peter found in chardev while testing a recent pl011 device patchset:
https://lore.kernel.org/qemu-devel/CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com/

For now I'm auditing our uses to understand better this subsystem,
and am looking at the returned values, and noticed this case.

Thanks,

Phil.

