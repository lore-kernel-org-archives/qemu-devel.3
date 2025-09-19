Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD90CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWmC-0000X9-HS; Fri, 19 Sep 2025 04:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWlu-0000W2-4F
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzWli-00057K-Kj
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jksf3t+FWFt0Jx44mTEdikAT/+hDGdGI0BX6woAyaFc=;
 b=eGoNJJVZdQNUi47oEBISiuF3uCfVF7TBWSS5xpVoa7IRBhKPCLvkrx/VIZ7ea+xlY8vt7Q
 MHVR6rgQFbUqu7IzoWfWARmsu/eCir3PBthJ2mvXKJSbvtXhd8MVwIW6uNWr7wkqLZ82Q0
 ca5gOGo964Tg7gJknIL0qiSEbM925lU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-0GLpPBM4MyGbjetCXtEfgQ-1; Fri,
 19 Sep 2025 04:46:56 -0400
X-MC-Unique: 0GLpPBM4MyGbjetCXtEfgQ-1
X-Mimecast-MFC-AGG-ID: 0GLpPBM4MyGbjetCXtEfgQ_1758271614
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC48D1956058; Fri, 19 Sep 2025 08:46:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF0830002C5; Fri, 19 Sep 2025 08:46:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A14921E6A27; Fri, 19 Sep 2025 10:46:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,  qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v3 05/20] audio: make jackaudio use qemu_thread_set_name
In-Reply-To: <aMQ1AYfJhxD26GPb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Sep 2025 15:58:09 +0100")
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-6-berrange@redhat.com>
 <10718921.crInZIivIp@silver> <aMQ1AYfJhxD26GPb@redhat.com>
Date: Fri, 19 Sep 2025 10:46:51 +0200
Message-ID: <87cy7m6d8k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 11, 2025 at 03:21:04PM +0200, Christian Schoenebeck wrote:
>> On Wednesday, September 10, 2025 8:03:42 PM CEST Daniel P. Berrang=C3=A9=
 wrote:
>> > This has greater portability than directly call pthread_setname_np,
>> > which is only 1 out of 3 possible functions for pthreads that can
>> > set the name.
>> >=20
>> > The new API requires a trampoline function, since it can only set
>> > the name of the current thread.
>> >=20
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> Well, it does what you said, so:
>>=20
>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>=20
>> I just wonder whether this thread naming code couldn't be much more simp=
lified
>> now by dropping jack_set_thread_creator() entirely, which is very seldom=
ly
>> used at all and had another user case [1]:
>>=20
>> "This function can be used in very very specialized cases where it is
>> necessary that client threads created by JACK are created by something o=
ther
>> than pthread_create(). After it is used, any threads that JACK needs for=
 the
>> client will will be created by calling the function passed to this funct=
ion.
>>=20
>> No normal application/client should consider calling this. The specific =
case
>> for which it was created involves running win32/x86 plugins under Wine on
>> Linux, where it is necessary that all threads that might call win32 func=
tions
>> are known to Wine."
>>=20
>> [1] https://jackaudio.org/api/group__ClientThreads.html#ga157ab0ade60e26=
6ffd26ddffdb5545af
>>=20
>> However there doesn't seem to be a thread creation callback in the JACK =
API,
>> so the jack_set_thread_creator() bypass is still the best we can get, ri=
ght?
>
> From QEMU's POV the only value we get from using the thread callback
> is that we can set the thread name so the jack thrread can be easily
> identified when debugging.  I don't think there's another easy way
> to get that set, as we can't portability set thread names from outside
> the thread.

As far as I can tell, this is due to Mac OS X.  Personally, I wouldn't
bother complicating things for that.  But whoever wrote the code in
qemu-thread-posix.c did, so ...


