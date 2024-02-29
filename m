Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC9C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfirx-0000jI-64; Thu, 29 Feb 2024 11:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfirr-0000iR-Nx
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfiro-00079g-VE
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709222559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+ZVzG6fyryFXzZbktppWR3lwqy70D2BqNW0CuTBnvY=;
 b=P6sPodVkliiwS1oIGc8ifaGuZoYensv45pbBRfWoiw0N0Dzip7miyVkx45C+jjRV6CM28V
 P+aKvipjd6PuOmx9/caMnNWxmKVZgk/inJMgCMopa7rA8rWdgF6tZS9/k5FlDB84w2d/AU
 zKrRuEPRFwmRjYREuWc9HCky3xKh8vE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-AvTMOSx5PYGQyWrtf9FBNA-1; Thu,
 29 Feb 2024 11:02:37 -0500
X-MC-Unique: AvTMOSx5PYGQyWrtf9FBNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F26461C06505;
 Thu, 29 Feb 2024 16:02:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F3C240C6EBA;
 Thu, 29 Feb 2024 16:02:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A6CE21E6740; Thu, 29 Feb 2024 17:02:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>,  Michael Tokarev <mjt@tls.msk.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 16/16] hw/core/qdev-properties-system: Fix missing
 ERRP_GUARD() for error_prepend()
In-Reply-To: <ZeCo9A82Uqi3TKBM@intel.com> (Zhao Liu's message of "Thu, 29 Feb
 2024 23:55:32 +0800")
References: <20240228163723.1775791-1-zhao1.liu@linux.intel.com>
 <20240228163723.1775791-17-zhao1.liu@linux.intel.com>
 <87frxbuy05.fsf@pond.sub.org> <ZeCo9A82Uqi3TKBM@intel.com>
Date: Thu, 29 Feb 2024 17:02:35 +0100
Message-ID: <87zfvjtg10.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> Hi Markus,
>
>> > ERRP_GUARD() could avoid the case when @errp is the pointer of
>> > error_fatal, the user can't see this additional information, because
>> 
>> Suggest "when @errp is &error_fatal"
>
> Sure! It's clearer.
>
>> > exit() happens in error_setg earlier than information is added [1].
>> >
>> > The set_chr() passes @errp to error_prepend() without ERRP_GUARD().
>> >
>> > As a PropertyInfo.set method, the @errp passed to set_chr() is so widely
>> > sourced that it is necessary to protect it with ERRP_GUARD().
>> 
>> "sourced"?  Do you mean "used"?
>> 
>> Are you trying to say something like "there are too many possible
>> callers for me to check the impact of this defect; it may or may not be
>> harmless."
>
> Yes! Very well expressed. Thanks for your words.

You're welcome!  Go ahead and replace your sentence with it.

>> > To avoid the issue like [1] said, add missing ERRP_GUARD() at the
>> > beginning of this function.
>> >
>
> [snip]
>
>> Commit message could use a bit of polish.  Regardless
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> 
>
> Thanks!
>
> -Zhao


