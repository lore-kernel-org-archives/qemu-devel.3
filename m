Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B05C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzyl-00059o-E7; Thu, 08 May 2025 08:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCzyj-00054I-J7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCzyg-0000BZ-MH
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746705828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUMv4IIJrXqwyw8Je7U3SOqPI7g2SJSTqw2tPLjLHwk=;
 b=RhkkIVEwkFKmp7tt7cpxDGBmUd0eS/NrTYdvbMHt0Z3B/IrmBvcuHAcXZL2oVa4WneJrpJ
 K8F0oG0/joKcsgUl6eCwdPrwI3HRHOyq3o8sdhrkTZFTuG+soleZ/Ek9MdgzsMvTyYRwJc
 DQ9K1XDhHbbzAjoj0bUWI4e2dteD6YQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-NQPSugJyOAyG3_F1N9ScNg-1; Thu,
 08 May 2025 08:03:47 -0400
X-MC-Unique: NQPSugJyOAyG3_F1N9ScNg-1
X-Mimecast-MFC-AGG-ID: NQPSugJyOAyG3_F1N9ScNg_1746705826
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8148A19560AA; Thu,  8 May 2025 12:03:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE7A219560A7; Thu,  8 May 2025 12:03:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68C8021E66C9; Thu, 08 May 2025 14:03:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  philmd@linaro.org,
 christian.boenig@lauterbach.com
Subject: Re: [PATCH v2 07/20] mcd: Implement target initialization API
In-Reply-To: <20250430052741.21145-8-mario.fleischmann@lauterbach.com> (Mario
 Fleischmann's message of "Wed, 30 Apr 2025 07:27:28 +0200")
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-8-mario.fleischmann@lauterbach.com>
Date: Thu, 08 May 2025 14:03:42 +0200
Message-ID: <87jz6re2ch.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:

> The target initialization API ensures that the requested and provided
> MCD versions are compatible.
>
> * implement mcd_initialize_f and mcd_qry_error_info_f in mcdserver
> * implement QMP stub functionality
> * add QTest
>
> Thanks to the QMP integration in QTest, function arguments and results
> can be (de)serialized automatically.
>
> Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
> ---
>  mcd/mcd_qapi.c          |  66 +++++++++++++++
>  mcd/mcd_qapi.h          |  26 ++++++
>  mcd/mcd_server.c        |  44 +++++++++-
>  mcd/mcd_stub.c          |  35 ++++++++
>  mcd/meson.build         |  49 +++++++----
>  qapi/mcd.json           | 183 ++++++++++++++++++++++++++++++++++++++++
>  tests/qtest/mcd-test.c  |  62 ++++++++++++++
>  tests/qtest/mcd-util.c  |  99 ++++++++++++++++++++++
>  tests/qtest/mcd-util.h  |   6 ++
>  tests/qtest/meson.build |   2 +-
>  10 files changed, 554 insertions(+), 18 deletions(-)
>  create mode 100644 mcd/mcd_qapi.c
>  create mode 100644 mcd/mcd_qapi.h
>  create mode 100644 tests/qtest/mcd-util.c
>
> diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
> new file mode 100644
> index 0000000..9a99866
> --- /dev/null
> +++ b/mcd/mcd_qapi.c
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QAPI marshalling helpers for structures of the MCD API
> + *
> + * Copyright (c) 2025 Lauterbach GmbH
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "mcd_qapi.h"
> +
> +MCDAPIVersion *marshal_mcd_api_version(const mcd_api_version_st *api_version)
> +{
> +    MCDAPIVersion *marshal = g_malloc0(sizeof(*marshal));
> +
> +    *marshal = (MCDAPIVersion) {
> +        .v_api_major = api_version->v_api_major,
> +        .v_api_minor = api_version->v_api_minor,
> +        .author = g_strdup(api_version->author),
> +    };
> +
> +    return marshal;
> +}
> +
> +mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version)
> +{
> +    mcd_api_version_st unmarshal =  {
> +        .v_api_major = api_version->v_api_major,
> +        .v_api_minor = api_version->v_api_minor,
> +    };
> +    strncpy(unmarshal.author, api_version->author, MCD_API_IMP_VENDOR_LEN - 1);

Have you considered sizeof(unmarshal.author) - 1 ?

pstrcpy() from qemu/cutils.h is easier to use safely.

> +    return unmarshal;
> +}
> +
> +MCDImplVersionInfo *marshal_mcd_impl_version_info(
> +    const mcd_impl_version_info_st *impl_info)
> +{
> +    MCDImplVersionInfo *marshal = g_malloc0(sizeof(*marshal));
> +
> +    *marshal = (MCDImplVersionInfo) {
> +        .v_api = marshal_mcd_api_version(&impl_info->v_api),
> +        .v_imp_major = impl_info->v_imp_major,
> +        .v_imp_minor = impl_info->v_imp_minor,
> +        .v_imp_build = impl_info->v_imp_build,
> +        .vendor = g_strdup(impl_info->vendor),
> +        .date = g_strdup(impl_info->date),
> +    };
> +
> +    return marshal;
> +}
> +
> +MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info)
> +{
> +    MCDErrorInfo *marshal = g_malloc0(sizeof(*marshal));
> +
> +    *marshal = (MCDErrorInfo) {
> +        .return_status = error_info->return_status,
> +        .error_code = error_info->error_code,
> +        .error_events = error_info->error_events,
> +        .error_str = g_strdup(error_info->error_str),
> +    };
> +
> +    return marshal;
> +}
> diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
> new file mode 100644
> index 0000000..47f4e16
> --- /dev/null
> +++ b/mcd/mcd_qapi.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QAPI marshalling helpers for structures of the MCD API
> + *
> + * Copyright (c) 2025 Lauterbach GmbH
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef MCD_QAPI_H
> +#define MCD_QAPI_H
> +
> +#include "mcd_api.h"
> +#include "mcd/mcd-qapi-types.h"
> +
> +MCDAPIVersion *marshal_mcd_api_version(const mcd_api_version_st *api_version);
> +
> +MCDImplVersionInfo *marshal_mcd_impl_version_info(
> +    const mcd_impl_version_info_st *impl_info);
> +
> +MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info);
> +
> +mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
> +
> +#endif /* MCD_QAPI_H */
> diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
> index a20708d..6e941f0 100644
> --- a/mcd/mcd_server.c
> +++ b/mcd/mcd_server.c
> @@ -8,6 +8,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "mcd_api.h"
>  
>  static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
> @@ -17,6 +18,13 @@ static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
>      .error_str = "",
>  };
>  
> +static const mcd_error_info_st MCD_ERROR_INVALID_NULL_PARAM = {
> +    .return_status = MCD_RET_ACT_HANDLE_ERROR,
> +    .error_code = MCD_ERR_PARAM,
> +    .error_events = MCD_ERR_EVT_NONE,
> +    .error_str = "null was invalidly passed as a parameter",
> +};
> +
>  static const mcd_error_info_st MCD_ERROR_NONE = {
>      .return_status = MCD_RET_ACT_NONE,
>      .error_code = MCD_ERR_NONE,
> @@ -24,6 +32,9 @@ static const mcd_error_info_st MCD_ERROR_NONE = {
>      .error_str = "",
>  };
>  
> +/* reserves memory for custom errors */
> +static mcd_error_info_st custom_mcd_error;
> +
>  /**
>   * struct mcdserver_state - State of the MCD server
>   *
> @@ -40,12 +51,43 @@ static mcdserver_state g_server_state = {
>  mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
>                                 mcd_impl_version_info_st *impl_info)
>  {
> -    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
> +    if (!version_req || !impl_info) {
> +        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
> +        return g_server_state.last_error->return_status;
> +    }
> +
> +    *impl_info = (mcd_impl_version_info_st) {
> +        .v_api = (mcd_api_version_st) {
> +            .v_api_major = MCD_API_VER_MAJOR,
> +            .v_api_minor = MCD_API_VER_MINOR,
> +            .author = MCD_API_VER_AUTHOR,
> +        },
> +        .v_imp_major = QEMU_VERSION_MAJOR,
> +        .v_imp_minor = QEMU_VERSION_MINOR,
> +        .v_imp_build = 0,
> +        .vendor = "QEMU",
> +        .date = __DATE__,
> +    };
> +
> +    if (version_req->v_api_major == MCD_API_VER_MAJOR &&
> +        version_req->v_api_minor <= MCD_API_VER_MINOR) {
> +        g_server_state.last_error = &MCD_ERROR_NONE;
> +    } else {
> +        custom_mcd_error = (mcd_error_info_st) {
> +            .return_status = MCD_RET_ACT_HANDLE_ERROR,
> +            .error_code = MCD_ERR_GENERAL,
> +            .error_events = MCD_ERR_EVT_NONE,
> +            .error_str = "incompatible versions",
> +        };
> +        g_server_state.last_error = &custom_mcd_error;
> +    }
> +
>      return g_server_state.last_error->return_status;
>  }
>  
>  void mcd_exit_f(void)
>  {
> +    g_server_state.last_error = &MCD_ERROR_NONE;
>      return;
>  }
>  
> diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
> index de679a4..23db1cf 100644
> --- a/mcd/mcd_stub.c
> +++ b/mcd/mcd_stub.c
> @@ -8,4 +8,39 @@
>   * See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
>  #include "mcd_api.h"
> +#include "mcd_qapi.h"
> +#include "mcd/mcd-qapi-commands.h"
> +
> +MCDInitializeResult *qmp_mcd_initialize(MCDAPIVersion *version_req,
> +                                        Error **errp)
> +{
> +    mcd_impl_version_info_st impl_info;
> +    MCDInitializeResult *result = g_malloc0(sizeof(*result));
> +    mcd_api_version_st version_req_unmarshalled =
> +        unmarshal_mcd_api_version(version_req);
> +
> +    result->return_status = mcd_initialize_f(&version_req_unmarshalled,
> +                                             &impl_info);
> +
> +    if (result->return_status == MCD_RET_ACT_NONE) {
> +        result->impl_info = marshal_mcd_impl_version_info(&impl_info);
> +    }
> +
> +    return result;
> +}
> +
> +void qmp_mcd_exit(Error **errp)
> +{
> +    mcd_exit_f();
> +}
> +
> +MCDErrorInfo *qmp_mcd_qry_error_info(Error **errp)
> +{
> +    MCDErrorInfo *result;
> +    mcd_error_info_st error_info;
> +    mcd_qry_error_info_f(NULL, &error_info);
> +    result = marshal_mcd_error_info(&error_info);
> +    return result;
> +}
> diff --git a/mcd/meson.build b/mcd/meson.build
> index 191f0cc..2adaa1b 100644
> --- a/mcd/meson.build
> +++ b/mcd/meson.build
> @@ -1,14 +1,10 @@
>  mcd_qapi_outputs = [
> -  'mcd-qapi-commands.c',
> -  'mcd-qapi-commands.h',
>    'mcd-qapi-emit-events.c',
>    'mcd-qapi-emit-events.h',
>    'mcd-qapi-events.c',
>    'mcd-qapi-events.h',
>    'mcd-qapi-features.c',
>    'mcd-qapi-features.h',
> -  'mcd-qapi-init-commands.c',
> -  'mcd-qapi-init-commands.h',
>    'mcd-qapi-introspect.c',
>    'mcd-qapi-introspect.h',
>    'mcd-qapi-types.c',
> @@ -17,27 +13,48 @@ mcd_qapi_outputs = [
>    'mcd-qapi-visit.h',
>  ]
>  
> +# QAPI outputs that will only be used by the MCD server
> +mcd_qapi_server_outputs = [
> +  'mcd-qapi-commands.c',
> +  'mcd-qapi-commands.h',
> +  'mcd-qapi-init-commands.c',
> +  'mcd-qapi-init-commands.h'
> +]
> +
>  mcd_qapi_files = custom_target('MCD QAPI files',
> -                               output: mcd_qapi_outputs,
> +                               output: mcd_qapi_outputs + mcd_qapi_server_outputs,
>                                 input: '../qapi/mcd.json',
>                                 command: [ qapi_gen, '-p', 'mcd-', '-o', 'mcd',
>                                            '--suppress-tracing','@INPUT0@'],
>                                 depend_files: qapi_gen_depends)
>  
> -mcd_ss = ss.source_set()
> +mcd_qapi_ss = ss.source_set()
>  
> -mcd_ss.add(mcd_qapi_files.to_list())
> -mcd_ss.add(files(
> -  'mcd_server.c',
> -  'mcd_stub.c',
> -  'mcd_monitor.c'))
> +foreach f : mcd_qapi_files.to_list()
> +  if mcd_qapi_outputs.contains(fs.name(f))
> +    mcd_qapi_ss.add([f])
> +  endif
> +endforeach
>  
> -mcd_ss = mcd_ss.apply({})
> +mcd_qapi_ss.add(files('mcd_qapi.c'))
> +mcd_qapi_ss = mcd_qapi_ss.apply({})
>  
> -libmcd = static_library('mcd_system',
> -                        mcd_ss.sources() + genh,
> +libmcd_qapi = static_library('mcd_qapi',
> +                        mcd_qapi_ss.sources() + genh,
>                          build_by_default: false)
>  
> -mcd = declare_dependency(objects: libmcd.extract_all_objects(recursive: false))
> +mcd_qapi = declare_dependency(
> +    objects: libmcd_qapi.extract_all_objects(recursive: false))
> +
> +foreach f : mcd_qapi_files.to_list()
> +  if mcd_qapi_server_outputs.contains(fs.name(f))
> +    libsystem_ss.add([f])
> +  endif
> +endforeach
> +
> +libsystem_ss.add(files(
> +  'mcd_server.c',
> +  'mcd_stub.c',
> +  'mcd_monitor.c'))
>  
> -system_ss.add(mcd)
> +libsystem_ss.add(mcd_qapi)

The commit message did not prepare me for such changes to meson.build.
What are you doing here?

> diff --git a/qapi/mcd.json b/qapi/mcd.json
> index 701fd03..7b42a74 100644
> --- a/qapi/mcd.json
> +++ b/qapi/mcd.json
> @@ -4,3 +4,186 @@
>  ##
>  # = Multi-Core Debug (MCD) API
>  ##
> +
> +
> +##
> +# == Definition of Structures
> +##
> +
> +
> +##
> +# @MCDAPIVersion:
> +#
> +# Structure type containing the MCD API version information of the tool.
> +#
> +# @v-api-major: API major version.
> +# @v-api-minor: API minor version.
> +# @author:      API name of the author of this MCD API version.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MCDAPIVersion',
> +  'data': {
> +    'v-api-major': 'uint16',
> +    'v-api-minor': 'uint16',
> +    'author':      'str' } }
> +
> +
> +##
> +# @MCDImplVersionInfo:
> +#
> +# Structure type containing the MCD API implementation information.
> +#
> +# @v-api:       Implemented API version.
> +# @v-imp-major: Major version number of this implementation.
> +# @v-imp-minor: Minor version number of this implementation.
> +# @v-imp-build: Build number of this implementation.
> +# @vendor:      Name of vendor of the implementation.
> +# @date:        String from __DATE__ macro at compile time.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MCDImplVersionInfo',
> +  'data': {
> +    'v-api'      : 'MCDAPIVersion',
> +    'v-imp-major': 'uint16',
> +    'v-imp-minor': 'uint16',
> +    'v-imp-build': 'uint16',
> +    'vendor'     : 'str',
> +    'date'       : 'str' } }
> +
> +
> +##
> +# @MCDErrorInfo:
> +#
> +# Structure type containing the error status and error event notification.
> +#
> +# @return-status: Return status from the last API call.
> +# @error-code:    Detailed error code from the last API call.
> +# @error-events:  Detailed event code from the last API call.
> +# @error-str:     Detailed error text string from the last API call.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MCDErrorInfo',
> +  'data': {
> +    'return-status': 'uint32',
> +    'error-code'   : 'uint32',
> +    'error-events' : 'uint32',
> +    'error-str'    : 'str' }}
> +
> +
> +##
> +# == Target Initialization API
> +##
> +
> +
> +##
> +# @MCDInitializeResult:
> +#
> +# Return value of @mcd-initialize.
> +#
> +# @return-status: Return code.
> +#
> +# @impl-info: Information about the QEMU build, its version and the version of
> +#             the implemented MCD API.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MCDInitializeResult',
> +  'data': {
> +    'return-status': 'uint32',
> +    '*impl-info'   : 'MCDImplVersionInfo' } }
> +
> +
> +##
> +# @mcd-initialize:
> +#
> +# Function initializing the interaction between a tool-side implementation and
> +# target-side implementation.
> +#
> +# @version-req: MCD API version as requested by an upper layer.
> +#
> +# Returns: @MCDInitializeResult
> +#
> +# Since: 9.1
> +#
> +# .. qmp-example::
> +#    :title: Check compatibility with MCD server
> +#
> +#     -> { "execute": "mcd-initialize",
> +#          "arguments": { "version-req": { "v-api-major": 1,
> +#                                          "v-api-minor": 1,
> +#                                          "author": "" } } }
> +#     <- {
> +#            "return": {
> +#                "impl-info": {
> +#                    "v-api": {
> +#                        "v-api-minor": 1,
> +#                        "v-api-major": 1,
> +#                        "author": "QEMU Release"
> +#                    },
> +#                    "vendor": "QEMU",
> +#                    "v-imp-minor": 2,
> +#                    "v-imp-major": 9,
> +#                    "v-imp-build": 0,
> +#                    "date": "Dec 18 2024"
> +#                },
> +#                "return-status": 0
> +#            }
> +#        }
> +##
> +{ 'command': 'mcd-initialize',
> +  'data': { 'version-req': 'MCDAPIVersion' },
> +  'returns': 'MCDInitializeResult' }
> +
> +
> +##
> +# @mcd-exit:
> +#
> +# Function cleaning up all core and server connections from a tool.
> +#
> +# Since: 9.1
> +##
> +{ 'command': 'mcd-exit' }
> +
> +
> +##
> +# == Core Connection API
> +##
> +
> +
> +##
> +# @mcd-qry-error-info:
> +#
> +# Function allowing the access to detailed error and/or event information after
> +# an API call.
> +#
> +# Returns: @MCDErrorInfo
> +#
> +# Since: 9.1
> +#
> +# .. qmp-example::
> +#    :title: Incompatible MCD versions
> +#
> +#     -> { "execute": "mcd-initialize",
> +#          "arguments": { "version-req": { "v-api-major": 2,
> +#                                          "v-api-minor": 0,
> +#                                          "author": "" } } }
> +#     <- {
> +#            "return": {
> +#                "return-status": 3
> +#            }
> +#        }
> +#     -> { "execute": "mcd-qry-error-info" }
> +#     <- {
> +#            "return": {
> +#                "error-str": "incompatible versions",
> +#                "error-code": 3840,
> +#                "error-events": 0,
> +#                "return-status": 3
> +#            }
> +#        }
> +##
> +{ 'command': 'mcd-qry-error-info',
> +  'returns': 'MCDErrorInfo' }

You need "Since: 10.0" now.

From docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

and

    Descriptions start with '\@name:'.  The description text must be
    indented like this::

     # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
     #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.

[...]


