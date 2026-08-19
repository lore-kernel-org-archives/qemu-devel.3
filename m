Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4465FC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQz-0005Y2-SI; Wed, 19 Aug 2026 14:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlQy-0005X2-65
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwlQw-0007PV-Pm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787165681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRu9LUGGrzhm0rt+z6U7qZDOAwT1fGm6NRHnwVw7E5o=;
 b=Ci+h/X2ZN0q+txsBHCaNc/CjzVuG7GB/FUVU/CVYoHN8Q9iNa0BKCs983Ipt25+skc9AXF
 iXVrBiexIlTv/inc8UWh2aMDPYWXLse3d3SpK+FbSghZYDHtsjFupid67nzmJjV285UoEM
 M0NCvPQn/maZMdvJQgGIHteWwasGCTM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-8BflyO2pNj6Apzn5KsxcNw-1; Wed, 19 Aug 2026 14:54:39 -0400
X-MC-Unique: 8BflyO2pNj6Apzn5KsxcNw-1
X-Mimecast-MFC-AGG-ID: 8BflyO2pNj6Apzn5KsxcNw_1787165678
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-933023a5980so224113485a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787165678; x=1787770478; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qRu9LUGGrzhm0rt+z6U7qZDOAwT1fGm6NRHnwVw7E5o=;
 b=i5eE4nC1N4BOtStETBD6l3mgxH5EnKo1Pb3om73QggIYXYS/dj8cXCImsMqn3CqYAA
 wgCu+U6TkzJruHquZqk0PIs9irAEl3jhUTkEOrFbdJSb/zbXV2nwbUlSNwpjDy5s0M9n
 xVQInmYPeuyK+kq/6QfHM9j/3gHMHeAW/qoROtHq/U57ssSMClBv+XVZWzF7LO3Jtjsu
 QeURG2VNkmNLXlug/R2wuTxv/F/CbKHfQuglNGDBMWbqh1g1l63GGs4ZEfATP5gDuiHE
 /Uh6gOqs/vfhsrUUyIW29fIiNWASsxONK89bLRr98aIhdi5GxtK9uL57YfEyL0Aag11W
 iw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165678; x=1787770478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qRu9LUGGrzhm0rt+z6U7qZDOAwT1fGm6NRHnwVw7E5o=;
 b=U181PUi1RUISGJgqnxtDrQooZX/f/noBBCQcRk4XfErdJiDe8KHsDgDqr3hfCE9kRV
 S6OOZVqttxszOajrSo+UJZVl2uTR1+cG9bIuflDfJEp0ONwTKn+eHkUJU9gnS7jVcQat
 NcF5gQMcBoP80qHZxRINkQvHHko2YxwZfjCp6Fe6cfcMF6E3d9FA3Fw1glfQ5KBP4iRH
 luJyrViPXbfYJ5WrnIv3hcOUB0jT7xcgrQvece/61CLYK7uK9keAV9IaEcLbyYnA4hUT
 oIqJBrvircQpg5R0s/u6hqELox4MjurqcBa0Yxi7CUUwfdeiMIfnRGHPGe2966/05yyf
 vgLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroJ2RqSlBKc/WJo/k+Ucv5gMZwMYDnMa3dJZMdhs7LW4Aq9QQok54bq+l0HKtbVxu3sy4QJVnkIheC@nongnu.org
X-Gm-Message-State: AOJu0YzCEADlgBpcBCDOHpJ8n7hZraBUh1NyyiC0lSOqjfncOVgSDvni
 ZilYCPFSh932SB1TVhJMcqXxer/a09UtNNSXCb1tn69Kb1ajPzVmbc1whadhN7YAE6iWlVr2QCV
 2r2+O6b1lvLz8QzsX48x0Y8yNpDhUX7SUQxjuK61D5K8aRRQR69Vb0XCQ
X-Gm-Gg: AR+sD12bEqJgscM9zn9ZqQx6UxWTghwx/zdacX+4+GvrZCW+C3PW5aLZ6OfQNmENIyg
 2vwAso9gN2hKGknDQPaoCeeqF/vdMDYylHu6SIzBReQFBxyLu1ETQptOBWe/Vo3jx6UDznJXq5/
 N2b1kC1u8eB2jIrmKHK20t9mT3gWy9A0HNxAAfd9F9IA5/PI9hcBiZ6inHrJr6dMRDVYGOSo4l8
 RWrF3hFFOO0V7QOLccS/5blsnrR6DDVKbeQ6P9FbBRD1atCZ575InXMVJExF4fMp1XJmTWcW3fg
 Zc2ZdKSXCL6DJRkrmp1DGk40HCu3gwzBcP2M/bETqJrYBMevclIef2ZJ6RLxwGMkdbX7
X-Received: by 2002:a05:620a:2909:b0:926:e8e6:3c34 with SMTP id
 af79cd13be357-9371e258decmr549246485a.21.1787165678373; 
 Wed, 19 Aug 2026 11:54:38 -0700 (PDT)
X-Received: by 2002:a05:620a:2909:b0:926:e8e6:3c34 with SMTP id
 af79cd13be357-9371e258decmr549238285a.21.1787165677129; 
 Wed, 19 Aug 2026 11:54:37 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b5a1bsm20837546d6.45.2026.08.19.11.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:54:36 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:54:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v21 11/16] migration/fd: add errp parameter to
 migration_fd_valid()
Message-ID: <aoX76TtzqcTMrYhY@x1.local>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
 <20260819180201.1970193-12-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819180201.1970193-12-vsementsov@yandex-team.ru>
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

On Wed, Aug 19, 2026 at 09:01:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Let migration_fd_valid() report the error itself, instead of
> duplicating the error message in both callers. This also prepares
> for adding one more check (with a different error message) to the
> function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


