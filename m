Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A31C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4nj-0006oh-Ur; Tue, 24 Jun 2025 10:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4ni-0006oX-Ff
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uU4nf-0007L0-UK
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ge314U67yp/TNiqGWf3Lv2HO0QfO8KmGrdRo6OQ7kSg=;
 b=ei/GuCgZpA37100y4jMNz4XX6W/4XJDUf8ol6PXvC2e1UzM+ATpCMZ0VqvORJEJCFMoHDA
 cdJy1L1y2XtCvE7weBif30B2rRJpQFtdqw/nAW7n+TTyMtc161Mo042l97E82UlmvD6Woq
 ARpTez7TzR2k+fZfwNPHIeha3sY4t4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-_uDPo4swMN2fSXwgtGjPaQ-1; Tue, 24 Jun 2025 10:38:56 -0400
X-MC-Unique: _uDPo4swMN2fSXwgtGjPaQ-1
X-Mimecast-MFC-AGG-ID: _uDPo4swMN2fSXwgtGjPaQ_1750775935
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so2761179f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775935; x=1751380735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ge314U67yp/TNiqGWf3Lv2HO0QfO8KmGrdRo6OQ7kSg=;
 b=jPu1Ruu59XaZTyI821vdE9ChGqTX4VuEI8dG7YhL+qET7VQ6RBw+BOJgd8XRCF2ZLF
 kIdpaMRds0j0jWjfyx08lFpNWdIDcqB2Jk4aXyayMAn/F8b1qr04zCkDmLN6v6dJvCQH
 4rOcHJ2kl2b2sBUKvkbYB7fUbAWTlzjLCwwDvuEdFq+dwcp9g1LutpVeqASsovODx15m
 N4SlQkvZmL+iiNUfjglMdUDyLlC+XFVYHPe7WeQsZVVkvVX/5FswYJHWGy6rn804CVaa
 2PQOBIdajH41D1rKB1LdGpJmdQTCPMwmfL1dSMGp8jUjI+X7/eQz4VzHi2sQbSilrA/3
 GlYA==
X-Gm-Message-State: AOJu0Yw0qbrdCLOb/8BlI+tjM1Qsz3IdozGOCtHM9yr0wbfAgWkhrjVc
 aUBIyHy9yFiY4K/6t9bjZdnWE0hGoeDh2+SV+PLNvobjxd3227+tJHUmCF8cNNM0h2x1O+OZWrO
 7n3E2gh66ZHfffCLt2WD0bHxhRGU47gE9OOV2I5gN7DLaqn1y946/qKH8
X-Gm-Gg: ASbGncs+n2Xx2IyOa+AI0kx0fe8vj3Ce5s0EDxAfhXI53Q6fweOXJMTuo00okI81nLy
 XJ5Ap7Mz9wvtpM+X6U5WNem5OFfnnn7BP4f9XTCXsghV3VpFZ3LbDsSAtGmRDIbKpNRoe9BLdCB
 BW7LArV9Dmb+ic47lZzq69Ordgaup8wfIzHEpxLJoLaeWlXft2A0OVKH8Alx2czjC6iNwrVFQFb
 eW5ddr1dGUwd71HiZYRuipadwMaoQ61SAM4Yj4joOFCpoUgSSlphep9sWbip8XqxvM/bGFGYaLo
 J9ONaTWf6PU=
X-Received: by 2002:a5d:584c:0:b0:3a4:fa6a:9174 with SMTP id
 ffacd0b85a97d-3a6d12de83emr13617657f8f.33.1750775935424; 
 Tue, 24 Jun 2025 07:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUVH0/a3QJhJgr2uXY4FeXKuKNyr69LCj626c2wGN+ib5GDkufsMlaDPFz/Jdmpfl7wmYd1A==
X-Received: by 2002:a5d:584c:0:b0:3a4:fa6a:9174 with SMTP id
 ffacd0b85a97d-3a6d12de83emr13617634f8f.33.1750775935036; 
 Tue, 24 Jun 2025 07:38:55 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f24casm2131233f8f.61.2025.06.24.07.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 07:38:54 -0700 (PDT)
Date: Tue, 24 Jun 2025 16:38:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 07/11] migration: qemu_savevm_complete*() helpers
Message-ID: <trtrghar4fnqsojsqpk3obxuubd2oq6cydse7kq6zstmkp7mxx@xmsls7uj7bjh>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613140801.474264-8-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-06-13 10:07, Peter Xu wrote:
> Since we use the same save_complete() hook for both precopy and postcopy,
> add a set of helpers to invoke the hook() to dedup the code.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


