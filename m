Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7CEC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgNE-0004w8-72; Thu, 29 May 2025 12:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgN6-0004ve-3S
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgN3-0006no-8O
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZ4cTznDjsVg91MvDFoO2ra7bAVqEU/sahkSEdUGcms=;
 b=dlH+ajEXXKBMzZizzJAhI5Kd5Iw3xNP2JJR8piF6WxJxQayA0LVuUsCeAAJzXcZfBvA6nb
 lONLtkoCn6oemsB2VWpimLXbnDu1j1msIJgJ23+AgjF7sLC2PWnVaVNiLaW+T+rYwx3e51
 aOpCypszdhVkrJgGFy4XKd8xSjnl5HU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-iQwzJDnyOseFQXY-g7a0PQ-1; Thu, 29 May 2025 12:44:39 -0400
X-MC-Unique: iQwzJDnyOseFQXY-g7a0PQ-1
X-Mimecast-MFC-AGG-ID: iQwzJDnyOseFQXY-g7a0PQ_1748537078
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4d95f197dso766093f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537078; x=1749141878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZ4cTznDjsVg91MvDFoO2ra7bAVqEU/sahkSEdUGcms=;
 b=nKa8tgBE2X4FsJPgCjkR08fw0pAIyxTDYDY7FEY0g3fBpn2rL0TWC+vUqM5tHmQp8C
 8+GgZa+PxXfzP0WGIVYCNU2GPYrt1SkdkFEApSpeB2BNl4ub9osdQFQdKvWA2wc3uN3e
 +d/62KRpE8sWRw0C5aal09l1HRHC9AtrnsnWuJNXJXsfhZFPfNp3oKO4X4U0uQACIOMD
 XULOr4etVfy7T4HGbK5ViqTDHq8FSEWxpjKBtc1gUnFfh0vLNIStRPmAw7EyTvGliIQC
 D1hSKF+zKsHdlcqGPXC0sauhCuSpUqlpZGwyjsucr9OG3+IGhopiSv/ot5JVKpbeaMjD
 HDcQ==
X-Gm-Message-State: AOJu0YwnZTh2sCbveWp1qGksLM7owtf/QEh/0YPLs8OUizXjbxWqlh26
 ELqOZzTWfL7q+P+H8rWUEo+IEVnF9lWJHjj+yq3h3+r9muF6hyAWkuvjV2DIKvhJOLAfyqbVDEt
 /vyfNP+EiQz9DXYPX4/KuLFDQetKRyaBIeFkM3nmFtiEDrHdRM0FkGpyo
X-Gm-Gg: ASbGncvmMVI//gGCgx7JTlZc4CMw9Fb6KFkqYCM0Ry0bA86/oGBIDp0sxsHlVEAtgPO
 2AEw/BrF/UXCmZZAhmnAlDIa3lQepMdkufKlWqAVaZGRqvFoK0hSrPRLj7utvWAs1oZvGO1iahq
 19vgfT21Fri/2492XJD2pN4ui4U7/XSWpElPi0dqXkRv7nBqzLhMOQRjqETfJ5vQ1m2GyC0S9jF
 RkDWUQdNAAlyeg6W4xCpIXuNmOuZgrqPJa5zIDdbrqFliYZJPaHIwS5rLIAgPBWTfUB614vVLHR
X-Received: by 2002:a05:6000:40e1:b0:3a4:d0ed:2579 with SMTP id
 ffacd0b85a97d-3a4d0ed281bmr14895561f8f.22.1748537078041; 
 Thu, 29 May 2025 09:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMF2/n/gjqkmKc6Oft5uaOZJeMt70T3p5O+Ph+PfwTbSLBaPlvTEOpbfCmE9X2taj+mc4xrQ==
X-Received: by 2002:a05:6000:40e1:b0:3a4:d0ed:2579 with SMTP id
 ffacd0b85a97d-3a4d0ed281bmr14895546f8f.22.1748537077644; 
 Thu, 29 May 2025 09:44:37 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d637790dsm3475025e9.6.2025.05.29.09.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:44:36 -0700 (PDT)
Date: Thu, 29 May 2025 18:44:34 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH 01/11] migration/hmp: Reorg "info migrate" once more
Message-ID: <caqiz4pl3cn42quijpj4xoh5gcuyttpzlcvdp2w75hx73rszck@ryktyvffk5fw>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-2-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

On 2025-05-27 17:58, Peter Xu wrote:
> Dave suggested the HMP output for "info migrate" can not only leverage the
> lines but also better grouping:
> 
>   https://lore.kernel.org/r/aC4_-nMc7FwsMf9p@gallifrey
> 
> I followed Dave's suggestion, and some more modifications on top:
> 
>   - Added all elements into the picture
> 
>   - Use size_to_str() and drop most of the units: benefit is more friendly
>   to most human eyes, bad side effect is lose of details, but that should
>   be corner case per my uses, and one can still leverage the QMP interface
>   when necessary.
> 
>   - Sub-grouping for "Transfers" ("Channels" and "Page Types").
> 
>   - Better indentations
> 
> Sample output:
> 
> (qemu) info migrate
> Status:                 postcopy-active
> Time (ms):              total=47317, setup=5, down=8
> RAM info:
>   Throughput (Mbps):    1342.83
>   Sizes:                pagesize=4 KiB, total=4.02 GiB
>   Transfers:            transferred=1.41 GiB, remain=2.46 GiB
>     Channels:           precopy=15.2 MiB, multifd=0 B, postcopy=1.39 GiB
>     Page Types:         normal=367713, zero=41195
>   Page Rates (pps):     transfer=40900, dirty=4
>   Others:               dirty_syncs=2, postcopy_req=57503
> 
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 59 ++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 28 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


