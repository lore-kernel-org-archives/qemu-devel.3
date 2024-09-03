Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202F0CD342A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVLZ-0004y0-4R; Tue, 03 Sep 2024 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1slVLY-0004xX-Ev
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1slVLW-00036C-6i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725376888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WbUQoRRWmMI0SMvAnR2u4IjbgkZrzicErmC6r/9Cj4=;
 b=MgdPjULRIEVmmC6O+79+izZBOlnZmydmSqS7TIEiLT7es7fym8hcHv9JVQfZjuZ/gzXUkL
 W7B2Erb/WCg6lca0ymkwp/OUeJn0D5uzsuHqnLHzed/OESRi9G/VY4gDLsR+crVe7DP7PB
 6XFT1BMkVXKKo6s/ZcPY7thxovunhBU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-v7M7woMEPtScDT2gzGsdWQ-1; Tue,
 03 Sep 2024 11:21:24 -0400
X-MC-Unique: v7M7woMEPtScDT2gzGsdWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B184190F99C; Tue,  3 Sep 2024 15:21:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 446C719560AE; Tue,  3 Sep 2024 15:21:19 +0000 (UTC)
Date: Tue, 3 Sep 2024 16:21:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] qemu/osdep: handle sysconf(_SC_OPEN_MAX) return
 value == -1
Message-ID: <ZtcpbNx0SAzzW0Ta@redhat.com>
References: <20240830111451.3799490-1-cleger@rivosinc.com>
 <20240830111451.3799490-3-cleger@rivosinc.com>
 <de7b12a3-7480-41b9-837a-880da9264dea@tls.msk.ru>
 <dd28ea4f-67eb-4c42-84d2-24956cde7896@rivosinc.com>
 <294a5480-d871-41e2-8e08-c1067f45d454@linaro.org>
 <563f3b75-bf13-4ca7-a995-f2c8ff1b6799@rivosinc.com>
 <7e405b99-50b4-4c87-a9b6-83c90110eca5@linaro.org>
 <313c9a55-4cc8-4beb-a483-c0202665b226@rivosinc.com>
 <b9b574e7-11de-4f04-a84f-40b9ffac986c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9b574e7-11de-4f04-a84f-40b9ffac986c@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Sep 03, 2024 at 05:02:44PM +0200, Philippe Mathieu-Daudé wrote:
> On 3/9/24 15:37, Clément Léger wrote:
> > On 03/09/2024 15:34, Philippe Mathieu-Daudé wrote:
> > > On 3/9/24 09:53, Clément Léger wrote:
> > > > On 02/09/2024 21:38, Philippe Mathieu-Daudé wrote:
> > > > > On 30/8/24 13:57, Clément Léger wrote:
> > > > > > On 30/08/2024 13:31, Michael Tokarev wrote:
> > > > > > > 30.08.2024 14:14, Clément Léger wrote:
> > > > > > > > On some systems (MacOS for instance), sysconf(_SC_OPEN_MAX) can
> > > > > > > > return
> > > > > > > > -1. In that case we should fallback to using the OPEN_MAX define.
> > > > > > > > According to "man sysconf", the OPEN_MAX define should be present and
> > > > > > > > provided by either unistd.h and/or limits.h so include them for that
> > > > > > > > purpose. For other OSes, just assume a maximum of 1024 files
> > > > > > > > descriptors
> > > > > > > > as a fallback.
> > > > > > > > 
> > > > > > > > Fixes: 4ec5ebea078e ("qemu/osdep: Move close_all_open_fds() to oslib-
> > > > > > > > posix")
> > > > > > > > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > > > > Signed-off-by: Clément Léger <cleger@rivosinc.com>
> > > > > > > 
> > > > > > > Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> > > > > > > 
> > > > > > > > @@ -928,6 +933,13 @@ static void
> > > > > > > > qemu_close_all_open_fd_fallback(const
> > > > > > > > int *skip, unsigned int nskip,
> > > > > > > >      void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
> > > > > > > >      {
> > > > > > > >          int open_max = sysconf(_SC_OPEN_MAX);
> > > > > > > > +    if (open_max == -1) {
> > > > > > > > +#ifdef CONFIG_DARWIN
> > > > > > > > +        open_max = OPEN_MAX;
> > > > > 
> > > > > Missing errno check.
> > > > 
> > > > man sysconf states that:
> > > > 
> > > > "On error, -1 is returned and errno is set to indicate the error (for
> > > > example, EINVAL, indicating that name is invalid)."
> > > > 
> > > > So it seems checking for -1 is enough no ? Or were you thinking about
> > > > something else ?
> > > 
> > > Mine (macOS 14.6) is:
> > > 
> > >   RETURN VALUES
> > >       If the call to sysconf() is not successful, -1 is returned and
> > >       errno is set appropriately.  Otherwise, if the variable is
> > >       associated with functionality that is not supported, -1 is
> > >       returned and errno is not modified.  Otherwise, the current
> > >       variable value is returned.
> > 
> > Which seems to imply the same than mine right ? -1 is always returned in
> > case of error and errno might or not be set. So checking for -1 seems
> > enough to check an error return.
> 
> Yes but we can check for the unsupported case. Something like:
> 
>     long qemu_sysconf(int name, long unsupported_default)
>     {
>         int current_errno = errno;
>         long retval;
> 
>         retval = sysconf(name);
>         if (retval == -1) {
>             if (errno == current_errno) {
>                 return unsupported_default;
>             }
>             perror("sysconf");
>             return -1;
>         }
>         return retval;
>     }

That looks uncessarily complicated, and IMHO makes it less
portable. eg consider macOS behaviour:

 "if the variable is associated with functionality that is
  not supported, -1 is returned and errno is not modified"

vs Linux documented behaviour:

  "If name corresponds to a maximum or minimum limit, and
   that limit is indeterminate, -1 is returned and errno
   is  not  changed."

IMHO we should do what Clément already suggested and set a
default anytime retval == -1, and ignore errno. There is
no user benefit from turning errnos into a fatal error
via perror()

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


