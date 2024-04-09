Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E4C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCFk-0007SO-FK; Tue, 09 Apr 2024 10:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruCFf-0007S2-4T
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruCFX-0006vW-AG
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712672095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kJj7kNjsjgnkdTxB8+OOJnAN2u/vufHePBF+pOiITLY=;
 b=UgQZopNNXES0kkfh9PeO2o6VYuy5RSAfxCTBUYoE/mMdcQ0c+1QlavMHuNN0h7ZQwfOxAw
 JQmbTV3GMdB/AAn+mUYX4dszU84o+eq0d82vzDJ2B8MkUwzAgTft/B8YHyRRruzUhgyxKL
 PGCqbTFiQjPsuG46wF37ezH6k5ZIHf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-o9DgYaeFO9u4BB1s5-QhQA-1; Tue, 09 Apr 2024 10:14:53 -0400
X-MC-Unique: o9DgYaeFO9u4BB1s5-QhQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FC641809EC8;
 Tue,  9 Apr 2024 14:14:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DFDCC0157E;
 Tue,  9 Apr 2024 14:14:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E2E3618009F4; Tue,  9 Apr 2024 16:14:47 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:14:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] edk2: get version + date from git submodule
Message-ID: <sevlzxonvgps5m7r263bkzouabg62tbe6vknvv4rbvjfnnhkqg@jnqkst5xetwn>
References: <20240325144440.1069662-1-kraxel@redhat.com>
 <CAFEAcA8eX=-6yXCZ2+X6niJPcgzkzXfHT9F6LpbfqV4b9VRW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8eX=-6yXCZ2+X6niJPcgzkzXfHT9F6LpbfqV4b9VRW6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> > +               --version-override "$(EDK2_STABLE)-for-qemu" \
> > +               --release-date "$(EDK2_DATE)" \
> 
> Hi -- I've just noticed that we never made this change to
> automate the date/version for EDK2 ROMs, but we also never
> updated the version by hand. So at the moment we ship an
> EDK2 blob that wrongly claims to be an older version.
> See this bug report by a user:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/2233
> 
> Is it possible to fix this for 9.0?

I've posted v2 (series) a while back, no feedback so far.

https://lore.kernel.org/qemu-devel/20240327102448.61877-1-kraxel@redhat.com/

If there are no objections I can do a PR for these three patches plus an
edk2 binary rebuild (which shouldn't change anything but the version
string).

take care,
  Gerd


