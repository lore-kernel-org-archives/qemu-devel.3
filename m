Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E48C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjjS-0005hq-Uv; Mon, 10 Jun 2024 14:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGjjI-0005gO-1L
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGjjG-0006pw-8f
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718044008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wDKPwfTMvPEdBysezOfWfcB12MRhGMTru7l7+W2DslE=;
 b=eqSujr7FN7QKFSnrHEACOYlk7nVIO/8xaGH9NcizKKoV6URFoM6s+bth1ci4rcu9KPR24Y
 ODkHgeI6vMSst028j1kHZEm1//0fQwiQSTqmU0l77LgNGFtAnHB6Do3UDuwUXyfW4TDDLp
 ZPMA85AAoYxG4Gam7Vk9cwic9w1yRwg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-XQutqeZXOk-Dq7aiGw_Y0A-1; Mon,
 10 Jun 2024 14:26:45 -0400
X-MC-Unique: XQutqeZXOk-Dq7aiGw_Y0A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A17AE19560A2; Mon, 10 Jun 2024 18:26:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDE619560AA; Mon, 10 Jun 2024 18:26:36 +0000 (UTC)
Date: Mon, 10 Jun 2024 19:26:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/3] monitor: Allow passing HMP arguments to QMP
 HumanReadableText API
Message-ID: <ZmdFWdtTyhqoRREK@redhat.com>
References: <20240610175852.21215-1-philmd@linaro.org>
 <20240610175852.21215-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610175852.21215-3-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 10, 2024 at 07:58:51PM +0200, Philippe Mathieu-Daudé wrote:
> Allow HMP commands implemented using the HumanReadableText API
> (via the HMPCommand::cmd_info_hrt handler) to pass arguments
> to the QMP equivalent command. The arguments are serialized as
> a JSON dictionary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/devel/writing-monitor-commands.rst | 15 ++++++++++++++-
>  qapi/machine.json                       | 24 ++++++++++++++++++++++++
>  include/monitor/monitor.h               |  3 ++-
>  monitor/monitor-internal.h              |  2 +-
>  accel/tcg/monitor.c                     |  4 ++--
>  hw/core/loader.c                        |  2 +-
>  hw/core/machine-qmp-cmds.c              |  9 +++++----
>  hw/usb/bus.c                            |  2 +-
>  monitor/hmp-target.c                    |  3 ++-
>  monitor/hmp.c                           | 11 +++++++----
>  10 files changed, 59 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
> index 930da5cd06..843458e52c 100644
> --- a/docs/devel/writing-monitor-commands.rst
> +++ b/docs/devel/writing-monitor-commands.rst
> @@ -561,6 +561,7 @@ returns a ``HumanReadableText``::
>   # Since: 6.2
>   ##
>   { 'command': 'x-query-roms',
> +   'data': { 'json-args': 'str'},
>     'returns': 'HumanReadableText',
>     'features': [ 'unstable' ] }
>  
> @@ -578,7 +579,7 @@ Implementing the QMP command
>  The QMP implementation will typically involve creating a ``GString``
>  object and printing formatted data into it, like this::
>  
> - HumanReadableText *qmp_x_query_roms(Error **errp)
> + HumanReadableText *qmp_x_query_roms(const char *json_args, Error **errp)
>   {
>       g_autoptr(GString) buf = g_string_new("");
>       Rom *rom;
> @@ -596,6 +597,18 @@ object and printing formatted data into it, like this::
>  The actual implementation emits more information.  You can find it in
>  hw/core/loader.c.
>  
> +For QMP command taking (optional) parameters, these parameters are
> +serialized as a JSON dictionary, and can be retrieved using the QDict
> +API. If the previous ``x-query-roms`` command were taking a "index"
> +argument, it could be retrieved as::
> +
> + HumanReadableText *qmp_x_query_roms(const char *json_args, Error **errp)
> + {
> +     g_autoptr(GString) buf = g_string_new("");
> +     QDict *qdict = qobject_to(QDict, qobject_from_json(json_args, &error_abort));
> +     uint64_t index = qdict_get_int(qdict, "index");
> +     ...
> + }

Passing json inside json is pretty gross, and throwing away a key
benefit of QAPI - that it de-serializes the JSON into the actual
data types that you need, avoiding manual & error prone code for
unpacking args from a QDict.

IMHO if a commend requires arguments, they should be modelled
explicitly, and not use the  cmd_info_hrt convenience handler
which was only ever intended simple for no-arg 'info' commands.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


