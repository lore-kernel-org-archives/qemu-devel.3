Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3930C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2H7-00087I-KH; Thu, 08 May 2025 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uD2H5-00084W-JX
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uD2H3-0003ix-53
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746714654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zh0+m7UYB0qzLT13ZBCzIV21zKxBNDrIXP82cXV8/eI=;
 b=KhmiKkCUyl9mxugCuXIeb7Br3qaalHhYPEF+OwHCpgRwZ4Z7qlJJ5eOmdGI++90Xy7sthn
 XBetjfY81689zhzUlNVWC2/FuOAaW6y8bOGXCnHWmFeEL5Gu8JuK6QXsmDz0sw+7odhDha
 vDjMd1InQIsIMph/201rLMq9jEslV1Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-ueK_6xpQPwSscGdQ3MV8ew-1; Thu,
 08 May 2025 10:30:50 -0400
X-MC-Unique: ueK_6xpQPwSscGdQ3MV8ew-1
X-Mimecast-MFC-AGG-ID: ueK_6xpQPwSscGdQ3MV8ew_1746714648
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B68AE1800873; Thu,  8 May 2025 14:30:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F1FE19560B3; Thu,  8 May 2025 14:30:45 +0000 (UTC)
Date: Thu, 8 May 2025 09:30:43 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] block/null: Add read-pattern option
Message-ID: <mykoj5oasoeq3k4xa7c2f4kt4sybz3o7plf7wc6ma27auh7gst@2anh6h54xam7>
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-3-nirsof@gmail.com>
 <87h61vekn9.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h61vekn9.fsf@pond.sub.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 08, 2025 at 07:28:26AM +0200, Markus Armbruster wrote:
> Let's take a step back from the concrete interface and ponder what we're
> trying to do.  We want three cases:
> 
> * Allocated, reads return unspecified crap (security hazard)
> 
> * Allocated, reads return specified data
> 
> * Sparse, reads return zeroes
> 
> How would we do this if we started on a green field?
> 
> Here's my try:
> 
>     bool sparse
>     uint8 contents
> 
> so that
> 
> * Allocated, reads return unspecified crap (security hazard)
> 
>   @sparse is false, and @contents is absent
> 
> * Allocated, reads return specified data
> 
>   @sparse is false, and @contents is present
> 
> * Sparse, reads return zeroes
> 
>   @sparse is true, and @contents must absent or zero

That indeed is a nice view of what we hope to test with.

> 
> I'd make @sparse either mandatory or default to true, so that we don't
> default to security hazard.
> 
> Now compare this to your patch: same configuration data (bool × uint8),
> better names, cleaner semantics, better defaults.
> 
> Unless we want to break compatibility, we're stuck with the name
> @read-zeroes for the bool, and its trap-for-the-unwary default value,
> but cleaner semantics seem possible.
> 
> Thoughts?

What if we add @sparse as an optional bool, but mutually exclusive
with @read-zeroes.  That would lead to 27 combinations of absent,
present with 0 value, or present with non-zero value; but with fewer
actual cases supported.  Something like your above table of what to do
with sparse and contents, and with these additional rules:

read-zeroes omitted, sparse omitted
 - at present, defaults to sparse=false for back-compat
 - may change in the future [*]
read-zeroes present, sparse omitted
 - behaves like explicit setting of sparse, but with old spelling
 - may issue a deprecation warning [*]
read-zeroes omitted, sparse present
 - explicit spelling, no warning (use above logic for how contents acts)
read-zeroes and sparse both present
 - error, whether values were same or different

[*] Simultaneously, we start the deprecation cycle on @read-zeroes -
tagging it as deprecated now, and removing it in a couple of releases.
Once it is gone, we are left with just @sparse; at that time, we can
decide to either make it mandatory (if so, we should warn now if
neither read-zeroes nor sparse is specified), or leave it optional but
change it to default true (so that the security hazard of sparse:false
and omitted contents is now opt-in instead of default).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


