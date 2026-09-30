Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C0CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvxC-0001UD-En; Wed, 30 Sep 2026 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBvx5-0001MZ-93
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBvx3-0000T2-RB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDgMmMHBsk91zHLqy/OUb7moj4MV6vOcWJ6Y0IUvnLI=;
 b=AIvhsKZUvkMmOIEb9WdJdFAvnV31EZFKAmr6EmW6ceucWyjKk9MF0S6PKjzq6iqzHMplHu
 MxSPXIqTDO4ogyep7idqPhSkwHd+j85HGP2jWn04fnhGpWdAOHkoTgenZOUwQ4BADJ0Xde
 ZqfgktZ/BXYr6M9/M0T97D08lav6s0E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114--MEVi7kkOACFZALNfHaWzA-1; Wed, 30 Sep 2026 11:10:31 -0400
X-MC-Unique: -MEVi7kkOACFZALNfHaWzA-1
X-Mimecast-MFC-AGG-ID: -MEVi7kkOACFZALNfHaWzA_1790781031
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca6095cceso117749885a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781031; x=1791385831; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BDgMmMHBsk91zHLqy/OUb7moj4MV6vOcWJ6Y0IUvnLI=;
 b=WjJ+miBAD0QpqmIwqGd1ynQjP5bfE9vvv+Gys52Bv3OuTVZBykNcpPo8l8/y/1w3Ml
 zLiNOBtrReiVr8CE+1b9jYGyBuLYBct0g88GbK3Q4Mjc4x2sR1JAnWoZ+LOq9LOk4J7Q
 V9IYMIU+w/hYNnEgoNvX5g5xqssHNMKH/S48Tkw66jVWw49Zai68snRita0IbvDBV07b
 imZPcNuW2prjiLILw6HUFUmes5NjLGSJajI670Q+r5XKwsFAssv6TrG48hE01uSmJZ1/
 59e77Yf7CTU2CU+0/dU7IgaCt/Zx/gIS1fDOx/8C8aYoywmnxWsvpBpAzjybh8OS2O+B
 y6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781031; x=1791385831;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BDgMmMHBsk91zHLqy/OUb7moj4MV6vOcWJ6Y0IUvnLI=;
 b=KjqgTV2x8bLgG8aWSSt2q1bX8u+0Qy049jpfCfzRUg8XzvHdwVRlb3GEJWCZCtByPR
 Vm869cImJptSm2Xukh1FZpIKdlPAx2JGY+MoNBv9vFY1RRxHKjkL7ndLHZz9eHRVCB7z
 BkyyYTCJNFQNWnH4UWRtzrjO+hCvy8byxPXbgv75a1Bz/416qdCAH6kpNR2uOtswLGxi
 uIGVNFrRcg0vSFX9y0Dn2e/diiNOkmO3t5faIz2nCvjGz+9usnjI9BoaWSuFQa2saNB0
 46ipu2aQ7Uu+bsODX92w2wpsNgaZXtWmAHIxhSKjtWqO30mOkRh0X0yJi5fdyhQjhXxQ
 ksBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVr9W1iz5+gc/Dz+CBgm+wvosZOOwWLsVSebtAuBGYoQcC7sQ1r0I7LBI8hcnehu7RLDFTlrM5WO3r@nongnu.org
X-Gm-Message-State: AFuF++k05UwrLfAbl3pN1rkKlqOmBnaeKkTHzdzPGSrD6So6BV8n9OzP
 +xqziqgKozpZJPbiBJSjG8CfuX4NI/rpWDsfIsIM6U0eGWUevtY7v2aG8FIfKWkt3hbjmaGMo21
 OkNSr+qW5+5fe0/dhBfku5xlJ6bNUSWlXLeR7RDgvXigIPkRWQcek69zG
X-Gm-Gg: AYBFou2a6r+GWEt2xWSIHSNCZqZWPpAF3oIlKV0jMuYN1x+6/YhofTcRbWSEi9DZuKo
 uAsbFLWTX+Hy6DT4RcT2y5Rhw12lPnFWDKD2f55Fa8C21aGhXDux+YTMrsaNN8X49EIHUHXxu6G
 EG99ZkVVgxPPO40sdRWdZzsyV79jQGTKn8fIOosF6gscWNVnIdnG7Smx0oHimXkLzEnrC8IUFt7
 aXzQHICgbv4Cd64CMXJWdRozt2k7dRbP7lnFVdYaqjokCWwP7/xCN+LNBLScT6dVE63BagDwaDZ
 +j0szYmGWKxhkAVsmcZq+rnMQhcxefffLBvGHB6Fo2T7HBNkRA5BvP3+10KN123TFYDyjgI=
X-Received: by 2002:a05:620a:2b8c:b0:939:abe1:ed1b with SMTP id
 af79cd13be357-93ca940c511mr270348285a.0.1790781027139; 
 Wed, 30 Sep 2026 08:10:27 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8c:b0:939:abe1:ed1b with SMTP id
 af79cd13be357-93ca940c511mr270313985a.0.1790781024189; 
 Wed, 30 Sep 2026 08:10:24 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca7eb1207sm136843085a.4.2026.09.30.08.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:10:23 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:10:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, pankaj.gupta@amd.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, david@kernel.org, berrange@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v7 10/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <ar0mXsX6mOmqlIm9@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260929235109.1398509-1-michael.roth@amd.com>
 <20260929235109.1398509-11-michael.roth@amd.com>
 <87qzibtj77.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzibtj77.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Sep 30, 2026 at 07:13:48AM +0200, Markus Armbruster wrote:
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks all. I queued the series.

-- 
Peter Xu


