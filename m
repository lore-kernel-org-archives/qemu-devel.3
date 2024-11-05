Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F8AD3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Qyx-0000vp-HH; Tue, 05 Nov 2024 16:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qyw-0000vJ-08
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:20:58 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8Qyu-0008NW-Ay
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:20:57 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6e38ebcc0abso68045297b3.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730841655; x=1731446455; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPiMAN9QIzBPfA7lPqV6M+Nsp42HSnsGy+bCRhwQ8kw=;
 b=Y5su15eKLnZQHD59di8Mv5OWHmSIJ72fwtyRTV++va7c1c5AMOkAFzQnm+zABiwu7r
 1mmU8qj/Wp7M3dSxHk0SqSouUKMDk16d5HICAZMi37KLqDpKLu3EUEECXrRulGHlAw1O
 FQa08c5fA1VZsnhuKCqtMPEKSwIsN1wLX+1sy8L5IdckLcRrhJgMXE4lOkcNQV13ue0k
 ot0aTdU0sResoAPjU99L79mK9nG8UXPcWC16ToEkrp9gABxBMBW3TVuGh4PuPSnkqnSE
 GmNGgTztSPUCLFB5afjfMLxe+dbqKgLv+dh8SmdBubJiVoAZkkN+MOGnqVPQj9TrYSpH
 1Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730841655; x=1731446455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPiMAN9QIzBPfA7lPqV6M+Nsp42HSnsGy+bCRhwQ8kw=;
 b=DWTQ52k35Jnwy/jGWvz3D7Jt0el1jFbUwDNYYiB1gKBe13P1Xbc7Bwj/e/q5x12I/i
 ItuuZUKov9sb9qvdbSDMH48k0XrHk6H7jj8pGnmLrwLQk7ifQ1OcOqSpQeNFUJk9Zan8
 FLjcQmfnFFotVG5bUPUw0PPhV0HPoyspwBTqbeVpiuWLLNXgzRSExkroWJ+VyyUZ97TO
 vZln4SibDIxvoNhnf3/q3Ov80vP40x7J/ElDYZ8JOYGCcMMZ3W6iw+1FwbV5SMEJ3L2C
 hC3l5aYrgTJGRannh4QxRD0VIy+NGR8D2kgYtX8uLqeCqnq+CUcos/qTlgXA+ZYo4wA5
 IJCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBSL8TnG9YFI9ql3ec2U+jHrpfSS/1xRox9Q9pjI4+3PamF81KbkKTJYf6XeezJOTIZkPmuw0S10cz@nongnu.org
X-Gm-Message-State: AOJu0YwgnYtT4EAjyK8hoe+HeXn1rHgVOU3obVBEKSqKUUkwTpKxKQJD
 xquBROywWw8v4j9ys2P0MJQOeYVNjX3JKsZgORdY1z8W/shq8NXmTRqYUw==
X-Google-Smtp-Source: AGHT+IF6DQRuWsdCA1IjjAnvofSDQXE9T2x0H2s/5eic/WyeD6boHgJTjO69gjSlDgkmSIulgstCYQ==
X-Received: by 2002:a05:690c:87:b0:6ea:3313:f98c with SMTP id
 00721157ae682-6ea3313fa4emr280329027b3.32.1730841655012; 
 Tue, 05 Nov 2024 13:20:55 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea55ac99a1sm24729247b3.2.2024.11.05.13.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:20:54 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:20:52 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/10] hw/cxl: Ensuring enough data to read
 parameters in cmd_tunnel_management_cmd()
Message-ID: <ZyqMNCvnXkiwqubp@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-8-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-8-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Nov 01, 2024 at 01:39:14PM +0000, Jonathan Cameron wrote:
> If len_in is less than the minimum spec allowed value, then return
> CXL_MBOX_INVALID_PAYLOAD_LENGTH
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5e571955b6..a40d81219c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -151,6 +151,9 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
>      in = (void *)payload_in;
>      out = (void *)payload_out;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>      /* Enough room for minimum sized message - no payload */
>      if (in->size < sizeof(in->ccimessage)) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> -- 
> 2.43.0
> 

-- 
Fan Ni

