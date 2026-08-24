Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A03C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyVsr-0001OZ-4a; Mon, 24 Aug 2026 10:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVso-0001ML-NO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyVsn-0007N4-19
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 10:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787582559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=u+NBWWqcUHs5ssfN5Rb0Q5HairH34nNGEaNv1uLG/do=;
 b=jSC4PEPwWANmX9ATVi8aMc6GvRGxiJi6QvZ10M0ip6hWjgI4sXKOKnyRNVmVAgzb8XuW+w
 lULZokKUH6fsuAXJrR13Ms1FOST8z+jAXr3LO3xD5J+mgd+hQ8bkOgnRJQ8s9z7LnDCe8j
 AmhC3829l5cr7ip6cahDS5CVCwA6RG0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-G0JcXDphOs-FociHKCrOfA-1; Mon,
 24 Aug 2026 10:42:35 -0400
X-MC-Unique: G0JcXDphOs-FociHKCrOfA-1
X-Mimecast-MFC-AGG-ID: G0JcXDphOs-FociHKCrOfA_1787582551
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9642183459B; Mon, 24 Aug 2026 14:42:30 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73B821955F10; Mon, 24 Aug 2026 14:42:23 +0000 (UTC)
Date: Mon, 24 Aug 2026 15:42:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org,
 clg@redhat.com, akrowiak@linux.ibm.com, jjherne@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH 3/8] qdev: Support forced device_del in QMP and HMP
Message-ID: <aoxYTO8UkzzXvKOc@redhat.com>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <20260824011420.752806-4-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824011420.752806-4-dongli.zhang@oracle.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Aug 23, 2026 at 06:13:33PM -0700, Dongli Zhang wrote:
> Add an optional force argument to the QMP device_del command and expose it
> in HMP as "device_del -f".
> 
> When force is requested, qdev_unplug() bypasses the pending deletion guard
> and asks the selected hotplug controller to complete removal through its
> force_unplug callback. Controllers that do not implement the callback
> reject the operation.
> 
> Forced removal bypasses guest cooperation.

This sentence is rather missing the punchline....

  Force removal bypasses guest cooperation and may result in guest
  errors, I/O failures, or guest panics. The guest OS cannot be
  trusted after force removal until a full power cycle has been
  performed.

I'm rather on the fence as to whether it is a good idea to enable
this feature or not. If it is used by a cloud admin without knowledge
of the guest owner, its use is liable to lead to hard-to-debug/diagnose
problems in the guest OS.

If a guest OS is not honouring an unplug request and the host owner needs
to force reclaim a resource, power off is always there as the failsafe.

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 974cf9c583..cb5b5ad1db 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -90,6 +90,11 @@
>  #
>  # @id: the device's ID or QOM path
>  #
> +# @force: if true, remove the device without waiting for guest
> +#     cooperation.  The guest may still be using the device.  This can
> +#     cause guest-visible errors, I/O failures, or guest crashes.

I'd want to be warning in a stronger way.


 This is a dangerous operation that can cause guest-visible errors,
 I/O failures, or guest crashes. The guest OS state should not be
 trusted after a forced device removal, until a full power cycle has
 been performed.


> +#     (since 11.2)
> +#
>  # Errors:
>  #     - If @id is not a valid device, DeviceNotFound
>  #
> @@ -101,7 +106,9 @@
>  #    will automatically complete removal for all devices.  If a
>  #    guest-side error in the hot removal process is detected, the
>  #    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
> -#    event is sent.  Some errors cannot be detected.
> +#    event is sent.  Some errors cannot be detected.  If @force is
> +#    true, guest cooperation is bypassed, but backend cleanup is still
> +#    performed through the device's normal unrealize path.
>  #
>  # Since: 0.14
>  #
> @@ -117,7 +124,7 @@
>  #          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
>  #     <- { "return": {} }
>  ##
> -{ 'command': 'device_del', 'data': {'id': 'str'} }
> +{ 'command': 'device_del', 'data': {'id': 'str', '*force': 'bool'} }
>  
>  ##
>  # @DEVICE_DELETED:
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index fa3cae246b..ca10a25c46 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -956,11 +956,13 @@ void qdev_unplug(DeviceState *dev, bool force, Error **errp)
>      error_propagate(errp, local_err);
>  }

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


