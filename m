Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD25D3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVUI-00012x-JP; Mon, 25 Nov 2024 04:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFVUG-00011o-1H
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFVUD-0003WK-RF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 04:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732527267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLTUdn598AI79vI7KWSTBzRXubivT3Ph6InPaaDPg8k=;
 b=Uh8zKNCTenbMOyM15BCRQsd/cG9Cfzhpu5b5QnUPqiHJlTsQ993jTerhS3kMHhs0Y1tv9C
 t/0W16PDGEYgej08amVa0u6atFslbminqdowhtpMCKffmBkAzVSAPMn26sDZT1gv+ZjK8J
 pAOmFe+FjKwQ7jDwUOHQ+f0U0T1eS44=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-uMfDMde2Mo2-eAjikeC8sQ-1; Mon,
 25 Nov 2024 04:34:24 -0500
X-MC-Unique: uMfDMde2Mo2-eAjikeC8sQ-1
X-Mimecast-MFC-AGG-ID: uMfDMde2Mo2-eAjikeC8sQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA55D19540F2; Mon, 25 Nov 2024 09:34:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E9B195E481; Mon, 25 Nov 2024 09:34:18 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:34:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Supporting clang on windows
Message-ID: <Z0REl6xtaYuvP876@redhat.com>
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Nov 25, 2024 at 08:00:00AM +0100, Paolo Bonzini wrote:
> On Sun, Nov 24, 2024 at 9:23 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> > -mms-bitfields is already the (silent) gcc default on windows, to mimic
> > MSVC behaviour. Yes, it would be preferable to use this default and
> > gcc_struct attribute, but right now, it does not work with clang. So the
> > whole point is to accept a compromise for this.
> > I don't understand the strong pushback against clang support on windows.
> > Because of a "theoretical" problem, that was proved here we don't have
> > currently, we are stuck with gcc_struct attribute.
> 
> I think you are unnecessarily pessimistic:
> 
> * there is no need for a compromise, eliminating gcc_struct is the
> best solution but it needs proof that it introduces no guest-visible
> changes
> 
> * there is no pushback against clang support, there is pushback
> against asking for a change without understanding the problem

To expand on this...

Bear in mind that when stuff breaks, users file bugs, and the QEMU
maintainers are on the receiving end of user demands to investigate
and fix the problem.

These kind of issues have the potential to be very hard to debug
and diagnose. Maintainer time is precious, which is why we're
conservative at making decisions that expose us to potential long
term negative consequences / increased workload. Compiling with
flags that were known to be incompatible with our code historically
is a reasonable thing to reject. It should not be unexpected that
when a request to change this has a higher burden of proof that
other proposals.

> clang's lack of support for gcc_struct is stupid, but we have to work
> around it and we can, without introducing potential ABI breaks. Just
> verify that gcc_struct still has any effect. Initially I mentioned
> checking sizeof() but actually it's possible to do the same using
> debug info, similar to your scripts.

IMHO we need to have confidence not only in the current state of the code,
but also that we're not going to accidentally regresss it in the future.
This is what the gcc_struct attribute gives us confidence in.

If we can do an assert with a 'sizeof' check, that would give us similar,
but I presume any sizeof checks need to be manually written to specify
the expected size ? A manual check for pahole output by comparison only
tells us about the current point in time of QEMU code.

As an alternative is it practical for us to eliminate all bitfields
from our structs ? IIUC, we already have the preference that we use
the 'BIT(n)' and 'BIT_ULL(n)' macros for accessing bits from full
sized int32/int64 fields which avoids the semantic layout problems.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


