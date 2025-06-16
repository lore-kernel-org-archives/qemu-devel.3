Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE02C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2op-0005Zq-Pu; Mon, 16 Jun 2025 01:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR2oQ-0005MC-JR
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR2oP-0000cf-3t
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750053315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BY4l1pNxbzCRmcvWLVcPxLn13aGmAquOzkkPL4iuItM=;
 b=ACnUnpEkYbCw91DAbdh7BFVRGlm95okpftE2NlxDi0EvgAmSfFzJ63aitcvMMZbsklTt+Q
 AYw2HFdGVE6XdVEN+ZbZmHp6eJ+654HgiBZ59wQejlBMuvqsfNflSx09o0rCe97jSS6HvY
 VueQNFi8pzjTR2Fx9DtfPd3um9Z3tZ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-3TEsGQYsNt2wAR7BE9IrMw-1; Mon,
 16 Jun 2025 01:55:09 -0400
X-MC-Unique: 3TEsGQYsNt2wAR7BE9IrMw-1
X-Mimecast-MFC-AGG-ID: 3TEsGQYsNt2wAR7BE9IrMw_1750053308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4477F18089B6; Mon, 16 Jun 2025 05:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6F27180045C; Mon, 16 Jun 2025 05:55:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA05421E6A27; Mon, 16 Jun 2025 07:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Chao Liu <lc00631@tecorigin.com>
Cc: pbonzini@redhat.com,  peterx@redhat.com,  david@redhat.com,
 philmd@linaro.org,  balaton@eik.bme.hu,  chao.liu@yeah.net,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
In-Reply-To: <cover.1749800810.git.chao.liu@yeah.net> (Chao Liu's message of
 "Fri, 13 Jun 2025 15:49:28 +0800")
References: <cover.1749800810.git.chao.liu@yeah.net>
Date: Mon, 16 Jun 2025 07:55:04 +0200
Message-ID: <87frg0w7rb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Chao Liu <lc00631@tecorigin.com> writes:

> From: Chao Liu <chao.liu@yeah.net>
>
> Hi, all:
>
> After several rounds of discussion, I think that adding a -t option to the
> `info mtree` command, which enables the display of tree-like node characters
> (e.g., +--, |--), is a better approach.
>
> As BALATON Zoltan pointed out, retaining space-based indentation for displaying
> memory region (mr) nodes helps ensure that the output remains easily parseable
> by other programs. This also provides better compatibility with existing tools
> and scripts.

If people really feed the output of HMP info mtree to parsers, we should
probably provide the information via QMP.

> Users can choose between:
>
> - Without '-t': The default format using spaces for indentation, suitable for
>   scripting and parsing;
> - With '-t': The tree-style format using visual characters, ideal for
>   human-readable output.
>
> This way, both usability and compatibility are preserved.

Maintaining compatibility is a choice in HMP, not a requirement.  I'm
not judging, mind.


