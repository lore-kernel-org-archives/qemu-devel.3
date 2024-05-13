Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783DCC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6TlC-0007SS-Oh; Mon, 13 May 2024 07:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6TlB-0007SH-JM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Tl8-00071M-TG
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715599341;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykJV2L5P6auBvKRf7YWFmKzOqvHyFSYlGc1LbiLhyk8=;
 b=hUQ8OQpi07+dhyliYA1u1PFkNn2/v60c04KAfs6XGFtn+1+cZ7wdqem6pixfpTte3OtD/q
 pFIE9xhvTg7XVI1WMqMh/3h7xsA3ep94fyr85afPPmaesGRJedbR1ee/UPxCcTjZiSm493
 0uKcjClF9l8njbKnG5d/oRZGen3CTqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655--2Kjd2KrMDy7cpvXqyY18w-1; Mon, 13 May 2024 07:22:17 -0400
X-MC-Unique: -2Kjd2KrMDy7cpvXqyY18w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72A3180021D;
 Mon, 13 May 2024 11:22:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBCFD40004B;
 Mon, 13 May 2024 11:22:14 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 3/3] gitlab: use 'setarch -R' to workaround tsan bug
Message-ID: <ZkH341rrPTNS9yqA@redhat.com>
References: <20240513111551.488088-1-berrange@redhat.com>
 <20240513111551.488088-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513111551.488088-4-berrange@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 13, 2024 at 12:15:51PM +0100, Daniel P. Berrangé wrote:
> The TSAN job started failing when gitlab rolled out their latest
> release. The root cause is a change in the Google COS version used
> on shared runners. This brings a kernel running with
> 
>  vm.mmap_rnd_bits = 31
> 
> which is incompatible with TSAN in LLVM < 18, which only supports
> upto '28'. LLVM 18 can support upto '30', and failing that will
> re-exec itself to turn off VA randomization.
> 
> Our LLVM is too old for now, but we can run with 'setarch -R make ..'
> to turn off VA randomization ourselves.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 3 +++
>  1 file changed, 3 insertions(+)

Example job showing this working:

  https://gitlab.com/berrange/qemu/-/jobs/6824465594

 > 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index bab6194564..d864562628 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -575,6 +575,9 @@ tsan-build:
>      CONFIGURE_ARGS: --enable-tsan --cc=clang --cxx=clang++
>            --enable-trace-backends=ust --disable-slirp
>      TARGETS: x86_64-softmmu ppc64-softmmu riscv64-softmmu x86_64-linux-user
> +    # Remove when we switch to a distro with clang >= 18
> +    # https://github.com/google/sanitizers/issues/1716
> +    MAKE: setarch -R make
>  
>  # gcov is a GCC features
>  gcov:
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


