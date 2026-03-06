Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9B5FCB623
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYMe-0002pp-Qv; Fri, 06 Mar 2026 11:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyYMc-0002oQ-L7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyYMb-0005Va-7m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772815760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SM6aaEMN8h5RCViJAlJrlj7L1a0jU4Acoemmwy9fW8=;
 b=KcdJiEqqtN83GwQH4VIFwD38aSWfx4+ZC3K1REcQWlwcf504Ff6TOta5vsYZQYTRUCv/+P
 0FSnZsaLS1w19nnZmtPuTsCcZgfLMi4sUdVniU/fGbQLNK40yibNJqhGMQqaa/yqhqcCET
 YosRQ8INlesftBkxZxLibSZkUS6W6mY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-Ipib_zVgMPCF2dhz9A1B3w-1; Fri,
 06 Mar 2026 11:49:17 -0500
X-MC-Unique: Ipib_zVgMPCF2dhz9A1B3w-1
X-Mimecast-MFC-AGG-ID: Ipib_zVgMPCF2dhz9A1B3w_1772815756
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158B01800631; Fri,  6 Mar 2026 16:49:16 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 905511958DC5; Fri,  6 Mar 2026 16:49:14 +0000 (UTC)
Date: Fri, 6 Mar 2026 17:49:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] qcow2: Add keep_data_file command-line option
Message-ID: <aasFiDpYO9kpI1Vb@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Am 30.05.2025 um 10:44 hat Hanna Czenczek geschrieben:
> Hi,
> 
> This series adds a keep_data_file qemu-img create option to qcow2 that
> makes it keep the given external data file for a newly created image
> instead of overwriting it.
> 
> This allows to create a qcow2 image for an existing raw image using the
> qemu-img create command, which previously wasn’t easily possible
> (besides work-arounds using a temporary data file or qemu-img amend).
> 
> (The “proper” way of doing it without this option is to use QMP
> blockdev-create.)
> 
> This new option is a pure qemu-img create (i.e. command-line) option,
> not available via QMP, because it does not make any sense there.  See
> patch 1 for more explanation.
> 
> (See https://issues.redhat.com/browse/RHEL-73509 for perhaps a bit more
> context.)
> 
> 
> Hanna Czenczek (4):
>   qcow2: Add keep_data_file command-line option
>   qcow2: Simplify size round-up in co_create_opts
>   iotests/common.filter: Sort keep_data_file
>   iotests/244: Add test cases for keep_data_file

Thanks, applied to the block branch.

Kevin


