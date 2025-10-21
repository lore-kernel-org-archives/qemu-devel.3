Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E110CCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEly-0005HD-T5; Tue, 21 Oct 2025 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBElj-00058n-AG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBElb-0008CY-1o
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761062353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnO8YVQo5sXjYRrz3znPcdceLNpP0ZhJ4rfrmcJXm1E=;
 b=O3MtH0WlSuPz3ZAukBeO2YeTE93s8fMsYwxWoIPwiNQ+lvCSGMVaOwez0xOvcP8kLr2XIj
 GdWyABZNYwekNl+VgXpTTxAQyennxSB028bvS3wlNnhPaUWktM4FtKrX1JW54I/CtubWtL
 yDCX16nD/WmcemWD6zVONHqqBiSrabY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-hj8D9OSdOhyprVKrmnp8aw-1; Tue, 21 Oct 2025 11:59:12 -0400
X-MC-Unique: hj8D9OSdOhyprVKrmnp8aw-1
X-Mimecast-MFC-AGG-ID: hj8D9OSdOhyprVKrmnp8aw_1761062352
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8787a94467cso227133306d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062352; x=1761667152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnO8YVQo5sXjYRrz3znPcdceLNpP0ZhJ4rfrmcJXm1E=;
 b=M8govfDlMgrIVUMhO58OoX9Sk5by5wFsaAilOYtRe8tS8vPuJgd4T9UJcOXQomAoIT
 wpNQ+xtvHdup3R7Cp78BIWcxvEl5eNH7Khiut5OwmIavV42f+FQiERzKtCmg7tBlUxwE
 w0UJ6TIMajKeAnJP3/SJpXOL503E+Q0TEyK9FfF2Hrf0A5TeIFwh2L1v8TTIblD5JTPC
 fHuRi/u9IDXz+gQCBa3kD7wqFq13wyBZbUZhJWSFkEOo/0Mz29mBIxXwRacxOU3q6Q5K
 1+r24oPXL8Ax8G8Sz8lDsOOxwHDAYDcRXJXR5gf3n9oQmJ2WrQOxtFOah3uENuBvGlbI
 WDtw==
X-Gm-Message-State: AOJu0YxRUryv3XRIhh64921fK9DdwZuDzWBmi1FXcHm6H2hKvMYFrMli
 KS3LNtOmKb7g7HVHCHeKo65MP7/3SNhd6NSMQsy1sODiDVi2c5Srwn7etvjrxRj28aQh2GBDy5A
 lP4ORkCA8Ot5qiKIrD7PtiwVh4ILj8Bb7nPxonMgJtEsd7sXNnqTLPEusKDAcYecg
X-Gm-Gg: ASbGncvjl5dn6APT8j4DZl9n93r429Tplz/mEBzsoEwAZnobeONc7KBvEZws/xU7vO1
 31hn3I7xqROsxxDaZqRouzeXMow/uJCWEP+0P4SfI+hLwdzB8SvwZHk9f1Qn1/Qms5KxeB8FSiT
 h0IupgvJLrV2N1BG2jiTWl+Dt2wT/OaVUpiQEg/D4yu0L+6RSVlkJVyz1TOqb2wf+DrfgUc0oWl
 4MM7RKAcxfbs82HzAQG9dDwIiyM07oTCzXr5LLLwK0X4Uf6lNrtauEC7GlLMC/XVvxD/b9rbDy5
 7TnNCu2zcXtjltziyE3nucQfCjCgc6GeWxa5QsF9RJLxJ8EWfa2FY/tCFnQQjJEfjvY=
X-Received: by 2002:ad4:5cc1:0:b0:7ef:f440:2b40 with SMTP id
 6a1803df08f44-87c20817f04mr216863666d6.53.1761062351625; 
 Tue, 21 Oct 2025 08:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrk8lTodkYMfkdFUBJL/FgmS70MQXDlBI76VTYqBC4yA7VQajKcMHee7yVma1lE6mgXZ8N3w==
X-Received: by 2002:ad4:5cc1:0:b0:7ef:f440:2b40 with SMTP id
 6a1803df08f44-87c20817f04mr216863396d6.53.1761062351176; 
 Tue, 21 Oct 2025 08:59:11 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028932d3sm71192476d6.41.2025.10.21.08.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:59:10 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:59:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 42/45] migration: cpr-exec mode
Message-ID: <aPetzFnweUu8cxEw@x1.local>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-43-peterx@redhat.com>
 <CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com>
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

On Tue, Oct 21, 2025 at 04:34:32PM +0100, Peter Maydell wrote:
> On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
> >
> > From: Steve Sistare <steven.sistare@oracle.com>
> >
> > Add the cpr-exec migration mode.  Usage:
> >   qemu-system-$arch -machine aux-ram-share=on ...
> >   migrate_set_parameter mode cpr-exec
> >   migrate_set_parameter cpr-exec-command \
> >     <arg1> <arg2> ... -incoming <uri-1> \
> >   migrate -d <uri-1>
> 
> Hi; Coverity complains about this code (CID 1641397):
> 
> > +static void cpr_exec_cb(void *opaque)
> > +{
> > +    MigrationState *s = migrate_get_current();
> > +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
> > +    Error *err = NULL;
> > +
> > +    /*
> > +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> > +     * earlier because they should not persist across miscellaneous fork and
> > +     * exec calls that are performed during normal operation.
> > +     */
> > +    cpr_exec_preserve_fds();
> > +
> > +    trace_cpr_exec();
> > +    execvp(argv[0], argv);
> > +
> > +    /*
> > +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
> > +     * or the system is very short on resources.
> > +     */
> > +    g_strfreev(argv);
> 
> Here we free the argv array...
> 
> > +    cpr_exec_unpreserve_fds();
> > +
> > +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
> 
> ...but here we read from the freed memory argv[0].
> 
> Presumably we can just move the free down a bit ?

Yep, will change this to:

    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
    g_clear_pointer(&argv, g_strfreev);

-- 
Peter Xu


