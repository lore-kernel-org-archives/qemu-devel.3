Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68531D3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8RFO-0005OI-1f; Tue, 05 Nov 2024 16:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8RFM-0005OA-QS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:37:56 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8RFL-0001od-9v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:37:56 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e30d517c82fso5453835276.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730842673; x=1731447473; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HfVTQCmMouuqtILwXS/kTUubRKXoIRL+2su4vKaPwvY=;
 b=EkL+S+0FGUtcMjOsRx4qsFYpGkXKylsYDZ756AcJkB+R0sqzHraTnAAZ4111dYzdd9
 D9G3Uil64MV0ZRE2+Q1sC+3IKaIWBJkDnhxWYTYq0cgSdcfMj7jkIdU+XPhL/EaGTJX/
 80t+jslOQrfwKHC3sxe26i3z6g7zDepASb/P8EHvVdN4XByL5WLfPkdmH1YDbVhIROrD
 HUHGzxifn8k2Gl7Sted9OTpkXNA/T6y+upZyX8rpwoHuYrKbq4eNv79Nn+YV+WEB2gV+
 zXg/Lj+NB+RIO0c4d1Jjp3W2L5ztn5nMXu+62u7nOWKSXKufxeAaYzDinTM79YV7GPc6
 hyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730842673; x=1731447473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfVTQCmMouuqtILwXS/kTUubRKXoIRL+2su4vKaPwvY=;
 b=vqtJBE3YPAaLqz35eldSlWo+rWPPwuBiNQnBN9pHEQhHcushZNWcJKJzvNtztPbN6w
 rz8suE+QVH+ATm0O1qIOK0CtSwctjrW9WDbTCSrZs3vbolE1nJnfb2PjgVCKHrRgv3az
 clqeuMZp/QG6TARdB9icqKkSIglmOy4B3cN3WYwHobXLI03cnz3MGVYsdKcdW7UzCGZh
 6SZx7HMy9lviyd59tEc0gyQ440F56DDZiXuVFzjkYEEBvxPPZSFQjZHatrB3Ji/vpvVa
 CbQUTnTPolcXQfziDcDdWBFg1XsbI90ixgYLMGwGn4ZT6hiIWGJA7wgGGL9eFxCV8vdK
 AfHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVABNLCuO9sOPLlPXpQ9Lj80yWVfo1mpKjXRzS42tXfzWc59xrVZVXKzQFQtJAVww9jf8gk/ryD6orP@nongnu.org
X-Gm-Message-State: AOJu0YwGdUFak/R5wxIA5QgYSiQWIdLQfykgapsLQSwu2hsIRndI+M1H
 bylmrqalqzFdYvG5jjwA4d83oApix0KFq1qBXwnLHcF1fRSe1X/D
X-Google-Smtp-Source: AGHT+IFLaglPhrw++ZguAUgwYQrvQv/21EPC2m3ciNiq6mzQ3dpQQ67vSy2ldIPvo9wgWJlD7HWGwA==
X-Received: by 2002:a05:690c:608a:b0:6ea:86b6:f703 with SMTP id
 00721157ae682-6ea86b6fa7emr105413097b3.1.1730842673522; 
 Tue, 05 Nov 2024 13:37:53 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ea94102de3sm12224947b3.52.2024.11.05.13.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:37:53 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:37:50 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 10/10] hw/cxl: Ensure there is enough data to read
 the input header in cmd_get_physical_port_state()
Message-ID: <ZyqQLoCnYMDhBmTG@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-11-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-11-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb32.google.com
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

On Fri, Nov 01, 2024 at 01:39:17PM +0000, Jonathan Cameron wrote:
> If len_in is smaller than the header length then the accessing the
> number of ports will result in an out of bounds access.
> Add a check to avoid this.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f4a436e172..2d4d62c454 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -530,6 +530,9 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>      in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>      out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>      /* Check if what was requested can fit */
>      if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
>          return CXL_MBOX_INVALID_INPUT;
> -- 
> 2.43.0
> 

-- 
Fan Ni

