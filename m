Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE4BC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 06:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4DMU-0007Nx-7D; Mon, 14 Apr 2025 02:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4DMN-0007N9-ND
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u4DMJ-0008ER-LH
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 02:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744612299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PPsJTBY3kc2djQa+tgfTOhpY2oQOI98PSfrbdA9HQ0=;
 b=G7XqmYaDxxP45Rs/qBPm1crGBebrL+PpbNJS8cFvQ0sQ0j9OJYOcaQmCYrlSiWDAMRjaJy
 DdluO29/3MfN0TgSrMz+5T2QW6r3RrxxKtak3PsNa5UA/ALC2A4oxXITZQ3T0Ipt0oQiyF
 SbFIXnm13WP5pCb1TtvExJwF40ZGg0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-bJTQVYFnO06GK2wlFHxkVw-1; Mon,
 14 Apr 2025 02:31:35 -0400
X-MC-Unique: bJTQVYFnO06GK2wlFHxkVw-1
X-Mimecast-MFC-AGG-ID: bJTQVYFnO06GK2wlFHxkVw_1744612294
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5403180AF59; Mon, 14 Apr 2025 06:31:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FB5C1955DCE; Mon, 14 Apr 2025 06:31:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A47C21E66C2; Mon, 14 Apr 2025 08:31:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 zhao1.liu@intel.com,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 slp@redhat.com,  eblake@redhat.com,  armbru@redhat.com,
 miguel.luis@oracle.com
Subject: Re: [RFC V3 PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
In-Reply-To: <20250411204517.3043-1-annie.li@oracle.com> (Annie Li's message
 of "Fri, 11 Apr 2025 16:45:17 -0400")
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204517.3043-1-annie.li@oracle.com>
Date: Mon, 14 Apr 2025 08:31:26 +0200
Message-ID: <875xj71cg1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Annie Li <annie.li@oracle.com> writes:

> Followng hmp/qmp commands are implemented for pressing virtual
> sleep button,
>
> hmp: system_sleep
> qmp: { "execute": "system_sleep" }
>
> These commands put the guest into suspend or other power states
> depending on the power settings inside the guest.
>
> These hmp/qmp command are in '*_*' format, it is intended to do
> so to align to existing 'system_*' commands.
>
> Signed-off-by: Annie Li <annie.li@oracle.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09..0965e78f4e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -361,6 +361,26 @@
>  ##
>  { 'command': 'system_reset' }
>  
> +##
> +# @system_sleep:
> +#
> +# Requests that the guest perform a ACPI sleep transition by pushing
> +# the virtual sleep button.
> +#
> +# Since:10.0
> +#
> +# .. note:: A guest may or may not respond to this command. This

Two spaces between sentences for consistency, please.

> +#        command returning does not indicate that a guest has
> +#        accepted the request or that it has gone to sleep.
> +#
> +# .. qmp-example::
> +#
> +# -> { "execute": "system_sleep" }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'system_sleep' }
> +
>  ##
>  # @system_powerdown:
>  #
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 023a2ef7bc..285ce82e9b 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -23,6 +23,7 @@
>          'set_password',
>          'system_powerdown',
>          'system_reset',
> +        'system_sleep',

Additions here are always sad, but inconsistency with the other
system_FOO commands would be worse.

>          'system_wakeup' ],
>      # Commands allowed to return a non-dictionary
>      'command-returns-exceptions': [

With the spacing nit touched up:
Acked-by: Markus Armbruster <armbru@redhat.com>


