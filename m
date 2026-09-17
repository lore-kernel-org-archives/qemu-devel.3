Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7256EC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GMl-0007m7-GE; Thu, 17 Sep 2026 13:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7GMj-0007lQ-H1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7GMh-0005Ic-JX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789667862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
 b=TBp79/DY7GPZzPdZXcbASS8gYFr+OY5FZqk6Ks9UQSbBd79+wFBTx/uS98VTVVdZrd3vN3
 j+77puUunqBCl94q8KprWL3Yw6/bay6VZMimZ3AftE7crbAzQDCW073Jf4WYh5cBfv4MXW
 kwklA1FpIzu+U8tVeq+lbGS9ERv+618=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-FeyXbE57NRycOphoVC7jUQ-1; Thu, 17 Sep 2026 13:57:41 -0400
X-MC-Unique: FeyXbE57NRycOphoVC7jUQ-1
X-Mimecast-MFC-AGG-ID: FeyXbE57NRycOphoVC7jUQ_1789667860
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-671203c3d56so1287792d50.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789667860; cv=none;
 d=google.com; s=arc-20260327;
 b=EPzJOezB2N6aRFGEOwQYSRoboyNt6gcqMsFwYISM2VM4kD1yYIvtXV13EAeZTDvp/k
 FsHjOEE+98pCdF6liJ/eyyFNTvndy2naQQBqvpSzZR538hygsSJc0677MmBtB868ymqp
 GDFSmmO4Sx/A4v19SRUXoXMNlDrsqWtLnCbQPHc+jEL8+kWd4YJYw9TvUoxq4xuPC9qO
 mBVFXwWh9Ts0mDfZVv7IwsEgu9KvCTTZM4gHaTZtg3Aae//jkLrgdxI0h02PyXhCZQ79
 TJEIHhUDr4vQTGgVGS1iakqv0efBfFA9wwdo3SIpcBfgO1SpbZBPvz3f0QwT5YCZoxJp
 ul3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
 fh=N1T2rJRgpF5SwCDa8mYUq6XaRC8Zgv+Raym5wifJ61I=;
 b=seqLE3LWyzlXhZetWibz040sSQuHtslkdLGDsl5HSnapdRxvp/UYIF+i/uWN34x1z3
 Y4ZPptLY8x8C3riBgR//bMqao/1qH6B5lp+WqWrxFnPng7FP+0FvRpzYlCvNfyHCYZkO
 9ogyjSw7lZT3UK2Ilej9fk//1rNuzCClR47/BsJUhGv8qVkgBESMTTqHaL5YEAqbXCn3
 Nq0Abfx+aj9tw7RtIRzFZ6JOTj5wrkrqSezEoajn/QA558O8AFH7wezO+PC0MoLbmKU2
 6kGfC8+8FaU9UnbAmu6ch0sqviA+bLSIpTzPApNcUp29oIFjcmyLuf5Q7yu2YBJYFWAC
 IPDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789667860; x=1790272660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
 b=BbO3h+jo+ZpFz7p8uD5kWWshB4nWfvI/eHLuGvMlrRSLZ1iMrldx8IONOxAr5FB5G5
 8PJpsvNXKdIvquMj0HDPE9QcJE6w0Sr3R/cgKDWUnP/U1UcnYdvaOVmFvYaoAQYyl5MD
 f8xwB9Uen+I0bN3830YctEVwSZmEXqZ1eUtyxqoSmBClqEgvr0wn3a8MtIuz6dkEQfZ6
 2JtveQ/1trbGm7t/g4kv7iE0C3yfISxTh4kkHEbI9+Q9fArYhWLZb7U81pb6NQpHpeKe
 4U7OTx3075AaZMg+TZeVE+mwUwiqj4QiACW4ZKmIC3lVpYHImkcfT2hMxgxTb9yswb9g
 qk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667860; x=1790272660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O/q/6dJD/yPJToU467v7Aq+z2ukz3I9Dup6fwZQVmx0=;
 b=UaKIxYNZvylrwefGUY/CovF2Xgs3BHzlX1Zj0K/W1pcJmr9Q2GRUYvC9cMPySXkr5L
 CWyHvLzS1dOXg/Du6UlxOFHgODIjRn+EwheSufstmOwfAqU9Z0fWQQG6nE9B99Fw+LGb
 TfVi4UPKlnAMw7ojcXRaqRWfdH1OJSv7zHVw+h4JEAQkNZscvL7UBxu5SH3Nul9beOwq
 DqEA/iAPImatbuo2lltHqw6xwqGLvZroe4fb3FEjZvUnotGZHSTN9p/Cx7/9gR+VUBTE
 gmfoWI4w94PpvAqgKoNKMc8uGutPJeYBUqgrsDGCDC42sGi+5wRBca57+m6VG0aXY0Yd
 btsw==
X-Gm-Message-State: AFuF++lSaCsnKm/4ghM7+1eGs3vH7NECjwczJh65/TSRLnNi8UuI7O/1
 d8EzBhTKHlzOpv8tETB+2q9FHuk/8Dfn11INVx9MZ9iWUz68a35NtgdZ5Au794vG1iosZeBGpI0
 8fbJTg4XW20delKn1PQGn/ORxVTP94Rjs4amwt6P4NISZbgtsI7HBVkRKvs52SSIi6NrppcXWDw
 HuFxmew3JacRNk2Z07EQqCvOwrXYIcx0s=
X-Gm-Gg: AYBFou04isg+ynR1CSH/fCRCPYKzT7AKj5WphjBjxamfFETE9mDo6Sq2rBEbbNCGSjn
 LwLhf5fYNQg9bRawIKVdzZIYvX7J7tJJ9xxec+vkI7bDkXpXButv2UuIz1Mit5/5/mAscnbYyjP
 uEwY5/bMdqOcEGamGZTuFtuqyx9v83shW+QPS/jCioAv9Y/SGJJLv+Mi+XKookGQeecWe+KU2ow
 uiUktRmBfdd1pvf
X-Received: by 2002:a05:690e:120c:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-6717034c5afmr1189620d50.13.1789667860159; 
 Thu, 17 Sep 2026 10:57:40 -0700 (PDT)
X-Received: by 2002:a05:690e:120c:b0:66a:b15e:bb93 with SMTP id
 956f58d0204a3-6717034c5afmr1189605d50.13.1789667859750; Thu, 17 Sep 2026
 10:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260916135841.3614495-1-jsnow@redhat.com>
 <20260916135841.3614495-6-jsnow@redhat.com>
 <87tsno5ulh.fsf@pond.sub.org>
In-Reply-To: <87tsno5ulh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 13:57:28 -0400
X-Gm-Features: AcwNN1XG52uuiUnWNJlaDC6V1kzKVkLG2iXP2kRaAwxcqV_ifQ48YVjOovC8RbY
Message-ID: <CAFn=p-YAVahwz2-MmWkwO10RxrDaJDKNp_2-eqEAyzjqbneW3g@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] qapi/parser: fix intermediate "intro" detection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jonathan Cameron <jic23@kernel.org>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 linux-cxl@vger.kernel.org, 
 qemu-block@nongnu.org, Junjie Cao <junjie.cao@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 17, 2026 at 1:13=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
> > something after the "introduction" to cope with both the old and new
> > syntax while we converted QAPI to the new syntax. There's a bug in
> > that code that only shows up in a handful of cases and only when using
> > the new syntax while this affordance/flex code is still enabled.
> >
> > In the case that we do actually have a real bona-fide intro section,
> > we want to insert directly after that real-deal intro section, not
> > after any plaintext sections that may follow it. This code adjusts the
> > temporary code to strongly prefer inserting after the actual intro
> > section if it exists.
> >
> > Once again: once conversion is done, you will be delighted by how much
> > of this ugly code goes away.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 9e14c2f7921..6a9a5589c14 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -845,6 +845,14 @@ def _insert_after_intro(
> >          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
> >          be sufficient.
> >          """
> > +        first =3D self.all_sections[0]
> > +        if first.text and first.kind =3D=3D QAPIDoc.Kind.INTRO:
> > +            # First section is introduction and is non-empty: insert h=
ere.
> > +            # Rest assured all of this ugliness will very soon go away=
.
> > +            # Pinkie-swear.
> > +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=
=3DTrue)
>
> Isn't this a roundabout way to do
>
>                self.all_sections.insert(1, section)
>
> ?

Yes O:-)

... but it's the more semantically abstracted version that does not
rely on the specific location of the section. By the end of the
next-next series, all of this goes away anyway. I think I was
preferring to avoid using insert in more than the two helpers we
already use it in. (But since I intend to delete it all, I don't
really care about fighting for purity in isolating this call.)

Specifically:

_insert_near_kind(), _insert_after_intro() both go away.
append_member_stub() also goes away. ensure_returns() stays but
becomes something like two lines.

*all* section modification in the next-next series happens exclusively
through a method named `_append()` which Does The Right Thing In All
Cases.

--js

>
> > +            return
> > +
> >          index =3D 0
> >          for index, ref_section in enumerate(self.all_sections):
> >              if ref_section.kind.name in ("PLAIN", "INTRO"):
>                    continue
>                break
>            else:
>                index +=3D 1
>
>            self.all_sections.insert(index, section)
>


