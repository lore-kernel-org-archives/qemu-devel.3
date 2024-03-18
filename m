Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD9C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm91r-0006PK-Oq; Mon, 18 Mar 2024 05:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rm91q-0006Nq-CZ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rm91d-0004o0-Tx
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710753078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INKZYE/7LaKnc215emtkrHVpGX5QXlCxza6kfENK2AY=;
 b=c7Vx81PcaNfyfojauNldx5HNOqtGnZYSf4FKEWnNCTC3/iVdto66lj88FKk+Qq80Oti5Yx
 YabzeJGBT7CHaFljCaDImihDV6nQj26KmY0u4tsG2oJDepaTVin8w0OPOsqH11vFRnY7zn
 YMlN5Bs68swEPVS1qy6ySgzZE9r1VZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-bMTkdYifP5OGDPoC4ihzkA-1; Mon, 18 Mar 2024 05:11:16 -0400
X-MC-Unique: bMTkdYifP5OGDPoC4ihzkA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C447185A784;
 Mon, 18 Mar 2024 09:11:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F20B7492BDB;
 Mon, 18 Mar 2024 09:11:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E2EF21E6A28; Mon, 18 Mar 2024 10:11:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,  peter.maydell@linaro.org,  michael.roth@amd.com
Subject: Re: [PATCH v5 25/25] qapi: Dumb down QAPISchema.lookup_entity()
In-Reply-To: <20240315152301.3621858-26-armbru@redhat.com> (Markus
 Armbruster's message of "Fri, 15 Mar 2024 16:23:01 +0100")
References: <20240315152301.3621858-1-armbru@redhat.com>
 <20240315152301.3621858-26-armbru@redhat.com>
Date: Mon, 18 Mar 2024 10:11:11 +0100
Message-ID: <87v85j7vm8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> QAPISchema.lookup_entity() takes an optional type argument, a subtype
> of QAPISchemaDefinition, and returns that type or None.  Callers can
> use this to save themselves an isinstance() test.
>
> The only remaining user of this convenience feature is .lookup_type().
> But we don't actually save anything anymore there: we still the

we still need the

> isinstance() to help mypy over the hump.
>
> Drop the .lookup_entity() argument, and adjust .lookup_type().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


