Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7F5EFD209
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvAVv-0000mf-Ou; Wed, 25 Feb 2026 03:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvAVt-0000m3-Hl
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvAVp-00064j-0j
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772009081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HuGUyiDycW/Vnee9LZdiuJ5H/qpylEqd2MesRVPuTRI=;
 b=K3+bwWAEbfC75+XaSX3CSGC5kvZpYMfIhmcSpJ2QDMBnu0mibBM59AEmkbdKBELPZLHt7N
 dbLKMenjLMvNNRpGP4kxgCA3otSys/ItGIU1ZjaJBj8W5qBQt2hwjcrl7Oxo0+iMOOOtCz
 lwU/C4qyCSchXYDSMWS97oSR0x86KRI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-oWjwELn9MJSdqblYVU0LNQ-1; Wed,
 25 Feb 2026 03:44:40 -0500
X-MC-Unique: oWjwELn9MJSdqblYVU0LNQ-1
X-Mimecast-MFC-AGG-ID: oWjwELn9MJSdqblYVU0LNQ_1772009079
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8B731956089; Wed, 25 Feb 2026 08:44:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86CE13003D88; Wed, 25 Feb 2026 08:44:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1069D21E692D; Wed, 25 Feb 2026 09:44:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/16] scripts/qapi: add QAPISchemaType.is_predefined
In-Reply-To: <21b5e0ec-d03d-4e39-a3bf-deada48243b7@redhat.com> (Paolo
 Bonzini's message of "Wed, 25 Feb 2026 09:01:15 +0100")
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <20260108131043.490084-11-pbonzini@redhat.com>
 <87bjhdxooi.fsf@pond.sub.org>
 <21b5e0ec-d03d-4e39-a3bf-deada48243b7@redhat.com>
Date: Wed, 25 Feb 2026 09:44:36 +0100
Message-ID: <87ldghw6tn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/25/26 08:33, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> It is impossible to call is_implicit on an enum type from the visitor, because
>>> the QAPISchemaEnumType has already been exploded into its costituent fields.
>> 
>> constituent
>> 
>> Passing selected attributes instead of the entire object to its visitor
>> method limits what the visitor can do.  This is both good and bad.
>> We've run into "bad" a couple of times.  It's never been bad enough to
>> change the interface, though.
>> 
>> Thoughts?
>
> I think that applies here, is_predefined() is a reasonable addition.
>
>>> The Rust backend is also not modular (yet?) so it is not possible to filter
>>> out the builtin module;
>> 
>> Really?
>> 
>> The visitors are all based on QAPISchemaVisitor.  Protocol:
>> 
>>      .visit_begin()
>>      for all modules:
>>          .visit_module()
>>          for all entities:
>>              if .visit_needed():
>>                  .visit_FOO()
>>      .visit_end()
>> 
>> QAPISchemaModularCVisitor implements .visit_module() to generate code
>> per module.  Its .write() skips builtin modules unless opt_builtins.
>
> ... because its .write() already builds multiple QAPIGen{C,H,Trace}, one 
> per module.  Here instead there is just one QAPIGenRs.
>
> Using multiple QAPIGenRs instances, one per module, would be hackish. 

I was thinking of having .visit_module() save .is_builtin_module(name)
in self.in_builtin_module, then use that to recognize built-ins.

> I'd rather just go modular instead of that.  I can take a look, since 
> this series will be (early) 11.1 material anyway.

Modular C code generation reduces incremental build time massively.
Before, we suffered from "touch the schema, recompile the world".  If
Rust would similarly profit, then I'm all for going modular.

[...]


