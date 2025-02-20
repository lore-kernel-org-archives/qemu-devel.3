Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B3C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8vm-0002fn-P4; Thu, 20 Feb 2025 10:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8vl-0002fW-1o
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8vj-0005Br-KZ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740067058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kutWJ/pRiS4O+ybMZ8u9U62kCBYvj0o1JRJeL57JCt8=;
 b=hPDfOwbEVtW4tBLrTWw6ngFEpr1V/UQhABe7zsrBmVJ1FcZa0fAw5mxdospvegyYUAN0Zh
 wCkyYkV4DnfpjwSo0+o02pLJq06lt4qgTJHJTOMsmGhSc7PqvkMJMtiXj/pMKdxvuLhNOa
 SWUcN8zTCRym0PQvOWh+ZChkV0jWYOY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-WpfLFPzANk-w4zNnKHSIyg-1; Thu, 20 Feb 2025 10:57:37 -0500
X-MC-Unique: WpfLFPzANk-w4zNnKHSIyg-1
X-Mimecast-MFC-AGG-ID: WpfLFPzANk-w4zNnKHSIyg_1740067056
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abbc0572fc9so176335466b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740067056; x=1740671856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kutWJ/pRiS4O+ybMZ8u9U62kCBYvj0o1JRJeL57JCt8=;
 b=VxOAw2WWoSTkuZpCdCtYghg9OkmTFjAZ2RbkCXNc+zigJ3dyGfyCmlokmZx+0YF68s
 O/xKA8u1l7qP6G+NP6Bhr4PH5LBTbjKwqHocrkMTz5JX9k6FPUr9IEXN0yVOzz4LB6Be
 koSca0T4n4xvy+0CxXyHhxMAPMO/MgCfDWPTpa1hLAHvFsbLd5ylp0nJ7MFAKS3JgNrK
 raCVq/ubkrXb0+BDreR/LUfLSJRveRklIHgYN0z5SDG26cO2dCbbQWzTpzoX90SNCvoJ
 2UVJRnUN6P2hQosMmosHz25+okQiH9dfGOqzmMod9VLDRuGov8q6mP62rCVoWfGEijCN
 Vlfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBRloWJVBOMQKbQuvzimb9PzWOFwWG+4yP92KXfzHSVJj3XAPQ6AHWvIEXHA9+UyUTr40e7VPZrfd9@nongnu.org
X-Gm-Message-State: AOJu0YyvtLOm1PZhZzEPyjh/R028YCGCLvLE86LW6Ojfg9xkPCPrO/pC
 KFGZpWkK8pJHf3Wy8As5xjcp5fs5658a3zMk61bUQPSmAZCkyytNzKWuJTkm6aZJ5GLWPrkagi6
 7OPqtV412CAPJ+q0ekxwckt1kRCOr0qV/gSb72GYb3Pas4m/qIErk
X-Gm-Gg: ASbGncuJiWjkPaTKKfbHUH90Nhi5xYZWVOD236katXbCmdtmP6qmmeOnbm05zGB4Uhc
 QPwlRFwrWCv7yGI6N+56v/HYrzI5OlZkl0Q0rbYW1Vl+i+SE5S02//WUtJRc5GTMtt3cn2clppu
 fjS42uQtNNlgD2G99rv7XoODoLlN8gn2/Pp53qZIM2LsI7AP0d0PDuS6so/2HXLlnnt7KavtRTx
 KxhKM7WPdxJLYsghEYS7vWa2omMeml7iODAl9LoywQo1dVsxB4I6r1Ut1sQ5T0EZFhFQg==
X-Received: by 2002:a17:907:c5cf:b0:ab7:aaf2:f7f9 with SMTP id
 a640c23a62f3a-abbf3cb8afamr329641466b.42.1740067056133; 
 Thu, 20 Feb 2025 07:57:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+RpLOo11wWsfLQtiHv+3IU1e5Q8QlEJZJ2bW8dqfGCbq74JQvxYJFBO1ur47VKcyofxIG+Q==
X-Received: by 2002:a17:907:c5cf:b0:ab7:aaf2:f7f9 with SMTP id
 a640c23a62f3a-abbf3cb8afamr329638266b.42.1740067055672; 
 Thu, 20 Feb 2025 07:57:35 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba5337634bsm1497520966b.91.2025.02.20.07.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:57:35 -0800 (PST)
Date: Thu, 20 Feb 2025 10:57:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: eperezma@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
Message-ID: <20250220105323-mutt-send-email-mst@kernel.org>
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211161923.1477960-1-kshk@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 11, 2025 at 10:19:23AM -0600, Konstantin Shkolnyy wrote:
> Add .set_vnet_le() function that always returns success, assuming that
> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
> outputs the message:
> "backend does not support LE vnet headers; falling back on userspace virtio"
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>

Thanks for the patch! Yet something to improve:


> ---
>  net/vhost-vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 231b45246c..7219aa2eee 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>  
>  }
>  
> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
> +{
> +    return 0;

How about checking is_le is true then?
And add a code comment with an explanation, please.


> +}
> +
>  static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
>                                         Error **errp)
>  {
> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>          .cleanup = vhost_vdpa_cleanup,
>          .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>          .has_ufo = vhost_vdpa_has_ufo,
> +        .set_vnet_le = vhost_vdpa_set_vnet_le,
>          .check_peer_type = vhost_vdpa_check_peer_type,
>          .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
>  };
> -- 
> 2.34.1


