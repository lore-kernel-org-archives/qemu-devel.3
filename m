Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C2C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMOwb-00080A-09; Tue, 03 Jun 2025 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMOwV-0007zN-TY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMOwT-0007TO-GA
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748946742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fhSZSAV/6vQipzUtXID/HCzKaZL8NDiReASoJHPQeqo=;
 b=hpLLna93oQjRx/pYuXCdp341ebWXb8BIARDUHMxMXIFG+RzXCOiHU1csgY27rjqx4H2oUO
 2uXG26gTxyFQW7RKDTCy4sCg9eERSQSHQRQmNxtHTnTYpQVTmQHFafh4wfnTPgXs5TPtZD
 TNqLXvD7QxfmjbyQLD5xrBM7kslDokU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-SB_n5QQqM-yJsLpzK3n53A-1; Tue,
 03 Jun 2025 06:32:19 -0400
X-MC-Unique: SB_n5QQqM-yJsLpzK3n53A-1
X-Mimecast-MFC-AGG-ID: SB_n5QQqM-yJsLpzK3n53A_1748946738
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11E921956095; Tue,  3 Jun 2025 10:32:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BB8B1800359; Tue,  3 Jun 2025 10:32:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 232D521E6766; Tue, 03 Jun 2025 12:32:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 06/14] rust: qemu-api: add bindings to Error
In-Reply-To: <aD7AbxghCc5VYDhu@intel.com> (Zhao Liu's message of "Tue, 3 Jun
 2025 17:29:19 +0800")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-7-pbonzini@redhat.com>
 <877c1uffj3.fsf@pond.sub.org> <aD7AbxghCc5VYDhu@intel.com>
Date: Tue, 03 Jun 2025 12:32:15 +0200
Message-ID: <8734ch5d5c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:
> Markus Armbruster <armbru@redhat.com> writes:

[...]

>> Let's examine the other aspect: how exactly "storing" behaves.
>> 
>> error_setg() according to its contract:
>> 
>>     If @errp is NULL, the error is ignored.  [...]
>> 
>>     If @errp is &error_abort, print a suitable message and abort().
>> 
>>     If @errp is &error_fatal, print a suitable message and exit(1).
>> 
>>     If @errp is anything else, *@errp must be NULL.
>> 
>> error_propagate() according to its contract:
>> 
>>     [...] if @dst_errp is NULL, errors are being ignored.  Free the
>>     error object.
>> 
>>     Else, if @dst_errp is &error_abort, print a suitable message and
>>     abort().
>> 
>>     Else, if @dst_errp is &error_fatal, print a suitable message and
>>     exit(1).
>> 
>>     Else, if @dst_errp already contains an error, ignore this one: free
>>     the error object.
>> 
>>     Else, move the error object from @local_err to *@dst_errp.
>> 
>> The second to last clause is where its storing differs from
>> error_setg().
>> 
>> What does errp.write(err) do?  I *guess* it simply stores @err in @errp.
>> Matches neither behavior.
>> 
>> If that's true, then passing &error_abort or &error_fatal to Rust does
>> not work, and neither does error accumulation.  Not equivalent of C
>> error_propagate().
>
> I did some simple tests. yes, &error_abort or &error_fatal doesn't work.
> Current @errp of realize() can work because @errp points to @local_err
> in device_set_realized().

Thank you!

>> Is "propagate" semantics what you want here?
>> 
>> If not, use another name.
>
> I guess here we should call C version's error_propagate() instead of
> write():
>
> diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
> index a91ce6fefaf4..56622065ad22 100644
> --- a/rust/qemu-api/src/error.rs
> +++ b/rust/qemu-api/src/error.rs
> @@ -205,7 +205,7 @@ pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
>
>          // SAFETY: caller guarantees errp is valid
>          unsafe {
> -            errp.write(err);
> +            bindings::error_propagate(errp, err);
>          }
>      }
>
> ---
>
> Then Rust's propagate has the same behavior as C (Of course, here Rust
> is actually using C's error_propagate, so the two are equivalent.)

*If* we want propagate semantics.  I'm not sure we do.

If we don't: use error_handle()?


