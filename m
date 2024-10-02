Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAB7CF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwnu-00034n-IS; Wed, 02 Oct 2024 06:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwns-0002xQ-3r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwnl-0002a0-Uh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jk+6uwbU3+q/YGIC1U4HcCbOtPCb9GLeymuWSf5rIMg=;
 b=ZYdqkLnxwvTqbgR/boVAENzU2NQcERdCj/PUb6xWaWLfr9nrmofQtc23ChFXa1buYqD99J
 7QzxUsncGFZL027YVEH92HSdrRGqVLE9BCycdXrDAZpMHGgqvP2QPZsoqgQv+eRWyraA2T
 u4gjXoBWqLFklBuaVbRg8AAlMSDl9MI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-qxt5bM7MMJSENn28hCXXUQ-1; Wed, 02 Oct 2024 06:41:47 -0400
X-MC-Unique: qxt5bM7MMJSENn28hCXXUQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb115566eso65157185e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865706; x=1728470506;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jk+6uwbU3+q/YGIC1U4HcCbOtPCb9GLeymuWSf5rIMg=;
 b=UBlCXT/BrIgG4ev0eM93syf4cwWhbT6pp0WCgjAeRnrKeCcTMUT/RrQVMquQlHiCZg
 0ZJMYDgA0FDLH88XgZRFJ3o8HeTPlaUNm9WP3ktSLP7D4fH+xcWWjNxbS5IbjkjEkRyr
 afWjq370JrhbaN4PH3qX3ohW/huKYhYj08WziDO5VK309lHZMianMizqhda0ZgGuuFuL
 BuHl9Ey7xMahH8wPuLwmcpOMIYFRsHQ0vBIi+0XVKP2Vs7otcpdWjmGp1cdLLlTR4JYm
 4Wa4zWMSU6XMJLMZ3I6jBiNplLCFjPMuu+51hblkTuVeK/0xBtmeOxgMkL/Tr7vj4qBw
 88oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7A51vjFYiJsvLkm+0mNvlPhihmw3YcYJFPdAc5ZL6xIVMWJRUbQA2jsHMCG3yiSGrfJA2isUHm7iK@nongnu.org
X-Gm-Message-State: AOJu0Ywv+1MgsUbdIF1YiCkeW4KcKw6sBy4RD95STDCxjg0qME2cqcwZ
 d15iqSabAo8j53iHasX3igKfiZPT0J8Dk/fXLvY7hFjj34vhNWup4hAv9u0YEugUEEphYcurOYS
 yuZGM6b2dnjOHHS6qOPlw65rHMjI/QYhH02r4QxGrrllzCxIeEzTH
X-Received: by 2002:a05:6000:c9:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37cfba19c9amr2397619f8f.55.1727865706494; 
 Wed, 02 Oct 2024 03:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsT/UcOOX1wF4XzUTMJamNALfDPq/+4M53dYqDtYVw6vCmJjwxLUBmA8EGusw1CZLiIXHbhg==
X-Received: by 2002:a05:6000:c9:b0:37c:d2e3:1298 with SMTP id
 ffacd0b85a97d-37cfba19c9amr2397587f8f.55.1727865706004; 
 Wed, 02 Oct 2024 03:41:46 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d27csm13629502f8f.23.2024.10.02.03.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:41:45 -0700 (PDT)
Message-ID: <31578ca3-4819-463a-85ba-d12aa784e377@redhat.com>
Date: Wed, 2 Oct 2024 12:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: Remove unused replay_disable_events
To: dave@treblig.org, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240918234005.466999-1-dave@treblig.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918234005.466999-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/09/2024 01.40, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> replay_disable_events has been unused since 2019's
>    c8aa7895eb ("replay: don't drain/flush bdrv queue while RR is working")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   include/sysemu/replay.h | 2 --
>   replay/replay-events.c  | 9 ---------
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 8102fa54f0..cba74fa9bc 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -117,8 +117,6 @@ void replay_async_events(void);
>   
>   /* Asynchronous events queue */
>   
> -/*! Disables storing events in the queue */
> -void replay_disable_events(void);
>   /*! Enables storing events in the queue */
>   void replay_enable_events(void);
>   /*! Returns true when saving events is enabled */
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index af0721cc1a..2e46eda6bf 100644
> --- a/replay/replay-events.c
> +++ b/replay/replay-events.c
> @@ -92,15 +92,6 @@ void replay_flush_events(void)
>       }
>   }
>   
> -void replay_disable_events(void)
> -{
> -    if (replay_mode != REPLAY_MODE_NONE) {
> -        events_enabled = false;
> -        /* Flush events queue before waiting of completion */
> -        replay_flush_events();
> -    }
> -}
> -
>   /*! Adds specified async event to the queue */
>   void replay_add_event(ReplayAsyncEventKind event_kind,
>                         void *opaque,

Reviewed-by: Thomas Huth <thuth@redhat.com>


