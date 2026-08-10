Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A527DC5B56D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtRd5-0003om-Fo; Mon, 10 Aug 2026 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRd2-0003nz-Cl
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtRd0-0001II-O2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786374565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYkMROPk5tnt9TKZ2yMptsHcqYxKzdJ/3bYucS5nefU=;
 b=S/HbKs5LLoH8BqipkgTLxeJp1KTSil+KGV5pbgRJ3o/wPrd/VcpxFjbVVOPToJEUTRTVna
 8MvjJI6EZGVrnRERvC4x0MkyNd39w9kCDEVlwh1psTTYEYTF8rbFEPd02uB8/25w0sJ2mU
 tk/RYkAUaZe1Mt0/gJEZqyOG/rcOb8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-oNxg4Wj4Ps-U6rykJRxu_g-1; Mon, 10 Aug 2026 11:08:15 -0400
X-MC-Unique: oNxg4Wj4Ps-U6rykJRxu_g-1
X-Mimecast-MFC-AGG-ID: oNxg4Wj4Ps-U6rykJRxu_g_1786374494
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so21618865e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786374494; x=1786979294; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HYkMROPk5tnt9TKZ2yMptsHcqYxKzdJ/3bYucS5nefU=;
 b=EKhJaPEM0X4Xf+F4xX6K8v01n54ALfNkNrQkdLoHIKzOCOIr/bvBDOBdKMCYqxDLen
 Lq+Env6zK3pdjn8FkpNsOBg0OPxkKjn2oqYoDvg/As35zqJ4/HcyZn0h3wFCiNEPHlA+
 IJzuih6BRqK+fFDxhaAtkreO2SURsNTUamzOZdzWRjvCi8/ZlV+Uk17XiPFWhbJRqaOS
 k+LevsVhhzi7IIU//CZ9VjRiCN+rp+U0zuYg5AYlfnH08MPCXMg7YJEhcQAUS9uvR/Lt
 h62H7xsLSHomYCglN+9rrpHvF6h2gmROSSUGK1qO775Ar5yreZ/FMHsPM7hxlnZgux5r
 J/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374494; x=1786979294;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HYkMROPk5tnt9TKZ2yMptsHcqYxKzdJ/3bYucS5nefU=;
 b=D/six/xnedzhcPxNv2zbgJsOEAk21nQktWSUbmtOA3wmBO2DdcJLOABJIjCRr8KDnr
 EkZfo/kYGcjAixm+19GFWSyciVYkNI/Lpe+0BM9Z+RZ9CeekyoXUbMaFTBj4oUm2c/sX
 wciPauMII0SbrIB4RAGXA072pG3dfTJhGLaGJeHl+KMY+JZgs9bIOEh425ajhpB+06Uz
 yoD0jJ/SyTChGUpsLPVuHxfvAf2jWcyCZLi+VCLQ+HbgW7jMczoq3lPP3V4Rvgw+FldN
 sA6jDvxwgsQicDmqRQ3GDIo1X4werVpsF7ZYZmYKN4asXn5SETxtJHTh6sWiOaYlxa0Q
 NvQw==
X-Gm-Message-State: AOJu0YykQYdgDfIYrnvkOknFgGs3wea2XWTEBkfTE3Jwc6WUt3n3bFcc
 3y1mVVS/8xs1tSqbzJDaVLdE/EcykbsToR+f/f2LtqaSbjXTQhF/hwFmxr0MDwqCPVZCV48TDQH
 T1sV+gYE7qCjK/mvUFQtLIuVhB7M2rB+4XBAcXRDiBnXy/6Rb9ytX3d00
X-Gm-Gg: AR+sD12XvxFPE6AxH5gyL80nYUlVqj7Rki1XGdvLWUNYORzr5bpqV/HT4clLMnKjE5/
 agHhFfb0XoN2NdFVO4F5WMX/k7zIkYze1Ju2Efi2DX47tbRo9139ZS1hfcEJ1INZKQBOW36QVbd
 r3+VVIVn8ZpgZUV6PIFOWHD8jzTWtRV2zuJLWUIyE3Mh2TNBF9TTHN3VXvfDFUsRAd/wKHoECXL
 aCfIa+m082lN03MKwCAbH4JGub2iaUVCSgupfM3GDcdUSIdDCHc1Y+Lb3+mmIN5wAxfTCQj9Yrg
 cyU98vXKqpwk3vYlr8KCDJZcpWu1laOiVF9YjW8bzSpPX78ULHC6Vppd
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id
 5b1f17b1804b1-499727fd550mr41613625e9.19.1786374494194; 
 Mon, 10 Aug 2026 08:08:14 -0700 (PDT)
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id
 5b1f17b1804b1-499727fd550mr41612865e9.19.1786374493768; 
 Mon, 10 Aug 2026 08:08:13 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995427a4dcsm483994085e9.11.2026.08.10.08.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:08:12 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:08:10 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 01/11] migration: Propagate error in postcopy setup
 functions
Message-ID: <annpOewt7RS5GjBA@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-2-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-2-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Modernize error handling in postcopy_ram_incoming_setup() and
> postcopy_temp_pages_setup() by replacing error_reports and local error
> handling with standard Error propagation.
> 
> Replace use of strerror() on errno with error_setg_errno() for modular
> handling of errors and change return values to -1 on failure as no
> caller checks the actual return value.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/postcopy-ram.c | 41 +++++++++++++++++-----------------------
>  migration/postcopy-ram.h |  2 +-
>  2 files changed, 18 insertions(+), 25 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


