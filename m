Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD16ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 16:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2XW-0003Nc-Pp; Thu, 06 Nov 2025 11:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vH2XU-0003NM-Mm
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vH2XS-0000aA-Lc
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762445320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxtOmAhmFFbM1s2mwl8Jj2q62YhaU8SeXIvPxuE06Mw=;
 b=X3eOK/bTodwMGp+CxdbuGUNYlNGHApzFJLQfqXom3tIRRuS2jpxzt5Kq8Kv5AVnMG+DP2F
 Tnwy8RZliBq+dc1ROLGAU8z88NsJmSVaIqlAP/UmuytUufrgtkrwD7yrBVnIp55smsx0G6
 x8LI6ltndyKb64Eh6IxnCmPw+fzr1As=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-b_6SFyCwP1OW6Sd-EkzNZQ-1; Thu, 06 Nov 2025 11:08:38 -0500
X-MC-Unique: b_6SFyCwP1OW6Sd-EkzNZQ-1
X-Mimecast-MFC-AGG-ID: b_6SFyCwP1OW6Sd-EkzNZQ_1762445317
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429cdb0706aso831727f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 08:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762445317; x=1763050117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UxtOmAhmFFbM1s2mwl8Jj2q62YhaU8SeXIvPxuE06Mw=;
 b=G3rwsDIUmGpPDm3KKnuMx+siysUTBUESkRfo4N04J+KDoR1S6Pn9lWfRJA/r7vzw8H
 vq86IcaETIHhR/znvWby8ngLArgLYY7EsfS4blKyF45fAvehB/vy/6XV4v4cGVVY/syo
 MlwYv92OdBolD0HHovH0iN9O1N0p7DX/qL64DM4qHEiEJYR6VEkNbxRp8L0F18AeRIfQ
 7d4ulwX/S72EDXZnRGuc0ZCF/79+Pg6tkWKAUG+9WMtMYWa9ERnwIULAOwOoyIJ4rFAA
 N/r5GAYVf8TIdMvTGcOU7VG1JkNtyf3n/BKSsJVJEBe4nUackPWl7GhQIIinu1+ssqSm
 ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762445317; x=1763050117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UxtOmAhmFFbM1s2mwl8Jj2q62YhaU8SeXIvPxuE06Mw=;
 b=HGgiYTVuX/FbNEyy5ek4yfimVBKeCORg8G2w/KboAlLT/KFKG0ndHme/w8gjAmT5cA
 YqB+SXhOZYkIERQ/GX2qjBLl5bkuGLGEc2ayR2xkfBHT5RrAPOtn+IXfBmapq03xOk99
 266XNmL5Gil684u8jCmVzLL/Fj//BaY5U+pSFsNp71S+rFaLb6LCahB+k3JjFKpHqjEe
 SiVv9ezB39IIKpooBb9vxUGpx0XgChs880U2Nm6C6fHLL+BOQc5mxoRhemsZbk9srbOJ
 EfzqVynm97XACHzpT28eWujLRb0H/Gx+NUfBaV7tD5yq9vHgeo0s7waZ0bbRgdvnCF4H
 GOwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVpH3AyvAQvYJ0SJy6gfJCmrhyT3yHpdUAhL/OROqtg6SWJA+dBdxl0t1ZLkEmNjsev39VQLud7sx@nongnu.org
X-Gm-Message-State: AOJu0Yz5jDsdxL8n437SyWQjJpoI+s1eZbKSYUEwp9pLVs7c5NhKcxyc
 d41XhiSHXdKdMFF1gDEut2Jso+1PckbX+e4hUD+EBpyXuCectaPX2Wfdl6orJU8FLM8K250a2p9
 XExSQTgD2cvWl1e4N+H3IbyXjmjKPorLcjD/OHotoWSoHOWmc7eTGH/FU
X-Gm-Gg: ASbGncur2s+EnhpBN/opEiLulcmSlVMVSJkzXHUWpgNr4aAZkGzKB2veq0MaDjtvoJn
 HZb+kCfkFYcpwaRbUQl5CHaRZBHR1oWj/gNqPU3s6j7R5x9uBrSUxOLjuu1CQk2mYPlGmmjTSNn
 I/AfoZEg+wE4uoMTrfuCysW76fNEMCVm4LLBGz0Xc36kdh8kpVetNWV1So3Ii80knzySK7pmOKX
 +oSP5nsvU0YIHb3qB2Lz5yTQp3I0pFQU2Y/8NETGttDSQJB0c++FqgpGcqiQQoS7VQXbnrBgRag
 yZE+JIveusPv4vobND7qTivOEpai7jLgramY3AEzRoO+Id871iCydZuWohEI803HrVpg8RTlM5+
 9mlkR4r0SCHB1BxwiDgzkLEN+NOeVau/kVwkeaunuiJTGCwpVPaog9IW3o/uKxnFThypNMBAs6M
 C1mHPv8av5Clb4oMYdJkM9A9UqbJCA
X-Received: by 2002:a5d:5f50:0:b0:427:719f:de70 with SMTP id
 ffacd0b85a97d-429e32e48d5mr6908152f8f.14.1762445317424; 
 Thu, 06 Nov 2025 08:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKvHuDjvRlmP6iR3WSfPg2VrUp1mYLCZsTR7pGO+GgIWX2UdSy1j7Rg8JVKrcJ9xnGJq+ySQ==
X-Received: by 2002:a5d:5f50:0:b0:427:719f:de70 with SMTP id
 ffacd0b85a97d-429e32e48d5mr6908121f8f.14.1762445316957; 
 Thu, 06 Nov 2025 08:08:36 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1fbe:5be2:af15:c77e:cc7d?
 (p200300cfd7171fbe5be2af15c77ecc7d.dip0.t-ipconnect.de.
 [2003:cf:d717:1fbe:5be2:af15:c77e:cc7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4ad537sm5648493f8f.42.2025.11.06.08.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 08:08:35 -0800 (PST)
Message-ID: <7991d0d5-7d41-4564-97bd-bb73d6057f19@redhat.com>
Date: Thu, 6 Nov 2025 17:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] qcow2: Fix cache_clean_timer
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-11-hreitz@redhat.com> <aQJ30-Ifcji8lrme@redhat.com>
 <0d98f477-722c-4023-9b28-54d8faffff66@redhat.com>
 <aQSzm_LOySEpFmuG@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQSzm_LOySEpFmuG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 31.10.25 14:03, Kevin Wolf wrote:
> Am 31.10.2025 um 10:29 hat Hanna Czenczek geschrieben:
>> On 29.10.25 21:23, Kevin Wolf wrote:
>>> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
[...]

>>>> @@ -1239,12 +1310,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>>>>        s->discard_no_unref = r->discard_no_unref;
>>>> -    if (s->cache_clean_interval != r->cache_clean_interval) {
>>>> -        cache_clean_timer_del(bs);
>>>> -        s->cache_clean_interval = r->cache_clean_interval;
>>>> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
>>>> -    }
>>>> -
>>> I think the del/init pair here won't be necessary any more after
>>> switching to the background coroutine. It will just start using the new
>>> value of s->cache_clean_interval the next time it sleeps.
>> One problem is that if we don’t lock s->lock, the coroutine can read
>> s->l2_table_cache and s->refcount_block_cache while they’re invalid, which
>> is why I moved the deletion above.
> I see. This is a preexisting problem, right? The timer runs in the BDS
> main context, while qcow2_update_options_commit() runs in the main loop
> or... essentially anywhere else?

Sorry for the late reply, yes.  There may be the additional problem 
noted in the commit message, specifically that the timer may fire, run 
the CB in the BDS’s context, and is concurrently deleted from the main 
context.  It will then still run, so just moving the delete up is not a 
100 % solution I think.  We also need to make sure the timer code really 
isn’t running.

> Should it be a separate patch then? A comment in the code wouldn't hurt
> either.

I’ll add a comment.

>> We also still need to delete if the interval is set to 0 (or
>> special-case that in the coroutine to wait forever).
> If the coroutine terminates on 0 as you suggested above, that would
> automatically be solved.

I don’t think so, because we still need to be able to restart it (when 
transitioning from a value of 0 to a different value).

>> We could run all of this in a coroutine so we can lock s->lock, or we
>> have to force-stop the timer/coroutine at the start.  Maybe running it
>> in a coroutine is better…
> So qcow2_reopen_commit() would immediately enter a coroutine and
> BDRV_POLL_WHILE() for its completion?
>
> It's not exactly pretty (and I hope polling in reopen callbacks is even
> allowed), but maybe more local ugliness than having additional state
> (like s->cache_clean_running) to allow BDRV_POLL_WHILE() to wait for the
> cache clean coroutine to stop.

I think I’ll keep it as-is.  We’ll probably actually want to wait in 
detach_aio_context, too.

Hanna


