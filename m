Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915EDC021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnC9N-0003zN-OS; Wed, 26 Feb 2025 02:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnC9M-0003yR-IT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tnC9L-0005nV-3E
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740556089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nbBOJoc/hYi/TbtRJ3CkGAC1erM0h3qUj9etGg1ef44=;
 b=fzM9w/ZCnakUA/Cm/FUsodWksqLFceo0TovirdvjTH8aidHsZwPjey9jyXVHf90o/4p9ut
 Ngj8Kqs4SKvLzR7f7uAyFUVODTBYxL3cIUJwQ1v3ril0wVGncd41cPxgfKKDC0xWZmkY4T
 Q62VPxsPyilTlnxQmDGpZEtaU5z+Rj4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-gWxH8c8IMASaB1eQhnE19w-1; Wed,
 26 Feb 2025 02:48:04 -0500
X-MC-Unique: gWxH8c8IMASaB1eQhnE19w-1
X-Mimecast-MFC-AGG-ID: gWxH8c8IMASaB1eQhnE19w_1740556083
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4FBE1800877; Wed, 26 Feb 2025 07:48:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BD45300018D; Wed, 26 Feb 2025 07:48:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CE1E91800091; Wed, 26 Feb 2025 08:47:57 +0100 (CET)
Date: Wed, 26 Feb 2025 08:47:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, 
 Ard Biesheuvel <ardb@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com, 
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 14/24] hw/uefi: add var-service-json.c + qapi for NV
 vars.
Message-ID: <wyrnw2ur2xp7e6yr7f7hdbn3zbvolnvjojjrlaoax7hb2psxzo@xw7arzdtroer>
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-15-kraxel@redhat.com>
 <87zfi95khl.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfi95khl.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi,

> > +# @data: variable value, encoded as hex string.
> 
> I understand this is a blob.  We commonly use base64 for that.  Why not
> here?

It's an existing format already supported by other tools.  Guess I
should add that to the preamble.

> > +# @digest: variable certificate digest.  Used to verify the signature
> > +#     of updates for authenticated variables.
> 
> How to create and verify these digests will be obvious enough to users
> of this interface?

Well, no.  It's a somewhat complicated story ...

UEFI has two kinds of authenticated variables.  First, the secure boot
variables (PK, KEK, db, dbx).  These have hard-coded rules, the rule
most relevant in practice is that signed update requests for the 'db'
and 'dbx' variables are checked against the 'KEK' certificate database.

For other authenticated variables UEFI essentially remembers the
certificate when the variable is created, and any update / delete
requests need a signature from the same certificate (simplified a
bit to keep it short, the actual rules are more complicated, details
are in the UEFI spec).

This digest handles the "remembers the certificate" part.

In practice the second kind of authenticated variables is rarely used.
I have yet to see a piece of software actually using that in practice
(other than the test case I have written).


Also note that this is *not* part of the QMP interface.  The driver uses
this to store the efi variable store in json format on disk (see
var-service-json.c in this patch).

Adding support for reading/writing uefi variables is something we might
add to the monitor in the future.   Should that happen it is not clear
whenever such an interface would actually use the raw 'UefiVariable'
struct or if higher-level interfaces would be more useful.  For example
a command to query whenever the guest has secure boot turned on.

take care,
  Gerd


