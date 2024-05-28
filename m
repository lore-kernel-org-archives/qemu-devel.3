Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCAFC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 11:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBubR-0002kP-Mx; Tue, 28 May 2024 07:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBubP-0002k2-Hw
 for qemu-devel@nongnu.org; Tue, 28 May 2024 07:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBubN-0005yW-7j
 for qemu-devel@nongnu.org; Tue, 28 May 2024 07:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716894163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AeUmwpTzkKJEJoYr/eJWivPL1j8IP8f4hOzvAngFAE=;
 b=PDJIrmXvWgErTwF2GH6+tOyTtI3tRFn++Exd3j0L2LNaqtk31qVnvuDroc0pQKHhlWWbKZ
 olvVUPhJ6dwcT0TcbH6uzP2Tqyc/bvZZFcyfRdyBvWCT57DfedOuOM5pP0wpAQ+e9bLfMb
 A3TVO9/Uew7bwpVFAx01ja9J49FYBkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-jR9HIjMFPLi7eYGQTNJw7w-1; Tue, 28 May 2024 07:02:39 -0400
X-MC-Unique: jR9HIjMFPLi7eYGQTNJw7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5948B80028D;
 Tue, 28 May 2024 11:02:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27079105480A;
 Tue, 28 May 2024 11:02:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D93221E668F; Tue, 28 May 2024 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Laurent Vivier
 <lvivier@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/4] qapi: Do not cast function pointers
In-Reply-To: <20240524-xkb-v4-3-2de564e5c859@daynix.com> (Akihiko Odaki's
 message of "Fri, 24 May 2024 14:35:49 +0900")
References: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
 <20240524-xkb-v4-3-2de564e5c859@daynix.com>
Date: Tue, 28 May 2024 13:02:37 +0200
Message-ID: <87r0dmw65u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> -fsanitize=undefined complains if function pointers are casted. It
> also prevents enabling teh strict mode of CFI which is currently

Typo: the

> disabled with -fsanitize-cfi-icall-generalize-pointers.

The above describes the problem the patch solves.  Good!  Two
suggestions:

1. Quote the error message.

2. Briefly describe the solution as well.  Perhaps:

  The problematic casts are necessary to pass visit_type_T() and
  visit_type_T_members() as callbacks to qapi_clone() and
  qapi_clone_members(), respectively.  Open-code these two functions to
  avoid the callbacks, and thus the type casts.

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2346
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Always kind of sad to move implementation code to headers, but getting
rid of the function pointer casts makes sense, and I don't have better
ideas for doing that.

With an improved commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>


