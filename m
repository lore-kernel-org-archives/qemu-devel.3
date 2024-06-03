Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCB4C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBuB-0001bZ-QR; Mon, 03 Jun 2024 13:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEBtr-00014q-HI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEBtn-0000YZ-Ak
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717437306;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KARoLuBVHwanDn5ZOSrMUvpIv5PZX8QSh4rGPd7RZs8=;
 b=MjuuMbqbQuPc62stP9ZUFfC13D8M7Ci3el0iowocIzFuvmtbxyhT4pJ7AeuXRgHIwMjGHJ
 +f5v854fZ/77bqQJvo4+JsU7Eyxv728muPq9pN6T0wfBnpGCN5RR472WA2Px7GvKFU6ykX
 IN+fUiJEa0ykgbfLjLjgPmqSFX91dmU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-kx1ZY5kuPr2WkVm4BZxHLw-1; Mon,
 03 Jun 2024 13:55:03 -0400
X-MC-Unique: kx1ZY5kuPr2WkVm4BZxHLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43E829AA385;
 Mon,  3 Jun 2024 17:55:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CB4F5620;
 Mon,  3 Jun 2024 17:55:01 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:55:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
Message-ID: <Zl4DdL1Cwiy-GuCj@redhat.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <877cf6gk10.fsf@draig.linaro.org> <Zl3YTm0-rEs2Kqqj@redhat.com>
 <8734pthqc8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734pthqc8.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 03, 2024 at 06:46:15PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Jun 03, 2024 at 03:47:55PM +0100, Alex Bennée wrote:
> >> Thomas Huth <thuth@redhat.com> writes:
> >> 
> >> > Casting function pointers from one type to another causes undefined
> >> > behavior errors when compiling with -fsanitize=undefined with Clang
> >> > v18:
> >> 
> >> Queued to testing/next, thanks.
> >
> > Please remove, as I don't think this is a viable approach to the
> > problem
> 
> Ok - I'll drop it.
> 
> I still have:
> 
>   .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function in the clang-system job
> 
> to prevent the CI failures.

Yes, that's good.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


