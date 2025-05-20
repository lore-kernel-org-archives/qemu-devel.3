Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C274C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHAp-0000Bw-8G; Tue, 20 May 2025 03:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHAn-0000Ba-D1
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHHAl-0001PS-FK
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747725238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+rdamO7z+MVVFagep15J+sTzCFhI1hAxdcbsWDd80eI=;
 b=Dy6w+nA6ZO1H4vjgTlGG+A2m3VukIjSZUmcBoFO4xVolzhuN8Izunc3L4LGqZ/Kd8Ow7Js
 P6VVKU3lmYS0qrxNTaxv4OO/IZf9i5ZPkgbkYpqcCi/x0jFFs2X3vA9JR/iPekd0X1W+66
 mSHP4OEuBhZ6gj7Csq4540VDI4v+dso=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-vgqASAZUNE6R0NAFVcE47A-1; Tue,
 20 May 2025 03:13:53 -0400
X-MC-Unique: vgqASAZUNE6R0NAFVcE47A-1
X-Mimecast-MFC-AGG-ID: vgqASAZUNE6R0NAFVcE47A_1747725232
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D2991955DAD; Tue, 20 May 2025 07:13:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BB1A1956096; Tue, 20 May 2025 07:13:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8018621E66C3; Tue, 20 May 2025 09:13:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 07/20] mcd: Implement target initialization API
In-Reply-To: <a71a747f-d8c3-40ac-ab61-0628dffbb2f6@lauterbach.com> (Mario
 Fleischmann's message of "Mon, 19 May 2025 18:52:05 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-8-mario.fleischmann@lauterbach.com>
 <875xi2yqlh.fsf@pond.sub.org>
 <a71a747f-d8c3-40ac-ab61-0628dffbb2f6@lauterbach.com>
Date: Tue, 20 May 2025 09:13:48 +0200
Message-ID: <87o6vndaab.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> On 15.05.2025 15:02, Markus Armbruster wrote:
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
>> 
>> [...]
>> 
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
>> You define some types under "Definition of Structures", and some
>> elsewhere.  How do you decide what goes where?  Hmm, looks like you
>> mirror mcd/mcd_api.h.  Correct?
>
> Generally, mcd/qapi-schema.json is intended to stay as close as possible
> to mcd_api.h. However, there are a few exceptions.
>
> If a function "MCDFunction" from the MCD API has multiple return values,
> an additional QAPI struct with the naming scheme "MCDFunctionResult" is
> introduced which will be returned by "MCDFunction".
> Since this struct is intended to be used by only one function, it is
> defined directly before that function.
>
> If the type of an argument or return value cannot be serialized, most
> often because it is a pointer, it is changed to a type which is able to
> carry the same information. In most cases, an int carrying a unique
> identifier suffices. Sometimes, an additional struct is required.
> This struct can possibly be used by multiple functions, so I would
> expect it in the "Definition of Structures" section.

Makes sense.

Suggest to add a suitable varation of this explanation to the .json as a
non-doc comment.  Reminder:

##
# Doc comment
##

#
# Not a doc comment
#


