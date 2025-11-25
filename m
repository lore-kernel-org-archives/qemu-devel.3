Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD8CFD368
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrPZ-0006IC-LT; Tue, 25 Nov 2025 06:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNrPY-0006G8-1I
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNrPW-0007j9-DC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764070839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HV5v/0PX91ze+rqqyXuU8cyV6ZiotaUP3OO2JKWgpBo=;
 b=C/l+H2HIX4kU+K/nihkhAUIQi9MAkpikMZYix4ydVVn2hQ4NS09nsMWvxyr1jigev+GnF0
 rV4IB0n4rqOCf6+XjqWKZPYoSWjdbFXFVOom4w9k0ZYcBDAFuiQEMKjkXS9CPZkAlTDaoi
 3AxGKBQo2ZKUg597eE7ek6yMv4qpCsQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-rOHIm4nHPKaBGrGs89H5Ew-1; Tue,
 25 Nov 2025 06:40:36 -0500
X-MC-Unique: rOHIm4nHPKaBGrGs89H5Ew-1
X-Mimecast-MFC-AGG-ID: rOHIm4nHPKaBGrGs89H5Ew_1764070836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6FEF180057A; Tue, 25 Nov 2025 11:40:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 418EF18004D8; Tue, 25 Nov 2025 11:40:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9A6321E6A27; Tue, 25 Nov 2025 12:40:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  kvm@vger.kernel.org,
 eesposit@redhat.com
Subject: Re: [PATCH] kvm: Don't assume accel_ioctl_end() preserves @errno
In-Reply-To: <bdbb568d-0432-4d59-bd1f-cf2eb20bc2a1@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 25 Nov 2025 11:33:43
 +0100")
References: <20251125090146.2370735-1-armbru@redhat.com>
 <875xay4h6y.fsf@pond.sub.org>
 <bdbb568d-0432-4d59-bd1f-cf2eb20bc2a1@linaro.org>
Date: Tue, 25 Nov 2025 12:40:32 +0100
Message-ID: <871plm2vdb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 25/11/25 10:03, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>>> Retrieve the @errno set by ioctl() before we call accel_ioctl_end()
>>> instead of afterwards, so it works whether accel_ioctl_end() preserves
>>> @errno or not.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>=20
>> I did not check whether the assumption holds or not.
>
> Indeed, on Linux the futex syscall is called via qemu_event_set.

So ...

>>  If it doesn't,
>> then this needs
>>=20
>>    Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)

... we definitely want this tag, and the commit message should be
clarified as well.  Here's my try:

    kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value

    These functions wrap ioctl().  When ioctl() fails, it sets @errno.
    The wrappers then return that @errno negated.

    Except they call accel_ioctl_end() between calling ioctl() and reading
    @errno.  accel_ioctl_end() can clobber @errno, e.g. when a futex()
    system call fails.  Seems unlikely, but it's a bug all the same.

    Fix by retrieving @errno before calling accel_ioctl_end().

    Fixes: a27dd2de68f3 (KVM: keep track of running ioctls)

> LGTM.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!


