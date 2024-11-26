Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA244D3B9A2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxKb-0002lz-Rh; Tue, 26 Nov 2024 10:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFxKZ-0002fi-RG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFxKX-0004bw-Kr
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732634299;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nUFj0u4xUrZUnxNbS5AT2u7yQ1rYvddwlqDbureuip8=;
 b=NoxDUscbjOz356mDw5fBlcOiu7H8j6dQPwasmcyR1IIxnpZ4aiv3NaLFHEmLY7hsIBG/CE
 BF3OOR4/HQPdbs7VwSqXZdjmYHnl4N8HF3ieSYwQT2hsfr8Jn2Thd9nD2R0ROznSwqIttz
 tIgs26NBpIgRCQXRs/NHtueGxP/yrPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-f2WajsY8OlGMqIdTKpdiDA-1; Tue,
 26 Nov 2024 10:18:10 -0500
X-MC-Unique: f2WajsY8OlGMqIdTKpdiDA-1
X-Mimecast-MFC-AGG-ID: f2WajsY8OlGMqIdTKpdiDA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E781B19775F7; Tue, 26 Nov 2024 15:17:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C109300019E; Tue, 26 Nov 2024 15:17:49 +0000 (UTC)
Date: Tue, 26 Nov 2024 15:17:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 11/26] target/arm/kvm-rme: Add measurement algorithm
 property
Message-ID: <Z0XmmfCNmQHB0vpu@redhat.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-13-jean-philippe@linaro.org>
 <Z0XFsC6vWkrR7aAm@redhat.com> <87ed2yowrs.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed2yowrs.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 26, 2024 at 04:11:19PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Nov 25, 2024 at 07:56:10PM +0000, Jean-Philippe Brucker wrote:
> 
> [...]
> 
> >> diff --git a/qapi/qom.json b/qapi/qom.json
> >> index f982850bca..901ba67634 100644
> >> --- a/qapi/qom.json
> >> +++ b/qapi/qom.json
> >> @@ -1068,6 +1068,20 @@
> >>    'data': { '*cpu-affinity': ['uint16'],
> >>              '*node-affinity': ['uint16'] } }
> >>  
> >> +##
> >> +# @RmeGuestMeasurementAlgorithm:
> >> +#
> >> +# @sha256: Use the SHA256 algorithm
> >> +#
> >> +# @sha512: Use the SHA512 algorithm
> >> +#
> >> +# Algorithm to use for realm measurements
> >> +#
> >> +# Since: 9.3
> >> +##
> >> +{ 'enum': 'RmeGuestMeasurementAlgorithm',
> >> +  'data': ['sha256', 'sha512'] }
> >
> >
> > A design question for Markus....
> >
> >
> > We have a "QCryptoHashAlg" enum that covers both of these strings
> > and more besides.
> >
> > We have a choice of using a dedicated enum strictly limited to
> > just what RME needs, vs using the common enum type, but rejecting
> > unsupported algorithms at runtime.  Do we prefer duplication for
> > improve specificity, or removal of duplication ?
> 
> With a dedicated enum, introspection shows precisely the accepted
> values.
> 
> If we reuse a wider enum, introspection shows additional, invalid
> values.
> 
> Say we later make one of these valid here.  If we reuse the wider enum
> now, nothing changes in introspection then, i.e. introspection cannot
> tell us whether this particular QEMU supports this additional algorithm.
> With a dedicated enum, it can.  Whether that's needed in practice I find
> hard to predict.
> 
> I lean towards lean towards dedicated enum.
> 
> Questions?

That's fine with me. Lets stick with the approach in this patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


