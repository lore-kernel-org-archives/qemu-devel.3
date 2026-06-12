Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D034CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXxks-0007om-Dt; Fri, 12 Jun 2026 05:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXxkq-0007mH-QD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXxkp-0005el-0H
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 05:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781254841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5NhEHxZ6hI0beLeWp6qgypW+fgnxBRyBUQAZPd30UWk=;
 b=YDcQ2hgNTiUBRoM+xW8ZtDbXPmTg4fgLnC3AQ4I4Bw+CwBj9skEEMkP6KHiX5KaVIj2qe+
 GNXA6855L/Pg4mY88gDPpyNvPsbxW5IgiSI1rkWHgHTLRSxBtOfYZuvjfLyfG3pY/5X+lz
 oAW3/a0istQryTI7tFG+J5F8H30iNik=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-u1o-JyP_MxK38jVKp0ZYIA-1; Fri, 12 Jun 2026 05:00:39 -0400
X-MC-Unique: u1o-JyP_MxK38jVKp0ZYIA-1
X-Mimecast-MFC-AGG-ID: u1o-JyP_MxK38jVKp0ZYIA_1781254838
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bec440e6b9fso59896466b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781254838; x=1781859638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5NhEHxZ6hI0beLeWp6qgypW+fgnxBRyBUQAZPd30UWk=;
 b=Af6KsqcgUtD/EjmLwU+BDi+P4+owW70SqSlJdvHlmtpAckCZeqs1cUJX0JIlx1dWTy
 woD9GWOLNRsAl+gwaEUNv4fPDqUQ7a7Gp9cFhDyuQHgNdujxoZ3A5wuGu6pws3j2DxAU
 Y6oA/F0vVAKUdF+cz1J/uAciyZYPmEovE2W/+2DMwa6RA5oqTHngruw1KFAZU+zXzQ0g
 cMQ5XhYZX7PCSPlwRp3jpjvU8oQNsUsvcIXPH3Mui/PaTU2mgkWlV6d56X4l+r86NwQm
 vedgsAnyKicFuq75f8W10wcUCIXAcyY49NKL5GSjiJ0bfCCmWjFdtF5leTfnbrzoQv+l
 TphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781254838; x=1781859638;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NhEHxZ6hI0beLeWp6qgypW+fgnxBRyBUQAZPd30UWk=;
 b=d8cD+bi1Vt37d18GqoUGYz4aMa3Lm7SAUPa3D9n93jgQdedZ3OyC6tHNDb283CVwZa
 pM396wVEE+fpps4ccTJIEQVjRS1U2AySzl3f/RMfuxT+bixiNqYzIGZGj6oc7J9TEmTe
 0SRVGdZDmHEHYTELUGntP69+QgIFgYHh5bT4nw4+WtjIxGW2jWodeeHtt0fzCrQjvLgB
 sDHYnVdyM1OjLikh/NKT3JDUrVVcl8bbqwLOALXmO4tKW3NiU9QNXwIT51XbBrHEmekI
 09/HjxE++uDMWXLdzKSNrbLBERPAEAPqON1gqFjubBd16A7a8WRgyMEv7ck7vbr5d03F
 zY2w==
X-Gm-Message-State: AOJu0YwtfELjshPMJcren6pYHnDEBIv5m3XJWvuTk2OR5VjOVTROcCVM
 U4c9D3h5FrzPSuhdiaFLJtrGxSNVUMKCDzN0Mzi3LdvVUvtWI02rZl51Or6vzAzsAeaOST18J5o
 yck2lElQzf/bDxmQwEDkjtcNaVO8G6GJ7EhfIhn713qsn0BUpOh0BFCfi
X-Gm-Gg: Acq92OGHaELW9Psluxxetf7MYXgsj78jxjACqt21usbK01qfZZllw3N0o8bhq/vlS4N
 /+RrqPvmz7FQEM1k5KDhrBD2OY1XgxEvBKWBnwHTqST97K84bbXDPsbO1s9K9VmFtajsWt3lh6O
 gn1p2Ddn12vLYheppapX51Wnw45zvXGV2l6VFkN5At50bmUEVNS7blC5XstbVSh4EMx/rBLiNNg
 7X4JoRG/kvBQgZ3jajVQPt8MyvCKyz38GBIdqkrxY3BmVT3Ae3mTFzK1E7lsoZi9nWsERuFkAYr
 MYOAMSqHvh3ItPRm1u9FS1w4sKg6QxOx5w3nzaulxFVzv0PS/87vjzPVp9mZD8U+oBtwpNON53u
 gtr6ODIk7pDp07GFKLIvL/dhhzr0QdpaH3qf5/B/KOJWnRJoca9EY3G/gPweL
X-Received: by 2002:a17:907:3fa7:b0:bd3:cb24:ae61 with SMTP id
 a640c23a62f3a-bfe27830142mr86269666b.6.1781254837736; 
 Fri, 12 Jun 2026 02:00:37 -0700 (PDT)
X-Received: by 2002:a17:907:3fa7:b0:bd3:cb24:ae61 with SMTP id
 a640c23a62f3a-bfe27830142mr86266566b.6.1781254836972; 
 Fri, 12 Jun 2026 02:00:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb83420e9sm78333266b.45.2026.06.12.02.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 02:00:36 -0700 (PDT)
Message-ID: <fbcf6e7f-c25e-4e37-a171-46a484a162d8@redhat.com>
Date: Fri, 12 Jun 2026 11:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-user: validate VERSION replies
To: zhaoguohan@kylinos.cn, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Cc: qemu-devel@nongnu.org
References: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260603062138.4008583-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John, Thanos,

Does this change look good to you ?

Thanks,

C.


On 6/3/26 08:21, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> The vfio-user protocol makes the VERSION payload optional, so a
> reply may legally stop after the major and minor fields.
> 
> vfio_user_validate_version() currently assumes a capabilities string is
> always present and NUL-terminated. When the server replies without
> version data, QEMU ends up reusing the request-side capabilities buffer
> and the terminating-NUL check underflows. Replies shorter than the fixed
> VERSION header are also accessed before they are validated.
> 
> Reject replies shorter than the fixed VERSION header and only parse
> capabilities when the reply actually carries version data.
> 
> Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio-user/proxy.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 0f7d8425d614..197aee07bf7a 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -1292,7 +1292,7 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
>   {
>       g_autofree VFIOUserVersion *msgp = NULL;
>       GString *caps;
> -    char *reply;
> +    const char *reply = "";
>       int size, caplen;
>   
>       caps = caps_json();
> @@ -1322,17 +1322,24 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
>           return false;
>       }
>   
> -    reply = msgp->capabilities;
> -    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
> -        error_setg(errp, "corrupt version reply");
> +    if (msgp->hdr.size < sizeof(*msgp)) {
> +        error_setg(errp, "short version reply");
>           return false;
>       }
>   
> -    if (!caps_check(proxy, msgp->minor, reply, errp)) {
> -        return false;
> +    if (msgp->hdr.size > sizeof(*msgp)) {
> +        reply = msgp->capabilities;
> +        if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
> +            error_setg(errp, "corrupt version reply");
> +            return false;
> +        }
> +
> +        if (!caps_check(proxy, msgp->minor, reply, errp)) {
> +            return false;
> +        }
>       }
>   
> -    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
> +    trace_vfio_user_version(msgp->major, msgp->minor, reply);
>       return true;
>   }
>   


