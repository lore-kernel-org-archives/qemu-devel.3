Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AEBE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJvU-0003WL-SJ; Thu, 19 Dec 2024 12:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOJvT-0003Ve-SB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOJvR-0003WG-SX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734627779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/aVhxzNeYhn+VYtubSsYO3EM+sTUc89Fg/MIhk4FCKM=;
 b=e7dtyA65/byQdC5o1RyBCc8ptZ2c99JjJAKa6eT1LzZ9Aq7vKZhFLMREDeWdIV/gMRxVbJ
 HUj31WmfZoL7feRoGy9padj4zzpZUi4g7cacaM/hcG6HvVCSciIQ5pnYXeR3GknXT0y148
 apJxx7JGDvgjlJn6kCXDsPYPU19BKgQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-zQ1VcKpdOT-FCYKMUeJoPQ-1; Thu, 19 Dec 2024 12:02:58 -0500
X-MC-Unique: zQ1VcKpdOT-FCYKMUeJoPQ-1
X-Mimecast-MFC-AGG-ID: zQ1VcKpdOT-FCYKMUeJoPQ
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8f94518c9so19909866d6.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734627778; x=1735232578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/aVhxzNeYhn+VYtubSsYO3EM+sTUc89Fg/MIhk4FCKM=;
 b=HGFZ3VGrlR/RZT5UbqnqauG7KRJWCzTKYecs37QdSp5BQu4/BWsgHU0FI7L1twiNWn
 XE4h3cHLdzrKGHyz+4b7P4C/kle6inJfU1cSPsJk0QZrT1hJTq9dIrE12pop+mf+DuG7
 8+sJoAB8DD6qeux5mHx1SP4ci+q3PvPsujzlZGTd/FkaN17ONWUl68M4611yeqzoC2pu
 P2VNsmsOh0enlFWlwJKtoYf9pmIxP5K8EsGmfcgs9QT3UD6NHJ3FdDbScbL9zHYBaEoV
 L+rSHEG348/JPipf6dd1lrxET8TBsdPW5cjia6M/Fk8NDB9azanTeyoj1IqzkJQ0alVT
 Nljw==
X-Gm-Message-State: AOJu0YygC4suQIu0D7LxkHtpBd2Ns9+9B1nEx57PhnorIIVAwP9u45i/
 FcsOl7OOQoHSrTdc5esO8u9gezoGfPM3uwBlmkzLCZ7aVv80ISIMLLl4Yt/jStXkFAn2F2q9rms
 OoJWLJjRo1WeX4oofEAcueP8AwlVCwZv3siryGDvKxSO5ulqRbDiU
X-Gm-Gg: ASbGncte8KcK2HSJLTNRNVhO2kQPf0AvteE5LtyVB+V1RABZUcCDx4HkIOu63NizhqA
 L7ZtOzAiyDPj+ZPsvCazb9AsumU3dL2eRUchRp5w902qQIeSDILIYCpD/lr6RIOC0It+MEmMZyf
 XGsICJcB8izX+GZ0l/IvZtbBMPkezy+sbBQqlHL+5SxzZozsDskslVKCmkFulpWGzS4PZDSPHEJ
 Qv5c9OZuAsLMNMwBDIMzSiloauKDzHpayZU9niarHZvvWxprIXGnTYnBYuS1eTgekn3zEDp15eX
 SQo0hZfXNOBODfEYjQ==
X-Received: by 2002:a05:6214:e4c:b0:6d8:8496:6b00 with SMTP id
 6a1803df08f44-6dd14c56e34mr71368946d6.35.1734627777786; 
 Thu, 19 Dec 2024 09:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnMogb2fxy6wnHaCUFKXIF4AP9ByqzAfzXIvChJJ4Wa97kbjji3SYXcyaz/pQgMpgg9tRJVw==
X-Received: by 2002:a05:6214:e4c:b0:6d8:8496:6b00 with SMTP id
 6a1803df08f44-6dd14c56e34mr71368356d6.35.1734627777370; 
 Thu, 19 Dec 2024 09:02:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd18137367sm8249666d6.65.2024.12.19.09.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:02:56 -0800 (PST)
Date: Thu, 19 Dec 2024 12:02:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 19/19] migration: cpr-transfer documentation
Message-ID: <Z2RRvnsYZ7t3f8-b@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Mon, Dec 02, 2024 at 05:20:11AM -0800, Steve Sistare wrote:
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I think this one is already good enough, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

But still, a few comments inline.

> ---
>  docs/devel/migration/CPR.rst | 176 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 63c3647..a8a57c0 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>  VM is migrated to a new QEMU instance on the same host.  It is
>  intended for use when the goal is to update host software components
>  that run the VM, such as QEMU or even the host kernel.  At this time,
> -cpr-reboot is the only available mode.
> +the cpr-reboot and cpr-transfer modes are available.
>  
>  Because QEMU is restarted on the same host, with access to the same
>  local devices, CPR is allowed in certain cases where normal migration
> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>  Outgoing:
>    * Set the migration mode parameter to ``cpr-reboot``.
>    * Set the ``x-ignore-shared`` capability if desired.
> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>      ``file`` type, but one can use other types such as ``exec``,
>      provided the command captures all the data from the outgoing side,
>      and provides all the data to the incoming side.
> @@ -145,3 +145,175 @@ Caveats
>  
>  cpr-reboot mode may not be used with postcopy, background-snapshot,
>  or COLO.
> +
> +cpr-transfer mode
> +-----------------
> +
> +This mode allows the user to transfer a guest to a new QEMU instance
> +on the same host with minimal guest pause time, by preserving guest
> +RAM in place, albeit with new virtual addresses in new QEMU.

IMHO it's important to have some words discussing the diff
v.s. ignore-shared, because from above it's undistinguishable from it.

The important bit could be that cpr-transfer allows pinning.  If that's too
internal a concept, we could mention "unlike an ignore-shared migration,
cpr-transfer will start to enable local migrations to work seamlessly with
all kinds of device assignments like VFIO, vDPA and so on".

> +
> +The user starts new QEMU on the same host as old QEMU, with the
> +same arguments as old QEMU, plus the ``-incoming option``.  The user
> +issues the migrate command to old QEMU, which stops the VM, saves
> +state to the migration channels, and enters the postmigrate state.
> +Execution resumes in new QEMU.
> +
> +This mode requires a second migration channel type "cpr" in the
> +channel arguments on the outgoing side.  The channel must be a type,
> +such as unix socket, that supports SCM_RIGHTS.  However, the cpr
> +channel cannot be added to the list of channels for a migrate-incoming
> +command, because it must be read before new QEMU opens a monitor.
> +Instead, the user passes the channel as a second -incoming
> +command-line argument to new QEMU using JSON syntax.
> +
> +Usage
> +^^^^^
> +
> +Memory backend objects must have the ``share=on`` attribute.
> +
> +The VM must be started with the ``-machine aux-ram-share=on``
> +option.  This causes implicit RAM blocks (those not described by
> +a memory-backend object) to be allocated by mmap'ing a memfd.
> +Examples include VGA and ROM.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-transfer``.
> +  * Issue the ``migrate`` command, containing a main channel and
> +    a cpr channel.
> +
> +Incoming:
> +  * Start new QEMU with two ``-incoming`` options.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-transfer mode may not be used with postcopy, background-snapshot,
> +or COLO.

Maybe we can even remove this line.  It's not like someone could think
about supporting any of above; they just don't apply in cpr context.

> +
> +memory-backend-epc is not supported.
> +
> +The main incoming migration channel cannot be a file type.
> +
> +If the main incoming migration channel is a tcp type, then the port
> +cannot be 0 (meaning dynamically choose a port).
> +
> +When using ``-incoming defer``, you must issue the migrate command to
> +old QEMU before issuing any monitor commands to new QEMU, because new
> +QEMU blocks waiting to read from the cpr channel before starting its
> +monitor, and old QEMU does not write to the channel until the migrate
> +command is issued.  However, new QEMU does not open and read the
> +main migration channel until you issue the migrate incoming command.
> +
> +Example 1: incoming channel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In these examples, we simply restart the same version of QEMU, but
> +in a real scenario one would start new QEMU on the incoming side.
> +Note that new QEMU does not print the monitor prompt until old QEMU
> +has issued the migrate command.  The outgoing side uses QMP because
> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
> +brevity.
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -qmp stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming tcp:0:44444
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...
> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "running",
> +              "running": true}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Example 2: incoming defer
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This example uses ``-incoming defer`` to hot plug a device before
> +accepting the main migration channel.  Again note you must issue the
> +migrate command to old QEMU before you can issue any monitor
> +commands to new QEMU.
> +
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming defer
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...
> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "device_add",
> +   "arguments": {"driver": "pcie-root-port"}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: paused (inmigrate)
> +                                        (qemu) device_add pcie-root-port
> +                                        (qemu) migrate_incoming tcp:0:44444
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Futures
> +^^^^^^^
> +
> +cpr-transfer mode is based on a capability to transfer open file
> +descriptors from old to new QEMU.  In the future, descriptors for
> +vfio, iommufd, vhost, and char devices could be transferred,
> +preserving those devices and their kernel state without interruption,
> +even if they do not explicitly support live migration.
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


