Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20166F36C31
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 07:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEivm-0005gq-Fk; Mon, 20 Apr 2026 03:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEivU-0005bg-Ar
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:20:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEivS-0005lg-HR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 03:20:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so6036395e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776669608; x=1777274408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q2R/4bu4Qx5VLoJElaowuRvfMVbmXN6v1Nl95K+mVBc=;
 b=eM2vxUesNntwzAHEEbJ520HXYoyyyfcRyMYYnEAoOqNC6mVSfR3K4F36NrObfjqAEj
 l0MY3c2alNv9thCOP4QkykYtX1tarOfMAGn/bamHPT8puVnGcSwk5DKQNQieAnHnEqbA
 Zung63AvusvoXzPw2NfRu2iAIxCM0pZ+8NhktOcv9WFQQTB+GlUIO8mkTAp8AOty2/Ns
 dxDbKzou9aYgZ4s6Hv3538gyCWYTOjOKGY/QdWlP5yPY8fFzkoFV/GB1sLWh5KReZyL5
 +AU0sOAX915hHJAHEziO69BOfUf01ofwx6wrJqIEfEfKyB28wJO1Gl8/8fbhIELJNO9h
 vbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776669608; x=1777274408;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q2R/4bu4Qx5VLoJElaowuRvfMVbmXN6v1Nl95K+mVBc=;
 b=fQzyD1/ptrW7eE7mXdCkpMcHFsgYlL/6lgpk/4URjWynK+6uDOvPe7fDbwKk8DwanB
 o3tRw2VEvbrrnpwaGuA6fWFpmWx1Mk067Gjrw+6GfWMHtMJaJlFI7BeNhl2XGsY9bqkj
 M5Je3G4h8AoPrMKVelEKX6u14K6s1WOCl2NKuikKdQdudosUg+dEf/inG1Z4t/xaLn/p
 qkbkmq+rDncj14UZC17XAAekx39OgF3aYQ5gmZugrXLP37pksEB2iK+PiMt7IO8D7JLo
 ZKrlS7GpmBYPrXuR8enhy20CkUdsfGneRPmZlhf2KmxTEhOd6RVPXjIbT5rkut9y7yO+
 4UjQ==
X-Gm-Message-State: AOJu0Yzsyt0qldrdXDdkE5446ZI0RU0LNPwc39FZQ8Kk8VAEYY7m6oFP
 NCbvhj/Omwo4q53ONOSR90iEWTIEM8kfxZNeCPmad4u7QmbAvM5Q+9xyNaAh3pbC1cc=
X-Gm-Gg: AeBDiesP9e+JYKz16OqOfl2ZmCPRFtQq5eKsnJH9JZnpvsX6i5vhl9bQLOdkH1z0Vm5
 RthQseibJnyZyxYl7/xEKeSl3AuZ7eQC3FmVrNHi43+V+t055MPvWKq9gBuVVH8d/49okcZxK+k
 sSTTKqP7dW6KEfDbprgVBiB0So+QZKVtwboKiTRRXafnOxLpbqG5Pg26mkL7gbGK+tMLrXdW7k4
 fKWHlFYL5CRHd9KNiqeAUdcsgEs6CUipN92vc23Ly/CfVtVpcY6eZFuHO50iTYNjMupjSQnstWw
 wbXKLmKcwBXEemFW7TzciQPW3MOIlczgjnJ77rqmJ+Npam+WgnW2uCjbmlJA8IUTWxO6mncLgOC
 /vizrRqze6168uY5kxvvOIQB7NxODbZtTZN47J7J4R0jJqZxr83WCJ04lY1n//rLZHeV5lcBAFu
 4jKjLqN7TopBdnqF4v+JK570IEXhUmoMZVquYzmjjspsXxG7h2jDESgmeX9CtniGVCqPjYERZ74
 oJh
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr28197065e9.3.1776669607594; 
 Mon, 20 Apr 2026 00:20:07 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm306375125e9.8.2026.04.20.00.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 00:20:06 -0700 (PDT)
Message-ID: <5998180b-55c1-40a7-8426-d21539f99100@linaro.org>
Date: Mon, 20 Apr 2026 09:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io: use g_clear_handle_id() for GSource cleanup
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Matthew Penney <matt@matthewpenney.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260408100605.66795-1-philmd@linaro.org>
 <20260408100605.66795-3-philmd@linaro.org>
 <_FLwJ4IKFwbr2FlwMah_gLTk8PG-FdvyrrFM2UgmbYPlN7wSwZIslJehtfZV7mb8w1UD69eX6LD5Lt9wGkstMiLrdrkkzU1coVZiuy7CSNE=@matthewpenney.net>
 <98a3dea5-266e-4326-b224-0a3401e49783@linaro.org>
In-Reply-To: <98a3dea5-266e-4326-b224-0a3401e49783@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/4/26 18:46, Philippe Mathieu-Daudé wrote:
> On 9/4/26 16:20, Matthew Penney wrote:
>> Hi Philippe,
>>
>> Thanks for picking this up and cleaning it up.
>>
>> This matches what I was aiming for with my series.
> 
> Thanks Matt, does that mean I can add your tag to this
> series?
> 
>    Reviewed-by: Matthew Penney <matt@matthewpenney.net>

Hmm maybe in this case Co-developed-by: is more appropriate.

But then we need to wait for Marc-André or Daniel for a review.

> 
>>
>> Best regards,
>> Matt
>>
>>
>>
>> Sent with Proton Mail secure email.
>>
>> On Wednesday, 8 April 2026 at 11:06, Philippe Mathieu-Daudé 
>> <philmd@linaro.org> wrote:
>>
>>> Use g_clear_handle_id() instead of g_source_remove() with
>>> manual ID checking and zeroing.
>>>
>>> This simplifies the code and ensures consistent handling of
>>> GSource IDs, since g_clear_handle_id() checks for a non-zero
>>> ID before calling the cleanup function and zeros it afterwards.
>>>
>>> No functional change intended.
>>>
>>> Mechanical change using the following Coccinelle spatch script:
>>>
>>>    @@
>>>    expression TAG;
>>>    @@
>>>    -    if (TAG > 0) {
>>>    +    if (TAG) {
>>>             g_source_remove(TAG);
>>>             <... when != TAG
>>>             TAG = 0;
>>>             ...>
>>>         }
>>>
>>>    @@
>>>    expression TAG;
>>>    @@
>>>    -    g_source_remove(TAG);
>>>    -    TAG = 0;
>>>    +    g_clear_handle_id(&TAG, g_source_remove);
>>>
>>>    @@
>>>    expression TAG;
>>>    @@
>>>    -    if (TAG) {
>>>             g_clear_handle_id(&TAG, g_source_remove);
>>>    -    }
>>>
>>> Inspired-by: Matthew Penney <matt@matthewpenney.net>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/char/cmsdk-apb-uart.c  |  5 +----
>>>   hw/char/nrf51_uart.c      |  5 +----
>>>   hw/char/serial.c          |  6 +-----
>>>   hw/char/stm32l4x5_usart.c |  5 +----
>>>   hw/char/terminal3270.c    |  5 +----
>>>   hw/char/virtio-console.c  | 10 ++--------
>>>   hw/usb/redirect.c         |  5 +----
>>>   io/channel-websock.c      | 13 +++----------
>>>   net/passt.c               |  8 ++------
>>>   net/stream.c              | 15 +++------------
>>>   net/stream_data.c         |  5 +----
>>>   net/vhost-user.c          |  8 ++------
>>>   ui/dbus-clipboard.c       |  6 ++----
>>>   ui/input-barrier.c        |  6 +-----
>>>   ui/vnc-auth-vencrypt.c    |  6 +-----
>>>   ui/vnc-ws.c               | 12 ++----------
>>>   16 files changed, 25 insertions(+), 95 deletions(-)
> 


