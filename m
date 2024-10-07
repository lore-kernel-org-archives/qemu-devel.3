Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD0CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxn6g-0002Bm-TQ; Mon, 07 Oct 2024 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxn6e-0002B1-4d
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxn6c-0004LT-Hw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728305093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XimklviNwoadeALIBpKZ5s2pHbdlyJaEPc4Sg0+99s=;
 b=bXk6Cw4jb3RqvMswn3v30O0cbsjhi/Wiw1wO27OhepXoWoLntfT6pTd4auh8lQ8i58BxnR
 mibzZ7ald5OinDFTR3tPogrZXChDnEK84MNtIK2SM+8Aqr6gB/lf43dccwJdDOx6MAbM5g
 lSLRS34p+HR74YfBgAi8kJsF/Om8Y/k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-7DBhn_iWPdq5F24n8UOKkA-1; Mon, 07 Oct 2024 08:44:52 -0400
X-MC-Unique: 7DBhn_iWPdq5F24n8UOKkA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cdeac2da6so39232405e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728305091; x=1728909891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XimklviNwoadeALIBpKZ5s2pHbdlyJaEPc4Sg0+99s=;
 b=mhHN3WegFO+YsM0Uf5Q6E32zDieApTha26fltThF2OpOf4qzCF6n7GnkdYfCHUWDCl
 57QXTiQBFUPQMvrakXCRYIdbrWhFzyYcayQGuRJmQ2Yv6inMQwPlwsUn3J9IXE7HgFjU
 rm28/UbK3Qe6xLOB3sH+STMPI06bwhkgLgcKXAXrCJGNkrKZuY/Jer43e1O8dMErxJnH
 OFr7LFJknlU3sJBimLPSEANYn/0i0IKuOzwoAcaHN76ecXF3wl5CGb1CbAL7brmtzP7p
 xhrwa1wfN4aocDDq7cUlnPZpnNgjd1z0b3P9+ZP3fzpZiq0JNyfLJYYnsHvKk8ey2H1z
 xWzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNqNImbHxidm0+KfeQPyoMyujFeVzYi1EsYBeTfYSn3jJZZbkU83t2fZAS15xzD0LP2HO6CXi69Y4g@nongnu.org
X-Gm-Message-State: AOJu0Yxm4nygdrMnsB6+lU7ueMBNbThHnqBEYV01QHPU4aCmZfnHmrox
 PHfPzManXVBd8OutOQwvcIxSGwMF8Gh2LHGgoIXnktwz5xDMbrCZIyadw+XgwN3ILIJY308gkXm
 WD0FVqo49iaygIpzpMGN/dZHE9lFL7VZhqoHfQ0T4xLHTY5id70VF
X-Received: by 2002:a7b:c44c:0:b0:42f:6878:a68d with SMTP id
 5b1f17b1804b1-42f8664f3c4mr77076345e9.20.1728305091508; 
 Mon, 07 Oct 2024 05:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS2xc8afWwDsQ0wwImJL1ts+tTXupmvsBG1eenO4wcKj6OReHq5k3VKABP3zeM4BmeoQW5mQ==
X-Received: by 2002:a7b:c44c:0:b0:42f:6878:a68d with SMTP id
 5b1f17b1804b1-42f8664f3c4mr77075975e9.20.1728305091050; 
 Mon, 07 Oct 2024 05:44:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a20471sm91063045e9.17.2024.10.07.05.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 05:44:50 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:44:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [RFC V2 PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Message-ID: <20241007144449.457d304f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240927183906.1248-2-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-2-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 27 Sep 2024 14:38:56 -0400
Annie Li <annie.li@oracle.com> wrote:

> Followng hmp/qmp commands are implemented for pressing virtual
> sleep button,
> 
> hmp: system_sleep
> qmp: { "execute": "system_sleep" }
> 
> These commands put the guest into suspend or other power states
> depending on the power settings inside the guest.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hmp-commands.hx            | 14 ++++++++++++++
>  hw/core/machine-hmp-cmds.c |  5 +++++
>  hw/core/machine-qmp-cmds.c |  9 +++++++++
>  include/monitor/hmp.h      |  1 +
>  qapi/machine.json          | 18 ++++++++++++++++++
>  qapi/pragma.json           |  1 +
>  6 files changed, 48 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 06746f0afc..4c149f403f 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -639,6 +639,20 @@ SRST
>    whether profiling is on or off.
>  ERST
>  
> +    {
> +        .name       = "system_sleep",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "send ACPI sleep event",
> +        .cmd = hmp_system_sleep,
> +    },
> +
> +SRST
> +``system_sleep``
> +  Push the virtual sleep button; if supported the system will enter
> +  an ACPI sleep state.

perhaps comma after 'if supported'


> +ERST
> +
>      {
>          .name       = "system_reset",
>          .args_type  = "",
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index 8701f00cc7..3ee529d8d5 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -189,6 +189,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>      qmp_system_reset(NULL);
>  }
>  
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
> +{
> +    qmp_system_sleep(NULL);
> +}
> +
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>  {
>      qmp_system_powerdown(NULL);
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 130217da8f..770f8189ba 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -276,6 +276,15 @@ void qmp_system_reset(Error **errp)
>      qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>  }
>  
> +void qmp_system_sleep(Error **errp)
> +{
> +    if (!qemu_wakeup_suspend_enabled()) {
> +        error_setg(errp,
> +                   "suspend from running is not supported by this guest");

it's machine and not the guest that doesn't support, isn't it?

> +        return;
> +    }

I'd reorder this after 6/11, to avoid adding function that does nothing
and then explaining why it is done this way.

> +}
> +
>  void qmp_system_powerdown(Error **errp)
>  {
>      qemu_system_powerdown_request();
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index ae116d9804..e543eec109 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -43,6 +43,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
>  void hmp_stop(Monitor *mon, const QDict *qdict);
>  void hmp_sync_profile(Monitor *mon, const QDict *qdict);
>  void hmp_system_reset(Monitor *mon, const QDict *qdict);
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>  void hmp_announce_self(Monitor *mon, const QDict *qdict);
> diff --git a/qapi/machine.json b/qapi/machine.json
> index d4317435e7..b32d231aa9 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -362,6 +362,24 @@
>  ##
>  { 'command': 'system_reset' }
>  
> +##
> +# @system_sleep:
> +#
> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
> +# sleep button.
> +#
> +# .. note:: A guest may or may not respond to this command. This command
> +#        returning does not indicate that a guest has accepted the request
> +#        or that it has gone to sleep.
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
> index 59fbe74b8c..e2c5dcb829 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -23,6 +23,7 @@
>          'set_password',
>          'system_powerdown',
>          'system_reset',
> +        'system_sleep',
>          'system_wakeup' ],
>      # Commands allowed to return a non-dictionary
>      'command-returns-exceptions': [


