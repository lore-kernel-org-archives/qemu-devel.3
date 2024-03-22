Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF1C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfd7-0003jl-0s; Fri, 22 Mar 2024 10:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfd3-0003eL-KG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfd1-0004Fk-JJ
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PkkMj4l2HKx0Qfm2+N64kiO84ZuDJSRw04ejTSVNncI=;
 b=MYvjxP0V98qbdMQ1tcB8m+xG6uhtCRKX7p9XwGAbG2YSqtAsqUcLdnViZ5hzMByxRYtA1o
 mK8BAe7yHtuBdbr3jyMpXyA4TJoyHAYhiMFgNNzfmVtQQ2pgqIG0/YkQULON7MHtL2QEBl
 BgPmxT/4zI4E/Jw0Pn3RBr/Erq380kI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-Ai3aJ4MPM2G0GDru6_fQzQ-1; Fri,
 22 Mar 2024 10:12:11 -0400
X-MC-Unique: Ai3aJ4MPM2G0GDru6_fQzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB529282D3D2;
 Fri, 22 Mar 2024 14:12:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AC65C1576F;
 Fri, 22 Mar 2024 14:12:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AD4921E680D; Fri, 22 Mar 2024 15:12:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 peterx@redhat.com,  eblake@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH 1/3] qapi: Improve migration TLS documentation
In-Reply-To: <875xxemkkt.fsf@suse.de> (Fabiano Rosas's message of "Fri, 22 Mar
 2024 11:01:54 -0300")
References: <20240322135117.195489-1-armbru@redhat.com>
 <20240322135117.195489-2-armbru@redhat.com> <875xxemkkt.fsf@suse.de>
Date: Fri, 22 Mar 2024 15:12:05 +0100
Message-ID: <87o7b6we2y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> MigrateSetParameters is about setting parameters, and
>> MigrationParameters is about querying them.  Their documentation of
>> @tls-creds and @tls-hostname has residual damage from a failed attempt
>> at de-duplicating them (see commit de63ab61241 "migrate: Share common
>> MigrationParameters struct" and commit 1bda8b3c695 "migration: Unshare
>> MigrationParameters struct for now").
>>
>> MigrateSetParameters documentation issues:
>>
>> * It claims plain text mode "was reported by omitting tls-creds"
>>   before 2.9.  MigrateSetParameters is not used for reporting, so this
>>   is misleading.  Delete.
>>
>> * It similarly claims hostname defaulting to migration URI "was
>>   reported by omitting tls-hostname" before 2.9.  Delete as well.
>>
>> Rephrase the remaining @tls-hostname contents for clarity.
>>
>> Enum MigrationParameter mirrors the members of struct
>> MigrateSetParameters.  Differences to MigrateSetParameters's member
>> documentation are pointless.  Copy the new text to MigrationParameter.
>>
>> MigrationParameters documentation issues:
>>
>> * @tls-creds runs the two last sentences together without punctuation.
>>   Fix that.
>>
>> * Much of the contents on @tls-hostname only applies to setting
>>   parameters, resulting in confusion.  Replace by a suitable abridged
>>   version of the new MigrateSetParameters text, and a note on
>>   @tls-hostname omission in 2.8.
>>
>> Additional damage is due to flawed doc fix commit
>> 66fcb9d651d (qapi/migration: Add missing tls-authz documentation):
>> since it copied the missing MigrateSetParameters text from
>> MigrationParameters instead of MigrationParameter, the part on
>> recreating @tls-authz on the fly is missing.  Copy that, too.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/migration.json | 63 +++++++++++++++++++++++----------------------
>>  1 file changed, 32 insertions(+), 31 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index aa1b39bce1..cbcc6946eb 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -809,16 +809,19 @@
>>  #     for establishing a TLS connection over the migration data
>>  #     channel.  On the outgoing side of the migration, the credentials
>>  #     must be for a 'client' endpoint, while for the incoming side the
>> -#     credentials must be for a 'server' endpoint.  Setting this will
>> -#     enable TLS for all migrations.  The default is unset, resulting
>> -#     in unsecured migration at the QEMU level.  (Since 2.7)
>> +#     credentials must be for a 'server' endpoint.  Setting this to a
>> +#     non-empty string enables TLS for all migrations.  An empty
>> +#     string means that QEMU will use plain text mode for migration,
>> +#     rather than TLS.  (Since 2.7)
>>  #
>> -# @tls-hostname: hostname of the target host for the migration.  This
>> -#     is required when using x509 based TLS credentials and the
>> -#     migration URI does not already include a hostname.  For example
>> -#     if using fd: or exec: based migration, the hostname must be
>> -#     provided so that the server's x509 certificate identity can be
>> -#     validated.  (Since 2.7)
>> +# @tls-hostname: migration target's hostname for validating the
>> +#     server's x509 certificate identify.  If empty, QEMU will use the
>
> identity

ACK!  Also the other two copies you noted.  Thanks!

[...]


