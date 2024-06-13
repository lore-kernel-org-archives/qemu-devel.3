Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75D4C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHibr-0002GC-8V; Thu, 13 Jun 2024 07:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHibo-0002EX-WB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHibn-0003rn-4r
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718278030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HcBz4/DIbpxcSbGQV4EoKY2pytLRNgk+mqBJH77Pbk=;
 b=idqYdG9n780Bmh1i5uFvkWWGMAkXiXy2kanVa3Q9A/ngaIFQigokB4uKPtrDEGCecCiK+H
 GietOR3g/nnFoUNFQtmGifpQo3/PZTWEZHVTyXJOt24x25nBBflQBYsa01xUBLlV2VrJmR
 noKwDKzXcYz6luSoZgm7GONNHWtnh6s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-VmpmQsrqOCSiHYznFQIrEg-1; Thu,
 13 Jun 2024 07:27:06 -0400
X-MC-Unique: VmpmQsrqOCSiHYznFQIrEg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1D8B19560B1; Thu, 13 Jun 2024 11:27:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D93E619560BF; Thu, 13 Jun 2024 11:27:01 +0000 (UTC)
Date: Thu, 13 Jun 2024 12:26:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 08/20] qga: conditionalize schema for commands
 unsupported on Windows
Message-ID: <ZmrXgoyu5gYYrzuV@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-9-berrange@redhat.com>
 <87a5jrlu5f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5jrlu5f.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 11, 2024 at 11:13:00AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Rather than creating stubs for every command that just return
> > QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> > fully exclude generation of the commands on Windows.
> >
> > The command will be rejected at QMP dispatch time instead,
> > avoiding reimplementing rejection by blocking the stub commands.
> 
> The commit message should mention that the value of "error" in the error
> response changes from
> 
>     {"class": "GenericError, "desc": "this feature or command is not currently supported"}
> 
> to
> 
>     {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

Actually it doesn't change like this, because the runtime disablement
means the stub never runs. So the actual differenceis this:

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
    
to
    
    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

still better, because it more accurately describes the sitution
where a command is not implemented on a platform configuration.

I'll add this to the commit msg.

> 
> > This fixes inconsistency where some commands are implemented
> > as stubs, yet not added to the blockedrpc list.
> 
> Example?

guest-get-cpustats & guest-get-diskstats. These two do actally
have their error message change in the way you describe. I'll
document this too.

> 
> > This has the additional benefit that the QGA protocol reference
> > now documents what conditions enable use of the command.
> 
> Yes!
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


