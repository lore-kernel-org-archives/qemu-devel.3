Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75ECCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKaM-0000gD-12; Tue, 02 Jun 2026 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUKaK-0000fz-69
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUKaI-0000hj-HO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780389288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5pFa0FIkeV6ihl8xHC3tS17xLByKCnrUJUUSb9/GhuQ=;
 b=RUfFoCdoGwwOJjqfCCXGLxv1BMbRWj1VQsrIoHCVh/azHCfd9XE96k6b0oGVBZPLDOOeYK
 jPb+dewz+Ehb7KEYuzxlTngs4owjNLaTrKjCXIIgkiui4kA83Byq2DvBMdDsthAdreHdCw
 tVqVRTmeYWvXmLmwiogYkJNwqKE3bLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-s7nbmAShM1icTDM7q_GDWg-1; Tue,
 02 Jun 2026 04:34:47 -0400
X-MC-Unique: s7nbmAShM1icTDM7q_GDWg-1
X-Mimecast-MFC-AGG-ID: s7nbmAShM1icTDM7q_GDWg_1780389286
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CB91956095; Tue,  2 Jun 2026 08:34:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEFF118004A3; Tue,  2 Jun 2026 08:34:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5849621E6A01; Tue, 02 Jun 2026 10:34:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] qobject/json-writer: preallocate output buffer
In-Reply-To: <20260529023426.54680-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Fri, 29 May 2026 10:34:26 +0800")
References: <20260529023426.54680-1-guobin@linux.alibaba.com>
Date: Tue, 02 Jun 2026 10:34:43 +0200
Message-ID: <87ldcx5oik.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Bin Guo <guobin@linux.alibaba.com> writes:

> json_writer_new() creates the output GString with g_string_new(NULL),
> which starts at the GLib default of 64 bytes.  Serializing typical
> QMP responses then requires multiple reallocations as the buffer
> grows -- for query-qmp-schema the GString is reallocated 12+ times.

That's an extreme case.  Most responses are *much* smaller.  Still,
starting with a larger buffer makes sense.

> Preallocate JSON_WRITER_INITIAL_SIZE (4096) bytes.  This covers
> most QMP responses without any reallocation.  4096 is one page on
> most systems, which is efficient for the allocator.

I doubt "one page" matters.  How many QMP commands get executed in
practice?  A couple of hundred during startup, then tens per second?
Probably less than that.

>                                                      The JSONWriter
> is a short-lived object so the preallocation does not accumulate.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  qobject/json-writer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qobject/json-writer.c b/qobject/json-writer.c
> index aac2c6ab71..fb3f3f3e3c 100644
> --- a/qobject/json-writer.c
> +++ b/qobject/json-writer.c
> @@ -24,13 +24,16 @@ struct JSONWriter {
>      GByteArray *container_is_array;
>  };
>  
> +/* Covers most QMP responses without reallocation (one page) */

Covering most responses matters, one page does not.  Suggest

   /* Should cover most QMP responses without reallocation */

> +#define JSON_WRITER_INITIAL_SIZE  4096
> +
>  JSONWriter *json_writer_new(bool pretty)
>  {
>      JSONWriter *writer = g_new(JSONWriter, 1);
>  
>      writer->pretty = pretty;
>      writer->need_comma = false;
> -    writer->contents = g_string_new(NULL);
> +    writer->contents = g_string_sized_new(JSON_WRITER_INITIAL_SIZE);
>      writer->container_is_array = g_byte_array_new();
>      return writer;
>  }

Consider tweaking the commit message and the comment to address my
remarks.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


