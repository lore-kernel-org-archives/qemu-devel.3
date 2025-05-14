Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F526C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCA0-00027r-FJ; Wed, 14 May 2025 09:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFC9x-00020C-M6
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFC9t-0006Z7-Qh
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747229307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UkwCGrpv1fJh9aXHCZHnwnpuBGR+Kmlc7KfeOOsY75g=;
 b=e0xeUcB3NhQYfsGDfMlTwNtPb1TDwmuey/EuyJJ3kR37LfzNktNjwKAgxbns+sEGsgF2ti
 NxC9Hcct+P3tghiBP5mVWoBzOsdvSSTc55yJs5dxgL75HiZlVmIawkYniq+KcUnh5ZhbXa
 6d0tcEBwNlCX6K+GYR0G29iv8wlc8ww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-tDZH1AlJPhGgXqaS6tTOKA-1; Wed, 14 May 2025 09:28:23 -0400
X-MC-Unique: tDZH1AlJPhGgXqaS6tTOKA-1
X-Mimecast-MFC-AGG-ID: tDZH1AlJPhGgXqaS6tTOKA_1747229302
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so31541405e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747229302; x=1747834102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkwCGrpv1fJh9aXHCZHnwnpuBGR+Kmlc7KfeOOsY75g=;
 b=rJeJ+mQ49bj3rnCkmZVjs/un23zoeWRglLbZpw+c4R1DFsUUZtYpr5cVtrkbeNKX1X
 +mKyOBN/JAbiGcOvpQHmfEu/nY8UjGzIdtYiLDhZLL3H0PEnwNrnfkB8KK8j5dozdYDx
 WngSA+e4bVz4a7a750cnVGxb1KSb83oGohD1qzI5F6XQMQUrFtoyFsLpg4ceK6z8mpxg
 223HFFwZ26Yq6tKl8Yaa2KKXHQtOvLXXVU1KCpSz5t7e+Tta46fTHOta0KL3BmW/73TU
 9Jv2TB74XE2gwVYELMLuPPDfhhobe/c++qDvmt87UHbPlvj7K8lLQx3W4S7RnrA7sChY
 LeFg==
X-Gm-Message-State: AOJu0Yy70rVcVFpMZKtPrVocRkQmzr0KRgVBy9+nDvYv9jnOSxb3q+BO
 yNhysgI5tTfslfKKxF1bwvu2WBazoD2/AhYL/HIHLB+qkHF6tc5Q7OpY/Voiju3UQKTF2l5lT5k
 gqj7/dGXEfgdzCVguMgjTUQdAni9+fwF1F6SXczMwjKOYv/yQvk5L
X-Gm-Gg: ASbGncvJ17LX47KH5M+lKRC89158FoNS/e18/rnXcnsNmF+XmdJPaenzFCf2EEf7pqU
 k28LRgdzlwvdJnU5FGpI3K5va12p7ILUljuZnGdQe2NNtVdTTk0nLrAsmV7AjHjYpGCh2WbRG+l
 7htMliXHCy2CQOeoOjg1WO+/4GEwYcfHNf0UcxlXOEOSd6XbO32raoY3kNf3GXUARSqN6VTJdA/
 00W6NcvgL5VweTFqJAuvUYZ8Xue2/LDgxw6oocPKnMu6QTK9lGgWLIJYEnXs6LDtjVFIZ9r17jC
X-Received: by 2002:a05:600c:1d9a:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-442f1dd5eccmr34059635e9.0.1747229301828; 
 Wed, 14 May 2025 06:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIO3mLT+GKggApVvLJFDsbnSaNwnbxs+TdH2GMHLpYxlQwHujZdhZZU5g2YjvPXR4drHUY4A==
X-Received: by 2002:a05:600c:1d9a:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-442f1dd5eccmr34059295e9.0.1747229301482; 
 Wed, 14 May 2025 06:28:21 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3380539sm31984285e9.16.2025.05.14.06.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 06:28:21 -0700 (PDT)
Date: Wed, 14 May 2025 15:28:19 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 2/3] migration/hmp: Dump global in "info
 migrate_parameters" instead
Message-ID: <yvgdscg3oczfqhiv5hyemzb5r2pjawz4gyra7ugpxobu5d3vyy@ja7hbmcmrx7p>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513220923.518025-3-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 2025-05-13 18:09, Peter Xu wrote:
> "info migrate" is the command people would frequently use to query
> migration status.  We may not want it to dump global configurations because
> dumping the same things over and over won't help.
> 
> The globals are just more suitable for a parameter dump instead.  Hence
> move it over.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


