Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BE5CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXgH-00083y-4D; Fri, 19 Sep 2025 05:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzXgB-00083J-In
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzXg8-0007mH-Pe
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758275118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xacy4n2iqw0p2UzBkRZQnQpPyvN0wqHYwJ+s8/sPhDc=;
 b=MgELkKC4s8vLb0GLuyOK97wjwxEAhOKv8ipxcH7q4J7yy2NMwqPPOxpNrN0lh5QGc+LYMX
 4eekikllXH3M7R8EAD1xyHxNkDflHFPM3IgXvMXeHmILP4Cln+Iq432upuJXogi/eO5Gkm
 x9mMHT+dd8W7EKY0CcMa0YPzirBhh+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-vtDI4ET-Psq23wmqW7oMfw-1; Fri,
 19 Sep 2025 05:45:12 -0400
X-MC-Unique: vtDI4ET-Psq23wmqW7oMfw-1
X-Mimecast-MFC-AGG-ID: vtDI4ET-Psq23wmqW7oMfw_1758275111
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D316718004D8; Fri, 19 Sep 2025 09:45:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8431230002C5; Fri, 19 Sep 2025 09:45:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99F4221E6A27; Fri, 19 Sep 2025 11:45:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 qemu-stable@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] linux-user: avoid -Werror=int-in-bool-context
In-Reply-To: <CAFEAcA8BBisMO3VJF=bb0a7oQCK16P4NhtTxcWRNRg0yMTWtwg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 19 Sep 2025 10:33:02 +0100")
References: <20250919083612.86546-1-pbonzini@redhat.com>
 <CAFEAcA8BBisMO3VJF=bb0a7oQCK16P4NhtTxcWRNRg0yMTWtwg@mail.gmail.com>
Date: Fri, 19 Sep 2025 11:45:08 +0200
Message-ID: <87tt0y3hej.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 19 Sept 2025 at 09:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> linux-user is failing to compile on Fedora 43:
>>
>> ../linux-user/strace.c:57:66: error: enum constant in boolean context [-Werror=int-in-bool-context]
>>    57 | #define FLAG_BASIC(V, M, N)      { V, M | QEMU_BUILD_BUG_ON_ZERO(!(M)), N }
>>
>> The warning does not seem to useful and we could even disable it, but
>> the workaround is simple in this case.
>
> I'm surprised this is the only place in the codebase
> where we treat an int as a bool...

It definitely isn't.  Idiomatic C...


