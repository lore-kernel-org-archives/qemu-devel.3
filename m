Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C318E6BF0B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 13:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlo6m-0001xO-AS; Fri, 30 Jan 2026 08:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vlo6k-0001wy-Qb
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vlo6j-0004Dh-9I
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 08:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769778015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jf7iKSggsgEKMs2PudMNrxhonBP+inDRAov8nfr+xV8=;
 b=HBXgUsmSQdYDqtdA3MT8NTACUA5/McFnPHaS1rkmsEk5kQAiIngA0+kNjYM3HDlSZCD5fp
 4EY+5Ib+kD7AbMgBK52IcKqdVrRrW3DpwGoYNY2BUS2lNiWGJtefZlKEgCMgHJpcKOS/H7
 8vhT0kcEuGIH70CAkjUS7wzhGfM9RPM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-8HVRv2LfP0OSYoZyibeOPA-1; Fri,
 30 Jan 2026 08:00:13 -0500
X-MC-Unique: 8HVRv2LfP0OSYoZyibeOPA-1
X-Mimecast-MFC-AGG-ID: 8HVRv2LfP0OSYoZyibeOPA_1769778013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 181CF180047F
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 13:00:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBC741800965
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 13:00:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 416CF21E692D; Fri, 30 Jan 2026 14:00:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
In-Reply-To: <20260107084840.150843-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 7 Jan 2026 09:48:35 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
Date: Fri, 30 Jan 2026 14:00:10 +0100
Message-ID: <87ldhffe79.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> This rewrites the json-parser to use a push parser aka state machine.
> While push parsers are inherently more complex than recursive descent,
> the grammar for JSON is simple enough that the parser remains readable.
> There is therefore no need to use e.g. QEMU coroutines.
>
> Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
> to consume JSON values", 2018-08-24), I kept the json-streamer concept.
> It helps in handling input limits, it performs error recovery, and it
> converts the token-at-a-time push interface to callbacks---all things
> that are more easily done in a separate layer to keep the parser clean.
> However, there is no need anymore for it to store partial JSON objects
> in tokenized form.
>
> Another benefit is that QEMU can report the first parsing error
> immediately, without waiting for delimiters to be balanced.

Sounds promising!  Let's see...

Before the series:

     $ socat "READLINE,prompt=QMP> " UNIX-CONNECT:$HOME/work/images/test-qmp 
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 10}, "package": "v10.2.0-567-gfb6b66de43-dirty"}, "capabilities": ["oob"]}}
    QMP> [{"a"]

Parse error not diagnosed right away, but ...

    QMP> }
    {"error": {"class": "GenericError", "desc": "JSON parse error, missing : in object pair"}}

.... only when the streamer decides the expression is complete.

After the series:

    QMP> [{"a"]
    {"error": {"class": "GenericError", "desc": "JSON parse error at line 1, column 6, expecting ':'"}}

Cool!  However, if I do it again, things fall apart:

    QMP> [{"a"
    QMP> }
    QMP> }
    QMP> }
    QMP> ]
    QMP> ]
    {"error": {"class": "GenericError", "desc": "JSON parse error at line 7, column 1, expecting value"}}

Parse error recovery not quite right?

> On top of the benefits intrinsic in the push architecture, it so happens
> that it's really easy to add a location to JSON parsing errors now, so
> do that as well.
>
> Paolo


