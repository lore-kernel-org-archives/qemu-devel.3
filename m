Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9290CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 16:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v15hy-0007qE-L4; Tue, 23 Sep 2025 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v15hw-0007pr-3A
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v15ht-0004xX-3Z
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758644250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1lw66AvW4rnyYSxf9FaokMN1zJrTnzcZdfr7Mvew4w=;
 b=jBWjRBACpFrSC92k8hUZMDV3JoMvnE5tSHN+IWlEVfWBRNAB48rbuHqVdka0kddBt2kOGe
 R6FeDJdYRXzPKz4BUY+ZGrhx99q+SvyN+C2Vw16IV06ROk+d50io4dUJXYyyoudkzGTgiS
 9gHmuuxzC/eomDXo+Hc5d6l2xYj1ZHo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-VHMZJNN-P1eJNNNaSvYLVg-1; Tue, 23 Sep 2025 12:17:29 -0400
X-MC-Unique: VHMZJNN-P1eJNNNaSvYLVg-1
X-Mimecast-MFC-AGG-ID: VHMZJNN-P1eJNNNaSvYLVg_1758644248
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-84e6256b1c2so439128585a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 09:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758644248; x=1759249048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1lw66AvW4rnyYSxf9FaokMN1zJrTnzcZdfr7Mvew4w=;
 b=a6pxKvthLRZ5uAjXrnEvvQkpKG/w39PgJN1Uo+GkyelXjDUp+jt+Sy8u8e/owdQ9J8
 wk3TprRszCZi1AQjUKF+uOeXdudLvUiSCG3Rhxu02Owm5qvuX9TDkN/Hy8jrIaNfNq2A
 T40V+9Yl6+vkfaaSQF4hD66t9TO4oZHkQfEAwRUInk4HhxZJNCm9nRqaW1wBGsFvtZvU
 2mkYSKs3a+dUEScuW0K11LrMoR/4lzc3TSeJ8XIQKFtLHI03kXiBWm95FuJDIGZlUw0K
 HWFjVNTDNgdTJUwVqFA401otXxK+LzaChaUEUv7OKBXcTDNQ7Y4VNcdp1+wO3v4mv9Th
 y3hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyayXT17VSue78cN0kUG6tTxavsvgqIadD5TXowhBMJi/wZA52WJ99XqCWOfykNY5zR1oEUn0EqyOI@nongnu.org
X-Gm-Message-State: AOJu0Yw2T+gqKZ9o7U23k37SfcTfAv3L58FUnm+OxPS4uUCsGWNeLcrR
 mUDr9EBr21kJDslIA2eMrlNp1/zYMoPbO0upgSOE3ZXo2dK6TuOYGFQq369gJaUjtU9+YXjmmhr
 Y9yQZbRLvZrToWDsaZp+EB+0AwSA3iWhhhe/R2sMgVlQUVYNle42tx8zk
X-Gm-Gg: ASbGnct3RD335RXz57z3prW+C9Ogr+4ge1sNHq/hxeM4hVhNZ53sl+Jchb88J0j+csI
 A5bqD1wJ4mBs+faz5wHnmQQ47tTVnkOUVCGgjdPNJy1E13GDBsZWE7bPWE7DREK6deCzDE+rGJE
 iEOBVeItjF18OL6zY3XuBn7hHH/s6tcDTmlEA/RyBHuAK30NHDltRhqcNacnRwoG9AsgszplGcG
 ZxDTzBm+b3afF2B4bJsx5IKzBeMqwI1I74Y/Vv+6hvNw4qSMXSvixei0Js8xzlqD/q3sIEAf+ok
 XBzsyxR7Ux3vktFHwKwsFKuAvQrgMxB7
X-Received: by 2002:a05:620a:3710:b0:82e:ef43:38f0 with SMTP id
 af79cd13be357-8516024209fmr372148385a.0.1758644248064; 
 Tue, 23 Sep 2025 09:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkZCUQd0XfNr9/d0duWdZOErc4528MYH+Pju7/ol3JhjazkBeLJ9bpo9pgh2xoSXxfPWapw==
X-Received: by 2002:a05:620a:3710:b0:82e:ef43:38f0 with SMTP id
 af79cd13be357-8516024209fmr372143685a.0.1758644247393; 
 Tue, 23 Sep 2025 09:17:27 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-84a03114426sm390198085a.12.2025.09.23.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 09:17:26 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:17:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Message-ID: <aNLIFdBSwwyzQUXe@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
 <87plbmtmox.fsf@suse.de>
 <luoiumyvzjxtro6bd4vqn5mq6icf2zfic3n6shivb2e3ngkmcl@bz7vzg7xwdiq>
 <aNFwdic2-d_Crctc@x1.local>
 <jwyopauf2bjzkyrda7pgahmrbpkeb2te6przhuvtj5ue7odq55@nzgxjbl75mk6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwyopauf2bjzkyrda7pgahmrbpkeb2te6przhuvtj5ue7odq55@nzgxjbl75mk6>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 23, 2025 at 04:58:15PM +0200, Juraj Marcin wrote:
> On 2025-09-22 11:51, Peter Xu wrote:
> > On Mon, Sep 22, 2025 at 02:58:38PM +0200, Juraj Marcin wrote:
> > > Hi Fabiano,
> > > 
> > > On 2025-09-19 13:46, Fabiano Rosas wrote:
> > > > Juraj Marcin <jmarcin@redhat.com> writes:
> > > > 
> > > > Hi Juraj,
> > > > 
> > > > Good patch, nice use of migrate_has_failed()
> > > 
> > > Thanks!
> > > 
> > > > 
> > > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > >
> > > > > Currently, there are two functions that are responsible for cleanup of
> > > > > the incoming migration state. With successful precopy, it's the main
> > > > > thread and with successful postcopy it's the listen thread. However, if
> > > > > postcopy fails during in the device load, both functions will try to do
> > > > > the cleanup. Moreover, when exit-on-error parameter was added, it was
> > > > > applied only to precopy.
> > > > >
> > > > 
> > > > Someone could be relying in postcopy always exiting on error while
> > > > explicitly setting exit-on-error=false for precopy and this patch would
> > > > change the behavior incompatibly. Is this an issue? I'm willing to
> > > > ignore it, but you guys know more about postcopy.
> > > 
> > > Good question. When going through older patches where postcopy listen
> > > thread and then where exit-on-error were implemented, it seemed more
> > > like an overlook than intentional omission. However, it might be better
> > > to not break any potential users of this, we could add another option,
> > > "exit-on-postcopy-error" that would allow such handling if postscopy
> > > failed unrecoverably. I've already talked about such option with
> > > @jdenemar and he agreed with it.
> > 
> > The idea for postcopy ram is, it should never fail.. as failing should
> > never be better than a pause.  Block dirty bitmap might be different,
> > though, when enabled separately.
> > 
> > For postcopy-ram, qemu_loadvm_state_main() will in reality only receive RAM
> > updates. It'll almost always trigger the postcopy_pause_incoming() path
> > when anything fails.
> > 
> > For pure block-dirty-bitmap-only styled postcopy: for this exit-on-error, I
> > also don't think we should really "exit on errors", even if the flag is
> > set.  IIUC, it's not fatal to the VM if that failed, as described in:
> 
> I agree, however, this patch doesn't add any new cases in which the
> destination QEMU would exit. If there is an error in block dirty bitmaps
> it is only reported to the console, and then it continues to waiting for
> main_thread_load_event, marks the migration as COMPLETED and does the
> cleanup, same as before. [1] I can add a comment similar to "prevent
> further exit" as there was before.
> 
> However, if there is other error, in which the postcopy cannot pause
> (for example there was a failure in the main thread loading the device
> state before the machine started), the migration status changes to
> FAILED and jumps right to cleanup which then checks exit-on-error and
> optionally exits the QEMU, before it would always exit in such case [2]:
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/blob/ab8008b231e758e03c87c1c483c03afdd9c02e19/migration/savevm.c#L2120
> [2]: https://gitlab.com/qemu-project/qemu/-/blob/ab8008b231e758e03c87c1c483c03afdd9c02e19/migration/savevm.c#L2150

Ah, so you're saying an failure within qemu_loadvm_state_main() but during
POSTCOPY_INCOMING_LISTENING..  I think you're right.  It's possible.

In that case, exit-on-postcopy-error still sounds an overkill to me.  I
vote that we go ahead reusing exit-on-error for postcopy too. IIUC that's
what this current patch does as-is.

-- 
Peter Xu


