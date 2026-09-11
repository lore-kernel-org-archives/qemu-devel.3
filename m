Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ACBC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4wNG-00040Q-Dn; Fri, 11 Sep 2026 04:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wNE-000406-9R
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4wNB-0006dx-Qw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 04:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789114356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ukMzkwgViU2fi5Os7PRjjIMzSEkzlAVHygo4kxgwRE=;
 b=b1a3EsjF23Zqa7UuOdXyjhTDIG/ScLJWhw3e6Q5YPOTEG/6GBlG0lRkCAbiQtythD1MEsl
 ZvijMN0jpI8VRxANCrUt21ntVT9x3MhYDx4KjPdVP5JPFnxfuMZfX4csCIOrRwK53S2xIi
 /7zyQR5ao1MiCubP2NbkVevhqUxFeN0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--4jZ7s-LPkOldS-4pV_vwg-1; Fri,
 11 Sep 2026 04:12:30 -0400
X-MC-Unique: -4jZ7s-LPkOldS-4pV_vwg-1
X-Mimecast-MFC-AGG-ID: -4jZ7s-LPkOldS-4pV_vwg_1789114349
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082CE195423B; Fri, 11 Sep 2026 08:12:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D1C030001A2; Fri, 11 Sep 2026 08:12:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BDFE721E6A04; Fri, 11 Sep 2026 10:12:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 13/18] migration: Use keyval input visitor in HMP set
 command
In-Reply-To: <87qzj1tcpl.fsf@suse.de> (Fabiano Rosas's message of "Thu, 10 Sep
 2026 11:15:02 -0300")
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-14-farosas@suse.de>
 <87qzj1e563.fsf@pond.sub.org> <87qzj1tcpl.fsf@suse.de>
Date: Fri, 11 Sep 2026 10:12:25 +0200
Message-ID: <8733vgb40m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Change the hmp_migrate_set_parameter command to use a keyval input
>>> visitor.
>>>
>>> Currently a string visitor is used and due to limitations of that
>>> particular visitor's implementation it's necessary to consult the QAPI
>>> type enum (MigrationParameter_lookup) and call each visit_type_*
>>> function individually. Which makes using a visitor pointless.
>>
>> Also, the less the string visitors are used, the happier I am.
>>
>>> Since there are other visitors implemented properly and generated code
>>> to iterate the QAPI object, prefer using one of those. The keyval
>>> input visitor is adequate because HMP provides basically one key and
>>> one value for each migrate_set_parameter command.
>>>
>>> To switch from string_input_visitor to keyval_input_visitor simply put
>>> the parameter name and value into a dict and invoke
>>> visit_type_MigrationParameters().
>>
>> This works for scalar types: the value is a QString, and the QObject
>> keyval input visitor automatically converts to the C type the visitor
>> expects.  It doesn't work for non-scalar types; see cpr-exec-command
>> below.
>>
>>> Note that it's not necessary to go through any of the keyval_* code
>>> because due to the nature of HMP, there's no parsing to do (no '=', no
>>> ',', etc).
>>
>> migrate_set_parameter syntax isn't keyval, only val is, i.e. its value
>> argument is in keyval value syntax (more or less).
>>
>> "More or less" is my hedge against differences between the string input
>> visitor and the QObject keyval input visitor.  Did you check?
>>
>
> They ultimately use the same functions to do the conversion
> (qemu_strtou64, qemu_strtod_finite, etc). The differences are in
> slightly different wording of error messages and the fact that the
> string input visitor has a different message for -ERANGE while the
> qobject input visitor has a TODO for that case.
>
> I think those differences are of no consequence. The error messages that
> we really care about are the ones resulting from the migration code
> validation (because they're informative to the user). The API level
> messages are too generic anyway.

Should the commit message make this argument?

>> Aside: we could create migrate_set_parameters with keyval syntax if we
>> cared.
>>
>>> With this the migrate_set_parameters HMP commands will be
>>> automatically updated anytime a new migration parameter is added.
>>>
>>> One parameter, "cpr-exec-command", takes the strList type which needs
>>> to be built manually. This moves to a "legacy" suffixed function.
>>
>> When visit_type_MigrationParameters() visits "cpr-exec-command", it
>> calls visit_type_strList().  With the QObject keyval input visitor, this
>> expects a QList, not a QString.
>>
>> Thus, hmp_migrate_set_parameter() needs to parse the value argument into
>> a list at least.  That's why it needs to be a special case.
>>
>
> I'm having some difficulty understanding why isn't that the job of the
> visit function.
>
> I think what you're saying is that we can convert QAPI's strList into
> QObject's QList of QString, but cannot convert the HMP string directly
> into QList even though we know that string represents a strList. I feel
> like there's code missing somewhere...

This is due to separation of concerns in the design of the visitor
pipelines.  Example:

         JSON         input
        parser       visitor
    JSON ---> QObject ---> QAPI-generated C type

         JSON         output
       formatter     visitor
    JSON <--- QObject <--- QAPI-generated C type

Parser/formatter deal with JSON.  All they know about QAPI is QObject.

Visitors deal with QAPI-generated C types.  All they know about JSON is
QObject.

Keyval came much later, and we had to accept a weaker separation for it.
In JSON, the type of scalars is explicit in the syntax.  In keyval, it
is not.  So scalar values are always strings in the parser's output, and
the QObject keyval visitor needs to parse these strings.  This leads to
restrictions discussed in keyval.c's big comment.

But this applies *only* to scalars!  The separation still holds for
objects and arrays.

> ... although it wouldn't help with cpr-exec-command because of the
> "shell parsing" semantics. But that's another issue.

Yes.

>> It parses it with g_shell_parse_argv().  GLib docs "specify" this to
>> parse "a command line [...] in much the same way the shell would, but
>> without many of the expansions the shell would perform (variable
>> expansion, globs, operators, filename expansion, etc. are not
>> supported)."  Ugh!  But I digress.
>
> One side-effect of having code that handles parameters genericly is that
> there is less room for inventing custom parsing when new parameters are
> introduced.

We use g_shell_parse_argv() for cpr-exec-command and nothing else, which
effectively makes it custom syntax.  At least it's custom syntax we
didn't design and implement, but still.  Too.  Much.  Syntax.  Too.
Many.  Parsers.

>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

>>> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
>>> index 2261ae7c89..4ac2f42a5a 100644
>>> --- a/tests/qtest/migration/misc-tests.c
>>> +++ b/tests/qtest/migration/misc-tests.c
>>> @@ -50,7 +50,7 @@ typedef struct HMPTestData {
>>>  HMPTestData test_cases[] = {
>>>      TEST("", "", "migrate_set_parameter: string expected"),
>>>      TEST("foo", "", "migrate_set_parameter: string expected"),
>>> -    TEST("foo", "on", "Error: invalid parameter value: foo"),
>>> +    TEST("foo", "on", "Error: Parameter 'foo' is unexpected"),
>>
>> This appears to be an improvement.  Where does it come from?
>>
>
> Old code went through the enum lookup whereas now the QObject visitor's
> qobject_input_check_struct flags the struct member name.

hmp_migrate_set_parameter() takes a parameter argument that names a
member of MigrationParameters.  Trick: it parses it as a member of
related type MigrationParameter, with qapi_enum_parse().  Since the
members of MigrationParameter are *values*, qapi_enum_parse() reasonably
reports "invalid parameter value".

Trickery breed bad error messages, film at eleven.

Suggest to mention the improvement in the commit message.

>>>  
>>>      /* bool */
>>>      TEST("cpu-throttle-tailslow", "on", "on"),


