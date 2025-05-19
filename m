Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97634C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3j6-0003sV-Bz; Mon, 19 May 2025 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH3j2-0003s7-F5
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:52:28 -0400
Received: from bm.lauterbach.com ([62.154.241.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1uH3j0-0007nV-4G
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:52:28 -0400
Received: from [10.2.13.100] (unknown [10.2.13.100])
 (Authenticated sender: mario.fleischmann@lauterbach.com)
 by bm.lauterbach.com (Postfix) with ESMTPSA id 36C5A4FAAA67;
 Mon, 19 May 2025 18:52:05 +0200 (CEST)
Message-ID: <a71a747f-d8c3-40ac-ab61-0628dffbb2f6@lauterbach.com>
Date: Mon, 19 May 2025 18:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] mcd: Implement target initialization API
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 christian.boenig@lauterbach.com
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-8-mario.fleischmann@lauterbach.com>
 <875xi2yqlh.fsf@pond.sub.org>
Content-Language: en-US
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
In-Reply-To: <875xi2yqlh.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1747673525230
Received-SPF: pass client-ip=62.154.241.218;
 envelope-from=mario.fleischmann@lauterbach.com; helo=bm.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

On 15.05.2025 15:02, Markus Armbruster wrote:

> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
> 
>> The target initialization API ensures that the requested and provided
>> MCD versions are compatible.
>>
>> * implement mcd_initialize_f and mcd_qry_error_info_f in mcdserver
>> * implement QMP stub functionality
>> * add QTest
>>
>> Thanks to the QMP integration in QTest, function arguments and results
>> can be (de)serialized automatically.
>>
>> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
> 
> [...]
> 
>> diff --git a/qapi/mcd.json b/qapi/mcd.json
>> index 701fd03..7b42a74 100644
>> --- a/qapi/mcd.json
>> +++ b/qapi/mcd.json
>> @@ -4,3 +4,186 @@
>>  ##
>>  # = Multi-Core Debug (MCD) API
>>  ##
>> +
>> +
>> +##
>> +# == Definition of Structures
>> +##
>> +
>> +
>> +##
>> +# @MCDAPIVersion:
>> +#
>> +# Structure type containing the MCD API version information of the tool.
>> +#
>> +# @v-api-major: API major version.
>> +# @v-api-minor: API minor version.
>> +# @author:      API name of the author of this MCD API version.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MCDAPIVersion',
>> +  'data': {
>> +    'v-api-major': 'uint16',
>> +    'v-api-minor': 'uint16',
>> +    'author':      'str' } }
>> +
>> +
>> +##
>> +# @MCDImplVersionInfo:
>> +#
>> +# Structure type containing the MCD API implementation information.
>> +#
>> +# @v-api:       Implemented API version.
>> +# @v-imp-major: Major version number of this implementation.
>> +# @v-imp-minor: Minor version number of this implementation.
>> +# @v-imp-build: Build number of this implementation.
>> +# @vendor:      Name of vendor of the implementation.
>> +# @date:        String from __DATE__ macro at compile time.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MCDImplVersionInfo',
>> +  'data': {
>> +    'v-api'      : 'MCDAPIVersion',
>> +    'v-imp-major': 'uint16',
>> +    'v-imp-minor': 'uint16',
>> +    'v-imp-build': 'uint16',
>> +    'vendor'     : 'str',
>> +    'date'       : 'str' } }
>> +
>> +
>> +##
>> +# @MCDErrorInfo:
>> +#
>> +# Structure type containing the error status and error event notification.
>> +#
>> +# @return-status: Return status from the last API call.
>> +# @error-code:    Detailed error code from the last API call.
>> +# @error-events:  Detailed event code from the last API call.
>> +# @error-str:     Detailed error text string from the last API call.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MCDErrorInfo',
>> +  'data': {
>> +    'return-status': 'uint32',
>> +    'error-code'   : 'uint32',
>> +    'error-events' : 'uint32',
>> +    'error-str'    : 'str' }}
>> +
>> +
>> +##
>> +# == Target Initialization API
>> +##
>> +
>> +
>> +##
>> +# @MCDInitializeResult:
>> +#
>> +# Return value of @mcd-initialize.
>> +#
>> +# @return-status: Return code.
>> +#
>> +# @impl-info: Information about the QEMU build, its version and the version of
>> +#             the implemented MCD API.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'struct': 'MCDInitializeResult',
>> +  'data': {
>> +    'return-status': 'uint32',
>> +    '*impl-info'   : 'MCDImplVersionInfo' } }
>> +
>> +
>> +##
>> +# @mcd-initialize:
>> +#
>> +# Function initializing the interaction between a tool-side implementation and
>> +# target-side implementation.
>> +#
>> +# @version-req: MCD API version as requested by an upper layer.
>> +#
>> +# Returns: @MCDInitializeResult
>> +#
>> +# Since: 9.1
>> +#
>> +# .. qmp-example::
>> +#    :title: Check compatibility with MCD server
>> +#
>> +#     -> { "execute": "mcd-initialize",
>> +#          "arguments": { "version-req": { "v-api-major": 1,
>> +#                                          "v-api-minor": 1,
>> +#                                          "author": "" } } }
>> +#     <- {
>> +#            "return": {
>> +#                "impl-info": {
>> +#                    "v-api": {
>> +#                        "v-api-minor": 1,
>> +#                        "v-api-major": 1,
>> +#                        "author": "QEMU Release"
>> +#                    },
>> +#                    "vendor": "QEMU",
>> +#                    "v-imp-minor": 2,
>> +#                    "v-imp-major": 9,
>> +#                    "v-imp-build": 0,
>> +#                    "date": "Dec 18 2024"
>> +#                },
>> +#                "return-status": 0
>> +#            }
>> +#        }
>> +##
>> +{ 'command': 'mcd-initialize',
>> +  'data': { 'version-req': 'MCDAPIVersion' },
>> +  'returns': 'MCDInitializeResult' }
>> +
>> +
>> +##
>> +# @mcd-exit:
>> +#
>> +# Function cleaning up all core and server connections from a tool.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'command': 'mcd-exit' }
>> +
>> +
>> +##
>> +# == Core Connection API
>> +##
>> +
>> +
>> +##
>> +# @mcd-qry-error-info:
>> +#
>> +# Function allowing the access to detailed error and/or event information after
>> +# an API call.
>> +#
>> +# Returns: @MCDErrorInfo
>> +#
>> +# Since: 9.1
>> +#
>> +# .. qmp-example::
>> +#    :title: Incompatible MCD versions
>> +#
>> +#     -> { "execute": "mcd-initialize",
>> +#          "arguments": { "version-req": { "v-api-major": 2,
>> +#                                          "v-api-minor": 0,
>> +#                                          "author": "" } } }
>> +#     <- {
>> +#            "return": {
>> +#                "return-status": 3
>> +#            }
>> +#        }
>> +#     -> { "execute": "mcd-qry-error-info" }
>> +#     <- {
>> +#            "return": {
>> +#                "error-str": "incompatible versions",
>> +#                "error-code": 3840,
>> +#                "error-events": 0,
>> +#                "return-status": 3
>> +#            }
>> +#        }
>> +##
>> +{ 'command': 'mcd-qry-error-info',
>> +  'returns': 'MCDErrorInfo' }
> 
> You define some types under "Definition of Structures", and some
> elsewhere.  How do you decide what goes where?  Hmm, looks like you
> mirror mcd/mcd_api.h.  Correct?

Generally, mcd/qapi-schema.json is intended to stay as close as possible
to mcd_api.h. However, there are a few exceptions.

If a function "MCDFunction" from the MCD API has multiple return values,
an additional QAPI struct with the naming scheme "MCDFunctionResult" is
introduced which will be returned by "MCDFunction".
Since this struct is intended to be used by only one function, it is
defined directly before that function.

If the type of an argument or return value cannot be serialized, most
often because it is a pointer, it is changed to a type which is able to
carry the same information. In most cases, an int carrying a unique
identifier suffices. Sometimes, an additional struct is required.
This struct can possibly be used by multiple functions, so I would
expect it in the "Definition of Structures" section.


