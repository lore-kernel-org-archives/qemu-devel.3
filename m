Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020B0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfI56-0000ah-Uh; Thu, 02 Jul 2026 10:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfI51-0000aJ-Aa
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wfI4y-0005Du-NH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 10:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783001266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i3RDCN2vN7VaEcfPzoYZ0jodyZY2aWslYWNMdSBdpHo=;
 b=fYC3aSew8ghQz61S6JXiTGczAmMazU7QWScUOr607IXUaHN5MPnN0fMesCwx15jI6ylKF2
 rwKe7Cyvr1dI4f9cauBEXM0ICHKvbjD8/x+PjkjXOqbNdR2rXq4cPHFRCVRtyBoPIsB8T9
 INFhYZEHSwkgnjg4oE4O78qvAMcX5fQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-I7ri7vt8Mbqh5vPueTaHEQ-1; Thu,
 02 Jul 2026 10:07:43 -0400
X-MC-Unique: I7ri7vt8Mbqh5vPueTaHEQ-1
X-Mimecast-MFC-AGG-ID: I7ri7vt8Mbqh5vPueTaHEQ_1783001262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B81C21833388; Thu,  2 Jul 2026 14:07:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A57CA1800841; Thu,  2 Jul 2026 14:07:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B4EE21E6920; Thu, 02 Jul 2026 16:07:38 +0200 (CEST)
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
In-Reply-To: <akZocWIi6-Pmwk3N@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 2 Jul 2026 14:32:33 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-33-berrange@redhat.com>
 <178233405051.3955748.10990724544083287885.b4-review@b4>
 <87zf0busnt.fsf@pond.sub.org> <akZocWIi6-Pmwk3N@redhat.com>
Date: Thu, 02 Jul 2026 16:07:38 +0200
Message-ID: <877bndzdqt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 01, 2026 at 08:32:06AM +0200, Markus Armbruster wrote:

[...]

>> >>  static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>> >>  {
>> >>      QDict *data;
>> >>      MonitorQMP *mon =3D opaque;
>> >>=20=20
>> >> +    /* Protect against race if a client drops & quickly
>> >> +     * reconnects - we'll have the delete BH scheduled
>> >> +     * so must not honour a new open request
>> >> +     */
>> >> +    if (mon->delete_pending) {
>> >> +        return;
>> >> +    }
>>=20
>> Consider "something happens between setting @delete_pending and monitor
>> destruction that triggers the event" and "same thing happens after
>> destruction".  Any observable differences in behavior?
>>=20
>> Are there any other monitor interactions that might need similar
>> special-casing when @delete_pending?
>
> When the BH deletes the monitor object, it will disconnect the
> chardev handlers. So there is no possibility of monitor_qmp_event
> being called after the monitor QOM destruction is complete. The
> only race is between this method and the start of the BH.

Add this completeness argument to the commit message?


