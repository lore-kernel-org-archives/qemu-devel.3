Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050B7CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCMF0-000787-Mi; Thu, 01 Oct 2026 15:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMEz-00077t-64
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCMEw-000220-Sc
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 15:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790882085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hZIlXfmB9UHms9touvdJyaJRiwRt4ZOmeTj7TOgySc=;
 b=gEMqeBDdWgqQr4kH2X0aMjEJUN+8Wx/XUDArImrAaBe3s45n3NxCBN+uwAMa3u7YV1AxJ6
 pb6KLszgoNbc0JdIEoExJIjR/bUc8b15nk92lrr3BK9Devozp+NGDRe+KKMEmOF93Cgr3B
 uwHVTtmFqT2rtekjVILPBPeLIdn/gBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-XpOQevc_PRaxSsfeAwRvrQ-1; Thu,
 01 Oct 2026 15:14:44 -0400
X-MC-Unique: XpOQevc_PRaxSsfeAwRvrQ-1
X-Mimecast-MFC-AGG-ID: XpOQevc_PRaxSsfeAwRvrQ_1790882083
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DB92197701D
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 19:14:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F04D5BC; Thu,  1 Oct 2026 19:14:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/20] trace: bugfixes, cleanups and optimizations
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
Date: Thu, 01 Oct 2026 23:14:36 +0400
Message-Id: <179088207684.2348671.9429143967459679840.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cziczeotQrkmKT5YaDBgmzWlm4BQxYd++PpZ/uZKWPc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvrEeXGoDofQVslM2XN5e83LXQEW5bZSpbRvms
 yt9I89Bu1WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar6xHgAKCRDa6OEJdZac
 5ZY5D/9iv3WTKToJvn09MmvqoMClgFmoXA+lTYliGJM2cUTutKIIketJnjFELVbehrYQ1G6Qc37
 mlF7qpal8+o6R6d/7v+0mC6uJCXUNKPnXSXSZQTyy8zBefqVl5BYIaYTwQKajwb6EZDS78b5Ibn
 uzaHM3ZtFAowu1SS04MrQmYM77JHhS8KyxrVW6sm1rKWa5xEy11SEnJ1EPSVFqHPkkYoE0HEsMj
 /MAHeG/EYBfwsBVCXKM6gNzG0arY+VBUjIIhQDk+Kkoyq0xaYypJ6wSSIhSH13M8hbVdVCOI8er
 w1h0wM5jgwWUgtbGFF/raXe6oTuVG/2e7Jfa80bsAmpP0cUIjJk+B1sQh370LiSpEsT+945r7EZ
 MvQy74BSngT56c3zQ6kjE1MkuV1LqDYlQy10MRxfsGc0Fv9K2tUniSzFUliU1mh8mYkKlvybKXj
 rrZrhTv69IFtMzFUPaiwhSDAoyduwOeIkptJTEGRuAdL7QKCC13fIcTJ7oHOn9g6YNdFQ/ifoKT
 FFfKCHmoHRjGnFnWg/ySjATxRzq8mH+S2EyFPM7OIfD4xuj0Id4OVe9jsMpU1t+ohWxHFj6YJDo
 zmPMGkmuMI4OFPEhxHhkqAP65xOypGPXJx9LDT4KvSRQMZBm0GSx7U9vluazK4vcS5NsNcjXpm2
 2FKWvgH4/tgfYEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

> This series started off with fixing some compile failures seen
> with dtrace and ust backends, and got somewhat out of hand as
> I looked more deeply at the trace code. So it ended up doing
> various bits of code cleanup and memory usage optimizations.
> 
> The optimizations aren't huge against each individual binaries.
> There are too many scenarios to show the full set, but here
> are some binary size examples
> 
> The current git master baseline for different enabled
> backends  on the x86_64 emulator:
> 
>   nop 88546360
>   dtrace 90604496
>   ftrace 93265944
>   log 93799528
>   syslog 93962704
>   simple 97064528
>   ust 162999944
>   dtrace,ftrace,log,syslog,simple,ust 174438088
> 
> 'ust' has insanely high overhead in terms of binary sizes,
> inexplicably insane.
> 
> 'ftrace/log/syslog' are all similar because their overhead
> is dominated by the printf() format strings which are
> identical in all.
> 
> 'simple' is a bit worse because of the helper functions we
> must generated for each probe
> 
> After this series is applied the results for x86_64 are
> 
>   nop 88510248
>   dtrace 90576160
>   ftrace 93156320
>   log 93735064
>   syslog 93853480
>   simple 97050856
>   ust 162957256
>   dtrace,ftrace,log,syslog,simple,ust 174431128
> 
> IOW, for 'dtrace', we save 28k, for 'log' we save 62k
> 
> For the aarch64 binary, we see bigger saving in some
> cases:
> 
>   baseline dtrace 127610144
>   baseline log 131050320
>      trace dtrace 127459264
>      trace log  130998872
> 
> IOW, for 'dtrace' we save 150k, for 'log' we only save
> 50k. No clue why the saving is not so significant for
> the 'log' backend but not a big deal.

Need tracing.rst update, and maybe better commit message, but lgtm otherwise,
series:

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


