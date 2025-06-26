Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABFDC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 09:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUj5m-0005ib-Tx; Thu, 26 Jun 2025 05:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUj5e-0005db-2X
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUj5b-0007Q5-LY
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750930814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8PuF75Nddbzy9CQshdzRlsef/GYEOZVsWvxuG6Dd7Fc=;
 b=Oi5eOpHgtDFqffPs06ARm615T32C9TqboopgsaolnYeXBzod9g+enUjexgxFlKVYk5NOUz
 r6htdkoLhdarU3pbZE7/LLkK8q7tA+4TaE6DPQzd2Itbgj/DS3E11VuEaCXQ/UUx3H0+yW
 qhTEn/nCUMlR3IyGPuERxaE6LcPugos=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-cNpl7toBMomvpKakLka8Zw-1; Thu,
 26 Jun 2025 05:40:12 -0400
X-MC-Unique: cNpl7toBMomvpKakLka8Zw-1
X-Mimecast-MFC-AGG-ID: cNpl7toBMomvpKakLka8Zw_1750930811
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 383721956086; Thu, 26 Jun 2025 09:40:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C9D30002C0; Thu, 26 Jun 2025 09:40:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1018021E6A27; Thu, 26 Jun 2025 11:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 02/21] migration: Remove MigrateSetParameters
In-Reply-To: <875xgj7n51.fsf@suse.de> (Fabiano Rosas's message of "Wed, 25 Jun
 2025 14:21:30 -0300")
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-3-farosas@suse.de> <87y0tg5a7l.fsf@pond.sub.org>
 <875xgj7n51.fsf@suse.de>
Date: Thu, 26 Jun 2025 11:40:08 +0200
Message-ID: <87ikkiyh6v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Now that the TLS options have been made the same between
>>> migrate-set-parameters and query-migrate-parameters, a single type can
>>> be used. Remove MigrateSetParameters.
>>>
>>> The TLS options documentation from MigrationParameters were replaced
>>> with the ones from MigrateSetParameters which was more complete.
>>>
>>> I'm choosing to somewhat ignore any ambiguity between "query" and
>>> "set" because other options' docs are already ambiguous in that
>>> regard.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  migration/migration-hmp-cmds.c |   4 +-
>>>  migration/options.c            |   6 +-
>>>  qapi/migration.json            | 221 +++------------------------------
>>>  3 files changed, 20 insertions(+), 211 deletions(-)
>>>
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>>> index bc8179c582..aacffdc532 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -490,7 +490,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>>      const char *param = qdict_get_str(qdict, "parameter");
>>>      const char *valuestr = qdict_get_str(qdict, "value");
>>>      Visitor *v = string_input_visitor_new(valuestr);
>>> -    MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
>>> +    MigrationParameters *p = g_new0(MigrationParameters, 1);
>>>      uint64_t valuebw = 0;
>>>      uint64_t cache_size;
>>>      Error *err = NULL;
>>> @@ -656,7 +656,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>>      qmp_migrate_set_parameters(p, &err);
>>>  
>>>   cleanup:
>>> -    qapi_free_MigrateSetParameters(p);
>>> +    qapi_free_MigrationParameters(p);
>>>      visit_free(v);
>>>      hmp_handle_error(mon, err);
>>>  }
>>> diff --git a/migration/options.c b/migration/options.c
>>> index 45a95dc6da..e49d584a99 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -1227,7 +1227,7 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>>      return true;
>>>  }
>>>  
>>> -static void migrate_params_test_apply(MigrateSetParameters *params,
>>> +static void migrate_params_test_apply(MigrationParameters *params,
>>>                                        MigrationParameters *dest)
>>>  {
>>>      *dest = migrate_get_current()->parameters;
>>> @@ -1350,7 +1350,7 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>>      }
>>>  }
>>>  
>>> -static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>> +static void migrate_params_apply(MigrationParameters *params, Error **errp)
>>>  {
>>>      MigrationState *s = migrate_get_current();
>>>  
>>> @@ -1479,7 +1479,7 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>>      }
>>>  }
>>>  
>>> -void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>>> +void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
>>>  {
>>>      MigrationParameters tmp;
>>>  
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index fa42d94810..080968993a 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -914,202 +914,6 @@
>>>             'zero-page-detection',
>>>             'direct-io'] }
>>>  
>>> -##
>>> -# @MigrateSetParameters:
>>
>> Only use is argument type of migrate-set-parameters.  You're replacing
>> it by MigrationParameters there.  Let's compare the deleted docs to
>> their replacement.  I'll quote replacement docs exactly where they
>> differ.
>>
>>    # @MigrationParameters:
>>    #
>>    # Migration parameters. Optional members are optional when used with
>>    # an input command, otherwise mandatory.
>>
>> Figuring out which commands are input commands is left to the reader.
>> Why not simply "optional with migrate-set-parameters"?
>>
>
> Future patches include migrate and migrate-incoming. I can enumerate
> them if that's better.

Not necessary if you move the note to commands as discussed below.

>> However, it doesn't end there.  The paragraph creates a problem with
>> John Snow's "inliner", which I hope to merge later this year.  Let me
>> explain.
>>
>> Generated command documentation normally looks like this:
>>
>>     Command migrate-set-capabilities (Since: 1.2)
>>
>>        Enable/Disable the following migration capabilities (like xbzrle)
>>
>>        Arguments:
>>           * **capabilities** ("[""MigrationCapabilityStatus""]") -- json
>>             array of capability modifications to make
>>
>> Except when we happen to use a named type for the arguments.  This
>> should be an implementation detail, and it is, except for generated
>> documentation, which looks like
>>
>>     Command migrate-set-parameters (Since: 2.4)
>>
>>        Set various migration parameters.
>>
>>        Arguments:
>>           * The members of "MigrationParameters".
>>
>> The arguments are hidden behind a link.  The "inliner" will show the
>> them normally *always*, for better usability.  It will not, however,
>> inline the introductory paragraph above.  I can explain why if
>> necessary.
>>
>> To compensate for the loss of that paragraph, we'll have to add suitable
>> text to migrate-set-parameters's doc comment.
>>
>> I think we could just as well do that *now*: scratch the paragraph here,
>> add a suitable paragraph there.
>>
>
> Ok, no worries.

[...]


