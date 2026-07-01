Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wev7s-00037T-RW; Wed, 01 Jul 2026 09:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wev7r-00037H-Dk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wev7p-00042S-KZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782913031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PmtpMO/nMpYv77e5X23T8MgyYWNfiBq1aNlzuRUAe0=;
 b=AHutz8BRkW5smrK/7HFQ7LYmBoOBbLgCDNZY3TQ8oc35zMpZ5sjPXlCUfY84vCFjVujgRR
 BHrJAgFG3macvMyP7g099/kZ8pztsbwaJUqacKcPu5ssq2/hGrl1Wt7TERR0IEL4VGn2/0
 eHKx7iqpELsB9x2Ro0dj6t8TiRJ8O80=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-_9Dkiz9iO6yEtOZtl1iKVQ-1; Wed,
 01 Jul 2026 09:37:08 -0400
X-MC-Unique: _9Dkiz9iO6yEtOZtl1iKVQ-1
X-Mimecast-MFC-AGG-ID: _9Dkiz9iO6yEtOZtl1iKVQ_1782913026
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551DD1944EAE; Wed,  1 Jul 2026 13:37:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 346B01800612; Wed,  1 Jul 2026 13:37:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B986021E6920; Wed, 01 Jul 2026 15:37:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 32/35] monitor: add support for auto-deleting
 monitors upon close
In-Reply-To: <akTLejz0-b48s5NS@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 1 Jul 2026 09:10:34 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
 <87zf0busnt.fsf@pond.sub.org> <akTLejz0-b48s5NS@redhat.com>
Date: Wed, 01 Jul 2026 15:37:02 +0200
Message-ID: <87mrwa4yrl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 01, 2026 at 08:32:06AM +0200, Markus Armbruster wrote:
>> marcandre.lureau@redhat.com writes:
>>=20
>> >> The default monitor is usually a long lived object that will exist for
>> >> the entire lifetime of the VM. A monitor can only service a single
>> >> client at a time though, and so it might be desirable to hotplug
>> >> additional monitors at runtime for specific tasks. If doing that,
>> >> however, there is a need to remove the monitor when it is no longer
>> >> needed.
>>=20
>> Whatever adds the additional monitor can also delete it.  The fact that
>> you propose other means suggests you believe this would be cumbersome in
>> practice.  Why?
>
> The use is is that someone/something wants to spawn a script that
> does some job with the QEMU monitor.  The thing that spawns the
> script adds the new monitor and launches the script. Having
> auto-delete means that you do not need to then keep track of that
> script to perform cleanup of the dynamically added monitor. It
> gives you "do the right thing" behaviour automatically when the
> script exits, closing its monitor connection.
>
> The initial series proposed by Christian supported the ability
> to run "object-del' on the monitor itself - a "self delete"
> essentially. That is very awkward from the code POV, as it
> required special case hanlding to ensure the QMP response to
> the delete action got sent on the socket before the delete
> action took place. It also made it impossible to then delete
> the character device.
>
> Auto-delete gives us a better solution with less code complexity.

I agree "self delete" is problematic.

I wonder how important the ability to fire and forget a script with a
dedicated monitor is.  I'd (naively?) expect whatever spawns the script
to reap its exit status.

If it is important, what about fire and forget a script with a dedicated
character device?  Can't come up with a use case for that within ten
seconds.  However, we use character devices for all kinds of crap.  Food
for thought, not a demand.

>> >> Allowing a client to run "object-del" against its own monitor adds
>> >> complex edge cases, as it would be desirable to send the QMP response
>> >> despite the monitor sending it being deleted. Doing "object-del" alone
>> >> will also result in orphaning a character device backend instance, as
>> >> there is no opportunity to run the companion "chardev-del" command.
>> >>=20
>> >> A simpler way to ensure cleanup is to add the concept of auto-deleting
>> >> monitor objects. Specifically when the "CHR_EVENT_CLOSED" event is
>> >> emitted, the equivalent of "object-del" + "chardev-del" can be run
>> >> internally. Since the transient client has already droppped its
>> >> monitor connection, there is no synchronization to be concerned about.
>>=20
>> If object-del or chardev-del fail, there's no way to report the error.
>> Can they fail?
>
> object-del can fail if
>
>  * An object with the specified "id" does not exist. That shouldn't
>    happen in this case but harmless if it odes.
>  * object_del command tries to delete the monitor that
>    is servicing the object_del command. Cannot happen with
>    auto-delete
>  * the monitor has not finished initializing it BH with
>    chardev handlers. Cannot happen if we know we have a
>    live connection already.
>
> chardev-del can fail if
>
>  * The chardev with "id" does not exist. SHouldn't happen
>    but is harmless if it does
>  * The chardev reports it is "busy" - aka the frontend
>    is still connected - we just deleted it so cannot happen
>  * Record/replay is in use - a niche use case
>
> So I don't think errors are a problem.
>
>> Do we always want to delete both monitor and character device?
>
> IMHO yes they are a pair whose lifetime should be tied together
> for normal use.

Would we make monitor auto-delete delete its character device if
character devices also had an auto-delete feature?

[...]


