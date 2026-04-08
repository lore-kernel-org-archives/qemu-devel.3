Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4338210F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYZa-0005G4-JZ; Wed, 08 Apr 2026 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wAY7l-0007so-5I
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wALGN-0001Gs-RR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 01:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775625336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=anDg1AsAF6woKXVQvgN1bJcMLtaFg0chLBWiuFDUSEY=;
 b=LyFiV419sQMNlt73j1kAb0NMwyW38qq+B2X+r9CLUdPE4Z1anMmg/DnwRxfYdSZpzX72L8
 WupRCPJq8+G1WFJOeqgLztfUFBOuyx2i3fYC4/ayQ5dvNvSe+4sk7L1vUYGIla431w2QfL
 QT9FBRmrWhmGt6eSXprxDZQXL9vlxaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-FENpv_naNgOIsvR2rCynHQ-1; Wed, 08 Apr 2026 01:15:35 -0400
X-MC-Unique: FENpv_naNgOIsvR2rCynHQ-1
X-Mimecast-MFC-AGG-ID: FENpv_naNgOIsvR2rCynHQ_1775625334
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488c213b485so9077985e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775625334; x=1776230134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=anDg1AsAF6woKXVQvgN1bJcMLtaFg0chLBWiuFDUSEY=;
 b=HwRgOxaJhNipH0ADr6V9ehzgWlK+UAaZCyb+39yNzE9s3q4mEjjPmY9hJ072046FVn
 9Hq1hhS6LqVcKxkXC1RMouYpUi/gEK39DJwN5zgpqov/kC0uEY3qreaoVhdoHh3w7GeD
 HiVKCimHw3e5HZIUtnnXkfFPSo5Mu2CQfFHpZZZSMdnLMbsvPpQm3MNUG9r3ElSHDXeg
 fXYbna0OkpBEXdHazCnCtVhsbczuz2fNo1pH7YPwI4H4ydW6HXt5gNANjQ5dTc/ASJZK
 N+8UBnqMbmTASewCvpgXI26wKDn4ZHO5Jc7fy30nCEKj8yscaLbNNaI5eVwnRJlUtd/6
 eY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775625334; x=1776230134;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anDg1AsAF6woKXVQvgN1bJcMLtaFg0chLBWiuFDUSEY=;
 b=BiGQN/DmdFUuxAHB27URRNvlfwCZ9XCgk1GzpWdwK0E+Gngi81DdR9qY/mbJu4YV2f
 nRXSIpvQ+qVh9QqJNNjgOZ0+ReZCRCuMtPHkK99kflhzmjAau+SMhzBOMwnf2iFeM9gf
 /m+ZEfXYDCGKUMzjWEm3zvsU12BJXg1rVwy8vgh3+ZpA2SZiOh9cT1vAi0Ek+ky65lFg
 lKQlyzhkKqMR7sCEIFH+HK15aCj2/0DShIbfeA+VOvQ2vKDqX/EMjxtJ8zHsAxA3iacS
 cbRsOBtAx+GHAWmVhlLN1PQJDUL7Mjq+G+5wEEbDPRDVHFcGTblbiHYCmj5QI64ea8aI
 qnhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN2PHBLikoRo51GLjB00wyiuxKQRm7EBKR9Gj4WmhO33IC+uZAlIakzvtCikUTHW5dMhTYWpD+Cy/x@nongnu.org
X-Gm-Message-State: AOJu0YxDVYg+odcA+Sx2fWhqTzbPoruR9NzKXopmfc4PTiQREewfO0iZ
 2DS21AIXD3sEhEmS4bdR+XJwWRA/WEAWtnheQoXUjp3TFjIonZgm2DMnH3GyYlBOuspbvdMeZ4U
 w2KUfvPM1SeuI/NrcTW1PvmFth3a2yJATp1JYlEB+VZcL7vKPK4fwcIEa
X-Gm-Gg: AeBDies4MbgqL/YBz0flRgWWyPqvWZKQBKFZCnaBuUXIoJ9CynJiTNKItLAHVcrV0GI
 bydiNDZCDofMyaOZCFGcUCAkcXSn98Xhr3NQoJGbA6+ipJErOSnI5RF4AU10JqyE2rm8a0vZR6/
 Mc5VltQFtYIJHJ1moP5GgV2zEblhJJYK2pEBZ4uS+7F0LGqjEwT8kcbJxV3upSFfkvuWhIppwD4
 B2ZSr0a1AQfSxSkyZXDpKbhfmbuo73PZ7pc3VsElzBbuLN55E/wOiQRQJVz5GCnz+dcaadqp6ey
 LeFPNrvYKoezVFc8vjDcIBmddxQCbz3FW8oL+OPGyFL1EO0XVxDSj/wtSwRD2Ws4uPaCn20A8R4
 1U9NLWbOlmoSgOP2Ulg==
X-Received: by 2002:a05:600c:138f:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4889970e3c4mr269418425e9.11.1775625334148; 
 Tue, 07 Apr 2026 22:15:34 -0700 (PDT)
X-Received: by 2002:a05:600c:138f:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-4889970e3c4mr269418195e9.11.1775625333700; 
 Tue, 07 Apr 2026 22:15:33 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488be75215dsm106869205e9.6.2026.04.07.22.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 22:15:33 -0700 (PDT)
Message-ID: <7c4c01de-475c-4864-9dc4-743bf8d10247@redhat.com>
Date: Wed, 8 Apr 2026 07:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audio/pipewire: Fix stack overflow by moving buffer to
 heap
To: Jun Yu <yujun@kylinos.cn>, marcandre.lureau@redhat.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Cc: mark.caveayland@nutanix.com, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260408012341.16131-1-yujun@kylinos.cn>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260408012341.16131-1-yujun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/04/2026 03.23, Jun Yu wrote:
> The PWVoice struct was allocating a large 4MB buffer on the stack using
> uint8_t buffer[RINGBUFFER_SIZE], which could cause stack overflow.

Which function is this? I.e. where does this get created on the stack?

> This commit:
> 1. Changes the buffer from stack allocation to heap allocation by replacing
>     uint8_t buffer[RINGBUFFER_SIZE] with uint8_t *buffer
> 2. Adds g_malloc() calls in qpw_init_out() and qpw_init_in() to allocate
>     the buffer on the heap
> 3. Adds g_free() in qpw_voice_fini() to properly clean up the buffer
> 4. Adds error handling for allocation failures
> 
> This fix prevents stack overflow while maintaining the same functionality,
> as each audio stream (input/output) still gets its own independent buffer
> for the ringbuffer operations.

Just to double-check: Did you use AI to create this patch? Or just for the 
patch description?

> Signed-off-by: Jun Yu <yujun@kylinos.cn>
> ---
>   audio/pwaudio.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index a59c22e60b..ff75ec2af2 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -56,7 +56,7 @@ typedef struct PWVoice {
>       uint32_t highwater_mark;
>       uint32_t frame_size, req;
>       struct spa_ringbuffer ring;
> -    uint8_t buffer[RINGBUFFER_SIZE];
> +    uint8_t *buffer;
>   
>       pwvolume volume;
>       bool muted;
> @@ -532,6 +532,12 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
>       AudiodevPipewirePerDirectionOptions *ppdo = popts->out;
>       int r;
>   
> +    v->buffer = g_malloc(RINGBUFFER_SIZE);
> +    if (!v->buffer) {

g_malloc never returns NULL.

> +        error_report("pipewire: failed to allocate buffer");
> +        return -1;
> +    }
> +
>       pw_thread_loop_lock(c->thread_loop);
>   
>       v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
> @@ -551,6 +557,8 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
>                          ppdo->name, SPA_DIRECTION_OUTPUT);
>       if (r < 0) {
>           pw_thread_loop_unlock(c->thread_loop);
> +        g_free(v->buffer);
> +        v->buffer = NULL;
>           return -1;
>       }
>   
> @@ -579,6 +587,12 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
>       AudiodevPipewirePerDirectionOptions *ppdo = popts->in;
>       int r;
>   
> +    v->buffer = g_malloc(RINGBUFFER_SIZE);
> +    if (!v->buffer) {

dito.

> +        error_report("pipewire: failed to allocate buffer");
> +        return -1;
> +    }
> +
>       pw_thread_loop_lock(c->thread_loop);
>   
>       v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
> @@ -595,6 +609,8 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
>                          ppdo->name, SPA_DIRECTION_INPUT);
>       if (r < 0) {
>           pw_thread_loop_unlock(c->thread_loop);
> +        g_free(v->buffer);
> +        v->buffer = NULL;
>           return -1;
>       }
>   
> @@ -619,6 +635,8 @@ qpw_voice_fini(AudioPw *c, PWVoice *v)
>       pw_stream_destroy(v->stream);
>       v->stream = NULL;
>       pw_thread_loop_unlock(c->thread_loop);
> +    g_free(v->buffer);
> +    v->buffer = NULL;
>   }

  Thomas


