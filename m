Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D140C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjhv-0006YU-GR; Mon, 06 Jul 2026 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgjhr-0006Te-9H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgjhp-0007En-BI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783345791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWcDQbDTDw5p+fLIxViMRh9E3X9KLG1DvQXwGt9mwOo=;
 b=FvtzEUtePJJuQhadAnsiWX1aN5ZRGiN1j3QHNSPLzvaYnwVnHFT61jeQaaAIAtzuki7o5P
 7ZmG42bIB5BEPH/Z4DxaB2EKoFIktwu3s+VyIE82GcB72DeYhtMY7l/r4q6xawc3kGVAMy
 O/j3ofHLKEjVS/PbM9Jqqqi987YciHM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-QZix-ntePWGRBwGSDjOPNg-1; Mon,
 06 Jul 2026 09:49:50 -0400
X-MC-Unique: QZix-ntePWGRBwGSDjOPNg-1
X-Mimecast-MFC-AGG-ID: QZix-ntePWGRBwGSDjOPNg_1783345788
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 874C71800643; Mon,  6 Jul 2026 13:49:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E60E3000715; Mon,  6 Jul 2026 13:49:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3201A21E6920; Mon, 06 Jul 2026 15:49:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Christian Brauner <brauner@kernel.org>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v6 01/34] qom: replace 'can_be_deleted' with
 'prepare_delete'
In-Reply-To: <akum0a48LrMa0bJt@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 6 Jul 2026 14:00:01 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-2-berrange@redhat.com>
 <87mrw8y3s3.fsf@pond.sub.org> <akum0a48LrMa0bJt@redhat.com>
Date: Mon, 06 Jul 2026 15:49:45 +0200
Message-ID: <87v7asmdmu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jul 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > While most objects can perform all their cleanup in the finalizer
>> > method, there can be interactions with other resources / subsystems
>> > / threads which require that some cleanup be performed on an user
>> > creatable object before unparenting it and entering finalization.
>> >
>> > The current 'can_be_deleted' method runs in the deletion path and
>> > is intended to be used to block deletion. While it could be used
>> > to perform cleanup tasks, its name suggests it should be free of
>> > side-effects.
>> >
>> > Generalize this by renaming it to 'prepare_delete', explicitly
>> > allowing for cleanup to be provided. Existing users of 'can_be_deleted'
>> > are re-written, which provides them with more detailed/tailored error
>> > messages.
>>=20
>> Old message:
>>=20
>>         error_setg(errp, "object '%s' is in use, can not be deleted", id=
);
>>=20
>> New messages:
>>=20
>>         error_setg(errp, "Cryptodev backend '%s' is still in use",
>>         error_setg(errp, "Host memory backend '%s' is still mapped",
>>         error_setg(errp, "IOMMUFD backend '%s' still has %d users",
>>         error_setg(errp, "Throttle group '%s' still has multiple referen=
ces",
>>     error_setg(errp, "Deleting CAN bus device '%s' is not supported",
>>     error_setg(errp, "Deleting main loop '%s' is not supported",
>>=20
>> All now mention what kind of object it is.  Users could probably figure
>> this out from context easily.  Welcome small improvement.
>>=20
>> The two unconditional ones become more accurate: they now report "not
>> supported" instead of "in use".
>>=20
>> The other four lose "can not be deleted".  Users can probably figure
>> this out from context.  Still, I lean towards error messages like "Can't
>> DO-SOMETHING because REASON" until that becomes overly verbose.  What do
>> you think?
>
> I'll change them as follows:
>
>   -        error_setg(errp, "Cryptodev backend '%s' is still in use",
>   +        error_setg(errp,
>   +                   "Cannot delete cryptodev backend '%s' that is in us=
e",
>
>
>   -        error_setg(errp, "Host memory backend '%s' is still mapped",
>   +        error_setg(errp,
>   +                   "Cannot delete host memory backend '%s' which is ma=
pped",
>
>
>   -        error_setg(errp, "IOMMUFD backend '%s' still has %d users",
>   +        error_setg(errp, "Can not delete IOMMUFD backend '%s' with %d =
users",
>
>
>   -        error_setg(errp, "Throttle group '%s' still has multiple refer=
ences",
>   +        error_setg(errp,
>   +                   "Cannot delete throttle group '%s' with active refe=
rences",

Works for me, thanks!


