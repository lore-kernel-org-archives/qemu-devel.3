Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F58CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ECB-0003kB-UN; Fri, 10 Oct 2025 10:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v7EC8-0003jf-52
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v7EC0-000163-7D
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760106836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t35fA8ZeSRwsdlcn75vwVy+0iI8tXDVz4Dw1USA2CUw=;
 b=OcO+W4Hw6/+I13STVJitFdGMqeaj0bqzybxfY+hSwUXRDoUN5r6xu9TXnjZIKw32SqyaI+
 Tvn0KA/lANH4ZVXgA3uRyMyI4kwAdLC4rYTRZOIomG86IyzAsJE8dnh7ZIDlg5FdQ/i9N5
 Ygib/1acykkamWraatDL3r3D7Xq3Ys4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-UXlxmgQrMCqeRYM4Npc9-w-1; Fri, 10 Oct 2025 10:33:55 -0400
X-MC-Unique: UXlxmgQrMCqeRYM4Npc9-w-1
X-Mimecast-MFC-AGG-ID: UXlxmgQrMCqeRYM4Npc9-w_1760106834
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8715f5037beso691377685a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106834; x=1760711634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t35fA8ZeSRwsdlcn75vwVy+0iI8tXDVz4Dw1USA2CUw=;
 b=ts9gzpezcMTHhd1Alv41oFw5quTLOEsw9gqFRPo9Vz+62W8A0kVlaxYs9qaRMS9V5S
 GQWN+LnfkA4yyxHMB2z2QrRq445BsnfppM2ONmEZKshN56dMmZsf4dvPt9VM/goSbq7q
 Io/wgSg4WYFizvBkDwLArq68Oc3KdSlWbmgu3A3UhNQt1XFicMVzGGFVYmUp1kXQQxM7
 dO5PPGxglE3+p+wekDYrqFH9coZTdicgAqN5ojEGp28R8nQJZm2VpAtQo3MhPtDXZIne
 OEmaBprqoWjyZwZmCCTjPV7MkNa3lnDBQzLgIFLrLcHWPHt6D+gdyPhvezSLY/B2HZAn
 SjrQ==
X-Gm-Message-State: AOJu0YwJ2K/1xQBiJEvpbow07lhh/jlqDG6NyTHX9Mv5B6EoWY4rVQ8/
 TOS6R41RfiMT/WOhfghjlAC5z6L53YG6X2keAUYJPiw0G7AoQ10pQRhr7yYUmWb1xM5lThLq5R+
 Dh+KNtt8BDGQ0sUHwDLD/VZUJEYCXFdk9dBp6f5Gq82yp4AOa8TcOYk1r
X-Gm-Gg: ASbGncuHEVgvHTnXXdYmNsS0N5uUeem9NDMLfwssWspi9kZkpptCy/j8w2LYLxXj6vB
 ypoY5lgtrcdrrmm4rg3N1VQm314QMhgwqGIRR8OfFbTZFH4F6CqwnOEO3sMckGUnrcC4rqcO671
 VAFQfW4uAg5VaritLPnyPf128XAUCEtYv74A7jR9FUYTdcRu7qnN+HXYWNyMljffsXpHKdWI6ID
 UxudCm8dBU0qhGojkushoq1Of5TeafGNp3yqV+OujgkBW5fI/L8RuE8UuPPA2HjOJo+3nMoRqH1
 9QLTDQohi0QrWicaawJ2rRvrtS7Gkz26zw==
X-Received: by 2002:a05:620a:1a20:b0:870:4652:4d19 with SMTP id
 af79cd13be357-88353846516mr1650144185a.28.1760106834143; 
 Fri, 10 Oct 2025 07:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBH4APTklRMOqVYm3oYN+k4bGeyZmkAx4AjEjqd9PIfh6hlbVaN3Bq0E13yPqSAvo/7ubAZA==
X-Received: by 2002:a05:620a:1a20:b0:870:4652:4d19 with SMTP id
 af79cd13be357-88353846516mr1650137585a.28.1760106833480; 
 Fri, 10 Oct 2025 07:33:53 -0700 (PDT)
Received: from x1.local ([2605:8d80:662:923a:17a7:8919:431a:e4f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8849f9ae48fsm419457385a.24.2025.10.10.07.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:33:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:33:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] MAINTAINERS: update cpr reviewers
Message-ID: <aOkZTWCVq-iDhggq@x1.local>
References: <1760098600-399192-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1760098600-399192-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Oct 10, 2025 at 05:16:40AM -0700, Steve Sistare wrote:
> Update cpr reviewers.  Some of these files overlap with migration
> files, but some do not.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84cfd85..9a10bda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3107,7 +3107,8 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
>  T: git https://gitlab.com/vsementsov/qemu.git block
>  
>  CheckPoint and Restart (CPR)
> -R: Steve Sistare <steven.sistare@oracle.com>
> +R: Peter Xu <peterx@redhat.com>
> +R: Fabiano Rosas <farosas@suse.de>
>  S: Supported
>  F: hw/vfio/cpr*
>  F: include/hw/vfio/vfio-cpr.h
> -- 
> 1.8.3.1

Queued, thank you Steve.

-- 
Peter Xu


