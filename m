Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E091091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mli-0002eG-U2; Thu, 19 Mar 2026 19:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3Mlf-0002Iv-7H
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3Mlc-000881-CO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhgPPveaCl5QhaHSmMG5Irx7zbRZmOJXmMVEsSXjbhE=;
 b=Awfi5qDs3q8LuHjFf/0kGtQKDpDB+yP90C6Pszs4+CGVvYEVuAjQdhkqynVmEOi3X1zHjU
 TPKbzetPRtS6blYNHattkeCcfQaJHd1A1F4vyT+wvrd/LMLQK7wvoRPTWztoH59aRYepaA
 AQ+ExQQKyaQX57yjRNIi8pSUC0ykHn4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-b-qB14kdPQC-5uNaiu8uJQ-1; Thu, 19 Mar 2026 19:27:00 -0400
X-MC-Unique: b-qB14kdPQC-5uNaiu8uJQ-1
X-Mimecast-MFC-AGG-ID: b-qB14kdPQC-5uNaiu8uJQ_1773962820
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd77e5e187so715485085a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962820; x=1774567620; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IhgPPveaCl5QhaHSmMG5Irx7zbRZmOJXmMVEsSXjbhE=;
 b=bHYmgz0Qr8A/TIdSWXzN+099dhXZBVhGiwLZyMtmpH6lBihvIRieEoVdjE7+EkA0Tj
 kaa0Q1AVa4TLcbkVPq7d/sxqvazQJ6dnKf4EG+EsXXRQzySAw1YTY60wLwGYoRsVk2zB
 adgvS2WxdE8Bsg0RgPrA3OrOWKEFzZMUJq+pfvPZ4crT/vPzg5I0xq0OxIfZQ14Dzsuk
 5CWHvLIUeMlQpbRyuJgrZmg7xHAdjS3T8IBW8F7C4QWqog1fxjzkAz16P2+TBc4ZeSww
 M/5ggnneUCOknDpgWti1FkFvrW7lLR+HTO/MN1pPqIyRfdC+3YRrDLhMcbysTsxbLfpp
 rSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962820; x=1774567620;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IhgPPveaCl5QhaHSmMG5Irx7zbRZmOJXmMVEsSXjbhE=;
 b=Iot5bVbxp9GywQWdHZdrTtUxtemY9f8vyirgFepKhXSGhZBx4aErK+8c61MfQUQ1OQ
 tD5tqJnaogCNXVOE2hKrZbXWaBwl/8fQspYMlYE4ki374K65f0QuogqxmrrMfBbKkudO
 GCLEnyCXAO8m+DN4bX9Lu/wVZNLVKPUGS+p+o/JafiiSx5hIwrg4JFUXmSDicLTqjABy
 hHstrGCfwDoxqssRMX+jM/5xsY79lzOsrnBhnHb+6JsfzhKvd/lITqRT58MJfH5zRmT6
 CO+8vmZr5O99xk8g9PSEHnoplVe5LdtEyurqPPuoekLMp/emBc9gmfDij+0E2hZyS01r
 PpUg==
X-Gm-Message-State: AOJu0YzBnUdybYcOgvMxzFdmhsxgIHLaEA6Yq5vuNPj1ypwA6OVAGyDn
 xjs42J0GrHSR89rxGeXhY6JiXhDdY4amJhjeKbO++F2un5YZQQ31P6z3kESeUX5Mdwu0id4tWZZ
 GpNu2+z5FosQjZy66RiqK2VJQARuLs9KRyNhli2QGMTkSnpxp4K7UDmTy8JOQZ8VaSl03jyRcvF
 Mqc9nZvm5gWyPdsbYEyfbYk/TN+pVfwt5ctCv4Sw==
X-Gm-Gg: ATEYQzwYX5bKPzURa+WOAQBfV3tQwoFN3FTuLwmWw6o7uzVL6fJFysZlCz3ow5zbPGr
 A1UwYMGeKKsa/DUdy7NCJDVA3EqNt0JPSoeQdVkfTZl/trUUDcUiH1+dMtSleTe7qFuP92n9jJB
 SNitz9z0RQfYS74jfXH1rN6BkUTUAPhRgqMtYGFRE8RyYM2wAN2Xv1q6iJoigC6Q5SHgSsxhvFU
 6IpdfW4arbwT/+E15pZBi7J8jcCkFW+jfgWRhqbu6vv71lb49H2SwCxcGcdPEtddd7N7VFH58C0
 bA+Z9d0Vq/YaGrBIAFRhxx9EqyF9SW7nkWym6s6YEXQzzr4Ke8tH1DQmh/QwVY/UqPnkPKVrmN9
 0efx/aCIl9F2MMw==
X-Received: by 2002:a05:620a:4403:b0:8cd:c0a6:5100 with SMTP id
 af79cd13be357-8cfc80984f4mr175444485a.71.1773962819740; 
 Thu, 19 Mar 2026 16:26:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4403:b0:8cd:c0a6:5100 with SMTP id
 af79cd13be357-8cfc80984f4mr175439785a.71.1773962819111; 
 Thu, 19 Mar 2026 16:26:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc9089ca9sm38847585a.24.2026.03.19.16.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:58 -0700 (PDT)
Date: Thu, 19 Mar 2026 19:26:56 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Libvirt Mailing List <devel@lists.libvirt.org>
Subject: Re: [PATCH RFC 02/12] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Message-ID: <abyGQMRElTmLjdN-@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319231302.123135-3-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 19, 2026 at 07:12:52PM -0400, Peter Xu wrote:
> This stats is only about RAM, so make it accurate.  This paves way for
> statistics for all devices.
> 
> Note that even if this is part of qapi/, this should not be part of ABI of
> at least query-migrate, because the structure is not changed, and this
> stats is always reported only under the "ram" section.
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Libvirt Mailing List <libvir-list@redhat.com>

I got the address wrong..  Will update when I repost.  Copying the correct
one.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/removed-features.rst | 2 +-
>  qapi/migration.json             | 8 ++++----
>  migration/migration-stats.h     | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 6f4447993c..7c4f4325f7 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -699,7 +699,7 @@ was superseded by ``sections``.
>  ``query-migrate`` return value member ``skipped`` (removed in 9.1)
>  ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>  
> -Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
> +Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
>  for more than 10 years. Removed with no replacement.
>  
>  ``migrate`` command option ``inc`` (removed in 9.1)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47..cfc6ccee26 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -12,7 +12,7 @@
>  { 'include': 'sockets.json' }
>  
>  ##
> -# @MigrationStats:
> +# @MigrationRAMStats:
>  #
>  # Detailed migration status.
>  #
> @@ -64,7 +64,7 @@
>  #
>  # Since: 0.14
>  ##
> -{ 'struct': 'MigrationStats',
> +{ 'struct': 'MigrationRAMStats',
>    'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
>             'duplicate': 'int',
>             'normal': 'int',
> @@ -209,7 +209,7 @@
>  #     If this field is not returned, no migration process has been
>  #     initiated
>  #
> -# @ram: `MigrationStats` containing detailed migration status, only
> +# @ram: `MigrationRAMStats` containing detailed migration status, only
>  #     returned if status is 'active' or 'completed'(since 1.2)
>  #
>  # @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
> @@ -309,7 +309,7 @@
>  # Since: 0.14
>  ##
>  { 'struct': 'MigrationInfo',
> -  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
> +  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
>             '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index c0f50144c9..1153520f7a 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -27,7 +27,7 @@
>  
>  /*
>   * These are the ram migration statistic counters.  It is loosely
> - * based on MigrationStats.
> + * based on MigrationRAMStats.
>   */
>  typedef struct {
>      /*
> -- 
> 2.50.1
> 

-- 
Peter Xu


