Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF5C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoYS-0005s0-QO; Wed, 21 Feb 2024 10:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoNM-0006Nd-JC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcitP-0003Ab-5x
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708507674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgCoAvodRLVzHJkgildrLHAc/XRACmSJVVWSYWw3g44=;
 b=cyGEFNsrmUwcB/yn8D0xrB3MFfBHE/xran4Ar84eJkLZQ/fIoCRAqX5WppdriQmVC46y3b
 kKTIjyb0Rk52XHTNLuqOp7+mb99b5sjAlEdkqrdxIjCZvbxOF0sEGdG1j0AqM6xHylRbnK
 Ydc6xDGLHtnijrTIjcvdcEmOrrn5jSw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-_MkwwRkmMkm-fha1rgxBBA-1; Wed,
 21 Feb 2024 04:27:50 -0500
X-MC-Unique: _MkwwRkmMkm-fha1rgxBBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 159A538143AF;
 Wed, 21 Feb 2024 09:27:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E64B240C94A7;
 Wed, 21 Feb 2024 09:27:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9D1321E6740; Wed, 21 Feb 2024 10:27:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 32/34] monitor: fdset: Match against O_DIRECT
In-Reply-To: <20240220224138.24759-33-farosas@suse.de> (Fabiano Rosas's
 message of "Tue, 20 Feb 2024 19:41:36 -0300")
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-33-farosas@suse.de>
Date: Wed, 21 Feb 2024 10:27:48 +0100
Message-ID: <878r3exj3f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> We're about to enable the use of O_DIRECT in the migration code and
> due to the alignment restrictions imposed by filesystems we need to
> make sure the flag is only used when doing aligned IO.
>
> The migration will do parallel IO to different regions of a file, so
> we need to use more than one file descriptor. Those cannot be obtained
> by duplicating (dup()) since duplicated file descriptors share the
> file status flags, including O_DIRECT. If one migration channel does
> unaligned IO while another sets O_DIRECT to do aligned IO, the
> filesystem would fail the unaligned operation.
>
> The add-fd QMP command along with the fdset code are specifically
> designed to allow the user to pass a set of file descriptors with
> different access flags into QEMU to be later fetched by code that
> needs to alternate between those flags when doing IO.
>
> Extend the fdset matching function to behave the same with the
> O_DIRECT flag.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  monitor/fds.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/monitor/fds.c b/monitor/fds.c
> index 9a28e4b72b..42bf3eb982 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -413,6 +413,12 @@ static bool monitor_fdset_flags_match(int flags, int fd_flags)
   static bool monitor_fdset_flags_match(int flags, int fd_flags)
   {
       bool match = false;
   
>      if ((flags & O_ACCMODE) == (fd_flags & O_ACCMODE)) {
>          match = true;
> +
> +#ifdef O_DIRECT
> +        if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
> +            match = false;
> +        }
> +#endif
>      }
>  
>      return match;
   }

I'd prefer something like

   static bool monitor_fdset_flags_match(int flags, int fd_flags)
   {
   #ifdef O_DIRECT
       if ((flags & O_DIRECT) != (fd_flags & O_DIRECT)) {
           return false;
       }
   #endif

       if ((flags & O_ACCMODE) != (fd_flags & O_ACCMODE)) {
           return false;

       }

       return true;
   }


