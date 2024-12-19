Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09CDE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJK8-0005Ey-OF; Thu, 19 Dec 2024 11:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOIuH-0007Ok-G7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOIuE-0007j4-HY
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734623858;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jvfSuxYNPQ5/ctxMNVu0yYWuX2n7QJya0YHrfYmu8A=;
 b=BOaWZcHRBx8fxKsRdFZoK85vCw+46fS9ca0qzMFb0f40J1G3lGFN3tgic4VsL59wGDWH0P
 r8n+rVNQbQHawl1zG+kqqRPzm4QDDYfLVLdQzuOXwmgJJy/dP1JmUNGOnNKUpmh39VIfOZ
 Yy5JB1cyN5Wv4ANQBx7YYw9UduxwzcA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-RVwFgWIhOq6rFDLN6J9IIg-1; Thu,
 19 Dec 2024 10:57:37 -0500
X-MC-Unique: RVwFgWIhOq6rFDLN6J9IIg-1
X-Mimecast-MFC-AGG-ID: RVwFgWIhOq6rFDLN6J9IIg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7118A1956060; Thu, 19 Dec 2024 15:57:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5202719560AD; Thu, 19 Dec 2024 15:57:33 +0000 (UTC)
Date: Thu, 19 Dec 2024 15:57:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [RFC PATCH 00/10] hw/misc/vmcoreinfo: Convert from QDev to plain
 Object
Message-ID: <Z2RCaZrwjYSM3NpV@redhat.com>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 19, 2024 at 04:38:47PM +0100, Philippe Mathieu-Daudé wrote:
> No reason for vmcoreinfo to be based on QDev, since it
> doesn't use any QDev API. Demote to plain Object.

I'm not especially convinced by that rationale, at least in the short
term[1].

As a user of QEMU, I would tend to view -device  as being the way to
create devices that are visible to the guest, and -object as being
for dealing with host backends.

vmcoreinfo is quite an unusal device, in that if only exists as a
fwcfg field, but that's an internal impl detail from a user's POV,
and it is still a guest visible device type.

So while it may not leverage QDev API, I still feel it is more of
a fit for -device, than -object.  Is there any functional benefit
to moving it to -object, that outweighs the disruption ?


With regards,
Daniel

[1] I say "short term", because overall I'm of the opinion that
-device, -machine, -cpu, -chardev, etc should not exist, and
-object ought to be made capable of instantiating any type of
object whatever subclass it might be. I doubt that will change
any time in the forseeable future though, so it is more of a
hypothetical point.

-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


