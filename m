Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B482BCA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzx4-0002Qg-79; Fri, 30 Aug 2024 07:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzx3-0002QD-E4
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjzx1-0000fp-9X
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725017878;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3X8fjKmIYuQzjY3t9BsODEAEaRNiip9ABd5gQ3Mg1c=;
 b=J5s6Kol1fjZ0jOeMMU/WBSXO8gy7lKpaEfqwIqw9FrLB6Xc+e3A1iBYGG5RxVlavETnRSr
 8DjElf8z9zPCtcK0HftXdymki4EvgllaYtrg+/GkTtOznbOCGJQT+44Vd6iN31M9jFcCW0
 b3p0FYXxsZA0NnQgTG9l5s+IPOLs1io=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-pafCGh8COsO3u8xvRogGDg-1; Fri,
 30 Aug 2024 07:37:56 -0400
X-MC-Unique: pafCGh8COsO3u8xvRogGDg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 300201954B34; Fri, 30 Aug 2024 11:37:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFDC019560A3; Fri, 30 Aug 2024 11:37:50 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:37:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 15/35] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <ZtGvCzgqN9SksvFp@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-16-thuth@redhat.com>
 <3a435391-f485-4223-93aa-b937a141db16@linaro.org>
 <2e2c6480-8a43-4606-b500-2e60bf583d00@redhat.com>
 <f126030e-faf9-429e-957d-db503f7e5e33@redhat.com>
 <ZtBKR205LUm9qvgu@redhat.com>
 <c6d6f31d-d507-437f-9f7e-7857ed415fea@redhat.com>
 <ZtF366lfxm1gNR_Z@redhat.com>
 <aa7edbf3-d615-4f00-9e5f-2c675fa3a01c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa7edbf3-d615-4f00-9e5f-2c675fa3a01c@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 30, 2024 at 01:27:15PM +0200, Thomas Huth wrote:
> On 30/08/2024 09.42, Daniel P. Berrangé wrote:
> > On Fri, Aug 30, 2024 at 09:38:17AM +0200, Thomas Huth wrote:
> > > On 29/08/2024 12.15, Daniel P. Berrangé wrote:
> > > > On Tue, Aug 27, 2024 at 04:24:59PM +0200, Thomas Huth wrote:
> > > > > On 27/08/2024 15.16, Thomas Huth wrote:
> > > > > > On 23/08/2024 09.28, Philippe Mathieu-Daudé wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On 21/8/24 10:27, Thomas Huth wrote:
> > > > > > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > > > > > > 
> > > > > > > > Many tests need to access assets stored on remote sites. We don't want
> > > > > > > > to download these during test execution when run by meson, since this
> > > > > > > > risks hitting test timeouts when data transfers are slow.
> > > > > > > > 
> > > > > > > > Add support for pre-emptive caching of assets by setting the env var
> > > > > > > > QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> > > > > > > > instead of running the test, the assets will be downloaded and saved
> > > > > > > > to the cache, then the timestamp file created.
> > > ...
> > > > > > > 
> > > > > > > When using multiple jobs (-jN) I'm observing some hangs,
> > > > > > > apparently multiple threads trying to download the same file.
> > > > > > > The files are eventually downloaded successfully but it takes
> > > > > > > longer. Should we acquire some exclusive lock somewhere?
> > > > > > 
> > > > > > I haven't seen that yet ... what did you exactly run? "make
> > > > > > check-functional -jN" ? Or "make check-functional-<target> -jN" ?
> > > > > 
> > > > > After applying some of your patches, I think I've run now into this problem,
> > > > > too: It's because test_aarch64_sbsaref.py and test_aarch64_virt.py try to
> > > > > download the same asset in parallel (alpine-standard-3.17.2-aarch64.iso).
> > > > > 
> > > > > Daniel, any ideas how to fix this in the Asset code?
> > > > 
> > > > So when downloading we open a file with a ".download" suffix, write to
> > > > that, and then rename it to the final filename.
> > > > 
> > > > If we have concurrent usage, both will open the same file and try to
> > > > write to it. Assuming both are downloading the same content we would
> > > > probably "get lucky" and have a consistent file at the end, but clearly
> > > > it is bad to rely on luck.
> > > > 
> > > > The lame option is to use NamedTemporaryFile for the teporary file.
> > > > This ensures both processes will write to different temp files, and
> > > > the final rename is atomic. This guarantees safety, but still has
> > > > the double download penalty.
> > > > 
> > > > The serious option is to use fcntl.lockf(..., fcntl.LOCK_EX) on the
> > > > temp file. If we can't acquire the lock then just immediately close
> > > > the temp file (don't delete it) and assume another thread is going to
> > > > finish its download.
> > > > 
> > > > On windows  we'll need msvcrt.locking(..., msvcrt.LK_WLCK, ...)
> > > > instead of fcntl.
> > > 
> > > While looking for portable solutions, I noticed that newer versions
> > > of Python have a "x" mode for creating files only if they do not
> > > exist yet. So I think something like this could be a solution:
> > > 
> > > @@ -71,17 +72,26 @@ def fetch(self):
> > >           tmp_cache_file = self.cache_file.with_suffix(".download")
> > >           try:
> > > -            resp = urllib.request.urlopen(self.url)
> > > +            with tmp_cache_file.open("xb") as dst:
> > > +                with urllib.request.urlopen(self.url) as resp:
> > > +                    copyfileobj(resp, dst)
> > > +        except FileExistsError:
> > > +            # Another thread already seems to download this asset,
> > > +            # so wait until it is done
> > > +            self.log.debug("%s already exists, waiting for other thread to finish...",
> > > +                           tmp_cache_file)
> > > +            i = 0
> > > +            while i < 600 and os.path.exists(tmp_cache_file):
> > > +                sleep(1)
> > > +                i += 1
> > > +            if os.path.exists(self.cache_file):
> > > +                return str(self.cache_file)
> > > +            raise
> > >           except Exception as e:
> > >               self.log.error("Unable to download %s: %s", self.url, e)
> > > -            raise
> > > -
> > > -        try:
> > > -            with tmp_cache_file.open("wb+") as dst:
> > > -                copyfileobj(resp, dst)
> > > -        except:
> > >               tmp_cache_file.unlink()
> > >               raise
> > > +
> > >           try:
> > >               # Set these just for informational purposes
> > >               os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> > > 
> > > What do you think, does it look reasonable?
> > 
> > The main risk with this, as opposed to fcntl locking, is that it is not
> > crash-safe. If a download is interrupted, subsequent cache runs will
> > wait for a process that doesn't exist to finish downloading and then
> > raise an exception, requiring manual user cleanup of the partial
> > download.
> > 
> > Perhaps if we see the tmp_cache_file, and it doesn't change in size
> > after N seconds, we could force unlink it, and create a new download,
> > so we gracefully recover ?
> 
> Sounds like a plan ... does this look acceptable:
> 
> @@ -70,18 +71,52 @@ def fetch(self):
>          self.log.info("Downloading %s to %s...", self.url, self.cache_file)
>          tmp_cache_file = self.cache_file.with_suffix(".download")
> 
> -        try:
> -            resp = urllib.request.urlopen(self.url)
> -        except Exception as e:
> -            self.log.error("Unable to download %s: %s", self.url, e)
> -            raise
> +        for retries in range(3):
> +            try:
> +                with tmp_cache_file.open("xb") as dst:
> +                    with urllib.request.urlopen(self.url) as resp:
> +                        copyfileobj(resp, dst)
> +                break
> +            except FileExistsError:
> +                # Another thread already seems to download this asset,
> +                # so wait until it is done
> +                self.log.debug("%s already exists, "
> +                               "waiting for other thread to finish...",
> +                               tmp_cache_file)
> +                try:
> +                    current_size = tmp_cache_file.stat().st_size
> +                    new_size = current_size
> +                except:
> +                    if os.path.exists(self.cache_file):
> +                        return str(self.cache_file)
> +                    raise
> +                waittime = lastchange = 600
> +                while waittime > 0:
> +                    sleep(1)
> +                    waittime -= 1
> +                    try:
> +                        new_size = tmp_cache_file.stat().st_size
> +                    except:
> +                        if os.path.exists(self.cache_file):
> +                            return str(self.cache_file)
> +                        raise
> +                    if new_size != current_size:
> +                        lastchange = waittime
> +                        current_size = new_size
> +                    elif lastchange - waittime > 90:
> +                       self.log.debug("%s seems to be stale ... "
> +                                      "deleting and retrying download...",
> +                                      tmp_cache_file)
> +                       tmp_cache_file.unlink()
> +                       break
> +                if waittime > 0:
> +                    continue
> +                raise
> +            except Exception as e:
> +                self.log.error("Unable to download %s: %s", self.url, e)
> +                tmp_cache_file.unlink()
> +                raise
> 
> -        try:
> -            with tmp_cache_file.open("wb+") as dst:
> -                copyfileobj(resp, dst)
> -        except:
> -            tmp_cache_file.unlink()
> -            raise
>          try:
>              # Set these just for informational purposes
>              os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> 
> ?
> 
> I tried it with a stale file in my cache, and it seems to work - after 90
> seconds, one of the threads is properly trying to redownload the file.

Yeah, I think that'll work ok 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


