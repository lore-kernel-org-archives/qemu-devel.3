Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27ACC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSdZ-0008O1-CK; Wed, 09 Jul 2025 07:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZSdP-0008Fp-RZ
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uZSdN-0000wa-9r
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752059196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKBgpuwPVY22fh8yAm00FTbzjULaUBz7CroglPCe2Bw=;
 b=KXtApJI7l96quDUoHnitWI0auzlZm+wSQLRqFU6JcbV0IDaS4X5za1CncrhJgiYm5qvZXf
 Nz693+66FB1rGYhijjL9FWIPx2ZXtsSgqtNPjZksgd65M4TwA///20YAtd6kq5SF6ssm4u
 hCYSA8dgTwUrJQh33pUvTUCF5oNwKBw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-hCMtwzDpMOWHA4RbDuGEuQ-1; Wed,
 09 Jul 2025 07:06:30 -0400
X-MC-Unique: hCMtwzDpMOWHA4RbDuGEuQ-1
X-Mimecast-MFC-AGG-ID: hCMtwzDpMOWHA4RbDuGEuQ_1752059189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C1619560A6; Wed,  9 Jul 2025 11:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B14518003FC; Wed,  9 Jul 2025 11:06:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74A4E21E6A27; Wed, 09 Jul 2025 13:06:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Akihiko
 Odaki <akihiko.odaki@daynix.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>
Subject: Re: Python ecosystem versions overview
In-Reply-To: <CAFn=p-bee25L9Zqyv=LjpCw4WMHqCUAcMaBg0Lbu3gUU6cuakQ@mail.gmail.com>
 (John Snow's message of "Tue, 8 Jul 2025 21:01:07 -0400")
References: <CAFn=p-bp_hFTu7yDGuQa-Eoctnpb_dd4_fgfhrC3umpX1EuvCA@mail.gmail.com>
 <d1c33e1e-8b26-4a75-8b1d-2ec6c54d72d0@redhat.com>
 <CAFn=p-bee25L9Zqyv=LjpCw4WMHqCUAcMaBg0Lbu3gUU6cuakQ@mail.gmail.com>
Date: Wed, 09 Jul 2025 13:06:26 +0200
Message-ID: <87bjptpqrx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jul 8, 2025, 7:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
>> On 7/8/25 22:36, John Snow wrote:
>> > centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3   BaseOS, CRB
>>
>> Ok, so the lowest version of Sphinx (3.4.3) is currently used for CentOS
>> Stream 9.  It's supported for roughly 2 more years, until 12.0.
>>
>
> Yep. I am thinking however that because 3.9 is soon to be EOL this autumn,
> it may become reasonable to start requiring newer Python interpreters for
> this platform as well. They *are* available.
>
> I won't do it without a reason, but I think this may be a reasonable poli=
cy
> moving forward- If your platform is otherwise supported by our policy but
> ships a version of Python from more than five years ago (aka is EOL
> upstream), you *may* be required to install a newer, optional version (if
> and only if one is reasonably available from official distro repositories=
.)
>
> In general, this should have little to no impact except that isolated,
> offline builds (a la rpmbuild) may fail to produce documentation unless
> special considerations are taken for the build environment (namely, sphinx
> needs to be loaded for the newer interpreter).
>
> I think this is a reasonable compromise. If distributions want to package
> bleeding edge QEMU with five-years-old dependencies, they can expect to
> face *some* hurdles, and figuring out how to get sphinx as a builddep to
> build an optional component is not entirely unreasonable.

I agree.

Moreover, I can't see why we should invest into making such packaging
easy without a shred of evidence for anyone actually doing it.

> TLDR - I pledge to support any platform covered by our promise for
> building, but testing and documentation *requires* a non-EOL interpreter.
> This should have little to no effect for developers or users building from
> source or git, but has minor drawbacks for downstream maintainers of
> enterprise distributions that may attempt to backport bleeding edge QEMU
> versions.
>
>
>> > opensuse_leap_15_6  3.6.15   20.0.2  44.1.1      2.3.1   updates/sle,
>>
>> We use the 3.11 runtime in the dockerfile, see
>> tests/lcitool/mappings.yml.  That is a bare minimum install, so
>> configure won't use the distro sphinx and instead use 5.3.0 from
>> pythondeps.toml.
>>
>
> Yep, this tool was made to show the platform defaults only for now. Maybe
> I'll add a "show first party backports" flag in the future, if anyone more
> than just my own personal self would find that useful. (Speak up if so.)
>
>
>> > main/oss
>> > pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3   ---
>> > ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2
>> > jammy-updates/main, jammy/universe, jammy/main
>>
>> This is the second oldest version of Sphinx.
>>
>
> With us until 26.04, in about 0.75 years. This seems like a reasonable new
> minimum if we wanted to increase it, though that does artificially drop
> support for RHEL9/CentOS stream building documentation from source under
> rpmbuild.
>
> (FWIW I probably can continue to support sphinx 3.x for a little while, t=
he
> code is gross but it does appear functional. The only thing we *need* to =
do
> is bump the preferred version, I think. This support generally comes at t=
he
> expense of type checking support for the docs code, as it's so gross I
> couldn't get it to work from 3.x to 8.x inclusive.)

It's gross, it's functional, it's impressive in a "don't do this at
home, kids" way, and it comes with a big, red "John, help!"  button for
you to smash in case of trouble.  Because the few smart enough to be
able to maintain that code are almost certainly much too smart to be
willing to maintain that code.

[...]


