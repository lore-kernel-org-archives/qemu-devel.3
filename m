Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C4C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUT6i-0005Bx-S9; Thu, 18 Jul 2024 11:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUT6b-0004wb-Sp
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUT6X-0001wV-GC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721316696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=irV0jrBv4R8M+jldso9jcFwBxeDOEmGozA1qpk+7aIo=;
 b=iQhNQXx5qdSTM+4By51CwtY6wZj0scaLn5m+VUIsOUNvH9kYKY9x0EB848Z7gPBTjIJgYH
 5Yc7FQEN8x999nfMjdSm6zEbi7/+qKYF3Q/oatJ/TnYQXdAEnO0ixuk8CiAW+mWa5+ZXEa
 MNMJ8mDzcu4Dm41vLW6uNyT5Olpezvg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-Z6AN1-20Nu-KBGTKpWNoUQ-1; Thu,
 18 Jul 2024 11:31:34 -0400
X-MC-Unique: Z6AN1-20Nu-KBGTKpWNoUQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D3FF19560BF; Thu, 18 Jul 2024 15:31:33 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C715C1955D42; Thu, 18 Jul 2024 15:31:31 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:31:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 3/5] vvfat: Fix wrong checks for cluster mappings
 invariant
Message-ID: <Zpk1UZGPquFum48s@redhat.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <cb635e58663b2dd02baa8e015dbc7fd57da89e46.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb635e58663b2dd02baa8e015dbc7fd57da89e46.1718195956.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
> How this `abort` was intended to check for was:
> - if the `mapping->first_mapping_index` is not the same as
>   `first_mapping_index`, which **should** happen only in one case,
>   when we are handling the first mapping, in that case
>   `mapping->first_mapping_index == -1`, in all other cases, the other
>   mappings after the first should have the condition `true`.
> - From above, we know that this is the first mapping, so if the offset
>   is not `0`, then abort, since this is an invalid state.
> 
> The issue was that `first_mapping_index` is not set if we are
> checking from the middle, the variable `first_mapping_index` is
> only set if we passed through the check `cluster_was_modified` with the
> first mapping, and in the same function call we checked the other
> mappings.
> 
> One approach is to go into the loop even if `cluster_was_modified`
> is not true so that we will be able to set `first_mapping_index` for the
> first mapping, but since `first_mapping_index` is only used here,
> another approach is to just check manually for the
> `mapping->first_mapping_index != -1` since we know that this is the
> value for the only entry where `offset == 0` (i.e. first mapping).
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


