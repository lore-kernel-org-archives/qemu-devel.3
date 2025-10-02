Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFFECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Kbx-0003bW-9x; Thu, 02 Oct 2025 10:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v4Kbt-0003aE-3A
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v4Kbh-0005sy-9H
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759416506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0HYnV+wr0hPHRUePeUgtyc6EKW3/QsFOU5FU9hyMkQ=;
 b=J6qY0UO7BSDbSb7Tp9zDFZF0DGXhlbkaitycU2/wlJTHT7+HwNEqOV2g9U4/cU1wrKlBzF
 k0yHid/jRHaz/a7b3knXnilpwiWO5H7ORhQ3yBlc8Zv8PJG9XAS8hub0M27IvQGQcBfayR
 e0jac9t0NkKsS6BtvR5P7d7XdNaZSXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-A3sbj9UnM2OFcemfU7AvnQ-1; Thu, 02 Oct 2025 10:48:22 -0400
X-MC-Unique: A3sbj9UnM2OFcemfU7AvnQ-1
X-Mimecast-MFC-AGG-ID: A3sbj9UnM2OFcemfU7AvnQ_1759416501
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e2d845ebeso6784555e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759416501; x=1760021301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0HYnV+wr0hPHRUePeUgtyc6EKW3/QsFOU5FU9hyMkQ=;
 b=iqz3CnJEbVH1dBgXjNEsHcfKUJiOt7+lMMWuv8UBz0EPfWH2O5uilj1nqNbaWNNYbA
 uWpo5Oe09tlD7f/zcbZKGOIlybJP70ErTEA94h54mesXfC2X9hLYuPZRK87voQ27d9FH
 NbZ3pg81aEW9i4O+3TXwfh49VE7o8Xy7Y+juaNlglW0jWiUGFMNjMPMKlDKMxpwjhGDU
 cZLPdwvf5kDVbdJiJKjg5FN32WPciECzfWyPLIkzgwue3JjMZNKHfeKxyTzAYN6DTiuH
 fpNYxHaoo0pwf/lZO6wTVXj0SmD8gonxWhgf5RN7z78tHu2JjkA1VtZpQaUb52JKAgc2
 3/vQ==
X-Gm-Message-State: AOJu0Yx/nxUPmAaZJkzjxk9lVthEN90X0fuekLr170U1adQch53S8ICn
 cwWLqQHhC4mPM/uqoZ6aAZ6zSEF7UPRmP+KMaCFmR2tXFakHgV7u4mWPduNNdPilk6PseqnxWL0
 YLk0VvkB5M/BPtf/FSDShOOs30g+SWjqatOk5GjGOgz21HjhTEalRBuHq
X-Gm-Gg: ASbGncvCx715koMqSq7yrPyDCL4dPNXT3BkFPy9fDvKEYRIuUqURmIXrS1QLTFoNzpj
 M6viFULdcSIJdNa5QLkFRlprpaz7OEqO4qO5dcZ67sONChap9Sb9ZwNkuWPGa2V6sGMqcwC7bRx
 RBBDgwc4NYKQsUvXLa2DQxBh52ttgI3XDjpuV8JVMkKD2yJnZ+/GRiHvXS72iE0N2uOOHc6QxUx
 1mOaOOVl5lxGGCSDyTqT0FFWAMTEkAjUl8vcSp+ldyI9Riy5i8QINFnKC7gIvY3WFIshkXiGu8b
 +DVz6A2PSEzm9hxRU2JUge+AQWmWTaqpIXc=
X-Received: by 2002:a05:600c:3109:b0:45d:f7cb:70f4 with SMTP id
 5b1f17b1804b1-46e6128628emr52434955e9.13.1759416501307; 
 Thu, 02 Oct 2025 07:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFekOZTGhn7K4o+aUCLJ8ppUKMHaHG5o2N2bbCELUaAC763vyAIXydH8QPMgd4AY984vkYyLQ==
X-Received: by 2002:a05:600c:3109:b0:45d:f7cb:70f4 with SMTP id
 5b1f17b1804b1-46e6128628emr52434775e9.13.1759416500940; 
 Thu, 02 Oct 2025 07:48:20 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a25dbcsm91488235e9.19.2025.10.02.07.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 07:48:20 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:48:18 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 ppandit@redhat.com, berrange@redhat.com
Subject: Re: [PATCH 2/3] migration/ram: fix docs of ram_handle_zero
Message-ID: <siksubjav4zoz4f46b5om5mkw4pz53oxwrdvsshslmngnqtauu@svxc7xqstdyk>
References: <20251001161823.2032399-1-Marco.Cavenati@eurecom.fr>
 <20251001161823.2032399-3-Marco.Cavenati@eurecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001161823.2032399-3-Marco.Cavenati@eurecom.fr>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2025-10-01 18:18, Marco Cavenati wrote:
> Remove outdated 'ch' parameter from the function documentation.
> 
> Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> ---
>  migration/ram.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7208bc114f..e238c9233f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3552,7 +3552,6 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
>   * determined to be zero, then zap it.
>   *
>   * @host: host address for the zero page
> - * @ch: what the page is filled from.  We only support zero
>   * @size: size of the zero page
>   */
>  void ram_handle_zero(void *host, uint64_t size)
> -- 
> 2.48.1
> 
> 


