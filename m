Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF2C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MIt-0004wE-TM; Fri, 04 Sep 2026 01:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2MIs-0004vP-71
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2MIq-0000i5-RJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788499048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lFzC+mu/BwuNUEIs2huevL2qXjsq7rsRzc3aKCGOJqc=;
 b=cccmexQFUt394Aw1Bo4NHYTGiMwzFC7GzsQupwjh3fkOKUUxHO7TSYi9yxO5+Ner6ry5x3
 8UXh0Ebcer10ZBN0pV1CsK5NSfbHYEGR2IyjixFwooeI68bVdFjrEaEdqDyihKfQ58tybp
 gaQbF/wU7b+pid4TA4dOhSyFqQmIH0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-Xp66TstZPayTrpAosnIb5w-1; Fri,
 04 Sep 2026 01:17:23 -0400
X-MC-Unique: Xp66TstZPayTrpAosnIb5w-1
X-Mimecast-MFC-AGG-ID: Xp66TstZPayTrpAosnIb5w_1788499042
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1134D18D62CB; Fri,  4 Sep 2026 05:17:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97A681800598; Fri,  4 Sep 2026 05:17:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34EA921E6A04; Fri, 04 Sep 2026 07:17:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowangio@gmail.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Fabiano Rosas <farosas@suse.de>,  Hanna Reitz
 <hreitz@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  qemu-block@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] qapi: convert simple event intros for machine.json
In-Reply-To: <20260903200008.729791-5-jsnow@redhat.com> (John Snow's message
 of "Thu, 3 Sep 2026 16:00:07 -0400")
References: <20260903200008.729791-1-jsnow@redhat.com>
 <20260903200008.729791-5-jsnow@redhat.com>
Date: Fri, 04 Sep 2026 07:17:18 +0200
Message-ID: <87h5k5ioip.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 9d709cb53e0..cf905afd4f1 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1125,10 +1125,9 @@
>  
>  ##
>  # @BALLOON_CHANGE:
> -#
> -# Emitted when the guest changes the actual BALLOON level.  This value
> -# is equivalent to the @actual field return by the `query-balloon`
> -# command
> +#     Emitted when the guest changes the actual BALLOON level.  This
> +#     value is equivalent to the @actual field return by the
> +#     `query-balloon` command

@actual does not refer to the argument here, it refers to
query-balloon's result.  Harmless until we turn it into a link.  Not
fixable now, because we lack markup for such non-local references.

Yet another note of future work:

5. Implement markup for non-local argument / member / feature
references, and put it to use.

>  #
>  # @actual: the logical size of the VM in bytes.  Formula used:
>  #     logical_vm_size = vm_ram_size - balloon_size
> @@ -1556,10 +1555,9 @@
>  
>  ##
>  # @MEMORY_DEVICE_SIZE_CHANGE:
> -#
> -# Emitted when the size of a memory device changes.  Only emitted for
> -# memory devices that can actually change the size (e.g., virtio-mem
> -# due to guest action).
> +#     Emitted when the size of a memory device changes.  Only emitted
> +#     for memory devices that can actually change the size (e.g.,
> +#     virtio-mem due to guest action).
>  #
>  # @id: device's ID
>  #


