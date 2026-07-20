Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D81DC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlq9v-0006M9-Mv; Mon, 20 Jul 2026 11:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlq9u-0006Lo-7f
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlq9s-0003Yq-T8
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784562235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yf065jabcYafMmVIJkRCgULyD+XarIXuqgsfgkkgdag=;
 b=MUaUgXymG046w+9lVMKqUgWiqI/jn0nZzkm+xmWMDfTYAOWjrLrnr0Qm/q6gxwp9WE6Q07
 ZMVjRNhMl4Rs6ZPR0YEf1jo96VEsXln3uXdU1tzc5huu3H9gZPGWtgJsD5hgGwJ3tiMP9O
 KNZ83LD36CVYmTqnuh0sSIJ8RdLSrUA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-EXIAo6RaMZqKhJEuOFFCiA-1; Mon, 20 Jul 2026 11:43:53 -0400
X-MC-Unique: EXIAo6RaMZqKhJEuOFFCiA-1
X-Mimecast-MFC-AGG-ID: EXIAo6RaMZqKhJEuOFFCiA_1784562233
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ef8249f871so194450266d6.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784562233; x=1785167033; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yf065jabcYafMmVIJkRCgULyD+XarIXuqgsfgkkgdag=;
 b=NdIMaZkElkHhdnpEfJQWr7vN1S56njUUZnvwIM6wCFcgHBU+Db+JYmGROI0Znyo9Ie
 Hpu4aafztsQNkwLJeS+v0RFcBw5FHKHcSV4/R+GL1sobmIDzUycnSveExKRL52NwNlEs
 2sdKnghZJx8vEGRkZJqES5BG+3oXlZoBv37f4lJfHW83d4Y8tH6YqJ1mwZmCURr9sD70
 mGrCwQEomB3u8XfnombyTYCHUVNRUQYjvYyZDaT/oURzqeMeBJw+pGG1SOUnc/LTC7uK
 tWodyqq1dlkghMI9nFjLhgygoxPZaB/1kEXXdPF/x8GypIQAbf4NYq4OF+SVe2ceuSQ5
 P3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562233; x=1785167033;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yf065jabcYafMmVIJkRCgULyD+XarIXuqgsfgkkgdag=;
 b=LzqzNYf2ZoN6B8HQYWgmKLwqH0Ju0n7n7c9dpvovnlDiZXuAC24wIs17/pu1kfPHQt
 HEJTF/3EnJ9YPfWr9YC25r+fGoVpUo8J+ToL4ySuQToVGIS/bKYQ6BamsxVmCZolnPt+
 zQKgzN8YEAi3G00ziN/r/tRVqKd2D6JmHCpxhkCFknkCtcQuuGzfmEB+/tT9ei4nU8NE
 bqP5garOyboOkxCtR9EbzYIEfS/rOSovfOK7Xv1rFK+qKM9S8kisH3y1f9D5S7ZZGrNV
 PqJuhIVDHtW3lJ7yhP+QSuSX/Q5JVi0XbAVE10rNz+dD9q9P06HTi89JGhEAYgH6aRRh
 ykog==
X-Gm-Message-State: AOJu0YzjyUrEXjL521UGA9MbtgqGuIfOVXxIOhd2LRvCmXiZoiYrafZ4
 Urwu3LeTkKWT2B0CKHbNLPJWX6MdYT5LnT/Vw5/3+v7v6SEVwiH9xHx2ZT4x8uLpwGHIlVoXozR
 aWQ9OxEjzyKUJS4vIlzAF0ur0k+Vz4VhxVj94qsX+UHj+aXmJb5d7oMrZ
X-Gm-Gg: AR+sD11JIt0Gyv9cS99LwOV15+AjIxtkV+EH9RljiI8eYaNX5YPOWx3mI+pCZipUgsT
 6RZe1lN4fuZFm+KkuIrhgpi1A86R8U9HugwdbwR1ykwghHKI9Mu2+iRXmRKblLDkWDkLnryBSd2
 xK7CKFQvbx8Nh6K3528VAzaw5VdFJztHUntvjxwaJBqiPN2md0mvLbf8+sLecPXdNF8Xnvgh+tS
 k6yyEIk7UYwaZsdgeq7mLX0TD9htAPg70LbYIB5inylDz2Ve1s2tSJs1TI7pg+BPSsSDtYlptZz
 tFe8TBIABCIQJA4P8zQMv2YOwQRGpEImaSkjpMxUNYiDJ8WW2OS869vCAEmswMbAtvVw
X-Received: by 2002:a05:6214:5d89:b0:904:4d83:e1b0 with SMTP id
 6a1803df08f44-9077852e893mr135852356d6.54.1784562232732; 
 Mon, 20 Jul 2026 08:43:52 -0700 (PDT)
X-Received: by 2002:a05:6214:5d89:b0:904:4d83:e1b0 with SMTP id
 6a1803df08f44-9077852e893mr135852006d6.54.1784562232226; 
 Mon, 20 Jul 2026 08:43:52 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778541910sm93871776d6.4.2026.07.20.08.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:43:51 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:43:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 02/11] migration: Extract blocktime marking helper
Message-ID: <al5CJ1A4me2fjwn0@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-3-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-3-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:38PM +0530, Aadeshveer Singh wrote:
> Use new function try_mark_postcopy_blocktime_begin() to call
> mark_postcopy_blocktime_begin if page was not received and return if it
> actually marked it.
> 
> This will help in having a cleaner API to call
> mark_postcopy_blocktime_begin as it requires the page to not be received
> by asserting on it's existance in RAMBlock->receivedmap.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


