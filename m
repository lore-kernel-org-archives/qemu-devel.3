Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535C9C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE459-0006bN-FP; Mon, 03 Jun 2024 05:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE458-0006bE-K0
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sE457-0002UW-2J
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717407260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YuS+CEU8wWX42N9SF4IedJuSubIOn23i3D1gNGY8coY=;
 b=fWxdXYjxDQOHdfz/UCBAENRHUBY3ZEmarI/bfdqO6NBXOhpE45lPiX9w42ICB4ly7OE+jw
 X0JNnJS7zF9KPQ13m4CDoKsT0Rem1PQjUz95oiJ6jVeQ6UQ6cfpyjJK08ACUmrk2dl+KNP
 B9E7NJvPh1f0jIvHqlsV/0CyJBF0AeY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-rHn7AAqTNc6J_Nd-rOjcZQ-1; Mon, 03 Jun 2024 05:34:13 -0400
X-MC-Unique: rHn7AAqTNc6J_Nd-rOjcZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E69B3800074;
 Mon,  3 Jun 2024 09:34:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C72FA1C00A8E;
 Mon,  3 Jun 2024 09:34:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D50F421E6757; Mon,  3 Jun 2024 11:34:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: clarify that the default is backend dependent
In-Reply-To: <20240523133302.103858-1-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Thu, 23 May 2024 15:33:02 +0200")
References: <20240523133302.103858-1-sgarzare@redhat.com>
Date: Mon, 03 Jun 2024 11:34:10 +0200
Message-ID: <877cf61ib1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> The default value of the @share option of the @MemoryBackendProperties
> eally depends on the backend type, so let's document it explicitly and
> add the default value where it was missing.
>
> Cc: David Hildenbrand <david@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> I followed how we document @share in memfd and epc, but I don't like it
> very much, I just can't think of a better way, so if you have a suggestion
> I can change them in all of them.
>
> Thanks,
> Stefano
> ---
>  qapi/qom.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..8463bd32a2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -600,7 +600,7 @@
   ##
   # @MemoryBackendProperties:
   #
   # Properties for objects of classes derived from memory-backend.
   #

[...]

>  #     preallocation threads (default: none) (since 7.2)
>  #
>  # @share: if false, the memory is private to QEMU; if true, it is
> -#     shared (default: false)
> +#     shared (default depends on the backend type)

Note for later: the backends are the branches of ObjectOptions that use
MemoryBackendProperties as branch type or as base of their branch type.
These are

    memory-backend-epc (uses MemoryBackendEpcProperties)
    memory-backend-file (uses MemoryBackendFileProperties)
    memory-backend-memfd (uses MemoryBackendMemfdProperties)
    memory-backend-ram (uses MemoryBackendProperties)

>  #
>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>  #     (default: true) (since 6.1)
> @@ -639,6 +639,8 @@
>  #
>  # Properties for memory-backend-file objects.
>  #
> +# The @share boolean option is false by default with file.
> +#
>  # @align: the base address alignment when QEMU mmap(2)s @mem-path.
>  #     Some backend stores specified by @mem-path require an alignment
>  #     different than the default one used by QEMU, e.g. the device DAX

As stated in the commit message, this matches existing documentation in
memory-backend-epc

   # The @share boolean option is true by default with epc

and memory-backend-memfd

   # The @share boolean option is true by default with memfd.

I think "with FOO" could be clearer.  Perhaps something like "with
backend 'memory-backend-FOO'.

However, even with your patch, we're still missing memory-backend-ram.
I can see two solutions:

1. Create MemoryBackendRamProperties just to have a place for
documenting @share's default.

2. Document @share's default right where it's defined, roughly like
this:

   # @share: if false, the memory is private to QEMU; if true, it is
   #     shared (default false for backends memory-backend-file and
   #     memory-backend-ram, true for backends memory-backend-epc and
   #     memory-backend-memfd)

CON: we need to remember to update this whenever we add another backend.

PRO: generated documentation is better, in my opinion.

Thoughts?


