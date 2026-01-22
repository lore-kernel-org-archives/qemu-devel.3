Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E546AC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virj3-0008Jb-QE; Thu, 22 Jan 2026 05:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viriy-0008IY-L9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1viriu-0008MU-NZ
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769076929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rlEAygC1h9mczR1y0+mi8VH3UsiAelRgmF+YEFh3nM=;
 b=Lj7+LXcXoznypvz0EC8z9HGGbknlOA6N+6WHCcPOiYykHM/Y/fOUTr0J67d+a4XVDHYM5a
 3W3JhG7a2+RH0MtR/NfXiEd+rbVJ8XbBMVvRTCWXEbpdvs+dacW0/ulvcQMJOAJRIpHUk9
 P+9biwN/wk+K2OtjHmtHoQzXOdkDsWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-cX8whe-qNTCbd-NwToqu5A-1; Thu, 22 Jan 2026 05:15:28 -0500
X-MC-Unique: cX8whe-qNTCbd-NwToqu5A-1
X-Mimecast-MFC-AGG-ID: cX8whe-qNTCbd-NwToqu5A_1769076927
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso6165375e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769076927; cv=none;
 d=google.com; s=arc-20240605;
 b=SdLB5NDDORYkuIpKGNckM79uvKgHFjEeZAcyS12i20wIewJthZUdI14hQDZvoQ3RjO
 XOOljBtVd4obY/bGyoBWXCwvSiZBgFj+IzyCgWGOYQ3wg3i+DdbLHXjQ9u4xafWvmkpg
 iRP0weaofRFuD4VqdaK5z0OR2z9RsDJl408ilc+s0RdfFzQokAaqSNfGLNRaYdaYrfQj
 ubWtnGaQAwqdkqa/jPj+pvW9ZsW9HHQ0wSY0luFIbXA8gq/JItJ7cooFlj6xD+IdHcN7
 f6GKq/PHKPYlFxQPodn+GdDMxk9jgFLXBPodrWxn7BjIz+vN8ZeRmVKc/oIrEdbAKUMq
 3u7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6rlEAygC1h9mczR1y0+mi8VH3UsiAelRgmF+YEFh3nM=;
 fh=Yi0vBjmsTj1dYaJTvBfK7+gaEfwkSzLXsVfqapRpNiI=;
 b=WnXnHnKDMpVHKzdpp3VL8Crj2v7HDnhEnsfM0q1Qb8BFzCaCgmoaTG1awDvq4WqKBi
 s+oNk2kuUEDala3mUsOC+SohzqXP1AO25mphUoX167DuiUjVpszL0X7tOE01B0wJkizu
 xDCldK9y2PQJvdhnYelZyEofaBllh/Uhs4lgJZr5SmXrn+QGvVp+JHQ/ib/ci6VKB91n
 ZLZJQqP+nqtFt6K3C7bDzRlfqRSEP2qYqFw0iLLg5Y9rQUapor1ob1Uw/gUxGFllEX9r
 TfFva8CCArUY2egK17LGTJnKLjRD4zUsRpilrpVUhPV/Wbv2hmvi+1NP9H7lfgMcaiYZ
 a2Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769076927; x=1769681727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rlEAygC1h9mczR1y0+mi8VH3UsiAelRgmF+YEFh3nM=;
 b=rZI2J5c+hIkCTZOUXzLM072r1ejMf5diu2sWIbpHtpuf840ocjHuz0bYoOqGB6aBLH
 3NzZMnnfHRvHatmLJMuYx9t6LGyTLlewly0xGKAwp54yx7XOCcDPX4OjDn4OSZ9WDwNV
 uSK6px9JD1+xCUl7rUi5H0EG12CHD+uNaMLIU4UhEhUXbcIXBnN8JQPCWSMIynr/wA8E
 6BzcNkITY4lODi7SxobUG/BCpQfVUi6tIkn62XLEakebKUfwzUC16LmgC3GJKHZj9b1z
 DUX22cokQJjU6tVK+O82ZYvZCK6haDMjd8LTqTqTsQR1bkspzwPWWhrhaEWQxqrKtTMM
 snlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769076927; x=1769681727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rlEAygC1h9mczR1y0+mi8VH3UsiAelRgmF+YEFh3nM=;
 b=arDuL+znVZV1DXwN25A/orCufpriiPW9gybMPzisR7N6cbve9CJlsyIhfxz69WbCKN
 uXKRqLRvgC7fuUWP+zVPxeTXd/IEp7eu6RMUZXiZigtGHWsV+lQWQXT25hL7+VFsq6BX
 oGRoFArVs8DnB/bhYVDcgUvCWxrJvJU6gjrzVHM8xWTy0G5zS+yN3XpL6CAPT2uj0RbJ
 UmNB1Kjolq/pqT5hmSMhLi9C/I1I+qMvBqli+lW2Df1RsUEn0H8n0fGmDhqBlAxVjdwq
 VqZvJ8C1ch/d9KVXwnLTcoRKuxp3mz6RZx5Gp222P0YFqZ83KjOiEnthIMulkxuCYewv
 EzyQ==
X-Gm-Message-State: AOJu0Yyzdx3FLZU5PbjIb+F9m1wlI8hS3KyoDQVD9VZhMgI5Cofzb8mc
 EWZNwdWS4xoDS2srOTFxSK1XNcUE2kZN85BvWv79JTkaFkW6oaNCvOIpzzFjTw8vDn8WKFR7lPZ
 z6WtkuttvKMcHw4Ise2lRPUsQJVCp2/b8dtxgT7nJjLpjqg/j53ko619xSPT7dMZXj7BijwAcV+
 91kZOcI/lKHtBxZkoX31u/ROBI5mfnLDs=
X-Gm-Gg: AZuq6aJqc9TmXH6cJowEY92IaIPoh9o9L3M/Q4HvxX8m42qNrn3NA/GAb6wj+EhhpiN
 Jg2B2NaRtMkKXwBmt3+zWMTeZLxqvQjIKUhn2Z0AhEged7L72qSZ6EDkszQ62E6MG/KNwS8wupc
 mGskxU+iTKAtSA1N9GNfmmwHjH+wy0MZ75g0VXg4TmFbE8e+i1O+0DpUujbV3B7rTd+aKW/DFl1
 5wH1hSrHsbV1oP7zrAgkcD7+PIeuT8NOUIMEseG5cq8dBm0zo/uKH1k
X-Received: by 2002:a05:600c:608a:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-48025ccb812mr262118345e9.10.1769076926933; 
 Thu, 22 Jan 2026 02:15:26 -0800 (PST)
X-Received: by 2002:a05:600c:608a:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-48025ccb812mr262117935e9.10.1769076926489; Thu, 22 Jan 2026
 02:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20260122093036.16085-1-thuth@redhat.com>
In-Reply-To: <20260122093036.16085-1-thuth@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Jan 2026 15:45:09 +0530
X-Gm-Features: AZwV_QiVZFNvJvo__5UZlQv8jcuU4eI09xllUl0PFyaGQFSKnk3i1jpcyNed6EI
Message-ID: <CAE8KmOxyA107Uc-E8rDXGJ7wXcMXwirNtdUM8dytPMw=6j+1YA@mail.gmail.com>
Subject: Re: [PATCH] tests/vm: Make the haiku VM usable again
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 kallisti5@unixzen.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 22 Jan 2026 at 15:01, Thomas Huth <thuth@redhat.com> wrote:
> The haiku VM bitrotted in the course of time. Make sure to use the
> latest version of the repositories here and install missing pieces
> like "pip" and "tomli" now.
>
> We also have to add a little "hack" to our configure script: For some
> weird reasons, the meson binary shows up as pyvenv/non-packaged/bin/meson
> here, and not in the expected location pyvenv/bin/meson. Use a symlink
> to fix it.

   -> https://github.com/haiku/haiku/blob/master/docs/user/storage/storageintro.dox

* Packages not available in the HPKG format are installed under the
"/non-packaged/" directory, it seems.

> For this new version, we also have to compile with "-pie", otherwise
> the linker complains about bad relocations in the object files, so
> allow compiling with PIE in the configure script now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure             | 8 +++++++-
>  tests/vm/haiku.x86_64 | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 9d7fd13a98b..587cd2a2fe6 100755
> --- a/configure
> +++ b/configure
> @@ -967,6 +967,12 @@ mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
>  $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
>       ${source_path}/pythondeps.toml meson || exit 1
>
> +# For some unknown reason, the meson binary shows up in the wrong
> +# folder on Haiku. Use a symlink to fix it.
> +if test "$host_os" = "haiku" && test ! -e pyvenv/bin/meson ; then
> +    ln -s "$PWD"/pyvenv/non-packaged/bin/meson pyvenv/bin/meson
> +fi
> +
>  # At this point, we expect Meson to be installed and available.
>  # We expect mkvenv or pip to have created pyvenv/bin/meson for us.
>  # We ignore PATH completely here: we want to use the venv's Meson
> @@ -1068,7 +1074,7 @@ static THREAD int tls_var;
>  int main(void) { return tls_var; }
>  EOF
>
> -if test "$host_os" = windows || test "$host_os" = haiku; then
> +if test "$host_os" = windows ; then
>    if test "$pie" = "yes"; then
>      error_exit "PIE not available due to missing OS support"
>    fi
> diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
> index 71cf75a9a3e..529283c39f6 100755
> --- a/tests/vm/haiku.x86_64
> +++ b/tests/vm/haiku.x86_64
> @@ -78,6 +78,8 @@ class HaikuVM(basevm.BaseVM):
>          "devel:libusb_1.0",
>          "devel:libz",
>          "ninja",
> +        "pip",
> +        "tomli_python310",
>      ]
>
>      BUILD_SCRIPT = """
> @@ -109,6 +111,8 @@ class HaikuVM(basevm.BaseVM):
>          self.wait_ssh(wait_root=True, cmd="exit 0")
>
>          # Install packages
> +        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haiku/r1beta5/$(getarch)/current")
> +        self.ssh_root("echo yes | pkgman add-repo https://eu.hpkg.haiku-os.org/haikuports/r1beta5/$(getarch)/current")
>          self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
>          self.graceful_shutdown()
>
> --

* Instead of creating a symlink for meson, could we add
'/non-packaged/' directory to an appropriate PATH variable, so that
all such binaries are accessible from 'non-packaged/bin/' directory?
That way we avoid creating symlinks for many /non-packaged/ binaries.

* Otherwise change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


