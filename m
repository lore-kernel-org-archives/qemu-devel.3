Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B433C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjcgf-0005XJ-8N; Mon, 11 Mar 2024 06:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjcge-0005Wq-1u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjcgU-0007Rm-5g
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710152104;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6O6jy44/meyHSmUeC/WZjHCzjDOybfRhBY0M22B0QR0=;
 b=A0nqiiE/0jIyA8ccb1UkAaoYg6lHQ3ic5wSwb/T8g18wWGk3tFfM2yCmU5RTVtgDAV7J60
 pOah0PDfcgWVrqP/bBxRaY4b8iLHdMD36OnicZf2sPAGTCMUwf3H9YAWIE/EbnceydEHtt
 ifkXR5x6lBmmDbkVthAp4rtX9AxQhV0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-t9Nj-VWrN1KdbPb_rChWGA-1; Mon,
 11 Mar 2024 06:15:02 -0400
X-MC-Unique: t9Nj-VWrN1KdbPb_rChWGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA683C0F227;
 Mon, 11 Mar 2024 10:15:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68BCB3C20;
 Mon, 11 Mar 2024 10:15:00 +0000 (UTC)
Date: Mon, 11 Mar 2024 10:14:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] crypto: Introduce SM4 symmetric cipher algorithm
Message-ID: <Ze7Zomg9YrhvrN2J@redhat.com>
References: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
 <ac13ac70-9894-48b2-97a9-ddb7a8077ac7@redhat.com>
 <Ze7PsJV7eQar1hNe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze7PsJV7eQar1hNe@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Mar 11, 2024 at 09:32:32AM +0000, Daniel P. Berrangé wrote:
> On Fri, Mar 08, 2024 at 09:30:52PM +0100, Thomas Huth wrote:
> > On 07/12/2023 16.47, Hyman Huang wrote:
> > > Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> > > 
> > > SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> > > Organization of State Commercial Administration of China (OSCCA)
> > > as an authorized cryptographic algorithms for the use within China.
> > > 
> > > Detect the SM4 cipher algorithms and enable the feature silently
> > > if it is available.
> > > 
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > 
> > FYI, starting with this commit, tests/unit/test-crypto-cipher is now failing
> > on s390x hosts (i.e. big endian machines)... could be that there is maybe an
> > endianess issue somewhere in here...
> 
> Or more worringly the issue could be in nettle's impl of SM4, as
> I'm not seeing an obvious place in this QEMU glue layer which
> could cause endianness mistakes.

This is not a s390x problem in fact, it happens on all arches.

For unknown reasons RHEL has disabled build of the SM4 cipher
algorithm in libgcrypt.

If building QEMU with nettle you won't see the problem, as the
nettle in RHEL is too old currently.

If building QEMU with gnutls you won't see the issue as gnutls
doesn't support SM4 cipher at all.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


