Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA109CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjcI-0000ha-5Y; Wed, 17 Jun 2026 02:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZjcG-0000gg-Fj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZjcE-00034W-NB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781677148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VOzHT253eQlU1G72RQrrd7zHcygnQ0SP5Ifh/akOPQ=;
 b=VOycE/qaV27NuMQ16Q3+KoCRW7suPw1rAb0m/KfP8G4KXuKK9/xrxpTimQGc9DmaMSV/qy
 pCQlf5qaNWRzzEkCJAWjbVP/AU8SD6LEO0ZbdZm7QwiYxXS8ufBlDdDZGoLkZK21JgOnhx
 KcobCDtAsyoUx7KRFJUjWdUs5Pg7Djg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-_0LnBf5KO-2XiPV0do1_4Q-1; Wed,
 17 Jun 2026 02:19:05 -0400
X-MC-Unique: _0LnBf5KO-2XiPV0do1_4Q-1
X-Mimecast-MFC-AGG-ID: _0LnBf5KO-2XiPV0do1_4Q_1781677144
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01E01953998; Wed, 17 Jun 2026 06:19:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEED43008B3E; Wed, 17 Jun 2026 06:19:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4984521E6A01; Wed, 17 Jun 2026 08:19:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  philmd@oss.qualcomm.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
In-Reply-To: <72a4533f-067a-4539-99a5-ebbc34224167@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Tue, 16 Jun 2026 11:16:01 -0700")
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <ajEA4CybcZHwYEEF@redhat.com>
 <CAFEAcA_r2+S+iy4nu4Kv9Gjwsu_izq5iHUYs6vycq=dX-+Cpsw@mail.gmail.com>
 <72a4533f-067a-4539-99a5-ebbc34224167@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:19:00 +0200
Message-ID: <87mrwtpu3v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 6/16/2026 1:30 AM, Peter Maydell wrote:
>> On Tue, 16 Jun 2026 at 08:54, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>>
>>> On Mon, Jun 15, 2026 at 01:17:23PM -0700, Pierrick Bouvier wrote:
>>>> We add a new script: scripts/check-maintainers-file.py, that will run =
at
>>>> configuration time (and not at build time), to not hurt build time.
>>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>>
>>>> We can expect things to be mostly in sync since adding or removing a
>>>> source or test file will trigger a configure step.
>>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>>> build things from scratch and always run the configure step.
>>>>
>>>> With this, it should be impossible by design to have an upstream
>>>> MAINTAINERS file with non existing file entries.
>>>
>>> Accuracy of the MAINTAINERS file is an upstream-only concern, but
>>> IIUC, this check is going to apply universally to every build of
>>> QEMU which is undesirable. It is irrelevant to end users and not
>>> appropriate to check in downsteam vendors forks.
>>>
>
> I accept the argument about downstream forks even though they are free
> to remove the check since they are... forks.
> However, it's relevant to users I think. It's very easy to move a file,
> and forget to update associated MAINTAINERS entry, and the sooner we
> catch that, the better. Similar, when a new file is added and not
> covered by an entry in MAINTAINERS, it's very easy to miss that.
>
>>> In a "normal" modern project this kind of check would be done in
>>> a CI job on the merge request, since that's the only place it is
>>> relevant. In our case, the nearest fit is the checkpatch.pl file.
>
> It depends how fast you want to catch the problem.
> Adding yet another round trip latency to a project that already has a
> multi day latency for upstream is not a good thing IMHO.

Yes, and ...

> Also, it brings yet another burden on top maintainers that will have to
> deal with this new failure, fix it themselves, or recreate their staging
> set for the next batch and wait for yet another day. More time spent,
> more noise, more iteration, just for a missing line update in
> MAINTAINERS file.

... yes.

We might have conditioned ourselves to consider such loops normal.
They're not.

> All that is nonexistent if no one can build it if it's incorrect. That's
> why we use -Werror by default for instance. And if someone sends a patch
> breaking this, you can be sure they didn't even try to build their own
> code/doc/test.

I don't want make to fail during development just because I haven't
updated MAINTAINERS, yet.  It's a distraction that could snap me out of
the flow.  I'm developing with -Werror disabled for the same reason.

I do want make to fail before I send patches.  I do another compile with
-Werror enabled then, but that's just my personal workflow.

Solutions I like well enough:

* Make it a compile-time warning that obeys --enable-werror.  Could well
  be more trouble than it's worth.

* Make it fail "make check".

Dislike:

* Make it a checkpatch.pl error.  Stays out of my hair during
  development, but then I have to remember to actually run
  checkpatch.pl, or risk having CI bouncing things back to me, wasting
  everybody's time.  Meh

* Make it fail CI in some other way.  Worse, because now I have to
  remember running checkpatch.pl *and* that other way.

* Make it fail "make".  Stay out of my hair!

> Does that open your view on this approach?
>
>>=20
>> You could put it in "make check", or (if you want to avoid the
>> downstream-forks issue) in some sub-bit of "make check"
>> that we don't check by default but do check in one of our CI jobs.
>>
>
> If argument above is still rejected, we can just add a CI job (calling
> script directly). I'm not sure any kind of integration is needed. Also,
> not sure where to fit that in any existing test suite to be honest.
>
>> checkpatch isn't a great place for checks that you want to
>> stay consistent on because so much of its output is "this
>> is wrong/merely something to check, ignore".
>>
>
> I agree, checkpatch is not useful to enforce things. It would be
> different if it was strictly enforced in CI, but that's not the case,
> and won't be given the false positives it brings.

CI should only reject things that are actually wrong, or at least
undesirable.

checkpatch.pl warns when you add, move, or delete files without updating
MAINTAINERS.  It's only a warning, because MAINTAINERS may in fact not
need an update.  Not good enough for CI rejects.

The purpose of warnings is to help maintainers and developers find
*potential* issues.

>
>> -- PMM
>
> Thanks for both of you for the feedback,
> Pierrick


