Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJvX-0007lH-Ko; Tue, 21 Oct 2025 17:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJvW-0007l7-3f
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBJvS-0005xA-QS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761082189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AyRA5FQFX7yFYw9r8Yv+oYls0INmJmyVHA+nIxj6+eI=;
 b=K8LVYZRW/uxRsUjDnNECyApI0qnz5VoA2V4DfUYrEP5AiPXDrGDlq9pjRiQWfz6zPkvaGM
 WDXqGyVWmf15VdE+EC9xdWYMgg0fmJmQeIb5Hcz1wbz98+iYJQMFer/D+JHzqp2AV2xjP/
 F36rOngs0fl2LCuFniV05cYc9trNwKU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-EXZwtBVMM5m8QOw97IWzwg-1; Tue, 21 Oct 2025 17:29:47 -0400
X-MC-Unique: EXZwtBVMM5m8QOw97IWzwg-1
X-Mimecast-MFC-AGG-ID: EXZwtBVMM5m8QOw97IWzwg_1761082187
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87df30d45ecso31743136d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761082186; x=1761686986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AyRA5FQFX7yFYw9r8Yv+oYls0INmJmyVHA+nIxj6+eI=;
 b=NPYcaqzGINnAfu0ea61LAs7fSjvKfaJadb33u0KIJvqK4iBZbDbU+Y//GyliTlxa8X
 qst1R3fu3XssyBECpVU0dT12GAy7R4nQ+infrITvoeo8aOfA1auPzvVWb9Dg7xLr7pqh
 VRsL5Tej7wkXKgRPy2fM3En1UHcosphDCmotRqK146vEl3vpC88h3XWsIE5ETkB9wnoC
 KFo/A4lQdFQWW/9Vwqh1HR5im1RtsP3S7Ysj6L+rgCqSMxUceTOJQwQPRfaDMR5vtJz4
 vffSsk8FjGLgByw4JniIZQDjrcrMn+0GRvSMvFuGcsQDYW4DTpjABPUXQI7iSCPC27aw
 UZ4Q==
X-Gm-Message-State: AOJu0YxIoKdWdQjhNo00aZJ1i3gEmZutObR9bjGFywkzkEnqSwXz4uLL
 WLU0jnAmGr7NxMUhLC/FBqPAXOP5/VgkUO0s3cbwIdnEn5CFDvCHCpnXQN2UiUbTg/Sk0qXBjj7
 s08KggvGJLWCK+KdwDQndxfBml8dABexuxdzrUvwO3WwNabW0QSrsBYsW1OICcSN9
X-Gm-Gg: ASbGncsLh/+TGmAt6wUzQyQIVaBL9CI8Xvr6Hm+74t7eQHSjDP0aNZ7I0db4BKvsToS
 iicfEwdbLNEp55NQqHgMTY00H+G6XHsRgJkzm17nZNxmn5QJhmqjUgI5Z4ON0XKAaSplGu51czU
 Md2iUjZrc2+mzm0TXDHQcM/NgdGKcEmBRVRvtaA/cKXM7JMd+981IlDkgzCOhEbUkYwn0e1Q63+
 IkxD+yrqVghsZnZncfhBGIK08YPoSPcsuecTnPka0atGYS+LtoJ0B0XWtP/8suw818hYzXiRfdK
 IsZX16dG+NuS+V4X773qTIV99eu68jVAkds1PEwwwBmt6Ob3wwpyS6R6B8WMo8rMt8k=
X-Received: by 2002:ad4:5c45:0:b0:87c:124b:7750 with SMTP id
 6a1803df08f44-87c20566b16mr230997866d6.21.1761082186491; 
 Tue, 21 Oct 2025 14:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6XY1vndS6/XrHWeET7vrZn20PUlyqEViDfT2QYFSX6J/UrTHNOfW6Vv8nNAmtIbGE+zTy7w==
X-Received: by 2002:ad4:5c45:0:b0:87c:124b:7750 with SMTP id
 6a1803df08f44-87c20566b16mr230997616d6.21.1761082185893; 
 Tue, 21 Oct 2025 14:29:45 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02892e79sm75609756d6.40.2025.10.21.14.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 14:29:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:29:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Arun Menon <armenon@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
Message-ID: <aPf7R-F0uv1RSqXh@x1.local>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-3-peterx@redhat.com>
 <87o6q0t1z0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6q0t1z0.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 21, 2025 at 05:49:07PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Per reported and analyzed by Peter:
> >
> > https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com
> >
> > mfd leak is a false positive, try to use a coverity annotation (which I
> > didn't find manual myself, but still give it a shot).
> >
> > Fix the other one by dumping an error message if setenv() failed.
> >
> > Resolves: Coverity CID 1641391
> > Resolves: Coverity CID 1641392
> > Fixes: efc6587313 ("migration: cpr-exec save and load")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/cpr-exec.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > index d57714bc5d..3cf44634a9 100644
> > --- a/migration/cpr-exec.c
> > +++ b/migration/cpr-exec.c
> > @@ -43,13 +43,16 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
> >  void cpr_exec_persist_state(QEMUFile *f)
> >  {
> >      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> > +    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
> >      int mfd = dup(fioc->fd);
> >      char val[16];
> >  
> >      /* Remember mfd in environment for post-exec load */
> >      qemu_clear_cloexec(mfd);
> >      snprintf(val, sizeof(val), "%d", mfd);
> > -    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
> > +    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
> > +        error_report("Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
> > +    }
> 
> Best to abort no? We don't want the rest of the code reading whatever
> may be at that env variable and running with it.

I didn't want to abort, because it's the same as QMP migrate failure at the
beginning.

If we want to do better, we can allow this function to return a failure
instead.

And.. when I was trying cpr-exec with no argv it already can crash QEMU.  I
think that's also a bug.

Let me prepare something better than this..  I'll likely add a new patch to
fix that too.

> 
> >  }
> >  
> >  static int cpr_exec_find_state(void)
> 

-- 
Peter Xu


