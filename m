Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C44C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHXB-0005Hn-1W; Thu, 02 Jul 2026 09:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfHX8-0005Gp-ML
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfHX6-0007mr-Kv
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782999167;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEiiqyCknAK/WhENlqtqHsVylMyOpbn7DqtgvExilNM=;
 b=RtULRtcKMTMspYinTcAP6/LFu1HUPP/ZbKEwK0FkchNEof7F7vflY4TQdscjJEXisI8ejt
 8wgRxvcwUp7eY0qcvHiHUVQBSpWJo8LyNYUPyw+3UG2INxFKx1W1tH1uxtF5pMxkN0luLd
 7MUieaOgqPjBzTtS99q8kUbGa3upViE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-fw2krMUsOR-LBVAAdlwHhA-1; Thu,
 02 Jul 2026 09:32:44 -0400
X-MC-Unique: fw2krMUsOR-LBVAAdlwHhA-1
X-Mimecast-MFC-AGG-ID: fw2krMUsOR-LBVAAdlwHhA_1782999161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 152B518C1072; Thu,  2 Jul 2026 13:32:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.186])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02A8C180058D; Thu,  2 Jul 2026 13:32:36 +0000 (UTC)
Date: Thu, 2 Jul 2026 14:32:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting monitors
 upon close
Message-ID: <akZocWIi6-Pmwk3N@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
 <87zf0busnt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf0busnt.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 01, 2026 at 08:32:06AM +0200, Markus Armbruster wrote:
> marcandre.lureau@redhat.com writes:
> 
> >> The default monitor is usually a long lived object that will exist for
> >> the entire lifetime of the VM. A monitor can only service a single
> >> client at a time though, and so it might be desirable to hotplug
> >> additional monitors at runtime for specific tasks. If doing that,
> >> however, there is a need to remove the monitor when it is no longer
> >> needed.
> 
> Whatever adds the additional monitor can also delete it.  The fact that
> you propose other means suggests you believe this would be cumbersome in
> practice.  Why?
> 
> >> 
> >> Allowing a client to run "object-del" against its own monitor adds
> >> complex edge cases, as it would be desirable to send the QMP response
> >> despite the monitor sending it being deleted. Doing "object-del" alone
> >> will also result in orphaning a character device backend instance, as
> >> there is no opportunity to run the companion "chardev-del" command.
> >> 
> >> A simpler way to ensure cleanup is to add the concept of auto-deleting
> >> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
> >> emitted, the equivalent of "object-del" + "chardev-del" can be run
> >> internally. Since the transient client has already droppped its
> >> monitor connection, there is no synchronization to be concerned about.
> 
> If object-del or chardev-del fail, there's no way to report the error.
> Can they fail?
> 
> Do we always want to delete both monitor and character device?
> 
> >> This is implemented via a new "close-action=none|delete" property on
> >> the 'monitor-qmp' object. This concept could be extended with further
> >> actions in future, for example:
> >> 
> >>  * close-action=shutdown - graceful guest shutdown
> >>  * close-action=terminate - immediate guest poweroff
> >>  * close-action=stop - pause guest CPUs while the monitor is not
> >>                        connected to any client
> 
> I'm not sure these would be useful and safe.  Mentioning them here is
> okay regardless.
> 
> >> 
> >> This is left as an exercise for future interested contributors.
> >> 
> >> Tested-by: Peter Krempa <pkrempa@redhat.com>
> >> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> Message-ID: <20260624173752.2928717-33-berrange@redhat.com>

snip

> >> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> >> index 5522e05464b..23829f32f9a 100644
> >> --- a/monitor/monitor-internal.h
> >> +++ b/monitor/monitor-internal.h

snip

> >> +static void monitor_qmp_self_delete_bh(void *opaque)
> >> +{
> >> +    MonitorQMP *mon = opaque;
> >> +    g_autofree char *mon_id = object_property_get_child_name(
> >> +        object_get_objects_root(), OBJECT(mon));
> >> +    g_autofree char *chardev_id = g_strdup(mon->parent_obj.chardev_id);
> >> +    Error *local_error = NULL;
> >> +
> >> +    if (!mon_id) {
> >> +        /* Another monitor raced & ran 'object-del' on 'mon'
> >> +         * before this BH got scheduled, so we have a ref on
> >> +         * mon but it is already unparented.
> >> +         */
> >> +        object_unref(mon);
> >> +        return;
> >> +    }
> >> +
> >> +    user_creatable_del(mon_id, &local_error);
> >> +    object_unref(mon);
> 
> This object_unref() and the one above pair with the object_ref() in
> monitor_qmp_event() case MONITOR_QMP_CLOSE_ACTION_DELETE.  Correct?
> 
> Is this worth a comment?
> 
> >> +    if (local_error != NULL) {
> >> +        error_report_err(local_error);
> >> +    } else {
> >> +        qmp_chardev_remove(chardev_id, NULL);
> >> +    }
> >> +}
> >> +
> >>  static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >>  {
> >>      QDict *data;
> >>      MonitorQMP *mon = opaque;
> >>  
> >> +    /* Protect against race if a client drops & quickly
> >> +     * reconnects - we'll have the delete BH scheduled
> >> +     * so must not honour a new open request
> >> +     */
> >> +    if (mon->delete_pending) {
> >> +        return;
> >> +    }
> 
> Consider "something happens between setting @delete_pending and monitor
> destruction that triggers the event" and "same thing happens after
> destruction".  Any observable differences in behavior?
> 
> Are there any other monitor interactions that might need similar
> special-casing when @delete_pending?

When the BH deletes the monitor object, it will disconnect the
chardev handlers. So there is no possibility of monitor_qmp_event
being called after the monitor QOM destruction is complete. The
only race is between this method and the start of the BH.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


