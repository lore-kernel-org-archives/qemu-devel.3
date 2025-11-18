Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0CFCEBF97
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLN9n-0000Lp-3m; Tue, 18 Nov 2025 09:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLN9k-0000Kp-2Q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vLN9i-0002qf-4q
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763477885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z/aa8yfyRA+tzhhe96SEZJlyh7EQAcrppLYu/LHLY6Q=;
 b=HMOPqPXLn4Z+hpPyVDcCZxNsQ511rN3hP3ip+/jBX+dcJW5WUB68qO+c9y8HYGF6xKhs9M
 fUddPQJapN6exfT+6CnVugCbJen4n1U/ZeBsBpBwuNY6BhfmoDNqmts8F8AXahhwfAN9V4
 mug/h/MDb5nM39oIzGDAQI5L6vZ1kds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-PCxCZzDWPMeGAPGmEildaw-1; Tue, 18 Nov 2025 09:58:01 -0500
X-MC-Unique: PCxCZzDWPMeGAPGmEildaw-1
X-Mimecast-MFC-AGG-ID: PCxCZzDWPMeGAPGmEildaw_1763477880
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2ffbba05so2965687f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763477880; x=1764082680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/aa8yfyRA+tzhhe96SEZJlyh7EQAcrppLYu/LHLY6Q=;
 b=oXknvUIDSKT4HaBqlNCNAae8pgVGATGx4qNn0zK15Xm9OXFDrZ5GbWNvzgki7JwmLV
 ZvSzQc5i9prRgRMMdtQzGNaG0zDbE9cbxqeHvanjnlsWfJcJJcJodUQ8hEfv9h5ZFlqz
 jqLO35U/d/tzjvi6N61ZniL+oSueVltBzhPLjo2mpi8yn42y8p1Iqd92j/+djTdKnVVo
 P+HcGw77nh+1DU6E8u+x1wTruhSaaHA9ULmuM7WuVBl6/4tw0uev00XtS4xVNLHU6x3W
 XUEOGpH0lmravkWmd+RQO/l20NvvES7ddw2hFz3z5N4IWKjSv7HcdqOPu1mK+0Re+sIO
 iCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763477880; x=1764082680;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/aa8yfyRA+tzhhe96SEZJlyh7EQAcrppLYu/LHLY6Q=;
 b=FNqks6vyWs8wzfXtg/4TgK8mwGr2kgYy8JDgceeEEyKuxiRSyV9rTCBM4xa/j4Vx1Q
 eaEQJ9emLUwP586GTQm2aOOjKuUwrfkR8ToYrFcPRsK9Le4FDxexy2vJNNP/6+vorFPe
 QHfkwM0eCNTaHSKxANgxpF957MiZyg8ujdI3rpkPkQ8ZCgaEGkvFiaYv44xE67MVVJHI
 BGLYxq0N2BEjGK9M3cKZD/ePWa6UZNqYF8tje2jFkPdNTPM82mS3p9u/F0S4o0zRMuZG
 JJelXZSOPSms1bnwlA7AQafFGF9XJe92oDND9dpHADf1mPFCLNhN7iyhCV8vZDd8D/e8
 MpDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUao0PAkniRnpMd6TQqDB/Q9COCsDb+SlhH3U0Y0elu7MBkA9V4gT/xPxHa8rSPmLJWXd5D6uvuD/7a@nongnu.org
X-Gm-Message-State: AOJu0YwWDUybvkARfXNqcwPaBgFUyxN9huhsHIHCjWaVuOlMiy1n6Q7f
 rWbDmjux7OtSCs5EI35HTBzrLhIlR2i0Su/+TnPd/bGX424j013Rx1RynmeNBpyEMcrpN9jyQuq
 mW1Hn2rj6V/YYN4S11EagsKPRI6ufSpFwsSCOClcqm74waHl0J5jwwCm8
X-Gm-Gg: ASbGncuWc7YhiY2dybUsn9z7q8StD0RNhKBVNJvyKYvDU6aP2gTwg6qEov6THpWVG9i
 e5z9ROHKSCpukEDO38CJhnl4SJ5KfO3XXI/H1lspyUA6hK8AM6XOgQTcYaTJNQDepgphZma7bv5
 HjKhVKYv/pFvCHcl6rJEjEPIZaOeYBvb5zThah/OJsNnjquvejhrcf7GgJHYDgVkPg003RUFAsE
 08rXgmDTR4mTL3AlN0bIGgIdeV6xRS7q652dq0lROQOX4ILFnFsoctc8b/Vn10j3l7OjlUiG4FR
 qnXb6N10cWQ+ANCrb+z1Ux2jPSEF9aEdmBc30vLvxSRYDxiEFAy8Wt7Df9kjiUWQ0yQSaoZw8QK
 lxzg92iwrvXUrgMqLMbpP+dlow41vtmtPa8Tktg==
X-Received: by 2002:a05:6000:40cc:b0:429:b9bc:e826 with SMTP id
 ffacd0b85a97d-42b59399155mr17209384f8f.53.1763477878863; 
 Tue, 18 Nov 2025 06:57:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/6IDGmi3zfdLUyeWuK9xJ1cU3S0zNwhJMRBb593metR2f6EVi8X74OCb603F0x0hXpI/pNw==
X-Received: by 2002:a05:6000:40cc:b0:429:b9bc:e826 with SMTP id
 ffacd0b85a97d-42b59399155mr17209355f8f.53.1763477878228; 
 Tue, 18 Nov 2025 06:57:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm32198030f8f.9.2025.11.18.06.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 06:57:57 -0800 (PST)
Message-ID: <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com>
Date: Tue, 18 Nov 2025 15:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251117155656.2060336-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 11/17/25 16:56, John Levon wrote:
> This function was unnecessarily difficult to understand due to the
> separate handling of request and reply messages. Use common code for
> both where we can.

It's still difficult to read :) Could we have feedback from Thanos or Mark ?

Thanks,

C.




> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
>   1 file changed, 30 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 87e50501af..aa5b971fb6 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
>    */
>   static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>   {
> -    VFIOUserMsg *msg = NULL;
>       g_autofree int *fdp = NULL;
> -    VFIOUserFDs *reqfds;
> -    VFIOUserHdr hdr;
> +    VFIOUserMsg *msg = NULL;
>       bool isreply = false;
> -    int i, ret;
> -    size_t msgleft, numfds = 0;
> +    size_t msgleft = 0;
> +    size_t numfds = 0;
>       char *data = NULL;
> -    char *buf = NULL;
> +    VFIOUserHdr hdr;
> +    int i, ret;
>   
>       /*
>        * Complete any partial reads
> @@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       }
>   
>       /*
> -     * For replies, find the matching pending request.
> -     * For requests, reap incoming FDs.
> +     * Find the matching request if this is a reply, or initialize a new
> +     * server->client request.
>        */
>       if (isreply) {
>           QTAILQ_FOREACH(msg, &proxy->pending, next) {
> @@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           }
>           QTAILQ_REMOVE(&proxy->pending, msg, next);
>   
> -        /*
> -         * Process any received FDs
> -         */
> -        if (numfds != 0) {
> -            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
> -                error_setg(errp, "unexpected FDs");
> -                goto err;
> -            }
> -            msg->fds->recv_fds = numfds;
> -            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> -        }
> -    } else {
> -        if (numfds != 0) {
> -            reqfds = vfio_user_getfds(numfds);
> -            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
> -        } else {
> -            reqfds = NULL;
> -        }
> -    }
> -
> -    /*
> -     * Put the whole message into a single buffer.
> -     */
> -    if (isreply) {
>           if (hdr.size > msg->rsize) {
>               error_setg(errp, "reply larger than recv buffer");
>               goto err;
>           }
> -        *msg->hdr = hdr;
> -        data = (char *)msg->hdr + sizeof(hdr);
>       } else {
> +        void *buf;
> +
>           if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
>               error_setg(errp, "vfio_user_recv request larger than max");
>               goto err;
>           }
> +
>           buf = g_malloc0(hdr.size);
> -        memcpy(buf, &hdr, sizeof(hdr));
> -        data = buf + sizeof(hdr);
> -        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
> +        msg = vfio_user_getmsg(proxy, buf, NULL);
>           msg->type = VFIO_MSG_REQ;
>       }
>   
> +    *msg->hdr = hdr;
> +    data = (char *)msg->hdr + sizeof(hdr);
> +
> +    if (numfds != 0) {
> +        if (msg->type == VFIO_MSG_REQ) {
> +            msg->fds = vfio_user_getfds(numfds);
> +        } else {
> +            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
> +                error_setg(errp, "unexpected FDs");
> +                goto err;
> +            }
> +            msg->fds->recv_fds = numfds;
> +        }
> +
> +        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +    }
> +
>       /*
> -     * Read rest of message.
> +     * Read rest of message into the data buffer.
>        */
> +
>       msgleft = hdr.size - sizeof(hdr);
>       while (msgleft > 0) {
>           ret = qio_channel_read(proxy->ioc, data, msgleft, errp);


