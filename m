Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C1EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfpX-0004Ly-KU; Tue, 16 Jul 2024 06:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTfpU-0004BR-Tp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTfpS-0004lW-QO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721127281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwQd4XW64C1P3zvoWBzW7Z/a91Rc/eaHeasg5mhOlgc=;
 b=FZM9XxlxAQRdTunQobLHaWp3B9MWbBrKmY9Bc7gOUrNYLIwhzpszXLOKWO1XWjCOPuYBYt
 HNeJ0dblhadZhWRp+9HQc7zb3OJTGCmk2MmA5ubmf2UEPBBFyWOiUdV9kZLP7wPR7M5NKE
 lZftHyaaMjx0U2b4HHNtAH2a7KZ4ioU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-YFue-F5kPuu9yEhR7QsoLw-1; Tue,
 16 Jul 2024 06:54:40 -0400
X-MC-Unique: YFue-F5kPuu9yEhR7QsoLw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 795961955D4C; Tue, 16 Jul 2024 10:54:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C9931955D42; Tue, 16 Jul 2024 10:54:32 +0000 (UTC)
Date: Tue, 16 Jul 2024 11:54:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>
Subject: Re: [PATCH v4 1/7] util: Introduce qemu_get_runtime_dir()
Message-ID: <ZpZRYyW74wfqR6Zr@redhat.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <20240716-run-v4-1-5f7a29631168@daynix.com>
 <ZpZC8AaUJH9WW6uF@redhat.com>
 <087e1eee-e7e3-4147-9c8c-882d458c1abd@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <087e1eee-e7e3-4147-9c8c-882d458c1abd@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 16, 2024 at 07:52:00PM +0900, Akihiko Odaki wrote:
> On 2024/07/16 18:53, Daniel P. Berrangé wrote:
> > On Tue, Jul 16, 2024 at 04:27:31PM +0900, Akihiko Odaki wrote:
> > > qemu_get_runtime_dir() returns a dynamically allocated directory path
> > > that is appropriate for storing runtime files. It corresponds to "run"
> > > directory in Unix.
> > > 
> > > With a tree-wide search, it was found that there are several cases
> > > where such a functionality is implemented so let's have one as a common
> > > utlity function.
> > > 
> > > A notable feature of qemu_get_runtime_dir() is that it uses
> > > $XDG_RUNTIME_DIR if available. While the function is often called by
> > > executables which requires root privileges, it is still possible that
> > > they are called from a user without privilege to write the system
> > > runtime directory. In fact, I decided to write this patch when I ran
> > > virtiofsd in a Linux namespace created by a normal user and realized
> > > it tries to write the system runtime directory, not writable in this
> > > case. $XDG_RUNTIME_DIR should provide a writable directory in such
> > > cases.
> > > 
> > > This function does not use qemu_get_local_state_dir() or its logic
> > > for Windows. Actually the implementation of qemu_get_local_state_dir()
> > > for Windows seems not right as it calls g_get_system_data_dirs(),
> > > which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
> > > "/usr/share", not "/var", which qemu_get_local_state_dir() is intended
> > > to provide. Instead, this function try to use the following in order:
> > > - $XDG_RUNTIME_DIR
> > > - LocalAppData folder
> > > - get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
> > > 
> > > This function does not use g_get_user_runtime_dir() either as it
> > > falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
> > > available. In the case, we rather use:
> > > get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Message-Id: <20230921075425.16738-2-akihiko.odaki@daynix.com>
> > > ---
> > >   include/qemu/osdep.h | 12 ++++++++++++
> > >   util/oslib-posix.c   | 11 +++++++++++
> > >   util/oslib-win32.c   | 26 ++++++++++++++++++++++++++
> > >   3 files changed, 49 insertions(+)
> > > 
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index 191916f38e6d..fe8609fc1375 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -670,6 +670,18 @@ void qemu_set_cloexec(int fd);
> > >    */
> > >   char *qemu_get_local_state_dir(void);
> > > +/**
> > > + * qemu_get_runtime_dir:
> > > + *
> > > + * Return a dynamically allocated directory path that is appropriate for storing
> > > + * runtime files. It corresponds to "run" directory in Unix, and uses
> > > + * $XDG_RUNTIME_DIR if available.
> > > + *
> > > + * The caller is responsible for releasing the value returned with g_free()
> > > + * after use.
> > > + */
> > > +char *qemu_get_runtime_dir(void);
> > > +
> > >   /**
> > >    * qemu_getauxval:
> > >    * @type: the auxiliary vector key to lookup
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index e76441695bdc..9599509a9aa7 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -278,6 +278,17 @@ qemu_get_local_state_dir(void)
> > >       return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
> > >   }
> > > +char *
> > > +qemu_get_runtime_dir(void)
> > > +{
> > > +    char *env = getenv("XDG_RUNTIME_DIR");
> > > +    if (env) {
> > > +        return g_strdup(env);
> > > +    }
> > > +
> > > +    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
> > > +}
> > 
> > I'm not convinced this is the correct logic to be following.
> > 
> > In the cover letter you mention not using g_get_user_runtime_dir()
> > because it falls back to XDG_CACHE_HOME, and we need to fallback
> > to LOCALSTATEDIR/run. This is not right for normal users though,
> > where falling back to LOCALSTATEDIR/run is always wrong, as it
> > won't be writable - the g_get_user_runtime_dir() fallback is
> > desirable for non-root users.
> 
> It also checks LocalAppData, which should be usually available.
> 
> g_get_user_runtime_dir() is not a proper fallback in case neither of
> XDG_RUNTIME_DIR and LocalAppData are available. g_get_user_cache_dir(),
> which gets called by g_get_user_runtime_dir(), internally uses:
> - XDG_CACHE_HOME or
> - FOLDERID_InternetCache
> 
> g_get_user_cache_dir() just returns NULL if neither of them is available.
> 
> We can't expect XDG_CACHE_HOME is present when XDG_RUNTIME_DIR is missing.
> FOLDERID_InternetCache points to %LOCALAPPDATA%\Microsoft\Windows\Temporary
> Internet Files, according to:
> https://learn.microsoft.com/en-us/windows/win32/shell/knownfolderid
> 
> So we can't expect FOLDERID_InternetCache is available when LocalAppData is
> missing.

XDG_CACHE_HOME isn't required to be present. Glib will use a fallback
location if XDG_CACHE_HOME isn't set, and it will mkdir() the location
if it doesn't exist.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


