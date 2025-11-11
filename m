Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB48CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 08:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIjZH-0003YO-6M; Tue, 11 Nov 2025 03:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjZF-0003Sy-D7
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vIjZD-0003t1-K4
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 03:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762849050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YusdMKKfuZa6AdZ+htp2fyUAslY0D7TTFVBo4lZHQYU=;
 b=MmMShZy2x1RLtDgu/JmyqrePmagmwBZNLJiwIek2k6z6q3aMa/L1amEnUU59p2NnSDr8+q
 S42JdrUPUAmm5rmt4p2tDkjAKbC3siOJTiWSAC+KZ0BdrOAcqJU2cVOIa6qinDK1QMEtai
 K7mVEBTiAQls0Uh/JzL6QRhg+St+Qu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-SUAGR8pBNTSkLUuIH8PlPw-1; Tue,
 11 Nov 2025 03:17:27 -0500
X-MC-Unique: SUAGR8pBNTSkLUuIH8PlPw-1
X-Mimecast-MFC-AGG-ID: SUAGR8pBNTSkLUuIH8PlPw_1762849046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B694180057A; Tue, 11 Nov 2025 08:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C42331800361; Tue, 11 Nov 2025 08:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 228EC21E6A27; Tue, 11 Nov 2025 09:17:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 qemu-block@nongnu.org,
 qemu-devel@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
In-Reply-To: <aRIE8ACbqWZ2MPdE@redhat.com> (Kevin Wolf's message of "Mon, 10
 Nov 2025 16:29:52 +0100")
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-3-chigot@adacore.com>
 <874ir2nqr9.fsf@pond.sub.org>
 <CAJ307Ej8oNXjOZt2fkBMjR6bKSf=C2M6ncFFLCfy=Wk6+KMhNQ@mail.gmail.com>
 <877bvykp3q.fsf@pond.sub.org> <aRIE8ACbqWZ2MPdE@redhat.com>
Date: Tue, 11 Nov 2025 09:17:23 +0100
Message-ID: <87ldkddlv0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.11.2025 um 14:13 hat Markus Armbruster geschrieben:
>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>>=20
>> > On Mon, Nov 10, 2025 at 11:09=E2=80=AFAM Markus Armbruster <armbru@red=
hat.com> wrote:
>> >>
>> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:

[...]

>> >> > So it is a special case in a way, but given that this is vvfat, whi=
ch is
>> >> > known to be unstable, not widely used outside of the occasional man=
ual
>> >> > use and not supported by libvirt, I'm willing to just make the chan=
ge.
>>=20
>> I'm fine to treat vvfat as unstable.  But it's not marked as such in the
>> QAPI schema!  Is that a bug?  Again, for Kevin.
>
> Maybe? Though the kind of unstable I think of with vvfat is more than
> just API instability that the QAPI feature is about. vvfat is more a
> dirty (and clever) hack that sometimes works and can be useful enough,
> but if it breaks, you get to keep both pieces. Good for one-off uses on
> your personal toy VM, but keep it far away from production. We never
> seriously tried to get it to a properly supportable level.
>
> (And yes, probably none of this is documented as clearly as it should
> be.)

Do we need to differentiate between "unstable interface, may change
incompatibly or be withdrawn in future releases, stay away if you don't
want your software to break when this happens" and "known-wobbly
feature, do not use in production"?

Related ot Daniel's work on marking insecure objects, I think:

    Subject: [PATCH v2 00/32] Encode object type security status in code
    Date: Fri, 26 Sep 2025 15:01:11 +0100
    Message-ID: <20250926140144.1998694-1-berrange@redhat.com>


