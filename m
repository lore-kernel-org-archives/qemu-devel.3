Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03015C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAc9-0001fN-GW; Thu, 06 Feb 2025 17:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAc8-0001fA-BL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:44:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgAc6-00037A-NR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738881890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dgvreo4gpfQ5KsbRV4oqyLZ8m/vqYtAyIU94eFdYcc4=;
 b=KZ3Kjb3KVksi/HkykquCJbCsZE1Yo1Kl68cCSLpkIPA672GA7o4UqD57K5ez1HBq33Bfyh
 2vOdB2l580JSt/5RwNrBn4O+uMs/Rluc7FsWxrZ5P/63QUf9VYz/0VPOADMW9YmyukMWdT
 kagWrjlfA30IRk4Pq0RnEdAfL1rHi78=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-PJwlqFAEOMGtwJS6OatBWg-1; Thu, 06 Feb 2025 17:44:48 -0500
X-MC-Unique: PJwlqFAEOMGtwJS6OatBWg-1
X-Mimecast-MFC-AGG-ID: PJwlqFAEOMGtwJS6OatBWg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6e4221ff9a9so32502266d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 14:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881887; x=1739486687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgvreo4gpfQ5KsbRV4oqyLZ8m/vqYtAyIU94eFdYcc4=;
 b=d7FlA2GEp2XPM3pHBsYYxUQz4vpdb+V5TZPwm9EpZL+N3I8fAsgn0JO7FIUR7BJs06
 onTjaqEX8gPeSJLLk89Q7///cSbAwWZ8dbVnZL1/5bP6AfGE27Aq1WW01sHRhMskEqWP
 bGhsBlGVttVSvaPdzsbk3wRLIvDJfNGbN2NcmmFgTv48UztXXja1MwprZ1dYATtV/AGG
 sxD7WvPseKDXda/hDwWyl7+P1EbiNw51aQlvwTA7BfjISZyUXyWGIgZ84WFvMHYjBjGj
 Ot+es5DSbe0tCD++qKAWCF7pbn2B0HPvO6zGjfB1zyc/f1hKw5YcJKlFjP4B/h8joFaA
 3HtA==
X-Gm-Message-State: AOJu0Yx3MgC6bdiz6iN5VuGpBQWhWmRtcI1hJe/wyW3sy0Qe56WJCesY
 t32OA++KAVY5zFIgx0wY419FSQyX2lntJLjTpan2Oj5mqk0ueZXocXoV19DzzutsXOIG678NCDt
 RDzN0ufsE90ZaJR2Lwuna8WZBfCjviV1idW01TxB4PqDVTyBFkTNp
X-Gm-Gg: ASbGncuLKPE/w2IPRWHnHM3nvBl8qaw+GfmtrdoILfXp0RD0UmZ4atdb13+Agbqj6At
 evoeViQUcgkrrAU4Mk2pHUzr8DSXkEOpZvByMptH22u0rIJnFSW06oHVh2rUWDOO5BxtIkbjJlg
 GYHldeV7h3YwbziptFJra0v8drzg/5cvjCuAk+ToTlgGR+ht5s5s2tfwNbhd+uYgvKM9+/U0Atu
 w8uHkiHvZ8aAPm3Mxr4SZkUtfOrXP1nWNAX3VAla72P5nVo/f/Ry939mx/qjznoGYtdgSxp7oXK
 iQQ//GMKxAlweNoklPHD6BVONjWrizolxKS/aNfJbUUHE3wA
X-Received: by 2002:ad4:5f0e:0:b0:6d4:211c:dff0 with SMTP id
 6a1803df08f44-6e4456d9d9dmr10998346d6.29.1738881887728; 
 Thu, 06 Feb 2025 14:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErfapYm8RdNRRK3BJYUXbWLJexc8Wnz131lxvY0rgLXyST4kiPqSBwnyilfOmJ4TCN/c+uLQ==
X-Received: by 2002:ad4:5f0e:0:b0:6d4:211c:dff0 with SMTP id
 6a1803df08f44-6e4456d9d9dmr10998136d6.29.1738881887484; 
 Thu, 06 Feb 2025 14:44:47 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47153bc6e93sm9802131cf.54.2025.02.06.14.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:44:46 -0800 (PST)
Date: Thu, 6 Feb 2025 17:44:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 5/5] tests/qtest/migration: consolidate set capabilities
Message-ID: <Z6U7XQO-Mjgb92eb@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-6-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250205122712.229151-6-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 05, 2025 at 05:57:12PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Migration capabilities are set in multiple '.start_hook'
> functions for various tests. Instead, consolidate setting
> capabilities in 'set_migration_capabilities()' function
> which is called from various 'test_*_common()' functions.
> While simplifying the capabilities setting, it helps
> to declutter the test sources.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Would you mind reorder the two test patches, to avoid removing the lines
added by previous patch?

Thanks,

-- 
Peter Xu


