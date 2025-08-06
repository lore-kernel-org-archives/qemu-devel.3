Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5DFC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYbY-0007B8-PW; Wed, 06 Aug 2025 03:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ujYbN-00077R-F7
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ujYbH-0005Do-DL
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754465413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6+g7nd94Bk/4TEewIZlSAr/luvcCrHVaNG8ghCZsn8=;
 b=PrvOL9yB7w4ceOXll8DSXJ1SPHfaAYbiDHSBxnOIydKqoMRPqKexoWEXyOy6rMPUsufUbB
 1+zs0Zlq98z8dWmm+a8tUDWHCUStXryRsy9za3PrK5nKeKpvN2MFXry7glyTEK9As/PRX3
 6QwR2iQU2MHMtBLb5HQkbfgTbtdDBHU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-ZEcGD5nAMv6WArx2yBdsqQ-1; Wed,
 06 Aug 2025 03:30:10 -0400
X-MC-Unique: ZEcGD5nAMv6WArx2yBdsqQ-1
X-Mimecast-MFC-AGG-ID: ZEcGD5nAMv6WArx2yBdsqQ_1754465409
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD9A919560AD; Wed,  6 Aug 2025 07:30:07 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.228])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F1E0180047F; Wed,  6 Aug 2025 07:30:04 +0000 (UTC)
Date: Wed, 6 Aug 2025 09:30:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH-for-10.1] tests/qemu-iotests/tests/mirror-sparse: skip if
 O_DIRECT is not supported
Message-ID: <aJMEeVr1BU-abnNb@redhat.com>
References: <20250801122850.27632-1-mjt@tls.msk.ru>
 <7893945e-6287-4f32-9e93-f28c39c7bdc8@linaro.org>
 <4f0a804d-d448-4dc0-97e1-20b3f669c8a2@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f0a804d-d448-4dc0-97e1-20b3f669c8a2@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 05.08.2025 um 19:56 hat Michael Tokarev geschrieben:
> On 05.08.2025 20:23, Philippe Mathieu-Daudé wrote:
> 
> > > diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-
> > > iotests/tests/mirror-sparse
> > > index cfcaa600ab..19843a622c 100755
> > > --- a/tests/qemu-iotests/tests/mirror-sparse
> > > +++ b/tests/qemu-iotests/tests/mirror-sparse
> > > @@ -41,6 +41,7 @@ _supported_fmt qcow2 raw  # Format of the source.
> > > dst is always raw file
> > >   _supported_proto file
> > >   _supported_os Linux
> > >   _require_disk_usage
> > > +_require_o_direct
> > 
> > Could the correct use be:
> > 
> >    _supported_cache_modes none directsync
> 
> Yes that works too.  I've no idea which is "better" - we've
> a bit too many options here, I think.  I'll change it to your
> suggestion.

No, _require_o_direct is better because it directly checks if files in
the scratch directory support O_DIRECT, which is what we need here
because the test unconditionally opens the file this way:

    -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
                "filename":"'"$TEST_IMG.base"'", "node-name":"src-file"}' \

_supported_cache_modes is about the cache mode requested on the command
line when running qemu-iotests, which is not what we're interested in.
The relevant call doesn't even consider the command line option. It
still "fixes" the failure because requesting "none" or "directsync"
makes it do the O_DIRECT check, too.

But the effect is different: With "_supported_cache_modes none
directsync", the test will always be skipped if on the command line
"writeback" was requested (it's the default, so we'll skip the test by
default - that's a bad idea). With _require_o_direct it will only be
skipped if the filesystem really doesn't support O_DIRECT.

Kevin


