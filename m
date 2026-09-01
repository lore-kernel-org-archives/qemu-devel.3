Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C6FC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1H9W-0006QI-9S; Tue, 01 Sep 2026 01:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1H9U-0006QA-S7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1H9T-00081y-Bh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788240917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YqkQTr3q2Nnn463NYqyMnOUN5oHEEop77o8k/m/NlOE=;
 b=Progg5+GtXyWGvvVQWxVcoV66YAi1PsHa4m7AKuQ34SeZW9LzdluL0PqE278Orm19COTHA
 067qpdVYJw8nya1NmO7Li7Ps/1420JN9GlvBpcCDEaN2CBrqc4+3FYMWQVSxSO6PDPKgKN
 NcZWtyIgRZ1sQy6z4hYaL4/bsO3UV4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-b4iW4058NGSDes7PQVYxzw-1; Tue,
 01 Sept 2026 01:35:14 -0400
X-MC-Unique: b4iW4058NGSDes7PQVYxzw-1
X-Mimecast-MFC-AGG-ID: b4iW4058NGSDes7PQVYxzw_1788240913
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15D2718417F6; Tue,  1 Sep 2026 05:35:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAA4530002F5; Tue,  1 Sep 2026 05:35:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23BCA21E6837; Tue, 01 Sep 2026 07:35:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V14 14/15] iothread: remove legacy
 iothread_get_aio_context()
In-Reply-To: <20260831160038.221776-15-zhangckid@gmail.com> (Zhang Chen's
 message of "Tue, 1 Sep 2026 00:00:35 +0800")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-15-zhangckid@gmail.com>
Date: Tue, 01 Sep 2026 07:35:10 +0200
Message-ID: <877bl5bkkx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> All production callers have migrated to either the holder-tracking
> iothread_ref_and_get_aio_context() API or the explicitly unsafe legacy
> accessor. Remove the now-unused ambiguous getter.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h | 1 -
>  iothread.c                | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index 2ef8c1a1bb..9850cdb3dc 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -66,7 +66,6 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
> -AioContext *iothread_get_aio_context(IOThread *iothread);
>  
>  /*
>   * Return @iothread's AioContext without registering a holder or taking a
> diff --git a/iothread.c b/iothread.c
> index 803d6ce3c3..3a092119ee 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -422,11 +422,6 @@ char *iothread_get_id(IOThread *iothread)
>      return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
>  }
>  
> -AioContext *iothread_get_aio_context(IOThread *iothread)
> -{
> -    return iothread->ctx;
> -}
> -
>  AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
>                                               const IOThreadHolder *holder)
>  {

Easier, I think: squash PATCH 04 into this one.  Turns "add copy of old
function, change a caller to the copy, then delete old function eight
patches later" into "rename function to mark it unsafe".


