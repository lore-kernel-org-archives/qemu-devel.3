Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96331C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 09:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFUy7-0004R5-L3; Thu, 15 May 2025 05:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFUy5-0004Q6-HD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFUy2-00028q-3p
 for qemu-devel@nongnu.org; Thu, 15 May 2025 05:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747301608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0B32UzCU9A9XAmpzZbboFKUM38urDHu4/PvK6aKy2I=;
 b=Gk06hNlBUiEm7nbUtowhCY9F7fBMJGpzSVoITk+nclA8e1VBenLPiLcmjfD/f2WcNRJcTR
 vFoiANief9D38UxcdhOlWJ98LkIPelvOd6OkOEbzJatT4xwAf6FARzl+UP8vuZGQC+b57k
 G3ZyON1nCpGVoBpK9WEAIRhjMIKzVrc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-IkeR0dFQMPS9XNjeK_TX8A-1; Thu,
 15 May 2025 05:33:24 -0400
X-MC-Unique: IkeR0dFQMPS9XNjeK_TX8A-1
X-Mimecast-MFC-AGG-ID: IkeR0dFQMPS9XNjeK_TX8A_1747301603
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ABE8195608D; Thu, 15 May 2025 09:33:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBB51956066; Thu, 15 May 2025 09:33:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BE5D21E66C2; Thu, 15 May 2025 11:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 alex.bennee@linaro.org,  philmd@linaro.org, christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 07/20] mcd: Implement target initialization API
In-Reply-To: <2699a98b-ca71-4cda-acfc-e334d765c9cb@lauterbach.com> (Mario
 Fleischmann's message of "Wed, 14 May 2025 15:59:32 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-8-mario.fleischmann@lauterbach.com>
 <87jz6re2ch.fsf@pond.sub.org>
 <2699a98b-ca71-4cda-acfc-e334d765c9cb@lauterbach.com>
Date: Thu, 15 May 2025 11:33:18 +0200
Message-ID: <871psq2p7l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> Thank you very much for the review!
>
> On 08.05.2025 14:04, Markus Armbruster wrote:
>
>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>> 
>>> The target initialization API ensures that the requested and provided
>>> MCD versions are compatible.
>>>
>>> * implement mcd_initialize_f and mcd_qry_error_info_f in mcdserver
>>> * implement QMP stub functionality
>>> * add QTest
>>>
>>> Thanks to the QMP integration in QTest, function arguments and results
>>> can be (de)serialized automatically.
>>>
>>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>

[...]

>>> diff --git a/mcd/meson.build b/mcd/meson.build
>>> index 191f0cc..2adaa1b 100644
>>> --- a/mcd/meson.build
>>> +++ b/mcd/meson.build
>>> @@ -1,14 +1,10 @@
>>>  mcd_qapi_outputs = [
>>> -  'mcd-qapi-commands.c',
>>> -  'mcd-qapi-commands.h',
>>>    'mcd-qapi-emit-events.c',
>>>    'mcd-qapi-emit-events.h',
>>>    'mcd-qapi-events.c',
>>>    'mcd-qapi-events.h',
>>>    'mcd-qapi-features.c',
>>>    'mcd-qapi-features.h',
>>> -  'mcd-qapi-init-commands.c',
>>> -  'mcd-qapi-init-commands.h',
>>>    'mcd-qapi-introspect.c',
>>>    'mcd-qapi-introspect.h',
>>>    'mcd-qapi-types.c',
>>> @@ -17,27 +13,48 @@ mcd_qapi_outputs = [
>>>    'mcd-qapi-visit.h',
>>>  ]
>>>  
>>> +# QAPI outputs that will only be used by the MCD server
>>> +mcd_qapi_server_outputs = [
>>> +  'mcd-qapi-commands.c',
>>> +  'mcd-qapi-commands.h',
>>> +  'mcd-qapi-init-commands.c',
>>> +  'mcd-qapi-init-commands.h'
>>> +]
>>> +
>>>  mcd_qapi_files = custom_target('MCD QAPI files',
>>> -                               output: mcd_qapi_outputs,
>>> +                               output: mcd_qapi_outputs + mcd_qapi_server_outputs,
>>>                                 input: '../qapi/mcd.json',
>>>                                 command: [ qapi_gen, '-p', 'mcd-', '-o', 'mcd',
>>>                                            '--suppress-tracing','@INPUT0@'],
>>>                                 depend_files: qapi_gen_depends)
>>>  
>>> -mcd_ss = ss.source_set()
>>> +mcd_qapi_ss = ss.source_set()
>>>  
>>> -mcd_ss.add(mcd_qapi_files.to_list())
>>> -mcd_ss.add(files(
>>> -  'mcd_server.c',
>>> -  'mcd_stub.c',
>>> -  'mcd_monitor.c'))
>>> +foreach f : mcd_qapi_files.to_list()
>>> +  if mcd_qapi_outputs.contains(fs.name(f))
>>> +    mcd_qapi_ss.add([f])
>>> +  endif
>>> +endforeach
>>>  
>>> -mcd_ss = mcd_ss.apply({})
>>> +mcd_qapi_ss.add(files('mcd_qapi.c'))
>>> +mcd_qapi_ss = mcd_qapi_ss.apply({})
>>>  
>>> -libmcd = static_library('mcd_system',
>>> -                        mcd_ss.sources() + genh,
>>> +libmcd_qapi = static_library('mcd_qapi',
>>> +                        mcd_qapi_ss.sources() + genh,
>>>                          build_by_default: false)
>>>  
>>> -mcd = declare_dependency(objects: libmcd.extract_all_objects(recursive: false))
>>> +mcd_qapi = declare_dependency(
>>> +    objects: libmcd_qapi.extract_all_objects(recursive: false))
>>> +
>>> +foreach f : mcd_qapi_files.to_list()
>>> +  if mcd_qapi_server_outputs.contains(fs.name(f))
>>> +    libsystem_ss.add([f])
>>> +  endif
>>> +endforeach
>>> +
>>> +libsystem_ss.add(files(
>>> +  'mcd_server.c',
>>> +  'mcd_stub.c',
>>> +  'mcd_monitor.c'))
>>>  
>>> -system_ss.add(mcd)
>>> +libsystem_ss.add(mcd_qapi)
>> 
>> The commit message did not prepare me for such changes to meson.build.
>> What are you doing here?
>
> I understand that this requires further comments...
> The goal is to provide the marshal helpers from mcd_qapi to mcd-test. We
> cannot use meson's mcd dependency for that since that would result in
> linker errors for functions that are not needed anyway:
>
>   cc -m64  -o tests/qtest/mcd-test [...]
>   build/../mcd/mcd_monitor.c:53: undefined reference to `monitor_puts'
>
> So we split meson's mcd dependency into two parts, one of them being
> mcd_qapi which will be used by mcd-test:
>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 3dc9508..11a9270 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -398,7 +398,7 @@ if dbus_display
>>  endif
>>  
>>  if get_option('mcd').enabled()
>> -  qtests += { 'mcd-test': files('mcd-test.c') }
>> +  qtests += { 'mcd-test': files('mcd-test.c', 'mcd-util.c') + mcd_qapi }
>>    qtests_generic += [ 'mcd-test' ]
>>  endif
>
> I should've probably included this already in
>   [PATCH v2 06/20] qtest: Introduce MCD test suite
> instead of keeping that version's meson files as simple as possible.

Might be less surprising there.

> Provided the explanation above makes sense, I will add a variant of it
> in the commit message for more context.

Yes, please!

> Thanks for pointing that out. After a working a longer stretch on a
> larger patch set, it's quite difficult to see which parts of the
> submission might be unclear.

True!

>>> diff --git a/qapi/mcd.json b/qapi/mcd.json
>>> index 701fd03..7b42a74 100644
>>> --- a/qapi/mcd.json
>>> +++ b/qapi/mcd.json
>>> @@ -4,3 +4,186 @@
>>>  ##
>>>  # = Multi-Core Debug (MCD) API
>>>  ##
>>> +
>>> +
>>> +##
>>> +# == Definition of Structures
>>> +##
>>> +
>>> +
>>> +##
>>> +# @MCDAPIVersion:
>>> +#
>>> +# Structure type containing the MCD API version information of the tool.
>>> +#
>>> +# @v-api-major: API major version.
>>> +# @v-api-minor: API minor version.
>>> +# @author:      API name of the author of this MCD API version.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'struct': 'MCDAPIVersion',
>>> +  'data': {
>>> +    'v-api-major': 'uint16',
>>> +    'v-api-minor': 'uint16',
>>> +    'author':      'str' } }
>>> +
>>> +
>>> +##
>>> +# @MCDImplVersionInfo:
>>> +#
>>> +# Structure type containing the MCD API implementation information.
>>> +#
>>> +# @v-api:       Implemented API version.
>>> +# @v-imp-major: Major version number of this implementation.
>>> +# @v-imp-minor: Minor version number of this implementation.
>>> +# @v-imp-build: Build number of this implementation.
>>> +# @vendor:      Name of vendor of the implementation.
>>> +# @date:        String from __DATE__ macro at compile time.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'struct': 'MCDImplVersionInfo',
>>> +  'data': {
>>> +    'v-api'      : 'MCDAPIVersion',
>>> +    'v-imp-major': 'uint16',
>>> +    'v-imp-minor': 'uint16',
>>> +    'v-imp-build': 'uint16',
>>> +    'vendor'     : 'str',
>>> +    'date'       : 'str' } }
>>> +
>>> +
>>> +##
>>> +# @MCDErrorInfo:
>>> +#
>>> +# Structure type containing the error status and error event notification.
>>> +#
>>> +# @return-status: Return status from the last API call.
>>> +# @error-code:    Detailed error code from the last API call.
>>> +# @error-events:  Detailed event code from the last API call.
>>> +# @error-str:     Detailed error text string from the last API call.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'struct': 'MCDErrorInfo',
>>> +  'data': {
>>> +    'return-status': 'uint32',
>>> +    'error-code'   : 'uint32',
>>> +    'error-events' : 'uint32',
>>> +    'error-str'    : 'str' }}
>>> +
>>> +
>>> +##
>>> +# == Target Initialization API
>>> +##
>>> +
>>> +
>>> +##
>>> +# @MCDInitializeResult:
>>> +#
>>> +# Return value of @mcd-initialize.
>>> +#
>>> +# @return-status: Return code.
>>> +#
>>> +# @impl-info: Information about the QEMU build, its version and the version of
>>> +#             the implemented MCD API.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'struct': 'MCDInitializeResult',
>>> +  'data': {
>>> +    'return-status': 'uint32',
>>> +    '*impl-info'   : 'MCDImplVersionInfo' } }
>>> +
>>> +
>>> +##
>>> +# @mcd-initialize:
>>> +#
>>> +# Function initializing the interaction between a tool-side implementation and
>>> +# target-side implementation.
>>> +#
>>> +# @version-req: MCD API version as requested by an upper layer.
>>> +#
>>> +# Returns: @MCDInitializeResult
>>> +#
>>> +# Since: 9.1
>>> +#
>>> +# .. qmp-example::
>>> +#    :title: Check compatibility with MCD server
>>> +#
>>> +#     -> { "execute": "mcd-initialize",
>>> +#          "arguments": { "version-req": { "v-api-major": 1,
>>> +#                                          "v-api-minor": 1,
>>> +#                                          "author": "" } } }
>>> +#     <- {
>>> +#            "return": {
>>> +#                "impl-info": {
>>> +#                    "v-api": {
>>> +#                        "v-api-minor": 1,
>>> +#                        "v-api-major": 1,
>>> +#                        "author": "QEMU Release"
>>> +#                    },
>>> +#                    "vendor": "QEMU",
>>> +#                    "v-imp-minor": 2,
>>> +#                    "v-imp-major": 9,
>>> +#                    "v-imp-build": 0,
>>> +#                    "date": "Dec 18 2024"
>>> +#                },
>>> +#                "return-status": 0
>>> +#            }
>>> +#        }
>>> +##
>>> +{ 'command': 'mcd-initialize',
>>> +  'data': { 'version-req': 'MCDAPIVersion' },
>>> +  'returns': 'MCDInitializeResult' }
>>> +
>>> +
>>> +##
>>> +# @mcd-exit:
>>> +#
>>> +# Function cleaning up all core and server connections from a tool.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'command': 'mcd-exit' }
>>> +
>>> +
>>> +##
>>> +# == Core Connection API
>>> +##
>>> +
>>> +
>>> +##
>>> +# @mcd-qry-error-info:
>>> +#
>>> +# Function allowing the access to detailed error and/or event information after
>>> +# an API call.
>>> +#
>>> +# Returns: @MCDErrorInfo
>>> +#
>>> +# Since: 9.1
>>> +#
>>> +# .. qmp-example::
>>> +#    :title: Incompatible MCD versions
>>> +#
>>> +#     -> { "execute": "mcd-initialize",
>>> +#          "arguments": { "version-req": { "v-api-major": 2,
>>> +#                                          "v-api-minor": 0,
>>> +#                                          "author": "" } } }
>>> +#     <- {
>>> +#            "return": {
>>> +#                "return-status": 3
>>> +#            }
>>> +#        }
>>> +#     -> { "execute": "mcd-qry-error-info" }
>>> +#     <- {
>>> +#            "return": {
>>> +#                "error-str": "incompatible versions",
>>> +#                "error-code": 3840,
>>> +#                "error-events": 0,
>>> +#                "return-status": 3
>>> +#            }
>>> +#        }
>>> +##
>>> +{ 'command': 'mcd-qry-error-info',
>>> +  'returns': 'MCDErrorInfo' }
>> 
>> You need "Since: 10.0" now.
>> 
>> From docs/devel/qapi-code-gen.rst:
>> 
>>     For legibility, wrap text paragraphs so every line is at most 70
>>     characters long.
>> 
>> and
>> 
>>     Descriptions start with '\@name:'.  The description text must be
>>     indented like this::
>> 
>>      # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
>>      #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
>> 
>> [...]
>
> Will be changed in v3!

Correction: "Since: 10.1".


