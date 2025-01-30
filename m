Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1696DC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 12:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdTY8-0000F1-Va; Thu, 30 Jan 2025 07:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdTY7-0000ER-A5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 07:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdTY5-00015C-Cd
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 07:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738239692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k7PADETBOPriYbe6v3UxyD97jr11fizzLXb3N77s4QI=;
 b=UfaHXOMtSreWsLjkbtkfn/g8bquj1KT+8KlJmnPZsec5fwCEDVnxGGuFN9upfhMWfEY2vE
 rMQhAHFlKi/mIxSxEDVNNhXjdh7Apg7lPVaKdxneM5kEOw5JyysrlsIKSW8SOjrcbF0kup
 UeBrt/hpePo/o0DShFMPwDjhgkDnDKM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-KqzAUJk_OhGXXLhvNbJRbg-1; Thu, 30 Jan 2025 07:21:28 -0500
X-MC-Unique: KqzAUJk_OhGXXLhvNbJRbg-1
X-Mimecast-MFC-AGG-ID: KqzAUJk_OhGXXLhvNbJRbg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6eabd51cfso120811785a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 04:21:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738239688; x=1738844488;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7PADETBOPriYbe6v3UxyD97jr11fizzLXb3N77s4QI=;
 b=BF5QvBVLzMrnEFnHrAUl0BokiPQ4cRq7HIHATwMz/dNEl5+ooOmyl0vBXfh23ASP4v
 8qOh6mH69mundNxLrR0elJDUmoPSAjEXE7KFwslclM9bcshvAsyChEPqMXEDDiKBa971
 hsL7apc+FvLTkFLRvNqlux3s+apiuKeo7n2I4PV9MINXnJudt12J/I5d6pA2pOKU9u4z
 ri9DTQtXDeQHctcQLy6U9tcGObQauPZsP4mGJYmiXYpLi4sC1dERGsQeuKh9OBVXCPb0
 iBwPT+gpsjWCi2utOuQ8H71OOqRAcps1La2MU7n6YN8JP3ey6iwSCJ086MgQzgnwIW44
 AXHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH1KCx86iJpYevSnmyCs5PiSjqtlhIe86yzRecJYjIlBqYX1TL7K+1TEMIOE46kWfTR10XfDtiAxdh@nongnu.org
X-Gm-Message-State: AOJu0YyuqAuPvry6rj2JaDXKmiQKhHfC/Zo+3nmG73/sZkXa/eP8tIJy
 eGbef3phSCiyXb/1Zs4SG5KUEFuqRKLEVl/oG9rG1S8667Ugl4GP4IL1c3zNmBR+clOAgpZXDMJ
 7P8b5o0VbbXf0/ZnYI3edk5iuFLQLjb0QWA/Gif+JcxrLIDUGvn6x
X-Gm-Gg: ASbGncv1qeFbWiETSqd5AHkUbu7NpOpLMtM5OUUgdfsVTANr3tFVU4b9cvd7fhHb1Xi
 6Pme/ARHugnnUhRzQKCHMoQDRKZkinBHz11quQvb652LROpYiPnqTRwSbUfyGjiiVrvA6lQOUYt
 3zjcXF3IUGu7TQFR28QBCoI/aqCpbzlpH75o71BBS2eHinBXVQX6sPNohNhba0USP70ptkXkJYN
 f+cdAlAwulyBKSXwcVG0Ciz4zbAzyVphPCKAMvpxBIoojhJLP4Ba4jtOS2giDJ6p2Xlc8B4CRa7
 EOedPFOBF4mwzL5wglbTpY63aBYH/rzmx2r/
X-Received: by 2002:a05:620a:2b8a:b0:7b8:6242:18b8 with SMTP id
 af79cd13be357-7bffcce2f2amr923877985a.16.1738239688220; 
 Thu, 30 Jan 2025 04:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMcJBzepdIB9C7tdkecJDGigBVBSEjkhMKH5yP9DnnCN0MnEjTPqLmSZXFGW0EVTbgYhXRbw==
X-Received: by 2002:a05:620a:2b8a:b0:7b8:6242:18b8 with SMTP id
 af79cd13be357-7bffcce2f2amr923874585a.16.1738239687852; 
 Thu, 30 Jan 2025 04:21:27 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d0203sm68173585a.47.2025.01.30.04.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 04:21:27 -0800 (PST)
Message-ID: <c445afee-582d-46f7-a3eb-6b04f3b6cdee@redhat.com>
Date: Thu, 30 Jan 2025 13:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/slirp: libslirp 4.8.0 compatibility
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Samuel Thibault <samuel.thibault@gnu.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250130114810.857224-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250130114810.857224-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 30/01/2025 12.48, Michael Tokarev wrote:
> Update the code in net/slirp.c to be compatible with
> libslirp 4.8.0, which deprecated slirp_pollfds_fill()
> and started using slirp_os_socket type for sockets
> (which is a 64-bit integer on win64) for all callbacks
> starting with version 6 of the interface.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v2: update other callbacks too, use version 6 of the interface
> v3: commit the changes before sending (*_sock => *_socket)
> 
>   net/slirp.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index eb9a456ed4..2d2a58a6ee 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -247,7 +247,14 @@ static void net_slirp_timer_mod(void *timer, int64_t expire_timer,
>       timer_mod(&t->timer, expire_timer);
>   }
>   
> -static void net_slirp_register_poll_fd(int fd, void *opaque)
> +#if !SLIRP_CHECK_VERSION(4,8,0)
> +# define slirp_os_socket int
> +# define slirp_pollfds_fill_socket slirp_pollfds_fill
> +# define register_poll_socket register_poll_fd

If I get that right, register_poll_socket has just been added to libslirp 
4.9.0, but is not available with 4.8.0 yet? ... so you might need to split 
the #if into two parts, one for 4.8.0 and one for 4.9.0 ?

  Thomas


> +# define unregister_poll_socket unregister_poll_fd
> +#endif
> +
> +static void net_slirp_register_poll_sock(slirp_os_socket fd, void *opaque)
>   {
>   #ifdef WIN32
>       AioContext *ctxt = qemu_get_aio_context();
> @@ -260,7 +267,7 @@ static void net_slirp_register_poll_fd(int fd, void *opaque)
>   #endif
>   }
>   
> -static void net_slirp_unregister_poll_fd(int fd, void *opaque)
> +static void net_slirp_unregister_poll_sock(slirp_os_socket fd, void *opaque)
>   {
>   #ifdef WIN32
>       if (WSAEventSelect(fd, NULL, 0) != 0) {
> @@ -286,8 +293,8 @@ static const SlirpCb slirp_cb = {
>   #endif
>       .timer_free = net_slirp_timer_free,
>       .timer_mod = net_slirp_timer_mod,
> -    .register_poll_fd = net_slirp_register_poll_fd,
> -    .unregister_poll_fd = net_slirp_unregister_poll_fd,
> +    .register_poll_socket = net_slirp_register_poll_sock,
> +    .unregister_poll_socket = net_slirp_unregister_poll_sock,
>       .notify = net_slirp_notify,
>   };
>   
> @@ -314,7 +321,7 @@ static int slirp_poll_to_gio(int events)
>       return ret;
>   }
>   
> -static int net_slirp_add_poll(int fd, int events, void *opaque)
> +static int net_slirp_add_poll(slirp_os_socket fd, int events, void *opaque)
>   {
>       GArray *pollfds = opaque;
>       GPollFD pfd = {
> @@ -363,8 +370,8 @@ static void net_slirp_poll_notify(Notifier *notifier, void *data)
>   
>       switch (poll->state) {
>       case MAIN_LOOP_POLL_FILL:
> -        slirp_pollfds_fill(s->slirp, &poll->timeout,
> -                           net_slirp_add_poll, poll->pollfds);
> +        slirp_pollfds_fill_socket(s->slirp, &poll->timeout,
> +                                  net_slirp_add_poll, poll->pollfds);
>           break;
>       case MAIN_LOOP_POLL_OK:
>       case MAIN_LOOP_POLL_ERR:
> @@ -629,7 +636,9 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>   
>       s = DO_UPCAST(SlirpState, nc, nc);
>   
> -    cfg.version = SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
> +    cfg.version =
> +         SLIRP_CHECK_VERSION(4,8,0) ? 6 :
> +         SLIRP_CHECK_VERSION(4,7,0) ? 4 : 1;
>       cfg.restricted = restricted;
>       cfg.in_enabled = ipv4;
>       cfg.vnetwork = net;


