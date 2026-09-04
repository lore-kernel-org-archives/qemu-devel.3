Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F288C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2X2b-0004jq-US; Fri, 04 Sep 2026 12:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2X2a-0004ir-I2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2X2Y-0005yY-0N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788540320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RRYUoVWmyQjRLBTJjRuFfIIvGxwHu9HqhMnP9iTHAc=;
 b=TxVxiVUt8GDGW61XOr4g2QIoLdQLH2gRwhvDSoOxPhS2hGiGo5KNFMbxvMpG6aAwhvfCeT
 ds1SxVKq2W6Tn3EwPwc1SIa1diJJs/iRUKBbFl6CV9fyWFz5oPos6jVWgjgNfL1CIIYa9g
 +1vYpL3xrZI079BG7aIsjH0mSizBap4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-EpYT5ZLsPgy5HMC7AJLW0Q-1; Fri, 04 Sep 2026 12:45:18 -0400
X-MC-Unique: EpYT5ZLsPgy5HMC7AJLW0Q-1
X-Mimecast-MFC-AGG-ID: EpYT5ZLsPgy5HMC7AJLW0Q_1788540317
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66e63e9b6feso1914072d50.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540317; cv=none;
 d=google.com; s=arc-20260327;
 b=iY0KIAzJ7Do2lG81hF4VT7TcqH1eg1LVP+ORYOUuGEOsPZdiyy85eoQ2Bjyoqpf0nW
 n7UvoqF1L31iEqVV8X2d2RFfZy23KwuTqcs2nD9AVql9tsk2vOuKx+IdPd3ige06nX31
 9yA9A/Ki4o6JxKk+E66oxJSXRZ9pRHphC8Gnh928gQfYe+awFefZaVSn+bC7Da7JD4e9
 pWc7t2oXbsExDYUg3o/3NXFRCRQpaIl//I0sSumRv75bS4kZG0pMNov+6dGIhpMQwYtX
 g3eZj5H88XrCH/JnibzPOR7g73V2Jsg9ylMf4oBDg7mY3IylH0zumQuqZ2O5szUzA1L8
 GxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9RRYUoVWmyQjRLBTJjRuFfIIvGxwHu9HqhMnP9iTHAc=;
 fh=X2xY5At9n+4HaE60q6wCR12bJaVQsZOzkjK/Czdau3s=;
 b=SANdme5PnTddQvmqyRAPlxLiTy4fElXJer9uGWJ616GlNrzSE+sNL3yXv7s6j98Ygf
 s9nyYJR6vFBPRwb/HOlHe8DkFPL/anA1uvAvevh9CcuNBJZZSUcwXg7EpJK25XtFeXw6
 hbtPX7weFexhnpUiLktXd1yN+YPjf5zgtuHDR/yRywwh8TjbmUXJhNqVXmsktSjEMaXi
 gLbtaagKR+rWbomlVSe1yXfhIUF++HZRpQz/Zg4+L4odmc6Mp2pGT/wxPqsUDwXzZWos
 7WLBMjyyfGUU5ySMm4watiMHIWMMEVBRm4MNTvyXDnY2YVAiOFeRNwb+p+QUVij611lk
 6Guw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788540317; x=1789145117; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9RRYUoVWmyQjRLBTJjRuFfIIvGxwHu9HqhMnP9iTHAc=;
 b=DSW14VmiV9eg5rVCfYp5QOF1u9BydOzKokTfgFCYj3uPwlPnA6xBmBDgxrEIZpe/sa
 v8yRX6Ct3PtUTnIqH9gAl13NvuxywDxTHrdmhwD5bmoqy1xy7aTopwIs7+KJYRP1RFlZ
 lDdj4iWIfDKC9c637VUgznOh2QhHrvyvvUoOqaM2cp/GEw3wqI1i39a2EidvOaMi4Npc
 ge1m44RYlpBcgaC9mBwlMOPCYkUZbIUjSMGp2RG9Kp4OCxYeUvyWIJOWZ3Jb6ZoqumtC
 h6A6j245uU3r7Sxiq5FmIc7CwiQqWvyFZDWGrpLtwm5SamX8y4GMS6y+wEONK1J57TkD
 /Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788540317; x=1789145117;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9RRYUoVWmyQjRLBTJjRuFfIIvGxwHu9HqhMnP9iTHAc=;
 b=EHs1w03tjUlp4yUHieQnw1M7Hubc9mUvF57IWtRzamSpkTnzLA/OHvaIdmay5oqClj
 aB6ULVQebck+lsi08OwsiEG7svG44tmphf1lhN7LOg1OwE1BpQo+4GBsaYkLHqo6PrOD
 S59LAUqK5kkO4qhLyJQsf9zCcjotOr9ppbQIqBw0IhnmhCAK40UmYhcFy3Kpj6woVmF0
 5+vOOVeX0lNUTzVQA2fk4BFo6XGtPiB4UWQDo/LP6KxL55T9t8G/X64BYL/dalKHAwhr
 2lUdT7OEhizDdC/FhiRdxxTbo0iVa2ka5skMOE1CA3NpxIny2fqg5BmXlh1Dxw0sAJWX
 G2Zg==
X-Gm-Message-State: AFuF++mBROWO8uhXu6pBNTbau40mdjeEk7oa17F/LO0a3y4TwfEtKF94
 9vyq/SgelmY/gLgbivq1pCrmL/nVbsgQ1R2DBpjcFhxdd4vuAYy1/7XSEdtFXGqnYFZGuS33Luk
 3Ljp5QnDS94DQFKqNTi9stOn4GFVCdNzytJDCiepEix4w/aD6YKxjkJQ3zmHy/l6b23o2HqbV8T
 MgE0JAxUkey+larEfE8wYHPNAMggcSDq8=
X-Gm-Gg: AYBFou0vBVWFbrkq+DJh7pETusi7IFPlIJRXCF8S7LuorDvK/zWa+81XKS6PX51VwhO
 C0qgme9V+t2cYdRVbb28hVlJp6r4WyEljPSAMeHwAu7KT1cnXM7uIzg5O5LupyBCZWmd131NYNk
 H3ecOYSVFvuh0lxn5d7VkbB0OSi9f+o3y49hmTUCWIlyobNwYW2NIyCrbOpbCyEDSjiaxDe9xpU
 rl1XQP2rjhyeA3E
X-Received: by 2002:a53:d01c:0:b0:66f:c1bc:4054 with SMTP id
 956f58d0204a3-66fc1bc4206mr303363d50.28.1788540317222; 
 Fri, 04 Sep 2026 09:45:17 -0700 (PDT)
X-Received: by 2002:a53:d01c:0:b0:66f:c1bc:4054 with SMTP id
 956f58d0204a3-66fc1bc4206mr303347d50.28.1788540316519; Fri, 04 Sep 2026
 09:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260901194324.458482-1-jsnow@redhat.com>
 <20260901194324.458482-13-jsnow@redhat.com>
 <87mrtyr1gz.fsf@pond.sub.org>
In-Reply-To: <87mrtyr1gz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 4 Sep 2026 12:45:05 -0400
X-Gm-Features: AcwNN1X3FNvbk2zeIs6gvh8_ITt1AkuNMCAm7EKDZGVDQk-cP6pAfhQRKzWd7hY
Message-ID: <CAFn=p-bd1EOw8aQQn+CUSEWLTNz98MP5z77rAn3jt02bbRNYbA@mail.gmail.com>
Subject: Re: [PATCH 12/12] qapi: convert simple command intros for
 block-core.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Ani Sinha <anisinha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003beb20065aaafedc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000003beb20065aaafedc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026, 7:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json | 96 +++++++++++++++++++++-----------------------
> >  1 file changed, 46 insertions(+), 50 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 33e1147792b..29f011dc209 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1816,12 +1816,12 @@
> >
> >  ##
> >  # @change-backing-file:
> > -#
> > -# Change the backing file in the image file metadata.  This does not
> > -# cause QEMU to reopen the image file to reparse the backing filename
> > -# (it may, however, perform a reopen to change permissions from r/o ->
> > -# r/w -> r/o, if needed).  The new backing file string is written into
> > -# the image file metadata, and the QEMU internal strings are updated.
> > +#     Change the backing file in the image file metadata.  This does
> > +#     not cause QEMU to reopen the image file to reparse the backing
> > +#     filename (it may, however, perform a reopen to change
> > +#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
> > +#     file string is written into the image file metadata, and the
> > +#     QEMU internal strings are updated.
> >  #
> >  # @image-node-name: The name of the block driver state node of the
> >  #     image to modify.  The "device" argument is used to verify
> > @@ -1957,12 +1957,12 @@
> >
> >  ##
> >  # @drive-backup:
> > -#
> > -# Start a point-in-time copy of a block device to a new destination.
> > -# The status of ongoing `drive-backup` operations can be checked with
> > -# `query-block-jobs` where the `BlockJobInfo`.type field has the value
> > -# 'backup'.  The operation can be stopped before it has completed
> > -# using the `job-cancel` or `block-job-cancel` command.
> > +#     Start a point-in-time copy of a block device to a new
> > +#     destination.  The status of ongoing `drive-backup` operations
> > +#     can be checked with `query-block-jobs` where the
> > +#     `BlockJobInfo`.type field has the value 'backup'.  The operation
> > +#     can be stopped before it has completed using the `job-cancel` or
> > +#     `block-job-cancel` command.
> >  #
> >  # Features:
> >  #
> > @@ -1988,12 +1988,12 @@
> >
> >  ##
> >  # @blockdev-backup:
> > -#
> > -# Start a point-in-time copy of a block device to a new destination.
> > -# The status of ongoing `blockdev-backup` operations can be checked
> > -# with `query-block-jobs` where the `BlockJobInfo`.type field has the
> > -# value 'backup'.  The operation can be stopped before it has
> > -# completed using the `job-cancel` or `block-job-cancel` command.
> > +#     Start a point-in-time copy of a block device to a new
> > +#     destination.  The status of ongoing `blockdev-backup` operations
> > +#     can be checked with `query-block-jobs` where the
> > +#     `BlockJobInfo`.type field has the value 'backup'.  The operation
> > +#     can be stopped before it has completed using the `job-cancel` or
> > +#     `block-job-cancel` command.
> >  #
> >  # Errors:
> >  #     - If @device is not a valid block device, DeviceNotFound
> > @@ -2185,13 +2185,13 @@
> >
> >  ##
> >  # @drive-mirror:
> > -#
> > -# Start mirroring a block device's writes to a new destination.
> > -# target specifies the target of the new image.  If the file exists,
> > -# or if it is a device, it will be used as the new destination for
> > -# writes.  If it does not exist, a new file will be created.  @format
> > -# specifies the format of the mirror image, default is to probe if
> > -# mode=3D'existing', else the format of the source.
> > +#     Start mirroring a block device's writes to a new destination.
> > +#     target specifies the target of the new image.  If the file
>
> @target, I think.
>
> > +#     exists, or if it is a device, it will be used as the new
> > +#     destination for writes.  If it does not exist, a new file will
> > +#     be created.  @format specifies the format of the mirror image,
> > +#     default is to probe if mode=3D'existing', else the format of the
>
> @mode
>
> Where there are two, there are almost certainly more.
>

You reviewed the series, does this mean changes for later?


> > +#     source.
>
> Text that refers to arguments should probably go below the argument
> descriptions.  I.e. this "intro" should probably be split.
>
> Let's leave that for another day, just take note of future work:
>
> 1. Add missing markup to argument / member / feature references.
>
> 2. Review and improve doc comments where the intro refers to arguments /
> members / features.
>
> Not noting any of this again for this series.
>

OK.


> >  #
> >  # Errors:
> >  #     - If @device is not a valid block device, GenericError
> > @@ -2387,10 +2387,9 @@
> >
> >  ##
> >  # @block-dirty-bitmap-remove:
> > -#
> > -# Stop write tracking and remove the dirty bitmap that was created
> > -# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove
> > -# it from its storage too.
> > +#     Stop write tracking and remove the dirty bitmap that was created
> > +#     with `block-dirty-bitmap-add`.  If the bitmap is persistent,
> > +#     remove it from its storage too.
> >  #
> >  # Errors:
> >  #     - If @node is not a valid block device or node, DeviceNotFound
> > @@ -4937,10 +4936,9 @@
> >
> >  ##
> >  # @blockdev-del:
> > -#
> > -# Deletes a block device that has been added using `blockdev-add`.
> > -# The command will fail if the node is attached to a device or is
> > -# otherwise being used.
> > +#     Deletes a block device that has been added using `blockdev-add`.
> > +#     The command will fail if the node is attached to a device or is
> > +#     otherwise being used.
>
> Perhaps the "will fail" part should be in an Errors: section.
>
> The intros above use imperative mode, this one doesn't.  Elsewhere in
> this series, I even saw "Command to <do stuff>".
>
> More notes:
>
> 3. Review and improve doc comments where the intro talks about failure
> modes.
>
> 4. Consistently use imperative mood for command intros.
>
> Not noting any of this again for this series.
>

Are you keeping a log of future changes, or should I write them down?


> >  #
> >  # @node-name: Name of the graph node to delete.
> >  #
>
> [...]
>
>

--0000000000003beb20065aaafedc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2026, 7:58=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json | 96 +++++++++++++++++++++-----------------=
------<br>
&gt;=C2=A0 1 file changed, 46 insertions(+), 50 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index 33e1147792b..29f011dc209 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -1816,12 +1816,12 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @change-backing-file:<br>
&gt; -#<br>
&gt; -# Change the backing file in the image file metadata.=C2=A0 This does=
 not<br>
&gt; -# cause QEMU to reopen the image file to reparse the backing filename=
<br>
&gt; -# (it may, however, perform a reopen to change permissions from r/o -=
&gt;<br>
&gt; -# r/w -&gt; r/o, if needed).=C2=A0 The new backing file string is wri=
tten into<br>
&gt; -# the image file metadata, and the QEMU internal strings are updated.=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Change the backing file in the image file metada=
ta.=C2=A0 This does<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0not cause QEMU to reopen the image file to repar=
se the backing<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0filename (it may, however, perform a reopen to c=
hange<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0permissions from r/o -&gt; r/w -&gt; r/o, if nee=
ded).=C2=A0 The new backing<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0file string is written into the image file metad=
ata, and the<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0QEMU internal strings are updated.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @image-node-name: The name of the block driver state node of t=
he<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0image to modify.=C2=A0 The &quot;device&quo=
t; argument is used to verify<br>
&gt; @@ -1957,12 +1957,12 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @drive-backup:<br>
&gt; -#<br>
&gt; -# Start a point-in-time copy of a block device to a new destination.<=
br>
&gt; -# The status of ongoing `drive-backup` operations can be checked with=
<br>
&gt; -# `query-block-jobs` where the `BlockJobInfo`.type field has the valu=
e<br>
&gt; -# &#39;backup&#39;.=C2=A0 The operation can be stopped before it has =
completed<br>
&gt; -# using the `job-cancel` or `block-job-cancel` command.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Start a point-in-time copy of a block device to =
a new<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0destination.=C2=A0 The status of ongoing `drive-=
backup` operations<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0can be checked with `query-block-jobs` where the=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0`BlockJobInfo`.type field has the value &#39;bac=
kup&#39;.=C2=A0 The operation<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0can be stopped before it has completed using the=
 `job-cancel` or<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0`block-job-cancel` command.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Features:<br>
&gt;=C2=A0 #<br>
&gt; @@ -1988,12 +1988,12 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @blockdev-backup:<br>
&gt; -#<br>
&gt; -# Start a point-in-time copy of a block device to a new destination.<=
br>
&gt; -# The status of ongoing `blockdev-backup` operations can be checked<b=
r>
&gt; -# with `query-block-jobs` where the `BlockJobInfo`.type field has the=
<br>
&gt; -# value &#39;backup&#39;.=C2=A0 The operation can be stopped before i=
t has<br>
&gt; -# completed using the `job-cancel` or `block-job-cancel` command.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Start a point-in-time copy of a block device to =
a new<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0destination.=C2=A0 The status of ongoing `blockd=
ev-backup` operations<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0can be checked with `query-block-jobs` where the=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0`BlockJobInfo`.type field has the value &#39;bac=
kup&#39;.=C2=A0 The operation<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0can be stopped before it has completed using the=
 `job-cancel` or<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0`block-job-cancel` command.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, D=
eviceNotFound<br>
&gt; @@ -2185,13 +2185,13 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @drive-mirror:<br>
&gt; -#<br>
&gt; -# Start mirroring a block device&#39;s writes to a new destination.<b=
r>
&gt; -# target specifies the target of the new image.=C2=A0 If the file exi=
sts,<br>
&gt; -# or if it is a device, it will be used as the new destination for<br=
>
&gt; -# writes.=C2=A0 If it does not exist, a new file will be created.=C2=
=A0 @format<br>
&gt; -# specifies the format of the mirror image, default is to probe if<br=
>
&gt; -# mode=3D&#39;existing&#39;, else the format of the source.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Start mirroring a block device&#39;s writes to a=
 new destination.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0target specifies the target of the new image.=C2=
=A0 If the file<br>
<br>
@target, I think.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0exists, or if it is a device, it will be used as=
 the new<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0destination for writes.=C2=A0 If it does not exi=
st, a new file will<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0be created.=C2=A0 @format specifies the format o=
f the mirror image,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0default is to probe if mode=3D&#39;existing&#39;=
, else the format of the<br>
<br>
@mode<br>
<br>
Where there are two, there are almost certainly more.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">You reviewed the serie=
s, does this mean changes for later?</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0source.<br>
<br>
Text that refers to arguments should probably go below the argument<br>
descriptions.=C2=A0 I.e. this &quot;intro&quot; should probably be split.<b=
r>
<br>
Let&#39;s leave that for another day, just take note of future work:<br>
<br>
1. Add missing markup to argument / member / feature references.<br>
<br>
2. Review and improve doc comments where the intro refers to arguments /<br=
>
members / features.<br>
<br>
Not noting any of this again for this series.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">OK.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @device is not a valid block device, G=
enericError<br>
&gt; @@ -2387,10 +2387,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @block-dirty-bitmap-remove:<br>
&gt; -#<br>
&gt; -# Stop write tracking and remove the dirty bitmap that was created<br=
>
&gt; -# with `block-dirty-bitmap-add`.=C2=A0 If the bitmap is persistent, r=
emove<br>
&gt; -# it from its storage too.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Stop write tracking and remove the dirty bitmap =
that was created<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0with `block-dirty-bitmap-add`.=C2=A0 If the bitm=
ap is persistent,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0remove it from its storage too.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Errors:<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If @node is not a valid block device or n=
ode, DeviceNotFound<br>
&gt; @@ -4937,10 +4936,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @blockdev-del:<br>
&gt; -#<br>
&gt; -# Deletes a block device that has been added using `blockdev-add`.<br=
>
&gt; -# The command will fail if the node is attached to a device or is<br>
&gt; -# otherwise being used.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0Deletes a block device that has been added using=
 `blockdev-add`.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0The command will fail if the node is attached to=
 a device or is<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0otherwise being used.<br>
<br>
Perhaps the &quot;will fail&quot; part should be in an Errors: section.<br>
<br>
The intros above use imperative mode, this one doesn&#39;t.=C2=A0 Elsewhere=
 in<br>
this series, I even saw &quot;Command to &lt;do stuff&gt;&quot;.<br>
<br>
More notes:<br>
<br>
3. Review and improve doc comments where the intro talks about failure<br>
modes.<br>
<br>
4. Consistently use imperative mood for command intros.<br>
<br>
Not noting any of this again for this series.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Are you keeping a log of futur=
e changes, or should I write them down?</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @node-name: Name of the graph node to delete.<br>
&gt;=C2=A0 #<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--0000000000003beb20065aaafedc--


