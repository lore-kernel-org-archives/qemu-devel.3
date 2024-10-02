Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33882CF31B0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwnJ-0002am-8I; Wed, 02 Oct 2024 06:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwnG-0002aE-6y
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwnE-0002Yr-Az
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6lvvepeCr/w31iiapTDJFAzQrCKLFbSQiEUqxFrebgw=;
 b=XpzWL/Fl06GaP1MkE5gWVV9quaSBa26Rrny41ZjG6m/jVJ4+8oQpV4r+AAy5Kh6RMeGmSX
 b3Xi+0XX2gmZINpGIfumH3J8/nnVVEjvcUrg4oMiyGUpC8S+nDJ50Z5WOZIVTQAyOtMGXQ
 6gAEww5mEUOXyyPXvyeLzo9KVvOhrlE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372--V0B-coRPRuF9O49jkwERQ-1; Wed, 02 Oct 2024 06:41:11 -0400
X-MC-Unique: -V0B-coRPRuF9O49jkwERQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso37298405e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865670; x=1728470470;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lvvepeCr/w31iiapTDJFAzQrCKLFbSQiEUqxFrebgw=;
 b=wOdBv4jcQ5fkWXX31/dcpreYbsh0jwioF5MSb2PjccAt9Ioy0GAm1RuKQRo8EIEkaG
 SHHXnK6RrFNFnhqA3LJ3TMNR8Xl4OCmERAwY/gRFVyP+N+TXGdTCMnr0WespXOZNJZe5
 sRx2VTG2or4I5e4cR1DP8WYLBP9Wj41lJgtkZb+VVSqfhEYjItILyZuhQoxwCsPxFs3r
 bfCg3igx4YeHEKH1egAFx78y4yKxG1uYro5RQfDN7ECYQGnCYGVR33At+ddbaaBRRF5L
 89hFxNq57sfVSjk0eA9FFsi4OKtemTwYXk06S4AFN2wKU6w4noMKiZHCSeX2TVOmK0r/
 eGFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWedcJWyfME3g9ZGIbR4biNulGhsYM3RbVVkjE8tWGoQLSvB7SyypvXDUq0XAHWidsO9vFmfkvPQDaY@nongnu.org
X-Gm-Message-State: AOJu0YwghMjIlxA/VnIkPdvSIJkQxEOZF+76br9DElhLXZkv12KmuOmt
 F6+Ki1V3XlP0jakZ8hpZVqkTE1scLrS6vrME4+5yP9n8r8ZxvnFBes3FPnjj4nqQArDFwucdlYR
 YN3vW+vImtU2TUx7JQubzqhiPDuEjRe45yz8m5bhep9liZQJYiUGkuYrvGe6uXC8=
X-Received: by 2002:a05:600c:4705:b0:42e:93f4:5383 with SMTP id
 5b1f17b1804b1-42f777ecf6dmr16705575e9.23.1727865669628; 
 Wed, 02 Oct 2024 03:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjrRCfjE5CyiCwnTqrjl0B3KeyzxI0sIDQFmmrnoK3wgcS4mE6nqKbQ1GsnTssSkyG5bCs/A==
X-Received: by 2002:a05:600c:4705:b0:42e:93f4:5383 with SMTP id
 5b1f17b1804b1-42f777ecf6dmr16705365e9.23.1727865669199; 
 Wed, 02 Oct 2024 03:41:09 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a00bc5csm15175585e9.45.2024.10.02.03.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:41:08 -0700 (PDT)
Message-ID: <2149788c-ea6a-4e6c-be95-b4daa5c5aefe@redhat.com>
Date: Wed, 2 Oct 2024 12:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remote: Remove unused remote_iohub_finalize
To: dave@treblig.org, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240919165852.322707-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240919165852.322707-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/09/2024 18.58, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> remote_iohub_finalize has never been used.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/remote/iohub.c         | 13 -------------
>   include/hw/remote/iohub.h |  1 -
>   2 files changed, 14 deletions(-)
> 
> diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
> index 40dfee4bad..988d3285cc 100644
> --- a/hw/remote/iohub.c
> +++ b/hw/remote/iohub.c
> @@ -33,19 +33,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
>       }
>   }
>   
> -void remote_iohub_finalize(RemoteIOHubState *iohub)
> -{
> -    int pirq;
> -
> -    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
> -        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
> -                            NULL, NULL, NULL);
> -        event_notifier_cleanup(&iohub->irqfds[pirq]);
> -        event_notifier_cleanup(&iohub->resamplefds[pirq]);
> -        qemu_mutex_destroy(&iohub->irq_level_lock[pirq]);
> -    }
> -}
> -
>   int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
>   {
>       return pci_dev->devfn;
> diff --git a/include/hw/remote/iohub.h b/include/hw/remote/iohub.h
> index 6a8444f9a9..09ee6c77b6 100644
> --- a/include/hw/remote/iohub.h
> +++ b/include/hw/remote/iohub.h
> @@ -37,6 +37,5 @@ void remote_iohub_set_irq(void *opaque, int pirq, int level);
>   void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg);
>   
>   void remote_iohub_init(RemoteIOHubState *iohub);
> -void remote_iohub_finalize(RemoteIOHubState *iohub);
>   
>   #endif

Reviewed-by: Thomas Huth <thuth@redhat.com>


